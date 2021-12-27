Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42DB147FC4A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 12:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233794AbhL0Lof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 06:44:35 -0500
Received: from www381.your-server.de ([78.46.137.84]:52948 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233644AbhL0Loe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 06:44:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=psg5+Dzo96XOyu7fltrYHxLgWyC+qu6AQZNSG2ZMtgs=; b=keAm/q9HABjsLb7g6jrhdBWE5c
        dJSkF5AwA0j5e/ucIuwaJJbM7lNSBFQGocvK32YBJxKL4I+pI17vJtmFGy4GufYI0IX1EU1yoGxRY
        4HMHUaCQIQTQjpUns7fCTa3Ud+xSysPokKzUcVKXfvhuekGFc67zY7upXEvWkOsHXQspVCxi3GgI7
        F+U27+Tg9glyPcNsbpHqD7DZytnQbdYMKJB0ogiHmIj/quJdlWGYrn1/OsctOCET9Klli6kbODccc
        tPHLOMhZ+nj/2V3X0hS56arKgAW4cgKd7tSbB+DnecbX0hq4Axp4kP2pji2U9zSrgOO51q6PiVLq5
        xp4T5lgw==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1n1oQY-0003Ye-6b; Mon, 27 Dec 2021 12:44:30 +0100
Received: from [2001:a61:2bc8:8501:9e5c:8eff:fe01:8578]
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1n1oQX-000QdJ-UA; Mon, 27 Dec 2021 12:44:29 +0100
Subject: Re: [PATCH v2 16/23] counter: interrupt-cnt: Convert to new counter
 registration
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Oleksij Rempel <linux@rempel-privat.de>
References: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
 <20211227094526.698714-17-u.kleine-koenig@pengutronix.de>
 <YcmcdftX3YO06nD1@kroah.com>
 <7e3a4a67-4e97-8660-9437-0250588d5e5e@metafoo.de>
 <YcmkwaeHBy9Jca+2@kroah.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <c9300c02-2704-4f46-9e1f-74665e6b6f8b@metafoo.de>
Date:   Mon, 27 Dec 2021 12:44:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YcmkwaeHBy9Jca+2@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.3/26404/Mon Dec 27 10:34:40 2021)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/27/21 12:34 PM, Greg Kroah-Hartman wrote:
> On Mon, Dec 27, 2021 at 12:21:14PM +0100, Lars-Peter Clausen wrote:
>> On 12/27/21 11:59 AM, Greg Kroah-Hartman wrote:
>>> On Mon, Dec 27, 2021 at 10:45:19AM +0100, Uwe Kleine-König wrote:
>>>> This fixes device lifetime issues where it was possible to free a live
>>>> struct device.
>>>>
>>>> Fixes: a55ebd47f21f ("counter: add IRQ or GPIO based counter")
>>>> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>>>> ---
>>>>    drivers/counter/interrupt-cnt.c | 28 ++++++++++++++++------------
>>>>    1 file changed, 16 insertions(+), 12 deletions(-)
>>>>
>>>> diff --git a/drivers/counter/interrupt-cnt.c b/drivers/counter/interrupt-cnt.c
>>>> index 4bf706ef46e2..9e99702470c2 100644
>>>> --- a/drivers/counter/interrupt-cnt.c
>>>> +++ b/drivers/counter/interrupt-cnt.c
>>>> @@ -16,7 +16,6 @@
>>>>    struct interrupt_cnt_priv {
>>>>    	atomic_t count;
>>>> -	struct counter_device counter;
>>>>    	struct gpio_desc *gpio;
>>>>    	int irq;
>>>>    	bool enabled;
>>>> @@ -148,12 +147,14 @@ static const struct counter_ops interrupt_cnt_ops = {
>>>>    static int interrupt_cnt_probe(struct platform_device *pdev)
>>>>    {
>>>>    	struct device *dev = &pdev->dev;
>>>> +	struct counter_device *counter;
>>>>    	struct interrupt_cnt_priv *priv;
>>>>    	int ret;
>>>> -	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>>>> -	if (!priv)
>>>> +	counter = devm_counter_alloc(dev, sizeof(*priv));
>>> I just picked one of these patches at random, nothing specific about
>>> this driver...
>>>
>>> You can not have a 'struct device' in memory allocated by devm_*()
>>> functions for the obvious reason that now that memory is being
>>> controlled by a reference count that is OUTSIDE of the structure itself.
>>>
>>> So while your goal might be good here, this is not the correct solution
>>> at all, sorry.
>> Before this patch the memory for the struct device was devm_kzalloc'ed.
>> Which as you point out is a bug.
>>
>> After this patch the memory is reference counted and will be freed when the
>> last reference is dropped, in the release callback of the struct device.
>>
>> The alloc function is still a devm_ function, but on 'free' it will only
>> drop the reference to the struct device that it holds. This is a very common
>> pattern that is used by basically any driver subsystem in the kernel.
> Then it is not a real devm_() call, let's not call it that please as it
> is obviously very confusing :)
>
> Just call it counter_alloc(), or , counter_create(), or something a bit
> more in line with the rest of all driver subsystems.

But all the other driver subsystems call this kind of function devm_... :)

Usually for everything you call in probe() you need a corresponding 
action in remove(). With the devm_... function is remove action will be 
automatically called.

