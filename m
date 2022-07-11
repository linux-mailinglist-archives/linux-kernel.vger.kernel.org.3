Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9291A570BD2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 22:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbiGKUb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 16:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbiGKUbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 16:31:36 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92F087354;
        Mon, 11 Jul 2022 13:29:50 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id f73so10592333yba.10;
        Mon, 11 Jul 2022 13:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ShzjEhLEe0k5FQ6GyMvo3z3FN/ZLOq7ZYOFzyB6kD20=;
        b=oIo3c7K7sfGKtX+P9CqNGT20A9gc1caPNVU/ahHOcNlb7iyuOBDC7JAr8+TGCGyYgF
         +2YWKr+UAr+2VNTEdOp0E5ijfyM0Svlzt90iUxi5A3IZReUU+VvaOKc4dZfmzWutTtXW
         BUCJ9j/z4c6RgwfbWluszvZ0+sxeG+8KglLi/ZYVTNPxbQDgvpCisDbvQflmgKVXmKYa
         9WKuXWr7jmVCIjbYRRyb2Vok/JDbMHK4EBPOOcm/+WBbhBXpDqqAD+tGz46P+hklk9Pk
         GERqz9JVe1+01jjuv/hgK/sgmqPZRgZLu1mrMFMGE84OvfIbvDOcLJFL2IBEfuqA/40B
         f7nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ShzjEhLEe0k5FQ6GyMvo3z3FN/ZLOq7ZYOFzyB6kD20=;
        b=UooUyLCg/Cl5vphGNNxj/XlOJUn5ScuQBj0skcVA01KvG8qWXeFficcSd5Lk5vvzqn
         r3N7iA5MqSPxQO7YSMSRuZrOErtgMGOrwy7SMcAtVgYUCahQNxZ6qzEY7LmSznnGhaG0
         uXQ/UJOuQTi9t5pNlCwLRBFU74d8n5VAyJGSgkUqMc+XqlsDf45XaDytJZwp+EMLpfV9
         3C+QHop5k6ATu73ciJIi6ci1Kjwcq7mME/hjz0kLetGPHWifxozTyKLES4y8C+ccElgj
         9swVCOekaLhNeWYkYHIRI0kHqHtW2+vSR0oq0byeRu4oQV5Gl4X1T2TFrhsreNtnuVPm
         Aftg==
X-Gm-Message-State: AJIora9hSiOfNNgTpKUCn2M300crCjBTDcEOoGMdnd+H+fE8TxkKka9d
        gWNQWpjaDXF0WanlK2ZQYfjvrUvFFQGK83Uu5j4=
X-Google-Smtp-Source: AGRyM1vWoRu/kFl3OAas1bDl0jpatlNqpbg+RlHPiqlRykpWGdO7kua3L5SZ0OFZTsKlED0D7rSpkR+VJHg9fCAKE9o=
X-Received: by 2002:a05:6902:1143:b0:66e:eb08:4c23 with SMTP id
 p3-20020a056902114300b0066eeb084c23mr13624745ybu.570.1657571390165; Mon, 11
 Jul 2022 13:29:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220711192113.3522664-1-horatiu.vultur@microchip.com>
 <20220711192113.3522664-3-horatiu.vultur@microchip.com> <CAHp75VdeZSP62qoOdQf=g4b7AheFd4=jNxfjMh-_T7Q1Zi=LbA@mail.gmail.com>
 <20220711202646.om65vrksyifvkfkw@soft-dev3-1.localhost>
In-Reply-To: <20220711202646.om65vrksyifvkfkw@soft-dev3-1.localhost>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 11 Jul 2022 22:29:13 +0200
Message-ID: <CAHp75VeJgUFdFgBpG5avmKCn-CGNOJ6wZAhc0a4f2MHfLbvXmA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] pinctrl: ocelot: Fix pincfg
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        kavyasree.kotagiri@microchip.com,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Colin Foster <colin.foster@in-advantage.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Michael Walle <michael@walle.cc>
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

On Mon, Jul 11, 2022 at 10:23 PM Horatiu Vultur
<horatiu.vultur@microchip.com> wrote:
>
> The 07/11/2022 21:51, Andy Shevchenko wrote:
> >
> > On Mon, Jul 11, 2022 at 9:17 PM Horatiu Vultur
> > <horatiu.vultur@microchip.com> wrote:
> > >
> > > The blamed commit changed to use regmaps instead of __iomem. But it
> > > didn't update the register offsets to be at word offset, so it uses byte
> > > offset.
> > > Another issue with the same commit is that it has a limit of 32 registers
> > > which is incorrect. The sparx5 has 64 while lan966x has 77.
> >
> > ...
> >
> > > -static struct regmap *ocelot_pinctrl_create_pincfg(struct platform_device *pdev)
> > > +static struct regmap *ocelot_pinctrl_create_pincfg(struct ocelot_pinctrl *info,
> > > +                                                  struct platform_device *pdev)
> >
> > const?
> >
> > And I would leave pdev to be the first parameter, if there are no
> > other functions that have them like this.
>
> I will do that in the next version.
> Just for my understanding/knowledge why is this desire to have const or
> to keep the const?

For non-POD types it's a good coding practice to reduce surface of
attack, if any (the data will be located in the pages with RO flag
set, and attempt to write will give you a page fault or other
exception, it depends on architecture).
Also a common sense, if you don't change data (which is actually
initial configuration or so), then why shouldn't you use const?
Note, in cases when it's not initial data, but runtime stuff (like
really run time), const is obviously either can't or not needed to be
used.

-- 
With Best Regards,
Andy Shevchenko
