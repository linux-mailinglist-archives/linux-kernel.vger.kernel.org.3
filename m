Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBACB4FB12E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 02:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237717AbiDKA5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 20:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237896AbiDKA5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 20:57:02 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD65C15A05
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 17:54:47 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id bu29so24039192lfb.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 17:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=AGOvdbvV48LJxrrD59FU5yvNT/muH7bipRW6igGRin8=;
        b=OqMEWPC1LeLQuLoZAaK+Ldkd4lj5tlb3AQX5dccDfv7UE4KNzxUUu3kqJ7bGRD/Mwt
         ZrLtsWpMlLABD2meFnEb+qzLWGNezDO/h86lPytroSRtoFypkh5BgsWCrbprbwzoP+Bo
         qjhuUMao2yGAP8CeYd7lyaEtiR7cK5K2thOx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=AGOvdbvV48LJxrrD59FU5yvNT/muH7bipRW6igGRin8=;
        b=zRLGLL2/oczxE3smNNOCG3AJ5M2Zucy7hjTJqb4/3ocsY492UeHFKwoG+gCa7Nt1kU
         94QTV4r4mu/7g5Vwo9dHVB6eGNUn1CQAMX+7VOmRfjka7GWe9PAbs+UPki0q0/JIpA2m
         I3Jb7mWVXrdf94OZ/21QbDViAeFRgqxrCNFgxXAQNHxGanfjnbVz2eFHKH5wBUyCfVqp
         OPXV6v3pDaHyz+d9oRO33obvC63tBUnYylzX1ZSXahbPpit3GTDx+LKPAIc+qekqox+d
         zWG5N4iMO7031M8UsfcEB8LysWhcnyZ1n8MuLHPIoru4f8CM2qyWt4HTWyGACfek9Rf1
         Niig==
X-Gm-Message-State: AOAM5319OR+aGEkpyZBa22/IhINBBG61aQR0L3hvH1Y+PCZ0xK1LsDwI
        U0mAb4QtEMR6cZUIHGp6uEBsT4M0yMyJ2sU3
X-Google-Smtp-Source: ABdhPJzQ34kgoMLs7P2DvkedV5hyDhPQNOI+QNc1EPEBfK5wgb6q0dO2kFEuDw3V6boCAj1RZevlJg==
X-Received: by 2002:ac2:4194:0:b0:442:ed9e:4a25 with SMTP id z20-20020ac24194000000b00442ed9e4a25mr19131137lfh.629.1649638485136;
        Sun, 10 Apr 2022 17:54:45 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id o26-20020a056512053a00b0046b851384bcsm896862lfc.101.2022.04.10.17.54.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Apr 2022 17:54:44 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id c15so18219385ljr.9
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 17:54:44 -0700 (PDT)
X-Received: by 2002:a05:651c:b07:b0:24b:4af9:828 with SMTP id
 b7-20020a05651c0b0700b0024b4af90828mr10594283ljr.506.1649638483523; Sun, 10
 Apr 2022 17:54:43 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 10 Apr 2022 14:54:27 -1000
X-Gmail-Original-Message-ID: <CAHk-=wh0+DYC2+Aeu2=vfUtGaDqVuKxKrxyhwQFoG89rcynzww@mail.gmail.com>
Message-ID: <CAHk-=wh0+DYC2+Aeu2=vfUtGaDqVuKxKrxyhwQFoG89rcynzww@mail.gmail.com>
Subject: Linux 5.18-rc2
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

It's Sunday afternoon for me, which means "rc release time". Things
look fairly normal here, although it's early in the release cycle so
it's a bit hard to say for sure. But at least it's not looking
particularly odd, and we have fixes all over.

Drivers is the bulk of it, and there's a little bit of everything
here, although the AMD GPU driver fixes are perhaps the most
noticeable. But there's also networking, scsi, rdma, block, you name
it...

On the non-driver side, we've got a bump in the diffstat for the
static call infrastructure, but that's really just code movement. The
actual changes are more spread out than that bump would imply, and are
generally pretty small. There's some filesystem fixes, core
networking, and obviously the usual architecture work.

And as has been the case lately, there's the usual tooling updates -
selftests and perf.

Full shortlog appended, it's not exactly tiny, but it's easy enough to
scroll through to get a feel for what's been going on.

Testing appreciated as always,
            Linus

---

