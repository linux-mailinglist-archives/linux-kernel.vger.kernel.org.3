Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5235804FB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 22:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236748AbiGYUF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 16:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236589AbiGYUF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 16:05:26 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628996385;
        Mon, 25 Jul 2022 13:05:25 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id tk8so22520491ejc.7;
        Mon, 25 Jul 2022 13:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IjUjwK3ElFJ8pxv20zoLj+tD6iYdFeeNew4jTmYt/44=;
        b=cGE6CEk0QSSPB6KPoo76GR4W7rfZkQSW0l/s7lLWDsVAdi0RWDDuAEIm4mPv3Y2vla
         E9jWTsprUvs7mj3NAZ750HA+h/nDEP0DrHfJKB0kA3Y8aihP6aqn2H9bd2bSYcD4HZLy
         yruYZcVrm1DtqeIbLOuyj1SLZ9Wgv8ZbPsr9CQyd2skE6PYlEljVmOQuB/H/a2xxcXaE
         BcVqzg+k6wTU9iZY8D47ZYNT+v7XTYF/kqzNcQEMVyruPFbqhRuWOxOo84f4OzrWUGVi
         vGmkQy/6ERNzaf+M9TgdJMTsecGebht2h/HKLD8Syb2inviIX+JAs0DJ8Ld8+fheTFMp
         J5Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IjUjwK3ElFJ8pxv20zoLj+tD6iYdFeeNew4jTmYt/44=;
        b=D3LOlaCHyUK6ltE55+9Pz9OuBz23Yty+GdBlBf+TvPjJq/Kn98LkSWRBb7fZJEjPrH
         NNa09fONkVBhOt3oE1HGnZSbcj1GBpiSxvme7fSVjnHkInnUEpb7OLa4BcqRjGnIFMzZ
         5iRtqyoE5rtvNi0mubnj5mtsqtILvFMH4lzEprVPEF5Jv11CofVRoXyQ82rLtv+2oxUV
         PJwwY4IPSYYwMYMjPTkbsxaJWy5408gtyKOgYUwvar3pH8gGvvh2cE21zSpINlPUnP9m
         COpWBs704EVsIieoE+bkoZvs/ULfwTYwgJuUbtiGaQQjNyfKP4gO1NoEfYBcQ1grUPpT
         wHPA==
X-Gm-Message-State: AJIora9xDwY/2/b2BXFkHWcUjYrjenfJ0Aik1xD9wXyw4uSEgbVUXD7k
        BJ+Vq0nre+16mXRsl5oCQjZejeM4xGeojElsOjM=
X-Google-Smtp-Source: AGRyM1vlACcQsivYTx0sMq+Ae6+AdaZj0mtKjW2Tew03XEARVQjPMHOvoLZ8T1SsDNqV6MOLjdGMYq2w8AjLGWHe2sg=
X-Received: by 2002:a17:907:1c8d:b0:6f2:eb2:1cd6 with SMTP id
 nb13-20020a1709071c8d00b006f20eb21cd6mr11153522ejc.568.1658779523752; Mon, 25
 Jul 2022 13:05:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220721073909.23318-1-srinivas.neeli@xilinx.com> <CAMRc=Mefhk4i8_1j2=JO63SwfHEb3TrRMj45+CC1i1DUr8VULw@mail.gmail.com>
In-Reply-To: <CAMRc=Mefhk4i8_1j2=JO63SwfHEb3TrRMj45+CC1i1DUr8VULw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 25 Jul 2022 22:04:47 +0200
Message-ID: <CAHp75Vdr3yM_b_8bDgAhNLrHUuyoq2nkVcj84wdvTzvLLetkNg@mail.gmail.com>
Subject: Re: [PATCH] gpio: gpio-xilinx: Fix integer overflow
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Srinivas Neeli <srinivas.neeli@xilinx.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        neelisrinivas18@gmail.com,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        srinivas.neeli@amd.com, Srinivas Goud <sgoud@xilinx.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        git <git@xilinx.com>
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

On Fri, Jul 22, 2022 at 9:19 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> On Thu, Jul 21, 2022 at 9:39 AM Srinivas Neeli
> <srinivas.neeli@xilinx.com> wrote:
> >
> > Current implementation is not able to configure more than 32 pins
> > due to incorrect data type. So type casting with unsigned long
> > to avoid it.

> > Fixes: 02b3f84d9080 ("xilinx: Switch to use bitmap APIs")

It doesn't fix anything,  I already reject one such "fix" during
development of this patch. Thanks!

...

> > @@ -99,7 +99,7 @@ static inline void xgpio_set_value32(unsigned long *map, int bit, u32 v)
> >         const unsigned long offset = (bit % BITS_PER_LONG) & BIT(5);
> >
> >         map[index] &= ~(0xFFFFFFFFul << offset);
> > -       map[index] |= v << offset;
> > +       map[index] |= (unsigned long)v << offset;
> >  }

> Applied, thanks!

False positive.

-- 
With Best Regards,
Andy Shevchenko
