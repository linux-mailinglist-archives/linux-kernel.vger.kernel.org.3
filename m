Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1F75AC654
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 22:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234299AbiIDUXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 16:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiIDUXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 16:23:22 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E111DA7C
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 13:23:19 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 29so3928915edv.2
        for <linux-kernel@vger.kernel.org>; Sun, 04 Sep 2022 13:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date;
        bh=5KiWrEv3MAsO1uogsQUVQxnJpppPwY77w8Kmlw2kc6s=;
        b=A6BATuLLNHY2qAiGCsNxTZaQN7du/MRxSE7egOfkvU13gDPHLTeIksWFBhIkzeEVlp
         NETtvR5670Y+YUjPA/xAMIBrDW63DgE7BXrnkarukEAbRK5QA7wludO0keAPu0IQmiMW
         xM96aeh/rz9ngw/RK7dyIVxdwaApYKLtXfXNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=5KiWrEv3MAsO1uogsQUVQxnJpppPwY77w8Kmlw2kc6s=;
        b=5t6NpYLWGqW1klyduOel8oi5E6LZW8ctJN2mPsgd2CMeFoNQeS+sUuQdB7kq6uYGI4
         BKN4ilrSn94hIY8D/dcssQVOi5ghpyn2CZBXHry81JHl4YJHTDtOjPPblrM6KmmBRchR
         9YwZSwdCuvT5mt3Jr+bACiqi1t5Q/pEmIoZIA1QP1l9vZCIm0e7jDLJ+/bfbKsgeRTXO
         aWvuHF5pBex8ToOD+rypA4Vi8ld7WVHoAXIDHEJnfHB6uqi/ds+RwItOTW8uaMoecHVI
         SkEHyvtguuvjTcHJMPrmdrvCYojnf2my2PPbIaOVvhJorr4IyWLQTz9tsoaApvlONZ6T
         YZtQ==
X-Gm-Message-State: ACgBeo2bsCF2iRN/aiDkQMtXLic6J0sPuuuOcuJ2h5Q5ykQS9NtIinEv
        XKB+CvsVTxLQKxeIcYiRazrEHa2T3MthEFBP
X-Google-Smtp-Source: AA6agR7TSITaelpxtjcqFuQQRtVrqOX1J33rbwBQNBg3q+1azxEk7POICha9+FJZmyDmowhr+XxCNw==
X-Received: by 2002:a05:6402:1f89:b0:44e:798b:75c6 with SMTP id c9-20020a0564021f8900b0044e798b75c6mr2425838edc.407.1662322997692;
        Sun, 04 Sep 2022 13:23:17 -0700 (PDT)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id e23-20020a50a697000000b004481ee9b4besm5206930edc.63.2022.09.04.13.23.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Sep 2022 13:23:17 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id f15so4134576wrw.3
        for <linux-kernel@vger.kernel.org>; Sun, 04 Sep 2022 13:23:16 -0700 (PDT)
X-Received: by 2002:a5d:6045:0:b0:226:d21d:947b with SMTP id
 j5-20020a5d6045000000b00226d21d947bmr22023019wrt.274.1662322996257; Sun, 04
 Sep 2022 13:23:16 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 4 Sep 2022 13:22:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiqix9N5P0BXrSSOXjPZxMh=wDDRJ3sgf=hutoTUx0nZQ@mail.gmail.com>
Message-ID: <CAHk-=wiqix9N5P0BXrSSOXjPZxMh=wDDRJ3sgf=hutoTUx0nZQ@mail.gmail.com>
Subject: Linux 6.0-rc4
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

It's Sunday afternoon, which can only mean one thing - another rc
release. We're up to rc4, and things mostly still look fairly normal.

Most of the fixes the past week have been drivers (gpu, networking,
gpio, tty, usb, sound.. a little bit of everything in other words).
But we have the usual mix of fixes elsewhere too - architecture fixes
(arm64, loongarch, powerpc, RISC-V, s390 and x86), and various other
areas - core networking, filesystems, io_uring, LSM, selftests and
documentation. Some of this is reverts of things that just turned out
to be wrong or just not quite ready.

Please do go test,
            Linus

---

Abhinav Kumar (1):
      drm/msm/dpu: populate wb or intf before reset_intf_cfg

