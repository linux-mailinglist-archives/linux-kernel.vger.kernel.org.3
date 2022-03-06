Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43C234CEE39
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 23:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234391AbiCFWm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 17:42:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbiCFWmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 17:42:25 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187E611C12
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 14:41:31 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id s25so17998200lji.5
        for <linux-kernel@vger.kernel.org>; Sun, 06 Mar 2022 14:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=gzEA4Vo1eWyflGliHUUq+NuiJf973MWL0zaWz77U2pc=;
        b=IwE/2XiOrr55yoX+4QxWuCZfrjvdwAGxSDfVGfMhJY081tGU1el3fTbIL0vOwmjxQO
         nPRVliOw9Qi2FK+9Rw7AUqFhG0KH2PvsfcxUgcPVtwlg0FMkXXUi2NG/HuDFIEpKfFnB
         MLrIONYzJP8HSM9rbsa95E4bsNMWQquLdAFAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=gzEA4Vo1eWyflGliHUUq+NuiJf973MWL0zaWz77U2pc=;
        b=aYVEqxQA7/jdyQOqsUJteafMMp88zvAKU8Am0ofXT1esXZ//sNX4spoh1dUJ7YFMf/
         iN2S53E8zA+AZf37QCTRDQGg7COIHoALOfLC59yQwsL3f6sYNGOBtVvvILxBU5hYV0bb
         9j16dL2k1u5Wp5hPbtV3O6FQc+FPer/8PWPWCIwTsaOvFJRBAi0e6rcLLGTVeWVPAQT+
         J5IelpDJGouuwPjG7Tv4NG2w2JWmeddqOgZGa8Bl86UPV6s71kvZ7A258pZjWJYFxpq2
         76Bn92VsvrH97JPQy3aHCyvCMJQnhXg8EuQ5/j586Yp3xRtMzL1okM3pzT87/JmQYbRF
         PmnA==
X-Gm-Message-State: AOAM532Fk5XCDcFYgwLm7vDpdnAHNeFnuECQqgIB8LqrKIZgvKu5N9Mg
        1YI1BZQ7EaaNtztA68faFz3Y/vOsD2kejxNWM6k=
X-Google-Smtp-Source: ABdhPJyeO2l/QBEHGoqx7ZiqRWu/TB4E/THFGEy/Zi3EdV3F+v+y61XWRSPm/Lyjla0NMv8NLgmRtw==
X-Received: by 2002:a2e:a885:0:b0:247:dbb6:e3d with SMTP id m5-20020a2ea885000000b00247dbb60e3dmr5018683ljq.475.1646606488652;
        Sun, 06 Mar 2022 14:41:28 -0800 (PST)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id r28-20020a2eb61c000000b00247e43e83e0sm400373ljn.58.2022.03.06.14.41.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Mar 2022 14:41:28 -0800 (PST)
Received: by mail-lj1-f173.google.com with SMTP id r22so2451791ljd.4
        for <linux-kernel@vger.kernel.org>; Sun, 06 Mar 2022 14:41:28 -0800 (PST)
X-Received: by 2002:a2e:804b:0:b0:247:e81f:87e9 with SMTP id
 p11-20020a2e804b000000b00247e81f87e9mr507963ljg.176.1646606487589; Sun, 06
 Mar 2022 14:41:27 -0800 (PST)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 6 Mar 2022 14:41:11 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjkkYX8OvTv60+XvQkAK4Pg0QC0Hn-4+n7Q0t1+QWw7Sw@mail.gmail.com>
Message-ID: <CAHk-=wjkkYX8OvTv60+XvQkAK4Pg0QC0Hn-4+n7Q0t1+QWw7Sw@mail.gmail.com>
Subject: Linux 5.17-rc7
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

No surprises this week - we still have a couple of pending things, but
everything looks under control.

Knock wood.

Last week saw the usual number of small fixes all over - with btrfs
standing out once again. But once again it's not like it's a lot of
changes, it's just that the rest tends to be pretty small.

"The rest" in this case is mostly networking (drivers but also some
core fixes), misc other drivers (gpu and input, with some noise
elsewhere) and arch updates (mostly devicetree and some kvm fixes, but
also RISC-V and s390).

Shortlog appended - and as things stand, I expect that final 5.17 will
be next weekend unless something surprising comes up.

Please test,

                Linus

---

Adam Ford (1):
      arm64: dts: imx8mm: Fix VPU Hanging

Adrian Huang (1):
      iommu/vt-d: Fix double list_add when enabling VMD in scalable mode

Alex Elder (2):
      net: ipa: fix a build dependency
      net: ipa: add an interconnect dependency

