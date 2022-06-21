Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8272E553070
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 13:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348725AbiFULGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 07:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348730AbiFULGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 07:06:50 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77AEF29C8D;
        Tue, 21 Jun 2022 04:06:49 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id m14so12199846plg.5;
        Tue, 21 Jun 2022 04:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H3pfG6ncEe8j2NTCEWsSik6FNJ+rzYtpJd/lCG81Lbo=;
        b=ouX9z8GWqIHqXlaWOwE1dVudTSH6cFc1fNrG7Li0J1puaUb7wVVUPYVDBTY/kuyd4+
         Q8pF6R+fA87fOA90C2fhmeoGWnzk3HUa2ZiJfkCrjYKHPSwsyLYfyYC+c6nAwGc69FnP
         ErjXlh3Y0+xltLGQCno8htwE7WU8AH0pQinElhBxZQlaxZxqn/fxF4SvefKVjVNziqsS
         GzSLLF5n79kTDsEZxRr4zBgZAhMHSEHvMQ4UyWcqBCsZrrZqfyjmJMMA77qo6F6zD6ZV
         R2Fecb6UL25DKZ+y5u62FHWFFXOH5ma0cT9FmYI6GmIebpkQhfe+nBiBt3B2jMNN6yRm
         0a5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H3pfG6ncEe8j2NTCEWsSik6FNJ+rzYtpJd/lCG81Lbo=;
        b=CPE/bLXCGqSiHK4szpJKLAOKlGNO0gaIjJ/uZCFuLn4xxr1Zg9DjXnJbyJ+DuQDXqM
         /44uTgpRFNjiSc3ym5DOKdKfs4SBcWr6kKA35LBKVR66ak+8RyB/EhWuRVxiL53LS4dc
         kZKsxPYd5YJx+6RMQ3ZQvxGUXeib6TiV3rIbGduknH6uhduWOU+eEGz+JX0XWKt+ffHs
         m8UaEp+G6+FrYuICDoFU9V7jXVz0wOjg/v5kLIByI7oHDooFXCjMU6H2VBCjKQ6fYXq+
         09ofn/tC2x7CPfnBYLB+iFxJ2Y8EBx2LsOG97eQsCZP6dit9QqUgvco4aoMnvwV6o5oR
         /AMQ==
X-Gm-Message-State: AJIora9Vpw2iK3R55yjnuDolOiMAUphGGXP/5Sq91LiK951+yHjKD6v0
        Q0IaL2uzFnSP9tCSF5YY2JIHSZHFQxDS+wAnzcA=
X-Google-Smtp-Source: AGRyM1sTjOpxo2C2vfqRljcbd17pUJjXAD3TJr+qNCGzo3TdVe3655/70aO2UNa7g0KbrhEZDsIa32jybAhpzjlQo8A=
X-Received: by 2002:a17:90a:cb84:b0:1ea:ffd2:3075 with SMTP id
 a4-20020a17090acb8400b001eaffd23075mr28581043pju.106.1655809608927; Tue, 21
 Jun 2022 04:06:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220530173324.921-1-andriy.shevchenko@linux.intel.com>
 <CAOMZO5CtjkjsbOTaNF7+Hwswsn-fs2WNK=zyFL53JnBBpS8=0Q@mail.gmail.com> <YrGkSMUsMzTqBEJz@smile.fi.intel.com>
In-Reply-To: <YrGkSMUsMzTqBEJz@smile.fi.intel.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 21 Jun 2022 08:06:37 -0300
Message-ID: <CAOMZO5AKecF1c+FqucgQM0+xkuk9MAE_YdSQ3pAf73f5wO4JEA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] iio: adc: mxs-lradc-adc: Get rid of OF specifics
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        Marek Vasut <marex@denx.de>, linux-iio@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>
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

Hi Andy,

On Tue, Jun 21, 2022 at 8:00 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Jun 20, 2022 at 06:13:53PM -0300, Fabio Estevam wrote:
> > On Mon, May 30, 2022 at 2:33 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
>
> ...
>
> > I tried to apply the same change inside
> > drivers/input/touchscreen/mxs-lradc-ts.c:
> >
> > --- a/drivers/input/touchscreen/mxs-lradc-ts.c
> > +++ b/drivers/input/touchscreen/mxs-lradc-ts.c
> > @@ -675,11 +675,9 @@ static int mxs_lradc_ts_probe(struct platform_device *pdev)
> >                 if (irq < 0)
> >                         return irq;
> >
> > -               virq = irq_of_parse_and_map(node, irq);
> > -
> >                 mxs_lradc_ts_stop(ts);
> >
> > -               ret = devm_request_irq(dev, virq,
> > +               ret = devm_request_irq(dev, irq,
> >                                        mxs_lradc_ts_handle_irq,
> >                                        0, mxs_lradc_ts_irq_names[i], ts);
> >                 if (ret)
> >
> > but I still get the following warning:
>
> So just to be sure. You got it before the above change applied, correct?

Correct. This warning is an old one. See:
https://lore.kernel.org/all/20200701224145.GA3616172@bjorn-Precision-5520/T/

> I'm wondering how this all LRADC was supposed to work. The IRQs are assigned
> based on abstract numbering without any IRQ domain behind it. This is not how
> it's designed in Linux. Adding Ksenija and Marek to shed a light.