Aditya Garg (1):
      HID: Add Apple Touchbar on T2 Macs in hid_have_special_driver list

Adrian Hunter (2):
      mmc: core: Fix UHS-I SD 1.8V workaround branch
      mmc: core: Fix inconsistent sd3_bus_mode at UHS-I SD voltage
switch failure

Akihiko Odaki (1):
      HID: AMD_SFH: Add a DMI quirk entry for Chromebooks

Akira Yokosawa (2):
      docs: kerneldoc-preamble: Test xeCJK.sty before loading
      docs/ja_JP/SubmittingPatches: Remove reference to submitting-drivers.=
rst

Alan Stern (3):
      USB: gadget: Fix obscure lockdep violation for udc_mutex
      USB: core: Prevent nested device-reset calls
      media: mceusb: Use new usb_control_msg_*() routines

Alex Sierra (1):
      drm/amdgpu: ensure no PCIe peer access for CPU XGMI iolinks

Alex Williamson (1):
      drm/i915/gvt: Fix Comet Lake

Alvaro Karsz (1):
      net: virtio_net: fix notification coalescing comments

Andrey Zhadchenko (1):
      openvswitch: fix memory leak at failed datapath creation

Andy Shevchenko (2):
      platform/x86: pmc_atom: Fix SLP_TYPx bitfield mask
      platform/x86: p2sb: Fix UAF when caller uses resource name

Archie Pusaka (1):
      Bluetooth: hci_event: Fix checking conn for le_conn_complete_evt

Ard Biesheuvel (3):
      arm64: head: Ignore bogus KASLR displacement on non-relocatable kerne=
ls
      arm64: mm: Reserve enough pages for the initial ID map
      LoongArch: Avoid orphan input sections

Armin Wolf (1):
      hwmon: (gpio-fan) Fix array out of bounds access

Arnd Bergmann (1):
      musb: fix USB_MUSB_TUSB6010 dependency

Arun R Murthy (2):
      drm/i915/display: avoid warnings when registering dual panel backligh=
t
      drm/i915/display: avoid warnings when registering dual panel backligh=
t

Aurabindo Pillai (4):
      drm/amd/display: Fix CAB cursor size allocation for DCN32/321
      drm/amd/display: disable display fresh from MALL on an edge case
for DCN321
      drm/amd/display: use actual cursor size instead of max for CAB alloca=
tion
      drm/amd/display: Use correct plane for CAB cursor size allocation

Axel Rasmussen (1):
      selftests: net: sort .gitignore file

Badhri Jagan Sridharan (1):
      usb: typec: tcpm: Return ENOTSUPP for power supply prop writes

Bart Van Assche (1):
      tracing: Define the is_signed_type() macro once

Bartosz Golaszewski (1):
      gpio: pxa: use devres for the clock struct

Benjamin Tissoires (1):
      HID: input: fix uclogic tablets

Bjorn Andersson (1):
      drm/msm/gpu: Drop qos request if devm_devfreq_add_device() fails

Carlos Llamas (2):
      binder: fix UAF of ref->proc caused by race condition
      binder: fix alloc->vma_vm_mm null-ptr dereference

Casey Schaufler (1):
      Smack: Provide read control for io_uring_cmd

Casper Andersson (1):
      net: sparx5: fix handling uneven length packets in manual extraction

Charlene Liu (1):
      drm/amd/display: fix wrong register access

Chen-Yu Tsai (2):
      clk: core: Honor CLK_OPS_PARENT_ENABLE for clk gate ops
      clk: core: Fix runtime PM sequence in clk_core_unprepare()

Chengming Gui (1):
      drm/amd/amdgpu: skip ucode loading if ucode_size =3D=3D 0

Christian K=C3=B6nig (1):
      dma-buf/dma-resv: check if the new fence is really later

Christophe JAILLET (2):
      iio: light: cm3605: Fix an error handling path in cm3605_probe()
      hwmon: (pmbus) Use dev_err_probe() to filter -EPROBE_DEFER error mess=
ages

Christophe Leroy (1):
      powerpc: Fix hard_irq_disable() with sanitizer

Chunfeng Yun (3):
      usb: xhci-mtk: relax TT periodic bandwidth allocation
      usb: xhci-mtk: fix bandwidth release issue
      dt-bindings: usb: mtu3: add compatible for mt8188

