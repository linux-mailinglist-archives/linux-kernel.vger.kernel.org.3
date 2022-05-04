Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8FA351A211
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 16:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351248AbiEDOY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 10:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345701AbiEDOYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 10:24:25 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D07D11C928;
        Wed,  4 May 2022 07:20:49 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id k27so1880070edk.4;
        Wed, 04 May 2022 07:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PDUpqEwsU0g54F2duDLV9Pqr2Yjkf7JgCmsGkPEOp0w=;
        b=LsrQObZXf1A/KJ3l8fAg9QNyokldjCq9cX5C7y+XIxBlonabohntkTLKb0rJ3mO6ES
         DlWroY41MZMuGn0G6eM/TINrCGpIqU0VYsy/5y8QrNBn/E0vvJSiXGIOOonTe7PX7wwJ
         Kr/dUZlao0crAh6cyzm7vJ9wvZQXkXUGl5gJnY6WKF6pf6dww8E3AHlESi0P/yHZ2q5F
         Bki4i/mXRFF/XI2J7ovTbRnLw4ZJqtR4NOewVfd6Y94CzqGiP1rULXKWxYnGan3Qclxs
         uPDx/gryb9V0LY+irlYkN/WoifbWSwOPw8d2bWmzgbROezZ2j1qhBrfFqwvyezQ0hqZd
         Ztww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PDUpqEwsU0g54F2duDLV9Pqr2Yjkf7JgCmsGkPEOp0w=;
        b=yCA0xbQpp3xj6eKFuxId0IaP1z61UvE6HS2vfoiq4uKLPZBeY7E1iZDDvyVdQ3Xzof
         ISPhrC40ToQZ6GPYH1IU6Qi+o1Ql0O2Uqlm2Ua6wmedDrO4WFRFwLeYUzBZVpq/TWWwT
         ateNDi9VVbi4FokhjI3HwQ3+6FXBHUkYWiyc0XUSMeNLJ06v576Tjeg1ZRu/c1ihqqPf
         d28LthPl4+yCacBlYKREyZnH64idZ0CDlQ3xPJYLNskJjs0t0jMrem8POuR635pBowPJ
         NjhSOoKpCP6dROBtTMDTCBJNbVJA3KdkrzbuvICyFX7bm+SsTMFyBYrbdw2MqKaH96tt
         vA2g==
X-Gm-Message-State: AOAM530E+5iBuB4DCWaSoXjF9xGWLAL2wPVJWpPg5Kq/g220uKz0by6b
        mTCYATCRMp5Mm8ciLiXJUpJRaPxr4IU/e/11ydQ=
X-Google-Smtp-Source: ABdhPJxtzj9zFuQw6N6sVztraiGsQxy5kNW6AXTNcgQlk00LHVmbnO+1P+bByTm7T3zXzTkNai4eTBVZFHT+TvmdkoU=
X-Received: by 2002:a05:6402:d51:b0:425:d5e1:e9f0 with SMTP id
 ec17-20020a0564020d5100b00425d5e1e9f0mr23287754edb.125.1651674048120; Wed, 04
 May 2022 07:20:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220504133612.604304-1-Qing-wu.Li@leica-geosystems.com.cn> <20220504133612.604304-4-Qing-wu.Li@leica-geosystems.com.cn>
In-Reply-To: <20220504133612.604304-4-Qing-wu.Li@leica-geosystems.com.cn>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 4 May 2022 16:20:11 +0200
Message-ID: <CAHp75VeseZ2ChtbafmbgVavS4KvCvrQ4+XSRkeiJSyqr8__dSw@mail.gmail.com>
Subject: Re: [PATCH V3 3/5] iio: accel: sca3300: modified to support multi chips
To:     LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Tomas Melin <tomas.melin@vaisala.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Rob Herring <robh@kernel.org>
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

On Wed, May 4, 2022 at 3:36 PM LI Qingwu
<Qing-wu.Li@leica-geosystems.com.cn> wrote:
>
> The drive support sca3300 only.

driver supports

> There are some other similar chips, for instance, SCL3300.
> Prepare the way for multiple chips and additional channels.
> Modify the driver to read the device id.
> Add the tables for the corresponding id to support multiple chips.
> Add prepares for the addition of extra channels.
> Add prepares for handling the operation modes for multiple chips.

It seems you need to work more on the commit messages in all patches.

...

> +struct sca3300_chip_info {
> +       const struct iio_chan_spec *channels;
> +       const int (*accel_scale_table)[2];
> +       const int *accel_scale_modes_map;
> +       const unsigned long *scan_masks;
> +       const int *avail_modes_table;
> +       const int *freq_modes_map;
> +       const int *freq_table;
> +       const u8 num_accel_scales;
> +       const u8 num_avail_modes;
> +       const u8 num_channels;
> +       const u8 num_freqs;
> +       const u8 chip_id;

Why do you have const qualifier on all members?  The last one is
understandable, but the rest, esp. pointers should be justified.

> +       const char *name;
> +};

...

> +static int sca3300_set_op_mode(struct sca3300_data *sca_data, int index)
> +{
> +       int mode;
> +
> +       if ((index < 0) || (index >= sca_data->chip->num_avail_modes))

Too many parentheses.

> +               return -EINVAL;
> +
> +       mode = sca_data->chip->avail_modes_table[index];
> +
> +       return sca3300_write_reg(sca_data, SCA3300_REG_MODE, mode);
> +}

-- 
With Best Regards,
Andy Shevchenko