Alexander Egorenkov (1):
      s390/setup: preserve memory at OLDMEM_BASE and OLDMEM_SIZE

Alexander Lobakin (1):
      MIPS: smp: fill in sibling and core maps earlier

Alexandre Ghiti (6):
      riscv: Fix is_linear_mapping with recent move of KASAN region
      riscv: Fix config KASAN && SPARSEMEM && !SPARSE_VMEMMAP
      riscv: Fix DEBUG_VIRTUAL false warnings
      riscv: Fix config KASAN && DEBUG_VIRTUAL
      riscv: Move high_memory initialization to setup_bootmem
      riscv: Fix kasan pud population

Alyssa Ross (1):
      firmware: arm_scmi: Remove space in MODULE_ALIAS name

Amit Cohen (2):
      selftests: mlxsw: tc_police_scale: Make test more robust
      selftests: mlxsw: resource_scale: Fix return value

Ammar Faizi (1):
      MAINTAINERS: Remove dead patchwork link

Andy Shevchenko (6):
      soc: fsl: Replace kernel.h with the necessary inclusions
      soc: fsl: Correct MAINTAINERS database (QUICC ENGINE LIBRARY)
      soc: fsl: Correct MAINTAINERS database (SOC)
      auxdisplay: lcd2s: Fix lcd2s_redefine_char() feature
      auxdisplay: lcd2s: Fix memory leak in ->remove()
      auxdisplay: lcd2s: Use proper API to free the instance of charlcd obj=
ect

Anthoine Bourgeois (2):
      ARM: dts: switch timer config to common devkit8000 devicetree
      ARM: dts: Use 32KiHz oscillator on devkit8000

Antony Antony (1):
      xfrm: fix the if_id check in changelink

Ben Dooks (1):
      rfkill: define rfill_soft_blocked() if !RFKILL

Brian Gix (1):
      Bluetooth: Fix not checking MGMT cmd pending queue

Brian Norris (1):
      arm64: dts: rockchip: Switch RK3399-Gru DP to SPDIF output

Carsten Haitzler (1):
      drm/arm: arm hdlcd select DRM_GEM_CMA_HELPER

Casper Andersson (2):
      net: sparx5: Fix add vlan when invalid operation
      net: sparx5: Add #include to remove warning

Chengming Zhou (1):
      kselftest/vm: fix tests build with old libc

Christophe JAILLET (3):
      soc: fsl: guts: Revert commit 3c0d64e867ed
      soc: fsl: guts: Add a missing memory allocation failure check
      bnx2: Fix an error message

Chuanhong Guo (1):
      MIPS: ralink: mt7621: do memory detection on KSEG1

Corentin Labbe (1):
      ARM: dts: rockchip: fix a typo on rk3288 crypto-controller

Corinna Vinschen (1):
      igc: igc_read_phy_reg_gpy: drop premature return

D. Wythe (3):
      net/smc: fix connection leak
      net/smc: fix unexpected SMC_CLC_DECL_ERR_REGRMB error generated by cl=
ient
      net/smc: fix unexpected SMC_CLC_DECL_ERR_REGRMB error cause by server

Daniel Borkmann (1):
      mm: Consider __GFP_NOWARN flag for oversized kvmalloc() calls

Dave Jiang (2):
      ntb: intel: fix port config status offset for SPR
      MAINTAINERS: update mailing list address for NTB subsystem

David Gow (1):
      Input: samsung-keypad - properly state IOMEM dependency

David Howells (1):
      cachefiles: Fix incorrect length to fallocate()

Deren Wu (1):
      mac80211: fix EAPoL rekey fail in 802.3 rx path

Dexuan Cui (1):
      x86/kvmclock: Fix Hyper-V Isolated VM's boot issue when vCPUs > 64

Dinh Nguyen (2):
      dt-bindings: usb: dwc2: add compatible "intel,socfpga-agilex-hsotg"
      arm64: dts: agilex: use the compatible "intel,socfpga-agilex-hsotg"

Douglas Anderson (1):
      drm/bridge: ti-sn65dsi86: Properly undo autosuspend

Emmanuel Grumbach (1):
      iwlwifi: mvm: return value for request_ownership

Eric Dumazet (5):
      netfilter: nf_tables: prefer kfree_rcu(ptr, rcu) variant
      netfilter: fix use-after-free in __nf_register_net_hook()
      bpf, sockmap: Do not ignore orig_len parameter
      tcp: make tcp_read_sock() more robust
      ipv6: fix skb drops in igmp6_event_query() and igmp6_event_report()

Eric W. Biederman (1):
      ucounts: Fix systemd LimitNPROC with private users regression

