Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3A554D9EF2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 16:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349710AbiCOPo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 11:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349695AbiCOPo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 11:44:56 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675E313CD6;
        Tue, 15 Mar 2022 08:43:44 -0700 (PDT)
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22FEP3ii027583;
        Tue, 15 Mar 2022 15:43:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=BqkAywTgWdlW1+XBiXg5Rfy8g9DvAfqYPHFJLBdTzOk=;
 b=Q/7VDq0U/7A11PDBhbJkzps7Kb4q633tqup7bOX7q8pxLrcsdf34HPzGuPNAchY4UiQF
 m9fWXGqo3/4gcRfUeWksNEOLetOc2rDQ5juSrLknsx48XnKufIdsnPm2Z/BwdP1tAEQg
 PSADIvWF0qTSnLuihQcPoCiEQ+bH7ket2x4mQoaF9jGimG7FJknP2ru+4JlroG31Gw7p
 kly8iwzegrvQRZCxc0KPZbXgHMF+Sg4fZgYRzFPBWgj5BgQEkKB9xNyi/Ifu5hvtMBOJ
 boiDxRL8ane/F7jtugcebtNjQwdl2CZCLGxU13qDcUxOJaw6St7uJZcc6hQC6ajbgcgy KQ== 
Received: from g4t3425.houston.hpe.com (g4t3425.houston.hpe.com [15.241.140.78])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3etvhvrsnu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Mar 2022 15:43:08 +0000
Received: from g4t3433.houston.hpecorp.net (g4t3433.houston.hpecorp.net [16.208.49.245])
        by g4t3425.houston.hpe.com (Postfix) with ESMTP id 3D99F8D;
        Tue, 15 Mar 2022 15:43:07 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (dog.eag.rdlabs.hpecorp.net [128.162.243.181])
        by g4t3433.houston.hpecorp.net (Postfix) with ESMTP id E4F634A;
        Tue, 15 Mar 2022 15:43:06 +0000 (UTC)
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
Subject: [PATCH v2 2/3] x86/platform/uv: Update TSC sync state for UV5
Date:   Tue, 15 Mar 2022 10:42:48 -0500
Message-Id: <20220315154249.201067-3-mike.travis@hpe.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220315154249.201067-1-mike.travis@hpe.com>
References: <20220315154249.201067-1-mike.travis@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: r2THen_Mma8MzJ0A4onq1MwKP4PAQ1q5
X-Proofpoint-GUID: r2THen_Mma8MzJ0A4onq1MwKP4PAQ1q5
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-15_03,2022-03-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 adultscore=0 spamscore=0
 malwarescore=0 mlxscore=0 priorityscore=1501 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

Update TSC to not check TSC sync state for uv5+ as it is not available.
It is assumed that TSC will always be in sync for multiple chassis and
will pass the tests for the kernel to accept it as the clocksource.
To disable this check use the kernel start options tsc=reliable
clocksource=tsc.

Signed-off-by: Mike Travis <mike.travis@hpe.com>
Reviewed-by: Dimitri Sivanich <dimitri.sivanich@hpe.com>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
---
v2: Update patch description to be more explanatory.
---
 arch/x86/kernel/apic/x2apic_uv_x.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index f5a48e66e4f5..387d6533549a 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -199,10 +199,16 @@ static void __init uv_tsc_check_sync(void)
 	int mmr_shift;
 	char *state;
 
-	/* Different returns from different UV BIOS versions */
+	/* UV5+, sync state from bios not available, assumed valid */
+	if (!is_uv(UV2|UV3|UV4)) {
+		pr_debug("UV: TSC sync state for UV5+ assumed valid\n");
+		mark_tsc_async_resets("UV5+");
+		return;
+	}
+
+	/* UV2,3,4, UV BIOS TSC sync state available */
 	mmr = uv_early_read_mmr(UVH_TSC_SYNC_MMR);
-	mmr_shift =
-		is_uv2_hub() ? UVH_TSC_SYNC_SHIFT_UV2K : UVH_TSC_SYNC_SHIFT;
+	mmr_shift = is_uv2_hub() ? UVH_TSC_SYNC_SHIFT_UV2K : UVH_TSC_SYNC_SHIFT;
 	sync_state = (mmr >> mmr_shift) & UVH_TSC_SYNC_MASK;
 
 	/* Check if TSC is valid for all sockets */
-- 
2.26.2

