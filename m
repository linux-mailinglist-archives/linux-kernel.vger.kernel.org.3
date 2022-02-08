Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8394ADC8D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 16:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380124AbiBHPZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 10:25:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380007AbiBHPZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 10:25:31 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E652EC061577
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 07:25:30 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD0CB2B;
        Tue,  8 Feb 2022 07:25:30 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4A5223F73B;
        Tue,  8 Feb 2022 07:25:29 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        virtualization@lists.linux-foundation.org
Cc:     sudeep.holla@arm.com, mst@redhat.com, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, peter.hilber@opensynergy.com,
        igor.skalkin@opensynergy.com, cristian.marussi@arm.com
Subject: [PATCH 0/4] Introduce optional VirtIO ring wrap counters
Date:   Tue,  8 Feb 2022 15:25:16 +0000
Message-Id: <20220208152520.52983-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

While using the current VirtIO API to optionally access the virtqueues in
polling mode, so as to able to send messages (SCMI commands and replies in
my case) in atomic context, it was pointed out in reviews that the current
VirtIO API based on virtqueue_poll() is prone to an ABA problem: in fact it
is possible, even though extremely unlikely, that, between two polling
iterations, the polled index (internal last_used_idx), moving away by
exactly 2^16 positions, rolls over into the same apparent exact index
position as in the previous polling iteration, so fooling the user into
thinking that nothing new has arrived. (while a whopping 2^16 msgs went by)

Patch 3/4 intend to mitigate this scenario by embedding a 16 bits wrap
counter in the upper 16 bits of the opaque value that is returned by
virtqueue_enable_cb_prepare and is, as usual, fed back to virtqueue_poll.

This way the ABA problem is indeed mitigated since it can now happen only
if a 2^32 'messages-wraparound' happen, which seems better enough.

Given that, as of now, the polling behaviour is really not required by
any driver but the SCMI VirtIO transport layer, the wrap counting in the
core virtio functions is conditional to a use_wrap_counter flag which is
false by default and must be explicitly enabled by a driver before
virtqueues are made ready (i.e. in the driver probe after the vqs have
been discovered).

In order to set such vq->use_wrap_counter flag a new API is exported
virtqueue_use_wrap_counter(). (given such flag is not really something
related to the specification inherently, but it is more of an
implementation issue...and sincerely I did not know where else to
configure it..)

The other patches in the series are related to tools/virtio fixes both
related to this series and to pre-existing build errors.

A new --wrap-counters option has been added to virtio_test to be able
to measure perfs with and without the flag set.

While testing on a QEMU-KVM x86 guest I saw a broad range of not-so-stable
perf results (to the point that in some run the patched code seemed a lot
[1/2 secs] faster than the original o_O, or with the same unpatched
original code reporting widely different result in two subsequent runs):
here down below you can find the most reliable perf data I was able to
gather takeing care to:

 - pinning QEMU to well defined CPUs
 - forcing such Host CPUs to use 'performance' governor
 - pinning guest virtio_test processes to some vCPUs with cpuset
   (or taskset)
 - disabling ASLR
 - disabling console printout

...anyway I still saw a bit of contrasting results here and there, so any
suggestion for a better VirtIO perf testbed setup is welcome.

Series is based on Linux 5.17-rc2.

Thanks,
Cristian

----

 cset shield --exec -- perf stat --repeat 25 -- nice -n -20 /root/virtio_test_unpatched 
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

 cset shield --exec -- perf stat --repeat 25 -- nice -n -20 /root/virtio_test_flag_V1
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

 cset shield --exec -- perf stat --repeat 25 -- nice -n -20 /root/virtio_test_flag_V1 --wrap-counters
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

Cristian Marussi (4):
  tools/virtio: Miscellaneous build fixes
  tools/virtio: Add missing spin_lock_init on virtio_test
  virtio_ring: Embed a wrap counter in opaque poll index value
  tools/virtio: Add virtqueue_use_wrap_counter support

 drivers/virtio/virtio_ring.c     |  88 ++++++++-
 include/linux/virtio.h           |   2 +
 tools/virtio/Makefile            |   2 +-
 tools/virtio/linux/bitfield.h    |  88 +++++++++
 tools/virtio/linux/bits.h        |  36 ++++
 tools/virtio/linux/mm_types.h    |   3 +
 tools/virtio/linux/module.h      |   1 +
 tools/virtio/linux/moduleparam.h |   7 +
 tools/virtio/linux/uio.h         | 299 ++++++++++++++++++++++++++++++-
 tools/virtio/linux/virtio.h      |  96 ++++++++++
 tools/virtio/virtio_test.c       |  39 +++-
 tools/virtio/vringh_test.c       |   3 +
 12 files changed, 655 insertions(+), 9 deletions(-)
 create mode 100644 tools/virtio/linux/bitfield.h
 create mode 100644 tools/virtio/linux/bits.h
 create mode 100644 tools/virtio/linux/mm_types.h
 create mode 100644 tools/virtio/linux/moduleparam.h

-- 
2.17.1

