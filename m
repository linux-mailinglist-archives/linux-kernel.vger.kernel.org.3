Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5E0481F2A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 19:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241696AbhL3SWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 13:22:01 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43424 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233228AbhL3SV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 13:21:56 -0500
Date:   Thu, 30 Dec 2021 18:21:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1640888514;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+HMwP1PVPtYXHPLBy/V6ZdLxIg4rEIUc2wdg1ht/A3E=;
        b=tR15BMa3V0bbY9T3oF/ySUI3rM3EHDzSWw2hS6ENT1922HgwaNuCqOGHEKPwRK+dflh9Kp
        eji1sqqxp9d53eJp1oe3YleQ/Z+sg6KPhzgO5QtH/yC7e/hQDm9Jv/dkNoDtdNq4DCjF1m
        Rdv1n0bz7BGhzjvM4oQyvXJ+mw0PkLgf4pJLEGpeEEaRJXxQdnh5Z3x51gUt2et5rKE4z/
        Jdi4YXxIOtUQ5yA+ojGbn+sVwTx1yGyRlpupyMDVi1Xc3bMlRILM8M3ZgmAks9X3Q3JKH3
        bCMSCm9mGi1NPQIoeZoBDVVDtAJGISvO49ys0oxgj8ddh428rvMv+AtEoIDmwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1640888514;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+HMwP1PVPtYXHPLBy/V6ZdLxIg4rEIUc2wdg1ht/A3E=;
        b=G6NMBGaVPBXCg2sai9ZMa+shn2Tr4ELdWmT2QpNm1Db93nJcxSR6suy0tqS/sfXquJzj0I
        Mb/RJhT5lTmGEtDw==
From:   "tip-bot2 for Masahiro Yamada" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/vdso] x86/purgatory: Remove -nostdlib compiler flag
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Nick Desaulniers <ndesaulniers@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211107162641.324688-2-masahiroy@kernel.org>
References: <20211107162641.324688-2-masahiroy@kernel.org>
MIME-Version: 1.0
Message-ID: <164088851339.16921.17427310116959875857.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/vdso branch of tip:

Commit-ID:     9102fa34604159642625f42d7f801f1e04d9ca12
Gitweb:        https://git.kernel.org/tip/9102fa34604159642625f42d7f801f1e04d9ca12
Author:        Masahiro Yamada <masahiroy@kernel.org>
AuthorDate:    Mon, 08 Nov 2021 01:26:41 +09:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 30 Dec 2021 14:13:06 +01:00

x86/purgatory: Remove -nostdlib compiler flag

The -nostdlib option requests the compiler to not use the standard
system startup files or libraries when linking. It is effective only
when $(CC) is used as a linker driver.

$(LD) is directly used for linking purgatory.{ro,chk} here, hence
-nostdlib is unneeded.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Link: https://lore.kernel.org/r/20211107162641.324688-2-masahiroy@kernel.org
---
 arch/x86/purgatory/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index 95ea17a..ae53d54 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -16,7 +16,7 @@ CFLAGS_sha256.o := -D__DISABLE_EXPORTS
 
 # When linking purgatory.ro with -r unresolved symbols are not checked,
 # also link a purgatory.chk binary without -r to check for unresolved symbols.
-PURGATORY_LDFLAGS := -e purgatory_start -nostdlib -z nodefaultlib
+PURGATORY_LDFLAGS := -e purgatory_start -z nodefaultlib
 LDFLAGS_purgatory.ro := -r $(PURGATORY_LDFLAGS)
 LDFLAGS_purgatory.chk := $(PURGATORY_LDFLAGS)
 targets += purgatory.ro purgatory.chk
