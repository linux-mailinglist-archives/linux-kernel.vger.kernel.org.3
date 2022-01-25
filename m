Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0305549B4AA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 14:12:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1575761AbiAYNLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 08:11:35 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:34491 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1575524AbiAYNI7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 08:08:59 -0500
Received: from [192.168.0.2] (ip5f5aeaa2.dynamic.kabel-deutschland.de [95.90.234.162])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id AB07361E6478B;
        Tue, 25 Jan 2022 14:08:53 +0100 (CET)
Message-ID: <92c233bc-d1e0-b180-efaa-27e05fbd732b@molgen.mpg.de>
Date:   Tue, 25 Jan 2022 14:08:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Zha Qipeng <qipeng.zha@intel.com>
Cc:     linux-kernel@vger.kernel.org
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Subject: mfd/intel_pmc_bxt: `intel_pmc_get_resources()` results in page fault
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linux folks,


`intel_pmc_get_resources()` does not set the name member in the 
`resource` struct `gcr_res` resulting in a page fault.

```
[    0.592954] Run /init as init process
[    0.594199]   with arguments:
[    0.594201]     /init
[    0.594203]   with environment:
[    0.594204]     HOME=/
[    0.594205]     TERM=linux
[    0.594206]     BOOT_IMAGE=/boot/vmlinuz-5.13.0-27-generic
[    0.792277] BUG: unable to handle page fault for address: 
ffffffff00000dc0
[    0.794072] #PF: supervisor read access in kernel mode
[    0.795873] #PF: error_code(0x0000) - not-present page
[    0.797698] PGD 107e15067 P4D 107e15067 PUD 0
[    0.799514] Oops: 0000 [#1] SMP PTI
[    0.801344] CPU: 2 PID: 182 Comm: systemd-udevd Not tainted 
5.13.0-27-generic #29~20.04.1-Ubuntu
[    0.803202] Hardware name: Star Labs Lite/Lite, BIOS 8 01/24/2022
[    0.805041] RIP: 0010:string_nocheck+0x38/0x60
[    0.806918] Code: 66 85 c0 74 3e 83 e8 01 4c 8d 5c 07 01 31 c0 eb 19 
49 39 fa 76 03 44 88 07 48 83 c7 01 41 8d 71 01 48 83 c0 01 4c 39 df 74 
0f <44> 0f b6 04 02 41 89 c1 89 c6 45 84 c0 75 d8 4c 89 d2 e8 11 ff ff
[    0.808908] RSP: 0018:ffffb6d58056b7d0 EFLAGS: 00010246
[    0.810881] RAX: 0000000000000000 RBX: ffffb6d58056b870 RCX: 
ffff0a00ffffff04
[    0.812850] RDX: ffffffff00000dc0 RSI: 0000000000000000 RDI: 
000000000000000b
[    0.814777] RBP: ffffb6d58056b7d0 R08: ffffffff9b61ba58 R09: 
000000000000000a
[    0.816732] R10: 0000000000000000 R11: 000000010000000a R12: 
0000000000000000
[    0.818605] R13: ffffffff00000dc0 R14: ffff0a00ffffff04 R15: 
000000000000000b
[    0.820559] FS:  00007fd48008b880(0000) GS:ffff9324fc100000(0000) 
knlGS:0000000000000000
[    0.822536] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.824499] CR2: ffffffff00000dc0 CR3: 0000000101dbe000 CR4: 
0000000000350ee0
[    0.826477] Call Trace:
[    0.828434]  string+0x4a/0x60
[    0.830387]  vsnprintf+0x26f/0x4e0
[    0.832346]  devm_kvasprintf+0x55/0xb0
[    0.834288]  devm_kasprintf+0x4e/0x70
[    0.836216]  __devm_ioremap_resource+0x7e/0x110
[    0.838158]  devm_ioremap_resource+0xb/0x10
[    0.840097]  intel_pmc_get_resources.isra.0+0x9e/0x430 [intel_pmc_bxt]
[    0.842028]  ? devres_add+0x5f/0x70
[    0.843945]  intel_pmc_probe+0x76/0x170 [intel_pmc_bxt]
[    0.845808]  platform_probe+0x45/0xa0
[    0.847673]  really_probe+0x1dc/0x440
[    0.849520]  driver_probe_device+0xf0/0x160
[    0.851304]  device_driver_attach+0x5d/0x70
[    0.853031]  __driver_attach+0xb2/0x140
[    0.854842]  ? device_driver_attach+0x70/0x70
[    0.856647]  bus_for_each_dev+0x7e/0xc0
[    0.858457]  driver_attach+0x1e/0x20
[    0.860228]  bus_add_driver+0x152/0x1f0
[    0.862014]  driver_register+0x74/0xd0
[    0.863707]  ? 0xffffffffc0189000
[    0.865406]  __platform_driver_register+0x1e/0x20
[    0.867098]  intel_pmc_driver_init+0x1c/0x1000 [intel_pmc_bxt]
[    0.868774]  do_one_initcall+0x46/0x1d0
[    0.870449]  ? __cond_resched+0x19/0x30
[    0.872030]  ? kmem_cache_alloc_trace+0x37c/0x440
[    0.873697]  do_init_module+0x62/0x260
[    0.875308]  load_module+0x125d/0x1440
[    0.876983]  __do_sys_finit_module+0xc2/0x120
[    0.878675]  ? __do_sys_finit_module+0xc2/0x120
[    0.880365]  __x64_sys_finit_module+0x1a/0x20
[    0.882029]  do_syscall_64+0x61/0xb0
[    0.883734]  ? __x64_sys_read+0x1a/0x20
[    0.885422]  ? do_syscall_64+0x6e/0xb0
[    0.887152]  ? do_syscall_64+0x6e/0xb0
[    0.888875]  ? syscall_exit_to_user_mode+0x27/0x50
[    0.890542]  ? __x64_sys_newstat+0x16/0x20
[    0.892234]  ? do_syscall_64+0x6e/0xb0
[    0.893947]  ? do_syscall_64+0x6e/0xb0
[    0.895645]  ? do_syscall_64+0x6e/0xb0
[    0.897321]  ? do_syscall_64+0x6e/0xb0
[    0.898909]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[    0.900587] RIP: 0033:0x7fd48060d89d
[    0.902217] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 
48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d c3 f5 0c 00 f7 d8 64 89 01 48
[    0.904009] RSP: 002b:00007ffe1f9e0058 EFLAGS: 00000246 ORIG_RAX: 
0000000000000139
[    0.905808] RAX: ffffffffffffffda RBX: 00005570f9be8830 RCX: 
00007fd48060d89d
[    0.907591] RDX: 0000000000000000 RSI: 00007fd4804eaded RDI: 
0000000000000005
[    0.909378] RBP: 0000000000020000 R08: 0000000000000000 R09: 
0000000000000000
[    0.911073] R10: 0000000000000005 R11: 0000000000000246 R12: 
00007fd4804eaded
[    0.912754] R13: 0000000000000000 R14: 00005570f9bdda60 R15: 
00005570f9be8830
[    0.914435] Modules linked in: fjes(+) hid(+) intel_pmc_bxt(+) 
pinctrl_geminilake(+)
[    0.916078] CR2: ffffffff00000dc0
[    0.917705] ---[ end trace 81defb97a01a8ee4 ]---
[    0.919288] RIP: 0010:string_nocheck+0x38/0x60
[    0.920894] Code: 66 85 c0 74 3e 83 e8 01 4c 8d 5c 07 01 31 c0 eb 19 
49 39 fa 76 03 44 88 07 48 83 c7 01 41 8d 71 01 48 83 c0 01 4c 39 df 74 
0f <44> 0f b6 04 02 41 89 c1 89 c6 45 84 c0 75 d8 4c 89 d2 e8 11 ff ff
[    0.922530] RSP: 0018:ffffb6d58056b7d0 EFLAGS: 00010246
[    0.924126] RAX: 0000000000000000 RBX: ffffb6d58056b870 RCX: 
ffff0a00ffffff04
[    0.925753] RDX: ffffffff00000dc0 RSI: 0000000000000000 RDI: 
000000000000000b
[    0.927376] RBP: ffffb6d58056b7d0 R08: ffffffff9b61ba58 R09: 
000000000000000a
[    0.929043] R10: 0000000000000000 R11: 000000010000000a R12: 
0000000000000000
[    0.930689] R13: ffffffff00000dc0 R14: ffff0a00ffffff04 R15: 
000000000000000b
[    0.932281] FS:  00007fd48008b880(0000) GS:ffff9324fc100000(0000) 
knlGS:0000000000000000
[    0.933887] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.935477] CR2: ffffffff00000dc0 CR3: 0000000101dbe000 CR4: 
0000000000350ee0
[    0.941894] idma64 idma64.0: Found Intel integrated DMA 64-bit
[    0.944318] ahci 0000:00:12.0: version 3.0
[    0.952275] hid: raw HID events driver (C) Jiri Kosina
[    0.952968] xhci_hcd 0000:00:15.0: xHCI Host Controller
[    0.953622] idma64 idma64.1: Found Intel integrated DMA 64-bit
[    0.954588] sdhci: Secure Digital Host Controller Interface driver
[    0.955750] xhci_hcd 0000:00:15.0: new USB bus registered, assigned 
bus number 1
```


Kind regards,

Paul
