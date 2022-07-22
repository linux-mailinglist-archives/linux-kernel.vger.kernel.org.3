Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C913C57E8A0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 22:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235099AbiGVUz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 16:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiGVUzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 16:55:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B18B743D3;
        Fri, 22 Jul 2022 13:55:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E1095614F9;
        Fri, 22 Jul 2022 20:55:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00612C341C6;
        Fri, 22 Jul 2022 20:55:48 +0000 (UTC)
From:   Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 5.15.55-rt48
Date:   Fri, 22 Jul 2022 20:49:37 -0000
Message-ID: <165852297725.1199839.16341506468859284592@puck.lan>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Pavel Machek <pavel@denx.de>
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_ENVFROM,
        PP_MIME_FAKE_ASCII_TEXT,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 5.15.55-rt48 stable release.

Note that this list has two commits beyond merging the 5.15.55 stable branch:

cbca68f0a00 sched/core: Always flush pending blk_plug
0d167993e93c crypto/cryptd:   fix leftover hunks from 2a30446f4

The first is John Keeping's fix of a deadlock involving tsk_is_pi_blocked. I picked
this up from the 'tip' branch and will handle any conflict when gregkh pushes it.

The second is my fix of a thinko when I merged commit 2a30446f4. I missed two patch
hunks that left a spinlock and it's initialization code. The code was truly dead
code but it's annoying to define/initialize something and never use it :). Thanks to
Luis Claudio Goncalves for spotting this.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.15-rt
  Head SHA1: 988298f6b0d5078750ba2920e0b19eb3c84188c8

Or to build 5.15.55-rt48 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.15.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.15.55.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15/patch-5.15.55-rt48.patch.xz


Enjoy!
Clark

Changes from v5.15.49-rt47:
---

Adrian Hunter (1):
      perf build-id: Fix caching files with a wrong build ID

Aidan MacDonald (2):
      regmap-irq: Fix a bug in regmap_irq_enable() for type_in_mask chips
      regmap-irq: Fix offset/index mismatch in read_sub_irq_data()

Alan Stern (2):
      usb: gadget: Fix non-unique driver names in raw-gadget driver
      USB: gadget: Fix double-free bug in raw_gadget driver

Alex Deucher (1):
      Revert "drm/amdgpu/display: set vblank_disable_immediate for DC"

Alexander Egorenkov (1):
      s390/setup: preserve memory at OLDMEM_BASE and OLDMEM_SIZE

Alexander Gordeev (2):
      s390/boot: allocate amode31 section in decompressor
      s390/setup: use physical pointers for memblock_reserve()

Alexander Stein (1):
      ARM: dts: imx7: Move hsic_phy power domain to HSIC PHY node

Alexey Dobriyan (1):
      module: fix [e_shstrndx].sh_size=0 OOB access

Alexey Khoroshilov (1):
      NFSD: restore EINVAL error translation in nfsd_commit()

Amelie Delaunay (1):
      ARM: dts: stm32: use usbphyc ck_usbo_48m as USBH OHCI clock on stm32mp151

Amir Goldstein (1):
      vfs: fix copy_file_range() regression in cross-fs copies

Anatolii Gerasymenko (1):
      ice: ethtool: advertise 1000M speeds properly

Andreas Gruenbacher (1):
      gfs2: Fix gfs2_file_buffered_write endless loop workaround

Andrei Lalaev (1):
      pinctrl: sunxi: sunxi_pconf_set: use correct offset

Andrew Donnellan (1):
      powerpc/rtas: Allow ibm,platform-dump RTAS call with null buffer address

Andrew Gabbasov (1):
      memory: renesas-rpc-if: Avoid unaligned bus access for HyperFlash

Andy Shevchenko (1):
      usb: typec: wcove: Drop wrong dependency to INTEL_SOC_PMIC

Aneesh Kumar K.V (1):
      powerpc/memhotplug: Add add_pages override for PPC

AngeloGioacchino Del Regno (2):
      serial: 8250_mtk: Make sure to select the right FEATURE_SEL
      Revert "serial: 8250_mtk: Make sure to select the right FEATURE_SEL"

Arun Easi (2):
      scsi: qla2xxx: Fix crash during module load unload test
      scsi: qla2xxx: Fix loss of NVMe namespaces after driver reload test

Aswath Govindraju (1):
      arm64: dts: ti: k3-am64-main: Remove support for HS400 speed mode

Barnabás Pőcze (1):
      platform/x86: wmi: introduce helper to convert driver to WMI driver

Baruch Siach (1):
      iio: adc: vf610: fix conversion mode sysfs node name

Bjorn Andersson (1):
      drm/msm/dp: Drop now unused hpd_high member

Brian Foster (1):
      xfs: punch out data fork delalloc blocks on COW writeback failure

Bryan O'Donoghue (1):
      dt-bindings: soc: qcom: smd-rpm: Fix missing MSM8936 compatible

CHANDAN VURDIGERE NATARAJ (1):
      drm/amd/display: Fix by adding FPU protection for dcn30_internal_validate_bw

Caleb Connolly (1):
      dmaengine: qcom: bam_dma: fix runtime PM underflow

Carlo Lobrano (1):
      USB: serial: option: add Telit LE910Cx 0x1250 composition

Carlos Llamas (1):
      drm/fourcc: fix integer type usage in uapi header

Charles Keepax (2):
      ASoC: rt711: Add endianness flag in snd_soc_component_driver
      ASoC: rt711-sdca: Add endianness flag in snd_soc_component_driver

Chevron Li (1):
      mmc: sdhci-pci-o2micro: Fix card detect by dealing with debouncing

Chris Ye (1):
      nvdimm: Fix badblocks clear off-by-one error

Christian Borntraeger (1):
      s390/mm: use non-quiescing sske for KVM switch to keyed guest

Christian Brauner (12):
      fs: add is_idmapped_mnt() helper
      fs: move mapping helpers
      fs: tweak fsuidgid_has_mapping()
      fs: account for filesystem mappings
      docs: update mapping documentation
      fs: use low-level mapping helpers
      fs: remove unused low-level mapping helpers
      fs: port higher-level mapping helpers
      fs: add i_user_ns() helper
      fs: support mapped mounts of mapped filesystems
      fs: fix acl translation
      fs: account for group membership

Christian Marangi (1):
      net: dsa: qca8k: reset cpu port on MTU change

Christoph Hellwig (1):
      nvme: move the Samsung X5 quirk entry to the core quirks

Christophe JAILLET (1):
      dmaengine: lgm: Fix an error handling path in intel_ldma_probe()

Christophe Leroy (2):
      powerpc/book3e: Fix PUD allocation size in map_kernel_page()
      powerpc/32: Don't use lmw/stmw for saving/restoring non volatile regs

Chuck Lever (3):
      SUNRPC: Fix READ_PLUS crasher
      NFSD: De-duplicate net_generic(nf->nf_net, nfsd_net_id)
      NFSD: COMMIT operations must not return NFS?ERR_INVAL

Chun-Kuang Hu (4):
      drm/mediatek: Use mailbox rx_callback instead of cmdq_task_cb
      drm/mediatek: Remove the pointer of struct cmdq_client
      drm/mediatek: Detect CMDQ execution timeout
      drm/mediatek: Add cmdq_handle in mtk_crtc

Ciara Loftus (1):
      xsk: Fix generic transmit when completion queue reservation fails

Clark Williams (5):
      Merge tag 'v5.15.50' into v5.15-rt
      Merge tag 'v5.15.53' into v5.15-rt
      Merge tag 'v5.15.55' into v5.15-rt
      crypto/cryptd:   fix leftover hunks from 2a30446f4
      'Linux 5.15.55-rt48'

Claudio Imbrenda (1):
      KVM: s390x: fix SCK locking

Claudiu Beznea (3):
      ARM: at91: pm: use proper compatible for sama5d2's rtc
      ARM: at91: pm: use proper compatibles for sam9x60's rtc and rtt
      ARM: at91: pm: use proper compatibles for sama7g5's rtc and rtt

Claudiu Manoil (1):
      phy: aquantia: Fix AN when higher speeds than 1G are not advertised

Coly Li (1):
      bcache: memset on stack variables in bch_btree_check() and bch_sectors_dirty_init()

Damien Le Moal (2):
      zonefs: fix zonefs_iomap_begin() for reads
      scsi: scsi_debug: Fix zone transition to full condition

Dan Carpenter (3):
      gpio: winbond: Fix error code in winbond_gpio_get()
      net: fix IFF_TX_SKB_NO_LINEAR definition
      btrfs: fix error pointer dereference in btrfs_ioctl_rm_dev_v2()

Dan Williams (2):
      cxl/port: Hold port reference until decoder release
      memregion: Fix memregion_free() fallback definition

Daniel Borkmann (2):
      bpf: Fix incorrect verifier simulation around jmp32's jeq/jne
      bpf: Fix insufficient bounds propagation from adjust_scalar_min_max_vals

Daniel Starke (5):
      tty: n_gsm: fix frame reception handling
      tty: n_gsm: fix missing update of modem controls after DLCI open
      tty: n_gsm: fix invalid use of MSC in advanced option
      tty: n_gsm: fix sometimes uninitialized warning in gsm_dlci_modem_output()
      tty: n_gsm: fix invalid gsmtty_write_room() result

Daniele Palmas (1):
      net: usb: qmi_wwan: add Telit 0x1070 composition

Darrick J. Wong (3):
      xfs: remove all COW fork extents when remounting readonly
      xfs: prevent UAF in xfs_log_item_in_current_chkpt
      xfs: only bother with sync_filesystem during readonly remount

Dave Chinner (1):
      xfs: check sb_meta_uuid for dabuf buffer recovery

Dave Jiang (1):
      dmaengine: idxd: force wq context cleanup on device disable path

David Howells (2):
      afs: Fix dynamic root getattr
      rxrpc: Fix locking issue

David Sterba (1):
      btrfs: add error messages to all unrecognized mount options

