Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F06D577840
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 23:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbiGQVDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 17:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiGQVDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 17:03:01 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B681EE17
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 14:02:56 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id x91so12966638ede.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 14:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=9pVB/6IAClOcnGzDC3qQ9FFMchSRrxoS37fffuxDxak=;
        b=YFg0d3sJLGn0Ov4PuNkLZd+nmUccaEJ754c1U41cKjVvzvDoJJGFStdJD0DPpcph9c
         b7YEDPPnMamrcWfaY8MaUCl9tdCDA4ZaZnbJKWakQAbFcc0lbta6y1MPusOckEhPn39W
         c2B2OR06CxsVdleWsKzSpXcWNTbU07XzERql8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=9pVB/6IAClOcnGzDC3qQ9FFMchSRrxoS37fffuxDxak=;
        b=xWqN2pN7T/i9o2/sNG5fxeB+moGhRx92xY6srZhAwdAPf4m6ppOTzUMpdvJ/+rz7PM
         Q72uipBVoN6j02iSunZlBFOMJ4fN1OXCvbr/1vX5lz723wXkXPLjVMN6drpFygt2wzEu
         d/pK+DZIBbz8fOJCqJ4a48MuzvLfpQ7ZbaxsC2KpRGLpj+UwS8pEz16N0ylTOCwP2uPT
         /D/nZIhjbymzVzM2FkZ4cwEyTryg9y86zSeGDKMULG0DB6t2Rw9esGsQBSJzEm86phV5
         aovPPTz2KF7c194TGaMc1nfA3UhlxF3DOI/huTVcSJLFq40SdgQkHAMcJp70dSmbr4Xm
         ewlg==
X-Gm-Message-State: AJIora9+X9frc9Hr4iISBgduyfYKRa+azF/vNy9iM6MN9fwfl+zbV5av
        drsok/FR3aLFIAMGCJHq33qXbAHmcFF8oCdHkm8=
X-Google-Smtp-Source: AGRyM1sRWMYVNts3JHdGXiYR/Ba7j1+BmhIP/zt+EnZ6p7hMBEHpye/pQ6kusU5+ccsMf1oD++RTuA==
X-Received: by 2002:a05:6402:3881:b0:43a:691f:8e3b with SMTP id fd1-20020a056402388100b0043a691f8e3bmr33104909edb.217.1658091774593;
        Sun, 17 Jul 2022 14:02:54 -0700 (PDT)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id r1-20020a17090609c100b0072af102e65csm4701164eje.152.2022.07.17.14.02.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Jul 2022 14:02:54 -0700 (PDT)
Received: by mail-wm1-f47.google.com with SMTP id p4so6108075wms.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 14:02:54 -0700 (PDT)
X-Received: by 2002:a05:600c:4ec9:b0:3a2:e9bd:fcd9 with SMTP id
 g9-20020a05600c4ec900b003a2e9bdfcd9mr30325765wmq.154.1658091773388; Sun, 17
 Jul 2022 14:02:53 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 17 Jul 2022 14:02:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj63HHDU0MTRVKese5a4j82g3s3u4Ztno7=7Cj=cRRFFQ@mail.gmail.com>
Message-ID: <CAHk-=wj63HHDU0MTRVKese5a4j82g3s3u4Ztno7=7Cj=cRRFFQ@mail.gmail.com>
Subject: Linux 5.19-rc7
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's a Sunday afternoon, I wonder what that might mean..

Another week, another rc. We obviously had that whole "Retbleed"
thing, and it does show up in both the diffstat and the shortlog, and
rc7 is definitely bigger than usual.

And also as usual, when we've had one of those embargoed hw issues
pending, the patches didn't get the open development, and then as a
result missed all the usual sanity checking by all the automation
build and test infrastructure we have. So no surprise - there's been
various small fixup patches afterwards too for some corner cases.

That said, last week there were two other development trees that
independently also asked for an extension, so 5.19 will be one of
those releases that have an additional rc8 next weekend before the
final release. We had some last-minute btrfs reverts, and there's also
a pending issue with a intel GPU firmware.

When it rains it pours.

