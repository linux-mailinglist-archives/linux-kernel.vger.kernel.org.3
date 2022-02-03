Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49B2D4A7FE5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 08:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349416AbiBCHfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 02:35:13 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:38449 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239925AbiBCHfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 02:35:10 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1nFWTW-0007TF-6f; Thu, 03 Feb 2022 08:24:14 +0100
Received: from ore by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1nFWTT-0005dv-4m; Thu, 03 Feb 2022 08:24:11 +0100
Date:   Thu, 3 Feb 2022 08:24:11 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     David Lechner <david@lechnology.com>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        David Jander <david@protonic.nl>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-iio@vger.kernel.org,
        Robin van der Gracht <robin@protonic.nl>,
        linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v1] counter: interrupt-cnt: add counter_push_event()
Message-ID: <20220203072411.GA12695@pengutronix.de>
References: <YZ7tv79LQwLL7h3T@shinobu>
 <f73650b6-5a08-9ea9-9ecb-c47665ef07b0@lechnology.com>
 <20211207081602.45b1423c@erd992>
 <20211208135902.7j3aawytt3jlqgwr@pengutronix.de>
 <20211208171035.6ad117af@erd992>
 <Ybmr2kCLScuGZ41h@shinobu>
 <20211215100853.11f9262d@erd992>
 <YcaZEKbzRbX982YW@shinobu>
 <Yfp56WznEMh7rp2O@pengutronix.de>
 <7a22b7c7-e5ac-7574-9d65-179ab605e4ca@lechnology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7a22b7c7-e5ac-7574-9d65-179ab605e4ca@lechnology.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 08:04:33 up 54 days, 15:50, 44 users,  load average: 0.23, 0.46,
 0.28
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2022 at 09:17:57AM -0600, David Lechner wrote:
> On 2/2/22 6:32 AM, Oleksij Rempel wrote:
> > Hi William,
> > 
> > On Sat, Dec 25, 2021 at 01:07:44PM +0900, William Breathitt Gray wrote:
> > ...
> > > So the counter_push_event() function interacts with two spinlocks:
> > > events_list_lock and events_in_lock. The events_list_lock spinlock is
> > > necessary because userspace can modify the events_list list via the
> > > counter_enable_events() and counter_disable_events() functions. The
> > > events_in_lock spinlock is necessary because userspace can modify the
> > > events kfifo via the counter_events_queue_size_write() function.
> > > 
> > > A lockless solution for this might be possible if the driver maintains
> > > its own circular buffer as you suggest. The driver's IRQ handler can
> > > write to this circular buffer without calling the counter_push_event()
> > > function, and then flush the buffer to the Counter character device via
> > > a userspace write to a "flush_events" sysfs attribute or similar; this
> > > eliminates the need for the events_in_lock spinlock. The state of the
> > > events_list list can be captured in the driver's events_configure()
> > > callback and stored locally in the driver for reference, thus
> > > eliminating the need for the events_list_lock; interrupts can be
> > > disabled before the driver's local copy of events_list is modified.
> > > 
> > > With only one reader and one writer operating on the driver's buffer,
> > > you can use the normal kfifo_in and kfifo_out calls for lockless
> > > operations. Perhaps that is a way forward for this problem.
> > 
> > As proof of concept, I implemented the double buffered version with the
> > sysfs flush_events interface. Currently it feels kind of wired, I use
> > poll and wait until it timeouts to run the sysfs_flush_counter() to
> > trigger new data.
> > 
> > Here is example:
> > int main(void)
> > {
> > 	ret = sysfs_enable_counter();
> > 	...
> > 
> > 	fd = open("/dev/counter0", O_RDWR);
> > 	...
> > 
> > 	ret = ioctl(fd, COUNTER_ADD_WATCH_IOCTL, watches);
> > 	...
> > 
> > 	ret = ioctl(fd, COUNTER_ENABLE_EVENTS_IOCTL);
> > 	...
> > 
> > 	for (;;) {
> > 		struct pollfd fds[] = {
> > 			{
> > 				.fd = fd,
> > 				.events = POLLIN,
> > 			},
> > 		};
> > 		ssize_t i;
> > 
> > 		/* wait for 10 sec */
> > 		ret = poll(fds, ARRAY_SIZE(fds), DEFAULT_TIMEOUT_MS);
> > 		if (ret == -EINTR)
> > 			continue;
> > 		else if (ret < 0)
> > 			return -errno;
> > 		else if (ret == 0) {
> > 			sysfs_flush_counter(); <---- request to flush queued events from the driver
> > 			continue;
> > 		}
> > 
> > 		ret = read(fd, event_data, sizeof(event_data));
> > 		...
> > 
> > 		for (i = 0; i < ret / (ssize_t)sizeof(event_data[0]); i++)
> > 			/* process event */
> > 			....
> > 		}
> > 	}
> > 
> > 	return ret;
> > }
> > 
> > If it is still the only way to go, I'll send kernel patches.
> > 
> > Regards,
> > Oleksij
> > 
> 
> Couldn't the flush be implicit in the `read()` implementation
> instead of requiring a separate sysfs attribute to trigger it?

Hm...

To detect pulse frequency, I need a burst of sequential time-stamps
without drops. In case the pulse frequency is higher then the use space
is able to get it out of FIFO, we will get high number of drops. 
So, we do not need all time stamps. Only bunch of them without drops in
the middle.

I know, at some frequency we wont be able to collect all pulses any way.
Internal FIFO is just increasing the max detectable frequency. So, it is
sort of optimization.

My current driver version has own FIFO which is filled directly by the
IRQ handler and user space trigger flush_cb to push all collected
time stamps. The main question is: how the flush procedure should be
controlled. We have following options:

- Attach it to the read(). The disadvantage: at high frequencies, we
  wont be able to get a burst with time stamps without drops in the
  middle
- Trigger flush from user space. In this case, we make user space a bit
  more complicated and cant really get all advantages of poll().
- kernel driver is using own timer to trigger flush. The timer can be
  configured from user space. The advantage of it, the user space is
  simple and has full advantage of using poll()

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
