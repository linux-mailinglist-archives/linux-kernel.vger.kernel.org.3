Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B56884F1BD4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 23:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381812AbiDDVYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379938AbiDDSYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 14:24:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4FE222B20;
        Mon,  4 Apr 2022 11:22:22 -0700 (PDT)
Date:   Mon, 04 Apr 2022 18:22:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649096541;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7T7M9w/3/K8SrwEK+r7mwxcGiwdDvdtwtN5lFOD/4Kc=;
        b=jTOdvDqTvofidZ3q2ZPWuFRlsB6NFhDzKnZdcbNM3957zWRByBxJsZRGB49zeWlt58uH53
        17tsrH7a7UmVee4SisWm22fu0TyDdIJxip15q5GVrJBXyzWnImG0pfR+G0LagaCSKHGp/3
        5mGRMBt4Mseuh9CUd7PWK38X8q5HHTOrDVslsYnJatJAzhJHt0aiLg/80WqaHAJOMc7YIv
        SxM8d5zlu9ppxup4tyEOMFJOuDxH7guGSirpES4FAYMxGn60MbgJWH7ViRr4y37Q60M4W7
        a29NHeV10Euw9SXkbJn6WZX1i0tSkWaceaVXurQR4abTPA8Sug7QehgRQLXctw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649096541;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7T7M9w/3/K8SrwEK+r7mwxcGiwdDvdtwtN5lFOD/4Kc=;
        b=pnZW6t/0r9AwS8xEfGBq2p1lYfgi0izg4FoxCdI4yyxBcMevVR0z1TV8vb0XCpbO9RfTrg
        c56ScR2+q3e7NkDQ==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Remove "nosep"
Cc:     Borislav Petkov <bp@suse.de>, Kees Cook <keescook@chromium.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220127115626.14179-3-bp@alien8.de>
References: <20220127115626.14179-3-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <164909654054.389.299918398253472131.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     c949110ef4e31cb5d3387bd8273fd5de66b5227b
Gitweb:        https://git.kernel.org/tip/c949110ef4e31cb5d3387bd8273fd5de66b5227b
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Thu, 27 Jan 2022 12:56:22 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 04 Apr 2022 10:16:55 +02:00

x86/cpu: Remove "nosep"

That chicken bit was added by

  4f88651125e2 ("[PATCH] i386: allow disabling X86_FEATURE_SEP at boot")

but measuring int80 vsyscall performance on 32-bit doesn't matter
anymore.

If still needed, one can boot with

  clearcpuid=sep

to disable that feature for testing.

Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20220127115626.14179-3-bp@alien8.de
---
 Documentation/admin-guide/kernel-parameters.txt | 2 --
 arch/x86/kernel/cpu/common.c                    | 7 -------
 2 files changed, 9 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 0ea1786..a9f3d31 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3665,8 +3665,6 @@
 
 	nosbagart	[IA-64]
 
-	nosep		[BUGS=X86-32] Disables x86 SYSENTER/SYSEXIT support.
-
 	nosgx		[X86-64,SGX] Disables Intel SGX kernel support.
 
 	nosmp		[SMP] Tells an SMP kernel to act as a UP kernel,
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 69c7ea8..c71d107 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -298,13 +298,6 @@ static int __init cachesize_setup(char *str)
 }
 __setup("cachesize=", cachesize_setup);
 
-static int __init x86_sep_setup(char *s)
-{
-	setup_clear_cpu_cap(X86_FEATURE_SEP);
-	return 1;
-}
-__setup("nosep", x86_sep_setup);
-
 /* Standard macro to see if a specific flag is changeable */
 static inline int flag_is_changeable_p(u32 flag)
 {
