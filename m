Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8C2514928
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 14:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359057AbiD2MZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 08:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359021AbiD2MZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 08:25:45 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4958C1C81
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 05:22:24 -0700 (PDT)
Received: from zn.tnic (p5de8eeb4.dip0.t-ipconnect.de [93.232.238.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2CF621EC050F;
        Fri, 29 Apr 2022 14:22:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1651234938;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mCSj1Rr6jg+y4hMXAvJQ1cyCjuzpCYT+ry/pDOr9Z8k=;
        b=TPDb8rNyp6036ZXMsFvjBRNPEo64RwL1NIuTcXgd1Xs+Yxp/zUUWmt2c+baEMP4RzCaDjF
        xni65Nr3rfZXCXFI6wQVP066stdnM71Na7jOgisHb0WDXHyTiGte95H0jmmwM/nI9ymTx9
        jnwLv3Av7acu9s7+YGi5kYvB4VnZP4Q=
Date:   Fri, 29 Apr 2022 14:22:15 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     =?utf-8?Q?J=C3=BCrgen?= Gross <jgross@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH V6 6/8] x86/entry: Convert SWAPGS to swapgs and remove
 the definition of SWAPGS
Message-ID: <YmvYdy+Vdw5untIA@zn.tnic>
References: <20220421141055.316239-1-jiangshanlai@gmail.com>
 <20220421141055.316239-7-jiangshanlai@gmail.com>
 <Ymu2XC7k8Xj/vMjG@zn.tnic>
 <CAJhGHyBHPDD=hD-78rQDCj2VfQT21m8JzD-m9DazsUa8VpBVcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJhGHyBHPDD=hD-78rQDCj2VfQT21m8JzD-m9DazsUa8VpBVcQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 07:45:43PM +0800, Lai Jiangshan wrote:
> Adding ALTERNATIVE in swapgs_restore_regs_and_return_to_usermode()

All I'm saying is to do this:

diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index c5aeb0819707..79f0511a4791 100644
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -140,7 +140,7 @@ SYM_INNER_LABEL(entry_SYSENTER_compat_after_hwframe, SYM_L_GLOBAL)
 	call	do_SYSENTER_32
 	/* XEN PV guests always use IRET path */
 	ALTERNATIVE "testl %eax, %eax; jz swapgs_restore_regs_and_return_to_usermode", \
-		    "jmp swapgs_restore_regs_and_return_to_usermode", X86_FEATURE_XENPV
+		    "jmp xenpv_restore_regs_and_return_to_usermode", X86_FEATURE_XENPV
 	jmp	sysret32_from_system_call
 
 .Lsysenter_fix_flags:

which eliminates one JMP in the XENPV case if the CONFIG_DEBUG_ENTRY
thing is not relevant to XENPV.

But let's see what Jürgen says first...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
