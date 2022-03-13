Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5897E4D7776
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 19:40:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234888AbiCMS1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 14:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbiCMS1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 14:27:46 -0400
X-Greylist: delayed 88319 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 13 Mar 2022 11:26:37 PDT
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1E6186EE
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 11:26:37 -0700 (PDT)
Date:   Sun, 13 Mar 2022 18:26:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theinnocuous.com;
        s=protonmail; t=1647195994;
        bh=PhLD6jaumig7eXFjvwaJhL44qHF7KhFQI5+IkPB7YeE=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=tGGeHcpTPRJbHRTX1MTNInmSXmWJ7XCHkgG/N/bytrSsDyv4RFBlEiTGSndtBq+Gh
         m1eG5EUK2aLV0vvu7dR3Q9WQZ6g8iRTHuw7Uos3GX6sIj4A2LL3vfI7gMy97ukY+ys
         9M72gpia6hKiDIs4npqVL7udLhMWcC8FdoIUrkCM90sStQh8d9ycbKSLTRnbpTfGVQ
         r+fVk80UH2fTQkrvEa/r+MOc4ZRJB63DzQ4slX7sDlganHgUvCKorNl8xkShaoyirE
         BP0rBAegfG2Du1OV1OJ1KwbNhQiisatxE+WZOZsUoYeodBPw6dUZfO5mXGSkjEuWGc
         6TH4YIYSyvnkw==
To:     Borislav Petkov <bp@alien8.de>
From:   James Jones <linux@theinnocuous.com>
Cc:     keescook@chromium.org, x86@kernel.org, linux-kernel@vger.kernel.org
Reply-To: James Jones <linux@theinnocuous.com>
Subject: Re: [PATCH] x86: Remove a.out support
Message-ID: <785a6348-e1c5-7900-78bc-af8b6923cc8a@theinnocuous.com>
In-Reply-To: <Yi3b/GpUuhkI5lv7@zn.tnic>
References: <4c449fab-8135-5057-7d2c-7b948ce130cc@theinnocuous.com> <0b31b1d3-852d-6cab-82ae-5eecaec05679@theinnocuous.com> <Yi3b/GpUuhkI5lv7@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/13/22 4:56 AM, Borislav Petkov wrote:
> On Sat, Mar 12, 2022 at 06:06:26PM +0000, James Jones wrote:
>>> Sorry for taking so long to complain, but I have been meaning to note
>>> that I and a few others are still using a.out. I saw it go by in my
>>> morning Google news skim that this went in, and figured it was now or
>>> never. The use case is running an old set of tools to build programs fo=
r
>>> the Atari Jaguar. Namely, Atari's assembler (mac) and linker (aln). The
>>> alternative is running windows versions in dosbox, or using some
>>> replacements that have been developed based on an even older,
>>> less-featureful version of the source code for mac and aln, but which
>>> still haven't managed to add back in all the features needed to build
>>> some programs or use the Atari debugging tools (Also available in a.out
>>> only).
>
> Ok, for my own understanding only: you want to build those tools as
> a.out binaries and run them on x86, correct?

The 'mac' and 'aln' tools are only available as x86 a.out binaries. I
can't build them. They're in 'jaguar/bin/linux/[aln,mac]' in the
referenced jaguar-sdk project, along with a few others.

> Because wikipedia says that jaguar thing has a motorola m68k system
> processor and looking at your makefile, you build some ancient gcc with
> --target=3Dm68k-aout so where does x86's a.out support come into play
> here?

Sorry for not being clearer. The 'mac' and 'aln' x86 a.out binaries
generate and consume m68k a.out object files. So if you want to use some
C code in addition to assembly listings, you'd use this separate m68k
a.out build of gcc (itself an ELF executable) to compile the C code to
object files, then link everything with 'aln'.

The real value of 'mac' and 'aln' though isn't their m68k support.
binutils can assemble and link that, as can the version of 'mac' and
'aln' that source is available for. These builds of 'mac' also support
the Jaguar's custom RISC instruction set, allowing you to add this RISC
code in the same assembly listings as the m68k code using a few
directives. This version of 'aln' has a few options to support
Jaguar-specific stuff as well.

This all probably seems absurd now, but note the newest version of these
tools was released in 1995, when Linux ELF support would have been brand
new. I don't know when the tools first shipped on Linux, but it would
have been a few years before that, so a.out would have been the only
option. It seems some Atari Jaguar developers were rather early Linux
adopters.

>>> If others are open to it, I can share my small local patches along with
>>> a revert of this change. I'd also like to ask whether much is gained by
>>> deleting this code as far as reducing maintenance burden. It has
>>> survived nearly untouched since the deprecation notice and still works
>>> modulo a broken preprocessor macro in fs/exec.c.
>
> I personally don't mind if you fix it up and take care of it going
> forward, shouldn't be too much of a maintenance overhead - I'd just like
> you to document somewhere in those files what is still using this so
> that when you don't care for that project anymore or you stop needing
> it for whatever reason, we can look up the URL and check whether we can
> remove a.out support then.

OK, will do. I appreciate the consideration.

-James

> Thx.
>
> --
> Regards/Gruss,
>      Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette

