Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530A55521CA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 18:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243696AbiFTQDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 12:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiFTQDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 12:03:13 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917ED55B7;
        Mon, 20 Jun 2022 09:03:12 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id es26so14057666edb.4;
        Mon, 20 Jun 2022 09:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y87tteo65fPwP2KFKjtu1f8D6jluauyBet2xHwdc9hM=;
        b=VR3IMy6yFhkhF+Q30NdfXuDFk3tjHrqKWSO+wnLWXXxkIfXXClXX9moyzub2GN2nJz
         pUSCytPYZ12S+zqdkDFpO/wGdif8G9wzbRgutHvGAo44/Fymw9ZIZGW7aUBnhuVONkmQ
         N7W0XZJbzUypzqXEFLlb3mDVJtN933rbP+lGPYU+hs+izpOwqw6tXx1IFohl427Xo8eI
         zc91bUn3sQK/OClztUyOH5uz65T/VzkXZhWCgCSQ1a37JWUUISw50xYTb1LPSGU8XNGW
         246gVosXHJbvwznd00lpEScKmt+lsisGS3L8tKKcOYovyVDHcvXDDce0e/1QxXvUV6H2
         409Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y87tteo65fPwP2KFKjtu1f8D6jluauyBet2xHwdc9hM=;
        b=tFX7g59SuhAprzzoK5ZOKFSa7HaORzNoadaw6GVC8b5ROHP1rT8ORn8NIvA1BNdYxm
         2mYwLchlJdPnN3UdtrXb5tfd7H3ZIKdXmtsPiUescYz60mQVck0M7p83B+aOFIeTjMIA
         KCOJtD0LhzL47hX9fI2pBbMGZ4wFsGla1h2h2T0Iec9JSubmJZDre7RwD9vnCnG9QJBa
         fB2/YSKGhrqqFXVtS3PhrAZjE2+uRTKYKuO9HHtSFi3zVyViX7IjdjN0+NNrnZW7umR7
         pG2xeP5cw5g0MWpWPWYniuiAX63CB+wkEXwtbtPqJBiUWBS+lq2UEKVQxLkwrT+m9I0a
         ap2w==
X-Gm-Message-State: AJIora+BNoWFRR3QTolrNWOGgWh2x1W5f/Hn1Zi51tvymcphGCHdP3uF
        ona9tB5+KGllUf/lMtgP/JBpdDR8UD9a1jfcMmk=
X-Google-Smtp-Source: AGRyM1sPd0yc0qBXEGBRSSGH98qQAXbevPA3SWgu7Rg29DcdeRsUnYNbYNOVihlJ4XvBCDoajC5mrLHwD0cfMGzcvsI=
X-Received: by 2002:a05:6402:4390:b0:42e:b7e:e9ac with SMTP id
 o16-20020a056402439000b0042e0b7ee9acmr30648861edc.97.1655740991082; Mon, 20
 Jun 2022 09:03:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220307141955.28040-1-alifer.m@variscite.com>
 <CAHp75Vf=vQd5-PGPu3Pcx9bhKSfhdnYDOSOmZKQZQ+bxVkpmYg@mail.gmail.com> <AM6PR08MB4376058D3FFB4139E9292EE8FFB09@AM6PR08MB4376.eurprd08.prod.outlook.com>
In-Reply-To: <AM6PR08MB4376058D3FFB4139E9292EE8FFB09@AM6PR08MB4376.eurprd08.prod.outlook.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 20 Jun 2022 18:02:34 +0200
Message-ID: <CAHp75VdDDhMgQ_oiHGA1m8TQmP+F6neT_KG=UKqsEe9P96HbHw@mail.gmail.com>
Subject: Re: [PATCH] driver: pca953x: avoid error message when resuming
To:     Pierluigi Passaro <pierluigi.p@variscite.com>,
        Wolfram Sang <wsa@kernel.org>
Cc:     Alifer Willians de Moraes <alifer.m@variscite.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Eran Matityahu <eran.m@variscite.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Francesco Ferraro <francesco.f@variscite.com>
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

On Mon, Jun 20, 2022 at 4:18 PM Pierluigi Passaro
<pierluigi.p@variscite.com> wrote:

...

> > > Avoids the error messages "pca953x 1-0020: failed reading register"
> > > when resuming from suspend using gpio-key attached to pca9534.
> > Thanks for your report and fix. My comments below.
> > First of all, how many of them do you get and why is it a problem?
>
> The number of occurrences depends on the time required to I2C bus to fully wake-up.
> It's not a real problem, but the message may lead to think about a real I2C problem.

Wolfram, do we have any mechanisms that guarantees that I2C traffic is
not going on a semi-woken up host controller?

Writing this, I'm in doubt this patch is a fix we want. Wouldn't it
just hide the real issue with some resume ordering?

...

> > > +       int is_in_suspend;
> > Usually we call it is_suspended or so, check existing code by `git
> > grep ...`. And it can be boolean.
>
> Do you mean soomething like in drivers/gpio/gpio-omap.c ?

I believe almost any from the list `git grep -nl -w is_suspended` will suffice.

-- 
With Best Regards,
Andy Shevchenko
