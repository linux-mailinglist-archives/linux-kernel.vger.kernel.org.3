Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 089A94F1EAA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380529AbiDDWHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 18:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379596AbiDDRoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 13:44:10 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E7131DE8;
        Mon,  4 Apr 2022 10:42:14 -0700 (PDT)
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 234Gitsk001178;
        Mon, 4 Apr 2022 17:41:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=v6iZXwA2Am8swC6551Es3v1s4q+s9epkgRTwcKxjD5I=;
 b=iE5NPwcDy/K9FbjSFhvk0i813cqcvehb4sAcAHz7wD64lG8v7HD6SmKbmXY3UprsyKWc
 BXcJ5/4OOhO+4+tJclJSWM1jpYm8C/3Juqriv6suZSvA64UlyBWC0MK2oy4KPzq2F9vE
 rvEJmp71L4/OcnJTaN9yGcQmu9X7toMDwuLTnSlKqclUM6+25Xfa3ZITGzciJfmM00Ed
 jaG7h3W/ffnX81zIByIVSN7s42uWZJkqRBGUnU5gqaLWrEWJLOlVo1RyikkGfI1ciOfr
 tAfmcB/7nqr2t0dFrI3HM1nwnEoPtiFHQFOvHSVK3sWKd5eIOUBUQm1/gj1+TmY+JDDs Lw== 
Received: from g4t3425.houston.hpe.com (g4t3425.houston.hpe.com [15.241.140.78])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3f84f6rmj6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Apr 2022 17:41:37 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g4t3425.houston.hpe.com (Postfix) with ESMTP id 2366D8D;
        Mon,  4 Apr 2022 17:41:36 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (dog.eag.rdlabs.hpecorp.net [128.162.243.181])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id 461B650;
        Mon,  4 Apr 2022 17:41:35 +0000 (UTC)
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
Subject: [PATCH v3 1/3] x86/platform/uv: Update NMI Handler for UV5
Date:   Mon,  4 Apr 2022 12:41:09 -0500
Message-Id: <20220404174111.262414-2-mike.travis@hpe.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220404174111.262414-1-mike.travis@hpe.com>
References: <20220404174111.262414-1-mike.travis@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: mF3WG-gxurDNXS8dqyI5j0_zPu2UiUly
X-Proofpoint-GUID: mF3WG-gxurDNXS8dqyI5j0_zPu2UiUly
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-04_06,2022-03-31_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 spamscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2202240000 definitions=main-2204040100
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
v3: Fix mistake in UVH_EXTIO_INT0_BROADCAST check.
    Use true/false in setting bool flag.
v2: Use bool flag to assume NMI support for UV5 and above.
---
 arch/x86/platform/uv/uv_nmi.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/x86/platform/uv/uv_nmi.c b/arch/x86/platform/uv/uv_nmi.c
index 1e9ff28bc2e0..6d2e9ae8576b 100644
--- a/arch/x86/platform/uv/uv_nmi.c
+++ b/arch/x86/platform/uv/uv_nmi.c
@@ -244,8 +244,10 @@ static inline bool uv_nmi_action_is(const char *action)
 /* Setup which NMI support is present in system */
 static void uv_nmi_setup_mmrs(void)
 {
+	bool nmi_supported = false;
+
 	/* First determine arch specific MMRs to handshake with BIOS */
-	if (UVH_EVENT_OCCURRED0_EXTIO_INT0_MASK) {
+	if (UVH_EVENT_OCCURRED0_EXTIO_INT0_MASK) {	/* UV2,3,4 setup */
 		uvh_nmi_mmrx = UVH_EVENT_OCCURRED0;
 		uvh_nmi_mmrx_clear = UVH_EVENT_OCCURRED0_ALIAS;
 		uvh_nmi_mmrx_shift = UVH_EVENT_OCCURRED0_EXTIO_INT0_SHFT;
@@ -255,26 +257,25 @@ static void uv_nmi_setup_mmrs(void)
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
+		nmi_supported = true;		/* assume sync valid on UV5+ */
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
+	if (likely(nmi_supported) || (uv_read_local_mmr(uvh_nmi_mmrx_supported))) {
+		if (uvh_nmi_mmrx_req)
+			uv_write_local_mmr(uvh_nmi_mmrx_req,
+						1UL << uvh_nmi_mmrx_req_shift);
 		nmi_mmr = uvh_nmi_mmrx;
 		nmi_mmr_clear = uvh_nmi_mmrx_clear;
 		nmi_mmr_pending = 1UL << uvh_nmi_mmrx_shift;
-- 
2.26.2

