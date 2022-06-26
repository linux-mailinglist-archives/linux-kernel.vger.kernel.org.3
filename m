Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 740A955B436
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 23:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbiFZVu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 17:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiFZVuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 17:50:25 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56400DDD
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 14:50:23 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id c65so10549527edf.4
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 14:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=oj7mFyqSz8LJyilRwFazULzIy8VzcTN6rASJ/2GcRCc=;
        b=Kt1ysLC6oYrs7c0+2HEglvijBddOBI8j9rtF+vyeDGfJiE0iek0Hj7DaOEZXO/CJ7I
         ZHQ0HBfIpFkOzigWyVZFkxdunetZm+g6OlZ0L//Gz7k7OuEcFtJ+8haehU8u1w0n4bbo
         C3mZitn+SF5TsCzpok+Lcm1q3PO8FleONwZcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=oj7mFyqSz8LJyilRwFazULzIy8VzcTN6rASJ/2GcRCc=;
        b=D4b6E/1y+lBoBOV6y4WelktmPdGWj6B3rd3IjucjAbtwlwhBG1u2aw2PhCtFDuA1BR
         O41Kq6x1W7+jXwr277+0PCz0gkFOHm442S7YI2MnOu18g88kB0t34POSMBJIw54zRnJD
         6eknR+1cTi42/QiX+xGZa8XoF1I2ofUYCC2sQubNviPGSH2u8pE4FNb8CZpSjmXDfp30
         sb/aDOXm0A5tZDJpssac+KKonWDXPmbJO8V8nQLwVjOnLkgwIyQRghVMoCACp5LYskMv
         BpFDvHj8+KQKqWIuN4Ok/Kzw9IRC4BnESioWY+h+NpGX5K4f9bQRtLEzN49TDt/DJmMr
         fFkw==
X-Gm-Message-State: AJIora/sJnunDJ1B5pXbhlipomJ8MjdLBF5VmBL2alp/EJUgiKK5nj2V
        kPZq4fNgWejWZ9YrSdPXBDBKMbPYLUvbaxRe
X-Google-Smtp-Source: AGRyM1sPwGTZ7enV38gp9jKy3J5A0dDj0+hquagnosArTz4cE/X5PhJF0OJKUWOjg0nEWnRpzJZ8vA==
X-Received: by 2002:a05:6402:35cf:b0:435:bd7f:932c with SMTP id z15-20020a05640235cf00b00435bd7f932cmr12999832edc.415.1656280221214;
        Sun, 26 Jun 2022 14:50:21 -0700 (PDT)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id i5-20020a1709061e4500b006feb6dee4absm4199648ejj.137.2022.06.26.14.50.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jun 2022 14:50:20 -0700 (PDT)
Received: by mail-wm1-f53.google.com with SMTP id z9so4285458wmf.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 14:50:20 -0700 (PDT)
X-Received: by 2002:a05:600c:354c:b0:39c:7e86:6ff5 with SMTP id
 i12-20020a05600c354c00b0039c7e866ff5mr15758046wmq.145.1656280219747; Sun, 26
 Jun 2022 14:50:19 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 26 Jun 2022 14:50:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjRt2bxDDT9-Uq337dAg6jipZfetgSsHejggU=JHmyK6A@mail.gmail.com>
Message-ID: <CAHk-=wjRt2bxDDT9-Uq337dAg6jipZfetgSsHejggU=JHmyK6A@mail.gmail.com>
Subject: Linux 5.19-rc4
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So we've had a couple of fairly small rc releases, and here we finally
start to see an uptick in commits in rc4. Not what I really want to
see in the middle of the release cycle, but not entirely surprising
considering how quiet it's been so far.

And while 5.19-rc4 is a bit larger than previous rc's, and is a bit
larger than we usually see at this point, it's by no means anywhere
near record size. So more of a "a bit bigger than usual" than a "Oh my
God, this thing is huge".

The changes are also spread out fairly widely, and nothing really
stands out. I think the individually biggest patches are the reverts
to the printk threading changes that people wanted to really think
about some more, since the changes had caused some issues. The rest of
the diffstat is _fairly_ flat, with perhaps the vc4 drm patches
standing out a bit.

So at least right now this all feels like "making up for a small rc3"
rather than anything really worrisome, and probably just a result of
timing some of the patches shifted into rc4. But let's see how this
develops over the next couple of weeks.

The full shortlog with all the details is below, and I don't think
there's any larger pattern here. We've got all the usual architecture
fixes, driver fixes all over the place, and filesystems, core
networking, and tooling (perf and selftests). A lot of the changes
here are one- and few-liners.

Please do go test. Thanks,
                  Linus

---

Aashish Sharma (1):
      iio:proximity:sx9324: Check ret value of device_property_read_u32_arr=
