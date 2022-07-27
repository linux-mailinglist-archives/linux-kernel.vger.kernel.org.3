Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4095820A9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 09:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiG0HF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 03:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiG0HF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 03:05:27 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165F8DFC2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 00:05:25 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220727070523epoutp026f17ca983289e6c497eb8be284a97e81~FncjRPege2516125161epoutp02p
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 07:05:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220727070523epoutp026f17ca983289e6c497eb8be284a97e81~FncjRPege2516125161epoutp02p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1658905523;
        bh=R6OHZS8L6v6uGk9MS1iioqNTlA6txP76blUF08vlRRs=;
        h=Subject:Reply-To:From:To:In-Reply-To:Date:References:From;
        b=kU92BbhfG+juNXHex4nfROQrZXD7uA7jcrBitotCEOffGEWbur+vAEHKBXr09oJoM
         05vLvufMD+A+J6wNH6rkNy4e70qDnwisPr+ohaqH1gYFMd8S0a7v8hTIHT93GXJpV0
         4WmqRnver02ot76TuvpQ0/7vczSQQFFnfX3eDvv0=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20220727070523epcas2p167dff79a64fd544b7fa80694b4c297cb~Fnci3g7m41693016930epcas2p1n;
        Wed, 27 Jul 2022 07:05:23 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.90]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Lt4YG5VCdz4x9QL; Wed, 27 Jul
        2022 07:05:22 +0000 (GMT)
X-AuditID: b6c32a45-45bff700000025c2-3f-62e0e3b2b448
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        03.9B.09666.2B3E0E26; Wed, 27 Jul 2022 16:05:22 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v4 2/7] scsi: ufs: wb: Change wb_enabled condition test
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
In-Reply-To: <20220727070410epcms2p5206785e4d960b32dcbb6729710dab535@epcms2p5>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220727070522epcms2p5ad2dd21b471acee963dd58b37d35e11f@epcms2p5>
Date:   Wed, 27 Jul 2022 16:05:22 +0900
X-CMS-MailID: 20220727070522epcms2p5ad2dd21b471acee963dd58b37d35e11f
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPJsWRmVeSWpSXmKPExsWy7bCmme6mxw+SDPas1bY4+WQNm8WDedvY
        LF7+vMpmcfBhJ4vFtA8/mS1eHtK0WHRjG5PF5V1z2Cy6r+9gs1h+/B+TA5fH5SveHov3vGTy
        mLDoAKPH9/UdbB4fn95i8ejbsorR4/MmOY/2A91MARxR2TYZqYkpqUUKqXnJ+SmZeem2St7B
        8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6bpk5QCcqKZQl5pQChQISi4uV9O1sivJLS1IVMvKL
        S2yVUgtScgrMC/SKE3OLS/PS9fJSS6wMDQyMTIEKE7Iz7jdtYS3oZqtoPnCcuYFxImsXIyeH
        hICJxKJVBxm7GLk4hAR2MErsejoPKMHBwSsgKPF3hzBIjbCAu8T0v3+ZQGwhASWJc2tmMYKU
        CAsYSNzqNQcJswnoSfxcMoMNZIyIwFlmiYUPpzBBzOeVmNH+lAXClpbYvnwrI4jNKeAn0fPi
        BNQNGhI/lvUyQ9iiEjdXv2WHsd8fm88IYYtItN47C1UjKPHg526ouKTEoUNf2UDukRDIl9hw
        IBAiXCPxdvkBqBJ9iWsdG8FO4BXwlWi4NgPsNBYBVYnZz/uhTnCRmPd2KVgNs4C8xPa3c5hB
        RjILaEqs36UPMV1Z4sgtFpinGjb+ZkdnMwvwSXQc/gsX3zHvCRNEq5rEoiYjiLCMxNfD89kn
        MCrNQoTyLCRrZyGsXcDIvIpRLLWgODc9tdiowBAescn5uZsYwSlVy3UH4+S3H/QOMTJxMB5i
        lOBgVhLhTYi+nyTEm5JYWZValB9fVJqTWnyI0RTo4YnMUqLJ+cCknlcSb2hiaWBiZmZobmRq
        YK4kzuuVsiFRSCA9sSQ1OzW1ILUIpo+Jg1OqgWnjOzmFxacXTFn2/UHb3/J2naAC3ZuaVprH
        HikpTDq4WpjPtzX3oVnt7/CgKb88j29+13Nk6dmwgP9h/iL8x5dXKrFz55/0fzEzf+21OoZr
        D2V0FA3/iYWu4356WJe564D/fD9JJYn724Jf/suvSTrWWLFvYbXF9eps06JJ+9Y55LGk3f9m
        4BoyRURsI+f2rlki9U9OsWRruzxWWDL5Z5v7vMVH/8xWY7zkZHlbk4OlZMbbo6pHrhws2GB9
        +65/caDhz5PtrbfjQ/8uvBvluFdAMjzms6fd8Y2nsrYfYtHKa98RuSDKXKHefqfL5KpTx3cc
        39SzrlN1dgSXS3Nvx5eq6i1qfsGmJ1zyJfvipiuxFGckGmoxFxUnAgBGWGPvMgQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220727065904epcms2p60a7a56101785ddefa55c82b3cc25116d
References: <20220727070410epcms2p5206785e4d960b32dcbb6729710dab535@epcms2p5>
        <20220727065904epcms2p60a7a56101785ddefa55c82b3cc25116d@epcms2p6>
        <CGME20220727065904epcms2p60a7a56101785ddefa55c82b3cc25116d@epcms2p5>
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
Signed-off-by: Jinyoung Choi <j-young.choi@samsung.com>
---
 drivers/ufs/core/ufshcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index a3bdf9986511..48ba109e29f7 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -5733,7 +5733,7 @@ int ufshcd_wb_toggle(struct ufs_hba *hba, bool enable)
 {
 	int ret;
 
-	if (!(enable ^ hba->dev_info.wb_enabled))
+	if (hba->dev_info.wb_enabled == enable)
 		return 0;
 
 	ret = __ufshcd_wb_toggle(hba, enable, QUERY_FLAG_IDN_WB_EN);
-- 
2.25.1
