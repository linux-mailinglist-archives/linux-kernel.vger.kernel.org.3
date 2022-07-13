Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D80057343F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 12:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbiGMKa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 06:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236038AbiGMKaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 06:30:22 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E45FC989;
        Wed, 13 Jul 2022 03:30:20 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id w185so9860993pfb.4;
        Wed, 13 Jul 2022 03:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZlfFL39/OpL1t+nNlUxyQQyjvtZqYGz+VAIcGIn5k7U=;
        b=Tg+JVr0gejtT6Gtt0QalhJ5sXABI5Fo4TmY+SNlaviNZINAV6b0vmpjgeS5UzyMBFd
         P5C5tDmhBJHrbr/lUgWzOoVoLNPXZbMMtYJJvfBYZf3XLxHAdsPkc60FlYsfqBLOc4M5
         28y+Q1rYWI+gdbZHGBHkRN3RB3WuZ3Q8OJ2bh+89OqWydhOHF7p3qqf60YyqR8Kldxpl
         nh3rKBJuSChntx8JQvrkRT6l9Sa/SU5cXKBVNN4HNCn09cVjgPHIPxPYpRadoA59MD0j
         dd5r+g9t75HmXrYmPvjCDoG2rgAfkjy1hZlwlMe5xiJiVU8yy8gWiPnsiZ8mSmdufplo
         Usrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZlfFL39/OpL1t+nNlUxyQQyjvtZqYGz+VAIcGIn5k7U=;
        b=lqKXokatn1TkQIEdGFW5clZdDxHBdM0RAGVOFqH1faEm7QgBUayInVYxMPIlzkAqcw
         MsXBVSSXfurKh2eWDipubLyu3GmqR/C8HBZlIMyzQp+0dgWROmlgKi0920HnjyZv3PyK
         nMod7OxtC7PEKChZO9T69s+SHfOfyx49HHblmKwLwgwaNvL+OlgP7rfGr/6psi8FGBak
         uQ3WbOlGxltlc66WpwlmBo7elYkTQ6s6BI826rEu64x0yjLiTK4vtwmajcvG47TzwFR7
         NGS8cQwMRwnpjmSOHE8tjqeuImqj0s34LeVDxuYJFQQweHQdlEJV6PGv9npcSgRcqm8L
         aIxg==
X-Gm-Message-State: AJIora+sI7ez6wVDiB0Ws0Gfc8n03GGRXwEyrdy24N/RGp+ZtrebV8fs
        Q0maRUf7SQ3MtPybwQLFHq+N3zkAHsM=
X-Google-Smtp-Source: AGRyM1uZwJyvbRdQMh+DANXB9i75JHJcaiqFxe4tp2/f1L+eEhVuTFXKKcn37hBBLaA8lfYhF3693Q==
X-Received: by 2002:a63:5a1e:0:b0:411:f24a:a78 with SMTP id o30-20020a635a1e000000b00411f24a0a78mr2360910pgb.519.1657708219905;
        Wed, 13 Jul 2022 03:30:19 -0700 (PDT)
Received: from sol (110-174-58-111.static.tpgi.com.au. [110.174.58.111])
        by smtp.gmail.com with ESMTPSA id u10-20020a17090341ca00b00163e06e1a99sm8609114ple.120.2022.07.13.03.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 03:30:19 -0700 (PDT)
Date:   Wed, 13 Jul 2022 18:30:14 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dipen Patel <dipenp@nvidia.com>
Subject: Re: [PATCH 6/6] gpiolib: cdev: compile out HTE unless CONFIG_HTE
 selected
Message-ID: <20220713103014.GC113115@sol>
References: <20220713013721.68879-1-warthog618@gmail.com>
 <20220713013721.68879-7-warthog618@gmail.com>
 <CAHp75Vd7je7U7qsoFDz+2jcNkwCzJHJOadsaSNwk6xD2_vgdpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vd7je7U7qsoFDz+2jcNkwCzJHJOadsaSNwk6xD2_vgdpA@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 12:03:07PM +0200, Andy Shevchenko wrote:
> On Wed, Jul 13, 2022 at 3:39 AM Kent Gibson <warthog618@gmail.com> wrote:
> >
> > The majority of builds do not include HTE, so compile out hte
> > functionality unless CONFIG_HTE is selected.
> 
> ...
> 
> > +#ifdef CONFIG_HTE
> >         /*
> >          * -- hte specific fields --
> >          */
> 
> Now this comment seems useless to me and it takes 3 LoCs.
> 
> ...
> 
> > +       else if (IS_ENABLED(CONFIG_HTE) &&
> > +                (test_bit(FLAG_EVENT_CLOCK_HTE, &line->desc->flags)))
> 
> Too many parentheses.
> 
> ...
> 
> > +               if (!IS_ENABLED(CONFIG_HTE) ||
> > +                   !test_bit(FLAG_EVENT_CLOCK_HTE, &line->desc->flags)) {
> 
> if (!(x && y)) ?
> 
> ...
> 
> > +       if (!IS_ENABLED(CONFIG_HTE) &&
> > +           (flags & GPIO_V2_LINE_FLAG_EVENT_CLOCK_HTE))
> > +               return -EOPNOTSUPP;
> 
> Ditto for consistency?
> 

Those all make sense - will do.

Thanks for the prompt review.

Cheers,
Kent.
