Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83C750D5B4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 00:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239784AbiDXW0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 18:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239671AbiDXW0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 18:26:21 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9DB83CA69
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 15:23:18 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id p10so23206171lfa.12
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 15:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=tRw3tDtAxMXd/SW1cS9Ht567rligj3Dzoe66oNaPgxQ=;
        b=RaCAzv/TshG/c9CawhVkE2z9WuY48rQronBALGokJTG/4Yva4uRKIsOngWbXDKevw7
         4HhlSw+Xi8uUB5u2Frey+5ShkiOJhDtJs2HwYVtx3d3y36yeueIfmt6bm7jjE+YTemYg
         nutA3GhVosCVmxbQLdc/oU7Nu8QDvwSy+e7YA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=tRw3tDtAxMXd/SW1cS9Ht567rligj3Dzoe66oNaPgxQ=;
        b=A4brlwwwAkJzNj31RhgDpCSDKADyzAqvEm2nzpyHihtKyaFg4fQfwO0QB/tN4Pg2df
         csHqTDTTAsgl9HPIz5X9bwMMEo3A8xFiEidHXXpPLM/Ovn6WesbhgJBLap4Ugy3lNA6S
         Nvj4j9hP+kMJTaPioZVtsQWdz3IUpP7rAhMQ0wI1if0YVe6gQv7ROVrJaxu6lgR1fTfM
         inoop5Ry+XUIy8VtkryDR7CAQMb95RIrdE851K7xRl68y4CCAWZhSyf5mTLvIo1CNrX0
         O0XwbVS/TigehU1w5kBZ8/XN6QrZujs4rGwq6cO3MAD0MV0cqa2pxSwa2Il3y9DmIKCi
         OUkQ==
X-Gm-Message-State: AOAM533A1qWFWmGdnBpFRCapJneGBAeO88fN3Eu+P2omut2am2RX/AU8
        wg6Ouzz1ktr6owr5TPxyVN72XIlUgK1SjboDzw4=
X-Google-Smtp-Source: ABdhPJyAPGlmE17vwuF1KITaFcZfGTNVErgwXC5d+ZvFhVX9o8uht8eleSKUqVwH94GOrxcXVLDv2g==
X-Received: by 2002:a19:ac4d:0:b0:46b:ae5b:83dd with SMTP id r13-20020a19ac4d000000b0046bae5b83ddmr10786613lfc.557.1650838996513;
        Sun, 24 Apr 2022 15:23:16 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id g3-20020a2e9e43000000b00244c60deb14sm1015065ljk.15.2022.04.24.15.23.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Apr 2022 15:23:16 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id g19so23242779lfv.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 15:23:16 -0700 (PDT)
X-Received: by 2002:ac2:5084:0:b0:471:ccb3:8c99 with SMTP id
 f4-20020ac25084000000b00471ccb38c99mr11062349lfm.435.1650838995558; Sun, 24
 Apr 2022 15:23:15 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 24 Apr 2022 15:22:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=whmtHMzjaVUF9bS+7vE_rrRctcCTvsAeB8fuLYcyYLN-g@mail.gmail.com>
Message-ID: <CAHk-=whmtHMzjaVUF9bS+7vE_rrRctcCTvsAeB8fuLYcyYLN-g@mail.gmail.com>
Subject: Linux 5.18-rc4
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fairly slow and calm week - which makes me just suspect that the other
shoe will drop at some point.

But maybe things are just going really well this release. It's bound
to happen _occasionally_, after all.

It's not only a fairly small set of commits, the diffstat is pretty
small and flat too. The biggest single patch is literally killing off
a zombie file that had already been deleted - well, renamed, really -
once, but it didn't know to stay dead, and was resurrected by a merge
mistake.

The changes are sprinkled all over, they just aren't all that big:
arch updates (sound being the bulk of it, but "bulk" really is fairly
misleading), some driver updates, a couple of filesystem fixes, memory
management, networking, and some tooling (mainly a couple of
selftests).

Scroll through the shortlog below for an overview of the changes.

                  Linus

---

Ahmad Fatoum (1):
      ASoC: fsl_sai: fix 1:1 bclk:mclk ratio support

Ajye Huang (1):
      ASoC: Intel: sof_rt5682: Add support for max98360a speaker amp on SSP=
2

Alaa Mohamed (1):
      xen: Convert kmap() to kmap_local_page()

Aleksandr Nogikh (1):
      kcov: don't generate a warning on vm_insert_page()'s failure

Alexey Kardashevskiy (2):
      KVM: PPC: Fix TCE handling for VFIO
      powerpc/perf: Fix 32bit compile