Demi Marie Obenour (1):
      xen/gntdev: Avoid blocking in unmap_grant_pages()

Derek Fang (2):
      ASoC: rt5682: Avoid the unexpected IRQ event during going to suspend
      ASoC: rt5682: Re-detect the combo jack after resuming

Dexuan Cui (1):
      dma-direct: use the correct size for dma_set_encrypted()

Dimitris Michailidis (1):
      selftests/net: pass ipv6_args to udpgso_bench's IPv6 TCP test

Dmitry Baryshkov (1):
      arm64: dts: qcom: sdm845: use dispcc AHB clock for mdss node

Dmitry Osipenko (1):
      dmaengine: pl330: Fix lockdep warning about non-static key

Dmitry Rokosov (5):
      iio:humidity:hts221: rearrange iio trigger get and register
      iio:chemical:ccs811: rearrange iio trigger get and register
      iio:accel:kxcjk-1013: rearrange iio trigger get and register
      iio:accel:bma180: rearrange iio trigger get and register
      iio:accel:mxc4005: rearrange iio trigger get and register

Dominique Martinet (2):
      9p: fix fid refcount leak in v9fs_vfs_atomic_open_dotl
      9p: fix fid refcount leak in v9fs_vfs_get_link

Dongliang Mu (1):
      btrfs: don't access possibly stale fs_info data in device_list_add

Doug Berger (1):
      net: dsa: bcm_sf2: force pause link settings

Duoming Zhou (2):
      net: rose: fix UAF bugs caused by timer handler
      net: rose: fix UAF bug caused by rose_t0timer_expiry

Eddie James (3):
      fsi: occ: Force sequence numbering per OCC
      hwmon: (occ) Remove sequence numbering and checksum calculation
      hwmon: (occ) Prevent power cap command overwriting poll response

Edward Wu (1):
      ata: libata: add qc->flags in ata_qc_complete_template tracepoint

Eli Cohen (2):
      vdpa/mlx5: Update Control VQ callback information
      vdpa/mlx5: Avoid processing works if workqueue was destroyed

Enguerrand de Ribaucourt (2):
      net: dp83822: disable false carrier interrupt
      net: dp83822: disable rx error interrupt

Enzo Matsumiya (1):
      nvme-pci: add NO APST quirk for Kioxia device

Eric Dumazet (6):
      net: fix data-race in dev_isalive()
      erspan: do not assume transport header is always set
      net: bonding: fix possible NULL deref in rlb code
      tunnels: do not assume mac header is set in skb_tunnel_check_pmtu()
      ipv6: fix lockdep splat in in6_dump_addrs()
      tcp: add a missing nf_reset_ct() in 3WHS handling

Eric Sandeen (1):
      xfs: remove incorrect ASSERT in xfs_rename

Eugen Hristev (2):
      ARM: dts: at91: sam9x60ek: fix eeprom compatible and size
      ARM: dts: at91: sama5d2_icp: fix eeprom compatibles

Fabio Estevam (1):
      ARM: mxs_defconfig: Enable the framebuffer

Fabrice Gasnier (1):
      ARM: dts: stm32: add missing usbh clock and fix clk order on stm32mp15

Filipe Manana (4):
      btrfs: fix hang during unmount when block group reclaim task is running
      btrfs: fix invalid delayed ref after subvolume creation failure
      btrfs: fix warning when freeing leaf after subvolume creation failure
      btrfs: fix deadlock between chunk allocation and chunk btree modifications

Florian Westphal (2):
      netfilter: use get_random_u32 instead of prandom
      netfilter: nft_payload: don't allow th access for fragments

Geert Uytterhoeven (2):
      dt-bindings: usb: ohci: Increase the number of PHYs
      dt-bindings: usb: ehci: Increase the number of PHYs

Gerd Hoffmann (1):
      udmabuf: add back sanity check

Greg Kroah-Hartman (9):
      Linux 5.15.50
      Linux 5.15.51
      x86, kvm: use proper ASM macros for kvm_vcpu_is_preempted
      Linux 5.15.52
      clocksource/drivers/ixp4xx: remove EXPORT_SYMBOL_GPL from ixp4xx_timer_setup()
      Linux 5.15.53
      Linux 5.15.54
      Revert "mtd: rawnand: gpmi: Fix setting busy timeout setting"
      Linux 5.15.55

Guiling Deng (1):
      fbdev: fbmem: Fix logo center image dx issue

Guo-Feng Fan (1):
      rtw88: 8821c: support RFE type4 wifi NIC

Haibo Chen (3):
      iio: mma8452: fix probe fail when device tree compatible is used.
      iio: accel: mma8452: ignore the return value of reset operation
      iio: accel: mma8452: use the correct logic to get mma8452_data

Haiyang Zhang (1):
      net: mana: Add handling of CQE_RX_TRUNCATED

Hangbin Liu (1):
      selftests/net: fix section name when using xdp_dummy.o

Hans de Goede (12):
      iio: adc: axp288: Override TS pin bias current for some models
      ACPI: video: Change how we determine if brightness key-presses are handled
      platform/x86: panasonic-laptop: sort includes alphabetically
      platform/x86: panasonic-laptop: revert "Resolve hotkey double trigger bug"
      platform/x86: panasonic-laptop: don't report duplicate brightness key-presses
      platform/x86: panasonic-laptop: filter out duplicate volume up/down/mute keypresses
      Input: goodix - change goodix_i2c_write() len parameter type to int
      Input: goodix - add a goodix.h header file
      Input: goodix - refactor reset handling
      Input: goodix - try not to touch the reset-pin on x86/ACPI devices
      platform/x86: wmi: Replace read_takes_no_args with a flags field
      platform/x86: wmi: Fix driver->notify() vs ->probe() race

Heiner Kallweit (1):
      r8169: fix accessing unset transport header

Heinrich Schuchardt (1):
      riscv: defconfig: enable DRM_NOUVEAU

Heinz Mauelshagen (1):
      dm raid: fix accesses beyond end of raid member array

Helge Deller (5):
      parisc/stifb: Fix fb_is_primary_device() only available with CONFIG_FB_STI
      parisc: Enable ARCH_HAS_STRICT_MODULE_RWX
      fbmem: Check virtual screen sizes in fb_set_var()
      fbcon: Disallow setting font bigger than screen size
      fbcon: Prevent that screen size is smaller than font size

Hoang Le (1):
      tipc: fix use-after-free Read in tipc_named_reinit

Hou Tao (1):
      bpf, arm64: Use emit_addr_mov_i64() for BPF_PSEUDO_FUNC

Hsin-Yi Wang (1):
      video: of_display_timing.h: include errno.h

Hui Wang (2):
      serial: sc16is7xx: Clear RS485 bits in the shutdown
      Revert "serial: sc16is7xx: Clear RS485 bits in the shutdown"

Ivan Malov (1):
      xsk: Clear page contiguity bit when unmapping pool

Ivan Vecera (1):
      ethtool: Fix get module eeprom fallback

Jack Yu (1):
      ASoC: rt5682: move clk related code to rt5682_i2c_probe

Jaegeuk Kim (1):
      f2fs: attach inline_data after setting compression

Jakub Kicinski (5):
      Revert "net/tls: fix tls_sk_proto_close executed repeatedly"
      sock: redo the psock vs ULP protection check
      net: tun: unlink NAPI from device on destruction
      net: tun: stop NAPI when detaching queues
      net: tun: avoid disabling NAPI twice

Jakub Sitnicki (1):
      bpf, x86: Fix tail call count offset calculation on bpf2bpf call

Jan Beulich (1):
      xen-netfront: restore __skb_queue_tail() positioning in xennet_get_responses()

Jann Horn (1):
      mm/slub: add missing TID updates on slab deactivation

Jason A. Donenfeld (9):
      random: schedule mix_interrupt_randomness() less often
      random: quiet urandom warning ratelimit suppression message
      powerpc/microwatt: wire up rng during setup_arch()
      powerpc/powernv: wire up rng during setup_arch
      random: update comment from copy_to_user() -> copy_to_iter()
      powerpc/pseries: wire up rng during setup_arch()
      ksmbd: use vfs_llseek instead of dereferencing NULL
      s390/archrandom: simplify back to earlier design and initialize earlier
      powerpc/powernv: delay rng platform device creation until later in boot

Jason Andryuk (1):
      xen-blkfront: Handle NULL gendisk

Jason Wang (2):
      virtio-net: fix race between ndo_open() and virtio_device_ready()
      caif_virtio: fix race between virtio_device_ready() and ndo_open()

Jay Vosburgh (1):
      bonding: ARP monitor spams NETDEV_NOTIFY_PEERS notifiers

Jean Delvare (1):
      i2c: piix4: Fix a memory leak in the EFCH MMIO support

Jean-Baptiste Maneyrol (1):
      iio: imu: inv_icm42600: Fix broken icm42600 (chip id 0 value)

Jens Axboe (3):
      io_uring: ensure that send/sendmsg and recv/recvmsg check sqe->ioprio
      io_uring: ensure that fsnotify is always called
      block: only mark bio as tracked if it really is tracked

Jialin Zhang (2):
      iio: adc: rzg2l_adc: add missing fwnode_handle_put() in rzg2l_adc_parse_properties()
      iio: adc: ti-ads131e08: add missing fwnode_handle_put() in ads131e08_alloc_channels()

Jie2x Zhou (1):
      selftests: netfilter: correct PKTGEN_SCRIPT_PATHS in nft_concat_range.sh

Jimmy Assarsson (3):
      can: kvaser_usb: replace run-time checks with struct kvaser_usb_driver_info
      can: kvaser_usb: kvaser_usb_leaf: fix CAN clock frequency regression
      can: kvaser_usb: kvaser_usb_leaf: fix bittiming limits

Joerg Roedel (1):
      MAINTAINERS: Add new IOMMU development mailing list

