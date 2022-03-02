Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 708774C9CAC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 05:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239528AbiCBEqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 23:46:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239542AbiCBEpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 23:45:47 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C32B12E8
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 20:45:04 -0800 (PST)
Received: (Authenticated sender: ash@heyquark.com)
        by mail.gandi.net (Postfix) with ESMTPSA id E77C8100006;
        Wed,  2 Mar 2022 04:44:58 +0000 (UTC)
From:   Ash Logan <ash@heyquark.com>
To:     paulus@samba.org, mpe@ellerman.id.au, christophe.leroy@csgroup.eu,
        robh+dt@kernel.org, benh@kernel.crashing.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        j.ne@posteo.net, Roberto Van Eeden <rw-r-r-0644@protonmail.com>
Subject: [PATCH 09/12] powerpc: espresso processor support
Date:   Wed,  2 Mar 2022 15:44:03 +1100
Message-Id: <20220302044406.63401-10-ash@heyquark.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220302044406.63401-1-ash@heyquark.com>
References: <20220302044406.63401-1-ash@heyquark.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roberto Van Eeden <rw-r-r-0644@protonmail.com>

Adds a cputable entry for the "Espresso" processor found on the Nintendo
Wii U, which has a PVR unrelated to other 750CL-like chips.
Only this revision has been seen in the wild.

Signed-off-by: Roberto Van Eeden <rw-r-r-0644@protonmail.com>
Signed-off-by: Ash Logan <ash@heyquark.com>
---
 arch/powerpc/kernel/cputable.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index ae0fdef0ac11..b575f5570485 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -718,6 +718,22 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.platform		= "ppc750",
 		.oprofile_cpu_type      = "ppc/750",
 	},
+	{	/* "Espresso" (750CL-like) */
+		.pvr_mask		= 0xffffffff,
+		.pvr_value		= 0x70010201,
+		.cpu_name		= "Espresso",
+		.cpu_features		= CPU_FTRS_750CL,
+		.cpu_user_features	= COMMON_USER | PPC_FEATURE_PPC_LE,
+		.mmu_features		= MMU_FTR_HPTE_TABLE | MMU_FTR_USE_HIGH_BATS,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.num_pmcs		= 4,
+		.pmc_type		= PPC_PMC_IBM,
+		.cpu_setup		= __setup_cpu_750,
+		.machine_check		= machine_check_generic,
+		.platform		= "ppc750",
+		.oprofile_cpu_type      = "ppc/750",
+	},
 	{	/* 745/755 */
 		.pvr_mask		= 0xfffff000,
 		.pvr_value		= 0x00083000,
-- 
2.35.1

