Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC2A94FF869
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 16:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235964AbiDMOGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 10:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235897AbiDMOGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 10:06:00 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96785EDEA
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 07:03:36 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220413140331euoutp02628c2733fc2ec6f3e0cbfa043f548520~leapj0ui-1592815928euoutp02L
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 14:03:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220413140331euoutp02628c2733fc2ec6f3e0cbfa043f548520~leapj0ui-1592815928euoutp02L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1649858611;
        bh=T1R0CTD+wK1aIDXGzvZszJrbPF4LXgOY3H4YB4JCr/E=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=uhokYIVA9iAIFxcb0ZQ8P0jKl90CnE6Z5kwnnAZ7BtdQPOh7amb3fYhx5pw8m7xhl
         IWn7R1ljCzxvOZni65W+KphKfS36xOIJSkVG7QH52GM0FPfwZo0VBJVlyuurqfceSS
         bfeMfgF4kahSMI3XGcPfXFYvryz2FYQqxTdvnJfI=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220413140330eucas1p197fd5105f44db7a0e9d9f288ddf42eaf~leao-67_32380323803eucas1p1W;
        Wed, 13 Apr 2022 14:03:30 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 52.79.09887.238D6526; Wed, 13
        Apr 2022 15:03:30 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220413140330eucas1p167da41e079712b829ef8237dc27b049c~leaob6iMu0436704367eucas1p1J;
        Wed, 13 Apr 2022 14:03:30 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220413140330eusmtrp16308acac5b795abba1e1fc27975b71d1~leaoa3Dvu0036800368eusmtrp1A;
        Wed, 13 Apr 2022 14:03:30 +0000 (GMT)
X-AuditID: cbfec7f4-45bff7000000269f-0a-6256d8325ca5
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id B8.71.09404.138D6526; Wed, 13
        Apr 2022 15:03:29 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220413140329eusmtip1114725856862033c244c0b85ee42ccd6~leanm4wni0922209222eusmtip12;
        Wed, 13 Apr 2022 14:03:29 +0000 (GMT)