ay()

Abel Vesa (1):
      MAINTAINERS: update Abel Vesa's email

Abhinav Kumar (1):
      drm/msm/dpu: limit wb modes based on max_mixer_width

Adrian Hunter (2):
      perf inject: Fix missing free in copy_kcore_dir()
      perf build-id: Fix caching files with a wrong build ID

Aidan MacDonald (3):
      mips: dts: ingenic: Add TCU clock to x1000/x1830 tcu device node
      regmap-irq: Fix a bug in regmap_irq_enable() for type_in_mask chips
      regmap-irq: Fix offset/index mismatch in read_sub_irq_data()

Akira Yokosawa (1):
      gpio: Fix kernel-doc comments to nested union

Alan Stern (2):
      usb: gadget: Fix non-unique driver names in raw-gadget driver
      USB: gadget: Fix double-free bug in raw_gadget driver

Alex Deucher (1):
      drm/amdgpu: Adjust logic around GTT size (v3)

Alex Williamson (1):
      mm: re-allow pinning of zero pfns

Alexander Gordeev (2):
      s390/crash: add missing iterator advance in copy_oldmem_page()
      s390/crash: make copy_oldmem_page() return number of bytes copied

Alexander Stein (2):
      ARM: dts: imx7: Move hsic_phy power domain to HSIC PHY node
      soc: imx: imx8m-blk-ctrl: fix display clock for LCDIF2 power domain

Alexandre Torgue (1):
      ARM: dts: stm32: move SCMI related nodes in a dedicated file for stm3=
2mp15

Alistair Popple (1):
      filemap: Fix serialization adding transparent huge pages to page cach=
e

Anatolii Gerasymenko (2):
      ice: ethtool: advertise 1000M speeds properly
      ice: ethtool: Prohibit improper channel config for DCB

Andrew Donnellan (1):
      powerpc/rtas: Allow ibm,platform-dump RTAS call with null buffer addr=
ess

Andrew Morton (1):
      MAINTAINERS: update MM tree references

Andy Shevchenko (1):
      usb: typec: wcove: Drop wrong dependency to INTEL_SOC_PMIC

Antoniu Miclaus (1):
      iio: freq: admv1014: Fix warning about dubious x & !y and
improve readability

Arnaldo Carvalho de Melo (9):
      perf beauty: Update copy of linux/socket.h with the kernel sources
      tools headers UAPI: Sync x86's asm/kvm.h with the kernel sources
      tools headers arm64: Sync arm64's cputype.h with the kernel sources
      tools headers UAPI: Sync linux/prctl.h with the kernel sources
      tools headers UAPI: Sync drm/i915_drm.h with the kernel sources
      tools headers cpufeatures: Sync with the kernel sources
      perf trace beauty: Fix generation of errno id->str table on ALT Linux
      tools include UAPI: Sync linux/vhost.h with the kernel sources
      tools headers UAPI: Synch KVM's svm.h header with the kernel

Aswath Govindraju (1):
      arm64: dts: ti: k3-am64-main: Remove support for HS400 speed mode

Athira Rajeev (1):
      perf test topology: Use !strncmp(right platform) to fix guest
PPC comparision check

Bart Van Assche (3):
      scsi: ufs: Simplify ufshcd_clear_cmd()
      scsi: ufs: Support clearing multiple commands at once
      scsi: ufs: Fix a race between the interrupt handler and the reset han=
dler

Baruch Siach (1):
      iio: adc: vf610: fix conversion mode sysfs node name

Bjorn Helgaas (2):
      video: fbdev: cirrusfb: Remove useless reference to PCI power managem=
ent
      video: fbdev: skeletonfb: Convert to generic power management

Carlo Lobrano (1):
      USB: serial: option: add Telit LE910Cx 0x1250 composition

Chester Lin (1):
      MAINTAINERS: add a new reviewer for S32G

Chevron Li (1):
      mmc: sdhci-pci-o2micro: Fix card detect by dealing with debouncing

Christian Lamparter (1):
      Revert "mtd: rawnand: add support for Toshiba TC58NVG0S3HTA00 NAND fl=
ash"

Christian Marangi (3):
      mailmap: add entry for Christian Marangi
      net: dsa: qca8k: reset cpu port on MTU change
      net: dsa: qca8k: reduce mgmt ethernet timeout

Christoph Hellwig (5):
      block: disable the elevator int del_gendisk
      block: serialize all debugfs operations using q->debugfs_mutex
      block: remove per-disk debugfs files in blk_unregister_queue
      block: freeze the queue earlier in del_gendisk
      nvme: move the Samsung X5 quirk entry to the core quirks

Christophe Leroy (1):
      powerpc/prom_init: Fix build failure with
