Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3D2659C18F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 16:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235375AbiHVOYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 10:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234955AbiHVOYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 10:24:50 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5EFE2C12A
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 07:24:47 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id n7so3402151ejh.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 07:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=Bop5DnjmDaA6bh2XmvZb5hD/+LHjp60P7VMoFh1GQ34=;
        b=TcsfBsRxVuCOp88tk+YfnhDQZz+MYwJ5Vz5DLNjS0GPBfmK+0XLDfMYeAq+J0Ms4oW
         KAQPZcyf8Ux+dOCqaFWrTCLn82oiaEqX+ZIFxqk+ZI9eJAu2B2HQMJF+5obsQXpUDIBT
         c3aTQ+RRYHf13MACivjU0hjkqscZ7YzVeJDnOXL22dzGUiZwNZSZRrXdSvVacbacupjF
         LxjQqnaMy+oCCvseA4WZMREIYXTdVJWHhbusCQyoC+VJxF6z+7kZQBXkM+8c+J9MvN3g
         BzlCBd09DtBStmrOW9boFCTXkWyizM5P+YAX6SbrlTCX6vcF7z63u1kgw3UYqIhBLIrE
         zupA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=Bop5DnjmDaA6bh2XmvZb5hD/+LHjp60P7VMoFh1GQ34=;
        b=RNpy72vI1kL6hLr7bnARdiO6D2mt2Ogf6X4p/uFCGYSirY4LweUg/M+XB95NHyl8uS
         76wE9cM3gV740OlWdlYrsy9P4QY/EEnYHce9YS3RqkbCW3BdWwwjj+thaOYggahHmkf9
         ZOVfggkWrwpjghl2Z1zVHjBeRh7UbRRKFZKBC4CKZ0CHk7LHK89Qlwirn2B2cSE1CfbT
         NCjFxSemcpmB1w7xqV6IlnKfC89SWUUzvhtiM6uXL4Y3fjd65+nKDbYZ+B9g6ATqu3KT
         vypxwrgfYgbRkTpEMJjwQEGP7V+pv5zNOSVLYjrJfwRAvNZVYHINNaOtNzhWSgs29Aav
         gVfA==
X-Gm-Message-State: ACgBeo2C9KhlPPHhysrC7pTVtQ5aJbDkV4NCxwBf4+H0M4dgxerHQv9J
        vbNWcG3rM7WsX65nSKVSc5Y=
X-Google-Smtp-Source: AA6agR5QyoPJItVkUoG/lutB1ognS+KWZlzB5NzYEjR2KihMl/3qE5PCpO9GfsVGGBfw7FUVWF9z1Q==
X-Received: by 2002:a17:907:738a:b0:73d:8eb7:c3ea with SMTP id er10-20020a170907738a00b0073d8eb7c3eamr1127140ejc.431.1661178286099;
        Mon, 22 Aug 2022 07:24:46 -0700 (PDT)
Received: from localhost.localdomain (host-87-17-106-94.retail.telecomitalia.it. [87.17.106.94])
        by smtp.gmail.com with ESMTPSA id h4-20020a170906398400b0073151ce7726sm6286083eje.100.2022.08.22.07.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 07:24:43 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        James Smart <james.smart@broadcom.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCH v3 0/1] Don't kmap() pages which can't come from HIGHMEM
Date:   Mon, 22 Aug 2022 16:24:37 +0200
Message-Id: <20220822142438.5954-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmap() is being deprecated in favor of kmap_local_page().[1]

There are two main problems with kmap(): (1) It comes with an overhead as
mapping space is restricted and protected by a global lock for
synchronization and (2) it also requires global TLB invalidation when the
kmap’s pool wraps and it might block when the mapping space is fully
utilized until a slot becomes available.

The pages which will be mapped are allocated in nvmet_tcp_map_data(),
using the GFP_KERNEL flag. This assures that they cannot come from
HIGHMEM. This imply that a straight page_address() can replace the kmap()
of sg_page(sg) in nvmet_tcp_map_pdu_iovec(). As a side effect, we might
also delete the field "nr_mapped" from struct "nvmet_tcp_cmd" because,
after removing the kmap() calls, there would be no longer any need of it.

