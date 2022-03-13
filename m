Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF824D7837
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 21:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235582AbiCMUpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 16:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235575AbiCMUp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 16:45:29 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C3617E06
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 13:44:19 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id u3so19311526ljd.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 13:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Tj1WSAIrqg03/QLRab/sDl0bppKpD4z5taC+9WZif2o=;
        b=WJtMej7wGs4k4WeZ8uO3CSJBlKAM7B1wAUYsvb3Zdt+89l27Oq8988i3ubYCkjMpSr
         niO6ev+evD5IXaB9lJKrocUH5FxeNyEsuG+IHJDnubNWiVcfePXiCVDrkg1KBHc6VW/d
         /LLdcigfV+RQaG2TDwKvVRtpvGmqkMGtQ3YTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Tj1WSAIrqg03/QLRab/sDl0bppKpD4z5taC+9WZif2o=;
        b=eazTTTs5oRthUJ2g6sbgdf/yM8kKViiAgpR8kLfBxRr/nfEMuj/dzFCdh12siRH1IA
         ogDs7jZIFEPQM+S5RaayqQWUFw12BZlf/kCpZfcK6mjzoMA/zLUpJv68seO8QOl1bomF
         taPIhmqqtFX5GPp/uyn7jIm9SKqWXyxGTpOiByBmZXNbOkoV0V72UnqA0CCGeebMfpN1
         q/MD9j1zVGQM5ORsBt8SK4WpF5/7TKyj6hcEuqRgWhMHF+UVdRB53Y+MS3KOWAbcPqY0
         qqZeWuPdrMyFn1mE0IuIDNszFqhXQ2pwzw2I4tGlNfzNsYJex8xiHPWE1u2ha115T1Os
         LXbw==
X-Gm-Message-State: AOAM532hlTPc/+Ur0fiVxWNBn6YtbI9JwFL7Wvg4/9RpRxBWLeccskHE
        oYyRQMi46ucwpQV0m+9RVzElz2U/mHclxJNV
X-Google-Smtp-Source: ABdhPJzJj4NpFIJXnPVfImXST3+VM8CzmqCBhHtZJjZf/9UkqX9TBMHJbbOmj/DCeBddHPS6sY2Pdw==
X-Received: by 2002:a2e:a372:0:b0:247:ec7f:d458 with SMTP id i18-20020a2ea372000000b00247ec7fd458mr12319401ljn.275.1647204257525;
        Sun, 13 Mar 2022 13:44:17 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id b17-20020a2e5151000000b00246697dd9e7sm3442779lje.53.2022.03.13.13.44.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Mar 2022 13:44:16 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id bt26so23854216lfb.3
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 13:44:16 -0700 (PDT)
X-Received: by 2002:a05:6512:2037:b0:448:92de:21de with SMTP id
 s23-20020a056512203700b0044892de21demr1782886lfs.52.1647204255836; Sun, 13
 Mar 2022 13:44:15 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 13 Mar 2022 13:43:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiHa0vsZseZES=1T0rJ4Z_bC5cwHMUJfqFL9hVpvB283g@mail.gmail.com>
Message-ID: <CAHk-=wiHa0vsZseZES=1T0rJ4Z_bC5cwHMUJfqFL9hVpvB283g@mail.gmail.com>
Subject: Linux 5.17-rc8
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

So last weekend, I thought I'd be releasing the final 5.17 today.

That was then, this is now. Last week was somewhat messy, mostly
because of embargoed patches we had pending with another variation of
spectre attacks.  And while the patches were mostly fine, we had the
usual "because it was hidden, all our normal testing automation didn't
see it either".

And once the automation sees things, it tests all the insane
combinations that people don't tend to actually use or test in any
normal case, and so there was a (small) flurry of fixes for the fixes.

None of this was really surprising, but I na=C3=AFvely thought I'd be able
to do the final release this weekend anyway.

And honestly, I considered it. I don't think we really have any
pending issues that would hold up a release, but on the other hand we
also really don't have any reason _not_ to give it another week with
all the proper automated testing.  So that's what I'm doing, and as a
result we have an -rc8 release today instead of doing a final 5.17.

There's a number of non-spectre things in here too, of course. Among
other things, people finally chased down a couple of mislaid patches
that had been on the regression list, so hopefully we have those all
nailed down now too.