Adrian Hunter (2):
      scsi: ufs: ufs-pci: Add support for Intel MTL
      perf tools: Fix perf's libperf_print callback

Aharon Landau (2):
      RDMA/mlx5: Don't remove cache MRs when a delay is needed
      RDMA/mlx5: Add a missing update of cache->last_add

Akihiko Odaki (1):
      Revert "ACPI: processor: idle: Only flush cache on entering C3"

Alex Deucher (4):
      drm/amdgpu/gmc: use PCI BARs for APUs in passthrough
      drm/amdgpu: add more cases to noretry=3D1
      drm/amdgpu: don't use BACO for reset in S3
      drm/amdgpu/smu10: fix SoC/fclk units in auto mode

Alexey Galakhov (1):
      scsi: mvsas: Add PCI ID of RocketRaid 2640

Anatolii Gerasymenko (2):
      ice: Set txq_teid to ICE_INVAL_TEID on ring creation
      ice: Do not skip not enabled queues in ice_vc_dis_qs_msg

Andre Przywara (1):
      irqchip/gic, gic-v3: Prevent GSI to SGI translations

Andrea Parri (Microsoft) (3):
      Drivers: hv: vmbus: Deactivate sysctl_record_panic_msg by
default in isolated guests
      Drivers: hv: vmbus: Fix initialization of device object in
vmbus_device_register()
      Drivers: hv: vmbus: Replace smp_store_mb() with virt_store_mb()

Andrew Lunn (1):
      net: ethernet: mv643xx: Fix over zealous checking of_get_mac_address(=
)

Andrew Morton (1):
      mm/list_lru.c: revert "mm/list_lru: optimize
memcg_reparent_list_lru_node()"

Andy Chiu (4):
      net: axienet: setup mdio unconditionally
      net: axienet: factor out phy_node in struct axienet_local
      dt-bindings: net: add pcs-handle attribute
      net: axiemac: use a phandle to reference pcs_phy

Andy Gospodarek (1):
      bnxt_en: reserve space inside receive page for skb_shared_info

Arnaldo Carvalho de Melo (6):
      tools include UAPI: Sync linux/vhost.h with the kernel sources
      tools build: Use $(shell ) instead of `` to get embedded libperl's cc=
opts
      tools build: Filter out options and warnings not supported by clang
      perf python: Fix probing for some clang command line options
      perf build: Don't use -ffat-lto-objects in the python feature
test when building with clang-13
      tools headers arm64: Sync arm64's cputype.h with the kernel sources

Athira Rajeev (2):
      perf bench: Fix futex bench to correct usage of affinity for
machines with #CPUs > 1K
      perf bench: Fix epoll bench to correct usage of affinity for
machines with #CPUs > 1K

Aurabindo Pillai (1):
      drm/amd: Add USBC connector ID

Axel Lin (2):
      regulator: rtq2134: Fix missing active_discharge_on setting
      regulator: atc260x: Fix missing active_discharge_on setting

Axel Rasmussen (2):
      selftests: fix header dependency for pid_namespace selftests
      selftests: fix an unused variable warning in pidfd selftest

Benjamin Marty (1):
      drm/amdgpu/display: change pipe policy for DCN 2.1

Bjorn Helgaas (1):
      docs: net: dsa: fix minor grammar and punctuation issues

Boqun Feng (2):
      Drivers: hv: balloon: Support status report for larger page sizes
      Drivers: hv: balloon: Disable balloon and hot-add accordingly

Borislav Petkov (1):
      perf/imx_ddr: Fix undefined behavior due to shift overflowing the con=
stant

Boyuan Zhang (1):
      drm/amdgpu/vcn3: send smu interface type

CHANDAN VURDIGERE NATARAJ (1):
      drm/amd/display: Fix by adding FPU protection for
dcn30_internal_validate_bw

Catalin Marinas (1):
      arm64: mte: Fix the stack frame size warning in mte_dump_tag_range()

Chandrakanth patil (1):
      scsi: megaraid_sas: Target with invalid LUN ID is deleted during scan

Chanho Park (1):
      arm64: Add part number for Arm Cortex-A78AE

Charlene Liu (3):
      drm/amd/display: fix audio format not updated after edid updated
      drm/amd/display: remove destructive verify link for TMDS
      drm/amd/display: Clear optc false state when disable otg

Chen-Yu Tsai (1):
      net: stmmac: Fix unset max_speed difference between DT and
