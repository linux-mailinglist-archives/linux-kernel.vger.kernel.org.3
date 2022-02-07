Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3CDC4AC8E7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 19:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236167AbiBGSxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 13:53:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232506AbiBGSwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 13:52:22 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8FA07C0401DC
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 10:52:20 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4E1AD11FB;
        Mon,  7 Feb 2022 10:52:20 -0800 (PST)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8BD513F70D;
        Mon,  7 Feb 2022 10:52:18 -0800 (PST)
Date:   Mon, 7 Feb 2022 18:52:16 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, peter.hilber@opensynergy.com,
        igor.skalkin@opensynergy.com,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2 3/9] [RFC] virtio_ring: Embed a wrap counter in opaque
 poll index value
Message-ID: <20220207185216.GD2535@e120937-lin>
References: <20220201171601.53316-1-cristian.marussi@arm.com>
 <20220201171601.53316-4-cristian.marussi@arm.com>
 <20220201131434-mutt-send-email-mst@kernel.org>
 <20220203105105.GB2535@e120937-lin>
 <20220203063115-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220203063115-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2022 at 06:32:29AM -0500, Michael S. Tsirkin wrote:
> On Thu, Feb 03, 2022 at 10:51:19AM +0000, Cristian Marussi wrote:
> > On Tue, Feb 01, 2022 at 01:27:38PM -0500, Michael S. Tsirkin wrote:
> > > Looks correct, thanks. Some minor comments below:
> > > 
> > 
> > Hi Michael,
> > 
> > thanks for the feedback.
> > 

Hi Michael,

 
[snip]

> > > > @@ -806,6 +821,8 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
> > > >  	ret = vq->split.desc_state[i].data;
> > > >  	detach_buf_split(vq, i, ctx);
> > > >  	vq->last_used_idx++;
> > > > +	if (unlikely(!vq->last_used_idx))
> > > > +		vq->wraps++;
> > > >  	/* If we expect an interrupt for the next entry, tell host
> > > >  	 * by writing event index and flush out the write before
> > > >  	 * the read in the next get_buf call. */
> > > 
> > > So most drivers don't call virtqueue_poll.
> > > Concerned about the overhead here: another option is
> > > with a flag that will have to be set whenever a driver
> > > wants to use virtqueue_poll.
> > 
> > Do you mean a compile time flag/Kconfig to just remove the possible
> > overhead instructions as a whole when not needed by the driver ?
> > 
> > Or do you mean at runtime since checking the flag evry time should be
> > less costly than checking the wrpas each time AND counting when it
> > happens ?
> 
> The later.
> 
> > > Could you pls do a quick perf test e.g. using tools/virtio/
> > > to see what's faster?
> > 
> > Yes I'll do, thanks for the hint, I have some compilation issues in
> > tools/virtio due to my additions (missing mirrored hehaders) or to some
> > recently added stuff (missing drv_to_virtio & friends for
> > suppressed_used_validation thing)...anyway I fixed those now and I'll
> > post related tools/virtio patches with next iteration.
> > 
> > Anyway, do you mean perf data about vringh_test and virtio_test/vhost
> > right ? (ringtest/ excluded 'cause does not use any API is just
> > prototyping)
> 
> can be either or both, virtio_test/vhost is a bit easier to use.
> 

After a number of round tests with tools/virtio/virtio_test, below you can find
the most reliable results I had.

Using the flag as you suggested as in:

if (unlikely(vq->use_wrap_counter))
	vq->wraps += !vq->last_used_idx;


seems definitely better as per the result in virtio_test_flag_V1.

The last run with virtio_test_flag_V1 --wrap-counters is the case in which
the test code request to set the use_wrap_counter flag to true at start.

Since such flag is nothig spec related, I added a new EXPORT API

virtqueue_use_wrap_counter()

to allow a driver willing to use polling to ask for wrap counting at
probe time.

