Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70E005A400F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 00:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiH1WfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 18:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiH1WfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 18:35:17 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54631409A
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 15:35:14 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id se27so4676759ejb.8
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 15:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc;
        bh=0JPMGKjnqyL4ix3kk/k3vkI9dGOcMAMx0nLqqSixFQs=;
        b=Rr4swHlhAHSfrjaxLByxX6h3/VBNba7TaHzMQtDJbc4Dpl7PPuSTo3cZRQIt1/obte
         3J/CpadAMasZkAvxB8cNDLIjPWcK+fb2KPY65hm+GRRXLIdpUWJUSvLYlDUQ1/yLdNa1
         1UvFzzCZZDg/prOtb6+hk0yUNWpwEWNwj0drs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc;
        bh=0JPMGKjnqyL4ix3kk/k3vkI9dGOcMAMx0nLqqSixFQs=;
        b=uJaZLulSWkgry5W5L+VtytL9C0wY8+YjEkVCz51zke0J0S2P3eAYv+CBLsCgThyjiv
         tWwHqprH3UkVqlU9oDz0bWqZjZevgOu3hcqdRdsU2CWO1f1WQ+qlA/f3wrbtatoZkgLz
         BzFjKUk4BjgnGnngszILwTIG7MaL6P29GvNF+f/zbjWo3L8hi2zYj29rbflYWAvecWNX
         rAZzPPhjxmRdKGKzvWwBphtT5zkaZ1WLAKUWxeJx4Rroq9MdRnMOXMjcPyMZIrDhpTFq
         8l3+IigRssjz4O+GSVz5nRYECGXFLGBeobRM7cnvLrtKqcu925lPb3mAfP31M4hVtrgp
         a8EQ==
X-Gm-Message-State: ACgBeo1wRuXbLq7jMrkNQSe2BZ33dJo/MwUIzTAG7TdEGVqDU99E0XZj
        o37KWldJaPhobCd4W/A5XZVxKaEiHVDbJ7HH
X-Google-Smtp-Source: AA6agR7p5yqvKiG8nSC/SSJ9G+irNm6/wbVGYD6U1NHQ00GiJidWJQz6pnehAZT1+4Ij/Ov0LSkz9w==
X-Received: by 2002:a17:907:f82:b0:73d:afe4:c89 with SMTP id kb2-20020a1709070f8200b0073dafe40c89mr11659202ejc.534.1661726112789;
        Sun, 28 Aug 2022 15:35:12 -0700 (PDT)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id r10-20020a170906c28a00b0073d60922edfsm3686790ejz.102.2022.08.28.15.35.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Aug 2022 15:35:12 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id v16so5377146wrm.8
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 15:35:12 -0700 (PDT)
X-Received: by 2002:a5d:6045:0:b0:226:d21d:947b with SMTP id
 j5-20020a5d6045000000b00226d21d947bmr4096496wrt.274.1661726111693; Sun, 28
 Aug 2022 15:35:11 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 28 Aug 2022 15:34:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=whaiqzB6a_daUpvGyDg-cvkXKwwfjwPKV4HQRcci+8BeA@mail.gmail.com>
Message-ID: <CAHk-=whaiqzB6a_daUpvGyDg-cvkXKwwfjwPKV4HQRcci+8BeA@mail.gmail.com>
Subject: Linux 6.0-rc3
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

So as some people already noticed, last week was an anniversary week -
31 years since the original Linux development announcement. How time
flies.

But this is not that kind of historic email - it's just the regular
weekly RC release announcement, and things look pretty normal. We've
got various fixes all over the tree, in all the usual places: drivers
(networking, fbdev, drm), architectures (a bit of everythinig: x86,
loongarch, arm64, parisc, s390 and RISC-V), filesystems (mostly btrfs
and cifs, minor things elsewhere), and core kernel code (networking,
vm, vfs and cgroup).

And some tooling support (perf and selftests).

We've got a few known issues brewing, but nothing that looks all that
scary. Knock wood.

Please give it a go,

               Linus

---