Colin Ian King (1):
      drm/i915/reg: Fix spelling mistake "Unsupport" -> "Unsupported"

Cong Wang (1):
      kcm: fix strp_init() order and cleanup

Conor Dooley (2):
      riscv: kvm: vcpu_timer: fix unused variable warnings
      riscv: kvm: move extern sbi_ext declarations to a header

Dan Carpenter (6):
      wifi: cfg80211: debugfs: fix return type in ht40allow_map_read()
      wifi: mac80211: potential NULL dereference in ieee80211_tx_control_po=
rt()
      ALSA: control: Re-order bounds checking in get_ctl_id_hash()
      staging: rtl8712: fix use after free bugs
      net: lan966x: improve error handle in lan966x_fdma_rx_get_frame()
      xen/grants: prevent integer overflow in gnttab_dma_alloc_pages()

Daniel Borkmann (2):
      bpf: Partially revert flexible-array member replacement
      bpf: Don't use tnum_range on array range checking for poke descriptor=
s

Daniel J. Ogorchock (1):
      HID: nintendo: fix rumble worker null pointer deref

Daniel M=C3=BCller (1):
      selftests/bpf: Add lru_bug to s390x deny list

Daniele Ceraolo Spurio (2):
      drm/i915/guc: clear stalled request after a reset
      drm/i915/guc: clear stalled request after a reset

David Howells (2):
      smb3: Move the flush out of smb2_copychunk_range() into its callers
      smb3: fix temporary data corruption in insert range

David Matlack (2):
      KVM: selftests: Fix KVM_EXCEPTION_MAGIC build with Clang
      KVM: selftests: Fix ambiguous mov in KVM_ASM_SAFE()

David Thompson (1):
      mlxbf_gige: compute MDIO period based on i1clk

Diego Santa Cruz (1):
      drm/i915/glk: ECS Liva Q2 needs GLK HDMI port timing quirk

Douglas Anderson (2):
      drm/msm/dsi: Fix number of regulators for msm8996_dsi_cfg
      drm/msm/dsi: Fix number of regulators for SDM660

Duncan Ma (1):
      drm/amd/display: Fix OTG H timing reset for dcn314

Duoming Zhou (1):
      ethernet: rocker: fix sleep in atomic context bug in neigh_timer_hand=
ler

Enzo Matsumiya (1):
      cifs: fix small mempool leak in SMB2_negotiate()

Eric Biggers (1):
      crypto: lib - remove unneeded selection of XOR_BLOCKS

Eric Dumazet (2):
      tcp: annotate data-race around challenge_timestamp
      tcp: make global challenge ack rate limitation per net-ns and
default disabled

Ethan Wellenreiter (2):
      drm/amd/display: Re-initialize viewport after pipe merge
      drm/amd/display: Fix check for stream and plane

Evan Quan (3):
      drm/amd/pm: use vbios carried pptable for those supported SKUs
      drm/amd/pm: use vbios carried pptable for all SMU13.0.7 SKUs
      drm/amd/pm: bump SMU 13.0.0 driver_if header version

Even Xu (2):
      hid: intel-ish-hid: ishtp: Fix ishtp client sending disordered messag=
e
      HID: intel-ish-hid: ipc: Add Meteor Lake PCI device ID

Eyal Birger (1):
      ip_tunnel: Respect tunnel key's "flow_flags" in IP tunnels

Fedor Pchelkin (2):
      tty: n_gsm: replace kicktimer with delayed_work
      tty: n_gsm: avoid call of sleeping functions from atomic context

Florian Fainelli (2):
      net: smsc911x: Stop and start PHY during suspend and resume
      arch_topology: Silence early cacheinfo errors when non-existent

Gao Xiao (1):
      nfp: fix the access to management firmware hanging

George Shen (1):
      drm/amd/display: Fix DCN32 DPSTREAMCLK_CNTL programming

Gerald Schaefer (2):
      s390/mm: remove useless hugepage address alignment
      s390/hugetlb: fix prepare_hugepage_range() check for 2 GB hugepages

Graham Sider (1):
      drm/amdgpu: Update mes_v11_api_def.h

