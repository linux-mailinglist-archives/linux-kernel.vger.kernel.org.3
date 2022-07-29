Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F159584AD4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 06:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234019AbiG2ExD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 00:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233800AbiG2Ew7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 00:52:59 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A642558C7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 21:52:57 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220729045254epoutp036e30e421bb35b7d18ade2b9f2423248d~GM7czGIrX1168011680epoutp03L
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 04:52:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220729045254epoutp036e30e421bb35b7d18ade2b9f2423248d~GM7czGIrX1168011680epoutp03L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1659070374;
        bh=fsSA4Sh0mG9so9uVC+TBMYuxX7h98OOminCH5vQQ8/A=;
        h=Subject:Reply-To:From:To:In-Reply-To:Date:References:From;
        b=RKBuGzCFkla9p1S4avQMYaiU9zZ/F/xlXe5rVI7tsQ/wS6znIFc5YH7hWaef0+K8Q
         ROeXnrQo/F2Wva9PMCZQOiOv1/rIsrZV6ZQTXhvQHa0ptIdy69BxX2G2ebIdSEEFu2
         614qW5gbw6iNk30WQEZYOMQHlEfFOwPVWKFVzpdA=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20220729045253epcas2p1e05e80457c3d97aaec56220731ccd9ce~GM7b5FC-g2692626926epcas2p1i;
        Fri, 29 Jul 2022 04:52:53 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.70]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4LvFWT1Bglz4x9QH; Fri, 29 Jul
        2022 04:52:53 +0000 (GMT)
X-AuditID: b6c32a48-9f7ff700000025be-f6-62e367a5147f
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        69.31.09662.5A763E26; Fri, 29 Jul 2022 13:52:53 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v5 1/6] scsi: ufs: wb: Change wb_enabled condition test
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20220729045045epcms2p8caf00317889ed4da8531b7466ec6e368@epcms2p8>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220729045252epcms2p7fee5c1cdca5e4bef02a833e40f80649b@epcms2p7>
Date:   Fri, 29 Jul 2022 13:52:52 +0900
X-CMS-MailID: 20220729045252epcms2p7fee5c1cdca5e4bef02a833e40f80649b
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPJsWRmVeSWpSXmKPExsWy7bCmhe7S9MdJBhM2sVucfLKGzeLBvG1s
        Fi9/XmWzOPiwk8Vi2oefzBYvD2laLLqxjcni8q45bBbd13ewWSw//o/Jgcvj8hVvj8V7XjJ5
        TFh0gNHj+/oONo+PT2+xePRtWcXo8XmTnEf7gW6mAI6obJuM1MSU1CKF1Lzk/JTMvHRbJe/g
        eOd4UzMDQ11DSwtzJYW8xNxUWyUXnwBdt8wcoBOVFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnF
        JbZKqQUpOQXmBXrFibnFpXnpenmpJVaGBgZGpkCFCdkZT3duYy6Yzl7RsugKSwNjK1sXIyeH
        hICJxKazG1m6GLk4hAR2MEo82TyDuYuRg4NXQFDi7w5hkBphAXeJaQs+soDYQgJKEufWzGIE
        KREWMJC41WsOEmYT0JP4uWQGG8gYEYGzzBILH05hgpjPKzGj/SkLhC0tsX35VkYQm1PAT+LT
        5otQcQ2JH8t6mSFsUYmbq9+yw9jvj81nhLBFJFrvnYWqEZR48HM3VFxS4tChr2wg90gI5Ets
        OBAIEa6ReLv8AFSJvsS1jo1gq3gFfCXm/54ENp5FQFXi1epLUCNdJK7ffAd2MrOAvMT2t3PA
        ocAsoCmxfpc+xHRliSO3WGCeatj4mx2dzSzAJ9Fx+C9cfMe8J0wQrWoSi5qMIMIyEl8Pz2ef
        wKg0CxHKs5CsnYWwdgEj8ypGsdSC4tz01GKjAhN4xCbn525iBKdULY8djLPfftA7xMjEwXiI
        UYKDWUmEVyDgcZIQb0piZVVqUX58UWlOavEhRlOghycyS4km5wOTel5JvKGJpYGJmZmhuZGp
        gbmSOK9XyoZEIYH0xJLU7NTUgtQimD4mDk6pBiZRE6sL6VuvWKrWrGB+u2WJ2+mXXBpr2acm
        NN20lbGp+/Sk5EeK6pJip5SFtXM554r899PdePGkI69tqnTg/tuGd1VzzyWUXgwMWnNS3SH6
        rXj4wXkfqkz9fE+3NGYF7Yk+08/0t22m4qZjPxN/6t3wu3lm60239r5H298l/r971jehma+F
        +8VV4WUev40ONj3h3ZjAJbpmz5ljYR6dF6b5xhwM9HiycdNVi2M1FleFHNvsWgPPqU3gqZ3v
        xVnE8l1UaL337fPWZpNCnd9rGk3jCT1nHNV8l5GraKN28wW/PAmvaJEg2SW/QzImdPa9W/Mo
        POfPt7nv+1qbP21LUY8Nq7CoTt3RWOPKd9LFWYmlOCPRUIu5qDgRACtJtd0yBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220729045045epcms2p8caf00317889ed4da8531b7466ec6e368
References: <20220729045045epcms2p8caf00317889ed4da8531b7466ec6e368@epcms2p8>
        <CGME20220729045045epcms2p8caf00317889ed4da8531b7466ec6e368@epcms2p7>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
Signed-off-by: Jinyoung Choi <j-young.choi@samsung.com>
---
 drivers/ufs/core/ufshcd.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 8f11f118c30e..bbf12aa6a5ae 100644
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
