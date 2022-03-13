Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 651074D77EC
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 20:15:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235284AbiCMTQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 15:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiCMTQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 15:16:32 -0400
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4E59074601;
        Sun, 13 Mar 2022 12:15:22 -0700 (PDT)
Received: from [192.168.0.2] (chello089173232159.chello.sk [89.173.232.159])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 53AD27A00E1;
        Sun, 13 Mar 2022 20:15:20 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH] pata_parport: add driver (PARIDE replacement)
Date:   Sun, 13 Mar 2022 20:15:17 +0100
User-Agent: KMail/1.9.10
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Tim Waugh <tim@cyberelk.net>, linux-block@vger.kernel.org,
        linux-parport@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220312144415.20010-1-linux@zary.sk>
In-Reply-To: <20220312144415.20010-1-linux@zary.sk>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202203132015.18183.linux@zary.sk>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 12 March 2022 15:44:15 Ondrej Zary wrote:
> The pata_parport is a libata-based replacement of the old PARIDE
> subsystem - driver for parallel port IDE devices.
> It uses the original paride low-level protocol drivers but does not
> need the high-level drivers (pd, pcd, pf, pt, pg). The IDE devices
> behind parallel port adapters are handled by the ATA layer.
> 
> This will allow paride and its high-level drivers to be removed.
> 
> paride and pata_parport are mutually exclusive because the compiled
> protocol drivers are incompatible.
> 
> Tested with Imation SuperDisk LS-120 and HP C4381A (both use EPAT
> chip).
> 
> Note: EPP-32 mode is buggy in EPAT - and also in all other protocol
> drivers - they don't handle non-multiple-of-4 block transfers
> correctly. This causes problems with LS-120 drive.
> There is also another bug in EPAT: EPP modes don't work unless a 4-bit
> or 8-bit mode is used first (probably some initialization missing?).
> Once the device is initialized, EPP works until power cycle.
> 
> So after device power on, you have to:
> echo "parport0 epat 0" >/sys/bus/pata_parport/new_device
> echo pata_parport.0 >/sys/bus/pata_parport/delete_device
> echo "parport0 epat 4" >/sys/bus/pata_parport/new_device
> (autoprobe will initialize correctly as it tries the slowest modes
> first but you'll get the broken EPP-32 mode)

Found a bug - the same device can be registered multiple times. Fix will be in
v2. But this revealed a bigger problem: pi_connect can sleep (uses
parport_claim_or_block) and libata does not like that.
Any ideas how to fix this?

Mar 12 18:47:13 test kernel: [  348.863534] pata_parport: protocol epat registered
Mar 12 18:47:16 test kernel: [  352.226932] (null): epat 1.02, Shuttle EPAT chip c6 at 0x378,
Mar 12 18:47:16 test kernel: [  352.226943] mode 2 (8-bit), delay 1
Mar 12 18:47:16 test kernel: [  352.255210] scsi host4: pata_parport
Mar 12 18:47:16 test kernel: [  352.255359] ata5: PATA max PIO0 port parport0 protocol epat
Mar 12 18:47:17 test kernel: [  352.489441] ata5.00: ATAPI: LS-120 COSM   04              UHD Floppy, 0270M09T, max PIO2
Mar 12 18:47:17 test kernel: [  352.572733] scsi 4:0:0:0: Direct-Access     MATSHITA LS-120 COSM   04 0270 PQ: 0 ANSI: 5
Mar 12 18:47:17 test kernel: [  352.608160] sd 4:0:0:0: Attached scsi generic sg1 type 0
Mar 12 18:47:17 test kernel: [  352.635053] sd 4:0:0:0: [sdb] Media removed, stopped polling
Mar 12 18:47:17 test kernel: [  352.658924] sd 4:0:0:0: [sdb] Attached SCSI removable disk
Mar 12 18:47:31 test kernel: [  366.811817] (null): epat 1.02, Shuttle EPAT chip c6 at 0x378,
Mar 12 18:47:31 test kernel: [  366.811828] mode 2 (8-bit), delay 1
Mar 12 18:47:31 test kernel: [  366.846397] scsi host5: pata_parport
Mar 12 18:47:31 test kernel: [  366.846557] ata6: PATA max PIO0 port parport0 protocol epat
Mar 12 18:47:31 test kernel: [  367.076726] ata6.00: ATAPI: LS-120 COSM   04              UHD Floppy, 0270M09T, max PIO2
Mar 12 18:47:31 test kernel: [  367.157050] scsi 5:0:0:0: Direct-Access     MATSHITA LS-120 COSM   04 0270 PQ: 0 ANSI: 5
Mar 12 18:47:31 test kernel: [  367.192614] sd 5:0:0:0: Attached scsi generic sg2 type 0
Mar 12 18:47:31 test kernel: [  367.219398] sd 5:0:0:0: [sdc] Media removed, stopped polling
Mar 12 18:47:31 test kernel: [  367.243247] sd 5:0:0:0: [sdc] Attached SCSI removable disk
Mar 12 18:47:32 test kernel: [  367.542155] Modules linked in: epat pata_parport nouveau snd_intel8x0 snd_ac97_codec ac97_bus snd_pcm psmouse snd_timer snd soundcore wmi
hwmon serio_raw drm_ttm_helper 8139cp sg intel_agp i2c_dev parport_pc parport fuse
Mar 12 18:47:32 test kernel: [  367.542219] CPU: 0 PID: 17 Comm: kworker/0:1 Not tainted 5.17.0-rc2+ #441
Mar 12 18:47:32 test kernel: [  367.542227] Hardware name:  /848P-ICH5, BIOS 6.00 PG 02/03/2005
Mar 12 18:47:32 test kernel: [  367.542232] Workqueue: events_freezable_power_ disk_events_workfn
Mar 12 18:47:32 test kernel: [  367.542242] Call Trace:
Mar 12 18:47:32 test kernel: [  367.542250]  dump_stack_lvl+0x32/0x41
Mar 12 18:47:32 test kernel: [  367.542259]  ? preempt_count_add+0x4c/0x51
Mar 12 18:47:32 test kernel: [  367.542266]  dump_stack+0xd/0x10
Mar 12 18:47:32 test kernel: [  367.542271]  __schedule_bug+0x90/0xa1
Mar 12 18:47:32 test kernel: [  367.542281]  __schedule+0x3b/0x456
Mar 12 18:47:32 test kernel: [  367.542289]  schedule+0x68/0xa3
Mar 12 18:47:32 test kernel: [  367.542296]  parport_claim_or_block+0x68/0xa5 [parport]
Mar 12 18:47:32 test kernel: [  367.542307]  ? init_wait_entry+0x21/0x21
Mar 12 18:47:32 test kernel: [  367.542315]  pi_connect+0x2b/0x3e [pata_parport]
Mar 12 18:47:32 test kernel: [  367.542323]  pata_parport_check_status+0x16/0x4e [pata_parport]
Mar 12 18:47:32 test kernel: [  367.542329]  ? pata_parport_lost_interrupt+0x7c/0x7c [pata_parport]
Mar 12 18:47:32 test kernel: [  367.542336]  ata_sff_busy_wait+0x27/0x3b
Mar 12 18:47:32 test kernel: [  367.542345]  ata_wait_idle+0x12/0x14
Mar 12 18:47:32 test kernel: [  367.542350]  ata_sff_qc_issue+0x27/0x106
Mar 12 18:47:32 test kernel: [  367.542357]  ata_qc_issue+0x14b/0x16b
Mar 12 18:47:32 test kernel: [  367.542364]  __ata_scsi_queuecmd+0x1c7/0x1d4
Mar 12 18:47:32 test kernel: [  367.542369]  ? ata_scsiop_inq_83+0xb3/0xb3
Mar 12 18:47:32 test kernel: [  367.542375]  ata_scsi_queuecmd+0x36/0x5f
Mar 12 18:47:32 test kernel: [  367.542380]  scsi_queue_rq+0x577/0x69e
Mar 12 18:47:32 test kernel: [  367.542389]  blk_mq_dispatch_rq_list+0x229/0x3e4
Mar 12 18:47:32 test kernel: [  367.542395]  ? __sbitmap_get_word+0x28/0x5a
Mar 12 18:47:32 test kernel: [  367.542405]  __blk_mq_sched_dispatch_requests+0x7b/0xdb
Mar 12 18:47:32 test kernel: [  367.542411]  blk_mq_sched_dispatch_requests+0x25/0x46
Mar 12 18:47:32 test kernel: [  367.542417]  __blk_mq_run_hw_queue+0x36/0x6b
Mar 12 18:47:32 test kernel: [  367.542424]  __blk_mq_delay_run_hw_queue+0x54/0x11d
Mar 12 18:47:32 test kernel: [  367.542431]  blk_mq_run_hw_queue+0xa5/0xab
Mar 12 18:47:32 test kernel: [  367.542437]  blk_mq_sched_insert_request+0xa2/0xaa
Mar 12 18:47:32 test kernel: [  367.542443]  ? update_io_ticks+0x2a/0x5b
Mar 12 18:47:32 test kernel: [  367.542451]  blk_execute_rq_nowait+0x3f/0x47
Mar 12 18:47:32 test kernel: [  367.542457]  blk_execute_rq+0x3a/0xa4
Mar 12 18:47:32 test kernel: [  367.542463]  __scsi_execute+0x90/0x133
Mar 12 18:47:32 test kernel: [  367.542470]  scsi_test_unit_ready+0x43/0x95
Mar 12 18:47:32 test kernel: [  367.542477]  sd_check_events+0x8b/0xf6
Mar 12 18:47:32 test kernel: [  367.542483]  ? media_not_present+0x3b/0x3b
Mar 12 18:47:32 test kernel: [  367.542489]  disk_check_events+0x26/0xa3
Mar 12 18:47:32 test kernel: [  367.542495]  disk_events_workfn+0x10/0x12
Mar 12 18:47:32 test kernel: [  367.542499]  process_one_work+0x107/0x198
Mar 12 18:47:32 test kernel: [  367.542508]  worker_thread+0x151/0x1e3
Mar 12 18:47:32 test kernel: [  367.542514]  kthread+0xd2/0xd7
Mar 12 18:47:32 test kernel: [  367.542519]  ? rescuer_thread+0x1ec/0x1ec
Mar 12 18:47:32 test kernel: [  367.542525]  ? kthread_complete_and_exit+0x16/0x16
Mar 12 18:47:32 test kernel: [  367.542531]  ret_from_fork+0x19/0x28
Mar 12 18:47:32 test kernel: [  367.542540] ------------[ cut here ]------------
Mar 12 18:47:32 test kernel: [  367.542543] Voluntary context switch within RCU read-side critical section!
Mar 12 18:47:32 test kernel: [  367.542552] WARNING: CPU: 0 PID: 17 at kernel/rcu/tree_plugin.h:318 rcu_note_context_switch+0x4e/0x27f
Mar 12 18:47:32 test kernel: [  367.542568] Modules linked in: epat pata_parport nouveau snd_intel8x0 snd_ac97_codec ac97_bus snd_pcm psmouse snd_timer snd soundcore wmi hwmon serio_raw drm_ttm_helper 8139cp sg intel_agp i2c_dev parport_pc parport fuse
Mar 12 18:47:32 test kernel: [  367.542605] CPU: 0 PID: 17 Comm: kworker/0:1 Tainted: G        W         5.17.0-rc2+ #441
Mar 12 18:47:32 test kernel: [  367.542612] Hardware name:  /848P-ICH5, BIOS 6.00 PG 02/03/2005
Mar 12 18:47:32 test kernel: [  367.542616] Workqueue: events_freezable_power_ disk_events_workfn
Mar 12 18:47:32 test kernel: [  367.542624] EIP: rcu_note_context_switch+0x4e/0x27f
Mar 12 18:47:32 test kernel: [  367.542631] Code: 80 7d e3 00 75 27 8b 86 fc 01 00 00 85 c0 7e 1d 80 3d 95 06 87 d8 00 75 14 68 43 ad 6e d8 c6 05 95 06 87 d8 01 e8 ce e9 50 00 <0f> 0b 58 64 a1 cc 86 90 d8 8b 80 fc 01 00 00 85 c0 0f 8e dc 01 00
Mar 12 18:47:32 test kernel: [  367.542637] EAX: 0000003f EBX: c10bb780 ECX: ef9939cc EDX: 00000002
Mar 12 18:47:32 test kernel: [  367.542643] ESI: c10bb780 EDI: ef997840 EBP: c1093c5c ESP: c1093c38
Mar 12 18:47:32 test kernel: [  367.542648] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010096
Mar 12 18:47:32 test kernel: [  367.542654] CR0: 80050033 CR2: b5126000 CR3: 0d97c000 CR4: 00000690
Mar 12 18:47:32 test kernel: [  367.542660] Call Trace:
Mar 12 18:47:32 test kernel: [  367.542665]  ? preempt_count_add+0x4c/0x51
Mar 12 18:47:32 test kernel: [  367.542672]  ? dump_stack+0xd/0x10
Mar 12 18:47:32 test kernel: [  367.542677]  ? preempt_count_add+0x4c/0x51
Mar 12 18:47:32 test kernel: [  367.542683]  __schedule+0x63/0x456
Mar 12 18:47:32 test kernel: [  367.542691]  schedule+0x68/0xa3
Mar 12 18:47:32 test kernel: [  367.542697]  parport_claim_or_block+0x68/0xa5 [parport]
Mar 12 18:47:32 test kernel: [  367.542706]  ? init_wait_entry+0x21/0x21
Mar 12 18:47:32 test kernel: [  367.542713]  pi_connect+0x2b/0x3e [pata_parport]
Mar 12 18:47:32 test kernel: [  367.542720]  pata_parport_check_status+0x16/0x4e [pata_parport]
Mar 12 18:47:32 test kernel: [  367.542726]  ? pata_parport_lost_interrupt+0x7c/0x7c [pata_parport]
Mar 12 18:47:32 test kernel: [  367.542733]  ata_sff_busy_wait+0x27/0x3b
Mar 12 18:47:32 test kernel: [  367.542740]  ata_wait_idle+0x12/0x14
Mar 12 18:47:32 test kernel: [  367.542745]  ata_sff_qc_issue+0x27/0x106
Mar 12 18:47:32 test kernel: [  367.542752]  ata_qc_issue+0x14b/0x16b
Mar 12 18:47:32 test kernel: [  367.542758]  __ata_scsi_queuecmd+0x1c7/0x1d4
Mar 12 18:47:32 test kernel: [  367.542763]  ? ata_scsiop_inq_83+0xb3/0xb3
Mar 12 18:47:32 test kernel: [  367.542769]  ata_scsi_queuecmd+0x36/0x5f
Mar 12 18:47:32 test kernel: [  367.542774]  scsi_queue_rq+0x577/0x69e
Mar 12 18:47:32 test kernel: [  367.542782]  blk_mq_dispatch_rq_list+0x229/0x3e4
Mar 12 18:47:32 test kernel: [  367.542789]  ? __sbitmap_get_word+0x28/0x5a
Mar 12 18:47:32 test kernel: [  367.542797]  __blk_mq_sched_dispatch_requests+0x7b/0xdb
Mar 12 18:47:32 test kernel: [  367.542804]  blk_mq_sched_dispatch_requests+0x25/0x46
Mar 12 18:47:32 test kernel: [  367.542809]  __blk_mq_run_hw_queue+0x36/0x6b
Mar 12 18:47:32 test kernel: [  367.542816]  __blk_mq_delay_run_hw_queue+0x54/0x11d
Mar 12 18:47:32 test kernel: [  367.542823]  blk_mq_run_hw_queue+0xa5/0xab
Mar 12 18:47:32 test kernel: [  367.542829]  blk_mq_sched_insert_request+0xa2/0xaa
Mar 12 18:47:32 test kernel: [  367.542835]  ? update_io_ticks+0x2a/0x5b
Mar 12 18:47:32 test kernel: [  367.542842]  blk_execute_rq_nowait+0x3f/0x47
Mar 12 18:47:32 test kernel: [  367.542848]  blk_execute_rq+0x3a/0xa4
Mar 12 18:47:32 test kernel: [  367.542854]  __scsi_execute+0x90/0x133
Mar 12 18:47:32 test kernel: [  367.542861]  scsi_test_unit_ready+0x43/0x95
Mar 12 18:47:32 test kernel: [  367.542868]  sd_check_events+0x8b/0xf6
Mar 12 18:47:32 test kernel: [  367.542874]  ? media_not_present+0x3b/0x3b
Mar 12 18:47:32 test kernel: [  367.542879]  disk_check_events+0x26/0xa3
Mar 12 18:47:32 test kernel: [  367.542885]  disk_events_workfn+0x10/0x12
Mar 12 18:47:32 test kernel: [  367.542890]  process_one_work+0x107/0x198
Mar 12 18:47:32 test kernel: [  367.542898]  worker_thread+0x151/0x1e3
Mar 12 18:47:32 test kernel: [  367.542904]  kthread+0xd2/0xd7
Mar 12 18:47:32 test kernel: [  367.542909]  ? rescuer_thread+0x1ec/0x1ec
Mar 12 18:47:32 test kernel: [  367.542915]  ? kthread_complete_and_exit+0x16/0x16
Mar 12 18:47:32 test kernel: [  367.542921]  ret_from_fork+0x19/0x28
Mar 12 18:47:32 test kernel: [  367.542928] ---[ end trace 0000000000000000 ]---
Mar 12 18:47:32 test kernel: [  367.650552] ------------[ cut here ]------------
Mar 12 18:47:32 test kernel: [  367.650568] DEBUG_LOCKS_WARN_ON(val > preempt_count())
Mar 12 18:47:32 test kernel: [  367.650576] WARNING: CPU: 0 PID: 17 at kernel/sched/core.c:5474 preempt_count_sub+0x3e/0x7f
Mar 12 18:47:32 test kernel: [  367.650595] Modules linked in: epat pata_parport nouveau snd_intel8x0 snd_ac97_codec ac97_bus snd_pcm psmouse snd_timer snd soundcore wmi hwmon serio_raw drm_ttm_helper 8139cp sg intel_agp i2c_dev parport_pc parport fuse
Mar 12 18:47:32 test kernel: [  367.650641] CPU: 0 PID: 17 Comm: kworker/0:1 Tainted: G        W         5.17.0-rc2+ #441
Mar 12 18:47:32 test kernel: [  367.650649] Hardware name:  /848P-ICH5, BIOS 6.00 PG 02/03/2005
Mar 12 18:47:32 test kernel: [  367.650655] Workqueue: events_freezable_power_ disk_events_workfn
Mar 12 18:47:32 test kernel: [  367.650665] EIP: preempt_count_sub+0x3e/0x7f
Mar 12 18:47:32 test kernel: [  367.650672] Code: e2 ff ff ff 7f 39 c2 7d 25 e8 9d f4 19 00 85 c0 74 57 83 3d b4 2c 87 d8 00 75 4e 68 0a 6c 6e d8 68 db a7 6d d8 e8 3d b4 53 00 <0f> 0b eb 2e 3d fe 00 00 00 77 2b 84 d2 75 27 e8 6d f4 19 00 85 c0
Mar 12 18:47:32 test kernel: [  367.650679] EAX: 0000002a EBX: 00000000 ECX: ef9939cc EDX: 00000001
Mar 12 18:47:32 test kernel: [  367.650685] ESI: d4974000 EDI: 00000293 EBP: c1093d30 ESP: c1093d28
Mar 12 18:47:32 test kernel: [  367.650690] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010292
Mar 12 18:47:32 test kernel: [  367.650697] CR0: 80050033 CR2: b0eae6ec CR3: 035b5000 CR4: 00000690
Mar 12 18:47:32 test kernel: [  367.650704] Call Trace:
Mar 12 18:47:32 test kernel: [  367.650711]  _raw_spin_unlock_irqrestore+0x17/0x28
Mar 12 18:47:32 test kernel: [  367.650720]  ata_scsi_queuecmd+0x57/0x5f
Mar 12 18:47:32 test kernel: [  367.650728]  scsi_queue_rq+0x577/0x69e
Mar 12 18:47:32 test kernel: [  367.650737]  blk_mq_dispatch_rq_list+0x229/0x3e4
Mar 12 18:47:32 test kernel: [  367.650743]  ? __sbitmap_get_word+0x28/0x5a
Mar 12 18:47:32 test kernel: [  367.650753]  __blk_mq_sched_dispatch_requests+0x7b/0xdb
Mar 12 18:47:32 test kernel: [  367.650760]  blk_mq_sched_dispatch_requests+0x25/0x46
Mar 12 18:47:32 test kernel: [  367.650766]  __blk_mq_run_hw_queue+0x36/0x6b
Mar 12 18:47:32 test kernel: [  367.650774]  __blk_mq_delay_run_hw_queue+0x54/0x11d
Mar 12 18:47:32 test kernel: [  367.650781]  blk_mq_run_hw_queue+0xa5/0xab
Mar 12 18:47:32 test kernel: [  367.650788]  blk_mq_sched_insert_request+0xa2/0xaa
Mar 12 18:47:32 test kernel: [  367.650793]  ? update_io_ticks+0x2a/0x5b
Mar 12 18:47:32 test kernel: [  367.650801]  blk_execute_rq_nowait+0x3f/0x47
Mar 12 18:47:32 test kernel: [  367.650808]  blk_execute_rq+0x3a/0xa4
Mar 12 18:47:32 test kernel: [  367.650815]  __scsi_execute+0x90/0x133
Mar 12 18:47:32 test kernel: [  367.650822]  scsi_test_unit_ready+0x43/0x95
Mar 12 18:47:32 test kernel: [  367.650830]  sd_check_events+0x8b/0xf6
Mar 12 18:47:32 test kernel: [  367.650836]  ? media_not_present+0x3b/0x3b
Mar 12 18:47:32 test kernel: [  367.650842]  disk_check_events+0x26/0xa3
Mar 12 18:47:32 test kernel: [  367.650848]  disk_events_workfn+0x10/0x12
Mar 12 18:47:32 test kernel: [  367.650853]  process_one_work+0x107/0x198
Mar 12 18:47:32 test kernel: [  367.650862]  worker_thread+0x151/0x1e3
Mar 12 18:47:32 test kernel: [  367.650868]  kthread+0xd2/0xd7
Mar 12 18:47:32 test kernel: [  367.650874]  ? rescuer_thread+0x1ec/0x1ec
Mar 12 18:47:32 test kernel: [  367.650880]  ? kthread_complete_and_exit+0x16/0x16
Mar 12 18:47:32 test kernel: [  367.650886]  ret_from_fork+0x19/0x28
Mar 12 18:47:32 test kernel: [  367.650895] ---[ end trace 0000000000000000 ]---
Mar 12 18:47:32 test kernel: [  367.658169] Modules linked in: epat pata_parport nouveau snd_intel8x0 snd_ac97_codec ac97_bus snd_pcm psmouse snd_timer snd soundcore wmi hwmon serio_raw drm_ttm_helper 8139cp sg intel_agp i2c_dev parport_pc parport fuse
Mar 12 18:47:32 test kernel: [  367.658232] CPU: 0 PID: 561 Comm: scsi_eh_5 Tainted: G        W         5.17.0-rc2+ #441
Mar 12 18:47:32 test kernel: [  367.658240] Hardware name:  /848P-ICH5, BIOS 6.00 PG 02/03/2005
Mar 12 18:47:32 test kernel: [  367.658244] Call Trace:
Mar 12 18:47:32 test kernel: [  367.658251]  dump_stack_lvl+0x32/0x41
Mar 12 18:47:32 test kernel: [  367.658260]  ? preempt_count_add+0x4c/0x51
Mar 12 18:47:32 test kernel: [  367.658266]  dump_stack+0xd/0x10
Mar 12 18:47:32 test kernel: [  367.658272]  __schedule_bug+0x90/0xa1
Mar 12 18:47:32 test kernel: [  367.658278]  __schedule+0x3b/0x456
Mar 12 18:47:32 test kernel: [  367.658286]  ? _raw_spin_lock_irqsave+0x1b/0x21
Mar 12 18:47:32 test kernel: [  367.658293]  schedule+0x68/0xa3
Mar 12 18:47:32 test kernel: [  367.658300]  parport_claim_or_block+0x68/0xa5 [parport]
Mar 12 18:47:32 test kernel: [  367.658313]  ? init_wait_entry+0x21/0x21
Mar 12 18:47:32 test kernel: [  367.658321]  pi_connect+0x2b/0x3e [pata_parport]
Mar 12 18:47:32 test kernel: [  367.658329]  pata_parport_check_status+0x16/0x4e [pata_parport]
Mar 12 18:47:32 test kernel: [  367.658338]  pata_parport_drain_fifo+0x2b/0x7c [pata_parport]
Mar 12 18:47:32 test kernel: [  367.658345]  ? ata_sff_prereset+0x7e/0x7e
Mar 12 18:47:32 test kernel: [  367.658354]  ata_sff_error_handler+0x68/0xb6
Mar 12 18:47:32 test kernel: [  367.658361]  ? pata_parport_devchk+0x11e/0x11e [pata_parport]
Mar 12 18:47:32 test kernel: [  367.658369]  ata_scsi_port_error_handler+0x1cf/0x46a
Mar 12 18:47:32 test kernel: [  367.658376]  ata_scsi_error+0x74/0x85
Mar 12 18:47:32 test kernel: [  367.658383]  scsi_error_handler+0x11a/0x461
Mar 12 18:47:32 test kernel: [  367.658391]  ? _raw_spin_lock_irqsave+0x1b/0x21
Mar 12 18:47:32 test kernel: [  367.658397]  ? _raw_spin_unlock_irqrestore+0x17/0x28
Mar 12 18:47:32 test kernel: [  367.658402]  ? __kthread_parkme+0x2c/0x70
Mar 12 18:47:32 test kernel: [  367.658409]  kthread+0xd2/0xd7
Mar 12 18:47:32 test kernel: [  367.658415]  ? scsi_eh_get_sense+0x176/0x176
Mar 12 18:47:32 test kernel: [  367.658421]  ? kthread_complete_and_exit+0x16/0x16
Mar 12 18:47:32 test kernel: [  367.658427]  ret_from_fork+0x19/0x28
Mar 12 18:47:32 test kernel: [  367.815293] sd 5:0:0:0: [sdc] Media removed, stopped polling


-- 
Ondrej Zary
