Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 694CF550CFE
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 22:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236981AbiFSUiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 16:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiFSUir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 16:38:47 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEBF6E78
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 13:38:45 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id fd6so9773859edb.5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 13:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=XYibrci/JEMWZz3n6gUSBndL5rbGxA/V+jY5Ny+Yzgo=;
        b=IM1fMNUokfj/mL09l5nKPF43V27sWPfBXTDP2kxU70E0Oa9XRNmhG6iCGEi34BU8vV
         72p1O1evvrth0bpzwXHEIlnNgwgCl/OiZMDwggHCH6CTNJeqgr6Bw07GCPZTfZQg+tQm
         1q6lcQHn2zxXoGO0Llcr+CdatNbYTom6v/9Bo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=XYibrci/JEMWZz3n6gUSBndL5rbGxA/V+jY5Ny+Yzgo=;
        b=GS8DW/KDyS2aHJryYz6sWcxJBsXTMmaizcj07yA1X4gw5ub/ZzO7W0q4w3q93ubqFU
         R3XPaSLbxSVXUFcFZLjfTZ2v5rjSSlhWubRwBDTZNzovDuUxeSXUm8nNmPEh6UytFgRM
         +67vFblEcCuD7bXBeg3dS+OwGh6lWlw8SDlaj+7rT0p6KL5nYH+AT8Vc/b6fbetYo9Xm
         kBt07G1/rTSsLf65DCmbROS4R69I2LscH40mvNPFPcuncMuAjIZE4ERcoKArk32dETie
         gkq6+I/C2lMTuaa0hY/0h3jWYyoYH2rug+9D26gsizAuXMEuyJjVoEMrxBAFhuuWclVg
         bwgQ==
X-Gm-Message-State: AJIora8LhEhoyyW8wBAFmGJG7OY4yH9Oeqj7AVukrpsY/PVcHf1KmDlW
        Nxo4OIVjNKN4/YGfvX1DgeYmo/GWViOcMdp5
X-Google-Smtp-Source: AGRyM1tOM5J/RFiodADCopqKAEy/EcFbfnCesm2Qj90AtZbtWiPVYkNTC2MLxikEElcNuCof1XQDUg==
X-Received: by 2002:a05:6402:3490:b0:42f:b592:f364 with SMTP id v16-20020a056402349000b0042fb592f364mr25822664edc.66.1655671123927;
        Sun, 19 Jun 2022 13:38:43 -0700 (PDT)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id kv14-20020a17090778ce00b006fe8b3d8cb6sm4940063ejc.62.2022.06.19.13.38.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Jun 2022 13:38:43 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id g4so12056388wrh.11
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 13:38:43 -0700 (PDT)
X-Received: by 2002:a05:6000:1251:b0:21a:efae:6cbe with SMTP id
 j17-20020a056000125100b0021aefae6cbemr13056064wrx.281.1655671122800; Sun, 19
 Jun 2022 13:38:42 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 19 Jun 2022 15:38:26 -0500
X-Gmail-Original-Message-ID: <CAHk-=wgErDgDFbU9astx+NTUu_KNi-jgzfF6RGup=cVee6+U=g@mail.gmail.com>
Message-ID: <CAHk-=wgErDgDFbU9astx+NTUu_KNi-jgzfF6RGup=cVee6+U=g@mail.gmail.com>
Subject: Linux 5.19-rc3
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

It's Sunday afternoon, which means it's time for another rc release.

5.19-rc3 is fairly small, and just looking at the diffstat, a lot of
it ends up being in the documentation subdirectory. With another chunk
in selftests.

But we do have real code changes too, fairly evenly split between
drivers, architecture fixes, and "other code". That other code is
mostly filesystem fixes, but also some core kernel and networking.

Full shortlog appended for your enjoyment, but so far everything looks
fine. Knock wood,

                   Linus

---

Alan Previn (1):
      drm/i915/reset: Fix error_state_read ptr + offset use

Aleksandr Loktionov (1):
      i40e: Fix call trace in setup_tx_descriptors

