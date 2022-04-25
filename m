Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1D8C50E212
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 15:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242114AbiDYNoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 09:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240386AbiDYNoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 09:44:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E834349276;
        Mon, 25 Apr 2022 06:41:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9D345B817FE;
        Mon, 25 Apr 2022 13:41:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99CFBC385A4;
        Mon, 25 Apr 2022 13:41:05 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="HCy+TgIw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1650894064;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uUwRxX7Od1S9mr2fS/Pfy6EUiVME26A+4yI8z6Tcx64=;
        b=HCy+TgIwoaP/ZwSk50MW69l80eLdoGsRXfg6mcPbSqM2EBcW0J8IIz5hzKDAC0pYZIfCoO
        WYwESwWjWWG0sHnI0naiYR3+ZqQn/SYABXLVvx/XUbQrM/HbXPLj9kvIMyQvM4Ibt366gR
        QsKlKrAA6E5XfiPjg9TjhK5mPXQ/f7A=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 9eb25e26 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 25 Apr 2022 13:41:03 +0000 (UTC)
Date:   Mon, 25 Apr 2022 15:41:00 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        arnd@arndb.de, Borislav Petkov <bp@alien8.de>, x86@kernel.org
Subject: Re: [PATCH v6 13/17] x86: use fallback for random_get_entropy()
 instead of zero
Message-ID: <Ymak7LJd6GnFxsOo@zx2c4.com>
References: <20220423212623.1957011-1-Jason@zx2c4.com>
 <20220423212623.1957011-14-Jason@zx2c4.com>
 <871qxl2vdw.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <871qxl2vdw.ffs@tglx>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Mon, Apr 25, 2022 at 02:35:39PM +0200, Thomas Gleixner wrote:
> On Sat, Apr 23 2022 at 23:26, Jason A. Donenfeld wrote:
> 
> Please follow the guidelines of the tip maintainers when touching x86
> code. https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#patch-subject
> https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#changelog

Will fix up the message and topic.

> > In the event that random_get_entropy() can't access a cycle counter or
> > similar, falling back to returning 0 is really not the best we can do.
> > Instead, at least calling random_get_entropy_fallback() would be
> > preferable, because that always needs to return _something_, even
> > falling back to jiffies eventually. It's not as though
> > random_get_entropy_fallback() is super high precision or guaranteed to
> > be entropic, but basically anything that's not zero all the time is
> > better than returning zero all the time.
> >
> > If CONFIG_X86_TSC=n, then it's possible that we're running on a 486
> > with no RDTSC, so we only need the fallback code for that case.
> 
> There are also 586 CPUs which lack TSC.

Will note this in the rewritten commit message.

> > +static inline unsigned long random_get_entropy(void)
> > +{
> > +#ifndef CONFIG_X86_TSC
> > +	if (!cpu_feature_enabled(X86_FEATURE_TSC))
> > +		return random_get_entropy_fallback();
> > +#endif
> 
> Please get rid of this ifdeffery. While you are right, that anything
> with CONFIG_X86_TSC=y should have a TSC, there is virt ....
> 
> cpu_feature_enabled() is runtime patched and only evaluated before
> alternative patching, so the win of this ifdef is marginally, if even
> noticable.
> 
> We surely can think about making TSC mandatory, but not selectively in a
> particalur context.

This would be a regression of sorts from the current code, which reads:

    static inline cycles_t get_cycles(void)
    {
    #ifndef CONFIG_X86_TSC
            if (!boot_cpu_has(X86_FEATURE_TSC))
                    return 0;
    #endif
            return rdtsc();
    }

So my ifdef is just copying that one. I can make it into a `if
(IS_ENABLED(CONFIG_X86_TSC))` thing, if you'd prefer that. But on
systems where CONFIG_X86_TSC=n, including the extra code there seems
kind of undesirable. Consider the current interrupt handler random.c
code on x86, whose first lines (usually) compile to:

.text:0000000000001A70 add_interrupt_randomness proc near
.text:0000000000001A70                 movsxd  rcx, edi
.text:0000000000001A73                 rdtsc
.text:0000000000001A75                 shl     rdx, 20h
.text:0000000000001A79                 mov     rdi, [rsp+0]
.text:0000000000001A7D                 or      rax, rdx
.text:0000000000001A80                 mov     rdx, offset irq_randomness
.text:0000000000001A87                 mov     rsi, gs:__irq_regs
.text:0000000000001A8F                 add     rdx, gs:this_cpu_off

I'm not sure what advantage we'd get by changing that from the ifdefs to
unconditionally including that if statement. Your argument about virt
can't be valid, since the current get_cycles() code uses the ifdefs. And
if you're arguing from the basis that CONFIG_X86_TSC=y is not reliable,
then why does CONFIG_X86_TSC even exist in the first place?

Rather the stronger argument you could make would be that moving from
boot_cpu_has() to cpu_feature_enabled() (Borislav's suggestion) means
that there's now a static branch here, so the actual cost to the
assembly is a few meaningless nops, which you don't think would play a
part in quantizing when rdtsc is called. If this is actually what you
have in mind, and you find that ifdef ugly enough that this would be
worth it, I can understand, and I'll make that change for v7. But I
don't understand you to currently be making that argument, so I'm not
quite sure what your position is.

Could you clarify what you mean here and what your expectations are? And
how does that point of view tie into the fact that get_cycles()
currently uses the ifdef?

Thanks,
Jason
