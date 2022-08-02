Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 458145878A0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 10:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236046AbiHBIDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 04:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232855AbiHBIDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 04:03:50 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39049DEA3
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 01:03:48 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220802080346epoutp0147b2be2e4f48d088d21829edc804ffbe~HeHPeHam42049120491epoutp01J
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 08:03:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220802080346epoutp0147b2be2e4f48d088d21829edc804ffbe~HeHPeHam42049120491epoutp01J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1659427426;
        bh=wVOPOUxiNLaJA3Ek+mRYptXK+j9kErlnygcOfRzp26c=;
        h=Subject:Reply-To:From:To:In-Reply-To:Date:References:From;
        b=Ek4jXdpXmKsPDHdmClONNcTDXXjdLK7Bbz4LLQAjkJ0gYocYF6yO3ZomBMW6/lC2d
         0TlkpHk34tGNJKVFXo29VvF5bIMf8YUAmGWbnAWvodghFaDi3qvnDaH852BLYnip55
         6TE4z+P3Exp9RcEjH665uI2jiLS3lPyxL9zgBpA4=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20220802080346epcas2p2b976ddc37fbfad80061bbd719912e8fd~HeHPC6OsW2861328613epcas2p2I;
        Tue,  2 Aug 2022 08:03:46 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.99]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4LxnYs5Sy4z4x9Py; Tue,  2 Aug
        2022 08:03:45 +0000 (GMT)
X-AuditID: b6c32a47-5e1ff700000025aa-65-62e8da618fae
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        59.D1.09642.16AD8E26; Tue,  2 Aug 2022 17:03:45 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v6 1/6] scsi: ufs: wb: Change wb_enabled condition test
Reply-To: j-young.choi@samsung.com
Sender: Jinyoung CHOI <j-young.choi@samsung.com>
From:   Jinyoung CHOI <j-young.choi@samsung.com>
To:     ALIM AKHTAR <alim.akhtar@samsung.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20220802080146epcms2p24b86bfce3d3c09c79b91d861cb3b2cce@epcms2p2>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220802080345epcms2p3c503408ed9064c87833922b8d7fca2a5@epcms2p3>
Date:   Tue, 02 Aug 2022 17:03:45 +0900
X-CMS-MailID: 20220802080345epcms2p3c503408ed9064c87833922b8d7fca2a5
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOJsWRmVeSWpSXmKPExsWy7bCmqW7irRdJBnOnaVqcfLKGzeLBvG1s
        Fi9/XmWzOPiwk8Vi2oefzBYvD2laLLqxjcni8q45bBbd13ewWSw//o/JYunWm4wO3B6Xr3h7
        LN7zksljwqIDjB4tJ/ezeHxf38Hm8fHpLRaPvi2rGD0+b5LzaD/QzRTAGZVtk5GamJJapJCa
        l5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQN0rJJCWWJOKVAoILG4WEnf
        zqYov7QkVSEjv7jEVim1ICWnwLxArzgxt7g0L10vL7XEytDAwMgUqDAhO+PVrVfMBf/ZK+6+
        ncvcwPiIrYuRk0NCwETi7oE+5i5GLg4hgR2MEruWrGXpYuTg4BUQlPi7QxjEFBZwl/hy3x2k
        XEhASeLcmlmMEGEDiVu95iBhNgE9iZ9LZrCBTBERaGORONa5lRliPK/EjPanLBC2tMT25VsZ
        QWxOAT+JiTc+QNVoSPxY1gtli0rcXP2WHcZ+f2w+I4QtItF67yxUjaDEg5+7oeKSEocOfWUD
        uUdCIF9iw4FAiHCNxNvlB6BK9CWudWwEO4FXwFfiRMMxMJtFQFXi09EHUK0uErcvloGEmQXk
        Jba/ncMMEmYW0JRYv0sfokJZ4sgtFpifGjb+ZkdnMwvwSXQc/gsX3zHvCRNEq5rEoiYjiLCM
        xNfD89knMCrNQoTxLCRrZyGsXcDIvIpRLLWgODc9tdiowBgercn5uZsYwSlWy30H44y3H/QO
        MTJxMB5ilOBgVhLhvePyPEmINyWxsiq1KD++qDQntfgQoynQvxOZpUST84FJPq8k3tDE0sDE
        zMzQ3MjUwFxJnNcrZUOikEB6YklqdmpqQWoRTB8TB6dUA9P8rgc8Wd7qOU+rN1Yu2Xvk4sN/
        CRwXF8lPU+k57x+1kd/4D6tfWsaDnawdAluuXOxgbnPV5DVeejRPac0S7fu+S0+ItPZ+e6Oc
        tvr84i3K/YYTgy44ta2rn/hHqHRm+/f8I1fcjkyQrbWdZykQuOeeydKp3+reeZ/V2fH4Z9+x
        qt1GEpyd8vU101ld1PZYK1x/UTnbJ6e7rLih+JPajQmHJrwyDJ+2ROvoc01LKxbu5IrEr3JT
        T23vX7kh6WbrHumaBcfPvXCsduF6NI9dvtmbWbibb9X2f0erk3Q3ye6Yv4Wj503WzdXZHn9a
        717QWOxw89i1u8Zyv+bZiU7N+jeJqTtRcrXnFNdlZ+4f0P6hxFKckWioxVxUnAgAh0DelToE
        AAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220802080146epcms2p24b86bfce3d3c09c79b91d861cb3b2cce
References: <20220802080146epcms2p24b86bfce3d3c09c79b91d861cb3b2cce@epcms2p2>
        <CGME20220802080146epcms2p24b86bfce3d3c09c79b91d861cb3b2cce@epcms2p3>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changed to improve readability.
As implemented in ufshcd_wb_togle_flush(), the conditional test is
modified in the same way.

Reviewed-by: Avri Altman <avri.altman@wdc.com>
Reviewed-by: Bean Huo <beanhuo@micron.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Stanley Chu <stanley.chu@mediatek.com>
Signed-off-by: Jinyoung Choi <j-young.choi@samsung.com>
---
 drivers/ufs/core/ufshcd.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 0dc6437e956a..b7e7c0c4eb75 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -5730,10 +5730,8 @@ int ufshcd_wb_toggle(struct ufs_hba *hba, bool enable)
 {
 	int ret;
 
-	if (!ufshcd_is_wb_allowed(hba))
-		return 0;
-
-	if (!(enable ^ hba->dev_info.wb_enabled))
+	if (!ufshcd_is_wb_allowed(hba) ||
+	    hba->dev_info.wb_enabled == enable)
 		return 0;
 
 	ret = __ufshcd_wb_toggle(hba, enable, QUERY_FLAG_IDN_WB_EN);
-- 
2.25.1
