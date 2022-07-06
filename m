Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1B556956D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 00:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbiGFWsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 18:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbiGFWsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 18:48:31 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF4D17E01;
        Wed,  6 Jul 2022 15:48:30 -0700 (PDT)
Received: from [IPV6:2405:201:10:3153:7fbd:8a7b:29b6:89fb] (unknown [IPv6:2405:201:10:3153:7fbd:8a7b:29b6:89fb])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: shreeya)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 13F866601967;
        Wed,  6 Jul 2022 23:48:21 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657147708;
        bh=h45Gv9/CBtzMhLWXtaV5EArlpDe5KGn5W/AUow9ryTI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=KSjgbooxPNxwaYS1MTiF2wiKX2iCIrppsfJiX6P6cjynAcrwKMqowMksARnRDr4VY
         8jwyDPOXnb83gWybzHD33MAUcpO5Eai7tyr4Tfq/TLZFM+RcfERFGc2PHr9QtnK69M
         ibpB/fX9Tfp0U8ph2C5khkrp1Bc11Wsdf404Yq3CRw5o8Ri/N/zI2ptdJd7xJHG2VO
         29gdAPYJylfQZ96CIRoji6i+1ddpSr41syhqbMjNlNjEzDs7nnHnpHz6OwQOoSVcoA
         k6AKaHGUIc+NoAf81vuuoEaIb/AR4a2kMJN0iCeDIiJh5AVMhoryh3ooHrejg5/E92
         dvqQK5cP9uJHQ==
Message-ID: <f5e0a2a8-f206-e493-df7e-080ddec6a03f@collabora.com>
Date:   Thu, 7 Jul 2022 04:18:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v6 2/2] iio: light: Add support for ltrf216a sensor
Content-Language: en-US
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>, jic23@kernel.org,
        lars@metafoo.de, robh+dt@kernel.org, Zhigang.Shi@liteon.com,
        krisman@collabora.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        alvaro.soliverez@collabora.com, andy.shevchenko@gmail.com,
        digetx@gmail.com, kernel test robot <lkp@intel.com>
References: <20220615135130.227236-1-shreeya.patel@collabora.com>
 <20220615135130.227236-3-shreeya.patel@collabora.com>
 <60b6965b-7a14-8b7c-c9b9-c463fc0ad88c@collabora.com>
From:   Shreeya Patel <shreeya.patel@collabora.com>
In-Reply-To: <60b6965b-7a14-8b7c-c9b9-c463fc0ad88c@collabora.com>
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


On 07/07/22 02:39, Dmitry Osipenko wrote:
> On 6/15/22 16:51, Shreeya Patel wrote:
>> +static int ltrf216a_probe(struct i2c_client *client)
>> +{
>> +	struct ltrf216a_data *data;
>> +	struct iio_dev *indio_dev;
>> +	int ret;
>> +
>> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
>> +	if (!indio_dev)
>> +		return -ENOMEM;
>> +
>> +	data = iio_priv(indio_dev);
>> +	i2c_set_clientdata(client, indio_dev);
>> +	data->client = client;
>> +
>> +	mutex_init(&data->lock);
>> +
>> +	indio_dev->info = &ltrf216a_info;
>> +	indio_dev->name = LTRF216A_DRV_NAME;
>> +	indio_dev->channels = ltrf216a_channels;
>> +	indio_dev->num_channels = ARRAY_SIZE(ltrf216a_channels);
>> +	indio_dev->modes = INDIO_DIRECT_MODE;
>> +
>> +	/* reset sensor, chip fails to respond to this, so ignore any errors */
>> +	ltrf216a_reset(indio_dev);
> Shouldn't SW resetting be done after enabling sensor? Perhaps that's why
> it fails to respond?


We tried to reset the device through i2c-tool to see if that works :-

(root@steamdeck ~)# i2cset -f 0 0x53 0x00 0x10
warning! This program can confuse your i2c bus, cause data loss and worse!
Dangerous! Writing to a serial eeprom on a memory dimm
may render your memory useless and make your system unbootable!
I will write to device file /dev/i2c-0, chip address 0x53,
data address 0x00, data 0x10, mode byte.
Continue? [y/n] y
error: write failed
(1)(b+)(root@steamdeck ~)#

But the problem here is that the light sensor resets itself 
instantaneously while the i2c transaction is still in progress.
So it never replies with the proper stop bit that is expected at the end 
of a transaction. Hence, we decided to ignore
the error.


Thanks,
Shreeya Patel
>
