Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D887348FFCE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 01:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236527AbiAQAtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 19:49:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232724AbiAQAtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 19:49:32 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E789BC061574;
        Sun, 16 Jan 2022 16:49:31 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id l17so17683255qtk.7;
        Sun, 16 Jan 2022 16:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=VF9zy+f4TEJ0Oz8aOvvvQXIAmaKX9d7xk0ZYr1F46Kg=;
        b=m3p/nBs91OyfrFFGwV0+yixs0tRitVt2aahSUevA8ANB+8P5I2LLtcDdTWGbTjm/Nb
         vkuSB5iY1Wp3Hd4C06bB7G5pUy+k2pZQ340ioIdlMl+GuzvXcMv9PcxnZrhAbwPd26fT
         jW+o32LMkypCgCVWrNzHWPm3aV+32gCNpOOL87maUxsWC3EjeZp/ROmmtbQx2uUenS5r
         9TIIWUz2se1jeZTNOjUE8KSHIwRPLtH/GRZD7bE44bR2JPUb2ludQr2zAiMWzuAcNCx0
         TkzpQ3PEoJ0H6uyJh14UpTILraCsoocbxTNRETHpp+igivWOxTAJrRwRdvnv8TNZHlB0
         BThg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=VF9zy+f4TEJ0Oz8aOvvvQXIAmaKX9d7xk0ZYr1F46Kg=;
        b=wwlMwNsxtyje1FGBO3LQbueG9MDKrJtsNdLMc4q7lRpBsPMo+ihYWZyvUwRReuBOFB
         69fuGQ3TjxK7Bz5o10PfkKrvj+vUk26LOebEqEDSu20OgGJ47/WoH7rMoy/GWLwNwOvC
         PHrOjx8rEjIRu317QpYd9jVmgydsprRHRxVvTP4xzW5hPIKZahNL4ORWdVgFkjOSrS+1
         KoL6kDjIGTGDeqaWRnfsCCeT+ayfIUoYg8apaCKgPyA2f91BJcjofmzdpXC86JU8BLUF
         g5aVQBWrO9MVatUn0ohpXcXIJn0dmg5q8VAbCZMxT0pCUezKDi0OXyYoWtTkH/C6N2S2
         PqqA==
X-Gm-Message-State: AOAM533KmiAyYFtkjcVMk+jkPzPP/HfpaCB3sTch6Cv6ghrfxVEmIk6A
        eWA7ZtH4mEhzYVSxb9LkISCSF3z6vXftx1do9I4Bk390YR4DHA==
X-Google-Smtp-Source: ABdhPJwnSwdPnTFazY/JFDJ4nZOu5kjolMg6uNv9KYAIcHuNivMYLzvMx4jkH0GlSLjZ3a4GyfNBEB/GVLYzl1bZxQQ=
X-Received: by 2002:a05:622a:612:: with SMTP id z18mr15924004qta.616.1642380571027;
 Sun, 16 Jan 2022 16:49:31 -0800 (PST)
MIME-Version: 1.0
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Mon, 17 Jan 2022 05:49:19 +0500
Message-ID: <CABXGCsNb22JCJ4AyR1sYqFtF4QUnvM3B2zQcc1svcm2mquWxoA@mail.gmail.com>
Subject: [Bug][5.17-rc0] Between commits daadb3bd0e8d and 455e73a07f6e, the
 kernel stops loading on my devices.
