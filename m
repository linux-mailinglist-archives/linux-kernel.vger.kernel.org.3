Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6709513145
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 12:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234785AbiD1KaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 06:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233754AbiD1KaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 06:30:00 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5E629CAE
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 03:26:45 -0700 (PDT)
Received: from zn.tnic (p5de8eeb4.dip0.t-ipconnect.de [93.232.238.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 420781EC0494;
        Thu, 28 Apr 2022 12:26:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1651141600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=hNWNwXX4JHOhR5AkV+ZKCJoeYikWgZzneU0wZPfsPCY=;
        b=f31gUaucukPH/UdZE874YdbRAce7Q4NQVk0jLDDatRjH4Y/YOtnrf2c9/A7FoZ/4wQ2z2M
        TWtRbyqQwZ7DMgYjkl4+zFqrzFjQP5tnfLI77DPJ01E/YXHiiG4cnx57Cxsri6ZRNMTuS7
        s5c6+4v8WZxtBTUnCsaf46bgm2JzySg=
Date:   Thu, 28 Apr 2022 12:26:37 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juergen Gross <jgross@suse.com>, X86 ML <x86@kernel.org>,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH V6 3/8] x86/entry: Move PUSH_AND_CLEAR_REGS out of
 error_entry()
Message-ID: <Ympr3VU5Q182SVT7@zn.tnic>
References: <20220421141055.316239-1-jiangshanlai@gmail.com>
 <20220421141055.316239-4-jiangshanlai@gmail.com>
 <YmmBHABKMk7Ctx46@zn.tnic>
 <CAJhGHyANWhu-HX20_4XhgACE8tUd8SFa5BTH-ynJscNQ7QxBRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJhGHyANWhu-HX20_4XhgACE8tUd8SFa5BTH-ynJscNQ7QxBRw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 08:33:36AM +0800, Lai Jiangshan wrote:
> The branch in sync_regs() can be optimized out for the non-XENPV case
> since XENPV doesn't call sync_regs() after patch5 which makes XENPV
> not call error_entry().

I find it confusing why you're even mentioning optimizing a simple test.

That thing is basically a *whopping* two fastpath instructions:

# arch/x86/kernel/traps.c:853: 	if (regs != eregs)
	cmpq	%rdi, %rax	# eregs, <retval>
	je	.L255	#,

Is this such a hot path that it shows in some profiles and removing that
test there is so important?

> The aim of this patch and most of the patchset is to make
> error_entry() be able to be converted to C.  And XENPV cases can
> also be optimized in the patchset although it is not the major main.

So say just that.

> Since this patch adds extra overhead (CALL and RET), the changelog
> has to explain why it is worth it not just for converting ASM to C.

What is the practical relevance of this very minor overhead? Does it
show even in a microbenchmark?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
