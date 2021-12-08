Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2AA46D7CB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 17:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234103AbhLHQOL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 8 Dec 2021 11:14:11 -0500
Received: from protonic.xs4all.nl ([83.163.252.89]:58080 "EHLO
        protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbhLHQOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 11:14:09 -0500
Received: from erd992 (erd988.prtnl [192.168.224.30])
        by sparta.prtnl (Postfix) with ESMTP id 5ECBC44A024F;
        Wed,  8 Dec 2021 17:10:35 +0100 (CET)
Date:   Wed, 8 Dec 2021 17:10:35 +0100
From:   David Jander <david@protonic.nl>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     David Lechner <david@lechnology.com>, linux-iio@vger.kernel.org,
        Robin van der Gracht <robin@protonic.nl>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        linux-kernel@vger.kernel.org,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v1] counter: interrupt-cnt: add counter_push_event()
Message-ID: <20211208171035.6ad117af@erd992>
In-Reply-To: <20211208135902.7j3aawytt3jlqgwr@pengutronix.de>
References: <20211123134540.416695-1-o.rempel@pengutronix.de>
        <YZ3XAeYyfGblfaOi@shinobu>
        <20211124072720.GA30281@pengutronix.de>
        <YZ7tv79LQwLL7h3T@shinobu>
        <f73650b6-5a08-9ea9-9ecb-c47665ef07b0@lechnology.com>
        <20211207081602.45b1423c@erd992>
        <20211208135902.7j3aawytt3jlqgwr@pengutronix.de>
Organization: Protonic Holland
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Dear Uwe,

On Wed, 8 Dec 2021 14:59:02 +0100
Uwe Kleine-König <u.kleine-koenig@pengutronix.de> wrote:

