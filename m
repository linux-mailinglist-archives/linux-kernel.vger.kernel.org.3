Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11196481F29
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 19:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241690AbhL3SWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 13:22:00 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43436 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241682AbhL3SV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 13:21:56 -0500
Date:   Thu, 30 Dec 2021 18:21:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1640888515;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0qS7vPYQwEelqx8sSc1aUhwH3v16sfIxJfOIWybu0hI=;
        b=V/uWZgct52WYrnSXx6pIqL7KZcyEsaqjbg8pkhb6+hdxctklK1xidRCERVrLs4zn+6B4Vb
        hs9I7zvLKeqbqvUllFh5Jg8SRd31cI7N1xG+25AxT4ftxnpn1uwcXn1mB1nIX+541oLNQe
        O7E8E+GJkrM407A2p0BHe3w5CxWMt6FfQLd0070F781lvsb2OViRgJX/nPFT9XODRNMG56
        qczdV0v0WcoeZZxOtJ5A/T7H8+e2pddHvM8EjjDerUbkHUyPX7wcNQcHR/DNfJgqFgCRwO
        8dDYPXafQesiqvEOiQMuaeTIYRGttpBQVIz/U8dRXm2SrMgv/6omrEOr8oBTPg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1640888515;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0qS7vPYQwEelqx8sSc1aUhwH3v16sfIxJfOIWybu0hI=;
        b=nLlbS6rrsoKkE2dcWCMY9PocWGaLrmOQIXimExI5lq0ViiCczJRMD9btZEvL4/CABFIBK7
        2+ccFbGX9x+kymCQ==
From:   "tip-bot2 for Masahiro Yamada" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/vdso] x86/vdso: Remove -nostdlib compiler flag
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Nick Desaulniers <ndesaulniers@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211107162641.324688-1-masahiroy@kernel.org>
References: <20211107162641.324688-1-masahiroy@kernel.org>
MIME-Version: 1.0
Message-ID: <164088851429.16921.2918285742604804899.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/vdso branch of tip:

Commit-ID:     a41f5b78ac5ba65986b31ddc6325a0b8cc8b8864
Gitweb:        https://git.kernel.org/tip/a41f5b78ac5ba65986b31ddc6325a0b8cc8b8864
Author:        Masahiro Yamada <masahiroy@kernel.org>
AuthorDate:    Mon, 08 Nov 2021 01:26:40 +09:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 30 Dec 2021 14:08:20 +01:00

x86/vdso: Remove -nostdlib compiler flag

The -nostdlib option requests the compiler to not use the standard
system startup files or libraries when linking. It is effective only
when $(CC) is used as a linker driver.

Since

  379d98ddf413 ("x86: vdso: Use $LD instead of $CC to link")

$(LD) is directly used, hence -nostdlib is unneeded.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Link: https://lore.kernel.org/r/20211107162641.324688-1-masahiroy@kernel.org
---
 arch/x86/entry/vdso/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index a2dddcc..693f8b9 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -172,7 +172,7 @@ $(obj)/vdso32.so.dbg: $(obj)/vdso32/vdso32.lds $(vobjs32) FORCE
 # The DSO images are built using a special linker script.
 #
 quiet_cmd_vdso = VDSO    $@
-      cmd_vdso = $(LD) -nostdlib -o $@ \
+      cmd_vdso = $(LD) -o $@ \
 		       $(VDSO_LDFLAGS) $(VDSO_LDFLAGS_$(filter %.lds,$(^F))) \
 		       -T $(filter %.lds,$^) $(filter %.o,$^) && \
 		 sh $(srctree)/$(src)/checkundef.sh '$(NM)' '$@'