And obviously there's all the usual random fixes in here too. But
because of the spectre thing, about half of the -rc8 patch is
architecture updates.

That said, it's still a fairly _small_ half of the patch. It was not
one of the "big disaster" hw speculation things, it was mostly
extending existing mitigations and reporting.

Anyway, let's not keep the testing _just_ to automation - the more the
merrier, and real-life loads are always more interesting than what the
automation farms do. So please do give this last rc a quick try,

                    Linus

---

Akhil R (1):
      gpio: tegra186: Add IRQ per bank for Tegra241

Aleksander Jan Bajkowski (1):
      net: lantiq_xrx200: fix use after free bug

Alexey Khoroshilov (1):
      mISDN: Fix memory leak in dsp_pipeline_build()

Andy Shevchenko (2):
      gpiolib: acpi: Convert ACPI value of debounce to microseconds
      gpio: sim: Declare gpio_sim_hog_config_item_ops static

AngeloGioacchino Del Regno (1):
      soc: mediatek: mt8192-mmsys: Fix dither to dsi0 path's input sel

Anirudh Rayabharam (1):
      vhost: fix hung thread due to erroneous iotlb entries

Arnaldo Carvalho de Melo (2):
      tools kvm headers arm64: Update KVM headers from the kernel sources
      tools headers cpufeatures: Sync with the kernel sources

Aswath Govindraju (1):
      dt-bindings: phy: ti,tcan104x-can: Document mux-states property

Bartosz Golaszewski (1):
      gpio: sim: fix a typo

Ben Ben-Ishay (1):
      net/mlx5e: SHAMPO, reduce TIR indication

Biju Das (1):
      spi: Fix invalid sgs value

Bjorn Andersson (1):
      arm64: dts: qcom: sm8350: Correct UFS symbol clocks

Catalin Marinas (1):
      arm64: Ensure execute-only permissions are not allowed without EPAN

Christophe JAILLET (2):
      ice: Don't use GFP_KERNEL in atomic context
      watch_queue: Use the bitmap API when applicable

Cl=C3=A9ment L=C3=A9ger (1):
      net: phy: DP83822: clear MISR2 register to disable interrupts

Colin Foster (1):
      net: phy: correct spelling error of media in documentation

Dan Carpenter (1):
      staging: gdm724x: fix use after free in gdm_lte_rx()

Daniel Bristot de Oliveira (1):
      tracing/osnoise: Do not unregister events twice

Daniel Palmer (1):
      ARM: mstar: Select HAVE_ARM_ARCH_TIMER

Dave Ertman (1):
      ice: Fix error with handling of bonding MTU

David Howells (10):
      watch_queue: Fix filter limit check
      watch_queue, pipe: Free watchqueue state after clearing pipe ring
      watch_queue: Fix to release page in ->release()
      watch_queue: Fix to always request a pow-of-2 pipe ring size
      watch_queue: Fix the alloc bitmap size to reflect notes allocated
      watch_queue: Free the alloc bitmap when the watch_queue is torn down
      watch_queue: Fix lack of barrier/sync/lock between post and read
      watch_queue: Make comment about setting ->defunct more accurate
      afs: Fix potential thrashing in afs writeback
      cachefiles: Fix volume coherency attribute

Dima Chumak (1):
      net/mlx5: Fix offloading with ESWITCH_IPV4_TTL_MODIFY_ENABLE

Dmitry Torokhov (1):
      HID: vivaldi: fix sysfs attributes leak

Duoming Zhou (1):
      ax25: Fix NULL pointer dereference in ax25_kill_by_device

Emil Renner Berthing (1):
      riscv: Fix auipc+jalr relocation range checks

Emmanuel Gil Peyrot (1):
      ARM: fix build error when BPF_SYSCALL is disabled

Eric Dumazet (1):
      sctp: fix kernel-infoleak for SCTP sockets

Fabio Estevam (1):
      smsc95xx: Ignore -ENODEV errors when device is unplugged

Guillaume Nault (2):
      selftests: pmtu.sh: Kill tcpdump processes launched by subshell.
      selftests: pmtu.sh: Kill nettest processes launched in subshell.

Halil Pasic (1):
      swiotlb: rework "fix info leak with DMA_FROM_DEVICE"

Hans de Goede (3):
      staging: rtl8723bs: Fix access-point mode deadlock
      staging: rtl8723bs: Improve the comment explaining the locking rules
      Bluetooth: hci_core: Fix unbalanced unlock in set_device_flags()

