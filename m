Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3B15735DE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 13:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236304AbiGML4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 07:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235579AbiGML43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 07:56:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D26281034E0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 04:56:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E4C561A9C
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 11:56:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 437D0C3411E;
        Wed, 13 Jul 2022 11:56:27 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="V+bKEh/L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1657713385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qNm3JfWKP+6xtgW/xzieYA4/viVk90JmvN6aLuqi7ww=;
        b=V+bKEh/LQicSlyPkim/HDHh0M+bQG4kFS5lgzT4sfJdCBkdOwvwX2dO86tAvSuqbSMqgJV
        JSZnyYyyo5pyaSiNlOPifa4qumG8C2J/tZM7MSobkXIh5TuTYEqldrPVbP0vikDixrZSWq
        oygQvtQ3lfvQWm+yrx7qnR7TkxnZcwg=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c1976010 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 13 Jul 2022 11:56:24 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     johannes@sipsolutions.net, linux-um@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH] um: add "noreboot" command line option for PANIC_TIMEOUT=-1 setups
Date:   Wed, 13 Jul 2022 13:56:17 +0200
Message-Id: <20220713115617.493376-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QEMU has a -no-reboot option, which halts instead of reboots when the
guest asks to reboot. This is invaluable when used with
CONFIG_PANIC_TIMEOUT=-1 (and panic_on_warn), because it allows panics
and warnings to be caught immediately in CI. Implement this in UML too,
by way of a basic setup param.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 arch/um/os-Linux/skas/process.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index 87d3129e7362..0df2ebcc97c0 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -5,6 +5,7 @@
  */
 
 #include <stdlib.h>
+#include <stdbool.h>
 #include <unistd.h>
 #include <sched.h>
 #include <errno.h>
@@ -707,10 +708,24 @@ void halt_skas(void)
 	UML_LONGJMP(&initial_jmpbuf, INIT_JMP_HALT);
 }
 
+static bool noreboot;
+
+static int __init noreboot_cmd_param(char *str, int *add)
+{
+	noreboot = true;
+	return 0;
+}
+
+__uml_setup("noreboot", noreboot_cmd_param,
+"noreboot\n"
+"    Rather than rebooting, exit always, akin to QEMU's -no-reboot option.\n"
+"    This is useful if you're using CONFIG_PANIC_TIMEOUT in order to catch\n"
+"    crashes in CI\n");
+
 void reboot_skas(void)
 {
 	block_signals_trace();
-	UML_LONGJMP(&initial_jmpbuf, INIT_JMP_REBOOT);
+	UML_LONGJMP(&initial_jmpbuf, noreboot ? INIT_JMP_HALT : INIT_JMP_REBOOT);
 }
 
 void __switch_mm(struct mm_id *mm_idp)
-- 
2.35.1

