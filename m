Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF21259B71D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 02:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbiHVAy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 20:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbiHVAyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 20:54:25 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CAE0205DF
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 17:54:23 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id vw19so4686203ejb.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 17:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc;
        bh=yH4/SsdTHFtTHwFCnJax3T9m4hVNrEZIJk6Ide+2dw8=;
        b=MNAJa7+hjNZZK80p9fllLvUgCebCYP1PPn7ttXFGFJNJexhEbVnxF5GwE+8zkwKyTr
         GmbgSC4s9CF7zSlnbqsh8LNYSHB62eanuuPDq2APFwZzHZDGAKQ9WpLRg5m0vFExOIN3
         3PSd6sRJLcVDVjQ2g0u2duXSc7a7FCQRYevSo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc;
        bh=yH4/SsdTHFtTHwFCnJax3T9m4hVNrEZIJk6Ide+2dw8=;
        b=EHWBc0Svq2Xdff3ow9H7H2RynX21WgKfqdzsw4DqgZJvVgcctsUPozKHhLf4JlS8o2
         2yEfa5LB4qUtafRAoRxztwpvT9V27h1Z0V5bRmcUZNq7+LxiesSj+2c9uWfsGhskNtrf
         PtOtm303q1Nr1DsmyG0YkJhQKBuGWkNlquUp1k7RGYf5TyNxDrwQ8PSOgqceHR1jmTUU
         +1clBPoQyMicvSvDmxAlytKJRw7ZXBsp+NG7mTRq8lxiR7pGSR4YL/C7Doo0ZQePapPF
         Tr4PtKIAyTkSJkHgDfwlxyn9jkvpeTlNG5/S8ZxPC7VUQwVe3nxKwWcV9hWQbay4FLJj
         8WlA==
X-Gm-Message-State: ACgBeo34ALE5tHCQd/n9Snwoe5kQsh7zOXZ6OAS+sbjz7YTpfiZbc08W
        pjkclueRiMMzmx8fHgftDBjU5kLn2K8/N0v8
X-Google-Smtp-Source: AA6agR7GVpT7dp6YgN28ls5HkrCltcVUWhzWZQUK9xUkQ+3ZANsBE+4Bz2Jx84y7e1txmTOt+l/brg==
X-Received: by 2002:a17:907:87b0:b0:731:36ab:3223 with SMTP id qv48-20020a17090787b000b0073136ab3223mr11245924ejc.715.1661129661305;
        Sun, 21 Aug 2022 17:54:21 -0700 (PDT)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com. [209.85.128.49])
        by smtp.gmail.com with ESMTPSA id o23-20020a50fd97000000b00445f2dc2901sm7223405edt.21.2022.08.21.17.54.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Aug 2022 17:54:20 -0700 (PDT)
Received: by mail-wm1-f49.google.com with SMTP id m10-20020a05600c3b0a00b003a603fc3f81so5204819wms.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 17:54:20 -0700 (PDT)
X-Received: by 2002:a05:600c:4ece:b0:3a6:28:bc59 with SMTP id
 g14-20020a05600c4ece00b003a60028bc59mr13758068wmq.154.1661129660105; Sun, 21
 Aug 2022 17:54:20 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 21 Aug 2022 17:54:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj_XDfMiVXuo6A98KF4MsXxtyuMP_OtOGw87xnKERcfAg@mail.gmail.com>
Message-ID: <CAHk-=wj_XDfMiVXuo6A98KF4MsXxtyuMP_OtOGw87xnKERcfAg@mail.gmail.com>
Subject: Linux 6.0-rc2
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_ABUSE_SURBL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's Sunday afternoon (ok,early evening, just randomly doing this a
bit later than usual), and there's a new rc out.

Nothing particularly interesting here, rc2 tends to be fairly calm
with people taking a breather and not yet having found a lot of bugs.

The most noticeable fix in here is likely the virtio reverts that
fixed the problem people had with running tests on the google cloud
VMs, which was the "pending issue" that we had noticed just as the
merge window was closing. And it's noticeable - and notable - mainly
because that problem then kept people from running some of the
automated tests and thus finding other issues.

But obviously there's a lot of other things in here too, as per the
appended shortlog. The diffs are somewhat dominated by the amd gpu
fixes - they missed the "drm fixes" pull during the merge window, so
there were a bunch of fixes pending on that side.  But there's some
network driver fixes, some filesystem fixes (btrfs and a late ntfs3
half-fixes-half-updates pull), and the usual set of architecture fixes
and other core code (mainly networking).

And some tooling fixes - a mix of selftests and perf.

Go forth and test,

              Linus

---

