Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A014B557EC0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 17:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbiFWPkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 11:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiFWPkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 11:40:35 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7804348A;
        Thu, 23 Jun 2022 08:40:33 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id n15so12162001ljg.8;
        Thu, 23 Jun 2022 08:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xo3NKjzYcYrSFDKH7f5H5c3gspyfCAKzPPrQ5FJ0QBY=;
        b=n6Ya8T5VM4CdJFKMItCxxqy104iNjfKStuVzDC/DuuwRRWj2l6D0uEH4gujwk4srg9
         ell69hg6NCjg5OuXQYKE1ZCRe9yftbFFBhntbdj4TjvnQDJpIZKDB97FfrmgLRUYHtj9
         ee5V8PyEQdVWO/LtUK1fruscf3BvoEsYzgxq5vpeX6keri8mIwIqCxH6tBt0QZFQsR0g
         I7ssuQQcACX6tdIe2rlvkGTLRJ+h6r2LuyQbdfyvZaEC/7JzPUXwOApwub8VcG+sFtKO
         Hwa/nqvaj0K0bn2IuO7Tr6gEqDUV4J1pSMUxZi7S1bMcXWtRdJrNDExRzom5gsMn/LX7
         vFPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xo3NKjzYcYrSFDKH7f5H5c3gspyfCAKzPPrQ5FJ0QBY=;
        b=UtamY5CyJKZTPI+4G9BzjnN5g4bB5EkTI8/VQ8/RoPtKg7n6wmgr5M4GmijmYirEJJ
         MHvR4PGQjeZX6GBU3OJ7QUmICJPCb7+RFuBN39p1+4RO8b46rH7XCsFH2VakqfrZ4HHs
         6wo+rFr8Fz1lrhk5ZIN62gtTwxJT768t19iUS0Z5yDxHo7SadZPeX1F6mYKPjTeNzZuE
         kKrPibsiG3PXFTeG4GkfaiTZqJD1gBvtR0Ugqcf0o8z2qAEqFw8KJY/p1PaHO0kY7e9/
         07gsQlWqLGtZENEoMB+O1x9NSEadpeQ3dUhnPySpP7CVzV+TpV8Fk8rKAoLAFL2kDksJ
         kVVQ==
X-Gm-Message-State: AJIora/bA7cJJHBypTt0Ts45FQu7aN4lGJUXMCI/DsKYrygPZvL5w08p
        7gn5iluIKx+2CeNp+UWN5y9h8+928wzkNss4KWQ=
X-Google-Smtp-Source: AGRyM1sxNfXyEUG5fs8Firg5juHCdJ881udwdPMUtVWcipHu8U/F4XPJL14dI3a+MDqZ4f+GoMbNZvNmPEyowpLlTV4=
X-Received: by 2002:a2e:b8d1:0:b0:255:bfef:7212 with SMTP id
 s17-20020a2eb8d1000000b00255bfef7212mr5108176ljp.378.1655998831709; Thu, 23
 Jun 2022 08:40:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220620162059.1097264-1-cosmin.tanislav@analog.com>
 <20220620162059.1097264-3-cosmin.tanislav@analog.com> <CAHp75VcBJkQ+CwyoDaTJ_AD+mv9d0tEd_txqHwkPRy4-xvnyKg@mail.gmail.com>
 <2aa93eab-de6d-866b-a829-36b47ff00982@gmail.com>
In-Reply-To: <2aa93eab-de6d-866b-a829-36b47ff00982@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 23 Jun 2022 17:39:54 +0200
Message-ID: <CAHp75Vc_fcAP6gGwMkYZUoMM6jKeUoQr8J+zYCUz8inSHnTF_w@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] iio: adc: ad4130: add AD4130 driver
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
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

On Thu, Jun 23, 2022 at 5:27 PM Cosmin Tanislav <demonsingur@gmail.com> wrote:
> On 6/20/22 21:29, Andy Shevchenko wrote:
> > On Mon, Jun 20, 2022 at 6:27 PM Cosmin Tanislav <demonsingur@gmail.com> wrote:

...

> >> +       /*
> >> +        * DMA (thus cache coherency maintenance) requires the
> >> +        * transfer buffers to live in their own cache lines.
> >> +        */
> >
> > This is a good comment, but what fields does it apply to?
>
> Whatever is below it, grouped together. This is not hard to
> understand.

It's hard to understand what exactly is DMA-aware here. I see only one
buffer that is aligned properly for DMA, the rest are not, except the
case if all of them are going in one DMA transaction. Is this the case
here?

> >> +       u8                      reset_buf[AD4130_RESET_BUF_SIZE] __aligned(IIO_DMA_MINALIGN);

This is aligned.

> >> +       u8                      reg_write_tx_buf[4];

This one is aligned + offset (== AD4130_RESET_BUF_SIZE + 0).

> >> +       u8                      reg_read_tx_buf[1];

This one is aligned + offset (== AD4130_RESET_BUF_SIZE + 0 + 4).

> >> +       u8                      reg_read_rx_buf[3];

This one is aligned + offset (== AD4130_RESET_BUF_SIZE + 0 + 4 + 1).
And this is Rx.

> >> +       u8                      fifo_tx_buf[2];

Here is Tx again which is most likely is not aligned...

> >> +       u8                      fifo_rx_buf[AD4130_FIFO_SIZE *
> >> +                                           AD4130_FIFO_MAX_SAMPLE_SIZE];
> >> +};

-- 
With Best Regards,
Andy Shevchenko
