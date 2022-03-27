Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D764E8808
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 16:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235725AbiC0OUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 10:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235719AbiC0OUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 10:20:09 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034702BC6;
        Sun, 27 Mar 2022 07:18:30 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 565A42223E;
        Sun, 27 Mar 2022 16:18:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1648390708;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PxpDUOFhL1SUBSr62jPOsTrvlFFA+tZHwHKSyP7WhK4=;
        b=H2SpbtP2QOiCk5fjg/c5u3qOTsQcD+LpFr571qZLPTdAsN7QXMTnMX50tKKAKW95kh9Jvo
        2r4sbkKxaCIYEF5Fps5LD67IQ9tt0S8kIryN6M7fvaN17MVUncArPt4M4/KubUfZu2XwO+
        8w6RtVP8UZjktefKXNKeahygcJedMUs=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 27 Mar 2022 16:18:28 +0200
From:   Michael Walle <michael@walle.cc>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 4/4] hwmon: add driver for the Microchip LAN966x SoC
In-Reply-To: <2442b460-4c6d-0ac9-af08-ae4c25aed812@roeck-us.net>
References: <20220326192347.2940747-1-michael@walle.cc>
 <20220326192347.2940747-5-michael@walle.cc>
 <2442b460-4c6d-0ac9-af08-ae4c25aed812@roeck-us.net>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <9aab54bc48284c9e20cd76085cb9d83a@walle.cc>
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

Am 2022-03-27 03:34, schrieb Guenter Roeck:

>> +	/*
>> +	 * Data is given in pulses per second. According to the hwmon ABI we
>> +	 * have to assume two pulses per revolution.
> 
> The hwmon ABI doesn't make any such assumptions. It wants to see RPM,
> that is all. Pulses per revolution is a fan property.

There is fanY_pulses according to 
Documentation/ABI/testing/sysfs-class-hwmon:

   Should only be created if the chip has a register to configure
   the number of pulses. In the absence of such a register (and
   thus attribute) the value assumed by all devices is 2 pulses
   per fan revolution.

The hardware returns just the pulses per second. Doesn't that
mean I have to divide that value by two?

>> +	 */
>> +	*val = FIELD_GET(FAN_CNT_DATA, data) * 60 / 2;

.. otherwise this should then be
*val = FIELD_GET(FAN_CNT_DATA, data) * 60;


>> +
>> +	return 0;
>> +}
>> +
>> +static int lan966x_hwmon_read_pwm(struct device *dev, long *val)
>> +{
>> +	struct lan966x_hwmon *hwmon = dev_get_drvdata(dev);
>> +	unsigned int data;
>> +	int ret;
>> +
>> +	ret = regmap_read(hwmon->regmap_fan, FAN_CFG, &data);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	*val = FIELD_GET(FAN_CFG_DUTY_CYCLE, data);
>> +
>> +	return 0;
>> +}
>> +
>> +static int lan966x_hwmon_read_pwm_freq(struct device *dev, long *val)
>> +{
>> +	struct lan966x_hwmon *hwmon = dev_get_drvdata(dev);
>> +	unsigned long rate = clk_get_rate(hwmon->clk);
> 
> Is that a dynamic frequency ? If not, it would be better to read it 
> once
> and store it in struct lan966x_hwmon.

yes it is configurable, actually. See lan966x_hwmon_write_pwm_freq().

-michael
