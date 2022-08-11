Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20F81590701
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 21:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235540AbiHKTft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 15:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235402AbiHKTfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 15:35:48 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2375DFBF
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 12:35:46 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id t5so24159811edc.11
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 12:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=AzBK0WvHSrjzg7grX+nes2MRnQT5gXizb5gZy8rBp+Y=;
        b=YPzqKiu3/1o3+WhxBPnQHsvCyowjo+jxKKgQpHpM/fSe0hAtExcgjfDRYL+DvDpxMR
         9yug45riOHPwiTBowOYniLR3wG4ldyZ91Y/uoORgKhhD5rn8U1L+JMwtkF1RwMwiqB8v
         KUJ3rQcmlz1eggM89F78Q19q/K8nsvl/UoH9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=AzBK0WvHSrjzg7grX+nes2MRnQT5gXizb5gZy8rBp+Y=;
        b=MAUDcRsAzW6PfIyDTlxDR60LTZsIpwqZss12lN4pZm90auvJd11/eUFa5t3Bs5A0WC
         kG9GISexGprrIHiN4KJZygbW/0YAkZQpczYHI8FvEk1bjY6403ZhNV2k2cZTkTmhJMfw
         wzkC4X7V6E2cKq4oOhXx03nviz3TFhixTOJvAJHAf6qvL4HtbZOfoRhFFXHijNOtV8zj
         AJom1KIx9BH/cViZsJMJIjz2JucFG4CtTBIaySvOuuoq2Gj+iApUnuDc+fRtrgl522DZ
         5gQ4qG/HdRXih9hNTzsUsw7pNnAEYaXFtQ1WmnIJ7p+Vne1FCXuOe79vbOJxa4oP78w7
         OyMA==
X-Gm-Message-State: ACgBeo3VRiktm5Ofntkl7s4s7BILPw5g+kZrj2bjQl1TyJ39hH7zsdfO
        ELsf2VoI6ZcPBPFeB4W6EDRsELeZjIqR6uyV
X-Google-Smtp-Source: AA6agR5NHvA/Np8r76QVgO7NNC+1fwtntxHFWi52h18gaKJc5M6le9K3fdwHt/9NX2JU+lX9W5AvVA==
X-Received: by 2002:a05:6402:358a:b0:43d:aa71:3033 with SMTP id y10-20020a056402358a00b0043daa713033mr584740edc.248.1660246545039;
        Thu, 11 Aug 2022 12:35:45 -0700 (PDT)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com. [209.85.128.51])
        by smtp.gmail.com with ESMTPSA id w20-20020aa7da54000000b0043bba5ed21csm182064eds.15.2022.08.11.12.35.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Aug 2022 12:35:43 -0700 (PDT)
Received: by mail-wm1-f51.google.com with SMTP id h1so684723wmd.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 12:35:43 -0700 (PDT)
X-Received: by 2002:a1c:f603:0:b0:3a5:23ca:3e7c with SMTP id
 w3-20020a1cf603000000b003a523ca3e7cmr438228wmc.38.1660246542464; Thu, 11 Aug
 2022 12:35:42 -0700 (PDT)
MIME-Version: 1.0
References: <YvSxeDkmwxcJL+Z0@debian> <YvUZ+9kJ/AvUMxzO@dev-arch.thelio-3990X>
 <CAHk-=wivP4zipYnwNWCLF5cd24GLs3m8=Sp7M-CmmPva_UC+3Q@mail.gmail.com> <CAKwvOdnQjgtwqFXLv+QtWPfpHosM5fxE5oqbX0VUD53F8L6bRg@mail.gmail.com>
In-Reply-To: <CAKwvOdnQjgtwqFXLv+QtWPfpHosM5fxE5oqbX0VUD53F8L6bRg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 11 Aug 2022 12:35:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgJA=e-CLcvU5LRKu0bMLeAewXtOM6as1hFVeQAVkMPbg@mail.gmail.com>
Message-ID: <CAHk-=wgJA=e-CLcvU5LRKu0bMLeAewXtOM6as1hFVeQAVkMPbg@mail.gmail.com>
Subject: Re: mainline build failure for arm64 allmodconfig with clang
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Joe Perches <joe@perches.com>,
        Nathan Chancellor <nathan@kernel.org>,
        "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux <llvm@lists.linux.dev>,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2022 at 11:39 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> Generally, printing an int with %hhu may truncate depending on the
