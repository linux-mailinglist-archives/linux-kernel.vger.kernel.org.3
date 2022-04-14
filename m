Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 470B9501DB2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 23:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234969AbiDNVxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 17:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232439AbiDNVxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 17:53:22 -0400
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F187420193
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 14:50:55 -0700 (PDT)
Received: from [IPv6:::1] ([IPv6:2607:fb90:7391:dbf4:ac39:3cd7:6899:402e])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.15.2) with ESMTPSA id 23ELn22M2798814
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Thu, 14 Apr 2022 14:49:06 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 23ELn22M2798814
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2022040301; t=1649972954;
        bh=jiFuth2NsJ6kFB5qJAnKixgQm17ojdbszGGbG4v/FeY=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=WlSCH46pkTTvkaONLTYtjSkmVwtV4qIeEdMmXnK56j8qtfwYS7JikfRA16t5MViVC
         EM1qWGvWzhlh2WlFCdtk8/UVeYPWJN9pelM2/l0cF13oibPwWutbgFsYCsjE65uNxL
         UzaMe4CX9mRVu4ZeBkEf3DAcp1R7Lu0Q4CjYfJaSmfE341ksWVeh/c/jWjfchMFBDB
         Kc/0+g7g2/qKBHAy4Z8aTTrUnbJmj1jVMpR2c1aRJI76xB5zAdlw1ESnuyChATNlb9
         ESUZ4Kayt9mmYcOKPJjEWAfQnrQPber7lZBL2bGlkPEFzqEejAivyie3AdvPo+WqEc
         sBsC/PwpLjncQ==
Date:   Thu, 14 Apr 2022 14:49:01 -0700
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Rob Herring <robh@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>, "Theodore Ts'o" <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "David S . Miller" <davem@davemloft.net>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-m68k <linux-m68k@vger.kernel.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-um@lists.infradead.org, X86 ML <x86@kernel.org>,
        linux-xtensa@linux-xtensa.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v4_01/11=5D_timekeeping=3A_add_ra?= =?US-ASCII?Q?w_clock_fallback_for_random=5Fget=5Fentropy=28=29?=
User-Agent: K-9 Mail for Android
In-Reply-To: <YliHAl0XpQ57FSGy@robh.at.kernel.org>
References: <20220413115411.21489-1-Jason@zx2c4.com> <20220413115411.21489-2-Jason@zx2c4.com> <CAL_JsqJYq5Oe_zBbcwYNMpfpqGLGCyaSfGqOrPjZ_Pj=nF73mA@mail.gmail.com> <CAHmME9pn++c0qHzq39YWyXogcKRbn2XK=yA3kFqch0wH7qPcAg@mail.gmail.com> <YliHAl0XpQ57FSGy@robh.at.kernel.org>
Message-ID: <B465920D-5799-4799-A0AC-68837E159D66@zytor.com>
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

On April 14, 2022 1:41:38 PM PDT, Rob Herring <robh@kernel=2Eorg> wrote:
>On Thu, Apr 14, 2022 at 12:38:49AM +0200, Jason A=2E Donenfeld wrote:
>> Hi Rob,
>>=20
>> On Wed, Apr 13, 2022 at 4:32 PM Rob Herring <robh@kernel=2Eorg> wrote:
>> > 'does not have a usable get_cycles(), =2E=2E=2E' as clearly some arch=
es have
>> > get_cycles() and yet still need a fallback=2E
>> >
>> > Why not handle the 'if get_cycles() returns 0 do the fallback' within
>> > a weak random_get_entropy() function? Then more arches don't need any
>> > random_get_entropy() implementation=2E
>>=20
>> No, this doesn't really work=2E Actually, most archs don't need a
>> random_get_entropy() function, because it exists in asm-generic doing
>> the thing we want=2E So that's taken care of=2E But weak functions as y=
ou
>> suggested would be quite suboptimal, because on, e=2Eg=2E x86, what we
>> have now gets inlined into a single rdtsc instruction=2E Also, the
>> relation between get_cycles() and random_get_entropy() doesn't always
>> hold; some archs may not have a working get_cycles() function but do
>> have a path for a random_get_entropy()=2E Etc, etc=2E So I'm pretty sur=
e
>> that this commit is really the most simple and optimal thing to do=2E I
>> really don't want to go the weak functions route=2E
>
>Is random_get_entropy() a hot path?
>
>
>It doesn't have to be a weak function, but look at it this way=2E We have=
=20
>the following possibilities for what random_get_entropy() does:
>
>- get_cycles()
>- get_cycles() but returns 0 sometimes
>- returns 0
>- something else
>
>You're handling the 3rd case=2E
>
>For the 2nd case, that's riscv, arm, nios2, and x86=2E That's not a lot,=
=20
>but is 2 or 3 of the most widely used architectures=2E Is it really too=
=20
>much to ask to support the 2nd case in the generic code/header?
>
>Rob

It goes into interrupts, which means it is latency critical=2E