Heiner Kallweit (2):
      net: phy: meson-gxl: fix interrupt handling in forced mode
      net: phy: meson-gxl: improve link-up behavior

Horatiu Vultur (1):
      clk: lan966x: Fix linking error

Ivan Vecera (1):
      ice: Fix race condition during interface enslave

Jacob Keller (2):
      i40e: stop disabling VFs due to PF error responses
      ice: stop disabling VFs due to PF error responses

James Morse (20):
      arm64: entry.S: Add ventry overflow sanity checks
      arm64: spectre: Rename spectre_v4_patch_fw_mitigation_conduit
      KVM: arm64: Allow indirect vectors to be used without SPECTRE_V3A
      arm64: entry: Make the trampoline cleanup optional
      arm64: entry: Free up another register on kpti's tramp_exit path
      arm64: entry: Move the trampoline data page before the text page
      arm64: entry: Allow tramp_alias to access symbols after the 4K bounda=
ry
      arm64: entry: Don't assume tramp_vectors is the start of the vectors
      arm64: entry: Move trampoline macros out of ifdef'd section
      arm64: entry: Make the kpti trampoline's kpti sequence optional
      arm64: entry: Allow the trampoline text to occupy multiple pages
      arm64: entry: Add non-kpti __bp_harden_el1_vectors for mitigations
      arm64: entry: Add vectors that have the bhb mitigation sequences
      arm64: entry: Add macro for reading symbol addresses from the trampol=
ine
      arm64: Add percpu vectors for EL1
      arm64: proton-pack: Report Spectre-BHB vulnerabilities as part
of Spectre-v2
      arm64: Mitigate spectre style branch history side channels
      KVM: arm64: Allow SMCCC_ARCH_WORKAROUND_3 to be discovered and migrat=
ed
      arm64: Use the clearbhb instruction in mitigations
      arm64: proton-pack: Include unprivileged eBPF status in Spectre
v2 mitigation reporting

Jarkko Sakkinen (1):
      x86/sgx: Free backing memory after faulting the enclave page

Jedrzej Jagielski (1):
      ice: Fix curr_link_speed advertised speed

Jeff Layton (1):
      fuse: move FUSE_SUPER_MAGIC definition to magic.h

Jeremy Linton (1):
      net: bcmgenet: Don't claim WOL when its not available

Jernej Skrabec (1):
      drm/sun4i: mixer: Fix P010 and P210 format numbers

Jia-Ju Bai (3):
      HID: nintendo: check the return value of alloc_workqueue()
      isdn: hfcpci: check the return value of dma_set_mask() in setup_hw()
      net: qlogic: check the return value of dma_alloc_coherent() in
qed_vf_hw_prepare()

Jianglei Nie (1):
      net: arc_emac: Fix use after free in arc_mdio_probe()

Jiapeng Chong (1):
      ftrace: Fix some W=3D1 warnings in kernel doc comments

Jiasheng Jiang (2):
      net: ethernet: ti: cpts: Handle error for clk_enable
      net: ethernet: lpc_eth: Handle error for clk_enable

Jiri Kosina (1):
      HID: elo: Revert USB reference counting

Jisheng Zhang (2):
      MAINTAINERS: Update Jisheng's email address
      riscv: alternative only works on !XIP_KERNEL

Joel Stanley (1):
      ARM: dts: aspeed: Fix AST2600 quad spi group

Jon Hunter (1):
      arm64: tegra: Disable ISO SMMU for Tegra194

Jonathan Marek (2):
      arm64: dts: qcom: sm8450: enable GCC_USB3_0_CLKREF_EN for usb
      arm64: dts: qcom: sm8450: fix apps_smmu interrupts

Josh Poimboeuf (3):
      x86/speculation: Include unprivileged eBPF status in Spectre v2
mitigation reporting
      x86/speculation: Warn about Spectre v2 LFENCE mitigation
      x86/speculation: Warn about eIBRS + LFENCE + Unprivileged eBPF + SMT

Jouni H=C3=B6gander (1):
      drm/i915/psr: Set "SF Partial Frame Enable" also on full update

Juergen Gross (12):
      xen/xenbus: don't let xenbus_grant_ring() remove grants in error case
      xen/grant-table: add gnttab_try_end_foreign_access()
      xen/blkfront: don't use gnttab_query_foreign_access() for mapped stat=