> Hello David,
> 
> On Tue, Dec 07, 2021 at 08:16:02AM +0100, David Jander wrote:
> > On Mon, 6 Dec 2021 13:24:18 -0600
> > David Lechner <david@lechnology.com> wrote:
> >   
> > > On 11/24/21 7:58 PM, William Breathitt Gray wrote:  
> > > > On Wed, Nov 24, 2021 at 08:27:20AM +0100, Oleksij Rempel wrote:    
> > > >> Hi William,
> > > >>
> > > >> On Wed, Nov 24, 2021 at 03:09:05PM +0900, William Breathitt Gray wrote:    
> > > >>> On Tue, Nov 23, 2021 at 02:45:40PM +0100, Oleksij Rempel wrote:    
> > > >>>> Add counter_push_event() to notify user space about new pulses
> > > >>>>
> > > >>>> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > > >>>> ---
> > > >>>>   drivers/counter/interrupt-cnt.c | 2 ++
> > > >>>>   1 file changed, 2 insertions(+)
> > > >>>>
> > > >>>> diff --git a/drivers/counter/interrupt-cnt.c b/drivers/counter/interrupt-cnt.c
> > > >>>> index 8514a87fcbee..b237137b552b 100644
> > > >>>> --- a/drivers/counter/interrupt-cnt.c
> > > >>>> +++ b/drivers/counter/interrupt-cnt.c
> > > >>>> @@ -31,6 +31,8 @@ static irqreturn_t interrupt_cnt_isr(int irq, void *dev_id)
> > > >>>>   
> > > >>>>   	atomic_inc(&priv->count);
> > > >>>>   
> > > >>>> +	counter_push_event(&priv->counter, COUNTER_EVENT_OVERFLOW, 0);
> > > >>>> +
> > > >>>>   	return IRQ_HANDLED;
> > > >>>>   }
> > > >>>>   
> > > >>>> -- 
> > > >>>> 2.30.2    
> > > >>>
> > > >>> Hi Oleksij,
> > > >>>
> > > >>> It looks like this is pushing a COUNTER_EVENT_OVERFLOW event every time
> > > >>> an interrupt is handled, which I suspect is not what you want to happen.
> > > >>> The COUNTER_EVENT_OVERFLOW event indicates a count value overflow event,
> > > >>> so you'll need to check for a count value overflow before pushing the
> > > >>> event.
> > > >>>
> > > >>> It would be good idea to implement a ceiling extension as well (you can
> > > >>> use the COUNTER_COMP_CEILING() macro) so that users can configure the
> > > >>> particular point where the value overflows.    
> > > >>
> > > >> Thank you!
> > > >>
> > > >> What would be the best and resource effective strategy for periodically
> > > >> getting frequency of interrupts/pulses? This is actual information which is
> > > >> needed for my use case.
> > > >>
> > > >> So far, I was pushing every event to the user space, which is working
> > > >> but probably not the most resource effective method of doing it.
> > > >>
> > > >> Regards,
> > > >> Oleskij
> > > >> -- 
> > > >> Pengutronix e.K.                           |                             |
> > > >> Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
> > > >> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> > > >> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |    
> > > > 
> > > > We could introduce a new Counter change-of-state event type which would
> > > > trigger whenever the count value changes, but I agree with you that this
> > > > is likely not the best way for us to derive the frequency of the
> > > > interrupts due to the indirection of handling and parsing the event
> > > > data.
> > > > 
> > > > Instead, perhaps introducing a "frequency" or "period" Count extension
> > > > would make more sense here. This extension could report the value delta
> > > > between counts, or alternatively the time delta from which you can
> > > > derive frequency. Regarding implementation, you can store the previous
> > > > value in a variable, updating it whenever an interrupt occurs, and
> > > > compute the particular delta every time a read is requested by the user.
> > > > 
> > > > David Lechner is implementing something similar for the TI eQEP driver
> > > > to expose speed, so I'm CCing them here in case this is of interest to
> > > > them.
> > > >     
> > > 
> > > Based on my experience, I would recommend that counter drivers be as
> > > "thin" as possible. They shouldn't try to provide any information that
> > > the hardware itself doesn't provide. In other words, the kernel should
> > > provide userspace the information needed to calculate the speed/rate
> > > but not try to do the actual calculation in the kernel. Inevitably
> > > there are nuances for specific use cases that can't all possibly be
> > > handled by such an implementation.  
> > 
> > I completely agree with this. While interrupts aren't really meant for
> > measuring frequency, and this being somewhat of a mis-use of something, it is
> > still possible to do and very useful in many cases. That said, while the
> > counter framework is AFAIK the best fit for this, the main use-case for this
> > driver is measuring wheel speed (and similar "speeds"). For this, the minimum
> > amount of information the driver needs to provide user-space with to do
> > reliable calculations, is high-resolution time-stamps of GPIO events. A simple
> > counter is not suited, because there can be glitches that need to be detected.
> > If user-space gets a buffer full of consecutive time-stamps (don't need to be
> > all of them, just a sample of n consecutive timestamps), as well as total
> > count, all needed calculations, glitch filtering, low-pass filtering, etc...
> > can be done in user-space just fine.
> >   
> > > I've tried using gpio interrupts to try to calculate speed/rate in
> > > the kernel before and it simply doesn't work reliably. Interrupts
> > > get missed and the calculation will be off.  
> > 
> > Exactly. Been there, done that.
> > For reliable speed calculations of a mechanical system, the properties of the
> > mechanical system need to be known, like physical limits of accelerations,
> > maximum (or minimum) speed, etc. The minimum set of input data needed by a
> > user-space application to do these calculations is total pulse count in
> > addition to a buffer of timestamps of n consecutive input events (raising or
> > falling edges on GPIO). So IMHO this is what the driver should provide, and
> > in the most resource-efficient way possible. This particular driver will be
> > used 3 times on the same SoC, with each up to 10-15k pulses per second. That
> > is a lot of interrupts for an embedded system, so they better consume as
> > little resources as possible. Filling a ring buffer with timestamps should be
> > possible, as long as no locking is involved. Locks in IRQ context must be
> > avoided at all costs, specially in this case.
> >   
> > > For really slow counts (i.e. 1 count/second), I can see a use for
> > > generating an event on each count though. For high rates, I would
> > > just read the count every 100ms in usespace and divide the change in
> > > the number of counts by the time period to get the rate.  
> > 
> > For slow counts, I agree, but for high rates, I don't (see above). There can
> > be glitches and false events that can (and must) be effectively filtered out.
> > For that user-space needs to know the time of each event during the
> > measurement period.  
> 
> No sure I understood the problem here. If you keep the driver as is and
> in userspace just read out the counter value twice and measure the time
> between the reads[1], you can calculate the average frequency of the
> event in userspace.
> 
> Isn't that good enough?

No, I'm afraid it isn't, for two reasons:

1. These counters are often used in environments, where glitches can and do
happen. So sometimes there are fake events. The only way to tell fake from
real pulses, is to filter them. Unfortunately you need the timestamps of each
event for that.

2. Another reason for having time-stamps is the case when the frequency is low
and one still requires fast accurate measurements. In that case timestamps
provide a way of accurately measuring period time.

Best regards,

-- 
David Jander
Protonic Holland.