Greg Kroah-Hartman (3):
      Revert "binder_alloc: Add missing mmap_lock calls when using the VMA"
      Revert "usb: add quirks for Lenovo OneLink+ Dock"
      Revert "usb: gadget: udc-xilinx: replace memcpy with memcpy_toio"

Greg Tulli (1):
      Input: iforce - add support for Boeder Force Feedback Wheel

Grzegorz Szymaszek (1):
      staging: r8188eu: add firmware dependency

Guchun Chen (1):
      drm/amdgpu: disable FRU access on special SIENNA CICHLID card

Haibo Chen (1):
      gpio: pca953x: Add mutex_lock for regcache sync in PM

Hannes Reinecke (1):
      nvmet-auth: add missing goto in nvmet_setup_auth()

Hans de Goede (3):
      platform/x86: x86-android-tablets: Fix broken touchscreen on
Chuwi Hi8 with Windows BIOS
      Bluetooth: hci_event: Fix vendor (unknown) opcode status handling
      platform/x86: acer-wmi: Acer Aspire One AOD270/Packard Bell Dot
keymap fixes

Hawking Zhang (1):
      drm/amdgpu: only init tap_delay ucode when it's included in ucode bin=
ary

Heikki Krogerus (2):
      usb: dwc3: pci: Add support for Intel Raptor Lake
      usb: typec: Remove retimers properly

Heiko Carstens (1):
      s390: update defconfigs

Heiner Kallweit (1):
      usb: dwc2: fix wrong order of phy_power_on and phy_init

Helge Deller (1):
      vt: Clear selection before changing the font

Horatiu Vultur (1):
      net: phy: micrel: Make the GPIO to be non-exclusive

Hu Xiaoying (1):
      usb: storage: Add ASUS <0x0b05:0x1932> to IGNORE_UAS

Huacai Chen (3):
      LoongArch: Adjust arch_do_signal_or_restart() to adapt generic entry
      LoongArch: Improve dump_tlb() output messages
      LoongArch: Fix section mismatch due to acpi_os_ioremap()

Isaac J. Manjarres (1):
      driver core: Don't probe devices after bus_type.match() probe deferra=
l

Iwona Winiarska (1):
      peci: cpu: Fix use-after-free in adev_release()

Jakub Kicinski (1):
      Revert "sch_cake: Return __NET_XMIT_STOLEN when consuming enqueued sk=
b"

Jani Nikula (4):
      drm/i915/dsi: filter invalid backlight and CABC ports
      drm/i915/dsi: fix dual-link DSI backlight and CABC ports for display =
11+
      drm/i915/dsi: filter invalid backlight and CABC ports
      drm/i915/dsi: fix dual-link DSI backlight and CABC ports for display =
11+

Jann Horn (1):
      mm/rmap: Fix anon_vma->degree ambiguity leading to double-reuse

Jarrah Gosbell (2):
      dt-bindings: input: touchscreen: add compatible string for Goodix GT1=
158
      Input: goodix - add compatible string for GT1158

Jason Wang (1):
      HID: ishtp-hid-clientHID: ishtp-hid-client: Fix comment typo

Jean-Francois Le Fillatre (2):
      r8152: add PID for the Lenovo OneLink+ Dock
      usb: add quirks for Lenovo OneLink+ Dock

Jiapeng Chong (3):
      drm/i915/gvt: Fix kernel-doc
      drm/i915/gvt: Fix kernel-doc
      drm/i915/gvt: Fix kernel-doc

Jilin Yuan (1):
      net/ieee802154: fix repeated words in comments

Jim Mattson (2):
      KVM: VMX: Heed the 'msr' argument in msr_write_intercepted()
      KVM: x86: Mask off unsupported and unknown bits of IA32_ARCH_CAPABILI=
TIES

Jing Leng (1):
      usb: gadget: f_uac2: fix superspeed transfer

Johan Hovold (17):
      usb: dwc3: fix PHY disable sequence
      Revert "usb: dwc3: qcom: Keep power domain on to retain controller st=