non-DT platforms

ChenXiaoSong (2):
      Revert "NFSv4: Handle the special Linux file open access mode"
      NFSv4: fix open failure with O_ACCMODE flag

Chengdong Li (1):
      perf test tsc: Fix error message when not supported

Chengming Zhou (4):
      perf/core: Don't pass task around when ctx sched in
      perf/core: Use perf_cgroup_info->active to check if cgroup is active
      perf/core: Fix perf_cgroup_switch()
      perf/core: Always set cpuctx cgrp when enable cgroup event

Chiawen Huang (1):
      drm/amd/display: FEC check in timing validation

Chris Park (1):
      drm/amd/display: Correct Slice reset calculation

Christian K=C3=B6nig (5):
      dma-buf: Add dma_fence_array_for_each (v2)
      dma-buf: add dma_fence_unwrap v2
      dma-buf/sync-file: fix warning about fence containers
      dma-buf/sync-file: fix logic error in new fence merge code
      dma-buf: handle empty dma_fence_arrays gracefully

Christian Lamparter (2):
      ata: sata_dwc_460ex: Fix crash due to OOB write
      ata: libata-core: Disable READ LOG DMA EXT for Samsung 840 EVOs

Christian L=C3=B6hle (1):
      mmc: block: Check for errors after write on SPI

Christoph B=C3=B6hmwalder (1):
      drbd: set QUEUE_FLAG_STABLE_WRITES

Christophe JAILLET (3):
      scsi: pmcraid: Remove the PMCRAID_PASSTHROUGH_IOCTL ioctl implementat=
ion
      scsi: zorro7xx: Fix a resource leak in zorro7xx_remove_one()
      spi: mxic: Fix an error handling path in mxic_spi_probe()

Christophe Leroy (4):
      powerpc/64: Fix build failure with allyesconfig in book3s_64_entry.S
      static_call: Don't make __static_call_return0 static
      static_call: Properly initialise DEFINE_STATIC_CALL_RET0()
      static_call: Remove __DEFINE_STATIC_CALL macro

Colin Ian King (4):
      scsi: isci: Fix spelling mistake "doesnt" -> "doesn't"
      scsi: bnx2fc: Fix spelling mistake "mis-match" -> "mismatch"
      scsi: bnx2i: Fix spelling mistake "mis-match" -> "mismatch"
      scsi: message: fusion: Remove redundant variable dmp

Damien Le Moal (4):
      scsi: mpt3sas: Fix use after free in _scsih_expander_node_remove()
      ata: libata-sff: Fix compilation warning in ata_sff_lost_interrupt()
      scsi: scsi_debug: Fix sdebug_blk_mq_poll() in_use_bm bitmap use
      scsi: mpt3sas: Fix mpt3sas_check_same_4gb_region() kdoc comment

Dan Carpenter (2):
      drm/amdgpu: fix off by one in amdgpu_gfx_kiq_acquire()
      scsi: hisi_sas: Remove stray fallthrough annotation

Dan Williams (2):
      tools/testing/nvdimm: Fix security_init() symbol collision
      cxl/pci: Drop shadowed variable

Daniel Latypov (1):
      Documentation: kunit: fix path to .kunitconfig in start.rst

Daniel Mack (1):
      drm/panel: ili9341: fix optional regulator handling

Darrick J. Wong (1):
      btrfs: fix fallocate to use file_modified to update permissions
consistently

Dave Hansen (1):
      x86/mm/tlb: Revert retpoline avoidance approach

David Ahern (1):
      ipv6: Fix stats accounting in ip6_pkt_drop

Delyan Kratunov (1):
      bpftool: Explicit errno handling in skeletons

Denis Nikitin (1):
      perf session: Remap buf if there is no space for event

Dennis Dalessandro (1):
      MAINTAINERS: Update qib and hfi1 related drivers

Dimitris Michailidis (1):
      net/fungible: Fix reference to __udivdi3 on 32b builds

Divya Shikre (1):
      drm/amdkfd: Check use_xgmi_p2p before reporting hive_id

Dmytro Laktyushkin (1):
      drm/amd/display: update dcn315 clock table read

Douglas Miller (1):
      RDMA/hfi1: Fix use-after-free bug for mm struct

Duoming Zhou (1):
      drivers: net: slip: fix NPD bug in sl_tx_timeout()

