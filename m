Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63680495577
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 21:39:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377665AbiATUjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 15:39:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36361 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229701AbiATUjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 15:39:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642711161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ntrYMeN6pl5yWZvzZ3V4QM6g66eYCG9Ga0nZ73KJC1k=;
        b=VOXlGQ32H+sc4UreuTLXfdFhhfhZev2Vnt/3tEjLmUe7OZ9adCFh/WEQM0hk7uqG9E29eC
        xzcNqxZojyaygK8HIhNGNQ9a3xTzGM9VDdWxhGEEUvtN3HZsgZECp8QocfvxLTExPKAWvL
        COl5F2ogCSG9UH4b/RydZqIaHE2QVqQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-558-KuEkGkyINvy2nnKP9UjGeA-1; Thu, 20 Jan 2022 15:39:20 -0500
X-MC-Unique: KuEkGkyINvy2nnKP9UjGeA-1
Received: by mail-wm1-f71.google.com with SMTP id b134-20020a1c1b8c000000b0034e0874e828so1680750wmb.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 12:39:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ntrYMeN6pl5yWZvzZ3V4QM6g66eYCG9Ga0nZ73KJC1k=;
        b=a3ttJ8EUW4XqDhvTJgBb7e0vh1MSKdXtSGBf8k3MYIbhGJBKGC/Z0hVSb/Kp/BjGjq
         9FpDcnthX9jyWMYqlmo45iHR53V3iyUgtMkBxYh41ZkG54zINaGkNJNhpsu2E50L9l1P
         u0ZMO1tsMORdpbBhs43//0HaNzuRhu7ad2ZzbqVzLpR3v/cBx03841i6w4tIn1wAjKms
         pzvAJPLCsrTMbIZQx1nNo0ZHK+QaDSVdGcWV7QwkwEVfJ2TALSl8H/aJRqbrOXntbgOJ
         SPbCvlJdhpQ2qqcY27k0/hxjpOw5GGRzud2GXYrAaOsLEwQftn1eHbqkKdYKGAY6QklZ
         cyEg==
X-Gm-Message-State: AOAM531e8NIbxSFP+pYkovc3y+Zri3rUarZjtDmoCp4q2HA+riZYdiFK
        6YW3D15mqW2ClKilDezKOclmeEOInc/RUbuFc/u/vkNIMvVz6mWfjplgnyKja6fNZN0XmRnFBVx
        eBqX2PZxz7ONq4z2PbDSbgkCl
X-Received: by 2002:a05:600c:b58:: with SMTP id k24mr10696392wmr.47.1642711159203;
        Thu, 20 Jan 2022 12:39:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyEU3AJ1MJ37HmYik7y2xEv9ymA+ChFMYK53evSZLFYotO4fNcJ7hcEvE9AiCo/v2DXA2gnCg==
X-Received: by 2002:a05:600c:b58:: with SMTP id k24mr10696382wmr.47.1642711158959;
        Thu, 20 Jan 2022 12:39:18 -0800 (PST)
Received: from redhat.com ([2.55.159.47])
        by smtp.gmail.com with ESMTPSA id u9sm8250777wmc.11.2022.01.20.12.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 12:39:17 -0800 (PST)
Date:   Thu, 20 Jan 2022 15:39:12 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Peter Hilber <peter.hilber@opensynergy.com>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, igor.skalkin@opensynergy.com,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v9 09/11] firmware: arm_scmi: Add atomic mode support to
 virtio transport
Message-ID: <20220120150418-mutt-send-email-mst@kernel.org>
References: <20211220195646.44498-10-cristian.marussi@arm.com>
 <20211221140027.41524-1-cristian.marussi@arm.com>
 <f231094a-6f34-3dc1-237d-97218e8fde91@opensynergy.com>
 <20220119122338.GE6113@e120937-lin>
 <2f1ea794-a0b9-2099-edc0-b2aeb3ca6b92@opensynergy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f1ea794-a0b9-2099-edc0-b2aeb3ca6b92@opensynergy.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 08:09:56PM +0100, Peter Hilber wrote:
> On 19.01.22 13:23, Cristian Marussi wrote:
> > On Tue, Jan 18, 2022 at 03:21:03PM +0100, Peter Hilber wrote:
> >> On 21.12.21 15:00, Cristian Marussi wrote:
> >>> Add support for .mark_txdone and .poll_done transport operations to SCMI
> >>> VirtIO transport as pre-requisites to enable atomic operations.
> >>>
> >>> Add a Kernel configuration option to enable SCMI VirtIO transport polling
> >>> and atomic mode for selected SCMI transactions while leaving it default
> >>> disabled.
> >>>
> >>
> >> Hi Cristian,
> >>
> >> thanks for the update. I have some more remarks inline below.
> >>
> > 
> > Hi Peter,
> > 
> > thanks for your review, much appreciated, please see my replies online.
> > 
> >> My impression is that the virtio core does not expose helper functions suitable
> >> to busy-poll for used buffers. But changing this might not be difficult. Maybe
> >> more_used() from virtio_ring.c could be exposed via a wrapper?
> >>
> > 
> > While I definitely agree that the virtio core support for polling is far from
> > ideal, some support is provided and my point was at first to try implement SCMI
> > virtio polling leveraging what we have now in the core and see if it was attainable
> > (indeed I tried early in this series to avoid as a whole to have to support polling
> > at the SCMI transport layer to attain SCMI cmds atomicity..but that was an ill
> > attempt that led nowhere good...)
> > 
> > Btw, I was planning to post a new series next week (after merge-windows) with some
> > fixes I did already, at this point I'll include also some fixes derived
> > from some of your remarks.
> > 
> >> Best regards,
> >>
> >> Peter
> >>
> [snip]>>> + *
> >>> + * Return: True once polling has successfully completed.
> >>> + */
> >>> +static bool virtio_poll_done(struct scmi_chan_info *cinfo,
> >>> +			     struct scmi_xfer *xfer)
> >>> +{
> >>> +	bool pending, ret = false;
> >>> +	unsigned int length, any_prefetched = 0;
> >>> +	unsigned long flags;
> >>> +	struct scmi_vio_msg *next_msg, *msg = xfer->priv;
> >>> +	struct scmi_vio_channel *vioch = cinfo->transport_info;
> >>> +
> >>> +	if (!msg)
> >>> +		return true;
> >>> +
> >>> +	spin_lock_irqsave(&msg->poll_lock, flags);
> >>> +	/* Processed already by other polling loop on another CPU ? */
> >>> +	if (msg->poll_idx == VIO_MSG_POLL_DONE) {
> >>> +		spin_unlock_irqrestore(&msg->poll_lock, flags);
> >>> +		return true;
> >>> +	}
> >>> +
> >>> +	/* Has cmdq index moved at all ? */
> >>> +	pending = virtqueue_poll(vioch->vqueue, msg->poll_idx);
> >>
> >> In my understanding, the polling comparison could still be subject to the ABA
> >> problem when exactly 2**16 messages have been marked as used since
> >> msg->poll_idx was set (unlikely scenario, granted).
> >>
> >> I think this would be a lot simpler if the virtio core exported some
> >> concurrency-safe helper function for such polling (similar to more_used() from
> >> virtio_ring.c), as discussed at the top.
> > 
> > So this is the main limitation indeed of the current implementation, I
> > cannot distinguish if there was an exact full wrap and I'm reading the same
> > last_idx as before but a whoppying 2**16 messages have instead gone through...
> > 
> > The tricky part seems to me here that even introducing dedicated helpers
> > for polling in order to account for such wrapping (similar to more_used())
> > those would be based by current VirtIO spec on a single bit wrap counter,
> > so how do you discern if 2 whole wraps have happened (even more unlikely..) ?
> > 
> > Maybe I'm missing something though...
> > 
> 
> In my understanding, there is no need to keep track of the old state. We
> actually only want to check whether the device has marked any buffers as `used'
> which we did not retrieve yet via virtqueue_get_buf_ctx().
> 
> This is what more_used() checks in my understanding. One would just need to
> translate the external `struct virtqueue' param to the virtio_ring.c internal
> representation `struct vring_virtqueue' and then call `more_used()'.
> 
> There would be no need to keep `poll_idx` then.
> 
> Best regards,
> 
> Peter

Not really, I don't think so.

There's no magic in more_used. No synchronization happens.
more_used is exactly like virtqueue_poll except
you get to maintain your own index.

As it is, it is quite possible to read the cached index,
then another thread makes 2^16 bufs available, then device
uses them all, and presto you get a false positive.

I guess we can play with memory barriers such that cache
read happens after the index read - but it seems that
will just lead to the same wrap around problem
in reverse. So IIUC it's quite a bit more involved than
just translating structures.

And yes, a more_used like API would remove the need to pass
the index around, but it will also obscure the fact that
there's internal state here and that it's inherently racy
wrt wrap arounds. Whereas I'm happy to see that virtqueue_poll
seems to have made it clear enough that people get it.


It's not hard to handle wrap around in the driver if you like though:
just have a 32 bit atomic counter and increment it each time you are
going to make 2^16 buffers available. That gets you to 2^48 with an
overhead of an atomic read and that should be enough short term. Make
sure the cache line where you put the counter is not needed elsewhere -
checking it in a tight loop with an atomic will force it to the local
CPU. And if you are doing that virtqueue_poll will be enough.



> 
> > I'll have a though about this, but in my opinion this seems something so
> > unlikely that we could live with it, for the moment at least...
> > [snip]

