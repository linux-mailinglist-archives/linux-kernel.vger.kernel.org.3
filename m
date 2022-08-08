Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBB158CE47
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 21:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244210AbiHHTFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 15:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236838AbiHHTFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 15:05:50 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDEDE1F;
        Mon,  8 Aug 2022 12:05:48 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id E81532224F;
        Mon,  8 Aug 2022 21:05:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1659985547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9jzDzcair3ObU6jjVtN9JrVQdO9IqV9O9cxNAy1EWsQ=;
        b=EA5Zde1jaGtDz4kuSUT8cQ7hayTtawRfJC+kw5Nm3lOaXM6equOhzHZc5rVKC4CKybY+eS
        hZ+zPyNt3cXtnYcviOgoBhOw0SbeIBj0NKra2GhgMzo3nfB3a8h69MLn9s2Qy3FtkDM2uS
        PaoxeQ+wnyaMR+zj0GPy/3gtcDrIms8=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 08 Aug 2022 21:05:46 +0200
From:   Michael Walle <michael@walle.cc>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org,
        dan.carpenter@oracle.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 2/4] thermal/of: Return -ENODEV instead of -EINVAL if
 registration fails
In-Reply-To: <f8008f05-4e4d-e21f-2e40-e234930ee86e@roeck-us.net>
References: <20220808180915.446053-1-daniel.lezcano@linaro.org>
 <20220808180915.446053-2-daniel.lezcano@linaro.org>
 <f8008f05-4e4d-e21f-2e40-e234930ee86e@roeck-us.net>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <d676c6533e11ac357a8aaca4ba216b6d@walle.cc>
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

Am 2022-08-08 20:35, schrieb Guenter Roeck:
> On 8/8/22 11:09, Daniel Lezcano wrote:
>> The previous version of the OF code was returning -ENODEV if no
>> thermal zones description was found or if the lookup of the sensor in
>> the thermal zones was not found.
>> 
>> The backend drivers are expecting this return value as an information
>> about skipping the sensor initialization and considered as normal.
>> 
>> Fix the return value by replacing -EINVAL by -ENODEV
>> 
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>   drivers/thermal/thermal_of.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/thermal/thermal_of.c 
>> b/drivers/thermal/thermal_of.c
>> index 368eb58e97cf..4210c18ef7b2 100644
>> --- a/drivers/thermal/thermal_of.c
>> +++ b/drivers/thermal/thermal_of.c
>> @@ -329,7 +329,7 @@ static struct device_node 
>> *of_thermal_zone_find(struct device_node *sensor, int
>>   	np = of_find_node_by_name(NULL, "thermal-zones");
>>   	if (!np) {
>>   		pr_err("Unable to find thermal zones description\n");
> 
> I really don't like that error message: People will see it (and 
> complain)
> whenever a sensor registers and there is no thermal zone, even though 
> that
> is perfectly normal (see description above).

I can second that, and there actually two error messages:

[    6.156983] thermal_sys: Unable to find thermal zones description
[    6.163125] thermal_sys: Failed to find thermal zone for hwmon id=0

On the sl28 board with the qoriq_thermal driver:
[    1.917940] thermal_sys: Failed to find thermal zone for tmu id=2
[    1.929231] thermal_sys: Failed to find thermal zone for tmu id=3
[    1.940519] thermal_sys: Failed to find thermal zone for tmu id=4
[    1.951814] thermal_sys: Failed to find thermal zone for tmu id=5
[    1.963109] thermal_sys: Failed to find thermal zone for tmu id=6
[    1.974399] thermal_sys: Failed to find thermal zone for tmu id=7
[    1.985690] thermal_sys: Failed to find thermal zone for tmu id=8
[    1.996980] thermal_sys: Failed to find thermal zone for tmu id=9
[    2.008274] thermal_sys: Failed to find thermal zone for tmu id=10
[    2.019656] thermal_sys: Failed to find thermal zone for tmu id=11
[    2.031037] thermal_sys: Failed to find thermal zone for tmu id=12
[    2.048942] thermal_sys: Failed to find thermal zone for tmu id=13
[    2.060320] thermal_sys: Failed to find thermal zone for tmu id=14
[    2.071700] thermal_sys: Failed to find thermal zone for tmu id=15

Btw. the driver seems to always register 16 sensors regardless how
many the actual hardware has (or rather: are described in the DT).

-michael
