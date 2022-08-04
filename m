Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9B758A10B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 21:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235265AbiHDTDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 15:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238723AbiHDTDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 15:03:44 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949B26D9DC
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 12:03:42 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id E0B63240002;
        Thu,  4 Aug 2022 19:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1659639819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=4nE99AddbBTDV20nAD4BnDjQ/Hm3DjH+zY3AnfZeX48=;
        b=EuPh2ayLRlPvYsatzErYAhX1TLivjE2MjGf4OsmcRY/WIuccI5op8rZ+T5ZHwyvABBcI8M
        sZOtMyl0vQxbJfLnUDi7uCPppZsV5LaksCrTrIhsL+em5QWfELNqdqdrRG8Pvn8yDb00TK
        ZCq+7jkAh6VQgthDZLfBH46MPr7d/MJfSYkO0Zpdqzl32pVmM/HaqlOjz7H3Kc7e5o1Z44
        8HUI8J26tQgsdMOZdLZCMduG6XQEqwhYiW51O+uKp0EDApzKfA3tANqiABv4FS2UsuTRCK
        lZEjlnFSKp/s7C5iq/DGIZ0pEdvL97r7VbOu4y/Uq1LN29wybnsOZW37eTCM5w==
From:   alexandre.belloni@bootlin.com
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] init/Kconfig: fix CC_HAS_ASM_GOTO_TIED_OUTPUT test with dash
Date:   Thu,  4 Aug 2022 21:03:20 +0200
Message-Id: <20220804190320.262510-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

When using dash as /bin/sh, the CC_HAS_ASM_GOTO_TIED_OUTPUT test fails
with a syntax error which is not the one we are looking for:

<stdin>: In function ‘foo’:
<stdin>:1:29: warning: missing terminating " character
<stdin>:1:29: error: missing terminating " character
<stdin>:2:5: error: expected ‘:’ before ‘+’ token
<stdin>:2:7: warning: missing terminating " character
<stdin>:2:7: error: missing terminating " character
<stdin>:2:5: error: expected declaration or statement at end of input

Move all the CC_HAS_ASM_GOTO tests to scripts/gcc-goto.sh to solve the
escaping issues.

Fixes: 1aa0e8b144b6 ("Kconfig: Add option for asm goto w/ tied outputs to workaround clang-13 bug")
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 init/Kconfig        |  6 +++---
 scripts/gcc-goto.sh | 31 +++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index c984afc489de..9903a11cfe7d 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -71,16 +71,16 @@ config CC_CAN_LINK_STATIC
 	default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG_FLAGS) $(USERCFLAGS) $(USERLDFLAGS) $(m32-flag) -static)
 
 config CC_HAS_ASM_GOTO
-	def_bool $(success,$(srctree)/scripts/gcc-goto.sh $(CC))
+	def_bool $(success,$(srctree)/scripts/gcc-goto.sh goto $(CC))
 
 config CC_HAS_ASM_GOTO_OUTPUT
 	depends on CC_HAS_ASM_GOTO
-	def_bool $(success,echo 'int foo(int x) { asm goto ("": "=r"(x) ::: bar); return x; bar: return 0; }' | $(CC) -x c - -c -o /dev/null)
+	def_bool $(success,$(srctree)/scripts/gcc-goto.sh goto_output $(CC))
 
 config CC_HAS_ASM_GOTO_TIED_OUTPUT
 	depends on CC_HAS_ASM_GOTO_OUTPUT
 	# Detect buggy gcc and clang, fixed in gcc-11 clang-14.
-	def_bool $(success,echo 'int foo(int *x) { asm goto (".long (%l[bar]) - .\n": "+m"(*x) ::: bar); return *x; bar: return 0; }' | $CC -x c - -c -o /dev/null)
+	def_bool $(success,$(srctree)/scripts/gcc-goto.sh goto_tied_output $(CC))
 
 config TOOLS_SUPPORT_RELR
 	def_bool $(success,env "CC=$(CC)" "LD=$(LD)" "NM=$(NM)" "OBJCOPY=$(OBJCOPY)" $(srctree)/scripts/tools-support-relr.sh)
diff --git a/scripts/gcc-goto.sh b/scripts/gcc-goto.sh
index 8b980fb2270a..aa9498b74df8 100755
--- a/scripts/gcc-goto.sh
+++ b/scripts/gcc-goto.sh
@@ -3,6 +3,11 @@
 # Test for gcc 'asm goto' support
 # Copyright (C) 2010, Jason Baron <jbaron@redhat.com>
 
+TEST=$1
+shift
+
+case $TEST in
+    "goto")
 cat << "END" | $@ -x c - -fno-PIE -c -o /dev/null
 int main(void)
 {
@@ -20,3 +25,29 @@ entry:
 	return 0;
 }
 END
+    ;;
+
+    "goto_output")
+cat << "END" | $@ -x c - -c -o /dev/null
+int foo(int x) {
+	asm goto ("": "=r"(x) ::: bar);
+	return x;
+	bar: return 0;
+}
+END
+    ;;
+
+    "goto_tied_output")
+cat << "END" | $@ -x c - -c -o /dev/null
+int foo(int *x) {
+	asm goto (".long (%l[bar]) - .\n": "+m"(*x) ::: bar);
+	return *x;
+	bar: return 0;
+}
+END
+    ;;
+
+    *)
+	exit -1
+    ;;
+esac
-- 
2.37.1

