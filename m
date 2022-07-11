Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41E2F57047B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 15:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbiGKNjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 09:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbiGKNjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 09:39:36 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DE141D03;
        Mon, 11 Jul 2022 06:39:34 -0700 (PDT)
Received: from [IPV6:2405:201:10:3153:7fbd:8a7b:29b6:89fb] (unknown [IPv6:2405:201:10:3153:7fbd:8a7b:29b6:89fb])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: shreeya)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E800A66019FC;
        Mon, 11 Jul 2022 14:39:21 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657546773;
        bh=kcycLdUSAESBhBH1uafESxCPOSsn1Gvf4vdwqP6e/1k=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Zm/cmUoteEygUYeUwar5ruyBTHkhJVqUtTpks0krTjloXfpPvdS0CGw6iTccGZofN
         docyk1AqZwYf3IN0Bj5WP2Ni1woDQMP2tG9jfH+/lO+J22+37uMXrdgzWaluZTWPrx
         o+24Z9nnwAYWdN6JIqiRYackiZZeVOKmDT78dqmEH2356B/LZheN75qBkEQ1azhlxO
         moTkzf3PqAY+u9i8TrDndTS5piOtn3MyPvmExGZJorWGQeoMBBuA+IGDuyGTO4Ok4B
         knq9wXjNLtrUTReG94dc+9kgGj5mbr06L0UN9fGfRviI3nF8AtJdyaydSlaWqH9TnR
         rbI73kLZU6I0w==
Message-ID: <c90e7334-5921-886b-2f9c-869fb55216ca@collabora.com>
Date:   Mon, 11 Jul 2022 19:09:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v7 2/2] iio: light: Add support for ltrf216a sensor
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>, Zhigang.Shi@liteon.com,
        krisman@collabora.com, linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        alvaro.soliverez@collabora.com, dmitry.osipenko@collabora.com
References: <20220711112900.61363-1-shreeya.patel@collabora.com>
 <20220711112900.61363-3-shreeya.patel@collabora.com>
 <CAHp75Vf3NDsep5_819=e8yrna_AGh5cew=fs+hHe1q8LCa-PyA@mail.gmail.com>
From:   Shreeya Patel <shreeya.patel@collabora.com>
In-Reply-To: <CAHp75Vf3NDsep5_819=e8yrna_AGh5cew=fs+hHe1q8LCa-PyA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/07/22 18:36, Andy Shevchenko wrote:
> On Mon, Jul 11, 2022 at 1:30 PM Shreeya Patel
> <shreeya.patel@collabora.com> wrote:
>> From: Zhigang Shi <Zhigang.Shi@liteon.com>
>>
>> Add initial support for ltrf216a ambient light sensor.
>>
>> Datasheet: https://gitlab.steamos.cloud/shreeya/iio/-/blob/main/LTRF216A.pdf
>> Co-developed-by: Shreeya Patel <shreeya.patel@collabora.com>
>> Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
>> Signed-off-by: Zhigang Shi <Zhigang.Shi@liteon.com>
> Submitter's SoB always has to be last among SoBs in the proposed change.
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by
>
> ...
>
>> +static int ltrf216a_set_power_state(struct ltrf216a_data *data, bool on)
>> +{
>> +       struct device *dev = &data->client->dev;
>> +       int ret;
>> +
>> +       if (on) {
>> +               ret = pm_runtime_resume_and_get(dev);
>> +               if (ret < 0) {
>> +                       dev_err(dev, "Failed to resume runtime PM: %d\n", ret);
>> +                       return ret;
>> +               }
>> +
> Unneeded blank line.
>
>> +       } else {
>> +               pm_runtime_mark_last_busy(dev);
>> +               ret = pm_runtime_put_autosuspend(dev);
>> +       }
>> +
>> +       return ret;
>> +}
> ...
>
>> +       ret = regmap_read_poll_timeout(data->regmap, LTRF216A_MAIN_STATUS,
>> +                                      val, val & LTRF216A_ALS_DATA_STATUS,
>> +                                      LTRF216A_ALS_READ_DATA_DELAY_US,
>> +                                      LTRF216A_ALS_READ_DATA_DELAY_US * 50);
>> +       if (ret) {
>> +               dev_err(dev, "Timed out waiting for valid data from LTRF216A_MAIN_STATUS reg: %d\n",
>> +                       ret);
> THe message is a bit misleading. The loop might be broken by the I/O error.
>
>> +               return ret;
>> +       }
>> +
>> +       ret = regmap_bulk_read(data->regmap, addr, buf, sizeof(buf));
>> +       if (ret < 0) {
>> +               dev_err(dev, "Error reading measurement data: %d\n", ret);
>> +               return ret;
>> +       }
> ...
>
>> +static const struct regmap_config ltrf216a_regmap_config = {
>> +       .name = LTRF216A_DRV_NAME,
>> +       .reg_bits = 8,
>> +       .val_bits = 8,
>> +       .max_register = LTRF216A_MAX_REG,
> Why do you use regmap locking? What for?
>
Hi Andy,

Why do we want to skip the internal locking if it doesn't bring any 
benefits?


>> +};
> ...
>
>> +       data->regmap = devm_regmap_init_i2c(client, &ltrf216a_regmap_config);
>> +       if (IS_ERR(data->regmap)) {
>> +               dev_err(&client->dev, "Regmap initialization failed.\n");
>> +               return PTR_ERR(data->regmap);
> return dev_err_probe(...);
>
>> +       }
> ...
>
>> +       ret = devm_pm_runtime_enable(&client->dev);
>> +       if (ret < 0) {
>> +               dev_err_probe(&client->dev, ret, "Failed to enable runtime PM\n");
>> +               return ret;
> Ditto.
>
>> +       }
> ...
>
>> +               ret = ltrf216a_init(indio_dev);
>> +               if (ret) {
>> +                       dev_err_probe(&client->dev, ret, "Failed to enable the sensor\n");
>> +                       return ret;
> Ditto.
>
>> +               }
> ...
>
>> +       if (ret < 0)
> For all these  ' < 0', please explain what positive return value means
> there, if any, and why it's being ignored.
>
> ...
>
>> +static const struct i2c_device_id ltrf216a_id[] = {
>> +       { LTRF216A_DRV_NAME, 0 },
> Please, use the string literal directly since it's kinda an ABI,
> defining above for potential changes is not a good idea. Also you may
> drop the ', 0' part.
>
>> +       {}
>> +};
> ...
>
>> +static struct i2c_driver ltrf216a_driver = {
>> +       .driver = {
>> +               .name = LTRF216A_DRV_NAME,
> Ditto.
>
>> +               .pm = pm_ptr(&ltrf216a_pm_ops),
>> +               .of_match_table = ltrf216a_of_match,
>> +       },
>> +       .probe_new      = ltrf216a_probe,
>> +       .id_table       = ltrf216a_id,
>> +};
