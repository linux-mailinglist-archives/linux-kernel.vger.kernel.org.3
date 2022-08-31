Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55BE85A7DAB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 14:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbiHaMlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 08:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbiHaMle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 08:41:34 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A31A2D90;
        Wed, 31 Aug 2022 05:41:27 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id cv7so8411737qvb.3;
        Wed, 31 Aug 2022 05:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=SqSaiH001DaKHsJtGylzBtgtVHavENIN9cJHRvwSVcg=;
        b=cBeX6NbUeFDxee/h/N0TapFMYkJCFlRssIH4TXVMSzIHfIJzwVxMoRNkvGuMgTwdfG
         6ysgvlLYWWpJxc3WYHj21zBNqjQWBZy0TYGMGOaYnksIozBtMv2t9khsJfV4K0EXXAVs
         Eysms5qjh7C3kB+Lcu/V1Aj/dW1If5uy19bUUtuteKB50gqr5Ab5ZE8dYCpBZbCMQKNW
         RC+XTvBHmr2BnVqgAWlRYbWkCoVl51/iUd/ArO9EjFOWLovIEHwAbxUZTkV2uyigLh0W
         Yxa7LUUANqnyk2FEAa01eBmNJS6KnKs0LzUxenUzf7ImebvuMwqRJq5Rml7wZ//8pQyj
         Q60g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=SqSaiH001DaKHsJtGylzBtgtVHavENIN9cJHRvwSVcg=;
        b=3k8PopbYMoNYAixEC4CP/zrslXYAYKvs7+o1GGfTuBLKIM4NYFbS50zlcWuppKulPb
         eii+CgqF9wR9KxCuKCGUifZKPPUE1rBPDOaMD91shgB84Bpzo+Zz/d9Xor7SPh5RLV+x
         FdYTNoq4mLMEMpd73bF3xzkAkcWqb32JoGVaWRWyA9GRhXrZkiiyaCQC9eENgL00p8Ql
         Rp1aLcg3qjYVzmozngUlMh67IhDzsyS0G9bZIuwCODmIxO8MQ83JXIAQ4c+6UDm+7i+k
         IJo0vEaljwrbAXfPikdO90PeHIhnv735yN1qkU1fQlMMEhkj8IPTyn58TaOjs4cWRTab
         D8rQ==
X-Gm-Message-State: ACgBeo3tP4AERhtTTW/IJlrKRAVeGoOrKzZ0d2iE49qii/revXbzhKDK
        OOU/ktKo4PSYwpWhWtZVfRp1n+fytE3PLb+si9hkjG71PvM=
X-Google-Smtp-Source: AA6agR5f3FCjiKfWsC0DabfD1g2ht9f5bkZhBMZDQuweXO0x08WBqTdkZ/4Rc8AvW0QyOZ3Iji+d8zQCf0QlhO0HPz4=
X-Received: by 2002:a05:6214:c26:b0:499:19f1:1a73 with SMTP id
 a6-20020a0562140c2600b0049919f11a73mr3868741qvd.48.1661949685953; Wed, 31 Aug
 2022 05:41:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220831100506.3368103-1-vincent.whitchurch@axis.com> <20220831100506.3368103-2-vincent.whitchurch@axis.com>
In-Reply-To: <20220831100506.3368103-2-vincent.whitchurch@axis.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 31 Aug 2022 15:40:49 +0300
Message-ID: <CAHp75Vek8tLnwYWZO91HHr1_i7G_F9tErnRsq-GwfQcpR0FaTw@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] iio: adc: mcp320x: use callbacks for RX conversion
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, kernel <kernel@axis.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
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

On Wed, Aug 31, 2022 at 1:05 PM Vincent Whitchurch
<vincent.whitchurch@axis.com> wrote:
>
> Replace the device_index switch with callbacks from the chip_info
> structure, so that the latter has all the information needed to handle
> the variants.

Below are for the further patches, as I see the original code has the
same disadvantages.

...

>  struct mcp320x_chip_info {
>         const struct iio_chan_spec *channels;
>         unsigned int num_channels;
>         unsigned int resolution;

>         unsigned int conv_time; /* usec */

Instead of a comment, I would rename it to conv_time_us.

> +       int (*convert_rx)(struct mcp320x *adc);
>  };

...

> +       return adc->rx_buf[0] << 5 | adc->rx_buf[1] >> 3;

> +       return adc->rx_buf[0] << 2 | adc->rx_buf[1] >> 6;

> +       return adc->rx_buf[0] << 7 | adc->rx_buf[1] >> 1;

> +       return adc->rx_buf[0] << 4 | adc->rx_buf[1] >> 4;

> +       return sign_extend32((adc->rx_buf[0] & 0x1f) << 8 | adc->rx_buf[1], 12);

All above should really use

u16 buf = be16_to_cpu(&adc->rx_buf[0]);

return buf >> 3 /* 6, 1, 4 (respectively) */;

...

> +       if (raw & BIT(22) && raw & BIT(23))

> +               return -EIO; /* cannot have overrange AND underrange */
> +       else if (raw & BIT(22))

Redundant  'else'.

> +               raw &= ~BIT(22); /* overrange */
> +       else if (raw & BIT(23) || raw & BIT(21))

if (raw & (BIT(23) | BIT(21))) ?

> +               raw |= GENMASK(31, 22); /* underrange or negative */

...

>         [mcp3201] = {
>                 .channels = mcp3201_channels,
>                 .num_channels = ARRAY_SIZE(mcp3201_channels),
> +               .convert_rx = mcp3201_convert_rx,

>                 .resolution = 12

+ Comma in such lines.

>         },

-- 
With Best Regards,
Andy Shevchenko