Aleksander Jan Bajkowski (3):
      net: lantiq_xrx200: confirm skb is allocated before using
      net: lantiq_xrx200: fix lock under memory pressure
      net: lantiq_xrx200: restore buffer if memory allocation failed

Alex Elder (1):
      net: ipa: don't assume SMEM is page-aligned

Alex Williamson (1):
      mm: re-allow pinning of zero pfns (again)

Alim Akhtar (1):
      scsi: ufs: host: ufs-exynos: Make fsd_ufs_drvs static

Ammar Faizi (2):
      MAINTAINERS: Add `include/linux/io_uring_types.h`
      io_uring: uapi: Add `extern "C"` in io_uring.h for liburing

Anand Jain (2):
      btrfs: replace: drop assert for suspended replace
      btrfs: add info when mount fails due to stale replace target

Andi Kleen (1):
      perf record: Fix manpage formatting of description of support to
hybrid systems

Andy Shevchenko (1):
      firmware: dmi: Use the proper accessor for the version field

Antony Antony (3):
      Revert "xfrm: update SA curlft.use_time"
      xfrm: fix XFRMA_LASTUSED comment
      xfrm: clone missing x->lastused in xfrm_do_migrate

Arnaldo Carvalho de Melo (1):
      tools kvm headers arm64: Update KVM header from the kernel sources

Axel Rasmussen (1):
      selftests/vm: fix inability to build any vm tests

Aya Levin (1):
      net/mlx5e: Fix wrong application of the LRO state

Badari Pulavarty (1):
      mm/damon/dbgfs: avoid duplicate context directory creation

Bart Van Assche (3):
      scsi: ufs: core: Reduce the power mode change timeout
      scsi: sd: Revert "Rework asynchronous resume support"
      md/raid10: Fix the data type of an r10_sync_page_io() argument

Bernard Pidoux (1):
      rose: check NULL rose_loopback_neigh->loopback

Borislav Petkov (1):
      x86/sev: Mark snp_abort() noreturn

Brian Bunker (1):
      scsi: core: Allow the ALUA transitioning state enough time

Brian Foster (1):
      s390: fix double free of GS and RI CBs on fork() failure

Candice Li (1):
      drm/amdgpu: Check num_gfx_rings for gfx v9_0 rb setup.

Chen Zhongjin (1):
      x86/unwind/orc: Unwind ftrace trampolines with correct ORC entry

Christian Brauner (3):
      acl: handle idmapped mounts for idmapped filesystems
      MAINTAINERS: update idmapping tree
      ntfs: fix acl handling

Colin Ian King (1):
      mailmap: update email address for Colin King

Conor Dooley (6):
      riscv: signal: fix missing prototype warning
      riscv: traps: add missing prototype
      riscv: dts: microchip: mpfs: fix incorrect pcie child node name
      riscv: dts: microchip: mpfs: remove ti,fifo-depth property
      riscv: dts: microchip: mpfs: remove bogus card-detect-delay
      riscv: dts: microchip: mpfs: remove pci axi address translation prope=
rty

Cs=C3=B3k=C3=A1s Bence (1):
      fec: Restart PPS after link state change

Dan Carpenter (5):
      get_maintainer: add Alan to .get_maintainer.ignore
      net/mlx5: unlock on error path in esw_vfs_changed_event_handler()
      net/mlx5e: kTLS, Use _safe() iterator in mlx5e_tls_priv_tx_list_clean=
up()
      net/mlx5e: Fix use after free in mlx5e_fs_init()
      net/mlx5: Unlock on error in mlx5_sriov_enable()

Daniel Lezcano (2):
      thermal/core: Add missing EXPORT_SYMBOL_GPL
      dt-bindings: thermal: Fix missing required property

David Gow (2):
      mmc: sdhci-of-aspeed: test: Fix dependencies when KUNIT=3Dm
      module: kunit: Load .kunit_test_suites section when CONFIG_KUNIT=3Dm

David Hildenbrand (3):
      mm/gup: fix FOLL_FORCE COW security issue and remove FOLL_COW
      mm/hugetlb: fix hugetlb not supporting softdirty tracking
      mm/hugetlb: support write-faults in shared mappings

