Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B3D4DE42B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 23:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241386AbiCRWpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 18:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241343AbiCRWpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 18:45:15 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A7819B087;
        Fri, 18 Mar 2022 15:43:53 -0700 (PDT)
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22IMbsiP020011;
        Fri, 18 Mar 2022 22:43:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=BqkAywTgWdlW1+XBiXg5Rfy8g9DvAfqYPHFJLBdTzOk=;
 b=ja2jcvQw1ZuQnneZx5pTsQ7ncsg2jrUi8WGCyRij34aRr4/nw/QSmFQli4ATQfjfdcjm
 xlZmolnOnQiTORyC9vRo7yhile1VX07gsUvqAWNzN0pIa+9LaSEsX2QNmtcBHAcWMzhH
 lbZ9TegffocGLCiz5QJhV0maQYZnp0kVIYERpfR+jTu262FQfeWvSy36XN+LSZYSjVUO
 9j1Kkl6ccFQ2y4UgbqlK3+5Y+UbKw4ls/87OGrd1BWO8MN8nerQn28OePeXDj53ymAVV
 H0XckecD1aNdO28Ff9VU17Gy4GzMhfxZdDzIpCdkU1mOsL15CIM0t5RrNSHVMMdVg5KT 2A== 
Received: from g4t3426.houston.hpe.com (g4t3426.houston.hpe.com [15.241.140.75])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3evu2wc1hs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Mar 2022 22:43:14 +0000
Received: from g4t3433.houston.hpecorp.net (g4t3433.houston.hpecorp.net [16.208.49.245])
        by g4t3426.houston.hpe.com (Postfix) with ESMTP id D6B904E;
        Fri, 18 Mar 2022 22:43:13 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (dog.eag.rdlabs.hpecorp.net [128.162.243.181])
        by g4t3433.houston.hpecorp.net (Postfix) with ESMTP id ED66149;
        Fri, 18 Mar 2022 22:43:12 +0000 (UTC)
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
Subject: [PATCH v3 2/3] x86/platform/uv: Update TSC sync state for UV5
Date:   Fri, 18 Mar 2022 17:43:03 -0500
Message-Id: <20220318224304.174967-3-mike.travis@hpe.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220318224304.174967-1-mike.travis@hpe.com>
References: <20220318224304.174967-1-mike.travis@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: HHwULhifDUkZaLVnbF7EARGsKPn2ztiA
X-Proofpoint-GUID: HHwULhifDUkZaLVnbF7EARGsKPn2ztiA
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-18_14,2022-03-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 clxscore=1015 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203180122
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

