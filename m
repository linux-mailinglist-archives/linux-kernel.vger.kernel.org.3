Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8B855898A3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 09:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239234AbiHDHtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 03:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236160AbiHDHtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 03:49:33 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFBE761D98
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 00:49:31 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220804074930epoutp02ccdb4009c08a830d1f63edefa425a2bd~IFNWH5dtr2843928439epoutp02D
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 07:49:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220804074930epoutp02ccdb4009c08a830d1f63edefa425a2bd~IFNWH5dtr2843928439epoutp02D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1659599370;
        bh=wVOPOUxiNLaJA3Ek+mRYptXK+j9kErlnygcOfRzp26c=;
        h=Subject:Reply-To:From:To:In-Reply-To:Date:References:From;
        b=uPKHVP3cHElmhaAXng6OFkJ6GbCHvrsi73VEOkUGMX+YYGLVrSwLT7d61pdJwUVMI
         JzmGv6urX6g7RRW6GUSXr08CsjinU1a70V2JyfffmBDa6a93nK9E8gpkyYdH2ckRA9
         5YgK0fjHG5C6yrKEfplnCa0P1w+IXYU5qB61vHVg=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20220804074929epcas2p4b909a08e306a765d9d74bddb9f7ebe87~IFNVtEqkX2674526745epcas2p4g;
        Thu,  4 Aug 2022 07:49:29 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.98]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Lz18S728Lz4x9Pw; Thu,  4 Aug
        2022 07:49:28 +0000 (GMT)
X-AuditID: b6c32a48-9e1ff700000025be-46-62eb7a08a30a
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        33.F6.09662.80A7BE26; Thu,  4 Aug 2022 16:49:28 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v7 1/6] scsi: ufs: wb: Change wb_enabled condition test
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
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20220804074224epcms2p18f0ac2f92073aeed981718a9cab23866@epcms2p1>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220804074928epcms2p86582693a39597501b491400a28543a92@epcms2p8>
Date:   Thu, 04 Aug 2022 16:49:28 +0900
X-CMS-MailID: 20220804074928epcms2p86582693a39597501b491400a28543a92
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGJsWRmVeSWpSXmKPExsWy7bCmqS5H1eskg845OhYnn6xhs3gwbxub
        xcufV9ksDj7sZLGY9uEns8XLQ5oWi25sY7K4vGsOm0X39R1sFsuP/2OyWLr1JqMDt8flK94e
        i/e8ZPKYsOgAo0fLyf0sHt/Xd7B5fHx6i8Wjb8sqRo/Pm+Q82g90MwVwRmXbZKQmpqQWKaTm
        JeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gAdq6RQlphTChQKSCwuVtK3
        synKLy1JVcjILy6xVUotSMkpMC/QK07MLS7NS9fLSy2xMjQwMDIFKkzIznh16xVzwX/2irtv
        5zI3MD5i62Lk5JAQMJGYPHsuUxcjF4eQwA5GifZT71m6GDk4eAUEJf7uEAYxhQXcJVq3lYKU
        CwkoSZxbM4sRImwgcavXHCTMJqAn8XPJDLCJIgJtLBLrT7NDTOeVmNH+lAXClpbYvnwrWCun
        gJ/E/cNZEGENiR/LepkhbFGJm6vfssPY74/NZ4SwRSRa752FqhGUePBzN1RcUuLQoa9sICMl
        BPIlNhwIhAjXSLxdfgCqRF/iWsdGsAt4BXwlbjb/YwWxWQRUJT5P3wwNAxeJ/nUnwWqYBeQl
        tr+dwwwykllAU2L9Ln2I6coSR26xwPzUsPE3OzqbWYBPouPwX7j4jnlPmCBa1SQWNRlBhGUk
        vh6ezz6BUWkWIohnIVk7C2HtAkbmVYxiqQXFuempxUYFJvBYTc7P3cQITrBaHjsYZ7/9oHeI
        kYmD8RCjBAezkgjvCsvXSUK8KYmVValF+fFFpTmpxYcYTYEensgsJZqcD0zxeSXxhiaWBiZm
        ZobmRqYG5krivF4pGxKFBNITS1KzU1MLUotg+pg4OKUamFRMLc/dD7FIMtaaw3ovTZb1JAPr
        4326T9/mMndUf2G9Fn5R9qlQaguL63G1U4J7d8x7UPjhnax/rekxzkzdfZMPPirbL57Cf73D
        cuKrw/UnLX4cffpeX0P3m1nDz81mMvp6xhbVenN0Ftde/s1orFv/0s/5uKWPx7vEjV+6w95d
        ljmU/enmwb9lS/jVRIMmGiquPWf4S+X+ElYD3ylr52V4bjl0RvR7S9Qj79kMR1u8yiV9JDKW
        Xvv1/NhdkbIlVc9ktl1rX54j2Xzi0LLP9vcn/RCcfSbP/zbLtJO2m9ycI/+41sYmbA3yVahO
        dMlRWZDWZbLDQjPKyLqXp85iaSn3TKHGJ9H6lS4Jl6dPV2Ipzkg01GIuKk4EADQvNCE5BAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220804074224epcms2p18f0ac2f92073aeed981718a9cab23866
References: <20220804074224epcms2p18f0ac2f92073aeed981718a9cab23866@epcms2p1>
        <CGME20220804074224epcms2p18f0ac2f92073aeed981718a9cab23866@epcms2p8>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