David Howells (4):
      locks: Fix dropped call to ->fl_release_private()
      smb3: missing inode locks in zero range
      smb3: missing inode locks in punch hole
      rxrpc: Fix locking in rxrpc's sendmsg

David Sloan (1):
      md: Flush workqueue md_rdev_misc_wq in md_alloc()

Duoming Zhou (1):
      nfc: pn533: Fix use-after-free bugs caused by pn532_cmd_timeout

Eli Cohen (2):
      net/mlx5: LAG, fix logic over MLX5_LAG_FLAG_NDEVS_READY
      net/mlx5: Eswitch, Fix forwarding decision to uplink

Eric Dumazet (1):
      netfilter: nf_defrag_ipv6: allow nf_conntrack_frag6_high_thresh incre=
ases

Evan Quan (1):
      drm/amd/pm: update SMU 13.0.0 driver_if header

Filipe Manana (2):
      btrfs: update generation of hole file extent item when merging holes
      btrfs: fix silent failure when deleting root reference

Florian Westphal (3):
      netfilter: ebtables: reject blobs that don't provide all entry points
      netfilter: conntrack: work around exceeded receive window
      netfilter: nft_tproxy: restrict to prerouting hook

Gaosheng Cui (1):
      audit: fix potential double free on error path from
fsnotify_add_inode_mark

Gerald Schaefer (1):
      s390/mm: do not trigger write fault when vma does not allow VM_WRITE

Goldwyn Rodrigues (1):
      btrfs: check if root is readonly while setting security xattr

Guilherme G. Piccoli (1):
      mailmap: update Guilherme G. Piccoli's email addresses

Guixin Liu (2):
      scsi: megaraid_sas: Fix double kfree()
      scsi: megaraid_sas: Remove unnecessary kfree()

Guoqing Jiang (2):
      Revert "md-raid: destroy the bitmap after destroying the thread"
      md: call __md_stop_writes in md_stop

Hao Jia (3):
      sched/psi: Zero the memory of struct psi_group
      sched/psi: Remove unused parameter nbytes of psi_trigger_create()
      sched/psi: Remove redundant cgroup_psi() when !CONFIG_CGROUPS

Hao Lee (1):
      mm: add DEVICE_ZONE to FOR_ALL_ZONES

Hayes Wang (2):
      r8152: fix the units of some registers for RTL8156A
      r8152: fix the RX FIFO settings when suspending

Heiner Kallweit (1):
      net: stmmac: work around sporadic tx issue on link-up

Heinrich Schuchardt (1):
      riscv: dts: microchip: correct L2 cache interrupts

Helge Deller (4):
      parisc: Fix exception handler for fldw and fstw instructions
      parisc: Make CONFIG_64BIT available for ARCH=3Dparisc64 only
      Revert "parisc: Show error if wrong 32/64-bit compiler is being used"
      parisc: Add runtime check to prevent PA2.0 kernels on PA1.x machines

Heming Zhao (1):
      ocfs2: fix freeing uninitialized resource on ocfs2_dlm_shutdown

Herbert Xu (1):
      af_key: Do not call xfrm_probe_algs in parallel

Huacai Chen (6):
      LoongArch: Select PCI_QUIRKS to avoid build error
      LoongArch: Fix build warnings in VDSO
      LoongArch: Cleanup reset routines with new API
      LoongArch: Cleanup headers to avoid circular dependency
      LoongArch: Add subword xchg/cmpxchg emulation
      LoongArch: mm: Avoid unnecessary page fault retires on shared memory =
types

Hugh Dickins (3):
      mm/shmem: fix chattr fsflags support in tmpfs
      mm/shmem: tmpfs fallocate use file_modified()
      mm/shmem: shmem_replace_page() remember NR_SHMEM

Ian Rogers (3):
      perf stat: Clear evsel->reset_group for each stat run
      perf test: Stat test for repeat with a weak group
      perf sched: Fix memory leaks in __cmd_record detected with
-fsanitize=3Daddress

Ionela Voinescu (1):
      arm64: errata: add detection for AMEVCNTR01 incrementing incorrectly

Jacob Keller (1):
      ixgbe: stop resetting SYSTIME in ixgbe_ptp_start_cyclecounter

