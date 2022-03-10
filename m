Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5FE4D4DF5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 17:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236698AbiCJQBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 11:01:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239872AbiCJQAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 11:00:54 -0500
X-Greylist: delayed 2526 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Mar 2022 07:59:52 PST
Received: from iris.vrvis.at (iris.vrvis.at [92.60.8.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F6C1662FD
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 07:59:51 -0800 (PST)
Received: from [10.43.0.34]
        by iris.vrvis.at with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <valentin@vrvis.at>)
        id 1nSKXp-0001fg-JI; Thu, 10 Mar 2022 16:17:38 +0100
Message-ID: <07bafc71-a6d2-ad6d-4706-7c99047b3228@vrvis.at>
Date:   Thu, 10 Mar 2022 16:17:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-US
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Justin Sanders <justin@coraid.com>,
        Jens Axboe <axboe@kernel.dk>
From:   Valentin Kleibel <valentin@vrvis.at>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
Subject: [PATCH] block: aoe: handle device timeouts atomic-safe
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an aoe device does not respond to any packet on the network layer 
within aoe_deadsecs, the driver tries to mark the device as down, fail 
all I/O and clean out the queue.

This currently produces a "BUG: scheduling while atomic" and never finishes.
relevant dmesg output:
[....]
[  408.620155] blk_update_request: I/O error, dev etherd/e42.0, sector
4096 op 0x0:(READ) flags 0x0 phys_seg 2 prio class 0
[  408.620235] blk_update_request: I/O error, dev etherd/e42.0, sector 0
op 0x0:(READ) flags 0x0 phys_seg 2 prio class 0
[  408.620290] BUG: scheduling while atomic: swapper/16/0/0x00000100
[  408.620325] Modules linked in: sctp bridge 8021q garp stp mrp llc
psmouse dlm configfs aoe ipmi_ssif amd64_edac_mod edac_mce_amd
amd_energy kvm_amd kvm irqbypass ghash_clmulni_intel aesni_intel libaes
crypto_simd cryptd glue_helper rapl pcspkr ast drm_vram_helper
drm_ttm_helper ttm drm_kms_helper cec drm evdev joydev ccp sg sp5100_tco
rng_core watchdog k10temp acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler
acpi_cpufreq button ext4 crc16 mbcache jbd2 dm_mod raid10 raid456
async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq
libcrc32c crc32c_generic raid0 multipath linear mlx4_ib ib_uverbs
mlx4_en raid1 md_mod sd_mod t10_pi crc_t10dif crct10dif_generic ib_core
hid_generic usbhid hid crct10dif_pclmul crct10dif_common crc32_pclmul
crc32c_intel xhci_pci igb mpt3sas xhci_hcd ahci libahci i2c_algo_bit dca
ptp libata pps_core raid_class usbcore scsi_transport_sas mlx4_core
scsi_mod i2c_piix4 usb_common
[  408.620422] CPU: 16 PID: 0 Comm: swapper/16 Not tainted
5.10.0-5-amd64 #1 Debian 5.10.26-1
[  408.620424] Hardware name: Supermicro AS -2013S-C0R/H11SSL-C, BIOS
2.1 02/21/2020
[  408.620425] Call Trace:
[  408.620428]  <IRQ>
[  408.620437]  dump_stack+0x6b/0x83
[  408.620442]  __schedule_bug.cold+0x4c/0x58
[  408.620446]  __schedule+0x719/0x870
[  408.620449]  schedule+0x46/0xb0
[  408.620453]  blk_mq_freeze_queue_wait+0x62/0x90
[  408.620458]  ? add_wait_queue_exclusive+0x70/0x70
[  408.620466]  aoedev_downdev+0x106/0x150 [aoe]
[  408.620471]  rexmit_timer+0x4ea/0x500 [aoe]
[  408.620476]  ? rexmit_deferred+0x380/0x380 [aoe]
[  408.620480]  call_timer_fn+0x29/0xf0
[  408.620483]  __run_timers.part.0+0x1d3/0x240
[  408.620485]  ? ktime_get+0x38/0xa0
[  408.620488]  ? lapic_next_event+0x1d/0x20
[  408.620491]  ? clockevents_program_event+0x8d/0xf0
[  408.620494]  run_timer_softirq+0x26/0x50
[  408.620496]  __do_softirq+0xc5/0x275
[  408.620499]  asm_call_irq_on_stack+0x12/0x20
[  408.620501]  </IRQ>
[  408.620505]  do_softirq_own_stack+0x37/0x40
[  408.620509]  irq_exit_rcu+0x8e/0xc0
[  408.620512]  sysvec_apic_timer_interrupt+0x36/0x80
[  408.620515]  asm_sysvec_apic_timer_interrupt+0x12/0x20
[  408.620520] RIP: 0010:cpuidle_enter_state+0xc7/0x350

The timeout is handled in rexmit_timer() [drivers/block/aoe/aoecmd.c 
L727ff] which is registered as a timer callback function and never 
explicitly called. For this reason rexmit_timer() is always called from 
an interrupt context.
When the timeout exceeds aoe_deadsecs aoedev_downdev() is called from 
rexmit_timer() in L782.
aoedev_downdev() then tries to clean out the queue 
[drivers/block/aoe/aoedev.c L227ff] using blk_mq_freeze_queue() and 
blk_mq_quiesce_queue(). These functions will sleep and, in the context 
of an interrupt, trigger the "BUG: scheduling while atomic" message, 
ultimately leading to hung tasks and an unusable system.

Before the change to blk_mq (commit 3582dd291788) the queue was emptied 
by iterating over all requests in the queue and failing them 1 by 1 
while no new requests were accepted due to ~DEVFL_UP being set.
To fail the queue in an atomic-safe way, this patch restores the 
previous behavior and adapts it to blk_mq.
Fetching requests from the queue is borrowed from nextbuf() 
[drivers/block/aoe/aoecmd.c L850] and finally failing them is done with 
aoe_end_request() [drivers/block/aoe/aoecmd.c L1030]. This is done while 
the ~DEVFL_UP flag is set which prevents aoeblk_queue_rq() 
[drivers/block/aoe/aoeblk.c L262] to enqueue new requests.

Fixes: 3582dd291788 (aoe: convert aoeblk to blk-mq)
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=212665
Signed-off-by: Valentin Kleibel <valentin@vrvis.at>
---
  drivers/block/aoe/aoedev.c | 13 ++++++++-----
  1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/block/aoe/aoedev.c b/drivers/block/aoe/aoedev.c
index c5753c6bfe80..0740acefed4c 100644
--- a/drivers/block/aoe/aoedev.c
+++ b/drivers/block/aoe/aoedev.c
@@ -198,6 +198,7 @@ aoedev_downdev(struct aoedev *d)
  {
         struct aoetgt *t, **tt, **te;
         struct list_head *head, *pos, *nx;
+       struct request *rq;
         int i;

         d->flags &= ~DEVFL_UP;
@@ -225,11 +226,13 @@ aoedev_downdev(struct aoedev *d)

         /* fast fail all pending I/O */
         if (d->blkq) {
-               /* UP is cleared, freeze+quiesce to insure all are 
errored */
-               blk_mq_freeze_queue(d->blkq);
-               blk_mq_quiesce_queue(d->blkq);
-               blk_mq_unquiesce_queue(d->blkq);
-               blk_mq_unfreeze_queue(d->blkq);
+               /* UP is cleared, error all requests without sleeping */
+               while ((rq = list_first_entry_or_null(&d->rq_list, 
struct request,
+                               queuelist))) {
+                       list_del_init(&rq->queuelist);
+                       blk_mq_start_request(rq);
+                       aoe_end_request(d, rq, 1);
+               }
         }

         if (d->gd)