GCC_PLUGIN_STRUCTLEAK_BYREF_ALL and KASAN

Ciara Loftus (1):
      xsk: Fix generic transmit when completion queue reservation fails

Claudiu Manoil (1):
      phy: aquantia: Fix AN when higher speeds than 1G are not advertised

Cristian Marussi (4):
      firmware: arm_scmi: Relax base protocol sanity checks on the protocol=
 list
      firmware: arm_scmi: Remove all the unused local variables
      firmware: arm_scmi: Fix SENSOR_AXIS_NAME_GET behaviour when unsupport=
ed
      firmware: arm_scmi: Avoid using extended string-buffers sizes if
not necessary

Daeho Jeong (1):
      f2fs: fix iostat related lock protection

Damien Le Moal (2):
      scsi: scsi_debug: Fix zone transition to full condition
      block: remove queue from struct blk_independent_access_range

Dan Carpenter (2):
      drm/vc4: fix error code in vc4_check_tex_size()
      gpio: winbond: Fix error code in winbond_gpio_get()

Dan Vacura (1):
      usb: gadget: uvc: fix list double add in uvcg_video_pump

Daniel Borkmann (1):
      bpf, docs: Update some of the JIT/maintenance entries

Daniil Dementev (1):
      ALSA: usb-audio: US16x08: Move overflow check before array access

David Hildenbrand (1):
      MAINTAINERS: add MEMORY HOT(UN)PLUG section and add David as reviewer

David Howells (3):
      certs: Move load_certificate_list() to be with the asymmetric keys co=
de
      certs: Add FIPS selftests
      afs: Fix dynamic root getattr

David Sterba (2):
      btrfs: add error messages to all unrecognized mount options
      Documentation: update btrfs list of features and link to readthedocs.=
io

David Virag (1):
      arm64: dts: exynos: Correct UART clocks on Exynos7885

Demi Marie Obenour (1):
      xen/gntdev: Avoid blocking in unmap_grant_pages()

Dexuan Cui (1):
      dma-direct: use the correct size for dma_set_encrypted()

Ding Xiang (1):
      selftests: vm: Fix resource leak when return error

Dmitry Klochkov (1):
      tools/kvm_stat: fix display of error when multiple processes are foun=
d

Dmitry Osipenko (1):
      PM: hibernate: Use kernel_can_power_off()

Dmitry Rokosov (5):
      iio:accel:bma180: rearrange iio trigger get and register
      iio:accel:kxcjk-1013: rearrange iio trigger get and register
      iio:accel:mxc4005: rearrange iio trigger get and register
      iio:chemical:ccs811: rearrange iio trigger get and register
      iio:humidity:hts221: rearrange iio trigger get and register

Dominique Martinet (3):
      9p: fix fid refcount leak in v9fs_vfs_atomic_open_dotl
      9p: fix fid refcount leak in v9fs_vfs_get_link
      9p: fix EBADF errors in cached mode

Dylan Yudaken (1):
      io_uring: move io_uring_get_opcode out of TP_printk

Edward Wu (1):
      ata: libata: add qc->flags in ata_qc_complete_template tracepoint

Eric Dumazet (2):
      net: fix data-race in dev_isalive()
      erspan: do not assume transport header is always set

Evgeniy Baskov (1):
      efi/x86: libstub: Fix typo in __efi64_argmap* name

Fabio Estevam (1):
      arm64: s32g2: Pass unit name to soc node

Filipe Manana (4):
      btrfs: fix hang during unmount when block group reclaim task is runni=
ng
      btrfs: fix race between reflinking and ordered extent completion
      btrfs: add missing inode updates on each iteration when replacing ext=
ents
      btrfs: do not BUG_ON() on failure to migrate space when replacing ext=
ents

Florian Westphal (4):
      netfilter: use get_random_u32 instead of prandom
      netfilter: cttimeout: fix slab-out-of-bounds read typo in
cttimeout_net_exit
      netfilter: nf_dup_netdev: do not push mac header a second time
      netfilter: nf_dup_netdev: add and use recursion counter

Gang Li (1):
      perf stat: Enable ignore_missing_thread

Gautam Menghani (1):
      tracing/uprobes: Remove unwanted initialization in __trace_uprobe_cre=
ate()

Geert Uytterhoeven (3):
      memory: omap-gpmc: OMAP_GPMC should depend on ARCH_OMAP2PLUS ||
ARCH_KEYSTONE || ARCH_K3
      dt-bindings: usb: ohci: Increase the number of PHYs
      dt-bindings: usb: ehci: Increase the number of PHYs

George Shen (1):
      drm/amd/display: Fix typo in override_lane_settings

Gerd Hoffmann (1):
      udmabuf: add back sanity check

