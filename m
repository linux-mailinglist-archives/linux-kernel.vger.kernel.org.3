Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9F015253BA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 19:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357101AbiELRb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 13:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356894AbiELRbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 13:31:51 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8084316D5C1;
        Thu, 12 May 2022 10:31:50 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id w24so7118764edx.3;
        Thu, 12 May 2022 10:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1fM6Q+QVCd0RgN41s9cVT8krA6k8tSlwArRQNdHsfaI=;
        b=dTLmUVUtHPVrgETgl3SE8wEBx2LZCQdFe538atFhuB5eoiWSVbUxG3H9yWP377bIzB
         YuLsvc9lc7VqlM2GBLfoDVk1mBna9O3HrxQqHEyeU0rzcP9y+ldK99ltAX1V+kAoB+Ob
         y5MH3TU9ekkEm28zje1IsSyzr7OnRGeP7fsDA7pbVGx8uY4M28zCUdSrEPDNqKUIHHBK
         mjjn9VliMaWqKvh3lb+xriMRmbA+FnSJlpQVxbjFA1w1YwR1oqZH2dB2Bj9Rjny/gDYw
         gKv0fc3pcw9CpLdXZuCmR/ofkxPf9onuPuQVyM9dWYrxY3wvVcTRFr7ytzr7EFMdtwgK
         8cYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1fM6Q+QVCd0RgN41s9cVT8krA6k8tSlwArRQNdHsfaI=;
        b=C1TPsUJOo9ajFSbsR/fPpgydFpRMJqzeJKOMiVfxaVVAShYANjO6lxEaLs+l9hpFbI
         GjrLrsHPnYMIgSPSVf9JnEXB269GXs95T/W5EJFt/CwRQjUpevW/CH65ExY8Xw3jpMag
         cik2Y1TMrTHra8Nm6bPTvtgHN/mhrBR3HDpucI2LmeNODOxQdf3R2ki5o9iBTfqvMUG2
         sk8oolr4To6FChzPbmzfQj0ziJl9P1qSZ5folZPBXBCtizdoyZvwF4YK+qCMVg1JK6bV
         +FZHNgn9Y1R7Act9YNoNWTS0wJOfyuZBxsJe1JMJVeEhdmWawg3nSGDnB29wmAXmdXCo
         IbZg==
X-Gm-Message-State: AOAM532oMG9RqaQkEy6Plg6PrZmcnnXBS+96BR7xZTLmuOIHl3Fz6Aah
        8MvbCzNLnPx0keNisbrnHQTF9jkXNcigzn5Ep+4=
X-Google-Smtp-Source: ABdhPJxCtEmi5pEc/ZhnDEd1q03hRk+8aIdKlUWIhHKLAbZ9LpKs7uwP/v5cBKwHXMbxbjfcaJQ71QoTHNGDvYaotdI=
X-Received: by 2002:aa7:d350:0:b0:425:e029:da56 with SMTP id
 m16-20020aa7d350000000b00425e029da56mr36422902edr.296.1652376708905; Thu, 12
 May 2022 10:31:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220512160312.3880433-1-Qing-wu.Li@leica-geosystems.com.cn> <20220512160312.3880433-4-Qing-wu.Li@leica-geosystems.com.cn>
In-Reply-To: <20220512160312.3880433-4-Qing-wu.Li@leica-geosystems.com.cn>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 12 May 2022 19:31:11 +0200
Message-ID: <CAHp75Vc=duGJ+Y4QHvTG4ZZej3JbYCbhfj+LKhiOcd-+-sU5aw@mail.gmail.com>
Subject: Re: [PATCH V5 3/5] iio: accel: sca3300: modified to support multi chips
To:     LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Tomas Melin <tomas.melin@vaisala.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
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

On Thu, May 12, 2022 at 6:03 PM LI Qingwu
<Qing-wu.Li@leica-geosystems.com.cn> wrote:
>
> The driver supports sca3300 only, there are some other similar chips,
> for instance, SCL3300. This commit prepares the way for multiple chips
> and additional channels. Modify the driver to read the device ID and load
> the corresponding sensor information from the table to support multiple
> chips. add prepares for the addition of extra channels. Add prepares for
> handling the operation modes for multiple chips.

Reading it again I think you may format it better, i.e.

Prepare the way for multiple chips and additional channels:
- Modify the driver to read the device ID and load the corresponding
sensor information from the table to support multiple chips
- Add prepares for the addition of extra channels
- Prepare for handling the operation modes for multiple chips

...

> +struct sca3300_chip_info {
> +       const unsigned long *scan_masks;
> +       const struct iio_chan_spec *channels;
> +       u8 num_channels;
> +       u8 num_accel_scales;
> +       const int (*accel_scale)[2];
> +       const int *accel_scale_map;
> +       u8 num_freqs;
> +       const int *freq_table;
> +       const int *freq_map;

> +       const char *name;

You can put it in the first place.

> +       const int *avail_modes_table;
> +       u8 num_avail_modes;
> +       u8 chip_id;
> +};

...

> +static const struct sca3300_chip_info sca3300_chip_tbl[] = {
> +       {       .scan_masks = sca3300_scan_masks,

Keep { on a separate line.

> +               .channels = sca3300_channels,
> +               .num_channels = ARRAY_SIZE(sca3300_channels),
> +               .num_accel_scales = ARRAY_SIZE(sca3300_accel_scale)*2,
> +               .accel_scale = sca3300_accel_scale,
> +               .accel_scale_map = sca3300_accel_scale_map,
> +               .num_freqs = ARRAY_SIZE(sca3300_lp_freq),
> +               .freq_table = sca3300_lp_freq,
> +               .freq_map = sca3300_lp_freq_map,
> +               .name = "sca3300",
> +               .avail_modes_table = sca3300_avail_modes_map,
> +               .num_avail_modes = 4,
> +               .chip_id = SCA3300_WHOAMI_ID,
> +       },
> +};

...

> +       ret = sca3300_read_reg(sca_data, SCA3300_REG_MODE, &reg_val);
> +       if (ret)
> +               return ret;
> +
> +       for (i = 0; i < sca_data->chip->num_avail_modes; i++) {
> +               if (sca_data->chip->avail_modes_table[i] == reg_val&0x03)
> +                       break;
> +       }

> +

This blank line is not needed as I explained.

> +       if (i >= sca_data->chip->num_avail_modes)

== is enough and better to understand.

> +               return -EINVAL;
> +
> +       *index = i;
> +       return 0;
> +}

...

> +       int index;
> +       int i;

Both can be unsigned.

...

> +       for (i = 0; i < chip->num_avail_modes; i++) {
> +               if ((val == chip->freq_table[chip->freq_map[i]]) &&
> +                   (chip->accel_scale[chip->accel_scale_map[index]] ==
> +                    chip->accel_scale[chip->accel_scale_map[i]]))
> +                       break;
> +       }
> +
> +       if (i >= chip->num_avail_modes)
> +               return -EINVAL;

Two comments as per above for-loop case.

-- 
With Best Regards,
Andy Shevchenko
