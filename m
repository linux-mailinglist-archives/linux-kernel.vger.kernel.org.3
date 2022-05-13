Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFB752631F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 15:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347203AbiEMNuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 09:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378060AbiEMNkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 09:40:16 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8922B13FAB;
        Fri, 13 May 2022 06:40:14 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: shreeya)
        with ESMTPSA id 20E7E1F4608A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652449212;
        bh=X8gPJfUaPvojokUrQ1VToFmt1LKmH1dH4HkLO7C9KHE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=CyYDwTVi4ueHyg/u7jL4r3bByMb9muNVhf6HiSrmSxIDn3/qh1ZgF4hKY0Ve7GJTq
         NC1TSrTlB0lJuLsY2sFbzJpb7CwAoZBX0oqpF+p+IoGrcmuxmm/RBCHxEvQNnRllOO
         f5yX2BHYZ/IrsOovE3YL32ovPyEW6ZlcM3IPTwl/kLyR35Qe59iDQHoDp8A/LKH2iD
         nR8JyJJTEq6MZdtGHIqxLN1c9ppxEPIWfe9YXO6NTCvN0WhWiOJsb4BvRTwE0KkAou
         aCv0jmHfaxIHZ/tqMfw2g1XqFG0zSiWl/Nthk3dmXLdzOxl1e91/cGnjMnjWHQQMP9
         7GELqEiEDvEzQ==
Message-ID: <88b33ada-e997-05e9-f555-b9c1ed369fb7@collabora.com>
Date:   Fri, 13 May 2022 19:10:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v4 3/3] iio: light: Add support for ltrf216a sensor
Content-Language: en-US
To:     Dmitry Osipenko <digetx@gmail.com>, jic23@kernel.org,
        lars@metafoo.de, robh+dt@kernel.org, Zhigang.Shi@liteon.com,
        krisman@collabora.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        alvaro.soliverez@collabora.com
References: <20220511094024.175994-1-shreeya.patel@collabora.com>
 <20220511094024.175994-4-shreeya.patel@collabora.com>
 <a5929558-d09a-cb67-cba9-1dcfb5e43525@gmail.com>
From:   Shreeya Patel <shreeya.patel@collabora.com>
In-Reply-To: <a5929558-d09a-cb67-cba9-1dcfb5e43525@gmail.com>
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


On 13/05/22 05:24, Dmitry Osipenko wrote:

Hi Dmitry,

> 11.05.2022 12:40, Shreeya Patel пишет:
>> +static int ltrf216a_init(struct iio_dev *indio_dev)
>> +{
>> +	int ret;
>> +	struct ltrf216a_data *data = iio_priv(indio_dev);
>> +
>> +	ret = i2c_smbus_read_byte_data(data->client, LTRF216A_MAIN_CTRL);
>> +	if (ret < 0) {
>> +		dev_err(&data->client->dev, "Error reading LTRF216A_MAIN_CTRL\n");
>> +		return ret;
>> +	}
>> +
>> +	/* enable sensor */
>> +	ret |= FIELD_PREP(LTRF216A_ALS_ENABLE_MASK, 1);
>> +	ret = i2c_smbus_write_byte_data(data->client, LTRF216A_MAIN_CTRL, ret);
>> +	if (ret < 0) {
>> +		dev_err(&data->client->dev, "Error writing LTRF216A_MAIN_CTRL\n");
>> +		return ret;
>> +	}
> Couldn't you write "1" directly without reading?
>
> What about doing SW reset?

I think we are doing a read here just to make sure device registers are 
ready and accessible
without any issues.

Also, why would we want to do a SW reset here?

In the datasheet, I could see the following steps to enable the sensor
Supply VDD to Sensor (Sensor in Standby Mode) ---> Wait 100 ms (min) - 
initial startup time
---> I2C Command (Write) To enable sensor to Active Mode

Thanks,
Shreeya Patel

>