To:     heikki.krogerus@linux.intel.com,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        rafael.j.wysocki@intel.com, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
Between commits 7ddb58cb0eca and d2f38a3c6507, the kernel stops
loading on my devices.
On the kernel log I see such a trace:
[    5.868358] primary-ws kernel: Oops: 0000 [#1] PREEMPT SMP NOPTI
[    5.868360] primary-ws kernel: CPU: 23 PID: 305 Comm: kworker/23:2
Tainted: G        W        --------- ---
5.17.0-0.rc0.20220113git455e73a07f6e.64.fc36.x86_64 #1
[    5.868363] primary-ws kernel: Hardware name: System manufacturer
System Product Name/ROG STRIX X570-I GAMING, BIOS 4021 08/09/2021
[    5.868365] primary-ws kernel: Workqueue: events_long
ucsi_init_work [typec_ucsi]
[    5.868370] primary-ws kernel: RIP: 0010:typec_port_match+0x44/0x80 [typec]
[    5.868377] primary-ws kernel: Code: 06 48 8b 98 00 05 00 00 48 89
df 48 83 eb 10 e8 b2 53 3b f3 84 c0 b8 00 00 00 00 48 0f 44 d8 4c 39
eb 74 0a 8b 85 70 fd ff ff <39> 03 74 09 5b 31 c0 5d 41 5c 41 5d c3 49
8b 3c 24 49 8d 74 24 08
[    5.868379] primary-ws kernel: RSP: 0018:ffffbf704494bd60 EFLAGS: 00010207
[    5.868381] primary-ws kernel: RAX: 0000000000000000 RBX:
0000000000000000 RCX: 0000000000000000
[    5.868382] primary-ws kernel: RDX: 0000000000000001 RSI:
ffffbf704494bdb8 RDI: 0000000000000000
[    5.868384] primary-ws kernel: RBP: ffff9a23c2bbf290 R08:
0000000000000001 R09: 0000000000000001
[    5.868385] primary-ws kernel: R10: 0000000000000001 R11:
0000000000000000 R12: ffffbf704494bdb8
[    5.868386] primary-ws kernel: R13: ffff9a23c2bbf000 R14:
ffff9a23c1b99008 R15: ffff9a23c1b01820
[    5.868388] primary-ws kernel: FS:  0000000000000000(0000)
GS:ffff9a32a8600000(0000) knlGS:0000000000000000
[    5.868389] primary-ws kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
[    5.868391] primary-ws kernel: CR2: 0000000000000000 CR3:
000000017c482000 CR4: 0000000000350ee0
[    5.868393] primary-ws kernel: Call Trace:
[    5.868394] primary-ws kernel:  <TASK>
[    5.868396] primary-ws kernel:  ? typec_port_compare+0x10/0x10 [typec]
[    5.868401] primary-ws kernel:  bus_for_each_dev+0x67/0x90
[    5.868406] primary-ws kernel:  typec_link_ports+0x32/0x50 [typec]
[    5.868411] primary-ws kernel:  typec_register_port+0x1e6/0x2e0 [typec]
[    5.868416] primary-ws kernel:  ucsi_init_work+0x463/0x840 [typec_ucsi]
[    5.868420] primary-ws kernel:  process_one_work+0x2bb/0x600
[    5.868426] primary-ws kernel:  worker_thread+0x55/0x3b0
[    5.868429] primary-ws kernel:  ? process_one_work+0x600/0x600
[    5.868431] primary-ws kernel:  kthread+0x17c/0x1a0
[    5.868433] primary-ws kernel:  ? set_kthread_struct+0x40/0x40
[    5.868436] primary-ws kernel:  ret_from_fork+0x22/0x30
[    5.868441] primary-ws kernel:  </TASK>
[    5.868442] primary-ws kernel: Modules linked in: crct10dif_pclmul
crc32_pclmul crc32c_intel ucsi_ccg drm_ttm_helper ghash_clmulni_intel
typec_ucsi ttm ccp sp5100_tco typec igb iommu_v2 gpu_sched nvme
nvme_core dca wmi ipmi_devintf ipmi_msghandler fuse
[    5.868455] primary-ws kernel: CR2: 0000000000000000
[    5.868457] primary-ws kernel: ---[ end trace c5a60084d820dc9c ]---
[    5.868459] primary-ws kernel: RIP: 0010:typec_port_match+0x44/0x80 [typec]
[    5.868463] primary-ws kernel: Code: 06 48 8b 98 00 05 00 00 48 89
df 48 83 eb 10 e8 b2 53 3b f3 84 c0 b8 00 00 00 00 48 0f 44 d8 4c 39
eb 74 0a 8b 85 70 fd ff ff <39> 03 74 09 5b 31 c0 5d 41 5c 41 5d c3 49
8b 3c 24 49 8d 74 24 08
[    5.868465] primary-ws kernel: RSP: 0018:ffffbf704494bd60 EFLAGS: 00010207
[    5.868467] primary-ws kernel: RAX: 0000000000000000 RBX:
0000000000000000 RCX: 0000000000000000
[    5.868468] primary-ws kernel: RDX: 0000000000000001 RSI:
ffffbf704494bdb8 RDI: 0000000000000000
[    5.868469] primary-ws kernel: RBP: ffff9a23c2bbf290 R08:
0000000000000001 R09: 0000000000000001
[    5.868470] primary-ws kernel: R10: 0000000000000001 R11:
0000000000000000 R12: ffffbf704494bdb8
[    5.868471] primary-ws kernel: R13: ffff9a23c2bbf000 R14:
ffff9a23c1b99008 R15: ffff9a23c1b01820
[    5.868473] primary-ws kernel: FS:  0000000000000000(0000)
GS:ffff9a32a8600000(0000) knlGS:0000000000000000
[    5.868475] primary-ws kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
[    5.868476] primary-ws kernel: CR2: 0000000000000000 CR3:
000000017c482000 CR4: 0000000000350ee0

I also bisect kernel and found first bad commit:

$ git bisect log
git bisect start
# good: [daadb3bd0e8d3e317e36bc2c1542e86c528665e5] Merge tag
'locking_core_for_v5.17_rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good daadb3bd0e8d3e317e36bc2c1542e86c528665e5
# bad: [455e73a07f6e288b0061dfcf4fcf54fa9fe06458] Merge tag
'clk-for-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux
git bisect bad 455e73a07f6e288b0061dfcf4fcf54fa9fe06458
# good: [342465f5337f7bd5b8bd3b6f939ac12b620cbb43] Merge tag
'tty-5.17-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty
git bisect good 342465f5337f7bd5b8bd3b6f939ac12b620cbb43
# bad: [362f533a2a1098fe95020cb59340023e9b11d062] Merge tag
'cxl-for-5.17' of
git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl
git bisect bad 362f533a2a1098fe95020cb59340023e9b11d062
# bad: [6020c204be997e3f5129839ff9c801800fb4336e] Merge tag
'folio-5.17' of git://git.infradead.org/users/willy/pagecache
git bisect bad 6020c204be997e3f5129839ff9c801800fb4336e
# bad: [e681a9d2050cdcaf24adeabc9f1aea6cff94be22] Merge 5.16-rc8 into usb-next
git bisect bad e681a9d2050cdcaf24adeabc9f1aea6cff94be22
# good: [a5b5b45fce2bed5560159095b4777afb18590740] dt-bindings: usb:
dwc3-xilinx: Convert USB DWC3 bindings
git bisect good a5b5b45fce2bed5560159095b4777afb18590740
# good: [cf081d009c447647c6b36aced535ca427dbebe72] usb: musb: Set the
DT node on the child device
git bisect good cf081d009c447647c6b36aced535ca427dbebe72
# good: [78e17d69999521b52b9db9656e9b9b397f59f228] usb: cdns3: Use
platform_get_irq_byname() to get the interrupt
git bisect good 78e17d69999521b52b9db9656e9b9b397f59f228
# good: [13068b7472f9720f807fe72b9bf3f76b9fd6d6ab] acpi: Export acpi_bus_type
git bisect good 13068b7472f9720f807fe72b9bf3f76b9fd6d6ab
# bad: [730b49aac426e1e8016d3c2dd6b407e500423821] usb: typec:
port-mapper: Convert to the component framework
git bisect bad 730b49aac426e1e8016d3c2dd6b407e500423821
# good: [8c67d06f3fd9639c44d8147483fb1c132d71388f] usb: Link the ports
to the connectors they are attached to
git bisect good 8c67d06f3fd9639c44d8147483fb1c132d71388f
# first bad commit: [730b49aac426e1e8016d3c2dd6b407e500423821] usb:
typec: port-mapper: Convert to the component framework

$ git bisect good
730b49aac426e1e8016d3c2dd6b407e500423821 is the first bad commit
commit 730b49aac426e1e8016d3c2dd6b407e500423821
Author: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Date:   Thu Dec 23 11:24:22 2021 +0300

    usb: typec: port-mapper: Convert to the component framework

    Instead of trying to keep track of the connections to the
    USB Type-C connectors separately, letting the component
    framework take care of that.

    From now on every USB Type-C connector will register itself
    as "aggregate" - component master - and anything that can be
    connected to it inside the system can then simply register
    itself as a generic component.

    The matching of the components and the connector shall rely
    on ACPI _PLD initially. Before registering itself as the
    aggregate, the connector will find all other ACPI devices
    that have matching _PLD crc hash with it (matching value in
    the pld_crc member of struct acpi_device), and add a
    component match entry for each one of them. Because only
    ACPI is supported for now, the driver shall only be build
    when ACPI is supported.

    This removes the need for the custom API that the driver
    exposed. The components and the connector can therefore
    exist completely independently of each other. The order in
    which they are registered, as well as are they modules or
    not, is now irrelevant.

    Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
    Link: https://lore.kernel.org/r/20211223082422.45637-1-heikki.krogerus@linux.intel.com
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

 drivers/usb/typec/Makefile      |   3 +-
 drivers/usb/typec/class.c       |   2 -
 drivers/usb/typec/class.h       |  10 +-
 drivers/usb/typec/port-mapper.c | 279 ++++++----------------------------------
 include/linux/usb/typec.h       |  12 --
 5 files changed, 46 insertions(+), 260 deletions(-)

Full kernel log is here: https://pastebin.com/byYtHyxZ

-- 
Best Regards,
Mike Gavrilov.
