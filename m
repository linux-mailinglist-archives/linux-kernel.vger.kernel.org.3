Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3090F549A19
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 19:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236412AbiFMRbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 13:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243998AbiFMRat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 13:30:49 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85399A1BB;
        Mon, 13 Jun 2022 05:53:03 -0700 (PDT)
Received: from [10.5.50.66] (unknown [103.108.5.209])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: shreeya)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 630BB6601653;
        Mon, 13 Jun 2022 13:52:58 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655124782;
        bh=wPVPeG0ehxwVBRfqVV1QMdSaUZUBQIBEq78jW56sV4o=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=AHeKSLCh5eGkJ6D/hN2EP4Yw6oO71wW7futn/cYMYl+/EHU1HMYTBq2KWP25QeJYS
         KpPSlsjloVqRuoWomCv8cOFP3HP8LJeViwFTu6NDLfNqKWnE1eIhGBuiZzShkaEcZI
         kepTO0cxJCDBB3x2B5WrO0FmQDm9xWdBJxslOluN158viHJUdPxTSAleqQgaR3chE7
         D4dOU/oDyOS+Rj6dIrW/cEfNkRc+shCKUZIOZYSv/Gr1dbJpm891MeYCKojBgddlw+
         OKmWCiBA+RINm9Hx9qAQ0J4Hzd1HkIvLWMUCeQB10P31sixFMrjTuy2qbsZtHutRVa
         oeJn2dn7VnLmA==
Message-ID: <a4334956-deca-d2cc-7bbd-6e5f305b9e35@collabora.com>
Date:   Mon, 13 Jun 2022 18:22:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v5 2/2] iio: light: Add support for ltrf216a sensor
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>, Zhigang.Shi@liteon.com,
        krisman@collabora.com, linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        alvaro.soliverez@collabora.com, Dmitry Osipenko <digetx@gmail.com>
References: <20220608113553.32083-1-shreeya.patel@collabora.com>
 <20220608113553.32083-3-shreeya.patel@collabora.com>
 <CAHp75VcpHO-_Dghdc0VFjT=us-95h1b03Jmg32odJuuJZRy8aA@mail.gmail.com>
From:   Shreeya Patel <shreeya.patel@collabora.com>
In-Reply-To: <CAHp75VcpHO-_Dghdc0VFjT=us-95h1b03Jmg32odJuuJZRy8aA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 08/06/22 21:46, Andy Shevchenko wrote:
> On Wed, Jun 8, 2022 at 1:37 PM Shreeya Patel
> <shreeya.patel@collabora.com> wrote:
>> From: Zhigang Shi <Zhigang.Shi@liteon.com>
>>
>> Add initial support for ltrf216a ambient light sensor.
>>
>> Datasheet: gitlab.steamos.cloud/shreeya/iio/-/blob/main/LTRF216A.pdf
> https?
>
> ...
>
>> +#define LTRF216A_ALS_READ_DATA_DELAY   20000
> What units?
>
> ...
>
>> +/* Window Factor is needed when device is under Window glass
> the device
>
>> + * with coated tinted ink. This is to compensate the light loss
> for the?
>
>> + * due to the lower transmission rate of the window glass.
>> + */
> /*
>   * Multi-line comments should look
>   * like this very example. Find the difference.
>   */
>
> ...
>
>> +static int ltrf216a_init(struct iio_dev *indio_dev)
>> +{
>> +       struct ltrf216a_data *data = iio_priv(indio_dev);
>> +       int ret = 0;
> Useless assignment.
>
>> +
>> +       /* enable sensor */
>> +       ret |= FIELD_PREP(LTRF216A_ALS_ENABLE_MASK, 1);
> This is bad code. Use another variable with distinguashable name.
>
>> +       ret = i2c_smbus_write_byte_data(data->client, LTRF216A_MAIN_CTRL, ret);
> Can this driver utilize regmap I2C?

Thanks for all your comments and yes we can use the regmap I2C
but the plan is to get the basic version merged and then I'll be sending
patches for any enhancements that we'd like to do.



Thanks,
Shreeya Patel

>
>> +       if (ret < 0)
>> +               dev_err(&data->client->dev,
>> +                       "Error writing to LTRF216A_MAIN_CTRL while enabling the sensor: %d\n", ret);
>> +
>> +       return ret;
>> +}
> ...
>
>> +static int ltrf216a_disable(struct iio_dev *indio_dev)
>> +{
>> +       struct ltrf216a_data *data = iio_priv(indio_dev);
>> +       int ret = 0;
> Useless assignment.
>
>> +       ret = i2c_smbus_write_byte_data(data->client, LTRF216A_MAIN_CTRL, 0);
>> +       if (ret < 0)
>> +               dev_err(&data->client->dev,
>> +                       "Error writing to LTRF216A_MAIN_CTRL while disabling the sensor: %d\n",
>> +                       ret);
> With a temporary variable for the device this may be located on one line.
> Same for the similar cases.
>
>> +       return ret;
>> +}
> ...
>
>> +#ifdef CONFIG_PM
> Why? Can't it be hidden by using pm_sleep_ptr() or alike?
>
>> +static int ltrf216a_set_power_state(struct ltrf216a_data *data, bool on)
>> +{
>> +       struct device *dev = &data->client->dev;
>> +       int ret = 0, suspended;
> Useless assignment. Please, go thru all your code and drop these
> potentially dangerous assignments.
>
>> +
>> +       if (on) {
>> +               suspended = pm_runtime_suspended(dev);
>> +               ret = pm_runtime_get_sync(dev);
>> +
>> +               /* Allow one integration cycle before allowing a reading */
>> +               if (suspended)
>> +                       msleep(ltrf216a_int_time_reg[0][0]);
>> +       } else {
>> +               pm_runtime_mark_last_busy(dev);
>> +               ret = pm_runtime_put_autosuspend(dev);
>> +       }
>> +
>> +       return ret;
>> +}
>> +#else
>> +static int ltrf216a_set_power_state(struct ltrf216a_data *data, bool on)
>> +{
>> +       return 0;
>> +}
>> +#endif
>> +
>> +int ltrf216a_check_for_data(struct i2c_client *client)
>> +{
>> +       int ret;
>> +
>> +       ret = i2c_smbus_read_byte_data(client, LTRF216A_MAIN_STATUS);
>> +       if (ret < 0) {
>> +               dev_err(&client->dev, "Failed to read LTRF216A_MAIN_STATUS register: %d\n", ret);
>> +               return ret;
> Dup.
>
>> +       }
>> +
>> +       return ret;
>> +}
> ...
>
>> +#ifdef CONFIG_PM_SLEEP
> Oh, please no.
>
>> +#endif
> ...
>
>> +static const struct dev_pm_ops ltrf216a_pm_ops = {
>> +       SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
>> +                               pm_runtime_force_resume)
>> +       SET_RUNTIME_PM_OPS(ltrf216a_runtime_suspend,
>> +                          ltrf216a_runtime_resume, NULL)
>> +};
> Use pm_sleep_ptr() and corresponding top-level macros.
>
