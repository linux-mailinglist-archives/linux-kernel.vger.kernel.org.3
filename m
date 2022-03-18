Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA19A4DE468
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 00:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241451AbiCRXFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 19:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238197AbiCRXE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 19:04:59 -0400
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F57E9C93;
        Fri, 18 Mar 2022 16:03:39 -0700 (PDT)
Received: from [IPv6:::1] ([IPv6:2601:646:8600:40c1:8f0c:2533:51ff:d719])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.15.2) with ESMTPSA id 22IN36PG1022936
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Fri, 18 Mar 2022 16:03:07 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 22IN36PG1022936
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2022030301; t=1647644587;
        bh=svb/lgQXEzjEPgFnj7j1DJy4Iq5vz9ytaGKdBRZvYko=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=bTlBuu+sxs0JshNvGQ3E+y9m/Xuz8dwiLyY+4q3DXXgPM+fnIbGU+MrR3G+OaRy/f
         bx0IiUAGeRjEQdVq/J5bCDkEudRK4+mlTQO15QkG+smtmr4QeUpncwoGZ5UPk8D6n0
         ioY5oZG34neIzvJJgJ+3XC+z8wcnI2N3X9ze6yeUd5MZzM7zkkNS0oOqWKU9aGJ+9a
         4gqt5VAmjtWwVfFf1Z+SrsJzYDuGPg8t82hbTOijcDGbdTXnMobW1CJvFz2r+pCAzL
         w0+tk1JlrNSvoxPleYrkG9U+tBYksKJu3vc/Po7R+SLx2Hs1jodCuoPsXgwlz7zDOz
         GjFceMUiJgd5g==
Date:   Fri, 18 Mar 2022 16:03:01 -0700
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     David Laight <David.Laight@ACULAB.COM>,
        "'Linus Torvalds'" <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>
CC:     Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-toolchains <linux-toolchains@vger.kernel.org>
Subject: RE: [PATCH v5] x86: use builtins to read eflags
User-Agent: K-9 Mail for Android
In-Reply-To: <5794cceec50a4f1ebca069d5a31afcdf@AcuMS.aculab.com>
References: <20220210223134.233757-1-morbo@google.com> <20220301201903.4113977-1-morbo@google.com> <CAGG=3QWh90r5C3gmTj9zxiJb-mwD=PGqGwZZTjAfyi1NCb1_9w@mail.gmail.com> <AC3D873E-A28B-41F1-8BF4-2F6F37BCEEB4@zytor.com> <CAGG=3QVu5QjQK8m2FWiYn-XQuVBjUGXcbznSbK22jVMB5GAutw@mail.gmail.com> <F5296439-4CA3-4F31-BD91-5ED1510BC382@zytor.com> <CAKwvOdkk-C8HMemKs4+yoxvNDgTLmvZG1rmwjVXBqhsQ-cED5g@mail.gmail.com> <CAHk-=whJfKN8Jag=8DS=pbZR3TY90znUOP6Km+TLRJ9dZEgNqw@mail.gmail.com> <fd89333f-e470-a295-baf6-a736c55caeb5@citrix.com> <CAHk-=wj47CG0Y9GOFmGg4AYFvXhRFDX9x7E2Uxo9k-UX2wgR4g@mail.gmail.com> <83b33afc-8502-0065-60bc-3a91528632d8@kernel.org> <CAHk-=wj1Z_zzY7ADxaarorK5sh2xkwbcHxJTzW=bsYChWJGBGg@mail.gmail.com> <5794cceec50a4f1ebca069d5a31afcdf@AcuMS.aculab.com>
Message-ID: <8B69D1BF-8369-42EC-B0ED-DED038966FC9@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On March 18, 2022 3:43:13 PM PDT, David Laight <David=2ELaight@ACULAB=2ECOM=
> wrote:
>From: Linus Torvalds
>> Sent: 18 March 2022 18:19
>>=20
>> On Fri, Mar 18, 2022 at 10:59 AM Andy Lutomirski <luto@kernel=2Eorg> wr=
ote:
>> >
>> > I generally agree=2E  In this particular case, though, I will keep us=
ing
>> > the builtin in tools/testing/selftests/x86/helpers=2Eh unless we actu=
ally
>> > hit breakage=2E  This is because this is *user* code, it is compiled =
with
>> > the redzone enabled, and the asm code to do the right thing when the
>> > redzone is enabled is too hairy for me to want to deal with it=2E
>>=20
>> Yeah, redzoning is a problem for "pushf"=2E
>>=20
>> Or rather, it's not the redzoning itself, but the fact that the
>> compiler might use the word under the stack for random other things,
>> and the pushf will then corrupt some local variable storage=2E
>>=20
>> I think it would be lovely to solve that in inline asm itself some way
>> - by marking the stack pointer clobbered or something=2E
>
>Something that generates:
>	mov	%rax,-8(%rsp)
>	pushf
>	xchg	%rax,0(%rsp)
>	add	%rsp,8
>should work with or without a redzone=2E
>Will be a bit slower :-(
>
>	David
>
>-
>Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1=
 1PT, UK
>Registration No: 1397386 (Wales)
>

*Much* slower (XCHG is implicitly locked, for hysterical raisins) and you =
are using the redzone between the mov and the push, so it seems like you ju=
st made things worse for no reason=2E
