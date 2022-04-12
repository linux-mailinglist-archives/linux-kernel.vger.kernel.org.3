Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD924FE26C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 15:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356015AbiDLN3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 09:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357703AbiDLN3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 09:29:07 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2095BC0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 06:26:37 -0700 (PDT)
Received: from zn.tnic (p200300ea971b584e329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:584e:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A9B881EC04D6;
        Tue, 12 Apr 2022 15:26:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1649769991;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=kv9jJsZZOOjBPt8MqkxzQ1hiZv0aEzxc0WidMPbYFyg=;
        b=k4s0zrPUVsVhx0XLqef71gl/YkOyGtyFfbmaIQvwCVrgDIvaYSR5VRIeIiiJSFYMURARBE
        ooDr1s93VPb51x5nc8+8ME1LugiulOMRlQ7EHKx2sWWjO+pSf2xLTLj1IP/tLGJVehefM+
        JZiJOlXCwnQr185oUW23SHODNGmGQos=
Date:   Tue, 12 Apr 2022 15:26:31 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH V5 3/7] x86/entry: Move PUSH_AND_CLEAR_REGS out of
 error_entry()
Message-ID: <YlV+B8faRD2lDoO3@zn.tnic>
References: <20220412121541.4595-1-jiangshanlai@gmail.com>
 <20220412121541.4595-4-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220412121541.4595-4-jiangshanlai@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 08:15:37PM +0800, Lai Jiangshan wrote:
> From: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> 
> error_entry() doesn't handle the stack balanced.

What does that mean?

> It includes
> PUSH_AND_CLEAR_REGS which is commonly needed for all IDT entries and
> can't pop the regs before it returns.
> 
> Move PUSH_AND_CLEAR_REGS out of error_entry() and make error_entry()
> works on the stack normally.
> 
> After this, XENPV doesn't need error_entry() since PUSH_AND_CLEAR_REGS
> is moved out and error_entry() can be converted to C code in future
> since it doesn't fiddle the stack.

This is not a justification for this size increase:

   text    data     bss     dec     hex filename
16060616        128131358       36384888        180576862       ac3625e vmlinux.before
16065626        128131358       36380792        180577776       ac365f0 vmlinux.after

~5K text increase already with my tailored config.

You can have a asm_error_entry(), written in asm, which does the regs
pushing and which calls error_entry() - the latter being the C version.
And no need for the size increase.

For example.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
