Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22AF44B3D42
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 21:08:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235713AbiBMUB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 15:01:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbiBMUB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 15:01:28 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4F70143EF1;
        Sun, 13 Feb 2022 12:01:22 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 808AA92009C; Sun, 13 Feb 2022 21:01:21 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 7ADD592009B;
        Sun, 13 Feb 2022 20:01:21 +0000 (GMT)
Date:   Sun, 13 Feb 2022 20:01:21 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>
cc:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Alpha: Remove redundant local asm header redirections
Message-ID: <alpine.DEB.2.21.2202131944000.34636@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,HDRS_LCASE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove a number of asm headers locally redirected to the respective 
generic or generated versions.

For asm-offsets.h all that is needed is a Kbuild entry for the generic 
version, and for div64.h, irq_regs.h and kdebug.h nothing is needed as 
in their absence they will be redirected automatically according to 
include/asm-generic/Kbuild.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
---
Hi,

 Noticed while fiddling with Kbuild for PARPORT_PC.  Please apply.

  Maciej
---
 arch/alpha/include/asm/Kbuild        |    1 +
 arch/alpha/include/asm/asm-offsets.h |    1 -
 arch/alpha/include/asm/div64.h       |    1 -
 arch/alpha/include/asm/irq_regs.h    |    1 -
 arch/alpha/include/asm/kdebug.h      |    1 -
 5 files changed, 1 insertion(+), 4 deletions(-)

linux-alpha-include-gen.diff
Index: linux-macro/arch/alpha/include/asm/Kbuild
===================================================================
--- linux-macro.orig/arch/alpha/include/asm/Kbuild
+++ linux-macro/arch/alpha/include/asm/Kbuild
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 generated-y += syscall_table.h
+generic-y += asm-offsets.h
 generic-y += export.h
 generic-y += kvm_para.h
 generic-y += mcs_spinlock.h
Index: linux-macro/arch/alpha/include/asm/asm-offsets.h
===================================================================
--- linux-macro.orig/arch/alpha/include/asm/asm-offsets.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <generated/asm-offsets.h>
Index: linux-macro/arch/alpha/include/asm/div64.h
===================================================================
--- linux-macro.orig/arch/alpha/include/asm/div64.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/div64.h>
Index: linux-macro/arch/alpha/include/asm/irq_regs.h
===================================================================
--- linux-macro.orig/arch/alpha/include/asm/irq_regs.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/irq_regs.h>
Index: linux-macro/arch/alpha/include/asm/kdebug.h
===================================================================
--- linux-macro.orig/arch/alpha/include/asm/kdebug.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/kdebug.h>