atus"
      usb: dwc3: qcom: fix gadget-only builds
      usb: dwc3: qcom: fix use-after-free on runtime-PM wakeup
      usb: dwc3: qcom: fix runtime PM wakeup
      usb: dwc3: qcom: fix peripheral and OTG suspend
      dt-bindings: usb: qcom,dwc3: add wakeup-source property
      usb: dwc3: qcom: fix wakeup implementation
      usb: dwc3: qcom: clean up suspend callbacks
      usb: dwc3: qcom: suppress unused-variable warning
      usb: dwc3: disable USB core PHY management
      USB: serial: cp210x: add Decagon UCA device id
      USB: serial: ch341: fix lost character on LCR updates
      USB: serial: ch341: fix disabled rx timer on older devices
      misc: fastrpc: fix memory corruption on probe
      misc: fastrpc: fix memory corruption on open
      misc: fastrpc: increase maximum session count

Josh Kilmer (1):
      HID: asus: ROG NKey: Ignore portion of 0x5a report

Josh Poimboeuf (1):
      s390: fix nospec table alignments

Jouni H=C3=B6gander (2):
      drm/i915/backlight: Disable pps power hook for aux based backlight
      drm/i915/backlight: Disable pps power hook for aux based backlight

Julia Lawall (1):
      drm/i915/gvt: fix typo in comment

Junaid Shahid (2):
      kvm: x86: mmu: Drop the need_remote_flush() function
      kvm: x86: mmu: Always flush TLBs when enabling dirty logging

Kacper Michaj=C5=82ow (1):
      ALSA: hda/realtek: Add speaker AMP init for Samsung laptops with ALC2=
98

Kai-Heng Feng (1):
      tg3: Disable tg3 device on system reboot to avoid triggering AER

Kairui Song (1):
      Docs/admin-guide/mm/damon/usage: fix the example code snip

Kajol Jain (1):
      powerpc/papr_scm: Fix nvdimm event mappings

Karthik Alapati (1):
      HID: hidraw: fix memory leak in hidraw_release()

Khalid Masum (1):
      fscache: fix misdocumented parameter

Konrad Dybcio (1):
      dt-bindings: usb: qcom,dwc3: Add SM6375 compatible

Krishna Kurapati (1):
      usb: gadget: mass_storage: Fix cdrom data transfers on MAC-OS

Krzysztof Kozlowski (1):
      dt-bindings: iio: gyroscope: bosch,bmg160: correct number of pins

Kumar Kartikeya Dwivedi (2):
      bpf: Do mark_chain_precision for ARG_CONST_ALLOC_SIZE_OR_ZERO
      selftests/bpf: Add regression test for pruning fix

Kuniyuki Iwashima (1):
      bpf: Fix a data-race around bpf_jit_limit.

Kuogee Hsieh (2):
      drm/msm/dp: make eDP panel as the first connected connector
      drm/msm/dp: delete DP_RECOVERED_CLOCK_OUT_EN to fix tps4

Kurt Kanzenbach (1):
      net: dsa: hellcreek: Print warning only once

Larry Finger (1):
      staging: r8188eu: Add Rosewill USB-N150 Nano to device tables

Lee Jones (1):
      HID: steam: Prevent NULL pointer dereference in steam_{recv,send}_rep=
ort

Leo Chen (1):
      drm/amd/display: Missing HPO instance added

Levi Yun (1):
      arm64/kexec: Fix missing extra range for crashkres_low.

Li Qiong (1):
      ieee802154: cc2520: add rc code in cc2520_tx()

Liam Howlett (1):
      binder_alloc: Add missing mmap_lock calls when using the VMA

Like Xu (1):
      perf/x86/core: Completely disable guest PEBS via guest's global_ctrl

Lin Ma (1):
      ieee802154/adf7242: defer destroy_workqueue call

Linus Torvalds (1):
      Linux 6.0-rc4

Liu Jian (1):
      skmsg: Fix wrong last sg check in sk_msg_recvmsg()

Lorenzo Bianconi (1):
      wifi: mac80211: always free sta in __sta_info_alloc in case of error

Luis Chamberlain (1):
      lsm,io_uring: add LSM hooks for the new uring_cmd file op

Luiz Augusto von Dentz (4):
      Bluetooth: hci_sync: Fix suspend performance regression
      Bluetooth: L2CAP: Fix build errors in some archs
      Bluetooth: MGMT: Fix Get Device Flags
      Bluetooth: ISO: Fix not handling shutdown condition

Lukas Bulwahn (3):
      MAINTAINERS: rectify entry for XILINX GPIO DRIVER
      MAINTAINERS: add include/dt-bindings/input to INPUT DRIVERS
      docs: Update version number from 5.x to 6.x in README.rst

