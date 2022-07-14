Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD7315740CD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 03:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbiGNBIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 21:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbiGNBIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 21:08:35 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E6CDFF;
        Wed, 13 Jul 2022 18:08:33 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id o5-20020a17090a3d4500b001ef76490983so882446pjf.2;
        Wed, 13 Jul 2022 18:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UqrddPa7B1xjzhJhO0J8la6bxwPd05VQ0KH+5kAgy7k=;
        b=Gg6hPigeI28/Nz8Tgupc1gPKfxBuZE/HW3NjdQdE5rxwDE7Pd2F4ZHtbf4aGTXE7oI
         qe0B7x9kgHxYqAqO0r1UCG1BVbe4QbBHExm3bbBQfF3JlaoYvhILVQkhuSJ0J7403uCe
         q++65HSXvRbliZLG7McB4VpNl1YDJ+kwtQR4RqbvQQca4249BZ1EL4zyN93dNZEWkvyu
         bwvdDNmAw5aUckdZjzwgtMpXt/76X+Li7P969Cu2Z3fEdOlry9RvF46NVmX8T9X2o0UY
         E/AS+c1WHLf/19v9Vvdu0fy6Zq6tBzG4Zz19ackdtjvm/aJKbxPrIqYseBQnnSRR65GM
         crrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UqrddPa7B1xjzhJhO0J8la6bxwPd05VQ0KH+5kAgy7k=;
        b=xCx9VNHO1ddyR6vUxiciHIsqepC/MGRIH6WEJJKlQkYN5APa3DFDbz4zLlK8/ogFo3
         pO3cC5isypM+JdzK7kvF0lLTUah8RV6AzY3nHxd9HVbpDjx7eLrL0n6PPRev/Yx3FRZr
         rW3Uf2Qe/u8nw6xV6RTVZzSyLvcSWS1955S9XZgS11GkLffoc5iHwPOVq+6lj6/QrwIL
         aaahJ1b5dDrelJ6dR92JiGFnDDN6btCeL8TnubE2+ol2cZz2MPPDgFkAOldvcDRyxQHD
         j8t9A4PGEi0sagYZFqq/z/6kmP4H3i/voY0Xk8/iCKkGPiLfluWI3m3S92IkLDWKrbfL
         vjgQ==
X-Gm-Message-State: AJIora+ZHzf4C6O3QitA8mTNEPipRDAQesiY+eNylPDpzBlQuQkI4+vY
        QJFM+Pl6riDlMvR4qmKWsdk=
X-Google-Smtp-Source: AGRyM1tR9vgkY7loI1d1UGEqiRNYuCWfBaS9O/zy3jW+g2oT9rJm2qmBAEEX2PHHPLWGiIO/UkkrpQ==
X-Received: by 2002:a17:902:f606:b0:168:ecca:44e with SMTP id n6-20020a170902f60600b00168ecca044emr5661281plg.144.1657760913366;
        Wed, 13 Jul 2022 18:08:33 -0700 (PDT)
Received: from sol (110-174-58-111.static.tpgi.com.au. [110.174.58.111])
        by smtp.gmail.com with ESMTPSA id v6-20020a1709029a0600b0016be834d54asm38983plp.306.2022.07.13.18.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 18:08:32 -0700 (PDT)
Date:   Thu, 14 Jul 2022 09:08:27 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dipen Patel <dipenp@nvidia.com>
Subject: Re: [PATCH 6/6] gpiolib: cdev: compile out HTE unless CONFIG_HTE
 selected
Message-ID: <20220714010827.GA45880@sol>
References: <20220713013721.68879-1-warthog618@gmail.com>
 <20220713013721.68879-7-warthog618@gmail.com>
 <CAHp75Vd7je7U7qsoFDz+2jcNkwCzJHJOadsaSNwk6xD2_vgdpA@mail.gmail.com>
 <20220713103014.GC113115@sol>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220713103014.GC113115@sol>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 06:30:14PM +0800, Kent Gibson wrote:
> On Wed, Jul 13, 2022 at 12:03:07PM +0200, Andy Shevchenko wrote:
> > On Wed, Jul 13, 2022 at 3:39 AM Kent Gibson <warthog618@gmail.com> wrote:
> > >
> > > The majority of builds do not include HTE, so compile out hte
> > > functionality unless CONFIG_HTE is selected.
> > 
> > ...
> > 
> > > +#ifdef CONFIG_HTE
> > >         /*
> > >          * -- hte specific fields --
> > >          */
> > 
> > Now this comment seems useless to me and it takes 3 LoCs.
> > 
> > ...
> > 
> > > +       else if (IS_ENABLED(CONFIG_HTE) &&
> > > +                (test_bit(FLAG_EVENT_CLOCK_HTE, &line->desc->flags)))
> > 
> > Too many parentheses.
> > 
> > ...
> > 
> > > +               if (!IS_ENABLED(CONFIG_HTE) ||
> > > +                   !test_bit(FLAG_EVENT_CLOCK_HTE, &line->desc->flags)) {
> > 
> > if (!(x && y)) ?
> > 
> > ...
> > 
> > > +       if (!IS_ENABLED(CONFIG_HTE) &&
> > > +           (flags & GPIO_V2_LINE_FLAG_EVENT_CLOCK_HTE))
> > > +               return -EOPNOTSUPP;
> > 
> > Ditto for consistency?
> > 

On second thought, that last one becomes:

	if (!(IS_ENABLED(CONFIG_HTE) ||
	      !(flags & GPIO_V2_LINE_FLAG_EVENT_CLOCK_HTE))
		return -EOPNOTSUPP;

which is MUCH less readable, so I'll leave that one as is.

Cheers,
Kent.