Aaron Lu (1):
      x86/mm: Use proper mask when setting PUD mapping

Al Viro (6):
      nios2: page fault et.al. are *not* restartable syscalls...
      nios2: don't leave NULLs in sys_call_table[]
      nios2: traced syscall does need to check the syscall number
      nios2: fix syscall restart checks
      nios2: restarts apply only to the first sigframe we build...
      nios2: add force_successful_syscall_return()

Alan Brady (1):
      i40e: Fix to stop tx_timeout recovery if GLOBR fails

Alex Deucher (1):
      drm/amdgpu: Only disable prefer_shadow on hawaii

Alexander Mikhalitsyn (1):
      neighbour: make proxy_queue.qlen limit per-device

Alexandre Vicenzi (1):
      rtla: Fix tracer name

Alvin Lee (8):
      drm/amd/display: Add a variable to update FCLK latency
      drm/amd/display: Revert "attempt to fix the logic in
commit_planes_for_stream()"
      drm/amd/display: For stereo keep "FLIP_ANY_FRAME"
      drm/amd/display: Don't try to enter MALL SS if stereo3d
      drm/amd/display: Add 16 lines margin for SubVP
      drm/amd/display: Don't set DSC for phantom pipes
      drm/amd/display: Use pitch when calculating size to cache in MALL
      drm/amd/display: Include scaling factor for SubVP command

Amadeusz S=C5=82awi=C5=84ski (1):
      ALSA: info: Fix llseek return value when using callback

Amit Cohen (4):
      mlxsw: spectrum_ptp: Fix compilation warnings
      mlxsw: spectrum: Clear PTP configuration after unregistering the netd=
evice
      mlxsw: spectrum_ptp: Protect PTP configuration with a mutex
      mlxsw: spectrum_ptp: Forbid PTP enablement only in RX or in TX

Andrew Donnellan (1):
      gcc-plugins: Undefine LATENT_ENTROPY_PLUGIN when plugin disabled
for a file

Andrew Jones (1):
      riscv: Ensure isa-ext static keys are writable

Andrey Strachuk (1):
      drm/amdgpu: remove useless condition in
amdgpu_job_stop_all_jobs_on_sched()

Aric Cyr (2):
      drm/amd/display: 3.2.197
      drm/amd/display: 3.2.198

Arnaldo Carvalho de Melo (10):
      perf beauty: Update copy of linux/socket.h with the kernel sources
      tools arch x86: Sync the msr-index.h copy with the kernel sources
      tools headers UAPI: Sync linux/fscrypt.h with the kernel sources
      tools headers cpufeatures: Sync with the kernel sources
      tools headers UAPI: Sync drm/i915_drm.h with the kernel sources
      tools headers UAPI: Sync linux/kvm.h with the kernel sources
      tools headers kvm s390: Sync headers with the kernel sources
      tools include UAPI: Sync linux/vhost.h with the kernel sources
      tools headers UAPI: Sync KVM's vmx.h header with the kernel sources
      tools headers UAPI: Sync x86's asm/kvm.h with the kernel sources

Arun Ramadoss (1):
      net: dsa: microchip: ksz9477: fix fdb_dump last invalid entry

Arunpravin Paneer Selvam (1):
      drm/ttm: Fix dummy res NULL ptr deref bug

Atte Heikkil=C3=A4 (1):
      ksmbd: request update to stale share config

Aurabindo Pillai (4):
      drm/amd/display: Add a missing register field for HPO DP stream encod=
er
      drm/amd/display: fix CAB allocation for multiple displays
      drm/amd/display: Check correct bounds for stream encoder
instances for DCN303
      drm/amd/display: Enable SubVP by default on DCN32 & DCN321

Ben Hutchings (2):
      tools/rtla: Fix command symlinks
      tools/rtla: Build with EXTRA_{C,LD}FLAGS

Benjamin Mikailenko (2):
      ice: Fix VSI rebuild WARN_ON check for VF
      ice: Ignore error message when setting same promiscuous mode

Biju Das (1):
      ASoC: sh: rz-ssi: Improve error handling in rz_ssi_probe() error path

Chaitanya Dhere (1):
      drm/amd/display: Modify header inclusion pattern

Chao Peng (2):
      KVM: Rename KVM_PRIVATE_MEM_SLOTS to KVM_INTERNAL_MEM_SLOTS
      KVM: Rename mmu_notifier_* to mmu_invalidate_*

Charlene Liu (1):
      drm/amd/display: avoid doing vm_init multiple time

Cheng Xu (2):
      RDMA/erdma: Using the key in FMR WR instead of MR structure
      RDMA/erdma: Correct the max_qp and max_cq capacities of the device