Message-ID: <710c48c9-406d-e4c5-a394-10501b951316@samsung.com>
Date:   Wed, 13 Apr 2022 16:03:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH v8 03/23] mm: Check against orig_pte for finish_fault()
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Alistair Popple <apopple@nvidia.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20220405014836.14077-1-peterx@redhat.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFKsWRmVeSWpSXmKPExsWy7djPc7pGN8KSDDafULJYsH4pu8Wc9WvY
        LHbdCLHYd+U3q8XX9b+YLZ5+6mOxmD39BZPFmokLmS0u75rDZnFvzX9Wi4/7gy0Ofl3MaLFl
        /zd2i1mHpS1+/5jD5sDvsXPWXXaPBZtKPTav0PLY9GkSu8eJGb9ZPB4c2szi0dv8js3j49Nb
        LB7v911l85jd95TJ4/MmuQDuKC6blNSczLLUIn27BK6M2c87mQtaAiv+TDzA2MB4ybmLkYND
        QsBE4sBZuy5GLg4hgRWMEptObWaCcL4wSpyafZYNwvnMKPF19gT2LkZOsI61198zgthCAssZ
        Jd6droIo+sgo8ex9HytIglfATuLm4VtgRSwCqhKLO3uh4oISJ2c+YQGxRQWSJFZvX80GYgsL
        eEu82DqdGcRmFhCXuPVkPhPIeSICIRI3GgNA5jMLPGWWeNvWDTaHTcBQouttFxtIDaeAucSO
        mREQrfISzVtnM4PUSwgc5pSYtWAiM8TRLhIHv02GekBY4tXxLVC2jMTpyT0skKDIl/g7wxgi
        XCFx7fUaqFZriTvnfoGtYhbQlFi/Sx8i7Chx9f1fNohOPokbbwUhLuCTmLQN5BGQMK9ER5sQ
        RLWaxKzj6+B2HrxwiXkCo9IspCCZheT1WUh+mYWwdwEjyypG8dTS4tz01GKjvNRyveLE3OLS
        vHS95PzcTYzA5Hf63/EvOxiXv/qod4iRiYPxEKMEB7OSCG+/emiSEG9KYmVValF+fFFpTmrx
        IUZpDhYlcd7kzA2JQgLpiSWp2ampBalFMFkmDk6pBqYdhnMXCe9M2PSG8b9ntIUs/6yOpszG
        Lr3U/lc9XOqbQllmz+5leyPi+G/eg5M7LAyvTj3guj16q0O8icMqpvQuyYS4RZNvlfolfrs+
        p/kuu0Pd70BXKTkRn9h21tgmpafna469rJyclbnFwLH3gL9J4vu1uvu+Nbz50zvFsjuk/Xan
        g/HL/WVBN0VK8n7V3CxPttD7VSqdsO13/t6fPM/vl7wtD7XO3VoWP19zL+f69prt2b4RJ9by
        zK687TIjcuGG8wxK/VlRKR+4Tm4Mm7JD8Ob+m92LFy46cmhWZt+PqzFHfHzWSm23mLXiU6Wa
        kZTMjvZDqvLc6lP786Un7Fm/babqJtVVdXeKXrLN51ViKc5INNRiLipOBAAiYb5w7QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPIsWRmVeSWpSXmKPExsVy+t/xu7qGN8KSDHqemFssWL+U3WLO+jVs
        FrtuhFjsu/Kb1eLr+l/MFk8/9bFYzJ7+gslizcSFzBaXd81hs7i35j+rxcf9wRYHvy5mtNiy
        /xu7xazD0ha/f8xhc+D32DnrLrvHgk2lHptXaHls+jSJ3ePEjN8sHg8ObWbx6G1+x+bx8ekt
        Fo/3+66yeczue8rk8XmTXAB3lJ5NUX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamS
        vp1NSmpOZllqkb5dgl7G7OedzAUtgRV/Jh5gbGC85NzFyMkhIWAisfb6e8YuRi4OIYGljBKr
        ps9ggUjISJyc1sAKYQtL/LnWxQZiCwm8Z5Q4uk8QxOYVsJO4efgWI4jNIqAqsbizlxUiLihx
        cuYTsDmiAkkSl7rawWqEBbwlXmydzgxiMwuIS9x6Mp8JxBYRCJFo3/SLGeQIZoHXzBKffjQD
        NXAALUuWmP/cCaSGTcBQoustyA0cHJwC5hI7ZkZAjDGT6NraxQhhy0s0b53NPIFRaBaSK2Yh
        2TYLScssJC0LGFlWMYqklhbnpucWG+kVJ+YWl+al6yXn525iBMb8tmM/t+xgXPnqo94hRiYO
        xkOMEhzMSiK8/eqhSUK8KYmVValF+fFFpTmpxYcYTYFBMZFZSjQ5H5h08kriDc0MTA1NzCwN
        TC3NjJXEeT0LOhKFBNITS1KzU1MLUotg+pg4OKUamHYLbi25MGXOtXe2lRqG8lfjphxVvzhz
        0f/TPDeaXvTnF/29lp56tvNb3K5537K7UvT55N7LM02XeChzpzLh6J+2xOufyxROCT18vTh5
        5TSZIAdP28PeLsvvTvXrv7qnIX+zj9eSDUvyNgr1xOkHi9trPnh/+sNc4dJ/qtwz9svv/fxS
        y6Rl/eeIlk+1phMaEnszVTT/bDvz4HGN2tvkmg/MnWVFE9Svle7QMeuzPro7//Zfa8fpfz/F
        Wq8+uf1YquJSHd+u/qLe5+mOS38cKzqbJG5reHKVXtIlvU2RNxstvsw9q2hx6XlGsLnc3+vz
        Fvw4f1vk8CFt79sBz6bdN59T7Lpx3d4Kthu7Z8s3i2grsRRnJBpqMRcVJwIAwvWxF4IDAAA=
