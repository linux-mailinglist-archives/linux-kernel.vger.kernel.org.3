Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 965BD58116D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 12:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232402AbiGZKsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 06:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233341AbiGZKsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 06:48:04 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A297240B4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 03:47:59 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220726104754epoutp044ffc760078b2e7804f6b4367ec5145f6~FW1immUgg1496914969epoutp04g
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 10:47:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220726104754epoutp044ffc760078b2e7804f6b4367ec5145f6~FW1immUgg1496914969epoutp04g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1658832474;
        bh=fQ+Y+QmHnh/EDveNBIvr5sL4r2bOolAvTQu/ym0MQ40=;
        h=From:To:Cc:Subject:Date:References:From;
        b=QSoSkNSlZ9myZg4vn3DO35QoU/VU+WK4mHamVkqdIYX1IWrdARJ8TSougIzEGJDUp
         COJFMbamRwwDkvk/SNWv3FUUg/couFDyHa2/h0yoNBMwcuOGL1mR55SA4rN+jo7okl
         TOem5lY6LBsupe6JpVVguyyUXL2mE4uvdYTEeHVg=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20220726104753epcas2p1f4f7ed696f18d7e5b34b7729d114cf1e~FW1iKIoha2666126661epcas2p1U;
        Tue, 26 Jul 2022 10:47:53 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.99]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4LsYXT28Thz4x9Pq; Tue, 26 Jul
        2022 10:47:53 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        3D.DD.09666.956CFD26; Tue, 26 Jul 2022 19:47:53 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20220726104752epcas2p25991dabdb0acb21e25f21277f3198b09~FW1hQlJM61146411464epcas2p29;
        Tue, 26 Jul 2022 10:47:52 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220726104752epsmtrp19621ddec4fcba5decef904a14c85faf9~FW1hPwgku2764827648epsmtrp1K;
        Tue, 26 Jul 2022 10:47:52 +0000 (GMT)
X-AuditID: b6c32a45-45bff700000025c2-ee-62dfc659025c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        40.DD.08802.856CFD26; Tue, 26 Jul 2022 19:47:52 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.55]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220726104752epsmtip26f3ea21891bc998bbdebccc76ea401a5~FW1hETgl02032620326epsmtip2W;
        Tue, 26 Jul 2022 10:47:52 +0000 (GMT)
From:   Gyunghoon Kwon <goodjob.kwon@samsung.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     alim.akhtar@samsung.com, avri.altman@wdc.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gyunghoon Kwon <goodjob.kwon@samsung.com>
Subject: [PATCH] scsi: ufs: introduce dev_cmd_notify callback
Date:   Tue, 26 Jul 2022 19:45:17 +0900
Message-Id: <20220726104516.127032-1-goodjob.kwon@samsung.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLKsWRmVeSWpSXmKPExsWy7bCmuW7ksftJBmvvcFk8mLeNzeLlz6ts
        Fj07nS0W3djGZHF51xw2i+7rO9gslh//x+TA7jFh0QFGj49Pb7F49G1ZxejxeZOcR/uBbqYA
        1qhsm4zUxJTUIoXUvOT8lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE3FRbJRefAF23zBygK5QU
        yhJzSoFCAYnFxUr6djZF+aUlqQoZ+cUltkqpBSk5BeYFesWJucWleel6eaklVoYGBkamQIUJ
        2RmPvjawFBwQrPj3YiVrA+M5vi5GTg4JAROJ1xvXMncxcnEICexglDjZcJ0ZJCEk8IlRYtps
        ZQj7M6PE0k5TmIYHc5czQjTsYpToObWVHcL5yChx6UofG0gVm4C+xNTzL4EmcXCICBhJXFvl
        CVLDLDCTUeLM1WNMIDXCArYSP06fZQGxWQRUJU79+gK2mVfATqLt9k4miG3yEtdvtkHFBSVO
        znwCVs8MFG/eOhvsbAmBc+wSex88YYVocJHYv2kvM4QtLPHq+BZ2CFtK4mV/G5RdLHHy/wZG
        iOYWRonO6+egEsYSs561M4JczSygKbF+lz6IKSGgLHHkFtRePomOw3/ZIcK8Eh1tQhCNahJn
        Zk6D2iojcX9KAwuE7SHRteM0OyQQYyVmr9zKNoFRfhaSb2Yh+WYWwt4FjMyrGMVSC4pz01OL
        jQoM4XGanJ+7iRGcDrVcdzBOfvtB7xAjEwfjIUYJDmYlEd6E6PtJQrwpiZVVqUX58UWlOanF
        hxhNgeE7kVlKNDkfmJDzSuINTSwNTMzMDM2NTA3MlcR5vVI2JAoJpCeWpGanphakFsH0MXFw
        SjUwLVtsvzy7LeXSgqs/V7Ps/vF7oZ023+bef/JqqRP/vFrY8pXzdfSPC9ZHls5tbuOx0eFa
        nmBV/n2B9o8vzHscRE/++9uV4c79ynSN/GG7TUdj6zlmZ+oyLO/IDH/oe1L9yaSLoiceKrCp
        yNkHNb//u9txboLOl2WMp/nTnJwZ5T/L2LFITOt50jg1KcnBNDB7A8vzwqU3NpySy8mJqZLg
        F9Y+mf/15+K6U4bKS6WPF11bJO2maVX2QNd9+RNdxo/xT2U21G5+7HXusN6TNZdWuU8W2r5n
        9jqxaTNst50+dDi5TCXu8LUFC9bVz1LyWSxqml82lb9M57e9XP9HN4sGbi4GP/OL+zgluiO9
        VhxYrsRSnJFoqMVcVJwIAINo7CEQBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHLMWRmVeSWpSXmKPExsWy7bCSvG7EsftJBnffyVs8mLeNzeLlz6ts
        Fj07nS0W3djGZHF51xw2i+7rO9gslh//x+TA7jFh0QFGj49Pb7F49G1ZxejxeZOcR/uBbqYA
        1igum5TUnMyy1CJ9uwSujEdfG1gKDghW/HuxkrWB8RxfFyMnh4SAicSDucsZuxi5OIQEdjBK
        zH72mLWLkQMoISNx74gURI2wxP2WI6wQNe8ZJU6vP8UIkmAT0JeYev4lM4gtAjRoxq13YEXM
        AnMZJSZs/sEEkhAWsJX4cfosC4jNIqAqcerXF7AGXgE7ibbbO5kgNshLXL/ZBhUXlDg58wlY
        PTNQvHnrbOYJjHyzkKRmIUktYGRaxSiZWlCcm55bbFhglJdarlecmFtcmpeul5yfu4kRHKRa
        WjsY96z6oHeIkYmD8RCjBAezkghvQvT9JCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8F7pOxgsJ
        pCeWpGanphakFsFkmTg4pRqY1nnO75v4Nc11EYubKP/c/JSt3eqFOnqnv29jyeRhfVB89/ux
        eu21d59uW5t69VxVE+8j2UgZ6eQ1cXN7V3nlVxc73Df/qCgZqFzH2cUq0LUx8pl3fo79P7Wv
        k6sUrgX1nnGpdH6X6Wd1a43wXUNG/UK/1kebBB+ufB072+zWQkWHo2VTjv0r1Fz5Wlro0wNu
        xh1vKuYoLRIx3iK78YGkWee7gPrLXDl+kWvN1sr9XXxgxsYJxzTVQ58sv3crcIrwCVNBlo4L
        nk160ysl1xiqO59cfe/grWsLLTavmZFRda7DXc6BpymI64JM1fOglHtrC+duPxC8Jdtt7tFq
        yS++Jj8N18gIB6YZrlnAU7ROiaU4I9FQi7moOBEAfqyhcMECAAA=
