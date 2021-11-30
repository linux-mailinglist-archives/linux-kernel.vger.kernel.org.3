Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EFF3462DDB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 08:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234901AbhK3Hwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 02:52:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31246 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234257AbhK3Hwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 02:52:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638258564;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5YVyVwYwLR8uNFWlNwzMy6drCWOuyxsj24/NtJLaJhE=;
        b=f1L00ivBXTVC293G777hLHaC2wXgQIGRnIiOW/2mZOtBJE/obtaissqlLcl5AqP63Epn3D
        QGtikjoTX6L2KKEF4XofrjnObsNIeO4g2PEV0gwQVlc7+OrlCqhRMNmRfzIy4S7Ku/fBwB
        6CXtOHnmXQlqluGfiOFBJ1Pkkk1gJio=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-66-dwubE5oRME2pErkF8p_TeQ-1; Tue, 30 Nov 2021 02:49:20 -0500
X-MC-Unique: dwubE5oRME2pErkF8p_TeQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8BB6D190A7A0;
        Tue, 30 Nov 2021 07:49:19 +0000 (UTC)
Received: from starship (unknown [10.40.192.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D3234694DA;
        Tue, 30 Nov 2021 07:49:17 +0000 (UTC)
Message-ID: <382e91d156c119d9843e682ac330df3b0bade978.camel@redhat.com>
Subject: Re: Commit 'hugetlbfs: extend the definition of hugepages parameter
 to support node allocation' breaks old numa less syntax of reserving
 hugepages on boot.
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Zhenguo Yao <yaozhenguo1@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 30 Nov 2021 09:49:16 +0200
In-Reply-To: <dfdc836d4c9eb6b571a32b19cae74c0a426c5a9b.camel@redhat.com>
References: <e52068a6e98031a386b5052a166a55c94fe940f6.camel@redhat.com>
         <ff89f867-0709-d8bb-b6f5-51b2be4cc2dd@oracle.com>
         <dfdc836d4c9eb6b571a32b19cae74c0a426c5a9b.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-11-29 at 12:39 +0200, Maxim Levitsky wrote:
> On Sun, 2021-11-28 at 20:31 -0800, Mike Kravetz wrote:
> > On 11/28/21 03:18, Maxim Levitsky wrote:
> > > dmesg prints this:
> > > 
> > > HugeTLB: allocating 64 of page size 1.00 GiB failed.  Only allocated 0 hugepages
> > > 
> > > Huge pages were allocated on kernel command line (1/2 of 128GB system):
> > > 
> > > 'default_hugepagesz=1G hugepagesz=1G hugepages=64'
> > > 
> > > This is 3970X and no real support/need for NUMA, thus only fake NUMA node 0 is present.
> > > 
> > > Reverting the commit helps.
> > > 
> > > New syntax also works ( hugepages=0:64 )
> > > 
> > > I can test any patches for this bug.
> > 
> > Argh!  I think preallocation of gigantic pages on all systems with only
> > a single node is broken.  The issue is at the beginning of
> > __alloc_bootmem_huge_page:
> > 
> > int __alloc_bootmem_huge_page(struct hstate *h, int nid)
> > {
> >         struct huge_bootmem_page *m = NULL; /* initialize for clang */
> >         int nr_nodes, node;
> > 
> >         if (nid >= nr_online_nodes)
> >                 return 0;
> > 
> > Without using the node specific syntax, nid == NUMA_NO_NODE == -1.  For the
> > comparison, nid will be converted to an unsigned into to match nr_online_nodes
> > so we will immediately return 0 instead of doing the allocations.
> > 
> > Zhenguo Yao,
> > Can you verify and perhaps put together a patch?does
> > 
> > > Also unrelated, is there any progress on allocating 1GB pages on demand so that I could
> > > allocate them only when I run a VM?
> > 
> > That should be possible.  Such support was added back in 2014 with commit
> > 944d9fec8d7a "hugetlb: add support for gigantic page allocation at runtime".
> > 
> > > i don't mind having these pages to be marked as to be used for userspace only,
> > > since as far as I remember its the kernel usage that makes some page unmoveable.
> > > 
> > 
> > Of course, finding 1GB of contiguous space for a gigantic page is often
> > difficult at runtime.  So, allocations are likely to fail the longer the
> > system is up and running and fragmentation increases.
> > 
> > > Last time (many years ago) I tried to create a zone with only userspace pages
> > > (I don't remember what options I used) but it didn't work.
> > 
> > Not too long ago, support was added to use CMA for gigantic page allocation.
> > See commit cf11e85fc08c "mm: hugetlb: optionally allocate gigantic hugepages
> > using cma".  This sounds like something you might want to try.
> 
> This is exactly what I had in mind and it seems to work very well.
> Thank you very much!

I jumped the gun with this. While a normal VM backed with huge pages works
with this, a VM which uses VFIO fails to start:

qemu-system-x86_64: -device vfio-pci,host=4d:00.0,multifunction=on,bus=rport.1,addr=00.0,x-no-geforce-quirks=on,id=auto_id28: VFIO_MAP_DMA failed: Cannot allocate memory
qemu-system-x86_64: -device vfio-pci,host=4d:00.0,multifunction=on,bus=rport.1,addr=00.0,x-no-geforce-quirks=on,id=auto_id28: VFIO_MAP_DMA failed: Cannot allocate memory
qemu-system-x86_64: -device vfio-pci,host=4d:00.0,multifunction=on,bus=rport.1,addr=00.0,x-no-geforce-quirks=on,id=auto_id28: vfio 0000:4d:00.0: failed to setup container for group 81: memory listener
initialization failed: Region mainmem: vfio_dma_map(0x55d21366be70, 0x0, 0x80000000, 0x7fae00000000) = -12 (Cannot allocate memory)

Qemu complains that in-kernel vfio driver can't allocate memory.
(I am a KVM/Qemu developer, but I didn't touch VFIO for long time.)

I use 'default_hugepagesz=1G hugepagesz=1G hugetlb_cma=68G',
just in case I though maybe CMA is also used for other purposes,
and somehow the 64 pages fully use it.

I also tried to run guest with less that 64GB of memory, like
say 16GB - same result.


I storongly suspect that the issue is that, well hugepages were allocated
from CMA are by definition moveable, thus attempt to lock them
which VFIO needs for IOMMU fails.

On top of that I see that warning in dmesg:


[   84.539444] ------------[ cut here ]------------
[   84.539828] WARNING: CPU: 26 PID: 6273 at mm/hugetlb.c:5568 follow_hugetlb_page+0x498/0x540
[   84.540417] Modules linked in: vhost_net vhost vhost_iotlb tap vfio_pci vfio_pci_core vfio_virqfd vfio_iommu_type1 vfio xt_state xt_conntrack ip6table_filter ip6_tables tun pmbus pmbus_core ee1004
jc42 wmi_bmof iwlmvm kvm_amd(O) snd_hda_codec_hdmi uvcvideo mac80211 snd_hda_intel videobuf2_vmalloc libarc4 videobuf2_memops snd_intel_dspcfg videobuf2_v4l2 btusb snd_usb_audio kvm(O) snd_hda_codec
btrtl videobuf2_common snd_usbmidi_lib iwlwifi btbcm snd_hwdep irqbypass snd_hda_core videodev btintel snd_rawmidi xpad pcspkr i2c_nvidia_gpu snd_pcm bluetooth input_leds joydev mc ff_memless cfg80211
i2c_piix4 zenpower bfq tpm_crb rtc_cmos tpm_tis wmi tpm_tis_core sch_fq_codel binfmt_misc fuse dm_crypt wacom hid_logitech_hidpp hid_logitech_dj ext4 mbcache jbd2 sd_mod uas usb_storage hid_generic
usbhid amdgpu drm_ttm_helper ttm gpu_sched drm_kms_helper cfbfillrect syscopyarea cfbimgblt sysfillrect sysimgblt fb_sys_fops cfbcopyarea cec rc_core ahci libahci drm drm_panel_orientation_quirks igb
libata
[   84.540523]  xhci_pci i2c_algo_bit ccp nvme xhci_hcd nvme_core t10_pi dm_mirror dm_region_hash dm_log thunderbolt vendor_reset(O) nbd usbmon it87 hwmon_vid i2c_dev i2c_core autofs4 [last unloaded:
nvidia]
[   84.547934] CPU: 26 PID: 6273 Comm: qemu-system-x86 Tainted: P           O      5.15.0.stable #3 9257385de85b802120b1c33b8c5e3ab4bd663f12
[   84.548790] Hardware name: Gigabyte Technology Co., Ltd. TRX40 DESIGNARE/TRX40 DESIGNARE, BIOS F4c 03/05/2020
[   84.549488] RIP: 0010:follow_hugetlb_page+0x498/0x540
[   84.549857] Code: ff 31 ff e9 b3 fd ff ff a8 01 75 7e a8 30 75 39 83 e0 42 48 c7 45 b8 00 00 00 00 83 f8 01 19 c0 f7 d0 83 e0 f2 e9 3c fe ff ff <0f> 0b 41 c6 00 00 b8 f4 ff ff ff 48 c7 45 b8 00 00
00 00 e9 24 fe
[   84.551237] RSP: 0018:ffffc900032a7a48 EFLAGS: 00010246
[   84.551640] RAX: 0000000000000000 RBX: ffff8881110d2ed8 RCX: 0000000000000000
[   84.552142] RDX: 0000000000000007 RSI: 0000000000000000 RDI: ffffea0044000000
[   84.552675] RBP: ffffc900032a7ab0 R08: ffff88811872bbf4 R09: 0000000000000000
[   84.553142] R10: 0000000000000200 R11: 00000000000001ff R12: 00007f7100000000
[   84.553679] R13: ffff88811872bb80 R14: ffffffff82caf7e0 R15: 0000000000000200
[   84.554202] FS:  00007f8124a69ec0(0000) GS:ffff88a01e680000(0000) knlGS:0000000000000000
[   84.554790] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   84.555215] CR2: 00007f813412b008 CR3: 0000001275be3000 CR4: 0000000000350ee0
[   84.555762] Call Trace:
[   84.555948]  __get_user_pages+0xeb/0x600
[   84.556224]  __gup_longterm_locked+0xbb/0x440
[   84.556548]  ? __alloc_pages+0xe8/0x240
[   84.556826]  __get_user_pages_remote+0x55/0x340
[   84.557165]  pin_user_pages_remote+0x1c/0x40
[   84.557492]  vaddr_get_pfns+0x7d/0x200 [vfio_iommu_type1 d85f323b75b05027fe68b516c580019f072ed73f]
[   84.558109]  vfio_pin_pages_remote+0x20e/0x400 [vfio_iommu_type1 d85f323b75b05027fe68b516c580019f072ed73f]
[   84.558797]  ? alloc_pages+0x90/0x180
[   84.559088]  vfio_iommu_type1_ioctl+0x4a7/0x16c0 [vfio_iommu_type1 d85f323b75b05027fe68b516c580019f072ed73f]
[   84.559799]  ? __symbol_put+0x62/0x80
[   84.560064]  ? kvm_vfio_update_coherency+0x86/0xc0 [kvm 7adebd08b2928f289aad8e70b7bcbd1dc3df366c]
[   84.560731]  vfio_fops_unl_ioctl+0x65/0x280 [vfio a2fa14242efe258accd03d2ce1d3c5a26dbd9553]
[   84.561284]  ? sched_clock+0x9/0x40
[   84.561573]  __x64_sys_ioctl+0x8e/0xc0
[   84.561842]  do_syscall_64+0x35/0x80
[   84.562102]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   84.562469] RIP: 0033:0x7f81314fd39b
[   84.562743] Code: ff ff ff 85 c0 79 9b 49 c7 c4 ff ff ff ff 5b 5d 4c 89 e0 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 5d 2a 0f 00 f7
d8 64 89 01 48
[   84.564062] RSP: 002b:00007ffdbe1fdb98 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[   84.564594] RAX: ffffffffffffffda RBX: 000056163ad97e70 RCX: 00007f81314fd39b
[   84.565107] RDX: 00007ffdbe1fdba0 RSI: 0000000000003b71 RDI: 0000000000000036
[   84.565626] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000020
[   84.566123] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000080000000
[   84.566610] R13: 000056163ad97e80 R14: 00007ffdbe1fdba0 R15: 0000000000000000
[   84.567122] ---[ end trace 0a1d4723e3c12a45 ]---
[   84.715094] vfio-pci 0000:4d:00.0: vgaarb: changed VGA decodes: olddecodes=io+mem,decodes=io+mem:owns=none


This warning also points at inablitly to pin a moveable page.

So close but no cigar.


Best regards,
	Maxim Levitsky


> 
> Best regards,
> 	Maxim Levitsky


