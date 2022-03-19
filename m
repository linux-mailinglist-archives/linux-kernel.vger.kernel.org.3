Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A29004E18FC
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 00:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244361AbiCSXR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 19:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244359AbiCSXR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 19:17:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB0E25CB81;
        Sat, 19 Mar 2022 16:16:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 708D060F00;
        Sat, 19 Mar 2022 23:16:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EF71C340EC;
        Sat, 19 Mar 2022 23:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647731762;
        bh=lXASBNwBr/agrF4UaO6l9n/8WnFBciFHOoJgMWOR/D8=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=Wq1hjfa7y/igW9QymqOYJjyfybgc+aBBUV1zfz40VpkOCVeQWN2XgIy1ARil6vVdu
         YhV2ZzCCE4pGYNa5HeYGI0gfSHjtWYnX/FjfVZ272cApFGidsqjbK+qXP6tRFg56zW
         1BHYBKs6GfJDO9jcR6WWxKpWcuK3G37TWKXnumUe70S3kuv4tEngxia9dHgWqrAXex
         KqZSeZ53k2uD69iFe3pjtK62jSuoai0guFvRMMy6tBFlbecW/SYZfvA6GGlmWzKA1M
         WLVyYnygNwNRVe0TXMqo+/Xni1uyoRJY6x8cpE1YIJgTMwLHmPxt7+GxC/TUXzoZpA
         c8AcWAgV19cNA==
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 2A21027C0054;
        Sat, 19 Mar 2022 19:16:01 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute5.internal (MEProxy); Sat, 19 Mar 2022 19:16:01 -0400
X-ME-Sender: <xms:L2Q2YgRjP7fGdTj888cdkiQBoITgPrUuiC8ZXgJaBttua-qeaETy0Q>
    <xme:L2Q2YtzcmABE6N53Go-VFtemUiTI2J5SELrnSaiPJ2NaAyrAzANe2zur6nehEiUuJ
    jr0euCiNyYXiiY2HsA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudefledgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgfgsehtqhertderreejnecuhfhrohhmpedftehn
    ugihucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqnecugg
    ftrfgrthhtvghrnhepvdelheejjeevhfdutdeggefftdejtdffgeevteehvdfgjeeiveei
    ueefveeuvdetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homheprghnugihodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduudeiudek
    heeifedvqddvieefudeiiedtkedqlhhuthhopeepkhgvrhhnvghlrdhorhhgsehlihhnuh
    igrdhluhhtohdruhhs
X-ME-Proxy: <xmx:L2Q2Yt0JtPFmM2KrsMmKdzaqkdbOME1DJNyW6dUmQMjFecXgVt8SAQ>
    <xmx:L2Q2YkAtJK2OokZL-Dj-GpwSTOCU4S8ldGu49kzNRiDJMh9jCePCmw>
    <xmx:L2Q2YpiIUqx8QYjoHOlWo5pEdu6e8YN5Ij6YJrCdIyp8lTkQNGsumA>
    <xmx:MWQ2Yp58sxnIphpwyc5K0eqFNqirM3ahbQ_dZv4qqxJbDxQ6hKzqDH90n1Y>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 805FA21E006E; Sat, 19 Mar 2022 19:15:59 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4907-g25ce6f34a9-fm-20220311.001-g25ce6f34
Mime-Version: 1.0
Message-Id: <4ac71b88-4848-456f-8b34-518ca7622fee@www.fastmail.com>
In-Reply-To: <20220318234212.GU614@gate.crashing.org>
References: <CAGG=3QVu5QjQK8m2FWiYn-XQuVBjUGXcbznSbK22jVMB5GAutw@mail.gmail.com>
 <F5296439-4CA3-4F31-BD91-5ED1510BC382@zytor.com>
 <CAKwvOdkk-C8HMemKs4+yoxvNDgTLmvZG1rmwjVXBqhsQ-cED5g@mail.gmail.com>
 <CAHk-=whJfKN8Jag=8DS=pbZR3TY90znUOP6Km+TLRJ9dZEgNqw@mail.gmail.com>
 <fd89333f-e470-a295-baf6-a736c55caeb5@citrix.com>
 <CAHk-=wj47CG0Y9GOFmGg4AYFvXhRFDX9x7E2Uxo9k-UX2wgR4g@mail.gmail.com>
 <83b33afc-8502-0065-60bc-3a91528632d8@kernel.org>
 <CAHk-=wj1Z_zzY7ADxaarorK5sh2xkwbcHxJTzW=bsYChWJGBGg@mail.gmail.com>
 <9a97330b-e5ee-7b7e-4c7a-cfdf15032094@citrix.com>
 <CAHk-=wgKBme-SdbkSxbQ4+c6tZdvY2fe1wP1TgJeuDAf+AgwMg@mail.gmail.com>
 <20220318234212.GU614@gate.crashing.org>
Date:   Sat, 19 Mar 2022 16:15:39 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Segher Boessenkool" <segher@kernel.crashing.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     "Andrew Cooper" <Andrew.Cooper3@citrix.com>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Bill Wendling" <morbo@google.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "Nathan Chancellor" <nathan@kernel.org>,
        "Juergen Gross" <jgross@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        linux-toolchains <linux-toolchains@vger.kernel.org>
Subject: Re: [PATCH v5] x86: use builtins to read eflags
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, Mar 18, 2022, at 4:42 PM, Segher Boessenkool wrote:
> On Fri, Mar 18, 2022 at 04:10:55PM -0700, Linus Torvalds wrote:
>> It would be lovely to have some explicit model for "I want the frame
>> to have been set up for backtraces", but here we are.
>
> So please define exactly what that *means*?  Preferably portably, but I
> reckon at least some of it will have to be machine-specific (and ABI-
> specific).  But it needs to be well-defined, clearly defined, defined =
at
> all, and *documented* :-)
>
>> Marking '%rsp
>> used makes the compiler understand it's not a leaf function.
>
> As I said before, this is explicitly incorrect code.  Always was, but
> it is documented since a while (since GCC 9).  Clobbering the stack
> pointer can never be correct, the stack pointer after an asm has to be
> identical to the one before that asm!
>
>> And while we have other uses for it that then use the actual value,
>> those don't care about the exact value of the stack pointer register,
>> they just want "give me a pointer that is contained within the current
>> stack", because we control the stack allocation and do funky things
>> there. So "any random stack pointer value in this function" is
>> perfectly fine and expected.
>
> You can use %rsp as *input* operand just fine, which is all you need f=
or
> that.
>
>> But for user mode, it would probably be a great idea to also have a "I
>> cannot use a redzone in this function" thing. The kernel can't use it
>> because we have nested exceptions, but maybe some day even the kernel
>> could make use of (controlled) red-zoning.
>
> Yes.  We just have to figure out what the exact semantics we want is,
> and how to express that in a target-independent way, and then relatedly
> what a good name for it would be ("redzone" in the clobber list is the
> best I can come up with right now, but that may have to change).

Here=E2=80=99s the semantics I want:

I want to tell the compiler that an asm statement makes a function call.=
 I want to specify the stack alignment and offset I need.  I want the co=
mpiler to make it work. Something like this, but preferably with better =
syntax:

asm("asm here" ::: "call" (align=3D16, offset=3D0));

This means that the asm in question wants rsp to be 0 more than a multip=
le of 16 and that it wants precisely the setup needed for a call to be d=
one. If frame pointers are enabled, a frame should be set up. If there i=
s a redzone then either the compiler needs to not use it or needs to adv=
ance rsp past it.

>
>
> Segher
