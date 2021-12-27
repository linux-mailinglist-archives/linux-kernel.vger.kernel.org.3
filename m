Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2410047FC25
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 12:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236331AbhL0LVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 06:21:20 -0500
Received: from www381.your-server.de ([78.46.137.84]:39942 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233404AbhL0LVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 06:21:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=0lvuw0GyrsILeU4askHImfVv3TtmXjkExdJdQS5jdFQ=; b=FMo7SHm8KTF6wp2JPDJjBYSHAe
        a+ijfowOpOj/Yre5yx7JSLzSUsfIGuRMMV7lvjgQX9LuCEd4EDh63tdGeMEUsSDYse/6yhXlt6YCG
        MofXQ+5xxJ9vHyk0gqenU2LkJgP4/X82iFf5MkiZ1ED1Oo8xQXYmDWKhAZkrIFPjiQ/fcylngsQ1g
        9O1YQo5KeM70/OLbzrO53tUMG1QKiH9gHX/b4iC5BbRhHwahSvRXy46aPCd9GR8kG21PfZm3LxMkm
        3TTS08rh707xKvibEll/YHfkKORJK5bBidz+RQ05qLIhtoKN5aVbRSokG1fjaEcQGXbk8YXbpMgWX
        xTnq7Dhg==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1n1o43-000GZo-5k; Mon, 27 Dec 2021 12:21:15 +0100
Received: from [2001:a61:2bc8:8501:9e5c:8eff:fe01:8578]
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1n1o42-000WTb-Tl; Mon, 27 Dec 2021 12:21:14 +0100
Subject: Re: [PATCH v2 16/23] counter: interrupt-cnt: Convert to new counter
 registration
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Oleksij Rempel <linux@rempel-privat.de>
References: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
 <20211227094526.698714-17-u.kleine-koenig@pengutronix.de>
 <YcmcdftX3YO06nD1@kroah.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <7e3a4a67-4e97-8660-9437-0250588d5e5e@metafoo.de>
Date:   Mon, 27 Dec 2021 12:21:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YcmcdftX3YO06nD1@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.3/26404/Mon Dec 27 10:34:40 2021)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/27/21 11:59 AM, Greg Kroah-Hartman wrote:
> On Mon, Dec 27, 2021 at 10:45:19AM +0100, Uwe Kleine-König wrote:
>> This fixes device lifetime issues where it was possible to free a live
>> struct device.
>>
>> Fixes: a55ebd47f21f ("counter: add IRQ or GPIO based counter")
>> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>> ---
>>   drivers/counter/interrupt-cnt.c | 28 ++++++++++++++++------------
>>   1 file changed, 16 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/counter/interrupt-cnt.c b/drivers/counter/interrupt-cnt.c
>> index 4bf706ef46e2..9e99702470c2 100644
>> --- a/drivers/counter/interrupt-cnt.c
>> +++ b/drivers/counter/interrupt-cnt.c
>> @@ -16,7 +16,6 @@
>>   
>>   struct interrupt_cnt_priv {
>>   	atomic_t count;
>> -	struct counter_device counter;
>>   	struct gpio_desc *gpio;
>>   	int irq;
>>   	bool enabled;
>> @@ -148,12 +147,14 @@ static const struct counter_ops interrupt_cnt_ops = {
>>   static int interrupt_cnt_probe(struct platform_device *pdev)
>>   {
>>   	struct device *dev = &pdev->dev;
>> +	struct counter_device *counter;
>>   	struct interrupt_cnt_priv *priv;
>>   	int ret;
>>   
>> -	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>> -	if (!priv)
>> +	counter = devm_counter_alloc(dev, sizeof(*priv));
> I just picked one of these patches at random, nothing specific about
> this driver...
>
> You can not have a 'struct device' in memory allocated by devm_*()
> functions for the obvious reason that now that memory is being
> controlled by a reference count that is OUTSIDE of the structure itself.
>
> So while your goal might be good here, this is not the correct solution
> at all, sorry.

Before this patch the memory for the struct device was devm_kzalloc'ed. 
Which as you point out is a bug.

After this patch the memory is reference counted and will be freed when 
the last reference is dropped, in the release callback of the struct device.

The alloc function is still a devm_ function, but on 'free' it will only 
drop the reference to the struct device that it holds. This is a very 
common pattern that is used by basically any driver subsystem in the kernel.

This is the correct solution to the problem.

