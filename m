Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 521644CDFA2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 22:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbiCDVOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 16:14:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiCDVOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 16:14:01 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9952213CEC1;
        Fri,  4 Mar 2022 13:13:12 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id BDB1892009C; Fri,  4 Mar 2022 22:13:11 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id B6A0792009B;
        Fri,  4 Mar 2022 21:13:11 +0000 (GMT)
Date:   Fri, 4 Mar 2022 21:13:11 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: Sanitise Cavium switch cases in TLB handler
 synthesizers
Message-ID: <alpine.DEB.2.21.2203042044580.47558@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,HDRS_LCASE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It makes no sense to fall through to `break'.  Therefore reorder the 
switch statements so as to have the Cavium cases first, followed by the 
default case, which improves readability and pacifies code analysis 
tools.  No change in semantics, assembly produced is exactly the same.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
Fixes: bc431d2153cc ("MIPS: Fix fall-through warnings for Clang")
---
 arch/mips/mm/tlbex.c |   23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

linux-mips-tlbex-cavium-odd-switch.diff
Index: linux-macro/arch/mips/mm/tlbex.c
===================================================================
--- linux-macro.orig/arch/mips/mm/tlbex.c
+++ linux-macro/arch/mips/mm/tlbex.c
@@ -2160,16 +2160,14 @@ static void build_r4000_tlb_load_handler
 		uasm_i_tlbr(&p);
 
 		switch (current_cpu_type()) {
-		default:
-			if (cpu_has_mips_r2_exec_hazard) {
-				uasm_i_ehb(&p);
-			fallthrough;
-
 		case CPU_CAVIUM_OCTEON:
 		case CPU_CAVIUM_OCTEON_PLUS:
 		case CPU_CAVIUM_OCTEON2:
-				break;
-			}
+			break;
+		default:
+			if (cpu_has_mips_r2_exec_hazard)
+				uasm_i_ehb(&p);
+			break;
 		}
 
 		/* Examine  entrylo 0 or 1 based on ptr. */
@@ -2236,15 +2234,14 @@ static void build_r4000_tlb_load_handler
 		uasm_i_tlbr(&p);
 
 		switch (current_cpu_type()) {
-		default:
-			if (cpu_has_mips_r2_exec_hazard) {
-				uasm_i_ehb(&p);
-
 		case CPU_CAVIUM_OCTEON:
 		case CPU_CAVIUM_OCTEON_PLUS:
 		case CPU_CAVIUM_OCTEON2:
-				break;
-			}
+			break;
+		default:
+			if (cpu_has_mips_r2_exec_hazard)
+				uasm_i_ehb(&p);
+			break;
 		}
 
 		/* Examine  entrylo 0 or 1 based on ptr. */