James Clark (1):
      perf python: Fix build when PYTHON_CONFIG is user supplied

Jan Beulich (1):
      x86/PAT: Have pat_enabled() properly reflect state when running on Xe=
n

Jason Wang (1):
      parisc: ccio-dma: Fix typo in comment

Jeffy Chen (1):
      drm/gem: Fix GEM handle release errors

Jens Axboe (1):
      io_uring: fix off-by-one in sync cancelation file check

Jiapeng Chong (3):
      fbdev: sisfb: Clean up some inconsistent indenting
      fbdev: radeon: Clean up some inconsistent indenting
      fbdev: omap: Remove unnecessary print function dev_err()

Jilin Yuan (1):
      fbdev: ssd1307fb: Fix repeated words in comments

Jing-Ting Wu (1):
      cgroup: Fix race condition at rebind_subsystems()

Jiri Slaby (1):
      Revert "zram: remove double compression logic"

Jonathan Toppins (3):
      selftests: include bonding tests into the kselftest infra
      bonding: 802.3ad: fix no transmission of LACPDUs
      bonding: 3ad: make ad_ticks_per_sec a const

Josef Bacik (1):
      btrfs: don't allow large NOWAIT direct reads

Juergen Gross (2):
      x86/entry: Fix entry_INT80_compat for Xen PV guests
      xen/privcmd: fix error exit of privcmd_ioctl_dm_op()

Kan Liang (3):
      perf/x86/lbr: Enable the branch type for the Arch LBR by default
      perf/x86/intel: Fix pebs event constraints for ADL
      perf docs: Update the documentation for the save_type filter

Kanchan Joshi (1):
      io_uring: fix submission-failure handling for uring-cmd

Karol Herbst (1):
      nouveau: explicitly wait on the fence in nouveau_bo_move_m2mf

Khazhismel Kumykov (1):
      writeback: avoid use-after-free after removing device

Kiwoong Kim (1):
      scsi: ufs: core: Enable link lost interrupt

Kristen Carlson Accardi (1):
      selftests/sgx: Ignore OpenSSL 3.0 deprecated functions warning

Kuan-Ying Lee (1):
      arm64: Fix comment typo

Kuniyuki Iwashima (18):
      kprobes: don't call disarm_kprobe() for disabled kprobes
      net: Fix data-races around sysctl_[rw]mem_(max|default).
      net: Fix data-races around weight_p and dev_weight_[rt]x_bias.
      net: Fix data-races around netdev_max_backlog.
      net: Fix data-races around netdev_tstamp_prequeue.
      ratelimit: Fix data-races in ___ratelimit().
      net: Fix data-races around sysctl_optmem_max.
      net: Fix a data-race around sysctl_tstamp_allow_data.
      net: Fix a data-race around sysctl_net_busy_poll.
      net: Fix a data-race around sysctl_net_busy_read.
      net: Fix a data-race around netdev_budget.
      net: Fix data-races around sysctl_max_skb_frags.
      net: Fix a data-race around netdev_budget_usecs.
      net: Fix data-races around sysctl_fb_tunnels_only_for_init_net.
      net: Fix data-races around sysctl_devconf_inherit_init_net.
      net: Fix a data-race around gro_normal_batch.
      net: Fix a data-race around netdev_unregister_timeout_secs.
      net: Fix a data-race around sysctl_somaxconn.

Lee, Chun-Yi (1):
      thermal/int340x_thermal: handle data_vault when the value is ZERO_SIZ=
E_PTR

Letu Ren (1):
      fbdev: fb_pm2fb: Avoid potential divide by zero error

Li Qiong (1):
      parisc: ccio-dma: Handle kmalloc failure in ccio_init_resources()

Liam Howlett (1):
      binder_alloc: add missing mmap_lock calls when using the VMA

Likun Gao (1):
      drm/amdgpu: add MGCG perfmon setting for gfx11

Linus Torvalds (1):
      Linux 6.0-rc3

Liu Shixin (1):
      bootmem: remove the vmemmap pages from kmemleak in put_page_bootmem