Fabio Estevam (1):
      ASoC: cs4265: Fix the duplicated control name

Filipe Manana (3):
      btrfs: fix lost prealloc extents beyond eof after full fsync
      btrfs: add missing run of delayed items after unlink during log repla=
y
      btrfs: fallback to blocking mode when doing async dio over
multiple extents

Florian Westphal (5):
      netfilter: egress: silence egress hook lockdep splats
      netfilter: nf_queue: don't assume sk is full socket
      selftests: netfilter: add nfqueue TCP_NEW_SYN_RECV socket race test
      netfilter: nf_queue: fix possible use-after-free
      netfilter: nf_queue: handle socket prefetch

Frank Wunderlich (2):
      arm64: dts: rockchip: fix dma-controller node names on rk356x
      arm64: dts: rockchip: drop pclk_xpcs from gmac0 on rk3568

Gao Xiang (1):
      erofs: fix ztailpacking on > 4GiB filesystems

Golan Ben Ami (1):
      iwlwifi: don't advertise TWT support

Gustavo A. R. Silva (1):
      NTB/msi: Use struct_size() helper in devm_kzalloc()

Hans Verkuil (1):
      pinctrl-sunxi: sunxi_pinctrl_gpio_direction_in/output: use correct of=
fset

Hans de Goede (4):
      Input: goodix - use the new soc_intel_is_byt() helper
      Input: goodix - workaround Cherry Trail devices with a bogus
ACPI Interrupt() resource
      Input: elan_i2c - move regulator_[en|dis]able() out of
elan_[en|dis]able_power()
      Input: elan_i2c - fix regulator enable count imbalance after
suspend/resume

Heiko Carstens (3):
      s390/ftrace: fix ftrace_caller/ftrace_regs_caller generation
      s390/ftrace: fix arch_ftrace_get_regs implementation
      s390/extable: fix exception table sorting

Hugh Dickins (1):
      memfd: fix F_SEAL_WRITE after shmem huge page allocated

Ilya Lipnitskiy (1):
      MIPS: ralink: mt7621: use bitwise NOT instead of logical

Jakob Unterwurzacher (1):
      arm64: dts: rockchip: fix rk3399-puma eMMC HS400 signal integrity

Jann Horn (1):
      efivars: Respect "block" flag in efivar_entry_set_safe()

Jason Wang (1):
      soc: fsl: qe: fix typo in a comment

Jia-Ju Bai (2):
      net: chelsio: cxgb3: check the return value of pci_find_capability()
      atm: firestream: check the return value of ioremap() in fs_init()

Jiasheng Jiang (2):
      soc: fsl: qe: Check of ioremap return value
      nl80211: Handle nla_memdup failures in handle_nan_filter

Jiri Bohac (2):
      xfrm: fix MTU regression
      Revert "xfrm: xfrm_state_mtu should return at least 1280 for ipv6"

Johannes Berg (3):
      mac80211: refuse aggregations sessions before authorized
      mac80211: treat some SAE auth steps as final
      cfg80211: fix CONFIG_CFG80211_EXTRA_REGDB_KEYDIR typo

Jonathan Lemon (1):
      ptp: ocp: Add ptp_ocp_adjtime_coarse for large adjustments

Josef Bacik (2):
      btrfs: do not WARN_ON() if we have PageError set
      btrfs: do not start relocation until in progress drops are done

Julian Braha (1):
      ARM: 9178/1: fix unmet dependency on BITREVERSE for HAVE_ARCH_BITREVE=
RSE

Kees Cook (1):
      binfmt_elf: Avoid total_mapping_size for ET_EXEC

Krzysztof Kozlowski (1):
      arm64: dts: rockchip: align pl330 node name with dtschema

Lad Prabhakar (6):
      drm/exynos/exynos7_drm_decon: Use platform_get_irq_byname() to
get the interrupt
      drm/exynos: mixer: Use platform_get_irq() to get the interrupt
      drm/exynos/exynos_drm_fimd: Use platform_get_irq_byname() to get
the interrupt
      drm/exynos/fimc: Use platform_get_irq() to get the interrupt
      drm/exynos: gsc: Use platform_get_irq() to get the interrupt
      can: rcar_canfd: rcar_canfd_channel_probe(): register the CAN
device when fully ready

Laurent Pinchart (1):
      soc: imx: gpcv2: Fix clock disabling imbalance in error path

Lennert Buytenhek (1):
      iommu/amd: Recover from event log overflow

Leon Romanovsky (1):
      xfrm: enforce validity of offload input flags

Li RongQing (1):
      KVM: x86: Yield to IPI target vCPU only if it is busy