Alistair Popple (1):
      mm/mmu_notifier.c: fix race in mmu_interval_notifier_remove()

Allen-KH Cheng (1):
      spi: spi-mtk-nor: initialize spi controller after resume

Andy Chi (1):
      ALSA: hda/realtek: Enable mute/micmute LEDs and limit mic boost
on EliteBook 845/865 G9

Anup Patel (1):
      RISC-V: mm: Fix set_satp_mode() for platform not having Sv57

Arun Ramadoss (1):
      net: phy: LAN937x: added PHY_POLL_CABLE_TEST flag

Athira Rajeev (2):
      powerpc/perf: Fix power9 event alternatives
      powerpc/perf: Fix power10 event alternatives

Atish Patra (2):
      RISC-V: KVM: Remove 's' & 'u' as valid ISA extension
      RISC-V: KVM: Restrict the extensions that can be disabled

Bang Li (1):
      ARC: remove redundant READ_ONCE() in cmpxchg loop

Bjorn Andersson (2):
      Revert "drm: of: Properly try all possible cases for
bridge/panel detection"
      Revert "drm: of: Lookup if child node has panel or bridge"

Chao Song (1):
      ASoC: Intel: soc-acpi: correct device endpoints for max98373

Christian Brauner (2):
      fs: fix acl translation
      fs: unset MNT_WRITE_HOLD on failure

Christian K=C3=B6nig (2):
      drm/radeon: fix logic inversion in radeon_sync_resv
      drm/amdgpu: partial revert "remove ctx->lock" v2

Christophe JAILLET (3):
      ASoC: soc-pcm: use GFP_KERNEL when the code is sleepable
      ASoC: codecs: Fix an error handling path in (rx|tx|va)_macro_probe()
      ARC: Remove a redundant memset()

Christophe Leroy (1):
      mm, hugetlb: allow for "high" userspace addresses

Coly Li (2):
      bcache: put bch_bio_map() back to correct location in
journal_write_unlocked()
      bcache: fix wrong bdev parameter when calling bio_alloc_clone()
in do_bio_hook()

Darrick J. Wong (1):
      ext4: fix fallocate to use file_modified to update permissions
consistently

Dave Jiang (6):
      dmaengine: idxd: fix device cleanup on disable
      dmaengine: idxd: match type for retries var in idxd_enqcmds()
      dmaengine: idxd: fix retry value to be constant for duration of
function call
      dmaengine: idxd: add RO check for wq max_batch_size write
      dmaengine: idxd: add RO check for wq max_transfer_size write
      dmaengine: idxd: skip clearing device context when device is read-onl=
y

Dave Stevenson (2):
      drm/panel/raspberrypi-touchscreen: Avoid NULL deref if not initialise=
d
      drm/panel/raspberrypi-touchscreen: Initialise the bridge in prepare

David Ahern (3):
      xfrm: Pass flowi_oif or l3mdev as oif to xfrm_dst_lookup
      l3mdev: l3mdev_master_upper_ifindex_by_index_rcu should be using
netdev_master_upper_dev_get_rcu
      net: Handle l3mdev in ip_tunnel_init_flow

David Howells (1):
      rxrpc: Restore removed timer deletion

Dmitry Baryshkov (1):
      drm/msm: Revert "drm/msm: Stop using iommu_present()"

Duoming Zhou (2):
      arch: xtensa: platforms: Fix deadlock in rs_close()
      drivers: net: hippi: Fix deadlock in rr_close()

Eric Dumazet (4):
      net/sched: cls_u32: fix netns refcount changes in u32_change()
      net/sched: cls_u32: fix possible leak in u32_init_knode()
      ipv6: make ip6_rt_gc_expire an atomic_t
      netlink: reset network and mac headers in netlink_dump()

Gongjun Song (1):
      ALSA: hda: intel-dsp-config: Add RaptorLake PCI IDs

Guilherme Amadio (1):
      perf clang: Fix header include for LLVM >=3D 14

Guo Ren (1):
      xtensa: patch_text: Fixup last cpu should be master

Hangbin Liu (1):
      net/packet: fix packet_sock xmit return value checking

Hans de Goede (1):
      Documentation/ABI: sysfs-fs-erofs: Fix Sphinx errors

Haowen Bai (1):
      cifs: Use kzalloc instead of kmalloc/memset

Heiner Kallweit (2):
      ASoC: soc-core: add debugfs_prefix member to snd_soc_component_driver
      ASoC: meson: aiu: fix duplicate debugfs directory error

Herve Codina (1):
      dmaengine: dw-edma: Fix unaligned 64bit access

