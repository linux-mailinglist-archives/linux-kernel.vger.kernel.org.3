Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24952577A25
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 06:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232898AbiGRElg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 00:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiGREle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 00:41:34 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F5910551;
        Sun, 17 Jul 2022 21:41:32 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LmTnN1vs1z4xhn;
        Mon, 18 Jul 2022 14:41:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1658119288;
        bh=HfoMlxVHe2GNGL+Z3nwT14HwbjZ1aAk2Dtdo9PNK1VQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=CHSSgVtrop/Y7cdYxGnGHQMtrhKN6M4mfFF179p31b8WbnOsj/tE+V4NpwgwwMx6Z
         lAxnw5V0oEwFWQHxLcv1B6bI5z1F/0jZJUZF8lOXvvdrW2gdzcmjD82sB1YUESQ6/p
         UdxgKYYEzGQkBFqlT4kEHzSkxqzJLL2NY/5jd5D81xFH+s7tK6VFrwLGcSjuYuCBFx
         qkWjqmqY6wfvZ2SaiuOOFLRcPhrliuW3A25gQvyztz/W7IdV3Qxi05NsHd07cIIRHj
         eGjTRoqhbkPIhrlFr2oWYWmlUqM2BZYAWGLTPf8St8pzZX16L+C1KxjYFfSRV9COaQ
         bJo7pdgo4/H+w==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Kees Cook <keescook@chromium.org>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: mainline build failure of powerpc allmodconfig for prom_init_check
In-Reply-To: <CADVatmO9XzFnX+N0TuOtr0FYyxKr1oe5RAhCEJjmnvjteT5QNw@mail.gmail.com>
References: <Ys/aDKZNhhsENH9S@debian>
 <CADVatmO9XzFnX+N0TuOtr0FYyxKr1oe5RAhCEJjmnvjteT5QNw@mail.gmail.com>
Date:   Mon, 18 Jul 2022 14:41:23 +1000
Message-ID: <87cze3docs.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sudip Mukherjee <sudipm.mukherjee@gmail.com> writes:
> On Thu, Jul 14, 2022 at 9:55 AM Sudip Mukherjee (Codethink)
> <sudipm.mukherjee@gmail.com> wrote:
>>
>> Hi All,
>>
>> Not sure if it has been reported before but the latest mainline kernel
>> branch fails to build for powerpc allmodconfig with gcc-12 and the error is:
>>
>> Error: External symbol 'memset' referenced from prom_init.c
>> make[2]: *** [arch/powerpc/kernel/Makefile:204: arch/powerpc/kernel/prom_init_check] Error 1
>
> I was trying to check it. With gcc-11 the assembly code generated is
> not using memset, but using __memset.
> But with gcc-12, I can see the assembly code is using memset. One
> example from the assembly:
>
> call_prom:
>         .quad   .call_prom,.TOC.@tocbase,0
>         .previous
>         .size   call_prom,24
>         .type   .call_prom,@function
> .call_prom:
>         mflr 0           #,
>         std 29,-24(1)    #,
>         std 30,-16(1)    #,
>         std 31,-8(1)     #,
>         mr 29,3          # tmp166, service
>         mr 31,4          # nargs, tmp167
>         mr 30,5          # tmp168, nret
>  # arch/powerpc/kernel/prom_init.c:396:         struct prom_args args;
>         li 4,254                 #,

Here we load 254 into r4, which is the 2nd parameter to memset (c).

>         li 5,52          #,

This is r5, the 3rd parameter (n), ie. the size of the structure.

That tells us we're memsetting the entire structure, ie. the 10 x 4
bytes of args.args plus 3 x 4 bytes for the other members.

>  # arch/powerpc/kernel/prom_init.c:394: {
>         std 0,16(1)      #,
>         stdu 1,-208(1)   #,,
>  # arch/powerpc/kernel/prom_init.c:396:         struct prom_args args;
>         addi 3,1,112     # tmp174,,

Here we load (calculate) the address of "args" into r3, the first
parameter to memset.

>  # arch/powerpc/kernel/prom_init.c:394: {
>         std 9,304(1)     #,
>         std 10,312(1)    #,
>         std 6,280(1)     #,
>         std 7,288(1)     #,
>         std 8,296(1)     #,
>  # arch/powerpc/kernel/prom_init.c:396:         struct prom_args args;
>         bl .memset       #

So we're memsetting all of args to 254, not zero.

That's happening because allmodconfig with gcc 12 enables
CONFIG_INIT_STACK_ALL_PATTERN, whereas gcc 11 doesn't.

I think the simplest fix in the short term is to just disable stack
initialisation for prom_init.c. It only runs at boot so there's no real
security impact to disabling it.

cheers
