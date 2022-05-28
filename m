Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB84C536A88
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 06:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355520AbiE1ERo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 00:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiE1ERn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 00:17:43 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AACA15FC5
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 21:17:41 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id gh17so11956548ejc.6
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 21:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MNvYnB4k14pxexNxKk/IgMaTQuGWWOM1YG6cJjXi0i0=;
        b=bR59IgHUOYTykatDJWSUAg3erAMdwBd2Wfs5A2bHPWb6CeRYKb47xaoTzj5f5wA/Jf
         LzchkLCO9mIoXb0Jgq5zC673VNttuZfWUNenWb2vOcXmEdtMmc9Ak+ccf3OJVGKA2Bn/
         GKoYt/gdbdUfnLUN9RDX5NcUYrswaZHwwgTm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MNvYnB4k14pxexNxKk/IgMaTQuGWWOM1YG6cJjXi0i0=;
        b=KPRDq+DkCHWardQU96xcMqG16nEAPvNCHiqWfElSpbTDP+A9KfvImrY+9zhFnrlr2G
         fqOXA0/Inv7YdA1OuDCa/q5Li0MqgNhp0O+37mfh1TCkXt33teFl5lD5/sVdaLkQ8bIT
         LJ5D80kCYUo+4xEmEtz35I0bH9FmPp91/J+iNVw1vLixc+pQ3A7dU2+PAOrjj40M65kM
         kJpWBOOLQZytz/5PaWeHpITCchaSB6T2F4HTYNa+HHPkStABeoLpjBDS/B7jSKaCxJl8
         vjeE/1YT2p2Vgy4O1kX6UCqgFO80T4VOeNxP62ZQaqNu31ZpwBy0jGkj5XtdPbxltR2f
         2ylQ==
X-Gm-Message-State: AOAM532FQlyBVr5xPArrE/A6X8h2krXaGF/GQ/QuA09NRCW5sQmcll6r
        NOqbb033aTGka6A/nJ41Nny1XdIkcOcGu808
X-Google-Smtp-Source: ABdhPJw3i7QTS9U3Lx9t48+eKzqFPqlZVrs1beYKoWEdW/QaqkYtdRcwSUATtsGVUB39k7P9etoyww==
X-Received: by 2002:a17:907:961a:b0:6ff:b74:7e67 with SMTP id gb26-20020a170907961a00b006ff0b747e67mr16815157ejc.424.1653711459869;
        Fri, 27 May 2022 21:17:39 -0700 (PDT)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id pw8-20020a17090720a800b006fef0c7072esm2013646ejb.144.2022.05.27.21.17.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 May 2022 21:17:38 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id t20so2150097wrh.11
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 21:17:38 -0700 (PDT)
X-Received: by 2002:a5d:59ac:0:b0:20e:6fd6:88c1 with SMTP id
 p12-20020a5d59ac000000b0020e6fd688c1mr35025114wrr.442.1653711458029; Fri, 27
 May 2022 21:17:38 -0700 (PDT)
MIME-Version: 1.0
References: <YpDxiBywRMcdZNUO@yury-laptop>
In-Reply-To: <YpDxiBywRMcdZNUO@yury-laptop>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 27 May 2022 21:17:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=whTKRaz0j+cwkbLe6CEc1XWp45CLQESOqqGnRiaU1UsMQ@mail.gmail.com>
Message-ID: <CAHk-=whTKRaz0j+cwkbLe6CEc1XWp45CLQESOqqGnRiaU1UsMQ@mail.gmail.com>
Subject: Re: [GIT PULL] Bitmap patches for v5.19-rc1
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
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

On Fri, May 27, 2022 at 8:44 AM Yury Norov <yury.norov@gmail.com> wrote:
>
>       bitmap: add bitmap_weight_{cmp, eq, gt, ge, lt, le} functions

So honestly, I pulled this, looked at the code, and then unpulled it again.

This is not helping.

Making changes like this:

-       if (mm != current->active_mm || cpumask_weight(mm_cpumask(mm)) != 1) {
+       if (mm != current->active_mm || !cpumask_weight_eq(mm_cpumask(mm), 1)) {

only makes the code harder to understand.

And it gets worse:

-               if (cpumask_weight(mask) > cpumask_weight(sibling_mask(cpu)))
+               if (cpumask_weight_gt(mask, cpumask_weight(sibling_mask(cpu))))

is just disgusting. That original line is simple to read and makes
sense. That new replacement really makes you do "Whaa?"

Now, I understand that these kinds of helper functions could make for
slightly more efficient code in that you can break out of the bitmap
scanning early when you have found enough bits set. I get it.

BUT.

 (a) code legibility is really really important

 (b) the places I found this weren't that performance-critical.

 (c) in most cases, the bitmaps in question are one single word

so I'm unpulling this again.

Now, some other parts of the pull were clear improvements. For
example, the hyperv changes like this:

-               if (hc->var_cnt != bitmap_weight((unsigned long
*)&valid_bank_mask, 64))
+               if (hc->var_cnt != hweight64(valid_bank_mask))

were clear improvements where the old code was disgusting, and clearly
improved by the change.

But the "bitmap_weight_cmp()" functions (and the cpumask_weight_cmp()
ones) are just not a direction we want to go.

The special case of zero (ie "cpumask_weight() == 0" ->
"bitmap_empty()") is one thing: making that kind of change tends to
keep the code legible or even make it more understandable. So I didn't
mind that. But I do mind the pointlessly complex new arbitrary weight
comparisons, and the kind of mental cost they have.

There are people in the CS world that think "abstractions are always
good". Those people are very very wrong.

              Linus