Lorenzo Bianconi (1):
      net: ethernet: mtk_eth_soc: fix hw hash reporting for MTK_NETSYS_V2

Luca Ceresoli (1):
      .mailmap: update Luca Ceresoli's e-mail address

Lukas Bulwahn (3):
      arm64: adjust KASLR relocation after ARCH_RANDOM removal
      MAINTAINERS: rectify file entry in BONDING DRIVER
      xen: x86: remove setting the obsolete config XEN_MAX_DOMAIN_MEMORY

Lukasz Luba (1):
      cpufreq: check only freq_table in __resolve_freq()

Maciej Fijalkowski (2):
      ice: xsk: prohibit usage of non-balanced queue id
      ice: xsk: use Rx ring's XDP ring when picking NAPI context

Maciej =C5=BBenczykowski (1):
      net: ipvtap - add __init/__exit annotations to module init/exit funcs

Maor Dickman (1):
      net/mlx5e: Fix wrong tc flag used when set hw-tc-offload off

Mark Brown (7):
      arm64/sysreg: Directly include bitfield.h
      arm64/sysreg: Guard SYS_FIELD_ macros for asm
      arm64/cache: Fix cache_type_cwg() for register generation
      arm64/signal: Raise limit on stack frames
      arm64/signal: Flush FPSIMD register state when disabling streaming mo=
de
      arm64/sme: Don't flush SVE register state when allocating SME storage
      arm64/sme: Don't flush SVE register state when handling SME traps

Mark Rutland (1):
      arm64: fix rodata=3Dfull

Martin Li=C5=A1ka (1):
      docs/arm64: elf_hwcaps: unify newlines in HWCAP lists

Matthew Wilcox (Oracle) (1):
      shmem: update folio if shmem_replace_page() updates the page

Maxime Ripard (2):
      drm/vc4: hdmi: Depends on CONFIG_PM
      drm/vc4: hdmi: Rework power up

Ma=C3=ADra Canal (1):
      drm/amd/display: Include missing header

Miaohe Lin (1):
      mm/hugetlb: avoid corrupting page->mapping in hugetlb_mcopy_atomic_pt=
e

Michael Roth (1):
      x86/boot: Don't propagate uninitialized boot_params->cc_blob_address

Mike Christie (1):
      scsi: core: Fix passthrough retry counter handling

Mikulas Patocka (2):
      wait_on_bit: add an acquire memory barrier
      provide arch_test_bit_acquire for architectures that define test_bit

Moshe Shemesh (1):
      net/mlx5: Avoid false positive lockdep warning by adding lock_class_k=
ey

Mukul Joshi (1):
      drm/amdgpu: Fix page table setup on Arcturus

NeilBrown (1):
      NFS: unlink/rmdir shouldn't call d_delete() twice on ENOENT

Nikolay Aleksandrov (1):
      xfrm: policy: fix metadata dst->dev xmit null pointer dereference

Olga Kornievskaia (1):
      NFSv4.2 fix problems with __nfs42_ssc_open

Omar Sandoval (1):
      btrfs: fix space cache corruption and potential double allocations

Pablo Neira Ayuso (10):
      netfilter: nf_tables: disallow updates of implicit chain
      netfilter: nf_tables: make table handle allocation per-netns friendly
      netfilter: nft_payload: report ERANGE for too long offset and length
      netfilter: nft_payload: do not truncate csum_offset and csum_type
      netfilter: nf_tables: do not leave chain stats enabled on error
      netfilter: nft_osf: restrict osf to ipv4, ipv6 and inet families
      netfilter: nft_tunnel: restrict it to netdev family
      netfilter: nf_tables: disallow binding to already bound chain
      netfilter: flowtable: add function to invoke garbage collection
immediately
      netfilter: flowtable: fix stuck flows on cleanup due to pending work

Paulo Alcantara (1):
      cifs: skip extra NULL byte in filenames

Pavan Chebbi (1):
      bnxt_en: Use PAGE_SIZE to init buffer when multi buffer XDP is not in=
 use