Alexander Usyskin (3):
      mei: me: set internal pg flag to off on hardware reset
      mei: hbm: drop capability response on early shutdown
      mei: me: add raptor lake point S DID

Andy Chiu (2):
      net: axienet: make the 64b addresable DMA depends on 64b archectures
      net: axienet: Use iowrite64 to write all 64b descriptor pointers

Andy Shevchenko (1):
      MAINTAINERS: Update Synopsys DesignWare I2C to Supported

Ashutosh Dixit (1):
      drm/i915/gt: Fix memory leaks in per-gt sysfs

Baokun Li (2):
      ext4: fix bug_on ext4_mb_use_inode_pa
      ext4: correct the judgment of BUG in ext4_mb_normalize_request

Bart Van Assche (2):
      block: Fix handling of offline queues in blk_mq_alloc_request_hctx()
      block/bfq: Enable I/O statistics

Benjamin Marzinski (1):
      dm: fix race in dm_start_io_acct

Brad Bishop (1):
      eeprom: at25: Split reads into chunks and cap write size

Catalin Marinas (1):
      Revert "arm64: Initialize jump labels before setup_machine_fdt()"

Christian Brauner (1):
      fs: account for group membership

Christian G=C3=B6ttsche (2):
      audit: free module name
      selinux: free contexts previously transferred in selinux_add_opt()

Christian K=C3=B6nig (2):
      drm/ttm: fix missing NULL check in ttm_device_swapout
      drm/ttm: fix bulk move handling v2

Christophe JAILLET (2):
      i2c: mediatek: Fix an error handling path in mtk_i2c_probe()
      net: bgmac: Fix an erroneous kfree() in bgmac_remove()

Conor Dooley (1):
      riscv: dts: microchip: re-add pdma to mpfs device tree

Dan Carpenter (1):
      drm/exynos: fix IS_ERR() vs NULL check in probe

Darrick J. Wong (3):
      xfs: fix TOCTOU race involving the new logged xattrs control knob
      xfs: fix variable state usage
      xfs: preserve DIFLAG2_NREXT64 when setting other inode attributes

Dave Wysochanski (1):
      NFSv4: Add FMODE_CAN_ODIRECT after successful open of a NFS4.x file

David Matlack (11):
      KVM: selftests: Replace x86_page_size with PG_LEVEL_XX
      KVM: selftests: Add option to create 2M and 1G EPT mappings
      KVM: selftests: Drop stale function parameter comment for nested_map(=
)
      KVM: selftests: Refactor nested_map() to specify target level
      KVM: selftests: Move VMX_EPT_VPID_CAP_AD_BITS to vmx.h
      KVM: selftests: Add a helper to check EPT/VPID capabilities
      KVM: selftests: Drop unnecessary rule for STATIC_LIBS
      KVM: selftests: Link selftests directly with lib object files
      KVM: selftests: Clean up LIBKVM files in Makefile
      KVM: selftests: Add option to run dirty_log_perf_test vCPUs in L2
      KVM: selftests: Restrict test region to 48-bit physical
addresses when using nested

David S. Miller (1):
      xilinx:  Fix build on x86.

Ding Xiang (1):
      ext4: make variable "count" signed

Duoming Zhou (1):
      net: ax25: Fix deadlock caused by skb_recv_datagram in ax25_recvmsg

Dylan Yudaken (4):
      io_uring: fix index calculation
      io_uring: fix types in provided buffer ring
      io_uring: limit size of provided buffer ring
      io_uring: do not use prio task_work_add in uring_cmd

Eddie James (1):
      hwmon: (occ) Lock mutex in shutdown to prevent race with occ_active

Eric Biggers (1):
      ext4: fix up test_dummy_encryption handling for new mount API

GONG, Ruiqi (1):
      drm/atomic: fix warning of unused variable

Grzegorz Szczurek (2):
      i40e: Fix adding ADQ filter to TC0
      i40e: Fix calculating the number of queue pairs

Guangbin Huang (3):
      net: hns3: set port base vlan tbl_sta to false before removing old vl=
an
      net: hns3: restore tm priority/qset to default settings when tc disab=
led
      net: hns3: fix tm port shapping of fibre port is incorrect after