Li Yang (2):
      dt-bindings: qoriq-clock: add missing compatible for lx2160a
      dt-bindings: fsl,layerscape-dcfg: add missing compatible for lx2160a

Like Xu (1):
      KVM: x86/mmu: Passing up the error state of mmu_alloc_shadow_roots()

Lin Ma (1):
      Bluetooth: fix data races in smp_unregister(), smp_del_chan()

Linus Torvalds (1):
      Linux 5.17-rc7

Luiz Augusto von Dentz (4):
      Bluetooth: hci_core: Fix leaking sent_cmd skb
      Bluetooth: Fix bt_skb_sendmmsg not allocating partial chunks
      Bluetooth: hci_sync: Fix hci_update_accept_list_sync
      Bluetooth: hci_sync: Fix not using conn_timeout

Maciej Fijalkowski (1):
      ixgbe: xsk: change !netif_carrier_ok() handling in ixgbe_xmit_zc()

Manasi Navare (1):
      drm/vrr: Set VRR capable prop only if it is attached to connector

Marek Marczykowski-G=C3=B3recki (1):
      xen/netfront: destroy queues before real_num_tx_queues is zeroed

Marek Szyprowski (2):
      drm/exynos: Don't fail if no TE-gpio is defined for DSI driver
      drm/exynos: Search for TE-gpio in DSI panel's node

Marek Vasut (1):
      ASoC: ops: Shift tested values in snd_soc_put_volsw() by +min

Mark Brown (1):
      KVM: selftests: aarch64: Skip tests if we can't create a vgic-v3

Mat Martineau (1):
      mptcp: Correctly set DATA_FIN timeout when number of retransmits is l=
arge

Miaoqian Lin (1):
      iommu/tegra-smmu: Fix missing put_device() call in tegra_smmu_find

Mike Kravetz (1):
      selftests/vm: cleanup hugetlb file after mremap test

Murilo Opsfelder Araujo (1):
      powerpc/64s: Fix build failure when CONFIG_PPC_64S_HASH_MMU is not se=
t

Nicolas Cavallari (1):
      thermal: core: Fix TZ_GET_TRIP NULL pointer dereference

Nicolas Escande (1):
      mac80211: fix forwarded mesh frames AC & queue selection

Nicolas Ferre (2):
      MAINTAINERS: replace a Microchip AT91 maintainer
      dt-bindings: ARM: at91: update maintainers entry

Niels Dossche (1):
      sfc: extend the locking on mcdi->seqno

Niklas Cassel (1):
      riscv: dts: k210: fix broken IRQs on hart1

Oliver Upton (1):
      KVM: arm64: Don't miss pending interrupts for suspended vCPU

Omar Sandoval (1):
      btrfs: fix relocation crash due to premature return from
btrfs_commit_transaction()

Paolo Abeni (2):
      mptcp: accurate SIOCOUTQ for fallback socket
      selftests: mptcp: do complete cleanup at exit

Paolo Bonzini (1):
      KVM: x86: pull kvm->srcu read-side to kvm_arch_vcpu_ioctl_run

Paul Blakey (1):
      net/sched: act_ct: Fix flow table lookup failure with no
originating ifindex

Peter Geis (1):
      arm64: dts: rockchip: fix Quartz64-A ddr regulator voltage

Qian Cai (1):
      configs/debug: set CONFIG_DEBUG_INFO=3Dy properly

Qiang Yu (1):
      drm/amdgpu: fix suspend/resume hang regression

Qu Wenruo (1):
      btrfs: subpage: fix a wrong check on subpage->writers

Quentin Schulz (1):
      arm64: dts: rockchip: fix rk3399-puma-haikou USB OTG mode

Randy Dunlap (7):
      mips: setup: fix setnocoherentio() boolean setting
      net: sxgbe: fix return value of __setup handler
      net: stmmac: fix return value of __setup handler
      ARM: 9182/1: mmu: fix returns from early_param() and __setup() functi=
ons
      iwlwifi: mvm: check debugfs_dir ptr before use
      iwlwifi: fix build error for IWLMEI
      tracing: Fix return value of __setup handlers

Robin Murphy (1):
      arm64: dts: juno: Remove GICv2m dma-range

Russell King (Oracle) (1):
      ARM: Fix kgdb breakpoint for Thumb2

Samuel Holland (1):
      pinctrl: sunxi: Use unique lockdep classes for IRQs

Sascha Hauer (2):
      arm64: dts: rockchip: reorder rk3399 hdmi clocks
      ARM: dts: rockchip: reorder rk322x hmdi clocks