Pavel Begunkov (6):
      io_uring/net: fix must_hold annotation
      io_uring/net: fix zc send link failing
      io_uring/net: fix indentation
      io_uring/notif: order notif vs send CQEs
      io_uring: conditional ->async_data allocation
      io_uring/net: save address for sendzc async execution

Pawan Gupta (1):
      x86/bugs: Add "unknown" reporting for MMIO Stale Data

Peter Xu (3):
      mm/smaps: don't access young/dirty bit if pte unpresent
      mm/uffd: reset write protection when unregister with wp-mode
      mm/mprotect: only reference swap pfn page if type match

Peter Zijlstra (3):
      x86/nospec: Unwreck the RSB stuffing
      x86/nospec: Fix i386 RSB stuffing
      perf/x86/core: Set pebs_capable and PMU_FL_PEBS_ALL for the Baseline

Phillip Lougher (1):
      squashfs: don't call kmalloc in decompressors

Prike Liang (1):
      drm/amdkfd: Fix isa version for the GC 10.3.7

Qu Huang (1):
      drm/amdgpu: mmVM_L2_CNTL3 register not initialized correctly

Qu Wenruo (1):
      btrfs: don't merge pages into bio if their page offset is not contigu=
ous

Quanyang Wang (1):
      asm-generic: sections: refactor memory_intersects

R Mohamed Shah (1):
      ionic: VF initial random MAC address if no assigned mac

Randy Dunlap (1):
      kernel/sys_ni: add compat entry for fadvise64_64

Richard Guy Briggs (1):
      audit: move audit_return_fixup before the filters

Riwen Lu (1):
      ACPI: processor: Remove freq Qos request for all CPUs

Roi Dayan (1):
      net/mlx5e: TC, Add missing policer validation

Roman Li (1):
      drm/amd/display: enable PCON support for dcn314

Roy Novich (1):
      net/mlx5: Fix cmd error logging for manage pages cmd

Sabrina Dubroca (1):
      Revert "net: macsec: update SCI upon MAC address change."

Sakari Ailus (2):
      ACPI: property: Ignore already existing data node tags
      ACPI: property: Remove default association from integer maximum value=
s

Salvatore Bonaccorso (1):
      Documentation/ABI: Mention retbleed vulnerability info file for sysfs

Sander Vanheule (5):
      lib/test_cpumask: drop cpu_possible_mask full test
      lib/test_cpumask: fix cpu_possible_mask last test
      lib/test_cpumask: follow KUnit style guidelines
      lib/cpumask_kunit: log mask contents
      lib/cpumask_kunit: add tests file to MAINTAINERS

Saurabh Sengar (1):
      scsi: storvsc: Remove WQ_MEM_RECLAIM from storvsc_error_wq

Sean Anderson (1):
      net: dpaa: Fix <1G ethernet on LS1046ARDB

Sergei Antonov (1):
      net: moxa: get rid of asymmetry in DMA mapping/unmapping

Sergey Senozhatsky (1):
      mm/zsmalloc: do not attempt to free IS_ERR handle

Seth Forshee (1):
      fs: require CAP_SYS_ADMIN in target namespace for idmapped mounts

Shakeel Butt (1):
      Revert "memcg: cleanup racy sum avoidance code"

Shannon Nelson (2):
      ionic: clear broken state on generation change
      ionic: fix up issues with handling EAGAIN on FW cmds

Shigeru Yoshida (2):
      fbdev: fbcon: Destroy mutex on freeing struct fb_info
      fbdev: fbcon: Properly revert changes when vc_resize() failed

Siddh Raman Pant (1):
      loop: Check for overflow while configuring loop

Stefan Binding (1):
      ACPI: property: Fix type detection of unified integer reading functio=
ns

Stefan Roesch (1):
      fs: __file_remove_privs(): restore call to inode_has_no_xattr()

Stephane Eranian (2):
      perf/x86/intel/ds: Fix precise store latency handling
      perf/x86/intel/uncore: Fix broken read_counter() for SNB IMC PMU

Stephen Brennan (1):
      vmcoreinfo: add kallsyms_num_syms symbol

Sudeep Holla (1):
      arm64: cacheinfo: Fix incorrect assignment of signed error value
to unsigned fw_level

