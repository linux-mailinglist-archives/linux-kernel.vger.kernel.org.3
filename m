Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 960EA4A951D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 09:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356803AbiBDIad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 03:30:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356372AbiBDIa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 03:30:29 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A96C061714
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 00:30:29 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8F0E91EC06BA;
        Fri,  4 Feb 2022 09:30:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1643963427;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+PQlCVtDGGcQX8X7rNH1W7t9Z75hoyQCmKbUBgEu6LQ=;
        b=WHtMVIiiPmZQc0KMC6ktN4oX1vKfCzgwFiBGE7q3e1y6vgnUNtlHMn2EXzbC9O/itg/DOr
        FyhebtHyyDaj23mIHesNw+PuTzYLI3aHTp+7eiwDmzxZl/siHegQsjQbGN/XvPaPKjpnGw
        GkTkfXQ0riDu3SlIwOX+LC2eRrgoVro=
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Marco Elver <elver@google.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] x86/ptrace: Always inline v8086_mode() for instrumentation
Date:   Fri,  4 Feb 2022 09:30:14 +0100
Message-Id: <20220204083015.17317-3-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220204083015.17317-1-bp@alien8.de>
References: <20220204083015.17317-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Instrumentation glue like KASAN causes the following warning:

  vmlinux.o: warning: objtool: mce_gather_info()+0x5f: call to v8086_mode.constprop.0() leaves .noinstr.text section

due to gcc creating a function call for that oneliner. Force-inline it
and even save some vmlinux bytes (.config is close to an allmodconfig):

     text    data     bss     dec     hex filename
  209431677       208257651       34411048        452100376       1af28118	vmlinux.before
  209431519       208257615       34411048        452100182       1af28056	vmlinux.after

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/asm/ptrace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/ptrace.h b/arch/x86/include/asm/ptrace.h
index 703663175a5a..4357e0f2cd5f 100644
--- a/arch/x86/include/asm/ptrace.h
+++ b/arch/x86/include/asm/ptrace.h
@@ -137,7 +137,7 @@ static __always_inline int user_mode(struct pt_regs *regs)
 #endif
 }
 
-static inline int v8086_mode(struct pt_regs *regs)
+static __always_inline int v8086_mode(struct pt_regs *regs)
 {
 #ifdef CONFIG_X86_32
 	return (regs->flags & X86_VM_MASK);
-- 
2.29.2

