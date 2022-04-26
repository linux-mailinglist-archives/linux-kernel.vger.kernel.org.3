Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8603350FB14
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 12:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349503AbiDZKlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 06:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350157AbiDZKkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 06:40:12 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9D91EACA;
        Tue, 26 Apr 2022 03:30:00 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id d6so16661700ede.8;
        Tue, 26 Apr 2022 03:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LTZivMFTyarowtjvZsLmSz53sJ8fua2clE9JO0AViWw=;
        b=lIWdCje29PhrXiG84AYK/fAkTPVO9Xz9g253ZCUUK+Hp/vIVJWHpPBpQpxQjt53gHx
         iN+KMl6ALYRKvPaDySuc4UsI6ga0mWS7yUdyy3ioev1B1rCpklQalOH4hpN+xw235Odq
         qzwYQ7nm2RsS9J7KXnbza27TlkAtGModTyAulsIPkqvbYSkvBb3fbZQZ3fnhx9Qkmy8S
         F81bBmzpgV9G7Lwiy9JYs+Y8XG0guJEYp+64sAyPjuXHfXh2wTY7MBybgQ0OywzWM/tv
         e5UWhtV2yShw2LYoY5EqceFDrdtWuU99L2ButNyqfdos3WS80fS9s6oh7C8WYyf1TfOx
         h3hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LTZivMFTyarowtjvZsLmSz53sJ8fua2clE9JO0AViWw=;
        b=Y4rUzz6Qm+PXSMGPPNW/EbHu9RjKxoxQZZI0N0zcrRq65LyeM8QMCO2ehxg8E0abSO
         LQ/cXxFYJZTQnJq4lB/yJurcLiA4FwtDgHAlmtFTnwJ3dry2LxOITCFqCijR2RPJz1lW
         c1n/1ct2UwJsOMvbpry3hs0DFGZkZLv21qzfa9FXXvo22hLp/HakVibmuTbLwJ1mwzFu
         B7wuezyhaF1h7aoAUcglvt55sM5rRxQHjhPbByxe2YP5NnhVE+YzoZ7BhQfF+k11DdBK
         vaKuojAdTrSDH/pfiYJHKcER+nnz3hRNvgqmJmDFLJOjg2nUhMQlESOyYwD8wdj0ECh8
         RfNQ==
X-Gm-Message-State: AOAM530tAW/tFVu3xn+XNRjfsvDq4+1Xz/l8WU32iKTlnHAeRW7pNqhs
        TCY2fd/tLnwbgTUmf5p3UGumOMGRgXYs411McDw=
X-Google-Smtp-Source: ABdhPJyDzGgT65bNt9vthGlanF7wSx2um9g1nmHGK2QB5fZUPfxvE2f7p5FkhAVNQhWvys1clS4g3RswY5rO293PZcM=
X-Received: by 2002:aa7:d350:0:b0:425:e029:da56 with SMTP id
 m16-20020aa7d350000000b00425e029da56mr12360614edr.296.1650968999090; Tue, 26
 Apr 2022 03:29:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220414190242.22178-1-andriy.shevchenko@linux.intel.com>
 <20220414190242.22178-2-andriy.shevchenko@linux.intel.com> <CAMRc=MfE0othcfwETf13_K3sOLKmUGwCnjapzVjLMk1cD+ihVQ@mail.gmail.com>
In-Reply-To: <CAMRc=MfE0othcfwETf13_K3sOLKmUGwCnjapzVjLMk1cD+ihVQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 26 Apr 2022 12:29:20 +0200
Message-ID: <CAHp75VcpZPB12Y4FVN4h9RdkvYQfELtbRnd08FfPpG1cJG-99g@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] gpiolib: Introduce a helper to get first GPIO
 controller node
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic <linux-amlogic@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 12:27 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> On Thu, Apr 14, 2022 at 9:02 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > Introduce a helper to get first GPIO controller node which drivers
> > may want to use.

> > +static inline struct fwnode_handle *gpiochip_node_get_first(struct device *dev)
> > +{
> > +       struct fwnode_handle *fwnode;
> > +
> > +       for_each_gpiochip_node(dev, fwnode)
> > +               return fwnode;
> > +
> > +       return NULL;
> > +}
> > +
> >  #endif /* __LINUX_GPIO_DRIVER_H */
> > --
> > 2.35.1
> >
>
> Any chance you could name it get_first_gpiochip_node()? It's static so
> we don't have to worry about the prefix and it would make the purpose
> more clear.

There are two things why I prefer it as is:
1) it's static inline, so it's part of (internal) but still exported API;
2) it's already in my for-next branch which I would like not to
rebase, until it's a really serious issue.

That said, if you still insist I can rename it.

-- 
With Best Regards,
Andy Shevchenko
