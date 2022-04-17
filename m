Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76BF650499F
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 23:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234815AbiDQVWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 17:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233153AbiDQVV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 17:21:59 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF84F207
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 14:19:21 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id bu29so21748631lfb.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 14:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=U062sEL1mB4+mevcAlK0G9zYMOPXMiY0Bl4dvQY+sHE=;
        b=F5nGuBaq8SVSKliD83c3mhzgv83oonUG7vX2lOK5OfFEoP95U4YU7MHGbRPIAFJIPl
         rpKeyojrM6bDkjuvXTImvWnPSIHM6ktiIcQ3CfTByRO4Ic31F0fdZH4uN6wYwR13jsbY
         AAyWoIWMKNvVSqjf0Yh7rT6Q7sGvqZgF3OMCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=U062sEL1mB4+mevcAlK0G9zYMOPXMiY0Bl4dvQY+sHE=;
        b=cZdbN2jdyChYXX3vl/lD9taYrcfgqIjBnZq9MzxFqWIC7/9C+m8L+Rb1MhkZmTulIN
         B8qFQ+e+LVgiBv/PAMEvmYPYuBYIoZVkny948t6bcBFCWiRKLtA5+PgNoUarZaS85C17
         P6x9TfsMTvITwiQzih/+fyKrWlLNH1AyblocMJ0luIGizwxgBEJnk8cYoS2aZZC1uIuD
         ry/UEbkKjeKAJ4Hb2IDUqquwoxZAkY6f4bXrwM4wJGbOaHDhk52H3QAb3hvG1Ck7YNDx
         LtWkC4HF9SVZ8kkmMKrXoExe7WpkU+CtLf0sb/C+upF8aXPVkywp7a7rf8BLJicg4cFX
         mHMQ==
X-Gm-Message-State: AOAM530bYYXmwmMqzBQ1j/m2ET7A6cZKwZpGmTFIzAwT8R57A2AL2Kbp
        uISxDPXjyENTvgh5SjhDaAwtusuHPM7aAQMMXSs=
X-Google-Smtp-Source: ABdhPJyIQZbtJQj96BABK6oK/DGe0/HGv5Ntk0EE69qrDxv7QdPEBnTSik6K5JZH/1tB0q4ofNqx/w==
X-Received: by 2002:a05:6512:23aa:b0:471:96bc:7ab1 with SMTP id c42-20020a05651223aa00b0047196bc7ab1mr588179lfv.492.1650230359516;
        Sun, 17 Apr 2022 14:19:19 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id x6-20020a056512046600b0046fd05817f4sm720414lfd.239.2022.04.17.14.19.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Apr 2022 14:19:18 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id bu29so21748572lfb.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 14:19:17 -0700 (PDT)
X-Received: by 2002:a05:6512:3055:b0:44a:3914:6603 with SMTP id
 b21-20020a056512305500b0044a39146603mr6064350lfb.435.1650230357438; Sun, 17
 Apr 2022 14:19:17 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 17 Apr 2022 14:19:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgBR6P8EseYMjfMjxQ_oTpoQmL0qvKpAw04kP-HBgSGFg@mail.gmail.com>
Message-ID: <CAHk-=wgBR6P8EseYMjfMjxQ_oTpoQmL0qvKpAw04kP-HBgSGFg@mail.gmail.com>
Subject: Linux 5.18-rc3
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

It's Sunday afternoon, and you all know what that means. It's time for
another release candidate.

