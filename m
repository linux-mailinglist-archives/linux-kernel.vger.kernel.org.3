Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 126624D3B37
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 21:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236625AbiCIUjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 15:39:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236176AbiCIUjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 15:39:20 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4BD527F3
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 12:38:19 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id v28so4893114ljv.9
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 12:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/yeinogDeuOBTA+RgXs0VaNGe2cwXag06ouy/qbMCCs=;
        b=eAKctOojBAW5vDxW9VxH+BGy31s6He186/PWHaAwIkHLzVegn5dhGdivM4jeg72UAe
         GkML1gmaFxGvszjifGcmZzmlorfKxzX8XLPWQ94CkkGCi+OMrgGduicTJGG3qmRhfXQA
         JD8i+KL7gGnY5EOdq35cteeedEM2EWl62TU3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/yeinogDeuOBTA+RgXs0VaNGe2cwXag06ouy/qbMCCs=;
        b=mSszR6HAo6THBeAMrhlWQJMN21stDrVFsosjCZRaHaCrhf7EXSNjH/0FaAR3icndfe
         mdG04qjHxVPYSfiXhtMhUJVEqBX8u+f9MczUJP+Jp/QJqg5wBOhEXLlze/Mv9qJOgXua
         IHfcS/sFOx0SeJCeuZORiij8F4AD6OnagmU6B1Q1KdjxT5mREgXNzQ7Lzk7xIWVlArtE
         8gy99hXo02zq7YiAMcrHBWrCWUn4jo3D04SSR0xSLLmhFJuHna4xqGByZxFG6OiM/tTr
         pWUPs9qWvkF3Kk27AA1MUgEuLwPpRZ8Q8qoG4OtNoCj7jX/CVGuC7BxSSd5MxR9btcl0
         BlYw==
X-Gm-Message-State: AOAM530awpCFiAmkwRz7LeLQa8omDaEK7cegMyuN2pQuHgFyq4WaqA2H
        b1FasY1OAGpkKjI0gqupY1O+GoqVj0ry9C0DZws=
X-Google-Smtp-Source: ABdhPJxras7Z8dZSesnSMBLQ8VnaBYn4g56yHK6mX7GaiHZ5uA8MGxNeZlFA7jumfgQTnqeAQptPTA==
X-Received: by 2002:a2e:8256:0:b0:246:3e95:77e8 with SMTP id j22-20020a2e8256000000b002463e9577e8mr821130ljh.493.1646858297930;
        Wed, 09 Mar 2022 12:38:17 -0800 (PST)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id f15-20020a2e6a0f000000b0023e429778fasm625131ljc.56.2022.03.09.12.38.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 12:38:11 -0800 (PST)
Received: by mail-lj1-f177.google.com with SMTP id bn33so4911770ljb.6
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 12:38:11 -0800 (PST)
X-Received: by 2002:a2e:9904:0:b0:247:ec95:fdee with SMTP id
 v4-20020a2e9904000000b00247ec95fdeemr823721lji.291.1646858290905; Wed, 09 Mar
 2022 12:38:10 -0800 (PST)
MIME-Version: 1.0
References: <20220113160115.5375-1-bp@alien8.de> <YeBzxuO0wLn/B2Ew@mit.edu>
 <YeCuNapJLK4M5sat@zn.tnic> <CAMuHMdUbTNNr16YY1TFe=-uRLjg6yGzgw_RqtAFpyhnOMM5Pvw@mail.gmail.com>
 <YeHLIDsjGB944GSP@zn.tnic> <CAMuHMdUBr+gpF6Z5nPadjHFYJwgGd+LGoNTV=Sxty+yaY5EWxg@mail.gmail.com>
 <YeHQmbMYyy92AbBp@zn.tnic> <YeKyBP5rac8sVvWw@zn.tnic> <b40d1377-51d5-4ba3-ab3f-b40626c229ad@physik.fu-berlin.de>
 <87ilsmdhb5.fsf_-_@email.froward.int.ebiederm.org>
In-Reply-To: <87ilsmdhb5.fsf_-_@email.froward.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 9 Mar 2022 12:37:54 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg+TYsns5JvNds6BVG7ezdg8uM_z9m8uJBcRDANdd7csw@mail.gmail.com>
Message-ID: <CAHk-=wg+TYsns5JvNds6BVG7ezdg8uM_z9m8uJBcRDANdd7csw@mail.gmail.com>
Subject: Re: [PATCH] a.out: Stop building a.out/osf1 support on alpha and m68k
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Kees Cook <keescook@chromium.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Borislav Petkov <bp@alien8.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Theodore Ts'o" <tytso@mit.edu>, X86 ML <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Matt Turner <mattst88@gmail.com>,
        =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>,
        Michael Cree <mcree@orcon.net.nz>,
        linux-arch <linux-arch@vger.kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
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

On Wed, Mar 9, 2022 at 12:04 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Let's see if anyone cares about a.out support on the last two
> architectures that build it, by disabling the build of the support in
> Kconfig.

Oh, I'm pretty sure we can't do this.

a.out on alpha is afaik still very much alive - well, as alive as
anything alpha is - although it's called "ECOFF".

It's the native Tru64 (aka "DEC OSF/1", aka "Digital UNIX") format, so
it's more than some old legacy Linux thing.

We still call it "a.out", but the history is that a.out with some
extensions became COFF, which then became ECOFF, so our a.out code
really covers the whole gamut.

Yeah, we don't actually parse any of the extensions that make COFF
what it is, or ECOFF what _it_ is, but the a.out loader ends up
working "well enough" for simple binaries by using ugly code like

  #define N_TXTOFF(x) \
    ((long) N_MAGIC(x) == ZMAGIC ? 0 : \
     (sizeof(struct exec) + (x).fh.f_nscns*SCNHSZ + SCNROUND - 1) &
~(SCNROUND - 1))

which jumps over all the section headers.

But sure, it would be interesting to know if any alpha people care - I
just have this suspicion that we can't drop it that easily because of
the non-Linux legacy.

                   Linus
