Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B06599769
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 10:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347603AbiHSITZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 04:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347599AbiHSIS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 04:18:56 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCBD13F1E2;
        Fri, 19 Aug 2022 01:18:18 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id p5so1332776qvz.6;
        Fri, 19 Aug 2022 01:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=5w+/g5YGTVdUHyIqk02zSqLS8P5U5fB9MVF9V2agJs0=;
        b=gdAXzwgCjGLoD1sElbapv4QEHxkB7G5webqH9OcGwe0JTZ+S3aa40oCN2BsF7UhTFi
         dzC7tuI4ZcdBbTu+37Z5nQXVEzEYODot/JQoQutZHP4ZnBuvYgqUjNSd3Enm3uOfGDji
         Z6jN086ldl3QK05dZ7sykm/vBoXyb3zqQThCN9UYV0aoY7Q253/gpc469j8wOMcAXhsk
         +hcLDE88iyEwK7deBSl0itpcChEfyi/b2qjAgKVGExoFuVtfGgd8cE/3n8aQ/FngpoNb
         kmAuCmFc5UybXNyQn+vbezSBfe3fj1p7BU70y/MbLRtvJkt3nPrjrwye7w5NJFWGQsrT
         slcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=5w+/g5YGTVdUHyIqk02zSqLS8P5U5fB9MVF9V2agJs0=;
        b=NR+OXYcnEmeC+noF5/ufQcsc11miCRICo0JQBPUeC2vmfCP12JNkS4DW4MZGEnJ+7/
         ilkpqV+H2BfAnUTnxEW1GSCu7r2aZyDFBOFm5oJw32fLk9n4ZZGp5Qa47GhLPnpxTVX8
         WAuknSrsF2H5+fmJtAqtmR7RsgJTGkThIp4n17lENEq2gXEXOcVHpf0TpktY35aWaIFR
         0ssAZC4xY6vguMbGBaWYJYsDX+l9mFnigj0DYk4Rmnk4+rjgOcYMdY2J8RsA3Q4PMPUQ
         i2K1PYT8M3oBHKuh6UKBeRXyGa1izy53kqK2Ij92ENOFBOY50rib6tlxYRSjZBDjk/sa
         /iEg==
X-Gm-Message-State: ACgBeo3hYw1Ouk1NEzERDNRa6lldaaRbMEwh3vXQP7aykcHoCfTsYYfy
        4h5CZNLMejVTrn0Qs99h9UkwO17T6BClU6mDrTA=
X-Google-Smtp-Source: AA6agR7LmW3N9z3MXZX9n9igF+gWSbyWFvq+FB6r3EgvE+6nZGrWjDoyV5HF2BTjg2dmSLl5DuAi/kX6oqCv1o7HUFw=
X-Received: by 2002:a05:6214:e69:b0:476:b991:586f with SMTP id
 jz9-20020a0562140e6900b00476b991586fmr5323691qvb.48.1660897097715; Fri, 19
 Aug 2022 01:18:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220817105643.95710-1-contact@artur-rojek.eu> <20220817105643.95710-4-contact@artur-rojek.eu>
In-Reply-To: <20220817105643.95710-4-contact@artur-rojek.eu>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 19 Aug 2022 11:17:41 +0300
Message-ID: <CAHp75VeierGKV7BqF+y-vxramA4nk24LOSPRxgmjots_amkg-w@mail.gmail.com>
Subject: Re: [PATCH 3/4] iio: add helper function for reading channel offset
 in buffer
To:     Artur Rojek <contact@artur-rojek.eu>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Chris Morgan <macromorgan@hotmail.com>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>
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

On Wed, Aug 17, 2022 at 1:58 PM Artur Rojek <contact@artur-rojek.eu> wrote:
>
> This is useful for consumers that wish to parse raw buffer data.

...

> +int iio_find_channel_offset_in_buffer(struct iio_dev *indio_dev,
> +                                     const struct iio_chan_spec *chan,
> +                                     struct iio_buffer *buffer)
> +{
> +       int length, offset = 0;
> +       unsigned int si;
> +
> +       if (chan->scan_index < 0 ||
> +           !test_bit(chan->scan_index, buffer->scan_mask)) {
> +               return -EINVAL;
> +       }

Have you run checkpatch? The {} are redundant. But personally I would
split this into two separate conditionals.

> +       for (si = 0; si < chan->scan_index; ++si) {

Just a side crying: where did you, people, get this pre-increment pattern from?!

> +               if (!test_bit(si, buffer->scan_mask))
> +                       continue;

NIH for_each_set_bit()

> +               length = iio_storage_bytes_for_si(indio_dev, si);
> +
> +               /* Account for channel alignment. */
> +               if (offset % length)
> +                       offset += length - (offset % length);
> +               offset += length;
> +       }
> +
> +       return offset;
> +}
> +EXPORT_SYMBOL_GPL(iio_find_channel_offset_in_buffer);

Same Q as per previous patch: IIO namespace?

-- 
With Best Regards,
Andy Shevchenko
