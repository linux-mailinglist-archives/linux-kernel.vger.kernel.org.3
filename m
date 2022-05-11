Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA134523BB9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 19:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345696AbiEKRjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 13:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233838AbiEKRi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 13:38:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFFFC6EC67
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 10:38:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50C4F61D41
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 17:38:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C233C34113;
        Wed, 11 May 2022 17:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652290735;
        bh=syIKHRhgy3Ko+vIqW2rsVLjtccP6pVBn9FOZ1vI6eqU=;
        h=From:To:Cc:Subject:Date:From;
        b=SbRJTBcw7K2fFL78Gm/QGQKqgk0GXCKKDxrn6+yUnVwkeWvelJ91h1vri7arXbSPf
         DwfLL89F4v1HJwkvmfpHqCRf7CPLLH94K8pY4zlqUKY7pU2SoGgqxaPzRi5+hq920u
         uGZhcA6o4lPG1dOJLWqd+TgqH0NWr2L7YTGv96LO/ax9dlKvHu2apWJD2ltknrFkXN
         hbp1kmSkHFa4ZAEpeujrNoBMOmruZXfuh/JQHvxs+reHAOG7lqbaULEoIQAmTij2oI
         42rjHpSfDGctQg1yLbGxKhux9OFkAjDB40tesSRJE1Ef34E288nXWP1JN6oBHDC3bW
         jxyYbOsjUqTRA==
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Florian Weimer <fweimer@redhat.com>
Subject: [PATCH] x86/vsyscall: Remove CONFIG_LEGACY_VSYSCALL_EMULATE
Date:   Wed, 11 May 2022 10:38:53 -0700
Message-Id: <898932fe61db6a9d61bc2458fa2f6049f1ca9f5c.1652290558.git.luto@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_LEGACY_VSYSCALL_EMULATE is, as far as I know, only needed for the
combined use of exotic and outdated debugging mechanisms with outdated
binaries.  At this point, no one should be using it.  We would like to
implement dynamic switching of vsyscalls, but this is much more
complicated to support in EMULATE mode than XONLY mode.

So let's force all the distros off of EMULATE mode.  If anyone actually
needs it, they can set vsyscall=emulate, and we can then get away with
refusing to support newer security models if that option is set.

Cc: x86@kernel.org
Cc: Kees Cook <keescook@chromium.org>
Cc: Florian Weimer <fweimer@redhat.com>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/Kconfig                      | 18 +++---------------
 arch/x86/entry/vsyscall/vsyscall_64.c |  2 +-
 2 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 4bed3abf444d..68c669680c16 100644
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
index fd2ee9408e91..4af81df133ee 100644
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
-- 
2.35.1

