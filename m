Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F30257A0F0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 16:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbiGSONN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 10:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238786AbiGSOMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 10:12:48 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51533AB34;
        Tue, 19 Jul 2022 06:35:42 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LnKbF1NT5z4x7X;
        Tue, 19 Jul 2022 23:35:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1658237737;
        bh=CrnNLr81S4YloGowqIvvpwhKM5iqnery0Z9Yt9RUyUs=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=aHMRxUHbnCfBomhXQ9tcldDT7Pg5cCo4FncMhuN9OsMFUFaf1g9O5F7eSr913cN8V
         6htMn2aBuGi1A0ciVH+PVPjaqPpmy4axP36kZF1GMcKGDvsIng09UB3jFSApnWQnVF
         qpwEBvIATnpJkrTY9K7VLEIVWsp/LcImBXE2obx++KfGOLC7R63Ry00J0hGkmmSUlk
         so2xQ8rIVeHG4gFXtj4tp3I53J7LL3AhVDLFSRcweulMtvcSYBl1o4dfbkI7m2cgYd
         ToqoL7kkOTto9lRWn68KxknxrSec249u8WrBzJC+0+kUvx2Sr+jOv6O6W6LmYdHb0i
         tJzl1r/3dGEtA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Kees Cook <keescook@chromium.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Subject: Re: mainline build failure of powerpc allmodconfig for prom_init_check
In-Reply-To: <CAHk-=wgJCTaY5FeNpcw6U-c1Z6c-A2WWQfCVa=1WW3Hdf9_eww@mail.gmail.com>
References: <Ys/aDKZNhhsENH9S@debian>
 <CADVatmO9XzFnX+N0TuOtr0FYyxKr1oe5RAhCEJjmnvjteT5QNw@mail.gmail.com>
 <87cze3docs.fsf@mpe.ellerman.id.au>
 <CAHk-=wgJCTaY5FeNpcw6U-c1Z6c-A2WWQfCVa=1WW3Hdf9_eww@mail.gmail.com>
Date:   Tue, 19 Jul 2022 23:35:33 +1000
Message-ID: <871quhdy3e.fsf@mpe.ellerman.id.au>
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

Linus Torvalds <torvalds@linux-foundation.org> writes:
> On Sun, Jul 17, 2022 at 9:41 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>>
>> >         li 4,254                 #,
>>
>> Here we load 254 into r4, which is the 2nd parameter to memset (c).
>
> I love how even powerpc people know that "4" is bogus, and have to
> make it clear that it means "r4".

I wouldn't say it's bogus, I was just translating from asm to English :)

But I agree it's preferable to use a proper register name rather than a
bare integer. I never write asm using bare integers, I always use r4 or
%r4, because as you say it's too easy to get mixed up otherwise.

When looking at generated code I usually use objdump -d output, which
uses the "r4" syntax.

> It's not even an IBM thing. S390 uses perfectly sane register syntax,
> and calls things '%r4" etc.

as accepts that syntax if you tell it to.

We use that syntax in some of our newer inline asm blocks.

> The human-written asm files have those #define's in headers just to
> make things slightly more legible, because apparently the assembler
> doesn't even *accept* the sane names.

I would like to switch to using %rX everywhere and get rid of those
defines, but it's never seemed like it's worth the churn. We have ~48K
lines of asm in arch/powerpc.

cheers
