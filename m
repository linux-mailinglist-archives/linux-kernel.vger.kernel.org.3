Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB0752651A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 16:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381361AbiEMOpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 10:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382679AbiEMOnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 10:43:00 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44779233A66;
        Fri, 13 May 2022 07:39:06 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: shreeya)
        with ESMTPSA id A09621F41584
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652452745;
        bh=gRvN0U44G+s5wnTf9TatqIFny+dQW+BUWl7iXyoauxE=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=OWZFYyigA4guxjvhT5wFLWrOiPzQFXdLe47CmAdYSXFhhiWW0n2Hg+cHLUFxZQnxt
         4dEIAqyazU1VjLsft9Y4vJN6MUZ5wB9+9eO0+V5UAm39SWuN0mKGxTm5zY4KMq7nZi
         Cz++qKYNJJY/2tCloe9tLfIIQrmbVsIpilLrw8RmXGosFaT3ajgzyD7oLKer33wBVo
         QdurcSWDJw6bvr/E6mDYVZ9p1dTfGqFqpwGdDDbXBXqnpI6+EvIGV0vDHHOJjCHwIO
         bHJSPLX6cAehwl5NyXAh1Y66OTki9XPYkdpMYsvL0PKdFYJB59Gf0mTwdCU7TJGFxC
         dZ0jcN30Yz5aQ==
Message-ID: <0231ff5d-9bdd-03f2-cdf4-2b7b9b25609c@collabora.com>
Date:   Fri, 13 May 2022 20:08:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v4 3/3] iio: light: Add support for ltrf216a sensor
Content-Language: en-US
From:   Shreeya Patel <shreeya.patel@collabora.com>
To:     Dmitry Osipenko <digetx@gmail.com>, jic23@kernel.org,
        lars@metafoo.de, robh+dt@kernel.org, Zhigang.Shi@liteon.com,
        krisman@collabora.com, sebastian.reichel@collabora.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        alvaro.soliverez@collabora.com
References: <20220511094024.175994-1-shreeya.patel@collabora.com>
 <20220511094024.175994-4-shreeya.patel@collabora.com>
 <a5929558-d09a-cb67-cba9-1dcfb5e43525@gmail.com>
 <88b33ada-e997-05e9-f555-b9c1ed369fb7@collabora.com>
In-Reply-To: <88b33ada-e997-05e9-f555-b9c1ed369fb7@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 13/05/22 19:10, Shreeya Patel wrote:
>
> On 13/05/22 05:24, Dmitry Osipenko wrote:
>
> Hi Dmitry,
>
>> 11.05.2022 12:40, Shreeya Patel пишет:
>>> +static int ltrf216a_init(struct iio_dev *indio_dev)
>>> +{
>>> +    int ret;
>>> +    struct ltrf216a_data *data = iio_priv(indio_dev);
>>> +
>>> +    ret = i2c_smbus_read_byte_data(data->client, LTRF216A_MAIN_CTRL);
>>> +    if (ret < 0) {
>>> +        dev_err(&data->client->dev, "Error reading 
>>> LTRF216A_MAIN_CTRL\n");
>>> +        return ret;
>>> +    }
>>> +
>>> +    /* enable sensor */
>>> +    ret |= FIELD_PREP(LTRF216A_ALS_ENABLE_MASK, 1);
>>> +    ret = i2c_smbus_write_byte_data(data->client, 
>>> LTRF216A_MAIN_CTRL, ret);
>>> +    if (ret < 0) {
>>> +        dev_err(&data->client->dev, "Error writing 
>>> LTRF216A_MAIN_CTRL\n");
>>> +        return ret;
>>> +    }
>> Couldn't you write "1" directly without reading?
>>
>> What about doing SW reset?
>
> I think we are doing a read here just to make sure device registers 
> are ready and accessible
> without any issues.
>
I just came to know that in I2C communication, writing a single bit 
requires reading the old value (whole byte),
modifying the result (i.e. set or clear the bit one is interested in) 
and then write it back. So the above code writes
the enable bit without modifying the other bits in the 
LTRF216A_MAIN_CTRL register. ( Thanks to Sebastian )

And you are right, we don't need to do a read here since we anyway want 
all other bits of LTRF216A_MAIN_CTRL
to be 0.

Thanks,
Shreeya Patel


> Also, why would we want to do a SW reset here?
>
> In the datasheet, I could see the following steps to enable the sensor
> Supply VDD to Sensor (Sensor in Standby Mode) ---> Wait 100 ms (min) - 
> initial startup time
> ---> I2C Command (Write) To enable sensor to Active Mode
>
> Thanks,
> Shreeya Patel
>
>>
>
