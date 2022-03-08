Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B15F4D0D3B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 02:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344200AbiCHBHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 20:07:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242839AbiCHBHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 20:07:20 -0500
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C84F30F6E;
        Mon,  7 Mar 2022 17:06:25 -0800 (PST)
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 227NIDU1019922;
        Tue, 8 Mar 2022 01:05:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=fDTsdmG1pqyVShSr12ajAIDhLg24fyBw6k5XjNje+2c=;
 b=hnTalihwQNFzYF149WlS+Q/ctrOMXVU0HoFiQA39Pmwn2k7TlT4bsKc8w5pgmhThsZbQ
 N1RUHM+aDAOlUxEE7syiebGVCCbqCSUfQIM0mr2U3vpUPR6+m5PNUWfcIuJ1BWMFmzz8
 CSAmMbRQ4wRJvMR/XYJuBlRgmKjdGpt1I/GdvCjMP1UFwl/8xaHb1wOGWAF4n/Tbl6ON
 KxEOnioPhD7q+JWp4yEnS5Ys8Xg3uKatnO5/jsDkSuXOVj7jdysMNEFj8Q5Mc8G9hTs+
 U2AH2wLcJO7QlZTk2q27ZPZICkQypxkl1QgRiz4plLnwUCIwXO5XQA4dwkCvbn50MK9Y LA== 
Received: from g4t3426.houston.hpe.com (g4t3426.houston.hpe.com [15.241.140.75])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3ensrf1dcc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Mar 2022 01:05:51 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g4t3426.houston.hpe.com (Postfix) with ESMTP id 7A1CC4F;
        Tue,  8 Mar 2022 01:05:50 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (dog.eag.rdlabs.hpecorp.net [128.162.243.181])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id 960D64A;
        Tue,  8 Mar 2022 01:05:49 +0000 (UTC)
From:   Mike Travis <mike.travis@hpe.com>
To:     Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steve Wahl <steve.wahl@hpe.com>, x86@kernel.org
Cc:     Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH 2/4] x86/platform/uv: Update NMI Handler for UV5
Date:   Mon,  7 Mar 2022 19:05:35 -0600
Message-Id: <20220308010537.70150-3-mike.travis@hpe.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220308010537.70150-1-mike.travis@hpe.com>
References: <20220308010537.70150-1-mike.travis@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: wM21q4DL4STOqrLNBdYBhKkeIaVAJzDf
X-Proofpoint-GUID: wM21q4DL4STOqrLNBdYBhKkeIaVAJzDf
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-07_12,2022-03-04_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 malwarescore=0
 adultscore=0 suspectscore=0 clxscore=1015 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203080000
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update NMI handler to interface with UV5 hardware. This involves
changing the EVENT_OCCURRED MMR used by the hardware and removes
the check for the newer NMI function supported by UV BIOS.

Signed-off-by: Mike Travis <mike.travis@hpe.com>
Reviewed-by: Dimitri Sivanich <dimitri.sivanich@hpe.com>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
---
 arch/x86/platform/uv/uv_nmi.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/x86/platform/uv/uv_nmi.c b/arch/x86/platform/uv/uv_nmi.c
index 926a4e006e5a..38f4beae9fab 100644
--- a/arch/x86/platform/uv/uv_nmi.c
+++ b/arch/x86/platform/uv/uv_nmi.c
@@ -245,7 +245,7 @@ static inline bool uv_nmi_action_is(const char *action)
 static void uv_nmi_setup_mmrs(void)
 {
 	/* First determine arch specific MMRs to handshake with BIOS */
-	if (UVH_EVENT_OCCURRED0_EXTIO_INT0_MASK) {
+	if (UVH_EVENT_OCCURRED0_EXTIO_INT0_MASK) {	/* UV2,3,4 setup */
 		uvh_nmi_mmrx = UVH_EVENT_OCCURRED0;
 		uvh_nmi_mmrx_clear = UVH_EVENT_OCCURRED0_ALIAS;
 		uvh_nmi_mmrx_shift = UVH_EVENT_OCCURRED0_EXTIO_INT0_SHFT;
@@ -255,26 +255,26 @@ static void uv_nmi_setup_mmrs(void)
 		uvh_nmi_mmrx_req = UVH_BIOS_KERNEL_MMR_ALIAS_2;
 		uvh_nmi_mmrx_req_shift = 62;
 
-	} else if (UVH_EVENT_OCCURRED1_EXTIO_INT0_MASK) {
+	} else if (UVH_EVENT_OCCURRED1_EXTIO_INT0_MASK) { /* UV5 setup */
 		uvh_nmi_mmrx = UVH_EVENT_OCCURRED1;
 		uvh_nmi_mmrx_clear = UVH_EVENT_OCCURRED1_ALIAS;
 		uvh_nmi_mmrx_shift = UVH_EVENT_OCCURRED1_EXTIO_INT0_SHFT;
 		uvh_nmi_mmrx_type = "OCRD1-EXTIO_INT0";
 
-		uvh_nmi_mmrx_supported = UVH_EXTIO_INT0_BROADCAST;
-		uvh_nmi_mmrx_req = UVH_BIOS_KERNEL_MMR_ALIAS_2;
-		uvh_nmi_mmrx_req_shift = 62;
+		uvh_nmi_mmrx_supported = 1;
+		uvh_nmi_mmrx_req = 0;
 
 	} else {
-		pr_err("UV:%s:cannot find EVENT_OCCURRED*_EXTIO_INT0\n",
-			__func__);
+		pr_err("UV:%s:NMI support not available on this system\n", __func__);
 		return;
 	}
 
-	/* Then find out if new NMI is supported */
-	if (likely(uv_read_local_mmr(uvh_nmi_mmrx_supported))) {
-		uv_write_local_mmr(uvh_nmi_mmrx_req,
-					1UL << uvh_nmi_mmrx_req_shift);
+	/* Then find out if new NMI is supported (assumed on UV5) */
+	if (likely(uvh_nmi_mmrx_supported == 1) ||
+	   (uv_read_local_mmr(uvh_nmi_mmrx_supported) & 1UL << uvh_nmi_mmrx_req_shift)) {
+		if (uvh_nmi_mmrx_req)
+			uv_write_local_mmr(uvh_nmi_mmrx_req,
+						1UL << uvh_nmi_mmrx_req_shift);
 		nmi_mmr = uvh_nmi_mmrx;
 		nmi_mmr_clear = uvh_nmi_mmrx_clear;
 		nmi_mmr_pending = 1UL << uvh_nmi_mmrx_shift;
-- 
2.26.2