Chiawen Huang (1):
      drm/amd/display: Device flash garbage before get in OS

Chris Wilson (5):
      drm/i915/gt: Ignore TLB invalidations on idle engines
      drm/i915/gt: Invalidate TLB of the OA unit at TLB invalidations
      drm/i915/gt: Skip TLB invalidations once wedged
      drm/i915/gt: Batch TLB invalidations
      drm/i915/gem: Remove shared locking on freeing objects

Christoffer Sandberg (1):
      ALSA: hda/realtek: Add quirk for Clevo NS50PU, NS70PU

Christophe JAILLET (6):
      fs/ntfs3: Remove a useless test
      irqchip/loongson-liointc: Fix an error handling path in liointc_init(=
)
      mmc: pxamci: Fix an error handling path in pxamci_probe()
      mmc: pxamci: Fix another error handling path in pxamci_probe()
      mmc: meson-gx: Fix an error handling path in meson_mmc_probe()
      stmmac: intel: Add a missing clk_disable_unprepare() call in
intel_eth_pci_remove()

Colin Ian King (3):
      fs/ntfs3: Remove redundant assignment to variable frame
      fs/ntfs3: Remove redundant assignment to variable vcn
      fs/ntfs3: Remove duplicated assignment to variable r

Cong Wang (4):
      tcp: fix sock skb accounting in tcp_read_skb()
      tcp: fix tcp_cleanup_rbuf() for tcp_read_skb()
      tcp: refactor tcp_read_skb() a bit
      tcp: handle pure FIN case correctly

Conor Dooley (1):
      perf: riscv legacy: fix kerneldoc comment warning

Cs=C3=B3k=C3=A1s Bence (1):
      fec: Fix timer capture timing in `fec_ptp_enable_pps()`

Damien Le Moal (1):
      ata: libata-eh: Add missing command name

Dan Carpenter (4):
      fs/ntfs3: Don't clear upper bits accidentally in log_replay()
      fs/ntfs3: Unlock on error in attr_insert_range()
      fs/ntfs3: uninitialized variable in ntfs_set_acl_ex()
      drm/amdkfd: potential crash in kfd_create_indirect_link_prop()

Daniel Miess (3):
      drm/amd/display: Use pixels per container logic for DCN314 DCCG divid=
ers
      drm/amd/display: Fix TMDS 4K@60Hz YCbCr420 corruption issue
      drm/amd/display: Add debug parameter to retain default clock table

Daniel Phillips (2):
      drm/amdgpu: Remove rounding from vram allocation path
      drm/amdgpu: Pessimistic availability based on rounded up allocations

David Galiffi (2):
      drm/amd/display: Allow alternate prefetch modes in DML for DCN32
      drm/amd/display: Fix Compile-time Warning

David Howells (1):
      net: Fix suspicious RCU usage in bpf_sk_reuseport_detach()

David Jander (1):
      spi: spi.c: Add missing __percpu annotations in users of spi_statisti=
cs

Denis V. Lunev (1):
      neigh: fix possible DoS due to net iface start/stop loop

Douglas Anderson (1):
      regulator: core: Fix missing error return from regulator_bulk_get()

Duncan Ma (2):
      drm/amd/display: Fix VPG instancing for dcn314 HPO
      drm/amd/display: Correct DTBCLK for dcn314

Dusica Milinkovic (1):
      drm/amdgpu: Increase tlb flush timeout for sriov

Enzo Matsumiya (2):
      cifs: remove unused server parameter from calc_smb_size()
      cifs: remove useless parameter 'is_fsctl' from SMB2_ioctl()

Ethan Wellenreiter (1):
      drm/amd/display: reverted limiting vscsdp_for_colorimetry and
ARGB16161616 pixel format addition

Evan Quan (4):
      drm/amd/pm: add 3715 softpptable support for SMU13.0.0
      drm/amdgpu: disable 3DCGCG/CGLS temporarily due to stability issue
      drm/amd/pm: add missing ->fini_microcode interface for Sienna Cichlid
      drm/amd/pm: add missing ->fini_xxxx interfaces for some SMU13 asics

Fabio M. De Francesco (1):
      exec: Replace kmap{,_atomic}() with kmap_local_page()

Felix Kuehling (2):
      drm/amdkfd: Handle restart of kfd_ioctl_wait_events
      drm/amdkfd: Fix mm reference in SVM eviction worker

Filipe Manana (2):
      btrfs: fix lost error handling when looking up extended ref on log re=
play
      btrfs: fix warning during log replay when bumping inode link count

