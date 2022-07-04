Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CBF9565F3A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 23:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbiGDV5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 17:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbiGDV5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 17:57:20 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B85641B;
        Mon,  4 Jul 2022 14:57:19 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id o2so13517006yba.7;
        Mon, 04 Jul 2022 14:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I69GAf5w9UfzHnFC+S/CpBJc7q1BhKlaTmzgktdZI7Q=;
        b=S1IFj0DtCpx6wWjkO0gwYCosHqcfj3p3+SFGK6gt9lQip4nrhxnLw3HUCn88Sc1NZF
         0uk+GI1afz3MxnA5wfOhziHNxI12XXMDo4hx+f9TazVbfB6eq+ladHyRCR1soYQK+wNd
         P9htMoB3LypWioJ63GMQexaGThb4ixSjNunh2DCWHSYUeiPcu55UswPZBDh5jECFDFGA
         nmRjZ2DmJq4xWXCMvwKvE7Q5Jr0flT+E96/u8bTTy8T/49tL47WsQkvhFfQiXPBb+iC+
         bDuyWesX4eAqsVuGVCh2Hn2zvp1Hx9dKyCOnFjxhKrwsCIyl8oMF6a5HbidVsD6ob5qZ
         OGdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I69GAf5w9UfzHnFC+S/CpBJc7q1BhKlaTmzgktdZI7Q=;
        b=uog2gzgEDwBmvxY7E7bdsLQgWrRl3UEiJo2jYSfDO9Z7IPL0KEgKh8ypEwiAGsYpZZ
         9LEdNbkm+6Uz5QflMYLa99XOnjh2oUjvcDOtC2IHQyqqg4/0F7ZtW1BLXhW/ZiJ8H5KX
         B2+oWrtlkxXDv4CKRAy77S8xuSFYs/sWCcIKD40XoHv475cmiLwYtYFxH2t/xYKuNlUN
         Zsz7lX4lrYgzyRijYdEkL78nlguKhvcnwyoRnoQKBpkZIIsDx19nslXwG25bmVt2nt6i
         S+frOyzun3ia9wZJMEaFmzpzwgl/q+B1Ma6NSoMD3o4yhonSHU9N0HqhuxQK+WMR/46n
         anMQ==
X-Gm-Message-State: AJIora/fWwJX0NfqDg8JIJl8h3w2QNXgPvs8IBOz9GR0kRWZRoEeMuQf
        APix9hcl4uhMfi37tKBl+qkohHyIbpR9Cb1AJW4=
X-Google-Smtp-Source: AGRyM1szgSwfuDA7rJDcPQjF9rcYKmrgKXUXwCpG7BA4yWDTMPS16yEq60dezfnYPHmirOGXfQAnkYK0Rt61RBYlWiU=
X-Received: by 2002:a05:6902:10c9:b0:668:e27c:8f7 with SMTP id
 w9-20020a05690210c900b00668e27c08f7mr33683051ybu.128.1656971838460; Mon, 04
 Jul 2022 14:57:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220704172116.195841-1-marcus.folkesson@gmail.com> <20220704172116.195841-6-marcus.folkesson@gmail.com>
In-Reply-To: <20220704172116.195841-6-marcus.folkesson@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 4 Jul 2022 23:56:41 +0200
Message-ID: <CAHp75Vc84jTQmTo7sb9sohkG0LmZmQX+hDimwCUb89vqmGfdcA@mail.gmail.com>
Subject: Re: [PATCH v3 5/9] iio: adc: mcp3911: add support for buffers
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
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

On Mon, Jul 4, 2022 at 7:20 PM Marcus Folkesson
<marcus.folkesson@gmail.com> wrote:
>
> Add support for buffers to make the driver fit for more usecases.

use cases

...

> +       for_each_set_bit(scan_index, indio_dev->active_scan_mask,
> +                       indio_dev->masklength) {
> +               const struct iio_chan_spec *scan_chan =
> +                       &indio_dev->channels[scan_index];
> +
> +               adc->scan.channels[i] = adc->rx_buf[scan_chan->channel * 3 + 0] << 16 |
> +                                       adc->rx_buf[scan_chan->channel * 3 + 1] << 8 |
> +                                       adc->rx_buf[scan_chan->channel * 3 + 2] << 0;

get_unaligned_be24()

> +               i++;
> +       }

...

> @@ -325,6 +403,7 @@ static int mcp3911_probe(struct spi_device *spi)
>         if (ret)
>                 return ret;
>
> +
>         indio_dev->name = spi_get_device_id(spi)->name;
>         indio_dev->modes = INDIO_DIRECT_MODE;
>         indio_dev->info = &mcp3911_info;

Stray change.

-- 
With Best Regards,
Andy Shevchenko