Therefore, replace the kmap() of sg_page(sg) with a page_address() and
delete the "nr_mapped" field from "nvmet_tcp_cmd" and instead pass a
local variable to iov_iter_kvec() from the call site in
nvmet_tcp_map_pdu_iovec().

Test with blktests on a QEMU/KVM x86_32 VM, 6GB RAM, booting a kernel with
HIGHMEM64GB enabled.

[1] "[PATCH] checkpatch: Add kmap and kmap_atomic to the deprecated
list" https://lore.kernel.org/all/20220813220034.806698-1-ira.weiny@intel.com/

Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

v2->v3: Test with blktests on a QEMU/KVM x86_32 VM, 6GB RAM, booting a
kernel with HIGHMEM64GB enabled as requested by Sagi (thanks!).

With or without this patch, test nvme/029 fails, therefore, these changes
don't introduce new bugs. The output from dmesg and the decoded stacktrace
is copy-pasted at the end of this cover letter.

Split a couple of long lines (thanks to Chaitanya and Christoph).

v1->v2: Use a local variable as argument of iov_iter_kvec() instead of
the removed "nr_mapped" field from struct "nvmet_tcp_cmd". Thanks to
Sagi and Keith who noticed my mistake.

Many thanks to Chaitanya, Keith, Sagi, for the answers and the comments on
the RFC which led to this patch. The RFC is at:
https://lore.kernel.org/all/20220816091808.23236-1-fmdefrancesco@gmail.com/

Fabio M. De Francesco (1):
  nvmet-tcp: Don't kmap() pages which can't come from HIGHMEM

 drivers/nvme/target/tcp.c | 28 +++++-----------------------
 1 file changed, 5 insertions(+), 23 deletions(-)

Output from dmesg command with decoded stack-trace (as said, with or
without my changes, test nvme/029 fails and hangs the VM):

