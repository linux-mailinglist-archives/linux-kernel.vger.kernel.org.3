Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23D9347FE28
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 16:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237167AbhL0PQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 10:16:38 -0500
Received: from vern.gendns.com ([98.142.107.122]:52286 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230158AbhL0PQg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 10:16:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=7KpQx+h0Klvke6yJCfH0XVWhHPGXYISyGy9eJvRkX40=; b=bWyuT8u4FUvyURrgAvvZPbEzdp
        lDhANzNKbwXUymoRjOJZP43sAeUFYfzju39yryzBtasDhPBiht7nAWDaOQEWCagCL4xTIinhLT1An
        Wyh0X2nIW2Vinr7CUg0TqDNePatne24jukK8jAvJP6UT4xIEGkIN0ypBJV36jX2/wIbsfswizLpHV
        j/BmJzNtMd9MT83d19O/8BMpxxwkXtoGni1ctqlhZ/D8DYfVXla86GKK3ZbXn+K25J7QEQ4tweIzY
        HfYMAn8ARmaS4SQB5uiMyUwuNL6t0G/9IKmjR4Nfrv1WsE9GxDvgf3WwMAmXxOP8OIkwluazx+nZI
        x4q35APg==;
Received: from [2600:1700:4830:1658::fb2] (port=56210)
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <david@lechnology.com>)
        id 1n1rjj-000534-Db; Mon, 27 Dec 2021 10:16:34 -0500
Subject: Re: [PATCH v1] counter: interrupt-cnt: add counter_push_event()
To:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        David Jander <david@protonic.nl>
Cc:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-iio@vger.kernel.org,
        Robin van der Gracht <robin@protonic.nl>,
        linux-kernel@vger.kernel.org,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Jonathan Cameron <jic23@kernel.org>
References: <20211123134540.416695-1-o.rempel@pengutronix.de>
 <YZ3XAeYyfGblfaOi@shinobu> <20211124072720.GA30281@pengutronix.de>
 <YZ7tv79LQwLL7h3T@shinobu>
 <f73650b6-5a08-9ea9-9ecb-c47665ef07b0@lechnology.com>
 <20211207081602.45b1423c@erd992>
 <20211208135902.7j3aawytt3jlqgwr@pengutronix.de>
 <20211208171035.6ad117af@erd992> <Ybmr2kCLScuGZ41h@shinobu>
 <20211215100853.11f9262d@erd992> <YcaZEKbzRbX982YW@shinobu>
From:   David Lechner <david@lechnology.com>
Message-ID: <7a717808-2a06-975b-cd91-5362b784d0bf@lechnology.com>
Date:   Mon, 27 Dec 2021 09:16:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YcaZEKbzRbX982YW@shinobu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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