X-CMS-MailID: 20220726104752epcas2p25991dabdb0acb21e25f21277f3198b09
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220726104752epcas2p25991dabdb0acb21e25f21277f3198b09
References: <CGME20220726104752epcas2p25991dabdb0acb21e25f21277f3198b09@epcas2p2.samsung.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some UFS host controller may need to synchronize dev command among
UFS host controllers.

Signed-off-by: Gyunghoon Kwon <goodjob.kwon@samsung.com>
---
 drivers/scsi/ufs/ufshcd.c |  2 ++
 drivers/scsi/ufs/ufshcd.h | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 823ecd99eb2c..02d0350ee1a2 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -2942,8 +2942,10 @@ static int ufshcd_exec_dev_cmd(struct ufs_hba *hba,
 
 	ufshcd_add_query_upiu_trace(hba, UFS_QUERY_SEND, lrbp->ucd_req_ptr);
 
+	ufshcd_vops_dev_cmd_notify(hba, PRE_CHANGE);
 	ufshcd_send_command(hba, tag);
 	err = ufshcd_wait_for_dev_cmd(hba, lrbp, timeout);
+	ufshcd_vops_dev_cmd_notify(hba, POST_CHANGE);
 	ufshcd_add_query_upiu_trace(hba, err ? UFS_QUERY_ERR : UFS_QUERY_COMP,
 				    (struct utp_upiu_req *)lrbp->ucd_rsp_ptr);
 
diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
index 34c5db101f14..f13b6cdfbe1d 100644
--- a/drivers/scsi/ufs/ufshcd.h
+++ b/drivers/scsi/ufs/ufshcd.h
@@ -320,6 +320,7 @@ struct ufs_pwr_mode_info {
  * @device_reset: called to issue a reset pulse on the UFS device
  * @program_key: program or evict an inline encryption key
  * @event_notify: called to notify important events
+ * @dev_cmd_notify: called to notify device management request is issued
  */
 struct ufs_hba_variant_ops {
 	const char *name;
@@ -357,6 +358,8 @@ struct ufs_hba_variant_ops {
 			       const union ufs_crypto_cfg_entry *cfg, int slot);
 	void	(*event_notify)(struct ufs_hba *hba,
 				enum ufs_event_type evt, void *data);
+	void	(*dev_cmd_notify)(struct ufs_hba *hba,
+			       enum ufs_notify_change_status);
 };
 
 /* clock gating state  */
@@ -1354,6 +1357,13 @@ static inline void ufshcd_vops_config_scaling_param(struct ufs_hba *hba,
 		hba->vops->config_scaling_param(hba, profile, data);
 }
 
+static inline void ufshcd_vops_dev_cmd_notify(struct ufs_hba *hba,
+					enum ufs_notify_change_status status)
+{
+	if (hba->vops && hba->vops->dev_cmd_notify)
+		hba->vops->dev_cmd_notify(hba, status);
+}
+
 extern struct ufs_pm_lvl_states ufs_pm_lvl_states[];
 
 /*
-- 
2.37.1

