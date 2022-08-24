Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDEAF5A00A9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 19:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240300AbiHXRpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 13:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240290AbiHXRpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 13:45:46 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02AA181B15
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 10:45:39 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id c9so12117045qkk.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 10:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=3majRtgK1WM50+kP58AFxmfVpFYPY7FKVRe4D0xTAv0=;
        b=qxBMKiEQGuZvs5Dq43ToYAMt54TMF7Yxv4BNjtRFc9vAvinTZMAwC8bUtp+Lf7j2YI
         iTlHFUivMbvLhrl8nn2eckkR5yXTOO5gqNA3sq4n+dPxNow71aRHFxezX9H4G02VwG2x
         x7U0HiQ6NymmNAg9Eu4TBMhEp8dpj+CxRTAXBA6f0GlIQq/loErqqrqTR3K50zwZBUVM
         krvoWho2zym5qCH3tPnnCM2Pr1mMiph9qPS9LelomKaU1rOahdD5DzJznFwFrjcFLG6j
         yGiRmjyiLyTk6YIdTnvxeCxD775yZ94eKFe4aNi3OHgpCcp8hg/a7003HUAmBb9hSKL7
         QOdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=3majRtgK1WM50+kP58AFxmfVpFYPY7FKVRe4D0xTAv0=;
        b=6jGu2UxKCBHJRM+vlxGf9h4JP3QRB9aj57oDoxgao3Hq5sb5VDVuoULIx1E/EZmcWv
         thI2on6+5iv7JbrCY1+Zjin4BWKNyivtkfYMOrzVzQKR57bA4UmOzKOpQY3DQnvJraWb
         fmBp/17Ke34+7ZAo3JxZjfHSpEpSd43uJ49Y2eeEDBEv1p+Msh3hT35tsybFPKoEtdGO
         tRCv0y0UTorDvYQQgmYpDFbVhILGq0RLNjR25E97ldwp3o7YpPwZ9NGcRT3Dzd9Hfy34
         Eykfoq+yBWQoOk+bXTSeOmXHQINWE21HPyydxoO9OEg54m26yJsiPGvJAt2/pfPFUGIG
         zAIQ==
X-Gm-Message-State: ACgBeo1GV4qy8YU1lmo3EbxqaG2GPfcKRdhIZIany+B0x6fJ51yYaxPC
        LsqU82lXHLdvWSCaN616dRTMTTEHTrljrtWozPQ=
X-Google-Smtp-Source: AA6agR4QxgDdktn2ZYSf8KdAxCno48xFhw0M2iDD0dOIyCXNsC4KZG/LjTAfmxRn2n+0D7uIhzyYnL5YSjl2/vAA44E=
X-Received: by 2002:ae9:e311:0:b0:6ba:e711:fb27 with SMTP id
 v17-20020ae9e311000000b006bae711fb27mr305631qkf.320.1661363137961; Wed, 24
 Aug 2022 10:45:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220824012624.2826445-1-yury.norov@gmail.com>
 <20220824012624.2826445-2-yury.norov@gmail.com> <CAHp75VcB08oTrB8R9Zyo4Ja=c_XqybqdCw46fY4_MNqvSSCtLQ@mail.gmail.com>
 <YwYlWjlWO3fFrtQp@yury-laptop>
In-Reply-To: <YwYlWjlWO3fFrtQp@yury-laptop>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 24 Aug 2022 20:45:01 +0300
Message-ID: <CAHp75VfrA7S033=mKkUj-SnWWyM9pwEiM_Umrrd4arpf1SNw6Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] lib/find_bit: introduce FIND_FIRST_BIT() macro
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Dennis Zhou <dennis@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexey Klimov <aklimov@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Whitcroft <apw@canonical.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 4:19 PM Yury Norov <yury.norov@gmail.com> wrote:
> On Wed, Aug 24, 2022 at 12:10:02PM +0300, Andy Shevchenko wrote:
> > On Wed, Aug 24, 2022 at 4:51 AM Yury Norov <yury.norov@gmail.com> wrote:

...

> > > +#define FIND_FIRST_BIT(EXPRESSION, size)                                       \
> > > +({                                                                             \
> > > +       unsigned long idx, val, sz = (size);                                    \
> > > +                                                                               \
> > > +       for (idx = 0; idx * BITS_PER_LONG < sz; idx++) {                        \
> >
> > I think we can do slightly better:
> >
> > for (unsigned long idx = 0; idx < sz; idx += BITS_PER_LONG) {
> >   unsigned long val;
>
> This will blow up the EXPRESSION. We can mitigate it on user side:

I'm not sure I understand how EXPRESSION is involved in all this. What
I proposed is to replace the for-loop one-by-one to
one-by-BITS_PER_LONG. But okay, I have re-read the above patch and now
I see what you are doing, basically you use internal variables of the
macro in the EXPRESSION. Hmm...

-- 
With Best Regards,
Andy Shevchenko
