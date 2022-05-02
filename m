Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC6451762C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 19:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244202AbiEBR7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 13:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbiEBR7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 13:59:53 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44696DE6
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 10:56:23 -0700 (PDT)
Received: from zn.tnic (p5de8eeb4.dip0.t-ipconnect.de [93.232.238.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C4F441EC01E0;
        Mon,  2 May 2022 19:56:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1651514177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ax9mLqJq26WVCNoAnal0GnnYMD1isqJF7WNSRvnbeB4=;
        b=FI21241rgEUpLXdSDgaERfq9PcBWw5BWbIddewGVzK3VwtM07Q+qJ9UvrUpSWVvm8os9cV
        iz+4+LiSKtwZlMFGCQyBcLMGDh4ZjeYiO+PVT8m7xY6VRHHgL9FykYFFhfqgDW8s+DU4I8
        z2999rdeBmwnnVKquraT5MR5kVKbG/w=
Date:   Mon, 2 May 2022 19:56:16 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH V6 6/8] x86/entry: Convert SWAPGS to swapgs and remove
 the definition of SWAPGS
Message-ID: <YnAbQK9kLdCxxGSf@zn.tnic>
References: <20220421141055.316239-1-jiangshanlai@gmail.com>
 <20220421141055.316239-7-jiangshanlai@gmail.com>
 <Ymu2XC7k8Xj/vMjG@zn.tnic>
 <3db51f9f-317a-352a-4214-0f159b6cd34c@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3db51f9f-317a-352a-4214-0f159b6cd34c@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2022 at 02:18:35PM +0200, Juergen Gross wrote:
> The syscall will land in the hypervisor, which then will activate
> the related registered callback (xen_sysenter_target).

Aha, that would do a bit of a fixup and then go to the common label
entry_SYSENTER_compat_after_hwframe.

We probably should document this so that it is clear what uses those...

---
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 9da5eef9affe..93065c4914ad 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -103,6 +103,11 @@ SYM_INNER_LABEL(entry_SYSCALL_64_safe_stack, SYM_L_GLOBAL)
 	pushq	%r11					/* pt_regs->flags */
 	pushq	$__USER_CS				/* pt_regs->cs */
 	pushq	%rcx					/* pt_regs->ip */
+
+	/*
+	 * XENPV jumps here after frame fixup in the respective entry points in
+	 * ...xen-asm.S.
+	 */
 SYM_INNER_LABEL(entry_SYSCALL_64_after_hwframe, SYM_L_GLOBAL)
 	pushq	%rax					/* pt_regs->orig_ax */
 
diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index c5aeb0819707..b473f8e17afc 100644
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -71,6 +71,11 @@ SYM_CODE_START(entry_SYSENTER_compat)
 	pushfq				/* pt_regs->flags (except IF = 0) */
 	pushq	$__USER32_CS		/* pt_regs->cs */
 	pushq	$0			/* pt_regs->ip = 0 (placeholder) */
+
+	/*
+	 * XENPV jumps here after frame fixup in the respective entry points in
+	 * ...xen-asm.S.
+	 */
 SYM_INNER_LABEL(entry_SYSENTER_compat_after_hwframe, SYM_L_GLOBAL)
 
 	/*

> I wouldn't insist on the CONFIG_DEBUG_ENTRY chunk.

Ok, simpler asm, cool, let's do it then.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
