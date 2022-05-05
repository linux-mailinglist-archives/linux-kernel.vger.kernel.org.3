Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18CEB51C034
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 15:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378937AbiEENJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 09:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378845AbiEENJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 09:09:44 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A8750B0A
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 06:06:05 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id b24so5118273edu.10
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 06:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mL7w0UMKorZQ2g0L1DfCw6LR3UMP76ttTU+pAi6oLp8=;
        b=thkq/Oe9nJNhuWKKyXJioTRuksejdS4P/kXbCrE43AhgzOgACtL3WlfvieNBmQqQ+G
         MffenwvYyEE/lyM6o5nlmL6cqoqXf2JLlV9Pqf59ZwhnlRsg0EEZAaaBRwGtqynW9/3D
         7nIMP/GeOSzcRkEGfmLrPzxr2OcLJtnZshwKErO0/B8ah6A/IhRVB6dZWKeScY8dMPNX
         1zRNKzTFQ3NxyxG0Zh62W3IcJeUkNoLDAuqfKXM0K2J815M+nocKNHapidlHY7FPLyw5
         7z83NA03x9UBBjVvstLDBu+6qQ3ESO9XqXHwoTHF7FFaDJCJY/e8q6BySCbLEWHt85VA
         eiBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mL7w0UMKorZQ2g0L1DfCw6LR3UMP76ttTU+pAi6oLp8=;
        b=ZgvJyZbKj7s5Axg+6pe8FuN/19kO3UC1PgD7V+hImox6t5Kc0QfuUUOZwHwAs12n54
         7y3mghtuL8I4IiHBgFL/ForLo9bzcswycz+naPmm1mgKJ7WKcfqVq4SKy8Jv4x7dv+dc
         ZdDs/JGztJYURIFOEK4cyJFGgElBZx0u/BbKCOnZ6kO26tHZ92WLx5xwkILkPC2yX2o2
         84R0flWjhubtJLAG2rZ4L/IiVXJRo1fKyBqcuTa/tDoU4x8zQdQta6hR6t23c/hlOver
         Da7R+mtCwapNqWmwqFAJn8jm6ejhBR0RF7v0S+UP7vIgGSoYmVkN2sUoL2tKSq2wVwql
         dl+Q==
X-Gm-Message-State: AOAM532q3heDBNT6csaO3KcgoDZbmYUcqAxDQFQf1RUWbV0YJmRUrMOq
        whisMLpBErgtJRaFdq1VH88pLi3mnC0o9mB3oDv4pQ==
X-Google-Smtp-Source: ABdhPJxr7BHz9MN/SywvgtY21Ie07p3CIeurjYtmb7zi7rCM463OgbWz+0yWrSPh0S+WrcPNGwAj+sr6dUi1BvovgpY=
X-Received: by 2002:a05:6402:5286:b0:425:f0fb:5d23 with SMTP id
 en6-20020a056402528600b00425f0fb5d23mr29314171edb.243.1651755963620; Thu, 05
 May 2022 06:06:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220414190242.22178-1-andriy.shevchenko@linux.intel.com>
 <20220414190242.22178-2-andriy.shevchenko@linux.intel.com>
 <CAMRc=MfE0othcfwETf13_K3sOLKmUGwCnjapzVjLMk1cD+ihVQ@mail.gmail.com> <CAHp75VcpZPB12Y4FVN4h9RdkvYQfELtbRnd08FfPpG1cJG-99g@mail.gmail.com>
In-Reply-To: <CAHp75VcpZPB12Y4FVN4h9RdkvYQfELtbRnd08FfPpG1cJG-99g@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 5 May 2022 15:05:52 +0200
Message-ID: <CAMRc=Mef77ejvzx2Pg1P_xzozxb1VjxGtArfvFdS=Cgq-8Mbwg@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] gpiolib: Introduce a helper to get first GPIO
 controller node
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 12:29 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Tue, Apr 26, 2022 at 12:27 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> >
> > On Thu, Apr 14, 2022 at 9:02 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > Introduce a helper to get first GPIO controller node which drivers
> > > may want to use.
>
> > > +static inline struct fwnode_handle *gpiochip_node_get_first(struct device *dev)
> > > +{
> > > +       struct fwnode_handle *fwnode;
> > > +
> > > +       for_each_gpiochip_node(dev, fwnode)
> > > +               return fwnode;
> > > +
> > > +       return NULL;
> > > +}
> > > +
> > >  #endif /* __LINUX_GPIO_DRIVER_H */
> > > --
> > > 2.35.1
> > >
> >
> > Any chance you could name it get_first_gpiochip_node()? It's static so
> > we don't have to worry about the prefix and it would make the purpose
> > more clear.
>
> There are two things why I prefer it as is:
> 1) it's static inline, so it's part of (internal) but still exported API;
> 2) it's already in my for-next branch which I would like not to
> rebase, until it's a really serious issue.
>
> That said, if you still insist I can rename it.

No that's fine and I also pulled that into my tree.

Bart