Florian Westphal (8):
      netfilter: nf_ct_sane: remove pseudo skb linearization
      netfilter: nf_ct_h323: cap packet size at 64k
      netfilter: nf_ct_ftp: prefer skb_linearize
      netfilter: nf_ct_irc: cap packet search space to 4k
      netfilter: nf_tables: fix scheduling-while-atomic splat
      netfilter: nfnetlink: re-enable conntrack expectation events
      testing: selftests: nft_flowtable.sh: use random netns names
      testing: selftests: nft_flowtable.sh: rework test to detect
offload failure

Frieder Schrempf (1):
      regulator: pca9450: Remove restrictions for regulator-name

Fudong Wang (1):
      drm/amd/display: clear optc underflow before turn off odm clock

Geert Uytterhoeven (2):
      netfilter: conntrack: NF_CONNTRACK_PROCFS should no longer default to=
 y
      dt-bindings: Fix incorrect "the the" corrections

Grzegorz Siwik (3):
      ice: Fix double VLAN error when entering promisc mode
      ice: Ignore EEXIST when setting promisc mode
      ice: Fix clearing of promisc mode with bridge over bond

Guillaume Tucker (1):
      selftests/landlock: fix broken include of linux/landlock.h

Guru Das Srinagesh (1):
      scripts/clang-tools: Remove DeprecatedOrUnsafeBufferHandling check

Harald Freudenberger (1):
      s390/ap: fix crash on older machines based on QCI info missing

Harish Kasiviswanathan (1):
      drm/amdgpu: Add decode_iv_ts helper for ih_v6 block

Hector Martin (1):
      locking/atomic: Make test_and_*_bit() ordered on failure

Hongbin Wang (1):
      ip6_tunnel: Fix the type of functions

Huacai Chen (3):
      irqchip/loongson-eiointc: Fix irq affinity setting
      irqchip/loongson-eiointc: Fix a build warning
      irqchip/loongson-pch-pic: Move find_pch_pic() into CONFIG_ACPI

Hyunchul Lee (1):
      ksmbd: remove unnecessary generic_fillattr in smb2_open

Ian Chen (1):
      drm/amd/display: Add reserved dc_log_type.

Ian Rogers (4):
      perf cpumap: Const map for max()
      perf cpumap: Synthetic events and const/static
      perf cpumap: Compute mask size in constant time
      perf cpumap: Fix alignment for masks in event encoding

Ilya Bakoulin (1):
      drm/amd/display: Fix pixel clock programming

Ivan Vecera (1):
      iavf: Fix deadlock in initialization

Jakub Kicinski (2):
      tls: rx: react to strparser initialization errors
      net: genl: fix error path memory leak in policy dumping

Jamal Hadi Salim (1):
      net_sched: cls_route: disallow handle of 0

Jason Gunthorpe (1):
      RDMA: Handle the return code from dma_resv_wait_timeout() properly

Jason Wang (3):
      net: ipa: Fix comment typo
      bnx2x: Fix comment typo
      net: cxgb3: Fix comment typo

Jens Wiklander (1):
      tee: add overflow check in register_shm_helper()

Jiapeng Chong (1):
      fs/ntfs3: Remove unused function wnd_bits

Jilin Yuan (1):
      skfp/h: fix repeated words in comments

Jiri Slaby (1):
      kbuild: dummy-tools: pretend we understand __LONG_DOUBLE_128__

John Garry (1):
      ata: libata: Set __ATA_BASE_SHT max_sectors

Josef Bacik (4):
      btrfs: reset RO counter on block group if we fail to relocate
      btrfs: move lockdep class helpers to locking.c
      btrfs: fix lockdep splat with reloc root extent buffers
      btrfs: tree-checker: check for overlapping extent items

Joseph Greathouse (1):
      drm/amdgpu: Enable translate_further to extend UTCL2 reach

Josh Poimboeuf (3):
      x86/ibt, objtool: Add IBT_NOSEAL()
      x86/kvm: Simplify FOP_SETCC()
      x86/kvm: Fix "missing ENDBR" BUG for fastop functions

Josip Pavic (2):
      drm/amd/display: Avoid MPC infinite loop
      drm/amd/display: do not compare integers of different widths

Juergen Gross (1):
      s390/hypfs: avoid error message under KVM

Justin Stitt (1):
      ASoC: SOF: ipc3-topology: Fix clang -Wformat warning

Karol Herbst (1):
      drm/nouveau: recognise GA103

Kees Cook (1):
      LoadPin: Return EFAULT on copy_from_user() failures

Kenneth Feng (3):
      drm/amd/pm: skip pptable override for smu_v13_0_7
      drm/amd/amdgpu: add ih cg and hdp sd on smu_v13_0_7
      drm/amd/pm: add mode1 support on smu_v13_0_7