(Yes, yes, it's also Easter Sunday, but priorities, people!)

Things continue to look quite regular, although the diffstat may look
a bit odd due to some email  updates that ended up causing a lot of
spread-out one-liner updates in the devicetree files.

There's also a series to sound card probing error handling fixes ("Fix
the missing snd_card_free() call at probe error") which ends up
showing as a lot of few-lines across a number of sound drivers.

But it all looks pretty small and fairly simple. Famous last words.

Please do test,
                 Linus

---

Adrian Hunter (2):
      perf tools: Fix misleading add event PMU debug message
      perf tools: Fix segfault accessing sample_id xyarray

Ajish Koshy (2):
      scsi: pm80xx: Mask and unmask upper interrupt vectors 32-63
      scsi: pm80xx: Enable upper inbound, outbound queues

Alex Deucher (1):
      drm/amdgpu: fix VCN 3.1.2 firmware name

Alexander Lobakin (2):
      ice: arfs: fix use-after-free when freeing @rx_cpu_rmap
      asm-generic: fix __get_unaligned_be48() on 32 bit platforms

Alexander Sverdlin (2):
      ep93xx: clock: Fix UAF in ep93xx_clk_register_gate()
      ep93xx: clock: Don't use plain integer as NULL pointer

Alexey Bayduraev (1):
      perf record: Fix per-thread option

Alvin =C5=A0ipraga (2):
      net: dsa: realtek: fix Kconfig to assure consistent driver linkage
      net: dsa: realtek: don't parse compatible string for RTL8366S

Andrew Jones (1):
      KVM: selftests: get-reg-list: Add KVM_REG_ARM_FW_REG(3)

Andrew Morton (2):
      revert "fs/binfmt_elf: fix PT_LOAD p_align values for loaders"
      revert "fs/binfmt_elf: use PT_LOAD p_align values for static PIE"

Andy Shevchenko (3):
      gpiolib: acpi: Convert type for pin to be unsigned
      i2c: dev: check return value when calling dev_set_name()
      i2c: dev: Force case user pointers in compat_i2cdev_ioctl()

Anilkumar Kolli (1):
      Revert "ath11k: mesh: add support for 256 bitmap in blockack
frames in 11ax"

Anna-Maria Behnsen (1):
      timers: Fix warning condition in __run_timers()

Antoine Tenart (2):
      netfilter: nf_tables: nft_parse_register can return a negative value
      tun: annotate access to queue->trans_start

Anup Patel (3):
      RISC-V: KVM: Don't clear hgatp CSR in kvm_arch_vcpu_put()
      KVM: selftests: riscv: Set PTE A and D bits in VS-stage page table
      KVM: selftests: riscv: Fix alignment of the guest_hang() function

Arnd Bergmann (1):
      ARM: iop32x: include iop3xx.h header where needed

Arun Ramadoss (1):
      net: phy: LAN87xx: remove genphy_softreset in config_aneg

Athira Rajeev (3):
      testing/selftests/mqueue: Fix mq_perf_tests to free the allocated cpu=
 set
      perf bench: Fix numa testcase to check if CPU used to bind task is on=
line
      perf bench: Fix numa bench to fix usage of affinity for machines
with #CPUs > 1K

Axel Rasmussen (1):
      mm/secretmem: fix panic when growing a memfd_secret

Bagas Sanjaya (1):
      Documentation: kvm: Add missing line break in api.rst

Bart Van Assche (1):
      Revert "scsi: scsi_debug: Address races following module load"

Bartosz Golaszewski (1):
      gpio: sim: fix setting and getting multiple lines

Ben Greear (1):
      mac80211: fix ht_capa printout in debugfs

Benedikt Spranger (1):
      net/sched: taprio: Check if socket flags are valid

Bjorn Andersson (1):
      i2c: qcom-geni: Use dev_err_probe() for GPI DMA error

Borislav Petkov (4):
      ALSA: usb-audio: Fix undefined behavior due to shift overflowing
the constant
      mt76: Fix undefined behavior due to shift overflowing the constant
      brcmfmac: sdio: Fix undefined behavior due to shift overflowing
the constant
      i2c: ismt: Fix undefined behavior due to shift overflowing the consta=
nt

Chaitanya Kulkarni (1):
      nvme: don't print verbose errors for internal passthrough requests

Chao Gao (1):
      dma-direct: avoid redundant memory sync for swiotlb

Charan Teja Kalla (1):
      mm: compaction: fix compiler warning when CONFIG_COMPACTION=3Dn

Charlene Liu (1):
      drm/amd/display: remove dtbclk_ss compensation for dcn316

Christoph Hellwig (4):
      nvme: add a quirk to disable namespace identifiers
      nvme-pci: disable namespace identifiers for the MAXIO MAP1002/1202
      nvme-pci: disable namespace identifiers for Qemu controllers
      block: don't print I/O error warning for dead disks

Chuck Lever (2):
      SUNRPC: Fix NFSD's request deferral on RDMA transports
      SUNRPC: Fix the svc_deferred_event trace class

Cristian Marussi (2):
      firmware: arm_scmi: Remove clear channel call on the TX channel
      firmware: arm_scmi: Fix sorting of retrieved clock rates

Dave Wysochanski (1):
      cachefiles: Fix KASAN slab-out-of-bounds in cachefiles_set_volume_xat=
tr

David Heidelberg (1):
      dt-bindings: reset: document deprecated HiSilicon property

David Howells (2):
      cifs: Check the IOCB_DIRECT flag, not O_DIRECT
      cifs: Split the smb3_add_credits tracepoint

Dennis Zhou (1):
      btrfs: fix btrfs_submit_compressed_write cgroup attribution

Dinh Nguyen (1):
      net: ethernet: stmmac: fix altr_tse_pcs function when using a fixed-l=
ink

Dmitry Baryshkov (1):
      dt-bindings: display/msm: another fix for the dpu-qcm2290 example

Dongjin Yang (1):
      dt-bindings: net: snps: remove duplicate name

Dylan Hung (1):
      net: ftgmac100: access hardware register after clock ready

Dylan Yudaken (4):
      io_uring: move io_uring_rsrc_update2 validation
      io_uring: verify that resv2 is 0 in io_uring_rsrc_update2
      io_uring: verify resv is 0 in ringfd register/unregister
      io_uring: verify pad field is 0 in io_get_ext_arg

Fabio M. De Francesco (1):
      ALSA: pcm: Test for "silence" field in struct "pcm_format_data"

Florian Westphal (1):
      netfilter: nft_socket: make cgroup match work in input too

Gal Pressman (1):
      bonding: Update layer2 and layer2+3 hash formula documentation

Geert Uytterhoeven (1):
      dt-bindings: power: renesas,apmu: Fix cpus property limits

Guillaume Nault (1):
      veth: Ensure eth header is in skb's linear part

Hans de Goede (3):
      Documentation/ABI: sysfs-driver-intel_sdsi: Fix sphinx warnings
      Documentation/ABI: sysfs-class-firmware-attributes: Fix Sphinx errors
      Documentation/ABI: sysfs-class-firmware-attributes: Misc. cleanups

Haowen Bai (3):
      SUNRPC: Return true/false (not 1/0) from bool functions
      platform/x86: barco-p50-gpio: Fix duplicate included linux/io.h
      btrfs: zoned: remove redundant condition in btrfs_run_delalloc_range

Harshit Mogalapalli (1):
      cifs: potential buffer overflow in handling symlinks

Heiko Carstens (4):
      s390: add z16 elf platform
      s390: allow to compile with z16 optimizations
      s390/kexec: silence -Warray-bounds warning
      s390: update defconfigs

Heiko Stuebner (1):
      RISC-V: KVM: include missing hwcap.h into vcpu_fp

Heiner Kallweit (1):
      reset: renesas: Check return value of reset_control_deassert()

Hongbin Wang (1):
      vxlan: fix error return code in vxlan_fdb_append

Horatiu Vultur (4):
      net: lan966x: Update lan966x_ptp_get_nominal_value
      net: lan966x: Fix IGMP snooping when frames have vlan tag
      net: lan966x: Fix when a port's upper is changed.
      net: lan966x: Stop processing the MAC entry is port is wrong.

Hugh Dickins (1):
      tmpfs: fix regressions from wider use of ZERO_PAGE

Jakub Kicinski (1):
      flow_dissector: fix false-positive __read_overflow2_field() warning

Jason A. Donenfeld (4):
      gcc-plugins: latent_entropy: use /dev/urandom
      random: allow partial reads if later user copies fail
      random: make random_get_entropy() return an unsigned long
      random: use memmove instead of memcpy for remaining 32 bytes

Jason Gunthorpe (1):
      vfio/pci: Fix vf_token mechanism when device-specific VF drivers are =
used

Jeffle Xu (1):
      cachefiles: unmark inode in use in error path

Jens Axboe (5):
      io_uring: flag the fact that linked file assignment is sane
      io_uring: io_kiocb_update_pos() should not touch file for non -1 offs=
et
      io_uring: move apoll->events cache
      io_uring: stop using io_wq_work as an fd placeholder
      io_uring: abort file assignment prior to assigning creds

Jeremy Linton (1):
      net: bcmgenet: Revert "Use stronger register read/writes to
assure ordering"

Jia-Ju Bai (1):
      btrfs: fix root ref counts in error handling in btrfs_get_root_ref

Jiapeng Chong (2):
      platform/x86: samsung-laptop: Fix an unsigned comparison which
can never be negative
      tick/sched: Fix non-kernel-doc comment

Joe Perches (1):
      MAINTAINERS: Broadcom internal lists aren't maintainers

Johan Hovold (1):
      memory: renesas-rpc-if: fix platform-device leak in error path

Johannes Berg (2):
      MAINTAINERS: claim include/uapi/linux/wireless.h
      nl80211: correctly check NL80211_ATTR_REG_ALPHA2 size

Jonathan Cameron (1):
      arm: configs: imote2: Drop defconfig as board support dropped.

Juergen Gross (2):
      xen/balloon: don't use PV mode extra memory for zone device allocatio=
ns
      mm, page_alloc: fix build_zonerefs_node()

Kai Vehmanen (1):
      ALSA: hda/i915 - skip acomp init if no matching display

Kai-Heng Feng (2):
      net: atlantic: Avoid out-of-bounds indexing
      drm/amdgpu: Ensure HDA function is suspended before ASIC reset

Kalle Valo (1):
      MAINTAINERS: mark wil6210 as orphan

Karsten Graul (3):
      net/smc: use memcpy instead of snprintf to avoid out of bounds read
      net/smc: Fix NULL pointer dereference in smc_pnet_find_ib()
      net/smc: Fix af_ops of child socket pointing to released memory

Kees Cook (1):
      ARM: vexpress/spc: Avoid negative array index when !SMP

Keith Busch (1):
      block: move lower_48_bits() to block

Khazhismel Kumykov (2):
      dm mpath: only use ktime_get_ns() in historical selector
      block/compat_ioctl: fix range check in BLKGETSIZE

Krzysztof Kozlowski (5):
      dt-bindings: update Krzysztof Kozlowski's email
      MAINTAINERS: update Krzysztof Kozlowski's email to Linaro
      dt-bindings: extcon: maxim,max77843: fix ports type
      dt-bindings: irqchip: mrvl,intc: refresh maintainers
      ARM: dts: align SPI NOR node name with dtschema

Kunihiko Hayashi (3):
      dt-bindings: reset: Add parent "resets" property as optional
      dt-bindings: net: ave: Clean up clocks, resets, and their names
using compatible string
      dt-bindings: net: ave: Use unevaluatedProperties

Kuogee Hsieh (1):
      drm/msm/dp: add fail safe mode outside of event_mutex context

Kyle Copperfield (1):
      media: rockchip/rga: do proper error checking in probe

Lad Prabhakar (1):
      dt-bindings: gpu: mali-bifrost: Document RZ/V2L SoC

Laurent Pinchart (1):
      media: platform: imx-mipi-csis: Add dependency on VIDEO_DEV

Li Yang (1):
      memory: fsl_ifc: populate child nodes of buses and mfd devices

Like Xu (2):
      selftests: kvm: add tsc_scaling_sync to .gitignore
      Documentation: KVM: Add SPDX-License-Identifier tag

Lin Ma (1):
      nfc: nci: add flush_workqueue to prevent uaf

Linus Torvalds (2):
      gpiolib: acpi: use correct format characters
      Linux 5.18-rc3

Linus Walleij (5):
      ARM: config: Refresh U8500 defconfig
      ARM: config: u8500: Add some common hardware
      ARM: config: u8500: Re-enable AB8500 battery charging
      power: supply: samsung-sdi-battery: Add missing charge restart voltag=
es
      ARM: config: Update Gemini defconfig

Lorenzo Bianconi (1):
      MAINTAINERS: update Lorenzo's email address

Lv Ruyi (4):
      firmware: arm_scmi: Replace zero-length array with flexible-array mem=
ber
      KVM: x86/mmu: remove unnecessary flush_workqueue()
      dpaa_eth: Fix missing of_node_put in dpaa_get_ts_info()
      perf stat: Fix error check return value of hashmap__new(), must
use IS_ERR()

Marcelo Ricardo Leitner (1):
      net/sched: fix initialization order when updating chain 0 head

Marco Elver (1):
      mm, kfence: support kmem_dump_obj() for KFENCE objects

Marek Vasut (1):
      i2c: imx: Implement errata ERR007805 or e7805 bus frequency limit

Marijn Suijten (1):
      drm/msm/dpu: Use indexed array initializer to prevent mismatches

Mario Limonciello (1):
      platform/x86: amd-pmc: Fix compilation without CONFIG_SUSPEND

Mark Pearson (1):
      platform/x86: think-lmi: certificate support clean ups

Martin Povi=C5=A1er (1):
      i2c: pasemi: Wait for write xfers to finish

Martin Willi (1):
      macvlan: Fix leaking skb in source mode with nodst option

Mateusz Palczewski (1):
      Revert "iavf: Fix deadlock occurrence during resetting VF interface"

Matt Roper (1):
      drm/i915: Sunset igpu legacy mmap support based on GRAPHICS_VER_FULL

Melissa Wen (1):
      drm/amd/display: don't ignore alpha property on pre-multiplied mode

Miaoqian Lin (1):
      memory: atmel-ebi: Fix missing of_node_put in atmel_ebi_probe

Michael Walle (1):
      net: dsa: felix: suppress -EPROBE_DEFER errors

Mike Christie (10):
      scsi: iscsi: Move iscsi_ep_disconnect()
      scsi: iscsi: Fix offload conn cleanup when iscsid restarts
      scsi: iscsi: Release endpoint ID when its freed
      scsi: iscsi: Fix endpoint reuse regression
      scsi: iscsi: Fix conn cleanup and stop race during iscsid restart
      scsi: iscsi: Fix unbound endpoint error handling
      scsi: iscsi: Merge suspend fields
      scsi: iscsi: Fix NOP handling during conn recovery
      scsi: qedi: Fix failed disconnect handling
      scsi: iscsi: MAINTAINERS: Add Mike Christie as co-maintainer

Mike Kravetz (1):
      hugetlb: do not demote poisoned hugetlb pages

Mike Snitzer (2):
      dm zone: fix NULL pointer dereference in dm_zone_map_bio
      dm: allow dm_accept_partial_bio() for dm_io without duplicate bios

Mikulas Patocka (2):
      stat: fix inconsistency between struct stat and struct compat_stat
      dm integrity: fix memory corruption when tag_size is less than digest=
 size

Minchan Kim (1):
      mm: fix unexpected zeroed page mapping with zram swap

Ming Lei (2):
      block: fix offset/size check in bio_trim()
      block: null_blk: end timed out poll request

Nadav Amit (1):
      smp: Fix offline cpu check in flush_smp_call_function_queue()

Naohiro Aota (4):
      btrfs: release correct delalloc amount in direct IO write path
      btrfs: mark resumed async balance as writing
      btrfs: return allocated block group from do_chunk_alloc()
      btrfs: zoned: activate block group only for extent allocation

Nathan Chancellor (3):
      ARM: davinci: da850-evm: Avoid NULL pointer dereference
      btrfs: remove unused variable in btrfs_{start,write}_dirty_block_grou=
ps()
      drm/msm/gpu: Avoid -Wunused-function with !CONFIG_PM_SLEEP

NeilBrown (1):
      VFS: filename_create(): fix incorrect intent.

Nicolas Dichtel (1):
      ipv6: fix panic when forwarding a pkt with no in6 dev

Nikolay Borisov (1):
      btrfs: remove support of balance v1 ioctl

Oliver Upton (7):
      KVM: arm64: Generally disallow SMC64 for AArch32 guests
      KVM: arm64: Actually prevent SMC64 SYSTEM_RESET2 from AArch32
      KVM: arm64: Drop unneeded minor version check from PSCI v1.x handler
      KVM: arm64: Don't split hugepages outside of MMU write lock
      KVM: Don't create VM debugfs files outside of the VM directory
      selftests: KVM: Don't leak GIC FD across dirty log test iterations
      selftests: KVM: Free the GIC FD when cleaning up in arch_timer

Omar Sandoval (1):
      mm/vmalloc: fix spinning drain_vmap_work after reading from /proc/vmc=
ore

Paolo Bonzini (1):
      KVM: avoid NULL pointer dereference in kvm_dirty_ring_push

Patrick Wang (1):
      mm: kmemleak: take a full lowmem check in kmemleak_*_phys()

Paul Gortmaker (1):
      tick/nohz: Use WARN_ON_ONCE() to prevent console saturation

Pavel Begunkov (4):
      io_uring: fix assign file locking issue
      io_uring: use right issue_flags for splice/tee
      io_uring: fix poll file assign deadlock
      io_uring: fix poll error reporting

Pawan Gupta (2):
      x86/tsx: Use MSR_TSX_CTRL to clear CPUID bits
      x86/tsx: Disable TSX development mode at boot

Peter Gonda (1):
      KVM: SEV: Add cond_resched() to loop in sev_clflush_pages()

Petr Machata (1):
      rtnetlink: Fix handling of disabled L3 stats in RTM_GETSTATS replies

Petr Malat (1):
      sctp: Initialize daddr on peeled off socket

Pierre-Louis Bossart (1):
      ALSA: hda: intel-dsp-config: update AlderLake PCI IDs

Piotr Chmura (1):
      media: si2157: unknown chip version Si2147-A30 ROM 0x50

Rameshkumar Sundaram (1):
      cfg80211: hold bss_lock while updating nontrans_list

Randy Dunlap (1):
      sound/oss/dmasound: fix build when drivers are mixed =3Dy/=3Dm

Rei Yamamoto (1):
      genirq/affinity: Consider that CPUs on nodes can be unbalanced

Reiji Watanabe (2):
      KVM: arm64: mixed-width check should be skipped for uninitialized vCP=
Us
      KVM: arm64: selftests: Introduce vcpu_width_config

Rob Clark (5):
      drm/msm/gpu: Rename runtime suspend/resume functions
      drm/msm/gpu: Park scheduler threads for system suspend
      drm/msm/gpu: Remove mutex from wait_event condition
      drm/msm: Add missing put_task_struct() in debugfs path
      drm/msm: Fix range size vs end confusion

Rob Herring (11):
      dt-bindings: Fix incomplete if/then/else schemas
      dt-bindings: Fix 'enum' lists with duplicate entries
      arm: dts: at91: Fix boolean properties with values
      arm64: dts: tegra: Fix boolean properties with values
      arm: dts: imx: Fix boolean properties with values
      arm64: dts: imx: Fix imx8*-var-som touchscreen property sizes
      arm/arm64: dts: qcom: Fix boolean properties with values
      dt-bindings: Fix array constraints on scalar properties
      ARM: dts: Fix more boolean properties with values
      arm64: dts: qcom/sdm845-shift-axolotl: Fix boolean properties with va=
lues
      dt-bindings: display: panel-timing: Define a single type for properti=
es

Robin Murphy (1):
      drm/msm: Stop using iommu_present()

Ronnie Sahlberg (1):
      cifs: verify that tcon is valid before dereference in cifs_kill_sb

Sameer Pujar (1):
      reset: tegra-bpmp: Restore Handle errors in BPMP response

Sean Christopherson (1):
      KVM: x86/mmu: Resolve nx_huge_pages when kvm.ko is loaded

Sherry Sun (1):
      dt-bindings: memory: snps,ddrc-3.80a compatible also need interrupts

Shin'ichiro Kawasaki (1):
      dm: fix bio length of empty flush

Shyam Prasad N (1):
      cifs: release cached dentries only if mount is complete

Stephen Boyd (1):
      drm/msm/dsi: Use connector directly in msm_dsi_manager_connector_init=
()

Steven Price (1):
      cpu/hotplug: Remove the 'cpu' member of cpuhp_cpu_state

Sudeep Holla (3):
      firmware: arm_scmi: Fix sparse warnings in OPTEE transport driver
      ARM: vexpress/spc: Fix kernel-doc build warning for ve_spc_cpu_in_wfi
      ARM: vexpress/spc: Fix all the kernel-doc build warnings

Suravee Suthikulpanit (1):
      KVM: SVM: Do not activate AVIC for SEV-enabled guest

Sven Schnelle (2):
      s390: current_stack_pointer shouldn't be a function
      s390: enable CONFIG_HARDENED_USERCOPY in debug_defconfig

Tadeusz Struk (1):
      uapi/linux/stddef.h: Add include guards

Takashi Iwai (45):
      ALSA: usb-audio: Cap upper limits of buffer/period bytes for implicit=
 fb
      ALSA: usb-audio: Increase max buffer size
      ALSA: core: Add snd_card_free_on_error() helper
      ALSA: echoaudio: Fix the missing snd_card_free() call at probe error
      ALSA: galaxy: Fix the missing snd_card_free() call at probe error
      ALSA: sc6000: Fix the missing snd_card_free() call at probe error
      ALSA: ad1889: Fix the missing snd_card_free() call at probe error
      ALSA: ali5451: Fix the missing snd_card_free() call at probe error
      ALSA: als4000: Fix the missing snd_card_free() call at probe error
      ALSA: atiixp: Fix the missing snd_card_free() call at probe error
      ALSA: au88x0: Fix the missing snd_card_free() call at probe error
      ALSA: azt3328: Fix the missing snd_card_free() call at probe error
      ALSA: ca0106: Fix the missing snd_card_free() call at probe error
      ALSA: cs4281: Fix the missing snd_card_free() call at probe error
      ALSA: cs5535audio: Fix the missing snd_card_free() call at probe erro=
r
      ALSA: emu10k1x: Fix the missing snd_card_free() call at probe error
      ALSA: ens137x: Fix the missing snd_card_free() call at probe error
      ALSA: es1938: Fix the missing snd_card_free() call at probe error
      ALSA: es1968: Fix the missing snd_card_free() call at probe error
      ALSA: fm801: Fix the missing snd_card_free() call at probe error
      ALSA: ice1724: Fix the missing snd_card_free() call at probe error
      ALSA: intel8x0: Fix the missing snd_card_free() call at probe error
      ALSA: korg1212: Fix the missing snd_card_free() call at probe error
      ALSA: maestro3: Fix the missing snd_card_free() call at probe error
      ALSA: riptide: Fix the missing snd_card_free() call at probe error
      ALSA: rme32: Fix the missing snd_card_free() call at probe error
      ALSA: rme96: Fix the missing snd_card_free() call at probe error
      ALSA: sonicvibes: Fix the missing snd_card_free() call at probe error
      ALSA: via82xx: Fix the missing snd_card_free() call at probe error
      ALSA: intel_hdmi: Fix the missing snd_card_free() call at probe error
      ALSA: sis7019: Fix the missing error handling
      ALSA: bt87x: Fix the missing snd_card_free() call at probe error
      ALSA: lola: Fix the missing snd_card_free() call at probe error
      ALSA: als300: Fix the missing snd_card_free() call at probe error
      ALSA: aw2: Fix the missing snd_card_free() call at probe error
      ALSA: cmipci: Fix the missing snd_card_free() call at probe error
      ALSA: lx6464es: Fix the missing snd_card_free() call at probe error
      ALSA: oxygen: Fix the missing snd_card_free() call at probe error
      ALSA: hdsp: Fix the missing snd_card_free() call at probe error
      ALSA: hdspm: Fix the missing snd_card_free() call at probe error
      ALSA: rme9652: Fix the missing snd_card_free() call at probe error
      ALSA: mtpav: Don't call card private_free at probe error path
      ALSA: nm256: Don't call card private_free at probe error path
      ALSA: memalloc: Add fallback SG-buffer allocations for x86
      ALSA: usb-audio: Limit max buffer and period sizes per time

Tao Jin (1):
      ALSA: hda/realtek: add quirk for Lenovo Thinkpad X12 speakers

Tim Crawford (1):
      ALSA: hda/realtek: Add quirk for Clevo PD50PNT

Toke H=C3=B8iland-J=C3=B8rgensen (2):
      ath9k: Properly clear TX status area before reporting to mac80211
      ath9k: Fix usage of driver-private space in tx_info

Tomas Melin (1):
      net: macb: Restart tx only if queue pointer is lagging

Tomasz Mo=C5=84 (1):
      drm/amdgpu: Enable gfxoff quirk on MacBook Pro

Trond Myklebust (2):
      nfsd: Fix a write performance regression
      nfsd: Clean up nfsd_file_put()

Vadim Pasternak (1):
      mlxsw: i2c: Fix initialization error flow

Vincenzo Frascino (1):
      kasan: fix hw tags enablement when KUNIT tests are disabled

Vitaly Kuznetsov (1):
      KVM: x86: hyper-v: Avoid writing to TSC page without an active vCPU

Vlad Buslov (1):
      net/sched: flower: fix parsing of ethertype following VLAN header

Vladimir Oltean (3):
      net: mdio: don't defer probe forever if PHY IRQ provider is missing
      Revert "net: dsa: setup master before ports"
      net: dsa: felix: fix tagging protocol changes with multiple CPU ports

Wei Li (1):
      platform/x86: acerhdf: Cleanup str_starts_with()

Xiaoke Wang (2):
      drm/msm/disp: check the return value of kzalloc()
      drm/msm/mdp5: check the return of kzalloc()

Xin Long (1):
      sctp: use the correct skb for security_sctp_assoc_request

Yassine Oudjana (1):
      power: supply: Reset err after not finding static battery

Yu Zhe (1):
      KVM: arm64: vgic: Remove unnecessary type castings

Yue Hu (6):
      docs: filesystems: caching/backend-api.rst: correct two
relinquish APIs use
      docs: filesystems: caching/backend-api.rst: fix an object withdrawn A=
PI
      fscache: Remove the cookie parameter from fscache_clear_page_bits()
      fscache: Move fscache_cookies_seq_ops specific code under CONFIG_PROC=
_FS
      fscache: Use wrapper fscache_set_cache_state() directly when relinqui=
shing
      fscache: remove FSCACHE_OLD_API Kconfig option

Zqiang (1):
      irq_work: use kasan_record_aux_stack_noalloc() record callstack
