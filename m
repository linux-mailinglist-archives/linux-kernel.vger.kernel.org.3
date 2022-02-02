Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C0F4A7474
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 16:18:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345447AbiBBPSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 10:18:04 -0500
Received: from vern.gendns.com ([98.142.107.122]:40680 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229758AbiBBPSC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 10:18:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=mpoVInAtsv/YA6dQvqwdYD/Z/Z2uGxkkZTeDwQNf29E=; b=iaBhdHQcWhpOJXePxbidutIY6w
        pOgeWkUt8k2qwc2LpVp3ffIPJ9h++L3+AD6/YrZ078dVSA+OWoC8d4wTUOTbYygMoA42vBdtRRmnv
        BWfzJOXZT9L/YnDfuIT0kNfOn+cyrR7aflbwjJYFQEG1E14zosFKNbMB7O0rLcgSj6/Q3oOVUN+vn
        OASXKH10UHfRvPwgcuy9LLFmvSOJlVUxItCvb9UqAV0r/njHPHPULxNr66tX48ksEoBRvAv+IfTSJ
        JBwgdsULGeln3Og8NDsVpS4NZQWeQ3lRTRqcLjocFeLAvwqkgi4j8JH3WjQDeHSjdIDALTTNyqaS4
        KxCb/IkQ==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:52452 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <david@lechnology.com>)
        id 1nFHOK-0007JH-Mv; Wed, 02 Feb 2022 10:18:00 -0500
Subject: Re: [PATCH v1] counter: interrupt-cnt: add counter_push_event()
To:     Oleksij Rempel <o.rempel@pengutronix.de>,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     David Jander <david@protonic.nl>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-iio@vger.kernel.org,
        Robin van der Gracht <robin@protonic.nl>,
        linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Jonathan Cameron <jic23@kernel.org>
References: <YZ3XAeYyfGblfaOi@shinobu> <20211124072720.GA30281@pengutronix.de>
 <YZ7tv79LQwLL7h3T@shinobu>
 <f73650b6-5a08-9ea9-9ecb-c47665ef07b0@lechnology.com>
 <20211207081602.45b1423c@erd992>
 <20211208135902.7j3aawytt3jlqgwr@pengutronix.de>
 <20211208171035.6ad117af@erd992> <Ybmr2kCLScuGZ41h@shinobu>
 <20211215100853.11f9262d@erd992> <YcaZEKbzRbX982YW@shinobu>
 <Yfp56WznEMh7rp2O@pengutronix.de>
From:   David Lechner <david@lechnology.com>
Message-ID: <7a22b7c7-e5ac-7574-9d65-179ab605e4ca@lechnology.com>
Date:   Wed, 2 Feb 2022 09:17:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <Yfp56WznEMh7rp2O@pengutronix.de>
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

On 2/2/22 6:32 AM, Oleksij Rempel wrote:
> Hi William,
> 
> On Sat, Dec 25, 2021 at 01:07:44PM +0900, William Breathitt Gray wrote:
> ...
>> So the counter_push_event() function interacts with two spinlocks:
>> events_list_lock and events_in_lock. The events_list_lock spinlock is
>> necessary because userspace can modify the events_list list via the
>> counter_enable_events() and counter_disable_events() functions. The
>> events_in_lock spinlock is necessary because userspace can modify the
>> events kfifo via the counter_events_queue_size_write() function.
>>
>> A lockless solution for this might be possible if the driver maintains
>> its own circular buffer as you suggest. The driver's IRQ handler can
>> write to this circular buffer without calling the counter_push_event()
>> function, and then flush the buffer to the Counter character device via
>> a userspace write to a "flush_events" sysfs attribute or similar; this
>> eliminates the need for the events_in_lock spinlock. The state of the
>> events_list list can be captured in the driver's events_configure()
>> callback and stored locally in the driver for reference, thus
>> eliminating the need for the events_list_lock; interrupts can be
>> disabled before the driver's local copy of events_list is modified.
>>
>> With only one reader and one writer operating on the driver's buffer,
>> you can use the normal kfifo_in and kfifo_out calls for lockless
>> operations. Perhaps that is a way forward for this problem.
> 
> As proof of concept, I implemented the double buffered version with the
> sysfs flush_events interface. Currently it feels kind of wired, I use
> poll and wait until it timeouts to run the sysfs_flush_counter() to
> trigger new data.
> 
> Here is example:
> int main(void)
> {
> 	ret = sysfs_enable_counter();
> 	...
> 
> 	fd = open("/dev/counter0", O_RDWR);
> 	...
> 
> 	ret = ioctl(fd, COUNTER_ADD_WATCH_IOCTL, watches);
> 	...
> 
> 	ret = ioctl(fd, COUNTER_ENABLE_EVENTS_IOCTL);
> 	...
> 
> 	for (;;) {
> 		struct pollfd fds[] = {
> 			{
> 				.fd = fd,
> 				.events = POLLIN,
> 			},
> 		};
> 		ssize_t i;
> 
> 		/* wait for 10 sec */
> 		ret = poll(fds, ARRAY_SIZE(fds), DEFAULT_TIMEOUT_MS);
> 		if (ret == -EINTR)
> 			continue;
> 		else if (ret < 0)
> 			return -errno;
> 		else if (ret == 0) {
> 			sysfs_flush_counter(); <---- request to flush queued events from the driver
> 			continue;
> 		}
> 
> 		ret = read(fd, event_data, sizeof(event_data));
> 		...
> 
> 		for (i = 0; i < ret / (ssize_t)sizeof(event_data[0]); i++)
> 			/* process event */
> 			....
> 		}
> 	}
> 
> 	return ret;
> }
> 
> If it is still the only way to go, I'll send kernel patches.
> 
> Regards,
> Oleksij
> 

Couldn't the flush be implicit in the `read()` implementation
instead of requiring a separate sysfs attribute to trigger it?
