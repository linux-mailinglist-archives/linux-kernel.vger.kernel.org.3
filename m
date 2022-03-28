Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F12434E9577
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 13:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbiC1LqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 07:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243460AbiC1Lgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 07:36:33 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D9F201BB;
        Mon, 28 Mar 2022 04:28:14 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 18E1B2223A;
        Mon, 28 Mar 2022 13:28:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1648466893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0izGFsz6GTIJ5k2/n2+LlCxCAa9dPx6ye+X401jvCCo=;
        b=LA0PS2WzebEJVJScqJ1xVF2JEHiJGr2Rpc6A7e6LUh/msDLe1WTf0AZJuHkUhnqESnQh0g
        KV3h8UtNVnC8KTxYm5ylF0GRycj60zu9SwMX4uQTHSAOtB8Ovo5UbriTEX5jAkUmZTBUwT
        u9IWuJdw3C2E48QWNF4fAeScOCYpn8k=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Mon, 28 Mar 2022 13:28:12 +0200
From:   Michael Walle <michael@walle.cc>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 4/4] hwmon: add driver for the Microchip LAN966x SoC
In-Reply-To: <4455ca4c-1ebb-41df-5f04-72a48e8ca7dc@roeck-us.net>
References: <20220326192347.2940747-1-michael@walle.cc>
 <20220326192347.2940747-5-michael@walle.cc>
 <2442b460-4c6d-0ac9-af08-ae4c25aed812@roeck-us.net>
 <9aab54bc48284c9e20cd76085cb9d83a@walle.cc>
 <4455ca4c-1ebb-41df-5f04-72a48e8ca7dc@roeck-us.net>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <4e5c78ce651c258a4be33c01ec07a0c3@walle.cc>
X-Sender: michael@walle.cc
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-03-27 20:22, schrieb Guenter Roeck:
> On 3/27/22 07:18, Michael Walle wrote:
>> Am 2022-03-27 03:34, schrieb Guenter Roeck:
>> 
>>>> +    /*
>>>> +     * Data is given in pulses per second. According to the hwmon 
>>>> ABI we
>>>> +     * have to assume two pulses per revolution.
>>> 
>>> The hwmon ABI doesn't make any such assumptions. It wants to see RPM,
>>> that is all. Pulses per revolution is a fan property.
>> 
>> There is fanY_pulses according to 
>> Documentation/ABI/testing/sysfs-class-hwmon:
>> 
>>    Should only be created if the chip has a register to configure
>>    the number of pulses. In the absence of such a register (and
>>    thus attribute) the value assumed by all devices is 2 pulses
>>    per fan revolution.
>> 
>> The hardware returns just the pulses per second. Doesn't that
>> mean I have to divide that value by two?
>> 
> 
> The above refers to hardware which reports RPM.
> 
> It is up to the driver to calculate and return RPM. How you do it is 
> your
> decision. Drivers should report the most likely correct RPM value to
> userspace, one that rarely needs manual adjustment. Almost all fans
> report two pulses per revolution, so normally that assumption is used
> to convert PPM to RPM. That isn't mandated (or supposed to be mandated)
> by the ABI. I would call it common sense.
> 
> I'll be happy to accept a patch clarifying this.

Where would that go? into the sysfs abi description of the
fanY_input?

>>>> +     */
>>>> +    *val = FIELD_GET(FAN_CNT_DATA, data) * 60 / 2;
>> 
>> .. otherwise this should then be
>> *val = FIELD_GET(FAN_CNT_DATA, data) * 60;
>> 
> 
> If you really want to do this, make sure it is well documented that 
> users
> will need to adjust the fan speed via sensors3.conf to get the real fan 
> speed.
> 
>> 
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static int lan966x_hwmon_read_pwm(struct device *dev, long *val)
>>>> +{
>>>> +    struct lan966x_hwmon *hwmon = dev_get_drvdata(dev);
>>>> +    unsigned int data;
>>>> +    int ret;
>>>> +
>>>> +    ret = regmap_read(hwmon->regmap_fan, FAN_CFG, &data);
>>>> +    if (ret < 0)
>>>> +        return ret;
>>>> +
>>>> +    *val = FIELD_GET(FAN_CFG_DUTY_CYCLE, data);
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static int lan966x_hwmon_read_pwm_freq(struct device *dev, long 
>>>> *val)
>>>> +{
>>>> +    struct lan966x_hwmon *hwmon = dev_get_drvdata(dev);
>>>> +    unsigned long rate = clk_get_rate(hwmon->clk);
>>> 
>>> Is that a dynamic frequency ? If not, it would be better to read it 
>>> once
>>> and store it in struct lan966x_hwmon.
>> 
>> yes it is configurable, actually. See lan966x_hwmon_write_pwm_freq().
>> 
> 
> That is the pwm frequency, not the clock frequency. I don't see any
> code which updates the clock frequency reported by 
> clk_get_rate(hwmon->clk),
> ie I don't see a call to clk_set_rate().

Ahh sorry, missunderstood you. Yeah, in v2 it will be read
during probe.

-michael
