Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2274F47BF53
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 13:05:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237397AbhLUMFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 07:05:07 -0500
Received: from www381.your-server.de ([78.46.137.84]:59816 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbhLUMFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 07:05:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=piV6SIE1+0IdMSZ7ySmRFXOklhct4UYro/BH75s56m4=; b=ErsanGshiTquvyXPP+8A3aoOk5
        TeyCHba9dP5FJUKQSq6ww37eXKqdfcpezwnDqa9hJtrLaWSv7mgeNTxKmeZ9nCJfrHAHqOgwNb+zU
        MAADUl2azg16xuh15qya0Ur1t/E45uup7IYGlM6qW/qKmabUy3iL/YpQekwqkQt0gr6G4m6+Me5Os
        PoupNivAQmB7eP2tIygJmF/80LdzU0o+ve7wqwXhbiRK452MjeSJaH2mGJZAvYY9Mz0hFJQYm6r/S
        yGGwrRk8HQQffgZqr0Yr3l624lfN6yydiZQLPfv5mpNGQE0ENxdLIxzIo0UlkUHZqWBB+mu6eUXg6
        5xzKK3/g==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1mzdsx-0006fC-6V; Tue, 21 Dec 2021 13:04:51 +0100
Received: from [2001:a61:2bc8:8501:9e5c:8eff:fe01:8578]
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1mzdsw-000FnK-Po; Tue, 21 Dec 2021 13:04:50 +0100
Subject: Re: [PATCH 0/8] counter: Remove struct counter_device::priv
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        David Lechner <david@lechnology.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Kamel Bouhara <kamel.bouhara@bootlin.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Patrick Havelange <patrick.havelange@essensium.com>,
        Syed Nayyar Waris <syednwaris@gmail.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
References: <20211221104546.214066-1-u.kleine-koenig@pengutronix.de>
 <dadb79b2-ac21-1899-48b9-1c6723afb1b4@metafoo.de>
 <20211221113542.rl4aburbzzrgs3km@pengutronix.de>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <65009237-7e61-21aa-60cd-b7f7e0bb2f91@metafoo.de>
Date:   Tue, 21 Dec 2021 13:04:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211221113542.rl4aburbzzrgs3km@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.3/26395/Tue Dec 21 10:18:41 2021)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/21/21 12:35 PM, Uwe Kleine-König wrote:
> Hello Lars,
>
> On Tue, Dec 21, 2021 at 12:12:12PM +0100, Lars-Peter Clausen wrote:
>> On 12/21/21 11:45 AM, Uwe Kleine-König wrote:
>>> similar to patch
>>> https://lore.kernel.org/r/4bde7cbd9e43a5909208102094444219d3154466.1640072891.git.vilhelm.gray@gmail.com
>>> the usage of struct counter_device::priv can be replaced by
>>> container_of which improves type safety and code size.
>>>
>>> This series depends on above patch, converts the remaining drivers and
>>> finally drops struct counter_device::priv.
>> Not sure if this is such a good idea. struct counter_device should not be
>> embedded in the drivers state struct in the first place.
> Just to mention it: My patch series didn't change this, this was already
> broken before.
I know, but this series has to be reverted when the framework is fixed.
>
>> struct counter_device contains a struct device, which is a reference counted
>> object. But by embedding it in the driver state struct the life time of both
>> the struct counter_device and and struct device are bound to the life time
>> of the driver state struct.
>>
>> Which means the struct device memory can get freed before the last reference
>> is dropped, which leads to a use-after-free and undefined behavior.
> Well, the driver struct is allocated using devm_kzalloc for all drivers.

devm_kzalloc() doesn't make a difference. The managed memory is freed 
when the parent device is unbound/removed. There may very well be 
reference to the counter_device at this point.

> So I think it's not *very* urgent to fix. Still you're right, this
> should be addressed.

Yes and no, this can trivially be used for privilege escalation, but 
then again on systems with a counter_device probably everything runs as 
root anyway.

>   
>> The framework should be changed to rather then embedding the struct
>> counter_device in the state struct to just have a pointer to it. With the
>> struct counter_device having its own allocation that will be freed when the
>> last reference to the struct device is dropped.
> My favourite would be to implement a counter_device_alloc /
> counter_device_add approach, similar to what spi_alloc_controller and
> alloc_etherdev do. The downside is that this isn't typesafe either :-\