X-CMS-MailID: 20220413140330eucas1p167da41e079712b829ef8237dc27b049c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220413140330eucas1p167da41e079712b829ef8237dc27b049c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220413140330eucas1p167da41e079712b829ef8237dc27b049c
References: <20220405014646.13522-1-peterx@redhat.com>
        <20220405014836.14077-1-peterx@redhat.com>
        <CGME20220413140330eucas1p167da41e079712b829ef8237dc27b049c@eucas1p1.samsung.com>
X-Spam-Status: No, score=-8.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 05.04.2022 03:48, Peter Xu wrote:
> We used to check against none pte in finish_fault(), with the assumption
> that the orig_pte is always none pte.
>
> This change prepares us to be able to call do_fault() on !none ptes.  For
> example, we should allow that to happen for pte marker so that we can restore
> information out of the pte markers.
>
> Let's change the "pte_none" check into detecting changes since we fetched
> orig_pte.  One trivial thing to take care of here is, when pmd==NULL for
> the pgtable we may not initialize orig_pte at all in handle_pte_fault().
>
> By default orig_pte will be all zeros however the problem is not all
> architectures are using all-zeros for a none pte.  pte_clear() will be the
> right thing to use here so that we'll always have a valid orig_pte value
> for the whole handle_pte_fault() call.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

