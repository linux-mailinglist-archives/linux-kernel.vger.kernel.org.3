Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 210CB4CEC67
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 18:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233882AbiCFRLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 12:11:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbiCFRLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 12:11:21 -0500
Received: from smtp.smtpout.orange.fr (smtp08.smtpout.orange.fr [80.12.242.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D9666CA0
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 09:10:28 -0800 (PST)
Received: from localhost.localdomain ([106.133.21.169])
        by smtp.orange.fr with ESMTPA
        id QuObnKJQ7uvBOQuOhnsSxM; Sun, 06 Mar 2022 18:10:26 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: MDU0YmViZGZmMDIzYiBlMiM2NTczNTRjNWZkZTMwOGRiOGQ4ODf3NWI1ZTMyMzdiODlhOQ==
X-ME-Date: Sun, 06 Mar 2022 18:10:26 +0100
X-ME-IP: 106.133.21.169
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     linux-kernel@vger.kernel.org,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [RFC PATCH v1] x86/build: add -fno-builtin flag to prevent shadowing
Date:   Mon,  7 Mar 2022 02:10:09 +0900
Message-Id: <20220306171009.1973074-1-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aside of the __builtin_foo() ones, x86 does not directly rely on any
builtin functions.

However, such builtin functions are not explicitly deactivated,
creating some collisions, concrete example being ffs() from bitops.h,
c.f.:

| ./arch/x86/include/asm/bitops.h:283:28: warning: declaration of 'ffs' shadows a built-in function [-Wshadow]
|   283 | static __always_inline int ffs(int x)

This patch adds -fno-builtin to KBUILD_CFLAGS for the x86
architectures in order to prevent shadowing of builtin functions.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
FYI, I tested this patch on a "make allyesconfig" for both x86_32 and
x86_64.

arch/x86/Makefile.um already adds the -fno-builtin but
does not get included in arch/x86/Makefile (the only consumer of
Makefile.um is arch/um/Makefile). I do not understand what is the role
of Makefile.um here.

Because of my lack of confidence on this Makefile.um, and because it
is the first time for me to send a patch for x86/build I am sending
this as an RFC.

Regarless, this patch is my best shot on this issue. I hope I did not
miss anything obvious.
---
 arch/x86/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index e84cdd409b64..5ff7b6571dd2 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -53,6 +53,8 @@ export REALMODE_CFLAGS
 # e.g.: obj-y += foo_$(BITS).o
 export BITS
 
+KBUILD_CFLAGS += -fno-builtin
+
 #
 # Prevent GCC from generating any FP code by mistake.
 #
-- 
2.34.1

