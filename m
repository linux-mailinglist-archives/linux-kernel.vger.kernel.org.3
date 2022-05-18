Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93B1252C394
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 21:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242043AbiERTh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 15:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242011AbiERTh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 15:37:26 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE5E18DADA;
        Wed, 18 May 2022 12:37:25 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-2f83983782fso35655967b3.6;
        Wed, 18 May 2022 12:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cUlmvVpLomPSS2iPEmLkZrwTN9EoPXX7KPV8DkkGzCQ=;
        b=GQZ4v14jxx+Y21uFSplk58RQa/KLOG36GgRAw1qS9mUn1HitaLNkSwPMUqlIWjZfwf
         wgRYq6zv9d59hCqkGpZwEv72jIn1PJAtTNMZRa7G5b3ICEDMkZSSFFNN/i2GlTfJ1t+9
         0zvab7L+zL2kudnxhdEgQRlSn+ndOUnwsvDjHRPbJNThamVr4Pmt8BktuKEBDZslvUP+
         rSlMO1OW1l/lXtcNY3scTRl6qGJwlqhOG/8sV5zCa5XVr/jEPNm0UOdjFFN6yKiQnvsV
         UK6SL3JaPxdiTNV0lHf8lshtD2j3kKDQ8J23wcy6SHctl0zDzblqfA2QU1qThI4EQ/6C
         BJeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cUlmvVpLomPSS2iPEmLkZrwTN9EoPXX7KPV8DkkGzCQ=;
        b=bC/u2kmCrHKX0IcZwdYELP7ij5Ymf/hmhdexOmjl6Ps5EbjaXqu1WMVH4FdE2hYMqi
         ltz4z4f6wkJi49dwnLHIIizCjD7EigIKBQJdmVc5TLHiF1uhCEdHmvvqYFJKVjkmvnaZ
         yLjlbaBSrye0/mBFB8Hp0whSy0bp9Cvko62yrigE6xUKwmfZCpkjI3jZ3plOWaMeKzw8
         O7ZnaD6170qj9R/k5itreVpp+AOM79c2kbMBqbyUTHzUQRquIY+JHHfG3IzGISiCfMmG
         37EoZRDEMHqW9PwwasZ1YVraXYCpeNFnK95d6sUKa2j5l8iv5ycrLRDhRII7b7A8+2E2
         q3ww==
X-Gm-Message-State: AOAM532HfHQ7qNKAVXpXN6m4ZH0/oXY7LnhnQ7OBAPTE++2BGeN8C+3J
        zsusQwW9S08dpu/5BfXrB9g6lza+8/kzH/ZY+ueEPFgRvwV6JA==
X-Google-Smtp-Source: ABdhPJw/0JByLkvuE6NJDDajSUk7usheivBYLT8kNa+ctMcMJiyI30wW1LXi2rQOGGwbaIIlP4/Pgz3k7bMNvyNhlnc=
X-Received: by 2002:a0d:c607:0:b0:2fe:c294:bfc1 with SMTP id
 i7-20020a0dc607000000b002fec294bfc1mr1029865ywd.265.1652902644608; Wed, 18
 May 2022 12:37:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220517033526.2035735-1-zhangjialin11@huawei.com>
In-Reply-To: <20220517033526.2035735-1-zhangjialin11@huawei.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 18 May 2022 20:36:58 +0100
Message-ID: <CA+V-a8vJPq4-osQniSx0-PGCGKqiYJQMouG2edTw4xJfXbrrMg@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: rzg2l_adc: add missing fwnode_handle_put() in rzg2l_adc_parse_properties()
To:     Jialin Zhang <zhangjialin11@huawei.com>
Cc:     "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
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

On Tue, May 17, 2022 at 5:44 AM Jialin Zhang <zhangjialin11@huawei.com> wrote:
>
> fwnode_handle_put() should be used when terminating
> device_for_each_child_node() iteration with break or
> return to prevent stale device node references from
> being left behind.
>
> Fixes: d484c21bacfa ("iio: adc: Add driver for Renesas RZ/G2L A/D converter")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jialin Zhang <zhangjialin11@huawei.com>
> ---
>  drivers/iio/adc/rzg2l_adc.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Cheers,
Prabhakar

> diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
> index 7585144b9715..5b09a93fdf34 100644
> --- a/drivers/iio/adc/rzg2l_adc.c
> +++ b/drivers/iio/adc/rzg2l_adc.c
> @@ -334,11 +334,15 @@ static int rzg2l_adc_parse_properties(struct platform_device *pdev, struct rzg2l
>         i = 0;
>         device_for_each_child_node(&pdev->dev, fwnode) {
>                 ret = fwnode_property_read_u32(fwnode, "reg", &channel);
> -               if (ret)
> +               if (ret) {
> +                       fwnode_handle_put(fwnode);
>                         return ret;
> +               }
>
> -               if (channel >= RZG2L_ADC_MAX_CHANNELS)
> +               if (channel >= RZG2L_ADC_MAX_CHANNELS) {
> +                       fwnode_handle_put(fwnode);
>                         return -EINVAL;
> +               }
>
>                 chan_array[i].type = IIO_VOLTAGE;
>                 chan_array[i].indexed = 1;
> --
> 2.25.1
>
