Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23C3F4F6C34
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 23:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233668AbiDFVLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 17:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235196AbiDFVKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 17:10:48 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70727522EA;
        Wed,  6 Apr 2022 12:52:30 -0700 (PDT)
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 236HOnn8020668;
        Wed, 6 Apr 2022 19:51:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=9fcEDTBymkCzxRXWh5HStMC0uPGxFf8X8/Y+P8j7Jgo=;
 b=O/7y+aZ0EJxOa5trXJu2Q1YjRRCavt26FjTBoPz608/FVkZlD2N6mzJ3jiM32wQGg0fM
 uNHVjJtK9fbr1e76wWItm3eOU/bw9QEsWhKr8wl+EO9Bbf/4QAW929ssMX72l0MIQl2+
 WWO8kUj/a/qO7HW5oMMgEiKxt5emZdRzq9uKHF6zZ8uZ/EikRn87YyMHvRa+en6kFqFJ
 iI0Zv9nJnToyE3ZgF1+W8A3wSmM3eH7nclTTs+qij5ivAeYFyqk0PzxGuUcbJE78VY41
 7CI/cHT3f1ujiFlRJcBjltuEoxzzzndqCk9gLZrHTDDirHfNhnGbxoKxJa4oHXE55SyB Xw== 
Received: from g9t5009.houston.hpe.com (g9t5009.houston.hpe.com [15.241.48.73])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3f9d8ba9x6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Apr 2022 19:51:51 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g9t5009.houston.hpe.com (Postfix) with ESMTP id E774863;
        Wed,  6 Apr 2022 19:51:50 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (dog.eag.rdlabs.hpecorp.net [128.162.243.181])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id 4C5774D;
        Wed,  6 Apr 2022 19:51:50 +0000 (UTC)
Received: by dog.eag.rdlabs.hpecorp.net (Postfix, from userid 200934)
        id C936D3007794E; Wed,  6 Apr 2022 14:51:49 -0500 (CDT)
From:   Steve Wahl <steve.wahl@hpe.com>
To:     Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Cc:     Mike Travis <mike.travis@hpe.com>, Steve Wahl <steve.wahl@hpe.com>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH v4 1/3] x86/platform/uv: Update NMI Handler for UV5
Date:   Wed,  6 Apr 2022 14:51:47 -0500
Message-Id: <20220406195149.228164-2-steve.wahl@hpe.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220406195149.228164-1-steve.wahl@hpe.com>
References: <20220406195149.228164-1-steve.wahl@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 8Gvke4zppVrqrS_nuqfRZVMKuCvFW1Us
X-Proofpoint-GUID: 8Gvke4zppVrqrS_nuqfRZVMKuCvFW1Us
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-06_11,2022-04-06_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2202240000 definitions=main-2204060098
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Travis <mike.travis@hpe.com>

Update NMI handler for UV5 hardware. A platform register changed, and
UV5 only uses one of the two NMI methods used on previous hardware.

Signed-off-by: Mike Travis <mike.travis@hpe.com>
Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
Reviewed-by: Dimitri Sivanich <dimitri.sivanich@hpe.com>
---
v4: Clarify comments, change variable name to better convey what's happening
v3: Fix mistake in UVH_EXTIO_INT0_BROADCAST check.
    Use true/false in setting bool flag.
v2: Use bool flag to assume NMI support for UV5 and above.
---
 arch/x86/platform/uv/uv_nmi.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/x86/platform/uv/uv_nmi.c b/arch/x86/platform/uv/uv_nmi.c
index 1e9ff28bc2e0..50fdd1a77f02 100644
--- a/arch/x86/platform/uv/uv_nmi.c
+++ b/arch/x86/platform/uv/uv_nmi.c
@@ -244,8 +244,10 @@ static inline bool uv_nmi_action_is(const char *action)
 /* Setup which NMI support is present in system */
 static void uv_nmi_setup_mmrs(void)
 {
+	bool new_nmi_method_only = false;
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
+		new_nmi_method_only = true;		/* Newer nmi always valid on UV5+ */
+		uvh_nmi_mmrx_req = 0;			/* no request bit to clear */
 
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
+	if (new_nmi_method_only || uv_read_local_mmr(uvh_nmi_mmrx_supported)) {
+		if (uvh_nmi_mmrx_req)
+			uv_write_local_mmr(uvh_nmi_mmrx_req,
+						1UL << uvh_nmi_mmrx_req_shift);
 		nmi_mmr = uvh_nmi_mmrx;
 		nmi_mmr_clear = uvh_nmi_mmrx_clear;
 		nmi_mmr_pending = 1UL << uvh_nmi_mmrx_shift;
-- 
2.26.2