driver initialization

Guenter Roeck (1):
      watchdog: gxp: Add missing MODULE_LICENSE

Guoqing Jiang (1):
      Revert "md: don't unregister sync_thread with reconfig_mutex held"

Hans de Goede (1):
      x86/PCI: Revert "x86/PCI: Clip only host bridge windows for E820 regi=
ons"

Hao Xu (2):
      io_uring: openclose: fix bug of closing wrong fixed file
      io_uring: kbuf: fix bug of not consuming ring buffer in partial io ca=
se

Heiko Stuebner (3):
      riscv: fix dependency for t-head errata
      riscv: drop cpufeature_apply_feature tracking variable
      riscv: Improve description for RISCV_ISA_SVPBMT Kconfig symbol

Ian Abbott (1):
      comedi: vmk80xx: fix expression for tx buffer size

Ilpo J=C3=A4rvinen (1):
      serial: 8250: Store to lsr_save_flags after lsr read

Jamie Iles (1):
      irqchip/xilinx: Remove microblaze+zynq dependency

Jan Kara (2):
      init: Initialize noop_backing_dev_info early
      ext4: improve write performance with disabled delalloc

Jani Nikula (1):
      drm/i915/uc: remove accidental static from a local variable

Jason A. Donenfeld (1):
      crypto: memneq - move into lib/

Javier Martinez Canillas (1):
      staging: olpc_dcon: mark driver as broken

Jean-Philippe Brucker (1):
      amd-xgbe: Use platform_irq_count()

Jens Axboe (2):
      io_uring: commit non-pollable provided mapped buffers upfront
      io_uring: recycle provided buffer if we punt to io-wq

Jian Shen (1):
      net: hns3: don't push link state to VF if unalive

Jiasheng Jiang (1):
      i2c: npcm7xx: Add check for platform_driver_register

Jiaxun Yang (1):
      irqchip/loongson-liointc: Use architecture register to get coreid

Jie Wang (2):
      net: hns3: modify the ring param print info
      net: hns3: fix PF rss size initialization bug

Jing Leng (1):
      usb: cdnsp: Fixed setting last_trb incorrectly

Joanne Koong (1):
      Revert "net: Add a second bind table hashed by port and address"

Jonathan Neusch=C3=A4fer (1):
      docs: networking: phy: Fix a typo

Jose Alonso (1):
      net: usb: ax88179_178a needs FLAG_SEND_ZLP

Josh Poimboeuf (5):
      x86/speculation/mmio: Print SMT warning
      objtool: Fix obsolete reference to CONFIG_X86_SMAP
      faddr2line: Fix overlapping text section failures, the sequel
      x86/ftrace: Remove OBJECT_FILES_NON_STANDARD usage
      x86/mm: Fix RESERVE_BRK() for older binutils

Julia Lawall (1):
      RISC-V: KVM: fix typos in comments

Kees Cook (1):
      staging: rtl8723bs: Allocate full pwep structure

Keith Busch (5):
      nvme: add bug report info for global duplicate id
      nvme-pci: add trouble shooting steps for timeouts
      nvme-pci: phison e12 has bogus namespace ids
      nvme-pci: smi has bogus namespace ids
      nvme-pci: sk hynix p31 has bogus namespace ids

Kirill A. Shutemov (3):
      x86/tdx: Fix early #VE handling
      x86/tdx: Clarify RIP adjustments in #VE handler
      x86/tdx: Handle load_unaligned_zeropad() page-cross to a shared page

Kunihiko Hayashi (2):
      dt-bindings: interrupt-controller/uniphier-aidet: Add bindings for NX=
1 SoC
      irqchip/uniphier-aidet: Add compatible string for NX1 SoC

Larry Finger (1):
      staging: r8188eu: Fix warning of array overflow in ioctl_linux.c

Linus Torvalds (2):
      netfs: fix up netfs_inode_init() docbook comment
      Linux 5.19-rc3

Linyu Yuan (2):
      usb: gadget: f_fs: change ep->status safe in ffs_epfile_io()
      usb: gadget: f_fs: change ep->ep safe in ffs_epfile_io()

