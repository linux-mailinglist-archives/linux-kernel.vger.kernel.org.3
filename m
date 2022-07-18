Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1E35779D0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 05:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbiGRDws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 23:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiGRDwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 23:52:45 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 049D613CE1;
        Sun, 17 Jul 2022 20:52:44 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LmSj62Gn2z4xdJ;
        Mon, 18 Jul 2022 13:52:42 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1658116362;
        bh=PAhbVquV8KMmPT0KbTUCb3rhFdvrE7pS8SUJl2k86NQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=abNf9MX4GToZ6jiZBngBosnaGO7J6cYxeNUtHJjScudZr25fDWl24rBpyIX65VBb8
         UsLGOhmSjfXpcn6B8TuwACWUDoTD+0uOnbXkAK7zW5vL8jMsCQQIrHpH/DKoofWkAJ
         Wa5uTJqVo6voEQzV+NIjrLGnWPWntFlxcdKDzmte+G7ez220tFzclj2p7XzHQU518/
         L9h0KiQLxI94FEBrFBpFVy84BHz1Vj69336+PshS8riZ1OA5d4TwpO+ntrmWF8ftlH
         cUYoLH9Y0AL0ldtOSxCReqfi8u0gC0ITOvkL31Y17LJ/2IBL5EJsQGVCSw2mrBdMC0
         naA3RyWOj+3dQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Segher Boessenkool <segher@kernel.crashing.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Paul Mackerras <paulus@samba.org>,
        linux-hardening@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: mainline build failure of powerpc allmodconfig for prom_init_check
In-Reply-To: <20220717195448.GB25951@gate.crashing.org>
References: <Ys/aDKZNhhsENH9S@debian>
 <CADVatmO9XzFnX+N0TuOtr0FYyxKr1oe5RAhCEJjmnvjteT5QNw@mail.gmail.com>
 <CAHk-=whc3Uvhrmrr27xp5=oOhSDjXc5s1ZxC3B7xMYV6oj4WRQ@mail.gmail.com>
 <20220717195448.GB25951@gate.crashing.org>
Date:   Mon, 18 Jul 2022 13:52:38 +1000
Message-ID: <87k08bdqm1.fsf@mpe.ellerman.id.au>
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

Segher Boessenkool <segher@kernel.crashing.org> writes:
> On Sun, Jul 17, 2022 at 07:44:22AM -0700, Linus Torvalds wrote:
>> On Sun, Jul 17, 2022 at 2:13 AM Sudip Mukherjee
>> <sudipm.mukherjee@gmail.com> wrote:
>> > I was trying to check it. With gcc-11 the assembly code generated is
>> > not using memset, but using __memset.
>> > But with gcc-12, I can see the assembly code is using memset. One
>> > example from the assembly:
>> 
>> You could try making the 'args' array in 'struct prom_args' be marked
>> 'volatile'.
>> 
>> Ie something like this:
>> 
>>   --- a/arch/powerpc/kernel/prom_init.c
>>   +++ b/arch/powerpc/kernel/prom_init.c
>>   @@ -115,6 +115,6 @@ struct prom_args {
>>            __be32 service;
>>            __be32 nargs;
>>            __be32 nret;
>>   -          __be32 args[10];
>>   +        volatile __be32 args[10];
>>    };
>> 
>> because I think it's just the compilers turning the small loop over
>> those fields into a "memset()".
>
> Yes.  See <https://gcc.gnu.org/onlinedocs/gcc/Standards.html#C-Language>
> near the end:
>   Most of the compiler support routines used by GCC are present in
>   libgcc, but there are a few exceptions. GCC requires the freestanding
>   environment provide memcpy, memmove, memset and memcmp. Finally, if
>   __builtin_trap is used, and the target does not implement the trap
>   pattern, then GCC emits a call to abort.
>
> Can't we simply have a small simple implementation of these functions in
> arch/powerpc/boot/?  This stuff is not performance-critical, and this is
> not the first time we hit these problems.

prom_init.c isn't in arch/powerpc/boot :)

It's linked into the kernel proper, but we want it to behave like a
pre-boot environment (because not all boot paths run it) which is why we
restrict what symbols it can call.

We could have a prom_memset() etc. but we'd need to do some tricks to
rewrite references to memset() to prom_memset() before linking.

cheers