Luke D. Jones (1):
      platform/x86: asus-wmi: Increase FAN_CURVE_BUF_LEN to 32

Lv Ruyi (1):
      peci: aspeed: fix error check return value of platform_get_irq()

Magnus Karlsson (1):
      xsk: Fix corrupted packets for XDP_SHARED_UMEM

Marcus Folkesson (3):
      iio: adc: mcp3911: make use of the sign bit
      iio: adc: mcp3911: correct "microchip,device-addr" property
      iio: adc: mcp3911: use correct formula for AD conversion

Mario Limonciello (1):
      platform/x86: thinkpad_acpi: Explicitly set to balanced mode on start=
up

Masahiro Yamada (1):
      powerpc: align syscall table for ppc32

Mathias Nyman (3):
      xhci: Fix null pointer dereference in remove if xHC has only one root=
hub
      xhci: Add grace period after xHC start to prevent premature
runtime suspend.
      Revert "xhci: turn off port power in shutdown"

Matthew Auld (2):
      drm/i915/ttm: fix CCS handling
      drm/i915/ttm: fix CCS handling

Matthias Kaehlcke (1):
      usb: misc: onboard_usb_hub: Drop reset delay in onboard_hub_power_off=
()

Matti Vaittinen (1):
      iio: ad7292: Prevent regulator double disable

Maurizio Lombardi (1):
      nvmet-tcp: fix unhandled tcp states in nvmet_tcp_state_change()

Mauro Carvalho Chehab (1):
      serial: document start_rx member at struct uart_ops

Maximilian Luz (4):
      platform/surface: aggregator_registry: Add support for Surface Laptop=
 Go 2
      platform/surface: aggregator_registry: Rename HID device nodes
based on their function
      platform/surface: aggregator_registry: Rename HID device nodes
based on new findings
      platform/surface: aggregator_registry: Add HID devices for
sensors and UCSI client to SP8

Mazin Al Haddad (1):
      tty: n_gsm: add sanity check for gsm->receive in gsm_receive_buf()

Menglong Dong (1):
      docs/conf.py: add function attribute '__fix_address' to conf.py

Miaohe Lin (1):
      KVM: x86: fix memoryleak in kvm_arch_vcpu_create()

Michael Ellerman (3):
      Revert "powerpc: Remove unused FW_FEATURE_NATIVE references"
      powerpc/rtas: Fix RTAS MSR[HV] handling for Cell
      Revert "powerpc/irq: Don't open code irq_soft_mask helpers"

Michael H=C3=BCbner (1):
      HID: thrustmaster: Add sparco wheel and fix array length

Micka=C3=ABl Sala=C3=BCn (1):
      landlock: Fix file reparenting without explicit LANDLOCK_ACCESS_FS_RE=
FER

Mika Westerberg (2):
      thunderbolt: Use the actual buffer in tb_async_error()
      thunderbolt: Check router generation before connecting xHCI

Ming Lei (1):
      Documentation: document ublk

Miquel Raynal (1):
      net: mac802154: Fix a condition in the receive path

Nathan Chancellor (1):
      powerpc/papr_scm: Ensure rc is always initialized in
papr_scm_pmu_register()

Nick Desaulniers (1):
      Makefile.extrawarn: re-enable -Wformat for clang; take 2

Nicolas Dichtel (1):
      ip: fix triggering of 'icmp redirect'

Niek Nooijens (1):
      USB: serial: ftdi_sio: add Omron CS1W-CIF31 device id

Ondrej Jirman (1):
      Input: goodix - add support for GT1158

Pablo Sun (1):
      usb: typec: altmodes/displayport: correct pin assignment for UFP
receptacles

PaddyKP_Yao (1):
      platform/x86: asus-wmi: Fix the name of the mic-mute LED classdev

Pali Roh=C3=A1r (1):
      powerpc/pci: Enable PCI domains in /proc when PCI bus numbers
are not unique

Paolo Bonzini (1):
      KVM: x86: check validity of argument to KVM_SET_MP_STATE

Paul Moore (2):
      selinux: implement the security_uring_cmd() LSM hook
      /dev/null: add IORING_OP_URING_CMD support