us
      xen/netfront: don't use gnttab_query_foreign_access() for mapped stat=
us
      xen/scsifront: don't use gnttab_query_foreign_access() for mapped sta=
tus
      xen/gntalloc: don't use gnttab_query_foreign_access()
      xen: remove gnttab_query_foreign_access()
      xen/usb: don't use gnttab_end_foreign_access() in xenhcd_gnttab_done(=
)
      xen/9p: use alloc/free_pages_exact()
      xen/pvcalls: use alloc/free_pages_exact()
      xen/gnttab: fix gnttab_end_foreign_access() without page specified
      xen/netfront: react properly to failing gnttab_end_foreign_access_ref=
()

Kai Lueke (1):
      Revert "xfrm: state and policy should fail if XFRMA_IF_ID 0"

Kim Phillips (2):
      x86/speculation: Use generic retpoline by default on AMD
      x86/speculation: Update link to AMD speculation whitepaper

Krzysztof Kozlowski (1):
      MAINTAINERS: update Krzysztof Kozlowski's email

Kuldeep Singh (1):
      MAINTAINERS: Update git tree for Broadcom iProc SoCs

Li Huafei (1):
      x86/traps: Mark do_int3() NOKPROBE_SYMBOL

Lina Wang (1):
      xfrm: fix tunnel model fragmentation behavior

Linus Torvalds (2):
      mm: gup: make fault_in_safe_writeable() use fixup_user_fault()
      Linux 5.17-rc8

Lucas Zampieri (1):
      HID: logitech-dj: add new lightspeed receiver id

Luiz Augusto von Dentz (1):
      Bluetooth: hci_sync: Fix not processing all entries on cmd_sync_work

Marcelo Roberto Jimenez (1):
      gpio: Revert regression in sysfs-gpio (gpiolib.c)

Mark Featherston (1):
      gpio: ts4900: Do not set DAT and OE together

Maxime Ripard (1):
      ARM: boot: dts: bcm2711: Fix HVS register range

Miaoqian Lin (3):
      ethernet: Fix error handling in xemaclite_of_probe
      net: marvell: prestera: Add missing of_node_put() in
prestera_switch_set_base_mac_addr
      gianfar: ethtool: Fix refcount leak in gfar_get_ts_info

Michael Ellerman (1):
      powerpc: Fix STACKTRACE=3Dn build

Michael H=C3=BCbner (1):
      HID: Add support for open wheel and no attachment to T300

Michael S. Tsirkin (6):
      virtio: unexport virtio_finalize_features
      virtio: acknowledge all features before access
      virtio: document virtio_reset_device
      virtio_console: break out of buf poll on remove
      virtio: drop default for virtio-mem
      tools/virtio: handle fallout from folio work

Michal Maloszewski (2):
      iavf: Fix handling of vlan strip virtual channel messages
      iavf: Fix adopting new combined setting

Miklos Szeredi (2):
      fuse: fix fileattr op failure
      fuse: fix pipe buffer lifetime for direct_io

Minghao Chi (CGEL ZTE) (1):
      net:mcf8390: Use platform_get_irq() to get the interrupt

Mohammad Kabat (1):
      net/mlx5: Fix size field in bufferx_reg struct

Moshe Shemesh (1):
      net/mlx5: Fix a race on command flush flow

Nathan Chancellor (2):
      arm64: Do not include __READ_ONCE() block in assembly files
      ARM: Do not use NOCROSSREFS directive with ld.lld

Nicolas Saenz Julienne (1):
      tracing/osnoise: Force quiescent states while tracing

N=C3=ADcolas F. R. A. Prado (1):
      arm64: dts: mt8183: jacuzzi: Fix bus properties in anx's DSI endpoint

Pali Roh=C3=A1r (2):
      arm64: dts: armada-3720-turris-mox: Add missing ethernet0 alias
      arm64: dts: marvell: armada-37xx: Remap IO space to bus address 0x0

Paul Semel (1):
      arm64: kasan: fix include error in MTE functions

Pavel Skripkin (2):
      HID: hid-thrustmaster: fix OOB read in thrustmaster_interrupts
      NFC: port100: fix use-after-free in port100_send_complete