Emily Deng (1):
      drm/amdgpu/vcn: Fix the register setting for vcn1

Enze Li (1):
      cdrom: remove unused variable

Eric Bernstein (1):
      drm/amd/display: remove assert for odm transition case

Eric Dumazet (1):
      rxrpc: fix a race in rxrpc_exit_net()

Ethan Lien (1):
      btrfs: fix qgroup reserve overflow the qgroup limit

Eugene Syromiatnikov (1):
      io_uring: implement compat handling for IORING_REGISTER_IOWQ_AFF

Eyal Birger (1):
      vrf: fix packet sniffing for traffic originating from ip tunnels

Felix Kuehling (1):
      drm/amdgpu: set noretry=3D1 for GFX 10.3.4

Finn Thain (2):
      scsi: aha152x: Stop using struct scsi_pointer
      scsi: sym53c500_cs: Stop using struct scsi_pointer

Florian Westphal (1):
      net: ipv6mr: fix unused variable warning with CONFIG_IPV6_PIMSM_V2=3D=
n

Gabe Teeger (1):
      drm/amd/display: Add support for zstate during extended vblank

Geert Uytterhoeven (2):
      spi: rpc-if: Fix RPM imbalance in probe error path
      perf: MARVELL_CN10K_DDR_PMU should depend on ARCH_THUNDER

Geliang Tang (1):
      selftests: x86: add 32bit build warnings for SUSE

Greg Kroah-Hartman (2):
      powerpc/pseries/vas: use default_groups in kobj_type
      kobject: kobj_type: remove default_attrs

Guchun Chen (2):
      drm/amdgpu: prevent memory wipe in suspend/shutdown stage
      drm/amdgpu: conduct a proper cleanup of PDB bo

Guenter Roeck (2):
      staging: r8188eu: Fix PPPoE tag insertion on little endian systems
      habanalabs: Fix test build failures

Guilherme G. Piccoli (1):
      Drivers: hv: vmbus: Fix potential crash on module unload

Guo Ren (1):
      arm64: patch_text: Fixup last cpu should be master

Guo Xuenan (1):
      lz4: fix LZ4_decompress_safe_partial read out of bound

Guo Zhengkui (2):
      selftests/vDSO: fix array_size.cocci warning
      selftests/proc: fix array_size.cocci warning

Haowen Bai (1):
      selftests/bpf: Fix warning comparing pointer to 0

Horatiu Vultur (4):
      dt-bindings: net: micrel: Revert latency support and timestamping che=
ck
      net: phy: micrel: Remove latency from driver
      net: phy: micrel: Remove DT option lan8814,ignore-ts
      net: micrel: Fix KS8851 Kconfig

Ian Rogers (1):
      perf annotate: Drop objdump stderr to avoid getting stuck
waiting for stdout output

Ilya Maximets (2):
      net: openvswitch: don't send internal clone attribute to the userspac=
e.
      net: openvswitch: fix leak of nested actions

Ivan Vecera (3):
      ice: Clear default forwarding VSI during VSI release
      ice: Fix MAC address setting
      ice: Fix broken IFF_ALLMULTI handling

Jackie Liu (1):
      scsi: core: sysfs: Remove comments that conflict with the actual logi=
c

Jakob Koschel (1):
      cifs: remove check of list iterator against head past the loop body

James Clark (2):
      perf unwind: Don't show unwind error messages when augmenting
frame pointer stack
      perf: arm-spe: Fix perf report --mem-mode

James Smart (6):
      scsi: lpfc: Improve PCI EEH Error and Recovery Handling
      scsi: lpfc: Fix unload hang after back to back PCI EEH faults
      scsi: lpfc: Fix queue failures when recovering from PCI parity error
      scsi: lpfc: Update lpfc version to 14.2.0.1
      scsi: lpfc: Fix broken SLI4 abort path
      scsi: lpfc: Fix locking for lpfc_sli_iocbq_lookup()

Jamie Bainbridge (2):
      sctp: count singleton chunks in assoc user stats
      qede: confirm skb is allocated before using

Jan Varho (1):
      random: do not split fast init input in add_hwgenerator_randomness()

Jann Horn (1):
      random: check for signal_pending() outside of need_resched() check

Jason A. Donenfeld (3):
      random: opportunistically initialize on /dev/urandom reads
      random: do not allow user to keep crng key around on stack
      random: check for signals every PAGE_SIZE chunk of /dev/[u]random