Pavel Begunkov (7):
      io_uring/net: fix overexcessive retries
      selftests/net: temporarily disable io_uring zc test
      Revert "io_uring: add zc notification flush requests"
      Revert "io_uring: rename IORING_OP_FILES_UPDATE"
      io_uring/notif: remove notif registration
      io_uring/net: simplify zerocopy send user API
      selftests/net: return back io_uring zc send tests

Pawel Laszczak (2):
      usb: cdns3: fix incorrect handling TRB_SMM flag for ISOC transfer
      usb: cdns3: fix issue with rearming ISO OUT endpoint

Peter Robinson (1):
      Input: rk805-pwrkey - fix module autoloading

Peter Ujfalusi (1):
      ALSA: hda: intel-nhlt: Correct the handling of fmt_config flexible ar=
ray

Pierre Morel (1):
      KVM: s390: pci: Hook to access KVM lowlevel from VFIO

Piyush Mehta (1):
      usb: gadget: udc-xilinx: replace memcpy with memcpy_toio

Pu Lehui (1):
      bpf, cgroup: Fix kernel BUG in purge_effective_progs

Qiang Yu (1):
      bus: mhi: host: Fix up null pointer access in mhi_irq_handler

Randy Dunlap (1):
      Documentation: networking: correct possessive "its"

Rob Clark (1):
      drm/msm/rd: Fix FIFO-full deadlock

Russ Weight (2):
      firmware_loader: Fix use-after-free during unregister
      firmware_loader: Fix memory leak in firmware upload

Sander Vanheule (1):
      gpio: realtek-otto: switch to 32-bit I/O

Saravana Kannan (4):
      Revert "driver core: Delete driver_deferred_probe_check_state()"
      Revert "net: mdio: Delete usage of driver_deferred_probe_check_state(=
)"
      Revert "PM: domains: Delete usage of driver_deferred_probe_check_stat=
e()"
      Revert "iommu/of: Delete usage of driver_deferred_probe_check_state()=
"

Sebastian Andrzej Siewior (2):
      net: dsa: xrs700x: Use irqsave variant for u64 stats update
      net: Use u64_stats_fetch_begin_irq() for stats fetch.

SeongJae Park (3):
      xen-blkback: Advertise feature-persistent as user requested
      xen-blkfront: Advertise feature-persistent as user requested
      xen-blkfront: Cache feature_persistent value before advertisement

Sergiu Moga (1):
      tty: serial: atmel: Preserve previous USART mode if RS485 disabled

Shenwei Wang (1):
      serial: fsl_lpuart: RS485 RTS polariy is inverse

Sherry Sun (1):
      tty: serial: lpuart: disable flow control while waiting for the
transmit engine to complete

Shyamin Ayesh (1):
      nvme-pci: add NVME_QUIRK_BOGUS_NID for Lexar NM610

Siddh Raman Pant (2):
      wifi: mac80211: Fix UAF in ieee80211_scan_rx()
      wifi: mac80211: Don't finalize CSA in IBSS mode if state is disconnec=
ted

Slark Xiao (1):
      USB: serial: option: add support for Cinterion MV32-WA/WB RmNet mode

Srinivas Kandagatla (2):
      soundwire: qcom: remove duplicate reset control get
      soundwire: qcom: fix device status array range

Steev Klimaszewski (1):
      HID: add Lenovo Yoga C630 battery quirk

Stefan Wahren (4):
      clk: bcm: rpi: Fix error handling of raspberrypi_fw_get_rate
      clk: bcm: rpi: Prevent out-of-bounds access
      clk: bcm: rpi: Add missing newline
      clk: bcm: rpi: Show clock id limit in error case

Stephen Boyd (1):
      Revert "clk: core: Honor CLK_OPS_PARENT_ENABLE for clk gate ops"

Steve French (2):
      smb3: fix temporary data corruption in collapse range
      smb3: use filemap_write_and_wait_range instead of filemap_write_and_w=
ait

Steven Price (1):
      mm: pagewalk: Fix race between unmap and page walker

Sun Ke (1):
      cachefiles: fix error return code in cachefiles_ondemand_copen()

Takashi Iwai (5):
      ALSA: memalloc: Revive x86-specific WC page allocations again
      Revert "usb: typec: ucsi: add a common function
