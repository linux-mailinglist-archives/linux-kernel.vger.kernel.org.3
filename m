Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFF34D9EF6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 16:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349725AbiCOPpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 11:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349702AbiCOPo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 11:44:57 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D330913CDD;
        Tue, 15 Mar 2022 08:43:44 -0700 (PDT)
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22FARJ3Q018367;
        Tue, 15 Mar 2022 15:43:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=TAo7Ep+DrB7wKhwVK2qoCBsJsS5PRjEodBXs1jfXTAY=;
 b=gNKu8J3F74wTjj8eayDzMDCgxTz/9mNF/TPvOTNckbgiXZFLOnKhGSfDay+VZkMN151n
 L43icPmbpFs25MlmASS89hU/mZ88O+dvoIQ2SG1UqbLsXORoixVNQmEr3V/ae1vxLzRv
 Kn6fhaKjmHsfTrlJoYerbw/9UU44RkQIIL795T45iJ/Acmkq9s17Afmb1e+z21RhwK7k
 YbaOHWduE4g78jXl9ZUf2nFOe9Uvz9twW3nZrYUvoO36twftwvWsYuiy0BWWJM32KtYF
 Xs8SmAR0OG9hfW3N+/VwKRsfKNhgrI5E5jI8fBHPmxYtd4jZTooGI92UsFtfmAykEX0H Bw== 
Received: from g4t3426.houston.hpe.com (g4t3426.houston.hpe.com [15.241.140.75])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3etqyb3rpw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Mar 2022 15:43:07 +0000
Received: from g4t3433.houston.hpecorp.net (g4t3433.houston.hpecorp.net [16.208.49.245])
        by g4t3426.houston.hpe.com (Postfix) with ESMTP id D15824E;
        Tue, 15 Mar 2022 15:43:06 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (dog.eag.rdlabs.hpecorp.net [128.162.243.181])
        by g4t3433.houston.hpecorp.net (Postfix) with ESMTP id F3DFB46;
        Tue, 15 Mar 2022 15:43:05 +0000 (UTC)
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
Subject: [PATCH v2 1/3] x86/platform/uv: Update NMI Handler for UV5
Date:   Tue, 15 Mar 2022 10:42:47 -0500
Message-Id: <20220315154249.201067-2-mike.travis@hpe.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220315154249.201067-1-mike.travis@hpe.com>
References: <20220315154249.201067-1-mike.travis@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 8z-i0VRx3kCzfXn6RmrEEdxnVlkxQzsU
X-Proofpoint-ORIG-GUID: 8z-i0VRx3kCzfXn6RmrEEdxnVlkxQzsU
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-15_03,2022-03-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 mlxscore=0 mlxlogscore=999 impostorscore=0 suspectscore=0
 adultscore=0 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203150101
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update NMI handler to interface with UV5 hardware. This involves changing
the EVENT_OCCURRED MMR used by the hardware and removes the check for
which NMI function is supported by UV BIOS.  The newer NMI function is
assumed supported on UV5 and above.

Signed-off-by: Mike Travis <mike.travis@hpe.com>
Reviewed-by: Dimitri Sivanich <dimitri.sivanich@hpe.com>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
---
v2: Use bool flag to assume NMI support for UV5 and above
---
 arch/x86/platform/uv/uv_nmi.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/x86/platform/uv/uv_nmi.c b/arch/x86/platform/uv/uv_nmi.c
index 1e9ff28bc2e0..4bab69fcd18c 100644
--- a/arch/x86/platform/uv/uv_nmi.c
+++ b/arch/x86/platform/uv/uv_nmi.c
@@ -244,8 +244,10 @@ static inline bool uv_nmi_action_is(const char *action)
 /* Setup which NMI support is present in system */
 static void uv_nmi_setup_mmrs(void)
 {
+	bool nmi_supported = 0;
+
 	/* First determine arch specific MMRs to handshake with BIOS */
-	if (UVH_EVENT_OCCURRED0_EXTIO_INT0_MASK) {
+	if (UVH_EVENT_OCCURRED0_EXTIO_INT0_MASK) {	/* UV2,3,4 setup */
 		uvh_nmi_mmrx = UVH_EVENT_OCCURRED0;
 		uvh_nmi_mmrx_clear = UVH_EVENT_OCCURRED0_ALIAS;
 		uvh_nmi_mmrx_shift = UVH_EVENT_OCCURRED0_EXTIO_INT0_SHFT;
@@ -255,26 +257,26 @@ static void uv_nmi_setup_mmrs(void)
 		uvh_nmi_mmrx_req = UVH_BIOS_KERNEL_MMR_ALIAS_2;
 		uvh_nmi_mmrx_req_shift = 62;
 
-	} else if (UVH_EVENT_OCCURRED1_EXTIO_INT0_MASK) {
+	} else if (UVH_EVENT_OCCURRED1_EXTIO_INT0_MASK) { /* UV5+ setup */
 		uvh_nmi_mmrx = UVH_EVENT_OCCURRED1;
 		uvh_nmi_mmrx_clear = UVH_EVENT_OCCURRED1_ALIAS;
 		uvh_nmi_mmrx_shift = UVH_EVENT_OCCURRED1_EXTIO_INT0_SHFT;
 		uvh_nmi_mmrx_type = "OCRD1-EXTIO_INT0";
 
-		uvh_nmi_mmrx_supported = UVH_EXTIO_INT0_BROADCAST;
-		uvh_nmi_mmrx_req = UVH_BIOS_KERNEL_MMR_ALIAS_2;
-		uvh_nmi_mmrx_req_shift = 62;
+		nmi_supported = 1;		/* assume sync valid on UV5+ */
+		uvh_nmi_mmrx_req = 0;		/* no request bit to clear */
 
 	} else {
-		pr_err("UV:%s:cannot find EVENT_OCCURRED*_EXTIO_INT0\n",
-			__func__);
+		pr_err("UV:%s:NMI support not available on this system\n", __func__);
 		return;
 	}
 
 	/* Then find out if new NMI is supported */
-	if (likely(uv_read_local_mmr(uvh_nmi_mmrx_supported))) {
-		uv_write_local_mmr(uvh_nmi_mmrx_req,
-					1UL << uvh_nmi_mmrx_req_shift);
+	if (likely(nmi_supported) ||
+	   (uv_read_local_mmr(uvh_nmi_mmrx_supported) & 1UL << uvh_nmi_mmrx_req_shift)) {
+		if (uvh_nmi_mmrx_req)
+			uv_write_local_mmr(uvh_nmi_mmrx_req,
+						1UL << uvh_nmi_mmrx_req_shift);
 		nmi_mmr = uvh_nmi_mmrx;
 		nmi_mmr_clear = uvh_nmi_mmrx_clear;
 		nmi_mmr_pending = 1UL << uvh_nmi_mmrx_shift;
-- 
2.26.2

