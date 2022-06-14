Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4049954BBF8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 22:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357332AbiFNUnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 16:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353110AbiFNUnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 16:43:33 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2E819015
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 13:43:31 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id v1so19357878ejg.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 13:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dhAM/LQikebwPyrwCB/38lxgJLD4HIC2Qhyl28Iz4Bo=;
        b=F64WuJyflipU8IKSxsvGs9EdDSEd6+FrvI2BKcasSS/0ENM051pT66CjnRViaTl7sw
         Lwp5sxIwuSmAzzBzwSqg/uYy/OkIfMGeDtO7gOick8FFKeDNMqyzE5X77y+6saloeTcw
         C2sC9S+KjWM86en5pcv/eMsQB6SPZUaenDdoU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dhAM/LQikebwPyrwCB/38lxgJLD4HIC2Qhyl28Iz4Bo=;
        b=3sGGjzari481ke74m1yJV7tk0Cv/mcVG6vWCvBUXRjpbSUO5XMnoQqs35fSCa/LwdP
         cQu1IcW2UFSS6j1YEcEHW/toMGbWerEhn4l+WAST12tUsS4UPMG0INboPNSQphE3+cQC
         ghXhmksw0g+6WLBmpzDjc7uqqHI4bE56jkV2/KQRfFrnswPmrJP3c24MoOEKcBGm23sD
         6I0pA/H/ob8v2Kqa2YeMcZ97imTMtteFewgDzDKSXILnexMDvxTDf+Pa5Vh8/BUsyL4F
         KFJFzSzpk61s6vnT47C27sORf7OZY1dC1p1ynY8KI9SAzkRuBnO61MOLYhYCRP7JTQvs
         ZbbQ==
X-Gm-Message-State: AOAM533qn1emDnkwmYF2dckU/+F0CrPqQZuMI2iV1X9IXGMMsT3o6C3Q
        bo9/mIg1sCLAewbhM/Ocr5EtnTb/E65XJRnk75k=
X-Google-Smtp-Source: AGRyM1tiWpdYzIGOYrqHbupSlyg/qLDQih/qjU84BV77pkxKPoyPFGAKjib5UCHvprwS5SFI9+xCBw==
X-Received: by 2002:a17:907:c22:b0:711:dc95:3996 with SMTP id ga34-20020a1709070c2200b00711dc953996mr5929448ejc.62.1655239409801;
        Tue, 14 Jun 2022 13:43:29 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id x90-20020a50bae3000000b0042ab87ea713sm7815658ede.22.2022.06.14.13.43.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 13:43:28 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id u8so12727663wrm.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 13:43:27 -0700 (PDT)
X-Received: by 2002:a5d:47aa:0:b0:218:5ac8:f3a8 with SMTP id
 10-20020a5d47aa000000b002185ac8f3a8mr6695741wrb.442.1655239407469; Tue, 14
 Jun 2022 13:43:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220614144853.3693273-1-glider@google.com> <CAHk-=whaWnwB8guceg8V=bA1adv74GNaMk2FEu+YQkBKUqxVoA@mail.gmail.com>
 <CAG_fn=WEed5NJ8hdrrP_N8aQ_1Ad11VoJgdVxQheo3VfT_xyXQ@mail.gmail.com>
 <CAHk-=whjz3wO8zD+itoerphWem+JZz4uS3myf6u1Wd6epGRgmQ@mail.gmail.com> <CAG_fn=UPoM3bafwu6inGPMjg1bPw3HSFM_KrE_hen_MN3fu2vA@mail.gmail.com>
In-Reply-To: <CAG_fn=UPoM3bafwu6inGPMjg1bPw3HSFM_KrE_hen_MN3fu2vA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 14 Jun 2022 13:43:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgG0nzFbGi_HmH9Yxi2KCofG5jPYNZQPA5+GsOfsZjWkw@mail.gmail.com>
Message-ID: <CAHk-=wgG0nzFbGi_HmH9Yxi2KCofG5jPYNZQPA5+GsOfsZjWkw@mail.gmail.com>
Subject: Re: [PATCH] [RFC] Initialization of unused function parameters
To:     Alexander Potapenko <glider@google.com>
Cc:     Evgenii Stepanov <eugenis@google.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vitaly Buka <vitalybuka@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-toolchains <linux-toolchains@vger.kernel.org>
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

On Tue, Jun 14, 2022 at 1:20 PM Alexander Potapenko <glider@google.com> wrote:
>
> What about the cases where these uninitialized values are never used
> in the callee?

I assume that what happens is that when things are inlined, the
compiler then sees that there is no actual uninitialized value, and
that's ok.

But if things aren't inlined, I really hope all compilers already warn
about "look, I'm calling this function with an uninitialized
argument".

IOW, compilers can - and should - obviously take more information into
account when they can see it.

So no, don't warn for things you can actually see are not used.

IOW, you shouldn't warn because of any _syntactic_ issue of it being
an argument to a function. We often use inlining as an actually
semantically meaningful thing, and the compiler should *not* warn for
some theoretical "if this was not inlined, the argument would be used
and be uninitialized" case.

For an example of this kind of "not really used" thing, I could
imagine that some configuration might need a "cookie" model to pair up
actions, and you have a

        void *cookie;

        start(arg, &cookie);
        ....
        end(cookie);

kind of situation.

But then I could imagine that other configurations don't actually need
or use that "end()" thing at all, and would leave "cookie"
uninitialized, because the only valid use would be an inline function
that is empty, and purely there for those *other* configurations.

Again, if the compiler inlines 'end()', and sees that 'cookie' is not
actually used, then no complaint is needed - or valid.

But if 'cookie()' is an actual real function call, and you don't see
the use of it, then it had better warn.

No?

               Linus