Jason Gunthorpe (1):
      MAINTAINERS: Add Leon Romanovsky to RDMA maintainers

Jason Wang (2):
      vdpa: mlx5: prevent cvq work from hogging CPU
      vdpa: mlx5: synchronize driver status with CVQ

Jean-Philippe Brucker (1):
      skbuff: fix coalescing for page_pool fragment recycling

Jens Axboe (8):
      io_uring: don't check req->file in io_fsync_prep()
      io_uring: defer splice/tee file validity check until command issue
      io_uring: move read/write file prep state into actual opcode handler
      io_uring: propagate issue_flags state down to file assignment
      io_uring: defer file assignment
      io_uring: drop the old style inflight file tracking
      Revert "io_uring: Add support for napi_busy_poll"
      io_uring: fix race between timeout flush and removal

Jeremy Sowden (1):
      netfilter: bitwise: fix reduce comparisons

Jiasheng Jiang (1):
      drm/imx: imx-ldb: Check for null pointer after calling kmemdup

Jimmy Kizito (2):
      drm/amd/display: Add work around for AUX failure on wake.
      drm/amd/display: Add configuration options for AUX wake work around.

Jiri Olsa (1):
      bpf: Fix sparse warnings in kprobe_multi_resolve_syms

Jiri Slaby (1):
      tty: serial: mpc52xx_uart: make rx/tx hooks return unsigned, part II.

Joey Gouly (1):
      arm64: alternatives: mark patch_alternative() as `noinstr`

Johannes Thumshirn (2):
      btrfs: zoned: traverse devices under chunk_mutex in
btrfs_can_activate_zone
      btrfs: zoned: remove left over ASSERT checking for single profile

John Garry (1):
      scsi: core: Fix sbitmap depth in scsi_realloc_sdev_budget_map()

Jonathan Bakker (1):
      regulator: wm8994: Add an off-on delay for WM8994 variant

Josef Bacik (1):
      btrfs: do not warn for free space inode in cow_file_range

Jos=C3=A9 Exp=C3=B3sito (1):
      drm/imx: Fix memory leak in imx_pd_connector_get_modes

Julia Lawall (1):
      arm64: fix typos in comments

Kaiwen Hu (1):
      btrfs: prevent subvol with swapfile from being deleted

Kamal Dasu (1):
      spi: bcm-qspi: fix MSPI only access with bcm_qspi_exec_mem_op()

Kan Liang (6):
      perf/x86: Add Intel Raptor Lake support
      perf/x86/cstate: Add Raptor Lake support
      perf/x86/msr: Add Raptor Lake CPU support
      perf/x86/uncore: Add Raptor Lake uncore support
      perf/x86/intel: Don't extend the pseudo-encoding to GP counters
      perf/x86/intel: Update the FRONTEND MSR mask on Sapphire Rapids

Karol Herbst (1):
      drm/nouveau/pmu: Add missing callbacks for Tegra devices

Kees Cook (1):
      selftests/harness: Run TEARDOWN for ASSERT failures

Kefeng Wang (2):
      powerpc: Fix virt_addr_valid() for 64-bit Book3E & 32-bit
      Revert "powerpc: Set max_mapnr correctly"

Keoseong Park (1):
      scsi: ufs: core: Remove unused field in struct ufs_hba

Kevin Groeneveld (1):
      scsi: sr: Fix typo in CDROM(CLOSETRAY|EJECT) handling

Krzysztof Kozlowski (1):
      scsi: ufs: qcom: Drop custom Android boot parameters

Lang Yu (1):
      drm/amdgpu: add workarounds for VCN TMZ issue on CHIP_RAVEN

Lee Jones (1):
      drm/amdkfd: Create file descriptor after client is added to
smi_clients list

Leo (Hanghong) Ma (1):
      drm/amd/display: Update VTEM Infopacket definition

Leo Ruan (1):
      gpu: ipu-v3: Fix dev_dbg frequency output

Linus Torvalds (1):
      Linux 5.18-rc2

Liu Ying (1):
      drm/imx: dw_hdmi-imx: Fix bailout in error cases of probe

Lv Yunlong (1):
      drbd: Fix five use after free bugs in get_initial_state

Ma Jun (1):
      drm/amdgpu: Sync up header and implementation to use the same
parameter names