Logan Gunthorpe (1):
      md/raid5-ppl: Fix argument order in bio_alloc_bioset()

Lukas Bulwahn (3):
      MAINTAINERS: Limit KVM RISC-V entry to existing selftests
      MAINTAINERS: add include/dt-bindings/i2c to I2C SUBSYSTEM HOST DRIVER=
S
      MAINTAINERS: add include/dt-bindings/net to NETWORKING DRIVERS

Marc Zyngier (8):
      KVM: arm64: Always start with clearing SVE flag on load
      KVM: arm64: Always start with clearing SME flag on load
      KVM: arm64: Don't read a HW interrupt pending state in user context
      KVM: arm64: Replace vgic_v3_uaccess_read_pending with
vgic_uaccess_read_pending
      KVM: arm64: Warn if accessing timer pending state outside of vcpu con=
text
      KVM: arm64: Handle all ID registers trapped for a protected VM
      KVM: arm64: Drop stale comment
      genirq: PM: Use runtime PM for chained interrupts

Marek Szyprowski (1):
      drm/exynos: mic: Rework initialization

Marian Postevca (1):
      usb: gadget: u_ether: fix regression in setting fixed MAC address

Mark Brown (1):
      arm64/cpufeature: Unexport set_cpu_feature()

Mark Rutland (3):
      arm64: ftrace: fix branch range checks
      arm64: ftrace: consistently handle PLTs.
      arm64: ftrace: remove redundant label

Masahiro Yamada (3):
      clocksource: hyper-v: unexport __init-annotated hv_init_clocksource()
      certs/blacklist_hashes.c: fix const confusion in certs blacklist
      certs: fix and refactor CONFIG_SYSTEM_BLACKLIST_HASH_LIST build

Mathias Nyman (1):
      xhci: Fix null pointer dereference in resume if xhci has only one roo=
thub

Matthew Wilcox (Oracle) (3):
      usercopy: Handle vm_map_ram() areas
      usercopy: Cast pointer to an integer once
      usercopy: Make usercopy resilient against ridiculously large copies

Maxim Levitsky (7):
      KVM: x86: document AVIC/APICv inhibit reasons
      KVM: x86: inhibit APICv/AVIC on changes to APIC ID or APIC base
      KVM: x86: SVM: remove avic's broken code that updated APIC ID
      KVM: x86: SVM: fix avic_kick_target_vcpus_fast
      KVM: x86: disable preemption while updating apicv inhibition
      KVM: x86: disable preemption around the call to
kvm_arch_vcpu_{un|}blocking
      KVM: x86: SVM: drop preempt-safe wrappers for avic_vcpu_load/put

Miaoqian Lin (9):
      irqchip/gic/realview: Fix refcount leak in realview_gic_of_init
      irqchip/apple-aic: Fix refcount leak in build_fiq_affinity
      irqchip/apple-aic: Fix refcount leak in aic_of_ic_init
      irqchip/gic-v3: Fix error handling in gic_populate_ppi_partitions
      irqchip/gic-v3: Fix refcount leak in gic_populate_ppi_partitions
      irqchip/realtek-rtl: Fix refcount leak in map_interrupts
      usb: dwc2: Fix memory leak in dwc2_hcd_init
      usb: gadget: lpc32xx_udc: Fix refcount leak in lpc32xx_udc_probe
      misc: atmel-ssc: Fix IRQ check in ssc_probe

Michael Carns (1):
      hwmon: (asus-ec-sensors) add missing comma in board name list.

Michael Kelley (1):
      HID: hyperv: Correctly access fields declared as __le16

Michal Michalik (1):
      ice: Fix PTP TX timestamp offset calculation

Michal Wilczynski (1):
      iavf: Fix issue with MAC address of VF shown as zero

Michel D=C3=A4nzer (1):
      drm/amdgpu: Fix GTT size reporting in amdgpu_ioctl

Mikulas Patocka (3):
      dm: fix use-after-free in dm_put_live_table_bio
      dm: fix narrow race for REQ_NOWAIT bios being issued despite no suppo=
