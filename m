Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6918567B1E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 02:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbiGFA2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 20:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiGFA2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 20:28:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B1F5BAE;
        Tue,  5 Jul 2022 17:28:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BC2AFB81A4C;
        Wed,  6 Jul 2022 00:28:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0E8CC341C7;
        Wed,  6 Jul 2022 00:28:25 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ihc73PJ/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1657067303;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OhugZvecg+oWrbxbccQQJUXAAF4kA6okY4PhlziPCHY=;
        b=ihc73PJ/0bSh+zgqGgWeUk/Hm5AVBfEF9wPhoIjfU6IXnQq0Evw5IV7MV7pFn+utADjqHU
        tLwFQa5KqWiwPoKWLREPMkkWzzzxJ/PRlWSblvPAqtP7Fx5tJ5pUAASWYy8W5Va7qsfJ9l
        a9mKSh5Snj6sDzvYSnoQdLykd2A6bMg=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 53f900aa (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 6 Jul 2022 00:28:23 +0000 (UTC)
Date:   Wed, 6 Jul 2022 02:28:19 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] random: remove CONFIG_ARCH_RANDOM and "nordrand"
Message-ID: <YsTXI3J+ptkN/vb4@zx2c4.com>
References: <20220705190121.293703-1-Jason@zx2c4.com>
 <YsSStCQQf008hF2F@zn.tnic>
 <YsSUkapje04MP2a1@zx2c4.com>
 <YsSXkNBtB6Ciy9iN@zn.tnic>
 <11C903CC-22A7-48EE-AD63-E71CC8D28B88@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <11C903CC-22A7-48EE-AD63-E71CC8D28B88@zytor.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Borislav, Peter,

On Tue, Jul 05, 2022 at 02:50:34PM -0700, H. Peter Anvin wrote:
> On July 5, 2022 12:57:04 PM PDT, Borislav Petkov <bp@alien8.de> wrote:
> >On Tue, Jul 05, 2022 at 09:44:17PM +0200, Jason A. Donenfeld wrote:
> >> Oh, huh. Maybe in that case I should adjust the message to say "consider
> >> using `random.trust_cpu=0`," which is the thing that would actually make
> >> a security difference.
> >
> >Why isn't that option documented in
> >Documentation/admin-guide/kernel-parameters.txt?

Maybe you're not grepping the right tree?

zx2c4@thinkpad ~/Projects/random-linux $ grep trust_cpu Documentation/admin-guide/kernel-parameters.txt
        random.trust_cpu={on,off}

https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git/tree/Documentation/admin-guide/kernel-parameters.txt#n4506

> >> But actually, one thing that wasn't clear to me was: does `nordrand`
> >> affect what userspace sees? While random.c is okay in lots of
> >> circumstances, I could imagine `nordrand` playing a role in preventing
> >> userspace from using it, which might be desirable. Is this the case? If
> >> so, I can remove the nordrand chunk from this patch for v2. If not, I'll
> >> adjust the text to mention `random.trust_cpu=0`.
> >
> >Unfortunately, it doesn't disable the instruction. It would be lovely if
> >we had a switch like that...
> >
> >That's why this message is supposed to be noisy so that people can pay
> >attention at least.

I was wondering if it somehow removed it from cpuid. But I guess that's
not possible. So okay, no real userspace effect. I think I agree with
you then:

> >> In the sense that random.c can handle mostly any input without making
> >> the quality worse. So, you can't accidentally taint it. The only risk is
> >> if it thinks RDRAND is good and trustable when it isn't, but that's what
> >> `random.trust_cpu=0` is for.
> >
> >And that's why I'm saying that if you detect RDRAND returning the
> >same thing over and over again, you should simply stop using it.
> >Automatically. Not rely on the user to do anything.
> >
> 
> It's just math. The only variable is your confidence level, i.e. at
> what level do you decide that the likelihood of pure chance is way
> smaller than the likelihood of hardware failure. For example, the
> likelihood of m n-bit samples in a row being identical is
> 2^-(n*(m-3/2)), and the likelihood of the CPU being destroyed by a
> meterorite in the same microsecond is about 2^-100.

I think I'm on board with that general plan of adding a little online
selftest that's better than what's there now and using that to get rid
of nordrand. I don't want to instrument every invocation like you
suggested, because this has effects on forward secrecy (e.g. it's nice
to burn previous results from memory). But doing a little test at boot
up better than what we have now seems like a good idea.

So let's do this - I'll send a v2 changing this patch to be a bit more
boring and just get rid of CONFIG_ARCH_RANDOM. That'll be straight
forward. And then Peter - do you want to take a stab at doing the
selftest in order to get rid of nordrand? Or would you prefer I try? It
sounds like you have a specific idea of what you'd like there, so maybe
that's best?

For now, v2 of this patch sans nordrand is incoming shortly.

Jason