tweed32:~ # cat /usr/src/git/packages/blktests/6.0.0-rc2-no-patched.dmesg
[  727.874459] run blktests nvme/029 at 2022-08-22 15:04:57
[  727.917821] loop0: detected capacity change from 0 to 2097152
[  727.935531] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[  727.952425] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
[  727.965284] device: 'nvme0': device_add
[  727.965481] PM: Adding info for No Bus:nvme0
[  727.966436] nvmet: creating nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0ce2efcb-2d44-4c39-9064-433de1b4c5d4.
[  727.967487] device: 'nvme-subsys0': device_add
[  727.967583] PM: Adding info for No Bus:nvme-subsys0
[  727.969295] device: 'hwmon0': device_add
[  727.969362] PM: Adding info for No Bus:hwmon0
[  727.969739] nvme nvme0: creating 4 I/O queues.
[  727.970839] nvme nvme0: mapped 4/0/0 default/read/poll queues.
[  727.972127] nvme nvme0: new ctrl: NQN "blktests-subsystem-1", addr 127.0.0.1:4420
[  727.974938] device: 'nvme0c0n1': device_add
[  727.975143] PM: Adding info for No Bus:nvme0c0n1
[  727.976215] device: 'nvme0n1': device_add
[  727.976401] PM: Adding info for No Bus:nvme0n1
[  727.976721] device: '259:27': device_add
[  727.976803] PM: Adding info for No Bus:259:27
[  727.977655] device: 'ng0n1': device_add
[  727.977731] PM: Adding info for No Bus:ng0n1
[  729.154663] usercopy: Kernel memory exposure attempt detected from kmap (offset 0, size 12288)!
[  729.154711] ------------[ cut here ]------------
[  729.154713] kernel BUG at mm/usercopy.c:101!
[  729.154723] invalid opcode: 0000 [#1] PREEMPT SMP
[  729.154727] CPU: 2 PID: 2907 Comm: kworker/2:2H Tainted: G S      W          6.0.0-rc2-vanilla-debug+ #31 aa3ee8c1eb49ad6f37c1eba908f84dc5e5ede635
[  729.154731] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.0-0-gd239552-rebuilt.opensuse.org 04/01/2014
[  729.154736] Workqueue: nvmet_tcp_wq nvmet_tcp_io_work [nvmet_tcp]
[  729.154743] EIP: usercopy_abort (mm/usercopy.c:101 (discriminator 17)) 
[ 729.154752] Code: 44 cb bb 9a fe d2 d1 89 4d f0 b9 ea fa d0 d1 0f 45 cb ff 75 0c ff 75 08 57 52 56 50 ff 75 f0 51 68 10 fe d2 d1 e8 52 86 ff ff <0f> 0b b8 70 7f 0b d2 83 c4 24 e8 3f dc 00 00 89 e0 56 31 d2 29 d8
All code
========
   0:	44                   	inc    %esp
   1:	cb                   	lret
   2:	bb 9a fe d2 d1       	mov    $0xd1d2fe9a,%ebx
   7:	89 4d f0             	mov    %ecx,-0x10(%ebp)
   a:	b9 ea fa d0 d1       	mov    $0xd1d0faea,%ecx
   f:	0f 45 cb             	cmovne %ebx,%ecx
  12:	ff 75 0c             	push   0xc(%ebp)
  15:	ff 75 08             	push   0x8(%ebp)
  18:	57                   	push   %edi
  19:	52                   	push   %edx
  1a:	56                   	push   %esi
  1b:	50                   	push   %eax
  1c:	ff 75 f0             	push   -0x10(%ebp)
  1f:	51                   	push   %ecx
  20:	68 10 fe d2 d1       	push   $0xd1d2fe10
  25:	e8 52 86 ff ff       	call   0xffff867c
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	b8 70 7f 0b d2       	mov    $0xd20b7f70,%eax
  31:	83 c4 24             	add    $0x24,%esp
  34:	e8 3f dc 00 00       	call   0xdc78
  39:	89 e0                	mov    %esp,%eax
  3b:	56                   	push   %esi
  3c:	31 d2                	xor    %edx,%edx
  3e:	29 d8                	sub    %ebx,%eax

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	b8 70 7f 0b d2       	mov    $0xd20b7f70,%eax
   7:	83 c4 24             	add    $0x24,%esp
   a:	e8 3f dc 00 00       	call   0xdc4e
   f:	89 e0                	mov    %esp,%eax
  11:	56                   	push   %esi
  12:	31 d2                	xor    %edx,%edx
  14:	29 d8                	sub    %ebx,%eax
[  729.154754] EAX: 00000053 EBX: d1d2fe9a ECX: f7484e08 EDX: 00000000
[  729.154755] ESI: d1d487be EDI: d1d487be EBP: d03b5cdc ESP: d03b5ca8
[  729.154757] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010286
[  729.154760] CR0: 80050033 CR2: b7f57080 CR3: 06027c20 CR4: 000006b0
[  729.154762] Call Trace:
[  729.154765] __check_object_size.cold (mm/usercopy.c:145 mm/usercopy.c:253) 
[  729.154768] simple_copy_to_iter (include/linux/uio.h:176 net/core/datagram.c:513) 
[  729.154772] __skb_datagram_iter (include/linux/highmem-internal.h:55 net/core/datagram.c:445) 
[  729.154775] skb_copy_datagram_iter (net/core/datagram.c:529) 
[  729.154777] ? skb_copy_and_hash_datagram_iter (net/core/datagram.c:512) 
[  729.154779] tcp_recvmsg_locked (net/ipv4/tcp.c:2593) 
[  729.154784] ? lock_sock_nested (net/core/sock.c:3399) 
[  729.154789] tcp_recvmsg (net/ipv4/tcp.c:2670) 
[  729.154791] ? aa_sk_perm (security/apparmor/include/cred.h:122 security/apparmor/net.c:176) 
[  729.154797] inet_recvmsg (net/ipv4/af_inet.c:852) 
[  729.154800] sock_recvmsg (net/socket.c:995 net/socket.c:1013) 
[  729.154804] nvmet_tcp_io_work (drivers/nvme/target/tcp.c:1137 drivers/nvme/target/tcp.c:1211 drivers/nvme/target/tcp.c:1237 drivers/nvme/target/tcp.c:1287) nvmet_tcp
[  729.154807] ? lock_acquire (include/trace/events/lock.h:24 kernel/locking/lockdep.c:5637) 
[  729.154814] ? rcu_read_lock_sched_held (kernel/rcu/update.c:104 kernel/rcu/update.c:123) 
[  729.154820] ? _raw_spin_unlock_irq (arch/x86/include/asm/preempt.h:103 include/linux/spinlock_api_smp.h:160 kernel/locking/spinlock.c:202) 
[  729.154830] ? process_one_work (kernel/workqueue.c:2264) 
[  729.154836] ? trace_preempt_on (kernel/trace/trace_preemptirq.c:125) 
[  729.154841] ? process_one_work (kernel/workqueue.c:2264) 
[  729.154845] process_one_work (kernel/workqueue.c:2294) 
[  729.154850] worker_thread (include/linux/list.h:292 kernel/workqueue.c:2437) 
[  729.154853] ? _raw_spin_unlock_irqrestore (arch/x86/include/asm/preempt.h:103 include/linux/spinlock_api_smp.h:152 kernel/locking/spinlock.c:194) 
[  729.154857] kthread (kernel/kthread.c:376) 
[  729.154860] ? process_one_work (kernel/workqueue.c:2379) 
[  729.154862] ? kthread_complete_and_exit (kernel/kthread.c:331) 
[  729.154865] ret_from_fork (arch/x86/entry/entry_32.S:770) 
[  729.154871] Modules linked in: nvmet_tcp nvmet nvme_tcp nvme_fabrics vfat fat xfs loop nvme_core uinput af_packet nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_tables ip6table_nat ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw iptable_security rfkill nfnetlink ip6table_filter ip6_tables iptable_filter qrtr snd_hda_codec_generic ledtrig_audio iTCO_wdt intel_pmc_bxt snd_hda_intel iTCO_vendor_support joydev snd_intel_dspcfg snd_intel_sdw_acpi snd_hda_codec snd_hda_core snd_hwdep snd_pcm snd_timer snd i2c_i801 pcspkr soundcore lpc_ich i2c_smbus virtio_net virtio_balloon net_failover failover tiny_power_button button intel_agp intel_gtt agpgart configfs ip_tables x_tables hid_generic usbhid ext4 mbcache jbd2 virtio_gpu uhci_hcd virtio_dma_buf ehci_hcd drm_shmem_helper drm_kms_helper syscopyarea sysfillrect
[  729.154919]  usbcore serio_raw virtio_blk sysimgblt virtio_rng virtiofs usb_common fb_sys_fops drm virtio_scsi fuse sg dm_multipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua msr qemu_fw_cfg [last unloaded: nvmet]
[  729.154931] ---[ end trace 0000000000000000 ]---
[  729.154932] EIP: usercopy_abort (mm/usercopy.c:101 (discriminator 17)) 
[ 729.154934] Code: 44 cb bb 9a fe d2 d1 89 4d f0 b9 ea fa d0 d1 0f 45 cb ff 75 0c ff 75 08 57 52 56 50 ff 75 f0 51 68 10 fe d2 d1 e8 52 86 ff ff <0f> 0b b8 70 7f 0b d2 83 c4 24 e8 3f dc 00 00 89 e0 56 31 d2 29 d8
All code
========
   0:	44                   	inc    %esp
   1:	cb                   	lret
   2:	bb 9a fe d2 d1       	mov    $0xd1d2fe9a,%ebx
   7:	89 4d f0             	mov    %ecx,-0x10(%ebp)
   a:	b9 ea fa d0 d1       	mov    $0xd1d0faea,%ecx
   f:	0f 45 cb             	cmovne %ebx,%ecx
  12:	ff 75 0c             	push   0xc(%ebp)
  15:	ff 75 08             	push   0x8(%ebp)
  18:	57                   	push   %edi
  19:	52                   	push   %edx
  1a:	56                   	push   %esi
  1b:	50                   	push   %eax
  1c:	ff 75 f0             	push   -0x10(%ebp)
  1f:	51                   	push   %ecx
  20:	68 10 fe d2 d1       	push   $0xd1d2fe10
  25:	e8 52 86 ff ff       	call   0xffff867c
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	b8 70 7f 0b d2       	mov    $0xd20b7f70,%eax
  31:	83 c4 24             	add    $0x24,%esp
  34:	e8 3f dc 00 00       	call   0xdc78
  39:	89 e0                	mov    %esp,%eax
  3b:	56                   	push   %esi
  3c:	31 d2                	xor    %edx,%edx
  3e:	29 d8                	sub    %ebx,%eax

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	b8 70 7f 0b d2       	mov    $0xd20b7f70,%eax
   7:	83 c4 24             	add    $0x24,%esp
   a:	e8 3f dc 00 00       	call   0xdc4e
   f:	89 e0                	mov    %esp,%eax
  11:	56                   	push   %esi
  12:	31 d2                	xor    %edx,%edx
  14:	29 d8                	sub    %ebx,%eax
[  729.154936] EAX: 00000053 EBX: d1d2fe9a ECX: f7484e08 EDX: 00000000
[  729.154937] ESI: d1d487be EDI: d1d487be EBP: d03b5cdc ESP: d03b5ca8
[  729.154938] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010286
[  729.154941] CR0: 80050033 CR2: b7f57080 CR3: 06027c20 CR4: 000006b0
[  753.362612] nvmet: ctrl 1 keep-alive timer (5 seconds) expired!
[  753.362619] nvmet: ctrl 1 fatal error occurred!
[  753.362688] nvme nvme0: starting error recovery
[  753.362962] nvmet_tcp: queue 1 unhandled state 5
[  753.363035] nvmet_tcp: queue 2 unhandled state 5
[  753.363130] nvme0c0n1: Unknown(0x3) @ LBA 18446744073709551615, 513 blocks, Host Aborted Command (sct 0x3 / sc 0x71)
[  753.392895] nvmet_tcp: queue 0 unhandled state 5
[  753.392966] nvme nvme0: Reconnecting in 10 seconds...
[  753.463036] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"
[  753.535011] PM: Removing info for No Bus:nvme0c0n1
[  753.535293] PM: Removing info for No Bus:ng0n1
[  753.613096] device: '259:27': device_unregister
[  753.613207] PM: Removing info for No Bus:259:27
[  753.613281] device: '259:27': device_create_release
[  753.613860] PM: Removing info for No Bus:nvme0n1
[  753.753744] nvme nvme0: Property Set error: 880, offset 0x14
[  753.753770] nvme nvme0: failed nvme_keep_alive_end_io error=4
[  753.753972] device: 'hwmon0': device_unregister
[  753.754061] PM: Removing info for No Bus:hwmon0
[  753.754647] PM: Removing info for No Bus:nvme0
[  753.754950] PM: Removing info for No Bus:nvme-subsys0
[  790.472628] BUG: workqueue lockup - pool cpus=2 node=0 flags=0x0 nice=-20 stuck for 56s!
[  790.472698] Showing busy workqueues and worker pools:
[  790.472708] workqueue events_highpri: flags=0x10
[  790.472720]   pwq 5: cpus=2 node=0 flags=0x0 nice=-20 active=1/256 refcnt=2
[  790.472729]     pending: mix_interrupt_randomness
[  790.472753] workqueue kblockd: flags=0x18
[  790.472763]   pwq 5: cpus=2 node=0 flags=0x0 nice=-20 active=3/256 refcnt=4
[  790.472771]     pending: blk_mq_timeout_work, blk_mq_timeout_work, blk_mq_run_work_fn
[  790.472794] workqueue nvmet-wq: flags=0x8
[  790.472805]   pwq 4: cpus=2 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
[  790.472812]     in-flight: 2191:nvmet_tcp_release_queue_work [nvmet_tcp]
[  790.472825]   pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=4/256 refcnt=5
[  790.472832]     in-flight: 2726:nvmet_tcp_release_queue_work [nvmet_tcp], 227:nvmet_fatal_error_handler [nvmet], 2723:nvmet_tcp_release_queue_work [nvmet_tcp], 2722:nvmet_tcp_release_queue_work [nvmet_tcp]
[  790.472854] workqueue nvmet_tcp_wq: flags=0x18
[  790.472865]   pwq 5: cpus=2 node=0 flags=0x0 nice=-20 active=5/256 refcnt=6
[  790.472878]     in-flight: 1802201963:nvmet_tcp_io_work [nvmet_tcp]
[  790.472881]     pending: nvmet_tcp_io_work [nvmet_tcp], nvmet_tcp_io_work [nvmet_tcp], nvmet_tcp_io_work [nvmet_tcp], nvmet_tcp_io_work [nvmet_tcp]
[  790.472894] pool 0: cpus=0 node=0 flags=0x0 nice=0 hung=1s workers=7 idle: 2349 4276 6
[  790.472909] pool 4: cpus=2 node=0 flags=0x0 nice=0 hung=0s workers=7 idle: 2500 29 734 2498 4601 2503
[  790.472926] pool 5: cpus=2 node=0 flags=0x0 nice=-20 hung=56s workers=2 idle: 213
[  821.032663] BUG: workqueue lockup - pool cpus=2 node=0 flags=0x0 nice=-20 stuck for 87s!
[  821.032676] Showing busy workqueues and worker pools:
[  821.032678] workqueue events: flags=0x0
[  821.032680]   pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
[  821.032684]     pending: vmstat_shepherd
[  821.032695] workqueue events_highpri: flags=0x10
[  821.032698]   pwq 5: cpus=2 node=0 flags=0x0 nice=-20 active=1/256 refcnt=2
[  821.032701]     pending: mix_interrupt_randomness
[  821.032706] workqueue mm_percpu_wq: flags=0x8
[  821.032709]   pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
[  821.032711]     pending: vmstat_update
[  821.032713] workqueue writeback: flags=0x4a
[  821.032715]   pwq 8: cpus=0-3 flags=0x4 nice=0 active=1/256 refcnt=3
[  821.032717]     in-flight: 3832:wb_workfn
[  821.032722] workqueue kblockd: flags=0x18
[  821.032724]   pwq 5: cpus=2 node=0 flags=0x0 nice=-20 active=3/256 refcnt=4
[  821.032726]     pending: blk_mq_timeout_work, blk_mq_timeout_work, blk_mq_run_work_fn
[  821.032738] workqueue nvmet-wq: flags=0x8
[  821.032740]   pwq 4: cpus=2 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
[  821.032742]     in-flight: 2191:nvmet_tcp_release_queue_work [nvmet_tcp]
[  821.032750]   pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=4/256 refcnt=5
[  821.032752]     in-flight: 2726:nvmet_tcp_release_queue_work [nvmet_tcp], 227:nvmet_fatal_error_handler [nvmet], 2723:nvmet_tcp_release_queue_work [nvmet_tcp], 2722:nvmet_tcp_release_queue_work [nvmet_tcp]
[  821.032766] workqueue nvmet_tcp_wq: flags=0x18
[  821.032770]   pwq 5: cpus=2 node=0 flags=0x0 nice=-20 active=5/256 refcnt=6
[  821.032771]     in-flight: 1802201963:nvmet_tcp_io_work [nvmet_tcp]
[  821.032773]     pending: nvmet_tcp_io_work [nvmet_tcp], nvmet_tcp_io_work [nvmet_tcp], nvmet_tcp_io_work [nvmet_tcp], nvmet_tcp_io_work [nvmet_tcp]
[  821.032779] pool 0: cpus=0 node=0 flags=0x0 nice=0 hung=0s workers=7 idle: 2349 4276 6
[  821.032782] pool 4: cpus=2 node=0 flags=0x0 nice=0 hung=0s workers=7 idle: 2500 29 734 2498 4601 2503
[  821.032787] pool 5: cpus=2 node=0 flags=0x0 nice=-20 hung=87s workers=2 idle: 213
[  821.032789] pool 8: cpus=0-3 flags=0x4 nice=0 hung=0s workers=5 idle: 3865 99 97 98
[  851.052808] BUG: workqueue lockup - pool cpus=2 node=0 flags=0x0 nice=-20 stuck for 117s!
[  851.052822] Showing busy workqueues and worker pools:
[  851.052824] workqueue events_highpri: flags=0x10
[  851.052826]   pwq 5: cpus=2 node=0 flags=0x0 nice=-20 active=1/256 refcnt=2
[  851.052830]     pending: mix_interrupt_randomness
[  851.052839] workqueue writeback: flags=0x4a
[  851.052842]   pwq 8: cpus=0-3 flags=0x4 nice=0 active=1/256 refcnt=3
[  851.052844]     in-flight: 3832:wb_workfn
[  851.052848] workqueue kblockd: flags=0x18
[  851.052851]   pwq 5: cpus=2 node=0 flags=0x0 nice=-20 active=3/256 refcnt=4
[  851.052853]     pending: blk_mq_timeout_work, blk_mq_timeout_work, blk_mq_run_work_fn
[  851.052867] workqueue nvmet-wq: flags=0x8
[  851.052870]   pwq 4: cpus=2 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
[  851.052871]     in-flight: 2191:nvmet_tcp_release_queue_work [nvmet_tcp]
[  851.052882]   pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=4/256 refcnt=5
[  851.052884]     in-flight: 2726:nvmet_tcp_release_queue_work [nvmet_tcp], 227:nvmet_fatal_error_handler [nvmet], 2723:nvmet_tcp_release_queue_work [nvmet_tcp], 2722:nvmet_tcp_release_queue_work [nvmet_tcp]
[  851.052898] workqueue nvmet_tcp_wq: flags=0x18
[  851.052901]   pwq 5: cpus=2 node=0 flags=0x0 nice=-20 active=5/256 refcnt=6
[  851.052903]     in-flight: 1802201963:nvmet_tcp_io_work [nvmet_tcp]
[  851.052905]     pending: nvmet_tcp_io_work [nvmet_tcp], nvmet_tcp_io_work [nvmet_tcp], nvmet_tcp_io_work [nvmet_tcp], nvmet_tcp_io_work [nvmet_tcp]
[  851.052910] pool 0: cpus=0 node=0 flags=0x0 nice=0 hung=0s workers=7 idle: 2349 4276 6
[  851.052915] pool 4: cpus=2 node=0 flags=0x0 nice=0 hung=0s workers=7 idle: 2500 29 734 2498 4601 2503
[  851.052920] pool 5: cpus=2 node=0 flags=0x0 nice=-20 hung=117s workers=2 idle: 213
[  851.052923] pool 8: cpus=0-3 flags=0x4 nice=0 hung=1s workers=5 idle: 99 3865 97 98
[  881.262608] BUG: workqueue lockup - pool cpus=2 node=0 flags=0x0 nice=-20 stuck for 147s!
[  881.262647] Showing busy workqueues and worker pools:
[  881.262654] workqueue events_highpri: flags=0x10
[  881.262661]   pwq 5: cpus=2 node=0 flags=0x0 nice=-20 active=1/256 refcnt=2
[  881.262668]     pending: mix_interrupt_randomness
[  881.262681] workqueue writeback: flags=0x4a
[  881.262687]   pwq 8: cpus=0-3 flags=0x4 nice=0 active=1/256 refcnt=3
[  881.262693]     in-flight: 3832:wb_workfn
[  881.262701] workqueue kblockd: flags=0x18
[  881.262708]   pwq 5: cpus=2 node=0 flags=0x0 nice=-20 active=3/256 refcnt=4
[  881.262713]     pending: blk_mq_timeout_work, blk_mq_timeout_work, blk_mq_run_work_fn
[  881.262728] workqueue nvmet-wq: flags=0x8
[  881.262735]   pwq 4: cpus=2 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
[  881.262740]     in-flight: 2191:nvmet_tcp_release_queue_work [nvmet_tcp]
[  881.262749]   pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=4/256 refcnt=5
[  881.262754]     in-flight: 2726:nvmet_tcp_release_queue_work [nvmet_tcp], 227:nvmet_fatal_error_handler [nvmet], 2723:nvmet_tcp_release_queue_work [nvmet_tcp], 2722:nvmet_tcp_release_queue_work [nvmet_tcp]
[  881.262771] workqueue nvmet_tcp_wq: flags=0x18
[  881.262778]   pwq 5: cpus=2 node=0 flags=0x0 nice=-20 active=5/256 refcnt=6
[  881.262782]     in-flight: 1802201963:nvmet_tcp_io_work [nvmet_tcp]
[  881.262785]     pending: nvmet_tcp_io_work [nvmet_tcp], nvmet_tcp_io_work [nvmet_tcp], nvmet_tcp_io_work [nvmet_tcp], nvmet_tcp_io_work [nvmet_tcp]
[  881.262794] pool 0: cpus=0 node=0 flags=0x0 nice=0 hung=0s workers=7 idle: 2349 4276 6
[  881.262804] pool 4: cpus=2 node=0 flags=0x0 nice=0 hung=3s workers=7 idle: 2500 29 734 2498 4601 2503
[  881.262816] pool 5: cpus=2 node=0 flags=0x0 nice=-20 hung=147s workers=2 idle: 213
[  881.262825] pool 8: cpus=0-3 flags=0x4 nice=0 hung=0s workers=5 idle: 99 3865 97 98

-- 
2.37.2

