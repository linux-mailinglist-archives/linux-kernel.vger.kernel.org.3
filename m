Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD0D9529FD0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 12:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239813AbiEQKzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 06:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233495AbiEQKzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 06:55:21 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C8A93E5C4;
        Tue, 17 May 2022 03:55:20 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: shreeya)
        with ESMTPSA id 733811F417F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652784919;
        bh=OzW1IAdicjiRJe7jjcmuiLDwRUkXPi2uk9eLVcRy3/U=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XsuIX+SCjnh9NhpU3jHgJJhEIq5NU9r/7/sC9RotLk/4tWeZSGzliBEa5tHryMAzh
         X7i87+rMQQYbRrT9j+0Vi0+M89k9d60ACL/rAR/rEGWjXdxjOjYflS75CNN24tzngh
         MSucP55dULCl8vIULj9QNMPxUJsltkdp9otHweppLO6uzSajxqpMinseEiOTcGef06
         da8cTb4eDm7B//gutbd/F+W/74c2daYbvoq1/ZM8SpvSZFQ8QO/ZcIjT4uA722mav0
         +Ti0qZa+AY1/LUlkTBRf7r9W2ezEFEiTc62SRSK01Uo6u8PAfVZXflErEA3fjhOUHY
         hFyypKN8iayjQ==
Message-ID: <c18c9fee-9cc1-526c-3d4a-23b317d9bbff@collabora.com>
Date:   Tue, 17 May 2022 16:24:54 +0530
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
 <a54012e3-291b-42e8-752a-9abc9a88ad6c@gmail.com>
From:   Shreeya Patel <shreeya.patel@collabora.com>
In-Reply-To: <a54012e3-291b-42e8-752a-9abc9a88ad6c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 13/05/22 06:00, Dmitry Osipenko wrote:
> 11.05.2022 12:40, Shreeya Patel пишет:
>> +static int ltrf216a_set_int_time(struct ltrf216a_data *data, int itime)
>> +{
>> +	int i, ret, index = -1;
>> +	u8 reg_val;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(ltrf216a_int_time_available); i++) {
>> +		if (ltrf216a_int_time_available[i][1] == itime) {
>> +			index = i;
>> +			break;
>> +		}
>> +	}
>> +
>> +	if (index < 0)
>> +		return -EINVAL;
>> +
>> +	reg_val = ltrf216a_int_time_reg[index][1];
>> +	data->int_time_fac = ltrf216a_int_time_reg[index][0];
>> +
>> +	ret = i2c_smbus_write_byte_data(data->client, LTRF216A_ALS_MEAS_RES, reg_val);
>> +	if (ret < 0)
>> +		return ret;
> Should the data->int_time_fac be updated only if I2C write was successful?

Yes, thanks for pointing it out. It should be updated only if write is 
successful.

> I'm not sure what reading of LTRF216A_CLEAR_DATA reg does, but if it
> clears the measured data, then shouldn't the data be cleared after
> changing the config?

LTRF216A_CLEAR_DATA isn't used for clearing the measured data. Name is a
bit confusing and even I assumed it is being used for clearing the data. 
But from the
datasheet, it seems that clear data registers provides light intensity 
data related to infrared
and ultravoilet.
We are currently not using this anywhere in the driver so we could 
remove the cleardata readings
for now.


Thanks,
Shreeya Patel
>> +	data->int_time = itime;
>> +
>> +	return 0;
>> +}
>
