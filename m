Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 161E44A70D2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 13:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344085AbiBBMcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 07:32:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiBBMcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 07:32:50 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E995C061714
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 04:32:50 -0800 (PST)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1nFEoU-0003vW-PT; Wed, 02 Feb 2022 13:32:42 +0100
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1nFEoT-00BkQb-8K; Wed, 02 Feb 2022 13:32:41 +0100
Date:   Wed, 2 Feb 2022 13:32:41 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     David Jander <david@protonic.nl>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        David Lechner <david@lechnology.com>,
        linux-iio@vger.kernel.org,
        Robin van der Gracht <robin@protonic.nl>,
        linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v1] counter: interrupt-cnt: add counter_push_event()
Message-ID: <Yfp56WznEMh7rp2O@pengutronix.de>
References: <YZ3XAeYyfGblfaOi@shinobu>
 <20211124072720.GA30281@pengutronix.de>
 <YZ7tv79LQwLL7h3T@shinobu>
 <f73650b6-5a08-9ea9-9ecb-c47665ef07b0@lechnology.com>
 <20211207081602.45b1423c@erd992>
 <20211208135902.7j3aawytt3jlqgwr@pengutronix.de>
 <20211208171035.6ad117af@erd992>
 <Ybmr2kCLScuGZ41h@shinobu>
 <20211215100853.11f9262d@erd992>
 <YcaZEKbzRbX982YW@shinobu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YcaZEKbzRbX982YW@shinobu>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 13:23:00 up 97 days, 18:50, 94 users,  load average: 3.46, 7.94,
 12.13
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi William,

On Sat, Dec 25, 2021 at 01:07:44PM +0900, William Breathitt Gray wrote:
... 
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

As proof of concept, I implemented the double buffered version with the
sysfs flush_events interface. Currently it feels kind of wired, I use
poll and wait until it timeouts to run the sysfs_flush_counter() to
trigger new data.

Here is example:
int main(void)
{
	ret = sysfs_enable_counter();
	...

	fd = open("/dev/counter0", O_RDWR);
	...

	ret = ioctl(fd, COUNTER_ADD_WATCH_IOCTL, watches);
	...

	ret = ioctl(fd, COUNTER_ENABLE_EVENTS_IOCTL);
	...

	for (;;) {
		struct pollfd fds[] = {
			{
				.fd = fd,
				.events = POLLIN,
			},
		};
		ssize_t i;

		/* wait for 10 sec */
		ret = poll(fds, ARRAY_SIZE(fds), DEFAULT_TIMEOUT_MS);
		if (ret == -EINTR)
			continue;
		else if (ret < 0)
			return -errno;
		else if (ret == 0) {
			sysfs_flush_counter(); <---- request to flush queued events from the driver
			continue;
		}

		ret = read(fd, event_data, sizeof(event_data));
		...

		for (i = 0; i < ret / (ssize_t)sizeof(event_data[0]); i++)
			/* process event */
			....
		}
	}

	return ret;
}

If it is still the only way to go, I'll send kernel patches.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
