Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E51D51F1C0
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 23:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232901AbiEHVNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 17:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiEHVNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 17:13:38 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E9DBE14
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 14:09:46 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id k27so14195471edk.4
        for <linux-kernel@vger.kernel.org>; Sun, 08 May 2022 14:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=aAdi9MflC4sj/HEyAwmG75KBagkvEzLzWwKM/VEYRUo=;
        b=MIWYoHumumBekCWXiKFRU73MAdRpGY8a7LQKIP25H1EWLZMzNGTGQd1exEOY0Swejo
         IZ17Ijk+MKUCICEg3Y407GQ2m53PhHSRzIT1c8rDKTBVDHu+LSEBPd+G7ESfeZNald45
         ORqt1i8aqsghIbbZvkQNqATOXwQlMyk/ZiMPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=aAdi9MflC4sj/HEyAwmG75KBagkvEzLzWwKM/VEYRUo=;
        b=jyFdZ8qNgjYkMp8d/Axo26nW+Sn7E2PO8cccGCWU+r9zNpmoa/z1pe+muUc5Yxd/ok
         SK1fj20gzl2CQ6ZAylDtsHSByHxam3taVBePIDOfLVGMMFa6Jfx/xyf4JzFxifbAE3ad
         NjPF6sNKoBV9ILavseW0Yej4mELDJDsdB2VBbRcvgq5gSX5zJHh2se21q1nnJ1IbZgyj
         CWJcS/hn8ZMfYbUxpWad66o8RQ6lcNpfYQhjMRqhTQywQTPGgj8HoT2ECFM7ZFrnLIoc
         HJ6FXgTqNsQvXU5UVR4GVnoE3MiH7/Ccd1LH2Ng05QqRBsj68j0ADX0TkDd1YLgT0Evc
         WnHQ==
X-Gm-Message-State: AOAM530IxzYdUhDk2PhKXcV2+eg7Zi2ukyfT5OSAWECpCOYF1QlCJCeY
        VKk8dkb6tl4PqN9lwbkYLBjl618zihmVwjiU
X-Google-Smtp-Source: ABdhPJwwh93YVVQRYPTcPFfNIeaZ07CJqSKH6L1pbMA9AJTT30h9qUnv7hXDKCpeHoIFQJZSY7tdRw==
X-Received: by 2002:aa7:c58e:0:b0:425:b5e3:6c51 with SMTP id g14-20020aa7c58e000000b00425b5e36c51mr14519445edq.99.1652044184935;
        Sun, 08 May 2022 14:09:44 -0700 (PDT)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id d12-20020a50fe8c000000b0042617ba637asm402011edt.4.2022.05.08.14.09.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 May 2022 14:09:44 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id t6so16961695wra.4
        for <linux-kernel@vger.kernel.org>; Sun, 08 May 2022 14:09:44 -0700 (PDT)
X-Received: by 2002:a5d:6d0b:0:b0:20c:4ec7:8e84 with SMTP id
 e11-20020a5d6d0b000000b0020c4ec78e84mr11186884wrq.281.1652044183685; Sun, 08
 May 2022 14:09:43 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 8 May 2022 14:09:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi0vqZQUAS67tBsJQW+dtt89m+dqA-Z4bOs8CH-mm8u2w@mail.gmail.com>
Message-ID: <CAHk-=wi0vqZQUAS67tBsJQW+dtt89m+dqA-Z4bOs8CH-mm8u2w@mail.gmail.com>
Subject: Linux 5.18-rc6
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