Hongyu Jin (1):
      erofs: fix use-after-free of on-stack io[]

Horatiu Vultur (1):
      net: lan966x: Make sure to release ptp interrupt

Hui Wang (2):
      ASoC: cs35l41: Add one more variable in the debug log
      ASoC: cs35l41: Fix a shift-out-of-bounds warning found by UBSAN

Ido Schimmel (2):
      selftests: mlxsw: vxlan_flooding: Prevent flooding of unwanted packet=
s
      selftests: mlxsw: vxlan_flooding_ipv6: Prevent flooding of
unwanted packets

Jens Axboe (1):
      io_uring: free iovec if file assignment fails

Jianglei Nie (1):
      ice: Fix memory leak in ice_get_orom_civd_data()

Jiapeng Chong (1):
      dmaengine: dw-edma: Fix inconsistent indenting

Jos=C3=A9 Roberto de Souza (1):
      drm/i915/display/psr: Unset enable_psr2_sel_fetch if other
checks in intel_psr2_config_valid() fails

Julia Lawall (1):
      ARC: fix typos in comments

Kai Vehmanen (2):
      ALSA: hda/hdmi: fix warning about PCM count when used with SOF
      ALSA: hda/hdmi: add HDMI codec VID for Raptorlake-P

Karol Herbst (1):
      dma-buf-map: remove renamed header file

Ken Kurematsu (1):
      arm64: fix typos in comments

Kevin Groeneveld (1):
      dmaengine: imx-sdma: fix init of uart scripts

Kevin Hao (1):
      net: stmmac: Use readl_poll_timeout_atomic() in atomic state

Krzysztof Kozlowski (2):
      ARC: dts: align SPI NOR node name with dtschema
      nfc: MAINTAINERS: add Bug entry

Kurt Kanzenbach (1):
      net: dsa: hellcreek: Calculate checksums in tagger

Leo Yan (2):
      perf script: Always allow field 'data_src' for auxtrace
      perf report: Set PERF_SAMPLE_DATA_SRC bit for Arm SPE event

Like Xu (1):
      KVM: x86/pmu: Update AMD PMC sample period to fix guest NMI-watchdog

Linus Torvalds (3):
      Revert "fs/pipe: use kvcalloc to allocate a pipe_buffer array"
      kvmalloc: use vmalloc_huge for vmalloc allocations
      Linux 5.18-rc4

Lucas De Marchi (1):
      ALSA: hda/i915: Fix one too many pci_dev_put()

Maciej Fijalkowski (2):
      ice: xsk: check if Rx ring was filled up to the end
      ice: allow creating VFs for !CONFIG_NET_SWITCHDEV

Manasi Navare (1):
      drm/i915/display/vrr: Reset VRR capable property on a long hpd

Manuel Ullmann (1):
      net: atlantic: invert deep par in pm functions, preventing null deref=
s

Mario Limonciello (1):
      gpio: Request interrupts after IRQ is initialized

Mark Brown (1):
      ASoC: atmel: Remove system clock tree configuration for at91sam9g20ek

Matthew Wilcox (Oracle) (2):
      tools: Add kmem_cache_alloc_lru()
      XArray: Disallow sibling entries of nodes

Matthias Schiffer (1):
      spi: cadence-quadspi: fix incorrect supports_op() return value

Maurizio Avogadro (1):
      ALSA: usb-audio: add mapping for MSI MAG X570S Torpedo MAX.

Mauro Carvalho Chehab (3):
      ASoC: Intel: sof_es8336: support a separate gpio to control headphone
      ASoC: Intel: sof_es8336: add a quirk for headset at mic1 port
      ASoC: Intel: sof_es8336: Add a quirk for Huawei Matebook D15

Max Filippov (1):
      xtensa: fix a7 clobbering in coprocessor context load/store

Miaoqian Lin (6):
      ASoC: rk817: Use devm_clk_get() in rk817_platform_probe
      ASoC: msm8916-wcd-digital: Check failure for
devm_snd_soc_register_component
      dmaengine: imx-sdma: Fix error checking in sdma_event_remap
      Input: omap4-keypad - fix pm_runtime_get_sync() error checking
      drm/vc4: Use pm_runtime_resume_and_get to fix pm_runtime_get_sync() u=
sage
      arm/xen: Fix some refcount leaks

Michael Ellerman (1):
      powerpc/time: Always set decrementer in timer_interrupt()

Mika Westerberg (1):
      spi: intel: Add support for Raptor Lake-S SPI serial flash

Mikulas Patocka (1):
      x86: __memcpy_flushcache: fix wrong alignment if size > 2^32