rt
      dm mirror log: round up region bitmap size to BITS_PER_LONG

Ming Lei (3):
      blk-mq: protect q->elevator by ->sysfs_lock in blk_mq_elv_switch_none
      blk-mq: avoid to touch q->elevator without any protection
      blk-mq: don't clear flush_rq from tags->rqs[]

Nathan Chancellor (1):
      misc: rtsx: Fix clang -Wsometimes-uninitialized in rts5261_init_from_=
hw()

Ning Wang (1):
      nvme-pci: avoid the deepest sleep state on ZHITAI TiPro7000 SSDs

Nirmoy Das (1):
      drm/i915: Individualize fences before adding to dma_resv obj

Oleksij Rempel (1):
      ARM: dts: at91: ksz9477_evb: fix port/phy validation

Paolo Bonzini (1):
      KVM: x86: SVM: fix nested PAUSE filtering when L0 intercepts PAUSE

Pavel Begunkov (13):
      io_uring: fix races with file table unregister
      io_uring: fix races with buffer table unregister
      io_uring: fix not locked access to fixed buf table
      io_uring: fix double unlock for pbuf select
      Revert "io_uring: support CQE32 for nop operation"
      Revert "io_uring: add buffer selection support to IORING_OP_NOP"
      io_uring: remove IORING_CLOSE_FD_AND_FILE_SLOT
      io_uring: get rid of __io_fill_cqe{32}_req()
      io_uring: unite fill_cqe and the 32B version
      io_uring: fill extra big cqe fields from req
      io_uring: fix ->extra{1,2} misuse
      io_uring: remove __io_fill_cqe() helper
      io_uring: make io_fill_cqe_aux honour CQE32

Pawan Gupta (10):
      Documentation: Add documentation for Processor MMIO Stale Data
      x86/speculation/mmio: Enumerate Processor MMIO Stale Data bug
      x86/speculation: Add a common function for MD_CLEAR mitigation update
      x86/speculation/mmio: Add mitigation for Processor MMIO Stale Data
      x86/bugs: Group MDS, TAA & Processor MMIO Stale Data mitigations
      x86/speculation/mmio: Enable CPU Fill buffer clearing on idle
      x86/speculation/mmio: Add sysfs reporting for Processor MMIO Stale Da=
ta
      x86/speculation/srbds: Update SRBDS mitigation selection
      x86/speculation/mmio: Reuse SRBDS mitigation for SBDS
      KVM: x86/speculation: Disable Fill buffer clear within guests

Peter Robinson (1):
      staging: Also remove the Unisys visorbus.h

Peter Zijlstra (1):
      sched: Fix balance_push() vs __sched_setscheduler()

Petr Machata (1):
      mlxsw: spectrum_cnt: Reorder counter pools

Petr Mladek (2):
      printk: Block console kthreads when direct printing will be required
      printk: Wait for the global console lock when the system is going dow=
n

Phillip Potter (1):
      staging: r8188eu: fix rtw_alloc_hwxmits error detection for now

Przemyslaw Patynowski (2):
      ice: Fix queue config fail handling
      ice: Fix memory corruption in VF driver

Rob Herring (1):
      dt-bindings: hwmon: ti,tmp401: Drop 'items' from 'ti,n-factor' proper=
ty

Robert Eckelmann (1):
      USB: serial: io_ti: add Agilent E5805A support

Roman Li (1):
      drm/amd/display: Cap OLED brightness per max frame-average luminance

Roman Storozhenko (1):
      ice: Sync VLAN filtering features for DVM

Sami Tolvanen (1):
      cfi: Fix __cfi_slowpath_diag RCU usage with cpuidle

Saurabh Sengar (2):
      Drivers: hv: vmbus: Don't assign VMbus channel interrupts to isolated=
 CPUs
      Drivers: hv: vmbus: Release cpu lock in error case

Scott Mayhew (1):
      sunrpc: set cl_max_connect when cloning an rpc_clnt

Sebastian Andrzej Siewior (1):
      locking/lockdep: Use sched_clock() for random numbers

Serge Semin (1):
      i2c: designware: Use standard optional ref clock implementation