Haibo Chen (2):
      iio: mma8452: fix probe fail when device tree compatible is used.
      iio: accel: mma8452: ignore the return value of reset operation

Hans de Goede (1):
      iio: adc: axp288: Override TS pin bias current for some models

Helge Deller (2):
      parisc/stifb: Fix fb_is_primary_device() only available with CONFIG_F=
B_STI
      parisc: Enable ARCH_HAS_STRICT_MODULE_RWX

Hoang Le (1):
      tipc: fix use-after-free Read in tipc_named_reinit

Hongyu Xie (1):
      xhci: Keep interrupt disabled in initialization until host is running=
.

Huacai Chen (5):
      MAINTAINERS: add maillist information for LoongArch
      LoongArch: Fix the !THP build
      LoongArch: Fix the _stext symbol address
      LoongArch: Fix sleeping in atomic context in setup_tlb_handler()
      LoongArch: Fix EENTRY/MERRENTRY setting in setup_tlb_handler()

Hyunwoo Kim (1):
      video: fbdev: pxa3xx-gcu: Fix integer overflow in pxa3xx_gcu_write

Ian Rogers (5):
      perf unwind: Fix uninitialized variable
      libperf evsel: Open shouldn't leak fd on failure
      perf test: Fix variable length array undefined behavior in bp_account
      perf expr: Allow exponents on floating point values
      perf metrics: Ensure at least 1 id per metric

Ivan Vecera (1):
      ethtool: Fix get module eeprom fallback

Jae Hyun Yoo (1):
      ARM: dts: aspeed: nuvia: rename vendor nuvia to qcom

Jaegeuk Kim (2):
      f2fs: attach inline_data after setting compression
      f2fs: do not count ENOENT for error case

Jakub Kicinski (3):
      Revert "drivers/net/ethernet/neterion/vxge: Fix a use-after-free
bug in vxge-main.c"
      Revert "net/tls: fix tls_sk_proto_close executed repeatedly"
      sock: redo the psock vs ULP protection check

Jakub Sitnicki (2):
      bpf, x86: Fix tail call count offset calculation on bpf2bpf call
      selftests/bpf: Test tail call counting with bpf2bpf and data on stack

Jann Horn (1):
      mm/slub: add missing TID updates on slab deactivation

Jarkko Sakkinen (1):
      mailmap: add alias for jarkko@profian.com

Jason A. Donenfeld (8):
      mm/kfence: select random number before taking raw lock
      powerpc/microwatt: wire up rng during setup_arch()
      powerpc/pseries: wire up rng during setup_arch()
      random: schedule mix_interrupt_randomness() less often
      random: quiet urandom warning ratelimit suppression message
      random: update comment from copy_to_user() -> copy_to_iter()
      drm/i915/display: Re-add check for low voltage sku for max dp source =
rate
      powerpc/powernv: wire up rng during setup_arch

Jason Andryuk (1):
      xen-blkfront: Handle NULL gendisk

Javier Martinez Canillas (4):
      regmap: Re-introduce bulk read support check in regmap_bulk_read()
      regmap: Make regmap_noinc_read() return -ENOTSUPP if map->read isn't =
set
      regmap: Wire up regmap_config provided bulk write in missed functions
      efi: sysfb_efi: remove unnecessary <asm/efi.h> include

Jay Vosburgh (2):
      veth: Add updating of trans_start
      bonding: ARP monitor spams NETDEV_NOTIFY_PEERS notifiers

Jean-Baptiste Maneyrol (1):
      iio: imu: inv_icm42600: Fix broken icm42600 (chip id 0 value)

Jens Axboe (4):
      io_uring: mark reissue requests with REQ_F_PARTIAL_IO
      io_uring: fix merge error in checking send/recv addr2 flags
      block: pop cached rq before potentially blocking rq_qos_throttle()
      io_uring: use original request task for inflight tracking

Jernej Skrabec (1):
      drm/sun4i: Add DMA mask and segment size

Jialin Zhang (2):
      iio: adc: rzg2l_adc: add missing fwnode_handle_put() in
rzg2l_adc_parse_properties()
      iio: adc: ti-ads131e08: add missing fwnode_handle_put() in
ads131e08_alloc_channels()

Jiang Jian (3):
      video: fbdev: omapfb: Align '*' in comment
      video: fbdev: omap: Remove duplicate 'the' in comment
      parisc: align '*' in comment in math-emu code

Jiapeng Chong (1):
      firewire: convert sysfs sprintf/snprintf family to sysfs_emit

Jie2x Zhou (1):
      selftests: netfilter: correct PKTGEN_SCRIPT_PATHS in nft_concat_range=
.sh

Jiri Olsa (4):
      selftests/bpf: Shuffle cookies symbols in kprobe multi test
      ftrace: Keep address offset in ftrace_lookup_symbols
      bpf: Force cookies array to follow symbols sorting
      selftest/bpf: Fix kprobe_multi bench test