Miles Chen (1):
      sound/oss/dmasound: fix 'dmasound_setup' defined but not used

Mingwei Zhang (2):
      KVM: SVM: Flush when freeing encrypted pages even on SME_COHERENT CPU=
s
      KVM: SEV: add cache flush to solve SEV cache incoherency issues

Muchun Song (1):
      arm64: mm: fix p?d_leaf()

Nadav Amit (1):
      userfaultfd: mark uffd_wp regardless of VM_WRITE flag

Namjae Jeon (3):
      ksmbd: remove filename in ksmbd_file
      ksmbd: increment reference count of parent fp
      ksmbd: set fixed sector size to FS_SECTOR_SIZE_INFORMATION

Naoya Horiguchi (1):
      mm/hwpoison: fix race between hugetlb free/demotion and
memory_failure_hugetlb()

Nathan Chancellor (1):
      arm64: Improve HAVE_DYNAMIC_FTRACE_WITH_REGS selection for clang

Nicholas Piggin (1):
      mm/vmalloc: huge vmalloc backing pages should be split rather
than compound

Nico Pache (1):
      oom_kill.c: futex: delay the OOM reaper to allow time for proper
futex cleanup

Nicolas Dichtel (1):
      doc/ip-sysctl: add bc_forwarding

Oliver Hartkopp (1):
      can: isotp: stop timeout monitoring when no first frame was sent

Paolo Bonzini (2):
      kvm: selftests: do not use bitfields larger than 32-bits for PTEs
      kvm: selftests: introduce and use more page size-related constants

Paolo Valerio (1):
      openvswitch: fix OOB access in reserve_sfa_size()

Paulo Alcantara (2):
      cifs: fix NULL ptr dereference in refresh_mounts()
      cifs: use correct lock type in cifs_reconnect()

Pavel Begunkov (1):
      io_uring: fix leaks on IOPOLL and CQE_SKIP

Peilin Ye (2):
      ip6_gre: Avoid updating tunnel->tun_hlen in __gre6_xmit()
      ip6_gre: Fix skb_under_panic in __gre6_xmit()

Peter Ujfalusi (2):
      ASoC: topology: Correct error handling in soc_tplg_dapm_widget_create=
()
      ASoC: SOF: topology: Fix memory leak of scontrol->name

Pierre-Louis Bossart (3):
      ASoC: rt711/5682: check if bus is active before deferred jack detecti=
on
      ASoC: SOF: topology: cleanup dailinks on widget unload
      ASoC: Intel: sof_es8336: simplify speaker gpio naming

Randy Dunlap (3):
      cpuidle: riscv: support non-SMP config
      RISC-V: cpuidle: fix Kconfig select for RISCV_SBI_CPUIDLE
      sparc: cacheflush_32.h needs struct page

Richard Fitzgerald (2):
      ASoC: simple-card-utils: Avoid NULL deref in asoc_simple_set_tdm()
      firmware: cs_dsp: Fix overrun of unterminated control name string

Rob Herring (1):
      arm_pmu: Validate single/group leader events

Rolf Eike Beer (1):
      arc: drop definitions of pgd_index() and pgd_offset{, _k}() entirely

Ronnie Sahlberg (1):
      cifs: destage any unwritten data to the server before calling
copychunk_write

Sabrina Dubroca (1):
      esp: limit skb_page_frag_refill use to a single page

Sasha Neftin (3):
      igc: Fix infinite loop in release_swfw_sync
      igc: Fix BUG: scheduling while atomic
      e1000e: Fix possible overflow in LTR decoding

Sean Christopherson (9):
      KVM: x86: Don't re-acquire SRCU lock in complete_emulated_io()
      KVM: RISC-V: Use kvm_vcpu.srcu_idx, drop RISC-V's unnecessary copy
      KVM: Add helpers to wrap vcpu->srcu_idx and yell if it's abused
      KVM: Initialize debugfs_dentry when a VM is created to avoid NULL der=
ef
      KVM: x86: Tag APICv DISABLE inhibit, not ABSENT, if APICv is disabled
      KVM: nVMX: Defer APICv updates while L2 is active until L1 is active
      KVM: x86: Pend KVM_REQ_APICV_UPDATE during vCPU creation to fix a rac=
e
      KVM: x86: Skip KVM_GUESTDBG_BLOCKIRQ APICv update if APICv is disable=
d
      KVM: SVM: Simplify and harden helper to flush SEV guest page(s)

Sergey Matyukevich (2):
      ARC: entry: fix syscall_trace_exit argument
      ARC: atomic: cleanup atomic-llsc definitions