Khalid Masum (1):
      drm/amdgpu/vcn: Return void from the stop_dbg_mode

Konstantin Komarov (26):
      fs/ntfs3: Refactoring of indx_find function
      fs/ntfs3: Fix double free on remount
      fs/ntfs3: Refactor ni_try_remove_attr_list function
      fs/ntfs3: Fix missing i_op in ntfs_read_mft
      fs/ntfs3: Add missing error check
      fs/ntfs3: Fallocate (FALLOC_FL_INSERT_RANGE) implementation
      fs/ntfs3: Enable FALLOC_FL_INSERT_RANGE
      fs/ntfs3: Do not change mode if ntfs_set_ea failed
      fs/ntfs3: Check reserved size for maximum allowed
      fs/ntfs3: extend ni_insert_nonresident to return inserted ATTR_LIST_E=
NTRY
      fs/ntfs3: Make ntfs_fallocate return -ENOSPC instead of -EFBIG
      fs/ntfs3: Fix work with fragmented xattr
      fs/ntfs3: Fix very fragmented case in attr_punch_hole
      fs/ntfs3: Remove unused mi_mark_free
      fs/ntfs3: Add new argument is_mft to ntfs_mark_rec_free
      fs/ntfs3: Make static function attr_load_runs
      fs/ntfs3: Fill duplicate info in ni_add_name
      fs/ntfs3: Added comments to frecord functions
      fs/ntfs3: Check possible errors in run_pack in advance
      fs/ntfs3: Make MFT zone less fragmented
      fs/ntfs3: New function ntfs_bad_inode
      fs/ntfs3: Refactoring attr_set_size to restore after errors
      fs/ntfs3: Refactoring attr_punch_hole to restore after errors
      fs/ntfs3: Refactoring attr_insert_range to restore after errors
      fs/ntfs3: Create MFT zone only if length is large enough
      fs/ntfs3: Make ni_ins_new_attr return error

Krzysztof Kozlowski (1):
      spi: dt-bindings: Drop Pratyush Yadav

Laurentiu Palcu (1):
      drm/imx/dcss: get rid of HPD warning message

Leo Ma (1):
      drm/amd/display: Fix HDMI VSIF V3 incorrect issue

Leon Romanovsky (1):
      net/mlx5e: Allocate flow steering storage during uplink initializatio=
n

Li Qiong (1):
      net: lan966x: fix checking for return value of platform_get_irq_bynam=
e()

Li kunyu (3):
      fs/ntfs3: Remove unnecessary 'NULL' values from pointers
      KVM: Drop unnecessary initialization of "npages" in hva_to_pfn_slow()
      KVM: Drop unnecessary initialization of "ops" in kvm_ioctl_create_dev=
ice()

Liang He (1):
      drm/meson: Fix refcount bugs in meson_vpu_has_available_connectors()

Lijo Lazar (1):
      drm/amdgpu: Avoid another list of reset devices

Likun Gao (1):
      drm/amdgpu: change vram width algorithm for vram_info v3_0

Liming Sun (1):
      mmc: sdhci-of-dwcmshc: Re-enable support for the BlueField-3 SoC

Lin Ma (1):
      igb: Add lock to avoid data race

Linus Torvalds (3):
      x86: simplify load_unaligned_zeropad() implementation
      dcache: move the DCACHE_OP_COMPARE case out of the __d_lookup_rcu loo=
p
      Linux 6.0-rc2

Lorenzo Bianconi (1):
      net: ethernet: mtk_eth_soc: fix possible NULL pointer
dereference in mtk_xdp_run

Lucas Tanure (1):
      platform/x86: serial-multi-instantiate: Add CLSA0101 Laptop

Lukas Bulwahn (2):
      MAINTAINERS: rectify entry for ARM/HPE GXP ARCHITECTURE
      tracing: React to error return from traceprobe_parse_event_name()

Ma Jun (1):
      drm/amdgpu: Remove redundant reference of header file

Magali Lemes (4):
      drm/amd/display: remove DML Makefile duplicate lines
      drm/amd/display: make variables static
      drm/amd/display: remove header from source file
      drm/amd/display: include missing headers

Marc Zyngier (1):
      irqchip/loongarch: Fix irq_domain_alloc_fwnode() abuse

Marek Vasut (1):
      drm/bridge: lvds-codec: Fix error checking of
drm_of_lvds_get_data_mapping()

Mark Bloch (1):
      RDMA/mlx5: Use the proper number of ports

