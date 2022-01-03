Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 272974838AD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 23:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbiACWCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 17:02:31 -0500
Received: from giacobini.uberspace.de ([185.26.156.129]:47652 "EHLO
        giacobini.uberspace.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiACWCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 17:02:31 -0500
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Mon, 03 Jan 2022 17:02:30 EST
Received: (qmail 30180 invoked by uid 990); 3 Jan 2022 21:55:48 -0000
Authentication-Results: giacobini.uberspace.de;
        auth=pass (plain)
Message-ID: <36ec2e79-7544-ba14-8bdd-d748dfad0ea7@eknoes.de>
Date:   Mon, 3 Jan 2022 22:55:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Content-Language: en-US
To:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        luiz.von.dentz@intel.com, Marcel Holtmann <marcel@holtmann.org>
From:   =?UTF-8?Q?S=c3=b6nke_Huster?= <soenke.huster@eknoes.de>
Subject: [BUG] Page Fault in hci_inquiry_result_with_rssi_evt
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Bar: --
X-Rspamd-Report: BAYES_HAM(-2.999632) MIME_GOOD(-0.1) R_MIXED_CHARSET(0.714285)
X-Rspamd-Score: -2.385347
Received: from unknown (HELO unkown) (::1)
        by giacobini.uberspace.de (Haraka/2.8.28) with ESMTPSA; Mon, 03 Jan 2022 22:55:48 +0100
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

While fuzzing bluetooth-next I found the following bug:

[   27.333034] BUG: unable to handle page fault for address: fffff61a1a1a1a1a
[   27.333241] #PF: supervisor read access in kernel mode
[   27.333241] #PF: error_code(0x0000) - not-present page
[   27.333241] PGD 6dfd2067 P4D 6dfd2067 PUD 0 
[   27.333241] Oops: 0000 [#1] PREEMPT SMP KASAN NOPTI
[   27.333241] CPU: 0 PID: 45 Comm: kworker/u3:2 Not tainted 5.16.0-rc1+ #81
[   27.333241] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[   27.333241] Workqueue: hci0 hci_rx_work
[   27.333241] RIP: 0010:hci_inquiry_result_with_rssi_evt+0xbc/0x950
[   27.333241] Code: 8b 04 24 48 c1 e8 03 42 80 3c 28 00 0f 85 20 07 00 00 48 8b 04 24 4c 8b 28 48 b8 00 00 00 00 00 fc ff df 4c 89 0
[   27.333241] RSP: 0018:ffffc900004ff9c8 EFLAGS: 00010212
[   27.333241] RAX: dffffc0000000000 RBX: 0000000000000022 RCX: ffffffff834663d1
[   27.333241] RDX: 1ffffa1a1a1a1a1a RSI: 0000000000000012 RDI: ffff88800affb074
[   27.333241] RBP: ffff88800aae0000 R08: ffffffff844ef360 R09: ffffffff83487b35
[   27.333241] R10: 000000000000002c R11: 0000000000000022 R12: ffff88800affb000
[   27.333241] R13: ffffd0d0d0d0d0d0 R14: 0000000000000000 R15: ffff88800aae0000
[   27.333241] FS:  0000000000000000(0000) GS:ffff88806ce00000(0000) knlGS:0000000000000000
[   27.333241] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   27.333241] CR2: fffff61a1a1a1a1a CR3: 0000000004a26000 CR4: 00000000000006f0
[   27.333241] Call Trace:
[   27.333241]  <TASK>
[   27.333241]  ? wait_for_completion_io+0x270/0x270
[   27.333241]  ? hci_inquiry_result_evt+0x4b0/0x4b0
[   27.333241]  hci_event_packet+0x3b11/0x7b10
[   27.333241]  ? lock_chain_count+0x20/0x20
[   27.333241]  ? hci_cmd_status_evt.constprop.0+0x4ea0/0x4ea0
[   27.333241]  ? sysvec_reboot+0x50/0xc0
[   27.333241]  ? find_held_lock+0x2c/0x110
[   27.333241]  ? lock_release+0x3b2/0x6f0
[   27.333241]  ? skb_dequeue+0x110/0x1a0
[   27.333241]  ? mark_held_locks+0x9e/0xe0
[   27.333241]  ? lockdep_hardirqs_on_prepare+0x17b/0x400
[   27.333241]  hci_rx_work+0x4d3/0xb90
[   27.333241]  process_one_work+0x904/0x1590
[   27.333241]  ? lock_release+0x6f0/0x6f0
[   27.333241]  ? pwq_dec_nr_in_flight+0x230/0x230
[   27.333241]  ? rwlock_bug.part.0+0x90/0x90
[   27.333241]  ? _raw_spin_lock_irq+0x41/0x50
[   27.333241]  worker_thread+0x578/0x1310
[   27.333241]  ? process_one_work+0x1590/0x1590
[   27.333241]  kthread+0x3b2/0x490
[   27.333241]  ? _raw_spin_unlock_irq+0x1f/0x40
[   27.333241]  ? set_kthread_struct+0x100/0x100
[   27.333241]  ret_from_fork+0x22/0x30
[   27.333241]  </TASK>
[   27.333241] Modules linked in:
[   27.333241] CR2: fffff61a1a1a1a1a
[   27.333241] ---[ end trace 6a6825484c8fefa6 ]---
[   27.333241] RIP: 0010:hci_inquiry_result_with_rssi_evt+0xbc/0x950
[   27.333241] Code: 8b 04 24 48 c1 e8 03 42 80 3c 28 00 0f 85 20 07 00 00 48 8b 04 24 4c 8b 28 48 b8 00 00 00 00 00 fc ff df 4c 89 0
[   27.333241] RSP: 0018:ffffc900004ff9c8 EFLAGS: 00010212
[   27.333241] RAX: dffffc0000000000 RBX: 0000000000000022 RCX: ffffffff834663d1
[   27.333241] RDX: 1ffffa1a1a1a1a1a RSI: 0000000000000012 RDI: ffff88800affb074
[   27.333241] RBP: ffff88800aae0000 R08: ffffffff844ef360 R09: ffffffff83487b35
[   27.333241] R10: 000000000000002c R11: 0000000000000022 R12: ffff88800affb000
[   27.333241] R13: ffffd0d0d0d0d0d0 R14: 0000000000000000 R15: ffff88800aae0000
[   27.333241] FS:  0000000000000000(0000) GS:ffff88806ce00000(0000) knlGS:0000000000000000
[   27.333241] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   27.333241] CR2: fffff61a1a1a1a1a CR3: 0000000004a26000 CR4: 00000000000006f0
[   27.379996] kworker/u3:2 (45) used greatest stack depth: 27736 bytes left

It occurs when sending the following frame to the kernel:

$ xxd crashes/hci_inquiry_result_with_rssi_evt
00000000: 0422 24d0 d0d0 d0d0 d0ff ff              ."$........

The bug was introduced with the commit "Bluetooth: HCI: Use skb_pull_data to parse Inquiry Result with RSSI event" (https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/commit/?id=8d08d324fdcb7).