On 12/24/21 10:07 PM, William Breathitt Gray wrote:
> On Wed, Dec 15, 2021 at 10:08:53AM +0100, David Jander wrote:
>>
>> Dear William,
>>
>> On Wed, 15 Dec 2021 17:48:26 +0900
>> William Breathitt Gray <vilhelm.gray@gmail.com> wrote:
>>
>>> On Wed, Dec 08, 2021 at 05:10:35PM +0100, David Jander wrote:
>>>>
>>>> Dear Uwe,
>>>>
>>>> On Wed, 8 Dec 2021 14:59:02 +0100
>>>> Uwe Kleine-König <u.kleine-koenig@pengutronix.de> wrote:
>>>>    
>>>>> Hello David,
>>>>>
>>>>> On Tue, Dec 07, 2021 at 08:16:02AM +0100, David Jander wrote:
>>>>>> On Mon, 6 Dec 2021 13:24:18 -0600
>>>>>> David Lechner <david@lechnology.com> wrote:
>>>>>>      
>>>>>>> On 11/24/21 7:58 PM, William Breathitt Gray wrote:
>>>>>>>> On Wed, Nov 24, 2021 at 08:27:20AM +0100, Oleksij Rempel wrote:
>>>>>>>>> Hi William,
>>>>>>>>>
>>>>>>>>> On Wed, Nov 24, 2021 at 03:09:05PM +0900, William Breathitt Gray wrote:
>>>>>>>>>> On Tue, Nov 23, 2021 at 02:45:40PM +0100, Oleksij Rempel wrote:
>>>>>>>>>>> Add counter_push_event() to notify user space about new pulses
>>>>>>>>>>>
>>>>>>>>>>> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
>>>>>>>>>>> ---
>>>>>>>>>>>    drivers/counter/interrupt-cnt.c | 2 ++
>>>>>>>>>>>    1 file changed, 2 insertions(+)
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/drivers/counter/interrupt-cnt.c b/drivers/counter/interrupt-cnt.c
>>>>>>>>>>> index 8514a87fcbee..b237137b552b 100644
>>>>>>>>>>> --- a/drivers/counter/interrupt-cnt.c
>>>>>>>>>>> +++ b/drivers/counter/interrupt-cnt.c
>>>>>>>>>>> @@ -31,6 +31,8 @@ static irqreturn_t interrupt_cnt_isr(int irq, void *dev_id)
>>>>>>>>>>>    
>>>>>>>>>>>    	atomic_inc(&priv->count);
>>>>>>>>>>>    
>>>>>>>>>>> +	counter_push_event(&priv->counter, COUNTER_EVENT_OVERFLOW, 0);
>>>>>>>>>>> +
>>>>>>>>>>>    	return IRQ_HANDLED;
>>>>>>>>>>>    }
>>>>>>>>>>>    
>>>>>>>>>>> -- 
>>>>>>>>>>> 2.30.2
>>>>>>>>>>
>>>>>>>>>> Hi Oleksij,
>>>>>>>>>>
>>>>>>>>>> It looks like this is pushing a COUNTER_EVENT_OVERFLOW event every time
>>>>>>>>>> an interrupt is handled, which I suspect is not what you want to happen.
>>>>>>>>>> The COUNTER_EVENT_OVERFLOW event indicates a count value overflow event,
>>>>>>>>>> so you'll need to check for a count value overflow before pushing the
>>>>>>>>>> event.
>>>>>>>>>>
>>>>>>>>>> It would be good idea to implement a ceiling extension as well (you can
>>>>>>>>>> use the COUNTER_COMP_CEILING() macro) so that users can configure the
>>>>>>>>>> particular point where the value overflows.
>>>>>>>>>
>>>>>>>>> Thank you!
>>>>>>>>>
>>>>>>>>> What would be the best and resource effective strategy for periodically
>>>>>>>>> getting frequency of interrupts/pulses? This is actual information which is
>>>>>>>>> needed for my use case.
>>>>>>>>>
>>>>>>>>> So far, I was pushing every event to the user space, which is working
>>>>>>>>> but probably not the most resource effective method of doing it.
>>>>>>>>>
>>>>>>>>> Regards,
>>>>>>>>> Oleskij
>>>>>>>>> -- 
>>>>>>>>> Pengutronix e.K.                           |                             |
>>>>>>>>> Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
>>>>>>>>> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
>>>>>>>>> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
>>>>>>>>
>>>>>>>> We could introduce a new Counter change-of-state event type which would
>>>>>>>> trigger whenever the count value changes, but I agree with you that this
>>>>>>>> is likely not the best way for us to derive the frequency of the
>>>>>>>> interrupts due to the indirection of handling and parsing the event
>>>>>>>> data.
>>>>>>>>
>>>>>>>> Instead, perhaps introducing a "frequency" or "period" Count extension
>>>>>>>> would make more sense here. This extension could report the value delta
>>>>>>>> between counts, or alternatively the time delta from which you can
>>>>>>>> derive frequency. Regarding implementation, you can store the previous
>>>>>>>> value in a variable, updating it whenever an interrupt occurs, and
>>>>>>>> compute the particular delta every time a read is requested by the user.
>>>>>>>>
>>>>>>>> David Lechner is implementing something similar for the TI eQEP driver
>>>>>>>> to expose speed, so I'm CCing them here in case this is of interest to
>>>>>>>> them.
>>>>>>>>        
>>>>>>>
>>>>>>> Based on my experience, I would recommend that counter drivers be as
>>>>>>> "thin" as possible. They shouldn't try to provide any information that
>>>>>>> the hardware itself doesn't provide. In other words, the kernel should
>>>>>>> provide userspace the information needed to calculate the speed/rate
>>>>>>> but not try to do the actual calculation in the kernel. Inevitably
>>>>>>> there are nuances for specific use cases that can't all possibly be
>>>>>>> handled by such an implementation.
>>>>>>
>>>>>> I completely agree with this. While interrupts aren't really meant for
>>>>>> measuring frequency, and this being somewhat of a mis-use of something, it is
>>>>>> still possible to do and very useful in many cases. That said, while the
>>>>>> counter framework is AFAIK the best fit for this, the main use-case for this
>>>>>> driver is measuring wheel speed (and similar "speeds"). For this, the minimum
>>>>>> amount of information the driver needs to provide user-space with to do
>>>>>> reliable calculations, is high-resolution time-stamps of GPIO events. A simple
>>>>>> counter is not suited, because there can be glitches that need to be detected.
>>>>>> If user-space gets a buffer full of consecutive time-stamps (don't need to be
>>>>>> all of them, just a sample of n consecutive timestamps), as well as total
>>>>>> count, all needed calculations, glitch filtering, low-pass filtering, etc...
>>>>>> can be done in user-space just fine.
>>>>>>      
>>>>>>> I've tried using gpio interrupts to try to calculate speed/rate in
>>>>>>> the kernel before and it simply doesn't work reliably. Interrupts
>>>>>>> get missed and the calculation will be off.
>>>>>>
>>>>>> Exactly. Been there, done that.
>>>>>> For reliable speed calculations of a mechanical system, the properties of the
>>>>>> mechanical system need to be known, like physical limits of accelerations,
>>>>>> maximum (or minimum) speed, etc. The minimum set of input data needed by a
>>>>>> user-space application to do these calculations is total pulse count in
>>>>>> addition to a buffer of timestamps of n consecutive input events (raising or
>>>>>> falling edges on GPIO). So IMHO this is what the driver should provide, and
>>>>>> in the most resource-efficient way possible. This particular driver will be
>>>>>> used 3 times on the same SoC, with each up to 10-15k pulses per second. That
>>>>>> is a lot of interrupts for an embedded system, so they better consume as
>>>>>> little resources as possible. Filling a ring buffer with timestamps should be
>>>>>> possible, as long as no locking is involved. Locks in IRQ context must be
>>>>>> avoided at all costs, specially in this case.
>>>>>>      
>>>>>>> For really slow counts (i.e. 1 count/second), I can see a use for
>>>>>>> generating an event on each count though. For high rates, I would
>>>>>>> just read the count every 100ms in usespace and divide the change in
>>>>>>> the number of counts by the time period to get the rate.
>>>>>>
>>>>>> For slow counts, I agree, but for high rates, I don't (see above). There can
>>>>>> be glitches and false events that can (and must) be effectively filtered out.
>>>>>> For that user-space needs to know the time of each event during the
>>>>>> measurement period.
>>>>>
>>>>> No sure I understood the problem here. If you keep the driver as is and
>>>>> in userspace just read out the counter value twice and measure the time
>>>>> between the reads[1], you can calculate the average frequency of the
>>>>> event in userspace.
>>>>>
>>>>> Isn't that good enough?
>>>>
>>>> No, I'm afraid it isn't, for two reasons:
>>>>
>>>> 1. These counters are often used in environments, where glitches can and do
>>>> happen. So sometimes there are fake events. The only way to tell fake from
>>>> real pulses, is to filter them. Unfortunately you need the timestamps of each
>>>> event for that.
>>>>
>>>> 2. Another reason for having time-stamps is the case when the frequency is low
>>>> and one still requires fast accurate measurements. In that case timestamps
>>>> provide a way of accurately measuring period time.
>>>>
>>>> Best regards,
>>>>
>>>> -- 
>>>> David Jander
>>>> Protonic Holland.
>>>
>>> Keeping drivers focused on just exposing the hardware data and
>>> functionality is likely the best path to choose, so my earlier
>>> suggestion of a "frequency" extension would better be left for userspace
>>> to handle.
>>
>> I agree.
>>
>>> So in order to enable userspace to derive frequency, you need reliable
>>> timestamps for enough consecutive events to provide an adequate size
>>> sample of data on which to perform filtering and other such operations.
>>
>> Ack.
>>
>>> If we add a COUNTER_EVENT_CHANGE_OF_STATE or similar, every count change
>>> will generate an event with a logged timestamp. Is the problem with this
>>> solution primarily that the Counter event queue is currently utilizing
>>> spinlocks for synchronization?
>>
>> Yes. Basically, since one can expect a very high amount of IRQs, it seems
>> paramount to eliminate any source of latency (spinlocks, etc...) from
>> interrupt context as well as to keep CPU load as low as technically possible.
>>
>> If a spinlock is used, and at 10kHz pulses, on a moderately fast embedded SoC,
>> it is IMHO quite possible to have user-space cause the spinlock to be held for
>> more than 100 microseconds, thus causing a pulse to be missed. Not to mention
>> slight jitter introduced to the timestamps that can cause user-space to falsely
>> filter out events (a software PLL that doesn't correctly lock).
>>
>> The ideal ISR in this case would only take a timestamp from a hardware TSC (or
>> similarly latency-free direct source) and put it into a circular buffer
>> without using locks, and maybe increase an unsigned long counter value (atomic
>> operation if MB's are correctly used) and nothing else.
>> If, for example, such a solution would require user-space access CPU
>> load (complexity) to increase by a factor of 10 or even more (in order to
>> avoid locks), this is likely still preferable, since the ISR is executed maybe
>> 1000+ times more often than user-space accessing the driver.
>>
>> Best regards,
>>
>> -- 
>> David Jander
>> Protonic Holland.
> 
> So the counter_push_event() function interacts with two spinlocks:
> events_list_lock and events_in_lock. The events_list_lock spinlock is
> necessary because userspace can modify the events_list list via the
> counter_enable_events() and counter_disable_events() functions. The
> events_in_lock spinlock is necessary because userspace can modify the
> events kfifo via the counter_events_queue_size_write() function.
> 
> A lockless solution for this might be possible if the driver maintains
> its own circular buffer as you suggest. The driver's IRQ handler can
> write to this circular buffer without calling the counter_push_event()
> function, and then flush the buffer to the Counter character device via
> a userspace write to a "flush_events" sysfs attribute or similar; this
> eliminates the need for the events_in_lock spinlock. The state of the
> events_list list can be captured in the driver's events_configure()
> callback and stored locally in the driver for reference, thus
> eliminating the need for the events_list_lock; interrupts can be
> disabled before the driver's local copy of events_list is modified.
> 
> With only one reader and one writer operating on the driver's buffer,
> you can use the normal kfifo_in and kfifo_out calls for lockless
> operations. Perhaps that is a way forward for this problem.
> 

Would it be possible to make it so that userspace can't modify the
events_list when IRQs are enabled? Then we wouldn't have to add asecond event buffer.

IIRC, the only operations that modify events_list are when another
list replaces events_list when events are enabled and when
events_list is cleared when events are disabled. So as long as the
ordering is right with respect to enabling and disabling IRQs, it
seems like the spin lock should not be needed.