Since all of this required a few build-fixes in tool/virtio both before
and after my additions, I'm going to post the proposed change in a new series
independent from this SCMI virtio series (and add later the call to
virtqueue_use_wrap_counter() to the SCMI virtio driver.

How does this sound ?

Thanks,
Cristian

---
+ cset shield --exec -- perf stat --repeat 25 -- nice -n -20 /root/virtio_test_unpatched
 Performance counter stats for 'nice -n -20 /root/virtio_test_unpatched' (25 runs):

           6100.81 msec task-clock                #    1.002 CPUs utilized            ( +-  0.16% )
                19      context-switches          #    3.126 /sec                     ( +-  2.08% )
                 0      cpu-migrations            #    0.000 /sec                   
               134      page-faults               #   22.049 /sec                     ( +-  0.03% )
       18249525657      cycles                    #    3.003 GHz                      ( +-  0.07% )
       45583397473      instructions              #    2.52  insn per cycle           ( +-  0.09% )
       14009712668      branches                  #    2.305 G/sec                    ( +-  0.09% )
          10075872      branch-misses             #    0.07% of all branches          ( +-  0.83% )

            6.0908 +- 0.0107 seconds time elapsed  ( +-  0.18% )


+ cset shield --exec -- perf stat --repeat 25 -- nice -n -20 /root/virtio_test_wraps_noflag
 Performance counter stats for 'nice -n -20 /root/virtio_test_wraps_noflag' (25 runs):

           7982.99 msec task-clock                #    0.996 CPUs utilized            ( +-  0.14% )
                16      context-switches          #    1.999 /sec                     ( +-  2.56% )
                 0      cpu-migrations            #    0.000 /sec                   
               134      page-faults               #   16.744 /sec                     ( +-  0.03% )
       23691074946      cycles                    #    2.960 GHz                      ( +-  0.06% )
       68176350359      instructions              #    2.88  insn per cycle           ( +-  0.09% )
       21037768642      branches                  #    2.629 G/sec                    ( +-  0.09% )
           9083084      branch-misses             #    0.04% of all branches          ( +-  0.74% )

            8.0125 +- 0.0114 seconds time elapsed  ( +-  0.14% )


+ cset shield --exec -- perf stat --repeat 25 -- nice -n -20 /root/virtio_test_flag_V1
 Performance counter stats for 'nice -n -20 /root/virtio_test_flag_V1' (25 runs):

           6182.21 msec task-clock                #    1.007 CPUs utilized            ( +-  0.25% )
                19      context-switches          #    3.104 /sec                     ( +-  1.68% )
                 0      cpu-migrations            #    0.000 /sec                   
               134      page-faults               #   21.889 /sec                     ( +-  0.03% )
       18142274957      cycles                    #    2.963 GHz                      ( +-  0.13% )
       48973010013      instructions              #    2.71  insn per cycle           ( +-  0.18% )
       15064825126      branches                  #    2.461 G/sec                    ( +-  0.18% )
           8697800      branch-misses             #    0.06% of all branches          ( +-  0.89% )

            6.1382 +- 0.0172 seconds time elapsed  ( +-  0.28% )

+ cset shield --exec -- perf stat --repeat 25 -- nice -n -20 /root/virtio_test_flag_V1 --wrap-counters
 Performance counter stats for 'nice -n -20 /root/virtio_test_flag_V1 --wrap-counters' (25 runs):

           6051.58 msec task-clock                #    0.984 CPUs utilized            ( +-  0.22% )
                21      context-switches          #    3.424 /sec                     ( +-  1.25% )
                 0      cpu-migrations            #    0.000 /sec                   
               134      page-faults               #   21.846 /sec                     ( +-  0.03% )
       17928356478      cycles                    #    2.923 GHz                      ( +-  0.11% )
       48147192304      instructions              #    2.67  insn per cycle           ( +-  0.14% )
       14808798588      branches                  #    2.414 G/sec                    ( +-  0.15% )
           9108899      branch-misses             #    0.06% of all branches          ( +-  1.22% )

            6.1525 +- 0.0155 seconds time elapsed  ( +-  0.25% )