Martin Povi=C5=A1er (4):
      ASoC: tas2770: Set correct FSYNC polarity
      ASoC: tas2770: Allow mono streams
      ASoC: tas2770: Drop conflicting set_bias_level power setting
      ASoC: tas2770: Fix handling of mute/unmute

Masahiro Yamada (2):
      modpost: fix module versioning when a symbol lacks valid CRC
      kbuild: fix the modules order between drivers and libs

Matthew Auld (1):
      drm/i915/ttm: don't leak the ccs state

Mauro Carvalho Chehab (1):
      drm/i915: pass a pointer for tlb seqno at vma_invalidate_tlb()

Maxim Kochetkov (1):
      net: qrtr: start MHI channel after endpoit creation

Ma=C3=ADra Canal (1):
      drm/amdgpu: Fix use-after-free on amdgpu_bo_list mutex

Meenakshikumar Somasundaram (1):
      drm/amd/display: Fix TDR eDP and USB4 display light up issue

Melissa Wen (1):
      drm/amd/display: set panel orientation before drm_dev_register

Michael Ellerman (1):
      powerpc/pci: Fix get_phb_number() locking

Michael Kelley (1):
      iommu/hyper-v: Use helper instead of directly accessing affinity

Michael S. Tsirkin (7):
      virtio_net: fix endian-ness for RSS
      virtio_net: Revert "virtio_net: set the default max ring size by
find_vqs()"
      virtio: Revert "virtio: add helper virtio_find_vqs_ctx_size()"
      virtio-mmio: Revert "virtio_mmio: support the arg sizes of find_vqs()=
"
      virtio_pci: Revert "virtio_pci: support the arg sizes of find_vqs()"
      virtio_vdpa: Revert "virtio_vdpa: support the arg sizes of find_vqs()=
"
      virtio: Revert "virtio: find_vqs() add arg sizes"

Michal Jaron (1):
      ice: Fix call trace with null VSI during VF reset

Michel D=C3=A4nzer (1):
      Revert "drm/amd/amdgpu: add pipe1 hardware support"

Mikulas Patocka (1):
      rds: add missing barrier to release_refill

Mukul Joshi (1):
      drm/amdgpu: Fix interrupt handling on ih_soft ring

Nadav Amit (1):
      x86/kprobes: Fix JNG/JNLE emulation

Namhyung Kim (4):
      tools headers UAPI: Sync linux/perf_event.h with the kernel sources
      libperf: Handle read format in perf_evsel__read()
      libperf: Add a test case for read formats
      perf tools: Support reading PERF_FORMAT_LOST

Namjae Jeon (2):
      ksmbd: return STATUS_BAD_NETWORK_NAME error status if share is
not configured
      ksmbd: don't remove dos attribute xattr on O_TRUNC open

Nathan Chancellor (1):
      scripts/Makefile.extrawarn: Do not disable clang's -Wformat-zero-leng=
th

Neil Armstrong (1):
      spi: meson-spicc: add local pow2 clock ops to preserve rate
between messages

Nicholas Kazlauskas (1):
      drm/amd/display: Update clock table policy for DCN314

Nick Desaulniers (1):
      asm goto: eradicate CC_HAS_ASM_GOTO

Nirmoy Das (1):
      drm/i915: disable pci resize on 32-bit machine

Oder Chiou (1):
      ASoC: rt5640: Fix the JD voltage dropping issue

Oliver Upton (2):
      KVM: arm64: Treat PMCR_EL1.LC as RES1 on asymmetric systems
      KVM: arm64: Reject 32bit user PSTATE on asymmetric systems

Pablo Neira Ayuso (8):
      netfilter: nf_tables: use READ_ONCE and WRITE_ONCE for shared
generation id access
      netfilter: nf_tables: disallow NFTA_SET_ELEM_KEY_END with
NFT_SET_ELEM_INTERVAL_END flag
      netfilter: nf_tables: possible module reference underflow in error pa=
th
      netfilter: nf_tables: really skip inactive sets when allocating name
      netfilter: nf_tables: validate NFTA_SET_ELEM_OBJREF based on
NFT_SET_OBJECT flag
      netfilter: nf_tables: NFTA_SET_ELEM_KEY_END requires concat and
interval flags
      netfilter: nf_tables: disallow NFT_SET_ELEM_CATCHALL and
NFT_SET_ELEM_INTERVAL_END
      netfilter: nf_tables: check NFT_SET_CONCAT flag if field_count
is specified

Paolo Bonzini (1):
      KVM: MIPS: remove unnecessary definition of KVM_PRIVATE_MEM_SLOTS

Pavel Begunkov (4):
      io_uring/net: use right helpers for async recycle
      io_uring/net: improve zc addr import error handling
      io_uring/notif: raise limit on notification slots
      io_uring/net: use right helpers for async_data

