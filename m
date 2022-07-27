Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E355820A3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 09:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbiG0HET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 03:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiG0HEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 03:04:15 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B871C904
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 00:04:14 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220727070411epoutp04204b99bf254240ab343593dccdd2ce3e~Fnbgk7wf-1980619806epoutp04A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 07:04:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220727070411epoutp04204b99bf254240ab343593dccdd2ce3e~Fnbgk7wf-1980619806epoutp04A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1658905452;
        bh=LXR6+O3eDWHctBCVff2wddft4H7hjY69vVRu/Mki4Uk=;
        h=Subject:Reply-To:From:To:In-Reply-To:Date:References:From;
        b=QYkW1oEC1f49N7wxkZz+zBS5+Mz2yeg6VKgswL8Ja2kaGeaFn1/zPEbtryg2Gmi44
         /qHvhsGIFrZiFIi+2MlvZmoA1sq1IgTLtuzb99uDPyTdBFt6OUNc+sP2YoSwphMzGT
         i/Xfm13WV6g3nf+FDjA7nNNS2CktWq0/EdT0uORo=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20220727070411epcas2p2bf17ee8cd775ee25c08011dd302627c6~FnbgLo7RU0217702177epcas2p2J;
        Wed, 27 Jul 2022 07:04:11 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.68]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Lt4Wt6znRz4x9Q1; Wed, 27 Jul
        2022 07:04:10 +0000 (GMT)
X-AuditID: b6c32a45-471ff700000025c2-c9-62e0e36a7e60
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        ED.0B.09666.A63E0E26; Wed, 27 Jul 2022 16:04:10 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v4 1/7] scsi: ufs: wb: Move ufshcd_is_wb_allowed() to callee
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
In-Reply-To: <20220727065904epcms2p60a7a56101785ddefa55c82b3cc25116d@epcms2p6>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220727070410epcms2p5206785e4d960b32dcbb6729710dab535@epcms2p5>
Date:   Wed, 27 Jul 2022 16:04:10 +0900
X-CMS-MailID: 20220727070410epcms2p5206785e4d960b32dcbb6729710dab535
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPJsWRmVeSWpSXmKPExsWy7bCmuW7W4wdJBh+eWVicfLKGzeLBvG1s
        Fi9/XmWzOPiwk8Vi2oefzBYvD2laLLqxjcni8q45bBbd13ewWSw//o/Jgcvj8hVvj8V7XjJ5
        TFh0gNHj+/oONo+PT2+xePRtWcXo8XmTnEf7gW6mAI6obJuM1MSU1CKF1Lzk/JTMvHRbJe/g
        eOd4UzMDQ11DSwtzJYW8xNxUWyUXnwBdt8wcoBOVFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnF
        JbZKqQUpOQXmBXrFibnFpXnpenmpJVaGBgZGpkCFCdkZ/9+9YS5o56k4+nIdawNjI1cXIyeH
        hICJxNp1O5m7GLk4hAR2MEq0X5vB3sXIwcErICjxd4cwSI2wgI/EoUWb2UFsIQEliXNrZjGC
        lAgLGEjc6jUHCbMJ6En8XDKDDWSMiMBZZomFD6cwQcznlZjR/pQFwpaW2L58KyOIzSngJ/Fq
        yl5GiLiGxI9lvcwQtqjEzdVv2WHs98fmQ9WISLTeOwtVIyjx4OduqLikxKFDX9lA7pEQyJfY
        cCAQIlwj8Xb5AagSfYlrHRvBTuAV8JU4fPEnG4jNIqAqcW/2K6gaF4nN61rAbGYBeYntb+cw
        g4xkFtCUWL9LH2K6ssSRWywwTzVs/M2OzmYW4JPoOPwXLr5j3hMmiFY1iUVNRhBhGYmvh+ez
        T2BUmoUI5VlI1s5CWLuAkXkVo1hqQXFuemqxUYEhPGKT83M3MYJTqpbrDsbJbz/oHWJk4mA8
        xCjBwawkwpsQfT9JiDclsbIqtSg/vqg0J7X4EKMp0MMTmaVEk/OBST2vJN7QxNLAxMzM0NzI
        1MBcSZzXK2VDopBAemJJanZqakFqEUwfEwenVAOTEu+Sre+sPI+fv5xv67U5zsp1hWdm6YHp
        7zQj1R4s6WJyLv4pf6FysZP1Z7uaFbz5lQwlsUuyE/qN/iUETJ8o/aNB0TJU0PWcPkfuQTFh
        V0bm9LSJ8h1X922I/PdPQPZVQqV5w3GbO0FzuhrXyG7X/Hbm0anZmbOz16y9wHs6NuWsXCrb
        6+kz9324fCSwZP6GBTHMlamZ72cHTF17L+5OWZuojKxZ8o2VHfHZcesslUJfhc9Yquz4b2q1
        0Q7DXytDlxf0zeQRXRMfMKHbOs9p8qJZu/z2P26Z1P3Ma2vIE1Z/lyjfjtA3fe9s17Cwl/ua
        nNkcFMY+mTU5fq53zJfoObHVW1u+x7TvdV31o0CJpTgj0VCLuag4EQDEvCr+MgQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220727065904epcms2p60a7a56101785ddefa55c82b3cc25116d
References: <20220727065904epcms2p60a7a56101785ddefa55c82b3cc25116d@epcms2p6>
        <CGME20220727065904epcms2p60a7a56101785ddefa55c82b3cc25116d@epcms2p5>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The condition test is performed for each function calling
__ufshcd_wb_toggle().
By modifying the position, it removes the code redundancy and prevents
the test from being missing in the caller function.

Reviewed-by: Avri Altman <avri.altman@wdc.com>
Signed-off-by: Jinyoung Choi <j-young.choi@samsung.com>
---
 drivers/ufs/core/ufshcd.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 8f11f118c30e..a3bdf9986511 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -5722,6 +5722,9 @@ static int __ufshcd_wb_toggle(struct ufs_hba *hba, bool set, enum flag_idn idn)
 	enum query_opcode opcode = set ? UPIU_QUERY_OPCODE_SET_FLAG :
 				   UPIU_QUERY_OPCODE_CLEAR_FLAG;
 
+	if (!ufshcd_is_wb_allowed(hba))
+		return -EPERM;
+
 	index = ufshcd_wb_get_query_index(hba);
 	return ufshcd_query_flag_retry(hba, opcode, idn, index, NULL);
 }
@@ -5730,9 +5733,6 @@ int ufshcd_wb_toggle(struct ufs_hba *hba, bool enable)
 {
 	int ret;
 
-	if (!ufshcd_is_wb_allowed(hba))
-		return 0;
-
 	if (!(enable ^ hba->dev_info.wb_enabled))
 		return 0;
 
@@ -5769,8 +5769,7 @@ static inline void ufshcd_wb_toggle_flush(struct ufs_hba *hba, bool enable)
 {
 	int ret;
 
-	if (!ufshcd_is_wb_allowed(hba) ||
-	    hba->dev_info.wb_buf_flush_enabled == enable)
+	if (hba->dev_info.wb_buf_flush_enabled == enable)
 		return;
 
 	ret = __ufshcd_wb_toggle(hba, enable, QUERY_FLAG_IDN_WB_BUFF_FLUSH_EN);
-- 
2.25.1
