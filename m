Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA2C45B1637
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 10:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbiIHIEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 04:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbiIHIDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 04:03:54 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD01D2B2B
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 01:03:51 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id go34so1158031ejc.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 01:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=TXeB7OP7ycRJE+socdYoFmQgfWQSmB9OKEIn7NkqjFE=;
        b=IBSzFUFIdheow/xg9ci6NJ42jQORwfUII/Zw4uVH+ShP9zg/zqc6jpkEspcxDEe5ve
         66RV0lrbwBFjEI4QcTgGQ71b09SZhZUzy8NNx0/GOBX2IzRBPC++T6sVenPwyhZtwf9L
         Lsu1JFoUc8kdu99u+M7FDuQ9lyynAkLrOUg5qdqc7IaVfHEbXoYPcnRznYm50dDhQqvt
         3tB9B/21llAszFtJaN+DuNj9i8K45Bo9RQ1D1cH8uUkUWxZsUz4lXS26JMZQxKQrr0vp
         sRMaWQ9dfCy1cIleFxpp8YbFrtN1wfAVj0HOzsCBoYIcg5zjwrq2ewjglQnojA5o/LvM
         QGZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=TXeB7OP7ycRJE+socdYoFmQgfWQSmB9OKEIn7NkqjFE=;
        b=L6Jza+Gqhu0N9V2Pjobid6O863OFtIMbmQAlni7T0gaOfzhxM67k6EcbcJs7nDQGcP
         TdBpWWfVd/0mtd3/rIargV8Xdtp8lrpqoVCcSKI4RmaNfp8iYJM0i1VAG2rW1VQz5wTE
         2+NTOwFOqoB7PcnDMdHaY+S9Oy5/dbGJ846cUZ54nRqUZI4xwMv9FWoqWLe9Oza1UnaB
         /RaziSx79dodmBmJt7iuzOnc+7XyyytfD5vNtJyOn/yZ0JLwN1azEL0xkwpgMYA3rp34
         Avt8YbKC02XH/DOAVy9y9EFUEvkaaNkkxFMMQwrmfqsukioo2iFAgwX88TNu0dvAHR02
         +JWQ==
X-Gm-Message-State: ACgBeo0gkbAdSMZAjjchEmg0wzAqhUvjvgD3UWKYx6wwJnJAqMJp+H7R
        SJtnOsucV6gmR36VV165KouOrthReGtOhSjsz+OfgnghXxht4g==
X-Google-Smtp-Source: AA6agR4nj7CjbyPl5irqfD85Ubel4kUCBthkRUzo6LDBUo3z6NwJeY/nxI4j9GbpBQY2r5W34ENyuZYLBb2SQd7tLEI=
X-Received: by 2002:a17:907:a420:b0:765:70a4:c101 with SMTP id
 sg32-20020a170907a42000b0076570a4c101mr5191874ejc.526.1662624229351; Thu, 08
 Sep 2022 01:03:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220902182650.83098-1-andriy.shevchenko@linux.intel.com>
 <20220902182650.83098-3-andriy.shevchenko@linux.intel.com>
 <CAHp75VcNGEVRnkWeVThaq4zNYoiZGSY-+KfbV5_9zG_5XoriMg@mail.gmail.com>
 <YxXyTCSKzL42PF1D@smile.fi.intel.com> <CACRpkdY4nJuXAxM7tYviWSPeqmCc6o4D--Vq0CZRPNjWNj+E_A@mail.gmail.com>
In-Reply-To: <CACRpkdY4nJuXAxM7tYviWSPeqmCc6o4D--Vq0CZRPNjWNj+E_A@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 8 Sep 2022 10:03:38 +0200
Message-ID: <CACRpkda=c23ZSBAomncevzboeApSM33t08t_kZUiRaNJ4Dwe-A@mail.gmail.com>
Subject: Re: [PATCH v1 03/17] pinctrl: cy8c95x0: Allow most of the registers
 to be cached
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 5, 2022 at 3:30 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Mon, Sep 5, 2022 at 2:57 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Fri, Sep 02, 2022 at 09:42:00PM +0300, Andy Shevchenko wrote:
> > > On Fri, Sep 2, 2022 at 9:36 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > >
> > > > It's unclear why many of static registers were marked as volatile.
> > >
> > > the static (yeah, forgot it)
> > >
> > > > They are pretty much bidirectional and static in a sense that
> > > > written value is kept there until a new write or chip reset.
> > > > Drop those registers from the list to allow them to be cached.
> > >
> > > This patch is not correct due to indexing access. It's sneaked since I
> > > forgot I added it into my main repo. The proper approach should be to
> > > create virtual registers and decode them before use. This allows to
> > > cache all ports and as a benefit to debug print all port actual
> > > statuses.
> >
> > To be clear: With this one removed from the bunch the rest can be applied w.o.
> > any change.
>
> I'll give Patrick a day or two to test/review and then I'll just apply
> them all except this one, they are all pretty self-evident except ACPI
> things which have obviously been tested on hardware so from my
> point of view it's good to merge.

I applied all patches now except this one (3/17), some patches needed
a bit of fuzzing because other stuff in my tree, so please check the
result once it lands in linux-next.

Yours,
Linus Walleij
