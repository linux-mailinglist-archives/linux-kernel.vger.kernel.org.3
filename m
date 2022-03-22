Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF23E4E4272
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 16:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235562AbiCVPBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 11:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234293AbiCVPBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 11:01:40 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE55F21261;
        Tue, 22 Mar 2022 08:00:12 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id o10so18037534ejd.1;
        Tue, 22 Mar 2022 08:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YhviSAwIOjDzR1pqsOvpQJHGJWDCBzWFuU7RfFuBx0s=;
        b=c9uPSeUFlfwX4VnQPHCJ9oSLDBor7yewdIOCVdR+P3j+W1KYCIWj15Z9stH99ctXUz
         /SvmObLwMq24Z3an/yek7eVoyVXO++9eMhdE8T6JtaVQhb0H1ZFYMskiNX3HM9+rzjcf
         1Kun1durU38YIadTfqioojbXvDibEmpyenwxc7L8fA5BQg855mEPOTabLhCtclsLpGzW
         7AUi1TD4KeqPfccj0VP6vecMQJ5lHuAdVjgeTB7l9LnMkcoQoBgnunQSIZqdo4STB62v
         k4QtQhogwRo5cVAJBhycV5PZ1iS5l6pQb5h7li2loFCjl03cebIlXPgQhp0CP/FLIjNm
         EzMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YhviSAwIOjDzR1pqsOvpQJHGJWDCBzWFuU7RfFuBx0s=;
        b=SLimKgAOzHcH87HmxS3RXu2dObMcnFbjo9fan9dPdv2u4b8CSB6GttrszG0cqXDqj5
         RWaYEJd/HmILP7bhupL+/cHVgtnC+N7GUZKA0+yWk/zTqJ30CjS6hM0lc7HwrhdkZdzT
         BLeyI8quRlyxXuHkaiNqKBhRS8s2/1ZpXyHk5wfYcpWGKL4GfrbnDxG3uzt+3ZoNZ7ix
         MIqipd8gxLcAeFQJTkE1l8Xo8ryJP693u5xfOUoTs91O5A/1vjjIMcjOqoxzoDawnZlr
         ALLA3B3Zpxnra/49/LgylqvWYiLv1/TyWYu1LzjXBndOerQH+PiUxaOEE/fFT48MYQuN
         jnZQ==
X-Gm-Message-State: AOAM533Av6Ekvk7na+u3CPqPAmoX2tkeaxVXWLuIP37bv/ykEYlLKpG/
        VT1cFnjySWC2pR7ol9jw/Ig7QdfQLF5u6LQYPOc=
X-Google-Smtp-Source: ABdhPJyBqK8CWpqnB9cefn5/xns9b1gRQMPRstpn/ic6+aoexanuW6ErOMtcz2f3Tsfx0eljmfeuak3BYUw44rnJO8E=
X-Received: by 2002:a17:906:4cc7:b0:6d0:7efb:49f with SMTP id
 q7-20020a1709064cc700b006d07efb049fmr26100969ejt.639.1647961211065; Tue, 22
 Mar 2022 08:00:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220310150905.1.Ie0a005d7a763d501e03b7abe8ee968ca99d23282@changeid>
 <CAHp75Vfbs6sPsrjwxNWLZQu=pEoar2K5sY=fX9a7KkOe=mwsZw@mail.gmail.com> <CAMRc=Mc_bw40uY68jcPYR-Lwe-qLcxmQeZO47WrexZtSiE_M5Q@mail.gmail.com>
In-Reply-To: <CAMRc=Mc_bw40uY68jcPYR-Lwe-qLcxmQeZO47WrexZtSiE_M5Q@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 22 Mar 2022 16:59:01 +0200
Message-ID: <CAHp75VcK0JDkTXuPc2N8G+OotXK0mqfQn7i4nDqXDODe1SqcrQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: Drop CONFIG_DEBUG_GPIO
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Brian Norris <briannorris@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Jianqun Xu <jay.xu@rock-chips.com>,
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

On Tue, Mar 22, 2022 at 4:49 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> On Tue, Mar 22, 2022 at 3:38 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Fri, Mar 11, 2022 at 4:55 AM Brian Norris <briannorris@chromium.org> wrote:
> >
> > ...
> >
> > > Description: it says nothing about enabling extra printk()s. But -DDEBUG
> > > does just that; it turns on every dev_dbg()/pr_debug() that would
> > > otherwise be silent.
> >
> > Which is what some and I are using a lot during development.
> >
>
> AFAIK this: https://www.kernel.org/doc/local/pr_debug.txt is the right
> way to do it?

Yes. But it means we need to have a separate option on a per driver
(or group of drivers) basis. I don't think it's a good idea right now.

> https://www.kernel.org/doc/local/pr_debug.txt
>
> This doesn't mention adding Kconfig options just to enable debug messages.
>
> > ...
> >
> > > -ccflags-$(CONFIG_DEBUG_GPIO)   += -DDEBUG
> > > -
> >
> > NAK to this change.
> >
> > I'm not against enabling might_sleep() unconditionally.
> >
>
> These are already controlled by CONFIG_DEBUG_ATOMIC_SLEEP, no? Or
> maybe I can't parse that double negation.

The part of the patch that converts might_sleep_if():s is fine with me.

-- 
With Best Regards,
Andy Shevchenko