Johan Hovold (2):
      USB: serial: pl2303: add support for more HXN (G) types
      media: davinci: vpif: fix use-after-free on driver unbind

Johannes Schickel (1):
      ALSA: usb-audio: add mapping for MSI MPG X570S Carbon Max Wifi.

Johannes Thumshirn (1):
      btrfs: zoned: encapsulate inode locking for zoned relocation

John Keeping (1):
      sched/core: Always flush pending blk_plug

Jon Maxwell (1):
      bpf: Fix request_sock leak in sk lookup helpers

Jonathan Marek (1):
      drm/msm: use for_each_sgtable_sg to iterate over scatterlist

Jose Alonso (1):
      net: usb: ax88179_178a: Fix packet receiving

Josef Bacik (4):
      btrfs: fix deadlock with fsync+fiemap+transaction commit
      btrfs: handle device lookup with btrfs_dev_lookup_args
      btrfs: add a btrfs_get_dev_args_from_path helper
      btrfs: use btrfs_get_dev_args_from_path in dev removal ioctls

Julien Grall (1):
      x86/xen: Remove undefined behavior in setup_features()

Kai-Heng Feng (1):
      igb: Make DMA faster when CPU is active on the PCIe link

Kailang Yang (1):
      ALSA: hda/realtek - ALC897 headset MIC no sound

Kamal Heib (1):
      RDMA/qedr: Fix reporting QP timeout attribute

Kees Cook (5):
      stddef: Introduce struct_group() helper macro
      media: omap3isp: Use struct_group() for memcpy() region
      Compiler Attributes: add __alloc_size() for better bounds checking
      bus: mhi: core: Use correctly sized arguments for bit field
      stddef: Introduce DECLARE_FLEX_ARRAY() helper

Konrad Dybcio (1):
      arm64: dts: qcom: msm8994: Fix CPU6/7 reg values

Krzysztof Kozlowski (1):
      nfc: nfcmrvl: Fix irq_of_parse_and_map() return value

Kumar Kartikeya Dwivedi (1):
      selftests/bpf: Add test_verifier support to fixup kfunc call insns

Kuogee Hsieh (5):
      drm/msm/dp: check core_initialized before disable interrupts at dp_display_unbind()
      drm/msm/dp: dp_link_parse_sink_count() return immediately if aux read failed
      drm/msm/dp: do not initialize phy until plugin interrupt received
      drm/msm/dp: force link training for display resolution change
      drm/msm/dp: Always clear mask bits to disable interrupts at dp_ctrl_reset_irq_ctrl()

Lad Prabhakar (1):
      clk: renesas: r9a07g044: Update multiplier and divider values for PLL2/3

Lamarque Vieira Souza (1):
      nvme-pci: add NVME_QUIRK_BOGUS_NID for ADATA IM2P33F8ABR1

Leah Rumancik (1):
      MAINTAINERS: add Leah as xfs maintainer for 5.15.y

Leo Yan (1):
      perf arm-spe: Don't set data source if it's not a memory operation

Liam Howlett (1):
      powerpc/prom_init: Fix kernel config grep

Liang He (5):
      xtensa: xtfpga: Fix refcount leak bug in setup
      xtensa: Fix refcount leak bug in time.c
      net/dsa/hirschmann: Add missing of_node_get() in hellcreek_led_setup()
      drivers: cpufreq: Add missing of_node_put() in qoriq-cpufreq.c
      can: grcan: grcan_probe(): remove extra of_node_get()

Linus Torvalds (1):
      ida: don't use BUG_ON() for debugging

Linus Walleij (2):
      iio: magnetometer: yas530: Fix memchr_inv() misuse
      iio: afe: rescale: Fix boolean logic bug

Liu Shixin (1):
      mm/filemap: fix UAF in find_lock_entries

Lorenzo Bianconi (5):
      igb: fix a use-after-free issue in igb_clean_tx_ring
      mt76: mt7921: get rid of mt7921_mac_set_beacon_filter
      mt76: mt7921: introduce mt7921_mcu_set_beacon_filter utility routine
      mt76: mt7921: fix a possible race enabling/disabling runtime-pm
      mt76: mt7921: do not always disable fw runtime-pm

Lucas Stach (1):
      ARM: dts: imx6qdl: correct PU regulator ramp delay

Luis Chamberlain (1):
      drbd: add error handling support for add_disk()

Lukas Wunner (4):
      serial: core: Initialize rs485 RTS polarity already on probe
      net: phy: Don't trigger state machine while in suspend
      PCI/portdrv: Rename pm_iter() to pcie_port_device_iter()
      PCI: pciehp: Ignore Link Down/Up caused by error-induced Hot Reset

Lukasz Cieplicki (1):
      i40e: Fix dropped jumbo frames statistics

Macpaul Lin (1):
      USB: serial: option: add Quectel RM500K module support

Manish Rangankar (1):
      scsi: qla2xxx: Move heartbeat handling from DPC thread to workqueue

Marc Kleine-Budde (2):
      can: m_can: m_can_chip_config(): actually enable internal timestamping
      can: m_can: m_can_{read_fifo,echo_tx_event}(): shift timestamp to full 32 bits

Marian Postevca (1):
      usb: gadget: u_ether: fix regression in setting fixed MAC address

Mario Limonciello (1):
      drm/amd: Refactor `amdgpu_aspm` to be evaluated per device

Mark Rutland (2):
      irqchip/gic-v3: Ensure pseudo-NMIs have an ISB between ack and handling
      irqchip/gic-v3: Refactor ISB + EOIR at ack time

Martin KaFai Lau (1):
      bpf: Stop caching subprog index in the bpf_pseudo_func insn

Masahiro Yamada (4):
      modpost: fix section mismatch check for exported init/exit sections
      kbuild: link vmlinux only once for CONFIG_TRIM_UNUSED_KSYMS (2nd attempt)
      tick/nohz: unexport __init-annotated tick_nohz_full_setup()
      s390: remove unneeded 'select BUILD_BIN2C'

Masami Hiramatsu (Google) (1):
      tracing/kprobes: Check whether get_kretprobe() returns NULL in kretprobe_dispatcher()

Mathias Nyman (1):
      xhci: turn off port power in shutdown

Mathieu Desnoyers (15):
      selftests/rseq: introduce own copy of rseq uapi header
      selftests/rseq: Remove useless assignment to cpu variable
      selftests/rseq: Remove volatile from __rseq_abi
      selftests/rseq: Introduce rseq_get_abi() helper
      selftests/rseq: Introduce thread pointer getters
      selftests/rseq: Uplift rseq selftests for compatibility with glibc-2.35
      selftests/rseq: Fix ppc32: wrong rseq_cs 32-bit field pointer on big endian
      selftests/rseq: Fix ppc32 missing instruction selection "u" and "x" for load/store
      selftests/rseq: Fix ppc32 offsets by using long rather than off_t
      selftests/rseq: Fix warnings about #if checks of undefined tokens
      selftests/rseq: Remove arm/mips asm goto compiler work-around
      selftests/rseq: Fix: work-around asm goto compiler bugs
      selftests/rseq: x86-64: use %fs segment selector for accessing rseq thread area
      selftests/rseq: x86-32: use %gs segment selector for accessing rseq thread area
      selftests/rseq: Change type of rseq_offset to ptrdiff_t

Matthew Brost (1):
      drm/i915: Disable bonding on gen12+ platforms

Maurizio Avogadro (1):
      ALSA: usb-audio: add mapping for MSI MAG X570S Torpedo MAX.

Max Gurtovoy (1):
      virtio-blk: avoid preallocating big SGL for data

Maximilian Luz (1):
      drm/msm: Fix double pm_runtime_disable() call

Mengqi Zhang (1):
      mmc: mediatek: wait dma stop bit reset to 0

Miaohe Lin (1):
      mm/memory-failure.c: fix race with changing page compound again

Miaoqian Lin (12):
      drm/msm/mdp4: Fix refcount leak in mdp4_modeset_init_intf
      iio: adc: adi-axi-adc: Fix refcount leak in adi_axi_adc_attach_client
      ARM: exynos: Fix refcount leak in exynos_map_pmu
      soc: bcm: brcmstb: pm: pm-arm: Fix refcount leak in brcmstb_pm_probe
      ARM: Fix refcount leak in axxia_boot_secondary
      memory: samsung: exynos5422-dmc: Fix refcount leak in of_get_dram_timings
      ARM: cns3xxx: Fix refcount leak in cns3xxx_init
      RDMA/cm: Fix memory leak in ib_cm_insert_listen
      PM / devfreq: exynos-ppmu: Fix refcount leak in of_get_devfreq_events
      ARM: meson: Fix refcount leak in meson_smp_prepare_cpus
      dmaengine: ti: Fix refcount leak in ti_dra7_xbar_route_allocate
      dmaengine: ti: Add missing put_device in ti_dra7_xbar_route_allocate

Michael Strauss (1):
      drm/amd/display: Set min dcfclk if pipe count is 0

Michael Walle (2):
      NFC: nxp-nci: Don't issue a zero length i2c_master_read()
      dmaengine: at_xdma: handle errors of at_xdmac_alloc_desc() correctly

Michel Dänzer (1):
      dma-buf/poll: Get a file reference for outstanding fence callbacks

Mihai Sain (1):
      ARM: at91: fix soc detection for SAM9X60 SiPs

Mikulas Patocka (2):
      dm mirror log: clear log bits up to BITS_PER_LONG boundary
      dm raid: fix KASAN warning in raid5_add_disks

Namjae Jeon (2):
      ksmbd: set the range of bytes to zero without extending file size in FSCTL_ZERO_DATA
      ksmbd: check invalid FileOffset and BeyondFinalZero in FSCTL_ZERO_DATA

Naohiro Aota (1):
      btrfs: zoned: use dedicated lock for data relocation

Naoya Horiguchi (3):
      mm/hwpoison: mf_mutex for soft offline and unpoison
      mm/hwpoison: fix race between hugetlb free/demotion and memory_failure_hugetlb()
      Revert "mm/memory-failure.c: fix race with changing page compound again"