Maciej Fijalkowski (3):
      ice: synchronize_rcu() when terminating rings
      ice: xsk: fix VSI state check in ice_xsk_wakeup()
      ice: clear cmd_type_offset_bsz for TX rings

Manish Chopra (1):
      qed: fix ethtool register dump

Marc Zyngier (2):
      irqchip/gic-v4: Wait for GICR_VPENDBASER.Dirty to clear before
descheduling
      irqchip/gic-v3: Fix GICR_CTLR.RWP polling

Marcin Kozlowski (1):
      net: usb: aqc111: Fix out-of-bounds accesses in RX fixup

Marek Vasut (1):
      dt-bindings: display: panel: mipi-dbi-spi: Make
width-mm/height-mm mandatory

Mario Limonciello (1):
      ata: ahci: Rename CONFIG_SATA_LPM_POLICY configuration item back

Mark Zhang (1):
      IB/cm: Cancel mad on the DREQ event when the state is MRA_REP_RCVD

Martin Habets (1):
      sfc: Do not free an empty page_ring

Martin K. Petersen (1):
      scsi: sd: sd_read_cpr() requires VPD pages

Martin KaFai Lau (2):
      bpf: Resolve to prog->aux->dst_prog->type only for BPF_PROG_TYPE_EXT
      bpf: selftests: Test fentry tracing a struct_ops program

Martin Leung (1):
      drm/amd/display: Revert FEC check in validation

Masami Hiramatsu (1):
      rethook: Fix to use WRITE_ONCE() for rethook:: Handler

Matt Johnston (3):
      mctp: Fix check for dev_hard_header() result
      mctp i2c: correct mctp_i2c_header_create result
      mctp: Use output netdev to allocate skb headroom

Matthew Wilcox (Oracle) (5):
      mm/huge_memory: Avoid calling pmd_page() on a non-leaf PMD
      mm/migrate: Use a folio in alloc_migration_target()
      mm/migrate: Use a folio in migrate_misplaced_transhuge_page()
      mm: Add vma_alloc_folio()
      mm/mempolicy: Use vma_alloc_folio() in new_page()

Matthias Schiffer (1):
      spi: cadence-quadspi: fix protocol setup for non-1-1-X operations

Matti Vaittinen (1):
      MAINTAINERS: Fix reviewer info for a few ROHM ICs

Max Filippov (1):
      highmem: fix checks in __kmap_local_sched_{in,out}

Maxim Mikityanskiy (2):
      bpf: Support dual-stack sockets in bpf_tcp_check_syncookie
      bpf: Adjust bpf_tcp_check_syncookie selftest to test dual-stack socke=
ts

Maxime Ripard (1):
      dt-bindings: display: bridge: Drop requirement on input port for
DSI devices

Miaohe Lin (1):
      mm/mempolicy: fix mpol_new leak in shared_policy_replace

Miaoqian Lin (1):
      dpaa2-ptp: Fix refcount leak in dpaa2_ptp_probe

Michael Ellerman (1):
      KVM: PPC: Move kvmhv_on_pseries() into kvm_ppc.h

Michael Kelley (3):
      Drivers: hv: vmbus: Propagate VMbus coherence to each VMbus device
      PCI: hv: Propagate coherence from VMbus device to PCI device
      Drivers: hv: vmbus: Prevent load re-ordering when reading ring buffer

Michael Petlan (2):
      perf docs: Add perf-iostat link to manpages
      perf tools: Add external commands to list-cmds

Michael S. Tsirkin (2):
      Revert "virtio: use virtio_device_ready() in virtio_device_restore()"
      Revert "virtio_config: introduce a new .enable_cbs method"

Michael Walle (1):
      net: phy: mscc-miim: reject clause 45 register accesses

Michael Wu (1):
      mmc: core: Fixup support for writeback-cache for eMMC and SD

Muchun Song (1):
      NFSv4.2: Fix missing removal of SLAB_ACCOUNT on kmem_cache allocation

Namhyung Kim (1):
      perf/core: Inherit event_caps

NeilBrown (1):
      SUNRPC: handle malloc failure in ->request_prepare

Nicholas Kazlauskas (1):
      drm/amd/display: Fix p-state allow debug index on dcn31

Nicholas Piggin (4):
      KVM: PPC: Book3S HV P9: Fix "lost kick" race
      KVM: PPC: Book3S PR: Disable SCV when AIL could be disabled
      KVM: PPC: Book3S PR: Disallow AIL !=3D 0
      KVM: PPC: Use KVM_CAP_PPC_AIL_MODE_3