Pavel Skripkin (2):
      fs/ntfs3: Fix NULL deref in ntfs_update_mftmirr
      fs/ntfs3: Make ntfs_update_mftmirr return void

Philipp Zabel (1):
      ASoC: codec: tlv320aic32x4: fix mono playback via I2S

Pierre-Louis Bossart (1):
      ASoC: Intel: fix sof_es8336 probe

Potnuri Bharat Teja (1):
      RDMA/cxgb4: fix accept failure due to increased
cpl_t5_pass_accept_rpl size

Przemyslaw Patynowski (4):
      iavf: Fix adminq error handling
      iavf: Fix NULL pointer dereference in iavf_get_link_ksettings
      iavf: Fix reset error handling
      i40e: Fix tunnel checksum offload with fragmented traffic

Rajneesh Bhardwaj (1):
      drm/amdgpu: Avoid direct cast to amdgpu_ttm_tt

Ricardo Ca=C3=B1uelo (1):
      virtio: kerneldocs fixes and enhancements

Rodrigo Siqueira (7):
      Revert "drm/amd/display: reduce stack for dml32_CalculatePrefetchSche=
dule"
      Revert "drm/amd/display: reduce stack for
dml32_CalculateWatermarksMALLUseAndDRAMSpeedChangeSupport"
      Revert "drm/amd/display: reduce stack for dml32_CalculateVMRowAndSwat=
h"
      Revert "drm/amd/display: reduce stack for
dml32_CalculateSwathAndDETConfiguration"
      drm/amd/display: Create FPU files for DCN314
      drm/amd/display: Move populate dml pipes from DCN314 to dml
      drm/amd/display: Drop FPU flags from Makefile

Russell Currey (1):
      selftests/powerpc: Add missing PMU selftests to .gitignores

Rustam Subkhankulov (1):
      net: dsa: sja1105: fix buffer overflow in sja1105_setup_devlink_regio=
ns()

Samson Tam (1):
      drm/amd/display: add chip revision to DCN32

Samuel Holland (2):
      dt-bindings: display: sun4i: Add D1 TCONs to conditionals
      drm/sun4i: dsi: Prevent underflow when computing packet sizes

Sander Vanheule (3):
      cpumask: align signatures of UP implementations
      lib/cpumask: add inline cpumask_next_wrap() for UP
      lib/cpumask: drop always-true preprocessor guard

Sean Christopherson (3):
      KVM: Properly unwind VM creation if creating debugfs fails
      KVM: Unconditionally get a ref to /dev/kvm module when creating a VM
      KVM: Move coalesced MMIO initialization (back) into kvm_create_vm()

Sebin Sebastian (1):
      drm/amdgpu: double free error and freeing uninitialized null pointer

Sergei Antonov (3):
      net: dsa: mv88e6060: prevent crash on an unused port
      net: moxa: pass pdev instead of ndev to DMA functions
      net: moxa: MAC address reading, generating, validity checking

Sergey Gorenko (1):
      IB/iser: Fix login with authentication

Shane Xiao (1):
      drm/amdgpu: Add secure display TA load for Renoir

Stefan Binding (3):
      ALSA: hda/realtek: Add quirks for ASUS Zenbooks using CS35L41
      ALSA: hda: cs35l41: Clarify support for CSC3551 without _DSD Properti=
es
      ALSA: hda/cs8409: Support new Dolphin Variants

Steve French (1):
      cifs: missing directory in MAINTAINERS file

Steven Rostedt (Google) (8):
      rtla: Consolidate and show all necessary libraries that failed
for building
      tracing/perf: Fix double put of trace event when init fails
      tracing/eprobes: Do not allow eprobes to use $stack, or % for regs
      tracing/eprobes: Do not hardcode $comm as a string
      tracing/eprobes: Fix reading of string fields
      tracing/eprobes: Have event probes be consistent with kprobes and upr=
obes
      tracing/probes: Have kprobes and uprobes use $COMM too
      tracing: Have filter accept "common_cpu" to be consistent

Sylwester Dziedziuch (1):
      ice: Fix VF not able to send tagged traffic with no VLAN filters

Takashi Iwai (5):
      ASoC: Intel: avs: Fix potential buffer overflow by snprintf()
      ASoC: SOF: debug: Fix potential buffer overflow by snprintf()
      ASoC: SOF: Intel: hda: Fix potential buffer overflow by snprintf()
      ASoC: DPCM: Don't pick up BE without substream
      ALSA: hda/realtek: Add quirk for Lenovo Yoga7 14IAL7

