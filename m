Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37C2C5167FD
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 23:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355000AbiEAVRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 17:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233783AbiEAVRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 17:17:38 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D952BB1F
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 14:14:10 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id h29so15216131lfj.2
        for <linux-kernel@vger.kernel.org>; Sun, 01 May 2022 14:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=seOYV/KrABZO0nd/4gNF41neL13qb9tJHMMIOhhovEU=;
        b=goIHsDvGXWumQcfxFMz4IE2hIhItfgUdnoOyppV5GLUAyIix6RH8mGtvjdSvBJ59XV
         v5LhL3f5S14nXH8mw5t+gkA6+SAwJik/ybRk1A9yAnCIDSzk+a/6SXjStLVhR2bbpdc1
         ADDCjIYsMe+WFFSiMiejmJdce5kX3uwswmOs0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=seOYV/KrABZO0nd/4gNF41neL13qb9tJHMMIOhhovEU=;
        b=7Fw+lmXv7FtPNbFnzPy2dcwWUVvek1ASZt3wS9voTGmcttMUPIh2vSR7cW5ib37tkd
         vVjOW8d2hoHI/3Rg6gIBSfKjQatCEWtvOjJo17rTKvhE9FRjw7iv5ecZFHXqW7ASBZob
         F4fQass0h1ayFOn8+9GezzBYVM4hoGP7CBTLqToiYC6ZxdmgpFpjZA75JHcoVffRG3t9
         ugrARib2D94i6Kva0uEW09gnJLrIe8FbRcj6PuYVqD+WBrOMLogf6zPqNEN2nYBI655y
         YIz8w3SyXMwOc1cP7b2f8EKx/7L4nC8+2V9Rs8ReB4LaP+ahIqH/5lEGwF6XFi06K33H
         um+g==
X-Gm-Message-State: AOAM533+kjrWMWqWXOXyK46wKo+T9C4DMUgzFbRE3xvhvaHjSv/Bs96A
        sDGdgmX0YuvngY0HHThUbPAdaCrRVZFtBb+u
X-Google-Smtp-Source: ABdhPJxvVPrIoNcfbdFFSfqe5feqmjcbkTC3s2MqQ0RblAKnaSYUJfuo3Dv/1h8crHKWKkCnMhqQqA==
X-Received: by 2002:ac2:504e:0:b0:471:fa2a:fad with SMTP id a14-20020ac2504e000000b00471fa2a0fadmr7414697lfm.148.1651439647889;
        Sun, 01 May 2022 14:14:07 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id 25-20020ac25699000000b0047255d211d8sm530418lfr.263.2022.05.01.14.14.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 May 2022 14:14:07 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id w1so22466799lfa.4
        for <linux-kernel@vger.kernel.org>; Sun, 01 May 2022 14:14:06 -0700 (PDT)
X-Received: by 2002:a05:6512:1083:b0:472:1013:aad1 with SMTP id
 j3-20020a056512108300b004721013aad1mr7172155lfg.52.1651439646205; Sun, 01 May
 2022 14:14:06 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 1 May 2022 14:13:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjUhfhaes6_hMYDQFTbGjkmA-j2ZSeXZ32H66ufRfYrmQ@mail.gmail.com>
Message-ID: <CAHk-=wjUhfhaes6_hMYDQFTbGjkmA-j2ZSeXZ32H66ufRfYrmQ@mail.gmail.com>
Subject: Linux 5.18-rc5
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

So if rc4 last week was tiny and smaller than usual, it seems to have
been partly timing, and rc5 is now a bit larger than usual.

