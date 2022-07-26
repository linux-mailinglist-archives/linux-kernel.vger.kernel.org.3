Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64D1F580BFD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 08:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbiGZG5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 02:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbiGZG5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 02:57:45 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A033D2715E
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 23:57:43 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LsSQq2lPSz4x1f;
        Tue, 26 Jul 2022 16:57:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1658818661;
        bh=g/ZRqB0p6ohpHeie0cs0FL1sIIleC/KZ3LH0jCnnNXA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=o+F2eptfMZFXVJJw+G1G2BMAZWxeIymUGkiaKj5XwBob0XFsM1igSY1T+PMnumncD
         2fkZhAbSyQajpxcIhBafQUPy9FoFCDtu5xsg/0dC8WAiLZGHLyjlp3Np4HHw5QW2Ml
         uINL3YlDsxZdT537dHXbJfp8aa64GkdO8x5ej0U88sNtfTsjrwrHKmHm4hnMKdncOj
         cqnoCgO8SeDpioGiIvOC+NWwYteGQgW0lGxDm6rD2+eZ80Hvkz09xYyDcvAXYCYi9z
         t06g0vLq3Jk8QPhpTy5kIsa6+80B0parsxOw+U2AkvzLCkiy+GuwSlmdlOPpb+w6Lm
         7vtz0SMGAyDyg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT" 
        <linuxppc-dev@lists.ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH 1/2] powerpc: drop dependency on <asm/machdep.h> in
 archrandom.h
In-Reply-To: <Yt7CJj8r3eo05pKd@yury-laptop>
References: <20220723214537.2054208-1-yury.norov@gmail.com>
 <20220723214537.2054208-2-yury.norov@gmail.com>
 <CAHp75VfOmN=cTEs7gbwxZ7W3hXjBo67N4AmHHiDfcVfFzHkMLA@mail.gmail.com>
 <Yt7CJj8r3eo05pKd@yury-laptop>
Date:   Tue, 26 Jul 2022 16:57:38 +1000
Message-ID: <87edy8bbtp.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yury Norov <yury.norov@gmail.com> writes:
> On Mon, Jul 25, 2022 at 09:28:12AM +0200, Andy Shevchenko wrote:
>> On Sun, Jul 24, 2022 at 12:19 AM Yury Norov <yury.norov@gmail.com> wrote:
>> >
>> > archrandom.h includes <asm/machdep.h> to refer ppc_md. This causes
>> > circular header dependency, if generic nodemask.h  includes random.h:
>> >
>> > In file included from include/linux/cred.h:16,
>> >                  from include/linux/seq_file.h:13,
>> >                  from arch/powerpc/include/asm/machdep.h:6,
>> >                  from arch/powerpc/include/asm/archrandom.h:5,
>> >                  from include/linux/random.h:109,
>> >                  from include/linux/nodemask.h:97,
>> >                  from include/linux/list_lru.h:12,
>> >                  from include/linux/fs.h:13,
>> >                  from include/linux/compat.h:17,
>> >                  from arch/powerpc/kernel/asm-offsets.c:12:
>> > include/linux/sched.h:1203:9: error: unknown type name 'nodemask_t'
>> >  1203 |         nodemask_t                      mems_allowed;
>> >       |         ^~~~~~~~~~
>> >
>> > Fix it by removing <asm/machdep.h> dependency from archrandom.h
>> 
>> ...
>> 
>> >  EXPORT_SYMBOL_GPL(pm_power_off);
>> 
>> ^^^ (Note this and read below)
>> 
>> ...
>> 
>> > +EXPORT_SYMBOL(arch_get_random_seed_long);
>> 
>> It can't be like this. Brief browsing of the callees shows that.
>
> Is my understanding correct that you're suggesting to make it GPL?
>
> ppc_md is exported with EXPORT_SYMBOL(), and the function is in header,
> so it's available for non-GPL code now. I don't want to change it.

That's true, your change maintains the status quo.

But I think we actually don't need it exported to modules, I think it's
a private detail of the RNG <-> architecture interface, not something
that modules should be calling.

So I think it's OK to drop the EXPORT_SYMBOL, either in this patch or a
subsequent one if you don't want to rebase.

cheers