Joel Granados (1):
      nvme: fix the CRIMS and CRWMS definitions to match the spec

Joel Savitz (1):
      selftests: make use of GUP_TEST_FILE macro

Joerg Roedel (1):
      MAINTAINERS: Add new IOMMU development mailing list

Johan Hovold (1):
      USB: serial: pl2303: add support for more HXN (G) types

John David Anglin (1):
      parisc: Fix flush_anon_page on PA8800/PA8900

Jon Lin (1):
      spi: rockchip: Unmask IRQ at the final to avoid preemption

Jon Maxwell (1):
      bpf: Fix request_sock leak in sk lookup helpers

Jonathan Marek (1):
      drm/msm: use for_each_sgtable_sg to iterate over scatterlist

Josef Bacik (1):
      btrfs: fix deadlock with fsync+fiemap+transaction commit

Joshua Ashton (1):
      amd/display/dc: Fix COLOR_ENCODING and COLOR_RANGE doing nothing
for DCN20+

Julien Grall (1):
      x86/xen: Remove undefined behavior in setup_features()

Kai-Heng Feng (1):
      igb: Make DMA faster when CPU is active on the PCIe link

Kailang Yang (1):
      ALSA: hda/realtek - ALC897 headset MIC no sound

Kees Cook (1):
      hinic: Replace memcpy() with direct assignment

Kumar Kartikeya Dwivedi (1):
      bpf: Limit maximum modifier chain length in btf_check_type_tags

Kuogee Hsieh (2):
      drm/msm/dp: check core_initialized before disable interrupts at
dp_display_unbind()
      drm/msm/dp: force link training for display resolution change

Lars-Peter Clausen (1):
      spi: cadence: Detect transmit FIFO depth

Leo Savernik (1):
      nvme: add a bogus subsystem NQN quirk for Micron MTFDKBA2T0TFH

Leo Yan (1):
      perf arm-spe: Don't set data source if it's not a memory operation

Li Nan (1):
      block: remove WARN_ON() from bd_link_disk_holder

Liam Beguin (1):
      iio: test: fix missing MODULE_LICENSE for IIO_RESCALE=3Dm

Liang He (10):
      xtensa: Fix refcount leak bug in time.c
      xtensa: xtfpga: Fix refcount leak bug in setup
      arch: mips: generic: Add missing of_node_put() in board-ranchu.c
      mips: mti-malta: Fix refcount leak in malta-time.c
      mips: ralink: Fix refcount leak in of.c
      mips: lantiq: falcon: Fix refcount leak bug in sysctrl
      mips: lantiq: xway: Fix refcount leak bug in sysctrl
      mips/pic32/pic32mzda: Fix refcount leak bugs
      mips: lantiq: Add missing of_node_put() in irq.c
      arm: mach-spear: Add missing of_node_put() in time.c

Linus Torvalds (1):
      Linux 5.19-rc4

Linus Walleij (2):
      iio: magnetometer: yas530: Fix memchr_inv() misuse
      iio: afe: rescale: Fix boolean logic bug

Lorenzo Bianconi (1):
      igb: fix a use-after-free issue in igb_clean_tx_ring

Lucas Stach (1):
      ARM: dts: imx6qdl: correct PU regulator ramp delay

Ludvig P=C3=A4rsson (1):
      firmware: arm_scmi: Fix incorrect error propagation in
scmi_voltage_descriptors_get

Lukas Bulwahn (2):
      MAINTAINERS: add include/dt-bindings/gpio to GPIO SUBSYSTEM
      MAINTAINERS: add include/dt-bindings/usb to USB SUBSYSTEM

Lukas Wunner (1):
      net: phy: smsc: Disable Energy Detect Power-Down in interrupt mode

Lv Ruyi (1):
      iio: adc: xilinx-ams: fix return error variable

Macpaul Lin (1):
      USB: serial: option: add Quectel RM500K module support

Marc Zyngier (1):
      KVM: arm64: Add Oliver as a reviewer

Marcelo Tosatti (1):
      mm: lru_cache_disable: use synchronize_rcu_expedited

Marcin Szycik (1):
      ice: ignore protocol field in GTP offload

Mario Limonciello (1):
      drm/amd: Revert "drm/amd/display: keep eDP Vdd on when eDP
stream is already enabled"

Mark Brown (1):
      selftests: Fix clang cross compilation

Masahiro Yamada (2):
      modpost: fix section mismatch check for exported init/exit sections
      kbuild: link vmlinux only once for CONFIG_TRIM_UNUSED_KSYMS (2nd atte=
mpt)