But only a very tiny bit larger - certainly not outrageously so, and
not something that worries me (admittedly partly because of that small
rc4: it doesn't feel like we're having any more issues than usual,
it's just that the work ended up shifting a bit to this past week).

The diffstat looks normal too, although with an odd bump for the n_gsm
tty ldisc code. I could have sworn that thing was legacy and nobody
used it, but apparently I would have been very wrong about that.

That small oddity aside, nothing surprising in here, with about half
the patch being drivers (mainly networking, gpu, pincontrol, clk, usb,
and that tty gsm thing), with the rest being the usual suspects:
architecture fixes (kvm, some arm dts files), core networking, tools
(both objtool and perf) and some documentation fixes. Add in a few
random things, and you have rc5.

The shortlog is appended for people who want to see the details, but
it honestly doesn't look very interesting.

But "interesting" isn't what we're going for - we're past the halfway
mark in the release, and "boring" is very much what we want.

Please do test, and hopefully we don't have some silly brown-paper bug
like the no-mmu breakage in rc4.

                  Linus

---

Adam Ford (3):
      soc: imx: imx8m-blk-ctrl: Fix IMX8MN_DISPBLK_PD_ISI hang
      ARM: dts: am3517-evm: Fix misc pinmuxing
      ARM: dts: logicpd-som-lv: Fix wrong pinmuxing on OMAP35

Adam Zabrocki (1):
      kprobes: Fix KRETPROBES when CONFIG_KRETPROBE_ON_RETHOOK is set

Adrian Hunter (1):
      perf intel-pt: Fix timeless decoding with perf.data directory

Akira Yokosawa (1):
      docs: vm/page_owner: use literal blocks for param description

Alessandro Astone (2):
      binder: Address corner cases in deferred copy and fixup
      binder: Gracefully handle BINDER_TYPE_FDA objects with num_fds=3D0

Alex Deucher (1):
      drm/amdgpu: don't runtime suspend if there are displays attached (v3)

Alexander Shiyan (1):
      video: fbdev: clps711x-fb: Use syscon_regmap_lookup_by_phandle

Alexander Stein (1):
      arm64: dts: imx8mq-tqma8mq: change the spi-nor tx

Alexandru Elisei (1):
      KVM/arm64: Don't emulate a PMU for 32-bit guests if feature not set

Andreas Gruenbacher (2):
      gfs2: Don't re-check for write past EOF unnecessarily
      gfs2: No short reads or writes upon glock contention

Andy Shevchenko (1):
      pinctrl: alderlake: Fix register offsets for ADL-N variant

Arnaud Pouliquen (1):
      RISC-V: configs: Configs that had RPMSG_CHAR now get RPMSG_CTRL

Arnd Bergmann (2):
      Revert "arm64: dts: tegra: Fix boolean properties with values"
      Revert "arm: dts: at91: Fix boolean properties with values"

Artem Bityutskiy (2):
      intel_idle: Fix the 'preferred_cstates' module parameter
      intel_idle: Fix SPR C6 optimization

Bagas Sanjaya (2):
      Documentation: siphash: convert danger note to warning for HalfSipHas=
h
      Documentation: siphash: enclose HalfSipHash usage example in the
literal block

Baruch Siach (1):
      net: phy: marvell10g: fix return value on error

Borislav Petkov (2):
      x86/cpu: Load microcode during restore_processor_state()
      usb: typec: tcpm: Fix undefined behavior due to shift
overflowing the constant

Bruno Thomsen (1):
      USB: serial: cp210x: add PIDs for Kamstrup USB Meter Reader

Catalin Marinas (1):
      elf: Fix the arm64 MTE ELF segment name and value

ChiYuan Huang (1):
      regulator: dt-bindings: Revise the rt5190a buck/ldo description

Christian Hewitt (2):
      arm64: dts: meson: remove CPU opps below 1GHz for G12B boards
      arm64: dts: meson: remove CPU opps below 1GHz for SM1 boards

Christoph Hellwig (3):
      btrfs: fix and document the zoned device choice in alloc_new_bio
      btrfs: fix direct I/O read repair for split bios
      btrfs: fix direct I/O writes for split bios on zoned devices

Christophe JAILLET (4):
      video: fbdev: of: display_timing: Remove a redundant zeroing of memor=
y
      phy: ti: tusb1210: Fix an error handling path in tusb1210_probe()
      usb: misc: eud: Fix an error handling path in eud_probe()
      bus: sunxi-rsb: Fix the return value of sunxi_rsb_device_create()

Christophe Leroy (2):
      video: fbdev: aty/matrox/...: Prepare cleanup of powerpc's asm/prom.h
      eeprom: at25: Use DMA safe buffers

Chuanhong Guo (1):
      mtd: rawnand: fix ecc parameters for mt7622

Claudiu Beznea (2):
      ARM: dts: at91: sama5d4_xplained: fix pinctrl phandle name
      ARM: dts: at91: fix pinctrl phandles

Cl=C3=A9ment L=C3=A9ger (1):
      net: bridge: switchdev: check br_vlan_group() return value

Conor Dooley (10):
      clk: microchip: mpfs: don't reset disabled peripherals
      clk: microchip: mpfs: fix parents for FIC clocks
      clk: microchip: mpfs: mark CLK_ATHENA as critical
      riscv: dts: microchip: fix usage of fic clocks on mpfs
      dt-bindings: clk: mpfs document msspll dri registers
      dt-bindings: clk: mpfs: add defines for two new clocks
      dt-bindings: rtc: add refclk to mpfs-rtc
      clk: microchip: mpfs: re-parent the configurable clocks
      clk: microchip: mpfs: add RTCREF clock control
      riscv: dts: microchip: reparent mpfs clocks

Damien Le Moal (2):
      zonefs: Clear inode information flags on inode creation
      zonefs: Fix management of open zones

Dan Carpenter (4):
      iio: dac: ad3552r: fix signedness bug in ad3552r_reset()
      iio:dac:ad3552r: Fix an IS_ERR() vs NULL check
      net: lan966x: fix a couple off by one bugs
      platform/x86: asus-wmi: Potential buffer overflow in
asus_wmi_evaluate_method_buf()

Dan Vacura (1):
      usb: gadget: uvc: Fix crash when encoding data for usb request

Daniel Lezcano (2):
      Revert "thermal/core: Deprecate changing cooling device state
from userspace"
      thermal/governor: Remove deprecated information

Daniel Starke (21):
      tty: n_gsm: fix missing mux reset on config change at responder
      tty: n_gsm: fix restart handling via CLD command
      tty: n_gsm: fix decoupled mux resource
      tty: n_gsm: fix mux cleanup after unregister tty device
      tty: n_gsm: fix wrong signal octet encoding in convergence layer type=
 2
      tty: n_gsm: fix frame reception handling
      tty: n_gsm: fix malformed counter for out of frame data
      tty: n_gsm: fix insufficient txframe size
      tty: n_gsm: fix wrong DLCI release order
      tty: n_gsm: fix missing explicit ldisc flush
      tty: n_gsm: fix wrong command retry handling
      tty: n_gsm: fix wrong command frame length field encoding
      tty: n_gsm: fix wrong signal octets encoding in MSC
      tty: n_gsm: fix missing tty wakeup in convergence layer type 2
      tty: n_gsm: fix reset fifo race condition
      tty: n_gsm: fix incorrect UA handling
      tty: n_gsm: fix missing update of modem controls after DLCI open
      tty: n_gsm: fix broken virtual tty handling
      tty: n_gsm: fix invalid use of MSC in advanced option
      tty: n_gsm: fix software flow control handling
      tty: n_gsm: fix sometimes uninitialized warning in gsm_dlci_modem_out=
put()

Daniele Palmas (1):
      USB: serial: option: add Telit 0x1057, 0x1058, 0x1075 compositions

Dany Madden (1):
      Revert "ibmvnic: Add ethtool private flag for driver-defined queue li=
mits"

Darren Hart (1):
      topology: make core_mask include at least cluster_siblings

Darryn Anton Jordan (1):
      platform/x86: gigabyte-wmi: added support for B660 GAMING X DDR4
motherboard

Dave Chinner (2):
      xfs: convert buffer flags to unsigned.
      xfs: reorder iunlink remove operation in xfs_ifree

David E. Box (3):
      platform/x86/intel/sdsi: Handle leaky bucket
      platform/x86/intel/sdsi: Poll on ready bit for writes
      platform/x86/intel/sdsi: Fix bug in multi packet reads

David Jeffery (1):
      scsi: target: pscsi: Set SCF_TREAT_READ_AS_NORMAL flag only if
there is valid data

David Yat Sin (2):
      drm/amdkfd: Fix GWS queue count
      drm/amdkfd: CRIU add support for GWS queues

Dinh Nguyen (1):
      net: ethernet: stmmac: fix write to sgmii_adapter_base

Dmitry Baryshkov (5):
      cpufreq: qcom-hw: drop affinity hint before freeing the IRQ
      cpufreq: qcom-hw: fix the race between LMH worker and cpuhp
      cpufreq: qcom-hw: fix the opp entries refcounting
      cpufreq: qcom-hw: provide online/offline operations
      clk: qcom: clk-rcg2: fix gfx3d frequency calculation

Dmitry Monakhov (1):
      x86/unwind/orc: Recheck address range after stack info was updated

Dmitry Osipenko (2):
      ARM: tegra_defconfig: Update CONFIG_TEGRA_VDE option
      ARM: config: multi v7: Enable NVIDIA Tegra video decoder driver

Dongliang Mu (1):
      tee: optee: add missing mutext_destroy in optee_ffa_probe

Eric Biggers (1):
      Documentation: siphash: disambiguate HalfSipHash algorithm from
hsiphash functions

Eric Dumazet (2):
      tcp: fix potential xmit stalls caused by TCP_NOTSENT_LOWAT
      tcp: make sure treq->af_specific is initialized

Eugen Hristev (1):
      ARM: dts: at91: sama7g5ek: enable pull-up on flexcom3 console lines

Eugene Syromiatnikov (1):
      io_uring: check that data field is 0 in ringfd unregister

Evan Green (1):
      xhci: Enable runtime PM on second Alderlake controller

Evan Quan (1):
      drm/amd/pm: fix the deadlock issue observed on SI

Eyal Birger (1):
      bpf, lwt: Fix crash when using bpf_skb_set_tunnel_key() from
bpf_xmit lwt hook

Fabio Estevam (2):
      ARM: dts: imx6qdl-apalis: Fix sgtl5000 detection issue
      arm64: dts: imx8mn-ddr4-evk: Describe the 32.768 kHz PMIC clock

Fawzi Khaber (1):
      iio: imu: inv_icm42600: Fix I2C init possible nack

Filipe Manana (2):
      btrfs: fix leaked plug after failure syncing log on zoned filesystems
      btrfs: fix assertion failure during scrub due to block group realloca=
tion

Florian Fainelli (1):
      MAINTAINERS: Update BNXT entry with firmware files

Florian Westphal (2):
      netfilter: nf_conntrack_tcp: re-init for syn packets only
      netfilter: nft_socket: only do sk lookups when indev is available

Francesco Ruggeri (1):
      tcp: md5: incorrect tcp_header_len for incoming connections

Gabriele Mazzotta (1):
      platform/x86: dell-laptop: Add quirk entry for Latitude 7520

Geert Uytterhoeven (3):
      linux/fb.h: Spelling s/palette/palette/
      video: fbdev: sh_mobile_lcdcfb: Remove
sh_mobile_lcdc_check_var() declaration
      memory: renesas-rpc-if: Fix HF/OSPI data transfer in Manual Mode

Greg Kroah-Hartman (1):
      topology: Fix up build warning in topology_is_visible()

Guillaume Giraudon (1):
      arm64: dts: meson-sm1-bananapi-m5: fix wrong GPIO pin labeling for CO=
N1

Guo Ren (1):
      riscv: patch_text: Fixup last cpu should be master

Gwendal Grignou (1):
      iio: sx9324: Fix default precharge internal resistance register

H. Nikolaus Schaller (1):
      ARM: dts: Fix mmc order for omap3-gta04

Hangyu Hua (1):
      usb: misc: fix improper handling of refcount in uss720_probe()

Hans de Goede (3):
      phy: ti: tusb1210: Make tusb1210_chg_det_states static
      drm/i915: Fix DISP_POS_Y and DISP_HEIGHT defines
      platform/x86: asus-wmi: Fix driver not binding when fan curve
control probe fails

Hao Chen (1):
      net: hns3: align the debugfs output to the left

Haowen Bai (2):
      video: fbdev: sis: fix potential NULL dereference in sisfb_post_sis30=
0()
      video: fbdev: pm2fb: Fix a kernel-doc formatting issue

Heikki Krogerus (3):
      usb: typec: ucsi: Fix reuse of completion structure
      usb: typec: ucsi: Fix role swapping
      usb: dwc3: pci: add support for the Intel Meteor Lake-P

Heiner Kallweit (1):
      phy: amlogic: fix error path in phy_g12a_usb3_pcie_probe()

Henry Lin (1):
      xhci: stop polling roothubs after shutdown

Herton R. Krzesinski (1):
      tools/power/x86/intel-speed-select: fix build failure when using
-Wl,--as-needed

Hui Wang (1):
      Revert "serial: sc16is7xx: Clear RS485 bits in the shutdown"

Ilya Dryomov (1):
      libceph: disambiguate cluster/pool full log message

Imre Deak (1):
      drm/i915: Fix SEL_FETCH_PLANE_*(PIPE_B+) register addresses

Ivan Vecera (2):
      ice: Fix incorrect locking in ice_vc_process_vf_msg()
      ice: Protect vf_state check by cfg_lock in ice_vc_process_vf_msg()

Jacob Keller (1):
      ice: fix use-after-free when deinitializing mailbox snapshot

Jaegeuk Kim (4):
      f2fs: remove obsolete whint_mode
      f2fs: keep io_flags to avoid IO split due to different op_flags
in two fio holders
      f2fs: fix wrong condition check when failing metapage read
      f2fs: should not truncate blocks during roll-forward recovery

Jakob Koschel (1):
      video: fbdev: mmp: replace usage of found with dedicated list
iterator variable

Jakub Kicinski (1):
      Add Eric Dumazet to networking maintainers

Jan Kara (1):
      bfq: Fix warning in bfqq_request_over_limit()

Janusz Krzysztofik (1):
      video: fbdev: omap: Make it CCF clk API compatible

Jason A. Donenfeld (2):
      wireguard: selftests: enable ACPI for SMP
      random: document crng_fast_key_erasure() destination possibility

Jens Axboe (2):
      io_uring: check reserved fields for send/sendmsg
      io_uring: check reserved fields for recv/recvmsg

Jian Shen (3):
      net: hns3: clear inited state and stop client after failed to
register netdev
      net: hns3: add validity check for message data length
      net: hns3: add return value for mailbox handling in PF

Jie Wang (1):
      net: hns3: modify the return code of hclge_get_ring_chain_from_mbx

Johan Hovold (2):
      arm64: dts: imx8mm-venice: fix spi2 pin configuration
      serial: imx: fix overrun interrupts in DMA mode

Jonathan Cameron (1):
      iio: adc: ad7280a: Fix wrong variable used when setting thresholds.

Jonathan Lemon (1):
      net: bcmgenet: hide status block before TX timestamping

Jose Cazarin (1):
      iio: dac: dac5571: Fix chip id detection for OF devices

Joseph Ravichandran (1):
      io_uring: fix uninitialized field in rw io_kiocb

Josh Poimboeuf (12):
      MAINTAINERS: Add x86 unwinding entry
      objtool: Enable unreachable warnings for CLANG LTO
      x86/static_call: Add ANNOTATE_NOENDBR to static call trampoline
      x86/retpoline: Add ANNOTATE_NOENDBR for retpolines
      x86/uaccess: Add ENDBR to __put_user_nocheck*()
      x86/xen: Add ANNOTATE_NOENDBR to startup_xen()
      objtool: Print data address for "!ENDBR" data warnings
      objtool: Use offstr() to print address of missing ENDBR
      x86/uaccess: Don't jump between functions
      objtool: Don't set 'jump_dest' for sibling calls
      objtool: Fix sibling call detection in alternatives
      objtool: Fix function fallthrough detection for vmlinux

Jouni H=C3=B6gander (1):
      drm/i915: Check EDID for HDR static metadata when choosing blc

Kees Cook (2):
      USB: serial: whiteheat: fix heap overflow in WHITEHEAT_GET_DTR_RTS
      thermal: int340x: Fix attr.show callback prototype

Krzysztof Kozlowski (7):
      pinctrl: samsung: staticize fsd_pin_ctrl
      phy: samsung: exynos5250-sata: fix missing device put in probe error =
paths
      ARM: dts: at91: align SPI NOR node name with dtschema
      ARM: dts: at91: use generic node name for dataflash
      pinctrl: samsung: fix missing GPIOLIB on ARM64 Exynos config
      MAINTAINERS: add Bug entry for Samsung and memory controller drivers
      dt-bindings: usb: samsung,exynos-usb2: add missing required reg

Leon Romanovsky (1):
      ixgbe: ensure IPsec VF<->PF compatibility

Lin Ma (1):
      mctp: defer the kfree of object mdev->addrs

Lino Sanfilippo (1):
      serial: amba-pl011: do not time out prematurely when draining tx fifo

Linus Torvalds (2):
      no-MMU: expose vmalloc_huge() for alloc_large_system_hash()
      Linux 5.18-rc5

Liu Ying (1):
      arm64: dts: imx8qm: Correct SCU clock controller's compatible propert=
y

Luca Ceresoli (2):
      pinctrl: rockchip: fix RK3308 pinmux bits
      pinctrl: rockchip: sort the rk3308_mux_recalced_data entries

Luca Weiss (1):
      pinctrl: qcom: sm6350: fix order of UFS & SDC pins

Luiz Angelo Daros de Luca (2):
      dt-bindings: net: dsa: realtek: cleanup compatible strings
      net: dsa: realtek: remove realtek,rtl8367s string

Luiz Augusto von Dentz (3):
      Bluetooth: hci_event: Fix checking for invalid handle on error status
      Bluetooth: hci_event: Fix creating hci_conn object on error status
      Bluetooth: hci_sync: Cleanup hci_conn if it cannot be aborted

Lv Ruyi (4):
      video: fbdev: imxfb: Fix missing of_node_put in imxfb_probe
      phy: ti: Fix missing of_node_put in ti_pipe3_get_sysctrl()
      net: cosa: fix error check return value of register_chrdev()
      pinctrl: pistachio: fix use of irq_of_parse_and_map()

Maciej Fijalkowski (2):
      xsk: Fix l2fwd for copy mode + busy poll combo
      xsk: Fix possible crash when multiple sockets are created

Maciej W. Rozycki (2):
      serial: 8250: Also set sticky MCR bits in console restoration
      serial: 8250: Correct the clock for EndRun PTP/1588 PCIe device

Macpaul Lin (1):
      usb: mtu3: fix USB 3.0 dual-role-switch from device to host

Manish Chopra (1):
      bnx2x: fix napi API usage sequence

Manivannan Sadhasivam (2):
      bus: mhi: host: pci_generic: Add missing poweroff() PM callback
      bus: mhi: host: pci_generic: Flush recovery worker during freeze

Marc Zyngier (1):
      KVM: arm64: Inject exception on out-of-IPA-range translation fault

Marek Vasut (3):
      arm64: dts: imx8mn: Fix SAI nodes
      pinctrl: stm32: Do not call stm32_gpio_get() for edge triggered
IRQs in EOI
      pinctrl: stm32: Keep pinctrl block clock enabled when LEVEL IRQ reque=
sted

Mark Brown (2):
      ARM: dts: at91: Map MCLK for wm8731 on at91sam9g20ek
      ARM: dts: at91: Describe regulators on at91sam9g20ek

Martin Blumenstingl (1):
      net: dsa: lantiq_gswip: Don't set GSWIP_MII_CFG_RMII_CLK

Martin Willi (1):
      netfilter: Update ip6_route_me_harder to consider L3 domain

Mathias Nyman (1):
      xhci: increase usb U3 -> U0 link resume timeout from 100ms to 500ms

Max Krummenacher (1):
      ARM: dts: imx6ull-colibri: fix vqmmc regulator

Maxim Mikityanskiy (1):
      tls: Skip tls_append_frag on zero copy size

Md Sadre Alam (1):
      mtd: rawnand: qcom: fix memory corruption that causes panic

Miaoqian Lin (8):
      phy: samsung: Fix missing of_node_put() in exynos_sata_phy_probe
      ARM: OMAP2+: Fix refcount leak in omap_gic_of_init
      phy: ti: omap-usb2: Fix error handling in omap_usb2_enable_clocks
      phy: mapphone-mdm6600: Fix PM error handling in phy_mdm6600_probe
      phy: ti: Add missing pm_runtime_disable() in serdes_am654_probe
      mtd: rawnand: Fix return value check of wait_for_completion_timeout
      net: dsa: Add missing of_node_put() in dsa_port_link_register_of
      drm/amd/display: Fix memory leak in dcn21_clock_source_create

Michael Hennerich (1):
      iio: dac: ad5446: Fix read_raw not returning set value

Mikulas Patocka (2):
      hex2bin: make the function hex_to_bin constant-time
      hex2bin: fix access beyond string end

Minchan Kim (1):
      kernfs: fix NULL dereferencing in kernfs_remove

Mingwei Zhang (1):
      KVM: x86/mmu: fix potential races when walking host page table

Miquel Raynal (1):
      ARM: dts: am33xx-l4: Add missing touchscreen clock properties

Namhyung Kim (3):
      perf symbol: Pass is_kallsyms to symbols__fixup_end()
      perf symbol: Update symbols__fixup_end()
      perf symbol: Remove arch__symbols__fixup_end()

Naohiro Aota (1):
      btrfs: zoned: use dedicated lock for data relocation

Nathan Rossi (1):
      net: dsa: mv88e6xxx: Fix port_hidden_wait to account for port_base_ad=
dr

Niels Dossche (1):
      ceph: get snap_rwsem read lock in handle_cap_export for ceph_add_cap

Nikolay Aleksandrov (2):
      wireguard: device: check for metadata_dst with skb_valid_dst()
      virtio_net: fix wrong buf address calculation when using xdp

Nuno S=C3=A1 (1):
      iio: dac: ltc2688: fix voltage scale read

Nur Hussein (1):
      x86/Kconfig: fix the spelling of 'becoming' in X86_KERNEL_IBT config

Oleksandr Ocheretnyi (1):
      mtd: fix 'part' field data corruption in mtd_info

Oliver Neukum (2):
      USB: quirks: add a Realtek card reader
      USB: quirks: add STRING quirk for VCOM device

Ondrej Zary (1):
      video: fbdev: i740fb: use memset_io() to clear screen

Pablo Neira Ayuso (1):
      netfilter: nft_set_rbtree: overlap detection with element
re-addition after deletion

Paolo Bonzini (2):
      KVM: fix bad user ABI for KVM_EXIT_SYSTEM_EVENT
      KVM: x86: work around QEMU issue with synthetic CPUID leaves

Pavel Skripkin (1):
      video: fbdev: udlfb: properly check endpoint type

Pawel Laszczak (1):
      usb: cdns3: Fix issue for clear halt endpoint

Peilin Ye (3):
      ip_gre: Make o_seqno start from 0 in native mode
      ip6_gre: Make o_seqno start from 0 in native mode
      ip_gre, ip6_gre: Fix race condition on o_seqno in collect_md mode

Peng Li (1):
      net: hns3: fix error log of tx/rx tqps stats

Peng Wu (1):
      net: hns: Add missing fwnode_handle_put in hns_mac_init

Pengcheng Yang (3):
      ipvs: correctly print the memory size of ip_vs_conn_tab
      tcp: ensure to use the most recently sent skb when filling the rate s=
ample
      tcp: fix F-RTO may not work correctly when receiving DSACK

Peter Geis (1):
      usb: dwc3: fix backwards compat with rockchip devices

Peter Zijlstra (6):
      lib/strn*,objtool: Enforce user_access_begin() rules
      x86,xen,objtool: Add UNWIND hint
      x86,objtool: Mark cpu_startup_entry() __noreturn
      x86,objtool: Explicitly mark idtentry_body()s tail REACHABLE
      objtool: Fix type of reloc::addend
      objtool: Fix code relocs vs weak symbols

Petr Oros (1):
      ice: wait 5 s for EMP reset after firmware flash

Prike Liang (1):
      drm/amdgpu: keep mmhub clock gating being enabled during s2idle suspe=
nd

Ren Zhijie (1):
      usb: typec: rt1719: Fix build error without CONFIG_POWER_SUPPLY

Rob Herring (3):
      ARM: dts: imx: Fix boolean properties with values
      arm64: dts: imx: Fix imx8*-var-som touchscreen property sizes
      ARM: dts: at91: Fix boolean properties with values

Rongguang Wei (1):
      netfilter: flowtable: Remove the empty file

Samuel Holland (2):
      clk: sunxi-ng: sun6i-rtc: Mark rtc-32k as critical
      drm/sun4i: Remove obsolete references to PHYS_OFFSET

Sean Anderson (1):
      usb: phy: generic: Get the vbus supply

Sean Christopherson (2):
      KVM: x86/mmu: Do not create SPTEs for GFNs that exceed host.MAXPHYADD=
R
      Revert "x86/mm: Introduce lookup_address_in_mm()"

Sebastian Andrzej Siewior (1):
      net: Use this_cpu_inc() to increment net->core_stats

Sergiu Moga (1):
      ARM: dts: at91: sama7g5: Swap `rx` and `tx` for `i2c` nodes

Shida Zhang (1):
      bug: Have __warn() prototype defined unconditionally

Shin'ichiro Kawasaki (1):
      bus: fsl-mc-msi: Fix MSI descriptor mutex lock for msi_first_desc()

Slark Xiao (1):
      USB: serial: option: add support for Cinterion MV32-WA/MV32-WB

Srinivas Pandruvada (1):
      platform/x86: intel-uncore-freq: Prevent driver loading in guests

Stephen Boyd (4):
      iio:proximity:sx_common: Fix device property parsing on DT systems
      iio:proximity:sx9324: Fix hardware gain read/write
      interconnect: qcom: sc7180: Drop IP0 interconnects
      interconnect: qcom: sdx55: Drop IP0 interconnects

Sven Peter (1):
      usb: dwc3: Try usb-role-switch first in dwc3_drd_init

Tasos Sahanidis (1):
      usb: core: Don't hold the device lock while sleeping in do_proc_contr=
ol()

Tejun Heo (2):
      iocost: don't reset the inuse weight of under-weighted debtors
      Revert "block: inherit request start time from bio for BLK_CGROUP"

Thinh Nguyen (3):
      usb: dwc3: core: Fix tx/rx threshold settings
      usb: dwc3: core: Only handle soft-reset in DCTL
      usb: dwc3: gadget: Return proper request status

Thomas Gleixner (1):
      x86/pci/xen: Disable PCI/MSI[-X] masking for XEN_HVM guests

Tiezhu Yang (1):
      MAINTAINERS: update IOMAP FILESYSTEM LIBRARY and XFS FILESYSTEM

Tim Harvey (1):
      ARM: dts: imx8mm-venice-gw{71xx,72xx,73xx}: fix OTG controller OC mod=
e

Timothy Hayes (3):
      perf arm-spe: Fix addresses of synthesized SPE events
      perf arm-spe: Fix SPE events with phys addresses
      perf test: Add perf_event_attr test for Arm SPE

Toke H=C3=B8iland-J=C3=B8rgensen (1):
      bpf: Fix release of page_pool in BPF_PROG_RUN in test runner

Tom Rix (2):
      iio: scd4x: check return of scd4x_write_and_fetch
      platform/x86/intel: pmc/core: change pmc_lpm_modes to static

Tong Zhang (1):
      iio:imu:bmi160: disable regulator in error path

Tony Lindgren (3):
      bus: ti-sysc: Make omap3 gpt12 quirk handling SoC specific
      ARM: dts: dra7: Fix suspend warning for vpe powerdomain
      serial: 8250: Fix runtime PM for start_tx() for empty buffer

Tony Luck (2):
      x86/cpu: Add new Alderlake and Raptorlake CPU model numbers
      topology/sysfs: Hide PPIN on systems that do not support it.

Tudor Ambarus (1):
      ARM: dts: at91: sama7g5ek: Align the impedance of the QSPI0's
HSIO and PCB lines

Vijayavardhan Vennapusa (1):
      usb: gadget: configfs: clear deactivation flag in
configfs_composite_unbind()

Ville Syrj=C3=A4l=C3=A4 (3):
      ACPI: processor: idle: Avoid falling back to C3 type C-states
      Revert "ACPI: processor: idle: fix lockup regression on 32-bit
ThinkPad T40"
      drm/i915/fbc: Consult hw.crtc instead of uapi.crtc

Vladimir Oltean (4):
      net: dsa: flood multicast to CPU when slave has IFF_PROMISC
      net: mscc: ocelot: ignore VID 0 added by 8021q module
      net: mscc: ocelot: don't add VID 0 to ocelot->vlans when leaving
VLAN-aware bridge
      net: enetc: allow tc-etf offload even with NETIF_F_CSUM_MASK

Vladimir Zapolskiy (2):
      cpufreq: qcom-cpufreq-hw: Fix throttle frequency value on EPSS platfo=
rms
      cpufreq: qcom-cpufreq-hw: Clear dcvs interrupts

Volodymyr Mytnyk (1):
      netfilter: conntrack: fix udp offload timeout sysctl

Wan Jiabing (2):
      bus: imx-weim: fix NULL but dereferenced coccicheck error
      clk: sunxi-ng: fix not NULL terminated coccicheck error

Wang Qing (2):
      video: fbdev: pxafb: use if else instead
      arch_topology: Do not set llc_sibling if llc_id is invalid

Wang ShaoBo (1):
      iio:filter:admv8818: select REGMAP_SPI for ADMV8818

Wei Yongjun (1):
      bus: imx-weim: make symbol 'weim_of_notifier' static

Weitao Wang (1):
      USB: Fix xhci event ring dequeue pointer ERDP update issue

Weitao Wango (1):
      USB: Fix ehci infinite suspend-resume loop issue in zhaoxin

Wells Lu (1):
      pinctrl: Fix an error in pin-function table of SP7021

Wen Gu (2):
      net/smc: Only save the original clcsock callback functions
      net/smc: Fix slab-out-of-bounds issue in fallback

Will Deacon (1):
      KVM: arm64: Handle host stage-2 faults from 32-bit EL0

Willy Tarreau (1):
      floppy: disable FDRAWCMD by default

Xianwei Zhao (1):
      arm64: dts: remove cpu compatible "arm,armv8" for s4

Xiaobing Luo (1):
      cpufreq: fix memory leak in sun50i_cpufreq_nvmem_probe

Xin Long (1):
      sctp: check asoc strreset_chunk in sctp_generate_reconf_event

Xiubo Li (2):
      ceph: remove incorrect session state check
      ceph: fix possible NULL pointer dereference for req->r_session

Yang Yingliang (2):
      clk: sunxi: sun9i-mmc: check return value after calling
platform_get_resource()
      net: fec: add missing of_node_put() in fec_enet_init_stop_mode()

YueHaibing (1):
      pinctrl: mediatek: moore: Fix build error

Zheyu Ma (8):
      iio: magnetometer: ak8975: Fix the error handling in ak8975_power_on(=
)
      video: fbdev: neofb: Fix the check of 'var->pixclock'
      video: fbdev: kyro: Error out if 'lineclock' equals zero
      video: fbdev: vt8623fb: Error out if 'pixclock' equals zero
      video: fbdev: tridentfb: Error out if 'pixclock' equals zero
      video: fbdev: arkfb: Error out if 'pixclock' equals zero
      video: fbdev: s3fb: Error out if 'pixclock' equals zero
      video: fbdev: i740fb: Error out if 'pixclock' equals zero

Zizhuang Deng (1):
      iio: dac: ad5592r: Fix the missing return value.

Zqiang (1):
      kasan: prevent cpu_quarantine corruption when CPU offline and
cache shrink occur at same time

liuyacan (1):
      net/smc: sync err code when tcp connection was refused

zhangqilong (1):
      usb: xhci: tegra:Fix PM usage reference leak of
tegra_xusb_unpowergate_partitions