Tim Huang (15):
      drm/amdgpu: add GFX Clock Gating support for GC IP v11.0.1
      drm/amdgpu: enable GFX Clock Gating control for GC IP v11.0.1
      drm/amdgpu/pm: update smu driver interface header for SMU IP v13.0.4
      drm/amdgpu/pm: remove EnableGfxOff message for SMU IP v13.0.4
      drm/amdgpu: enable GFX Power Gating for GC IP v11.0.1
      drm/amdgpu: add GFX Power Gating support for GC IP v11.0.1
      drm/amd/pm: update the smu driver interface version for SMU IP v13.0.=
4
      drm/amdgpu: add MMHUB IP v3.0.1 Clock Gating support
      drm/amdgpu: add HDP IP v5.2.1 Clock Gating support
      drm/amdgpu: add ATHUB IP v3.0.1 Clock Gating support
      drm/amdgpu: enable MMHUB IP v3.0.1 Clock Gating
      drm/amdgpu: enable HDP IP v5.2.1 Clock Gating
      drm/amdgpu: enable ATHUB IP v3.0.1 Clock Gating
      drm/amdgpu: enable IH Clock Gating for OSS IP v6.0.1
      drm/amd/pm: Enable GFXOFF feature for SMU IP v13.0.4

Timur Tabi (1):
      drm/nouveau: fix another off-by-one in nvbios_addr

Tom Chung (1):
      drm/amd/display: Fix plug/unplug external monitor will hang
while playback MPO video

Uwe Kleine-K=C3=B6nig (1):
      i2c: imx: Make sure to unregister adapter on remove()

Vladimir Oltean (9):
      net: dsa: don't warn in dsa_port_set_state_now() when driver
doesn't support it
      net: dsa: felix: fix ethtool 256-511 and 512-1023 TX packet counters
      net: mscc: ocelot: fix incorrect ndo_get_stats64 packet counters
      net: mscc: ocelot: fix address of SYS_COUNT_TX_AGING counter
      net: mscc: ocelot: turn stats_lock into a spinlock
      net: mscc: ocelot: fix race between ndo_get_stats64 and
ocelot_check_stats_work
      net: mscc: ocelot: make struct ocelot_stat_layout array indexable
      net: mscc: ocelot: keep ocelot_stat_layout by reg address, not offset
      net: mscc: ocelot: report ndo_get_stats64 from the
wraparound-resistant ocelot->stats

Wenbin Mei (1):
      mmc: mtk-sd: Clear interrupts when cqe off/disable

Wolfram Sang (2):
      cifs: move from strlcpy with unused retval to strscpy
      Revert "i2c: scmi: Replace open coded device_get_match_data()"

Xin Xiong (2):
      net/sunrpc: fix potential memory leaks in rpc_sysfs_xprt_state_change=
()
      net: fix potential refcount leak in ndisc_router_discovery()

Yan Lei (1):
      fs/ntfs3: Fix using uninitialized value n when calling indx_read

Yang Jihong (1):
      ftrace: Fix NULL pointer dereference in is_ftrace_trampoline
when ftrace is dead

Yang Xu (1):
      fs/ntfs3: Use the same order for acl pointer check in ntfs_init_acl

Yang Yingliang (1):
      KVM: arm64: Fix compile error due to sign extension

Yifan Zhang (2):
      drm/amd/display: change family id name for DCN314
      drm/amdkfd: reserve 2 queues for sdma 6.0.1 in bitmap

Yu Kuai (1):
      blk-mq: remove unused function blk_mq_queue_stopped()

Yufen Yu (1):
      blk-mq: run queue no matter whether the request is the last request

Zhang Xiaoxu (1):
      cifs: Fix memory leak on the deferred close

Zhen Ni (2):
      drm/amd/pm: Fix a potential gpu_metrics_table memory leak
      drm/amd/pm: Fix a potential gpu_metrics_table memory leak

Zhengchao Shao (2):
      net: rtnetlink: fix module reference count leak issue in rtnetlink_rc=
v_msg
      net: sched: fix misuse of qcpu->backlog in gnet_stats_add_queue_cpu

Zixuan Fu (1):
      btrfs: unset reloc control if transaction commit fails in
prepare_to_relocate()

ZiyangZhang (4):
      ublk_drv: update iod->addr for UBLK_IO_NEED_GET_DATA
      ublk_drv: check ubq_daemon_is_dying() in __ublk_rq_task_work()
      ublk_drv: update comment for __ublk_fail_req()
      ublk_drv: do not add a re-issued request aborted previously to
ioucmd's task_work

syed sabakareem (1):
      ASoC: amd: yc: Update DMI table entries for AMD platforms
