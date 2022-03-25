Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384294E720B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 12:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354358AbiCYLMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 07:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349575AbiCYLMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 07:12:20 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB23CD31A;
        Fri, 25 Mar 2022 04:10:46 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id r23so8861663edb.0;
        Fri, 25 Mar 2022 04:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FSiOOkU7sO5vji/trWKQvNHznIcArcS/Lftm+0xLgLo=;
        b=o4L6GV2hYjYJc6uJsu9XIm4VrSaBgEV2MOCycio7rJtxTUrHBfU2YAlcGNOVWCTtPw
         dOq0zuqUYIFNM2578cqd8XgxJ7xjgbhlyhfAcM/K8gwKMESlkoIp3CiM1n25GrbgDYgw
         tgf69Z4PQMvvHmiEky/DJN6S73ANugEdEWgIAoxCH7bVyW0NJR6UR3ZqWlaragZE+1WR
         5i0NM7fb4bp2R+zSGCWNxSDCgusretpHgWzXqUZWYe3roNnosrmbmlcAJNlsksDwIme1
         Qg57Ru8fbHN1JcWX240P0zcXlIuYvxDK8L3metIY1DoFYIZuXShd5LfTjTFmTn5IuH8o
         Kt7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FSiOOkU7sO5vji/trWKQvNHznIcArcS/Lftm+0xLgLo=;
        b=IKCOeM2cxOw21XLKOzHXrO3NSVZRjLXZzlFwnF0occT5ilfj2gClQhSjjwIKQsvilX
         K4/qTVS78XU0JcV6Hqot7WVlaD4lL2YY94qhqFNvatWX0BR9/FKuH8QmgbRopMftXXaS
         lrxqi4JHB7NwMNie5LGnsyprrz/p7VpJMSmmmWbA0qJUG8BBRYjjT+RC418n0Vs014Lo
         r11eSifoIqhr3yhXbEvfuGk6S0E9IOorjyNePfHsrEdGlWAzz75dm4xvbwxgaFWg5MgF
         STTfW1hiKbeq97v5cHtsf2vrDXJTcR83KFhvAxgXO1lSePV3xDY1HOiHkL8ea03V9Htl
         nuSg==
X-Gm-Message-State: AOAM5328Z3aQtkOBhxbajL05YXyRbYpZ7zuKEBsE0VXhancDssqLW7A0
        Qrccnvf00OoNpvK1mX6V3l2lmg7VNZuzPn+otjk=
X-Google-Smtp-Source: ABdhPJzWVEYhbVKfTJQgWSG/god4eGB6i4CUGRgQM61GnznP0+dVgdJfwE9zM4qj0pnx4TeMx8rmF9IjyYSOVyorjyI=
X-Received: by 2002:aa7:d1ce:0:b0:419:19ed:725a with SMTP id
 g14-20020aa7d1ce000000b0041919ed725amr12443160edp.270.1648206645126; Fri, 25
 Mar 2022 04:10:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220323140215.2568-1-andriy.shevchenko@linux.intel.com>
 <YjtNJe4Pgp3WIwOa@sirena.org.uk> <YjtXbDyCWZxKnf4Y@smile.fi.intel.com>
 <YjtvsYs+x3LRaLVP@sirena.org.uk> <Yjw4yjgordnSo+7M@smile.fi.intel.com> <YjyAFNYpDjSQnIN1@sirena.org.uk>
In-Reply-To: <YjyAFNYpDjSQnIN1@sirena.org.uk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 25 Mar 2022 13:09:36 +0200
Message-ID: <CAHp75VdFjYepcQ82e4WgNP2nQMk6O_xOALkG1yHxWPbYuHTXHA@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] spidev: Do not use atomic bit operations when
 allocating minor
To:     Mark Brown <broonie@kernel.org>, Yury Norov <yury.norov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Thu, Mar 24, 2022 at 10:48 PM Mark Brown <broonie@kernel.org> wrote:
> On Thu, Mar 24, 2022 at 11:24:26AM +0200, Andy Shevchenko wrote:
> > On Wed, Mar 23, 2022 at 07:06:25PM +0000, Mark Brown wrote:
>
> > > Yes, it's not needed but what meaningful harm does it do?
>
> > There are basically two points:
>
> > 1) in one driver the additional lock may not be influential, but
> >    if many drivers will do the same, it will block CPUs for no
> >    purpose;
>
> > 2) derived from the above, if one copies'n'pastes the code, esp.
> >    using spin locks, it may become an unneeded code and performance
> >    degradation.
>
> I think if these are serious issues they need to be addressed in the API
> so that code doing the fancy unlocked stuff that needs atomicity is the
> code that has the __ and looks like it's doing something tricky and
> peering into internals.

I believe the issue you mainly pointed out is the __ in the name of
the APIs, since it's case by case when you need one or the other. In
case of spidev we need non-atomic versions, in case of, e.g.,
drivers/dma/dw/core.c we need atomic, because spin locks used there do
not (and IIRC may not) cover some cases where the bit operations are
used against same bitmap.

Perhaps we might add the aliases as clear_bit_nonatomic() et al. Yury,
what do you think?

-- 
With Best Regards,
Andy Shevchenko