This patch landed in today's linux next-202204213 as commit fa6009949163 
("mm: check against orig_pte for finish_fault()"). Unfortunately it 
causes serious system instability on some ARM 32bit machines. I've 
observed it on all tested boards (various Samsung Exynos based, 
Raspberry Pi 3b and 4b, even QEMU's virt 32bit machine) when kernel was 
compiled from multi_v7_defconfig.

Here is a crash log from QEMU's ARM 32bit virt machine:

8<--- cut here ---
Unable to handle kernel paging request at virtual address e093263c
[e093263c] *pgd=42083811, *pte=00000000, *ppte=00000000
Internal error: Oops: 807 [#1] SMP ARM
Modules linked in:
CPU: 1 PID: 37 Comm: kworker/u4:0 Not tainted 
5.18.0-rc2-00176-gfa6009949163 #11684
Hardware name: Generic DT based system
PC is at cpu_ca15_set_pte_ext+0x4c/0x58
LR is at handle_mm_fault+0x46c/0xbb0
pc : [<c031bdec>]    lr : [<c0478144>]    psr: 40000013
sp : e0931df8  ip : e0931e54  fp : c26a8000
r10: 00000081  r9 : c2230880  r8 : 00000000
r7 : 00000081  r6 : beffffed  r5 : c267f000  r4 : c2230880
r3 : 00000000  r2 : 00000000  r1 : 00000040  r0 : e0931e3c
Flags: nZcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 10c5387d  Table: 4020406a  DAC: 00000051
Register r0 information: 2-page vmalloc region starting at 0xe0930000 
allocated at kernel_clone+0x8c/0x3a8
Register r1 information: non-paged memory
Register r2 information: NULL pointer
Register r3 information: NULL pointer
Register r4 information: slab task_struct start c2230880 pointer offset 0
Register r5 information: slab vm_area_struct start c267f000 pointer offset 0
Register r6 information: non-paged memory
Register r7 information: non-paged memory
Register r8 information: NULL pointer
Register r9 information: slab task_struct start c2230880 pointer offset 0
Register r10 information: non-paged memory
Register r11 information: slab mm_struct start c26a8000 pointer offset 0 
size 168
Register r12 information: 2-page vmalloc region starting at 0xe0930000 
allocated at kernel_clone+0x8c/0x3a8
Process kworker/u4:0 (pid: 37, stack limit = 0x(ptrval))
Stack: (0xe0931df8 to 0xe0932000)
...
---[ end trace 0000000000000000 ]---
CAN device driver interface
bgmac_bcma: Broadcom 47xx GBit MAC driver loaded
e1000e: Intel(R) PRO/1000 Network Driver
e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
igb: Intel(R) Gigabit Ethernet Network Driver
igb: Copyright (c) 2007-2014 Intel Corporation.
pegasus: Pegasus/Pegasus II USB Ethernet driver
usbcore: registered new interface driver pegasus
usbcore: registered new interface driver asix
usbcore: registered new interface driver ax88179_178a
usbcore: registered new interface driver cdc_ether
usbcore: registered new interface driver smsc75xx
usbcore: registered new interface driver smsc95xx
usbcore: registered new interface driver net1080
usbcore: registered new interface driver cdc_subset
usbcore: registered new interface driver zaurus
usbcore: registered new interface driver cdc_ncm
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci-pci: EHCI PCI platform driver
ehci-platform: EHCI generic platform driver
ehci-omap: OMAP-EHCI Host Controller driver
ehci-orion: EHCI orion driver
SPEAr-ehci: EHCI SPEAr driver
ehci-st: EHCI STMicroelectronics driver
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
ohci-pci: OHCI PCI platform driver
ohci-platform: OHCI generic platform driver
SPEAr-ohci: OHCI SPEAr driver
ohci-st: OHCI STMicroelectronics driver
usbcore: registered new interface driver usb-storage
rtc-pl031 9010000.pl031: registered as rtc0
rtc-pl031 9010000.pl031: setting system clock to 2022-04-13T13:49:19 UTC 
(1649857759)
i2c_dev: i2c /dev entries driver
sdhci: Secure Digital Host Controller Interface driver
sdhci: Copyright(c) Pierre Ossman
Synopsys Designware Multimedia Card Interface Driver
sdhci-pltfm: SDHCI platform and OF driver helper
ledtrig-cpu: registered to indicate activity on CPUs
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
NET: Registered PF_INET6 protocol family
Segment Routing with IPv6
In-situ OAM (IOAM) with IPv6
sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
NET: Registered PF_PACKET protocol family
can: controller area network core
NET: Registered PF_CAN protocol family
can: raw protocol
can: broadcast manager protocol
can: netlink gateway - max_hops=1
Key type dns_resolver registered
ThumbEE CPU extension supported.
Registering SWP/SWPB emulation handler
Loading compiled-in X.509 certificates
input: gpio-keys as /devices/platform/gpio-keys/input/input0
uart-pl011 9000000.pl011: no DMA platform data
EXT4-fs (vda): mounted filesystem with ordered data mode. Quota mode: 
disabled.
VFS: Mounted root (ext4 filesystem) readonly on device 254:0.
devtmpfs: mounted
Freeing unused kernel image (initmem) memory: 2048K
Run /sbin/init as init process
   with arguments:
     /sbin/init
   with environment:
     HOME=/
     TERM=linux
8<--- cut here ---
Unable to handle kernel paging request at virtual address e082662c
[e082662c] *pgd=42083811, *pte=00000000, *ppte=00000000
Internal error: Oops: 807 [#2] SMP ARM
Modules linked in:
CPU: 0 PID: 1 Comm: swapper/0 Tainted: G      D 
5.18.0-rc2-00176-gfa6009949163 #11684
Hardware name: Generic DT based system
PC is at cpu_ca15_set_pte_ext+0x4c/0x58
LR is at handle_mm_fault+0x46c/0xbb0
pc : [<c031bdec>]    lr : [<c0478144>]    psr: 40000013
sp : e0825de8  ip : e0825e44  fp : c213e000
r10: 00000081  r9 : c20e0000  r8 : 00000000
r7 : 00000081  r6 : befffff1  r5 : c2695000  r4 : c20e0000
r3 : 00000000  r2 : 00000000  r1 : 00000040  r0 : e0825e2c
Flags: nZcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 10c5387d  Table: 4020406a  DAC: 00000051
Register r0 information: 2-page vmalloc region starting at 0xe0824000 
allocated at kernel_clone+0x8c/0x3a8
Register r1 information: non-paged memory
Register r2 information: NULL pointer
Register r3 information: NULL pointer
Register r4 information: slab task_struct start c20e0000 pointer offset 0
Register r5 information: slab vm_area_struct start c2695000 pointer offset 0
Register r6 information: non-paged memory
Register r7 information: non-paged memory
Register r8 information: NULL pointer
Register r9 information: slab task_struct start c20e0000 pointer offset 0
Register r10 information: non-paged memory
Register r11 information: slab mm_struct start c213e000 pointer offset 0 
size 168
Register r12 information: 2-page vmalloc region starting at 0xe0824000 
allocated at kernel_clone+0x8c/0x3a8
Process swapper/0 (pid: 1, stack limit = 0x(ptrval))
Stack: (0xe0825de8 to 0xe0826000)
...
---[ end trace 0000000000000000 ]---
Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
CPU1: stopping
CPU: 1 PID: 0 Comm: swapper/1 Tainted: G      D 
5.18.0-rc2-00176-gfa6009949163 #11684
Hardware name: Generic DT based system
  unwind_backtrace from show_stack+0x10/0x14
  show_stack from dump_stack_lvl+0x40/0x4c
  dump_stack_lvl from do_handle_IPI+0x2c4/0x2fc
  do_handle_IPI from ipi_handler+0x18/0x20
  ipi_handler from handle_percpu_devid_irq+0x8c/0x1e0
  handle_percpu_devid_irq from generic_handle_domain_irq+0x40/0x84
  generic_handle_domain_irq from gic_handle_irq+0x88/0xa8
  gic_handle_irq from generic_handle_arch_irq+0x34/0x44
  generic_handle_arch_irq from call_with_stack+0x18/0x20
  call_with_stack from __irq_svc+0x98/0xb0
Exception stack(0xe0869f50 to 0xe0869f98)
9f40:                                     00009ddc 00000000 00000001 
c031be20
9f60: c20e5d80 c1b48f20 c1904d10 c1904d6c c183e9e8 c1b47971 00000000 
00000000
9f80: c1904e24 e0869fa0 c0307b74 c0307b78 60000113 ffffffff
  __irq_svc from arch_cpu_idle+0x38/0x3c
  arch_cpu_idle from default_idle_call+0x3c/0xb8
  default_idle_call from do_idle+0x1f8/0x298
  do_idle from cpu_startup_entry+0x18/0x1c
  cpu_startup_entry from 0x40301780
---[ end Kernel panic - not syncing: Attempted to kill init! 
exitcode=0x0000000b ]---


> ---
>   mm/memory.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 3f396241a7db..b1af996b09ca 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4241,7 +4241,7 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
>   				      vmf->address, &vmf->ptl);
>   	ret = 0;
>   	/* Re-check under ptl */
> -	if (likely(pte_none(*vmf->pte)))
> +	if (likely(pte_same(*vmf->pte, vmf->orig_pte)))
>   		do_set_pte(vmf, page, vmf->address);
>   	else
>   		ret = VM_FAULT_NOPAGE;
> @@ -4709,6 +4709,13 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
>   		 * concurrent faults and from rmap lookups.
>   		 */
>   		vmf->pte = NULL;
> +		/*
> +		 * Always initialize orig_pte.  This matches with below
> +		 * code to have orig_pte to be the none pte if pte==NULL.
> +		 * This makes the rest code to be always safe to reference
> +		 * it, e.g. in finish_fault() we'll detect pte changes.
> +		 */
> +		pte_clear(vmf->vma->vm_mm, vmf->address, &vmf->orig_pte);
>   	} else {
>   		/*
>   		 * If a huge pmd materialized under us just retry later.  Use

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

