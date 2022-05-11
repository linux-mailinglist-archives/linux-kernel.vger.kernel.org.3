Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5C8F523DEC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 21:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345915AbiEKTsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 15:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347374AbiEKTsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 15:48:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65997F61C1;
        Wed, 11 May 2022 12:47:50 -0700 (PDT)
Date:   Wed, 11 May 2022 19:47:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652298468;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1FrofJeH8+YlqGe3v/PhOdED1A/YchY+wAkMIrlJCJ4=;
        b=hk/2qcXifHKCqHGexFklQ1FwBKHZXXqUbyaLZp84SXfsSmf13za2IFx0yMX//ASFz9e0n+
        Q4rxmiB/nFZHtBOWK4/XMOhPuFjW2IeQyhGcdsuJaJrWsS8ktxDAD3gpV5V/ShhM25C15W
        lM6CeqnJqsCplJD5OkgPW6s5LRdzboZc/fEJ9ZmKPuaXFqu4DtrBZ/O+irDgJ5qm+T7PA5
        60ujGeNSHbXqb5G0Klp3drt3+0rvGAdAwch72WwK8ELQnEv1jGeq5CKbxNsY3F/sjiuK3M
        cp6CkL/70H+LxZGnb/vaTSzB1bCnh7oGkp0GFzdufQU4cbjHpMcbV+EYq3J1lA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652298468;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1FrofJeH8+YlqGe3v/PhOdED1A/YchY+wAkMIrlJCJ4=;
        b=E65oVB2yTCkkzgnqAy/OX3yqKsde+HubQCIwaJ2lFWfiJ6FEoflsNU5YOWBPDcunOevLcv
        NmBoGzmYTWVdNOAA==
From:   "tip-bot2 for Andy Lutomirski" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/vdso] x86/vsyscall: Remove CONFIG_LEGACY_VSYSCALL_EMULATE
Cc:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@suse.de>,
        Kees Cook <keescook@chromium.org>,
        Florian Weimer <fweimer@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <898932fe61db6a9d61bc2458fa2f6049f1ca9f5c.1652290558.git.luto@kernel.org>
References: <898932fe61db6a9d61bc2458fa2f6049f1ca9f5c.1652290558.git.luto@kernel.org>
MIME-Version: 1.0
Message-ID: <165229846773.4207.18182599891283244875.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/vdso branch of tip:

Commit-ID:     bf00745e7791fe2ba7941aeead8528075a158bbe
Gitweb:        https://git.kernel.org/tip/bf00745e7791fe2ba7941aeead8528075a158bbe
Author:        Andy Lutomirski <luto@kernel.org>
AuthorDate:    Wed, 11 May 2022 10:38:53 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 11 May 2022 20:39:31 +02:00

x86/vsyscall: Remove CONFIG_LEGACY_VSYSCALL_EMULATE

CONFIG_LEGACY_VSYSCALL_EMULATE is, as far as I know, only needed for the
combined use of exotic and outdated debugging mechanisms with outdated
binaries. At this point, no one should be using it. Eventually, dynamic
switching of vsyscalls will be implemented, but this is much more
complicated to support in EMULATE mode than XONLY mode.

So let's force all the distros off of EMULATE mode. If anyone actually
needs it, they can set vsyscall=emulate, and the kernel can then get
away with refusing to support newer security models if that option is
set.

  [ bp: Remove "we"s. ]

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Florian Weimer <fweimer@redhat.com>
Link: https://lore.kernel.org/r/898932fe61db6a9d61bc2458fa2f6049f1ca9f5c.1652290558.git.luto@kernel.org
---
 arch/x86/Kconfig                      | 18 +++---------------
 arch/x86/entry/vsyscall/vsyscall_64.c |  2 +-
 2 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 4bed3ab..68c6696 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2326,7 +2326,9 @@ choice
 	  it can be used to assist security vulnerability exploitation.
 
 	  This setting can be changed at boot time via the kernel command
-	  line parameter vsyscall=[emulate|xonly|none].
+	  line parameter vsyscall=[emulate|xonly|none].  Emulate mode
+	  is deprecated and can only be enabled using the kernel command
+	  line.
 
 	  On a system with recent enough glibc (2.14 or newer) and no
 	  static binaries, you can say None without a performance penalty
@@ -2334,20 +2336,6 @@ choice
 
 	  If unsure, select "Emulate execution only".
 
-	config LEGACY_VSYSCALL_EMULATE
-		bool "Full emulation"
-		help
-		  The kernel traps and emulates calls into the fixed vsyscall
-		  address mapping. This makes the mapping non-executable, but
-		  it still contains readable known contents, which could be
-		  used in certain rare security vulnerability exploits. This
-		  configuration is recommended when using legacy userspace
-		  that still uses vsyscalls along with legacy binary
-		  instrumentation tools that require code to be readable.
-
-		  An example of this type of legacy userspace is running
-		  Pin on an old binary that still uses vsyscalls.
-
 	config LEGACY_VSYSCALL_XONLY
 		bool "Emulate execution only"
 		help
diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
index fd2ee94..4af81df 100644
--- a/arch/x86/entry/vsyscall/vsyscall_64.c
+++ b/arch/x86/entry/vsyscall/vsyscall_64.c
@@ -48,7 +48,7 @@ static enum { EMULATE, XONLY, NONE } vsyscall_mode __ro_after_init =
 #elif defined(CONFIG_LEGACY_VSYSCALL_XONLY)
 	XONLY;
 #else
-	EMULATE;
+	#error VSYSCALL config is broken
 #endif
 
 static int __init vsyscall_setup(char *str)