Masami Hiramatsu (Google) (3):
      fprobe, samples: Add use_trace option and show hit/missed counter
      rethook: Reject getting a rethook if RCU is not watching
      tracing/kprobes: Check whether get_kretprobe() returns NULL in
kretprobe_dispatcher()

Mathias Nyman (1):
      xhci: turn off port power in shutdown

Matt Ranostay (1):
      arm64: dts: ti: k3-j721s2: Fix overlapping GICD memory region

Matthew Wilcox (Oracle) (3):
      filemap: Correct the conditions for marking a folio as accessed
      filemap: Handle sibling entries in filemap_get_read_batch()
      mm: Clear page->private when splitting or migrating a page

Max Filippov (1):
      xtensa: change '.bss' to '.section .bss'

Max Krummenacher (1):
      ARM: dts: imx6qdl-colibri: Fix capacitive touch reset polarity

Maxime Ripard (14):
      drm/vc4: plane: Prevent async update if we don't have a dlist
      drm/vc4: Consolidate Hardware Revision Check
      drm/vc4: bo: Rename vc4_dumb_create
      drm/vc4: bo: Split out Dumb buffers fixup
      drm/vc4: drv: Register a different driver on BCM2711
      drm/vc4: kms: Register a different drm_mode_config_funcs on BCM2711
      drm/vc4: plane: Register a different drm_plane_helper_funcs on BCM271=
1
      drm/vc4: drv: Skip BO Backend Initialization on BCM2711
      drm/vc4: crtc: Use an union to store the page flip callback
      drm/vc4: crtc: Move the BO handling out of common page-flip callback
      drm/vc4: crtc: Move the BO Handling out of Common Page-Flip Handler
      drm/vc4: crtc: Don't call into BO Handling on Async Page-Flips on BCM=
2711
      drm/vc4: crtc: Fix out of order frames during asynchronous page flips
      drm/vc4: Warn if some v3d code is run on BCM2711

Maximilian Luz (1):
      drm/msm: Fix double pm_runtime_disable() call

Maya Matuszczyk (1):
      drm: panel-orientation-quirks: Add quirk for Aya Neo Next

Mengqi Zhang (1):
      mmc: mediatek: wait dma stop bit reset to 0

Miaohe Lin (1):
      MAINTAINERS: add Miaohe Lin as a memory-failure reviewer

Miaoqian Lin (9):
      ARM: exynos: Fix refcount leak in exynos_map_pmu
      memory: mtk-smi: add missing put_device() call in
mtk_smi_device_link_common
      memory: samsung: exynos5422-dmc: Fix refcount leak in of_get_dram_tim=
ings
      soc: bcm: brcmstb: pm: pm-arm: Fix refcount leak in brcmstb_pm_probe
      ARM: Fix refcount leak in axxia_boot_secondary
      drm/msm/mdp4: Fix refcount leak in mdp4_modeset_init_intf
      iio: adc: aspeed: Fix refcount leak in aspeed_adc_set_trim_data
      iio: adc: adi-axi-adc: Fix refcount leak in adi_axi_adc_attach_client
      ARM: cns3xxx: Fix refcount leak in cns3xxx_init

Michael Ellerman (1):
      powerpc/mm: Move CMA reservations after initmem_init()

Michael Petlan (1):
      perf test: Record only user callchains on the "Check Arm64
callgraphs are complete in fp mode" test

Mike Kravetz (1):
      hugetlbfs: zero partial pages during fallocate hole punch

Mike Snitzer (1):
      dm: do not return early from dm_io_complete if BLK_STS_AGAIN
without polling

Mikulas Patocka (1):
      dm mirror log: clear log bits up to BITS_PER_LONG boundary

Ming Lei (1):
      dm: fix BLK_STS_DM_REQUEUE handling when dm_io represents split bio

Mingwei Zhang (1):
      KVM: x86/svm: add __GFP_ACCOUNT to __sev_dbg_{en,de}crypt_user()

Naohiro Aota (2):
      btrfs: zoned: prevent allocation from previous data relocation BG
      btrfs: zoned: fix critical section of relocation inode writeback

Nathan Chancellor (1):
      riscv: Fix ALT_THEAD_PMA's asm parameters

Naveen N. Rao (1):
      powerpc: Enable execve syscall exit tracepoint

Nick Desaulniers (1):
      Documentation/llvm: Update Supported Arch table

Nicolas Saenz Julienne (1):
      MAINTAINERS: Update BCM2711/BCM2835 maintainer

Nikos Tsironis (1):
      dm era: commit metadata in postsuspend after worker stops

Oleksandr Tyshchenko (1):
      drm/xen: Add missing VM_DONTEXPAND flag in mmap callback

Oleksij Rempel (1):
      net: phy: at803x: fix NULL pointer dereference on AR9331 PHY