Naveen N. Rao (3):
      powerpc: Enable execve syscall exit tracepoint
      powerpc/ftrace: Remove ftrace init tramp once kernel init is complete
      powerpc/bpf: Fix use of user_pt_regs in uapi

Nicholas Kazlauskas (1):
      drm/amd/display: Don't reinitialize DMCUB on s0ix resume

Nicholas Piggin (2):
      powerpc: flexible GPR range save/restore macros
      powerpc/tm: Fix more userspace r13 corruption

Nicolas Dichtel (1):
      ipv6: take care of disable_policy when restoring routes

Niels Dossche (1):
      Bluetooth: protect le accept and resolv lists with hdev->lock

Nikolay Borisov (2):
      btrfs: rename btrfs_alloc_chunk to btrfs_create_chunk
      btrfs: add additional parameters to btrfs_init_tree_ref/btrfs_init_data_ref

Nikos Tsironis (1):
      dm era: commit metadata in postsuspend after worker stops

Norbert Zulinski (1):
      i40e: Fix VF's MAC Address change on VM

Oleksandr Tyshchenko (1):
      xen/arm: Fix race in RB-tree based P2M accounting

Oleksij Rempel (3):
      net: usb: asix: do not force pause frames support
      net: asix: fix "can't send until first packet is send" issue
      net: phy: ax88772a: fix lost pause advertisement configuration

Oliver Hartkopp (1):
      can: bcm: use call_rcu() instead of costly synchronize_rcu()

Oliver Neukum (2):
      usbnet: fix memory allocation in helpers
      usbnet: fix memory leak in error case

Oliver Upton (1):
      KVM: Don't create VM debugfs files outside of the VM directory

Olivier Moysan (1):
      iio: adc: stm32: fix maximum clock rate for stm32mp15x

Pablo Greco (1):
      nvme-pci: add NVME_QUIRK_BOGUS_NID for ADATA XPG SX6000LNP (AKA SPECTRIX S40G)

Pablo Neira Ayuso (5):
      netfilter: nft_dynset: restore set element counter when failing to update
      netfilter: nft_set_pipapo: release elements in clone from abort path
      netfilter: nf_tables: stricter validation of element data
      netfilter: nf_tables: convert pktinfo->tprot_set to flags field
      netfilter: nft_payload: support for inner header matching / mangling

Palmer Dabbelt (2):
      RISC-V: defconfigs: Set CONFIG_FB=y, for FB console
      riscv/mm: Add XIP_FIXUP for riscv_pfn_base

Paolo Abeni (1):
      selftests: mptcp: more stable diag tests

Paolo Bonzini (2):
      mm: vmalloc: introduce array allocation functions
      KVM: use __vcalloc for very large allocations

Paul Davey (1):
      bus: mhi: Fix pm_state conversion to string

Pavel Begunkov (3):
      io_uring: fix not locked access to fixed buf table
      block: use bdev_get_queue() in bio.c
      io_uring: avoid io-wq -EAGAIN looping for !IOPOLL

Peilin Ye (1):
      net/sched: sch_netem: Fix arithmetic in netem_dump() for 32-bit platforms

Peng Fan (9):
      arm64: dts: imx8mp-evk: correct mmc pad settings
      arm64: dts: imx8mp-evk: correct gpio-led pad settings
      arm64: dts: imx8mp-evk: correct vbus pad settings
      arm64: dts: imx8mp-evk: correct eqos pad settings
      arm64: dts: imx8mp-evk: correct I2C1 pad settings
      arm64: dts: imx8mp-evk: correct I2C3 pad settings
      arm64: dts: imx8mp-phyboard-pollux-rdk: correct uart pad settings
      arm64: dts: imx8mp-phyboard-pollux-rdk: correct eqos pad settings
      arm64: dts: imx8mp-phyboard-pollux-rdk: correct i2c2 & mmc settings

Peter Robinson (1):
      dmaengine: imx-sdma: Allow imx8m for imx7 FW revs

Peter Ujfalusi (1):
      ASoC: rt5682: Fix deadlock on resume

Petr Machata (1):
      mlxsw: spectrum_router: Fix rollback in tunnel next hop init

Pierre-Louis Bossart (1):
      ASoC: codecs: rt700/rt711/rt711-sdca: resume bus/codec in .set_jack_detect

Ping-Ke Shih (1):
      rtw88: rtw8821c: enable rfe 6 devices

Po-Hsu Lin (1):
      Revert "selftests/bpf: Add test for bpf_timer overwriting crash"

Qu Wenruo (2):
      btrfs: prevent remounting to v1 space cache for subpage mount
      btrfs: remove device item and update super block in the same transaction

Quentin Perret (1):
      KVM: arm64: Prevent kmemleak from accessing pKVM memory

Quinn Tran (2):
      scsi: qla2xxx: Fix laggy FC remote port session recovery
      scsi: qla2xxx: edif: Replace list_for_each_safe with list_for_each_entry_safe

Rafael J. Wysocki (1):
      PM: runtime: Redefine pm_runtime_release_supplier()

Rex-BC Chen (1):
      drm/mediatek: Add vblank register/unregister callback functions

Rhett Aultman (1):
      can: gs_usb: gs_usb_open/close(): fix memory leak

Richard Gong (1):
      drm/amdgpu: vi: disable ASPM on Intel Alder Lake based systems

Rick Lindsley (1):
      ibmvnic: Properly dispose of all skbs during a failover.

Rob Clark (3):
      drm/msm: Ensure mmap offset is initialized
      drm/msm: Switch ordering of runpm put vs devfreq_idle
      drm/msm/gem: Fix error return on fence id alloc fail

Roger Pau Monne (4):
      xen/blkfront: fix leaking data in shared pages
      xen/netfront: fix leaking data in shared pages
      xen/netfront: force data bouncing when backend is untrusted
      xen/blkfront: force data bouncing when backend is untrusted

Roi Dayan (4):
      net/mlx5e: Check action fwd/drop flag exists also for nic flows
      net/mlx5e: Split actions_match_supported() into a sub function
      net/mlx5e: TC, Reject rules with drop and modify hdr action
      net/mlx5e: TC, Reject rules with forward and drop actions

Rosemarie O'Riorden (1):
      net: openvswitch: fix parsing of nw_proto for IPv6 fragments

Ruili Ji (1):
      drm/amdgpu: To flush tlb for MMHUB of RAVEN series

Rustam Kovhaev (1):
      xfs: use kmem_cache_free() for kmem_cache objects

Samuel Holland (3):
      drm/sun4i: Fix crash during suspend after component bind failure
      pinctrl: sunxi: a83t: Fix NAND function name for some pins
      dt-bindings: dma: allwinner,sun50i-a64-dma: Fix min/max typo

Sascha Hauer (1):
      mtd: rawnand: gpmi: Fix setting busy timeout setting

Satish Nagireddy (1):
      i2c: cadence: Unregister the clk notifier in error path

Saurabh Sengar (1):
      scsi: storvsc: Correct reporting of Hyper-V I/O size limits

Sean Christopherson (3):
      KVM: x86/mmu: Use yield-safe TDP MMU root iter in MMU notifier unmapping
      KVM: x86/mmu: Use common TDP MMU zap helper for MMU notifier unmap hook
      KVM: Initialize debugfs_dentry when a VM is created to avoid NULL deref

Sean Wang (2):
      mt76: mt76_connac: fix MCU_CE_CMD_SET_ROC definition error
      Bluetooth: btmtksdio: fix use-after-free at btmtksdio_recv_event

Sean Young (1):
      media: ir_toy: prevent device from hanging during transmit

Sebastian Andrzej Siewior (2):
      net: Write lock dev_base_lock without disabling bottom halves.
      batman-adv: Use netif_rx().

Seevalamuthu Mariappan (1):
      ath11k: add hw_param for wakeup_mhi

Sergey Gorenko (1):
      scsi: iscsi: Exclude zero from the endpoint ID range

Shai Malin (1):
      qed: Improve the stack space of filter_config()

Sherry Sun (1):
      arm64: dts: imx8mp-evk: correct the uart2 pinctl value

Shuah Khan (5):
      selftests/rseq: remove ARRAY_SIZE define from individual tests
      module: change to print useful messages from elf_validity_check()
      misc: rtsx_usb: fix use of dma mapped buffer for usb bulk transfer
      misc: rtsx_usb: use separate command and response buffers
      misc: rtsx_usb: set return value in rsp_buf alloc err path

Soham Sen (1):
      ALSA: hda/realtek: Add mute LED quirk for HP Omen laptop

Stefan Seyfried (1):
      platform/x86: panasonic-laptop: de-obfuscate button codes

Stefan Wahren (1):
      ARM: dts: bcm2711-rpi-400: Fix GPIO line names

Stephan Gerhold (2):
      virtio_net: fix xdp_rxq_info bug after suspend/resume
      arm64: dts: qcom: msm8992-*: Fix vdd_lvs1_2-supply typo

Sukadev Bhattiprolu (3):
      ibmvnic: init init_done_rc earlier
      ibmvnic: clear fop when retrying probe
      ibmvnic: Allow queueing resets during probe

Tadeusz Struk (1):
      uapi/linux/stddef.h: Add include guards

Takashi Iwai (5):
      ALSA: hda/via: Fix missing beep setup
      ALSA: hda/conexant: Fix missing beep setup
      ALSA: hda/realtek: Apply fixup for Lenovo Yoga Duet 7 properly
      ALSA: usb-audio: Workarounds for Behringer UMC 204/404 HD
      ALSA: cs46xx: Fix missing snd_card_free() call at probe error

Tang Bin (1):
      Input: cpcap-pwrbutton - handle errors from platform_get_irq()

Tanveer Alam (1):
      xhci-pci: Allow host runtime PM as default for Intel Raptor Lake xHCI