Not that things really look all that bad. I think we've got the
retbleed fallout all handled (knock wood), and the btrfs reverts are
in place. And the Intel GPU firmware issue seems to have a patch
pending too (or we'll just revert). So it's not like we have any huge
issues, but an extra week is most definitely called for.

          Linus

---

Aaron Tomlin (1):
      module: kallsyms: Ensure preemption in add_kallsyms() with PREEMPT_RT

Adrian Hunter (3):
      modules: Fix corruption of /proc/kallsyms
      perf tests: Stop Convert perf time to TSC test opening events twice
      perf tests: Fix Convert perf time to TSC test for hybrid

Alex Deucher (2):
      drm/amdgpu: keep fbdev buffers pinned during suspend
      drm/amdgpu/display: disable prefer_shadow for generic fb helpers

Alexandre Chartre (3):
      x86/bugs: Report AMD retbleed vulnerability
      x86/bugs: Add AMD retbleed=3D boot parameter
      x86/entry: Remove UNTRAIN_RET from native_irq_return_ldt

Alexandre Ghiti (1):
      riscv: Fix missing PAGE_PFN_MASK

Alexey Gladkov (1):
      ipc: Free mq_sysctls if ipc namespace creation failed

Andrea Mayer (3):
      seg6: fix skb checksum evaluation in SRH encapsulation/insertion
      seg6: fix skb checksum in SRv6 End.B6 and End.B6.Encaps behaviors
      seg6: bpf: fix skb checksum in bpf_push_seg6_encap()

Andrew Cooper (1):
      x86/cpu/amd: Enumerate BTC_NO

Andrzej Hajda (1):
      drm/i915/selftests: fix subtraction overflow bug

AngeloGioacchino Del Regno (1):
      cpufreq: mediatek: Handle sram regulator probe deferral

Ansgar L=C3=B6=C3=9Fer (1):
      vf/remap: return the amount of bytes actually deduplicated

Anup Patel (1):
      RISC-V: KVM: Fix SRCU deadlock caused by kvm_riscv_check_vcpu_request=
s()

Ard Biesheuvel (3):
      ARM: 9209/1: Spectre-BHB: avoid pr_info() every time a CPU comes
out of idle
      ARM: 9214/1: alignment: advance IT state after emulating Thumb instru=
ction
      ARM: 9208/1: entry: add .ltorg directive to keep literals in range

Arnaldo Carvalho de Melo (3):
      tools headers UAPI: Sync linux/kvm.h with the kernel sources
      tools headers cpufeatures: Sync with the kernel sources
      tools arch x86: Sync the msr-index.h copy with the kernel sources

Arunpravin Paneer Selvam (1):
      Revert "drm/amdgpu: add drm buddy support to amdgpu"

Axel Rasmussen (1):
      mm: userfaultfd: fix UFFDIO_CONTINUE on fallocated shmem pages

Bagas Sanjaya (1):
      Documentation: highmem: use literal block for code example in
highmem.h comment

Baolin Wang (1):
      mm/damon: use set_huge_pte_at() to make huge pte old

Baowen Zheng (1):
      nfp: fix issue of skb segments exceeds descriptor limitation

Bartosz Golaszewski (1):
      gpio: sim: fix the chip_name configfs item

Biju Das (1):
      serial: 8250: dw: Fix the macro RZN1_UART_xDMACR_8_WORD_BURST

Bjorn Andersson (1):
      scsi: ufs: core: Drop loglevel of WriteBoost message

Brent Lu (1):
      ASoC: Intel: sof_rt5682: fix out-of-bounds array access

Brian Norris (1):
      arm64: dts: rockchip: Assign RK3399 VDU clock rate

Bryan O'Donoghue (1):
      ASoC: dt-bindings: Fix description for msm8916

Changyuan Lyu (2):
      scsi: pm80xx: Fix 'Unknown' max/min linkrate
      scsi: pm80xx: Set stopped phy's linkrate to Disabled

Chanho Park (1):
      tty: serial: samsung_tty: set dma burst_size to 1

Charles Keepax (4):
      ASoC: wm5102: Fix event generation for output compensation
      ASoC: wm8998: Fix event generation for input mux
      ASoC: cs47l92: Fix event generation for OUT1 demux
      ASoC: arizona: Update arizona_aif_cfg_changed to use RX_BCLK_RATE

Chia-Lin Kao (AceLan) (2):
      net: atlantic: remove deep parameter on suspend/resume functions
      net: atlantic: remove aq_nic_deinit() when resume

Chris Wilson (3):
      drm/i915/gt: Serialize GRDOM access between multiple engine resets
      drm/i915/gt: Serialize TLB invalidates with GT resets
      drm/i915/gem: Look for waitboosting across the whole object
prior to individual waits

Christian Brauner (1):
      ovl: turn of SB_POSIXACL with idmapped layers temporarily

Christoph Hellwig (1):
      btrfs: zoned: fix a leaked bioc in read_zone_info

Christophe Leroy (2):
      module: Fix selfAssignment cppcheck warning
      module: Fix "warning: variable 'exit' set but not used"

Chuck Lever (1):
      NFSD: Decode NFSv4 birth time attribute

Coiby Xu (1):
      ima: force signature verification when CONFIG_KEXEC_SIG is configured

Conor Dooley (2):
      riscv: dts: microchip: hook up the mpfs' l2cache
      MAINTAINERS: add polarfire rng, pci and clock drivers

Cristian Ciocaltea (1):
      spi: amd: Limit max transfer and message size

C=C3=A9dric Le Goater (2):
      spi: aspeed: Add dev_dbg() to dump the spi-mem direct mapping descrip=
tor
      spi: aspeed: Fix division by zero

Dan Carpenter (3):
      drm/i915/gvt: IS_ERR() vs NULL bug in intel_gvt_update_reg_whitelist(=
)
      drm/i915/selftests: fix a couple IS_ERR() vs NULL tests
      net: stmmac: fix leaks in probe

Daniel Mack (1):
      ASoC: max98396: Fix register access for PCM format settings

Daniele Ceraolo Spurio (2):
      drm/i915/guc: ADL-N should use the same GuC FW as ADL-S
      drm/i915/guc: ADL-N should use the same GuC FW as ADL-S

Darren Stevens (1):
      drivers/usb/host/ehci-fsl: Fix interrupt setup in host mode.

Dave Chinner (1):
      fs/remap: constrain dedupe of EOF blocks

David Hildenbrand (1):
      mm/rmap: fix dereferencing invalid subpage pointer in try_to_migrate_=
one()

David Owens (1):
      ASoC: ti: omap-mcbsp: duplicate sysfs error

David Sterba (4):
      Revert "btrfs: turn fs_roots_radix in btrfs_fs_info into an XArray"
      Revert "btrfs: turn fs_info member buffer_radix into XArray"
      Revert "btrfs: turn name_cache radix tree into XArray in send_ctx"
      Revert "btrfs: turn delayed_nodes_tree into an XArray"

Demi Marie Obenour (1):
      xen/gntdev: Ignore failure to unmap INVALID_GRANT_HANDLE

Dmitry Osipenko (3):
      drm/panfrost: Put mapping instead of shmem obj on
panfrost_mmu_map_fault_addr() error
      drm/panfrost: Fix shrinker list corruption by madvise IOCTL
      ARM: 9213/1: Print message about disabled Spectre workarounds only on=
ce

Dorian Rudolph (1):
      power: supply: core: Fix boundary conditions in interpolation

Douglas Anderson (1):
      tracing: Fix sleeping while atomic in kdb ftdump

Eli Cohen (1):
      net/mlx5: TC, allow offload from uplink to other PF's VF

Eric Dumazet (2):
      bpf: Make sure mac_header was set before using it
      vlan: fix memory leak in vlan_newlink()

Ezequiel Garcia (1):
      drm/ssd130x: Fix pre-charge period setting

Fangzhi Zuo (1):
      drm/amd/display: Ignore First MST Sideband Message Return Error

Felix Fietkau (2):
      wifi: mac80211: do not wake queues on a vif that is being stopped
      wifi: mac80211: fix queue selection for mesh/OCB interfaces

Filipe Manana (1):
      btrfs: return -EAGAIN for NOWAIT dio reads/writes on compressed
and inline extents

Florian Westphal (1):
      netfilter: conntrack: fix crash due to confirmed bit load reordering

Francesco Dolcini (1):
      ASoC: sgtl5000: Fix noise on shutdown/remove

Gal Pressman (1):
      net/mlx5e: Fix capability check for updating vnic env counters

Gao Chao (1):
      power: supply: ab8500_fg: add missing destroy_workqueue in ab8500_fg_=
probe

Geert Uytterhoeven (1):
      sh: convert nommu io{re,un}map() to static inline functions

Gowans, James (1):
      mm: split huge PUD on wp_huge_pud fallback

Guenter Roeck (1):
      um: Replace to_phys() and to_virt() with less generic function names

Han Xu (1):
      MAINTAINERS: change the NXP FSPI driver maintainer.

Hangyu Hua (2):
      drm/i915: fix a possible refcount leak in intel_dp_add_mst_connector(=
)
      drm/i915: fix a possible refcount leak in intel_dp_add_mst_connector(=
)

Hans de Goede (7):
      drm: panel-orientation-quirks: Add quirk for the Lenovo Yoga Tablet 2=
 830
      Input: goodix - call acpi_device_fix_up_power() in some cases
      platform/x86: x86-android-tablets: Fix Lenovo Yoga Tablet 2
830/1050 poweroff again
      efi: Fix efi_power_off() not being run before acpi_power_off()
when necessary
      platform/x86/intel/ifs: Mark as BROKEN
      platform/x86: intel_atomisp2_led: Also turn off the always-on
camera LED on the Asus T100TAF
      ACPI: video: Fix acpi_video_handles_brightness_key_presses()

Hayes Wang (1):
      r8152: fix accessing unset transport header

Hector Martin (2):
      ASoC: tas2764: Correct playback volume range
      ASoC: tas2764: Fix amp gain register offset & default

Heiko Stuebner (1):
      riscv: don't warn for sifive erratas in modules

Huaxin Lu (1):
      ima: Fix a potential integer overflow in ima_appraise_measurement

Ilpo J=C3=A4rvinen (4):
      serial: pl011: UPSTAT_AUTORTS requires .throttle/unthrottle
      serial: 8250: Fix __stop_tx() & DMA Tx restart races
      serial: stm32: Clear prev values before setting RTS delays
      serial: 8250: Fix PM usage_count for console handover

Israel Rukshin (1):
      nvme: fix block device naming collision

Jakub Kicinski (1):
      selftest: net: add tun to .gitignore

Jason A. Donenfeld (1):
      random: cap jitter samples per bit to factor of HZ

Jason Gunthorpe (1):
      vfio: Move IOMMU_CAP_CACHE_COHERENCY test to after we know we have a =
group

Jeff Layton (2):
      lockd: set fl_owner when unlocking files
      lockd: fix nlm_close_files

Jeremy Szu (1):
      ALSA: hda/realtek: fix mute/micmute LEDs for HP machines

Jiang Jian (1):
      optee: Remove duplicate 'of' in two places.

Jianglei Nie (2):
      ASoC: qdsp6: fix potential memory leak in q6apm_get_audioreach_graph(=
)
      ima: Fix potential memory leak in ima_init_crypto()

Jiapeng Chong (1):
      x86/bugs: Mark retbleed_strings static

Jiri Slaby (3):
      tty: extract tty_flip_buffer_commit() from tty_flip_buffer_push()
      tty: use new tty_insert_flip_string_and_push_buffer() in pty_write()
      x86/asm/32: Fix ANNOTATE_UNRET_SAFE use on 32-bit

Joanne Koong (1):
      bpf: Add flags arg to bpf_dynptr_read and bpf_dynptr_write APIs

Johan Almbladh (1):
      xdp: Fix spurious packet loss in generic XDP TX path

Johan Hovold (1):
      Input: usbtouchscreen - add driver_info sanity check

Johannes Berg (1):
      wifi: mac80211_hwsim: set virtio device ready in probe()

John Ogness (1):
      printk: do not wait for consoles when suspended

Jon Hunter (1):
      net: stmmac: dwc-qos: Disable split header for Tegra194

Josh Poimboeuf (13):
      x86/bugs: Do IBPB fallback check only once
      x86/speculation: Fix RSB filling with CONFIG_RETPOLINE=3Dn
      x86/speculation: Fix firmware entry SPEC_CTRL handling
      x86/speculation: Fix SPEC_CTRL write on SMT state change
      x86/speculation: Use cached host SPEC_CTRL value for guest entry/exit
      x86/speculation: Remove x86_spec_ctrl_mask
      objtool: Re-add UNWIND_HINT_{SAVE_RESTORE}
      KVM: VMX: Flatten __vmx_vcpu_run()
      KVM: VMX: Convert launched argument to flags
      KVM: VMX: Prevent guest RSB poisoning attacks with eIBRS
      KVM: VMX: Fix IBRS handling after vmexit
      x86/speculation: Fill RSB on vmexit for IBRS
      KVM: VMX: Prevent RSB underflow before vmenter

Juergen Gross (2):
      x86/pat: Fix x86_has_pat_wp()
      xen/netback: avoid entering xenvif_rx_next_skb() with an empty rx que=
ue

Kalle Valo (2):
      dt-bindings: net: wireless: ath9k: Change Toke as maintainer
      dt-bindings: net: wireless: ath11k: change Kalle's email

Kashyap Desai (1):
      bnxt_en: reclaim max resources if sriov enable fails

Keith Busch (1):
      nvme-pci: fix freeze accounting for error handling

Kim Phillips (3):
      x86/sev: Avoid using __x86_return_thunk
      x86/bugs: Enable STIBP for JMP2RET
      x86/bugs: Remove apostrophe typo

Konrad Rzeszutek Wilk (1):
      x86/kexec: Disable RET on kexec

Kris Bahnsen (1):
      ARM: dts: imx6qdl-ts7970: Fix ngpio typo and count

Kuniyuki Iwashima (27):
      sysctl: Fix data races in proc_dointvec().
      sysctl: Fix data races in proc_douintvec().
      sysctl: Fix data races in proc_dointvec_minmax().
      sysctl: Fix data races in proc_douintvec_minmax().
      sysctl: Fix data races in proc_doulongvec_minmax().
      sysctl: Fix data races in proc_dointvec_jiffies().
      tcp: Fix a data-race around sysctl_tcp_max_orphans.
      inetpeer: Fix data-races around sysctl.
      net: Fix data-races around sysctl_mem.
      cipso: Fix data-races around sysctl.
      icmp: Fix data-races around sysctl.
      ipv4: Fix a data-race around sysctl_fib_sync_mem.
      sysctl: Fix data-races in proc_dou8vec_minmax().
      sysctl: Fix data-races in proc_dointvec_ms_jiffies().
      tcp: Fix a data-race around sysctl_max_tw_buckets.
      icmp: Fix a data-race around sysctl_icmp_echo_ignore_all.
      icmp: Fix data-races around sysctl_icmp_echo_enable_probe.
      icmp: Fix a data-race around sysctl_icmp_echo_ignore_broadcasts.
      icmp: Fix a data-race around sysctl_icmp_ignore_bogus_error_responses=
.
      icmp: Fix a data-race around sysctl_icmp_errors_use_inbound_ifaddr.
      icmp: Fix a data-race around sysctl_icmp_ratelimit.
      icmp: Fix a data-race around sysctl_icmp_ratemask.
      raw: Fix a data-race around sysctl_raw_l3mdev_accept.
      tcp: Fix data-races around sysctl_tcp_ecn.
      tcp: Fix a data-race around sysctl_tcp_ecn_fallback.
      ipv4: Fix data-races around sysctl_ip_dynaddr.
      nexthop: Fix data-races around nexthop_compat_mode.

Li kunyu (1):
      blk-iocost: tracing: atomic64_read(&ioc->vtime_rate) is assigned
an extra semicolon

Liang He (2):
      ARM: rockchip: Add missing of_node_put() in rockchip_suspend_init()
      net: ftgmac100: Hold reference returned by of_get_child_by_name()

Linus Torvalds (3):
      amdgpu: disable powerpc support for the newer display engine
      Revert "vf/remap: return the amount of bytes actually deduplicated"
      Linux 5.19-rc7

Linus Walleij (2):
      ARM: 9211/1: domain: drop modify_domain()
      ARM: 9212/1: domain: Modify Kconfig help text

Linyu Yuan (1):
      usb: typec: add missing uevent when partner support PD

Liu Ying (3):
      drm/bridge: fsl-ldb: Fix mode clock rate validation
      drm/bridge: fsl-ldb: Enable split mode for LVDS dual link
      drm/bridge: fsl-ldb: Drop DE signal polarity inversion

Liu, Changcheng (1):
      net/mlx5: Lag, correct get the port select mode str

Lorenzo Bianconi (1):
      wifi: mac80211: add gfp_t parameter to
ieeee80211_obss_color_collision_notify

Luca Weiss (1):
      ARM: dts: qcom: msm8974: re-add missing pinctrl

Lucien Buchmann (1):
      USB: serial: ftdi_sio: add Belimo device ids

Lukas Bulwahn (2):
      MAINTAINERS: rectify entry for SYNOPSYS AXS10x RESET CONTROLLER DRIVE=
R
      MAINTAINERS: mark ARM/PALM TREO SUPPORT orphan

Marc Kleine-Budde (1):
      tee: tee_get_drvdata(): fix description of return value

Marcin Wojtas (1):
      serial: 8250: dw: enable using pdata with ACPI

Marek Vasut (1):
      ASoC: doc: Capitalize RESET line name

Mario Kleiner (1):
      drm/amd/display: Only use depth 36 bpp linebuffers on DCN display eng=
ines.

Mario Limonciello (1):
      ACPI: CPPC: Fix enabling CPPC on AMD systems with shared memory

Mark Bloch (1):
      net/mlx5: Lag, decouple FDB selection and shared FDB

Martin Blumenstingl (2):
      selftests: forwarding: Install local_termination.sh
      selftests: forwarding: Install no_forwarding.sh

Martin Povi=C5=A1er (2):
      ASoC: tas2764: Add post reset delays
      ASoC: tas2764: Fix and extend FSYNC polarity handling

Masahiro Yamada (1):
      doc: module: update file references

Matthew Auld (2):
      drm/i915/ttm: fix sg_table construction
      drm/i915/ttm: fix 32b build

Matthieu Baerts (1):
      selftests: mptcp: validate userspace PM tests by default

Max Krummenacher (1):
      ARM: dts: colibri-imx6ull: fix snvs pinmux group

Max Staudt (1):
      tty: Add N_CAN327 line discipline ID for ELM327 based CAN driver

Maxim Mikityanskiy (1):
      net/mlx5e: Ring the TX doorbell on DMA errors

Melissa Wen (1):
      drm/amd/display: correct check of coverage blend mode

Meng Tang (6):
      ALSA: hda/realtek: Fix headset mic for Acer SF313-51
      ALSA: hda/conexant: Apply quirk for another HP ProDesk 600 G3 model
      ALSA: hda - Add fixup for Dell Latitidue E5430
      ALSA: hda/realtek - Fix headset mic problem for a HP machine with alc=
671
      ALSA: hda/realtek - Fix headset mic problem for a HP machine with alc=
221
      ALSA: hda/realtek - Enable the headset-mic on a Xiaomi's laptop

Miaoqian Lin (1):
      power/reset: arm-versatile: Fix refcount leak in versatile_reboot_pro=
be

Michael Chan (2):
      bnxt_en: Fix bnxt_reinit_after_abort() code path
      bnxt_en: Fix and simplify XDP transmit path

Michael Grzeschik (1):
      usb: gadget: uvc: fix changing interface name via configfs

Michael Walle (1):
      ARM: dts: kswitch-d10: use open drain mode for coma-mode pins

Michal Suchanek (1):
      ARM: dts: sunxi: Fix SPI NOR campatible on Orange Pi Zero

Michel D=C3=A4nzer (1):
      drm/amd/display: Ensure valid event timestamp for cursor-only commits

Mike Christie (1):
      scsi: target: Fix WRITE_SAME No Data Buffer crash

Mimi Zohar (1):
      ima: fix violation measurement list record

Ming Lei (1):
      scsi: megaraid: Clear READ queue map's nr_queues

Misaka19465 (1):
      platform/x86: asus-wmi: Add key mappings

Muchun Song (3):
      mm: sparsemem: fix missing higher order allocation splitting
      block: fix missing blkcg_bio_issue_init
      mm: sysctl: fix missing numa_stat when !CONFIG_HUGETLB_PAGE

Naohiro Aota (1):
      btrfs: zoned: drop optimization of zone finish

Nathan Chancellor (1):
      x86/speculation: Use DECLARE_PER_CPU for x86_spec_ctrl_current

Naveen N. Rao (1):
      perf trace: Fix SIGSEGV when processing syscall args

Nick Bowler (1):
      net: sunhme: output link status with a single print.

Nick Desaulniers (1):
      ubsan: disable UBSAN_DIV_ZERO for clang

Nicolas Dichtel (2):
      ip: fix dflt addr selection for connected nexthop
      selftests/net: test nexthop without gw

Oder Chiou (1):
      ASoC: rt5640: Fix the wrong state of JD1 and JD2

Oleg Nesterov (1):
      fix race between exit_itimers() and /proc/pid/timers

Pablo Neira Ayuso (2):
      netfilter: nf_log: incorrect offset to network header
      netfilter: nf_tables: replace BUG_ON by element length check

Pali Roh=C3=A1r (1):
      serial: mvebu-uart: correctly report configured baudrate value

Paolo Abeni (1):
      mptcp: fix subflow traversal at disconnect time

Paolo Bonzini (3):
      kvm: stats: tell userspace which values are boolean
      Documentation: kvm: clarify histogram units
      KVM: emulate: do not adjust size of fastop and setcc subroutines

Paul Blakey (1):
      net/mlx5e: Fix enabling sriov while tc nic rules are offloaded

Paul M Stillwell Jr (2):
      ice: handle E822 generic device ID in PLDM header
      ice: change devlink code to read NVM in blocks

Pavan Chebbi (1):
      bnxt_en: Fix bnxt_refclk_read()

Pavel Skripkin (1):
      net: ocelot: fix wrong time_after usage

Pawan Gupta (3):
      x86/speculation: Add spectre_v2=3Dibrs option to support Kernel IBRS
      x86/bugs: Add Cannon lake to RETBleed affected CPU list
      x86/speculation: Disable RRSBA behavior

Peter Geis (2):
      arm64: dts: rockchip: Fix ethernet on production Quartz64-B
      arm64: dts: rockchip: Fix Quartz64-A dwc3 otg port behavior

Peter Ujfalusi (2):
      ASoC: Intel: Skylake: Correct the ssp rate discovery in skl_get_ssp_c=
lks()
      ASoC: Intel: Skylake: Correct the handling of fmt_config flexible arr=
ay

Peter Zijlstra (33):
      x86/kvm/vmx: Make noinstr clean
      x86/cpufeatures: Move RETPOLINE flags to word 11
      x86/retpoline: Cleanup some #ifdefery
      x86/retpoline: Swizzle retpoline thunk
      x86/retpoline: Use -mfunction-return
      x86: Undo return-thunk damage
      x86,objtool: Create .return_sites
      x86,static_call: Use alternative RET encoding
      x86/ftrace: Use alternative RET encoding
      x86/bpf: Use alternative RET encoding
      x86/kvm: Fix SETcc emulation for return thunks
      x86/vsyscall_emu/64: Don't use RET in vsyscall emulation
      x86: Use return-thunk in asm code
      x86/entry: Avoid very early RET
      objtool: Treat .text.__x86.* as noinstr
      x86: Add magic AMD return-thunk
      x86/bugs: Keep a per-CPU IA32_SPEC_CTRL value
      x86/entry: Add kernel IBRS implementation
      x86/bugs: Optimize SPEC_CTRL MSR writes
      x86/bugs: Split spectre_v2_select_mitigation() and
spectre_v2_user_select_mitigation()
      x86/bugs: Report Intel retbleed vulnerability
      intel_idle: Disable IBRS during long idle
      objtool: Update Retpoline validation
      x86/xen: Rename SYS* entry points
      x86/xen: Add UNTRAIN_RET
      x86/bugs: Add retbleed=3Dibpb
      objtool: Add entry UNRET validation
      x86/cpu/amd: Add Spectral Chicken
      x86/common: Stamp out the stepping madness
      x86/retbleed: Add fine grained Kconfig knobs
      x86/entry: Move PUSH_AND_CLEAR_REGS() back into error_entry
      perf/core: Fix data race between perf_event_set_output() and
perf_mmap_close()
      um: Add missing apply_returns()

Ping-Ke Shih (1):
      rtw88: 8821c: fix access const table of channel parameters

Po-Wen Kao (1):
      scsi: ufs: core: Fix missing clk change notification on host reset

Prike Liang (1):
      drm/amdkfd: correct the MEC atomic support firmware checking for GC 1=
0.3.7

P=C3=A4r Eriksson (1):
      platform/x86: gigabyte-wmi: add support for B660I AORUS PRO DDR4

Roi Dayan (1):
      net/mlx5e: CT: Use own workqueue instead of mlx5e priv

Ryan Wanner (1):
      ARM: dts: at91: sama5d2: Fix typo in i2s1 node

Ryder Lee (1):
      wifi: mac80211: check skb_shared in ieee80211_8023_xmit()

Ryusuke Konishi (1):
      nilfs2: fix incorrect masking of permission flags for symlinks

Samuel Holland (1):
      dt-bindings: display: sun4i: Fix D1 pipeline count

Sascha Hauer (2):
      ASoC: audio_graph_card2: Fix port numbers in example
      ASoC: tlv320adcx140: Fix tx_mask check

Sean Anderson (1):
      arm64: dts: ls1028a: Update SFP node to include clock

Serge Semin (1):
      reset: Fix devm bulk optional exclusive control getter

Shyam Prasad N (2):
      cifs: fix race condition with delayed threads
      cifs: remove unnecessary locking of chan_lock while freeing session

Shyam Sundar S K (2):
      platform/x86/amd/pmc: Add new acpi id for PMC controller
      platform/x86/amd/pmc: Add new platform support

Siarhei Vishniakou (1):
      Input: document the units for resolution of size axes

Siddharth Vadapalli (1):
      net: ethernet: ti: am65-cpsw: Fix devlink port register sequence

Steve French (1):
      smb3: workaround negprot bug in some Samba servers

Steven Price (1):
      drm/rockchip: Detach from ARM DMA domain in attach_device

Steven Rostedt (Google) (2):
      net: sock: tracing: Fix sock_exceed_buf_limit not to dereference
stale pointer
      ftrace: Be more specific about arch impact when function tracer is en=
abled

Sven Schnelle (1):
      ptrace: fix clearing of JOBCTL_TRACED in ptrace_unfreeze_traced()

Tariq Toukan (3):
      net/mlx5e: kTLS, Fix build time constant test in TX
      net/mlx5e: kTLS, Fix build time constant test in RX
      net/tls: Check for errors in tls_device_init

Tejun Heo (1):
      cgroup: Use separate src/dst nodes when preloading css_sets for migra=
tion

Thadeu Lima de Souza Cascardo (3):
      x86/bugs: Do not enable IBPB-on-entry when IBPB is not supported
      x86/kvm: fix FASTOP_SIZE when return thunks are enabled
      efi/x86: use naked RET on mixed mode call wrapper

Thinh Nguyen (1):
      usb: dwc3: gadget: Fix event pending check

Thomas Gleixner (1):
      x86/static_call: Serialize __static_call_fixup() properly

Thomas Hellstr=C3=B6m (2):
      drm/i915: Fix vm use-after-free in vma destruction
      drm/i915: Fix vm use-after-free in vma destruction

Thomas Zimmermann (1):
      drm/aperture: Run fbdev removal before internal helpers

Tianyu Yuan (1):
      nfp: flower: configure tunnel neighbour on cmsg rx

Tiezhu Yang (1):
      samples: Use KSYM_NAME_LEN for kprobes

Tom Lendacky (1):
      MAINTAINERS: Add an additional maintainer to the AMD XGBE driver

Tony Krowiak (1):
      s390/ap: fix error handling in __verify_queue_reservations()

Uwe Kleine-K=C3=B6nig (1):
      Input: wm97xx - make .remove() obviously always return 0

Vaishnav Achath (1):
      spi: cadence-quadspi: Remove spi_master_put() in probe failure path

Vasily Gorbik (2):
      s390/nospec: build expoline.o for modules_prepare target
      s390/nospec: remove unneeded header includes

Vikas Gupta (1):
      bnxt_en: fix livepatch query

Vinayak Yadawad (1):
      wifi: cfg80211: Allow P2P client interface to indicate port authoriza=
tion

Vitaly Kuznetsov (2):
      KVM: nVMX: Always enable TSC scaling for L2 when it was enabled for L=
1
      KVM: x86: Fully initialize 'struct kvm_lapic_irq' in kvm_pv_kick_cpu_=
op()

Wang Kefeng (1):
      ARM: 9207/1: amba: fix refcount underflow if amba_device_add() fails

William Zhang (2):
      arm64: dts: broadcom: bcm4908: Fix timer node for BCM4906 SoC
      arm64: dts: broadcom: bcm4908: Fix cpu node for smp boot

Xiu Jianfeng (1):
      Revert "evm: Fix memleak in init_desc"

Xiubo Li (1):
      netfs: do not unlock and put the folio twice

Yang Yingliang (2):
      usb: dwc3-am62: remove unnecesary clk_put()
      optee: smc_abi.c: fix wrong pointer passed to IS_ERR/PTR_ERR()

Yangxi Xiang (1):
      vt: fix memory overlapping when deleting chars in the buffer

Yassine Oudjana (1):
      ASoC: wcd9335: Use int array instead of bitmask for TX mixers

Yefim Barashkin (1):
      drm/amd/pm: Prevent divide by zero

Yevhen Orlov (1):
      net: marvell: prestera: fix missed deinit sequence

Yi Yang (1):
      serial: 8250: fix return error code in serial8250_request_std_resourc=
e()

YueHaibing (1):
      riscv/mm: fix build error while PAGE_TABLE_CHECK enabled without MMU

Zhen Lei (1):
      ARM: 9210/1: Mark the FDT_FIXED sections as shareable

Zheng Yejian (1):
      tracing/histograms: Fix memory leak problem

sunliming (1):
      fprobe/samples: Make sample_probe static

xinhui pan (1):
      dma-buf: Fix one use-after-free of fence

=C3=8D=C3=B1igo Huguet (2):
      sfc: fix use after free when disabling sriov
      sfc: fix kernel panic when creating VF
