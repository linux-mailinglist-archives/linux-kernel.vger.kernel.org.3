Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7133560B53
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 23:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiF2VAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 17:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiF2VAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 17:00:21 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4A73E0FB;
        Wed, 29 Jun 2022 14:00:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id F0882CE29BA;
        Wed, 29 Jun 2022 21:00:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2418C34114;
        Wed, 29 Jun 2022 21:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656536413;
        bh=7BXH2jaI3uB8tJJwJfcDkmDZ3F/3KBVzz2v1XC2gL7Q=;
        h=Date:From:To:Subject:From;
        b=Y9v220aUPFSFGVKdqgMwfcLun29xO+snsJH4YxHmyGSkkAGZJWY39/S4kuTtqag7D
         2a72/TRBfSN+CZJMCqdF1+2/BMGoGwwg+nZDPaSeLRwF3d0yAOhKNiti3f52BFVt3k
         cJRkwiqLT7CReLxbWIXDdkNMfkW2yFAXWTEWICbzIREejTxZSvnPk+QKudjbhh1Qy0
         o5UrnB4egcJAmOtHKaluriV7Z3F6IrAhO+eENCMp3P38nw+x654UuWADKLhgQS56DV
         gPBAH1cwrnT0i/Ibq1sQ79TDRaOueuyR09vntgwNRMHEnCR0xsBB63Mp8mvkEHt0Cx
         JjwtAOzWr3EyQ==
Date:   Wed, 29 Jun 2022 14:00:11 -0700
From:   Mark Gross <markgross@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Danie l Wagner <dwagner@suse.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Joe Korty <joe.korty@concurrent-rt.com>
Subject: [ANNOUNCE] 4.9.319-rt195
Message-ID: <165653544233.150658.167155637716816810@T470>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.9.319-rt195 stable release.

This update includes a bugfix cherry-pick from v4.19-rt
cherry picked from commit a99e09659e6cd4b633c3689f2c3aa5f8a816fe5b
0329-signal-Prevent-double-free-of-user-struct.patch

Reported by Joe.Korty@concurrent-rt.com:
https://lore.kernel.org/lkml/20220624184431.GA4386@zipoli.concurrent-rt.com/

"""
We were seeing crashes in NFS.  It happened
only on arm64 systems.  We have a custom kernel with changes and the test
consisted of exercising one of those changes, which involved lots of signals,
then running NFS tests in loopback mode.  On occasion NFS would crash in
a way it never has crashed before, which suggested use-after-free corruption.
It never would crash unless we hit signals heavily first, which implied that
something in signals was wrong.  After that it wasn't too hard to find the
patch that fixed the problem in 4.4, 4.14, 4.19, 5.4, and 5.10.

We have not seen the NFS crash since applying the fix.
"""
Thanks Joe for the bug report and fix.

Our testing of this included a full LTP run (on x86) and did not find any
regressions.


You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.9-rt-rebase
  Head SHA1: 031611fdf1bb010d288cdc04ef6f0f205ecd83f5

Or to build 4.9.319-rt195 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.9.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.9.319.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.9/older/patch-4.9.319-rt195.patch.xz

Signing key fingerprint:

  A073 BC64 746A 086C DA24  97C8 F92D 73C9 A31A 1C17

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Mark Gross

Changes from v4.9.312-rt193:
---

Akira Yokosawa (1):
      docs/conf.py: Cope with removal of language=None in Sphinx 5.0.0

Alexander Aring (2):
      dlm: fix plock invalid read
      dlm: fix missing lkb refcount handling

Alexander Lobakin (1):
      modpost: fix removing numeric suffixes

Alexander Wetzel (1):
      rtl818x: Prevent using not initialized queues

Alexandra Winter (3):
      s390/ctcm: fix variable dereferenced before check
      s390/ctcm: fix potential memory leak
      s390/lcs: fix variable dereferenced before check

Amadeusz Sławiński (1):
      ALSA: jack: Access input_dev under mutex

Amir Goldstein (1):
      inotify: show inotify mask flags in proc fdinfo

Ammar Faizi (1):
      x86/delay: Fix the wrong asm constraint in delay_loop()

Andre Przywara (1):
      clocksource/drivers/sp804: Avoid error on multiple instances

Andreas Larsson (2):
      can: grcan: grcan_probe(): fix broken system id check for errata workaround needs
      can: grcan: only use the NAPI poll budget for RX

Ard Biesheuvel (2):
      ARM: 9196/1: spectre-bhb: enable for Cortex-A15
      ARM: 9197/1: spectre-bhb: fix loop8 sequence for Thumb2

Armin Wolf (1):
      hwmon: (adt7470) Fix warning on module removal

Baokun Li (1):
      jffs2: fix memory leak in jffs2_do_fill_super

Borislav Petkov (1):
      x86/cpu: Load microcode during restore_processor_state()

Brian Norris (1):
      drm/bridge: analogix_dp: Grab runtime PM reference for DP-AUX

Bruno Thomsen (1):
      USB: serial: cp210x: add PIDs for Kamstrup USB Meter Reader

Chengfeng Ye (1):
      firewire: fix potential uaf in outbound_phy_packet_callback()

Christophe JAILLET (2):
      bus: sunxi-rsb: Fix the return value of sunxi_rsb_device_create()
      net/qla3xxx: Fix a test in ql_reset_work()

Christophe de Dinechin (1):
      nodemask.h: fix compilation error with GCC12

Chuck Lever (2):
      NFSD: Fix possible sleep during nfsd4_release_lockowner()
      SUNRPC: Fix the calculation of xdr->end in xdr_get_next_encode_buffer()

Codrin Ciubotariu (1):
      ASoC: dmaengine: Restore NULL prepare_slave_config() callback

Corey Minyard (1):
      ipmi:ssif: Check for NULL msg when handling events and messages

Dan Carpenter (3):
      ath9k_htc: fix potential out of bounds access with invalid rxstatus->rs_keyix
      drm/msm: return an error pointer in msm_gem_prime_get_sg_table()
      net: ethernet: mtk_eth_soc: out of bounds read in mtk_hwlro_get_fdir_entry()

Dan Vacura (1):
      usb: gadget: uvc: Fix crash when encoding data for usb request

Daniel Hellstrom (1):
      can: grcan: use ofdev->dev when allocating DMA memory

Daniel Starke (7):
      tty: n_gsm: fix wrong signal octet encoding in convergence layer type 2
      tty: n_gsm: fix malformed counter for out of frame data
      tty: n_gsm: fix insufficient txframe size
      tty: n_gsm: fix missing explicit ldisc flush
      tty: n_gsm: fix wrong command retry handling
      tty: n_gsm: fix wrong command frame length field encoding
      tty: n_gsm: fix incorrect UA handling

Daniele Palmas (1):
      USB: serial: option: add Telit 0x1057, 0x1058, 0x1075 compositions

Dave Airlie (1):
      drm/amdgpu/cs: make commands with 0 chunks illegal behaviour.

David Gow (1):
      um: Cleanup syscall_handler_t definition/cast, fix warning

David Howells (3):
      rxrpc: Return an error to sendmsg if call failed
      rxrpc: Fix listen() setting the bar too high for the prealloc rings
      rxrpc: Don't try to resend the request if we're receiving the reply

Dennis Dalessandro (1):
      RDMA/hfi1: Fix potential integer multiplication overflow errors

Dinh Nguyen (1):
      dt-bindings: gpio: altera: correct interrupt-cells

Dmitry Baryshkov (1):
      drm/msm/dsi: fix error checks and return values for DSI xmit functions

Duoming Zhou (9):
      drivers: net: hippi: Fix deadlock in rr_close()
      can: grcan: grcan_close(): fix deadlock
      nfc: replace improper check device_is_registered() in netlink related functions
      nfc: nfcmrvl: main: reorder destructive operations in nfcmrvl_nci_unregister_dev to avoid bugs
      NFC: netlink: fix sleep in atomic bug when firmware download timeout
      NFC: nci: fix sleep in atomic context bugs caused by nci_skb_alloc
      drivers: staging: rtl8192e: Fix deadlock in rtllib_beacons_stop()
      drivers: tty: serial: Fix deadlock in sa1100_set_termios()
      drivers: usb: host: Fix deadlock in oxu_bus_suspend()

Emmanuel Grumbach (1):
      iwlwifi: mvm: fix assert 1F04 upon reconfig

Eric Dumazet (6):
      tcp: fix potential xmit stalls caused by TCP_NOTSENT_LOWAT
      net: igmp: respect RCU rules in ip_mc_source() and ip_mc_msfilter()
      netlink: do not reset transport header in netlink_recvmsg()
      sctp: read sk->sk_bound_dev_if once in sctp_rcv()
      tcp: tcp_rtx_synack() can be called from process context
      tcp: fix tcp_mtup_probe_success vs wrong snd_cwnd

Eric W. Biederman (2):
      ptrace/xtensa: Replace PT_SINGLESTEP with TIF_SINGLESTEP
      ptrace: Reimplement PTRACE_KILL by always sending SIGKILL

Ethan Yang (1):
      USB: serial: qcserial: add support for Sierra Wireless EM7590

Evan Green (1):
      USB: hcd-pci: Fully suspend across freeze/thaw cycle

Evan Quan (1):
      drm/amd/pm: fix the compile warning

Fabio Estevam (1):
      ARM: dts: imx6qdl-apalis: Fix sgtl5000 detection issue

Felix Fietkau (2):
      mac80211: fix rx reordering with non explicit / psmp ack policy
      mac80211: upgrade passive scan to active scan on DFS channels after beacon rx

Filipe Manana (1):
      btrfs: always log symlinks in full mode

Finn Thain (1):
      macintosh/via-pmu: Fix build failure when CONFIG_INPUT is disabled

Gal Pressman (1):
      net/mlx4_en: Fix wrong return value on ioctl EEPROM query failure

Gayatri Kammela (2):
      x86/cpu: Add Elkhart Lake to Intel family
      x86/cpu: Add another Alder Lake CPU to the Intel family

Geert Uytterhoeven (1):
      m68k: math-emu: Fix dependencies of math emulation support

Gleb Chesnokov (1):
      scsi: qla2xxx: Fix missed DMA unmap for aborted commands

Gong Yuanjun (1):
      drm/radeon: fix a possible null pointer dereference

Greg Kroah-Hartman (9):
      Revert "net: ethernet: stmmac: fix altr_tse_pcs function when using a fixed-link"
      lightnvm: disable the subsystem
      Linux 4.9.313
      Linux 4.9.314
      Linux 4.9.315
      Linux 4.9.316
      Linux 4.9.317
      Linux 4.9.318
      Linux 4.9.319

Greg Ungerer (2):
      m68knommu: set ZERO_PAGE() to the allocated zeroed page
      m68knommu: fix undefined reference to `_init_sp'

Guenter Roeck (1):
      cpu/speculation: Add prototype for cpu_show_srbds()

Guoqing Jiang (1):
      md: protect md_unregister_thread from reentrancy

Gustavo A. R. Silva (2):
      drm/i915: Fix -Wstringop-overflow warning in call to intel_read_wm_latency()
      scsi: fcoe: Fix Wstringop-overflow warnings in fcoe_wwn_from_mac()

H. Nikolaus Schaller (1):
      ARM: dts: Fix mmc order for omap3-gta04

Haimin Zhang (1):
      block-map: add __GFP_ZERO flag for alloc_page in function bio_copy_kern

Hangyu Hua (3):
      usb: misc: fix improper handling of refcount in uss720_probe()
      drm/dp/mst: fix a possible memory leak in fetch_monitor_name()
      usb: usbip: fix a refcount leak in stub_probe()

Haowen Bai (3):
      b43legacy: Fix assigning negative value to unsigned variable
      b43: Fix assigning negative value to unsigned variable
      ipw2x00: Fix potential NULL dereference in libipw_xmit()

Helge Deller (1):
      parisc: Merge model and model name into one line in /proc/cpuinfo

Henry Lin (1):
      xhci: stop polling roothubs after shutdown

Huang Guobin (1):
      tty: Fix a possible resource leak in icom_probe

Ilpo Järvinen (4):
      serial: digicolor-usart: Don't allow CS5-6
      serial: txx9: Don't allow CS5-6
      serial: sh-sci: Don't allow CS5-6
      serial: st-asc: Sanitize CSIZE and correct PARENB for CS7

Itay Iellin (1):
      Bluetooth: Fix the creation of hdev->name

Jakob Koschel (3):
      firewire: remove check of list iterator against head past the loop body
      drbd: remove usage of list iterator variable after loop
      staging: greybus: codecs: fix type confusion of list iterator variable

Jakub Kicinski (1):
      eth: tg3: silence the GCC 12 array-bounds warning

Jan Kara (1):
      ext4: verify dir block before splitting it

Janusz Krzysztofik (1):
      ARM: OMAP1: clock: Fix UART rate reporting algorithm

Jason A. Donenfeld (1):
      openrisc: start CPU timer early in boot

Jeff LaBundy (1):
      Input: add bounds checking to input_set_capability()

Ji-Ze Hong (Peter Hong) (1):
      hwmon: (f71882fg) Fix negative temperature

Jiasheng Jiang (1):
      net: af_key: add check for pfkey_broadcast in function pfkey_process

Jiazi Li (1):
      dm: fix mempool NULL pointer race when completing IO

Joerg Roedel (1):
      iommu/amd: Increase timeout waiting for GA log enablement

Johan Hovold (1):
      PCI: qcom: Fix unbalanced PHY init on probe errors

Johannes Berg (3):
      mac80211_hwsim: call ieee80211_tx_prepare_skb under RCU protection
      wifi: mac80211: fix use-after-free in chanctx code
      um: chan_user: Fix winch_tramp() return value

John Ogness (2):
      serial: meson: acquire port->lock in startup()
      serial: msm_serial: disable interrupts in __msm_console_write()

Jonathan Teh (1):
      HID: hid-led: fix maximum brightness for Dream Cheeky

Josh Poimboeuf (1):
      x86/speculation/mmio: Print SMT warning

Junxiao Bi via Ocfs2-devel (1):
      ocfs2: dlmfs: fix error handling of user_dlm_destroy_lock

Kan Liang (2):
      x86/CPU: Add more Icelake model numbers
      x86/cpu: Add Comet Lake to the Intel CPU models header

Kees Cook (4):
      USB: serial: whiteheat: fix heap overflow in WHITEHEAT_GET_DTR_RTS
      exec: Force single empty string when argv is empty
      lkdtm/usercopy: Expand size of "out of frame" object
      nodemask: Fix return values to be unsigned

Keita Suzuki (1):
      drm/amd/pm: fix double free in si_parse_power_table()

Kevin Mitchell (1):
      igb: skip phy status check where unavailable

Kirill A. Shutemov (1):
      ACPICA: Avoid cache flush inside virtual machines

Krzysztof Kozlowski (4):
      phy: samsung: exynos5250-sata: fix missing device put in probe error paths
      ARM: dts: exynos: add atmel,24c128 fallback to Samsung EEPROM
      rpmsg: qcom_smd: Fix irq_of_parse_and_map() return value
      clocksource/drivers/oxnas-rps: Fix irq_of_parse_and_map() return value

Kwanghoon Son (1):
      media: exynos4-is: Fix compile warning

Lee Jones (1):
      block: drbd: drbd_nl: Make conversion to 'enum drbd_ret_code' explicit

Lin Ma (3):
      ASoC: rt5645: Fix errorenous cleanup order
      NFC: NULL out the dev->rfkill to prevent UAF
      USB: storage: karma: fix rio_karma_init return

Linus Torvalds (1):
      drm: fix EDID struct for old ARM OABI format

Liu Jian (1):
      bpf: Enlarge offset check value to INT_MAX in bpf_skb_{load,store}_bytes

Liu Zixian (1):
      drm/virtio: fix NULL pointer dereference in virtio_gpu_conn_get_modes

Lokesh Dhoundiyal (1):
      ipv4: drop dst in multicast routing path

Lucas Tanure (1):
      i2c: cadence: Increase timeout per message if necessary

Lv Ruyi (4):
      pinctrl: pistachio: fix use of irq_of_parse_and_map()
      scsi: megaraid: Fix error check return value of register_chrdev()
      powerpc/xics: fix refcount leak in icp_opal_init()
      mfd: ipaq-micro: Fix error check return value of platform_get_irq()

Maciej W. Rozycki (4):
      serial: 8250: Also set sticky MCR bits in console restoration
      serial: 8250: Correct the clock for EndRun PTP/1588 PCIe device
      MIPS: Fix CP0 counter erratum detection for R4k CPUs
      MIPS: IP27: Remove incorrect `cpu_has_fpu' override

Maciej Żenczykowski (1):
      net: fix nla_strcmp to handle more then one trailing null character

Manish Chopra (1):
      bnx2x: fix napi API usage sequence

Manivannan Sadhasivam (1):
      scsi: ufs: qcom: Add a readl() to make sure ref_clk gets enabled

Marek Szyprowski (1):
      usb: dwc2: gadget: don't reset gadget's driver->bus

Mark Brown (6):
      ASoC: wm8958: Fix change notifications for DSP controls
      ASoC: max98090: Reject invalid values in custom control put()
      ASoC: max98090: Generate notifications on changes for custom control
      ASoC: ops: Validate input values in snd_soc_put_volsw_range()
      ASoC: dapm: Don't fold register value changes into notifications
      ASoC: rt5514: Fix event generation for "DSP Voice Wake Up" control

Mark Gross (3):
      Linux 4.9.312-rt194
      Merge tag 'v4.9.319' into v4.9-rt
      Linux 4.9.319-rt195

Mark-PK Tsai (1):
      tracing: Avoid adding tracer option before update_tracer_options

Martin Faltesek (2):
      nfc: st21nfca: fix incorrect validating logic in EVT_TRANSACTION
      nfc: st21nfca: fix memory leaks in EVT_TRANSACTION handling

Masahiro Yamada (2):
      net: xfrm: unexport __init-annotated xfrm4_protocol_init()
      modpost: fix undefined behavior of is_arm_mapping_symbol()

Mathias Nyman (1):
      Input: bcm5974 - set missing URB_NO_TRANSFER_DMA_MAP urb flag

Matt Fleming (1):
      signal: Prevent double-free of user struct

Matthieu Baerts (1):
      x86/pm: Fix false positive kmemleak report in msr_build_context()

Max Filippov (1):
      irqchip: irq-xtensa-mx: fix initial IRQ affinity

Miaohe Lin (1):
      drivers/base/node.c: fix compaction sysfs file leak

Miaoqian Lin (15):
      phy: samsung: Fix missing of_node_put() in exynos_sata_phy_probe
      ARM: OMAP2+: Fix refcount leak in omap_gic_of_init
      mtd: rawnand: Fix return value check of wait_for_completion_timeout
      ASoC: mediatek: Fix error handling in mt8173_max98090_dev_probe
      spi: spi-ti-qspi: Fix return value handling of wait_for_completion_timeout
      ASoC: mxs-saif: Fix refcount leak in mxs_saif_probe
      regulator: pfuze100: Fix refcount leak in pfuze_parse_regulators_dt
      media: exynos4-is: Change clk_disable to clk_disable_unprepare
      soc: qcom: smp2p: Fix missing of_node_put() in smp2p_parse_ipc
      soc: qcom: smsm: Fix missing of_node_put() in smsm_parse_ipc
      Input: sparcspkr - fix refcount leak in bbc_beep_probe
      video: fbdev: clcdfb: Fix refcount leak in clcdfb_of_vram_setup
      firmware: dmi-sysfs: Fix memory leak in dmi_sysfs_register_handle
      ata: pata_octeon_cf: Fix refcount leak in octeon_cf_probe
      net: altera: Fix refcount leak in altera_tse_mdio_create

Michael Ellerman (1):
      powerpc/32: Fix overread/overwrite of thread_struct via ptrace

Michael Hennerich (1):
      iio: dac: ad5446: Fix read_raw not returning set value

Michal Kubecek (1):
      Revert "net: af_key: add check for pfkey_broadcast in function pfkey_process"

Mike Kravetz (1):
      hugetlb: fix huge_pmd_unshare address update

Mike Snitzer (1):
      dm: interlock pending dm_io and dm_wait_for_bios_completion

Mikulas Patocka (5):
      hex2bin: make the function hex_to_bin constant-time
      hex2bin: fix access beyond string end
      dm crypt: make printing of the key constant-time
      dm stats: add cond_resched when looping over entries
      dma-debug: change allocation mode from GFP_NOWAIT to GFP_ATIOMIC

Miles Chen (1):
      drm/mediatek: Fix mtk_cec_mask()

Monish Kumar R (1):
      USB: new quirk for Dell Gen 2 devices

Muchun Song (1):
      mm: userfaultfd: fix missing cache flush in mcopy_atomic_pte() and __mcopy_atomic()

Nathan Chancellor (1):
      MIPS: Use address-of operator on section symbols

Nicolas Dichtel (1):
      ping: fix address binding wrt vrf

Niels Dossche (3):
      firewire: core: extend card->lock in fw_core_handle_bus_reset
      mwifiex: add mutex lock for call in mwifiex_dfs_chan_sw_work_queue
      usb: usbip: add missing device lock on tweak configuration cmd

OGAWA Hirofumi (1):
      fat: add ratelimit to fat*_ent_bread()

Oliver Neukum (2):
      USB: quirks: add a Realtek card reader
      USB: quirks: add STRING quirk for VCOM device

Pablo Neira Ayuso (1):
      netfilter: nf_tables: disallow non-stateful expression in sets earlier

Pali Rohár (1):
      irqchip/armada-370-xp: Do not touch Performance Counter Overflow on A375, A38x, A39x

Pavel Skripkin (1):
      media: pvrusb2: fix array-index-out-of-bounds in pvr2_i2c_core_init

Pawan Gupta (10):
      Documentation: Add documentation for Processor MMIO Stale Data
      x86/speculation/mmio: Enumerate Processor MMIO Stale Data bug
      x86/speculation: Add a common function for MD_CLEAR mitigation update
      x86/speculation/mmio: Add mitigation for Processor MMIO Stale Data
      x86/bugs: Group MDS, TAA & Processor MMIO Stale Data mitigations
      x86/speculation/mmio: Enable CPU Fill buffer clearing on idle
      x86/speculation/mmio: Add sysfs reporting for Processor MMIO Stale Data
      x86/speculation/srbds: Update SRBDS mitigation selection
      x86/speculation/mmio: Reuse SRBDS mitigation for SBDS
      KVM: x86/speculation: Disable Fill buffer clear within guests

Peilin Ye (1):
      ip_gre: Make o_seqno start from 0 in native mode

Peng Wu (2):
      ARM: versatile: Add missing of_node_put in dcscb_init
      ARM: hisi: Add missing of_node_put after of_find_compatible_node

Peter Zijlstra (1):
      perf: Fix sys_perf_event_open() race against self

Piyush Malgujar (1):
      drivers: i2c: thunderx: Allow driver to work with ACPI defined TWSI controllers

Qi Zheng (1):
      tty: fix deadlock caused by calling printk() under tty_port->lock

Qu Wenruo (1):
      btrfs: add "0x" prefix for unsupported optional features

Rajneesh Bhardwaj (2):
      x86/cpu: Add Cannonlake to Intel family
      x86/CPU: Add Icelake model number

Randy Dunlap (5):
      x86/mm: Cleanup the control_va_addr_alignment() __setup handler
      powerpc/8xx: export 'cpm_setbrg' for modules
      powerpc/idle: Fix return value of __setup() handler
      powerpc/4xx/cpm: Fix return value of __setup() handler
      pcmcia: db1xxx_ss: restrict to MIPS_DB1XXX boards

Ricky WU (1):
      mmc: rtsx: add 74 Clocks in power on flow

Sandipan Das (1):
      kvm: x86/cpuid: Only provide CPUID leaf 0xA if host has architectural PMU

Sarthak Kukreti (1):
      dm verity: set DM_TARGET_IMMUTABLE feature flag

Scott Chen (1):
      USB: serial: pl2303: add device id for HP LM930 Display

Sergey Ryazanov (1):
      usb: cdc-wdm: fix reading stuck on device close

Sergey Shtylyov (2):
      smsc911x: allow using IRQ0
      ata: libata-transport: fix {dma|pio|xfer}_mode sysfs files

Shravya Kumbham (1):
      net: emaclite: Add error handling for of_address_to_resource()

Shuah Khan (1):
      misc: rtsx: set NULL intfdata when probe fails

Shyam Prasad N (1):
      cifs: return errors during session setup during reconnects

Slark Xiao (1):
      USB: serial: option: add support for Cinterion MV32-WA/MV32-WB

Smith, Kyle Miller (Nimble Kernel) (1):
      nvme-pci: fix a NULL pointer dereference in nvme_alloc_admin_tags

Stephen Brennan (1):
      assoc_array: Fix BUG_ON during garbage collect

Sven Schwermer (2):
      USB: serial: option: add Fibocom L610 modem
      USB: serial: option: add Fibocom MA510 modem

Taehee Yoo (1):
      net: sfc: ef10: fix memory leak in efx_ef10_mtd_probe()

Takashi Iwai (1):
      ALSA: wavefront: Proper check of get_user() error

Takashi Sakamoto (1):
      ALSA: fireworks: fix wrong return count shorter than expected by 4 bytes

Tariq Toukan (1):
      net: Fix features skip in for_each_netdev_feature()

Thadeu Lima de Souza Cascardo (1):
      net: sched: prevent UAF on tc_ctl_tfilter when temporarily dropping rtnl_lock

Thibaut VARÈNE (1):
      ath9k: fix QCA9561 PA bias level

Thomas Bartschies (1):
      net: af_key: check encryption module availability consistency

Thomas Richter (1):
      perf bench numa: Address compiler error on s390

Tokunori Ikegami (2):
      mtd: cfi_cmdset_0002: Move and rename chip_check/chip_ready/chip_good_for_write
      mtd: cfi_cmdset_0002: Use chip_ready() for write on S29GL064N

Tony Luck (1):
      x86/cpu: Add Lakefield, Alder Lake and Rocket Lake models to the to Intel CPU family

Trond Myklebust (1):
      Revert "SUNRPC: attempt AF_LOCAL connect on setup"

Ulf Hansson (3):
      mmc: core: Specify timeouts for BKOPS and CACHE_FLUSH for eMMC
      mmc: block: Use generic_cmd6_time when modifying INAND_CMD38_ARG_EXT_CSD
      mmc: core: Default to generic_cmd6_time as timeout in __mmc_switch()

Uwe Kleine-König (1):
      pwm: lp3943: Fix duty calculation in case period was clamped

Vijayavardhan Vennapusa (1):
      usb: gadget: configfs: clear deactivation flag in configfs_composite_unbind()

Vincent Whitchurch (1):
      um: Fix out-of-bounds read in LDT setup

Wang Cheng (1):
      staging: rtl8712: fix uninit-value in r871xu_drv_init()

Willy Tarreau (2):
      floppy: disable FDRAWCMD by default
      floppy: use a statically allocated error counter

Xiao Yang (1):
      RDMA/rxe: Generate a completion for unsupported/invalid opcode

Xiaoke Wang (2):
      MIPS: lantiq: check the return value of kzalloc()
      iio: dummy: iio_simple_dummy: check the return value of kstrdup()

Xiaomeng Tong (7):
      media: uvcvideo: Fix missing check to determine if element is found in list
      scsi: dc395x: Fix a missing check on list iterator
      md: fix an incorrect NULL check in does_sb_need_changing
      md: fix an incorrect NULL check in md_reload_sb
      iommu/msm: Fix an incorrect NULL check on list iterator
      carl9170: tx: fix an incorrect use of list iterator
      gma500: fix an incorrect NULL check on list iterator

Xie Yongji (1):
      vringh: Fix loop descriptors check in the indirect cases

Xiu Jianfeng (1):
      tpm: ibmvtpm: Correct the return value in tpm_ibmvtpm_probe()

Yang Yingliang (9):
      clk: sunxi: sun9i-mmc: check return value after calling platform_get_resource()
      tty/serial: digicolor: fix possible null-ptr-deref in digicolor_uart_probe()
      ethernet: tulip: fix missing pci_disable_device() on error in tulip_init_one()
      net: stmmac: fix missing pci_disable_device() on error in stmmac_pci_probe()
      drm/msm/hdmi: check return value after calling platform_get_resource_byname()
      drm/rockchip: vop: fix possible null-ptr-deref in vop_bind()
      ASoC: wm2000: fix missing clk_disable_unprepare() on error in wm2000_anc_transition()
      rtc: mt6397: check return value after calling platform_get_resource()
      video: fbdev: pxa3xx-gcu: release the resources correctly in pxa3xx_gcu_probe/remove()

Ye Bin (2):
      ext4: fix use-after-free in ext4_rename_dir_prepare
      ext4: fix bug_on in ext4_writepages

Yicong Yang (1):
      PCI: Avoid pci_dev_lock() AB/BA deadlock with sriov_numvfs_store()

Ying Hsu (1):
      Bluetooth: fix dangling sco_conn and use-after-free in sco_sock_timeout

Zhang Rui (1):
      x86/cpu: Add Jasper Lake to Intel family

Zhen Ni (1):
      USB: host: isp116x: check return value after calling platform_get_resource()

Zheng Yongjun (1):
      spi: img-spfi: Fix pm_runtime_get_sync() error checking

Zheyu Ma (4):
      iio: magnetometer: ak8975: Fix the error handling in ak8975_power_on()
      ASoC: wm8731: Disable the regulator when probing fails
      media: cx25821: Fix the warning when removing the module
      tty: synclink_gt: Fix null-pointer-dereference in slgt_clean()

Zhihao Cheng (1):
      fs-writeback: writeback_sb_inodes：Recalculate 'wrote' according skipped pages

Zixuan Fu (3):
      net: vmxnet3: fix possible use-after-free bugs in vmxnet3_rq_alloc_rx_buf()
      net: vmxnet3: fix possible NULL pointer dereference in vmxnet3_rq_cleanup()
      fs: jfs: fix possible NULL pointer dereference in dbFree()

Zizhuang Deng (1):
      iio: dac: ad5592r: Fix the missing return value.

huangwenhui (1):
      ALSA: hda/conexant - Fix loopback issue with CX20632

j.nixdorf@avm.de (1):
      net: ipv6: ensure we call ipv6_mc_down() at most once

jianghaoran (1):
      ipv6: Don't send rs packets to the interface of ARPHRD_TUNNEL

linyujun (1):
      ARM: 9191/1: arm/stacktrace, kasan: Silence KASAN warnings in unwind_frame()
---
Documentation/ABI/testing/sysfs-ata                |   5 +-
 Documentation/ABI/testing/sysfs-devices-system-cpu |   1 +
 Documentation/conf.py                              |   2 +-
 .../devicetree/bindings/gpio/gpio-altera.txt       |   5 +-
 Documentation/hw-vuln/index.rst                    |   1 +
 .../hw-vuln/processor_mmio_stale_data.rst          | 246 +++++++++++++++++++++
 Documentation/kernel-parameters.txt                |  36 +++
 Makefile                                           |   2 +-
 arch/arm/boot/dts/exynos5250-smdk5250.dts          |   4 +-
 arch/arm/boot/dts/imx6qdl-apalis.dtsi              |  10 +-
 arch/arm/boot/dts/omap3-gta04.dtsi                 |   2 +
 arch/arm/kernel/entry-armv.S                       |   2 +-
 arch/arm/kernel/stacktrace.c                       |  10 +-
 arch/arm/mach-hisi/platsmp.c                       |   4 +
 arch/arm/mach-omap1/clock.c                        |   2 +-
 arch/arm/mach-omap2/omap4-common.c                 |   2 +
 arch/arm/mach-vexpress/dcscb.c                     |   1 +
 arch/arm/mm/proc-v7-bugs.c                         |   1 +
 arch/m68k/Kconfig.cpu                              |   2 +-
 arch/m68k/Kconfig.machine                          |   1 +
 arch/m68k/include/asm/pgtable_no.h                 |   3 +-
 arch/mips/bmips/setup.c                            |   2 +-
 .../include/asm/mach-ip27/cpu-feature-overrides.h  |   1 -
 arch/mips/include/asm/timex.h                      |   8 +-
 arch/mips/kernel/time.c                            |  11 +-
 arch/mips/lantiq/falcon/sysctrl.c                  |   2 +
 arch/mips/lantiq/prom.c                            |   2 +-
 arch/mips/lantiq/xway/gptu.c                       |   2 +
 arch/mips/lantiq/xway/sysctrl.c                    |  46 ++--
 arch/mips/pic32/pic32mzda/init.c                   |   2 +-
 arch/openrisc/include/asm/timex.h                  |   1 +
 arch/openrisc/kernel/head.S                        |   9 +
 arch/parisc/kernel/processor.c                     |   3 +-
 arch/powerpc/kernel/idle.c                         |   2 +-
 arch/powerpc/kernel/ptrace.c                       |  18 +-
 arch/powerpc/sysdev/cpm1.c                         |   1 +
 arch/powerpc/sysdev/ppc4xx_cpm.c                   |   2 +-
 arch/powerpc/sysdev/xics/icp-opal.c                |   1 +
 arch/um/drivers/chan_user.c                        |   9 +-
 arch/x86/include/asm/acenv.h                       |  14 +-
 arch/x86/include/asm/cpufeatures.h                 |   1 +
 arch/x86/include/asm/intel-family.h                |  25 +++
 arch/x86/include/asm/microcode.h                   |   2 +
 arch/x86/include/asm/msr-index.h                   |  25 +++
 arch/x86/include/asm/nospec-branch.h               |   2 +
 arch/x86/include/asm/suspend_32.h                  |   2 +-
 arch/x86/include/asm/suspend_64.h                  |  12 +-
 arch/x86/kernel/cpu/bugs.c                         | 235 +++++++++++++++++---
 arch/x86/kernel/cpu/common.c                       |  52 ++++-
 arch/x86/kernel/cpu/microcode/core.c               |   6 +-
 arch/x86/kernel/step.c                             |   3 +-
 arch/x86/kernel/sys_x86_64.c                       |   7 +-
 arch/x86/kvm/cpuid.c                               |   5 +
 arch/x86/kvm/vmx.c                                 |  77 ++++++-
 arch/x86/kvm/x86.c                                 |   4 +
 arch/x86/lib/delay.c                               |   4 +-
 arch/x86/power/cpu.c                               |   8 +
 arch/x86/um/ldt.c                                  |   6 +-
 arch/x86/um/shared/sysdep/syscalls_64.h            |   5 +-
 arch/xtensa/kernel/ptrace.c                        |   4 +-
 arch/xtensa/kernel/signal.c                        |   4 +-
 block/bio.c                                        |   2 +-
 drivers/ata/libata-transport.c                     |   2 +-
 drivers/ata/pata_octeon_cf.c                       |   3 +
 drivers/base/cpu.c                                 |   8 +
 drivers/base/node.c                                |   1 +
 drivers/block/Kconfig                              |  16 ++
 drivers/block/drbd/drbd_main.c                     |   7 +-
 drivers/block/drbd/drbd_nl.c                       |  13 +-
 drivers/block/floppy.c                             |  62 ++++--
 drivers/bus/sunxi-rsb.c                            |   2 +
 drivers/char/ipmi/ipmi_ssif.c                      |  23 ++
 drivers/char/tpm/tpm_ibmvtpm.c                     |   1 +
 drivers/clk/sunxi/clk-sun9i-mmc.c                  |   2 +
 drivers/clocksource/timer-oxnas-rps.c              |   2 +-
 drivers/clocksource/timer-sp804.c                  |  10 +-
 drivers/firewire/core-card.c                       |   3 +
 drivers/firewire/core-cdev.c                       |   4 +-
 drivers/firewire/core-topology.c                   |   9 +-
 drivers/firewire/core-transaction.c                |  30 +--
 drivers/firewire/sbp2.c                            |  13 +-
 drivers/firmware/dmi-sysfs.c                       |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |   2 +-
 drivers/gpu/drm/amd/amdgpu/kv_dpm.c                |  14 +-
 drivers/gpu/drm/amd/amdgpu/si_dpm.c                |   8 +-
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c |  13 +-
 drivers/gpu/drm/drm_dp_mst_topology.c              |   1 +
 drivers/gpu/drm/gma500/psb_intel_display.c         |   7 +-
 drivers/gpu/drm/i915/intel_pm.c                    |   2 +-
 drivers/gpu/drm/mediatek/mtk_cec.c                 |   2 +-
 drivers/gpu/drm/msm/dsi/dsi_host.c                 |  21 +-
 drivers/gpu/drm/msm/hdmi/hdmi.c                    |   4 +
 drivers/gpu/drm/msm/msm_gem_prime.c                |   2 +-
 drivers/gpu/drm/radeon/radeon_connectors.c         |   4 +
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c        |   2 +-
 drivers/gpu/drm/virtio/virtgpu_display.c           |   2 +
 drivers/hid/hid-led.c                              |   2 +-
 drivers/hwmon/adt7470.c                            |   4 +-
 drivers/hwmon/f71882fg.c                           |   5 +-
 drivers/i2c/busses/i2c-cadence.c                   |  12 +-
 drivers/i2c/busses/i2c-thunderx-pcidrv.c           |   1 +
 drivers/iio/dac/ad5446.c                           |   2 +-
 drivers/iio/dac/ad5592r-base.c                     |   2 +-
 drivers/iio/dummy/iio_simple_dummy.c               |  20 +-
 drivers/iio/magnetometer/ak8975.c                  |   1 +
 drivers/infiniband/hw/hfi1/init.c                  |   2 +-
 drivers/infiniband/sw/rxe/rxe_req.c                |   2 +-
 drivers/input/input.c                              |  19 ++
 drivers/input/misc/sparcspkr.c                     |   1 +
 drivers/input/mouse/bcm5974.c                      |   7 +-
 drivers/iommu/amd_iommu_init.c                     |   2 +-
 drivers/iommu/msm_iommu.c                          |  11 +-
 drivers/irqchip/irq-armada-370-xp.c                |  11 +-
 drivers/irqchip/irq-xtensa-mx.c                    |  18 +-
 drivers/lightnvm/Kconfig                           |   2 +-
 drivers/macintosh/Kconfig                          |   4 +
 drivers/macintosh/Makefile                         |   3 +-
 drivers/macintosh/via-pmu.c                        |   2 +-
 drivers/md/dm-crypt.c                              |  15 +-
 drivers/md/dm-stats.c                              |   8 +
 drivers/md/dm-verity-target.c                      |   1 +
 drivers/md/dm.c                                    |  19 +-
 drivers/md/md.c                                    |  33 ++-
 drivers/media/pci/cx25821/cx25821-core.c           |   2 +-
 drivers/media/platform/exynos4-is/fimc-is.c        |   2 +-
 drivers/media/platform/exynos4-is/fimc-isp-video.h |   2 +-
 drivers/media/usb/pvrusb2/pvrusb2-hdw.c            |   7 +-
 drivers/media/usb/uvc/uvc_v4l2.c                   |  20 +-
 drivers/mfd/ipaq-micro.c                           |   2 +-
 drivers/mfd/rtsx_usb.c                             |   1 +
 drivers/misc/lkdtm_usercopy.c                      |  17 +-
 drivers/mmc/card/block.c                           |   6 +-
 drivers/mmc/core/core.c                            |   5 +-
 drivers/mmc/core/mmc_ops.c                         |   9 +-
 drivers/mmc/host/rtsx_pci_sdmmc.c                  |  30 ++-
 drivers/mtd/chips/cfi_cmdset_0002.c                |  93 ++++----
 drivers/mtd/nand/sh_flctl.c                        |  14 +-
 drivers/net/can/grcan.c                            |  46 ++--
 drivers/net/ethernet/altera/altera_tse_main.c      |   6 +-
 drivers/net/ethernet/broadcom/Makefile             |   5 +
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c   |   9 +-
 drivers/net/ethernet/dec/tulip/tulip_core.c        |   5 +-
 drivers/net/ethernet/intel/igb/igb_main.c          |   3 +-
 drivers/net/ethernet/mediatek/mtk_eth_soc.c        |   3 +
 drivers/net/ethernet/mellanox/mlx4/en_ethtool.c    |   2 +-
 drivers/net/ethernet/qlogic/qla3xxx.c              |   3 +-
 drivers/net/ethernet/sfc/ef10.c                    |   5 +
 drivers/net/ethernet/smsc/smsc911x.c               |   2 +-
 drivers/net/ethernet/stmicro/stmmac/altr_tse_pcs.c |   8 +
 drivers/net/ethernet/stmicro/stmmac/altr_tse_pcs.h |   4 -
 .../net/ethernet/stmicro/stmmac/dwmac-socfpga.c    |  13 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c   |   4 +-
 drivers/net/ethernet/xilinx/xilinx_emaclite.c      |  15 +-
 drivers/net/hippi/rrunner.c                        |   2 +
 drivers/net/vmxnet3/vmxnet3_drv.c                  |   6 +
 drivers/net/wireless/ath/ath9k/ar9003_phy.h        |   2 +-
 drivers/net/wireless/ath/ath9k/htc_drv_txrx.c      |   8 +
 drivers/net/wireless/ath/carl9170/tx.c             |   3 +
 drivers/net/wireless/broadcom/b43/phy_n.c          |   2 +-
 drivers/net/wireless/broadcom/b43legacy/phy.c      |   2 +-
 drivers/net/wireless/intel/ipw2x00/libipw_tx.c     |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/power.c     |   3 +
 drivers/net/wireless/mac80211_hwsim.c              |   3 +
 drivers/net/wireless/marvell/mwifiex/11h.c         |   2 +
 drivers/net/wireless/realtek/rtl818x/rtl8180/dev.c |   8 +-
 drivers/nfc/nfcmrvl/main.c                         |   2 +-
 drivers/nfc/st21nfca/se.c                          |  15 +-
 drivers/nvme/host/pci.c                            |   1 +
 drivers/pci/host/pcie-qcom.c                       |   7 +-
 drivers/pci/pci.c                                  |  10 +-
 drivers/pcmcia/Kconfig                             |   2 +-
 drivers/phy/phy-exynos5250-sata.c                  |  21 +-
 drivers/pinctrl/pinctrl-pistachio.c                |   6 +-
 drivers/pwm/pwm-lp3943.c                           |   1 +
 drivers/regulator/pfuze100-regulator.c             |   2 +
 drivers/rpmsg/qcom_smd.c                           |   2 +-
 drivers/rtc/rtc-mt6397.c                           |   2 +
 drivers/s390/net/ctcm_mpc.c                        |   6 +-
 drivers/s390/net/ctcm_sysfs.c                      |   5 +-
 drivers/s390/net/lcs.c                             |   7 +-
 drivers/scsi/dc395x.c                              |  15 +-
 drivers/scsi/fcoe/fcoe_ctlr.c                      |   2 +-
 drivers/scsi/megaraid.c                            |   2 +-
 drivers/scsi/qla2xxx/qla_target.c                  |   3 +
 drivers/scsi/ufs/ufs-qcom.c                        |   7 +-
 drivers/soc/qcom/smp2p.c                           |   1 +
 drivers/soc/qcom/smsm.c                            |   1 +
 drivers/spi/spi-img-spfi.c                         |   2 +-
 drivers/spi/spi-ti-qspi.c                          |   5 +-
 drivers/staging/greybus/audio_codec.c              |   4 +-
 drivers/staging/rtl8192e/rtllib_softmac.c          |   2 +-
 drivers/staging/rtl8712/usb_intf.c                 |   6 +-
 drivers/tty/n_gsm.c                                |  40 ++--
 drivers/tty/serial/8250/8250_pci.c                 |   8 +-
 drivers/tty/serial/8250/8250_port.c                |   2 +-
 drivers/tty/serial/digicolor-usart.c               |   4 +-
 drivers/tty/serial/icom.c                          |   2 +-
 drivers/tty/serial/meson_uart.c                    |  13 ++
 drivers/tty/serial/msm_serial.c                    |   5 +
 drivers/tty/serial/sa1100.c                        |   4 +-
 drivers/tty/serial/serial_txx9.c                   |   2 +
 drivers/tty/serial/sh-sci.c                        |   6 +-
 drivers/tty/serial/st-asc.c                        |   4 +
 drivers/tty/synclink_gt.c                          |   2 +
 drivers/tty/tty_buffer.c                           |   3 +-
 drivers/usb/class/cdc-wdm.c                        |   1 +
 drivers/usb/core/hcd-pci.c                         |   4 +-
 drivers/usb/core/quirks.c                          |   9 +
 drivers/usb/dwc2/gadget.c                          |   1 -
 drivers/usb/gadget/configfs.c                      |   2 +
 drivers/usb/gadget/function/uvc_queue.c            |   2 +
 drivers/usb/host/isp116x-hcd.c                     |   6 +-
 drivers/usb/host/oxu210hp-hcd.c                    |   2 +
 drivers/usb/host/xhci.c                            |  11 +
 drivers/usb/misc/uss720.c                          |   3 +-
 drivers/usb/serial/cp210x.c                        |   2 +
 drivers/usb/serial/option.c                        |  16 ++
 drivers/usb/serial/pl2303.c                        |   1 +
 drivers/usb/serial/pl2303.h                        |   1 +
 drivers/usb/serial/qcserial.c                      |   2 +
 drivers/usb/serial/whiteheat.c                     |   5 +-
 drivers/usb/storage/karma.c                        |  15 +-
 drivers/usb/usbip/stub_dev.c                       |   2 +-
 drivers/usb/usbip/stub_rx.c                        |   2 +
 drivers/vhost/vringh.c                             |  10 +-
 drivers/video/fbdev/amba-clcd.c                    |   5 +-
 drivers/video/fbdev/pxa3xx-gcu.c                   |  12 +-
 fs/btrfs/disk-io.c                                 |   4 +-
 fs/btrfs/tree-log.c                                |  14 +-
 fs/cifs/smb2pdu.c                                  |   3 +
 fs/dlm/lock.c                                      |  11 +-
 fs/dlm/plock.c                                     |  12 +-
 fs/exec.c                                          |  17 ++
 fs/ext4/inline.c                                   |  12 +
 fs/ext4/namei.c                                    |  62 ++++--
 fs/fat/fatent.c                                    |   7 +-
 fs/fs-writeback.c                                  |  13 +-
 fs/jffs2/fs.c                                      |   1 +
 fs/jfs/jfs_dmap.c                                  |   3 +-
 fs/nfsd/nfs4state.c                                |  12 +-
 fs/notify/fdinfo.c                                 |  11 +-
 fs/notify/inotify/inotify.h                        |  12 +
 fs/notify/inotify/inotify_user.c                   |   2 +-
 fs/ocfs2/dlmfs/userdlm.c                           |  16 +-
 include/drm/drm_edid.h                             |   6 +-
 include/linux/cpu.h                                |   4 +
 include/linux/kernel.h                             |   2 +-
 include/linux/mtd/cfi.h                            |   1 +
 include/linux/netdev_features.h                    |   4 +-
 include/linux/nodemask.h                           |  51 +++--
 include/linux/ptrace.h                             |   6 -
 include/net/bluetooth/hci_core.h                   |   3 +
 include/net/tcp.h                                  |   1 +
 include/scsi/libfcoe.h                             |   3 +-
 include/sound/jack.h                               |   1 +
 kernel/events/core.c                               |  14 ++
 kernel/ptrace.c                                    |   5 +-
 kernel/signal.c                                    |   4 +-
 kernel/trace/trace.c                               |   7 +
 lib/assoc_array.c                                  |   8 +
 lib/dma-debug.c                                    |   2 +-
 lib/hexdump.c                                      |  41 +++-
 lib/nlattr.c                                       |   2 +-
 lib/nodemask.c                                     |   4 +-
 localversion-rt                                    |   2 +-
 mm/hugetlb.c                                       |   9 +-
 mm/userfaultfd.c                                   |   3 +
 net/bluetooth/hci_core.c                           |   6 +-
 net/bluetooth/sco.c                                |  21 +-
 net/core/filter.c                                  |   4 +-
 net/ipv4/igmp.c                                    |   9 +-
 net/ipv4/ip_gre.c                                  |   8 +-
 net/ipv4/ping.c                                    |  12 +-
 net/ipv4/route.c                                   |   1 +
 net/ipv4/tcp_input.c                               |  23 +-
 net/ipv4/tcp_output.c                              |   5 +-
 net/ipv4/xfrm4_protocol.c                          |   1 -
 net/ipv6/addrconf.c                                |  11 +-
 net/key/af_key.c                                   |  10 +-
 net/mac80211/chan.c                                |   7 +-
 net/mac80211/ieee80211_i.h                         |   5 +
 net/mac80211/rx.c                                  |   3 +-
 net/mac80211/scan.c                                |  20 ++
 net/netfilter/nf_tables_api.c                      |  16 +-
 net/netfilter/nft_dynset.c                         |   3 -
 net/netlink/af_netlink.c                           |   1 -
 net/nfc/core.c                                     |  30 +--
 net/nfc/nci/data.c                                 |   2 +-
 net/nfc/nci/hci.c                                  |   4 +-
 net/nfc/netlink.c                                  |   4 +-
 net/rxrpc/call_event.c                             |   3 +-
 net/rxrpc/sendmsg.c                                |   6 +
 net/rxrpc/sysctl.c                                 |   4 +-
 net/sched/cls_api.c                                |   5 +-
 net/sctp/input.c                                   |   4 +-
 net/sunrpc/xdr.c                                   |   6 +-
 net/sunrpc/xprtsock.c                              |   3 -
 scripts/mod/modpost.c                              |   5 +-
 sound/core/jack.c                                  |  34 ++-
 sound/firewire/fireworks/fireworks_hwdep.c         |   1 +
 sound/isa/wavefront/wavefront_synth.c              |   3 +-
 sound/pci/hda/patch_conexant.c                     |   7 +
 sound/soc/codecs/max98090.c                        |   5 +-
 sound/soc/codecs/rt5514.c                          |   2 +-
 sound/soc/codecs/rt5645.c                          |   6 +
 sound/soc/codecs/wm2000.c                          |   6 +-
 sound/soc/codecs/wm8731.c                          |  19 +-
 sound/soc/codecs/wm8958-dsp2.c                     |   8 +-
 sound/soc/mediatek/mt8173/mt8173-max98090.c        |   5 +-
 sound/soc/mxs/mxs-saif.c                           |   1 +
 sound/soc/soc-dapm.c                               |   2 -
 sound/soc/soc-generic-dmaengine-pcm.c              |   6 +-
 sound/soc/soc-ops.c                                |  18 +-
 tools/perf/bench/numa.c                            |   2 +-
 314 files changed, 2217 insertions(+), 754 deletions(-)
---
diff --git a/Documentation/ABI/testing/sysfs-ata b/Documentation/ABI/testing/sysfs-ata
index aa4296498859..c5dda2bc477d 100644
--- a/Documentation/ABI/testing/sysfs-ata
+++ b/Documentation/ABI/testing/sysfs-ata
@@ -59,17 +59,18 @@ class
 
 dma_mode
 
-	Transfer modes supported by the device when in DMA mode.
+	DMA transfer mode used by the device.
 	Mostly used by PATA device.
 
 pio_mode
 
-	Transfer modes supported by the device when in PIO mode.
+	PIO transfer mode used by the device.
 	Mostly used by PATA device.
 
 xfer_mode
 
 	Current transfer mode.
+	Mostly used by PATA device.
 
 id
 
diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index a5225df4a070..22c078d1a23b 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -361,6 +361,7 @@ What:		/sys/devices/system/cpu/vulnerabilities
 		/sys/devices/system/cpu/vulnerabilities/srbds
 		/sys/devices/system/cpu/vulnerabilities/tsx_async_abort
 		/sys/devices/system/cpu/vulnerabilities/itlb_multihit
+		/sys/devices/system/cpu/vulnerabilities/mmio_stale_data
 Date:		January 2018
 Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
 Description:	Information about CPU vulnerabilities
diff --git a/Documentation/conf.py b/Documentation/conf.py
index da7b54388eff..6818dfbeac7f 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -96,7 +96,7 @@ finally:
 #
 # This is also used if you do content translation via gettext catalogs.
 # Usually you set "language" from the command line for these cases.
-language = None
+language = 'en'
 
 # There are two options for replacing |today|: either, you set today to some
 # non-false value, then it is used:
diff --git a/Documentation/devicetree/bindings/gpio/gpio-altera.txt b/Documentation/devicetree/bindings/gpio/gpio-altera.txt
index 826a7208ca93..184ecd6bc39d 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-altera.txt
+++ b/Documentation/devicetree/bindings/gpio/gpio-altera.txt
@@ -9,8 +9,9 @@ Required properties:
   - The second cell is reserved and is currently unused.
 - gpio-controller : Marks the device node as a GPIO controller.
 - interrupt-controller: Mark the device node as an interrupt controller
-- #interrupt-cells : Should be 1. The interrupt type is fixed in the hardware.
+- #interrupt-cells : Should be 2. The interrupt type is fixed in the hardware.
   - The first cell is the GPIO offset number within the GPIO controller.
+  - The second cell is the interrupt trigger type and level flags.
 - interrupts: Specify the interrupt.
 - altr,interrupt-type: Specifies the interrupt trigger type the GPIO
   hardware is synthesized. This field is required if the Altera GPIO controller
@@ -38,6 +39,6 @@ gpio_altr: gpio@0xff200000 {
 	altr,interrupt-type = <IRQ_TYPE_EDGE_RISING>;
 	#gpio-cells = <2>;
 	gpio-controller;
-	#interrupt-cells = <1>;
+	#interrupt-cells = <2>;
 	interrupt-controller;
 };
diff --git a/Documentation/hw-vuln/index.rst b/Documentation/hw-vuln/index.rst
index 74466ba80167..608afc966776 100644
--- a/Documentation/hw-vuln/index.rst
+++ b/Documentation/hw-vuln/index.rst
@@ -15,3 +15,4 @@ are configurable at compile, boot or run time.
    tsx_async_abort
    multihit
    special-register-buffer-data-sampling
+   processor_mmio_stale_data
diff --git a/Documentation/hw-vuln/processor_mmio_stale_data.rst b/Documentation/hw-vuln/processor_mmio_stale_data.rst
new file mode 100644
index 000000000000..9393c50b5afc
--- /dev/null
+++ b/Documentation/hw-vuln/processor_mmio_stale_data.rst
@@ -0,0 +1,246 @@
+=========================================
+Processor MMIO Stale Data Vulnerabilities
+=========================================
+
+Processor MMIO Stale Data Vulnerabilities are a class of memory-mapped I/O
+(MMIO) vulnerabilities that can expose data. The sequences of operations for
+exposing data range from simple to very complex. Because most of the
+vulnerabilities require the attacker to have access to MMIO, many environments
+are not affected. System environments using virtualization where MMIO access is
+provided to untrusted guests may need mitigation. These vulnerabilities are
+not transient execution attacks. However, these vulnerabilities may propagate
+stale data into core fill buffers where the data can subsequently be inferred
+by an unmitigated transient execution attack. Mitigation for these
+vulnerabilities includes a combination of microcode update and software
+changes, depending on the platform and usage model. Some of these mitigations
+are similar to those used to mitigate Microarchitectural Data Sampling (MDS) or
+those used to mitigate Special Register Buffer Data Sampling (SRBDS).
+
+Data Propagators
+================
+Propagators are operations that result in stale data being copied or moved from
+one microarchitectural buffer or register to another. Processor MMIO Stale Data
+Vulnerabilities are operations that may result in stale data being directly
+read into an architectural, software-visible state or sampled from a buffer or
+register.
+
+Fill Buffer Stale Data Propagator (FBSDP)
+-----------------------------------------
+Stale data may propagate from fill buffers (FB) into the non-coherent portion
+of the uncore on some non-coherent writes. Fill buffer propagation by itself
+does not make stale data architecturally visible. Stale data must be propagated
+to a location where it is subject to reading or sampling.
+
+Sideband Stale Data Propagator (SSDP)
+-------------------------------------
+The sideband stale data propagator (SSDP) is limited to the client (including
+Intel Xeon server E3) uncore implementation. The sideband response buffer is
+shared by all client cores. For non-coherent reads that go to sideband
+destinations, the uncore logic returns 64 bytes of data to the core, including
+both requested data and unrequested stale data, from a transaction buffer and
+the sideband response buffer. As a result, stale data from the sideband
+response and transaction buffers may now reside in a core fill buffer.
+
+Primary Stale Data Propagator (PSDP)
+------------------------------------
+The primary stale data propagator (PSDP) is limited to the client (including
+Intel Xeon server E3) uncore implementation. Similar to the sideband response
+buffer, the primary response buffer is shared by all client cores. For some
+processors, MMIO primary reads will return 64 bytes of data to the core fill
+buffer including both requested data and unrequested stale data. This is
+similar to the sideband stale data propagator.
+
+Vulnerabilities
+===============
+Device Register Partial Write (DRPW) (CVE-2022-21166)
+-----------------------------------------------------
+Some endpoint MMIO registers incorrectly handle writes that are smaller than
+the register size. Instead of aborting the write or only copying the correct
+subset of bytes (for example, 2 bytes for a 2-byte write), more bytes than
+specified by the write transaction may be written to the register. On
+processors affected by FBSDP, this may expose stale data from the fill buffers
+of the core that created the write transaction.
+
+Shared Buffers Data Sampling (SBDS) (CVE-2022-21125)
+----------------------------------------------------
+After propagators may have moved data around the uncore and copied stale data
+into client core fill buffers, processors affected by MFBDS can leak data from
+the fill buffer. It is limited to the client (including Intel Xeon server E3)
+uncore implementation.
+
+Shared Buffers Data Read (SBDR) (CVE-2022-21123)
+------------------------------------------------
+It is similar to Shared Buffer Data Sampling (SBDS) except that the data is
+directly read into the architectural software-visible state. It is limited to
+the client (including Intel Xeon server E3) uncore implementation.
+
+Affected Processors
+===================
+Not all the CPUs are affected by all the variants. For instance, most
+processors for the server market (excluding Intel Xeon E3 processors) are
+impacted by only Device Register Partial Write (DRPW).
+
+Below is the list of affected Intel processors [#f1]_:
+
+   ===================  ============  =========
+   Common name          Family_Model  Steppings
+   ===================  ============  =========
+   HASWELL_X            06_3FH        2,4
+   SKYLAKE_L            06_4EH        3
+   BROADWELL_X          06_4FH        All
+   SKYLAKE_X            06_55H        3,4,6,7,11
+   BROADWELL_D          06_56H        3,4,5
+   SKYLAKE              06_5EH        3
+   ICELAKE_X            06_6AH        4,5,6
+   ICELAKE_D            06_6CH        1
+   ICELAKE_L            06_7EH        5
+   ATOM_TREMONT_D       06_86H        All
+   LAKEFIELD            06_8AH        1
+   KABYLAKE_L           06_8EH        9 to 12
+   ATOM_TREMONT         06_96H        1
+   ATOM_TREMONT_L       06_9CH        0
+   KABYLAKE             06_9EH        9 to 13
+   COMETLAKE            06_A5H        2,3,5
+   COMETLAKE_L          06_A6H        0,1
+   ROCKETLAKE           06_A7H        1
+   ===================  ============  =========
+
+If a CPU is in the affected processor list, but not affected by a variant, it
+is indicated by new bits in MSR IA32_ARCH_CAPABILITIES. As described in a later
+section, mitigation largely remains the same for all the variants, i.e. to
+clear the CPU fill buffers via VERW instruction.
+
+New bits in MSRs
+================
+Newer processors and microcode update on existing affected processors added new
+bits to IA32_ARCH_CAPABILITIES MSR. These bits can be used to enumerate
+specific variants of Processor MMIO Stale Data vulnerabilities and mitigation
+capability.
+
+MSR IA32_ARCH_CAPABILITIES
+--------------------------
+Bit 13 - SBDR_SSDP_NO - When set, processor is not affected by either the
+	 Shared Buffers Data Read (SBDR) vulnerability or the sideband stale
+	 data propagator (SSDP).
+Bit 14 - FBSDP_NO - When set, processor is not affected by the Fill Buffer
+	 Stale Data Propagator (FBSDP).
+Bit 15 - PSDP_NO - When set, processor is not affected by Primary Stale Data
+	 Propagator (PSDP).
+Bit 17 - FB_CLEAR - When set, VERW instruction will overwrite CPU fill buffer
+	 values as part of MD_CLEAR operations. Processors that do not
+	 enumerate MDS_NO (meaning they are affected by MDS) but that do
+	 enumerate support for both L1D_FLUSH and MD_CLEAR implicitly enumerate
+	 FB_CLEAR as part of their MD_CLEAR support.
+Bit 18 - FB_CLEAR_CTRL - Processor supports read and write to MSR
+	 IA32_MCU_OPT_CTRL[FB_CLEAR_DIS]. On such processors, the FB_CLEAR_DIS
+	 bit can be set to cause the VERW instruction to not perform the
+	 FB_CLEAR action. Not all processors that support FB_CLEAR will support
+	 FB_CLEAR_CTRL.
+
+MSR IA32_MCU_OPT_CTRL
+---------------------
+Bit 3 - FB_CLEAR_DIS - When set, VERW instruction does not perform the FB_CLEAR
+action. This may be useful to reduce the performance impact of FB_CLEAR in
+cases where system software deems it warranted (for example, when performance
+is more critical, or the untrusted software has no MMIO access). Note that
+FB_CLEAR_DIS has no impact on enumeration (for example, it does not change
+FB_CLEAR or MD_CLEAR enumeration) and it may not be supported on all processors
+that enumerate FB_CLEAR.
+
+Mitigation
+==========
+Like MDS, all variants of Processor MMIO Stale Data vulnerabilities  have the
+same mitigation strategy to force the CPU to clear the affected buffers before
+an attacker can extract the secrets.
+
+This is achieved by using the otherwise unused and obsolete VERW instruction in
+combination with a microcode update. The microcode clears the affected CPU
+buffers when the VERW instruction is executed.
+
+Kernel reuses the MDS function to invoke the buffer clearing:
+
+	mds_clear_cpu_buffers()
+
+On MDS affected CPUs, the kernel already invokes CPU buffer clear on
+kernel/userspace, hypervisor/guest and C-state (idle) transitions. No
+additional mitigation is needed on such CPUs.
+
+For CPUs not affected by MDS or TAA, mitigation is needed only for the attacker
+with MMIO capability. Therefore, VERW is not required for kernel/userspace. For
+virtualization case, VERW is only needed at VMENTER for a guest with MMIO
+capability.
+
+Mitigation points
+-----------------
+Return to user space
+^^^^^^^^^^^^^^^^^^^^
+Same mitigation as MDS when affected by MDS/TAA, otherwise no mitigation
+needed.
+
+C-State transition
+^^^^^^^^^^^^^^^^^^
+Control register writes by CPU during C-state transition can propagate data
+from fill buffer to uncore buffers. Execute VERW before C-state transition to
+clear CPU fill buffers.
+
+Guest entry point
+^^^^^^^^^^^^^^^^^
+Same mitigation as MDS when processor is also affected by MDS/TAA, otherwise
+execute VERW at VMENTER only for MMIO capable guests. On CPUs not affected by
+MDS/TAA, guest without MMIO access cannot extract secrets using Processor MMIO
+Stale Data vulnerabilities, so there is no need to execute VERW for such guests.
+
+Mitigation control on the kernel command line
+---------------------------------------------
+The kernel command line allows to control the Processor MMIO Stale Data
+mitigations at boot time with the option "mmio_stale_data=". The valid
+arguments for this option are:
+
+  ==========  =================================================================
+  full        If the CPU is vulnerable, enable mitigation; CPU buffer clearing
+              on exit to userspace and when entering a VM. Idle transitions are
+              protected as well. It does not automatically disable SMT.
+  full,nosmt  Same as full, with SMT disabled on vulnerable CPUs. This is the
+              complete mitigation.
+  off         Disables mitigation completely.
+  ==========  =================================================================
+
+If the CPU is affected and mmio_stale_data=off is not supplied on the kernel
+command line, then the kernel selects the appropriate mitigation.
+
+Mitigation status information
+-----------------------------
+The Linux kernel provides a sysfs interface to enumerate the current
+vulnerability status of the system: whether the system is vulnerable, and
+which mitigations are active. The relevant sysfs file is:
+
+	/sys/devices/system/cpu/vulnerabilities/mmio_stale_data
+
+The possible values in this file are:
+
+  .. list-table::
+
+     * - 'Not affected'
+       - The processor is not vulnerable
+     * - 'Vulnerable'
+       - The processor is vulnerable, but no mitigation enabled
+     * - 'Vulnerable: Clear CPU buffers attempted, no microcode'
+       - The processor is vulnerable, but microcode is not updated. The
+         mitigation is enabled on a best effort basis.
+     * - 'Mitigation: Clear CPU buffers'
+       - The processor is vulnerable and the CPU buffer clearing mitigation is
+         enabled.
+
+If the processor is vulnerable then the following information is appended to
+the above information:
+
+  ========================  ===========================================
+  'SMT vulnerable'          SMT is enabled
+  'SMT disabled'            SMT is disabled
+  'SMT Host state unknown'  Kernel runs in a VM, Host SMT state unknown
+  ========================  ===========================================
+
+References
+----------
+.. [#f1] Affected Processors
+   https://www.intel.com/content/www/us/en/developer/topic-technology/software-security-guidance/processors-affected-consolidated-product-cpu-model.html
diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index f2b10986ab88..97c0ff0787ea 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -2520,6 +2520,7 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 					       kvm.nx_huge_pages=off [X86]
 					       no_entry_flush [PPC]
 					       no_uaccess_flush [PPC]
+					       mmio_stale_data=off [X86]
 
 				Exceptions:
 					       This does not have any effect on
@@ -2541,6 +2542,7 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 				Equivalent to: l1tf=flush,nosmt [X86]
 					       mds=full,nosmt [X86]
 					       tsx_async_abort=full,nosmt [X86]
+					       mmio_stale_data=full,nosmt [X86]
 
 	mminit_loglevel=
 			[KNL] When CONFIG_DEBUG_MEMORY_INIT is set, this
@@ -2550,6 +2552,40 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 			log everything. Information is printed at KERN_DEBUG
 			so loglevel=8 may also need to be specified.
 
+	mmio_stale_data=
+			[X86,INTEL] Control mitigation for the Processor
+			MMIO Stale Data vulnerabilities.
+
+			Processor MMIO Stale Data is a class of
+			vulnerabilities that may expose data after an MMIO
+			operation. Exposed data could originate or end in
+			the same CPU buffers as affected by MDS and TAA.
+			Therefore, similar to MDS and TAA, the mitigation
+			is to clear the affected CPU buffers.
+
+			This parameter controls the mitigation. The
+			options are:
+
+			full       - Enable mitigation on vulnerable CPUs
+
+			full,nosmt - Enable mitigation and disable SMT on
+				     vulnerable CPUs.
+
+			off        - Unconditionally disable mitigation
+
+			On MDS or TAA affected machines,
+			mmio_stale_data=off can be prevented by an active
+			MDS or TAA mitigation as these vulnerabilities are
+			mitigated with the same mechanism so in order to
+			disable this mitigation, you need to specify
+			mds=off and tsx_async_abort=off too.
+
+			Not specifying this option is equivalent to
+			mmio_stale_data=full.
+
+			For details see:
+			Documentation/admin-guide/hw-vuln/processor_mmio_stale_data.rst
+
 	module.sig_enforce
 			[KNL] When CONFIG_MODULE_SIG is set, this means that
 			modules without (valid) signatures will fail to load.
diff --git a/Makefile b/Makefile
index a9f16c9c9614..bf4a7b0fe8e7 100644
--- a/Makefile
+++ b/Makefile
@@ -1,6 +1,6 @@
 VERSION = 4
 PATCHLEVEL = 9
-SUBLEVEL = 312
+SUBLEVEL = 319
 EXTRAVERSION =
 NAME = Roaring Lionus
 
diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
index 54e79f6887ff..3dda0569f86a 100644
--- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
+++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
@@ -129,7 +129,7 @@
 	samsung,i2c-max-bus-freq = <20000>;
 
 	eeprom@50 {
-		compatible = "samsung,s524ad0xd1";
+		compatible = "samsung,s524ad0xd1", "atmel,24c128";
 		reg = <0x50>;
 	};
 
@@ -288,7 +288,7 @@
 	samsung,i2c-max-bus-freq = <20000>;
 
 	eeprom@51 {
-		compatible = "samsung,s524ad0xd1";
+		compatible = "samsung,s524ad0xd1", "atmel,24c128";
 		reg = <0x51>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6qdl-apalis.dtsi b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
index 99e323b57261..cbe7b0dcb6eb 100644
--- a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
@@ -324,6 +324,8 @@
 	codec: sgtl5000@0a {
 		compatible = "fsl,sgtl5000";
 		reg = <0x0a>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_sgtl5000>;
 		clocks = <&clks IMX6QDL_CLK_CKO>;
 		VDDA-supply = <&reg_2p5v>;
 		VDDIO-supply = <&reg_3p3v>;
@@ -550,8 +552,6 @@
 			MX6QDL_PAD_DISP0_DAT21__AUD4_TXD	0x130b0
 			MX6QDL_PAD_DISP0_DAT22__AUD4_TXFS	0x130b0
 			MX6QDL_PAD_DISP0_DAT23__AUD4_RXD	0x130b0
-			/* SGTL5000 sys_mclk */
-			MX6QDL_PAD_GPIO_5__CCM_CLKO1		0x130b0
 		>;
 	};
 
@@ -812,6 +812,12 @@
 		>;
 	};
 
+	pinctrl_sgtl5000: sgtl5000grp {
+		fsl,pins = <
+			MX6QDL_PAD_GPIO_5__CCM_CLKO1	0x130b0
+		>;
+	};
+
 	pinctrl_spdif: spdifgrp {
 		fsl,pins = <
 			MX6QDL_PAD_GPIO_16__SPDIF_IN  0x1b0b0
diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index 338ee6bd0e0c..ced298d07338 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -29,6 +29,8 @@
 	aliases {
 		display0 = &lcd;
 		display1 = &tv0;
+		/delete-property/ mmc2;
+		/delete-property/ mmc3;
 	};
 
 	gpio-keys {
diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index 4a554d1c45c1..965ccfda6ccd 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -1087,7 +1087,7 @@ vector_bhb_loop8_\name:
 
 	@ bhb workaround
 	mov	r0, #8
-3:	b	. + 4
+3:	W(b)	. + 4
 	subs	r0, r0, #1
 	bne	3b
 	dsb
diff --git a/arch/arm/kernel/stacktrace.c b/arch/arm/kernel/stacktrace.c
index c10c1de244eb..83d0aa217bb2 100644
--- a/arch/arm/kernel/stacktrace.c
+++ b/arch/arm/kernel/stacktrace.c
@@ -50,17 +50,17 @@ int notrace unwind_frame(struct stackframe *frame)
 		return -EINVAL;
 
 	frame->sp = frame->fp;
-	frame->fp = *(unsigned long *)(fp);
-	frame->pc = *(unsigned long *)(fp + 4);
+	frame->fp = READ_ONCE_NOCHECK(*(unsigned long *)(fp));
+	frame->pc = READ_ONCE_NOCHECK(*(unsigned long *)(fp + 4));
 #else
 	/* check current frame pointer is within bounds */
 	if (fp < low + 12 || fp > high - 4)
 		return -EINVAL;
 
 	/* restore the registers from the stack frame */
-	frame->fp = *(unsigned long *)(fp - 12);
-	frame->sp = *(unsigned long *)(fp - 8);
-	frame->pc = *(unsigned long *)(fp - 4);
+	frame->fp = READ_ONCE_NOCHECK(*(unsigned long *)(fp - 12));
+	frame->sp = READ_ONCE_NOCHECK(*(unsigned long *)(fp - 8));
+	frame->pc = READ_ONCE_NOCHECK(*(unsigned long *)(fp - 4));
 #endif
 
 	return 0;
diff --git a/arch/arm/mach-hisi/platsmp.c b/arch/arm/mach-hisi/platsmp.c
index e1d67648d5d0..fccceab33325 100644
--- a/arch/arm/mach-hisi/platsmp.c
+++ b/arch/arm/mach-hisi/platsmp.c
@@ -70,14 +70,17 @@ static void __init hi3xxx_smp_prepare_cpus(unsigned int max_cpus)
 		}
 		ctrl_base = of_iomap(np, 0);
 		if (!ctrl_base) {
+			of_node_put(np);
 			pr_err("failed to map address\n");
 			return;
 		}
 		if (of_property_read_u32(np, "smp-offset", &offset) < 0) {
+			of_node_put(np);
 			pr_err("failed to find smp-offset property\n");
 			return;
 		}
 		ctrl_base += offset;
+		of_node_put(np);
 	}
 }
 
@@ -163,6 +166,7 @@ static int hip01_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	if (WARN_ON(!node))
 		return -1;
 	ctrl_base = of_iomap(node, 0);
+	of_node_put(node);
 
 	/* set the secondary core boot from DDR */
 	remap_reg_value = readl_relaxed(ctrl_base + REG_SC_CTRL);
diff --git a/arch/arm/mach-omap1/clock.c b/arch/arm/mach-omap1/clock.c
index 034b89499bd7..a3599696e7cc 100644
--- a/arch/arm/mach-omap1/clock.c
+++ b/arch/arm/mach-omap1/clock.c
@@ -44,7 +44,7 @@ static DEFINE_SPINLOCK(clockfw_lock);
 unsigned long omap1_uart_recalc(struct clk *clk)
 {
 	unsigned int val = __raw_readl(clk->enable_reg);
-	return val & clk->enable_bit ? 48000000 : 12000000;
+	return val & 1 << clk->enable_bit ? 48000000 : 12000000;
 }
 
 unsigned long omap1_sossi_recalc(struct clk *clk)
diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index e5dcbda20129..7fff67ea7bcd 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -342,10 +342,12 @@ void __init omap_gic_of_init(void)
 
 	np = of_find_compatible_node(NULL, NULL, "arm,cortex-a9-gic");
 	gic_dist_base_addr = of_iomap(np, 0);
+	of_node_put(np);
 	WARN_ON(!gic_dist_base_addr);
 
 	np = of_find_compatible_node(NULL, NULL, "arm,cortex-a9-twd-timer");
 	twd_base = of_iomap(np, 0);
+	of_node_put(np);
 	WARN_ON(!twd_base);
 
 skip_errata_init:
diff --git a/arch/arm/mach-vexpress/dcscb.c b/arch/arm/mach-vexpress/dcscb.c
index 5cedcf572104..3e86cff1d4d3 100644
--- a/arch/arm/mach-vexpress/dcscb.c
+++ b/arch/arm/mach-vexpress/dcscb.c
@@ -146,6 +146,7 @@ static int __init dcscb_init(void)
 	if (!node)
 		return -ENODEV;
 	dcscb_base = of_iomap(node, 0);
+	of_node_put(node);
 	if (!dcscb_base)
 		return -EADDRNOTAVAIL;
 	cfg = readl_relaxed(dcscb_base + DCS_CFG_R);
diff --git a/arch/arm/mm/proc-v7-bugs.c b/arch/arm/mm/proc-v7-bugs.c
index 1b6e770bc1cd..8b78694d56b8 100644
--- a/arch/arm/mm/proc-v7-bugs.c
+++ b/arch/arm/mm/proc-v7-bugs.c
@@ -297,6 +297,7 @@ void cpu_v7_ca15_ibe(void)
 {
 	if (check_spectre_auxcr(this_cpu_ptr(&spectre_warned), BIT(0)))
 		cpu_v7_spectre_v2_init();
+	cpu_v7_spectre_bhb_init();
 }
 
 void cpu_v7_bugs_init(void)
diff --git a/arch/m68k/Kconfig.cpu b/arch/m68k/Kconfig.cpu
index d2219f30b78f..2268d19cc915 100644
--- a/arch/m68k/Kconfig.cpu
+++ b/arch/m68k/Kconfig.cpu
@@ -307,7 +307,7 @@ comment "Processor Specific Options"
 
 config M68KFPU_EMU
 	bool "Math emulation support"
-	depends on MMU
+	depends on M68KCLASSIC && FPU
 	help
 	  At some point in the future, this will cause floating-point math
 	  instructions to be emulated by the kernel on machines that lack a
diff --git a/arch/m68k/Kconfig.machine b/arch/m68k/Kconfig.machine
index f622c3ccafc3..9f2896493ca0 100644
--- a/arch/m68k/Kconfig.machine
+++ b/arch/m68k/Kconfig.machine
@@ -302,6 +302,7 @@ comment "Machine Options"
 
 config UBOOT
 	bool "Support for U-Boot command line parameters"
+	depends on COLDFIRE
 	help
 	  If you say Y here kernel will try to collect command
 	  line parameters from the initial u-boot stack.
diff --git a/arch/m68k/include/asm/pgtable_no.h b/arch/m68k/include/asm/pgtable_no.h
index ac7d87a02335..269443e1084b 100644
--- a/arch/m68k/include/asm/pgtable_no.h
+++ b/arch/m68k/include/asm/pgtable_no.h
@@ -41,7 +41,8 @@ extern void paging_init(void);
  * ZERO_PAGE is a global shared page that is always zero: used
  * for zero-mapped memory areas etc..
  */
-#define ZERO_PAGE(vaddr)	(virt_to_page(0))
+extern void *empty_zero_page;
+#define ZERO_PAGE(vaddr)	(virt_to_page(empty_zero_page))
 
 /*
  * No page table caches to initialise.
diff --git a/arch/mips/bmips/setup.c b/arch/mips/bmips/setup.c
index 3b6f687f177c..32f8c501f6cb 100644
--- a/arch/mips/bmips/setup.c
+++ b/arch/mips/bmips/setup.c
@@ -174,7 +174,7 @@ void __init plat_mem_setup(void)
 		dtb = phys_to_virt(fw_arg2);
 	else if (fw_passed_dtb) /* UHI interface */
 		dtb = (void *)fw_passed_dtb;
-	else if (__dtb_start != __dtb_end)
+	else if (&__dtb_start != &__dtb_end)
 		dtb = (void *)__dtb_start;
 	else
 		panic("no dtb found");
diff --git a/arch/mips/include/asm/mach-ip27/cpu-feature-overrides.h b/arch/mips/include/asm/mach-ip27/cpu-feature-overrides.h
index 7449794eade6..dff5c2885d15 100644
--- a/arch/mips/include/asm/mach-ip27/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-ip27/cpu-feature-overrides.h
@@ -28,7 +28,6 @@
 #define cpu_has_6k_cache		0
 #define cpu_has_8k_cache		0
 #define cpu_has_tx39_cache		0
-#define cpu_has_fpu			1
 #define cpu_has_nofpuex			0
 #define cpu_has_32fpr			1
 #define cpu_has_counter			1
diff --git a/arch/mips/include/asm/timex.h b/arch/mips/include/asm/timex.h
index b05bb70a2e46..8026baf46e72 100644
--- a/arch/mips/include/asm/timex.h
+++ b/arch/mips/include/asm/timex.h
@@ -40,9 +40,9 @@
 typedef unsigned int cycles_t;
 
 /*
- * On R4000/R4400 before version 5.0 an erratum exists such that if the
- * cycle counter is read in the exact moment that it is matching the
- * compare register, no interrupt will be generated.
+ * On R4000/R4400 an erratum exists such that if the cycle counter is
+ * read in the exact moment that it is matching the compare register,
+ * no interrupt will be generated.
  *
  * There is a suggested workaround and also the erratum can't strike if
  * the compare interrupt isn't being used as the clock source device.
@@ -63,7 +63,7 @@ static inline int can_use_mips_counter(unsigned int prid)
 	if (!__builtin_constant_p(cpu_has_counter))
 		asm volatile("" : "=m" (cpu_data[0].options));
 	if (likely(cpu_has_counter &&
-		   prid >= (PRID_IMP_R4000 | PRID_REV_ENCODE_44(5, 0))))
+		   prid > (PRID_IMP_R4000 | PRID_REV_ENCODE_44(15, 15))))
 		return 1;
 	else
 		return 0;
diff --git a/arch/mips/kernel/time.c b/arch/mips/kernel/time.c
index b15ee1258668..1d6998933788 100644
--- a/arch/mips/kernel/time.c
+++ b/arch/mips/kernel/time.c
@@ -168,15 +168,10 @@ static __init int cpu_has_mfc0_count_bug(void)
 	case CPU_R4400MC:
 		/*
 		 * The published errata for the R4400 up to 3.0 say the CPU
-		 * has the mfc0 from count bug.
+		 * has the mfc0 from count bug.  This seems the last version
+		 * produced.
 		 */
-		if ((current_cpu_data.processor_id & 0xff) <= 0x30)
-			return 1;
-
-		/*
-		 * we assume newer revisions are ok
-		 */
-		return 0;
+		return 1;
 	}
 
 	return 0;
diff --git a/arch/mips/lantiq/falcon/sysctrl.c b/arch/mips/lantiq/falcon/sysctrl.c
index 82bbd0e2e298..714d92659489 100644
--- a/arch/mips/lantiq/falcon/sysctrl.c
+++ b/arch/mips/lantiq/falcon/sysctrl.c
@@ -169,6 +169,8 @@ static inline void clkdev_add_sys(const char *dev, unsigned int module,
 {
 	struct clk *clk = kzalloc(sizeof(struct clk), GFP_KERNEL);
 
+	if (!clk)
+		return;
 	clk->cl.dev_id = dev;
 	clk->cl.con_id = NULL;
 	clk->cl.clk = clk;
diff --git a/arch/mips/lantiq/prom.c b/arch/mips/lantiq/prom.c
index 4cbb000e778e..9b30e46e91a7 100644
--- a/arch/mips/lantiq/prom.c
+++ b/arch/mips/lantiq/prom.c
@@ -76,7 +76,7 @@ void __init plat_mem_setup(void)
 
 	if (fw_passed_dtb) /* UHI interface */
 		dtb = (void *)fw_passed_dtb;
-	else if (__dtb_start != __dtb_end)
+	else if (&__dtb_start != &__dtb_end)
 		dtb = (void *)__dtb_start;
 	else
 		panic("no dtb found");
diff --git a/arch/mips/lantiq/xway/gptu.c b/arch/mips/lantiq/xway/gptu.c
index 0f1bbea1a816..955d0d5cfbdb 100644
--- a/arch/mips/lantiq/xway/gptu.c
+++ b/arch/mips/lantiq/xway/gptu.c
@@ -124,6 +124,8 @@ static inline void clkdev_add_gptu(struct device *dev, const char *con,
 {
 	struct clk *clk = kzalloc(sizeof(struct clk), GFP_KERNEL);
 
+	if (!clk)
+		return;
 	clk->cl.dev_id = dev_name(dev);
 	clk->cl.con_id = con;
 	clk->cl.clk = clk;
diff --git a/arch/mips/lantiq/xway/sysctrl.c b/arch/mips/lantiq/xway/sysctrl.c
index 95bec460b651..dd7c36a193e3 100644
--- a/arch/mips/lantiq/xway/sysctrl.c
+++ b/arch/mips/lantiq/xway/sysctrl.c
@@ -331,6 +331,8 @@ static void clkdev_add_pmu(const char *dev, const char *con, bool deactivate,
 {
 	struct clk *clk = kzalloc(sizeof(struct clk), GFP_KERNEL);
 
+	if (!clk)
+		return;
 	clk->cl.dev_id = dev;
 	clk->cl.con_id = con;
 	clk->cl.clk = clk;
@@ -354,6 +356,8 @@ static void clkdev_add_cgu(const char *dev, const char *con,
 {
 	struct clk *clk = kzalloc(sizeof(struct clk), GFP_KERNEL);
 
+	if (!clk)
+		return;
 	clk->cl.dev_id = dev;
 	clk->cl.con_id = con;
 	clk->cl.clk = clk;
@@ -372,24 +376,28 @@ static void clkdev_add_pci(void)
 	struct clk *clk_ext = kzalloc(sizeof(struct clk), GFP_KERNEL);
 
 	/* main pci clock */
-	clk->cl.dev_id = "17000000.pci";
-	clk->cl.con_id = NULL;
-	clk->cl.clk = clk;
-	clk->rate = CLOCK_33M;
-	clk->rates = valid_pci_rates;
-	clk->enable = pci_enable;
-	clk->disable = pmu_disable;
-	clk->module = 0;
-	clk->bits = PMU_PCI;
-	clkdev_add(&clk->cl);
+	if (clk) {
+		clk->cl.dev_id = "17000000.pci";
+		clk->cl.con_id = NULL;
+		clk->cl.clk = clk;
+		clk->rate = CLOCK_33M;
+		clk->rates = valid_pci_rates;
+		clk->enable = pci_enable;
+		clk->disable = pmu_disable;
+		clk->module = 0;
+		clk->bits = PMU_PCI;
+		clkdev_add(&clk->cl);
+	}
 
 	/* use internal/external bus clock */
-	clk_ext->cl.dev_id = "17000000.pci";
-	clk_ext->cl.con_id = "external";
-	clk_ext->cl.clk = clk_ext;
-	clk_ext->enable = pci_ext_enable;
-	clk_ext->disable = pci_ext_disable;
-	clkdev_add(&clk_ext->cl);
+	if (clk_ext) {
+		clk_ext->cl.dev_id = "17000000.pci";
+		clk_ext->cl.con_id = "external";
+		clk_ext->cl.clk = clk_ext;
+		clk_ext->enable = pci_ext_enable;
+		clk_ext->disable = pci_ext_disable;
+		clkdev_add(&clk_ext->cl);
+	}
 }
 
 /* xway socs can generate clocks on gpio pins */
@@ -409,9 +417,15 @@ static void clkdev_add_clkout(void)
 		char *name;
 
 		name = kzalloc(sizeof("clkout0"), GFP_KERNEL);
+		if (!name)
+			continue;
 		sprintf(name, "clkout%d", i);
 
 		clk = kzalloc(sizeof(struct clk), GFP_KERNEL);
+		if (!clk) {
+			kfree(name);
+			continue;
+		}
 		clk->cl.dev_id = "1f103000.cgu";
 		clk->cl.con_id = name;
 		clk->cl.clk = clk;
diff --git a/arch/mips/pic32/pic32mzda/init.c b/arch/mips/pic32/pic32mzda/init.c
index 51599710472b..406c6c5cec29 100644
--- a/arch/mips/pic32/pic32mzda/init.c
+++ b/arch/mips/pic32/pic32mzda/init.c
@@ -36,7 +36,7 @@ static ulong get_fdtaddr(void)
 	if (fw_passed_dtb && !fw_arg2 && !fw_arg3)
 		return (ulong)fw_passed_dtb;
 
-	if (__dtb_start < __dtb_end)
+	if (&__dtb_start < &__dtb_end)
 		ftaddr = (ulong)__dtb_start;
 
 	return ftaddr;
diff --git a/arch/openrisc/include/asm/timex.h b/arch/openrisc/include/asm/timex.h
index 9935cad1b9b9..34d015bf0462 100644
--- a/arch/openrisc/include/asm/timex.h
+++ b/arch/openrisc/include/asm/timex.h
@@ -27,6 +27,7 @@ static inline cycles_t get_cycles(void)
 {
 	return mfspr(SPR_TTCR);
 }
+#define get_cycles get_cycles
 
 /* This isn't really used any more */
 #define CLOCK_TICK_RATE 1000
diff --git a/arch/openrisc/kernel/head.S b/arch/openrisc/kernel/head.S
index 98dd6860bc0b..0b6be5b3522b 100644
--- a/arch/openrisc/kernel/head.S
+++ b/arch/openrisc/kernel/head.S
@@ -452,6 +452,15 @@ _start:
 	l.ori	r3,r0,0x1
 	l.mtspr	r0,r3,SPR_SR
 
+	/*
+	 * Start the TTCR as early as possible, so that the RNG can make use of
+	 * measurements of boot time from the earliest opportunity. Especially
+	 * important is that the TTCR does not return zero by the time we reach
+	 * rand_initialize().
+	 */
+	l.movhi r3,hi(SPR_TTMR_CR)
+	l.mtspr r0,r3,SPR_TTMR
+
 	CLEAR_GPR(r1)
 	CLEAR_GPR(r2)
 	CLEAR_GPR(r3)
diff --git a/arch/parisc/kernel/processor.c b/arch/parisc/kernel/processor.c
index 0c2a94a0f751..e31633dcb0f3 100644
--- a/arch/parisc/kernel/processor.c
+++ b/arch/parisc/kernel/processor.c
@@ -390,8 +390,7 @@ show_cpuinfo (struct seq_file *m, void *v)
 		}
 		seq_printf(m, " (0x%02lx)\n", boot_cpu_data.pdc.capabilities);
 
-		seq_printf(m, "model\t\t: %s\n"
-				"model name\t: %s\n",
+		seq_printf(m, "model\t\t: %s - %s\n",
 				 boot_cpu_data.pdc.sys_model_name,
 				 cpuinfo->dev ?
 				 cpuinfo->dev->name : "Unknown");
diff --git a/arch/powerpc/kernel/idle.c b/arch/powerpc/kernel/idle.c
index d7216c9abda1..ca79aacfeda2 100644
--- a/arch/powerpc/kernel/idle.c
+++ b/arch/powerpc/kernel/idle.c
@@ -41,7 +41,7 @@ static int __init powersave_off(char *arg)
 {
 	ppc_md.power_save = NULL;
 	cpuidle_disable = IDLE_POWERSAVE_OFF;
-	return 0;
+	return 1;
 }
 __setup("powersave=off", powersave_off);
 
diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 4f2829634d79..88947f5fd778 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -2938,8 +2938,13 @@ long arch_ptrace(struct task_struct *child, long request,
 
 			flush_fp_to_thread(child);
 			if (fpidx < (PT_FPSCR - PT_FPR0))
-				memcpy(&tmp, &child->thread.TS_FPR(fpidx),
-				       sizeof(long));
+				if (IS_ENABLED(CONFIG_PPC32)) {
+					// On 32-bit the index we are passed refers to 32-bit words
+					tmp = ((u32 *)child->thread.fp_state.fpr)[fpidx];
+				} else {
+					memcpy(&tmp, &child->thread.TS_FPR(fpidx),
+					       sizeof(long));
+				}
 			else
 				tmp = child->thread.fp_state.fpscr;
 		}
@@ -2971,8 +2976,13 @@ long arch_ptrace(struct task_struct *child, long request,
 
 			flush_fp_to_thread(child);
 			if (fpidx < (PT_FPSCR - PT_FPR0))
-				memcpy(&child->thread.TS_FPR(fpidx), &data,
-				       sizeof(long));
+				if (IS_ENABLED(CONFIG_PPC32)) {
+					// On 32-bit the index we are passed refers to 32-bit words
+					((u32 *)child->thread.fp_state.fpr)[fpidx] = data;
+				} else {
+					memcpy(&child->thread.TS_FPR(fpidx), &data,
+					       sizeof(long));
+				}
 			else
 				child->thread.fp_state.fpscr = data;
 			ret = 0;
diff --git a/arch/powerpc/sysdev/cpm1.c b/arch/powerpc/sysdev/cpm1.c
index 986cd111d4df..8f2dc4ea9376 100644
--- a/arch/powerpc/sysdev/cpm1.c
+++ b/arch/powerpc/sysdev/cpm1.c
@@ -290,6 +290,7 @@ cpm_setbrg(uint brg, uint rate)
 		out_be32(bp, (((BRG_UART_CLK_DIV16 / rate) - 1) << 1) |
 			      CPM_BRG_EN | CPM_BRG_DIV16);
 }
+EXPORT_SYMBOL(cpm_setbrg);
 
 struct cpm_ioport16 {
 	__be16 dir, par, odr_sor, dat, intr;
diff --git a/arch/powerpc/sysdev/ppc4xx_cpm.c b/arch/powerpc/sysdev/ppc4xx_cpm.c
index ba95adf81d8d..05047cf32dbb 100644
--- a/arch/powerpc/sysdev/ppc4xx_cpm.c
+++ b/arch/powerpc/sysdev/ppc4xx_cpm.c
@@ -341,6 +341,6 @@ late_initcall(cpm_init);
 static int __init cpm_powersave_off(char *arg)
 {
 	cpm.powersave_off = 1;
-	return 0;
+	return 1;
 }
 __setup("powersave=off", cpm_powersave_off);
diff --git a/arch/powerpc/sysdev/xics/icp-opal.c b/arch/powerpc/sysdev/xics/icp-opal.c
index b53f80f0b4d8..80a4fa6dcc55 100644
--- a/arch/powerpc/sysdev/xics/icp-opal.c
+++ b/arch/powerpc/sysdev/xics/icp-opal.c
@@ -199,6 +199,7 @@ int icp_opal_init(void)
 
 	printk("XICS: Using OPAL ICP fallbacks\n");
 
+	of_node_put(np);
 	return 0;
 }
 
diff --git a/arch/um/drivers/chan_user.c b/arch/um/drivers/chan_user.c
index feb7f5ab4084..cd7346d26b89 100644
--- a/arch/um/drivers/chan_user.c
+++ b/arch/um/drivers/chan_user.c
@@ -220,7 +220,7 @@ static int winch_tramp(int fd, struct tty_port *port, int *fd_out,
 		       unsigned long *stack_out)
 {
 	struct winch_data data;
-	int fds[2], n, err;
+	int fds[2], n, err, pid;
 	char c;
 
 	err = os_pipe(fds, 1, 1);
@@ -238,8 +238,9 @@ static int winch_tramp(int fd, struct tty_port *port, int *fd_out,
 	 * problem with /dev/net/tun, which if held open by this
 	 * thread, prevents the TUN/TAP device from being reused.
 	 */
-	err = run_helper_thread(winch_thread, &data, CLONE_FILES, stack_out);
-	if (err < 0) {
+	pid = run_helper_thread(winch_thread, &data, CLONE_FILES, stack_out);
+	if (pid < 0) {
+		err = pid;
 		printk(UM_KERN_ERR "fork of winch_thread failed - errno = %d\n",
 		       -err);
 		goto out_close;
@@ -263,7 +264,7 @@ static int winch_tramp(int fd, struct tty_port *port, int *fd_out,
 		goto out_close;
 	}
 
-	return err;
+	return pid;
 
  out_close:
 	close(fds[1]);
diff --git a/arch/x86/include/asm/acenv.h b/arch/x86/include/asm/acenv.h
index 1b010a859b8b..6de59a4f723c 100644
--- a/arch/x86/include/asm/acenv.h
+++ b/arch/x86/include/asm/acenv.h
@@ -16,7 +16,19 @@
 
 /* Asm macros */
 
-#define ACPI_FLUSH_CPU_CACHE()	wbinvd()
+/*
+ * ACPI_FLUSH_CPU_CACHE() flushes caches on entering sleep states.
+ * It is required to prevent data loss.
+ *
+ * While running inside virtual machine, the kernel can bypass cache flushing.
+ * Changing sleep state in a virtual machine doesn't affect the host system
+ * sleep state and cannot lead to data loss.
+ */
+#define ACPI_FLUSH_CPU_CACHE()					\
+do {								\
+	if (!cpu_feature_enabled(X86_FEATURE_HYPERVISOR))	\
+		wbinvd();					\
+} while (0)
 
 int __acpi_acquire_global_lock(unsigned int *lock);
 int __acpi_release_global_lock(unsigned int *lock);
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 5b197248d546..910304aec2e6 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -362,5 +362,6 @@
 #define X86_BUG_TAA			X86_BUG(22) /* CPU is affected by TSX Async Abort(TAA) */
 #define X86_BUG_ITLB_MULTIHIT		X86_BUG(23) /* CPU may incur MCE during certain page attribute changes */
 #define X86_BUG_SRBDS			X86_BUG(24) /* CPU may leak RNG bits if not mitigated */
+#define X86_BUG_MMIO_STALE_DATA		X86_BUG(25) /* CPU is affected by Processor MMIO Stale Data vulnerabilities */
 
 #endif /* _ASM_X86_CPUFEATURES_H */
diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 74ee597beb3e..8b6c01774ca2 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -9,6 +9,10 @@
  *
  * Things ending in "2" are usually because we have no better
  * name for them.  There's no processor called "SILVERMONT2".
+ *
+ * While adding a new CPUID for a new microarchitecture, add a new
+ * group to keep logically sorted out in chronological order. Within
+ * that group keep the CPUID for the variants sorted by model number.
  */
 
 #define INTEL_FAM6_CORE_YONAH		0x0E
@@ -48,6 +52,24 @@
 #define INTEL_FAM6_KABYLAKE_MOBILE	0x8E
 #define INTEL_FAM6_KABYLAKE_DESKTOP	0x9E
 
+#define INTEL_FAM6_CANNONLAKE_MOBILE	0x66
+
+#define INTEL_FAM6_ICELAKE_X		0x6A
+#define INTEL_FAM6_ICELAKE_XEON_D	0x6C
+#define INTEL_FAM6_ICELAKE_DESKTOP	0x7D
+#define INTEL_FAM6_ICELAKE_MOBILE	0x7E
+
+#define INTEL_FAM6_COMETLAKE		0xA5
+#define INTEL_FAM6_COMETLAKE_L		0xA6
+
+#define INTEL_FAM6_ROCKETLAKE		0xA7
+
+/* Hybrid Core/Atom Processors */
+
+#define	INTEL_FAM6_LAKEFIELD		0x8A
+#define INTEL_FAM6_ALDERLAKE		0x97
+#define INTEL_FAM6_ALDERLAKE_L		0x9A
+
 /* "Small Core" Processors (Atom) */
 
 #define INTEL_FAM6_ATOM_BONNELL		0x1C /* Diamondville, Pineview */
@@ -67,7 +89,10 @@
 #define INTEL_FAM6_ATOM_GOLDMONT	0x5C /* Apollo Lake */
 #define INTEL_FAM6_ATOM_GOLDMONT_X	0x5F /* Denverton */
 #define INTEL_FAM6_ATOM_GOLDMONT_PLUS	0x7A /* Gemini Lake */
+
 #define INTEL_FAM6_ATOM_TREMONT_X	0x86 /* Jacobsville */
+#define INTEL_FAM6_ATOM_TREMONT		0x96 /* Elkhart Lake */
+#define INTEL_FAM6_ATOM_TREMONT_L	0x9C /* Jasper Lake */
 
 /* Xeon Phi */
 
diff --git a/arch/x86/include/asm/microcode.h b/arch/x86/include/asm/microcode.h
index da0d81fa0b54..0e50b668184a 100644
--- a/arch/x86/include/asm/microcode.h
+++ b/arch/x86/include/asm/microcode.h
@@ -135,10 +135,12 @@ extern void __init load_ucode_bsp(void);
 extern void load_ucode_ap(void);
 void reload_early_microcode(void);
 extern bool get_builtin_firmware(struct cpio_data *cd, const char *name);
+void microcode_bsp_resume(void);
 #else
 static inline void __init load_ucode_bsp(void)			{ }
 static inline void load_ucode_ap(void)				{ }
 static inline void reload_early_microcode(void)			{ }
+static inline void microcode_bsp_resume(void)			{ }
 static inline bool
 get_builtin_firmware(struct cpio_data *cd, const char *name)	{ return false; }
 #endif
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 1fdea3c334e7..5131146e1bd8 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -89,6 +89,30 @@
 						 * Not susceptible to
 						 * TSX Async Abort (TAA) vulnerabilities.
 						 */
+#define ARCH_CAP_SBDR_SSDP_NO		BIT(13)	/*
+						 * Not susceptible to SBDR and SSDP
+						 * variants of Processor MMIO stale data
+						 * vulnerabilities.
+						 */
+#define ARCH_CAP_FBSDP_NO		BIT(14)	/*
+						 * Not susceptible to FBSDP variant of
+						 * Processor MMIO stale data
+						 * vulnerabilities.
+						 */
+#define ARCH_CAP_PSDP_NO		BIT(15)	/*
+						 * Not susceptible to PSDP variant of
+						 * Processor MMIO stale data
+						 * vulnerabilities.
+						 */
+#define ARCH_CAP_FB_CLEAR		BIT(17)	/*
+						 * VERW clears CPU fill buffer
+						 * even on MDS_NO CPUs.
+						 */
+#define ARCH_CAP_FB_CLEAR_CTRL		BIT(18)	/*
+						 * MSR_IA32_MCU_OPT_CTRL[FB_CLEAR_DIS]
+						 * bit available to control VERW
+						 * behavior.
+						 */
 
 #define MSR_IA32_FLUSH_CMD		0x0000010b
 #define L1D_FLUSH			BIT(0)	/*
@@ -106,6 +130,7 @@
 /* SRBDS support */
 #define MSR_IA32_MCU_OPT_CTRL		0x00000123
 #define RNGDS_MITG_DIS			BIT(0)
+#define FB_CLEAR_DIS			BIT(3)	/* CPU Fill buffer clear disable */
 
 #define MSR_IA32_SYSENTER_CS		0x00000174
 #define MSR_IA32_SYSENTER_ESP		0x00000175
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 19829b00e4fe..8a618fbf569f 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -323,6 +323,8 @@ DECLARE_STATIC_KEY_FALSE(switch_mm_always_ibpb);
 DECLARE_STATIC_KEY_FALSE(mds_user_clear);
 DECLARE_STATIC_KEY_FALSE(mds_idle_clear);
 
+DECLARE_STATIC_KEY_FALSE(mmio_stale_data_clear);
+
 #include <asm/segment.h>
 
 /**
diff --git a/arch/x86/include/asm/suspend_32.h b/arch/x86/include/asm/suspend_32.h
index 5cc2ce4ab8a3..4cb2a435dc85 100644
--- a/arch/x86/include/asm/suspend_32.h
+++ b/arch/x86/include/asm/suspend_32.h
@@ -20,7 +20,6 @@ struct saved_context {
 #endif
 	unsigned long cr0, cr2, cr3, cr4;
 	u64 misc_enable;
-	bool misc_enable_saved;
 	struct saved_msrs saved_msrs;
 	struct desc_ptr gdt_desc;
 	struct desc_ptr idt;
@@ -29,6 +28,7 @@ struct saved_context {
 	unsigned long tr;
 	unsigned long safety;
 	unsigned long return_address;
+	bool misc_enable_saved;
 } __attribute__((packed));
 
 #endif /* _ASM_X86_SUSPEND_32_H */
diff --git a/arch/x86/include/asm/suspend_64.h b/arch/x86/include/asm/suspend_64.h
index 701751918921..a235dd7983f0 100644
--- a/arch/x86/include/asm/suspend_64.h
+++ b/arch/x86/include/asm/suspend_64.h
@@ -13,9 +13,13 @@
  * Image of the saved processor state, used by the low level ACPI suspend to
  * RAM code and by the low level hibernation code.
  *
- * If you modify it, fix arch/x86/kernel/acpi/wakeup_64.S and make sure that
- * __save/__restore_processor_state(), defined in arch/x86/kernel/suspend_64.c,
- * still work as required.
+ * If you modify it, check how it is used in arch/x86/kernel/acpi/wakeup_64.S
+ * and make sure that __save/__restore_processor_state(), defined in
+ * arch/x86/power/cpu.c, still work as required.
+ *
+ * Because the structure is packed, make sure to avoid unaligned members. For
+ * optimisation purposes but also because tools like kmemleak only search for
+ * pointers that are aligned.
  */
 struct saved_context {
 	struct pt_regs regs;
@@ -35,7 +39,6 @@ struct saved_context {
 
 	unsigned long cr0, cr2, cr3, cr4, cr8;
 	u64 misc_enable;
-	bool misc_enable_saved;
 	struct saved_msrs saved_msrs;
 	unsigned long efer;
 	u16 gdt_pad; /* Unused */
@@ -47,6 +50,7 @@ struct saved_context {
 	unsigned long tr;
 	unsigned long safety;
 	unsigned long return_address;
+	bool misc_enable_saved;
 } __attribute__((packed));
 
 #define loaddebug(thread,register) \
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 94aa0206b1f9..b4416df41d63 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -39,8 +39,10 @@ static void __init spectre_v2_select_mitigation(void);
 static void __init ssb_select_mitigation(void);
 static void __init l1tf_select_mitigation(void);
 static void __init mds_select_mitigation(void);
-static void __init mds_print_mitigation(void);
+static void __init md_clear_update_mitigation(void);
+static void __init md_clear_select_mitigation(void);
 static void __init taa_select_mitigation(void);
+static void __init mmio_select_mitigation(void);
 static void __init srbds_select_mitigation(void);
 
 /* The base value of the SPEC_CTRL MSR that always has to be preserved. */
@@ -75,6 +77,10 @@ EXPORT_SYMBOL_GPL(mds_user_clear);
 DEFINE_STATIC_KEY_FALSE(mds_idle_clear);
 EXPORT_SYMBOL_GPL(mds_idle_clear);
 
+/* Controls CPU Fill buffer clear before KVM guest MMIO accesses */
+DEFINE_STATIC_KEY_FALSE(mmio_stale_data_clear);
+EXPORT_SYMBOL_GPL(mmio_stale_data_clear);
+
 void __init check_bugs(void)
 {
 	identify_boot_cpu();
@@ -107,16 +113,9 @@ void __init check_bugs(void)
 	spectre_v2_select_mitigation();
 	ssb_select_mitigation();
 	l1tf_select_mitigation();
-	mds_select_mitigation();
-	taa_select_mitigation();
+	md_clear_select_mitigation();
 	srbds_select_mitigation();
 
-	/*
-	 * As MDS and TAA mitigations are inter-related, print MDS
-	 * mitigation until after TAA mitigation selection is done.
-	 */
-	mds_print_mitigation();
-
 	arch_smt_update();
 
 #ifdef CONFIG_X86_32
@@ -256,14 +255,6 @@ static void __init mds_select_mitigation(void)
 	}
 }
 
-static void __init mds_print_mitigation(void)
-{
-	if (!boot_cpu_has_bug(X86_BUG_MDS) || cpu_mitigations_off())
-		return;
-
-	pr_info("%s\n", mds_strings[mds_mitigation]);
-}
-
 static int __init mds_cmdline(char *str)
 {
 	if (!boot_cpu_has_bug(X86_BUG_MDS))
@@ -311,7 +302,7 @@ static void __init taa_select_mitigation(void)
 	/* TSX previously disabled by tsx=off */
 	if (!boot_cpu_has(X86_FEATURE_RTM)) {
 		taa_mitigation = TAA_MITIGATION_TSX_DISABLED;
-		goto out;
+		return;
 	}
 
 	if (cpu_mitigations_off()) {
@@ -325,7 +316,7 @@ static void __init taa_select_mitigation(void)
 	 */
 	if (taa_mitigation == TAA_MITIGATION_OFF &&
 	    mds_mitigation == MDS_MITIGATION_OFF)
-		goto out;
+		return;
 
 	if (boot_cpu_has(X86_FEATURE_MD_CLEAR))
 		taa_mitigation = TAA_MITIGATION_VERW;
@@ -357,18 +348,6 @@ static void __init taa_select_mitigation(void)
 
 	if (taa_nosmt || cpu_mitigations_auto_nosmt())
 		cpu_smt_disable(false);
-
-	/*
-	 * Update MDS mitigation, if necessary, as the mds_user_clear is
-	 * now enabled for TAA mitigation.
-	 */
-	if (mds_mitigation == MDS_MITIGATION_OFF &&
-	    boot_cpu_has_bug(X86_BUG_MDS)) {
-		mds_mitigation = MDS_MITIGATION_FULL;
-		mds_select_mitigation();
-	}
-out:
-	pr_info("%s\n", taa_strings[taa_mitigation]);
 }
 
 static int __init tsx_async_abort_parse_cmdline(char *str)
@@ -392,6 +371,151 @@ static int __init tsx_async_abort_parse_cmdline(char *str)
 }
 early_param("tsx_async_abort", tsx_async_abort_parse_cmdline);
 
+#undef pr_fmt
+#define pr_fmt(fmt)	"MMIO Stale Data: " fmt
+
+enum mmio_mitigations {
+	MMIO_MITIGATION_OFF,
+	MMIO_MITIGATION_UCODE_NEEDED,
+	MMIO_MITIGATION_VERW,
+};
+
+/* Default mitigation for Processor MMIO Stale Data vulnerabilities */
+static enum mmio_mitigations mmio_mitigation __ro_after_init = MMIO_MITIGATION_VERW;
+static bool mmio_nosmt __ro_after_init = false;
+
+static const char * const mmio_strings[] = {
+	[MMIO_MITIGATION_OFF]		= "Vulnerable",
+	[MMIO_MITIGATION_UCODE_NEEDED]	= "Vulnerable: Clear CPU buffers attempted, no microcode",
+	[MMIO_MITIGATION_VERW]		= "Mitigation: Clear CPU buffers",
+};
+
+static void __init mmio_select_mitigation(void)
+{
+	u64 ia32_cap;
+
+	if (!boot_cpu_has_bug(X86_BUG_MMIO_STALE_DATA) ||
+	    cpu_mitigations_off()) {
+		mmio_mitigation = MMIO_MITIGATION_OFF;
+		return;
+	}
+
+	if (mmio_mitigation == MMIO_MITIGATION_OFF)
+		return;
+
+	ia32_cap = x86_read_arch_cap_msr();
+
+	/*
+	 * Enable CPU buffer clear mitigation for host and VMM, if also affected
+	 * by MDS or TAA. Otherwise, enable mitigation for VMM only.
+	 */
+	if (boot_cpu_has_bug(X86_BUG_MDS) || (boot_cpu_has_bug(X86_BUG_TAA) &&
+					      boot_cpu_has(X86_FEATURE_RTM)))
+		static_branch_enable(&mds_user_clear);
+	else
+		static_branch_enable(&mmio_stale_data_clear);
+
+	/*
+	 * If Processor-MMIO-Stale-Data bug is present and Fill Buffer data can
+	 * be propagated to uncore buffers, clearing the Fill buffers on idle
+	 * is required irrespective of SMT state.
+	 */
+	if (!(ia32_cap & ARCH_CAP_FBSDP_NO))
+		static_branch_enable(&mds_idle_clear);
+
+	/*
+	 * Check if the system has the right microcode.
+	 *
+	 * CPU Fill buffer clear mitigation is enumerated by either an explicit
+	 * FB_CLEAR or by the presence of both MD_CLEAR and L1D_FLUSH on MDS
+	 * affected systems.
+	 */
+	if ((ia32_cap & ARCH_CAP_FB_CLEAR) ||
+	    (boot_cpu_has(X86_FEATURE_MD_CLEAR) &&
+	     boot_cpu_has(X86_FEATURE_FLUSH_L1D) &&
+	     !(ia32_cap & ARCH_CAP_MDS_NO)))
+		mmio_mitigation = MMIO_MITIGATION_VERW;
+	else
+		mmio_mitigation = MMIO_MITIGATION_UCODE_NEEDED;
+
+	if (mmio_nosmt || cpu_mitigations_auto_nosmt())
+		cpu_smt_disable(false);
+}
+
+static int __init mmio_stale_data_parse_cmdline(char *str)
+{
+	if (!boot_cpu_has_bug(X86_BUG_MMIO_STALE_DATA))
+		return 0;
+
+	if (!str)
+		return -EINVAL;
+
+	if (!strcmp(str, "off")) {
+		mmio_mitigation = MMIO_MITIGATION_OFF;
+	} else if (!strcmp(str, "full")) {
+		mmio_mitigation = MMIO_MITIGATION_VERW;
+	} else if (!strcmp(str, "full,nosmt")) {
+		mmio_mitigation = MMIO_MITIGATION_VERW;
+		mmio_nosmt = true;
+	}
+
+	return 0;
+}
+early_param("mmio_stale_data", mmio_stale_data_parse_cmdline);
+
+#undef pr_fmt
+#define pr_fmt(fmt)     "" fmt
+
+static void __init md_clear_update_mitigation(void)
+{
+	if (cpu_mitigations_off())
+		return;
+
+	if (!static_key_enabled(&mds_user_clear))
+		goto out;
+
+	/*
+	 * mds_user_clear is now enabled. Update MDS, TAA and MMIO Stale Data
+	 * mitigation, if necessary.
+	 */
+	if (mds_mitigation == MDS_MITIGATION_OFF &&
+	    boot_cpu_has_bug(X86_BUG_MDS)) {
+		mds_mitigation = MDS_MITIGATION_FULL;
+		mds_select_mitigation();
+	}
+	if (taa_mitigation == TAA_MITIGATION_OFF &&
+	    boot_cpu_has_bug(X86_BUG_TAA)) {
+		taa_mitigation = TAA_MITIGATION_VERW;
+		taa_select_mitigation();
+	}
+	if (mmio_mitigation == MMIO_MITIGATION_OFF &&
+	    boot_cpu_has_bug(X86_BUG_MMIO_STALE_DATA)) {
+		mmio_mitigation = MMIO_MITIGATION_VERW;
+		mmio_select_mitigation();
+	}
+out:
+	if (boot_cpu_has_bug(X86_BUG_MDS))
+		pr_info("MDS: %s\n", mds_strings[mds_mitigation]);
+	if (boot_cpu_has_bug(X86_BUG_TAA))
+		pr_info("TAA: %s\n", taa_strings[taa_mitigation]);
+	if (boot_cpu_has_bug(X86_BUG_MMIO_STALE_DATA))
+		pr_info("MMIO Stale Data: %s\n", mmio_strings[mmio_mitigation]);
+}
+
+static void __init md_clear_select_mitigation(void)
+{
+	mds_select_mitigation();
+	taa_select_mitigation();
+	mmio_select_mitigation();
+
+	/*
+	 * As MDS, TAA and MMIO Stale Data mitigations are inter-related, update
+	 * and print their mitigation after MDS, TAA and MMIO Stale Data
+	 * mitigation selection is done.
+	 */
+	md_clear_update_mitigation();
+}
+
 #undef pr_fmt
 #define pr_fmt(fmt)	"SRBDS: " fmt
 
@@ -453,11 +577,13 @@ static void __init srbds_select_mitigation(void)
 		return;
 
 	/*
-	 * Check to see if this is one of the MDS_NO systems supporting
-	 * TSX that are only exposed to SRBDS when TSX is enabled.
+	 * Check to see if this is one of the MDS_NO systems supporting TSX that
+	 * are only exposed to SRBDS when TSX is enabled or when CPU is affected
+	 * by Processor MMIO Stale Data vulnerability.
 	 */
 	ia32_cap = x86_read_arch_cap_msr();
-	if ((ia32_cap & ARCH_CAP_MDS_NO) && !boot_cpu_has(X86_FEATURE_RTM))
+	if ((ia32_cap & ARCH_CAP_MDS_NO) && !boot_cpu_has(X86_FEATURE_RTM) &&
+	    !boot_cpu_has_bug(X86_BUG_MMIO_STALE_DATA))
 		srbds_mitigation = SRBDS_MITIGATION_TSX_OFF;
 	else if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
 		srbds_mitigation = SRBDS_MITIGATION_HYPERVISOR;
@@ -1065,6 +1191,8 @@ static void update_indir_branch_cond(void)
 /* Update the static key controlling the MDS CPU buffer clear in idle */
 static void update_mds_branch_idle(void)
 {
+	u64 ia32_cap = x86_read_arch_cap_msr();
+
 	/*
 	 * Enable the idle clearing if SMT is active on CPUs which are
 	 * affected only by MSBDS and not any other MDS variant.
@@ -1076,14 +1204,17 @@ static void update_mds_branch_idle(void)
 	if (!boot_cpu_has_bug(X86_BUG_MSBDS_ONLY))
 		return;
 
-	if (sched_smt_active())
+	if (sched_smt_active()) {
 		static_branch_enable(&mds_idle_clear);
-	else
+	} else if (mmio_mitigation == MMIO_MITIGATION_OFF ||
+		   (ia32_cap & ARCH_CAP_FBSDP_NO)) {
 		static_branch_disable(&mds_idle_clear);
+	}
 }
 
 #define MDS_MSG_SMT "MDS CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html for more details.\n"
 #define TAA_MSG_SMT "TAA CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/tsx_async_abort.html for more details.\n"
+#define MMIO_MSG_SMT "MMIO Stale Data CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/processor_mmio_stale_data.html for more details.\n"
 
 void arch_smt_update(void)
 {
@@ -1128,6 +1259,16 @@ void arch_smt_update(void)
 		break;
 	}
 
+	switch (mmio_mitigation) {
+	case MMIO_MITIGATION_VERW:
+	case MMIO_MITIGATION_UCODE_NEEDED:
+		if (sched_smt_active())
+			pr_warn_once(MMIO_MSG_SMT);
+		break;
+	case MMIO_MITIGATION_OFF:
+		break;
+	}
+
 	mutex_unlock(&spec_ctrl_mutex);
 }
 
@@ -1681,6 +1822,20 @@ static ssize_t tsx_async_abort_show_state(char *buf)
 		       sched_smt_active() ? "vulnerable" : "disabled");
 }
 
+static ssize_t mmio_stale_data_show_state(char *buf)
+{
+	if (mmio_mitigation == MMIO_MITIGATION_OFF)
+		return sysfs_emit(buf, "%s\n", mmio_strings[mmio_mitigation]);
+
+	if (boot_cpu_has(X86_FEATURE_HYPERVISOR)) {
+		return sysfs_emit(buf, "%s; SMT Host state unknown\n",
+				  mmio_strings[mmio_mitigation]);
+	}
+
+	return sysfs_emit(buf, "%s; SMT %s\n", mmio_strings[mmio_mitigation],
+			  sched_smt_active() ? "vulnerable" : "disabled");
+}
+
 static char *stibp_state(void)
 {
 	if (spectre_v2_in_eibrs_mode(spectre_v2_enabled))
@@ -1778,6 +1933,9 @@ static ssize_t cpu_show_common(struct device *dev, struct device_attribute *attr
 	case X86_BUG_SRBDS:
 		return srbds_show_state(buf);
 
+	case X86_BUG_MMIO_STALE_DATA:
+		return mmio_stale_data_show_state(buf);
+
 	default:
 		break;
 	}
@@ -1829,4 +1987,9 @@ ssize_t cpu_show_srbds(struct device *dev, struct device_attribute *attr, char *
 {
 	return cpu_show_common(dev, attr, buf, X86_BUG_SRBDS);
 }
+
+ssize_t cpu_show_mmio_stale_data(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	return cpu_show_common(dev, attr, buf, X86_BUG_MMIO_STALE_DATA);
+}
 #endif
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index ff3253b9a879..48843fc76695 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -962,18 +962,42 @@ static const __initconst struct x86_cpu_id cpu_vuln_whitelist[] = {
 					    X86_FEATURE_ANY, issues)
 
 #define SRBDS		BIT(0)
+/* CPU is affected by X86_BUG_MMIO_STALE_DATA */
+#define MMIO		BIT(1)
+/* CPU is affected by Shared Buffers Data Sampling (SBDS), a variant of X86_BUG_MMIO_STALE_DATA */
+#define MMIO_SBDS	BIT(2)
 
 static const struct x86_cpu_id cpu_vuln_blacklist[] __initconst = {
 	VULNBL_INTEL_STEPPINGS(IVYBRIDGE,	X86_STEPPING_ANY,		SRBDS),
 	VULNBL_INTEL_STEPPINGS(HASWELL_CORE,	X86_STEPPING_ANY,		SRBDS),
 	VULNBL_INTEL_STEPPINGS(HASWELL_ULT,	X86_STEPPING_ANY,		SRBDS),
 	VULNBL_INTEL_STEPPINGS(HASWELL_GT3E,	X86_STEPPING_ANY,		SRBDS),
+	VULNBL_INTEL_STEPPINGS(HASWELL_X,	BIT(2) | BIT(4),		MMIO),
+	VULNBL_INTEL_STEPPINGS(BROADWELL_XEON_D,X86_STEPPINGS(0x3, 0x5),	MMIO),
 	VULNBL_INTEL_STEPPINGS(BROADWELL_GT3E,	X86_STEPPING_ANY,		SRBDS),
+	VULNBL_INTEL_STEPPINGS(BROADWELL_X,	X86_STEPPING_ANY,		MMIO),
 	VULNBL_INTEL_STEPPINGS(BROADWELL_CORE,	X86_STEPPING_ANY,		SRBDS),
+	VULNBL_INTEL_STEPPINGS(SKYLAKE_MOBILE,	X86_STEPPINGS(0x3, 0x3),	SRBDS | MMIO),
 	VULNBL_INTEL_STEPPINGS(SKYLAKE_MOBILE,	X86_STEPPING_ANY,		SRBDS),
+	VULNBL_INTEL_STEPPINGS(SKYLAKE_X,	BIT(3) | BIT(4) | BIT(6) |
+						BIT(7) | BIT(0xB),              MMIO),
+	VULNBL_INTEL_STEPPINGS(SKYLAKE_DESKTOP,	X86_STEPPINGS(0x3, 0x3),	SRBDS | MMIO),
 	VULNBL_INTEL_STEPPINGS(SKYLAKE_DESKTOP,	X86_STEPPING_ANY,		SRBDS),
-	VULNBL_INTEL_STEPPINGS(KABYLAKE_MOBILE,	X86_STEPPINGS(0x0, 0xC),	SRBDS),
-	VULNBL_INTEL_STEPPINGS(KABYLAKE_DESKTOP,X86_STEPPINGS(0x0, 0xD),	SRBDS),
+	VULNBL_INTEL_STEPPINGS(KABYLAKE_MOBILE,	X86_STEPPINGS(0x9, 0xC),	SRBDS | MMIO),
+	VULNBL_INTEL_STEPPINGS(KABYLAKE_MOBILE,	X86_STEPPINGS(0x0, 0x8),	SRBDS),
+	VULNBL_INTEL_STEPPINGS(KABYLAKE_DESKTOP,X86_STEPPINGS(0x9, 0xD),	SRBDS | MMIO),
+	VULNBL_INTEL_STEPPINGS(KABYLAKE_DESKTOP,X86_STEPPINGS(0x0, 0x8),	SRBDS),
+	VULNBL_INTEL_STEPPINGS(ICELAKE_MOBILE,	X86_STEPPINGS(0x5, 0x5),	MMIO | MMIO_SBDS),
+	VULNBL_INTEL_STEPPINGS(ICELAKE_XEON_D,	X86_STEPPINGS(0x1, 0x1),	MMIO),
+	VULNBL_INTEL_STEPPINGS(ICELAKE_X,	X86_STEPPINGS(0x4, 0x6),	MMIO),
+	VULNBL_INTEL_STEPPINGS(COMETLAKE,	BIT(2) | BIT(3) | BIT(5),	MMIO | MMIO_SBDS),
+	VULNBL_INTEL_STEPPINGS(COMETLAKE_L,	X86_STEPPINGS(0x1, 0x1),	MMIO | MMIO_SBDS),
+	VULNBL_INTEL_STEPPINGS(COMETLAKE_L,	X86_STEPPINGS(0x0, 0x0),	MMIO),
+	VULNBL_INTEL_STEPPINGS(LAKEFIELD,	X86_STEPPINGS(0x1, 0x1),	MMIO | MMIO_SBDS),
+	VULNBL_INTEL_STEPPINGS(ROCKETLAKE,	X86_STEPPINGS(0x1, 0x1),	MMIO),
+	VULNBL_INTEL_STEPPINGS(ATOM_TREMONT,	X86_STEPPINGS(0x1, 0x1),	MMIO | MMIO_SBDS),
+	VULNBL_INTEL_STEPPINGS(ATOM_TREMONT_X,	X86_STEPPING_ANY,		MMIO),
+	VULNBL_INTEL_STEPPINGS(ATOM_TREMONT_L,	X86_STEPPINGS(0x0, 0x0),	MMIO | MMIO_SBDS),
 	{}
 };
 
@@ -994,6 +1018,13 @@ u64 x86_read_arch_cap_msr(void)
 	return ia32_cap;
 }
 
+static bool arch_cap_mmio_immune(u64 ia32_cap)
+{
+	return (ia32_cap & ARCH_CAP_FBSDP_NO &&
+		ia32_cap & ARCH_CAP_PSDP_NO &&
+		ia32_cap & ARCH_CAP_SBDR_SSDP_NO);
+}
+
 static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
 {
 	u64 ia32_cap = x86_read_arch_cap_msr();
@@ -1045,12 +1076,27 @@ static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
 	/*
 	 * SRBDS affects CPUs which support RDRAND or RDSEED and are listed
 	 * in the vulnerability blacklist.
+	 *
+	 * Some of the implications and mitigation of Shared Buffers Data
+	 * Sampling (SBDS) are similar to SRBDS. Give SBDS same treatment as
+	 * SRBDS.
 	 */
 	if ((cpu_has(c, X86_FEATURE_RDRAND) ||
 	     cpu_has(c, X86_FEATURE_RDSEED)) &&
-	    cpu_matches(cpu_vuln_blacklist, SRBDS))
+	    cpu_matches(cpu_vuln_blacklist, SRBDS | MMIO_SBDS))
 		    setup_force_cpu_bug(X86_BUG_SRBDS);
 
+	/*
+	 * Processor MMIO Stale Data bug enumeration
+	 *
+	 * Affected CPU list is generally enough to enumerate the vulnerability,
+	 * but for virtualization case check for ARCH_CAP MSR bits also, VMM may
+	 * not want the guest to enumerate the bug.
+	 */
+	if (cpu_matches(cpu_vuln_blacklist, MMIO) &&
+	    !arch_cap_mmio_immune(ia32_cap))
+		setup_force_cpu_bug(X86_BUG_MMIO_STALE_DATA);
+
 	if (cpu_matches(cpu_vuln_whitelist, NO_MELTDOWN))
 		return;
 
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index b53a6579767d..499bc79fc82a 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -586,9 +586,9 @@ static struct subsys_interface mc_cpu_interface = {
 };
 
 /**
- * mc_bp_resume - Update boot CPU microcode during resume.
+ * microcode_bsp_resume - Update boot CPU microcode during resume.
  */
-static void mc_bp_resume(void)
+void microcode_bsp_resume(void)
 {
 	int cpu = smp_processor_id();
 	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
@@ -600,7 +600,7 @@ static void mc_bp_resume(void)
 }
 
 static struct syscore_ops mc_syscore_ops = {
-	.resume			= mc_bp_resume,
+	.resume			= microcode_bsp_resume,
 };
 
 static int mc_cpu_online(unsigned int cpu)
diff --git a/arch/x86/kernel/step.c b/arch/x86/kernel/step.c
index a23ce84a3f6c..1def1e8de4bd 100644
--- a/arch/x86/kernel/step.c
+++ b/arch/x86/kernel/step.c
@@ -173,8 +173,7 @@ void set_task_blockstep(struct task_struct *task, bool on)
 	 *
 	 * NOTE: this means that set/clear TIF_BLOCKSTEP is only safe if
 	 * task is current or it can't be running, otherwise we can race
-	 * with __switch_to_xtra(). We rely on ptrace_freeze_traced() but
-	 * PTRACE_KILL is not safe.
+	 * with __switch_to_xtra(). We rely on ptrace_freeze_traced().
 	 */
 	local_irq_disable();
 	debugctl = get_debugctlmsr();
diff --git a/arch/x86/kernel/sys_x86_64.c b/arch/x86/kernel/sys_x86_64.c
index 1d4e7fd3e66d..1078705292fc 100644
--- a/arch/x86/kernel/sys_x86_64.c
+++ b/arch/x86/kernel/sys_x86_64.c
@@ -66,9 +66,6 @@ static int __init control_va_addr_alignment(char *str)
 	if (*str == 0)
 		return 1;
 
-	if (*str == '=')
-		str++;
-
 	if (!strcmp(str, "32"))
 		va_align.flags = ALIGN_VA_32;
 	else if (!strcmp(str, "64"))
@@ -78,11 +75,11 @@ static int __init control_va_addr_alignment(char *str)
 	else if (!strcmp(str, "on"))
 		va_align.flags = ALIGN_VA_32 | ALIGN_VA_64;
 	else
-		return 0;
+		pr_warn("invalid option value: 'align_va_addr=%s'\n", str);
 
 	return 1;
 }
-__setup("align_va_addr", control_va_addr_alignment);
+__setup("align_va_addr=", control_va_addr_alignment);
 
 SYSCALL_DEFINE6(mmap, unsigned long, addr, unsigned long, len,
 		unsigned long, prot, unsigned long, flags,
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index a6f8600672d7..c068027ac55f 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -502,6 +502,11 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
 		union cpuid10_eax eax;
 		union cpuid10_edx edx;
 
+		if (!static_cpu_has(X86_FEATURE_ARCH_PERFMON)) {
+			entry->eax = entry->ebx = entry->ecx = entry->edx = 0;
+			break;
+		}
+
 		perf_get_x86_pmu_capability(&cap);
 
 		/*
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 622e5a7eb7db..c287fcc310b3 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -211,6 +211,9 @@ static const struct {
 #define L1D_CACHE_ORDER 4
 static void *vmx_l1d_flush_pages;
 
+/* Control for disabling CPU Fill buffer clear */
+static bool __read_mostly vmx_fb_clear_ctrl_available;
+
 static int vmx_setup_l1d_flush(enum vmx_l1d_flush_state l1tf)
 {
 	struct page *page;
@@ -794,6 +797,8 @@ struct vcpu_vmx {
 	 */
 	u64 msr_ia32_feature_control;
 	u64 msr_ia32_feature_control_valid_bits;
+	u64 msr_ia32_mcu_opt_ctrl;
+	bool disable_fb_clear;
 };
 
 enum segment_cache_field {
@@ -1573,6 +1578,60 @@ static inline void __invept(unsigned long ext, u64 eptp, gpa_t gpa)
 			: : "a" (&operand), "c" (ext) : "cc", "memory");
 }
 
+static void vmx_setup_fb_clear_ctrl(void)
+{
+	u64 msr;
+
+	if (boot_cpu_has(X86_FEATURE_ARCH_CAPABILITIES) &&
+	    !boot_cpu_has_bug(X86_BUG_MDS) &&
+	    !boot_cpu_has_bug(X86_BUG_TAA)) {
+		rdmsrl(MSR_IA32_ARCH_CAPABILITIES, msr);
+		if (msr & ARCH_CAP_FB_CLEAR_CTRL)
+			vmx_fb_clear_ctrl_available = true;
+	}
+}
+
+static __always_inline void vmx_disable_fb_clear(struct vcpu_vmx *vmx)
+{
+	u64 msr;
+
+	if (!vmx->disable_fb_clear)
+		return;
+
+	rdmsrl(MSR_IA32_MCU_OPT_CTRL, msr);
+	msr |= FB_CLEAR_DIS;
+	wrmsrl(MSR_IA32_MCU_OPT_CTRL, msr);
+	/* Cache the MSR value to avoid reading it later */
+	vmx->msr_ia32_mcu_opt_ctrl = msr;
+}
+
+static __always_inline void vmx_enable_fb_clear(struct vcpu_vmx *vmx)
+{
+	if (!vmx->disable_fb_clear)
+		return;
+
+	vmx->msr_ia32_mcu_opt_ctrl &= ~FB_CLEAR_DIS;
+	wrmsrl(MSR_IA32_MCU_OPT_CTRL, vmx->msr_ia32_mcu_opt_ctrl);
+}
+
+static void vmx_update_fb_clear_dis(struct kvm_vcpu *vcpu, struct vcpu_vmx *vmx)
+{
+	vmx->disable_fb_clear = vmx_fb_clear_ctrl_available;
+
+	/*
+	 * If guest will not execute VERW, there is no need to set FB_CLEAR_DIS
+	 * at VMEntry. Skip the MSR read/write when a guest has no use case to
+	 * execute VERW.
+	 */
+	if ((vcpu->arch.arch_capabilities & ARCH_CAP_FB_CLEAR) ||
+	   ((vcpu->arch.arch_capabilities & ARCH_CAP_MDS_NO) &&
+	    (vcpu->arch.arch_capabilities & ARCH_CAP_TAA_NO) &&
+	    (vcpu->arch.arch_capabilities & ARCH_CAP_PSDP_NO) &&
+	    (vcpu->arch.arch_capabilities & ARCH_CAP_FBSDP_NO) &&
+	    (vcpu->arch.arch_capabilities & ARCH_CAP_SBDR_SSDP_NO)))
+		vmx->disable_fb_clear = false;
+}
+
 static struct shared_msr_entry *find_msr_entry(struct vcpu_vmx *vmx, u32 msr)
 {
 	int i;
@@ -3407,9 +3466,13 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 			}
 			break;
 		}
-		ret = kvm_set_msr_common(vcpu, msr_info);
+			ret = kvm_set_msr_common(vcpu, msr_info);
 	}
 
+	/* FB_CLEAR may have changed, also update the FB_CLEAR_DIS behavior */
+	if (msr_index == MSR_IA32_ARCH_CAPABILITIES)
+		vmx_update_fb_clear_dis(vcpu, vmx);
+
 	return ret;
 }
 
@@ -5544,6 +5607,8 @@ static void vmx_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 	update_exception_bitmap(vcpu);
 
 	vpid_sync_context(vmx->vpid);
+
+	vmx_update_fb_clear_dis(vcpu, vmx);
 }
 
 /*
@@ -9177,6 +9242,11 @@ static void __noclone vmx_vcpu_run(struct kvm_vcpu *vcpu)
 		vmx_l1d_flush(vcpu);
 	else if (static_branch_unlikely(&mds_user_clear))
 		mds_clear_cpu_buffers();
+	else if (static_branch_unlikely(&mmio_stale_data_clear) &&
+		 kvm_arch_has_assigned_device(vcpu->kvm))
+		mds_clear_cpu_buffers();
+
+	vmx_disable_fb_clear(vmx);
 
 	asm(
 		/* Store host registers */
@@ -9295,6 +9365,8 @@ static void __noclone vmx_vcpu_run(struct kvm_vcpu *vcpu)
 #endif
 	      );
 
+	vmx_enable_fb_clear(vmx);
+
 	/*
 	 * We do not use IBRS in the kernel. If this vCPU has used the
 	 * SPEC_CTRL MSR it may have left it on; save the value and
@@ -11879,8 +11951,11 @@ static int __init vmx_init(void)
 		}
 	}
 
+	vmx_setup_fb_clear_ctrl();
+
 	for_each_possible_cpu(cpu) {
 		INIT_LIST_HEAD(&per_cpu(loaded_vmcss_on_cpu, cpu));
+
 		INIT_LIST_HEAD(&per_cpu(blocked_vcpu_on_cpu, cpu));
 		spin_lock_init(&per_cpu(blocked_vcpu_on_cpu_lock, cpu));
 	}
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0b6c412c6f0f..b81acd9c8230 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1090,6 +1090,10 @@ u64 kvm_get_arch_capabilities(void)
 
 	/* KVM does not emulate MSR_IA32_TSX_CTRL.  */
 	data &= ~ARCH_CAP_TSX_CTRL_MSR;
+
+	/* Guests don't need to know "Fill buffer clear control" exists */
+	data &= ~ARCH_CAP_FB_CLEAR_CTRL;
+
 	return data;
 }
 
diff --git a/arch/x86/lib/delay.c b/arch/x86/lib/delay.c
index 71a3759a2d4e..60cc4f222cbf 100644
--- a/arch/x86/lib/delay.c
+++ b/arch/x86/lib/delay.c
@@ -42,8 +42,8 @@ static void delay_loop(unsigned long loops)
 		"	jnz 2b		\n"
 		"3:	dec %0		\n"
 
-		: /* we don't need output */
-		:"a" (loops)
+		: "+a" (loops)
+		:
 	);
 }
 
diff --git a/arch/x86/power/cpu.c b/arch/x86/power/cpu.c
index 357b3e6a2f7b..a1fbf18eed5a 100644
--- a/arch/x86/power/cpu.c
+++ b/arch/x86/power/cpu.c
@@ -26,6 +26,7 @@
 #include <asm/cpu.h>
 #include <asm/mmu_context.h>
 #include <asm/cpu_device_id.h>
+#include <asm/microcode.h>
 
 #ifdef CONFIG_X86_32
 __visible unsigned long saved_context_ebx;
@@ -261,6 +262,13 @@ static void notrace __restore_processor_state(struct saved_context *ctxt)
 	x86_platform.restore_sched_clock_state();
 	mtrr_bp_restore();
 	perf_restore_debug_store();
+
+	microcode_bsp_resume();
+
+	/*
+	 * This needs to happen after the microcode has been updated upon resume
+	 * because some of the MSRs are "emulated" in microcode.
+	 */
 	msr_restore_context(ctxt);
 }
 
diff --git a/arch/x86/um/ldt.c b/arch/x86/um/ldt.c
index 3ee234b6234d..255a44dd415a 100644
--- a/arch/x86/um/ldt.c
+++ b/arch/x86/um/ldt.c
@@ -23,9 +23,11 @@ static long write_ldt_entry(struct mm_id *mm_idp, int func,
 {
 	long res;
 	void *stub_addr;
+
+	BUILD_BUG_ON(sizeof(*desc) % sizeof(long));
+
 	res = syscall_stub_data(mm_idp, (unsigned long *)desc,
-				(sizeof(*desc) + sizeof(long) - 1) &
-				    ~(sizeof(long) - 1),
+				sizeof(*desc) / sizeof(long),
 				addr, &stub_addr);
 	if (!res) {
 		unsigned long args[] = { func,
diff --git a/arch/x86/um/shared/sysdep/syscalls_64.h b/arch/x86/um/shared/sysdep/syscalls_64.h
index 8a7d5e1da98e..1e6875b4ffd8 100644
--- a/arch/x86/um/shared/sysdep/syscalls_64.h
+++ b/arch/x86/um/shared/sysdep/syscalls_64.h
@@ -10,13 +10,12 @@
 #include <linux/msg.h>
 #include <linux/shm.h>
 
-typedef long syscall_handler_t(void);
+typedef long syscall_handler_t(long, long, long, long, long, long);
 
 extern syscall_handler_t *sys_call_table[];
 
 #define EXECUTE_SYSCALL(syscall, regs) \
-	(((long (*)(long, long, long, long, long, long)) \
-	  (*sys_call_table[syscall]))(UPT_SYSCALL_ARG1(&regs->regs), \
+	(((*sys_call_table[syscall]))(UPT_SYSCALL_ARG1(&regs->regs), \
 		 		      UPT_SYSCALL_ARG2(&regs->regs), \
 				      UPT_SYSCALL_ARG3(&regs->regs), \
 				      UPT_SYSCALL_ARG4(&regs->regs), \
diff --git a/arch/xtensa/kernel/ptrace.c b/arch/xtensa/kernel/ptrace.c
index a651f3a628ee..63612244dbca 100644
--- a/arch/xtensa/kernel/ptrace.c
+++ b/arch/xtensa/kernel/ptrace.c
@@ -34,12 +34,12 @@
 
 void user_enable_single_step(struct task_struct *child)
 {
-	child->ptrace |= PT_SINGLESTEP;
+	set_tsk_thread_flag(child, TIF_SINGLESTEP);
 }
 
 void user_disable_single_step(struct task_struct *child)
 {
-	child->ptrace &= ~PT_SINGLESTEP;
+	clear_tsk_thread_flag(child, TIF_SINGLESTEP);
 }
 
 /*
diff --git a/arch/xtensa/kernel/signal.c b/arch/xtensa/kernel/signal.c
index e87adaa07ff3..1a4462a003aa 100644
--- a/arch/xtensa/kernel/signal.c
+++ b/arch/xtensa/kernel/signal.c
@@ -458,7 +458,7 @@ static void do_signal(struct pt_regs *regs)
 		/* Set up the stack frame */
 		ret = setup_frame(&ksig, sigmask_to_save(), regs);
 		signal_setup_done(ret, &ksig, 0);
-		if (current->ptrace & PT_SINGLESTEP)
+		if (test_thread_flag(TIF_SINGLESTEP))
 			task_pt_regs(current)->icountlevel = 1;
 
 		return;
@@ -484,7 +484,7 @@ static void do_signal(struct pt_regs *regs)
 	/* If there's no signal to deliver, we just restore the saved mask.  */
 	restore_saved_sigmask();
 
-	if (current->ptrace & PT_SINGLESTEP)
+	if (test_thread_flag(TIF_SINGLESTEP))
 		task_pt_regs(current)->icountlevel = 1;
 	return;
 }
diff --git a/block/bio.c b/block/bio.c
index 4c18a68913de..db3723675f5a 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1538,7 +1538,7 @@ struct bio *bio_copy_kern(struct request_queue *q, void *data, unsigned int len,
 		if (bytes > len)
 			bytes = len;
 
-		page = alloc_page(q->bounce_gfp | gfp_mask);
+		page = alloc_page(q->bounce_gfp | __GFP_ZERO | gfp_mask);
 		if (!page)
 			goto cleanup;
 
diff --git a/drivers/ata/libata-transport.c b/drivers/ata/libata-transport.c
index 20e2b7ad8925..841ab8a2cae6 100644
--- a/drivers/ata/libata-transport.c
+++ b/drivers/ata/libata-transport.c
@@ -196,7 +196,7 @@ static struct {
 	{ XFER_PIO_0,			"XFER_PIO_0" },
 	{ XFER_PIO_SLOW,		"XFER_PIO_SLOW" }
 };
-ata_bitfield_name_match(xfer,ata_xfer_names)
+ata_bitfield_name_search(xfer, ata_xfer_names)
 
 /*
  * ATA Port attributes
diff --git a/drivers/ata/pata_octeon_cf.c b/drivers/ata/pata_octeon_cf.c
index 7e6359e32ab6..fb07d16a9f2a 100644
--- a/drivers/ata/pata_octeon_cf.c
+++ b/drivers/ata/pata_octeon_cf.c
@@ -898,12 +898,14 @@ static int octeon_cf_probe(struct platform_device *pdev)
 				int i;
 				res_dma = platform_get_resource(dma_dev, IORESOURCE_MEM, 0);
 				if (!res_dma) {
+					put_device(&dma_dev->dev);
 					of_node_put(dma_node);
 					return -EINVAL;
 				}
 				cf_port->dma_base = (u64)devm_ioremap_nocache(&pdev->dev, res_dma->start,
 									 resource_size(res_dma));
 				if (!cf_port->dma_base) {
+					put_device(&dma_dev->dev);
 					of_node_put(dma_node);
 					return -EINVAL;
 				}
@@ -913,6 +915,7 @@ static int octeon_cf_probe(struct platform_device *pdev)
 					irq = i;
 					irq_handler = octeon_cf_interrupt;
 				}
+				put_device(&dma_dev->dev);
 			}
 			of_node_put(dma_node);
 		}
diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 100850398dd3..88f89a38588a 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -556,6 +556,12 @@ ssize_t __weak cpu_show_srbds(struct device *dev,
 	return sprintf(buf, "Not affected\n");
 }
 
+ssize_t __weak cpu_show_mmio_stale_data(struct device *dev,
+					struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "Not affected\n");
+}
+
 static DEVICE_ATTR(meltdown, 0444, cpu_show_meltdown, NULL);
 static DEVICE_ATTR(spectre_v1, 0444, cpu_show_spectre_v1, NULL);
 static DEVICE_ATTR(spectre_v2, 0444, cpu_show_spectre_v2, NULL);
@@ -565,6 +571,7 @@ static DEVICE_ATTR(mds, 0444, cpu_show_mds, NULL);
 static DEVICE_ATTR(tsx_async_abort, 0444, cpu_show_tsx_async_abort, NULL);
 static DEVICE_ATTR(itlb_multihit, 0444, cpu_show_itlb_multihit, NULL);
 static DEVICE_ATTR(srbds, 0444, cpu_show_srbds, NULL);
+static DEVICE_ATTR(mmio_stale_data, 0444, cpu_show_mmio_stale_data, NULL);
 
 static struct attribute *cpu_root_vulnerabilities_attrs[] = {
 	&dev_attr_meltdown.attr,
@@ -576,6 +583,7 @@ static struct attribute *cpu_root_vulnerabilities_attrs[] = {
 	&dev_attr_tsx_async_abort.attr,
 	&dev_attr_itlb_multihit.attr,
 	&dev_attr_srbds.attr,
+	&dev_attr_mmio_stale_data.attr,
 	NULL
 };
 
diff --git a/drivers/base/node.c b/drivers/base/node.c
index 5548f9686016..7f9126633080 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -315,6 +315,7 @@ static int register_node(struct node *node, int num, struct node *parent)
  */
 void unregister_node(struct node *node)
 {
+	compaction_unregister_node(node);
 	hugetlb_unregister_node(node);		/* no-op, if memoryless node */
 
 	device_unregister(&node->dev);
diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index b701c79f07e5..3d5cf588c078 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -33,6 +33,22 @@ config BLK_DEV_FD
 	  To compile this driver as a module, choose M here: the
 	  module will be called floppy.
 
+config BLK_DEV_FD_RAWCMD
+	bool "Support for raw floppy disk commands (DEPRECATED)"
+	depends on BLK_DEV_FD
+	help
+	  If you want to use actual physical floppies and expect to do
+	  special low-level hardware accesses to them (access and use
+	  non-standard formats, for example), then enable this.
+
+	  Note that the code enabled by this option is rarely used and
+	  might be unstable or insecure, and distros should not enable it.
+
+	  Note: FDRAWCMD is deprecated and will be removed from the kernel
+	  in the near future.
+
+	  If unsure, say N.
+
 config AMIGA_FLOPPY
 	tristate "Amiga floppy support"
 	depends on AMIGA
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index daa9cef96ec6..f4537a5eef02 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -193,7 +193,7 @@ void tl_release(struct drbd_connection *connection, unsigned int barrier_nr,
 		unsigned int set_size)
 {
 	struct drbd_request *r;
-	struct drbd_request *req = NULL;
+	struct drbd_request *req = NULL, *tmp = NULL;
 	int expect_epoch = 0;
 	int expect_size = 0;
 
@@ -247,8 +247,11 @@ void tl_release(struct drbd_connection *connection, unsigned int barrier_nr,
 	 * to catch requests being barrier-acked "unexpectedly".
 	 * It usually should find the same req again, or some READ preceding it. */
 	list_for_each_entry(req, &connection->transfer_log, tl_requests)
-		if (req->epoch == expect_epoch)
+		if (req->epoch == expect_epoch) {
+			tmp = req;
 			break;
+		}
+	req = list_prepare_entry(tmp, &connection->transfer_log, tl_requests);
 	list_for_each_entry_safe_from(req, r, &connection->transfer_log, tl_requests) {
 		if (req->epoch != expect_epoch)
 			break;
diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 3c9cee9520ed..ef51f811d4d9 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -774,9 +774,11 @@ int drbd_adm_set_role(struct sk_buff *skb, struct genl_info *info)
 	mutex_lock(&adm_ctx.resource->adm_mutex);
 
 	if (info->genlhdr->cmd == DRBD_ADM_PRIMARY)
-		retcode = drbd_set_role(adm_ctx.device, R_PRIMARY, parms.assume_uptodate);
+		retcode = (enum drbd_ret_code)drbd_set_role(adm_ctx.device,
+						R_PRIMARY, parms.assume_uptodate);
 	else
-		retcode = drbd_set_role(adm_ctx.device, R_SECONDARY, 0);
+		retcode = (enum drbd_ret_code)drbd_set_role(adm_ctx.device,
+						R_SECONDARY, 0);
 
 	mutex_unlock(&adm_ctx.resource->adm_mutex);
 	genl_lock();
@@ -1933,7 +1935,7 @@ int drbd_adm_attach(struct sk_buff *skb, struct genl_info *info)
 	drbd_flush_workqueue(&connection->sender_work);
 
 	rv = _drbd_request_state(device, NS(disk, D_ATTACHING), CS_VERBOSE);
-	retcode = rv;  /* FIXME: Type mismatch. */
+	retcode = (enum drbd_ret_code)rv;
 	drbd_resume_io(device);
 	if (rv < SS_SUCCESS)
 		goto fail;
@@ -2684,7 +2686,8 @@ int drbd_adm_connect(struct sk_buff *skb, struct genl_info *info)
 	}
 	rcu_read_unlock();
 
-	retcode = conn_request_state(connection, NS(conn, C_UNCONNECTED), CS_VERBOSE);
+	retcode = (enum drbd_ret_code)conn_request_state(connection,
+					NS(conn, C_UNCONNECTED), CS_VERBOSE);
 
 	conn_reconfig_done(connection);
 	mutex_unlock(&adm_ctx.resource->adm_mutex);
@@ -2790,7 +2793,7 @@ int drbd_adm_disconnect(struct sk_buff *skb, struct genl_info *info)
 	mutex_lock(&adm_ctx.resource->adm_mutex);
 	rv = conn_try_disconnect(connection, parms.force_disconnect);
 	if (rv < SS_SUCCESS)
-		retcode = rv;  /* FIXME: Type mismatch. */
+		retcode = (enum drbd_ret_code)rv;
 	else
 		retcode = NO_ERROR;
 	mutex_unlock(&adm_ctx.resource->adm_mutex);
diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 7164be9710e5..216ee1057b12 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -516,8 +516,8 @@ static unsigned long fdc_busy;
 static DECLARE_WAIT_QUEUE_HEAD(fdc_wait);
 static DECLARE_WAIT_QUEUE_HEAD(command_done);
 
-/* Errors during formatting are counted here. */
-static int format_errors;
+/* errors encountered on the current (or last) request */
+static int floppy_errors;
 
 /* Format request descriptor. */
 static struct format_descr format_req;
@@ -537,7 +537,6 @@ static struct format_descr format_req;
 static char *floppy_track_buffer;
 static int max_buffer_sectors;
 
-static int *errors;
 typedef void (*done_f)(int);
 static const struct cont_t {
 	void (*interrupt)(void);
@@ -1426,7 +1425,7 @@ static int interpret_errors(void)
 			if (DP->flags & FTD_MSG)
 				DPRINT("Over/Underrun - retrying\n");
 			bad = 0;
-		} else if (*errors >= DP->max_errors.reporting) {
+		} else if (floppy_errors >= DP->max_errors.reporting) {
 			print_errors();
 		}
 		if (ST2 & ST2_WC || ST2 & ST2_BC)
@@ -2049,7 +2048,7 @@ static void bad_flp_intr(void)
 		if (!next_valid_format())
 			return;
 	}
-	err_count = ++(*errors);
+	err_count = ++floppy_errors;
 	INFBOUND(DRWE->badness, err_count);
 	if (err_count > DP->max_errors.abort)
 		cont->done(0);
@@ -2194,9 +2193,8 @@ static int do_format(int drive, struct format_descr *tmp_format_req)
 		return -EINVAL;
 	}
 	format_req = *tmp_format_req;
-	format_errors = 0;
 	cont = &format_cont;
-	errors = &format_errors;
+	floppy_errors = 0;
 	ret = wait_til_done(redo_format, true);
 	if (ret == -EINTR)
 		return -EINTR;
@@ -2679,7 +2677,7 @@ static int make_raw_rw_request(void)
 		 */
 		if (!direct ||
 		    (indirect * 2 > direct * 3 &&
-		     *errors < DP->max_errors.read_track &&
+		     floppy_errors < DP->max_errors.read_track &&
 		     ((!probing ||
 		       (DP->read_track & (1 << DRS->probed_format)))))) {
 			max_size = blk_rq_sectors(current_req);
@@ -2812,8 +2810,10 @@ static int set_next_request(void)
 			fdc_queue = 0;
 		if (q) {
 			current_req = blk_fetch_request(q);
-			if (current_req)
+			if (current_req) {
+				floppy_errors = 0;
 				break;
+			}
 		}
 	} while (fdc_queue != old_pos);
 
@@ -2873,7 +2873,6 @@ static void redo_fd_request(void)
 		_floppy = floppy_type + DP->autodetect[DRS->probed_format];
 	} else
 		probing = 0;
-	errors = &(current_req->errors);
 	tmp = make_raw_rw_request();
 	if (tmp < 2) {
 		request_done(tmp);
@@ -3016,6 +3015,8 @@ static const char *drive_name(int type, int drive)
 		return "(null)";
 }
 
+#ifdef CONFIG_BLK_DEV_FD_RAWCMD
+
 /* raw commands */
 static void raw_cmd_done(int flag)
 {
@@ -3227,6 +3228,35 @@ static int raw_cmd_ioctl(int cmd, void __user *param)
 	return ret;
 }
 
+static int floppy_raw_cmd_ioctl(int type, int drive, int cmd,
+				void __user *param)
+{
+	int ret;
+
+	pr_warn_once("Note: FDRAWCMD is deprecated and will be removed from the kernel in the near future.\n");
+
+	if (type)
+		return -EINVAL;
+	if (lock_fdc(drive))
+		return -EINTR;
+	set_floppy(drive);
+	ret = raw_cmd_ioctl(cmd, param);
+	if (ret == -EINTR)
+		return -EINTR;
+	process_fd_request();
+	return ret;
+}
+
+#else /* CONFIG_BLK_DEV_FD_RAWCMD */
+
+static int floppy_raw_cmd_ioctl(int type, int drive, int cmd,
+				void __user *param)
+{
+	return -EOPNOTSUPP;
+}
+
+#endif
+
 static int invalidate_drive(struct block_device *bdev)
 {
 	/* invalidate the buffer track to force a reread */
@@ -3414,7 +3444,6 @@ static int fd_locked_ioctl(struct block_device *bdev, fmode_t mode, unsigned int
 {
 	int drive = (long)bdev->bd_disk->private_data;
 	int type = ITYPE(UDRS->fd_device);
-	int i;
 	int ret;
 	int size;
 	union inparam {
@@ -3565,16 +3594,7 @@ static int fd_locked_ioctl(struct block_device *bdev, fmode_t mode, unsigned int
 		outparam = UDRWE;
 		break;
 	case FDRAWCMD:
-		if (type)
-			return -EINVAL;
-		if (lock_fdc(drive))
-			return -EINTR;
-		set_floppy(drive);
-		i = raw_cmd_ioctl(cmd, (void __user *)param);
-		if (i == -EINTR)
-			return -EINTR;
-		process_fd_request();
-		return i;
+		return floppy_raw_cmd_ioctl(type, drive, cmd, (void __user *)param);
 	case FDTWADDLE:
 		if (lock_fdc(drive))
 			return -EINTR;
diff --git a/drivers/bus/sunxi-rsb.c b/drivers/bus/sunxi-rsb.c
index 4f3d988210b0..ce5b976a8856 100644
--- a/drivers/bus/sunxi-rsb.c
+++ b/drivers/bus/sunxi-rsb.c
@@ -224,6 +224,8 @@ static struct sunxi_rsb_device *sunxi_rsb_device_create(struct sunxi_rsb *rsb,
 
 	dev_dbg(&rdev->dev, "device %s registered\n", dev_name(&rdev->dev));
 
+	return rdev;
+
 err_device_add:
 	put_device(&rdev->dev);
 
diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
index a4ef9a6bd367..45117728e735 100644
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -812,6 +812,14 @@ static void msg_done_handler(struct ssif_info *ssif_info, int result,
 		break;
 
 	case SSIF_GETTING_EVENTS:
+		if (!msg) {
+			/* Should never happen, but just in case. */
+			dev_warn(&ssif_info->client->dev,
+				 "No message set while getting events\n");
+			ipmi_ssif_unlock_cond(ssif_info, flags);
+			break;
+		}
+
 		if ((result < 0) || (len < 3) || (msg->rsp[2] != 0)) {
 			/* Error getting event, probably done. */
 			msg->done(msg);
@@ -835,6 +843,14 @@ static void msg_done_handler(struct ssif_info *ssif_info, int result,
 		break;
 
 	case SSIF_GETTING_MESSAGES:
+		if (!msg) {
+			/* Should never happen, but just in case. */
+			dev_warn(&ssif_info->client->dev,
+				 "No message set while getting messages\n");
+			ipmi_ssif_unlock_cond(ssif_info, flags);
+			break;
+		}
+
 		if ((result < 0) || (len < 3) || (msg->rsp[2] != 0)) {
 			/* Error getting event, probably done. */
 			msg->done(msg);
@@ -857,6 +873,13 @@ static void msg_done_handler(struct ssif_info *ssif_info, int result,
 			deliver_recv_msg(ssif_info, msg);
 		}
 		break;
+
+	default:
+		/* Should never happen, but just in case. */
+		dev_warn(&ssif_info->client->dev,
+			 "Invalid state in message done handling: %d\n",
+			 ssif_info->ssif_state);
+		ipmi_ssif_unlock_cond(ssif_info, flags);
 	}
 
 	flags = ipmi_ssif_lock_cond(ssif_info, &oflags);
diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibmvtpm.c
index 0fad6cf37bab..b0f546f4b15c 100644
--- a/drivers/char/tpm/tpm_ibmvtpm.c
+++ b/drivers/char/tpm/tpm_ibmvtpm.c
@@ -653,6 +653,7 @@ static int tpm_ibmvtpm_probe(struct vio_dev *vio_dev,
 	if (!wait_event_timeout(ibmvtpm->crq_queue.wq,
 				ibmvtpm->rtce_buf != NULL,
 				HZ)) {
+		rc = -ENODEV;
 		dev_err(dev, "CRQ response timed out\n");
 		goto init_irq_cleanup;
 	}
diff --git a/drivers/clk/sunxi/clk-sun9i-mmc.c b/drivers/clk/sunxi/clk-sun9i-mmc.c
index f69f9e8c6f38..7e9d1624032f 100644
--- a/drivers/clk/sunxi/clk-sun9i-mmc.c
+++ b/drivers/clk/sunxi/clk-sun9i-mmc.c
@@ -117,6 +117,8 @@ static int sun9i_a80_mmc_config_clk_probe(struct platform_device *pdev)
 	spin_lock_init(&data->lock);
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!r)
+		return -EINVAL;
 	/* one clock/reset pair per word */
 	count = DIV_ROUND_UP((resource_size(r)), SUN9I_MMC_WIDTH);
 	data->membase = devm_ioremap_resource(&pdev->dev, r);
diff --git a/drivers/clocksource/timer-oxnas-rps.c b/drivers/clocksource/timer-oxnas-rps.c
index d630bf417773..411f211185d3 100644
--- a/drivers/clocksource/timer-oxnas-rps.c
+++ b/drivers/clocksource/timer-oxnas-rps.c
@@ -247,7 +247,7 @@ static int __init oxnas_rps_timer_init(struct device_node *np)
 	}
 
 	rps->irq = irq_of_parse_and_map(np, 0);
-	if (rps->irq < 0) {
+	if (!rps->irq) {
 		ret = -EINVAL;
 		goto err_iomap;
 	}
diff --git a/drivers/clocksource/timer-sp804.c b/drivers/clocksource/timer-sp804.c
index d07863388e05..780699e4d120 100644
--- a/drivers/clocksource/timer-sp804.c
+++ b/drivers/clocksource/timer-sp804.c
@@ -227,6 +227,11 @@ static int __init sp804_of_init(struct device_node *np)
 	struct clk *clk1, *clk2;
 	const char *name = of_get_property(np, "compatible", NULL);
 
+	if (initialized) {
+		pr_debug("%pOF: skipping further SP804 timer device\n", np);
+		return 0;
+	}
+
 	base = of_iomap(np, 0);
 	if (!base)
 		return -ENXIO;
@@ -235,11 +240,6 @@ static int __init sp804_of_init(struct device_node *np)
 	writel(0, base + TIMER_CTRL);
 	writel(0, base + TIMER_2_BASE + TIMER_CTRL);
 
-	if (initialized || !of_device_is_available(np)) {
-		ret = -EINVAL;
-		goto err;
-	}
-
 	clk1 = of_clk_get(np, 0);
 	if (IS_ERR(clk1))
 		clk1 = NULL;
diff --git a/drivers/firewire/core-card.c b/drivers/firewire/core-card.c
index 57ea7f464178..11c634125c7d 100644
--- a/drivers/firewire/core-card.c
+++ b/drivers/firewire/core-card.c
@@ -681,6 +681,7 @@ EXPORT_SYMBOL_GPL(fw_card_release);
 void fw_core_remove_card(struct fw_card *card)
 {
 	struct fw_card_driver dummy_driver = dummy_driver_template;
+	unsigned long flags;
 
 	card->driver->update_phy_reg(card, 4,
 				     PHY_LINK_ACTIVE | PHY_CONTENDER, 0);
@@ -695,7 +696,9 @@ void fw_core_remove_card(struct fw_card *card)
 	dummy_driver.stop_iso		= card->driver->stop_iso;
 	card->driver = &dummy_driver;
 
+	spin_lock_irqsave(&card->lock, flags);
 	fw_destroy_nodes(card);
+	spin_unlock_irqrestore(&card->lock, flags);
 
 	/* Wait for all users, especially device workqueue jobs, to finish. */
 	fw_card_put(card);
diff --git a/drivers/firewire/core-cdev.c b/drivers/firewire/core-cdev.c
index aee149bdf4c0..59b49ff1f4be 100644
--- a/drivers/firewire/core-cdev.c
+++ b/drivers/firewire/core-cdev.c
@@ -1496,6 +1496,7 @@ static void outbound_phy_packet_callback(struct fw_packet *packet,
 {
 	struct outbound_phy_packet_event *e =
 		container_of(packet, struct outbound_phy_packet_event, p);
+	struct client *e_client;
 
 	switch (status) {
 	/* expected: */
@@ -1512,9 +1513,10 @@ static void outbound_phy_packet_callback(struct fw_packet *packet,
 	}
 	e->phy_packet.data[0] = packet->timestamp;
 
+	e_client = e->client;
 	queue_event(e->client, &e->event, &e->phy_packet,
 		    sizeof(e->phy_packet) + e->phy_packet.length, NULL, 0);
-	client_put(e->client);
+	client_put(e_client);
 }
 
 static int ioctl_send_phy_packet(struct client *client, union ioctl_arg *arg)
diff --git a/drivers/firewire/core-topology.c b/drivers/firewire/core-topology.c
index 0de83508f321..2337b0f3dae2 100644
--- a/drivers/firewire/core-topology.c
+++ b/drivers/firewire/core-topology.c
@@ -387,16 +387,13 @@ static void report_found_node(struct fw_card *card,
 	card->bm_retries = 0;
 }
 
+/* Must be called with card->lock held */
 void fw_destroy_nodes(struct fw_card *card)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&card->lock, flags);
 	card->color++;
 	if (card->local_node != NULL)
 		for_each_fw_node(card, card->local_node, report_lost_node);
 	card->local_node = NULL;
-	spin_unlock_irqrestore(&card->lock, flags);
 }
 
 static void move_tree(struct fw_node *node0, struct fw_node *node1, int port)
@@ -522,6 +519,8 @@ void fw_core_handle_bus_reset(struct fw_card *card, int node_id, int generation,
 	struct fw_node *local_node;
 	unsigned long flags;
 
+	spin_lock_irqsave(&card->lock, flags);
+
 	/*
 	 * If the selfID buffer is not the immediate successor of the
 	 * previously processed one, we cannot reliably compare the
@@ -533,8 +532,6 @@ void fw_core_handle_bus_reset(struct fw_card *card, int node_id, int generation,
 		card->bm_retries = 0;
 	}
 
-	spin_lock_irqsave(&card->lock, flags);
-
 	card->broadcast_channel_allocated = card->broadcast_channel_auto_allocated;
 	card->node_id = node_id;
 	/*
diff --git a/drivers/firewire/core-transaction.c b/drivers/firewire/core-transaction.c
index d6a09b9cd8cc..0446221d7d2e 100644
--- a/drivers/firewire/core-transaction.c
+++ b/drivers/firewire/core-transaction.c
@@ -86,24 +86,25 @@ static int try_cancel_split_timeout(struct fw_transaction *t)
 static int close_transaction(struct fw_transaction *transaction,
 			     struct fw_card *card, int rcode)
 {
-	struct fw_transaction *t;
+	struct fw_transaction *t = NULL, *iter;
 	unsigned long flags;
 
 	spin_lock_irqsave(&card->lock, flags);
-	list_for_each_entry(t, &card->transaction_list, link) {
-		if (t == transaction) {
-			if (!try_cancel_split_timeout(t)) {
+	list_for_each_entry(iter, &card->transaction_list, link) {
+		if (iter == transaction) {
+			if (!try_cancel_split_timeout(iter)) {
 				spin_unlock_irqrestore(&card->lock, flags);
 				goto timed_out;
 			}
-			list_del_init(&t->link);
-			card->tlabel_mask &= ~(1ULL << t->tlabel);
+			list_del_init(&iter->link);
+			card->tlabel_mask &= ~(1ULL << iter->tlabel);
+			t = iter;
 			break;
 		}
 	}
 	spin_unlock_irqrestore(&card->lock, flags);
 
-	if (&t->link != &card->transaction_list) {
+	if (t) {
 		t->callback(card, rcode, NULL, 0, t->callback_data);
 		return 0;
 	}
@@ -938,7 +939,7 @@ EXPORT_SYMBOL(fw_core_handle_request);
 
 void fw_core_handle_response(struct fw_card *card, struct fw_packet *p)
 {
-	struct fw_transaction *t;
+	struct fw_transaction *t = NULL, *iter;
 	unsigned long flags;
 	u32 *data;
 	size_t data_length;
@@ -950,20 +951,21 @@ void fw_core_handle_response(struct fw_card *card, struct fw_packet *p)
 	rcode	= HEADER_GET_RCODE(p->header[1]);
 
 	spin_lock_irqsave(&card->lock, flags);
-	list_for_each_entry(t, &card->transaction_list, link) {
-		if (t->node_id == source && t->tlabel == tlabel) {
-			if (!try_cancel_split_timeout(t)) {
+	list_for_each_entry(iter, &card->transaction_list, link) {
+		if (iter->node_id == source && iter->tlabel == tlabel) {
+			if (!try_cancel_split_timeout(iter)) {
 				spin_unlock_irqrestore(&card->lock, flags);
 				goto timed_out;
 			}
-			list_del_init(&t->link);
-			card->tlabel_mask &= ~(1ULL << t->tlabel);
+			list_del_init(&iter->link);
+			card->tlabel_mask &= ~(1ULL << iter->tlabel);
+			t = iter;
 			break;
 		}
 	}
 	spin_unlock_irqrestore(&card->lock, flags);
 
-	if (&t->link == &card->transaction_list) {
+	if (!t) {
  timed_out:
 		fw_notice(card, "unsolicited response (source %x, tlabel %x)\n",
 			  source, tlabel);
diff --git a/drivers/firewire/sbp2.c b/drivers/firewire/sbp2.c
index 6bac03999fd4..d418a71faf0b 100644
--- a/drivers/firewire/sbp2.c
+++ b/drivers/firewire/sbp2.c
@@ -421,7 +421,7 @@ static void sbp2_status_write(struct fw_card *card, struct fw_request *request,
 			      void *payload, size_t length, void *callback_data)
 {
 	struct sbp2_logical_unit *lu = callback_data;
-	struct sbp2_orb *orb;
+	struct sbp2_orb *orb = NULL, *iter;
 	struct sbp2_status status;
 	unsigned long flags;
 
@@ -446,17 +446,18 @@ static void sbp2_status_write(struct fw_card *card, struct fw_request *request,
 
 	/* Lookup the orb corresponding to this status write. */
 	spin_lock_irqsave(&lu->tgt->lock, flags);
-	list_for_each_entry(orb, &lu->orb_list, link) {
+	list_for_each_entry(iter, &lu->orb_list, link) {
 		if (STATUS_GET_ORB_HIGH(status) == 0 &&
-		    STATUS_GET_ORB_LOW(status) == orb->request_bus) {
-			orb->rcode = RCODE_COMPLETE;
-			list_del(&orb->link);
+		    STATUS_GET_ORB_LOW(status) == iter->request_bus) {
+			iter->rcode = RCODE_COMPLETE;
+			list_del(&iter->link);
+			orb = iter;
 			break;
 		}
 	}
 	spin_unlock_irqrestore(&lu->tgt->lock, flags);
 
-	if (&orb->link != &lu->orb_list) {
+	if (orb) {
 		orb->callback(orb, &status);
 		kref_put(&orb->kref, free_orb); /* orb callback reference */
 	} else {
diff --git a/drivers/firmware/dmi-sysfs.c b/drivers/firmware/dmi-sysfs.c
index ef76e5eecf0b..37f76daa2b3d 100644
--- a/drivers/firmware/dmi-sysfs.c
+++ b/drivers/firmware/dmi-sysfs.c
@@ -601,7 +601,7 @@ static void __init dmi_sysfs_register_handle(const struct dmi_header *dh,
 				    "%d-%d", dh->type, entry->instance);
 
 	if (*ret) {
-		kfree(entry);
+		kobject_put(&entry->kobj);
 		return;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index c801624f33bd..35130c07e17f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -139,7 +139,7 @@ int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p, void *data)
 	int ret;
 
 	if (cs->in.num_chunks == 0)
-		return 0;
+		return -EINVAL;
 
 	chunk_array = kmalloc_array(cs->in.num_chunks, sizeof(uint64_t), GFP_KERNEL);
 	if (!chunk_array)
diff --git a/drivers/gpu/drm/amd/amdgpu/kv_dpm.c b/drivers/gpu/drm/amd/amdgpu/kv_dpm.c
index f61c489e5f6d..81f1591a9be9 100644
--- a/drivers/gpu/drm/amd/amdgpu/kv_dpm.c
+++ b/drivers/gpu/drm/amd/amdgpu/kv_dpm.c
@@ -1617,19 +1617,7 @@ static int kv_update_samu_dpm(struct amdgpu_device *adev, bool gate)
 
 static u8 kv_get_acp_boot_level(struct amdgpu_device *adev)
 {
-	u8 i;
-	struct amdgpu_clock_voltage_dependency_table *table =
-		&adev->pm.dpm.dyn_state.acp_clock_voltage_dependency_table;
-
-	for (i = 0; i < table->count; i++) {
-		if (table->entries[i].clk >= 0) /* XXX */
-			break;
-	}
-
-	if (i >= table->count)
-		i = table->count - 1;
-
-	return i;
+	return 0;
 }
 
 static void kv_update_acp_boot_level(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/si_dpm.c b/drivers/gpu/drm/amd/amdgpu/si_dpm.c
index 4826befc1bc3..fe6fda42fde8 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_dpm.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_dpm.c
@@ -7313,17 +7313,15 @@ static int si_parse_power_table(struct amdgpu_device *adev)
 	if (!adev->pm.dpm.ps)
 		return -ENOMEM;
 	power_state_offset = (u8 *)state_array->states;
-	for (i = 0; i < state_array->ucNumEntries; i++) {
+	for (adev->pm.dpm.num_ps = 0, i = 0; i < state_array->ucNumEntries; i++) {
 		u8 *idx;
 		power_state = (union pplib_power_state *)power_state_offset;
 		non_clock_array_index = power_state->v2.nonClockInfoIndex;
 		non_clock_info = (struct _ATOM_PPLIB_NONCLOCK_INFO *)
 			&non_clock_info_array->nonClockInfo[non_clock_array_index];
 		ps = kzalloc(sizeof(struct  si_ps), GFP_KERNEL);
-		if (ps == NULL) {
-			kfree(adev->pm.dpm.ps);
+		if (ps == NULL)
 			return -ENOMEM;
-		}
 		adev->pm.dpm.ps[i].ps_priv = ps;
 		si_parse_pplib_non_clock_info(adev, &adev->pm.dpm.ps[i],
 					      non_clock_info,
@@ -7345,8 +7343,8 @@ static int si_parse_power_table(struct amdgpu_device *adev)
 			k++;
 		}
 		power_state_offset += 2 + power_state->v2.ucNumDPMLevels;
+		adev->pm.dpm.num_ps++;
 	}
-	adev->pm.dpm.num_ps = state_array->ucNumEntries;
 
 	/* fill in the vce power states */
 	for (i = 0; i < AMDGPU_MAX_VCE_LEVELS; i++) {
diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index 72ec93de0e76..d1077a342f38 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -1275,8 +1275,19 @@ static ssize_t analogix_dpaux_transfer(struct drm_dp_aux *aux,
 				       struct drm_dp_aux_msg *msg)
 {
 	struct analogix_dp_device *dp = to_dp(aux);
+	int ret;
+
+	pm_runtime_get_sync(dp->dev);
 
-	return analogix_dp_transfer(dp, msg);
+	ret = analogix_dp_detect_hpd(dp);
+	if (ret)
+		goto out;
+
+	ret = analogix_dp_transfer(dp, msg);
+out:
+	pm_runtime_put(dp->dev);
+
+	return ret;
 }
 
 int analogix_dp_bind(struct device *dev, struct drm_device *drm_dev,
diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index bb70c5272fe8..efd3ac2acea5 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -2830,6 +2830,7 @@ static void fetch_monitor_name(struct drm_dp_mst_topology_mgr *mgr,
 
 	mst_edid = drm_dp_mst_get_edid(port->connector, mgr, port);
 	drm_edid_get_monitor_name(mst_edid, name, namelen);
+	kfree(mst_edid);
 }
 
 /**
diff --git a/drivers/gpu/drm/gma500/psb_intel_display.c b/drivers/gpu/drm/gma500/psb_intel_display.c
index 7b6c84925098..389c4973fea8 100644
--- a/drivers/gpu/drm/gma500/psb_intel_display.c
+++ b/drivers/gpu/drm/gma500/psb_intel_display.c
@@ -548,14 +548,15 @@ void psb_intel_crtc_init(struct drm_device *dev, int pipe,
 
 struct drm_crtc *psb_intel_get_crtc_from_pipe(struct drm_device *dev, int pipe)
 {
-	struct drm_crtc *crtc = NULL;
+	struct drm_crtc *crtc;
 
 	list_for_each_entry(crtc, &dev->mode_config.crtc_list, head) {
 		struct gma_crtc *gma_crtc = to_gma_crtc(crtc);
+
 		if (gma_crtc->pipe == pipe)
-			break;
+			return crtc;
 	}
-	return crtc;
+	return NULL;
 }
 
 int gma_connector_clones(struct drm_device *dev, int type_mask)
diff --git a/drivers/gpu/drm/i915/intel_pm.c b/drivers/gpu/drm/i915/intel_pm.c
index 202c00b17df2..dcae0ec973a9 100644
--- a/drivers/gpu/drm/i915/intel_pm.c
+++ b/drivers/gpu/drm/i915/intel_pm.c
@@ -2083,7 +2083,7 @@ hsw_compute_linetime_wm(const struct intel_crtc_state *cstate)
 	       PIPE_WM_LINETIME_TIME(linetime);
 }
 
-static void intel_read_wm_latency(struct drm_device *dev, uint16_t wm[8])
+static void intel_read_wm_latency(struct drm_device *dev, uint16_t wm[])
 {
 	struct drm_i915_private *dev_priv = to_i915(dev);
 
diff --git a/drivers/gpu/drm/mediatek/mtk_cec.c b/drivers/gpu/drm/mediatek/mtk_cec.c
index 7a3eb8c17ef9..4e5482986dc2 100644
--- a/drivers/gpu/drm/mediatek/mtk_cec.c
+++ b/drivers/gpu/drm/mediatek/mtk_cec.c
@@ -91,7 +91,7 @@ static void mtk_cec_mask(struct mtk_cec *cec, unsigned int offset,
 	u32 tmp = readl(cec->regs + offset) & ~mask;
 
 	tmp |= val & mask;
-	writel(val, cec->regs + offset);
+	writel(tmp, cec->regs + offset);
 }
 
 void mtk_cec_set_hpd_event(struct device *dev,
diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index 246336a9f47d..bea4969900ab 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -1240,10 +1240,10 @@ static int dsi_cmds2buf_tx(struct msm_dsi_host *msm_host,
 			dsi_get_bpp(msm_host->format) / 8;
 
 	len = dsi_cmd_dma_add(msm_host, msg);
-	if (!len) {
+	if (len < 0) {
 		pr_err("%s: failed to add cmd type = 0x%x\n",
 			__func__,  msg->type);
-		return -EINVAL;
+		return len;
 	}
 
 	/* for video mode, do not send cmds more than
@@ -1262,10 +1262,14 @@ static int dsi_cmds2buf_tx(struct msm_dsi_host *msm_host,
 	}
 
 	ret = dsi_cmd_dma_tx(msm_host, len);
-	if (ret < len) {
-		pr_err("%s: cmd dma tx failed, type=0x%x, data0=0x%x, len=%d\n",
-			__func__, msg->type, (*(u8 *)(msg->tx_buf)), len);
-		return -ECOMM;
+	if (ret < 0) {
+		pr_err("%s: cmd dma tx failed, type=0x%x, data0=0x%x, len=%d, ret=%d\n",
+			__func__, msg->type, (*(u8 *)(msg->tx_buf)), len, ret);
+		return ret;
+	} else if (ret < len) {
+		pr_err("%s: cmd dma tx failed, type=0x%x, data0=0x%x, ret=%d len=%d\n",
+			__func__, msg->type, (*(u8 *)(msg->tx_buf)), ret, len);
+		return -EIO;
 	}
 
 	return len;
@@ -1979,9 +1983,12 @@ int msm_dsi_host_cmd_rx(struct mipi_dsi_host *host,
 		}
 
 		ret = dsi_cmds2buf_tx(msm_host, msg);
-		if (ret < msg->tx_len) {
+		if (ret < 0) {
 			pr_err("%s: Read cmd Tx failed, %d\n", __func__, ret);
 			return ret;
+		} else if (ret < msg->tx_len) {
+			pr_err("%s: Read cmd Tx failed, too short: %d\n", __func__, ret);
+			return -ECOMM;
 		}
 
 		/*
diff --git a/drivers/gpu/drm/msm/hdmi/hdmi.c b/drivers/gpu/drm/msm/hdmi/hdmi.c
index a968cad509c2..48ab46726707 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi.c
@@ -148,6 +148,10 @@ static struct hdmi *msm_hdmi_init(struct platform_device *pdev)
 	/* HDCP needs physical address of hdmi register */
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
 		config->mmio_name);
+	if (!res) {
+		ret = -EINVAL;
+		goto fail;
+	}
 	hdmi->mmio_phy_addr = res->start;
 
 	hdmi->qfprom_mmio = msm_ioremap(pdev,
diff --git a/drivers/gpu/drm/msm/msm_gem_prime.c b/drivers/gpu/drm/msm/msm_gem_prime.c
index 13403c6da6c7..7e4664968106 100644
--- a/drivers/gpu/drm/msm/msm_gem_prime.c
+++ b/drivers/gpu/drm/msm/msm_gem_prime.c
@@ -26,7 +26,7 @@ struct sg_table *msm_gem_prime_get_sg_table(struct drm_gem_object *obj)
 	int npages = obj->size >> PAGE_SHIFT;
 
 	if (WARN_ON(!msm_obj->pages))  /* should have already pinned! */
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	return drm_prime_pages_to_sg(msm_obj->pages, npages);
 }
diff --git a/drivers/gpu/drm/radeon/radeon_connectors.c b/drivers/gpu/drm/radeon/radeon_connectors.c
index 9e6c2be0cc7d..a759955e3797 100644
--- a/drivers/gpu/drm/radeon/radeon_connectors.c
+++ b/drivers/gpu/drm/radeon/radeon_connectors.c
@@ -489,6 +489,8 @@ static struct drm_display_mode *radeon_fp_native_mode(struct drm_encoder *encode
 	    native_mode->vdisplay != 0 &&
 	    native_mode->clock != 0) {
 		mode = drm_mode_duplicate(dev, native_mode);
+		if (!mode)
+			return NULL;
 		mode->type = DRM_MODE_TYPE_PREFERRED | DRM_MODE_TYPE_DRIVER;
 		drm_mode_set_name(mode);
 
@@ -503,6 +505,8 @@ static struct drm_display_mode *radeon_fp_native_mode(struct drm_encoder *encode
 		 * simpler.
 		 */
 		mode = drm_cvt_mode(dev, native_mode->hdisplay, native_mode->vdisplay, 60, true, false, false);
+		if (!mode)
+			return NULL;
 		mode->type = DRM_MODE_TYPE_PREFERRED | DRM_MODE_TYPE_DRIVER;
 		DRM_DEBUG_KMS("Adding cvt approximation of native panel mode %s\n", mode->name);
 	}
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 5bed63eee5f0..050f9a59ed54 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -1524,10 +1524,10 @@ static int vop_bind(struct device *dev, struct device *master, void *data)
 	vop_win_init(vop);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	vop->len = resource_size(res);
 	vop->regs = devm_ioremap_resource(dev, res);
 	if (IS_ERR(vop->regs))
 		return PTR_ERR(vop->regs);
+	vop->len = resource_size(res);
 
 	vop->regsbak = devm_kzalloc(dev, vop->len, GFP_KERNEL);
 	if (!vop->regsbak)
diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
index 58048709c34e..1e528f13959d 100644
--- a/drivers/gpu/drm/virtio/virtgpu_display.c
+++ b/drivers/gpu/drm/virtio/virtgpu_display.c
@@ -184,6 +184,8 @@ static int virtio_gpu_conn_get_modes(struct drm_connector *connector)
 		DRM_DEBUG("add mode: %dx%d\n", width, height);
 		mode = drm_cvt_mode(connector->dev, width, height, 60,
 				    false, false, false);
+		if (!mode)
+			return count;
 		mode->type |= DRM_MODE_TYPE_PREFERRED;
 		drm_mode_probed_add(connector, mode);
 		count++;
diff --git a/drivers/hid/hid-led.c b/drivers/hid/hid-led.c
index d3e1ab162f7c..7fc5982a0ca4 100644
--- a/drivers/hid/hid-led.c
+++ b/drivers/hid/hid-led.c
@@ -369,7 +369,7 @@ static const struct hidled_config hidled_configs[] = {
 		.type = DREAM_CHEEKY,
 		.name = "Dream Cheeky Webmail Notifier",
 		.short_name = "dream_cheeky",
-		.max_brightness = 31,
+		.max_brightness = 63,
 		.num_leds = 1,
 		.report_size = 9,
 		.report_type = RAW_REQUEST,
diff --git a/drivers/hwmon/adt7470.c b/drivers/hwmon/adt7470.c
index 6e60ca53406e..474f226e0891 100644
--- a/drivers/hwmon/adt7470.c
+++ b/drivers/hwmon/adt7470.c
@@ -33,6 +33,7 @@
 #include <linux/kthread.h>
 #include <linux/slab.h>
 #include <linux/util_macros.h>
+#include <linux/sched.h>
 
 /* Addresses to scan */
 static const unsigned short normal_i2c[] = { 0x2C, 0x2E, 0x2F, I2C_CLIENT_END };
@@ -273,11 +274,10 @@ static int adt7470_update_thread(void *p)
 		adt7470_read_temperatures(client, data);
 		mutex_unlock(&data->lock);
 
-		set_current_state(TASK_INTERRUPTIBLE);
 		if (kthread_should_stop())
 			break;
 
-		schedule_timeout(msecs_to_jiffies(data->auto_update_interval));
+		schedule_timeout_interruptible(msecs_to_jiffies(data->auto_update_interval));
 	}
 
 	return 0;
diff --git a/drivers/hwmon/f71882fg.c b/drivers/hwmon/f71882fg.c
index cb28e4b4fb10..b87ca56fb774 100644
--- a/drivers/hwmon/f71882fg.c
+++ b/drivers/hwmon/f71882fg.c
@@ -1590,8 +1590,9 @@ static ssize_t show_temp(struct device *dev, struct device_attribute *devattr,
 		temp *= 125;
 		if (sign)
 			temp -= 128000;
-	} else
-		temp = data->temp[nr] * 1000;
+	} else {
+		temp = ((s8)data->temp[nr]) * 1000;
+	}
 
 	return sprintf(buf, "%d\n", temp);
 }
diff --git a/drivers/i2c/busses/i2c-cadence.c b/drivers/i2c/busses/i2c-cadence.c
index 23ee1a423654..a29ac9bae6d5 100644
--- a/drivers/i2c/busses/i2c-cadence.c
+++ b/drivers/i2c/busses/i2c-cadence.c
@@ -511,7 +511,7 @@ static void cdns_i2c_master_reset(struct i2c_adapter *adap)
 static int cdns_i2c_process_msg(struct cdns_i2c *id, struct i2c_msg *msg,
 		struct i2c_adapter *adap)
 {
-	unsigned long time_left;
+	unsigned long time_left, msg_timeout;
 	u32 reg;
 
 	id->p_msg = msg;
@@ -536,8 +536,16 @@ static int cdns_i2c_process_msg(struct cdns_i2c *id, struct i2c_msg *msg,
 	else
 		cdns_i2c_msend(id);
 
+	/* Minimal time to execute this message */
+	msg_timeout = msecs_to_jiffies((1000 * msg->len * BITS_PER_BYTE) / id->i2c_clk);
+	/* Plus some wiggle room */
+	msg_timeout += msecs_to_jiffies(500);
+
+	if (msg_timeout < adap->timeout)
+		msg_timeout = adap->timeout;
+
 	/* Wait for the signal of completion */
-	time_left = wait_for_completion_timeout(&id->xfer_done, adap->timeout);
+	time_left = wait_for_completion_timeout(&id->xfer_done, msg_timeout);
 	if (time_left == 0) {
 		cdns_i2c_master_reset(adap);
 		dev_err(id->adap.dev.parent,
diff --git a/drivers/i2c/busses/i2c-thunderx-pcidrv.c b/drivers/i2c/busses/i2c-thunderx-pcidrv.c
index bba5b429f69c..3298483bb9b4 100644
--- a/drivers/i2c/busses/i2c-thunderx-pcidrv.c
+++ b/drivers/i2c/busses/i2c-thunderx-pcidrv.c
@@ -208,6 +208,7 @@ static int thunder_i2c_probe_pci(struct pci_dev *pdev,
 	i2c->adap.bus_recovery_info = &octeon_i2c_recovery_info;
 	i2c->adap.dev.parent = dev;
 	i2c->adap.dev.of_node = pdev->dev.of_node;
+	i2c->adap.dev.fwnode = dev->fwnode;
 	snprintf(i2c->adap.name, sizeof(i2c->adap.name),
 		 "Cavium ThunderX i2c adapter at %s", dev_name(dev));
 	i2c_set_adapdata(&i2c->adap, i2c);
diff --git a/drivers/iio/dac/ad5446.c b/drivers/iio/dac/ad5446.c
index d3a3d62869d8..86de972f41b1 100644
--- a/drivers/iio/dac/ad5446.c
+++ b/drivers/iio/dac/ad5446.c
@@ -171,7 +171,7 @@ static int ad5446_read_raw(struct iio_dev *indio_dev,
 
 	switch (m) {
 	case IIO_CHAN_INFO_RAW:
-		*val = st->cached_val;
+		*val = st->cached_val >> chan->scan_type.shift;
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		*val = st->vref_mv;
diff --git a/drivers/iio/dac/ad5592r-base.c b/drivers/iio/dac/ad5592r-base.c
index 5c998ac8c840..126bb8349363 100644
--- a/drivers/iio/dac/ad5592r-base.c
+++ b/drivers/iio/dac/ad5592r-base.c
@@ -532,7 +532,7 @@ static int ad5592r_alloc_channels(struct ad5592r_state *st)
 		if (!ret)
 			st->channel_modes[reg] = tmp;
 
-		fwnode_property_read_u32(child, "adi,off-state", &tmp);
+		ret = fwnode_property_read_u32(child, "adi,off-state", &tmp);
 		if (!ret)
 			st->channel_offstate[reg] = tmp;
 	}
diff --git a/drivers/iio/dummy/iio_simple_dummy.c b/drivers/iio/dummy/iio_simple_dummy.c
index ad3410e528b6..7fef76f0b5c7 100644
--- a/drivers/iio/dummy/iio_simple_dummy.c
+++ b/drivers/iio/dummy/iio_simple_dummy.c
@@ -572,10 +572,9 @@ static struct iio_sw_device *iio_dummy_probe(const char *name)
 	struct iio_sw_device *swd;
 
 	swd = kzalloc(sizeof(*swd), GFP_KERNEL);
-	if (!swd) {
-		ret = -ENOMEM;
-		goto error_kzalloc;
-	}
+	if (!swd)
+		return ERR_PTR(-ENOMEM);
+
 	/*
 	 * Allocate an IIO device.
 	 *
@@ -587,7 +586,7 @@ static struct iio_sw_device *iio_dummy_probe(const char *name)
 	indio_dev = iio_device_alloc(sizeof(*st));
 	if (!indio_dev) {
 		ret = -ENOMEM;
-		goto error_ret;
+		goto error_free_swd;
 	}
 
 	st = iio_priv(indio_dev);
@@ -618,6 +617,10 @@ static struct iio_sw_device *iio_dummy_probe(const char *name)
 	 *    indio_dev->name = spi_get_device_id(spi)->name;
 	 */
 	indio_dev->name = kstrdup(name, GFP_KERNEL);
+	if (!indio_dev->name) {
+		ret = -ENOMEM;
+		goto error_free_device;
+	}
 
 	/* Provide description of available channels */
 	indio_dev->channels = iio_dummy_channels;
@@ -634,7 +637,7 @@ static struct iio_sw_device *iio_dummy_probe(const char *name)
 
 	ret = iio_simple_dummy_events_register(indio_dev);
 	if (ret < 0)
-		goto error_free_device;
+		goto error_free_name;
 
 	ret = iio_simple_dummy_configure_buffer(indio_dev);
 	if (ret < 0)
@@ -651,11 +654,12 @@ static struct iio_sw_device *iio_dummy_probe(const char *name)
 	iio_simple_dummy_unconfigure_buffer(indio_dev);
 error_unregister_events:
 	iio_simple_dummy_events_unregister(indio_dev);
+error_free_name:
+	kfree(indio_dev->name);
 error_free_device:
 	iio_device_free(indio_dev);
-error_ret:
+error_free_swd:
 	kfree(swd);
-error_kzalloc:
 	return ERR_PTR(ret);
 }
 
diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index 2a4e23e20ebc..a0787b1835e5 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -404,6 +404,7 @@ static int ak8975_power_on(const struct ak8975_data *data)
 	if (ret) {
 		dev_warn(&data->client->dev,
 			 "Failed to enable specified Vid supply\n");
+		regulator_disable(data->vdd);
 		return ret;
 	}
 	/*
diff --git a/drivers/infiniband/hw/hfi1/init.c b/drivers/infiniband/hw/hfi1/init.c
index 93ace2609bdd..9d90017a1406 100644
--- a/drivers/infiniband/hw/hfi1/init.c
+++ b/drivers/infiniband/hw/hfi1/init.c
@@ -371,7 +371,7 @@ void set_link_ipg(struct hfi1_pportdata *ppd)
 	u16 shift, mult;
 	u64 src;
 	u32 current_egress_rate; /* Mbits /sec */
-	u32 max_pkt_time;
+	u64 max_pkt_time;
 	/*
 	 * max_pkt_time is the maximum packet egress time in units
 	 * of the fabric clock period 1/(805 MHz).
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 463c4b3e7366..4553bed5353e 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -677,7 +677,7 @@ int rxe_requester(void *arg)
 	opcode = next_opcode(qp, wqe, wqe->wr.opcode);
 	if (unlikely(opcode < 0)) {
 		wqe->status = IB_WC_LOC_QP_OP_ERR;
-		goto exit;
+		goto err;
 	}
 
 	mask = rxe_opcode[opcode].mask;
diff --git a/drivers/input/input.c b/drivers/input/input.c
index 5d94fc3fce0b..378717d1b3b4 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -50,6 +50,17 @@ static DEFINE_MUTEX(input_mutex);
 
 static const struct input_value input_value_sync = { EV_SYN, SYN_REPORT, 1 };
 
+static const unsigned int input_max_code[EV_CNT] = {
+	[EV_KEY] = KEY_MAX,
+	[EV_REL] = REL_MAX,
+	[EV_ABS] = ABS_MAX,
+	[EV_MSC] = MSC_MAX,
+	[EV_SW] = SW_MAX,
+	[EV_LED] = LED_MAX,
+	[EV_SND] = SND_MAX,
+	[EV_FF] = FF_MAX,
+};
+
 static inline int is_event_supported(unsigned int code,
 				     unsigned long *bm, unsigned int max)
 {
@@ -1913,6 +1924,14 @@ EXPORT_SYMBOL(input_free_device);
  */
 void input_set_capability(struct input_dev *dev, unsigned int type, unsigned int code)
 {
+	if (type < EV_CNT && input_max_code[type] &&
+	    code > input_max_code[type]) {
+		pr_err("%s: invalid code %u for type %u\n", __func__, code,
+		       type);
+		dump_stack();
+		return;
+	}
+
 	switch (type) {
 	case EV_KEY:
 		__set_bit(code, dev->keybit);
diff --git a/drivers/input/misc/sparcspkr.c b/drivers/input/misc/sparcspkr.c
index 4a5afc7fe96e..f6e1f38267d9 100644
--- a/drivers/input/misc/sparcspkr.c
+++ b/drivers/input/misc/sparcspkr.c
@@ -204,6 +204,7 @@ static int bbc_beep_probe(struct platform_device *op)
 
 	info = &state->u.bbc;
 	info->clock_freq = of_getintprop_default(dp, "clock-frequency", 0);
+	of_node_put(dp);
 	if (!info->clock_freq)
 		goto out_free;
 
diff --git a/drivers/input/mouse/bcm5974.c b/drivers/input/mouse/bcm5974.c
index 30e3442518f8..0daf27ed4b16 100644
--- a/drivers/input/mouse/bcm5974.c
+++ b/drivers/input/mouse/bcm5974.c
@@ -956,17 +956,22 @@ static int bcm5974_probe(struct usb_interface *iface,
 	if (!dev->tp_data)
 		goto err_free_bt_buffer;
 
-	if (dev->bt_urb)
+	if (dev->bt_urb) {
 		usb_fill_int_urb(dev->bt_urb, udev,
 				 usb_rcvintpipe(udev, cfg->bt_ep),
 				 dev->bt_data, dev->cfg.bt_datalen,
 				 bcm5974_irq_button, dev, 1);
 
+		dev->bt_urb->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
+	}
+
 	usb_fill_int_urb(dev->tp_urb, udev,
 			 usb_rcvintpipe(udev, cfg->tp_ep),
 			 dev->tp_data, dev->cfg.tp_datalen,
 			 bcm5974_irq_trackpad, dev, 1);
 
+	dev->tp_urb->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
+
 	/* create bcm5974 device */
 	usb_make_path(udev, dev->phys, sizeof(dev->phys));
 	strlcat(dev->phys, "/input0", sizeof(dev->phys));
diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 45c809f3d24f..03bf538eabda 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -86,7 +86,7 @@
 #define ACPI_DEVFLAG_LINT1              0x80
 #define ACPI_DEVFLAG_ATSDIS             0x10000000
 
-#define LOOP_TIMEOUT	100000
+#define LOOP_TIMEOUT	2000000
 /*
  * ACPI table definitions
  *
diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index b09692bb5b0a..df65464fffd4 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -580,16 +580,19 @@ static void insert_iommu_master(struct device *dev,
 static int qcom_iommu_of_xlate(struct device *dev,
 			       struct of_phandle_args *spec)
 {
-	struct msm_iommu_dev *iommu;
+	struct msm_iommu_dev *iommu = NULL, *iter;
 	unsigned long flags;
 	int ret = 0;
 
 	spin_lock_irqsave(&msm_iommu_lock, flags);
-	list_for_each_entry(iommu, &qcom_iommu_devices, dev_node)
-		if (iommu->dev->of_node == spec->np)
+	list_for_each_entry(iter, &qcom_iommu_devices, dev_node) {
+		if (iter->dev->of_node == spec->np) {
+			iommu = iter;
 			break;
+		}
+	}
 
-	if (!iommu || iommu->dev->of_node != spec->np) {
+	if (!iommu) {
 		ret = -ENODEV;
 		goto fail;
 	}
diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
index ace01a626b09..75ce43ea7980 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -312,7 +312,16 @@ static void armada_xp_mpic_smp_cpu_init(void)
 
 static void armada_xp_mpic_perf_init(void)
 {
-	unsigned long cpuid = cpu_logical_map(smp_processor_id());
+	unsigned long cpuid;
+
+	/*
+	 * This Performance Counter Overflow interrupt is specific for
+	 * Armada 370 and XP. It is not available on Armada 375, 38x and 39x.
+	 */
+	if (!of_machine_is_compatible("marvell,armada-370-xp"))
+		return;
+
+	cpuid = cpu_logical_map(smp_processor_id());
 
 	/* Enable Performance Counter Overflow interrupts */
 	writel(ARMADA_370_XP_INT_CAUSE_PERF(cpuid),
diff --git a/drivers/irqchip/irq-xtensa-mx.c b/drivers/irqchip/irq-xtensa-mx.c
index 72a391e01011..1082f5284cd9 100644
--- a/drivers/irqchip/irq-xtensa-mx.c
+++ b/drivers/irqchip/irq-xtensa-mx.c
@@ -139,14 +139,25 @@ static struct irq_chip xtensa_mx_irq_chip = {
 	.irq_set_affinity = xtensa_mx_irq_set_affinity,
 };
 
+static void __init xtensa_mx_init_common(struct irq_domain *root_domain)
+{
+	unsigned int i;
+
+	irq_set_default_host(root_domain);
+	secondary_init_irq();
+
+	/* Initialize default IRQ routing to CPU 0 */
+	for (i = 0; i < XCHAL_NUM_EXTINTERRUPTS; ++i)
+		set_er(1, MIROUT(i));
+}
+
 int __init xtensa_mx_init_legacy(struct device_node *interrupt_parent)
 {
 	struct irq_domain *root_domain =
 		irq_domain_add_legacy(NULL, NR_IRQS - 1, 1, 0,
 				&xtensa_mx_irq_domain_ops,
 				&xtensa_mx_irq_chip);
-	irq_set_default_host(root_domain);
-	secondary_init_irq();
+	xtensa_mx_init_common(root_domain);
 	return 0;
 }
 
@@ -156,8 +167,7 @@ static int __init xtensa_mx_init(struct device_node *np,
 	struct irq_domain *root_domain =
 		irq_domain_add_linear(np, NR_IRQS, &xtensa_mx_irq_domain_ops,
 				&xtensa_mx_irq_chip);
-	irq_set_default_host(root_domain);
-	secondary_init_irq();
+	xtensa_mx_init_common(root_domain);
 	return 0;
 }
 IRQCHIP_DECLARE(xtensa_mx_irq_chip, "cdns,xtensa-mx", xtensa_mx_init);
diff --git a/drivers/lightnvm/Kconfig b/drivers/lightnvm/Kconfig
index 2f5d5f4a4c75..c2823d84cfa6 100644
--- a/drivers/lightnvm/Kconfig
+++ b/drivers/lightnvm/Kconfig
@@ -4,7 +4,7 @@
 
 menuconfig NVM
 	bool "Open-Channel SSD target support"
-	depends on BLOCK && HAS_DMA
+	depends on BLOCK && HAS_DMA && BROKEN
 	help
 	  Say Y here to get to enable Open-channel SSDs.
 
diff --git a/drivers/macintosh/Kconfig b/drivers/macintosh/Kconfig
index d28690f6e262..9e226e143473 100644
--- a/drivers/macintosh/Kconfig
+++ b/drivers/macintosh/Kconfig
@@ -87,6 +87,10 @@ config ADB_PMU
 	  this device; you should do so if your machine is one of those
 	  mentioned above.
 
+config ADB_PMU_EVENT
+	def_bool y
+	depends on ADB_PMU && INPUT=y
+
 config ADB_PMU_LED
 	bool "Support for the Power/iBook front LED"
 	depends on ADB_PMU
diff --git a/drivers/macintosh/Makefile b/drivers/macintosh/Makefile
index 383ba920085b..8513c8aa2faf 100644
--- a/drivers/macintosh/Makefile
+++ b/drivers/macintosh/Makefile
@@ -11,7 +11,8 @@ obj-$(CONFIG_MAC_EMUMOUSEBTN)	+= mac_hid.o
 obj-$(CONFIG_INPUT_ADBHID)	+= adbhid.o
 obj-$(CONFIG_ANSLCD)		+= ans-lcd.o
 
-obj-$(CONFIG_ADB_PMU)		+= via-pmu.o via-pmu-event.o
+obj-$(CONFIG_ADB_PMU)		+= via-pmu.o
+obj-$(CONFIG_ADB_PMU_EVENT)	+= via-pmu-event.o
 obj-$(CONFIG_ADB_PMU_LED)	+= via-pmu-led.o
 obj-$(CONFIG_PMAC_BACKLIGHT)	+= via-pmu-backlight.o
 obj-$(CONFIG_ADB_CUDA)		+= via-cuda.o
diff --git a/drivers/macintosh/via-pmu.c b/drivers/macintosh/via-pmu.c
index 32c696799300..9bdb7d2055b1 100644
--- a/drivers/macintosh/via-pmu.c
+++ b/drivers/macintosh/via-pmu.c
@@ -1439,7 +1439,7 @@ pmu_handle_data(unsigned char *data, int len)
 		pmu_pass_intr(data, len);
 		/* len == 6 is probably a bad check. But how do I
 		 * know what PMU versions send what events here? */
-		if (len == 6) {
+		if (IS_ENABLED(CONFIG_ADB_PMU_EVENT) && len == 6) {
 			via_pmu_event(PMU_EVT_POWER, !!(data[1]&8));
 			via_pmu_event(PMU_EVT_LID, data[1]&1);
 		}
diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 0aedd0ebccec..13a5fcca2833 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -1943,6 +1943,11 @@ static int crypt_map(struct dm_target *ti, struct bio *bio)
 	return DM_MAPIO_SUBMITTED;
 }
 
+static char hex2asc(unsigned char c)
+{
+	return c + '0' + ((unsigned)(9 - c) >> 4 & 0x27);
+}
+
 static void crypt_status(struct dm_target *ti, status_type_t type,
 			 unsigned status_flags, char *result, unsigned maxlen)
 {
@@ -1958,10 +1963,12 @@ static void crypt_status(struct dm_target *ti, status_type_t type,
 	case STATUSTYPE_TABLE:
 		DMEMIT("%s ", cc->cipher_string);
 
-		if (cc->key_size > 0)
-			for (i = 0; i < cc->key_size; i++)
-				DMEMIT("%02x", cc->key[i]);
-		else
+		if (cc->key_size > 0) {
+			for (i = 0; i < cc->key_size; i++) {
+				DMEMIT("%c%c", hex2asc(cc->key[i] >> 4),
+				       hex2asc(cc->key[i] & 0xf));
+			}
+		} else
 			DMEMIT("-");
 
 		DMEMIT(" %llu %s %llu", (unsigned long long)cc->iv_offset,
diff --git a/drivers/md/dm-stats.c b/drivers/md/dm-stats.c
index 0250e7e521ab..fdd4a840b30f 100644
--- a/drivers/md/dm-stats.c
+++ b/drivers/md/dm-stats.c
@@ -228,6 +228,7 @@ void dm_stats_cleanup(struct dm_stats *stats)
 				       atomic_read(&shared->in_flight[READ]),
 				       atomic_read(&shared->in_flight[WRITE]));
 			}
+			cond_resched();
 		}
 		dm_stat_free(&s->rcu_head);
 	}
@@ -316,6 +317,7 @@ static int dm_stats_create(struct dm_stats *stats, sector_t start, sector_t end,
 	for (ni = 0; ni < n_entries; ni++) {
 		atomic_set(&s->stat_shared[ni].in_flight[READ], 0);
 		atomic_set(&s->stat_shared[ni].in_flight[WRITE], 0);
+		cond_resched();
 	}
 
 	if (s->n_histogram_entries) {
@@ -328,6 +330,7 @@ static int dm_stats_create(struct dm_stats *stats, sector_t start, sector_t end,
 		for (ni = 0; ni < n_entries; ni++) {
 			s->stat_shared[ni].tmp.histogram = hi;
 			hi += s->n_histogram_entries + 1;
+			cond_resched();
 		}
 	}
 
@@ -348,6 +351,7 @@ static int dm_stats_create(struct dm_stats *stats, sector_t start, sector_t end,
 			for (ni = 0; ni < n_entries; ni++) {
 				p[ni].histogram = hi;
 				hi += s->n_histogram_entries + 1;
+				cond_resched();
 			}
 		}
 	}
@@ -477,6 +481,7 @@ static int dm_stats_list(struct dm_stats *stats, const char *program,
 			}
 			DMEMIT("\n");
 		}
+		cond_resched();
 	}
 	mutex_unlock(&stats->mutex);
 
@@ -753,6 +758,7 @@ static void __dm_stat_clear(struct dm_stat *s, size_t idx_start, size_t idx_end,
 				local_irq_enable();
 			}
 		}
+		cond_resched();
 	}
 }
 
@@ -868,6 +874,8 @@ static int dm_stats_print(struct dm_stats *stats, int id,
 
 		if (unlikely(sz + 1 >= maxlen))
 			goto buffer_overflow;
+
+		cond_resched();
 	}
 
 	if (clear)
diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
index 727f9e571955..bd9d9f183e4b 100644
--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@ -1056,6 +1056,7 @@ static int verity_ctr(struct dm_target *ti, unsigned argc, char **argv)
 
 static struct target_type verity_target = {
 	.name		= "verity",
+	.features	= DM_TARGET_IMMUTABLE,
 	.version	= {1, 3, 0},
 	.module		= THIS_MODULE,
 	.ctr		= verity_ctr,
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index dd154027adc9..ec6c2b566621 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -524,20 +524,19 @@ static void start_io_acct(struct dm_io *io)
 				    false, 0, &io->stats_aux);
 }
 
-static void end_io_acct(struct dm_io *io)
+static void end_io_acct(struct mapped_device *md, struct bio *bio,
+			unsigned long start_time, struct dm_stats_aux *stats_aux)
 {
-	struct mapped_device *md = io->md;
-	struct bio *bio = io->bio;
-	unsigned long duration = jiffies - io->start_time;
+	unsigned long duration = jiffies - start_time;
 	int pending;
 	int rw = bio_data_dir(bio);
 
-	generic_end_io_acct(rw, &dm_disk(md)->part0, io->start_time);
+	generic_end_io_acct(rw, &dm_disk(md)->part0, start_time);
 
 	if (unlikely(dm_stats_used(&md->stats)))
 		dm_stats_account_io(&md->stats, bio_data_dir(bio),
 				    bio->bi_iter.bi_sector, bio_sectors(bio),
-				    true, duration, &io->stats_aux);
+				    true, duration, stats_aux);
 
 	/*
 	 * After this is decremented the bio must not be touched if it is
@@ -768,6 +767,8 @@ static void dec_pending(struct dm_io *io, int error)
 	int io_error;
 	struct bio *bio;
 	struct mapped_device *md = io->md;
+	unsigned long start_time = 0;
+	struct dm_stats_aux stats_aux;
 
 	/* Push-back supersedes any I/O errors */
 	if (unlikely(error)) {
@@ -793,8 +794,10 @@ static void dec_pending(struct dm_io *io, int error)
 
 		io_error = io->error;
 		bio = io->bio;
-		end_io_acct(io);
+		start_time = io->start_time;
+		stats_aux = io->stats_aux;
 		free_io(md, io);
+		end_io_acct(md, bio, start_time, &stats_aux);
 
 		if (io_error == DM_ENDIO_REQUEUE)
 			return;
@@ -2024,6 +2027,8 @@ static int dm_wait_for_completion(struct mapped_device *md, long task_state)
 	}
 	finish_wait(&md->wait, &wait);
 
+	smp_rmb(); /* paired with atomic_dec_return in end_io_acct */
+
 	return r;
 }
 
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 98c72dd56a2d..9e8373e7e287 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -2254,14 +2254,16 @@ static void sync_sbs(struct mddev *mddev, int nospares)
 
 static bool does_sb_need_changing(struct mddev *mddev)
 {
-	struct md_rdev *rdev;
+	struct md_rdev *rdev = NULL, *iter;
 	struct mdp_superblock_1 *sb;
 	int role;
 
 	/* Find a good rdev */
-	rdev_for_each(rdev, mddev)
-		if ((rdev->raid_disk >= 0) && !test_bit(Faulty, &rdev->flags))
+	rdev_for_each(iter, mddev)
+		if ((iter->raid_disk >= 0) && !test_bit(Faulty, &iter->flags)) {
+			rdev = iter;
 			break;
+		}
 
 	/* No good device found. */
 	if (!rdev)
@@ -7252,17 +7254,22 @@ EXPORT_SYMBOL(md_register_thread);
 
 void md_unregister_thread(struct md_thread **threadp)
 {
-	struct md_thread *thread = *threadp;
-	if (!thread)
-		return;
-	pr_debug("interrupting MD-thread pid %d\n", task_pid_nr(thread->tsk));
-	/* Locking ensures that mddev_unlock does not wake_up a
+	struct md_thread *thread;
+
+	/*
+	 * Locking ensures that mddev_unlock does not wake_up a
 	 * non-existent thread
 	 */
 	spin_lock(&pers_lock);
+	thread = *threadp;
+	if (!thread) {
+		spin_unlock(&pers_lock);
+		return;
+	}
 	*threadp = NULL;
 	spin_unlock(&pers_lock);
 
+	pr_debug("interrupting MD-thread pid %d\n", task_pid_nr(thread->tsk));
 	kthread_stop(thread->tsk);
 	kfree(thread);
 }
@@ -8880,16 +8887,18 @@ static int read_rdev(struct mddev *mddev, struct md_rdev *rdev)
 
 void md_reload_sb(struct mddev *mddev, int nr)
 {
-	struct md_rdev *rdev;
+	struct md_rdev *rdev = NULL, *iter;
 	int err;
 
 	/* Find the rdev */
-	rdev_for_each_rcu(rdev, mddev) {
-		if (rdev->desc_nr == nr)
+	rdev_for_each_rcu(iter, mddev) {
+		if (iter->desc_nr == nr) {
+			rdev = iter;
 			break;
+		}
 	}
 
-	if (!rdev || rdev->desc_nr != nr) {
+	if (!rdev) {
 		pr_warn("%s: %d Could not find rdev with nr %d\n", __func__, __LINE__, nr);
 		return;
 	}
diff --git a/drivers/media/pci/cx25821/cx25821-core.c b/drivers/media/pci/cx25821/cx25821-core.c
index d58c58e61bde..acd896ca1339 100644
--- a/drivers/media/pci/cx25821/cx25821-core.c
+++ b/drivers/media/pci/cx25821/cx25821-core.c
@@ -1354,11 +1354,11 @@ static void cx25821_finidev(struct pci_dev *pci_dev)
 	struct cx25821_dev *dev = get_cx25821(v4l2_dev);
 
 	cx25821_shutdown(dev);
-	pci_disable_device(pci_dev);
 
 	/* unregister stuff */
 	if (pci_dev->irq)
 		free_irq(pci_dev->irq, dev);
+	pci_disable_device(pci_dev);
 
 	cx25821_dev_unregister(dev);
 	v4l2_device_unregister(v4l2_dev);
diff --git a/drivers/media/platform/exynos4-is/fimc-is.c b/drivers/media/platform/exynos4-is/fimc-is.c
index f9456f26ff4f..590ec04de827 100644
--- a/drivers/media/platform/exynos4-is/fimc-is.c
+++ b/drivers/media/platform/exynos4-is/fimc-is.c
@@ -144,7 +144,7 @@ static int fimc_is_enable_clocks(struct fimc_is *is)
 			dev_err(&is->pdev->dev, "clock %s enable failed\n",
 				fimc_is_clocks[i]);
 			for (--i; i >= 0; i--)
-				clk_disable(is->clocks[i]);
+				clk_disable_unprepare(is->clocks[i]);
 			return ret;
 		}
 		pr_debug("enabled clock: %s\n", fimc_is_clocks[i]);
diff --git a/drivers/media/platform/exynos4-is/fimc-isp-video.h b/drivers/media/platform/exynos4-is/fimc-isp-video.h
index f79a1b348aa6..67ef85249912 100644
--- a/drivers/media/platform/exynos4-is/fimc-isp-video.h
+++ b/drivers/media/platform/exynos4-is/fimc-isp-video.h
@@ -35,7 +35,7 @@ static inline int fimc_isp_video_device_register(struct fimc_isp *isp,
 	return 0;
 }
 
-void fimc_isp_video_device_unregister(struct fimc_isp *isp,
+static inline void fimc_isp_video_device_unregister(struct fimc_isp *isp,
 				enum v4l2_buf_type type)
 {
 }
diff --git a/drivers/media/usb/pvrusb2/pvrusb2-hdw.c b/drivers/media/usb/pvrusb2/pvrusb2-hdw.c
index 40535db585a0..b868a77a048c 100644
--- a/drivers/media/usb/pvrusb2/pvrusb2-hdw.c
+++ b/drivers/media/usb/pvrusb2/pvrusb2-hdw.c
@@ -2615,6 +2615,11 @@ struct pvr2_hdw *pvr2_hdw_create(struct usb_interface *intf,
 	} while (0);
 	mutex_unlock(&pvr2_unit_mtx);
 
+	INIT_WORK(&hdw->workpoll, pvr2_hdw_worker_poll);
+
+	if (hdw->unit_number == -1)
+		goto fail;
+
 	cnt1 = 0;
 	cnt2 = scnprintf(hdw->name+cnt1,sizeof(hdw->name)-cnt1,"pvrusb2");
 	cnt1 += cnt2;
@@ -2626,8 +2631,6 @@ struct pvr2_hdw *pvr2_hdw_create(struct usb_interface *intf,
 	if (cnt1 >= sizeof(hdw->name)) cnt1 = sizeof(hdw->name)-1;
 	hdw->name[cnt1] = 0;
 
-	INIT_WORK(&hdw->workpoll,pvr2_hdw_worker_poll);
-
 	pvr2_trace(PVR2_TRACE_INIT,"Driver unit number is %d, name is %s",
 		   hdw->unit_number,hdw->name);
 
diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
index 2b1e06e825f0..53d81ef9a4be 100644
--- a/drivers/media/usb/uvc/uvc_v4l2.c
+++ b/drivers/media/usb/uvc/uvc_v4l2.c
@@ -846,29 +846,31 @@ static int uvc_ioctl_enum_input(struct file *file, void *fh,
 	struct uvc_video_chain *chain = handle->chain;
 	const struct uvc_entity *selector = chain->selector;
 	struct uvc_entity *iterm = NULL;
+	struct uvc_entity *it;
 	u32 index = input->index;
-	int pin = 0;
 
 	if (selector == NULL ||
 	    (chain->dev->quirks & UVC_QUIRK_IGNORE_SELECTOR_UNIT)) {
 		if (index != 0)
 			return -EINVAL;
-		list_for_each_entry(iterm, &chain->entities, chain) {
-			if (UVC_ENTITY_IS_ITERM(iterm))
+		list_for_each_entry(it, &chain->entities, chain) {
+			if (UVC_ENTITY_IS_ITERM(it)) {
+				iterm = it;
 				break;
+			}
 		}
-		pin = iterm->id;
 	} else if (index < selector->bNrInPins) {
-		pin = selector->baSourceID[index];
-		list_for_each_entry(iterm, &chain->entities, chain) {
-			if (!UVC_ENTITY_IS_ITERM(iterm))
+		list_for_each_entry(it, &chain->entities, chain) {
+			if (!UVC_ENTITY_IS_ITERM(it))
 				continue;
-			if (iterm->id == pin)
+			if (it->id == selector->baSourceID[index]) {
+				iterm = it;
 				break;
+			}
 		}
 	}
 
-	if (iterm == NULL || iterm->id != pin)
+	if (iterm == NULL)
 		return -EINVAL;
 
 	memset(input, 0, sizeof(*input));
diff --git a/drivers/mfd/ipaq-micro.c b/drivers/mfd/ipaq-micro.c
index df16fd1df68b..b03489268252 100644
--- a/drivers/mfd/ipaq-micro.c
+++ b/drivers/mfd/ipaq-micro.c
@@ -418,7 +418,7 @@ static int __init micro_probe(struct platform_device *pdev)
 	micro_reset_comm(micro);
 
 	irq = platform_get_irq(pdev, 0);
-	if (!irq)
+	if (irq < 0)
 		return -EINVAL;
 	ret = devm_request_irq(&pdev->dev, irq, micro_serial_isr,
 			       IRQF_SHARED, "ipaq-micro",
diff --git a/drivers/mfd/rtsx_usb.c b/drivers/mfd/rtsx_usb.c
index 691dab791f7a..e94f855eac15 100644
--- a/drivers/mfd/rtsx_usb.c
+++ b/drivers/mfd/rtsx_usb.c
@@ -678,6 +678,7 @@ static int rtsx_usb_probe(struct usb_interface *intf,
 	return 0;
 
 out_init_fail:
+	usb_set_intfdata(ucr->pusb_intf, NULL);
 	usb_free_coherent(ucr->pusb_dev, IOBUF_SIZE, ucr->iobuf,
 			ucr->iobuf_dma);
 	return ret;
diff --git a/drivers/misc/lkdtm_usercopy.c b/drivers/misc/lkdtm_usercopy.c
index 1dd611423d8b..36438947244d 100644
--- a/drivers/misc/lkdtm_usercopy.c
+++ b/drivers/misc/lkdtm_usercopy.c
@@ -28,12 +28,12 @@ static const unsigned char test_text[] = "This is a test.\n";
  */
 static noinline unsigned char *trick_compiler(unsigned char *stack)
 {
-	return stack + 0;
+	return stack + unconst;
 }
 
 static noinline unsigned char *do_usercopy_stack_callee(int value)
 {
-	unsigned char buf[32];
+	unsigned char buf[128];
 	int i;
 
 	/* Exercise stack to avoid everything living in registers. */
@@ -41,7 +41,12 @@ static noinline unsigned char *do_usercopy_stack_callee(int value)
 		buf[i] = value & 0xff;
 	}
 
-	return trick_compiler(buf);
+	/*
+	 * Put the target buffer in the middle of stack allocation
+	 * so that we don't step on future stack users regardless
+	 * of stack growth direction.
+	 */
+	return trick_compiler(&buf[(128/2)-32]);
 }
 
 static noinline void do_usercopy_stack(bool to_user, bool bad_frame)
@@ -64,6 +69,12 @@ static noinline void do_usercopy_stack(bool to_user, bool bad_frame)
 		bad_stack -= sizeof(unsigned long);
 	}
 
+#ifdef ARCH_HAS_CURRENT_STACK_POINTER
+	pr_info("stack     : %px\n", (void *)current_stack_pointer);
+#endif
+	pr_info("good_stack: %px-%px\n", good_stack, good_stack + sizeof(good_stack));
+	pr_info("bad_stack : %px-%px\n", bad_stack, bad_stack + sizeof(good_stack));
+
 	user_addr = vm_mmap(NULL, 0, PAGE_SIZE,
 			    PROT_READ | PROT_WRITE | PROT_EXEC,
 			    MAP_ANONYMOUS | MAP_PRIVATE, 0);
diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 709a872ed484..7b8c72a07900 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -1192,7 +1192,7 @@ static int mmc_blk_issue_discard_rq(struct mmc_queue *mq, struct request *req)
 				 arg == MMC_TRIM_ARG ?
 				 INAND_CMD38_ARG_TRIM :
 				 INAND_CMD38_ARG_ERASE,
-				 0);
+				 card->ext_csd.generic_cmd6_time);
 		if (err)
 			goto out;
 	}
@@ -1235,7 +1235,7 @@ static int mmc_blk_issue_secdiscard_rq(struct mmc_queue *mq,
 				 arg == MMC_SECURE_TRIM1_ARG ?
 				 INAND_CMD38_ARG_SECTRIM1 :
 				 INAND_CMD38_ARG_SECERASE,
-				 0);
+				 card->ext_csd.generic_cmd6_time);
 		if (err)
 			goto out_retry;
 	}
@@ -1251,7 +1251,7 @@ static int mmc_blk_issue_secdiscard_rq(struct mmc_queue *mq,
 			err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 					 INAND_CMD38_ARG_EXT_CSD,
 					 INAND_CMD38_ARG_SECTRIM2,
-					 0);
+					 card->ext_csd.generic_cmd6_time);
 			if (err)
 				goto out_retry;
 		}
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index f0fa6a799f7c..dfe55e9d729f 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -61,6 +61,8 @@
 /* The max erase timeout, used when host->max_busy_timeout isn't specified */
 #define MMC_ERASE_TIMEOUT_MS	(60 * 1000) /* 60 s */
 
+#define MMC_CACHE_FLUSH_TIMEOUT_MS     (30 * 1000) /* 30s */
+
 static const unsigned freqs[] = { 400000, 300000, 200000, 100000 };
 
 /*
@@ -2936,7 +2938,8 @@ int mmc_flush_cache(struct mmc_card *card)
 			(card->ext_csd.cache_size > 0) &&
 			(card->ext_csd.cache_ctrl & 1)) {
 		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
-				EXT_CSD_FLUSH_CACHE, 1, 0);
+				EXT_CSD_FLUSH_CACHE, 1,
+				 MMC_CACHE_FLUSH_TIMEOUT_MS);
 		if (err)
 			pr_err("%s: cache flush error %d\n",
 					mmc_hostname(card->host), err);
diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index ad6e9798e949..3d8907fc2a52 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -22,8 +22,6 @@
 #include "host.h"
 #include "mmc_ops.h"
 
-#define MMC_OPS_TIMEOUT_MS	(10 * 60 * 1000) /* 10 minute timeout */
-
 static const u8 tuning_blk_pattern_4bit[] = {
 	0xff, 0x0f, 0xff, 0x00, 0xff, 0xcc, 0xc3, 0xcc,
 	0xc3, 0x3c, 0xcc, 0xff, 0xfe, 0xff, 0xfe, 0xef,
@@ -530,8 +528,11 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 		ignore_crc = false;
 
 	/* We have an unspecified cmd timeout, use the fallback value. */
-	if (!timeout_ms)
-		timeout_ms = MMC_OPS_TIMEOUT_MS;
+	if (!timeout_ms) {
+		pr_warn("%s: unspecified timeout for CMD6 - use generic\n",
+			mmc_hostname(host));
+		timeout_ms = card->ext_csd.generic_cmd6_time;
+	}
 
 	/* Must check status to be sure of no errors. */
 	timeout = jiffies + msecs_to_jiffies(timeout_ms) + 1;
diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
index efd995e3cb0b..2c56f094b497 100644
--- a/drivers/mmc/host/rtsx_pci_sdmmc.c
+++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
@@ -49,10 +49,7 @@ struct realtek_pci_sdmmc {
 	bool			double_clk;
 	bool			eject;
 	bool			initial_mode;
-	int			power_state;
-#define SDMMC_POWER_ON		1
-#define SDMMC_POWER_OFF		0
-
+	int			prev_power_state;
 	int			sg_count;
 	s32			cookie;
 	int			cookie_sg_count;
@@ -914,14 +911,21 @@ static int sd_set_bus_width(struct realtek_pci_sdmmc *host,
 	return err;
 }
 
-static int sd_power_on(struct realtek_pci_sdmmc *host)
+static int sd_power_on(struct realtek_pci_sdmmc *host, unsigned char power_mode)
 {
 	struct rtsx_pcr *pcr = host->pcr;
 	int err;
 
-	if (host->power_state == SDMMC_POWER_ON)
+	if (host->prev_power_state == MMC_POWER_ON)
 		return 0;
 
+	if (host->prev_power_state == MMC_POWER_UP) {
+		rtsx_pci_write_register(pcr, SD_BUS_STAT, SD_CLK_TOGGLE_EN, 0);
+		goto finish;
+	}
+
+	msleep(100);
+
 	rtsx_pci_init_cmd(pcr);
 	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, CARD_SELECT, 0x07, SD_MOD_SEL);
 	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, CARD_SHARE_MODE,
@@ -940,11 +944,17 @@ static int sd_power_on(struct realtek_pci_sdmmc *host)
 	if (err < 0)
 		return err;
 
+	mdelay(1);
+
 	err = rtsx_pci_write_register(pcr, CARD_OE, SD_OUTPUT_EN, SD_OUTPUT_EN);
 	if (err < 0)
 		return err;
 
-	host->power_state = SDMMC_POWER_ON;
+	/* send at least 74 clocks */
+	rtsx_pci_write_register(pcr, SD_BUS_STAT, SD_CLK_TOGGLE_EN, SD_CLK_TOGGLE_EN);
+
+finish:
+	host->prev_power_state = power_mode;
 	return 0;
 }
 
@@ -953,7 +963,7 @@ static int sd_power_off(struct realtek_pci_sdmmc *host)
 	struct rtsx_pcr *pcr = host->pcr;
 	int err;
 
-	host->power_state = SDMMC_POWER_OFF;
+	host->prev_power_state = MMC_POWER_OFF;
 
 	rtsx_pci_init_cmd(pcr);
 
@@ -979,7 +989,7 @@ static int sd_set_power_mode(struct realtek_pci_sdmmc *host,
 	if (power_mode == MMC_POWER_OFF)
 		err = sd_power_off(host);
 	else
-		err = sd_power_on(host);
+		err = sd_power_on(host, power_mode);
 
 	return err;
 }
@@ -1417,7 +1427,7 @@ static int rtsx_pci_sdmmc_drv_probe(struct platform_device *pdev)
 	host->mmc = mmc;
 	host->pdev = pdev;
 	host->cookie = -1;
-	host->power_state = SDMMC_POWER_OFF;
+	host->prev_power_state = MMC_POWER_OFF;
 	INIT_WORK(&host->work, sd_request);
 	platform_set_drvdata(pdev, host);
 	pcr->slots[RTSX_SD_CARD].p_dev = pdev;
diff --git a/drivers/mtd/chips/cfi_cmdset_0002.c b/drivers/mtd/chips/cfi_cmdset_0002.c
index 3c4819a05bf0..a2b12d347f4d 100644
--- a/drivers/mtd/chips/cfi_cmdset_0002.c
+++ b/drivers/mtd/chips/cfi_cmdset_0002.c
@@ -49,6 +49,10 @@
 #define SST49LF008A		0x005a
 #define AT49BV6416		0x00d6
 
+enum cfi_quirks {
+	CFI_QUIRK_DQ_TRUE_DATA = BIT(0),
+};
+
 static int cfi_amdstd_read (struct mtd_info *, loff_t, size_t, size_t *, u_char *);
 static int cfi_amdstd_write_words(struct mtd_info *, loff_t, size_t, size_t *, const u_char *);
 static int cfi_amdstd_write_buffers(struct mtd_info *, loff_t, size_t, size_t *, const u_char *);
@@ -361,6 +365,15 @@ static void fixup_s29ns512p_sectors(struct mtd_info *mtd)
 	pr_warning("%s: Bad S29NS512P CFI data; adjust to 512 sectors\n", mtd->name);
 }
 
+static void fixup_quirks(struct mtd_info *mtd)
+{
+	struct map_info *map = mtd->priv;
+	struct cfi_private *cfi = map->fldrv_priv;
+
+	if (cfi->mfr == CFI_MFR_AMD && cfi->id == 0x0c01)
+		cfi->quirks |= CFI_QUIRK_DQ_TRUE_DATA;
+}
+
 /* Used to fix CFI-Tables of chips without Extended Query Tables */
 static struct cfi_fixup cfi_nopri_fixup_table[] = {
 	{ CFI_MFR_SST, 0x234a, fixup_sst39vf }, /* SST39VF1602 */
@@ -399,6 +412,7 @@ static struct cfi_fixup cfi_fixup_table[] = {
 #if !FORCE_WORD_WRITE
 	{ CFI_MFR_ANY, CFI_ID_ANY, fixup_use_write_buffers },
 #endif
+	{ CFI_MFR_ANY, CFI_ID_ANY, fixup_quirks },
 	{ 0, 0, NULL }
 };
 static struct cfi_fixup jedec_fixup_table[] = {
@@ -726,50 +740,46 @@ static struct mtd_info *cfi_amdstd_setup(struct mtd_info *mtd)
 }
 
 /*
- * Return true if the chip is ready.
+ * Return true if the chip is ready and has the correct value.
  *
  * Ready is one of: read mode, query mode, erase-suspend-read mode (in any
  * non-suspended sector) and is indicated by no toggle bits toggling.
  *
+ * Error are indicated by toggling bits or bits held with the wrong value,
+ * or with bits toggling.
+ *
  * Note that anything more complicated than checking if no bits are toggling
  * (including checking DQ5 for an error status) is tricky to get working
  * correctly and is therefore not done	(particularly with interleaved chips
  * as each chip must be checked independently of the others).
  */
-static int __xipram chip_ready(struct map_info *map, unsigned long addr)
+static int __xipram chip_ready(struct map_info *map, unsigned long addr,
+			       map_word *expected)
 {
 	map_word d, t;
+	int ret;
 
 	d = map_read(map, addr);
 	t = map_read(map, addr);
 
-	return map_word_equal(map, d, t);
+	ret = map_word_equal(map, d, t);
+
+	if (!ret || !expected)
+		return ret;
+
+	return map_word_equal(map, t, *expected);
 }
 
-/*
- * Return true if the chip is ready and has the correct value.
- *
- * Ready is one of: read mode, query mode, erase-suspend-read mode (in any
- * non-suspended sector) and it is indicated by no bits toggling.
- *
- * Error are indicated by toggling bits or bits held with the wrong value,
- * or with bits toggling.
- *
- * Note that anything more complicated than checking if no bits are toggling
- * (including checking DQ5 for an error status) is tricky to get working
- * correctly and is therefore not done	(particularly with interleaved chips
- * as each chip must be checked independently of the others).
- *
- */
-static int __xipram chip_good(struct map_info *map, unsigned long addr, map_word expected)
+static int __xipram chip_good(struct map_info *map, unsigned long addr,
+			      map_word *expected)
 {
-	map_word oldd, curd;
+	struct cfi_private *cfi = map->fldrv_priv;
+	map_word *datum = expected;
 
-	oldd = map_read(map, addr);
-	curd = map_read(map, addr);
+	if (cfi->quirks & CFI_QUIRK_DQ_TRUE_DATA)
+		datum = NULL;
 
-	return	map_word_equal(map, oldd, curd) &&
-		map_word_equal(map, curd, expected);
+	return chip_ready(map, addr, datum);
 }
 
 static int get_chip(struct map_info *map, struct flchip *chip, unsigned long adr, int mode)
@@ -786,7 +796,7 @@ static int get_chip(struct map_info *map, struct flchip *chip, unsigned long adr
 
 	case FL_STATUS:
 		for (;;) {
-			if (chip_ready(map, adr))
+			if (chip_ready(map, adr, NULL))
 				break;
 
 			if (time_after(jiffies, timeo)) {
@@ -824,7 +834,7 @@ static int get_chip(struct map_info *map, struct flchip *chip, unsigned long adr
 		chip->state = FL_ERASE_SUSPENDING;
 		chip->erase_suspended = 1;
 		for (;;) {
-			if (chip_ready(map, adr))
+			if (chip_ready(map, adr, NULL))
 				break;
 
 			if (time_after(jiffies, timeo)) {
@@ -1357,7 +1367,7 @@ static int do_otp_lock(struct map_info *map, struct flchip *chip, loff_t adr,
 	/* wait for chip to become ready */
 	timeo = jiffies + msecs_to_jiffies(2);
 	for (;;) {
-		if (chip_ready(map, adr))
+		if (chip_ready(map, adr, NULL))
 			break;
 
 		if (time_after(jiffies, timeo)) {
@@ -1627,7 +1637,8 @@ static int __xipram do_write_oneword(struct map_info *map, struct flchip *chip,
 		 * We check "time_after" and "!chip_good" before checking
 		 * "chip_good" to avoid the failure due to scheduling.
 		 */
-		if (time_after(jiffies, timeo) && !chip_good(map, adr, datum)) {
+		if (time_after(jiffies, timeo) &&
+		    !chip_good(map, adr, &datum)) {
 			xip_enable(map, chip, adr);
 			printk(KERN_WARNING "MTD %s(): software timeout\n", __func__);
 			xip_disable(map, chip, adr);
@@ -1635,7 +1646,7 @@ static int __xipram do_write_oneword(struct map_info *map, struct flchip *chip,
 			break;
 		}
 
-		if (chip_good(map, adr, datum))
+		if (chip_good(map, adr, &datum))
 			break;
 
 		/* Latency issues. Drop the lock, wait a while and retry */
@@ -1879,13 +1890,13 @@ static int __xipram do_write_buffer(struct map_info *map, struct flchip *chip,
 		}
 
 		/*
-		 * We check "time_after" and "!chip_good" before checking "chip_good" to avoid
-		 * the failure due to scheduling.
+		 * We check "time_after" and "!chip_good" before checking
+		 * "chip_good" to avoid the failure due to scheduling.
 		 */
-		if (time_after(jiffies, timeo) && !chip_good(map, adr, datum))
+		if (time_after(jiffies, timeo) && !chip_good(map, adr, &datum))
 			break;
 
-		if (chip_good(map, adr, datum)) {
+		if (chip_good(map, adr, &datum)) {
 			xip_enable(map, chip, adr);
 			goto op_done;
 		}
@@ -2019,7 +2030,7 @@ static int cfi_amdstd_panic_wait(struct map_info *map, struct flchip *chip,
 	 * If the driver thinks the chip is idle, and no toggle bits
 	 * are changing, then the chip is actually idle for sure.
 	 */
-	if (chip->state == FL_READY && chip_ready(map, adr))
+	if (chip->state == FL_READY && chip_ready(map, adr, NULL))
 		return 0;
 
 	/*
@@ -2036,7 +2047,7 @@ static int cfi_amdstd_panic_wait(struct map_info *map, struct flchip *chip,
 
 		/* wait for the chip to become ready */
 		for (i = 0; i < jiffies_to_usecs(timeo); i++) {
-			if (chip_ready(map, adr))
+			if (chip_ready(map, adr, NULL))
 				return 0;
 
 			udelay(1);
@@ -2100,13 +2111,13 @@ static int do_panic_write_oneword(struct map_info *map, struct flchip *chip,
 	map_write(map, datum, adr);
 
 	for (i = 0; i < jiffies_to_usecs(uWriteTimeout); i++) {
-		if (chip_ready(map, adr))
+		if (chip_ready(map, adr, NULL))
 			break;
 
 		udelay(1);
 	}
 
-	if (!chip_good(map, adr, datum)) {
+	if (!chip_ready(map, adr, &datum)) {
 		/* reset on all failures. */
 		map_write(map, CMD(0xF0), chip->start);
 		/* FIXME - should have reset delay before continuing */
@@ -2247,6 +2258,7 @@ static int __xipram do_erase_chip(struct map_info *map, struct flchip *chip)
 	DECLARE_WAITQUEUE(wait, current);
 	int ret = 0;
 	int retry_cnt = 0;
+	map_word datum = map_word_ff(map);
 
 	adr = cfi->addr_unlock1;
 
@@ -2301,7 +2313,7 @@ static int __xipram do_erase_chip(struct map_info *map, struct flchip *chip)
 			chip->erase_suspended = 0;
 		}
 
-		if (chip_good(map, adr, map_word_ff(map)))
+		if (chip_ready(map, adr, &datum))
 			break;
 
 		if (time_after(jiffies, timeo)) {
@@ -2343,6 +2355,7 @@ static int __xipram do_erase_oneblock(struct map_info *map, struct flchip *chip,
 	DECLARE_WAITQUEUE(wait, current);
 	int ret = 0;
 	int retry_cnt = 0;
+	map_word datum = map_word_ff(map);
 
 	adr += chip->start;
 
@@ -2397,7 +2410,7 @@ static int __xipram do_erase_oneblock(struct map_info *map, struct flchip *chip,
 			chip->erase_suspended = 0;
 		}
 
-		if (chip_good(map, adr, map_word_ff(map))) {
+		if (chip_ready(map, adr, &datum)) {
 			xip_enable(map, chip, adr);
 			break;
 		}
@@ -2612,7 +2625,7 @@ static int __maybe_unused do_ppb_xxlock(struct map_info *map,
 	 */
 	timeo = jiffies + msecs_to_jiffies(2000);	/* 2s max (un)locking */
 	for (;;) {
-		if (chip_ready(map, adr))
+		if (chip_ready(map, adr, NULL))
 			break;
 
 		if (time_after(jiffies, timeo)) {
diff --git a/drivers/mtd/nand/sh_flctl.c b/drivers/mtd/nand/sh_flctl.c
index 31f98acdba07..17e15bd05442 100644
--- a/drivers/mtd/nand/sh_flctl.c
+++ b/drivers/mtd/nand/sh_flctl.c
@@ -399,7 +399,8 @@ static int flctl_dma_fifo0_transfer(struct sh_flctl *flctl, unsigned long *buf,
 	dma_addr_t dma_addr;
 	dma_cookie_t cookie;
 	uint32_t reg;
-	int ret;
+	int ret = 0;
+	unsigned long time_left;
 
 	if (dir == DMA_FROM_DEVICE) {
 		chan = flctl->chan_fifo0_rx;
@@ -440,13 +441,14 @@ static int flctl_dma_fifo0_transfer(struct sh_flctl *flctl, unsigned long *buf,
 		goto out;
 	}
 
-	ret =
+	time_left =
 	wait_for_completion_timeout(&flctl->dma_complete,
 				msecs_to_jiffies(3000));
 
-	if (ret <= 0) {
+	if (time_left == 0) {
 		dmaengine_terminate_all(chan);
 		dev_err(&flctl->pdev->dev, "wait_for_completion_timeout\n");
+		ret = -ETIMEDOUT;
 	}
 
 out:
@@ -456,7 +458,7 @@ static int flctl_dma_fifo0_transfer(struct sh_flctl *flctl, unsigned long *buf,
 
 	dma_unmap_single(chan->device->dev, dma_addr, len, dir);
 
-	/* ret > 0 is success */
+	/* ret == 0 is success */
 	return ret;
 }
 
@@ -480,7 +482,7 @@ static void read_fiforeg(struct sh_flctl *flctl, int rlen, int offset)
 
 	/* initiate DMA transfer */
 	if (flctl->chan_fifo0_rx && rlen >= 32 &&
-		flctl_dma_fifo0_transfer(flctl, buf, rlen, DMA_FROM_DEVICE) > 0)
+		!flctl_dma_fifo0_transfer(flctl, buf, rlen, DMA_FROM_DEVICE))
 			goto convert;	/* DMA success */
 
 	/* do polling transfer */
@@ -539,7 +541,7 @@ static void write_ec_fiforeg(struct sh_flctl *flctl, int rlen,
 
 	/* initiate DMA transfer */
 	if (flctl->chan_fifo0_tx && rlen >= 32 &&
-		flctl_dma_fifo0_transfer(flctl, buf, rlen, DMA_TO_DEVICE) > 0)
+		!flctl_dma_fifo0_transfer(flctl, buf, rlen, DMA_TO_DEVICE))
 			return;	/* DMA success */
 
 	/* do polling transfer */
diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
index db9538d4b358..c6a176d8681c 100644
--- a/drivers/net/can/grcan.c
+++ b/drivers/net/can/grcan.c
@@ -245,13 +245,14 @@ struct grcan_device_config {
 		.rxsize		= GRCAN_DEFAULT_BUFFER_SIZE,	\
 		}
 
-#define GRCAN_TXBUG_SAFE_GRLIB_VERSION	0x4100
+#define GRCAN_TXBUG_SAFE_GRLIB_VERSION	4100
 #define GRLIB_VERSION_MASK		0xffff
 
 /* GRCAN private data structure */
 struct grcan_priv {
 	struct can_priv can;	/* must be the first member */
 	struct net_device *dev;
+	struct device *ofdev_dev;
 	struct napi_struct napi;
 
 	struct grcan_registers __iomem *regs;	/* ioremap'ed registers */
@@ -928,7 +929,7 @@ static void grcan_free_dma_buffers(struct net_device *dev)
 	struct grcan_priv *priv = netdev_priv(dev);
 	struct grcan_dma *dma = &priv->dma;
 
-	dma_free_coherent(&dev->dev, dma->base_size, dma->base_buf,
+	dma_free_coherent(priv->ofdev_dev, dma->base_size, dma->base_buf,
 			  dma->base_handle);
 	memset(dma, 0, sizeof(*dma));
 }
@@ -953,7 +954,7 @@ static int grcan_allocate_dma_buffers(struct net_device *dev,
 
 	/* Extra GRCAN_BUFFER_ALIGNMENT to allow for alignment */
 	dma->base_size = lsize + ssize + GRCAN_BUFFER_ALIGNMENT;
-	dma->base_buf = dma_alloc_coherent(&dev->dev,
+	dma->base_buf = dma_alloc_coherent(priv->ofdev_dev,
 					   dma->base_size,
 					   &dma->base_handle,
 					   GFP_KERNEL);
@@ -1117,8 +1118,10 @@ static int grcan_close(struct net_device *dev)
 
 	priv->closing = true;
 	if (priv->need_txbug_workaround) {
+		spin_unlock_irqrestore(&priv->lock, flags);
 		del_timer_sync(&priv->hang_timer);
 		del_timer_sync(&priv->rr_timer);
+		spin_lock_irqsave(&priv->lock, flags);
 	}
 	netif_stop_queue(dev);
 	grcan_stop_hardware(dev);
@@ -1138,7 +1141,7 @@ static int grcan_close(struct net_device *dev)
 	return 0;
 }
 
-static int grcan_transmit_catch_up(struct net_device *dev, int budget)
+static void grcan_transmit_catch_up(struct net_device *dev)
 {
 	struct grcan_priv *priv = netdev_priv(dev);
 	unsigned long flags;
@@ -1146,7 +1149,7 @@ static int grcan_transmit_catch_up(struct net_device *dev, int budget)
 
 	spin_lock_irqsave(&priv->lock, flags);
 
-	work_done = catch_up_echo_skb(dev, budget, true);
+	work_done = catch_up_echo_skb(dev, -1, true);
 	if (work_done) {
 		if (!priv->resetting && !priv->closing &&
 		    !(priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY))
@@ -1160,8 +1163,6 @@ static int grcan_transmit_catch_up(struct net_device *dev, int budget)
 	}
 
 	spin_unlock_irqrestore(&priv->lock, flags);
-
-	return work_done;
 }
 
 static int grcan_receive(struct net_device *dev, int budget)
@@ -1243,19 +1244,13 @@ static int grcan_poll(struct napi_struct *napi, int budget)
 	struct net_device *dev = priv->dev;
 	struct grcan_registers __iomem *regs = priv->regs;
 	unsigned long flags;
-	int tx_work_done, rx_work_done;
-	int rx_budget = budget / 2;
-	int tx_budget = budget - rx_budget;
+	int work_done;
 
-	/* Half of the budget for receiveing messages */
-	rx_work_done = grcan_receive(dev, rx_budget);
+	work_done = grcan_receive(dev, budget);
 
-	/* Half of the budget for transmitting messages as that can trigger echo
-	 * frames being received
-	 */
-	tx_work_done = grcan_transmit_catch_up(dev, tx_budget);
+	grcan_transmit_catch_up(dev);
 
-	if (rx_work_done < rx_budget && tx_work_done < tx_budget) {
+	if (work_done < budget) {
 		napi_complete(napi);
 
 		/* Guarantee no interference with a running reset that otherwise
@@ -1272,7 +1267,7 @@ static int grcan_poll(struct napi_struct *napi, int budget)
 		spin_unlock_irqrestore(&priv->lock, flags);
 	}
 
-	return rx_work_done + tx_work_done;
+	return work_done;
 }
 
 /* Work tx bug by waiting while for the risky situation to clear. If that fails,
@@ -1604,6 +1599,7 @@ static int grcan_setup_netdev(struct platform_device *ofdev,
 	memcpy(&priv->config, &grcan_module_config,
 	       sizeof(struct grcan_device_config));
 	priv->dev = dev;
+	priv->ofdev_dev = &ofdev->dev;
 	priv->regs = base;
 	priv->can.bittiming_const = &grcan_bittiming_const;
 	priv->can.do_set_bittiming = grcan_set_bittiming;
@@ -1661,6 +1657,7 @@ static int grcan_setup_netdev(struct platform_device *ofdev,
 static int grcan_probe(struct platform_device *ofdev)
 {
 	struct device_node *np = ofdev->dev.of_node;
+	struct device_node *sysid_parent;
 	struct resource *res;
 	u32 sysid, ambafreq;
 	int irq, err;
@@ -1670,10 +1667,15 @@ static int grcan_probe(struct platform_device *ofdev)
 	/* Compare GRLIB version number with the first that does not
 	 * have the tx bug (see start_xmit)
 	 */
-	err = of_property_read_u32(np, "systemid", &sysid);
-	if (!err && ((sysid & GRLIB_VERSION_MASK)
-		     >= GRCAN_TXBUG_SAFE_GRLIB_VERSION))
-		txbug = false;
+	sysid_parent = of_find_node_by_path("/ambapp0");
+	if (sysid_parent) {
+		of_node_get(sysid_parent);
+		err = of_property_read_u32(sysid_parent, "systemid", &sysid);
+		if (!err && ((sysid & GRLIB_VERSION_MASK) >=
+			     GRCAN_TXBUG_SAFE_GRLIB_VERSION))
+			txbug = false;
+		of_node_put(sysid_parent);
+	}
 
 	err = of_property_read_u32(np, "freq", &ambafreq);
 	if (err) {
diff --git a/drivers/net/ethernet/altera/altera_tse_main.c b/drivers/net/ethernet/altera/altera_tse_main.c
index e02b99f77b1c..9d63bb33844e 100644
--- a/drivers/net/ethernet/altera/altera_tse_main.c
+++ b/drivers/net/ethernet/altera/altera_tse_main.c
@@ -152,7 +152,8 @@ static int altera_tse_mdio_create(struct net_device *dev, unsigned int id)
 	mdio = mdiobus_alloc();
 	if (mdio == NULL) {
 		netdev_err(dev, "Error allocating MDIO bus\n");
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto put_node;
 	}
 
 	mdio->name = ALTERA_TSE_RESOURCE_NAME;
@@ -169,6 +170,7 @@ static int altera_tse_mdio_create(struct net_device *dev, unsigned int id)
 			   mdio->id);
 		goto out_free_mdio;
 	}
+	of_node_put(mdio_node);
 
 	if (netif_msg_drv(priv))
 		netdev_info(dev, "MDIO bus %s: created\n", mdio->id);
@@ -178,6 +180,8 @@ static int altera_tse_mdio_create(struct net_device *dev, unsigned int id)
 out_free_mdio:
 	mdiobus_free(mdio);
 	mdio = NULL;
+put_node:
+	of_node_put(mdio_node);
 	return ret;
 }
 
diff --git a/drivers/net/ethernet/broadcom/Makefile b/drivers/net/ethernet/broadcom/Makefile
index 79f2372c66ec..4211c6cd6b35 100644
--- a/drivers/net/ethernet/broadcom/Makefile
+++ b/drivers/net/ethernet/broadcom/Makefile
@@ -15,3 +15,8 @@ obj-$(CONFIG_BGMAC_BCMA) += bgmac-bcma.o bgmac-bcma-mdio.o
 obj-$(CONFIG_BGMAC_PLATFORM) += bgmac-platform.o
 obj-$(CONFIG_SYSTEMPORT) += bcmsysport.o
 obj-$(CONFIG_BNXT) += bnxt/
+
+# FIXME: temporarily silence -Warray-bounds on non W=1+ builds
+ifndef KBUILD_EXTRA_WARN
+CFLAGS_tg3.o += -Wno-array-bounds
+endif
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
index 8d17d464c067..398928642a97 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
@@ -14314,10 +14314,6 @@ static int bnx2x_eeh_nic_unload(struct bnx2x *bp)
 
 	/* Stop Tx */
 	bnx2x_tx_disable(bp);
-	/* Delete all NAPI objects */
-	bnx2x_del_all_napi(bp);
-	if (CNIC_LOADED(bp))
-		bnx2x_del_all_napi_cnic(bp);
 	netdev_reset_tc(bp->dev);
 
 	del_timer_sync(&bp->timer);
@@ -14422,6 +14418,11 @@ static pci_ers_result_t bnx2x_io_slot_reset(struct pci_dev *pdev)
 		bnx2x_drain_tx_queues(bp);
 		bnx2x_send_unload_req(bp, UNLOAD_RECOVERY);
 		bnx2x_netif_stop(bp, 1);
+		bnx2x_del_all_napi(bp);
+
+		if (CNIC_LOADED(bp))
+			bnx2x_del_all_napi_cnic(bp);
+
 		bnx2x_free_irq(bp);
 
 		/* Report UNLOAD_DONE to MCP */
diff --git a/drivers/net/ethernet/dec/tulip/tulip_core.c b/drivers/net/ethernet/dec/tulip/tulip_core.c
index bbde90bc74fe..6224f9d22298 100644
--- a/drivers/net/ethernet/dec/tulip/tulip_core.c
+++ b/drivers/net/ethernet/dec/tulip/tulip_core.c
@@ -1412,8 +1412,10 @@ static int tulip_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	/* alloc_etherdev ensures aligned and zeroed private structures */
 	dev = alloc_etherdev (sizeof (*tp));
-	if (!dev)
+	if (!dev) {
+		pci_disable_device(pdev);
 		return -ENOMEM;
+	}
 
 	SET_NETDEV_DEV(dev, &pdev->dev);
 	if (pci_resource_len (pdev, 0) < tulip_tbl[chip_idx].io_size) {
@@ -1792,6 +1794,7 @@ static int tulip_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 err_out_free_netdev:
 	free_netdev (dev);
+	pci_disable_device(pdev);
 	return -ENODEV;
 }
 
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 6bede6774486..d825e527ec1a 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -4546,7 +4546,8 @@ static void igb_watchdog_task(struct work_struct *work)
 				break;
 			}
 
-			if (adapter->link_speed != SPEED_1000)
+			if (adapter->link_speed != SPEED_1000 ||
+			    !hw->phy.ops.read_reg)
 				goto no_wait;
 
 			/* wait for Remote receiver status OK */
diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 5b072bf80783..84d667957221 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -1496,6 +1496,9 @@ static int mtk_hwlro_get_fdir_entry(struct net_device *dev,
 	struct ethtool_rx_flow_spec *fsp =
 		(struct ethtool_rx_flow_spec *)&cmd->fs;
 
+	if (fsp->location >= ARRAY_SIZE(mac->hwlro_ip))
+		return -EINVAL;
+
 	/* only tcp dst ipv4 is meaningful, others are meaningless */
 	fsp->flow_type = TCP_V4_FLOW;
 	fsp->h_u.tcp_ip4_spec.ip4dst = ntohl(mac->hwlro_ip[fsp->location]);
diff --git a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
index 1569300844f0..8b0c28d4c627 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
@@ -2003,7 +2003,7 @@ static int mlx4_en_get_module_eeprom(struct net_device *dev,
 			en_err(priv,
 			       "mlx4_get_module_info i(%d) offset(%d) bytes_to_read(%d) - FAILED (0x%x)\n",
 			       i, offset, ee->len - i, ret);
-			return 0;
+			return ret;
 		}
 
 		i += ret;
diff --git a/drivers/net/ethernet/qlogic/qla3xxx.c b/drivers/net/ethernet/qlogic/qla3xxx.c
index 147effc16316..e62e3a9d5249 100644
--- a/drivers/net/ethernet/qlogic/qla3xxx.c
+++ b/drivers/net/ethernet/qlogic/qla3xxx.c
@@ -3625,7 +3625,8 @@ static void ql_reset_work(struct work_struct *work)
 		qdev->mem_map_registers;
 	unsigned long hw_flags;
 
-	if (test_bit((QL_RESET_PER_SCSI | QL_RESET_START), &qdev->flags)) {
+	if (test_bit(QL_RESET_PER_SCSI, &qdev->flags) ||
+	    test_bit(QL_RESET_START, &qdev->flags)) {
 		clear_bit(QL_LINK_MASTER, &qdev->flags);
 
 		/*
diff --git a/drivers/net/ethernet/sfc/ef10.c b/drivers/net/ethernet/sfc/ef10.c
index 22bc3dc44298..aa2cef8675f4 100644
--- a/drivers/net/ethernet/sfc/ef10.c
+++ b/drivers/net/ethernet/sfc/ef10.c
@@ -5197,6 +5197,11 @@ static int efx_ef10_mtd_probe(struct efx_nic *efx)
 		n_parts++;
 	}
 
+	if (!n_parts) {
+		kfree(parts);
+		return 0;
+	}
+
 	rc = efx_mtd_add(efx, &parts[0].common, n_parts, sizeof(*parts));
 fail:
 	if (rc)
diff --git a/drivers/net/ethernet/smsc/smsc911x.c b/drivers/net/ethernet/smsc/smsc911x.c
index 264136dba674..5eaee7a3ac17 100644
--- a/drivers/net/ethernet/smsc/smsc911x.c
+++ b/drivers/net/ethernet/smsc/smsc911x.c
@@ -2441,7 +2441,7 @@ static int smsc911x_drv_probe(struct platform_device *pdev)
 	if (irq == -EPROBE_DEFER) {
 		retval = -EPROBE_DEFER;
 		goto out_0;
-	} else if (irq <= 0) {
+	} else if (irq < 0) {
 		pr_warn("Could not allocate irq resource\n");
 		retval = -ENODEV;
 		goto out_0;
diff --git a/drivers/net/ethernet/stmicro/stmmac/altr_tse_pcs.c b/drivers/net/ethernet/stmicro/stmmac/altr_tse_pcs.c
index 6ca428a702f1..6a9c954492f2 100644
--- a/drivers/net/ethernet/stmicro/stmmac/altr_tse_pcs.c
+++ b/drivers/net/ethernet/stmicro/stmmac/altr_tse_pcs.c
@@ -68,6 +68,10 @@
 #define TSE_PCS_USE_SGMII_ENA				BIT(0)
 #define TSE_PCS_IF_USE_SGMII				0x03
 
+#define SGMII_ADAPTER_CTRL_REG				0x00
+#define SGMII_ADAPTER_DISABLE				0x0001
+#define SGMII_ADAPTER_ENABLE				0x0000
+
 #define AUTONEGO_LINK_TIMER				20
 
 static int tse_pcs_reset(void __iomem *base, struct tse_pcs *pcs)
@@ -211,8 +215,12 @@ void tse_pcs_fix_mac_speed(struct tse_pcs *pcs, struct phy_device *phy_dev,
 			   unsigned int speed)
 {
 	void __iomem *tse_pcs_base = pcs->tse_pcs_base;
+	void __iomem *sgmii_adapter_base = pcs->sgmii_adapter_base;
 	u32 val;
 
+	writew(SGMII_ADAPTER_ENABLE,
+	       sgmii_adapter_base + SGMII_ADAPTER_CTRL_REG);
+
 	pcs->autoneg = phy_dev->autoneg;
 
 	if (phy_dev->autoneg == AUTONEG_ENABLE) {
diff --git a/drivers/net/ethernet/stmicro/stmmac/altr_tse_pcs.h b/drivers/net/ethernet/stmicro/stmmac/altr_tse_pcs.h
index 254199f2efdb..2f5882450b06 100644
--- a/drivers/net/ethernet/stmicro/stmmac/altr_tse_pcs.h
+++ b/drivers/net/ethernet/stmicro/stmmac/altr_tse_pcs.h
@@ -21,10 +21,6 @@
 #include <linux/phy.h>
 #include <linux/timer.h>
 
-#define SGMII_ADAPTER_CTRL_REG		0x00
-#define SGMII_ADAPTER_ENABLE		0x0000
-#define SGMII_ADAPTER_DISABLE		0x0001
-
 struct tse_pcs {
 	struct device *dev;
 	void __iomem *tse_pcs_base;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
index b138968b8672..c3a78c113424 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
@@ -29,6 +29,9 @@
 
 #include "altr_tse_pcs.h"
 
+#define SGMII_ADAPTER_CTRL_REG                          0x00
+#define SGMII_ADAPTER_DISABLE                           0x0001
+
 #define SYSMGR_EMACGRP_CTRL_PHYSEL_ENUM_GMII_MII 0x0
 #define SYSMGR_EMACGRP_CTRL_PHYSEL_ENUM_RGMII 0x1
 #define SYSMGR_EMACGRP_CTRL_PHYSEL_ENUM_RMII 0x2
@@ -62,14 +65,16 @@ static void socfpga_dwmac_fix_mac_speed(void *priv, unsigned int speed)
 {
 	struct socfpga_dwmac *dwmac = (struct socfpga_dwmac *)priv;
 	void __iomem *splitter_base = dwmac->splitter_base;
+	void __iomem *tse_pcs_base = dwmac->pcs.tse_pcs_base;
 	void __iomem *sgmii_adapter_base = dwmac->pcs.sgmii_adapter_base;
 	struct device *dev = dwmac->dev;
 	struct net_device *ndev = dev_get_drvdata(dev);
 	struct phy_device *phy_dev = ndev->phydev;
 	u32 val;
 
-	writew(SGMII_ADAPTER_DISABLE,
-	       sgmii_adapter_base + SGMII_ADAPTER_CTRL_REG);
+	if ((tse_pcs_base) && (sgmii_adapter_base))
+		writew(SGMII_ADAPTER_DISABLE,
+		       sgmii_adapter_base + SGMII_ADAPTER_CTRL_REG);
 
 	if (splitter_base) {
 		val = readl(splitter_base + EMAC_SPLITTER_CTRL_REG);
@@ -91,9 +96,7 @@ static void socfpga_dwmac_fix_mac_speed(void *priv, unsigned int speed)
 		writel(val, splitter_base + EMAC_SPLITTER_CTRL_REG);
 	}
 
-	writew(SGMII_ADAPTER_ENABLE,
-	       sgmii_adapter_base + SGMII_ADAPTER_CTRL_REG);
-	if (phy_dev)
+	if (tse_pcs_base && sgmii_adapter_base)
 		tse_pcs_fix_mac_speed(&dwmac->pcs, phy_dev, speed);
 }
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
index 49eaede34eea..9beb93479e28 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
@@ -183,7 +183,7 @@ static int stmmac_pci_probe(struct pci_dev *pdev,
 		return -ENOMEM;
 
 	/* Enable pci device */
-	ret = pci_enable_device(pdev);
+	ret = pcim_enable_device(pdev);
 	if (ret) {
 		dev_err(&pdev->dev, "%s: ERROR: failed to enable device\n",
 			__func__);
@@ -241,8 +241,6 @@ static void stmmac_pci_remove(struct pci_dev *pdev)
 		pcim_iounmap_regions(pdev, BIT(i));
 		break;
 	}
-
-	pci_disable_device(pdev);
 }
 
 static int stmmac_pci_suspend(struct device *dev)
diff --git a/drivers/net/ethernet/xilinx/xilinx_emaclite.c b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
index 1f9a6ea356b0..cdcc86060749 100644
--- a/drivers/net/ethernet/xilinx/xilinx_emaclite.c
+++ b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
@@ -817,10 +817,10 @@ static int xemaclite_mdio_write(struct mii_bus *bus, int phy_id, int reg,
 static int xemaclite_mdio_setup(struct net_local *lp, struct device *dev)
 {
 	struct mii_bus *bus;
-	int rc;
 	struct resource res;
 	struct device_node *np = of_get_parent(lp->phy_node);
 	struct device_node *npp;
+	int rc, ret;
 
 	/* Don't register the MDIO bus if the phy_node or its parent node
 	 * can't be found.
@@ -830,8 +830,14 @@ static int xemaclite_mdio_setup(struct net_local *lp, struct device *dev)
 		return -ENODEV;
 	}
 	npp = of_get_parent(np);
-
-	of_address_to_resource(npp, 0, &res);
+	ret = of_address_to_resource(npp, 0, &res);
+	of_node_put(npp);
+	if (ret) {
+		dev_err(dev, "%s resource error!\n",
+			dev->of_node->full_name);
+		of_node_put(np);
+		return ret;
+	}
 	if (lp->ndev->mem_start != res.start) {
 		struct phy_device *phydev;
 		phydev = of_phy_find_device(lp->phy_node);
@@ -840,6 +846,7 @@ static int xemaclite_mdio_setup(struct net_local *lp, struct device *dev)
 				 "MDIO of the phy is not registered yet\n");
 		else
 			put_device(&phydev->mdio.dev);
+		of_node_put(np);
 		return 0;
 	}
 
@@ -852,6 +859,7 @@ static int xemaclite_mdio_setup(struct net_local *lp, struct device *dev)
 	bus = mdiobus_alloc();
 	if (!bus) {
 		dev_err(dev, "Failed to allocate mdiobus\n");
+		of_node_put(np);
 		return -ENOMEM;
 	}
 
@@ -866,6 +874,7 @@ static int xemaclite_mdio_setup(struct net_local *lp, struct device *dev)
 	lp->mii_bus = bus;
 
 	rc = of_mdiobus_register(bus, np);
+	of_node_put(np);
 	if (rc) {
 		dev_err(dev, "Failed to register mdio bus.\n");
 		goto err_register;
diff --git a/drivers/net/hippi/rrunner.c b/drivers/net/hippi/rrunner.c
index 6f3519123eb6..0e1a422d9567 100644
--- a/drivers/net/hippi/rrunner.c
+++ b/drivers/net/hippi/rrunner.c
@@ -1354,7 +1354,9 @@ static int rr_close(struct net_device *dev)
 
 	rrpriv->fw_running = 0;
 
+	spin_unlock_irqrestore(&rrpriv->lock, flags);
 	del_timer_sync(&rrpriv->timer);
+	spin_lock_irqsave(&rrpriv->lock, flags);
 
 	writel(0, &regs->TxPi);
 	writel(0, &regs->IpRxPi);
diff --git a/drivers/net/vmxnet3/vmxnet3_drv.c b/drivers/net/vmxnet3/vmxnet3_drv.c
index 56a8031b56b3..cce959f281b7 100644
--- a/drivers/net/vmxnet3/vmxnet3_drv.c
+++ b/drivers/net/vmxnet3/vmxnet3_drv.c
@@ -595,6 +595,7 @@ vmxnet3_rq_alloc_rx_buf(struct vmxnet3_rx_queue *rq, u32 ring_idx,
 				if (dma_mapping_error(&adapter->pdev->dev,
 						      rbi->dma_addr)) {
 					dev_kfree_skb_any(rbi->skb);
+					rbi->skb = NULL;
 					rq->stats.rx_buf_alloc_failure++;
 					break;
 				}
@@ -619,6 +620,7 @@ vmxnet3_rq_alloc_rx_buf(struct vmxnet3_rx_queue *rq, u32 ring_idx,
 				if (dma_mapping_error(&adapter->pdev->dev,
 						      rbi->dma_addr)) {
 					put_page(rbi->page);
+					rbi->page = NULL;
 					rq->stats.rx_buf_alloc_failure++;
 					break;
 				}
@@ -1571,6 +1573,10 @@ vmxnet3_rq_cleanup(struct vmxnet3_rx_queue *rq,
 	u32 i, ring_idx;
 	struct Vmxnet3_RxDesc *rxd;
 
+	/* ring has already been cleaned up */
+	if (!rq->rx_ring[0].base)
+		return;
+
 	for (ring_idx = 0; ring_idx < 2; ring_idx++) {
 		for (i = 0; i < rq->rx_ring[ring_idx].size; i++) {
 #ifdef __BIG_ENDIAN_BITFIELD
diff --git a/drivers/net/wireless/ath/ath9k/ar9003_phy.h b/drivers/net/wireless/ath/ath9k/ar9003_phy.h
index a171dbb29fbb..ad949eb02f3d 100644
--- a/drivers/net/wireless/ath/ath9k/ar9003_phy.h
+++ b/drivers/net/wireless/ath/ath9k/ar9003_phy.h
@@ -720,7 +720,7 @@
 #define AR_CH0_TOP2		(AR_SREV_9300(ah) ? 0x1628c : \
 					(AR_SREV_9462(ah) ? 0x16290 : 0x16284))
 #define AR_CH0_TOP2_XPABIASLVL		(AR_SREV_9561(ah) ? 0x1e00 : 0xf000)
-#define AR_CH0_TOP2_XPABIASLVL_S	12
+#define AR_CH0_TOP2_XPABIASLVL_S	(AR_SREV_9561(ah) ? 9 : 12)
 
 #define AR_CH0_XTAL		(AR_SREV_9300(ah) ? 0x16294 : \
 				 ((AR_SREV_9462(ah) || AR_SREV_9565(ah)) ? 0x16298 : \
diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c b/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c
index 6a9c9b4ef2c9..fe4491eff8ca 100644
--- a/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c
+++ b/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c
@@ -1004,6 +1004,14 @@ static bool ath9k_rx_prepare(struct ath9k_htc_priv *priv,
 		goto rx_next;
 	}
 
+	if (rxstatus->rs_keyix >= ATH_KEYMAX &&
+	    rxstatus->rs_keyix != ATH9K_RXKEYIX_INVALID) {
+		ath_dbg(common, ANY,
+			"Invalid keyix, dropping (keyix: %d)\n",
+			rxstatus->rs_keyix);
+		goto rx_next;
+	}
+
 	/* Get the RX status information */
 
 	memset(rx_status, 0, sizeof(struct ieee80211_rx_status));
diff --git a/drivers/net/wireless/ath/carl9170/tx.c b/drivers/net/wireless/ath/carl9170/tx.c
index 2bf04c9edc98..73f14d57e65d 100644
--- a/drivers/net/wireless/ath/carl9170/tx.c
+++ b/drivers/net/wireless/ath/carl9170/tx.c
@@ -1554,6 +1554,9 @@ static struct carl9170_vif_info *carl9170_pick_beaconing_vif(struct ar9170 *ar)
 					goto out;
 			}
 		} while (ar->beacon_enabled && i--);
+
+		/* no entry found in list */
+		return NULL;
 	}
 
 out:
diff --git a/drivers/net/wireless/broadcom/b43/phy_n.c b/drivers/net/wireless/broadcom/b43/phy_n.c
index d1afa74aa144..9cbc17c2751c 100644
--- a/drivers/net/wireless/broadcom/b43/phy_n.c
+++ b/drivers/net/wireless/broadcom/b43/phy_n.c
@@ -594,7 +594,7 @@ static void b43_nphy_adjust_lna_gain_table(struct b43_wldev *dev)
 	u16 data[4];
 	s16 gain[2];
 	u16 minmax[2];
-	static const u16 lna_gain[4] = { -2, 10, 19, 25 };
+	static const s16 lna_gain[4] = { -2, 10, 19, 25 };
 
 	if (nphy->hang_avoid)
 		b43_nphy_stay_in_carrier_search(dev, 1);
diff --git a/drivers/net/wireless/broadcom/b43legacy/phy.c b/drivers/net/wireless/broadcom/b43legacy/phy.c
index 995c7d0c212a..11ee5ee48976 100644
--- a/drivers/net/wireless/broadcom/b43legacy/phy.c
+++ b/drivers/net/wireless/broadcom/b43legacy/phy.c
@@ -1148,7 +1148,7 @@ void b43legacy_phy_lo_b_measure(struct b43legacy_wldev *dev)
 	struct b43legacy_phy *phy = &dev->phy;
 	u16 regstack[12] = { 0 };
 	u16 mls;
-	u16 fval;
+	s16 fval;
 	int i;
 	int j;
 
diff --git a/drivers/net/wireless/intel/ipw2x00/libipw_tx.c b/drivers/net/wireless/intel/ipw2x00/libipw_tx.c
index e8c039879b05..cb30b3b63635 100644
--- a/drivers/net/wireless/intel/ipw2x00/libipw_tx.c
+++ b/drivers/net/wireless/intel/ipw2x00/libipw_tx.c
@@ -397,7 +397,7 @@ netdev_tx_t libipw_xmit(struct sk_buff *skb, struct net_device *dev)
 
 		/* Each fragment may need to have room for encryption
 		 * pre/postfix */
-		if (host_encrypt)
+		if (host_encrypt && crypt && crypt->ops)
 			bytes_per_frag -= crypt->ops->extra_mpdu_prefix_len +
 			    crypt->ops->extra_mpdu_postfix_len;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/power.c b/drivers/net/wireless/intel/iwlwifi/mvm/power.c
index af6d10c23e5a..47b716b611e1 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/power.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/power.c
@@ -612,6 +612,9 @@ static void iwl_mvm_power_get_vifs_iterator(void *_data, u8 *mac,
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct iwl_power_vifs *power_iterator = _data;
 
+	if (!mvmvif->uploaded)
+		return;
+
 	switch (ieee80211_vif_type_p2p(vif)) {
 	case NL80211_IFTYPE_P2P_DEVICE:
 		break;
diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index a34647efb5ea..2cd1b3cfcc09 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -1987,11 +1987,13 @@ static void hw_scan_work(struct work_struct *work)
 				memcpy(skb_put(probe, req->ie_len), req->ie,
 				       req->ie_len);
 
+			rcu_read_lock();
 			if (!ieee80211_tx_prepare_skb(hwsim->hw,
 						      hwsim->hw_scan_vif,
 						      probe,
 						      hwsim->tmp_chan->band,
 						      NULL)) {
+				rcu_read_unlock();
 				kfree_skb(probe);
 				continue;
 			}
@@ -1999,6 +2001,7 @@ static void hw_scan_work(struct work_struct *work)
 			local_bh_disable();
 			mac80211_hwsim_tx_frame(hwsim->hw, probe,
 						hwsim->tmp_chan);
+			rcu_read_unlock();
 			local_bh_enable();
 		}
 	}
diff --git a/drivers/net/wireless/marvell/mwifiex/11h.c b/drivers/net/wireless/marvell/mwifiex/11h.c
index 43dccd5b0291..3024a83c0f33 100644
--- a/drivers/net/wireless/marvell/mwifiex/11h.c
+++ b/drivers/net/wireless/marvell/mwifiex/11h.c
@@ -308,5 +308,7 @@ void mwifiex_dfs_chan_sw_work_queue(struct work_struct *work)
 
 	mwifiex_dbg(priv->adapter, MSG,
 		    "indicating channel switch completion to kernel\n");
+	mutex_lock(&priv->wdev.mtx);
 	cfg80211_ch_switch_notify(priv->netdev, &priv->dfs_chandef);
+	mutex_unlock(&priv->wdev.mtx);
 }
diff --git a/drivers/net/wireless/realtek/rtl818x/rtl8180/dev.c b/drivers/net/wireless/realtek/rtl818x/rtl8180/dev.c
index e895a84481da..8ef6020292a9 100644
--- a/drivers/net/wireless/realtek/rtl818x/rtl8180/dev.c
+++ b/drivers/net/wireless/realtek/rtl818x/rtl8180/dev.c
@@ -460,8 +460,10 @@ static void rtl8180_tx(struct ieee80211_hw *dev,
 	struct rtl8180_priv *priv = dev->priv;
 	struct rtl8180_tx_ring *ring;
 	struct rtl8180_tx_desc *entry;
+	unsigned int prio = 0;
 	unsigned long flags;
-	unsigned int idx, prio, hw_prio;
+	unsigned int idx, hw_prio;
+
 	dma_addr_t mapping;
 	u32 tx_flags;
 	u8 rc_flags;
@@ -470,7 +472,9 @@ static void rtl8180_tx(struct ieee80211_hw *dev,
 	/* do arithmetic and then convert to le16 */
 	u16 frame_duration = 0;
 
-	prio = skb_get_queue_mapping(skb);
+	/* rtl8180/rtl8185 only has one useable tx queue */
+	if (dev->queues > IEEE80211_AC_BK)
+		prio = skb_get_queue_mapping(skb);
 	ring = &priv->tx_ring[prio];
 
 	mapping = pci_map_single(priv->pdev, skb->data,
diff --git a/drivers/nfc/nfcmrvl/main.c b/drivers/nfc/nfcmrvl/main.c
index a446590a71ca..cd44c1d27b12 100644
--- a/drivers/nfc/nfcmrvl/main.c
+++ b/drivers/nfc/nfcmrvl/main.c
@@ -194,6 +194,7 @@ void nfcmrvl_nci_unregister_dev(struct nfcmrvl_private *priv)
 {
 	struct nci_dev *ndev = priv->ndev;
 
+	nci_unregister_device(ndev);
 	if (priv->ndev->nfc_dev->fw_download_in_progress)
 		nfcmrvl_fw_dnld_abort(priv);
 
@@ -202,7 +203,6 @@ void nfcmrvl_nci_unregister_dev(struct nfcmrvl_private *priv)
 	if (priv->config.reset_n_io)
 		gpio_free(priv->config.reset_n_io);
 
-	nci_unregister_device(ndev);
 	nci_free_device(ndev);
 	kfree(priv);
 }
diff --git a/drivers/nfc/st21nfca/se.c b/drivers/nfc/st21nfca/se.c
index 475f8a67856d..21ab3e678cf3 100644
--- a/drivers/nfc/st21nfca/se.c
+++ b/drivers/nfc/st21nfca/se.c
@@ -320,7 +320,7 @@ int st21nfca_connectivity_event_received(struct nfc_hci_dev *hdev, u8 host,
 		 * AID		81	5 to 16
 		 * PARAMETERS	82	0 to 255
 		 */
-		if (skb->len < NFC_MIN_AID_LENGTH + 2 &&
+		if (skb->len < NFC_MIN_AID_LENGTH + 2 ||
 		    skb->data[0] != NFC_EVT_TRANSACTION_AID_TAG)
 			return -EPROTO;
 
@@ -332,22 +332,29 @@ int st21nfca_connectivity_event_received(struct nfc_hci_dev *hdev, u8 host,
 		transaction->aid_len = skb->data[1];
 
 		/* Checking if the length of the AID is valid */
-		if (transaction->aid_len > sizeof(transaction->aid))
+		if (transaction->aid_len > sizeof(transaction->aid)) {
+			devm_kfree(dev, transaction);
 			return -EINVAL;
+		}
 
 		memcpy(transaction->aid, &skb->data[2],
 		       transaction->aid_len);
 
 		/* Check next byte is PARAMETERS tag (82) */
 		if (skb->data[transaction->aid_len + 2] !=
-		    NFC_EVT_TRANSACTION_PARAMS_TAG)
+		    NFC_EVT_TRANSACTION_PARAMS_TAG) {
+			devm_kfree(dev, transaction);
 			return -EPROTO;
+		}
 
 		transaction->params_len = skb->data[transaction->aid_len + 3];
 
 		/* Total size is allocated (skb->len - 2) minus fixed array members */
-		if (transaction->params_len > ((skb->len - 2) - sizeof(struct nfc_evt_transaction)))
+		if (transaction->params_len > ((skb->len - 2) -
+		    sizeof(struct nfc_evt_transaction))) {
+			devm_kfree(dev, transaction);
 			return -EINVAL;
+		}
 
 		memcpy(transaction->params, skb->data +
 		       transaction->aid_len + 4, transaction->params_len);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c87f27d3ee31..e7b872592f36 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1203,6 +1203,7 @@ static int nvme_alloc_admin_tags(struct nvme_dev *dev)
 		dev->ctrl.admin_q = blk_mq_init_queue(&dev->admin_tagset);
 		if (IS_ERR(dev->ctrl.admin_q)) {
 			blk_mq_free_tag_set(&dev->admin_tagset);
+			dev->ctrl.admin_q = NULL;
 			return -ENOMEM;
 		}
 		if (!blk_get_queue(dev->ctrl.admin_q)) {
diff --git a/drivers/pci/host/pcie-qcom.c b/drivers/pci/host/pcie-qcom.c
index 35936409b2d4..f5f9828f96bf 100644
--- a/drivers/pci/host/pcie-qcom.c
+++ b/drivers/pci/host/pcie-qcom.c
@@ -562,10 +562,15 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	ret = dw_pcie_host_init(pp);
 	if (ret) {
 		dev_err(dev, "cannot initialize host\n");
-		return ret;
+		goto err_phy_exit;
 	}
 
 	return 0;
+
+err_phy_exit:
+	phy_exit(pcie->phy);
+
+	return ret;
 }
 
 static const struct of_device_id qcom_pcie_match[] = {
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 2cf13578fe75..e6e0012269cd 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4079,18 +4079,18 @@ static int __pci_dev_reset(struct pci_dev *dev, int probe)
 
 static void pci_dev_lock(struct pci_dev *dev)
 {
-	pci_cfg_access_lock(dev);
 	/* block PM suspend, driver probe, etc. */
 	device_lock(&dev->dev);
+	pci_cfg_access_lock(dev);
 }
 
 /* Return 1 on successful lock, 0 on contention */
 static int pci_dev_trylock(struct pci_dev *dev)
 {
-	if (pci_cfg_access_trylock(dev)) {
-		if (device_trylock(&dev->dev))
+	if (device_trylock(&dev->dev)) {
+		if (pci_cfg_access_trylock(dev))
 			return 1;
-		pci_cfg_access_unlock(dev);
+		device_unlock(&dev->dev);
 	}
 
 	return 0;
@@ -4098,8 +4098,8 @@ static int pci_dev_trylock(struct pci_dev *dev)
 
 static void pci_dev_unlock(struct pci_dev *dev)
 {
-	device_unlock(&dev->dev);
 	pci_cfg_access_unlock(dev);
+	device_unlock(&dev->dev);
 }
 
 /**
diff --git a/drivers/pcmcia/Kconfig b/drivers/pcmcia/Kconfig
index d3c378b4db6c..20d85d564b80 100644
--- a/drivers/pcmcia/Kconfig
+++ b/drivers/pcmcia/Kconfig
@@ -146,7 +146,7 @@ config TCIC
 
 config PCMCIA_ALCHEMY_DEVBOARD
 	tristate "Alchemy Db/Pb1xxx PCMCIA socket services"
-	depends on MIPS_ALCHEMY && PCMCIA
+	depends on MIPS_DB1XXX && PCMCIA
 	help
 	  Enable this driver of you want PCMCIA support on your Alchemy
 	  Db1000, Db/Pb1100, Db/Pb1500, Db/Pb1550, Db/Pb1200, DB1300
diff --git a/drivers/phy/phy-exynos5250-sata.c b/drivers/phy/phy-exynos5250-sata.c
index 60e13afcd9b8..2c39d2fd3cd8 100644
--- a/drivers/phy/phy-exynos5250-sata.c
+++ b/drivers/phy/phy-exynos5250-sata.c
@@ -193,6 +193,7 @@ static int exynos_sata_phy_probe(struct platform_device *pdev)
 		return -EINVAL;
 
 	sata_phy->client = of_find_i2c_device_by_node(node);
+	of_node_put(node);
 	if (!sata_phy->client)
 		return -EPROBE_DEFER;
 
@@ -201,20 +202,21 @@ static int exynos_sata_phy_probe(struct platform_device *pdev)
 	sata_phy->phyclk = devm_clk_get(dev, "sata_phyctrl");
 	if (IS_ERR(sata_phy->phyclk)) {
 		dev_err(dev, "failed to get clk for PHY\n");
-		return PTR_ERR(sata_phy->phyclk);
+		ret = PTR_ERR(sata_phy->phyclk);
+		goto put_dev;
 	}
 
 	ret = clk_prepare_enable(sata_phy->phyclk);
 	if (ret < 0) {
 		dev_err(dev, "failed to enable source clk\n");
-		return ret;
+		goto put_dev;
 	}
 
 	sata_phy->phy = devm_phy_create(dev, NULL, &exynos_sata_phy_ops);
 	if (IS_ERR(sata_phy->phy)) {
-		clk_disable_unprepare(sata_phy->phyclk);
 		dev_err(dev, "failed to create PHY\n");
-		return PTR_ERR(sata_phy->phy);
+		ret = PTR_ERR(sata_phy->phy);
+		goto clk_disable;
 	}
 
 	phy_set_drvdata(sata_phy->phy, sata_phy);
@@ -222,11 +224,18 @@ static int exynos_sata_phy_probe(struct platform_device *pdev)
 	phy_provider = devm_of_phy_provider_register(dev,
 					of_phy_simple_xlate);
 	if (IS_ERR(phy_provider)) {
-		clk_disable_unprepare(sata_phy->phyclk);
-		return PTR_ERR(phy_provider);
+		ret = PTR_ERR(phy_provider);
+		goto clk_disable;
 	}
 
 	return 0;
+
+clk_disable:
+	clk_disable_unprepare(sata_phy->phyclk);
+put_dev:
+	put_device(&sata_phy->client->dev);
+
+	return ret;
 }
 
 static const struct of_device_id exynos_sata_phy_of_match[] = {
diff --git a/drivers/pinctrl/pinctrl-pistachio.c b/drivers/pinctrl/pinctrl-pistachio.c
index b2b7e238bda9..fc8c57527fb7 100644
--- a/drivers/pinctrl/pinctrl-pistachio.c
+++ b/drivers/pinctrl/pinctrl-pistachio.c
@@ -1374,10 +1374,10 @@ static int pistachio_gpio_register(struct pistachio_pinctrl *pctl)
 		}
 
 		irq = irq_of_parse_and_map(child, 0);
-		if (irq < 0) {
-			dev_err(pctl->dev, "No IRQ for bank %u: %d\n", i, irq);
+		if (!irq) {
+			dev_err(pctl->dev, "No IRQ for bank %u\n", i);
 			of_node_put(child);
-			ret = irq;
+			ret = -EINVAL;
 			goto err;
 		}
 
diff --git a/drivers/pwm/pwm-lp3943.c b/drivers/pwm/pwm-lp3943.c
index 872ea76a4f19..4612315687cd 100644
--- a/drivers/pwm/pwm-lp3943.c
+++ b/drivers/pwm/pwm-lp3943.c
@@ -128,6 +128,7 @@ static int lp3943_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (err)
 		return err;
 
+	duty_ns = min(duty_ns, period_ns);
 	val = (u8)(duty_ns * LP3943_MAX_DUTY / period_ns);
 
 	return lp3943_write_byte(lp3943, reg_duty, val);
diff --git a/drivers/regulator/pfuze100-regulator.c b/drivers/regulator/pfuze100-regulator.c
index ffb1f61d2c75..998c7c972e60 100644
--- a/drivers/regulator/pfuze100-regulator.c
+++ b/drivers/regulator/pfuze100-regulator.c
@@ -407,6 +407,7 @@ static int pfuze_parse_regulators_dt(struct pfuze_chip *chip)
 	parent = of_get_child_by_name(np, "regulators");
 	if (!parent) {
 		dev_err(dev, "regulators node not found\n");
+		of_node_put(np);
 		return -EINVAL;
 	}
 
@@ -431,6 +432,7 @@ static int pfuze_parse_regulators_dt(struct pfuze_chip *chip)
 	}
 
 	of_node_put(parent);
+	of_node_put(np);
 	if (ret < 0) {
 		dev_err(dev, "Error parsing regulator init data: %d\n",
 			ret);
diff --git a/drivers/rpmsg/qcom_smd.c b/drivers/rpmsg/qcom_smd.c
index 312cb7fec5b0..5e67e42e6461 100644
--- a/drivers/rpmsg/qcom_smd.c
+++ b/drivers/rpmsg/qcom_smd.c
@@ -1258,7 +1258,7 @@ static int qcom_smd_parse_edge(struct device *dev,
 	}
 
 	irq = irq_of_parse_and_map(node, 0);
-	if (irq < 0) {
+	if (!irq) {
 		dev_err(dev, "required smd interrupt missing\n");
 		return -EINVAL;
 	}
diff --git a/drivers/rtc/rtc-mt6397.c b/drivers/rtc/rtc-mt6397.c
index 494a7fbd512b..7e37ec7c8e02 100644
--- a/drivers/rtc/rtc-mt6397.c
+++ b/drivers/rtc/rtc-mt6397.c
@@ -339,6 +339,8 @@ static int mtk_rtc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -EINVAL;
 	rtc->addr_base = res->start;
 
 	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
diff --git a/drivers/s390/net/ctcm_mpc.c b/drivers/s390/net/ctcm_mpc.c
index c103fc7efe9f..f2559e20df70 100644
--- a/drivers/s390/net/ctcm_mpc.c
+++ b/drivers/s390/net/ctcm_mpc.c
@@ -624,8 +624,6 @@ static void mpc_rcvd_sweep_resp(struct mpcg_info *mpcginfo)
 		ctcm_clear_busy_do(dev);
 	}
 
-	kfree(mpcginfo);
-
 	return;
 
 }
@@ -1205,10 +1203,10 @@ static void ctcmpc_unpack_skb(struct channel *ch, struct sk_buff *pskb)
 						CTCM_FUNTAIL, dev->name);
 			priv->stats.rx_dropped++;
 			/* mpcginfo only used for non-data transfers */
-			kfree(mpcginfo);
 			if (do_debug_data)
 				ctcmpc_dump_skb(pskb, -8);
 		}
+		kfree(mpcginfo);
 	}
 done:
 
@@ -1998,7 +1996,6 @@ static void mpc_action_rcvd_xid0(fsm_instance *fsm, int event, void *arg)
 		}
 		break;
 	}
-	kfree(mpcginfo);
 
 	CTCM_PR_DEBUG("ctcmpc:%s() %s xid2:%i xid7:%i xidt_p2:%i \n",
 		__func__, ch->id, grp->outstanding_xid2,
@@ -2059,7 +2056,6 @@ static void mpc_action_rcvd_xid7(fsm_instance *fsm, int event, void *arg)
 		mpc_validate_xid(mpcginfo);
 		break;
 	}
-	kfree(mpcginfo);
 	return;
 }
 
diff --git a/drivers/s390/net/ctcm_sysfs.c b/drivers/s390/net/ctcm_sysfs.c
index ddb0aa321339..07b7177abf26 100644
--- a/drivers/s390/net/ctcm_sysfs.c
+++ b/drivers/s390/net/ctcm_sysfs.c
@@ -38,11 +38,12 @@ static ssize_t ctcm_buffer_write(struct device *dev,
 	struct ctcm_priv *priv = dev_get_drvdata(dev);
 	int rc;
 
-	ndev = priv->channel[CTCM_READ]->netdev;
-	if (!(priv && priv->channel[CTCM_READ] && ndev)) {
+	if (!(priv && priv->channel[CTCM_READ] &&
+	      priv->channel[CTCM_READ]->netdev)) {
 		CTCM_DBF_TEXT(SETUP, CTC_DBF_ERROR, "bfnondev");
 		return -ENODEV;
 	}
+	ndev = priv->channel[CTCM_READ]->netdev;
 
 	rc = kstrtouint(buf, 0, &bs1);
 	if (rc)
diff --git a/drivers/s390/net/lcs.c b/drivers/s390/net/lcs.c
index 251db0a02e73..4d3caad7e981 100644
--- a/drivers/s390/net/lcs.c
+++ b/drivers/s390/net/lcs.c
@@ -1761,10 +1761,11 @@ lcs_get_control(struct lcs_card *card, struct lcs_cmd *cmd)
 			lcs_schedule_recovery(card);
 			break;
 		case LCS_CMD_STOPLAN:
-			pr_warn("Stoplan for %s initiated by LGW\n",
-				card->dev->name);
-			if (card->dev)
+			if (card->dev) {
+				pr_warn("Stoplan for %s initiated by LGW\n",
+					card->dev->name);
 				netif_carrier_off(card->dev);
+			}
 			break;
 		default:
 			LCS_DBF_TEXT(5, trace, "noLGWcmd");
diff --git a/drivers/scsi/dc395x.c b/drivers/scsi/dc395x.c
index 8490d0ff04ca..f7304ff0e08e 100644
--- a/drivers/scsi/dc395x.c
+++ b/drivers/scsi/dc395x.c
@@ -3775,10 +3775,19 @@ static struct DeviceCtlBlk *device_alloc(struct AdapterCtlBlk *acb,
 #endif
 	if (dcb->target_lun != 0) {
 		/* Copy settings */
-		struct DeviceCtlBlk *p;
-		list_for_each_entry(p, &acb->dcb_list, list)
-			if (p->target_id == dcb->target_id)
+		struct DeviceCtlBlk *p = NULL, *iter;
+
+		list_for_each_entry(iter, &acb->dcb_list, list)
+			if (iter->target_id == dcb->target_id) {
+				p = iter;
 				break;
+			}
+
+		if (!p) {
+			kfree(dcb);
+			return NULL;
+		}
+
 		dprintkdbg(DBG_1, 
 		       "device_alloc: <%02i-%i> copy from <%02i-%i>\n",
 		       dcb->target_id, dcb->target_lun,
diff --git a/drivers/scsi/fcoe/fcoe_ctlr.c b/drivers/scsi/fcoe/fcoe_ctlr.c
index 59ab3b40331c..d6c8e867828d 100644
--- a/drivers/scsi/fcoe/fcoe_ctlr.c
+++ b/drivers/scsi/fcoe/fcoe_ctlr.c
@@ -1945,7 +1945,7 @@ EXPORT_SYMBOL(fcoe_ctlr_recv_flogi);
  *
  * Returns: u64 fc world wide name
  */
-u64 fcoe_wwn_from_mac(unsigned char mac[MAX_ADDR_LEN],
+u64 fcoe_wwn_from_mac(unsigned char mac[ETH_ALEN],
 		      unsigned int scheme, unsigned int port)
 {
 	u64 wwn;
diff --git a/drivers/scsi/megaraid.c b/drivers/scsi/megaraid.c
index 2cbfec6a7466..2f7132edcd3f 100644
--- a/drivers/scsi/megaraid.c
+++ b/drivers/scsi/megaraid.c
@@ -4705,7 +4705,7 @@ static int __init megaraid_init(void)
 	 * major number allocation.
 	 */
 	major = register_chrdev(0, "megadev_legacy", &megadev_fops);
-	if (!major) {
+	if (major < 0) {
 		printk(KERN_WARNING
 				"megaraid: failed to register char device\n");
 	}
diff --git a/drivers/scsi/qla2xxx/qla_target.c b/drivers/scsi/qla2xxx/qla_target.c
index 6ef7a094ee51..b4a21adb3e73 100644
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -3286,6 +3286,9 @@ int qlt_abort_cmd(struct qla_tgt_cmd *cmd)
 
 	spin_lock_irqsave(&cmd->cmd_lock, flags);
 	if (cmd->aborted) {
+		if (cmd->sg_mapped)
+			qlt_unmap_sg(vha, cmd);
+
 		spin_unlock_irqrestore(&cmd->cmd_lock, flags);
 		/*
 		 * It's normal to see 2 calls in this path:
diff --git a/drivers/scsi/ufs/ufs-qcom.c b/drivers/scsi/ufs/ufs-qcom.c
index 1fe193590b8b..eada1b357338 100644
--- a/drivers/scsi/ufs/ufs-qcom.c
+++ b/drivers/scsi/ufs/ufs-qcom.c
@@ -915,8 +915,11 @@ static void ufs_qcom_dev_ref_clk_ctrl(struct ufs_qcom_host *host, bool enable)
 
 		writel_relaxed(temp, host->dev_ref_clk_ctrl_mmio);
 
-		/* ensure that ref_clk is enabled/disabled before we return */
-		wmb();
+		/*
+		 * Make sure the write to ref_clk reaches the destination and
+		 * not stored in a Write Buffer (WB).
+		 */
+		readl(host->dev_ref_clk_ctrl_mmio);
 
 		/*
 		 * If we call hibern8 exit after this, we need to make sure that
diff --git a/drivers/soc/qcom/smp2p.c b/drivers/soc/qcom/smp2p.c
index 4c5767c73b7a..a0562dec9604 100644
--- a/drivers/soc/qcom/smp2p.c
+++ b/drivers/soc/qcom/smp2p.c
@@ -416,6 +416,7 @@ static int smp2p_parse_ipc(struct qcom_smp2p *smp2p)
 	}
 
 	smp2p->ipc_regmap = syscon_node_to_regmap(syscon);
+	of_node_put(syscon);
 	if (IS_ERR(smp2p->ipc_regmap))
 		return PTR_ERR(smp2p->ipc_regmap);
 
diff --git a/drivers/soc/qcom/smsm.c b/drivers/soc/qcom/smsm.c
index 783cb3364599..01bc8528f24d 100644
--- a/drivers/soc/qcom/smsm.c
+++ b/drivers/soc/qcom/smsm.c
@@ -367,6 +367,7 @@ static int smsm_parse_ipc(struct qcom_smsm *smsm, unsigned host_id)
 		return 0;
 
 	host->ipc_regmap = syscon_node_to_regmap(syscon);
+	of_node_put(syscon);
 	if (IS_ERR(host->ipc_regmap))
 		return PTR_ERR(host->ipc_regmap);
 
diff --git a/drivers/spi/spi-img-spfi.c b/drivers/spi/spi-img-spfi.c
index 2a340234c85c..82ab1bc2196a 100644
--- a/drivers/spi/spi-img-spfi.c
+++ b/drivers/spi/spi-img-spfi.c
@@ -771,7 +771,7 @@ static int img_spfi_resume(struct device *dev)
 	int ret;
 
 	ret = pm_runtime_get_sync(dev);
-	if (ret) {
+	if (ret < 0) {
 		pm_runtime_put_noidle(dev);
 		return ret;
 	}
diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index b0a5486936c0..0b0f69551da0 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -401,6 +401,7 @@ static int ti_qspi_dma_xfer(struct ti_qspi *qspi, dma_addr_t dma_dst,
 	enum dma_ctrl_flags flags = DMA_CTRL_ACK | DMA_PREP_INTERRUPT;
 	struct dma_async_tx_descriptor *tx;
 	int ret;
+	unsigned long time_left;
 
 	tx = dma_dev->device_prep_dma_memcpy(chan, dma_dst, dma_src,
 					     len, flags);
@@ -420,9 +421,9 @@ static int ti_qspi_dma_xfer(struct ti_qspi *qspi, dma_addr_t dma_dst,
 	}
 
 	dma_async_issue_pending(chan);
-	ret = wait_for_completion_timeout(&qspi->transfer_complete,
+	time_left = wait_for_completion_timeout(&qspi->transfer_complete,
 					  msecs_to_jiffies(len));
-	if (ret <= 0) {
+	if (time_left == 0) {
 		dmaengine_terminate_sync(chan);
 		dev_err(qspi->dev, "DMA wait_for_completion_timeout\n");
 		return -ETIMEDOUT;
diff --git a/drivers/staging/greybus/audio_codec.c b/drivers/staging/greybus/audio_codec.c
index 4c2d6c2d4fb4..90bc23408a9c 100644
--- a/drivers/staging/greybus/audio_codec.c
+++ b/drivers/staging/greybus/audio_codec.c
@@ -618,8 +618,8 @@ static int gbcodec_mute_stream(struct snd_soc_dai *dai, int mute, int stream)
 			break;
 	}
 	if (!data) {
-		dev_err(dai->dev, "%s:%s DATA connection missing\n",
-			dai->name, module->name);
+		dev_err(dai->dev, "%s DATA connection missing\n",
+			dai->name);
 		mutex_unlock(&codec->lock);
 		return -ENODEV;
 	}
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index da74dc49b95e..f46def63967b 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -655,9 +655,9 @@ static void rtllib_beacons_stop(struct rtllib_device *ieee)
 	spin_lock_irqsave(&ieee->beacon_lock, flags);
 
 	ieee->beacon_txing = 0;
-	del_timer_sync(&ieee->beacon_timer);
 
 	spin_unlock_irqrestore(&ieee->beacon_lock, flags);
+	del_timer_sync(&ieee->beacon_timer);
 
 }
 
diff --git a/drivers/staging/rtl8712/usb_intf.c b/drivers/staging/rtl8712/usb_intf.c
index d0ba42dfafeb..7b7cb2a7db60 100644
--- a/drivers/staging/rtl8712/usb_intf.c
+++ b/drivers/staging/rtl8712/usb_intf.c
@@ -569,13 +569,13 @@ static int r871xu_drv_init(struct usb_interface *pusb_intf,
 		} else {
 			AutoloadFail = false;
 		}
-		if (((mac[0] == 0xff) && (mac[1] == 0xff) &&
+		if ((!AutoloadFail) ||
+		    ((mac[0] == 0xff) && (mac[1] == 0xff) &&
 		     (mac[2] == 0xff) && (mac[3] == 0xff) &&
 		     (mac[4] == 0xff) && (mac[5] == 0xff)) ||
 		    ((mac[0] == 0x00) && (mac[1] == 0x00) &&
 		     (mac[2] == 0x00) && (mac[3] == 0x00) &&
-		     (mac[4] == 0x00) && (mac[5] == 0x00)) ||
-		     (!AutoloadFail)) {
+		     (mac[4] == 0x00) && (mac[5] == 0x00))) {
 			mac[0] = 0x00;
 			mac[1] = 0xe0;
 			mac[2] = 0x4c;
diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 2311f8a635a6..3badb10229ef 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -84,6 +84,8 @@ module_param(debug, int, 0600);
  */
 #define MAX_MRU 1500
 #define MAX_MTU 1500
+/* SOF, ADDR, CTRL, LEN1, LEN2, ..., FCS, EOF */
+#define PROT_OVERHEAD 7
 #define	GSM_NET_TX_TIMEOUT (HZ*10)
 
 /**
@@ -839,7 +841,7 @@ static int gsm_dlci_data_output(struct gsm_mux *gsm, struct gsm_dlci *dlci)
 			break;
 		case 2:	/* Unstructed with modem bits.
 		Always one byte as we never send inline break data */
-			*dp++ = gsm_encode_modem(dlci);
+			*dp++ = (gsm_encode_modem(dlci) << 1) | EA;
 			break;
 		}
 		WARN_ON(kfifo_out_locked(dlci->fifo, dp , len, &dlci->lock) != len);
@@ -1316,11 +1318,12 @@ static void gsm_control_response(struct gsm_mux *gsm, unsigned int command,
 
 static void gsm_control_transmit(struct gsm_mux *gsm, struct gsm_control *ctrl)
 {
-	struct gsm_msg *msg = gsm_data_alloc(gsm, 0, ctrl->len + 1, gsm->ftype);
+	struct gsm_msg *msg = gsm_data_alloc(gsm, 0, ctrl->len + 2, gsm->ftype);
 	if (msg == NULL)
 		return;
-	msg->data[0] = (ctrl->cmd << 1) | 2 | EA;	/* command */
-	memcpy(msg->data + 1, ctrl->data, ctrl->len);
+	msg->data[0] = (ctrl->cmd << 1) | CR | EA;	/* command */
+	msg->data[1] = (ctrl->len << 1) | EA;
+	memcpy(msg->data + 2, ctrl->data, ctrl->len);
 	gsm_data_queue(gsm->dlci[0], msg);
 }
 
@@ -1343,7 +1346,6 @@ static void gsm_control_retransmit(unsigned long data)
 	spin_lock_irqsave(&gsm->control_lock, flags);
 	ctrl = gsm->pending_cmd;
 	if (ctrl) {
-		gsm->cretries--;
 		if (gsm->cretries == 0) {
 			gsm->pending_cmd = NULL;
 			ctrl->error = -ETIMEDOUT;
@@ -1352,6 +1354,7 @@ static void gsm_control_retransmit(unsigned long data)
 			wake_up(&gsm->event);
 			return;
 		}
+		gsm->cretries--;
 		gsm_control_transmit(gsm, ctrl);
 		mod_timer(&gsm->t2_timer, jiffies + gsm->t2 * HZ / 100);
 	}
@@ -1392,7 +1395,7 @@ static struct gsm_control *gsm_control_send(struct gsm_mux *gsm,
 
 	/* If DLCI0 is in ADM mode skip retries, it won't respond */
 	if (gsm->dlci[0]->mode == DLCI_MODE_ADM)
-		gsm->cretries = 1;
+		gsm->cretries = 0;
 	else
 		gsm->cretries = gsm->n2;
 
@@ -1826,7 +1829,6 @@ static void gsm_queue(struct gsm_mux *gsm)
 		gsm_response(gsm, address, UA);
 		gsm_dlci_close(dlci);
 		break;
-	case UA:
 	case UA|PF:
 		if (cr == 0 || dlci == NULL)
 			break;
@@ -1977,7 +1979,8 @@ static void gsm1_receive(struct gsm_mux *gsm, unsigned char c)
 		}
 		/* Any partial frame was a runt so go back to start */
 		if (gsm->state != GSM_START) {
-			gsm->malformed++;
+			if (gsm->state != GSM_SEARCH)
+				gsm->malformed++;
 			gsm->state = GSM_START;
 		}
 		/* A SOF in GSM_START means we are still reading idling or
@@ -2098,6 +2101,7 @@ static void gsm_cleanup_mux(struct gsm_mux *gsm)
 			gsm_dlci_release(gsm->dlci[i]);
 	mutex_unlock(&gsm->mutex);
 	/* Now wipe the queues */
+	tty_ldisc_flush(gsm->tty);
 	list_for_each_entry_safe(txq, ntxq, &gsm->tx_list, list)
 		kfree(txq);
 	INIT_LIST_HEAD(&gsm->tx_list);
@@ -2198,7 +2202,7 @@ static struct gsm_mux *gsm_alloc_mux(void)
 		kfree(gsm);
 		return NULL;
 	}
-	gsm->txframe = kmalloc(2 * MAX_MRU + 2, GFP_KERNEL);
+	gsm->txframe = kmalloc(2 * (MAX_MTU + PROT_OVERHEAD - 1), GFP_KERNEL);
 	if (gsm->txframe == NULL) {
 		kfree(gsm->buf);
 		kfree(gsm);
@@ -2515,7 +2519,7 @@ static int gsmld_config(struct tty_struct *tty, struct gsm_mux *gsm,
 	/* Check the MRU/MTU range looks sane */
 	if (c->mru > MAX_MRU || c->mtu > MAX_MTU || c->mru < 8 || c->mtu < 8)
 		return -EINVAL;
-	if (c->n2 < 3)
+	if (c->n2 > 255)
 		return -EINVAL;
 	if (c->encapsulation > 1)	/* Basic, advanced, no I */
 		return -EINVAL;
@@ -2860,19 +2864,17 @@ static struct tty_ldisc_ops tty_ldisc_packet = {
 
 static int gsmtty_modem_update(struct gsm_dlci *dlci, u8 brk)
 {
-	u8 modembits[5];
+	u8 modembits[3];
 	struct gsm_control *ctrl;
 	int len = 2;
 
-	if (brk)
+	modembits[0] = (dlci->addr << 2) | 2 | EA;  /* DLCI, Valid, EA */
+	modembits[1] = (gsm_encode_modem(dlci) << 1) | EA;
+	if (brk) {
+		modembits[2] = (brk << 4) | 2 | EA; /* Length, Break, EA */
 		len++;
-
-	modembits[0] = len << 1 | EA;		/* Data bytes */
-	modembits[1] = dlci->addr << 2 | 3;	/* DLCI, EA, 1 */
-	modembits[2] = gsm_encode_modem(dlci) << 1 | EA;
-	if (brk)
-		modembits[3] = brk << 4 | 2 | EA;	/* Valid, EA */
-	ctrl = gsm_control_send(dlci->gsm, CMD_MSC, modembits, len + 1);
+	}
+	ctrl = gsm_control_send(dlci->gsm, CMD_MSC, modembits, len);
 	if (ctrl == NULL)
 		return -ENOMEM;
 	return gsm_control_wait(dlci->gsm, ctrl);
diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 3973bbd5ee55..a54dc0375ac6 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -2915,7 +2915,7 @@ enum pci_board_num_t {
 	pbn_panacom2,
 	pbn_panacom4,
 	pbn_plx_romulus,
-	pbn_endrun_2_4000000,
+	pbn_endrun_2_3906250,
 	pbn_oxsemi,
 	pbn_oxsemi_1_4000000,
 	pbn_oxsemi_2_4000000,
@@ -3479,10 +3479,10 @@ static struct pciserial_board pci_boards[] = {
 	* signal now many ports are available
 	* 2 port 952 Uart support
 	*/
-	[pbn_endrun_2_4000000] = {
+	[pbn_endrun_2_3906250] = {
 		.flags		= FL_BASE0,
 		.num_ports	= 2,
-		.base_baud	= 4000000,
+		.base_baud	= 3906250,
 		.uart_offset	= 0x200,
 		.first_offset	= 0x1000,
 	},
@@ -4430,7 +4430,7 @@ static struct pci_device_id serial_pci_tbl[] = {
 	*/
 	{	PCI_VENDOR_ID_ENDRUN, PCI_DEVICE_ID_ENDRUN_1588,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_endrun_2_4000000 },
+		pbn_endrun_2_3906250 },
 	/*
 	 * Quatech cards. These actually have configurable clocks but for
 	 * now we just use the default.
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 8eaa3e7a822f..f07ede1cc3d2 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -3151,7 +3151,7 @@ static void serial8250_console_restore(struct uart_8250_port *up)
 
 	serial8250_set_divisor(port, baud, quot, frac);
 	serial_port_out(port, UART_LCR, up->lcr);
-	serial8250_out_MCR(up, UART_MCR_DTR | UART_MCR_RTS);
+	serial8250_out_MCR(up, up->mcr | UART_MCR_DTR | UART_MCR_RTS);
 }
 
 /*
diff --git a/drivers/tty/serial/digicolor-usart.c b/drivers/tty/serial/digicolor-usart.c
index 50ec5f1ac77f..74127813e6db 100644
--- a/drivers/tty/serial/digicolor-usart.c
+++ b/drivers/tty/serial/digicolor-usart.c
@@ -313,6 +313,8 @@ static void digicolor_uart_set_termios(struct uart_port *port,
 	case CS8:
 	default:
 		config |= UA_CONFIG_CHAR_LEN;
+		termios->c_cflag &= ~CSIZE;
+		termios->c_cflag |= CS8;
 		break;
 	}
 
@@ -476,10 +478,10 @@ static int digicolor_uart_probe(struct platform_device *pdev)
 		return PTR_ERR(uart_clk);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	dp->port.mapbase = res->start;
 	dp->port.membase = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(dp->port.membase))
 		return PTR_ERR(dp->port.membase);
+	dp->port.mapbase = res->start;
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
diff --git a/drivers/tty/serial/icom.c b/drivers/tty/serial/icom.c
index c60a8d5e4020..a3e420669674 100644
--- a/drivers/tty/serial/icom.c
+++ b/drivers/tty/serial/icom.c
@@ -1515,7 +1515,7 @@ static int icom_probe(struct pci_dev *dev,
 	retval = pci_read_config_dword(dev, PCI_COMMAND, &command_reg);
 	if (retval) {
 		dev_err(&dev->dev, "PCI Config read FAILED\n");
-		return retval;
+		goto probe_exit0;
 	}
 
 	pci_write_config_dword(dev, PCI_COMMAND,
diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index 6aea0f4a9165..273292f09bf6 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -253,6 +253,14 @@ static const char *meson_uart_type(struct uart_port *port)
 	return (port->type == PORT_MESON) ? "meson_uart" : NULL;
 }
 
+/*
+ * This function is called only from probe() using a temporary io mapping
+ * in order to perform a reset before setting up the device. Since the
+ * temporarily mapped region was successfully requested, there can be no
+ * console on this port at this time. Hence it is not necessary for this
+ * function to acquire the port->lock. (Since there is no console on this
+ * port at this time, the port->lock is not initialized yet.)
+ */
 static void meson_uart_reset(struct uart_port *port)
 {
 	u32 val;
@@ -267,9 +275,12 @@ static void meson_uart_reset(struct uart_port *port)
 
 static int meson_uart_startup(struct uart_port *port)
 {
+	unsigned long flags;
 	u32 val;
 	int ret = 0;
 
+	spin_lock_irqsave(&port->lock, flags);
+
 	val = readl(port->membase + AML_UART_CONTROL);
 	val |= AML_UART_CLR_ERR;
 	writel(val, port->membase + AML_UART_CONTROL);
@@ -285,6 +296,8 @@ static int meson_uart_startup(struct uart_port *port)
 	val = (AML_UART_RECV_IRQ(1) | AML_UART_XMIT_IRQ(port->fifosize / 2));
 	writel(val, port->membase + AML_UART_MISC);
 
+	spin_unlock_irqrestore(&port->lock, flags);
+
 	ret = request_irq(port->irq, meson_uart_interrupt, 0,
 			  meson_uart_type(port), port);
 
diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
index c284e61ed4fc..33d035f9fded 100644
--- a/drivers/tty/serial/msm_serial.c
+++ b/drivers/tty/serial/msm_serial.c
@@ -1578,6 +1578,7 @@ static inline struct uart_port *msm_get_port_from_line(unsigned int line)
 static void __msm_console_write(struct uart_port *port, const char *s,
 				unsigned int count, bool is_uartdm)
 {
+	unsigned long flags;
 	int i;
 	int num_newlines = 0;
 	bool replaced = false;
@@ -1595,6 +1596,8 @@ static void __msm_console_write(struct uart_port *port, const char *s,
 			num_newlines++;
 	count += num_newlines;
 
+	local_irq_save(flags);
+
 	if (port->sysrq)
 		locked = 0;
 	else if (oops_in_progress)
@@ -1640,6 +1643,8 @@ static void __msm_console_write(struct uart_port *port, const char *s,
 
 	if (locked)
 		spin_unlock(&port->lock);
+
+	local_irq_restore(flags);
 }
 
 static void msm_console_write(struct console *co, const char *s,
diff --git a/drivers/tty/serial/sa1100.c b/drivers/tty/serial/sa1100.c
index fd3d1329d48c..68eb1c9faa29 100644
--- a/drivers/tty/serial/sa1100.c
+++ b/drivers/tty/serial/sa1100.c
@@ -452,6 +452,8 @@ sa1100_set_termios(struct uart_port *port, struct ktermios *termios,
 	baud = uart_get_baud_rate(port, termios, old, 0, port->uartclk/16); 
 	quot = uart_get_divisor(port, baud);
 
+	del_timer_sync(&sport->timer);
+
 	spin_lock_irqsave(&sport->port.lock, flags);
 
 	sport->port.read_status_mask &= UTSR0_TO_SM(UTSR0_TFS);
@@ -482,8 +484,6 @@ sa1100_set_termios(struct uart_port *port, struct ktermios *termios,
 				UTSR1_TO_SM(UTSR1_ROR);
 	}
 
-	del_timer_sync(&sport->timer);
-
 	/*
 	 * Update the per-port timeout.
 	 */
diff --git a/drivers/tty/serial/serial_txx9.c b/drivers/tty/serial/serial_txx9.c
index ffb3fb1bda9e..61e0b65c3aaf 100644
--- a/drivers/tty/serial/serial_txx9.c
+++ b/drivers/tty/serial/serial_txx9.c
@@ -652,6 +652,8 @@ serial_txx9_set_termios(struct uart_port *port, struct ktermios *termios,
 	case CS6:	/* not supported */
 	case CS8:
 		cval |= TXX9_SILCR_UMODE_8BIT;
+		termios->c_cflag &= ~CSIZE;
+		termios->c_cflag |= CS8;
 		break;
 	}
 
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 5c6243a31166..91c69fc3987a 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2206,8 +2206,12 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
 	unsigned long max_freq = 0;
 	int best_clk = -1;
 
-	if ((termios->c_cflag & CSIZE) == CS7)
+	if ((termios->c_cflag & CSIZE) == CS7) {
 		smr_val |= SCSMR_CHR;
+	} else {
+		termios->c_cflag &= ~CSIZE;
+		termios->c_cflag |= CS8;
+	}
 	if (termios->c_cflag & PARENB)
 		smr_val |= SCSMR_PE;
 	if (termios->c_cflag & PARODD)
diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
index 379e5bd37df9..b845cd05e350 100644
--- a/drivers/tty/serial/st-asc.c
+++ b/drivers/tty/serial/st-asc.c
@@ -509,10 +509,14 @@ static void asc_set_termios(struct uart_port *port, struct ktermios *termios,
 	/* set character length */
 	if ((cflag & CSIZE) == CS7) {
 		ctrl_val |= ASC_CTL_MODE_7BIT_PAR;
+		cflag |= PARENB;
 	} else {
 		ctrl_val |= (cflag & PARENB) ?  ASC_CTL_MODE_8BIT_PAR :
 						ASC_CTL_MODE_8BIT;
+		cflag &= ~CSIZE;
+		cflag |= CS8;
 	}
+	termios->c_cflag = cflag;
 
 	/* set stop bit */
 	ctrl_val |= (cflag & CSTOPB) ? ASC_CTL_STOP_2BIT : ASC_CTL_STOP_1BIT;
diff --git a/drivers/tty/synclink_gt.c b/drivers/tty/synclink_gt.c
index 7446ce29f677..b5d053763263 100644
--- a/drivers/tty/synclink_gt.c
+++ b/drivers/tty/synclink_gt.c
@@ -1823,6 +1823,8 @@ static int hdlcdev_init(struct slgt_info *info)
  */
 static void hdlcdev_exit(struct slgt_info *info)
 {
+	if (!info->netdev)
+		return;
 	unregister_hdlc_device(info->netdev);
 	free_netdev(info->netdev);
 	info->netdev = NULL;
diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index dfccc102c1dd..e65faa98146e 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -166,7 +166,8 @@ static struct tty_buffer *tty_buffer_alloc(struct tty_port *port, size_t size)
 	   have queued and recycle that ? */
 	if (atomic_read(&port->buf.mem_used) > port->buf.mem_limit)
 		return NULL;
-	p = kmalloc(sizeof(struct tty_buffer) + 2 * size, GFP_ATOMIC);
+	p = kmalloc(sizeof(struct tty_buffer) + 2 * size,
+		    GFP_ATOMIC | __GFP_NOWARN);
 	if (p == NULL)
 		return NULL;
 
diff --git a/drivers/usb/class/cdc-wdm.c b/drivers/usb/class/cdc-wdm.c
index f9d39c993f2f..fb41efd6b892 100644
--- a/drivers/usb/class/cdc-wdm.c
+++ b/drivers/usb/class/cdc-wdm.c
@@ -744,6 +744,7 @@ static int wdm_release(struct inode *inode, struct file *file)
 			kill_urbs(desc);
 			spin_lock_irq(&desc->iuspin);
 			desc->resp_count = 0;
+			clear_bit(WDM_RESPONDING, &desc->flags);
 			spin_unlock_irq(&desc->iuspin);
 			desc->manage_power(desc->intf, 0);
 		} else {
diff --git a/drivers/usb/core/hcd-pci.c b/drivers/usb/core/hcd-pci.c
index 7af23b215254..a416eea9a366 100644
--- a/drivers/usb/core/hcd-pci.c
+++ b/drivers/usb/core/hcd-pci.c
@@ -637,10 +637,10 @@ const struct dev_pm_ops usb_hcd_pci_pm_ops = {
 	.suspend_noirq	= hcd_pci_suspend_noirq,
 	.resume_noirq	= hcd_pci_resume_noirq,
 	.resume		= hcd_pci_resume,
-	.freeze		= check_root_hub_suspended,
+	.freeze		= hcd_pci_suspend,
 	.freeze_noirq	= check_root_hub_suspended,
 	.thaw_noirq	= NULL,
-	.thaw		= NULL,
+	.thaw		= hcd_pci_resume,
 	.poweroff	= hcd_pci_suspend,
 	.poweroff_noirq	= hcd_pci_suspend_noirq,
 	.restore_noirq	= hcd_pci_resume_noirq,
diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index 2ca6ed207e26..1f26f0ab155f 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -243,6 +243,9 @@ static const struct usb_device_id usb_quirk_list[] = {
 	{ USB_DEVICE(0x0b05, 0x17e0), .driver_info =
 			USB_QUIRK_IGNORE_REMOTE_WAKEUP },
 
+	/* Realtek Semiconductor Corp. Mass Storage Device (Multicard Reader)*/
+	{ USB_DEVICE(0x0bda, 0x0151), .driver_info = USB_QUIRK_CONFIG_INTF_STRINGS },
+
 	/* Realtek hub in Dell WD19 (Type-C) */
 	{ USB_DEVICE(0x0bda, 0x0487), .driver_info = USB_QUIRK_NO_LPM },
 	{ USB_DEVICE(0x0bda, 0x5487), .driver_info = USB_QUIRK_RESET_RESUME },
@@ -325,6 +328,12 @@ static const struct usb_device_id usb_quirk_list[] = {
 	/* DJI CineSSD */
 	{ USB_DEVICE(0x2ca3, 0x0031), .driver_info = USB_QUIRK_NO_LPM },
 
+	/* DELL USB GEN2 */
+	{ USB_DEVICE(0x413c, 0xb062), .driver_info = USB_QUIRK_NO_LPM | USB_QUIRK_RESET_RESUME },
+
+	/* VCOM device */
+	{ USB_DEVICE(0x4296, 0x7570), .driver_info = USB_QUIRK_CONFIG_INTF_STRINGS },
+
 	/* INTEL VALUE SSD */
 	{ USB_DEVICE(0x8086, 0xf1a5), .driver_info = USB_QUIRK_RESET_RESUME },
 
diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
index 65bcbbad6d54..44bab6727b43 100644
--- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -3445,7 +3445,6 @@ static int dwc2_hsotg_udc_start(struct usb_gadget *gadget,
 
 	WARN_ON(hsotg->driver);
 
-	driver->driver.bus = NULL;
 	hsotg->driver = driver;
 	hsotg->gadget.dev.of_node = hsotg->dev->of_node;
 	hsotg->gadget.speed = USB_SPEED_UNKNOWN;
diff --git a/drivers/usb/gadget/configfs.c b/drivers/usb/gadget/configfs.c
index fe1b54a8fb0c..4653eeb10e0e 100644
--- a/drivers/usb/gadget/configfs.c
+++ b/drivers/usb/gadget/configfs.c
@@ -1409,6 +1409,8 @@ static void configfs_composite_unbind(struct usb_gadget *gadget)
 	usb_ep_autoconfig_reset(cdev->gadget);
 	spin_lock_irqsave(&gi->spinlock, flags);
 	cdev->gadget = NULL;
+	cdev->deactivations = 0;
+	gadget->deactivated = false;
 	set_gadget_data(gadget, NULL);
 	spin_unlock_irqrestore(&gi->spinlock, flags);
 }
diff --git a/drivers/usb/gadget/function/uvc_queue.c b/drivers/usb/gadget/function/uvc_queue.c
index 6377e9fee6e5..dadf6e507380 100644
--- a/drivers/usb/gadget/function/uvc_queue.c
+++ b/drivers/usb/gadget/function/uvc_queue.c
@@ -246,6 +246,8 @@ void uvcg_queue_cancel(struct uvc_video_queue *queue, int disconnect)
 		buf->state = UVC_BUF_STATE_ERROR;
 		vb2_buffer_done(&buf->buf.vb2_buf, VB2_BUF_STATE_ERROR);
 	}
+	queue->buf_used = 0;
+
 	/* This must be protected by the irqlock spinlock to avoid race
 	 * conditions between uvc_queue_buffer and the disconnection event that
 	 * could result in an interruptible wait in uvc_dequeue_buffer. Do not
diff --git a/drivers/usb/host/isp116x-hcd.c b/drivers/usb/host/isp116x-hcd.c
index d089b3fb7a13..c32145e63aea 100644
--- a/drivers/usb/host/isp116x-hcd.c
+++ b/drivers/usb/host/isp116x-hcd.c
@@ -1551,10 +1551,12 @@ static int isp116x_remove(struct platform_device *pdev)
 
 	iounmap(isp116x->data_reg);
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	release_mem_region(res->start, 2);
+	if (res)
+		release_mem_region(res->start, 2);
 	iounmap(isp116x->addr_reg);
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	release_mem_region(res->start, 2);
+	if (res)
+		release_mem_region(res->start, 2);
 
 	usb_put_hcd(hcd);
 	return 0;
diff --git a/drivers/usb/host/oxu210hp-hcd.c b/drivers/usb/host/oxu210hp-hcd.c
index 2f48da0c0bb3..af5248f62c59 100644
--- a/drivers/usb/host/oxu210hp-hcd.c
+++ b/drivers/usb/host/oxu210hp-hcd.c
@@ -3491,8 +3491,10 @@ static int oxu_bus_suspend(struct usb_hcd *hcd)
 		}
 	}
 
+	spin_unlock_irq(&oxu->lock);
 	/* turn off now-idle HC */
 	del_timer_sync(&oxu->watchdog);
+	spin_lock_irq(&oxu->lock);
 	ehci_halt(oxu);
 	hcd->state = HC_STATE_SUSPENDED;
 
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index a08369cb3462..ebf09503be39 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -746,6 +746,17 @@ void xhci_shutdown(struct usb_hcd *hcd)
 	if (xhci->quirks & XHCI_SPURIOUS_REBOOT)
 		usb_disable_xhci_ports(to_pci_dev(hcd->self.controller));
 
+	/* Don't poll the roothubs after shutdown. */
+	xhci_dbg(xhci, "%s: stopping usb%d port polling.\n",
+			__func__, hcd->self.busnum);
+	clear_bit(HCD_FLAG_POLL_RH, &hcd->flags);
+	del_timer_sync(&hcd->rh_timer);
+
+	if (xhci->shared_hcd) {
+		clear_bit(HCD_FLAG_POLL_RH, &xhci->shared_hcd->flags);
+		del_timer_sync(&xhci->shared_hcd->rh_timer);
+	}
+
 	spin_lock_irq(&xhci->lock);
 	xhci_halt(xhci);
 	/* Workaround for spurious wakeups at shutdown with HSW */
diff --git a/drivers/usb/misc/uss720.c b/drivers/usb/misc/uss720.c
index 0ec6d76d1563..08517d475d46 100644
--- a/drivers/usb/misc/uss720.c
+++ b/drivers/usb/misc/uss720.c
@@ -87,6 +87,7 @@ static void destroy_priv(struct kref *kref)
 
 	dev_dbg(&priv->usbdev->dev, "destroying priv datastructure\n");
 	usb_put_dev(priv->usbdev);
+	priv->usbdev = NULL;
 	kfree(priv);
 }
 
@@ -750,7 +751,6 @@ static int uss720_probe(struct usb_interface *intf,
 	parport_announce_port(pp);
 
 	usb_set_intfdata(intf, pp);
-	usb_put_dev(usbdev);
 	return 0;
 
 probe_abort:
@@ -770,7 +770,6 @@ static void uss720_disconnect(struct usb_interface *intf)
 	if (pp) {
 		priv = pp->private_data;
 		usbdev = priv->usbdev;
-		priv->usbdev = NULL;
 		priv->pp = NULL;
 		dev_dbg(&intf->dev, "parport_remove_port\n");
 		parport_remove_port(pp);
diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index ddee42e44a33..b0c98c61c53a 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -192,6 +192,8 @@ static const struct usb_device_id id_table[] = {
 	{ USB_DEVICE(0x16DC, 0x0015) }, /* W-IE-NE-R Plein & Baus GmbH CML Control, Monitoring and Data Logger */
 	{ USB_DEVICE(0x17A8, 0x0001) }, /* Kamstrup Optical Eye/3-wire */
 	{ USB_DEVICE(0x17A8, 0x0005) }, /* Kamstrup M-Bus Master MultiPort 250D */
+	{ USB_DEVICE(0x17A8, 0x0101) }, /* Kamstrup 868 MHz wM-Bus C-Mode Meter Reader (Int Ant) */
+	{ USB_DEVICE(0x17A8, 0x0102) }, /* Kamstrup 868 MHz wM-Bus C-Mode Meter Reader (Ext Ant) */
 	{ USB_DEVICE(0x17F4, 0xAAAA) }, /* Wavesense Jazz blood glucose meter */
 	{ USB_DEVICE(0x1843, 0x0200) }, /* Vaisala USB Instrument Cable */
 	{ USB_DEVICE(0x18EF, 0xE00F) }, /* ELV USB-I2C-Interface */
diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index c5d0d9e2bff2..5b198d881a40 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -430,6 +430,8 @@ static void option_instat_callback(struct urb *urb);
 #define CINTERION_PRODUCT_CLS8			0x00b0
 #define CINTERION_PRODUCT_MV31_MBIM		0x00b3
 #define CINTERION_PRODUCT_MV31_RMNET		0x00b7
+#define CINTERION_PRODUCT_MV32_WA		0x00f1
+#define CINTERION_PRODUCT_MV32_WB		0x00f2
 
 /* Olivetti products */
 #define OLIVETTI_VENDOR_ID			0x0b3c
@@ -1193,6 +1195,10 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = NCTRL(0) | RSVD(1) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1056, 0xff),	/* Telit FD980 */
 	  .driver_info = NCTRL(2) | RSVD(3) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1057, 0xff),	/* Telit FN980 */
+	  .driver_info = NCTRL(0) | RSVD(1) | RSVD(2) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1058, 0xff),	/* Telit FN980 (PCIe) */
+	  .driver_info = NCTRL(0) | RSVD(1) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1060, 0xff),	/* Telit LN920 (rmnet) */
 	  .driver_info = NCTRL(0) | RSVD(1) | RSVD(2) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1061, 0xff),	/* Telit LN920 (MBIM) */
@@ -1209,6 +1215,8 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = NCTRL(2) | RSVD(3) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1073, 0xff),	/* Telit FN990 (ECM) */
 	  .driver_info = NCTRL(0) | RSVD(1) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1075, 0xff),	/* Telit FN990 (PCIe) */
+	  .driver_info = RSVD(0) },
 	{ USB_DEVICE(TELIT_VENDOR_ID, TELIT_PRODUCT_ME910),
 	  .driver_info = NCTRL(0) | RSVD(1) | RSVD(3) },
 	{ USB_DEVICE(TELIT_VENDOR_ID, TELIT_PRODUCT_ME910_DUAL_MODEM),
@@ -1945,6 +1953,10 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = RSVD(3)},
 	{ USB_DEVICE_INTERFACE_CLASS(CINTERION_VENDOR_ID, CINTERION_PRODUCT_MV31_RMNET, 0xff),
 	  .driver_info = RSVD(0)},
+	{ USB_DEVICE_INTERFACE_CLASS(CINTERION_VENDOR_ID, CINTERION_PRODUCT_MV32_WA, 0xff),
+	  .driver_info = RSVD(3)},
+	{ USB_DEVICE_INTERFACE_CLASS(CINTERION_VENDOR_ID, CINTERION_PRODUCT_MV32_WB, 0xff),
+	  .driver_info = RSVD(3)},
 	{ USB_DEVICE(OLIVETTI_VENDOR_ID, OLIVETTI_PRODUCT_OLICARD100),
 	  .driver_info = RSVD(4) },
 	{ USB_DEVICE(OLIVETTI_VENDOR_ID, OLIVETTI_PRODUCT_OLICARD120),
@@ -2089,10 +2101,14 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = RSVD(3) },
 	{ USB_DEVICE(0x1508, 0x1001),						/* Fibocom NL668 (IOT version) */
 	  .driver_info = RSVD(4) | RSVD(5) | RSVD(6) },
+	{ USB_DEVICE(0x1782, 0x4d10) },						/* Fibocom L610 (AT mode) */
+	{ USB_DEVICE_INTERFACE_CLASS(0x1782, 0x4d11, 0xff) },			/* Fibocom L610 (ECM/RNDIS mode) */
 	{ USB_DEVICE(0x2cb7, 0x0104),						/* Fibocom NL678 series */
 	  .driver_info = RSVD(4) | RSVD(5) },
 	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x0105, 0xff),			/* Fibocom NL678 series */
 	  .driver_info = RSVD(6) },
+	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x0106, 0xff) },			/* Fibocom MA510 (ECM mode w/ diag intf.) */
+	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x010a, 0xff) },			/* Fibocom MA510 (ECM mode) */
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x2cb7, 0x010b, 0xff, 0xff, 0x30) },	/* Fibocom FG150 Diag */
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x2cb7, 0x010b, 0xff, 0, 0) },		/* Fibocom FG150 AT */
 	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x01a0, 0xff) },			/* Fibocom NL668-AM/NL652-EU (laptop MBIM) */
diff --git a/drivers/usb/serial/pl2303.c b/drivers/usb/serial/pl2303.c
index c5fa5b704ec5..008bf34978d5 100644
--- a/drivers/usb/serial/pl2303.c
+++ b/drivers/usb/serial/pl2303.c
@@ -95,6 +95,7 @@ static const struct usb_device_id id_table[] = {
 	{ USB_DEVICE(HP_VENDOR_ID, HP_LCM220_PRODUCT_ID) },
 	{ USB_DEVICE(HP_VENDOR_ID, HP_LCM960_PRODUCT_ID) },
 	{ USB_DEVICE(HP_VENDOR_ID, HP_LM920_PRODUCT_ID) },
+	{ USB_DEVICE(HP_VENDOR_ID, HP_LM930_PRODUCT_ID) },
 	{ USB_DEVICE(HP_VENDOR_ID, HP_LM940_PRODUCT_ID) },
 	{ USB_DEVICE(HP_VENDOR_ID, HP_TD620_PRODUCT_ID) },
 	{ USB_DEVICE(CRESSI_VENDOR_ID, CRESSI_EDY_PRODUCT_ID) },
diff --git a/drivers/usb/serial/pl2303.h b/drivers/usb/serial/pl2303.h
index 908865495b48..849f45a69430 100644
--- a/drivers/usb/serial/pl2303.h
+++ b/drivers/usb/serial/pl2303.h
@@ -133,6 +133,7 @@
 #define HP_TD620_PRODUCT_ID	0x0956
 #define HP_LD960_PRODUCT_ID	0x0b39
 #define HP_LD381_PRODUCT_ID	0x0f7f
+#define HP_LM930_PRODUCT_ID	0x0f9b
 #define HP_LCM220_PRODUCT_ID	0x3139
 #define HP_LCM960_PRODUCT_ID	0x3239
 #define HP_LD220_PRODUCT_ID	0x3524
diff --git a/drivers/usb/serial/qcserial.c b/drivers/usb/serial/qcserial.c
index f0bd6a66f551..d14e0bc93c61 100644
--- a/drivers/usb/serial/qcserial.c
+++ b/drivers/usb/serial/qcserial.c
@@ -170,6 +170,8 @@ static const struct usb_device_id id_table[] = {
 	{DEVICE_SWI(0x1199, 0x9090)},	/* Sierra Wireless EM7565 QDL */
 	{DEVICE_SWI(0x1199, 0x9091)},	/* Sierra Wireless EM7565 */
 	{DEVICE_SWI(0x1199, 0x90d2)},	/* Sierra Wireless EM9191 QDL */
+	{DEVICE_SWI(0x1199, 0xc080)},	/* Sierra Wireless EM7590 QDL */
+	{DEVICE_SWI(0x1199, 0xc081)},	/* Sierra Wireless EM7590 */
 	{DEVICE_SWI(0x413c, 0x81a2)},	/* Dell Wireless 5806 Gobi(TM) 4G LTE Mobile Broadband Card */
 	{DEVICE_SWI(0x413c, 0x81a3)},	/* Dell Wireless 5570 HSPA+ (42Mbps) Mobile Broadband Card */
 	{DEVICE_SWI(0x413c, 0x81a4)},	/* Dell Wireless 5570e HSPA+ (42Mbps) Mobile Broadband Card */
diff --git a/drivers/usb/serial/whiteheat.c b/drivers/usb/serial/whiteheat.c
index 345211f1a491..1dd65019eea1 100644
--- a/drivers/usb/serial/whiteheat.c
+++ b/drivers/usb/serial/whiteheat.c
@@ -644,9 +644,8 @@ static int firm_send_command(struct usb_serial_port *port, __u8 command,
 		switch (command) {
 		case WHITEHEAT_GET_DTR_RTS:
 			info = usb_get_serial_port_data(port);
-			memcpy(&info->mcr, command_info->result_buffer,
-					sizeof(struct whiteheat_dr_info));
-				break;
+			info->mcr = command_info->result_buffer[0];
+			break;
 		}
 	}
 exit:
diff --git a/drivers/usb/storage/karma.c b/drivers/usb/storage/karma.c
index f9d407f0b508..13d77421a915 100644
--- a/drivers/usb/storage/karma.c
+++ b/drivers/usb/storage/karma.c
@@ -185,23 +185,24 @@ static void rio_karma_destructor(void *extra)
 
 static int rio_karma_init(struct us_data *us)
 {
-	int ret = 0;
 	struct karma_data *data = kzalloc(sizeof(struct karma_data), GFP_NOIO);
 	if (!data)
-		goto out;
+		return -ENOMEM;
 
 	data->recv = kmalloc(RIO_RECV_LEN, GFP_NOIO);
 	if (!data->recv) {
 		kfree(data);
-		goto out;
+		return -ENOMEM;
 	}
 
 	us->extra = data;
 	us->extra_destructor = rio_karma_destructor;
-	ret = rio_karma_send_command(RIO_ENTER_STORAGE, us);
-	data->in_storage = (ret == 0);
-out:
-	return ret;
+	if (rio_karma_send_command(RIO_ENTER_STORAGE, us))
+		return -EIO;
+
+	data->in_storage = 1;
+
+	return 0;
 }
 
 static struct scsi_host_template karma_host_template;
diff --git a/drivers/usb/usbip/stub_dev.c b/drivers/usb/usbip/stub_dev.c
index cec5805feb25..ca76ee4058c9 100644
--- a/drivers/usb/usbip/stub_dev.c
+++ b/drivers/usb/usbip/stub_dev.c
@@ -441,7 +441,6 @@ static int stub_probe(struct usb_device *udev)
 			     (struct usb_dev_state *) udev);
 err_port:
 	dev_set_drvdata(&udev->dev, NULL);
-	usb_put_dev(udev);
 
 	/* we already have busid_priv, just lock busid_lock */
 	spin_lock(&busid_priv->busid_lock);
@@ -456,6 +455,7 @@ static int stub_probe(struct usb_device *udev)
 	put_busid_priv(busid_priv);
 
 sdev_free:
+	usb_put_dev(udev);
 	stub_device_free(sdev);
 
 	return rc;
diff --git a/drivers/usb/usbip/stub_rx.c b/drivers/usb/usbip/stub_rx.c
index d47176f9c310..dd6228a51d0d 100644
--- a/drivers/usb/usbip/stub_rx.c
+++ b/drivers/usb/usbip/stub_rx.c
@@ -151,7 +151,9 @@ static int tweak_set_configuration_cmd(struct urb *urb)
 	req = (struct usb_ctrlrequest *) urb->setup_packet;
 	config = le16_to_cpu(req->wValue);
 
+	usb_lock_device(sdev->udev);
 	err = usb_set_configuration(sdev->udev, config);
+	usb_unlock_device(sdev->udev);
 	if (err && err != -ENODEV)
 		dev_err(&sdev->udev->dev, "can't set config #%d, error %d\n",
 			config, err);
diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
index da47542496cc..63f0ab3e6f63 100644
--- a/drivers/vhost/vringh.c
+++ b/drivers/vhost/vringh.c
@@ -262,7 +262,7 @@ __vringh_iov(struct vringh *vrh, u16 i,
 	     gfp_t gfp,
 	     int (*copy)(void *dst, const void *src, size_t len))
 {
-	int err, count = 0, up_next, desc_max;
+	int err, count = 0, indirect_count = 0, up_next, desc_max;
 	struct vring_desc desc, *descs;
 	struct vringh_range range = { -1ULL, 0 }, slowrange;
 	bool slow = false;
@@ -319,7 +319,12 @@ __vringh_iov(struct vringh *vrh, u16 i,
 			continue;
 		}
 
-		if (count++ == vrh->vring.num) {
+		if (up_next == -1)
+			count++;
+		else
+			indirect_count++;
+
+		if (count > vrh->vring.num || indirect_count > desc_max) {
 			vringh_bad("Descriptor loop in %p", descs);
 			err = -ELOOP;
 			goto fail;
@@ -381,6 +386,7 @@ __vringh_iov(struct vringh *vrh, u16 i,
 				i = return_from_indirect(vrh, &up_next,
 							 &descs, &desc_max);
 				slow = false;
+				indirect_count = 0;
 			} else
 				break;
 		}
diff --git a/drivers/video/fbdev/amba-clcd.c b/drivers/video/fbdev/amba-clcd.c
index 89880b70cc28..ca3707e59633 100644
--- a/drivers/video/fbdev/amba-clcd.c
+++ b/drivers/video/fbdev/amba-clcd.c
@@ -849,12 +849,15 @@ static int clcdfb_of_vram_setup(struct clcd_fb *fb)
 		return -ENODEV;
 
 	fb->fb.screen_base = of_iomap(memory, 0);
-	if (!fb->fb.screen_base)
+	if (!fb->fb.screen_base) {
+		of_node_put(memory);
 		return -ENOMEM;
+	}
 
 	fb->fb.fix.smem_start = of_translate_address(memory,
 			of_get_address(memory, 0, &size, NULL));
 	fb->fb.fix.smem_len = size;
+	of_node_put(memory);
 
 	return 0;
 }
diff --git a/drivers/video/fbdev/pxa3xx-gcu.c b/drivers/video/fbdev/pxa3xx-gcu.c
index 50bce45e7f3d..184773b6b9e4 100644
--- a/drivers/video/fbdev/pxa3xx-gcu.c
+++ b/drivers/video/fbdev/pxa3xx-gcu.c
@@ -662,6 +662,7 @@ static int pxa3xx_gcu_probe(struct platform_device *pdev)
 	for (i = 0; i < 8; i++) {
 		ret = pxa3xx_gcu_add_buffer(dev, priv);
 		if (ret) {
+			pxa3xx_gcu_free_buffers(dev, priv);
 			dev_err(dev, "failed to allocate DMA memory\n");
 			goto err_disable_clk;
 		}
@@ -677,15 +678,15 @@ static int pxa3xx_gcu_probe(struct platform_device *pdev)
 			SHARED_SIZE, irq);
 	return 0;
 
-err_free_dma:
-	dma_free_coherent(dev, SHARED_SIZE,
-			priv->shared, priv->shared_phys);
+err_disable_clk:
+	clk_disable_unprepare(priv->clk);
 
 err_misc_deregister:
 	misc_deregister(&priv->misc_dev);
 
-err_disable_clk:
-	clk_disable_unprepare(priv->clk);
+err_free_dma:
+	dma_free_coherent(dev, SHARED_SIZE,
+			  priv->shared, priv->shared_phys);
 
 	return ret;
 }
@@ -698,6 +699,7 @@ static int pxa3xx_gcu_remove(struct platform_device *pdev)
 	pxa3xx_gcu_wait_idle(priv);
 	misc_deregister(&priv->misc_dev);
 	dma_free_coherent(dev, SHARED_SIZE, priv->shared, priv->shared_phys);
+	clk_disable_unprepare(priv->clk);
 	pxa3xx_gcu_free_buffers(dev, priv);
 
 	return 0;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index b100b8dae588..46ecb7405af1 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2716,7 +2716,7 @@ int open_ctree(struct super_block *sb,
 		~BTRFS_FEATURE_INCOMPAT_SUPP;
 	if (features) {
 		btrfs_err(fs_info,
-		    "cannot mount because of unsupported optional features (%llx)",
+		    "cannot mount because of unsupported optional features (0x%llx)",
 		    features);
 		err = -EINVAL;
 		goto fail_alloc;
@@ -2769,7 +2769,7 @@ int open_ctree(struct super_block *sb,
 		~BTRFS_FEATURE_COMPAT_RO_SUPP;
 	if (!(sb->s_flags & MS_RDONLY) && features) {
 		btrfs_err(fs_info,
-	"cannot mount read-write because of unsupported optional features (%llx)",
+	"cannot mount read-write because of unsupported optional features (0x%llx)",
 		       features);
 		err = -EINVAL;
 		goto fail_alloc;
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index cc91b0c564a3..312c050d0dbd 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -4696,6 +4696,18 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 		mutex_lock(&BTRFS_I(inode)->log_mutex);
 	}
 
+	/*
+	 * For symlinks, we must always log their content, which is stored in an
+	 * inline extent, otherwise we could end up with an empty symlink after
+	 * log replay, which is invalid on linux (symlink(2) returns -ENOENT if
+	 * one attempts to create an empty symlink).
+	 * We don't need to worry about flushing delalloc, because when we create
+	 * the inline extent when the symlink is created (we never have delalloc
+	 * for symlinks).
+	 */
+	if (S_ISLNK(inode->i_mode))
+		inode_only = LOG_INODE_ALL;
+
 	/*
 	 * a brute force approach to making sure we get the most uptodate
 	 * copies of everything.
@@ -5271,7 +5283,7 @@ static int log_new_dir_dentries(struct btrfs_trans_handle *trans,
 			}
 
 			ctx->log_new_dentries = false;
-			if (type == BTRFS_FT_DIR || type == BTRFS_FT_SYMLINK)
+			if (type == BTRFS_FT_DIR)
 				log_mode = LOG_INODE_ALL;
 			ret = btrfs_log_inode(trans, root, di_inode,
 					      log_mode, 0, LLONG_MAX, ctx);
diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index cf1a3d2f6ad8..0eb69b0b543a 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -265,6 +265,9 @@ smb2_reconnect(__le16 smb2_command, struct cifs_tcon *tcon)
 			rc = -EHOSTDOWN;
 			mutex_unlock(&tcon->ses->session_mutex);
 			goto failed;
+		} else if (rc) {
+			mutex_unlock(&ses->session_mutex);
+			goto out;
 		}
 	}
 	if (rc || !tcon->need_reconnect) {
diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index ffab7dc88157..a1f5982f0b51 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -1555,6 +1555,7 @@ static int _remove_from_waiters(struct dlm_lkb *lkb, int mstype,
 		lkb->lkb_wait_type = 0;
 		lkb->lkb_flags &= ~DLM_IFL_OVERLAP_CANCEL;
 		lkb->lkb_wait_count--;
+		unhold_lkb(lkb);
 		goto out_del;
 	}
 
@@ -1581,6 +1582,7 @@ static int _remove_from_waiters(struct dlm_lkb *lkb, int mstype,
 		log_error(ls, "remwait error %x reply %d wait_type %d overlap",
 			  lkb->lkb_id, mstype, lkb->lkb_wait_type);
 		lkb->lkb_wait_count--;
+		unhold_lkb(lkb);
 		lkb->lkb_wait_type = 0;
 	}
 
@@ -5314,11 +5316,16 @@ int dlm_recover_waiters_post(struct dlm_ls *ls)
 		lkb->lkb_flags &= ~DLM_IFL_OVERLAP_UNLOCK;
 		lkb->lkb_flags &= ~DLM_IFL_OVERLAP_CANCEL;
 		lkb->lkb_wait_type = 0;
-		lkb->lkb_wait_count = 0;
+		/* drop all wait_count references we still
+		 * hold a reference for this iteration.
+		 */
+		while (lkb->lkb_wait_count) {
+			lkb->lkb_wait_count--;
+			unhold_lkb(lkb);
+		}
 		mutex_lock(&ls->ls_waiters_mutex);
 		list_del_init(&lkb->lkb_wait_reply);
 		mutex_unlock(&ls->ls_waiters_mutex);
-		unhold_lkb(lkb); /* for waiters list */
 
 		if (oc || ou) {
 			/* do an unlock or cancel instead of resending */
diff --git a/fs/dlm/plock.c b/fs/dlm/plock.c
index d401425f602a..b81c7473f2bf 100644
--- a/fs/dlm/plock.c
+++ b/fs/dlm/plock.c
@@ -26,11 +26,11 @@ struct plock_op {
 	struct list_head list;
 	int done;
 	struct dlm_plock_info info;
+	int (*callback)(struct file_lock *fl, int result);
 };
 
 struct plock_xop {
 	struct plock_op xop;
-	int (*callback)(struct file_lock *fl, int result);
 	void *fl;
 	void *file;
 	struct file_lock flc;
@@ -132,19 +132,18 @@ int dlm_posix_lock(dlm_lockspace_t *lockspace, u64 number, struct file *file,
 		/* fl_owner is lockd which doesn't distinguish
 		   processes on the nfs client */
 		op->info.owner	= (__u64) fl->fl_pid;
-		xop->callback	= fl->fl_lmops->lm_grant;
+		op->callback	= fl->fl_lmops->lm_grant;
 		locks_init_lock(&xop->flc);
 		locks_copy_lock(&xop->flc, fl);
 		xop->fl		= fl;
 		xop->file	= file;
 	} else {
 		op->info.owner	= (__u64)(long) fl->fl_owner;
-		xop->callback	= NULL;
 	}
 
 	send_op(op);
 
-	if (xop->callback == NULL) {
+	if (!op->callback) {
 		rv = wait_event_interruptible(recv_wq, (op->done != 0));
 		if (rv == -ERESTARTSYS) {
 			log_debug(ls, "dlm_posix_lock: wait killed %llx",
@@ -206,7 +205,7 @@ static int dlm_plock_callback(struct plock_op *op)
 	file = xop->file;
 	flc = &xop->flc;
 	fl = xop->fl;
-	notify = xop->callback;
+	notify = op->callback;
 
 	if (op->info.rv) {
 		notify(fl, op->info.rv);
@@ -439,10 +438,9 @@ static ssize_t dev_write(struct file *file, const char __user *u, size_t count,
 		if (op->info.fsid == info.fsid &&
 		    op->info.number == info.number &&
 		    op->info.owner == info.owner) {
-			struct plock_xop *xop = (struct plock_xop *)op;
 			list_del_init(&op->list);
 			memcpy(&op->info, &info, sizeof(info));
-			if (xop->callback)
+			if (op->callback)
 				do_callback = 1;
 			else
 				op->done = 1;
diff --git a/fs/exec.c b/fs/exec.c
index 34843a6a2783..f666c974c55d 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1760,6 +1760,9 @@ static int do_execveat_common(int fd, struct filename *filename,
 		goto out_unmark;
 
 	bprm->argc = count(argv, MAX_ARG_STRINGS);
+	if (bprm->argc == 0)
+		pr_warn_once("process '%s' launched '%s' with NULL argv: empty string added\n",
+			     current->comm, bprm->filename);
 	if ((retval = bprm->argc) < 0)
 		goto out;
 
@@ -1784,6 +1787,20 @@ static int do_execveat_common(int fd, struct filename *filename,
 	if (retval < 0)
 		goto out;
 
+	/*
+	 * When argv is empty, add an empty string ("") as argv[0] to
+	 * ensure confused userspace programs that start processing
+	 * from argv[1] won't end up walking envp. See also
+	 * bprm_stack_limits().
+	 */
+	if (bprm->argc == 0) {
+		const char *argv[] = { "", NULL };
+		retval = copy_strings_kernel(1, argv, bprm);
+		if (retval < 0)
+			goto out;
+		bprm->argc = 1;
+	}
+
 	retval = exec_binprm(bprm);
 	if (retval < 0)
 		goto out;
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index c87558f120fb..3ca319e6c979 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -1984,6 +1984,18 @@ int ext4_convert_inline_data(struct inode *inode)
 	if (!ext4_has_inline_data(inode)) {
 		ext4_clear_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA);
 		return 0;
+	} else if (!ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA)) {
+		/*
+		 * Inode has inline data but EXT4_STATE_MAY_INLINE_DATA is
+		 * cleared. This means we are in the middle of moving of
+		 * inline data to delay allocated block. Just force writeout
+		 * here to finish conversion.
+		 */
+		error = filemap_flush(inode->i_mapping);
+		if (error)
+			return error;
+		if (!ext4_has_inline_data(inode))
+			return 0;
 	}
 
 	needed_blocks = ext4_writepage_trans_blocks(inode);
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 4d9901a18b97..159d259e5e5e 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -270,9 +270,9 @@ static struct dx_frame *dx_probe(struct ext4_filename *fname,
 				 struct dx_hash_info *hinfo,
 				 struct dx_frame *frame);
 static void dx_release(struct dx_frame *frames);
-static int dx_make_map(struct inode *dir, struct ext4_dir_entry_2 *de,
-		       unsigned blocksize, struct dx_hash_info *hinfo,
-		       struct dx_map_entry map[]);
+static int dx_make_map(struct inode *dir, struct buffer_head *bh,
+		       struct dx_hash_info *hinfo,
+		       struct dx_map_entry *map_tail);
 static void dx_sort_map(struct dx_map_entry *map, unsigned count);
 static struct ext4_dir_entry_2 *dx_move_dirents(char *from, char *to,
 		struct dx_map_entry *offsets, int count, unsigned blocksize);
@@ -1185,15 +1185,23 @@ static inline int search_dirblock(struct buffer_head *bh,
  * Create map of hash values, offsets, and sizes, stored at end of block.
  * Returns number of entries mapped.
  */
-static int dx_make_map(struct inode *dir, struct ext4_dir_entry_2 *de,
-		       unsigned blocksize, struct dx_hash_info *hinfo,
+static int dx_make_map(struct inode *dir, struct buffer_head *bh,
+		       struct dx_hash_info *hinfo,
 		       struct dx_map_entry *map_tail)
 {
 	int count = 0;
-	char *base = (char *) de;
+	struct ext4_dir_entry_2 *de = (struct ext4_dir_entry_2 *)bh->b_data;
+	unsigned int buflen = bh->b_size;
+	char *base = bh->b_data;
 	struct dx_hash_info h = *hinfo;
 
-	while ((char *) de < base + blocksize) {
+	if (ext4_has_metadata_csum(dir->i_sb))
+		buflen -= sizeof(struct ext4_dir_entry_tail);
+
+	while ((char *) de < base + buflen) {
+		if (ext4_check_dir_entry(dir, NULL, de, bh, base, buflen,
+					 ((char *)de) - base))
+			return -EFSCORRUPTED;
 		if (de->name_len && de->inode) {
 			ext4fs_dirhash(de->name, de->name_len, &h);
 			map_tail--;
@@ -1203,8 +1211,7 @@ static int dx_make_map(struct inode *dir, struct ext4_dir_entry_2 *de,
 			count++;
 			cond_resched();
 		}
-		/* XXX: do we need to check rec_len == 0 case? -Chris */
-		de = ext4_next_entry(de, blocksize);
+		de = ext4_next_entry(de, dir->i_sb->s_blocksize);
 	}
 	return count;
 }
@@ -1755,8 +1762,11 @@ static struct ext4_dir_entry_2 *do_split(handle_t *handle, struct inode *dir,
 
 	/* create map in the end of data2 block */
 	map = (struct dx_map_entry *) (data2 + blocksize);
-	count = dx_make_map(dir, (struct ext4_dir_entry_2 *) data1,
-			     blocksize, hinfo, map);
+	count = dx_make_map(dir, *bh, hinfo, map);
+	if (count < 0) {
+		err = count;
+		goto journal_error;
+	}
 	map -= count;
 	dx_sort_map(map, count);
 	/* Ensure that neither split block is over half full */
@@ -3318,6 +3328,9 @@ static struct buffer_head *ext4_get_first_dir_block(handle_t *handle,
 	struct buffer_head *bh;
 
 	if (!ext4_has_inline_data(inode)) {
+		struct ext4_dir_entry_2 *de;
+		unsigned int offset;
+
 		/* The first directory block must not be a hole, so
 		 * treat it as DIRENT_HTREE
 		 */
@@ -3326,9 +3339,30 @@ static struct buffer_head *ext4_get_first_dir_block(handle_t *handle,
 			*retval = PTR_ERR(bh);
 			return NULL;
 		}
-		*parent_de = ext4_next_entry(
-					(struct ext4_dir_entry_2 *)bh->b_data,
-					inode->i_sb->s_blocksize);
+
+		de = (struct ext4_dir_entry_2 *) bh->b_data;
+		if (ext4_check_dir_entry(inode, NULL, de, bh, bh->b_data,
+					 bh->b_size, 0) ||
+		    le32_to_cpu(de->inode) != inode->i_ino ||
+		    strcmp(".", de->name)) {
+			EXT4_ERROR_INODE(inode, "directory missing '.'");
+			brelse(bh);
+			*retval = -EFSCORRUPTED;
+			return NULL;
+		}
+		offset = ext4_rec_len_from_disk(de->rec_len,
+						inode->i_sb->s_blocksize);
+		de = ext4_next_entry(de, inode->i_sb->s_blocksize);
+		if (ext4_check_dir_entry(inode, NULL, de, bh, bh->b_data,
+					 bh->b_size, offset) ||
+		    le32_to_cpu(de->inode) == 0 || strcmp("..", de->name)) {
+			EXT4_ERROR_INODE(inode, "directory missing '..'");
+			brelse(bh);
+			*retval = -EFSCORRUPTED;
+			return NULL;
+		}
+		*parent_de = de;
+
 		return bh;
 	}
 
diff --git a/fs/fat/fatent.c b/fs/fat/fatent.c
index 0129d4d07a54..b0b1a71c07b7 100644
--- a/fs/fat/fatent.c
+++ b/fs/fat/fatent.c
@@ -92,7 +92,8 @@ static int fat12_ent_bread(struct super_block *sb, struct fat_entry *fatent,
 err_brelse:
 	brelse(bhs[0]);
 err:
-	fat_msg(sb, KERN_ERR, "FAT read failed (blocknr %llu)", (llu)blocknr);
+	fat_msg_ratelimit(sb, KERN_ERR, "FAT read failed (blocknr %llu)",
+			  (llu)blocknr);
 	return -EIO;
 }
 
@@ -105,8 +106,8 @@ static int fat_ent_bread(struct super_block *sb, struct fat_entry *fatent,
 	fatent->fat_inode = MSDOS_SB(sb)->fat_inode;
 	fatent->bhs[0] = sb_bread(sb, blocknr);
 	if (!fatent->bhs[0]) {
-		fat_msg(sb, KERN_ERR, "FAT read failed (blocknr %llu)",
-		       (llu)blocknr);
+		fat_msg_ratelimit(sb, KERN_ERR, "FAT read failed (blocknr %llu)",
+				  (llu)blocknr);
 		return -EIO;
 	}
 	fatent->nr_bhs = 1;
diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index e7815bebaeb8..1014659a19af 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1569,11 +1569,12 @@ static long writeback_sb_inodes(struct super_block *sb,
 	};
 	unsigned long start_time = jiffies;
 	long write_chunk;
-	long wrote = 0;  /* count both pages and inodes */
+	long total_wrote = 0;  /* count both pages and inodes */
 
 	while (!list_empty(&wb->b_io)) {
 		struct inode *inode = wb_inode(wb->b_io.prev);
 		struct bdi_writeback *tmp_wb;
+		long wrote;
 
 		if (inode->i_sb != sb) {
 			if (work->sb) {
@@ -1649,7 +1650,9 @@ static long writeback_sb_inodes(struct super_block *sb,
 
 		wbc_detach_inode(&wbc);
 		work->nr_pages -= write_chunk - wbc.nr_to_write;
-		wrote += write_chunk - wbc.nr_to_write;
+		wrote = write_chunk - wbc.nr_to_write - wbc.pages_skipped;
+		wrote = wrote < 0 ? 0 : wrote;
+		total_wrote += wrote;
 
 		if (need_resched()) {
 			/*
@@ -1671,7 +1674,7 @@ static long writeback_sb_inodes(struct super_block *sb,
 		tmp_wb = inode_to_wb_and_lock_list(inode);
 		spin_lock(&inode->i_lock);
 		if (!(inode->i_state & I_DIRTY_ALL))
-			wrote++;
+			total_wrote++;
 		requeue_inode(inode, tmp_wb, &wbc);
 		inode_sync_complete(inode);
 		spin_unlock(&inode->i_lock);
@@ -1685,14 +1688,14 @@ static long writeback_sb_inodes(struct super_block *sb,
 		 * bail out to wb_writeback() often enough to check
 		 * background threshold and other termination conditions.
 		 */
-		if (wrote) {
+		if (total_wrote) {
 			if (time_is_before_jiffies(start_time + HZ / 10UL))
 				break;
 			if (work->nr_pages <= 0)
 				break;
 		}
 	}
-	return wrote;
+	return total_wrote;
 }
 
 static long __writeback_inodes_wb(struct bdi_writeback *wb,
diff --git a/fs/jffs2/fs.c b/fs/jffs2/fs.c
index d3c9e4c82e57..610e11e76f2d 100644
--- a/fs/jffs2/fs.c
+++ b/fs/jffs2/fs.c
@@ -597,6 +597,7 @@ int jffs2_do_fill_super(struct super_block *sb, void *data, int silent)
 	jffs2_free_raw_node_refs(c);
 	kvfree(c->blocks);
 	jffs2_clear_xattr_subsystem(c);
+	jffs2_sum_exit(c);
  out_inohash:
 	kfree(c->inocache_list);
  out_wbuf:
diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index 6dac48e29d28..a07fbb60ac3c 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -398,7 +398,8 @@ int dbFree(struct inode *ip, s64 blkno, s64 nblocks)
 	}
 
 	/* write the last buffer. */
-	write_metapage(mp);
+	if (mp)
+		write_metapage(mp);
 
 	IREAD_UNLOCK(ipbmap);
 
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index d9381ca0ac47..b13649c63653 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6342,16 +6342,12 @@ nfsd4_release_lockowner(struct svc_rqst *rqstp,
 		if (sop->so_is_open_owner || !same_owner_str(sop, owner))
 			continue;
 
-		/* see if there are still any locks associated with it */
-		lo = lockowner(sop);
-		list_for_each_entry(stp, &sop->so_stateids, st_perstateowner) {
-			if (check_for_locks(stp->st_stid.sc_file, lo)) {
-				status = nfserr_locks_held;
-				spin_unlock(&clp->cl_lock);
-				return status;
-			}
+		if (atomic_read(&sop->so_count) != 1) {
+			spin_unlock(&clp->cl_lock);
+			return nfserr_locks_held;
 		}
 
+		lo = lockowner(sop);
 		nfs4_get_stateowner(sop);
 		break;
 	}
diff --git a/fs/notify/fdinfo.c b/fs/notify/fdinfo.c
index fd98e5100cab..317b7e7eb2e7 100644
--- a/fs/notify/fdinfo.c
+++ b/fs/notify/fdinfo.c
@@ -83,16 +83,9 @@ static void inotify_fdinfo(struct seq_file *m, struct fsnotify_mark *mark)
 	inode_mark = container_of(mark, struct inotify_inode_mark, fsn_mark);
 	inode = igrab(mark->inode);
 	if (inode) {
-		/*
-		 * IN_ALL_EVENTS represents all of the mask bits
-		 * that we expose to userspace.  There is at
-		 * least one bit (FS_EVENT_ON_CHILD) which is
-		 * used only internally to the kernel.
-		 */
-		u32 mask = mark->mask & IN_ALL_EVENTS;
-		seq_printf(m, "inotify wd:%x ino:%lx sdev:%x mask:%x ignored_mask:%x ",
+		seq_printf(m, "inotify wd:%x ino:%lx sdev:%x mask:%x ignored_mask:0 ",
 			   inode_mark->wd, inode->i_ino, inode->i_sb->s_dev,
-			   mask, mark->ignored_mask);
+			   inotify_mark_user_mask(mark));
 		show_mark_fhandle(m, inode);
 		seq_putc(m, '\n');
 		iput(inode);
diff --git a/fs/notify/inotify/inotify.h b/fs/notify/inotify/inotify.h
index ed855ef6f077..b0440287d7dd 100644
--- a/fs/notify/inotify/inotify.h
+++ b/fs/notify/inotify/inotify.h
@@ -20,6 +20,18 @@ static inline struct inotify_event_info *INOTIFY_E(struct fsnotify_event *fse)
 	return container_of(fse, struct inotify_event_info, fse);
 }
 
+/*
+ * INOTIFY_USER_FLAGS represents all of the mask bits that we expose to
+ * userspace.  There is at least one bit (FS_EVENT_ON_CHILD) which is
+ * used only internally to the kernel.
+ */
+#define INOTIFY_USER_MASK (IN_ALL_EVENTS | IN_ONESHOT | IN_EXCL_UNLINK)
+
+static inline __u32 inotify_mark_user_mask(struct fsnotify_mark *fsn_mark)
+{
+	return fsn_mark->mask & INOTIFY_USER_MASK;
+}
+
 extern void inotify_ignored_and_remove_idr(struct fsnotify_mark *fsn_mark,
 					   struct fsnotify_group *group);
 extern int inotify_handle_event(struct fsnotify_group *group,
diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
index 69d1ea3d292a..bb60bf1527e4 100644
--- a/fs/notify/inotify/inotify_user.c
+++ b/fs/notify/inotify/inotify_user.c
@@ -97,7 +97,7 @@ static inline __u32 inotify_arg_to_mask(u32 arg)
 	mask = (FS_IN_IGNORED | FS_EVENT_ON_CHILD | FS_UNMOUNT);
 
 	/* mask off the flags used to open the fd */
-	mask |= (arg & (IN_ALL_EVENTS | IN_ONESHOT | IN_EXCL_UNLINK));
+	mask |= (arg & INOTIFY_USER_MASK);
 
 	return mask;
 }
diff --git a/fs/ocfs2/dlmfs/userdlm.c b/fs/ocfs2/dlmfs/userdlm.c
index f70cda2f090d..cf5fbd3a616f 100644
--- a/fs/ocfs2/dlmfs/userdlm.c
+++ b/fs/ocfs2/dlmfs/userdlm.c
@@ -448,6 +448,11 @@ int user_dlm_cluster_lock(struct user_lock_res *lockres,
 	}
 
 	spin_lock(&lockres->l_lock);
+	if (lockres->l_flags & USER_LOCK_IN_TEARDOWN) {
+		spin_unlock(&lockres->l_lock);
+		status = -EAGAIN;
+		goto bail;
+	}
 
 	/* We only compare against the currently granted level
 	 * here. If the lock is blocked waiting on a downconvert,
@@ -614,7 +619,7 @@ int user_dlm_destroy_lock(struct user_lock_res *lockres)
 	spin_lock(&lockres->l_lock);
 	if (lockres->l_flags & USER_LOCK_IN_TEARDOWN) {
 		spin_unlock(&lockres->l_lock);
-		return 0;
+		goto bail;
 	}
 
 	lockres->l_flags |= USER_LOCK_IN_TEARDOWN;
@@ -628,12 +633,17 @@ int user_dlm_destroy_lock(struct user_lock_res *lockres)
 	}
 
 	if (lockres->l_ro_holders || lockres->l_ex_holders) {
+		lockres->l_flags &= ~USER_LOCK_IN_TEARDOWN;
 		spin_unlock(&lockres->l_lock);
 		goto bail;
 	}
 
 	status = 0;
 	if (!(lockres->l_flags & USER_LOCK_ATTACHED)) {
+		/*
+		 * lock is never requested, leave USER_LOCK_IN_TEARDOWN set
+		 * to avoid new lock request coming in.
+		 */
 		spin_unlock(&lockres->l_lock);
 		goto bail;
 	}
@@ -644,6 +654,10 @@ int user_dlm_destroy_lock(struct user_lock_res *lockres)
 
 	status = ocfs2_dlm_unlock(conn, &lockres->l_lksb, DLM_LKF_VALBLK);
 	if (status) {
+		spin_lock(&lockres->l_lock);
+		lockres->l_flags &= ~USER_LOCK_IN_TEARDOWN;
+		lockres->l_flags &= ~USER_LOCK_BUSY;
+		spin_unlock(&lockres->l_lock);
 		user_log_dlm_error("ocfs2_dlm_unlock", status, lockres);
 		goto bail;
 	}
diff --git a/include/drm/drm_edid.h b/include/drm/drm_edid.h
index c3a7d440bc11..514a02095983 100644
--- a/include/drm/drm_edid.h
+++ b/include/drm/drm_edid.h
@@ -114,7 +114,7 @@ struct detailed_data_monitor_range {
 			u8 supported_scalings;
 			u8 preferred_refresh;
 		} __attribute__((packed)) cvt;
-	} formula;
+	} __attribute__((packed)) formula;
 } __attribute__((packed));
 
 struct detailed_data_wpindex {
@@ -147,7 +147,7 @@ struct detailed_non_pixel {
 		struct detailed_data_wpindex color;
 		struct std_timing timings[6];
 		struct cvt_timing cvt[4];
-	} data;
+	} __attribute__((packed)) data;
 } __attribute__((packed));
 
 #define EDID_DETAIL_EST_TIMINGS 0xf7
@@ -165,7 +165,7 @@ struct detailed_timing {
 	union {
 		struct detailed_pixel_timing pixel_data;
 		struct detailed_non_pixel other_data;
-	} data;
+	} __attribute__((packed)) data;
 } __attribute__((packed));
 
 #define DRM_EDID_INPUT_SERRATION_VSYNC (1 << 0)
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index dd888fe6ec9b..15fd845aa7f7 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -61,6 +61,10 @@ extern ssize_t cpu_show_tsx_async_abort(struct device *dev,
 					char *buf);
 extern ssize_t cpu_show_itlb_multihit(struct device *dev,
 				      struct device_attribute *attr, char *buf);
+extern ssize_t cpu_show_srbds(struct device *dev, struct device_attribute *attr, char *buf);
+extern ssize_t cpu_show_mmio_stale_data(struct device *dev,
+					struct device_attribute *attr,
+					char *buf);
 
 extern __printf(4, 5)
 struct device *cpu_device_create(struct device *parent, void *drvdata,
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 1699cbdb9c97..edc0c81dfce8 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -535,7 +535,7 @@ static inline char *hex_byte_pack_upper(char *buf, u8 byte)
 	return buf;
 }
 
-extern int hex_to_bin(char ch);
+extern int hex_to_bin(unsigned char ch);
 extern int __must_check hex2bin(u8 *dst, const char *src, size_t count);
 extern char *bin2hex(char *dst, const void *src, size_t count);
 
diff --git a/include/linux/mtd/cfi.h b/include/linux/mtd/cfi.h
index 9b57a9b1b081..4ead3d1559f5 100644
--- a/include/linux/mtd/cfi.h
+++ b/include/linux/mtd/cfi.h
@@ -293,6 +293,7 @@ struct cfi_private {
 	map_word sector_erase_cmd;
 	unsigned long chipshift; /* Because they're of the same type */
 	const char *im_name;	 /* inter_module name for cmdset_setup */
+	unsigned long quirks;
 	struct flchip chips[0];  /* per-chip data structure for each chip */
 };
 
diff --git a/include/linux/netdev_features.h b/include/linux/netdev_features.h
index b692edeb0b90..27abbd7fbb2b 100644
--- a/include/linux/netdev_features.h
+++ b/include/linux/netdev_features.h
@@ -139,7 +139,7 @@ enum {
 #define NETIF_F_BUSY_POLL	__NETIF_F(BUSY_POLL)
 #define NETIF_F_HW_TC		__NETIF_F(HW_TC)
 
-/* Finds the next feature with the highest number of the range of start till 0.
+/* Finds the next feature with the highest number of the range of start-1 till 0.
  */
 static inline int find_next_netdev_feature(u64 feature, unsigned long start)
 {
@@ -158,7 +158,7 @@ static inline int find_next_netdev_feature(u64 feature, unsigned long start)
 	for ((bit) = find_next_netdev_feature((mask_addr),		\
 					      NETDEV_FEATURE_COUNT);	\
 	     (bit) >= 0;						\
-	     (bit) = find_next_netdev_feature((mask_addr), (bit) - 1))
+	     (bit) = find_next_netdev_feature((mask_addr), (bit)))
 
 /* Features valid for ethtool to change */
 /* = all defined minus driver/device-class-related */
diff --git a/include/linux/nodemask.h b/include/linux/nodemask.h
index f746e44d4046..3cc98ded3373 100644
--- a/include/linux/nodemask.h
+++ b/include/linux/nodemask.h
@@ -41,11 +41,11 @@
  * void nodes_shift_right(dst, src, n)	Shift right
  * void nodes_shift_left(dst, src, n)	Shift left
  *
- * int first_node(mask)			Number lowest set bit, or MAX_NUMNODES
- * int next_node(node, mask)		Next node past 'node', or MAX_NUMNODES
- * int next_node_in(node, mask)		Next node past 'node', or wrap to first,
+ * unsigned int first_node(mask)	Number lowest set bit, or MAX_NUMNODES
+ * unsigend int next_node(node, mask)	Next node past 'node', or MAX_NUMNODES
+ * unsigned int next_node_in(node, mask) Next node past 'node', or wrap to first,
  *					or MAX_NUMNODES
- * int first_unset_node(mask)		First node not set in mask, or 
+ * unsigned int first_unset_node(mask)	First node not set in mask, or
  *					MAX_NUMNODES
  *
  * nodemask_t nodemask_of_node(node)	Return nodemask with bit 'node' set
@@ -143,7 +143,7 @@ static inline void __nodes_clear(nodemask_t *dstp, unsigned int nbits)
 
 #define node_test_and_set(node, nodemask) \
 			__node_test_and_set((node), &(nodemask))
-static inline int __node_test_and_set(int node, nodemask_t *addr)
+static inline bool __node_test_and_set(int node, nodemask_t *addr)
 {
 	return test_and_set_bit(node, addr->bits);
 }
@@ -190,7 +190,7 @@ static inline void __nodes_complement(nodemask_t *dstp,
 
 #define nodes_equal(src1, src2) \
 			__nodes_equal(&(src1), &(src2), MAX_NUMNODES)
-static inline int __nodes_equal(const nodemask_t *src1p,
+static inline bool __nodes_equal(const nodemask_t *src1p,
 					const nodemask_t *src2p, unsigned int nbits)
 {
 	return bitmap_equal(src1p->bits, src2p->bits, nbits);
@@ -198,7 +198,7 @@ static inline int __nodes_equal(const nodemask_t *src1p,
 
 #define nodes_intersects(src1, src2) \
 			__nodes_intersects(&(src1), &(src2), MAX_NUMNODES)
-static inline int __nodes_intersects(const nodemask_t *src1p,
+static inline bool __nodes_intersects(const nodemask_t *src1p,
 					const nodemask_t *src2p, unsigned int nbits)
 {
 	return bitmap_intersects(src1p->bits, src2p->bits, nbits);
@@ -206,20 +206,20 @@ static inline int __nodes_intersects(const nodemask_t *src1p,
 
 #define nodes_subset(src1, src2) \
 			__nodes_subset(&(src1), &(src2), MAX_NUMNODES)
-static inline int __nodes_subset(const nodemask_t *src1p,
+static inline bool __nodes_subset(const nodemask_t *src1p,
 					const nodemask_t *src2p, unsigned int nbits)
 {
 	return bitmap_subset(src1p->bits, src2p->bits, nbits);
 }
 
 #define nodes_empty(src) __nodes_empty(&(src), MAX_NUMNODES)
-static inline int __nodes_empty(const nodemask_t *srcp, unsigned int nbits)
+static inline bool __nodes_empty(const nodemask_t *srcp, unsigned int nbits)
 {
 	return bitmap_empty(srcp->bits, nbits);
 }
 
 #define nodes_full(nodemask) __nodes_full(&(nodemask), MAX_NUMNODES)
-static inline int __nodes_full(const nodemask_t *srcp, unsigned int nbits)
+static inline bool __nodes_full(const nodemask_t *srcp, unsigned int nbits)
 {
 	return bitmap_full(srcp->bits, nbits);
 }
@@ -250,15 +250,15 @@ static inline void __nodes_shift_left(nodemask_t *dstp,
           > MAX_NUMNODES, then the silly min_ts could be dropped. */
 
 #define first_node(src) __first_node(&(src))
-static inline int __first_node(const nodemask_t *srcp)
+static inline unsigned int __first_node(const nodemask_t *srcp)
 {
-	return min_t(int, MAX_NUMNODES, find_first_bit(srcp->bits, MAX_NUMNODES));
+	return min_t(unsigned int, MAX_NUMNODES, find_first_bit(srcp->bits, MAX_NUMNODES));
 }
 
 #define next_node(n, src) __next_node((n), &(src))
-static inline int __next_node(int n, const nodemask_t *srcp)
+static inline unsigned int __next_node(int n, const nodemask_t *srcp)
 {
-	return min_t(int,MAX_NUMNODES,find_next_bit(srcp->bits, MAX_NUMNODES, n+1));
+	return min_t(unsigned int, MAX_NUMNODES, find_next_bit(srcp->bits, MAX_NUMNODES, n+1));
 }
 
 /*
@@ -266,7 +266,7 @@ static inline int __next_node(int n, const nodemask_t *srcp)
  * the first node in src if needed.  Returns MAX_NUMNODES if src is empty.
  */
 #define next_node_in(n, src) __next_node_in((n), &(src))
-int __next_node_in(int node, const nodemask_t *srcp);
+unsigned int __next_node_in(int node, const nodemask_t *srcp);
 
 static inline void init_nodemask_of_node(nodemask_t *mask, int node)
 {
@@ -286,9 +286,9 @@ static inline void init_nodemask_of_node(nodemask_t *mask, int node)
 })
 
 #define first_unset_node(mask) __first_unset_node(&(mask))
-static inline int __first_unset_node(const nodemask_t *maskp)
+static inline unsigned int __first_unset_node(const nodemask_t *maskp)
 {
-	return min_t(int,MAX_NUMNODES,
+	return min_t(unsigned int, MAX_NUMNODES,
 			find_first_zero_bit(maskp->bits, MAX_NUMNODES));
 }
 
@@ -365,14 +365,13 @@ static inline void __nodes_fold(nodemask_t *dstp, const nodemask_t *origp,
 }
 
 #if MAX_NUMNODES > 1
-#define for_each_node_mask(node, mask)			\
-	for ((node) = first_node(mask);			\
-		(node) < MAX_NUMNODES;			\
-		(node) = next_node((node), (mask)))
+#define for_each_node_mask(node, mask)				    \
+	for ((node) = first_node(mask);				    \
+	     (node >= 0) && (node) < MAX_NUMNODES;		    \
+	     (node) = next_node((node), (mask)))
 #else /* MAX_NUMNODES == 1 */
-#define for_each_node_mask(node, mask)			\
-	if (!nodes_empty(mask))				\
-		for ((node) = 0; (node) < 1; (node)++)
+#define for_each_node_mask(node, mask)                                  \
+	for ((node) = 0; (node) < 1 && !nodes_empty(mask); (node)++)
 #endif /* MAX_NUMNODES */
 
 /*
@@ -429,11 +428,11 @@ static inline int num_node_state(enum node_states state)
 
 #define first_online_node	first_node(node_states[N_ONLINE])
 #define first_memory_node	first_node(node_states[N_MEMORY])
-static inline int next_online_node(int nid)
+static inline unsigned int next_online_node(int nid)
 {
 	return next_node(nid, node_states[N_ONLINE]);
 }
-static inline int next_memory_node(int nid)
+static inline unsigned int next_memory_node(int nid)
 {
 	return next_node(nid, node_states[N_MEMORY]);
 }
diff --git a/include/linux/ptrace.h b/include/linux/ptrace.h
index 58ae371556bc..ac57a0641294 100644
--- a/include/linux/ptrace.h
+++ b/include/linux/ptrace.h
@@ -38,12 +38,6 @@ extern int ptrace_access_vm(struct task_struct *tsk, unsigned long addr,
 #define PT_EXITKILL		(PTRACE_O_EXITKILL << PT_OPT_FLAG_SHIFT)
 #define PT_SUSPEND_SECCOMP	(PTRACE_O_SUSPEND_SECCOMP << PT_OPT_FLAG_SHIFT)
 
-/* single stepping state bits (used on ARM and PA-RISC) */
-#define PT_SINGLESTEP_BIT	31
-#define PT_SINGLESTEP		(1<<PT_SINGLESTEP_BIT)
-#define PT_BLOCKSTEP_BIT	30
-#define PT_BLOCKSTEP		(1<<PT_BLOCKSTEP_BIT)
-
 extern long arch_ptrace(struct task_struct *child, long request,
 			unsigned long addr, unsigned long data);
 extern int ptrace_readdata(struct task_struct *tsk, unsigned long src, char __user *dst, int len);
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 819796fb9d46..0f231e96ae25 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -32,6 +32,9 @@
 /* HCI priority */
 #define HCI_PRIO_MAX	7
 
+/* HCI maximum id value */
+#define HCI_MAX_ID 10000
+
 /* HCI Core structures */
 struct inquiry_data {
 	bdaddr_t	bdaddr;
diff --git a/include/net/tcp.h b/include/net/tcp.h
index f26f075250b4..97df2f6fcbd7 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -579,6 +579,7 @@ void tcp_synack_rtt_meas(struct sock *sk, struct request_sock *req);
 void tcp_reset(struct sock *sk);
 void tcp_skb_mark_lost_uncond_verify(struct tcp_sock *tp, struct sk_buff *skb);
 void tcp_fin(struct sock *sk);
+void tcp_check_space(struct sock *sk);
 
 /* tcp_timer.c */
 void tcp_init_xmit_timers(struct sock *);
diff --git a/include/scsi/libfcoe.h b/include/scsi/libfcoe.h
index a911f993219d..ac14f3798e84 100644
--- a/include/scsi/libfcoe.h
+++ b/include/scsi/libfcoe.h
@@ -261,7 +261,8 @@ int fcoe_ctlr_recv_flogi(struct fcoe_ctlr *, struct fc_lport *,
 			 struct fc_frame *);
 
 /* libfcoe funcs */
-u64 fcoe_wwn_from_mac(unsigned char mac[MAX_ADDR_LEN], unsigned int, unsigned int);
+u64 fcoe_wwn_from_mac(unsigned char mac[ETH_ALEN], unsigned int scheme,
+		      unsigned int port);
 int fcoe_libfc_config(struct fc_lport *, struct fcoe_ctlr *,
 		      const struct libfc_function_template *, int init_fcp);
 u32 fcoe_fc_crc(struct fc_frame *fp);
diff --git a/include/sound/jack.h b/include/sound/jack.h
index 1e84bfb553cf..4742f842b457 100644
--- a/include/sound/jack.h
+++ b/include/sound/jack.h
@@ -77,6 +77,7 @@ struct snd_jack {
 	const char *id;
 #ifdef CONFIG_SND_JACK_INPUT_DEV
 	struct input_dev *input_dev;
+	struct mutex input_dev_lock;
 	int registered;
 	int type;
 	char name[100];
diff --git a/kernel/events/core.c b/kernel/events/core.c
index fd1a6b82f557..5abfbeffabb5 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9905,6 +9905,9 @@ SYSCALL_DEFINE5(perf_event_open,
 		 * Do not allow to attach to a group in a different task
 		 * or CPU context. If we're moving SW events, we'll fix
 		 * this up later, so allow that.
+		 *
+		 * Racy, not holding group_leader->ctx->mutex, see comment with
+		 * perf_event_ctx_lock().
 		 */
 		if (!move_group && group_leader->ctx != ctx)
 			goto err_context;
@@ -9954,11 +9957,22 @@ SYSCALL_DEFINE5(perf_event_open,
 			} else {
 				perf_event_ctx_unlock(group_leader, gctx);
 				move_group = 0;
+				goto not_move_group;
 			}
 		}
 	} else {
 		mutex_lock(&ctx->mutex);
+
+		/*
+		 * Now that we hold ctx->lock, (re)validate group_leader->ctx == ctx,
+		 * see the group_leader && !move_group test earlier.
+		 */
+		if (group_leader && group_leader->ctx != ctx) {
+			err = -EINVAL;
+			goto err_locked;
+		}
 	}
+not_move_group:
 
 	if (ctx->task == TASK_TOMBSTONE) {
 		err = -ESRCH;
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 8f2bf81793c7..234adc3627da 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -1134,9 +1134,8 @@ int ptrace_request(struct task_struct *child, long request,
 		return ptrace_resume(child, request, data);
 
 	case PTRACE_KILL:
-		if (child->exit_state)	/* already dead */
-			return 0;
-		return ptrace_resume(child, request, SIGKILL);
+		send_sig_info(SIGKILL, SEND_SIG_NOINFO, child);
+		return 0;
 
 #ifdef CONFIG_HAVE_ARCH_TRACEHOOK
 	case PTRACE_GETREGSET:
diff --git a/kernel/signal.c b/kernel/signal.c
index 6f30a8745775..50ac51cb6cb1 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -456,8 +456,8 @@ static void sigqueue_free_current(struct sigqueue *q)
 
 	up = q->user;
 	if (rt_prio(current->normal_prio) && !put_task_cache(current, q)) {
-		atomic_dec(&up->sigpending);
-		free_uid(up);
+		if (atomic_dec_and_test(&up->sigpending))
+			free_uid(up);
 	} else
 		  __sigqueue_free(q);
 }
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 1c801aeae9b2..19964864384e 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4808,12 +4808,18 @@ static void tracing_set_nop(struct trace_array *tr)
 	tr->current_trace = &nop_trace;
 }
 
+static bool tracer_options_updated;
+
 static void add_tracer_options(struct trace_array *tr, struct tracer *t)
 {
 	/* Only enable if the directory has been created already. */
 	if (!tr->dir)
 		return;
 
+	/* Only create trace option files after update_tracer_options finish */
+	if (!tracer_options_updated)
+		return;
+
 	create_trace_option_files(tr, t);
 }
 
@@ -7092,6 +7098,7 @@ static void __update_tracer_options(struct trace_array *tr)
 static void update_tracer_options(struct trace_array *tr)
 {
 	mutex_lock(&trace_types_lock);
+	tracer_options_updated = true;
 	__update_tracer_options(tr);
 	mutex_unlock(&trace_types_lock);
 }
diff --git a/lib/assoc_array.c b/lib/assoc_array.c
index 3b46c5433b7a..70ef5fdd11c7 100644
--- a/lib/assoc_array.c
+++ b/lib/assoc_array.c
@@ -1478,6 +1478,7 @@ int assoc_array_gc(struct assoc_array *array,
 	struct assoc_array_ptr *cursor, *ptr;
 	struct assoc_array_ptr *new_root, *new_parent, **new_ptr_pp;
 	unsigned long nr_leaves_on_tree;
+	bool retained;
 	int keylen, slot, nr_free, next_slot, i;
 
 	pr_devel("-->%s()\n", __func__);
@@ -1554,6 +1555,7 @@ int assoc_array_gc(struct assoc_array *array,
 		goto descend;
 	}
 
+retry_compress:
 	pr_devel("-- compress node %p --\n", new_n);
 
 	/* Count up the number of empty slots in this node and work out the
@@ -1571,6 +1573,7 @@ int assoc_array_gc(struct assoc_array *array,
 	pr_devel("free=%d, leaves=%lu\n", nr_free, new_n->nr_leaves_on_branch);
 
 	/* See what we can fold in */
+	retained = false;
 	next_slot = 0;
 	for (slot = 0; slot < ASSOC_ARRAY_FAN_OUT; slot++) {
 		struct assoc_array_shortcut *s;
@@ -1620,9 +1623,14 @@ int assoc_array_gc(struct assoc_array *array,
 			pr_devel("[%d] retain node %lu/%d [nx %d]\n",
 				 slot, child->nr_leaves_on_branch, nr_free + 1,
 				 next_slot);
+			retained = true;
 		}
 	}
 
+	if (retained && new_n->nr_leaves_on_branch <= ASSOC_ARRAY_FAN_OUT) {
+		pr_devel("internal nodes remain despite enough space, retrying\n");
+		goto retry_compress;
+	}
 	pr_devel("after: %lu\n", new_n->nr_leaves_on_branch);
 
 	nr_leaves_on_tree = new_n->nr_leaves_on_branch;
diff --git a/lib/dma-debug.c b/lib/dma-debug.c
index 4435bec55fb5..baafebabe3ac 100644
--- a/lib/dma-debug.c
+++ b/lib/dma-debug.c
@@ -463,7 +463,7 @@ EXPORT_SYMBOL(debug_dma_dump_mappings);
  * At any time debug_dma_assert_idle() can be called to trigger a
  * warning if any cachelines in the given page are in the active set.
  */
-static RADIX_TREE(dma_active_cacheline, GFP_NOWAIT);
+static RADIX_TREE(dma_active_cacheline, GFP_ATOMIC);
 static DEFINE_SPINLOCK(radix_lock);
 #define ACTIVE_CACHELINE_MAX_OVERLAP ((1 << RADIX_TREE_MAX_TAGS) - 1)
 #define CACHELINE_PER_PAGE_SHIFT (PAGE_SHIFT - L1_CACHE_SHIFT)
diff --git a/lib/hexdump.c b/lib/hexdump.c
index 992457b1284c..570b23275704 100644
--- a/lib/hexdump.c
+++ b/lib/hexdump.c
@@ -24,15 +24,33 @@ EXPORT_SYMBOL(hex_asc_upper);
  *
  * hex_to_bin() converts one hex digit to its actual value or -1 in case of bad
  * input.
+ *
+ * This function is used to load cryptographic keys, so it is coded in such a
+ * way that there are no conditions or memory accesses that depend on data.
+ *
+ * Explanation of the logic:
+ * (ch - '9' - 1) is negative if ch <= '9'
+ * ('0' - 1 - ch) is negative if ch >= '0'
+ * we "and" these two values, so the result is negative if ch is in the range
+ *	'0' ... '9'
+ * we are only interested in the sign, so we do a shift ">> 8"; note that right
+ *	shift of a negative value is implementation-defined, so we cast the
+ *	value to (unsigned) before the shift --- we have 0xffffff if ch is in
+ *	the range '0' ... '9', 0 otherwise
+ * we "and" this value with (ch - '0' + 1) --- we have a value 1 ... 10 if ch is
+ *	in the range '0' ... '9', 0 otherwise
+ * we add this value to -1 --- we have a value 0 ... 9 if ch is in the range '0'
+ *	... '9', -1 otherwise
+ * the next line is similar to the previous one, but we need to decode both
+ *	uppercase and lowercase letters, so we use (ch & 0xdf), which converts
+ *	lowercase to uppercase
  */
-int hex_to_bin(char ch)
+int hex_to_bin(unsigned char ch)
 {
-	if ((ch >= '0') && (ch <= '9'))
-		return ch - '0';
-	ch = tolower(ch);
-	if ((ch >= 'a') && (ch <= 'f'))
-		return ch - 'a' + 10;
-	return -1;
+	unsigned char cu = ch & 0xdf;
+	return -1 +
+		((ch - '0' +  1) & (unsigned)((ch - '9' - 1) & ('0' - 1 - ch)) >> 8) +
+		((cu - 'A' + 11) & (unsigned)((cu - 'F' - 1) & ('A' - 1 - cu)) >> 8);
 }
 EXPORT_SYMBOL(hex_to_bin);
 
@@ -47,10 +65,13 @@ EXPORT_SYMBOL(hex_to_bin);
 int hex2bin(u8 *dst, const char *src, size_t count)
 {
 	while (count--) {
-		int hi = hex_to_bin(*src++);
-		int lo = hex_to_bin(*src++);
+		int hi, lo;
 
-		if ((hi < 0) || (lo < 0))
+		hi = hex_to_bin(*src++);
+		if (unlikely(hi < 0))
+			return -1;
+		lo = hex_to_bin(*src++);
+		if (unlikely(lo < 0))
 			return -1;
 
 		*dst++ = (hi << 4) | lo;
diff --git a/lib/nlattr.c b/lib/nlattr.c
index fce1e9afc6d9..ea27e1d069b1 100644
--- a/lib/nlattr.c
+++ b/lib/nlattr.c
@@ -316,7 +316,7 @@ int nla_strcmp(const struct nlattr *nla, const char *str)
 	int attrlen = nla_len(nla);
 	int d;
 
-	if (attrlen > 0 && buf[attrlen - 1] == '\0')
+	while (attrlen > 0 && buf[attrlen - 1] == '\0')
 		attrlen--;
 
 	d = attrlen - len;
diff --git a/lib/nodemask.c b/lib/nodemask.c
index e42a5bf44d33..f6ad9c2775a8 100644
--- a/lib/nodemask.c
+++ b/lib/nodemask.c
@@ -2,9 +2,9 @@
 #include <linux/module.h>
 #include <linux/random.h>
 
-int __next_node_in(int node, const nodemask_t *srcp)
+unsigned int __next_node_in(int node, const nodemask_t *srcp)
 {
-	int ret = __next_node(node, srcp);
+	unsigned int ret = __next_node(node, srcp);
 
 	if (ret == MAX_NUMNODES)
 		ret = __first_node(srcp);
diff --git a/localversion-rt b/localversion-rt
index 58dccbc39d0a..d30c7d5647e6 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt193
+-rt195
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 8aad9bd08462..6bed5da45f8f 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4593,7 +4593,14 @@ int huge_pmd_unshare(struct mm_struct *mm, unsigned long *addr, pte_t *ptep)
 	pud_clear(pud);
 	put_page(virt_to_page(ptep));
 	mm_dec_nr_pmds(mm);
-	*addr = ALIGN(*addr, HPAGE_SIZE * PTRS_PER_PTE) - HPAGE_SIZE;
+	/*
+	 * This update of passed address optimizes loops sequentially
+	 * processing addresses in increments of huge page size (PMD_SIZE
+	 * in this case).  By clearing the pud, a PUD_SIZE area is unmapped.
+	 * Update address to the 'last page' in the cleared area so that
+	 * calling loop can move to first page past this area.
+	 */
+	*addr |= PUD_SIZE - PMD_SIZE;
 	return 1;
 }
 #define want_pmd_share()	(1)
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index af817e5060fb..bb6cb42656b1 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -50,6 +50,8 @@ static int mcopy_atomic_pte(struct mm_struct *dst_mm,
 			/* don't free the page */
 			goto out;
 		}
+
+		flush_dcache_page(page);
 	} else {
 		page = *pagep;
 		*pagep = NULL;
@@ -267,6 +269,7 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
 				err = -EFAULT;
 				goto out;
 			}
+			flush_dcache_page(page);
 			goto retry;
 		} else
 			BUG_ON(page);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 40e6e5feb1e0..6f99da11d207 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3064,10 +3064,10 @@ int hci_register_dev(struct hci_dev *hdev)
 	 */
 	switch (hdev->dev_type) {
 	case HCI_PRIMARY:
-		id = ida_simple_get(&hci_index_ida, 0, 0, GFP_KERNEL);
+		id = ida_simple_get(&hci_index_ida, 0, HCI_MAX_ID, GFP_KERNEL);
 		break;
 	case HCI_AMP:
-		id = ida_simple_get(&hci_index_ida, 1, 0, GFP_KERNEL);
+		id = ida_simple_get(&hci_index_ida, 1, HCI_MAX_ID, GFP_KERNEL);
 		break;
 	default:
 		return -EINVAL;
@@ -3076,7 +3076,7 @@ int hci_register_dev(struct hci_dev *hdev)
 	if (id < 0)
 		return id;
 
-	sprintf(hdev->name, "hci%d", id);
+	snprintf(hdev->name, sizeof(hdev->name), "hci%d", id);
 	hdev->id = id;
 
 	BT_DBG("%p name %s bus %d", hdev, hdev->name, hdev->bus);
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index b3b4ffaa394f..9892ce82cbdf 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -542,19 +542,24 @@ static int sco_sock_connect(struct socket *sock, struct sockaddr *addr, int alen
 	    addr->sa_family != AF_BLUETOOTH)
 		return -EINVAL;
 
-	if (sk->sk_state != BT_OPEN && sk->sk_state != BT_BOUND)
-		return -EBADFD;
+	lock_sock(sk);
+	if (sk->sk_state != BT_OPEN && sk->sk_state != BT_BOUND) {
+		err = -EBADFD;
+		goto done;
+	}
 
-	if (sk->sk_type != SOCK_SEQPACKET)
-		return -EINVAL;
+	if (sk->sk_type != SOCK_SEQPACKET) {
+		err = -EINVAL;
+		goto done;
+	}
 
 	hdev = hci_get_route(&sa->sco_bdaddr, &sco_pi(sk)->src, BDADDR_BREDR);
-	if (!hdev)
-		return -EHOSTUNREACH;
+	if (!hdev) {
+		err = -EHOSTUNREACH;
+		goto done;
+	}
 	hci_dev_lock(hdev);
 
-	lock_sock(sk);
-
 	/* Set destination address and psm */
 	bacpy(&sco_pi(sk)->dst, &sa->sco_bdaddr);
 
diff --git a/net/core/filter.c b/net/core/filter.c
index 753f5baea1e5..a5bdd6ea1403 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -1388,7 +1388,7 @@ BPF_CALL_5(bpf_skb_store_bytes, struct sk_buff *, skb, u32, offset,
 
 	if (unlikely(flags & ~(BPF_F_RECOMPUTE_CSUM | BPF_F_INVALIDATE_HASH)))
 		return -EINVAL;
-	if (unlikely(offset > 0xffff))
+	if (unlikely(offset > INT_MAX))
 		return -EFAULT;
 	if (unlikely(bpf_try_make_writable(skb, offset + len)))
 		return -EFAULT;
@@ -1423,7 +1423,7 @@ BPF_CALL_4(bpf_skb_load_bytes, const struct sk_buff *, skb, u32, offset,
 {
 	void *ptr;
 
-	if (unlikely(offset > 0xffff))
+	if (unlikely(offset > INT_MAX))
 		goto err_clear;
 
 	ptr = skb_header_pointer(skb, offset, len, to);
diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
index 381fc854ad19..75f961425639 100644
--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -2360,9 +2360,10 @@ int ip_mc_source(int add, int omode, struct sock *sk, struct
 				newpsl->sl_addr[i] = psl->sl_addr[i];
 			/* decrease mem now to avoid the memleak warning */
 			atomic_sub(IP_SFLSIZE(psl->sl_max), &sk->sk_omem_alloc);
-			kfree_rcu(psl, rcu);
 		}
 		rcu_assign_pointer(pmc->sflist, newpsl);
+		if (psl)
+			kfree_rcu(psl, rcu);
 		psl = newpsl;
 	}
 	rv = 1;	/* > 0 for insert logic below if sl_count is 0 */
@@ -2460,11 +2461,13 @@ int ip_mc_msfilter(struct sock *sk, struct ip_msfilter *msf, int ifindex)
 			psl->sl_count, psl->sl_addr, 0);
 		/* decrease mem now to avoid the memleak warning */
 		atomic_sub(IP_SFLSIZE(psl->sl_max), &sk->sk_omem_alloc);
-		kfree_rcu(psl, rcu);
-	} else
+	} else {
 		(void) ip_mc_del_src(in_dev, &msf->imsf_multiaddr, pmc->sfmode,
 			0, NULL, 0);
+	}
 	rcu_assign_pointer(pmc->sflist, newpsl);
+	if (psl)
+		kfree_rcu(psl, rcu);
 	pmc->sfmode = msf->imsf_fmode;
 	err = 0;
 done:
diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index fe1801d9f059..eec225c637f0 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -339,14 +339,12 @@ static void __gre_xmit(struct sk_buff *skb, struct net_device *dev,
 		       __be16 proto)
 {
 	struct ip_tunnel *tunnel = netdev_priv(dev);
-
-	if (tunnel->parms.o_flags & TUNNEL_SEQ)
-		tunnel->o_seqno++;
+	__be16 flags = tunnel->parms.o_flags;
 
 	/* Push GRE header. */
 	gre_build_header(skb, tunnel->tun_hlen,
-			 tunnel->parms.o_flags, proto, tunnel->parms.o_key,
-			 htonl(tunnel->o_seqno));
+			 flags, proto, tunnel->parms.o_key,
+			 (flags & TUNNEL_SEQ) ? htonl(tunnel->o_seqno++) : 0);
 
 	ip_tunnel_xmit(skb, dev, tnl_params, tnl_params->protocol);
 }
diff --git a/net/ipv4/ping.c b/net/ipv4/ping.c
index dd4e46af1e53..23646a08ed7b 100644
--- a/net/ipv4/ping.c
+++ b/net/ipv4/ping.c
@@ -302,6 +302,7 @@ static int ping_check_bind_addr(struct sock *sk, struct inet_sock *isk,
 	struct net *net = sock_net(sk);
 	if (sk->sk_family == AF_INET) {
 		struct sockaddr_in *addr = (struct sockaddr_in *) uaddr;
+		u32 tb_id = RT_TABLE_LOCAL;
 		int chk_addr_ret;
 
 		if (addr_len < sizeof(*addr))
@@ -315,7 +316,8 @@ static int ping_check_bind_addr(struct sock *sk, struct inet_sock *isk,
 		pr_debug("ping_check_bind_addr(sk=%p,addr=%pI4,port=%d)\n",
 			 sk, &addr->sin_addr.s_addr, ntohs(addr->sin_port));
 
-		chk_addr_ret = inet_addr_type(net, addr->sin_addr.s_addr);
+		tb_id = l3mdev_fib_table_by_index(net, sk->sk_bound_dev_if) ? : tb_id;
+		chk_addr_ret = inet_addr_type_table(net, addr->sin_addr.s_addr, tb_id);
 
 		if (addr->sin_addr.s_addr == htonl(INADDR_ANY))
 			chk_addr_ret = RTN_LOCAL;
@@ -357,6 +359,14 @@ static int ping_check_bind_addr(struct sock *sk, struct inet_sock *isk,
 				return -ENODEV;
 			}
 		}
+
+		if (!dev && sk->sk_bound_dev_if) {
+			dev = dev_get_by_index_rcu(net, sk->sk_bound_dev_if);
+			if (!dev) {
+				rcu_read_unlock();
+				return -ENODEV;
+			}
+		}
 		has_addr = pingv6_ops.ipv6_chk_addr(net, &addr->sin6_addr, dev,
 						    scoped);
 		rcu_read_unlock();
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index f05b8d63dba3..624bdd74583b 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1606,6 +1606,7 @@ static int ip_route_input_mc(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 #endif
 	RT_CACHE_STAT_INC(in_slow_mc);
 
+	skb_dst_drop(skb);
 	skb_dst_set(skb, &rth->dst);
 	return 0;
 
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 01c73775ed00..b12a329ef187 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -2663,12 +2663,15 @@ static void tcp_mtup_probe_success(struct sock *sk)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 	struct inet_connection_sock *icsk = inet_csk(sk);
+	u64 val;
 
-	/* FIXME: breaks with very large cwnd */
 	tp->prior_ssthresh = tcp_current_ssthresh(sk);
-	tp->snd_cwnd = tp->snd_cwnd *
-		       tcp_mss_to_mtu(sk, tp->mss_cache) /
-		       icsk->icsk_mtup.probe_size;
+
+	val = (u64)tp->snd_cwnd * tcp_mss_to_mtu(sk, tp->mss_cache);
+	do_div(val, icsk->icsk_mtup.probe_size);
+	WARN_ON_ONCE((u32)val != val);
+	tp->snd_cwnd = max_t(u32, 1U, val);
+
 	tp->snd_cwnd_cnt = 0;
 	tp->snd_cwnd_stamp = tcp_time_stamp;
 	tp->snd_ssthresh = tcp_current_ssthresh(sk);
@@ -5159,7 +5162,17 @@ static void tcp_new_space(struct sock *sk)
 	sk->sk_write_space(sk);
 }
 
-static void tcp_check_space(struct sock *sk)
+/* Caller made space either from:
+ * 1) Freeing skbs in rtx queues (after tp->snd_una has advanced)
+ * 2) Sent skbs from output queue (and thus advancing tp->snd_nxt)
+ *
+ * We might be able to generate EPOLLOUT to the application if:
+ * 1) Space consumed in output/rtx queues is below sk->sk_sndbuf/2
+ * 2) notsent amount (tp->write_seq - tp->snd_nxt) became
+ *    small enough that tcp_stream_memory_free() decides it
+ *    is time to generate EPOLLOUT.
+ */
+void tcp_check_space(struct sock *sk)
 {
 	if (sock_flag(sk, SOCK_QUEUE_SHRUNK)) {
 		sock_reset_flag(sk, SOCK_QUEUE_SHRUNK);
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index aafea53c7c06..e0009cd69da7 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -83,6 +83,7 @@ static void tcp_event_new_data_sent(struct sock *sk, const struct sk_buff *skb)
 
 	NET_ADD_STATS(sock_net(sk), LINUX_MIB_TCPORIGDATASENT,
 		      tcp_skb_pcount(skb));
+	tcp_check_space(sk);
 }
 
 /* SND.NXT, if window was not shrunk.
@@ -3708,8 +3709,8 @@ int tcp_rtx_synack(const struct sock *sk, struct request_sock *req)
 	tcp_rsk(req)->txhash = net_tx_rndhash();
 	res = af_ops->send_synack(sk, NULL, &fl, req, NULL, TCP_SYNACK_NORMAL);
 	if (!res) {
-		__TCP_INC_STATS(sock_net(sk), TCP_MIB_RETRANSSEGS);
-		__NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPSYNRETRANS);
+		TCP_INC_STATS(sock_net(sk), TCP_MIB_RETRANSSEGS);
+		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPSYNRETRANS);
 		if (unlikely(tcp_passive_fastopen(sk)))
 			tcp_sk(sk)->total_retrans++;
 	}
diff --git a/net/ipv4/xfrm4_protocol.c b/net/ipv4/xfrm4_protocol.c
index dccefa9d84cf..5a4b19834fe2 100644
--- a/net/ipv4/xfrm4_protocol.c
+++ b/net/ipv4/xfrm4_protocol.c
@@ -298,4 +298,3 @@ void __init xfrm4_protocol_init(void)
 {
 	xfrm_input_register_afinfo(&xfrm4_input_afinfo);
 }
-EXPORT_SYMBOL(xfrm4_protocol_init);
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 6119ab33a56e..02f62253a835 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -3539,6 +3539,7 @@ static int addrconf_ifdown(struct net_device *dev, int how)
 	struct list_head del_list;
 	int _keep_addr;
 	bool keep_addr;
+	bool was_ready;
 	int state, i;
 
 	ASSERT_RTNL();
@@ -3602,7 +3603,10 @@ static int addrconf_ifdown(struct net_device *dev, int how)
 
 	addrconf_del_rs_timer(idev);
 
-	/* Step 2: clear flags for stateless addrconf */
+	/* Step 2: clear flags for stateless addrconf, repeated down
+	 *         detection
+	 */
+	was_ready = idev->if_flags & IF_READY;
 	if (!how)
 		idev->if_flags &= ~(IF_RS_SENT|IF_RA_RCVD|IF_READY);
 
@@ -3689,7 +3693,7 @@ static int addrconf_ifdown(struct net_device *dev, int how)
 	if (how) {
 		ipv6_ac_destroy_dev(idev);
 		ipv6_mc_destroy_dev(idev);
-	} else {
+	} else if (was_ready) {
 		ipv6_mc_down(idev);
 	}
 
@@ -3989,7 +3993,8 @@ static void addrconf_dad_completed(struct inet6_ifaddr *ifp, bool bump_id)
 	send_rs = send_mld &&
 		  ipv6_accept_ra(ifp->idev) &&
 		  ifp->idev->cnf.rtr_solicits != 0 &&
-		  (dev->flags&IFF_LOOPBACK) == 0;
+		  (dev->flags & IFF_LOOPBACK) == 0 &&
+		  (dev->type != ARPHRD_TUNNEL);
 	read_unlock_bh(&ifp->idev->lock);
 
 	/* While dad is in progress mld report's source address is in6_addrany.
diff --git a/net/key/af_key.c b/net/key/af_key.c
index c9cc9f75b099..0737fc7b7ebd 100644
--- a/net/key/af_key.c
+++ b/net/key/af_key.c
@@ -2861,6 +2861,10 @@ static int pfkey_process(struct sock *sk, struct sk_buff *skb, const struct sadb
 	void *ext_hdrs[SADB_EXT_MAX];
 	int err;
 
+	/* Non-zero return value of pfkey_broadcast() does not always signal
+	 * an error and even on an actual error we may still want to process
+	 * the message so rather ignore the return value.
+	 */
 	pfkey_broadcast(skb_clone(skb, GFP_KERNEL), GFP_KERNEL,
 			BROADCAST_PROMISC_ONLY, NULL, sock_net(sk));
 
@@ -2933,7 +2937,7 @@ static int count_ah_combs(const struct xfrm_tmpl *t)
 			break;
 		if (!aalg->pfkey_supported)
 			continue;
-		if (aalg_tmpl_set(t, aalg))
+		if (aalg_tmpl_set(t, aalg) && aalg->available)
 			sz += sizeof(struct sadb_comb);
 	}
 	return sz + sizeof(struct sadb_prop);
@@ -2951,7 +2955,7 @@ static int count_esp_combs(const struct xfrm_tmpl *t)
 		if (!ealg->pfkey_supported)
 			continue;
 
-		if (!(ealg_tmpl_set(t, ealg)))
+		if (!(ealg_tmpl_set(t, ealg) && ealg->available))
 			continue;
 
 		for (k = 1; ; k++) {
@@ -2962,7 +2966,7 @@ static int count_esp_combs(const struct xfrm_tmpl *t)
 			if (!aalg->pfkey_supported)
 				continue;
 
-			if (aalg_tmpl_set(t, aalg))
+			if (aalg_tmpl_set(t, aalg) && aalg->available)
 				sz += sizeof(struct sadb_comb);
 		}
 	}
diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index a0d901d8992e..324b685b343e 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -1640,12 +1640,9 @@ int ieee80211_vif_use_reserved_context(struct ieee80211_sub_if_data *sdata)
 
 	if (new_ctx->replace_state == IEEE80211_CHANCTX_REPLACE_NONE) {
 		if (old_ctx)
-			err = ieee80211_vif_use_reserved_reassign(sdata);
-		else
-			err = ieee80211_vif_use_reserved_assign(sdata);
+			return ieee80211_vif_use_reserved_reassign(sdata);
 
-		if (err)
-			return err;
+		return ieee80211_vif_use_reserved_assign(sdata);
 	}
 
 	/*
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index f5532a3ce72e..0eb5dfb1031f 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1066,6 +1066,9 @@ struct tpt_led_trigger {
  *	a scan complete for an aborted scan.
  * @SCAN_HW_CANCELLED: Set for our scan work function when the scan is being
  *	cancelled.
+ * @SCAN_BEACON_WAIT: Set whenever we're passive scanning because of radar/no-IR
+ *	and could send a probe request after receiving a beacon.
+ * @SCAN_BEACON_DONE: Beacon received, we can now send a probe request
  */
 enum {
 	SCAN_SW_SCANNING,
@@ -1074,6 +1077,8 @@ enum {
 	SCAN_COMPLETED,
 	SCAN_ABORTED,
 	SCAN_HW_CANCELLED,
+	SCAN_BEACON_WAIT,
+	SCAN_BEACON_DONE,
 };
 
 /**
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index a3ac9f57a489..8502b277d150 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -1179,8 +1179,7 @@ static void ieee80211_rx_reorder_ampdu(struct ieee80211_rx_data *rx,
 		goto dont_reorder;
 
 	/* not part of a BA session */
-	if (ack_policy != IEEE80211_QOS_CTL_ACK_POLICY_BLOCKACK &&
-	    ack_policy != IEEE80211_QOS_CTL_ACK_POLICY_NORMAL)
+	if (ack_policy == IEEE80211_QOS_CTL_ACK_POLICY_NOACK)
 		goto dont_reorder;
 
 	/* new, potentially un-ordered, ampdu frame - process it */
diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
index 23d8ac829279..701adcb9262e 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -205,6 +205,16 @@ void ieee80211_scan_rx(struct ieee80211_local *local, struct sk_buff *skb)
 	if (likely(!sdata1 && !sdata2))
 		return;
 
+	if (test_and_clear_bit(SCAN_BEACON_WAIT, &local->scanning)) {
+		/*
+		 * we were passive scanning because of radar/no-IR, but
+		 * the beacon/proberesp rx gives us an opportunity to upgrade
+		 * to active scan
+		 */
+		 set_bit(SCAN_BEACON_DONE, &local->scanning);
+		 ieee80211_queue_delayed_work(&local->hw, &local->scan_work, 0);
+	}
+
 	if (ieee80211_is_probe_resp(mgmt->frame_control)) {
 		struct cfg80211_scan_request *scan_req;
 		struct cfg80211_sched_scan_request *sched_scan_req;
@@ -646,6 +656,8 @@ static int __ieee80211_start_scan(struct ieee80211_sub_if_data *sdata,
 						IEEE80211_CHAN_RADAR)) ||
 		    !req->n_ssids) {
 			next_delay = IEEE80211_PASSIVE_CHANNEL_TIME;
+			if (req->n_ssids)
+				set_bit(SCAN_BEACON_WAIT, &local->scanning);
 		} else {
 			ieee80211_scan_state_send_probe(local, &next_delay);
 			next_delay = IEEE80211_CHANNEL_TIME;
@@ -826,6 +838,8 @@ static void ieee80211_scan_state_set_channel(struct ieee80211_local *local,
 	    !scan_req->n_ssids) {
 		*next_delay = IEEE80211_PASSIVE_CHANNEL_TIME;
 		local->next_scan_state = SCAN_DECISION;
+		if (scan_req->n_ssids)
+			set_bit(SCAN_BEACON_WAIT, &local->scanning);
 		return;
 	}
 
@@ -918,6 +932,8 @@ void ieee80211_scan_work(struct work_struct *work)
 			goto out;
 	}
 
+	clear_bit(SCAN_BEACON_WAIT, &local->scanning);
+
 	/*
 	 * as long as no delay is required advance immediately
 	 * without scheduling a new work
@@ -928,6 +944,10 @@ void ieee80211_scan_work(struct work_struct *work)
 			goto out_complete;
 		}
 
+		if (test_and_clear_bit(SCAN_BEACON_DONE, &local->scanning) &&
+		    local->next_scan_state == SCAN_DECISION)
+			local->next_scan_state = SCAN_SEND_PROBE;
+
 		switch (local->next_scan_state) {
 		case SCAN_DECISION:
 			/* if no more bands/channels left, complete scan */
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index ec460aedfc61..0aad9b8466aa 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -1756,23 +1756,27 @@ struct nft_expr *nft_expr_init(const struct nft_ctx *ctx,
 
 	err = nf_tables_expr_parse(ctx, nla, &info);
 	if (err < 0)
-		goto err1;
+		goto err_expr_parse;
+
+	err = -EOPNOTSUPP;
+	if (!(info.ops->type->flags & NFT_EXPR_STATEFUL))
+		goto err_expr_stateful;
 
 	err = -ENOMEM;
 	expr = kzalloc(info.ops->size, GFP_KERNEL);
 	if (expr == NULL)
-		goto err2;
+		goto err_expr_stateful;
 
 	err = nf_tables_newexpr(ctx, &info, expr);
 	if (err < 0)
-		goto err3;
+		goto err_expr_new;
 
 	return expr;
-err3:
+err_expr_new:
 	kfree(expr);
-err2:
+err_expr_stateful:
 	module_put(info.ops->type->owner);
-err1:
+err_expr_parse:
 	return ERR_PTR(err);
 }
 
diff --git a/net/netfilter/nft_dynset.c b/net/netfilter/nft_dynset.c
index 81adbfaffe38..5c25ffec2755 100644
--- a/net/netfilter/nft_dynset.c
+++ b/net/netfilter/nft_dynset.c
@@ -196,9 +196,6 @@ static int nft_dynset_init(const struct nft_ctx *ctx,
 		if (IS_ERR(priv->expr))
 			return PTR_ERR(priv->expr);
 
-		err = -EOPNOTSUPP;
-		if (!(priv->expr->ops->type->flags & NFT_EXPR_STATEFUL))
-			goto err1;
 	} else if (set->flags & NFT_SET_EVAL)
 		return -EINVAL;
 
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index a8674e9ff37b..47b1631bf14c 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1929,7 +1929,6 @@ static int netlink_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 		copied = len;
 	}
 
-	skb_reset_transport_header(data_skb);
 	err = skb_copy_datagram_msg(data_skb, 0, msg, copied);
 
 	if (msg->msg_name) {
diff --git a/net/nfc/core.c b/net/nfc/core.c
index 32a2dfc08f48..120259c2b6a7 100644
--- a/net/nfc/core.c
+++ b/net/nfc/core.c
@@ -50,7 +50,7 @@ int nfc_fw_download(struct nfc_dev *dev, const char *firmware_name)
 
 	device_lock(&dev->dev);
 
-	if (!device_is_registered(&dev->dev)) {
+	if (dev->shutting_down) {
 		rc = -ENODEV;
 		goto error;
 	}
@@ -106,7 +106,7 @@ int nfc_dev_up(struct nfc_dev *dev)
 
 	device_lock(&dev->dev);
 
-	if (!device_is_registered(&dev->dev)) {
+	if (dev->shutting_down) {
 		rc = -ENODEV;
 		goto error;
 	}
@@ -154,7 +154,7 @@ int nfc_dev_down(struct nfc_dev *dev)
 
 	device_lock(&dev->dev);
 
-	if (!device_is_registered(&dev->dev)) {
+	if (dev->shutting_down) {
 		rc = -ENODEV;
 		goto error;
 	}
@@ -218,7 +218,7 @@ int nfc_start_poll(struct nfc_dev *dev, u32 im_protocols, u32 tm_protocols)
 
 	device_lock(&dev->dev);
 
-	if (!device_is_registered(&dev->dev)) {
+	if (dev->shutting_down) {
 		rc = -ENODEV;
 		goto error;
 	}
@@ -257,7 +257,7 @@ int nfc_stop_poll(struct nfc_dev *dev)
 
 	device_lock(&dev->dev);
 
-	if (!device_is_registered(&dev->dev)) {
+	if (dev->shutting_down) {
 		rc = -ENODEV;
 		goto error;
 	}
@@ -302,7 +302,7 @@ int nfc_dep_link_up(struct nfc_dev *dev, int target_index, u8 comm_mode)
 
 	device_lock(&dev->dev);
 
-	if (!device_is_registered(&dev->dev)) {
+	if (dev->shutting_down) {
 		rc = -ENODEV;
 		goto error;
 	}
@@ -346,7 +346,7 @@ int nfc_dep_link_down(struct nfc_dev *dev)
 
 	device_lock(&dev->dev);
 
-	if (!device_is_registered(&dev->dev)) {
+	if (dev->shutting_down) {
 		rc = -ENODEV;
 		goto error;
 	}
@@ -412,7 +412,7 @@ int nfc_activate_target(struct nfc_dev *dev, u32 target_idx, u32 protocol)
 
 	device_lock(&dev->dev);
 
-	if (!device_is_registered(&dev->dev)) {
+	if (dev->shutting_down) {
 		rc = -ENODEV;
 		goto error;
 	}
@@ -458,7 +458,7 @@ int nfc_deactivate_target(struct nfc_dev *dev, u32 target_idx, u8 mode)
 
 	device_lock(&dev->dev);
 
-	if (!device_is_registered(&dev->dev)) {
+	if (dev->shutting_down) {
 		rc = -ENODEV;
 		goto error;
 	}
@@ -505,7 +505,7 @@ int nfc_data_exchange(struct nfc_dev *dev, u32 target_idx, struct sk_buff *skb,
 
 	device_lock(&dev->dev);
 
-	if (!device_is_registered(&dev->dev)) {
+	if (dev->shutting_down) {
 		rc = -ENODEV;
 		kfree_skb(skb);
 		goto error;
@@ -562,7 +562,7 @@ int nfc_enable_se(struct nfc_dev *dev, u32 se_idx)
 
 	device_lock(&dev->dev);
 
-	if (!device_is_registered(&dev->dev)) {
+	if (dev->shutting_down) {
 		rc = -ENODEV;
 		goto error;
 	}
@@ -611,7 +611,7 @@ int nfc_disable_se(struct nfc_dev *dev, u32 se_idx)
 
 	device_lock(&dev->dev);
 
-	if (!device_is_registered(&dev->dev)) {
+	if (dev->shutting_down) {
 		rc = -ENODEV;
 		goto error;
 	}
@@ -1142,6 +1142,7 @@ int nfc_register_device(struct nfc_dev *dev)
 			dev->rfkill = NULL;
 		}
 	}
+	dev->shutting_down = false;
 	device_unlock(&dev->dev);
 
 	rc = nfc_genl_device_added(dev);
@@ -1173,13 +1174,12 @@ void nfc_unregister_device(struct nfc_dev *dev)
 	if (dev->rfkill) {
 		rfkill_unregister(dev->rfkill);
 		rfkill_destroy(dev->rfkill);
+		dev->rfkill = NULL;
 	}
+	dev->shutting_down = true;
 	device_unlock(&dev->dev);
 
 	if (dev->ops->check_presence) {
-		device_lock(&dev->dev);
-		dev->shutting_down = true;
-		device_unlock(&dev->dev);
 		del_timer_sync(&dev->check_pres_timer);
 		cancel_work_sync(&dev->check_pres_work);
 	}
diff --git a/net/nfc/nci/data.c b/net/nfc/nci/data.c
index d20383779710..b8a295dd15d8 100644
--- a/net/nfc/nci/data.c
+++ b/net/nfc/nci/data.c
@@ -130,7 +130,7 @@ static int nci_queue_tx_data_frags(struct nci_dev *ndev,
 
 		skb_frag = nci_skb_alloc(ndev,
 					 (NCI_DATA_HDR_SIZE + frag_len),
-					 GFP_KERNEL);
+					 GFP_ATOMIC);
 		if (skb_frag == NULL) {
 			rc = -ENOMEM;
 			goto free_exit;
diff --git a/net/nfc/nci/hci.c b/net/nfc/nci/hci.c
index 5fae3f064ad0..9c37618f36c6 100644
--- a/net/nfc/nci/hci.c
+++ b/net/nfc/nci/hci.c
@@ -165,7 +165,7 @@ static int nci_hci_send_data(struct nci_dev *ndev, u8 pipe,
 
 	i = 0;
 	skb = nci_skb_alloc(ndev, conn_info->max_pkt_payload_len +
-			    NCI_DATA_HDR_SIZE, GFP_KERNEL);
+			    NCI_DATA_HDR_SIZE, GFP_ATOMIC);
 	if (!skb)
 		return -ENOMEM;
 
@@ -198,7 +198,7 @@ static int nci_hci_send_data(struct nci_dev *ndev, u8 pipe,
 		if (i < data_len) {
 			skb = nci_skb_alloc(ndev,
 					    conn_info->max_pkt_payload_len +
-					    NCI_DATA_HDR_SIZE, GFP_KERNEL);
+					    NCI_DATA_HDR_SIZE, GFP_ATOMIC);
 			if (!skb)
 				return -ENOMEM;
 
diff --git a/net/nfc/netlink.c b/net/nfc/netlink.c
index 6e771022d43e..9750997643bb 100644
--- a/net/nfc/netlink.c
+++ b/net/nfc/netlink.c
@@ -1254,7 +1254,7 @@ int nfc_genl_fw_download_done(struct nfc_dev *dev, const char *firmware_name,
 	struct sk_buff *msg;
 	void *hdr;
 
-	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_ATOMIC);
 	if (!msg)
 		return -ENOMEM;
 
@@ -1270,7 +1270,7 @@ int nfc_genl_fw_download_done(struct nfc_dev *dev, const char *firmware_name,
 
 	genlmsg_end(msg, hdr);
 
-	genlmsg_multicast(&nfc_genl_family, msg, 0, 0, GFP_KERNEL);
+	genlmsg_multicast(&nfc_genl_family, msg, 0, 0, GFP_ATOMIC);
 
 	return 0;
 
diff --git a/net/rxrpc/call_event.c b/net/rxrpc/call_event.c
index 97a17ada4431..4aae0904ae1b 100644
--- a/net/rxrpc/call_event.c
+++ b/net/rxrpc/call_event.c
@@ -403,7 +403,8 @@ void rxrpc_process_call(struct work_struct *work)
 		goto recheck_state;
 	}
 
-	if (test_and_clear_bit(RXRPC_CALL_EV_RESEND, &call->events)) {
+	if (test_and_clear_bit(RXRPC_CALL_EV_RESEND, &call->events) &&
+	    call->state != RXRPC_CALL_CLIENT_RECV_REPLY) {
 		rxrpc_resend(call, now);
 		goto recheck_state;
 	}
diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
index 2ec1c29eeba4..b8e87804296c 100644
--- a/net/rxrpc/sendmsg.c
+++ b/net/rxrpc/sendmsg.c
@@ -336,6 +336,12 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
 
 success:
 	ret = copied;
+	if (READ_ONCE(call->state) == RXRPC_CALL_COMPLETE) {
+		read_lock_bh(&call->state_lock);
+		if (call->error < 0)
+			ret = call->error;
+		read_unlock_bh(&call->state_lock);
+	}
 out:
 	call->tx_pending = skb;
 	_leave(" = %d", ret);
diff --git a/net/rxrpc/sysctl.c b/net/rxrpc/sysctl.c
index 34c706d2f79c..f9afc21b7e2c 100644
--- a/net/rxrpc/sysctl.c
+++ b/net/rxrpc/sysctl.c
@@ -18,7 +18,7 @@ static struct ctl_table_header *rxrpc_sysctl_reg_table;
 static const unsigned int zero = 0;
 static const unsigned int one = 1;
 static const unsigned int four = 4;
-static const unsigned int thirtytwo = 32;
+static const unsigned int max_backlog = RXRPC_BACKLOG_MAX - 1;
 static const unsigned int n_65535 = 65535;
 static const unsigned int n_max_acks = RXRPC_RXTX_BUFF_SIZE - 1;
 
@@ -114,7 +114,7 @@ static struct ctl_table rxrpc_sysctl_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= (void *)&four,
-		.extra2		= (void *)&thirtytwo,
+		.extra2		= (void *)&max_backlog,
 	},
 	{
 		.procname	= "rx_window_size",
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index c1a4b5d30814..330a2c9d1907 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -268,10 +268,13 @@ static int tc_ctl_tfilter(struct sk_buff *skb, struct nlmsghdr *n)
 		err = -ENOENT;
 		tp_ops = tcf_proto_lookup_ops(tca[TCA_KIND]);
 		if (tp_ops == NULL) {
-#ifdef CONFIG_MODULES
 			struct nlattr *kind = tca[TCA_KIND];
 			char name[IFNAMSIZ];
 
+			if (cl)
+				cops->put(q, cl);
+			cl = 0;
+#ifdef CONFIG_MODULES
 			if (kind != NULL &&
 			    nla_strlcpy(name, kind, IFNAMSIZ) < IFNAMSIZ) {
 				rtnl_unlock();
diff --git a/net/sctp/input.c b/net/sctp/input.c
index 9c1670b4a687..ed3a8a66a00b 100644
--- a/net/sctp/input.c
+++ b/net/sctp/input.c
@@ -103,6 +103,7 @@ int sctp_rcv(struct sk_buff *skb)
 	struct sctp_chunk *chunk;
 	union sctp_addr src;
 	union sctp_addr dest;
+	int bound_dev_if;
 	int family;
 	struct sctp_af *af;
 	struct net *net = dev_net(skb->dev);
@@ -180,7 +181,8 @@ int sctp_rcv(struct sk_buff *skb)
 	 * If a frame arrives on an interface and the receiving socket is
 	 * bound to another interface, via SO_BINDTODEVICE, treat it as OOTB
 	 */
-	if (sk->sk_bound_dev_if && (sk->sk_bound_dev_if != af->skb_iif(skb))) {
+	bound_dev_if = READ_ONCE(sk->sk_bound_dev_if);
+	if (bound_dev_if && (bound_dev_if != af->skb_iif(skb))) {
 		if (transport) {
 			sctp_transport_put(transport);
 			asoc = NULL;
diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index dd547edee59f..06b4b76edd9d 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -544,7 +544,11 @@ static __be32 *xdr_get_next_encode_buffer(struct xdr_stream *xdr,
 	 */
 	xdr->p = (void *)p + frag2bytes;
 	space_left = xdr->buf->buflen - xdr->buf->len;
-	xdr->end = (void *)p + min_t(int, space_left, PAGE_SIZE);
+	if (space_left - nbytes >= PAGE_SIZE)
+		xdr->end = (void *)p + PAGE_SIZE;
+	else
+		xdr->end = (void *)p + space_left - frag1bytes;
+
 	xdr->buf->page_len += frag2bytes;
 	xdr->buf->len += nbytes;
 	return p;
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index bf20ea260638..4e2c49cb692c 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -2882,9 +2882,6 @@ static struct rpc_xprt *xs_setup_local(struct xprt_create *args)
 		}
 		xprt_set_bound(xprt);
 		xs_format_peer_addresses(xprt, "local", RPCBIND_NETID_LOCAL);
-		ret = ERR_PTR(xs_local_setup_socket(transport));
-		if (ret)
-			goto out_err;
 		break;
 	default:
 		ret = ERR_PTR(-EAFNOSUPPORT);
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 62b0552b7b71..c5f3267aa08a 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1212,7 +1212,8 @@ static int secref_whitelist(const struct sectioncheck *mismatch,
 
 static inline int is_arm_mapping_symbol(const char *str)
 {
-	return str[0] == '$' && strchr("axtd", str[1])
+	return str[0] == '$' &&
+	       (str[1] == 'a' || str[1] == 'd' || str[1] == 't' || str[1] == 'x')
 	       && (str[2] == '\0' || str[2] == '.');
 }
 
@@ -1932,7 +1933,7 @@ static char *remove_dot(char *s)
 
 	if (n && s[n]) {
 		size_t m = strspn(s + n + 1, "0123456789");
-		if (m && (s[n + m] == '.' || s[n + m] == 0))
+		if (m && (s[n + m + 1] == '.' || s[n + m + 1] == 0))
 			s[n] = 0;
 	}
 	return s;
diff --git a/sound/core/jack.c b/sound/core/jack.c
index 36cfe1c54109..d2f9a92453f2 100644
--- a/sound/core/jack.c
+++ b/sound/core/jack.c
@@ -48,8 +48,11 @@ static int snd_jack_dev_disconnect(struct snd_device *device)
 #ifdef CONFIG_SND_JACK_INPUT_DEV
 	struct snd_jack *jack = device->device_data;
 
-	if (!jack->input_dev)
+	mutex_lock(&jack->input_dev_lock);
+	if (!jack->input_dev) {
+		mutex_unlock(&jack->input_dev_lock);
 		return 0;
+	}
 
 	/* If the input device is registered with the input subsystem
 	 * then we need to use a different deallocator. */
@@ -58,6 +61,7 @@ static int snd_jack_dev_disconnect(struct snd_device *device)
 	else
 		input_free_device(jack->input_dev);
 	jack->input_dev = NULL;
+	mutex_unlock(&jack->input_dev_lock);
 #endif /* CONFIG_SND_JACK_INPUT_DEV */
 	return 0;
 }
@@ -96,8 +100,11 @@ static int snd_jack_dev_register(struct snd_device *device)
 	snprintf(jack->name, sizeof(jack->name), "%s %s",
 		 card->shortname, jack->id);
 
-	if (!jack->input_dev)
+	mutex_lock(&jack->input_dev_lock);
+	if (!jack->input_dev) {
+		mutex_unlock(&jack->input_dev_lock);
 		return 0;
+	}
 
 	jack->input_dev->name = jack->name;
 
@@ -122,6 +129,7 @@ static int snd_jack_dev_register(struct snd_device *device)
 	if (err == 0)
 		jack->registered = 1;
 
+	mutex_unlock(&jack->input_dev_lock);
 	return err;
 }
 #endif /* CONFIG_SND_JACK_INPUT_DEV */
@@ -242,9 +250,11 @@ int snd_jack_new(struct snd_card *card, const char *id, int type,
 		return -ENOMEM;
 	}
 
-	/* don't creat input device for phantom jack */
-	if (!phantom_jack) {
 #ifdef CONFIG_SND_JACK_INPUT_DEV
+	mutex_init(&jack->input_dev_lock);
+
+	/* don't create input device for phantom jack */
+	if (!phantom_jack) {
 		int i;
 
 		jack->input_dev = input_allocate_device();
@@ -262,8 +272,8 @@ int snd_jack_new(struct snd_card *card, const char *id, int type,
 				input_set_capability(jack->input_dev, EV_SW,
 						     jack_switch_types[i]);
 
-#endif /* CONFIG_SND_JACK_INPUT_DEV */
 	}
+#endif /* CONFIG_SND_JACK_INPUT_DEV */
 
 	err = snd_device_new(card, SNDRV_DEV_JACK, jack, &ops);
 	if (err < 0)
@@ -303,10 +313,14 @@ EXPORT_SYMBOL(snd_jack_new);
 void snd_jack_set_parent(struct snd_jack *jack, struct device *parent)
 {
 	WARN_ON(jack->registered);
-	if (!jack->input_dev)
+	mutex_lock(&jack->input_dev_lock);
+	if (!jack->input_dev) {
+		mutex_unlock(&jack->input_dev_lock);
 		return;
+	}
 
 	jack->input_dev->dev.parent = parent;
+	mutex_unlock(&jack->input_dev_lock);
 }
 EXPORT_SYMBOL(snd_jack_set_parent);
 
@@ -354,6 +368,8 @@ EXPORT_SYMBOL(snd_jack_set_key);
 
 /**
  * snd_jack_report - Report the current status of a jack
+ * Note: This function uses mutexes and should be called from a
+ * context which can sleep (such as a workqueue).
  *
  * @jack:   The jack to report status for
  * @status: The current status of the jack
@@ -373,8 +389,11 @@ void snd_jack_report(struct snd_jack *jack, int status)
 					    status & jack_kctl->mask_bits);
 
 #ifdef CONFIG_SND_JACK_INPUT_DEV
-	if (!jack->input_dev)
+	mutex_lock(&jack->input_dev_lock);
+	if (!jack->input_dev) {
+		mutex_unlock(&jack->input_dev_lock);
 		return;
+	}
 
 	for (i = 0; i < ARRAY_SIZE(jack->key); i++) {
 		int testbit = SND_JACK_BTN_0 >> i;
@@ -393,6 +412,7 @@ void snd_jack_report(struct snd_jack *jack, int status)
 	}
 
 	input_sync(jack->input_dev);
+	mutex_unlock(&jack->input_dev_lock);
 #endif /* CONFIG_SND_JACK_INPUT_DEV */
 }
 EXPORT_SYMBOL(snd_jack_report);
diff --git a/sound/firewire/fireworks/fireworks_hwdep.c b/sound/firewire/fireworks/fireworks_hwdep.c
index 2e1d9a23920c..09ba61f60699 100644
--- a/sound/firewire/fireworks/fireworks_hwdep.c
+++ b/sound/firewire/fireworks/fireworks_hwdep.c
@@ -35,6 +35,7 @@ hwdep_read_resp_buf(struct snd_efw *efw, char __user *buf, long remained,
 	type = SNDRV_FIREWIRE_EVENT_EFW_RESPONSE;
 	if (copy_to_user(buf, &type, sizeof(type)))
 		return -EFAULT;
+	count += sizeof(type);
 	remained -= sizeof(type);
 	buf += sizeof(type);
 
diff --git a/sound/isa/wavefront/wavefront_synth.c b/sound/isa/wavefront/wavefront_synth.c
index 6c06d0645779..b205c12c6009 100644
--- a/sound/isa/wavefront/wavefront_synth.c
+++ b/sound/isa/wavefront/wavefront_synth.c
@@ -1091,7 +1091,8 @@ wavefront_send_sample (snd_wavefront_t *dev,
 
 			if (dataptr < data_end) {
 		
-				__get_user (sample_short, dataptr);
+				if (get_user(sample_short, dataptr))
+					return -EFAULT;
 				dataptr += skip;
 		
 				if (data_is_unsigned) { /* GUS ? */
diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index f7797e546e3d..5a3dd06ff105 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -942,6 +942,13 @@ static int patch_conexant_auto(struct hda_codec *codec)
 		snd_hda_pick_fixup(codec, cxt5051_fixup_models,
 				   cxt5051_fixups, cxt_fixups);
 		break;
+	case 0x14f15098:
+		codec->pin_amp_workaround = 1;
+		spec->gen.mixer_nid = 0x22;
+		spec->gen.add_stereo_mix_input = HDA_HINT_STEREO_MIX_AUTO;
+		snd_hda_pick_fixup(codec, cxt5066_fixup_models,
+				   cxt5066_fixups, cxt_fixups);
+		break;
 	case 0x14f150f2:
 		codec->power_save_node = 1;
 		/* Fall through */
diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index e7aef841f87d..1a55f6aecdfe 100644
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -419,6 +419,9 @@ static int max98090_put_enab_tlv(struct snd_kcontrol *kcontrol,
 
 	val = (val >> mc->shift) & mask;
 
+	if (sel < 0 || sel > mc->max)
+		return -EINVAL;
+
 	*select = sel;
 
 	/* Setting a volume is only valid if it is already On */
@@ -433,7 +436,7 @@ static int max98090_put_enab_tlv(struct snd_kcontrol *kcontrol,
 		mask << mc->shift,
 		sel << mc->shift);
 
-	return 0;
+	return *select != val;
 }
 
 static const char *max98090_perf_pwr_text[] =
diff --git a/sound/soc/codecs/rt5514.c b/sound/soc/codecs/rt5514.c
index e024800213f5..a86ed616ec41 100644
--- a/sound/soc/codecs/rt5514.c
+++ b/sound/soc/codecs/rt5514.c
@@ -345,7 +345,7 @@ static int rt5514_dsp_voice_wake_up_put(struct snd_kcontrol *kcontrol,
 		}
 	}
 
-	return 0;
+	return 1;
 }
 
 static const struct snd_kcontrol_new rt5514_snd_controls[] = {
diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 1ac96ef9ee20..703b26ec4e15 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3878,6 +3878,12 @@ static int rt5645_i2c_remove(struct i2c_client *i2c)
 	if (i2c->irq)
 		free_irq(i2c->irq, rt5645);
 
+	/*
+	 * Since the rt5645_btn_check_callback() can queue jack_detect_work,
+	 * the timer need to be delted first
+	 */
+	del_timer_sync(&rt5645->btn_check_timer);
+
 	cancel_delayed_work_sync(&rt5645->jack_detect_work);
 	cancel_delayed_work_sync(&rt5645->rcclock_work);
 
diff --git a/sound/soc/codecs/wm2000.c b/sound/soc/codecs/wm2000.c
index 23cde3a0dc11..73cda3c2a861 100644
--- a/sound/soc/codecs/wm2000.c
+++ b/sound/soc/codecs/wm2000.c
@@ -545,7 +545,7 @@ static int wm2000_anc_transition(struct wm2000_priv *wm2000,
 {
 	struct i2c_client *i2c = wm2000->i2c;
 	int i, j;
-	int ret;
+	int ret = 0;
 
 	if (wm2000->anc_mode == mode)
 		return 0;
@@ -575,13 +575,13 @@ static int wm2000_anc_transition(struct wm2000_priv *wm2000,
 		ret = anc_transitions[i].step[j](i2c,
 						 anc_transitions[i].analogue);
 		if (ret != 0)
-			return ret;
+			break;
 	}
 
 	if (anc_transitions[i].dest == ANC_OFF)
 		clk_disable_unprepare(wm2000->mclk);
 
-	return 0;
+	return ret;
 }
 
 static int wm2000_anc_set_mode(struct wm2000_priv *wm2000)
diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
index 4f9a1eb28120..abe5e77ba171 100644
--- a/sound/soc/codecs/wm8731.c
+++ b/sound/soc/codecs/wm8731.c
@@ -604,7 +604,7 @@ static int wm8731_hw_init(struct device *dev, struct wm8731_priv *wm8731)
 	ret = wm8731_reset(wm8731->regmap);
 	if (ret < 0) {
 		dev_err(dev, "Failed to issue reset: %d\n", ret);
-		goto err_regulator_enable;
+		goto err;
 	}
 
 	/* Clear POWEROFF, keep everything else disabled */
@@ -621,10 +621,7 @@ static int wm8731_hw_init(struct device *dev, struct wm8731_priv *wm8731)
 
 	regcache_mark_dirty(wm8731->regmap);
 
-err_regulator_enable:
-	/* Regulators will be enabled by bias management */
-	regulator_bulk_disable(ARRAY_SIZE(wm8731->supplies), wm8731->supplies);
-
+err:
 	return ret;
 }
 
@@ -768,21 +765,27 @@ static int wm8731_i2c_probe(struct i2c_client *i2c,
 		ret = PTR_ERR(wm8731->regmap);
 		dev_err(&i2c->dev, "Failed to allocate register map: %d\n",
 			ret);
-		return ret;
+		goto err_regulator_enable;
 	}
 
 	ret = wm8731_hw_init(&i2c->dev, wm8731);
 	if (ret != 0)
-		return ret;
+		goto err_regulator_enable;
 
 	ret = snd_soc_register_codec(&i2c->dev,
 			&soc_codec_dev_wm8731, &wm8731_dai, 1);
 	if (ret != 0) {
 		dev_err(&i2c->dev, "Failed to register CODEC: %d\n", ret);
-		return ret;
+		goto err_regulator_enable;
 	}
 
 	return 0;
+
+err_regulator_enable:
+	/* Regulators will be enabled by bias management */
+	regulator_bulk_disable(ARRAY_SIZE(wm8731->supplies), wm8731->supplies);
+
+	return ret;
 }
 
 static int wm8731_i2c_remove(struct i2c_client *client)
diff --git a/sound/soc/codecs/wm8958-dsp2.c b/sound/soc/codecs/wm8958-dsp2.c
index 6b864c0fc2b6..fa803cef2324 100644
--- a/sound/soc/codecs/wm8958-dsp2.c
+++ b/sound/soc/codecs/wm8958-dsp2.c
@@ -533,7 +533,7 @@ static int wm8958_mbc_put(struct snd_kcontrol *kcontrol,
 
 	wm8958_dsp_apply(codec, mbc, wm8994->mbc_ena[mbc]);
 
-	return 0;
+	return 1;
 }
 
 #define WM8958_MBC_SWITCH(xname, xval) {\
@@ -659,7 +659,7 @@ static int wm8958_vss_put(struct snd_kcontrol *kcontrol,
 
 	wm8958_dsp_apply(codec, vss, wm8994->vss_ena[vss]);
 
-	return 0;
+	return 1;
 }
 
 
@@ -733,7 +733,7 @@ static int wm8958_hpf_put(struct snd_kcontrol *kcontrol,
 
 	wm8958_dsp_apply(codec, hpf % 3, ucontrol->value.integer.value[0]);
 
-	return 0;
+	return 1;
 }
 
 #define WM8958_HPF_SWITCH(xname, xval) {\
@@ -827,7 +827,7 @@ static int wm8958_enh_eq_put(struct snd_kcontrol *kcontrol,
 
 	wm8958_dsp_apply(codec, eq, ucontrol->value.integer.value[0]);
 
-	return 0;
+	return 1;
 }
 
 #define WM8958_ENH_EQ_SWITCH(xname, xval) {\
diff --git a/sound/soc/mediatek/mt8173/mt8173-max98090.c b/sound/soc/mediatek/mt8173/mt8173-max98090.c
index cab30cb48366..85bf9eafda49 100644
--- a/sound/soc/mediatek/mt8173/mt8173-max98090.c
+++ b/sound/soc/mediatek/mt8173/mt8173-max98090.c
@@ -170,7 +170,8 @@ static int mt8173_max98090_dev_probe(struct platform_device *pdev)
 	if (!codec_node) {
 		dev_err(&pdev->dev,
 			"Property 'audio-codec' missing or invalid\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto put_platform_node;
 	}
 	for (i = 0; i < card->num_links; i++) {
 		if (mt8173_max98090_dais[i].codec_name)
@@ -185,6 +186,8 @@ static int mt8173_max98090_dev_probe(struct platform_device *pdev)
 			__func__, ret);
 
 	of_node_put(codec_node);
+
+put_platform_node:
 	of_node_put(platform_node);
 	return ret;
 }
diff --git a/sound/soc/mxs/mxs-saif.c b/sound/soc/mxs/mxs-saif.c
index 5977a2011d9e..76e1059e7f15 100644
--- a/sound/soc/mxs/mxs-saif.c
+++ b/sound/soc/mxs/mxs-saif.c
@@ -748,6 +748,7 @@ static int mxs_saif_probe(struct platform_device *pdev)
 		saif->master_id = saif->id;
 	} else {
 		ret = of_alias_get_id(master, "saif");
+		of_node_put(master);
 		if (ret < 0)
 			return ret;
 		else
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 878a4fc97f04..40bf50cd87bc 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3165,7 +3165,6 @@ int snd_soc_dapm_put_volsw(struct snd_kcontrol *kcontrol,
 			update.val = val;
 			card->update = &update;
 		}
-		change |= reg_change;
 
 		ret = soc_dapm_mixer_update_power(card, kcontrol, connect);
 
@@ -3270,7 +3269,6 @@ int snd_soc_dapm_put_enum_double(struct snd_kcontrol *kcontrol,
 			update.val = val;
 			card->update = &update;
 		}
-		change |= reg_change;
 
 		ret = soc_dapm_mux_update_power(card, kcontrol, item[0], e);
 
diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index 61f0c9d6f6dc..67d22b4baeb0 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -98,10 +98,10 @@ static int dmaengine_pcm_hw_params(struct snd_pcm_substream *substream,
 
 	memset(&slave_config, 0, sizeof(slave_config));
 
-	if (pcm->config && pcm->config->prepare_slave_config)
-		prepare_slave_config = pcm->config->prepare_slave_config;
-	else
+	if (!pcm->config)
 		prepare_slave_config = snd_dmaengine_pcm_prepare_slave_config;
+	else
+		prepare_slave_config = pcm->config->prepare_slave_config;
 
 	if (prepare_slave_config) {
 		ret = prepare_slave_config(substream, params, &slave_config);
diff --git a/sound/soc/soc-ops.c b/sound/soc/soc-ops.c
index 74968ddee49f..90ba5521c189 100644
--- a/sound/soc/soc-ops.c
+++ b/sound/soc/soc-ops.c
@@ -528,7 +528,15 @@ int snd_soc_put_volsw_range(struct snd_kcontrol *kcontrol,
 	unsigned int mask = (1 << fls(max)) - 1;
 	unsigned int invert = mc->invert;
 	unsigned int val, val_mask;
-	int err, ret;
+	int err, ret, tmp;
+
+	tmp = ucontrol->value.integer.value[0];
+	if (tmp < 0)
+		return -EINVAL;
+	if (mc->platform_max && tmp > mc->platform_max)
+		return -EINVAL;
+	if (tmp > mc->max - mc->min + 1)
+		return -EINVAL;
 
 	if (invert)
 		val = (max - ucontrol->value.integer.value[0]) & mask;
@@ -543,6 +551,14 @@ int snd_soc_put_volsw_range(struct snd_kcontrol *kcontrol,
 	ret = err;
 
 	if (snd_soc_volsw_is_stereo(mc)) {
+		tmp = ucontrol->value.integer.value[1];
+		if (tmp < 0)
+			return -EINVAL;
+		if (mc->platform_max && tmp > mc->platform_max)
+			return -EINVAL;
+		if (tmp > mc->max - mc->min + 1)
+			return -EINVAL;
+
 		if (invert)
 			val = (max - ucontrol->value.integer.value[1]) & mask;
 		else
diff --git a/tools/perf/bench/numa.c b/tools/perf/bench/numa.c
index 7b364f2926d4..901e9d6efcec 100644
--- a/tools/perf/bench/numa.c
+++ b/tools/perf/bench/numa.c
@@ -1626,7 +1626,7 @@ static int __bench_numa(const char *name)
 		"GB/sec,", "total-speed",	"GB/sec total speed");
 
 	if (g->p.show_details >= 2) {
-		char tname[14 + 2 * 10 + 1];
+		char tname[14 + 2 * 11 + 1];
 		struct thread_data *td;
 		for (p = 0; p < g->p.nr_proc; p++) {
 			for (t = 0; t < g->p.nr_threads; t++) {
