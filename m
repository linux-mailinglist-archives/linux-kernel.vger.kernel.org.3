Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C609753EE52
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 21:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbiFFTGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 15:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbiFFTGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 15:06:46 -0400
X-Greylist: delayed 589 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 06 Jun 2022 12:06:44 PDT
Received: from smtp123.ord1c.emailsrvr.com (smtp123.ord1c.emailsrvr.com [108.166.43.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1BF2DA0
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 12:06:44 -0700 (PDT)
X-Auth-ID: markh@compro.net
Received: by smtp8.relay.ord1c.emailsrvr.com (Authenticated sender: markh-AT-compro.net) with ESMTPSA id 43AAEA017A;
        Mon,  6 Jun 2022 14:56:54 -0400 (EDT)
Message-ID: <e797a3e8-cabd-8ea9-39da-fbb0a095f396@compro.net>
Date:   Mon, 6 Jun 2022 14:56:53 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
From:   Mark Hounschell <markh@compro.net>
Subject: Possible 5.17 to 5.18 regression
Reply-To: markh@compro.net
To:     Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Linux-kernel <linux-kernel@vger.kernel.org>
Content-Language: en-US
Organization: Compro Computer Svcs.
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Classification-ID: 97f3d9bc-25d0-447d-a8ce-1ee1c24c0893-1-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I subscribed only to send this email. I will unsubscribe asap. Please CC 
me for any responses.

The following commit causes the kernel oops shown below.

f5ff79fddf0efecca538046b5cc20fb3ded2ec4f is the first bad commit
commit f5ff79fddf0efecca538046b5cc20fb3ded2ec4f
Author: Christoph Hellwig <hch@lst.de>
Date:   Sat Feb 26 16:40:21 2022 +0100

     dma-mapping: remove CONFIG_DMA_REMAP

     CONFIG_DMA_REMAP is used to build a few helpers around the core
     vmalloc code, and to use them in case there is a highmem page in
     dma-direct, and to make dma coherent allocations be able to use
     non-contiguous pages allocations for DMA allocations in the dma-iommu
     layer.

     Right now it needs to be explicitly selected by architectures, and
     is only done so by architectures that require remapping to deal
     with devices that are not DMA coherent.  Make it unconditional for
     builds with CONFIG_MMU as it is very little extra code, but makes
     it much more likely that large DMA allocations succeed on x86.

     This fixes hot plugging a NVMe thunderbolt SSD for me, which tries
     to allocate a 1MB buffer that is otherwise hard to obtain due to
     memory fragmentation on a heavily used laptop.

     Signed-off-by: Christoph Hellwig <hch@lst.de>
     Reviewed-by: Robin Murphy <robin.murphy@arm.com>

  arch/arm/Kconfig          |  2 +-
  arch/xtensa/Kconfig       |  2 +-
  drivers/iommu/dma-iommu.c | 14 +++++---------
  kernel/dma/Kconfig        |  7 +------
  kernel/dma/Makefile       |  2 +-
  kernel/dma/direct.c       | 18 +++++++-----------
  6 files changed, 16 insertions(+), 29 deletions(-)

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f5ff79fddf0efecca538046b5cc20fb3ded2ec4f


The code causing this is just normal DMA stuff.

         eprm_memory_channel_buf_size = 0x100000;
         brd->mci_virt_addr =
                 dma_alloc_coherent(&brd->device->dev, 
eprm_memory_channel_buf_size,
                                    &brd->mci_pci_addr, GFP_KERNEL);

         if (brd->mci_virt_addr) {
                 unsigned long adr = (unsigned long)brd->mci_virt_addr;
                 int32_t size = eprm_memory_channel_buf_size;

                 while (size > 0) {
                         SetPageReserved(virt_to_page(adr));   // ERROR 
HERE!!!!
                         adr += PAGE_SIZE;
                         size -= PAGE_SIZE;
                 }
         }

The SetPageReserved function is what actually causes the Oops.

2022-06-06T14:02:23.323786-04:00 harley kernel: [   83.770518][ T4606] 
eprm: loading out-of-tree module taints kernel.
2022-06-06T14:02:23.324773-04:00 harley kernel: [   83.771319][ T4606] 
eprm: board 0 PCI RMS 436 Revision M
2022-06-06T14:02:23.324775-04:00 harley kernel: [   83.771357][ T4606] 
eprm: board 0 Memory SRAM 8 MB LOCK 8 MB MC 0x100000 B
2022-06-06T14:02:23.324776-04:00 harley kernel: [   83.771479][ T4606] 
eprm: board 0 Serial Link Node ID 74 bus 9 slot 9
2022-06-06T14:02:23.325799-04:00 harley kernel: [   83.771634][ T4606] 
BUG: unable to handle page fault for address: ffffcfcfbe194e41
2022-06-06T14:02:23.325804-04:00 harley kernel: [   83.771638][ T4606] 
#PF: supervisor write access in kernel mode
2022-06-06T14:02:23.325805-04:00 harley kernel: [   83.771641][ T4606] 
#PF: error_code(0x0002) - not-present page
2022-06-06T14:02:23.325805-04:00 harley kernel: [   83.771644][ T4606] 
PGD 44f378067 P4D 44f378067 PUD 0
2022-06-06T14:02:23.325805-04:00 harley kernel: [   83.771648][ T4606] 
Oops: 0002 [#1] PREEMPT SMP NOPTI
2022-06-06T14:02:23.325806-04:00 harley kernel: [   83.771651][ T4606] 
CPU: 3 PID: 4606 Comm: modprobe Tainted: G        WC O      5.18.1 #1
2022-06-06T14:02:23.325807-04:00 harley kernel: [   83.771655][ T4606] 
Hardware name: BIOSTAR Group B550GTA/B550GTA, BIOS 5.17 12/03/2021
2022-06-06T14:02:23.325808-04:00 harley kernel: [   83.771658][ T4606] 
RIP: 0010:eprm_probe+0x367/0xb20 [eprm]
2022-06-06T14:02:23.325809-04:00 harley kernel: [   83.771664][ T4606] 
Code: 00 00 48 89 c2 48 01 ca 0f 82 1c 06 00 00 4c 89 c6 48 2b 35 3b 7e 
4f d0 48 01 f2 48 c1 ea 0c 48 c1 e2 06 48 03 15 19 7e 4f d0 <f0> 80 4a 
01 10 48 05 00 10 00 00 48 39 f8 75 c8 48 69 c5 f8 05 00
2022-06-06T14:02:23.325810-04:00 harley kernel: [   83.771669][ T4606] 
RSP: 0018:ffffa2a086f9fb40 EFLAGS: 00010282
2022-06-06T14:02:23.325810-04:00 harley kernel: [   83.771672][ T4606] 
RAX: ffffa2a086539000 RBX: ffffffffc0f1e580 RCX: 0000000080000000
2022-06-06T14:02:23.325811-04:00 harley kernel: [   83.771674][ T4606] 
RDX: ffffcfcfbe194e40 RSI: 000068be80000000 RDI: ffffa2a086639000
2022-06-06T14:02:23.325811-04:00 harley kernel: [   83.771677][ T4606] 
RBP: 0000000000000000 R08: ffffffff80000000 R09: ffffa2a08663a000
2022-06-06T14:02:23.325812-04:00 harley kernel: [   83.771680][ T4606] 
R10: ffff9742cb0df080 R11: ffffa2a086539000 R12: ffffffffc0f1e580
2022-06-06T14:02:23.325812-04:00 harley kernel: [   83.771682][ T4606] 
R13: 0000000000000000 R14: 0000000000000000 R15: ffff974206e8fde0
2022-06-06T14:02:23.325813-04:00 harley kernel: [   83.771684][ T4606] 
FS:  00007f4deea41740(0000) GS:ffff97453eac0000(0000) knlGS:0000000000000000
2022-06-06T14:02:23.325813-04:00 harley kernel: [   83.771688][ T4606] 
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
2022-06-06T14:02:23.325813-04:00 harley kernel: [   83.771690][ T4606] 
CR2: ffffcfcfbe194e41 CR3: 000000011fd7c000 CR4: 0000000000350ee0
2022-06-06T14:02:23.325814-04:00 harley kernel: [   83.771693][ T4606] 
Call Trace:
2022-06-06T14:02:23.325814-04:00 harley kernel: [   83.771696][ T4606] 
<TASK>
2022-06-06T14:02:23.325815-04:00 harley kernel: [   83.771699][ T4606] 
pci_device_probe+0xb1/0x160
2022-06-06T14:02:23.325815-04:00 harley kernel: [   83.771705][ T4606] 
really_probe+0x10b/0x3c0
2022-06-06T14:02:23.325815-04:00 harley kernel: [   83.771710][ T4606] 
__driver_probe_device+0x100/0x170
2022-06-06T14:02:23.325816-04:00 harley kernel: [   83.771714][ T4606] 
driver_probe_device+0x1f/0xa0
2022-06-06T14:02:23.325816-04:00 harley kernel: [   83.771717][ T4606] 
__driver_attach+0xa7/0x150
2022-06-06T14:02:23.325817-04:00 harley kernel: [   83.771721][ T4606] ? 
__device_attach_driver+0xe0/0xe0
2022-06-06T14:02:23.325817-04:00 harley kernel: [   83.771724][ T4606] 
bus_for_each_dev+0x65/0x90
2022-06-06T14:02:23.325817-04:00 harley kernel: [   83.771728][ T4606] 
bus_add_driver+0x141/0x220
2022-06-06T14:02:23.325818-04:00 harley kernel: [   83.771731][ T4606] ? 
0xffffffffc0b36000
2022-06-06T14:02:23.325818-04:00 harley kernel: [   83.771734][ T4606] 
driver_register+0x5b/0xf0
2022-06-06T14:02:23.325819-04:00 harley kernel: [   83.771738][ T4606] ? 
0xffffffffc0b36000
2022-06-06T14:02:23.325819-04:00 harley kernel: [   83.771740][ T4606] 
do_one_initcall+0x41/0x200
2022-06-06T14:02:23.325820-04:00 harley kernel: [   83.771744][ T4606] ? 
kmem_cache_alloc_trace+0x3d/0x420
2022-06-06T14:02:23.325820-04:00 harley kernel: [   83.771749][ T4606] 
do_init_module+0x4b/0x1fb
2022-06-06T14:02:23.325820-04:00 harley kernel: [   83.771754][ T4606] 
load_module+0x1c00/0x2270
2022-06-06T14:02:23.325821-04:00 harley kernel: [   83.771760][ T4606] ? 
__do_sys_finit_module+0x96/0xf0
2022-06-06T14:02:23.325821-04:00 harley kernel: [   83.771763][ T4606] 
__do_sys_finit_module+0x96/0xf0
2022-06-06T14:02:23.325821-04:00 harley kernel: [   83.771766][ T4606] 
do_syscall_64+0x3a/0xb0
2022-06-06T14:02:23.325822-04:00 harley kernel: [   83.771771][ T4606] 
entry_SYSCALL_64_after_hwframe+0x44/0xae
2022-06-06T14:02:23.325822-04:00 harley kernel: [   83.771775][ T4606] 
RIP: 0033:0x7f4ded310ec9
2022-06-06T14:02:23.325822-04:00 harley kernel: [   83.771778][ T4606] 
Code: 2e 00 b8 ca 00 00 00 0f 05 eb a5 66 0f 1f 44 00 00 48 89 f8 48 89 
f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 
f0 ff ff 73 01 c3 48 8b 0d 97 7f 2d 00 f7 d8 64 89 01 48
2022-06-06T14:02:23.325823-04:00 harley kernel: [   83.771782][ T4606] 
RSP: 002b:00007ffdb23f9458 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
2022-06-06T14:02:23.325823-04:00 harley kernel: [   83.771786][ T4606] 
RAX: ffffffffffffffda RBX: 0000564c08fdf9b0 RCX: 00007f4ded310ec9
2022-06-06T14:02:23.325824-04:00 harley kernel: [   83.771788][ T4606] 
RDX: 0000000000000000 RSI: 0000564c08fdfcc0 RDI: 0000000000000003
2022-06-06T14:02:23.325824-04:00 harley kernel: [   83.771791][ T4606] 
RBP: 0000564c08fdfcc0 R08: 0000000000000000 R09: 0000000000000001
2022-06-06T14:02:23.325825-04:00 harley kernel: [   83.771793][ T4606] 
R10: 0000000000000003 R11: 0000000000000246 R12: 0000000000040000
2022-06-06T14:02:23.325825-04:00 harley kernel: [   83.771795][ T4606] 
R13: 0000564c08fdfa90 R14: 0000000000000000 R15: 0000000000000000
2022-06-06T14:02:23.325826-04:00 harley kernel: [   83.771799][ T4606] 
</TASK>
2022-06-06T14:02:23.325826-04:00 harley kernel: [   83.771800][ T4606] 
Modules linked in: eprm(O+) af_packet iscsi_ibft iscsi_boot_sysfs rfkill 
dmi_sysfs ppdev intel_rapl_msr intel_rapl_common kvm irqbypass 
crct10dif_pclmul crc32_pclmul ghash_clmulni_intel joydev aesni_intel 
crypto_simd cryptd wmi_bmof pcspkr synclink_gt parport_pc r8169 dgap(C) 
ccp hdlc parport sp5100_tco realtek mdio_devres 3c59x k10temp i2c_piix4 
libphy mii thermal gpio_amdpt gpio_generic tiny_power_button fuse 
configfs snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio 
hid_generic usbhid nouveau video drm_ttm_helper ttm i2c_algo_bit mxm_wmi 
drm_dp_helper drm_kms_helper syscopyarea sysfillrect crc32c_intel 
sysimgblt fb_sys_fops serio_raw xhci_pci drm aic7xxx xhci_pci_renesas 
sr_mod scsi_transport_spi xhci_hcd cdrom usbcore usb_common wmi 
pinctrl_amd button snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi 
snd_hda_codec snd_hwdep snd_hda_core snd_pcm snd_timer snd soundcore sg 
dm_multipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua msr
2022-06-06T14:02:23.325827-04:00 harley kernel: [   83.771845][ T4606] 
CR2: ffffcfcfbe194e41
2022-06-06T14:02:23.325828-04:00 harley kernel: [   83.771847][ T4606] 
---[ end trace 0000000000000000 ]---
2022-06-06T14:02:23.325828-04:00 harley kernel: [   83.771850][ T4606] 
RIP: 0010:eprm_probe+0x367/0xb20 [eprm]
2022-06-06T14:02:23.325828-04:00 harley kernel: [   83.771854][ T4606] 
Code: 00 00 48 89 c2 48 01 ca 0f 82 1c 06 00 00 4c 89 c6 48 2b 35 3b 7e 
4f d0 48 01 f2 48 c1 ea 0c 48 c1 e2 06 48 03 15 19 7e 4f d0 <f0> 80 4a 
01 10 48 05 00 10 00 00 48 39 f8 75 c8 48 69 c5 f8 05 00
2022-06-06T14:02:23.325829-04:00 harley kernel: [   83.771858][ T4606] 
RSP: 0018:ffffa2a086f9fb40 EFLAGS: 00010282
2022-06-06T14:02:23.325829-04:00 harley kernel: [   83.771861][ T4606] 
RAX: ffffa2a086539000 RBX: ffffffffc0f1e580 RCX: 0000000080000000
2022-06-06T14:02:23.325830-04:00 harley kernel: [   83.771863][ T4606] 
RDX: ffffcfcfbe194e40 RSI: 000068be80000000 RDI: ffffa2a086639000
2022-06-06T14:02:23.325830-04:00 harley kernel: [   83.771865][ T4606] 
RBP: 0000000000000000 R08: ffffffff80000000 R09: ffffa2a08663a000
2022-06-06T14:02:23.325831-04:00 harley kernel: [   83.771868][ T4606] 
R10: ffff9742cb0df080 R11: ffffa2a086539000 R12: ffffffffc0f1e580
2022-06-06T14:02:23.325831-04:00 harley kernel: [   83.771870][ T4606] 
R13: 0000000000000000 R14: 0000000000000000 R15: ffff974206e8fde0
2022-06-06T14:02:23.325832-04:00 harley kernel: [   83.771873][ T4606] 
FS:  00007f4deea41740(0000) GS:ffff97453eac0000(0000) knlGS:0000000000000000
2022-06-06T14:02:23.325832-04:00 harley kernel: [   83.771875][ T4606] 
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
2022-06-06T14:02:23.325832-04:00 harley kernel: [   83.771878][ T4606] 
CR2: ffffcfcfbe194e41 CR3: 000000011fd7c000 CR4: 0000000000350ee0
