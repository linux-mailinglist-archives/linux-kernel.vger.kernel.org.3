Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9395046A5E8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 20:45:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347486AbhLFTtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 14:49:10 -0500
Received: from vern.gendns.com ([98.142.107.122]:43066 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245093AbhLFTtJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 14:49:09 -0500
X-Greylist: delayed 1277 seconds by postgrey-1.27 at vger.kernel.org; Mon, 06 Dec 2021 14:49:08 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=YA/G+b1h/jbDVfkm8Yg0kCmi1TBIab78m8yWhAJ7R8o=; b=R+9y0NUMqiKrlPN4lpSoyvz0fW
        jQbGzn4WAxDZQzG8I009nr2DImAIOnDschwKKikKKwdlzMpHZ5QVQ0EpD4VLy1Pu+k4SO/MgVUqXF
        EaK20+oa6tj/o1Vr38Yf1U1LW9L0DBc1a33iDrBjr/LQQY9obm2aPxactXiOKB1i8JSCxYLW++Y05
        MmDAWB6Zuxd4meS8LzKhexhcIGE2++8lgrtO5is/Vjnrkt4JQYutniZK6bi93ZMhGfqxw40X4Tk2u
        ShHGe/kMWn5xayGFsmntw0VMmX+UhiV1FiOMI57xnQrHC5H/KnKvuOJAzGqYhcfmHVioUax6bJE41
        9CuqpwKQ==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:49508 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <david@lechnology.com>)
        id 1muJaz-0005Ni-JU; Mon, 06 Dec 2021 14:24:20 -0500
Subject: Re: [PATCH v1] counter: interrupt-cnt: add counter_push_event()
To:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     linux-iio@vger.kernel.org,
        Robin van der Gracht <robin@protonic.nl>,
        linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Jonathan Cameron <jic23@kernel.org>
References: <20211123134540.416695-1-o.rempel@pengutronix.de>
 <YZ3XAeYyfGblfaOi@shinobu> <20211124072720.GA30281@pengutronix.de>
 <YZ7tv79LQwLL7h3T@shinobu>
From:   David Lechner <david@lechnology.com>
Message-ID: <f73650b6-5a08-9ea9-9ecb-c47665ef07b0@lechnology.com>
Date:   Mon, 6 Dec 2021 13:24:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YZ7tv79LQwLL7h3T@shinobu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/24/21 7:58 PM, William Breathitt Gray wrote:
> On Wed, Nov 24, 2021 at 08:27:20AM +0100, Oleksij Rempel wrote:
>> Hi William,
>>
>> On Wed, Nov 24, 2021 at 03:09:05PM +0900, William Breathitt Gray wrote:
>>> On Tue, Nov 23, 2021 at 02:45:40PM +0100, Oleksij Rempel wrote:
>>>> Add counter_push_event() to notify user space about new pulses
>>>>
>>>> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
>>>> ---
>>>>   drivers/counter/interrupt-cnt.c | 2 ++
>>>>   1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/drivers/counter/interrupt-cnt.c b/drivers/counter/interrupt-cnt.c
>>>> index 8514a87fcbee..b237137b552b 100644
>>>> --- a/drivers/counter/interrupt-cnt.c
>>>> +++ b/drivers/counter/interrupt-cnt.c
>>>> @@ -31,6 +31,8 @@ static irqreturn_t interrupt_cnt_isr(int irq, void *dev_id)
>>>>   
>>>>   	atomic_inc(&priv->count);
>>>>   
>>>> +	counter_push_event(&priv->counter, COUNTER_EVENT_OVERFLOW, 0);
>>>> +
>>>>   	return IRQ_HANDLED;
>>>>   }
>>>>   
>>>> -- 
>>>> 2.30.2
>>>
>>> Hi Oleksij,
>>>
>>> It looks like this is pushing a COUNTER_EVENT_OVERFLOW event every time
>>> an interrupt is handled, which I suspect is not what you want to happen.
>>> The COUNTER_EVENT_OVERFLOW event indicates a count value overflow event,
>>> so you'll need to check for a count value overflow before pushing the
>>> event.
>>>
>>> It would be good idea to implement a ceiling extension as well (you can
>>> use the COUNTER_COMP_CEILING() macro) so that users can configure the
>>> particular point where the value overflows.
>>
>> Thank you!
>>
>> What would be the best and resource effective strategy for periodically
>> getting frequency of interrupts/pulses? This is actual information which is
>> needed for my use case.
>>
>> So far, I was pushing every event to the user space, which is working
>> but probably not the most resource effective method of doing it.
>>
>> Regards,
>> Oleskij
>> -- 
>> Pengutronix e.K.                           |                             |
>> Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
>> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
>> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
> 
> We could introduce a new Counter change-of-state event type which would
> trigger whenever the count value changes, but I agree with you that this
> is likely not the best way for us to derive the frequency of the
> interrupts due to the indirection of handling and parsing the event
> data.
> 
> Instead, perhaps introducing a "frequency" or "period" Count extension
> would make more sense here. This extension could report the value delta
> between counts, or alternatively the time delta from which you can
> derive frequency. Regarding implementation, you can store the previous
> value in a variable, updating it whenever an interrupt occurs, and
> compute the particular delta every time a read is requested by the user.
> 
> David Lechner is implementing something similar for the TI eQEP driver
> to expose speed, so I'm CCing them here in case this is of interest to
> them.
> 

Based on my experience, I would recommend that counter drivers be as
"thin" as possible. They shouldn't try to provide any information that
the hardware itself doesn't provide. In other words, the kernel should
provide userspace the information needed to calculate the speed/rate
but not try to do the actual calculation in the kernel. Inevitably
there are nuances for specific use cases that can't all possibly be
handled by such an implementation.

I've tried using gpio interrupts to try to calculate speed/rate in
the kernel before and it simply doesn't work reliably. Interrupts
get missed and the calculation will be off.

For really slow counts (i.e. 1 count/second), I can see a use for
generating an event on each count though. For high rates, I would
just read the count every 100ms in usespace and divide the change in
the number of counts by the time period to get the rate.