Shakeel Butt (1):
      memcg: sync flush only if periodic flush is delayed

Shelby Heffron (1):
      Input: add Marine Navigation Keycodes

Shubhrajyoti Datta (1):
      EDAC/synopsys: Read the error count from the correct register

Sidhartha Kumar (4):
      selftest/vm: verify mmap addr in mremap_test
      selftest/vm: verify remap destination address in mremap_test
      selftest/vm: support xfail in mremap_test
      selftest/vm: add skip support to mremap_test

Song Liu (2):
      vmalloc: replace VM_NO_HUGE_VMAP with VM_ALLOW_HUGE_VMAP
      page_alloc: use vmalloc_huge for large system hash

Srinivas Kandagatla (1):
      ASoC: codecs: wcd934x: do not switch off SIDO Buck when codec is in u=
se

Stephen Hemminger (1):
      net: restore alpha order to Ethernet devices in config

Sukadev Bhattiprolu (1):
      powerpc: Update MAINTAINERS for ibmvnic and VAS

Tadeusz Struk (1):
      ext4: limit length to bitmap_maxbytes - blocksize in punch_hole

Takashi Iwai (1):
      ALSA: usb-audio: Clear MIDI port active flag after draining

Theodore Ts'o (3):
      ext4: fix overhead calculation to account for the reserved gdt blocks
      ext4: force overhead calculation if the s_overhead_cluster makes no s=
ense
      ext4: update the cached overhead value in the superblock

Thomas Huth (1):
      KVM: selftests: Silence compiler warning in the kvm_page_table_test

Thomas Richter (1):
      perf test: Fix error message for test case 71 on s390, where it
is not supported

Tim Crawford (1):
      ALSA: hda/realtek: Add quirk for Clevo NP70PNP

Tom Rix (2):
      scsi: sr: Do not leak information in ioctl
      KVM: SPDX style and spelling fixes

Tony Lu (1):
      net/smc: Fix sock leak when release after smc_shutdown()

Tudor Ambarus (1):
      spi: atmel-quadspi: Fix the buswidth adjustment between spi-mem
and controller

Vincenzo Frascino (1):
      MAINTAINERS: add Vincenzo Frascino to KASAN reviewers

Vinicius Costa Gomes (1):
      igc: Fix suspending when PTM is active

Vinod Koul (1):
      dt-bindings: dmaengine: qcom: gpi: Add minItems for interrupts

Vladimir Oltean (1):
      net: mscc: ocelot: fix broken IP multicast flooding

Wanpeng Li (1):
      x86/kvm: Preserve BSP MSR_KVM_POLL_CONTROL across suspend/resume

Wojciech Drewek (1):
      ice: fix crash in switchdev mode

Xiaomeng Tong (4):
      codecs: rt5682s: fix an incorrect NULL check on list iterator
      ASoC: soc-dapm: fix two incorrect uses of list iterator
      ASoC: rt5682: fix an incorrect NULL check on list iterator
      dma: at_xdmac: fix a missing check on list iterator

Xu Yu (1):
      mm/memory-failure.c: skip huge_zero_page in memory_failure()

Ye Bin (4):
      ext4: fix symlink file size not match to file content
      ext4: fix bug_on in start_this_handle during umount filesystem
      ext4: fix use-after-free in ext4_search_dir
      jbd2: fix a potential race while discarding reserved buffers
after an abort

Yu Liao (1):
      ASoC: SOF: topology: Fix memory leak in sof_control_load()

Zack Rusin (1):
      drm/vmwgfx: Fix gem refcounting and memory evictions

Zhang Rui (1):
      perf/x86/cstate: Add SAPPHIRERAPIDS_X CPU support

Zheng Bin (1):
      drm/vc4: Fix build error when CONFIG_DRM_VC4=3Dy &&
CONFIG_RASPBERRYPI_FIRMWARE=3Dm

Zheyu Ma (3):
      ASoC: wm8731: Disable the regulator when probing fails
      Input: cypress-sf - register a callback to disable the regulators
      ata: pata_marvell: Check the 'bmdma_addr' beforing reading

Zhipeng Xie (1):
      perf/core: Fix perf_mmap fail when CONFIG_PERF_USE_VMALLOC enabled

kuyo chang (1):
      sched/pelt: Fix attach_entity_load_avg() corner case

suresh kumar (1):
      bonding: do not discard lowest hash bit for non layer3+4 hashing

wangjianjian (C) (1):
      ext4, doc: fix incorrect h_reserved size

zhangqilong (1):
      dmaengine: mediatek:Fix PM usage reference leak of
mtk_uart_apdma_alloc_chan_resources