Olivier Moysan (2):
      iio: adc: stm32: fix vrefint wrong calibration value handling
      iio: adc: stm32: fix maximum clock rate for stm32mp15x

Paolo Bonzini (1):
      MAINTAINERS: Reorganize KVM/x86 maintainership

Patrice Chotard (1):
      spi: spi-mem: Fix spi_mem_poll_status()

Paulo Alcantara (1):
      cifs: update cifs_ses::ip_addr after failover

Pavel Begunkov (4):
      io_uring: fix req->apoll_events
      io_uring: fail links when poll fails
      io_uring: fix wrong arm_poll error handling
      io_uring: fix double poll leak on repolling

Peilin Ye (1):
      net/sched: sch_netem: Fix arithmetic in netem_dump() for 32-bit platf=
orms

Peter Gonda (1):
      KVM: SEV: Init target VMCBs in sev_migrate_from

Petr Cvek (2):
      video: fbdev: intelfb: Use aperture size from pci_resource_len
      video: fbdev: intelfb: Initialize value of stolen size

Petr Mladek (7):
      kthread: make it clear that kthread_create_on_node() might be
terminated by any fatal signal
      Revert "printk: Wait for the global console lock when the system
is going down"
      Revert "printk: Block console kthreads when direct printing will
be required"
      Revert "printk: remove @console_locked"
      Revert "printk: extend console_lock for per-console locking"
      Revert "printk: add kthread console printers"
      Revert "printk: add functions to prefer direct printing"

Pierre-Louis Bossart (4):
      ALSA: hda: intel-dspcfg: use SOF for UpExtreme and UpExtreme11 boards
      ALSA: hda: intel-nhlt: remove use of __func__ in dev_dbg
      ALSA: x86: intel_hdmi_audio: enable pm_runtime and set autosuspend de=
lay
      ALSA: x86: intel_hdmi_audio: use pm_runtime_resume_and_get()

Qingqing Zhuo (1):
      drm/amd/display: Fix DC warning at driver load

Qu Wenruo (1):
      btrfs: prevent remounting to v1 space cache for subpage mount

Quentin Perret (1):
      KVM: arm64: Prevent kmemleak from accessing pKVM memory

Raghavendra Rao Ananta (1):
      selftests: KVM: Handle compiler optimizations in ucall

Raul Silvera (1):
      perf inject: Adjust output data offset for backward compatibility

Riccardo Paolo Bestetti (2):
      ipv4: ping: fix bind address validity check
      ipv4: fix bind address validity regression tests

Rob Clark (6):
      drm/msm: Ensure mmap offset is initialized
      drm/msm: Switch ordering of runpm put vs devfreq_idle
      drm/msm/gem: Separate object and vma unpin
      drm/msm/gem: Drop early returns in close/purge vma
      drm/msm: Drop update_fences()
      drm/msm: Don't overwrite hw fence in hw_init

Rob Herring (1):
      spi: dt-bindings: Fix unevaluatedProperties warnings in examples

Robert Marko (1):
      regulator: qcom_smd: correct MP5496 ranges

Rosemarie O'Riorden (1):
      net: openvswitch: fix parsing of nw_proto for IPv6 fragments

Sai Krishna Potthuri (1):
      spi: spi-cadence: Fix SPI CS gets toggling sporadically

Sami Tolvanen (1):
      kbuild: Ignore __this_module in gen_autoksyms.sh

Samuel Holland (2):
      drm/sun4i: dw-hdmi: Fix ddc-en GPIO consumer conflict
      drm/sun4i: Fix crash during suspend after component bind failure

Sander Vanheule (1):
      gpio: realtek-otto: Make the irqchip immutable

Sascha Hauer (1):
      mtd: rawnand: gpmi: Fix setting busy timeout setting

Saud Farooqui (2):
      drm/vc4: hdmi: Fixed possible integer overflow
      drm/sun4i: Return if frontend is not present

Saurabh Sengar (1):
      scsi: storvsc: Correct reporting of Hyper-V I/O size limits

Sebastian Andrzej Siewior (1):
      mm/slub: Move the stackdepot related allocation out of IRQ-off sectio=
n.

SeongJae Park (1):
      mm/damon/reclaim: schedule 'damon_reclaim_timer' only after
'system_wq' is initialized

Serge Semin (2):
      bus: bt1-apb: Don't print error on -EPROBE_DEFER
      bus: bt1-axi: Don't print error on -EPROBE_DEFER

Sergey Gorenko (1):
      scsi: iscsi: Exclude zero from the endpoint ID range

Shyam Prasad N (5):
      smb3: use netname when available on secondary channels
      cifs: change iface_list from array to sorted linked list
      cifs: during reconnect, update interface if necessary
      cifs: periodically query network interfaces from server
      cifs: avoid deadlocks while updating iface

