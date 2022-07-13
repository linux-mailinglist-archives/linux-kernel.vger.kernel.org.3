Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3582457354F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 13:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236112AbiGMLZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 07:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236101AbiGMLZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 07:25:13 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A905B102717;
        Wed, 13 Jul 2022 04:25:10 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-31cf1adbf92so109195677b3.4;
        Wed, 13 Jul 2022 04:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zVsTRZ+KHVAlZ/Yd1qD9A+kSjJ/bpJiTUJw8KWJXUb4=;
        b=hhUOvCL9G8gIcwEqLsONL+dYxWME5xylW5azzJVe8SIC8Q1Sa15cxrMdYRSaGFexS0
         INQNO/z42XIiWGdHUf0nCSwvbZRAZqiOdn47tD+mibMkIGvp7bbPYb6CoJXHu3eDuT8Z
         3CpeaZZCJyep8zZgLmbym9Q2i5/14I/FUUvpwlpxWQ9bF6VG5vNKJa6GEE1MYzI85wA+
         7r5b0ssghr9NLUUv5bj6Ek2+Hjkp1yMhq7QdDHIIt8gHPX/K4tTi7Fcdl6hWWb2XqWva
         Jg1x82mmspmPjBaowzbxQ8fs+5LP226V1Nj43Yt8iSfjy0b5t1RWnEcFw4C/NB6MPMrJ
         6CJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zVsTRZ+KHVAlZ/Yd1qD9A+kSjJ/bpJiTUJw8KWJXUb4=;
        b=EUuZGeruWqryo8iz4mlj5Ei6AVq6uAQH8kPV6hU6ZBa2eERx/i7O9ovOyP6QiQGGoS
         eVWuI/Eq8RGJZ/WQDPuRLHQVA64pBdmg0VoWyG/ZiRJd0RszzWAytqLOrn5KKmuGLgMI
         bKSBDRVZFQunzQNHzXNJ+Ftaf7/Jf/1lxZvOGpE9Fe1++Xv+htZJx1Q2jdm37pX0zHRo
         r1AsOX8pu6/xNjRNfqSBPN5GXdo97J9ry0srr/DO8zW4a35QtIFhi/TMyo0lDSmi3yr8
         LyakfkJ1mMSpUd1f6VwcuZH9wPUpEqhmFcPaKXpZskCB1b/Whs+qDq/PQGkyUwYx7p5d
         buCQ==
X-Gm-Message-State: AJIora+E1NZXhdQOEUdj11K/lOgLIXdxOvU0Qs6kMiTXKmy/T8o1BykS
        mcoT3luMHqL9IownKOas3pnYasQGrLqlv1ujkrk=
X-Google-Smtp-Source: AGRyM1sHfektbvTGawGrVDTdh8I9O3i+FHUJ6r1+OTP3JFit85WN3rs30yFgZW/AlLHUyKnHox1Xp8I+br72qnAN9ts=
X-Received: by 2002:a81:108f:0:b0:31c:d7ae:9ff1 with SMTP id
 137-20020a81108f000000b0031cd7ae9ff1mr3550642ywq.18.1657711509887; Wed, 13
 Jul 2022 04:25:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220713013721.68879-1-warthog618@gmail.com> <20220713013721.68879-5-warthog618@gmail.com>
 <CAHp75VeRshC3Db8Q2J80fk7=UvLiRymrkoAbuWceOfncfzvr7A@mail.gmail.com> <20220713102710.GB113115@sol>
In-Reply-To: <20220713102710.GB113115@sol>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 13 Jul 2022 13:24:33 +0200
Message-ID: <CAHp75VdL4Zy=1+m5e4gcNUM7uW-q4cfJb1xof3qiQx6ZWsMSPg@mail.gmail.com>
Subject: Re: [PATCH 4/6] gpiolib: cdev: simplify line event identification
To:     Kent Gibson <warthog618@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dipen Patel <dipenp@nvidia.com>
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

On Wed, Jul 13, 2022 at 12:27 PM Kent Gibson <warthog618@gmail.com> wrote:
> On Wed, Jul 13, 2022 at 11:59:10AM +0200, Andy Shevchenko wrote:
> > On Wed, Jul 13, 2022 at 3:39 AM Kent Gibson <warthog618@gmail.com> wrote:

...

> > > +               le.id = level ? GPIO_V2_LINE_EVENT_RISING_EDGE :
> > > +                               GPIO_V2_LINE_EVENT_FALLING_EDGE;
> >
> > It seems several times you are doing the same, perhaps a helper?
>
> If by several times you mean twice, then yeah.
> Not sure that reaches the threshold for a helper though.

Up to you, then!


-- 
With Best Regards,
Andy Shevchenko