Peter Zijlstra (3):
      x86/speculation: Add eIBRS + Retpoline options
      Documentation/hw-vuln: Update spectre doc
      x86/module: Fix the paravirt vs alternative order

Peter Zijlstra (Intel) (1):
      x86/speculation: Rename RETPOLINE_AMD to RETPOLINE_LFENCE

Randy Dunlap (1):
      ARM: Spectre-BHB: provide empty stub for non-config

Rob Herring (1):
      dt-bindings: mfd: Fix pinctrl node name warnings

Robert Foss (2):
      dt-bindings: drm/bridge: anx7625: Revert DPI support
      Revert "arm64: dts: mt8183: jacuzzi: Fix bus properties in anx's
DSI endpoint"

Robert Hancock (1):
      net: macb: Fix lost RX packet wakeup race in NAPI receive

Roger Quadros (1):
      mtd: rawnand: omap2: Actually prevent invalid configuration and
build error

Roi Dayan (1):
      net/mlx5e: Lag, Only handle events from highest priority multipath en=
try

Rong Chen (1):
      mmc: meson: Fix usage of meson_mmc_post_req()

Ross Philipson (2):
      x86/boot: Fix memremap of setup_indirect structures
      x86/boot: Add setup_indirect support in early_memremap_is_setup_data(=
)

Russell King (Oracle) (9):
      ARM: report Spectre v2 status through sysfs
      ARM: early traps initialisation
      ARM: use LOADADDR() to get load address of sections
      ARM: Spectre-BHB workaround
      net: dsa: mt7530: fix incorrect test in mt753x_phylink_validate()
      ARM: include unprivileged BPF status in Spectre V2 reporting
      ARM: fix co-processor register typo
      ARM: fix build warning in proc-v7-bugs.c
      ARM: fix Thumb2 regression with Spectre BHB

Sebastian Andrzej Siewior (1):
      xdp: xdp_mem_allocator can be NULL in trace_mem_connect().

Shin'ichiro Kawasaki (1):
      block: fix blk_mq_attempt_bio_merge and rq_qos_throttle protection

Si-Wei Liu (3):
      vdpa: factor out vdpa_set_features_unlocked for vdpa internal use
      vdpa/mlx5: should verify CTRL_VQ feature exists for MQ
      vdpa/mlx5: add validation for VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET command

Stanislav Jakubek (1):
      Revert "dt-bindings: arm: qcom: Document SDX65 platform and boards"

Steev Klimaszewski (1):
      arm64: dts: qcom: c630: disable crypto due to serror

Stefano Garzarella (2):
      vhost: remove avail_event arg from vhost_update_avail_event()
      tools/virtio: fix virtio_test execution

Steffen Klassert (3):
      esp: Fix possible buffer overflow in ESP transformation
      esp: Fix BEET mode inter address family tunneling on GSO
      net: Fix esp GSO on inter address family tunnels.

Taniya Das (2):
      clk: qcom: gdsc: Add support to update GDSC transition delay
      clk: qcom: dispcc: Update the transition delay for MDSS GDSC

Thierry Reding (1):
      ARM: tegra: Move Nyan FHD panels to AUX bus

Thomas Zimmermann (1):
      drm/panel: Select DRM_DP_HELPER for DRM_PANEL_EDP

Tom Rix (1):
      qed: return status of qed_iov_get_link

Tung Nguyen (2):
      tipc: fix kernel panic when enabling bearer
      tipc: fix incorrect order of state message data sanity check

Ulf Hansson (1):
      mmc: core: Restore (almost) the busy polling for MMC_SEND_OP_COND

Vladimir Oltean (1):
      net: dsa: unlock the rtnl_mutex when dsa_master_setup() fails

Weiguo Li (2):
      perf parse-events: Fix NULL check against wrong variable
      perf bench: Fix NULL check against wrong variable

Xie Yongji (3):
      vduse: Fix returning wrong type in vduse_domain_alloc_iova()
      virtio-blk: Don't use MAX_DISCARD_SEGMENTS if max_discard_seg is zero
      virtio-blk: Remove BUG_ON() in virtio_queue_rq()

Zhang Min (1):
      vdpa: fix use-after-free on vp_vdpa_remove

Zhengjun Xing (1):
      perf parse: Fix event parser error for hybrid systems

Zheyu Ma (1):
      ethernet: sun: Free the coherent when failing in probing