Tao Liu (1):
      linux/dim: Fix divide by 0 in RDMA DIM

Tejun Heo (1):
      block: fix rq-qos breakage from skipping rq_qos_done_bio()

Thomas Hellström (2):
      drm/i915/gt: Register the migrate contexts with their engines
      drm/i915: Fix a race between vma / object destruction and unbinding

Thomas Kopp (2):
      can: mcp251xfd: mcp251xfd_regmap_crc_read(): improve workaround handling for mcp2517fd
      can: mcp251xfd: mcp251xfd_regmap_crc_read(): update workaround broken CRC on TBC register

Thomas Richter (1):
      s390/cpumf: Handle events cycles and instructions identical

Tim Crawford (3):
      ALSA: hda/realtek: Add quirk for Clevo PD70PNT
      ALSA: hda/realtek: Add quirk for Clevo NS50PU
      ALSA: hda/realtek: Add quirk for Clevo L140PU

Toke Høiland-Jørgensen (2):
      bpf: Fix calling global functions from BPF_PROG_TYPE_EXT programs
      selftests/bpf: Add selftest for calling global functions from freplace

Tom Rix (1):
      btrfs: fix use of uninitialized variable at rm device ioctl

Tong Zhang (1):
      epic100: fix use after free on rmmod

Tudor Ambarus (1):
      mtd: spi-nor: Skip erase logic when SPI_NOR_NO_ERASE is set

Tyler Hicks (1):
      9p: Fix refcounting during full path walks for fid lookups

Tyrel Datwyler (2):
      scsi: ibmvfc: Store vhost pointer during subcrq allocation
      scsi: ibmvfc: Allocate/free queue resource only during probe/remove

Utkarsh Patel (1):
      xhci-pci: Allow host runtime PM as default for Intel Meteor Lake xHCI

Victor Nogueira (1):
      net/sched: act_api: Notify user space if any actions were flushed before error

Ville Syrjälä (2):
      drm/i915: Implement w/a 22010492432 for adl-s
      drm/i915: Replace the unconditional clflush with drm_clflush_virt_range()

Vincent Whitchurch (1):
      iio: trigger: sysfs: fix use-after-free on remove

Vladimir Lypak (1):
      dt-bindings: soc: qcom: smd-rpm: Add compatible for MSM8953 SoC

Vladimir Oltean (4):
      net: mscc: ocelot: allow unregistered IP multicast flooding to CPU
      selftests: forwarding: fix flood_unicast_test when h2 supports IFF_UNICAST_FLT
      selftests: forwarding: fix learning_test when h1 supports IFF_UNICAST_FLT
      selftests: forwarding: fix error message in learning_test

Will Deacon (1):
      arm64: mm: Don't invalidate FROM_DEVICE buffers at start of DMA transfer

Wu Bo (1):
      drbd: Fix double free problem in drbd_create_device

Xiaomeng Tong (2):
      drbd: fix an invalid memory access caused by incorrect use of list iterator
      ASoC: rt5682: fix an incorrect NULL check on list iterator

Xin Long (1):
      tipc: move bc link creation back to tipc_node_create

Xu Yang (1):
      usb: chipidea: udc: check request status before setting device address

Yang Xu (1):
      xfs: Fix the free logic of state in xfs_attr_node_hasname

Yang Yingliang (1):
      hwmon: (ibmaem) don't call platform_device_del() if platform_device_add() fails

Yannick Brosseau (2):
      iio: adc: stm32: Fix ADCs iteration in irq handler
      iio: adc: stm32: Fix IRQs on STM32F4 by removing custom spurious IRQs message

Ye Guojin (1):
      virtio-blk: modify the value type of num in virtio_queue_rq()

Yevhen Orlov (1):
      net: bonding: fix use-after-free after 802.3ad slave unbind

Yian Chen (1):
      iommu/vt-d: Fix PCI bus rescan device hot add

Yonglin Tan (1):
      USB: serial: option: add Quectel EM05-G modem

YueHaibing (1):
      net: ipv6: unexport __init-annotated seg6_hmac_net_init()

Zhenguo Zhao (2):
      tty: n_gsm: Modify CR,PF bit when config requester
      tty: n_gsm: Save dlci address open status when config requester

Zheyu Ma (1):
      iio: gyro: mpu3050: Fix the error handling in mpu3050_power_up()

Ziyang Xuan (1):
      net/tls: fix tls_sk_proto_close executed repeatedly

Zygo Blaxell (1):
      btrfs: don't set lock_owner when locking extent buffer for reading

daniel.starke@siemens.com (1):
      tty: n_gsm: fix encoding of command/response bit

huhai (1):
      MIPS: Remove repetitive increase irq_err_count

katrinzhou (2):
      ipv6/sit: fix ipip6_tunnel_get_prl return value
      drm/i915/gem: add missing else

luofei (1):
      mm/hwpoison: avoid the impact of hwpoison_filter() return value on mce handler

tiancyin (1):
      drm/amd/vcn: fix an error msg on vcn 3.0