So 5.18 is looking like it's going to be one of the larger releases in
numbers of commits (we'll see where it ends up - it's going to be
neck-and-neck with 5.14 right now, but won't be as big as 5.13 was).
But despite the merge window being big, the release candidates have
generally been quite modest in size, and rc6 continues that trend. I
keep expecting the other shoe to drop, but 5.18 just seems to be quite
well-behaved.

Let's see if this jinxes it, but nothing looks particularly scary
here. rc6 looks to be mostly some driver updates (network drivers and
rdma stand out, small random fixes elsewhere), with the usual
smattering of architecture updates (x86 kvm fixes, but also a
long-standing x86 kernel FP use issue, and a smattering of parisc and
powerpc fixes). And some wireguard selftest updates.

The rest is mostly some btrfs fixes, some core networking, and just
random small one-offs elsewhere.

Please do go test it all out - because things may look good now, but
continued testing is the only thing that will make sure.

Thanks,
               Linus

---

Adam Wujek (1):
      hwmon: (pmbus) disable PEC if not enabled

Ajit Kumar Pandey (1):
      ASoC: SOF: Fix NULL pointer exception in sof_pci_probe callback

Andreas Larsson (2):
      can: grcan: grcan_probe(): fix broken system id check for errata
workaround needs
      can: grcan: only use the NAPI poll budget for RX

Andrei Lalaev (1):
      gpiolib: of: fix bounds check for 'gpio-reserved-ranges'

Andr=C3=A9 Almeida (1):
      futex: MAINTAINERS, .mailmap: Update Andr=C3=A9's email address

Andy Chi (1):
      ALSA: hda/realtek: Enable mute/micmute LEDs support for HP Laptops

Ariel Levkovich (4):
      net/mlx5e: Fix wrong source vport matching on tunnel rule
      net/mlx5e: TC, Fix ct_clear overwriting ct action metadata
      net/mlx5e: TC, fix decap fallback to uplink when int port not support=
ed
      net/mlx5e: Avoid checking offload capability in post_parse action

Armin Wolf (1):
      hwmon: (adt7470) Fix warning on module removal

Arun Ramadoss (1):
      net: dsa: ksz9477: port mirror sniffing limited to one port

Ashish Mhetre (1):
      iommu: arm-smmu: disable large page mappings for Nvidia arm-smmu

Aya Levin (1):
      net/mlx5: Fix slab-out-of-bounds while reading resource dump menu

Bartosz Golaszewski (1):
      MAINTAINERS: update the GPIO git tree entry

Baruch Siach (1):
      gpio: mvebu: drop pwm base assignment

Bob Pearson (4):
      RDMA/rxe: Fix "Replace mr by rkey in responder resources"
      RDMA/rxe: Recheck the MR in when generating a READ reply
      RDMA/rxe: Do not call  dev_mc_add/del() under a spinlock
      RDMA/rxe: Change mcg_lock to a _bh lock

Brian Norris (1):
      mmc: core: Set HS clock speed before sending HS CMD13

Cheng Xu (1):
      RDMA/siw: Fix a condition race issue in MPA request processing

Chengfeng Ye (1):
      firewire: fix potential uaf in outbound_phy_packet_callback()

ChiYuan Huang (1):
      ASoC: rt9120: Correct the reg 0x09 size to one byte

Christian Borntraeger (1):
      KVM: s390: vsie/gmap: reduce gmap_rmap overhead

Chung-Chiang Cheng (2):
      btrfs: export a helper for compression hard check
      btrfs: do not allow compression on nodatacow files

Codrin Ciubotariu (2):
      ASoC: atmel: mchp-pdmc: set prepare_slave_config
      ASoC: dmaengine: Restore NULL prepare_slave_config() callback

Corey Minyard (2):
      ipmi: When handling send message responses, don't process the message
      ipmi:ipmi_ipmb: Fix null-ptr-deref in ipmi_unregister_smi()

Daniel Hellstrom (1):
      can: grcan: use ofdev->dev when allocating DMA memory

David Howells (1):
      rxrpc: Enable IPv6 checksums on transport socket

David Sterba (1):
      btrfs: sysfs: export the balance paused state of exclusive operation

David Stevens (1):
      iommu/vt-d: Calculate mask for non-aligned flushes

Denis Pauk (1):
      hwmon: (asus_wmi_sensors) Fix CROSSHAIR VI HERO name

Duoming Zhou (5):
      RDMA/irdma: Fix deadlock in irdma_cleanup_cm_core()
      can: grcan: grcan_close(): fix deadlock
      nfc: replace improper check device_is_registered() in netlink
related functions
      nfc: nfcmrvl: main: reorder destructive operations in
nfcmrvl_nci_unregister_dev to avoid bugs
      NFC: netlink: fix sleep in atomic bug when firmware download timeout

Eric Dumazet (3):
      net: igmp: respect RCU rules in ip_mc_source() and ip_mc_msfilter()
      mld: respect RCU rules in ip6_mc_source() and ip6_mc_msfilter()
      tcp: resalt the secret every 10 seconds

Fabien Parent (1):
      drm/bridge: ite-it6505: add missing Kconfig option select

Fenghua Yu (1):
      mm: Fix PASID use-after-free issue

Filipe Manana (4):
      btrfs: always log symlinks in full mode
      btrfs: do not BUG_ON() on failure to update inode when setting xattr
      btrfs: skip compression property for anything other than files and di=
rs
      btrfs: fix assertion failure when logging directory key range item

Guenter Roeck (1):
      hwmon: (xdpe12284) Fix build warning seen if
CONFIG_SENSORS_XDPE122_REGULATOR is disabled

Hangbin Liu (2):
      selftests/net: add missing tests to Makefile
      selftests/net/forwarding: add missing tests to Makefile

Haowen Bai (1):
      s390/dasd: Use kzalloc instead of kmalloc/memset

Haren Myneni (1):
      powerpc/pseries/vas: Use QoS credits from the userspace

Harry Wentland (1):
      drm/amd/display: Avoid reading audio pattern past AUDIO_CHANNELS_COUN=
T

Hector Martin (2):
      iommu/dart: Add missing module owner to ops structure
      dt-bindings: pci: apple,pcie: Drop max-link-speed from example

Helge Deller (10):
      Revert "parisc: Mark cr16 CPU clocksource unstable on all SMP machine=
s"
      Revert "parisc: Mark sched_clock unstable only if clocks are not
syncronized"
      Revert "parisc: Fix patch code locking and flushing"
      parisc: Only list existing CPUs in cpu_possible_mask
      parisc: Update 32- and 64-bit defconfigs
      parisc: Re-enable GENERIC_CPU_DEVICES for !SMP
      parisc: Merge model and model name into one line in /proc/cpuinfo
      parisc: Change MAX_ADDRESS to become unsigned long long
      parisc: Mark cr16 clock unstable on all SMP machines
      Revert "parisc: Increase parisc_cache_flush_threshold setting"

Hui Wang (1):
      ALSA: hda/realtek: Fix mute led issue on thinkpad with cs35l41 s-code=
c

Ido Schimmel (1):
      selftests: mirror_gre_bridge_1q: Avoid changing PVID while
interface is operational

Jakob Koschel (1):
      firewire: remove check of list iterator against head past the loop bo=
dy

Jan H=C3=B6ppner (2):
      s390/dasd: Fix read for ESE with blksize < 4k
      s390/dasd: Fix read inconsistency for ESE DASD devices

Janis Schoetterl-Glausch (1):
      KVM: s390: Fix lockdep issue in vm memop

Jann Horn (1):
      selftests/seccomp: Don't call read() on TTY from background pgrp

Jason A. Donenfeld (6):
      wireguard: selftests: make routing loop test non-fatal
      wireguard: selftests: limit parallelism to $(nproc) tests at once
      wireguard: selftests: use newer toolchains to fill out architectures
      wireguard: selftests: restore support for ccache
      wireguard: selftests: bump package deps
      wireguard: selftests: set panic_on_warn=3D1 from cmdline

Javier Martinez Canillas (1):
      fbdev: Make fb_release() return -ENODEV if fbdev was unregistered

Jens Axboe (1):
      io_uring: assign non-fixed early for async work

Ji-Ze Hong (Peter Hong) (1):
      hwmon: (f71882fg) Fix negative temperature

John Stultz (1):
      MAINTAINERS: Update email address for John Stultz

Josh Poimboeuf (1):
      MAINTAINERS: Update Josh Poimboeuf's email address

Julia Lawall (1):
      parisc: Fix typos in comments

Kajol Jain (1):
      powerpc/papr_scm: Fix buffer overflow issue with CONFIG_FORTIFY_SOURC=
E

Krzysztof Kozlowski (1):
      dt-bindings: ufs: cdns,ufshc: Add power-domains

Kuogee Hsieh (1):
      drm/msm/dp: remove fail safe mode related code

Kurt Kanzenbach (1):
      timekeeping: Mark NMI safe time accessors as notrace

Kyle Huey (1):
      KVM: x86/svm: Account for family 17h event renumberings in
amd_pmc_perf_hw_id

Linus Torvalds (1):
      Linux 5.18-rc6

Lu Baolu (1):
      iommu/vt-d: Drop stop marker messages

Maciej W. Rozycki (1):
      MIPS: Fix CP0 counter erratum detection for R4k CPUs

Marc Kleine-Budde (2):
      selftests/net: so_txtime: fix parsing of start time stamp on 32
bit systems
      selftests/net: so_txtime: usage(): fix documentation of default clock

Marek Marczykowski-G=C3=B3recki (1):
      drm/amdgpu: do not use passthrough mode in Xen dom0

Mark Bloch (1):
      net/mlx5: Fix matching on inner TTC

Mark Brown (8):
      ASoC: wm8958: Fix change notifications for DSP controls
      ASoC: da7219: Fix change notifications for tone generator frequency
      ASoC: meson: Fix event generation for AUI ACODEC mux
      ASoC: meson: Fix event generation for AUI CODEC mux
      ASoC: meson: Fix event generation for G12A tohdmi mux
      ASoC: max98090: Reject invalid values in custom control put()
      ASoC: max98090: Generate notifications on changes for custom control
      ASoC: ops: Validate input values in snd_soc_put_volsw_range()

Mark Zhang (1):
      net/mlx5e: Fix the calling of update_buffer_lossy() API

Matthew Hagan (1):
      net: sfp: Add tx-fault workaround for Huawei MA5671A SFP ONT

Matthew Wilcox (Oracle) (2):
      block: Do not call folio_next() on an unreferenced folio
      mm/readahead: Fix readahead with large folios

Michael Chan (2):
      bnxt_en: Initiallize bp->ptp_lock first before using it
      bnxt_en: Fix unnecessary dropping of RX packets

Michael Ellerman (1):
      powerpc/vdso: Fix incorrect CFI in gettimeofday.S

Ming Lei (1):
      Revert "block: release rq qos structures for queue without disk"

Moshe Shemesh (2):
      net/mlx5: Fix deadlock in sync reset flow
      net/mlx5: Avoid double clear or set of sync reset requested

Moshe Tal (1):
      net/mlx5e: Fix trust state reset in reload

Mustafa Ismail (1):
      RDMA/irdma: Fix possible crash due to NULL netdev in notifier

Naohiro Aota (2):
      btrfs: zoned: move non-changing condition check out of the loop
      btrfs: zoned: activate block group properly on unlimited active
zone device

Neil Armstrong (2):
      ASoC: meson: axg-tdm-interface: Fix formatters in trigger"
      ASoC: meson: axg-card: Fix nonatomic links

Nick Kossifidis (1):
      RISC-V: relocate DTB if it's outside memory region

Nicolin Chen (1):
      iommu/arm-smmu-v3: Fix size calculation in arm_smmu_mm_invalidate_ran=
ge()

Niels Dossche (2):
      firewire: core: extend card->lock in fw_core_handle_bus_reset
      net: mdio: Fix ENOMEM return value in BCM6368 mux bus controller

Nobuhiro Iwamatsu (1):
      gpio: visconti: Fix fwnode of GPIO IRQ

Olga Kornievskaia (1):
      SUNRPC release the transport of a relocated task with an
assigned transport

Oliver Hartkopp (1):
      can: isotp: remove re-binding of bound socket

Olivier Moysan (1):
      ASoC: simple-card-utils: fix sysclk shutdown

Paul Blakey (1):
      net/mlx5e: CT: Fix queued up restore put() executing after
relevant ft release

Peter Gonda (1):
      KVM: SEV: Mark nested locking of vcpu->lock

Pierre-Louis Bossart (1):
      ASoC: soc-ops: fix error handling

Puyou Lu (1):
      gpio: pca953x: fix irq_stat not updated when irq is disabled
(irq_mask not set)

Qiao Ma (1):
      hinic: fix bug of wq out of bound access

Qu Wenruo (1):
      btrfs: force v2 space cache usage for subpage mount

Rob Herring (4):
      dt-bindings: hwmon: ti,tmp421: Fix type for 'ti,n-factor'
      dt-bindings: leds-mt6360: Drop redundant 'unevaluatedProperties'
      dt-bindings: pinctrl: Allow values for drive-push-pull and
drive-open-drain
      dt-bindings: Drop redundant 'maxItems/minItems' in if/then schemas

Robin Murphy (1):
      iommu: Make sysfs robust for non-API groups

Russell King (Oracle) (1):
      net: dsa: b53: convert to phylink_pcs

Samuel Holland (1):
      mmc: sunxi-mmc: Fix DMA descriptors allocated above 32 bits

Sandipan Das (1):
      kvm: x86/cpuid: Only provide CPUID leaf 0xA if host has architectural=
 PMU

Sean Christopherson (4):
      KVM: x86/mmu: Don't treat fully writable SPTEs as volatile (modulo A/=
D)
      KVM: x86/mmu: Move shadow-present check out of spte_has_volatile_bits=