ucsi_unregister_connectors()"
      ALSA: seq: oss: Fix data-race for max_midi_devs access
      ALSA: seq: Fix data-race at module auto-loading
      ALSA: usb-audio: Add quirk for LH Labs Geek Out HD Audio 1V5

Tetsuo Handa (3):
      Bluetooth: hci_sync: fix double mgmt_pending_free() in
remove_adv_monitor()
      Input: iforce - wake up after clearing IFORCE_XMIT_RUNNING flag
      tty: n_gsm: initialize more members at gsm_alloc_mux()

Thierry GUIBERT (1):
      USB: cdc-acm: Add Icom PMR F3400 support (0c26:0020)

Tianyu Yuan (1):
      nfp: flower: fix ingress police using matchall filter

Toke H=C3=B8iland-J=C3=B8rgensen (1):
      sch_cake: Return __NET_XMIT_STOLEN when consuming enqueued skb

Tony Lindgren (1):
      clk: ti: Fix missing of_node_get() ti_find_clock_provider()

Utkarsh Patel (1):
      usb: typec: intel_pmc_mux: Add new ACPI ID for Meteor Lake IOM device

Vadim Pasternak (4):
      platform/mellanox: mlxreg-lc: Fix coverity warning
      platform/mellanox: mlxreg-lc: Fix locking issue
      platform/mellanox: Remove unnecessary code
      platform/mellanox: Remove redundant 'NULL' check

Ville Syrj=C3=A4l=C3=A4 (1):
      drm/i915: Skip wm/ddb readout for disabled pipes

Vincent Whitchurch (2):
      hwmon: (pmbus) Fix vout margin caching
      tty: Fix lookahead_buf crash with serdev

Vladimir Stempen (1):
      drm/amd/display: Fix black flash when switching from ODM2to1 to ODMBy=
pass

Waiman Long (1):
      mm/slab_common: Deleting kobject in kmem_cache_destroy() without
holding slab_mutex/cpu_hotplug_lock

Wang Fudong (1):
      drm/amd/display: set dig fifo read start level to 7 before dig fifo r=
eset

Wang Hai (1):
      net/sched: fix netdevice reference leaks in attach_default_qdiscs()

Wei Yongjun (1):
      gpio: mockup: remove gpio debugfs when remove device

Wesley Cheng (1):
      usb: dwc3: gadget: Avoid duplicate requests to enable Run/Stop

William Breathitt Gray (4):
      gpio: 104-dio-48e: Make irq_chip immutable
      gpio: 104-idi-48: Make irq_chip immutable
      gpio: 104-idio-16: Make irq_chip immutable
      gpio: ws16c48: Make irq_chip immutable

Witold Lipieta (1):
      usb-storage: Add ignore-residue quirk for NXP PN7462AU

Wolfram Sang (1):
      Bluetooth: move from strlcpy with unused retval to strscpy

Xin Yin (1):
      cachefiles: make on-demand request distribution fairer

Yacan Liu (1):
      net/smc: Remove redundant refcount increase

Yan Xinyu (1):
      USB: serial: option: add support for OPPO R11 diag port

Yang Yingliang (1):
      wifi: mac80211: fix possible leak in ieee80211_tx_control_port()

YiFei Zhu (1):
      bpf: Restrict bpf_sys_bpf to CAP_PERFMON

Yonglin Tan (1):
      USB: serial: option: add Quectel EM060K modem

Yu Zhe (1):
      perf/arm_pmu_platform: fix tests for platform_get_irq() failure

YuBiao Wang (1):
      drm/amdgpu: Fix use-after-free in amdgpu_cs_ioctl

Yupeng Li (1):
      LoongArch: Fix arch_remove_memory() undefined build error

Zhengchao Shao (1):
      net: sched: tbf: don't call qdisc_put() while holding tree lock

Zhengping Jiang (1):
      Bluetooth: hci_sync: hold hdev->lock when cleanup hci_conn

Zheyu Ma (1):
      ALSA: control: Fix an out-of-bounds bug in get_ctl_id_hash()

sunliming (2):
      drm/msm/dsi: fix the inconsistent indenting
      iio: light: cm32181: make cm32181_pm_ops static

ye xingchen (1):
      LoongArch: mm: Remove the unneeded result variable

=C5=81ukasz Bartosik (1):
      drm/i915: fix null pointer dereference