Shin'ichiro Kawasaki (1):
      bus: fsl-mc-bus: fix KASAN use-after-free in fsl_mc_bus_remove()

Shreenidhi Shedi (1):
      char: lp: remove redundant initialization of err

Shuqi Zhang (1):
      ext4: use kmemdup() to replace kmalloc + memcpy

Shyam Prasad N (1):
      cifs: when a channel is not found for server, log its connection id

Slark Xiao (1):
      USB: serial: option: add support for Cinterion MV31 with new baseline

Stefan Reiter (1):
      nvme-pci: add NVME_QUIRK_BOGUS_NID for ADATA XPG GAMMIX S50

Stephan Gerhold (1):
      usb: dwc3: pci: Restore line lost in merge conflict resolution

Stephen Rothwell (1):
      USB: fixup for merge issue with "usb: dwc3: Don't switch OTG ->
peripheral if extcon is present"

Steve French (1):
      smb3: add trace point for SMB2_set_eof

Suman Ghosh (1):
      octeontx2-vf: Add support for adaptive interrupt coalescing

Thomas Wei=C3=9Fschuh (1):
      nvme: add device name to warning in uuid_show()

Tianyu Lan (1):
      x86/Hyper-V: Add SEV negotiate protocol support in Isolation VM

Tony Lindgren (1):
      tty: n_gsm: Debug output allocation must use GFP_ATOMIC

Trond Myklebust (2):
      pNFS: Don't keep retrying if the server replied NFS4ERR_LAYOUTUNAVAIL=
ABLE
      pNFS: Avoid a live lock condition in pnfs_update_layout()

Vijaya Krishna Nivarthi (2):
      serial: core: Introduce callback for start_rx and do stop_rx in
suspend only if this callback implementation is present.
      tty: serial: qcom-geni-serial: Implement start_rx callback

Vincent Whitchurch (1):
      tty: goldfish: Fix free_irq() on remove

Wang Jianjian (2):
      ext4: fix incorrect comment in ext4_bio_write_page()
      ext4, doc: remove unnecessary escaping

Wesley Cheng (1):
      usb: dwc3: gadget: Fix IN endpoint max packet size allocation

Will Deacon (5):
      KVM: arm64: Return error from kvm_arch_init_vm() on allocation failur=
e
      KVM: arm64: Ignore 'kvm-arm.mode=3Dprotected' when using VHE
      KVM: arm64: Extend comment in has_vhe()
      KVM: arm64: Remove redundant hyp_assert_lock_held() assertions
      arm64: mm: Don't invalidate FROM_DEVICE buffers at start of DMA trans=
fer

Wolfram Sang (1):
      MAINTAINERS: core DT include belongs to core

Xiang wangx (2):
      Drivers: hv: Fix syntax errors in comments
      ext4: fix a doubled word "need" in a comment

Xin Long (3):
      Documentation: add description for net.sctp.reconf_enable
      Documentation: add description for net.sctp.intl_enable
      Documentation: add description for net.sctp.ecn_enable

Yang Li (1):
      fs: fix jbd2_journal_try_to_free_buffers() kernel-doc comment

Yang Yingliang (1):
      net: axienet: add missing error return code in axienet_probe()

Yanteng Si (2):
      docs/LoongArch: Fix notes rendering by using reST directives
      docs/zh_CN/LoongArch: Fix notes rendering by using reST directives

Ye Bin (2):
      ext2: fix fs corruption when trying to remove a non-empty
directory with IO error
      ext4: fix super block checksum incorrect after mount

Youling Tang (1):
      LoongArch: vmlinux.lds.S: Add missing ELF_DETAILS

Yuan Yao (1):
      KVM: x86/mmu: Set memory encryption "value", not "mask", in shadow PD=
PTRs

Zhang Yi (2):
      ext4: fix warning when submitting superblock in ext4_commit_super()
      ext4: add reserved GDT blocks check

rasheed.hsueh (1):
      nvme-pci: disable write zeros support on UMIC and Samsung SSDs

sunliming (1):
      KVM: arm64: Fix inconsistent indenting