()
      KVM: x86/mmu: Use atomic XCHG to write TDP MMU SPTEs with volatile bi=
ts
      KVM: VMX: Exit to userspace if vCPU has injected exception and
invalid state

Sergey Shtylyov (1):
      smsc911x: allow using IRQ0

Shaik Sajida Bhanu (1):
      mmc: sdhci-msm: Reset GCC_SDCC_BCR register for SDHC

Shiraz Saleem (1):
      RDMA/irdma: Reduce iWARP QP destroy time

Shravya Kumbham (2):
      net: emaclite: Don't advertise 1000BASE-T and do auto negotiation
      net: emaclite: Add error handling for of_address_to_resource()

Somnath Kotur (1):
      bnxt_en: Fix possible bnxt_open() failure caused by wrong RFS flag

Stefan Haberland (2):
      s390/dasd: fix data corruption for ESE devices
      s390/dasd: prevent double format of tracks for ESE devices

Sven Schnelle (1):
      s390: disable -Warray-bounds

Takashi Sakamoto (1):
      ALSA: fireworks: fix wrong return count shorter than expected by 4 by=
tes

Tan Tee Min (1):
      net: stmmac: disable Split Header (SPH) for Intel platforms

Tatyana Nikolova (1):
      RDMA/irdma: Flush iWARP QP if modified to ERR from RTR state