---
Documentation/ABI/testing/sysfs-bus-iio-vf610      |   2 +-
 .../bindings/dma/allwinner,sun50i-a64-dma.yaml     |   2 +-
 .../devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml |   3 +
 .../devicetree/bindings/usb/generic-ehci.yaml      |   3 +-
 .../devicetree/bindings/usb/generic-ohci.yaml      |   3 +-
 Documentation/filesystems/idmappings.rst           |  72 -----
 MAINTAINERS                                        |  15 +-
 Makefile                                           |  19 +-
 arch/arm/boot/dts/at91-sam9x60ek.dts               |   3 +-
 arch/arm/boot/dts/at91-sama5d2_icp.dts             |   6 +-
 arch/arm/boot/dts/bcm2711-rpi-400.dts              |   6 +-
 arch/arm/boot/dts/imx6qdl.dtsi                     |   2 +-
 arch/arm/boot/dts/imx7s.dtsi                       |   2 +-
 arch/arm/boot/dts/stm32mp151.dtsi                  |   4 +-
 arch/arm/configs/mxs_defconfig                     |   1 +
 arch/arm/include/asm/arch_gicv3.h                  |   7 +-
 arch/arm/mach-at91/pm.c                            |  10 +-
 arch/arm/mach-axxia/platsmp.c                      |   1 +
 arch/arm/mach-cns3xxx/core.c                       |   2 +
 arch/arm/mach-exynos/exynos.c                      |   1 +
 arch/arm/mach-meson/platsmp.c                      |   2 +
 arch/arm/xen/p2m.c                                 |   6 +-
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts       |  54 ++--
 .../dts/freescale/imx8mp-phyboard-pollux-rdk.dts   |  48 ++--
 .../boot/dts/qcom/msm8992-bullhead-rev-101.dts     |   2 +-
 arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dts  |   2 +-
 arch/arm64/boot/dts/qcom/msm8994.dtsi              |   4 +-
 arch/arm64/boot/dts/qcom/sdm845.dtsi               |   2 +-
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi           |   2 -
 arch/arm64/include/asm/arch_gicv3.h                |   6 -
 arch/arm64/kvm/arm.c                               |   6 +-
 arch/arm64/mm/cache.S                              |   2 -
 arch/arm64/net/bpf_jit_comp.c                      |   5 +-
 arch/mips/vr41xx/common/icu.c                      |   2 -
 arch/parisc/Kconfig                                |   1 +
 arch/parisc/include/asm/fb.h                       |   2 +-
 arch/powerpc/Kconfig                               |   4 +
 arch/powerpc/boot/crt0.S                           |  31 +--
 arch/powerpc/crypto/md5-asm.S                      |  10 +-
 arch/powerpc/crypto/sha1-powerpc-asm.S             |   6 +-
 arch/powerpc/include/asm/bpf_perf_event.h          |   9 +
 arch/powerpc/include/asm/ftrace.h                  |   4 +-
 arch/powerpc/include/asm/ppc_asm.h                 |  43 +--
 arch/powerpc/include/uapi/asm/bpf_perf_event.h     |   9 -
 arch/powerpc/kernel/entry_32.S                     |  23 +-
 arch/powerpc/kernel/exceptions-64e.S               |  14 +-
 arch/powerpc/kernel/exceptions-64s.S               |   6 +-
 arch/powerpc/kernel/head_32.h                      |   3 +-
 arch/powerpc/kernel/head_booke.h                   |   3 +-
 arch/powerpc/kernel/interrupt_64.S                 |  34 +--
 arch/powerpc/kernel/optprobes_head.S               |   4 +-
 arch/powerpc/kernel/process.c                      |   2 +-
 arch/powerpc/kernel/prom_init_check.sh             |   2 +-
 arch/powerpc/kernel/rtas.c                         |  11 +-
 arch/powerpc/kernel/tm.S                           |  38 +--
 arch/powerpc/kernel/trace/ftrace.c                 |  15 +-
 arch/powerpc/kernel/trace/ftrace_64_mprofile.S     |  15 +-
 arch/powerpc/kvm/book3s_hv_rmhandlers.S            |   5 +-
 arch/powerpc/kvm/book3s_hv_uvmem.c                 |   2 +-
 arch/powerpc/lib/test_emulate_step_exec_instr.S    |   8 +-
 arch/powerpc/mm/mem.c                              |  35 ++-
 arch/powerpc/mm/nohash/book3e_pgtable.c            |   6 +-
 arch/powerpc/platforms/microwatt/microwatt.h       |   7 +
 arch/powerpc/platforms/microwatt/rng.c             |  10 +-
 arch/powerpc/platforms/microwatt/setup.c           |   8 +
 arch/powerpc/platforms/powernv/powernv.h           |   2 +
 arch/powerpc/platforms/powernv/rng.c               |  66 +++--
 arch/powerpc/platforms/powernv/setup.c             |   2 +
 arch/powerpc/platforms/pseries/pseries.h           |   2 +
 arch/powerpc/platforms/pseries/rng.c               |  11 +-
 arch/powerpc/platforms/pseries/setup.c             |   2 +
 arch/riscv/configs/defconfig                       |   8 +-
 arch/riscv/configs/rv32_defconfig                  |   1 +
 arch/riscv/mm/init.c                               |   1 +
 arch/s390/Kconfig                                  |   1 -
 arch/s390/boot/compressed/decompressor.h           |   1 +
 arch/s390/boot/startup.c                           |   8 +
 arch/s390/crypto/arch_random.c                     | 217 ---------------
 arch/s390/include/asm/archrandom.h                 |  14 +-
 arch/s390/kernel/entry.h                           |   1 +
 arch/s390/kernel/perf_cpum_cf.c                    |  22 +-
 arch/s390/kernel/setup.c                           |  36 +--
 arch/s390/kernel/vmlinux.lds.S                     |   1 +
 arch/s390/kvm/kvm-s390.c                           |  19 +-
 arch/s390/kvm/kvm-s390.h                           |   4 +-
 arch/s390/kvm/priv.c                               |  15 +-
 arch/s390/mm/pgtable.c                             |   2 +-
 arch/x86/kernel/cpu/mce/core.c                     |   8 +-
 arch/x86/kernel/kvm.c                              |   2 +-
 arch/x86/kvm/mmu/page_track.c                      |   4 +-
 arch/x86/kvm/mmu/tdp_mmu.c                         |   9 +-
 arch/x86/kvm/x86.c                                 |   4 +-
 arch/x86/net/bpf_jit_comp.c                        |   3 +-
 arch/xtensa/kernel/time.c                          |   1 +
 arch/xtensa/platforms/xtfpga/setup.c               |   1 +
 block/bio.c                                        |  11 +-
 block/blk-iolatency.c                              |   2 +-
 block/blk-rq-qos.h                                 |  23 +-
 crypto/cryptd.c                                    |   2 -
 drivers/acpi/acpi_video.c                          |  13 +-
 drivers/base/core.c                                |   3 +-
 drivers/base/memory.c                              |   2 +
 drivers/base/power/runtime.c                       |  20 +-
 drivers/base/regmap/regmap-irq.c                   |   8 +-
 drivers/block/Kconfig                              |   1 +
 drivers/block/drbd/drbd_main.c                     |   8 +-
 drivers/block/virtio_blk.c                         | 158 +++++++----
 drivers/block/xen-blkfront.c                       |  75 +++--
 drivers/bluetooth/btmtksdio.c                      |   3 +-
 drivers/bus/mhi/core/init.c                        |   9 +-
 drivers/bus/mhi/core/internal.h                    |   2 +-
 drivers/char/random.c                              |   6 +-
 drivers/clk/renesas/r9a07g044-cpg.c                |   4 +-
 drivers/clocksource/timer-ixp4xx.c                 |   1 -
 drivers/cpufreq/qoriq-cpufreq.c                    |   1 +
 drivers/cxl/core/bus.c                             |   4 +
 drivers/devfreq/event/exynos-ppmu.c                |   8 +-
 drivers/dma-buf/dma-buf.c                          |  19 +-
 drivers/dma-buf/udmabuf.c                          |   5 +-
 drivers/dma/at_xdmac.c                             |   5 +
 drivers/dma/idxd/device.c                          |   5 +-
 drivers/dma/imx-sdma.c                             |   2 +-
 drivers/dma/lgm/lgm-dma.c                          |   3 +-
 drivers/dma/pl330.c                                |   2 +-
 drivers/dma/qcom/bam_dma.c                         |  39 +--
 drivers/dma/ti/dma-crossbar.c                      |   5 +
 drivers/fsi/fsi-occ.c                              |  54 ++--
 drivers/gpio/gpio-vr41xx.c                         |   2 -
 drivers/gpio/gpio-winbond.c                        |   7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c         |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  25 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c            |   1 +
 drivers/gpu/drm/amd/amdgpu/cik.c                   |   2 +-
 drivers/gpu/drm/amd/amdgpu/nv.c                    |   2 +-
 drivers/gpu/drm/amd/amdgpu/si.c                    |   2 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c                 |   2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c              |   2 +-
 drivers/gpu/drm/amd/amdgpu/vi.c                    |  17 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  33 ++-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_resource.c  |   2 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_resource.h  |   7 +
 .../gpu/drm/amd/display/dc/dcn31/dcn31_resource.c  |  65 ++++-
 .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    |   2 +-
 drivers/gpu/drm/i915/display/intel_dpll_mgr.c      |   4 +-
 drivers/gpu/drm/i915/gem/i915_gem_context.c        |  12 +-
 drivers/gpu/drm/i915/gem/i915_gem_object.c         |   6 +
 drivers/gpu/drm/i915/gt/intel_context_types.h      |   8 +
 drivers/gpu/drm/i915/gt/intel_engine_cs.c          |   4 +
 drivers/gpu/drm/i915/gt/intel_engine_pm.c          |  23 ++
 drivers/gpu/drm/i915/gt/intel_engine_pm.h          |   2 +
 drivers/gpu/drm/i915/gt/intel_engine_types.h       |   7 +
 .../gpu/drm/i915/gt/intel_execlists_submission.c   |   2 +
 drivers/gpu/drm/i915/gt/intel_ring_submission.c    |   5 +-
 drivers/gpu/drm/i915/gt/mock_engine.c              |   2 +
 drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c  |  12 +-
 drivers/gpu/drm/mediatek/mtk_disp_drv.h            |  16 +-
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c            |  22 +-
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c           |  20 +-
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c            | 133 +++++++--
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c        |   4 +
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h        |  29 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.c            |   3 +-
 drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c           |   2 +
 drivers/gpu/drm/msm/dp/dp_ctrl.c                   | 118 ++++----
 drivers/gpu/drm/msm/dp/dp_ctrl.h                   |  10 +-
 drivers/gpu/drm/msm/dp/dp_display.c                | 127 ++++-----
 drivers/gpu/drm/msm/dp/dp_hpd.c                    |   2 -
 drivers/gpu/drm/msm/dp/dp_hpd.h                    |   2 -
 drivers/gpu/drm/msm/dp/dp_link.c                   |  19 +-
 drivers/gpu/drm/msm/msm_drv.c                      |   2 +-
 drivers/gpu/drm/msm/msm_drv.h                      |   1 +
 drivers/gpu/drm/msm/msm_gem_prime.c                |  15 +
 drivers/gpu/drm/msm/msm_gem_submit.c               |   2 +-
 drivers/gpu/drm/msm/msm_gpu.c                      |   3 +-
 drivers/gpu/drm/msm/msm_iommu.c                    |   2 +-
 drivers/gpu/drm/sun4i/sun4i_drv.c                  |   4 +-
 drivers/hwmon/ibmaem.c                             |  12 +-
 drivers/hwmon/occ/common.c                         |  31 +--
 drivers/hwmon/occ/common.h                         |   4 +-
 drivers/hwmon/occ/p8_i2c.c                         |  26 +-
 drivers/hwmon/occ/p9_sbe.c                         |   9 +-
 drivers/i2c/busses/i2c-cadence.c                   |   1 +
 drivers/i2c/busses/i2c-piix4.c                     |  16 +-
 drivers/iio/accel/bma180.c                         |   3 +-
 drivers/iio/accel/kxcjk-1013.c                     |   4 +-
 drivers/iio/accel/mma8452.c                        |  26 +-
 drivers/iio/accel/mxc4005.c                        |   4 +-
 drivers/iio/adc/adi-axi-adc.c                      |   3 +
 drivers/iio/adc/axp288_adc.c                       |   8 +
 drivers/iio/adc/rzg2l_adc.c                        |   8 +-
 drivers/iio/adc/stm32-adc-core.c                   |   9 +-
 drivers/iio/adc/stm32-adc.c                        |  10 -
 drivers/iio/adc/ti-ads131e08.c                     |  10 +-
 drivers/iio/afe/iio-rescale.c                      |   2 +-
 drivers/iio/chemical/ccs811.c                      |   4 +-
 drivers/iio/gyro/mpu3050-core.c                    |   1 +
 drivers/iio/humidity/hts221_buffer.c               |   5 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600.h        |   1 +
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c   |   2 +-
 drivers/iio/magnetometer/yamaha-yas530.c           |   2 +-
 drivers/iio/trigger/iio-trig-sysfs.c               |   1 +
 drivers/infiniband/core/cm.c                       |   4 +-
 drivers/infiniband/hw/qedr/qedr.h                  |   1 +
 drivers/infiniband/hw/qedr/verbs.c                 |   4 +-
 drivers/input/misc/cpcap-pwrbutton.c               |   6 +-
 drivers/input/touchscreen/goodix.c                 | 150 +++++-----
 drivers/input/touchscreen/goodix.h                 |  75 +++++
 drivers/iommu/intel/dmar.c                         |   2 +-
 drivers/irqchip/irq-gic-v3.c                       |  42 ++-
 drivers/md/bcache/btree.c                          |   1 +
 drivers/md/bcache/writeback.c                      |   1 +
 drivers/md/dm-era-target.c                         |   8 +-
 drivers/md/dm-log.c                                |   2 +-
 drivers/md/dm-raid.c                               |  34 +--
 drivers/md/raid5.c                                 |   1 +
 drivers/media/platform/davinci/vpif.c              |  97 +++++--
 drivers/media/platform/omap3isp/ispstat.c          |   5 +-
 drivers/media/rc/ir_toy.c                          |   2 +-
 drivers/memory/renesas-rpc-if.c                    |  48 +++-
 drivers/memory/samsung/exynos5422-dmc.c            |  29 +-
 drivers/misc/cardreader/rtsx_usb.c                 |  27 +-
 drivers/mmc/host/mtk-sd.c                          |  20 +-
 drivers/mmc/host/sdhci-pci-o2micro.c               |   2 +
 drivers/mtd/spi-nor/core.c                         |   3 +-
 drivers/net/bonding/bond_3ad.c                     |   3 +-
 drivers/net/bonding/bond_alb.c                     |   2 +-
 drivers/net/bonding/bond_main.c                    |   4 +-
 drivers/net/caif/caif_virtio.c                     |  10 +-
 drivers/net/can/grcan.c                            |   1 -
 drivers/net/can/m_can/m_can.c                      |   8 +-
 drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c   |  22 +-
 drivers/net/can/usb/gs_usb.c                       |  23 +-
 drivers/net/can/usb/kvaser_usb/kvaser_usb.h        |  25 +-
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c   | 286 ++++++++++---------
 drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c  |   4 +-
 drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c   | 119 ++++----
 drivers/net/dsa/bcm_sf2.c                          |   5 +
 drivers/net/dsa/hirschmann/hellcreek_ptp.c         |   1 +
 drivers/net/dsa/qca8k.c                            |  23 +-
 drivers/net/ethernet/ibm/ibmvnic.c                 | 147 +++++++++-
 drivers/net/ethernet/ibm/ibmvnic.h                 |   1 +
 drivers/net/ethernet/intel/i40e/i40e.h             |  16 ++
 drivers/net/ethernet/intel/i40e/i40e_main.c        |  73 +++++
 drivers/net/ethernet/intel/i40e/i40e_register.h    |  13 +
 drivers/net/ethernet/intel/i40e/i40e_type.h        |   1 +
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |   4 +
 drivers/net/ethernet/intel/ice/ice_ethtool.c       |  39 ++-
 drivers/net/ethernet/intel/igb/igb_main.c          |  19 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    |  88 +++---
 .../net/ethernet/mellanox/mlxsw/spectrum_router.c  |  14 +-
 drivers/net/ethernet/microsoft/mana/mana_en.c      |   7 +-
 drivers/net/ethernet/mscc/ocelot.c                 |   8 +-
 drivers/net/ethernet/qlogic/qed/qed_l2.c           |  23 +-
 drivers/net/ethernet/qlogic/qede/qede_filter.c     |  47 ++--
 drivers/net/ethernet/realtek/r8169_main.c          |  10 +-
 drivers/net/ethernet/smsc/epic100.c                |   4 +-
 drivers/net/phy/aquantia_main.c                    |  15 +-
 drivers/net/phy/ax88796b.c                         |   6 +-
 drivers/net/phy/dp83822.c                          |   4 +-
 drivers/net/phy/phy.c                              |  23 ++
 drivers/net/phy/phy_device.c                       |  23 ++
 drivers/net/tun.c                                  |  15 +-
 drivers/net/usb/asix.h                             |   3 +-
 drivers/net/usb/asix_common.c                      |   1 +
 drivers/net/usb/ax88179_178a.c                     | 101 +++++--
 drivers/net/usb/qmi_wwan.c                         |   1 +
 drivers/net/usb/usbnet.c                           |  21 +-
 drivers/net/virtio_net.c                           |  33 +--
 drivers/net/wireless/ath/ath11k/core.c             |   5 +
 drivers/net/wireless/ath/ath11k/hw.h               |   1 +
 drivers/net/wireless/ath/ath11k/pci.c              |  12 +-
 .../net/wireless/mediatek/mt76/mt76_connac_mac.c   |   3 -
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.h   |   2 +-
 .../net/wireless/mediatek/mt76/mt7921/debugfs.c    |  31 ++-
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c    |  28 --
 drivers/net/wireless/mediatek/mt76/mt7921/main.c   |  33 +--
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c    |  47 ++--
 drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h |  11 +-
 drivers/net/wireless/realtek/rtw88/rtw8821c.c      |  14 +-
 drivers/net/xen-netfront.c                         |  56 +++-
 drivers/nfc/nfcmrvl/i2c.c                          |   6 +-
 drivers/nfc/nfcmrvl/spi.c                          |   6 +-
 drivers/nfc/nxp-nci/i2c.c                          |   3 +
 drivers/nvdimm/bus.c                               |   4 +-
 drivers/nvme/host/core.c                           |  28 ++
 drivers/nvme/host/pci.c                            |   9 +-
 drivers/pci/hotplug/pciehp.h                       |   2 +
 drivers/pci/hotplug/pciehp_core.c                  |   2 +
 drivers/pci/hotplug/pciehp_hpc.c                   |  26 ++
 drivers/pci/pcie/portdrv.h                         |   3 +
 drivers/pci/pcie/portdrv_core.c                    |  20 +-
 drivers/pci/pcie/portdrv_pci.c                     |   3 +
 drivers/pinctrl/sunxi/pinctrl-sun8i-a83t.c         |  10 +-
 drivers/pinctrl/sunxi/pinctrl-sunxi.c              |   2 +
 drivers/platform/x86/Kconfig                       |   2 +
 drivers/platform/x86/panasonic-laptop.c            |  84 ++++--
 drivers/platform/x86/wmi.c                         |  39 +--
 drivers/scsi/ibmvscsi/ibmvfc.c                     |  82 ++++--
 drivers/scsi/ibmvscsi/ibmvfc.h                     |   2 +-
 drivers/scsi/qla2xxx/qla_def.h                     |   5 +-
 drivers/scsi/qla2xxx/qla_edif.c                    |  39 +--
 drivers/scsi/qla2xxx/qla_edif.h                    |   1 -
 drivers/scsi/qla2xxx/qla_init.c                    |   2 +
 drivers/scsi/qla2xxx/qla_nvme.c                    |  27 +-
 drivers/scsi/qla2xxx/qla_os.c                      | 102 ++++---
 drivers/scsi/scsi_debug.c                          |  22 +-
 drivers/scsi/scsi_transport_iscsi.c                |   7 +-
 drivers/scsi/storvsc_drv.c                         |  27 +-
 drivers/soc/atmel/soc.c                            |  12 +-
 drivers/soc/bcm/brcmstb/pm/pm-arm.c                |   1 +
 drivers/tty/n_gsm.c                                | 263 ++++++++++++++---
 drivers/tty/serial/amba-pl011.c                    |  15 +-
 drivers/tty/serial/serial_core.c                   |  34 +--
 drivers/usb/chipidea/udc.c                         |   3 +
 drivers/usb/gadget/function/u_ether.c              |  11 +-
 drivers/usb/gadget/legacy/raw_gadget.c             |  63 +++--
 drivers/usb/host/xhci-hub.c                        |   2 +-
 drivers/usb/host/xhci-pci.c                        |   6 +-
 drivers/usb/host/xhci.c                            |  15 +-
 drivers/usb/host/xhci.h                            |   2 +
 drivers/usb/serial/option.c                        |   6 +
 drivers/usb/serial/pl2303.c                        |  29 +-
 drivers/usb/typec/tcpm/Kconfig                     |   1 -
 drivers/vdpa/mlx5/net/mlx5_vnet.c                  |   9 +-
 drivers/video/console/sticore.c                    |   2 +
 drivers/video/fbdev/core/fbcon.c                   |  33 +++
 drivers/video/fbdev/core/fbmem.c                   |  16 +-
 drivers/xen/features.c                             |   2 +-
 drivers/xen/gntdev-common.h                        |   7 +
 drivers/xen/gntdev.c                               | 157 +++++++----
 fs/9p/fid.c                                        |  22 +-
 fs/9p/vfs_inode.c                                  |   8 +-
 fs/9p/vfs_inode_dotl.c                             |   3 +
 fs/afs/inode.c                                     |   3 +-
 fs/attr.c                                          |  26 +-
 fs/btrfs/block-group.c                             | 152 ++++++----
 fs/btrfs/block-group.h                             |   2 +
 fs/btrfs/ctree.c                                   |  17 +-
 fs/btrfs/ctree.h                                   |   8 +-
 fs/btrfs/delayed-ref.h                             |   5 +-
 fs/btrfs/dev-replace.c                             |  16 +-
 fs/btrfs/disk-io.c                                 |  14 +-
 fs/btrfs/extent-tree.c                             |  28 +-
 fs/btrfs/extent_io.c                               |   8 +-
 fs/btrfs/file.c                                    |  80 ++++--
 fs/btrfs/free-space-tree.c                         |   4 +-
 fs/btrfs/inode.c                                   |   3 +-
 fs/btrfs/ioctl.c                                   |  96 ++++---
 fs/btrfs/locking.c                                 |   3 -
 fs/btrfs/qgroup.c                                  |   3 +-
 fs/btrfs/relocation.c                              |  25 +-
 fs/btrfs/scrub.c                                   |   6 +-
 fs/btrfs/super.c                                   |  47 +++-
 fs/btrfs/tree-log.c                                |   2 +-
 fs/btrfs/volumes.c                                 | 310 +++++++++++++--------
 fs/btrfs/volumes.h                                 |  28 +-
 fs/btrfs/zoned.c                                   |   2 +-
 fs/btrfs/zoned.h                                   |  17 ++
 fs/cachefiles/bind.c                               |   2 +-
 fs/ecryptfs/main.c                                 |   2 +-
 fs/f2fs/namei.c                                    |  17 +-
 fs/gfs2/file.c                                     |   1 +
 fs/io_uring.c                                      |  42 +--
 fs/ksmbd/smb2pdu.c                                 |  43 ++-
 fs/ksmbd/smbacl.c                                  |  19 +-
 fs/ksmbd/smbacl.h                                  |   5 +-
 fs/ksmbd/vfs.c                                     |  12 +-
 fs/namespace.c                                     |  53 +++-
 fs/nfsd/export.c                                   |   2 +-
 fs/nfsd/nfs3proc.c                                 |   6 -
 fs/nfsd/vfs.c                                      |  75 +++--
 fs/nfsd/vfs.h                                      |   4 +-
 fs/open.c                                          |   8 +-
 fs/overlayfs/super.c                               |   2 +-
 fs/posix_acl.c                                     |  27 +-
 fs/proc_namespace.c                                |   2 +-
 fs/read_write.c                                    |  77 ++---
 fs/seq_file.c                                      |  32 +++
 fs/xattr.c                                         |   6 +-
 fs/xfs/libxfs/xfs_attr.c                           |  17 +-
 fs/xfs/xfs_aops.c                                  |  15 +-
 fs/xfs/xfs_buf_item_recover.c                      |   2 +-
 fs/xfs/xfs_extfree_item.c                          |   6 +-
 fs/xfs/xfs_inode.c                                 |   9 +-
 fs/xfs/xfs_linux.h                                 |   1 +
 fs/xfs/xfs_log_cil.c                               |   6 +-
 fs/xfs/xfs_super.c                                 |  21 +-
 fs/xfs/xfs_symlink.c                               |   4 +-
 fs/zonefs/super.c                                  |  94 +++++--
 include/linux/blk_types.h                          |   3 +-
 include/linux/bpf.h                                |   6 +
 include/linux/compiler-gcc.h                       |   8 +
 include/linux/compiler_attributes.h                |  10 +
 include/linux/compiler_types.h                     |  12 +
 include/linux/dim.h                                |   2 +-
 include/linux/fbcon.h                              |   4 +
 include/linux/fs.h                                 | 141 +++-------
 include/linux/hugetlb.h                            |   6 +
 include/linux/list.h                               |  10 +
 include/linux/memregion.h                          |   2 +-
 include/linux/mm.h                                 |   8 +
 include/linux/mnt_idmapping.h                      | 234 ++++++++++++++++
 include/linux/netdevice.h                          |   2 +-
 include/linux/phy.h                                |   6 +
 include/linux/pm_runtime.h                         |   5 +-
 include/linux/posix_acl_xattr.h                    |   4 +
 include/linux/qed/qed_eth_if.h                     |  21 +-
 include/linux/ratelimit_types.h                    |  12 +-
 include/linux/rtsx_usb.h                           |   2 -
 include/linux/sched/rt.h                           |   8 -
 include/linux/seq_file.h                           |   4 +
 include/linux/stddef.h                             |  61 ++++
 include/linux/vmalloc.h                            |   5 +
 include/net/inet_sock.h                            |   5 +
 include/net/netfilter/nf_tables.h                  |  10 +-
 include/net/netfilter/nf_tables_ipv4.h             |   7 +-
 include/net/netfilter/nf_tables_ipv6.h             |   6 +-
 include/trace/events/libata.h                      |   1 +
 include/uapi/drm/drm_fourcc.h                      |   4 +-
 include/uapi/linux/netfilter/nf_tables.h           |   2 +
 include/uapi/linux/omap3isp.h                      |  21 +-
 include/uapi/linux/stddef.h                        |  41 +++
 include/video/of_display_timing.h                  |   2 +
 kernel/bpf/btf.c                                   |   5 +-
 kernel/bpf/core.c                                  |   7 +
 kernel/bpf/verifier.c                              | 150 ++++------
 kernel/dma/direct.c                                |   5 +-
 kernel/module.c                                    |  79 ++++--
 kernel/sched/core.c                                |   8 +-
 kernel/time/tick-sched.c                           |   1 -
 kernel/trace/trace_kprobe.c                        |  11 +-
 lib/idr.c                                          |   3 +-
 localversion-rt                                    |   2 +-
 mm/filemap.c                                       |  12 +-
 mm/hugetlb.c                                       |  10 +
 mm/hwpoison-inject.c                               |   3 +-
 mm/madvise.c                                       |   2 +
 mm/memory-failure.c                                | 205 ++++++++------
 mm/slub.c                                          |   2 +
 mm/util.c                                          |  50 ++++
 net/batman-adv/bridge_loop_avoidance.c             |   2 +-
 net/bluetooth/hci_event.c                          |  12 +
 net/can/bcm.c                                      |  18 +-
 net/core/dev.c                                     |  28 +-
 net/core/filter.c                                  |  34 ++-
 net/core/net-sysfs.c                               |   1 +
 net/core/skmsg.c                                   |   5 +
 net/ethtool/eeprom.c                               |   2 +-
 net/ipv4/ip_gre.c                                  |  15 +-
 net/ipv4/ip_tunnel_core.c                          |   2 +-
 net/ipv4/tcp_bpf.c                                 |   3 -
 net/ipv4/tcp_ipv4.c                                |   4 +-
 net/ipv6/addrconf.c                                |   8 +-
 net/ipv6/ip6_gre.c                                 |  15 +-
 net/ipv6/route.c                                   |   9 +-
 net/ipv6/seg6_hmac.c                               |   1 -
 net/ipv6/sit.c                                     |   8 +-
 net/netfilter/nf_tables_api.c                      |   9 +-
 net/netfilter/nf_tables_core.c                     |   2 +-
 net/netfilter/nf_tables_trace.c                    |   4 +-
 net/netfilter/nft_exthdr.c                         |   2 +-
 net/netfilter/nft_meta.c                           |  15 +-
 net/netfilter/nft_numgen.c                         |  12 +-
 net/netfilter/nft_payload.c                        |  63 ++++-
 net/netfilter/nft_set_hash.c                       |   2 +
 net/netfilter/nft_set_pipapo.c                     |  48 +++-
 net/openvswitch/flow.c                             |   2 +-
 net/rose/rose_route.c                              |   4 +-
 net/rose/rose_timer.c                              |  34 ++-
 net/rxrpc/ar-internal.h                            |   2 +-
 net/rxrpc/call_accept.c                            |   6 +-
 net/rxrpc/call_object.c                            |  18 +-
 net/rxrpc/net_ns.c                                 |   2 +-
 net/rxrpc/proc.c                                   |  10 +-
 net/sched/act_api.c                                |  22 +-
 net/sched/sch_netem.c                              |   4 +-
 net/sunrpc/xdr.c                                   |   2 +-
 net/tipc/core.c                                    |   3 +-
 net/tipc/node.c                                    |  41 +--
 net/tls/tls_main.c                                 |   2 +
 net/xdp/xsk.c                                      |  16 +-
 net/xdp/xsk_buff_pool.c                            |   1 +
 scripts/checkpatch.pl                              |   3 +-
 scripts/kernel-doc                                 |   9 +
 scripts/mod/modpost.c                              |   2 +-
 security/commoncap.c                               |  15 +-
 sound/pci/cs46xx/cs46xx.c                          |  22 +-
 sound/pci/hda/hda_auto_parser.c                    |   7 +-
 sound/pci/hda/hda_local.h                          |   1 +
 sound/pci/hda/patch_conexant.c                     |   4 +-
 sound/pci/hda/patch_realtek.c                      |  37 ++-
 sound/pci/hda/patch_via.c                          |   4 +-
 sound/soc/codecs/rt5682-i2c.c                      |  36 ++-
 sound/soc/codecs/rt5682.c                          | 125 ++++-----
 sound/soc/codecs/rt5682.h                          |   4 +-
 sound/soc/codecs/rt700.c                           |  16 +-
 sound/soc/codecs/rt711-sdca.c                      |  27 +-
 sound/soc/codecs/rt711.c                           |  25 +-
 sound/usb/mixer_maps.c                             |  16 ++
 sound/usb/quirks.c                                 |   4 +
 tools/perf/util/arm-spe.c                          |  22 +-
 tools/perf/util/build-id.c                         |  28 ++
 .../selftests/bpf/prog_tests/fexit_bpf2bpf.c       |  14 +
 .../testing/selftests/bpf/prog_tests/timer_crash.c |  32 ---
 .../selftests/bpf/progs/freplace_global_func.c     |  18 ++
 tools/testing/selftests/bpf/progs/timer_crash.c    |  54 ----
 tools/testing/selftests/bpf/test_verifier.c        |  28 ++
 tools/testing/selftests/net/forwarding/lib.sh      |   6 +-
 tools/testing/selftests/net/mptcp/diag.sh          |  48 +++-
 tools/testing/selftests/net/udpgro.sh              |   2 +-
 tools/testing/selftests/net/udpgro_bench.sh        |   2 +-
 tools/testing/selftests/net/udpgro_fwd.sh          |   2 +-
 tools/testing/selftests/net/udpgso_bench.sh        |   2 +-
 tools/testing/selftests/net/veth.sh                |   6 +-
 .../selftests/netfilter/nft_concat_range.sh        |   2 +-
 tools/testing/selftests/rseq/Makefile              |   2 +-
 .../testing/selftests/rseq/basic_percpu_ops_test.c |   5 +-
 tools/testing/selftests/rseq/compiler.h            |  30 ++
 tools/testing/selftests/rseq/param_test.c          |   8 +-
 tools/testing/selftests/rseq/rseq-abi.h            | 151 ++++++++++
 tools/testing/selftests/rseq/rseq-arm.h            | 110 ++++----
 tools/testing/selftests/rseq/rseq-arm64.h          |  79 ++++--
 .../selftests/rseq/rseq-generic-thread-pointer.h   |  25 ++
 tools/testing/selftests/rseq/rseq-mips.h           |  71 ++---
 .../selftests/rseq/rseq-ppc-thread-pointer.h       |  30 ++
 tools/testing/selftests/rseq/rseq-ppc.h            | 128 ++++++---
 tools/testing/selftests/rseq/rseq-s390.h           |  55 +++-
 tools/testing/selftests/rseq/rseq-skip.h           |   2 +-
 tools/testing/selftests/rseq/rseq-thread-pointer.h |  19 ++
 .../selftests/rseq/rseq-x86-thread-pointer.h       |  40 +++
 tools/testing/selftests/rseq/rseq-x86.h            | 200 ++++++++-----
 tools/testing/selftests/rseq/rseq.c                | 165 ++++++-----
 tools/testing/selftests/rseq/rseq.h                |  30 +-
 virt/kvm/kvm_main.c                                |  14 +-
 535 files changed, 7205 insertions(+), 3860 deletions(-)
---
