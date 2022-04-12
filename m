Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87D514FDC5E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 13:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343703AbiDLKVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 06:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359427AbiDLKTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 06:19:20 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303127CB29;
        Tue, 12 Apr 2022 02:16:35 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id p15so36033991ejc.7;
        Tue, 12 Apr 2022 02:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EHG2IbCAiVOF3vEZ4P/yUZxJg6ubvPpIH2rRWthOYrg=;
        b=G92Gn1YJZuxQyQgqMa+NS6Km5+yE1SrRMLyGFD3365N87vl2wEmsHL2KkEobxIy6J2
         soQ40KENXoB2sJjJmZerSMF5oiRPd7j15Tw3JFo3dKken455nMA5sZKtvdPFxoLDhFX6
         9CfRWFAqrg+X0hBsFl2y7lUiRj+gw9VGPYx51a9/96ks5WgrersDjJbZRab3tKrekG1+
         IgyaO3hcAjfF0DyBLEEPPo1JrELJg3hFROlNxkoeBrucG+6IEP19L/O7NeameZo2foeB
         zvd9r1FcB/4zSxS2fi4qwOar8bUypCC3sGjU+Q6LixImmDwLVFOVfr3xSf15SQshYkMr
         VABA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EHG2IbCAiVOF3vEZ4P/yUZxJg6ubvPpIH2rRWthOYrg=;
        b=iamKGvYtyGZinPt5eKdmwafbA356gnq0uBF8ysjWPx3nX4tKuJvlYmGyuxTAgDN5S7
         2Cw5pL0BJvUhiy2R6KD3Mdweta65Mpx/FAvafvgy0BOMZuug8k8Ur3ybwW3MgBrqX4Z9
         YcfQ3qBifQ607LArI7eHNYK8Cm5P1nXt5zFAK3g7rqO4FeRin/cF6++GXNLwHdewMmWk
         B3vhSO4E/2OXyr6xB6t46wKnXjMf12SAoyud8zrlu8ctJedoFNMOi/XhATLCPO9Y55SJ
         kuiIN0AY8z7b00uaG6U/43Xv3GcS7TJidv934NfYb04BuUvphyBhezXQVvKBkpsn26Tx
         wDyw==
X-Gm-Message-State: AOAM532Etsnd7jENw0qLJ1qriHaTQFy+EfdndBjV89qbWkGh9nlPYa2W
        +44UCVrF9LbjZ6k140gIEXdQj2q/wIHBS42LM9XJMIVwROo=
X-Google-Smtp-Source: ABdhPJwecXWgLi/Y0O7C3BqMQAaINjC0g6xtKLweks3Mu+GmHo72tEFDcESkWd70UasQljW6QhRYWtBTmsjQXWqxG9w=
X-Received: by 2002:a17:907:e8d:b0:6e0:19e7:9549 with SMTP id
 ho13-20020a1709070e8d00b006e019e79549mr33953776ejc.44.1649754994299; Tue, 12
 Apr 2022 02:16:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220411203133.19929-1-jagathjog1996@gmail.com> <20220411203133.19929-5-jagathjog1996@gmail.com>
In-Reply-To: <20220411203133.19929-5-jagathjog1996@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 12 Apr 2022 12:12:21 +0300
Message-ID: <CAHp75VfHa9afhSdyi8dj5GpzrYE=hLacayu58+PHjXhMxTo9eg@mail.gmail.com>
Subject: Re: [PATCH v3 4/9] iio: accel: bma400: Add triggered buffer support
To:     Jagath Jog J <jagathjog1996@gmail.com>
Cc:     Dan Robertson <dan@dlrobertson.com>,
        Jonathan Cameron <jic23@kernel.org>,
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

On Mon, Apr 11, 2022 at 11:31 PM Jagath Jog J <jagathjog1996@gmail.com> wrote:
>
> Added trigger buffer support to read continuous acceleration
> data from device with data ready interrupt which is mapped
> to INT1 pin.

Can you explain the locking schema in this driver?

> +       /* Configure INT1 pin to open drain */
> +       ret = regmap_write(data->regmap, BMA400_INT_IO_CTRL_REG, 0x06);
> +       if (ret)
> +               return ret;

No locking (or regmap only locking).

...

> +static int bma400_data_rdy_trigger_set_state(struct iio_trigger *trig,
> +                                            bool state)
> +{
> +       struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
> +       struct bma400_data *data = iio_priv(indio_dev);
> +       int ret;
> +
> +       ret = regmap_update_bits(data->regmap, BMA400_INT_CONFIG0_REG,
> +                                BMA400_INT_DRDY_MSK,
> +                                FIELD_PREP(BMA400_INT_DRDY_MSK, state));
> +       if (ret)
> +               return ret;
> +
> +       return regmap_update_bits(data->regmap, BMA400_INT1_MAP_REG,
> +                                 BMA400_INT_DRDY_MSK,
> +                                 FIELD_PREP(BMA400_INT_DRDY_MSK, state));
> +}

Ditto.

...

> +       mutex_lock(&data->mutex);
> +
> +       /* bulk read six registers, with the base being the LSB register */
> +       ret = regmap_bulk_read(data->regmap, BMA400_X_AXIS_LSB_REG,
> +                              &data->buffer.buff, sizeof(data->buffer.buff));
> +       mutex_unlock(&data->mutex);
> +       if (ret)
> +               return IRQ_NONE;

But here only above with locking...

> +       ret = regmap_read(data->regmap, BMA400_TEMP_DATA_REG, &temp);
> +       if (ret)
> +               return IRQ_NONE;

...followed by no locking.

...

> +       mutex_lock(&data->mutex);
> +       ret = regmap_bulk_read(data->regmap, BMA400_INT_STAT0_REG, &status,
> +                              sizeof(status));
> +       mutex_unlock(&data->mutex);
> +       if (ret)
> +               return IRQ_NONE;

And again with locking.

...

So,
1) Does regmap is configured with locking? What for?
2) What's the role of data->mutex?

-- 
With Best Regards,
Andy Shevchenko