Tetsuo Handa (1):
      net: rds: acquire refcount on TCP sockets

Thomas Gleixner (2):
      pci_irq_vector() can't be used in atomic context any longer.
This conflicts with the usage of this function in
nic_mbx_intr_handler().
      x86/fpu: Prevent FPU state corruption

Thomas Pfaff (1):
      genirq: Synchronize interrupt thread startup

Trond Myklebust (5):
      NFSv4: Don't invalidate inode attributes on delegation return
      SUNRPC: Don't leak sockets in xs_local_connect()
      SUNRPC: Ensure timely close of disconnected AF_LOCAL sockets
      SUNRPC: Ensure gss-proxy connects on setup
      Revert "SUNRPC: attempt AF_LOCAL connect on setup"

Vlad Buslov (4):
      net/mlx5e: Don't match double-vlan packets if cvlan is not set
      net/mlx5e: Lag, Fix use-after-free in fib event handler
      net/mlx5e: Lag, Fix fib_info pointer assignment
      net/mlx5e: Lag, Don't skip fib events on current dst

Vladimir Oltean (1):
      selftests: ocelot: tc_flower_chains: specify conform-exceed
action for policer

Willy Tarreau (9):
      secure_seq: use the 64 bits of the siphash for port offset calculatio=
n
      tcp: use different parts of the port_offset for index and offset
      tcp: add small random increments to the source port
      tcp: dynamically allocate the perturb table used by source ports
      tcp: increase source port perturb table to 2^16
      tcp: drop the hash_32() part from the index calculation
      floppy: use a statically allocated error counter
      ataflop: use a statically allocated error counters
      blk-mq: remove the error_count from struct request

Yang Yingliang (5):
      iommu/dart: check return value after calling platform_get_resource()
      net: ethernet: mediatek: add missing of_node_put() in mtk_sgmii_init(=
)
      net: dsa: mt7530: add missing of_node_put() in mt7530_setup()
      net: stmmac: dwmac-sun8i: add missing of_node_put() in
sun8i_dwmac_register_mdio_mux()
      net: cpsw: add missing of_node_put() in cpsw_probe_dt()

Zev Weiss (1):
      hwmon: (pmbus) delta-ahe50dc-fan: work around hardware quirk

Zihao Wang (1):
      ALSA: hda/realtek: Add quirk for Yoga Duet 7 13ITL6 speakers