Nick Desaulniers (1):
      x86/extable: Prefer local labels in .set directives

Niels Dossche (1):
      IB/rdmavt: add lock to call to rvt_error_qp to prevent a race conditi=
on

Nikolay Aleksandrov (3):
      net: ipv4: fix route with nexthop object delete warning
      selftests: net: add delete nexthop route warning test
      selftests: net: fix nexthop warning cleanup double ip typo

Oliver Logush (1):
      drm/amd/display: Add fSMC_MSG_SetDtbClk support

Pali Roh=C3=A1r (1):
      Revert "mmc: sdhci-xenon: fix annoying 1.8V regulator warning"

Paolo Bonzini (1):
      mmmremap.c: avoid pointless invalidate_range_start/end on
mremap(old_size=3D0)

Paul Kocialkowski (1):
      drm: of: Properly try all possible cases for bridge/panel detection

Paulo Alcantara (2):
      cifs: fix potential race with cifsd thread
      cifs: force new session setup and tcon for dfs

Pavan Chebbi (1):
      bnxt_en: Synchronize tx when xdp redirects happen on same ring

Pavel Begunkov (4):
      io_uring: nospec index for tags on files update
      io_uring: don't touch scm_fp_list after queueing skb
      io_uring: zero tag on rsrc removal
      io_uring: use nospec annotation for more indexes

Pawan Gupta (2):
      x86/pm: Save the MSR validity status at context setup
      x86/speculation: Restore speculation related MSRs during S3 resume

Peter Zijlstra (5):
      sched/core: Fix forceidle balancing
      x86,static_call: Fix __static_call_return0 for i386
      objtool: Fix IBT tail-call detection
      objtool: Fix SLS validation for kcov tail-call replacement
      x86,bpf: Avoid IBT objtool warning

Phil Auld (1):
      arch/arm64: Fix topology initialization for core scheduling

Prike Liang (2):
      drm/amdgpu: set noretry for gfx 10.3.7
      drm/amdgpu/gfx10: enable gfx1037 clock counter retrieval function

QintaoShen (1):
      drm/amdkfd: Check for potential null return of kmalloc_array()

Qu Wenruo (2):
      btrfs: remove device item and update super block in the same transact=
ion
      btrfs: avoid defragging extents whose next extents are not targets

Rafael J. Wysocki (1):
      ACPI: bus: Eliminate acpi_bus_get_device()

Randy Dunlap (2):
      scsi: virtio-scsi: Eliminate anonymous module_init & module_exit
      net: micrel: fix KS8851_MLL Kconfig

Ray Jui (1):
      bnxt_en: Prevent XDP redirect from running when stopping TX queue

Reto Buerki (1):
      x86/msi: Fix msi message data shadow struct

Rodrigo Siqueira (1):
      drm/amd/display: Reduce stack size

Roman Li (3):
      drm/amd/display: Remove redundant dsc power gating from init_hw
      drm/amd/display: Enable power gating before init_pipes
      drm/amd/display: Fix allocate_mst_payload assert on resume

Ruili Ji (1):
      drm/amdgpu: fix incorrect GCR_GENERAL_CNTL address

Sebastian Andrzej Siewior (4):
      sched: Teach the forced-newidle balancer about CPU affinity limitatio=
n.
      x86/percpu: Remove volatile from arch_raw_cpu_ptr().
      Revert "locking/local_lock: Make the empty local_lock_*()
function a macro."
      Revert "mm/page_alloc: mark pagesets as __maybe_unused"

Shirish S (1):
      amd/display: set backlight only if required

Shreeya Patel (1):
      gpio: Restrict usage of GPIO chip irq members before initialization

Sreekanth Reddy (1):
      scsi: mpt3sas: Fail reset operation if config request timed out

Srikar Dronamraju (1):
      powerpc/numa: Handle partially initialized numa nodes

Stanley.Yang (1):
      drm/amdgpu/pm: add asic smu support check

Steve Capper (1):
      tlb: hugetlb: Add more sizes to tlb_remove_huge_tlb_entry

Steve French (1):
      cifs: update internal module number

Sven Schnelle (1):
      entry: Fix compile error in dynamic_irqentry_exit_cond_resched()