Sasha Neftin (3):
      igc: igc_write_phy_reg_gpy: drop premature return
      e1000e: Fix possible HW unit hang after an s0ix exit
      e1000e: Correct NVM checksum verification flow

Sean Christopherson (2):
      Revert "KVM: VMX: Save HOST_CR3 in vmx_set_host_fs_gs()"
      Revert "KVM: VMX: Save HOST_CR3 in vmx_prepare_switch_to_guest()"

Sidong Yang (1):
      btrfs: qgroup: fix deadlock between rescan worker and remove qgroup

Slawomir Laba (8):
      iavf: Rework mutexes for better synchronisation
      iavf: Add waiting so the port is initialized in remove
      iavf: Fix init state closure on remove
      iavf: Fix locking for VIRTCHNL_OP_GET_OFFLOAD_VLAN_V2_CAPS
      iavf: Fix race in init state
      iavf: Fix deadlock in iavf_reset_task
      iavf: Fix missing check for running netdev
      iavf: Fix __IAVF_RESETTING state usage

Sreeramya Soratkal (1):
      nl80211: Update bss channel on channel switch for P2P_CLIENT

Steven Rostedt (Google) (1):
      tracing/histogram: Fix sorting on old "cpu" value

Su Yue (1):
      btrfs: tree-checker: use u64 for item data end to avoid overflow

Sudeep Holla (1):
      arm64: dts: imx8ulp: Set #thermal-sensor-cells to 1 as required

Sukadev Bhattiprolu (8):
      ibmvnic: free reset-work-item when flushing
      ibmvnic: initialize rc before completing wait
      ibmvnic: define flush_reset_queue helper
      ibmvnic: complete init_done on transport events
      ibmvnic: register netdev after init of adapter
      ibmvnic: init init_done_rc earlier
      ibmvnic: clear fop when retrying probe
      ibmvnic: Allow queueing resets during probe

Sunil V L (1):
      riscv/efi_stub: Fix get_boot_hartid_from_fdt() return value

Suravee Suthikulpanit (1):
      iommu/amd: Fix I/O page table memory leak

Suren Baghdasaryan (3):
      mm: refactor vm_area_struct::anon_vma_name usage code
      mm: prevent vm_area_struct::anon_name refcount saturation
      mm: fix use-after-free when anon vma name is used after vma is freed

Sven Eckelmann (3):
      batman-adv: Request iflink once in batadv-on-batadv check
      batman-adv: Request iflink once in batadv_get_real_netdevice
      batman-adv: Don't expect inter-netns unique iflink indices

Thierry Reding (1):
      ARM: tegra: Move panels to AUX bus

Tony Lu (1):
      net/smc: Fix cleanup when register ULP fails

Ville Syrj=C3=A4l=C3=A4 (1):
      drm/i915: s/JSP2/ICP2/ PCH

Vinay Belgaumkar (1):
      drm/i915/guc/slpc: Correct the param count for unset param

Vincent Mailhol (2):
      can: etas_es58x: change opened_channel_cnt's type from atomic_t to u8
      can: gs_usb: change active_channels's type from atomic_t to u8

Vincent Whitchurch (1):
      net: stmmac: only enable DMA interrupts when ready

Vladimir Oltean (4):
      net: dcb: flush lingering app table entries for unregistered devices
      net: dsa: restore error path of dsa_tree_change_tag_proto
      net: dcb: disable softirqs in dcbnl_flush_dev()
      net: dsa: make dsa_tree_change_tag_proto actually unwind the tag
proto change

Wang Qing (1):
      Bluetooth: assign len after null check

Wanpeng Li (2):
      x86/kvm: Don't use PV TLB/yield when mwait is advertised
      x86/kvm: Don't waste memory if kvmclock is disabled

William Mahon (2):
      HID: add mapping for KEY_DICTATE
      HID: add mapping for KEY_ALL_APPLICATIONS

Yan Yan (2):
      xfrm: Check if_id in xfrm_migrate
      xfrm: Fix xfrm migrate issues when address family changes

Yang Yingliang (1):
      tee: optee: fix error return code in probe function

Yu Kuai (1):
      blktrace: fix use after free for struct blk_trace

Yun Zhou (1):
      proc: fix documentation and description of pagemap

Zhen Ni (1):
      ALSA: intel_hdmi: Fix reference to PCM buffer address

Zheyu Ma (1):
      net: arcnet: com20020: Fix null-ptr-deref in com20020pci_probe()

j.nixdorf@avm.de (1):
      net: ipv6: ensure we call ipv6_mc_down() at most once

lena wang (1):
      net: fix up skbs delta_truesize in UDP GRO frag_list