> value of the int.

Yes.

HOWEVER.

That truncation is *LITERALLY THE MAIN REASON TO EVER USE %hhu IN THE
FIRST PLACE*.

See the issue?

Warning about "this may truncate bits" when the main reason to use
that format string in the first place is said bit truncation is kind
of stupid, isn't it?

I suspect most people have no idea what '%hhu' means in the first
place, and probably have to look it up. It's a pretty specialized
thing, with a pretty specialized reason.

The most common reason that I've ever seen for using it has been "oh,
I have a 'char', and I don't know or care about the sign of it, I want
to print it out consistently, and %hhu does that for me".

And often that char isn't actually a 'char', it is actually an 'int',
either because you have situations like 'getch()', or you have simply
just the usual C expression rules, ie you have something like

        isprint(c) ? c : '.'

where even if 'c' is of type 'char', the end result is 'int'.

And guess what? Truncating out those sign bits - if char is signed,
which it may or may not be - is then what the whole and only point of
it is.

Really.

So if a compiler warns about it, the compiler is BROKEN.

And if a compiler writer says "well, then you should have added a cast
to 'unsigned char'", then the compiler writer is clueless and WRONG,
because if you add the cast, then the '%hhu' becomes pointless again,
and you would have been better off using the simpler and more obvious
%u (or the even more obvious %d).

See what I'm saying when I'm emphasizing that THE MAIN REASON TO USE
'%hhu' IS BECAUSE YOU KNOW AND WANT THAT TRUNCATION.

> Perhaps there's something different we can be doing for literals though.

No.

Look, literals just make that warning look obviously stupid. With a
literal, even a less-than-gifted rodent goes "that warning is stupid".
Adding a cast to 'unsigned char' looks stupid to begin with, but it is
then *extra* stupid when you know the function is a varargs functions
and it will just be cast right back to 'int' anyway.

It happens to be what at least one kernel use was, and it happens to
be what my example was, just to *really* point out how stupid that
warning is.

But the deeper truth is that the warning is wrong even for the case
where there are upper bits, because that's when '%hhu' really matters.

So that warning only makes '%hhu' pointless.

The only thing that warning shows is that some clang person understodd
the *syntax* of %hhu, but didn't understand the *meaning* of it, and
the use of it.

> I don't care which you pick, but let's be consistent?

The thing is, I don't care at all if some kernel developer decides to
use '%hhu'. It's odd, but it's not wrong. It's perhaps worth
discouraging just because it's so odd and unusual, but at the same
time I really don't care very deeply.

But what I *do* care about is when a compiler is so broken that it
gives completely mindless warnings because it doesn't understand what
it going on.

At that point I go "let's turn off this warning, because the people
who did that warning are clearly not doing the right thing, and that
warning causes pointless problems".

And until clang fixes their idiotic warning policy, that -Wformat
stays turned off.

Now, if you can show that the clang people understand why that warning
is completely bogus and broken, adn they've fixed it in their
development tree, at that point I'm willing to turn the warning on
again and work around it in the kernel.

But as long as clang just gets it fundamentally wrong, and as long as
clang developers continue to think that their broken warning is
"correct", then I refuse to turn that garbage on.

See where I'm coming from? The warning is fundamentally broken.

I'm willing to work around compiler bugs in the kernel. But if the
compiler people in question don't even think they are bugs, I'm not
working around them, I'm turning them off.

This is not that different from the whole "type-based alias analysis"
thing. It's fundamentally broken garbage, and it gets turned off.

See the difference?

One is "oh, compiler bug, we'll work around it".

The other is "the compiler is being actively wrong unless you pass the
right flag to the compiler".

Right now it appears that clang is being actively wrong, and that
passing '-Wformat' to clang is simply the wrong thing to do. Because
that warning has clearly been actively added. It's not some oversight,
it's literally extra code just to mess things up.

But the moment I hear that clang removed that warning in their
development tree, it turns from active malice to just a mostly
harmless bug.

               Linus