Soham Sen (1):
      ALSA: hda/realtek: Add mute LED quirk for HP Omen laptop

Stefan Wahren (2):
      ARM: dts: bcm2711-rpi-400: Fix GPIO line names
      gpio: mxs: Fix header comment

Stephan Gerhold (1):
      virtio_net: fix xdp_rxq_info bug after suspend/resume

Steve French (1):
      smb3: fix empty netname context on secondary channels

Sungjong Seo (1):
      exfat: use updated exfat_chain directly during renaming

Takashi Iwai (5):
      ALSA: hda/realtek: Apply fixup for Lenovo Yoga Duet 7 properly
      ALSA: memalloc: Drop x86-specific hack for WC allocations
      ALSA: hda/conexant: Fix missing beep setup
      ALSA: hda/via: Fix missing beep setup
      ALSA: hda: Fix discovery of i915 graphics PCI device

Takashi Sakamoto (1):
      firewire: cdev: fix potential leak of kernel stack due to
uninitialized value

Tanveer Alam (1):
      xhci-pci: Allow host runtime PM as default for Intel Raptor Lake xHCI

Thara Gopinath (1):
      MAINTAINERS: Update email address

Thomas Richter (4):
      perf test: Fix "perf stat CSV output linter" test on s390
      s390/cpumf: Handle events cycles and instructions identical
      s390/pai: Prevent invalid event number for pai_crypto PMU
      s390/pai: Fix multiple concurrent event installation

Tiezhu Yang (2):
      LoongArch: Fix wrong fpu version
      LoongArch: Make compute_return_era() return void

Tim Crawford (2):
      ALSA: hda/realtek: Add quirk for Clevo PD70PNT
      ALSA: hda/realtek: Add quirk for Clevo NS50PU

Tom Schwindl (1):
      docs: driver-api: gpio: Fix filename mismatch

Tvrtko Ursulin (1):
      drm/i915/fdinfo: Don't show engine classes not present

Tyler Hicks (1):
      9p: Fix refcounting during full path walks for fid lookups

Tyrel Datwyler (2):
      scsi: ibmvfc: Allocate/free queue resource only during probe/remove
      scsi: ibmvfc: Store vhost pointer during subcrq allocation

Utkarsh Patel (1):
      xhci-pci: Allow host runtime PM as default for Intel Meteor Lake xHCI

Uwe Kleine-K=C3=B6nig (1):
      gpio: grgpio: Fix device removing

Vadim Fedorenko (1):
      MAINTAINERS: Add a maintainer for OCP Time Card

Ville Syrj=C3=A4l=C3=A4 (1):
      drm/i915: Implement w/a 22010492432 for adl-s

Vincent Whitchurch (1):
      iio: trigger: sysfs: fix use-after-free on remove

Wentao_Liang (1):
      drivers/net/ethernet/neterion/vxge: Fix a use-after-free bug in
vxge-main.c

Wojciech Drewek (1):
      ice: Fix switchdev rules book keeping

Xiang wangx (2):
      tracefs: Fix syntax errors in comments
      video: fbdev: skeletonfb: Fix syntax errors in comments

Xu Jia (1):
      hamradio: 6pack: fix array-index-out-of-bounds in decode_std_command(=
)

Xu Yang (1):
      usb: chipidea: udc: check request status before setting device addres=
s

Yang Li (1):
      mm/page_isolation.c: fix one kernel-doc comment

Yang Yang (1):
      mm: memcontrol: reference to tools/cgroup/memcg_slabinfo.py

Yannick Brosseau (2):
      iio: adc: stm32: Fix ADCs iteration in irq handler
      iio: adc: stm32: Fix IRQs on STM32F4 by removing custom spurious
IRQs message

Yihao Han (2):
      video: fbdev: au1100fb: Drop unnecessary NULL ptr check
      video: fbdev: simplefb: Check before clk_put() not needed

Yonglin Tan (1):
      USB: serial: option: add Quectel EM05-G modem

Yoshihiro Shimoda (1):
      iommu/ipmmu-vmsa: Fix compatible for rcar-gen4

Yu Liao (1):
      selftests dma: fix compile error for dma_map_benchmark

Zheyu Ma (1):
      iio: gyro: mpu3050: Fix the error handling in mpu3050_power_up()

Ziyang Xuan (1):
      net/tls: fix tls_sk_proto_close executed repeatedly

Zygo Blaxell (1):
      btrfs: don't set lock_owner when locking extent buffer for reading

huhai (1):
      MIPS: Remove repetitive increase irq_err_count

sunliming (1):
      tracing: Simplify conditional compilation code in tracing_set_tracer(=
)

zhenwei pi (1):
      mm/memory-failure: disable unpoison once hw error happens