Sun Ke (1):
      NFS: Fix missing unlock in nfs_unlink()

Sylwester Dziedziuch (1):
      i40e: Fix incorrect address type for IPv6 flow rules

Tejun Heo (1):
      cgroup: Fix threadgroup_rwsem <-> cpus_read_lock() deadlock

Tetsuo Handa (1):
      cgroup: Add missing cpus_read_lock() to cgroup_attach_task_all()

Tim Huang (5):
      drm/amdgpu: enable GFXOFF allow control for GC IP v11.0.1
      drm/amdgpu: add TX_POWER_CTRL_1 macro definitions for NBIO IP v7.7.0
      drm/amdgpu: add NBIO IP v7.7.0 Clock Gating support
      drm/amdgpu: enable NBIO IP v7.7.0 Clock Gating
      drm/amdgpu: add sdma instance check for gfx11 CGCG

Tom Lendacky (1):
      x86/sev: Don't use cc_platform_has() for early SEV-SNP calls

Tony Battersby (1):
      scsi: qla2xxx: Disable ATIO interrupt coalesce for quad port ISP27XX

Tony Luck (1):
      x86/cpu: Add new Raptor Lake CPU model number

Trond Myklebust (4):
      NFS: Fix another fsync() issue after a server reboot
      NFS: Remove a bogus flag setting in pnfs_write_done_resend_to_mds
      NFS: Cleanup to remove unused flag NFS_CONTEXT_RESEND_WRITES
      SUNRPC: RPC level errors should set task->tk_rpc_status

Vikas Gupta (3):
      bnxt_en: set missing reload flag in devlink features
      bnxt_en: fix NQ resource accounting during vf creation on 57500 chips
      bnxt_en: fix LRO/GRO_HW features in ndo_fix_features callback

Vlad Buslov (2):
      net/mlx5e: Properly disable vlan strip on non-UL reps
      net/mlx5: Disable irq when locking lag_lock

Vladimir Oltean (3):
      net: dsa: microchip: keep compatibility with device tree blobs
with no phy-mode
      net: dsa: don't dereference NULL extack in dsa_slave_changeupper()
      net: dsa: microchip: make learning configurable and keep it off
while standalone

Wang Jingjin (1):
      ftrace: Fix build warning for ops_references_rec() not used

Wolfram Sang (3):
      parisc: led: Move from strlcpy with unused retval to strscpy
      fbdev: Move fbdev drivers from strlcpy to strscpy
      xen: move from strlcpy with unused retval to strscpy

Xiaolei Wang (1):
      net: phy: Don't WARN for PHY_READY state in mdio_bus_phy_resume()

Xin Xiong (1):
      xfrm: fix refcount leak in __xfrm_policy_check()

Yang Jihong (1):
      perf tools: Fix compile error for x86

Yang Yingliang (2):
      net: neigh: don't call kfree_skb() under spin_lock_irqsave()
      fbdev: chipsfb: Add missing pci_disable_device() in chipsfb_pci_init(=
)

YiPeng Chai (2):
      drm/amdgpu: Move psp_xgmi_terminate call from
amdgpu_xgmi_remove_device to psp_hw_fini
      drm/amdgpu: fix hive reference leak when adding xgmi device

Yu Kuai (1):
      blk-mq: fix io hung due to missing commit_rqs

Yu Zhe (1):
      fbdev: omapfb: Fix tests for platform_get_irq() failure

Zenghui Yu (1):
      arm64: Fix match_list for erratum 1286807 on Arm Cortex-A76

Zhang Xiaoxu (3):
      cifs: Use help macro to get the header preamble size
      cifs: Use help macro to get the mid header size
      cifs: Add helper function to check smb1+ server

Zhengjun Xing (1):
      perf stat: Capitalize topdown metrics' names

Zhenneng Li (1):
      drm/radeon: add a force flush to delay work when radeon

Zixuan Fu (1):
      btrfs: fix possible memory leak in btrfs_get_dev_args_from_path()

lily (1):
      net/core/skbuff: Check the return value of skb_copy_bits()

shaoyunl (1):
      drm/amdgpu: Remove the additional kfd pre reset call for sriov