Taehee Yoo (2):
      net: sfc: add missing xdp queue reinitialization
      net: sfc: fix using uninitialized xdp tx_queue

Thomas Zimmermann (1):
      fbdev: Fix unregistering of framebuffers without device

Tianci Yin (1):
      drm/amdgpu/vcn: improve vcn dpg stop procedure

Tom Rix (3):
      scsi: aic7xxx: Use standard PCI subsystem, subdevice defines
      stmmac: dwmac-loongson: change loongson_dwmac_driver from global to s=
tatic
      MAINTAINERS: add Tom as clang reviewer

Tomas Henzl (1):
      scsi: core: scsi_logging: Fix a BUG

Tony Lindgren (1):
      iommu/omap: Fix regression in probe for NULL pointer dereference

Trond Myklebust (9):
      NFS: Replace readdir's use of xxhash() with hash_64()
      SUNRPC: Ensure we flush any closed sockets before xs_xprt_free()
      SUNRPC: Handle ENOMEM in call_transmit_status()
      SUNRPC: Handle low memory situations in call_status()
      NFSv4/pnfs: Handle RPC allocation errors in nfs4_proc_layoutget
      NFS: Ensure rpc_run_task() cannot fail in nfs_async_rename()
      SUNRPC: Handle allocation failure in rpc_new_task()
      SUNRPC: svc_tcp_sendmsg() should handle errors from xdr_alloc_bvec()
      SUNRPC: Move the call to xprt_send_pagedata() out of xprt_sock_sendms=
g()

Tushar Patel (1):
      drm/amdkfd: Fix Incorrect VMIDs passed to HWS

Tyrel Datwyler (1):
      scsi: ibmvscsis: Increase INITIAL_SRP_LIMIT to 1024

Vasily Averin (2):
      netfilter: nf_tables: memcg accounting for dynamically allocated obje=
cts
      mailmap: update Vasily Averin's email address

Vincent Mailhol (1):
      x86/bug: Prevent shadowing in __WARN_FLAGS

Vinod Koul (1):
      spi: core: add dma_map_dev for __spi_unmap_msg()

Vladimir Oltean (1):
      Revert "net: dsa: stop updating master MTU from master.c"

Waiman Long (1):
      mm/sparsemem: fix 'mem_section' will never be NULL gcc 12 warning

Wenchao Hao (2):
      scsi: libiscsi: Remove unnecessary memset() in iscsi_conn_setup()
      scsi: sd: Clean up gendisk if device_add_disk() failed

Will Deacon (1):
      Revert "arm64: Change elfcore for_each_mte_vma() to use VMA iterator"

Willem de Bruijn (1):
      selftests/harness: Pass variant to teardown

Wolfram Sang (3):
      mmc: renesas_sdhi: special 4tap settings only apply to HS400
      mmc: renesas_sdhi: don't overwrite TAP settings when HS400
tuning is complete
      mmc: core: improve API to make clear mmc_hw_reset is for cards

Xiaoguang Wang (1):
      scsi: target: tcmu: Fix possible page UAF

Xiaomeng Tong (4):
      perf: qcom_l2_pmu: fix an incorrect NULL check on list iterator
      myri10ge: fix an incorrect free for skb in myri10ge_sw_tso
      drbd: fix an invalid memory access caused by incorrect use of
list iterator
      scsi: ufs: ufshpb: Fix a NULL check on list iterator

Yang Yingliang (1):
      irqchip/irq-qcom-mpm: fix return value check in qcom_mpm_init()

Yann Gautier (1):
      mmc: mmci: stm32: correctly check all elements of sg list

Yifan Zhang (2):
      drm/amdgpu/pm: fix the Stable pstate Test in amdgpu_test
      drm/amdgpu: set noretry=3D1 for gc 10.3.6

YueHaibing (1):
      irq/qcom-mpm: Fix build error without MAILBOX

Zhiyuan Dai (1):
      arm64: Fix comments in macro __init_el2_gicv3

Zi Yan (1):
      mm: migrate: use thp_order instead of HPAGE_PMD_ORDER for new
page allocation.

Ziyang Xuan (1):
      net/tls: fix slab-out-of-bounds bug in decrypt_internal

tiancyin (1):
      drm/amd/vcn: fix an error msg on vcn 3.0

zhenwei pi (1):
      mm/rmap: Fix handling of hugetlbfs pages in page_vma_mapped_walk
