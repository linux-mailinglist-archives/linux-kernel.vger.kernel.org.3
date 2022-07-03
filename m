Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE3AC564A66
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 00:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbiGCWxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 18:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiGCWxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 18:53:42 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74BD4DF2
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 15:53:40 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id sb34so13718406ejc.11
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jul 2022 15:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=JjDTJafXrRoXEshNmSP7e7yXFJnzoMlCdqRn18KugXo=;
        b=aUNToCsOESv8UXlVKluNglCHaNIR+IQ1I54Y6VwMduS/ePjMer4zyWR/V1lFBZXBNd
         ec3bB1jKkdNPtOI0If0BFD94f+4uNGbs9XXadFDPBKSjO2jF8TcFuvYoypm+WJ3Qyatx
         k/+Lx9l9PKCvXm++3JDAKJlV015tGti0MBLVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=JjDTJafXrRoXEshNmSP7e7yXFJnzoMlCdqRn18KugXo=;
        b=owZ6MlPsDh/k32K57sP1hQYBRFwZDiICFc8ydioAW0yaAqp7IjYlDMDmr1GxPCh4tP
         8HuxToDRFrtN1vkF/YfcpYMeGVAY41LzCpeMOTjYWcvGfeGI5Si+g6Py8rn6eKgSXAtw
         j/ZbKq4slC91osRGdpQpn9qIg+VA4HS6iAXpj7Xj5qslI7JoZMULFXnbzQ9VbLdw3S5U
         m6o1bN6zgTXX795isYl1E9T7xgTZxeKEEMDGR1R5F2XPRU6KDQg/50cD+CedazNUScr3
         k8sizVFXOGzMT6A3YNAQ4QPuEwvhk5feW/T+x5V/B66NvUVKCqTpaaXq0bLL27f9z6sO
         6Ycw==
X-Gm-Message-State: AJIora9DFUkYD6LdTcOKnTkMt4Woy9eJQB7l0JnyUfh2tUTtprCOAVVP
        8krsiSiMMlHUSTA4ySoHGkOFMCdohphQzCqZ
X-Google-Smtp-Source: AGRyM1uLAqE+1BMnhCaZ8XdgAWxX6KX6nhBUL3jGvdHqbS2ooYbQL1WSgqaem0lijeJgbZBhQGgZjQ==
X-Received: by 2002:a17:906:6a14:b0:72a:b32c:e839 with SMTP id qw20-20020a1709066a1400b0072ab32ce839mr7284859ejc.468.1656888818583;
        Sun, 03 Jul 2022 15:53:38 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id h1-20020a1709063c0100b006feec47dae9sm13428861ejg.157.2022.07.03.15.53.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Jul 2022 15:53:38 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id b26so11012142wrc.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jul 2022 15:53:37 -0700 (PDT)
X-Received: by 2002:a05:6000:1f8d:b0:21b:aaec:ebae with SMTP id
 bw13-20020a0560001f8d00b0021baaecebaemr24770959wrb.274.1656888817462; Sun, 03
 Jul 2022 15:53:37 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 3 Jul 2022 15:53:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgAOr-+OWLGo+aCMjGWiJ8xMYXUm0v5f-G+eizmPa3kKw@mail.gmail.com>
Message-ID: <CAHk-=wgAOr-+OWLGo+aCMjGWiJ8xMYXUm0v5f-G+eizmPa3kKw@mail.gmail.com>
Subject: Linux 5.19-rc5
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So last week, we had a rc4 that was slightly larger than normal, and
while I thought it was mostly just due to timing and pull requests
shifting between rc's, I wanted to keep an eye on it.

And this week, we have an rc5 that is slightly _smaller_ than normal,
so it all pans out and really does just look like just random timing
noise.

So everything looks ok - we certainly have some issues still being
looked at, but on the whole 5.19 looks normal, and nothing
particularly bad seems to be going on.

See the shortlog below for details, but nothing here looks very odd.
It's the usual mixture of driver fixes, arch updates, filesystems and
networking. And associated tooling and selftests.

The diffstat shows a couple of blips - random number handling fix and
simplification in s390, a couple drivers, and some patches to fs code
that are not exactly one-liners (copy_file_range fix, some xfs fixes),
and some mptcp fixes.  But none of it is huge by any means, and most
of the rest of commits are one- or few-liners.

So in between the general summer vacation (Europe) and the July 4th
extended weekend (US), and whatever the rest of the world is doing -
take some time off, build a new kernel and boot it. Just to verify
things are looking ok for you. But it should all be pretty calm.

             Linus

---

Alan Adamson (1):
      nvmet: add a clear_ids attribute for passthru targets

Alex Deucher (2):
      drm/amdgpu: fix adev variable used in amdgpu_device_gpu_recover()
      Revert "drm/amdgpu/display: set vblank_disable_immediate for DC"

Alexey Khoroshilov (1):
      NFSD: restore EINVAL error translation in nfsd_commit()

Amir Goldstein (2):
      fanotify: refine the validation checks on non-dir inode mask
      vfs: fix copy_file_range() regression in cross-fs copies

Aneesh Kumar K.V (1):
      powerpc/memhotplug: Add add_pages override for PPC

AngeloGioacchino Del Regno (1):
      cpufreq: Add MT8186 to cpufreq-dt-platdev blocklist

Anshuman Gupta (1):
      drm/i915/dgfx: Disable d3cold at gfx root port

Arnaldo Carvalho de Melo (2):
      tools kvm headers arm64: Update KVM headers from the kernel sources
      tools headers UAPI: Sync linux/kvm.h with the kernel sources

Bo Liu (1):
      virtio: Remove unnecessary variable assignments

Carlos Llamas (1):
      drm/fourcc: fix integer type usage in uapi header

Casper Andersson (1):
      net: sparx5: mdb add/del handle non-sparx5 devices

Chris Ye (1):
      nvdimm: Fix badblocks clear off-by-one error

Christian Marangi (5):
      PM / devfreq: Fix kernel panic with cpu based scaling to passive gov
      PM / devfreq: Mute warning on governor PROBE_DEFER
      PM / devfreq: Fix cpufreq passive unregister erroring on PROBE_DEFER
      PM / devfreq: Rework freq_table to be local to devfreq struct
      PM / devfreq: Fix kernel warning with cpufreq passive register fail

Christophe JAILLET (1):
      ksmbd: smbd: Remove useless license text when
SPDX-License-Identifier is already used

Christophe Leroy (1):
      powerpc/book3e: Fix PUD allocation size in map_kernel_page()

Chuck Lever (1):
      SUNRPC: Fix READ_PLUS crasher

Coleman Dietsch (1):
      selftests net: fix kselftest net fatal error

Dan Carpenter (2):
      net: fix IFF_TX_SKB_NO_LINEAR definition
      platform/mellanox: nvsw-sn2201: fix error code in
nvsw_sn2201_create_static_devices()

Darrick J. Wong (6):
      xfs: always free xattri_leaf_bp when cancelling a deferred op
      xfs: clean up the end of xfs_attri_item_recover
      xfs: empty xattr leaf header blocks are not corruption
      xfs: don't hold xattr leaf buffers across transaction rolls
      xfs: dont treat rt extents beyond EOF as eofblocks to be cleared
      xfs: prevent a UAF when log IO errors race with unmount

Dave Chinner (2):
      xfs: bound maximum wait time for inodegc work
      xfs: introduce xfs_inodegc_push()

Deming Wang (1):
      virtio_ring: make vring_create_virtqueue_split prettier

Dimitris Michailidis (1):
      selftests/net: pass ipv6_args to udpgso_bench's IPv6 TCP test

Doug Berger (1):
      net: dsa: bcm_sf2: force pause link settings

Duoming Zhou (1):
      net: rose: fix UAF bugs caused by timer handler

Dylan Yudaken (1):
      io_uring: fix provided buffer import

Eddie James (1):
      hwmon: (occ) Prevent power cap command overwriting poll response

Eli Cohen (2):
      vdpa/mlx5: Update Control VQ callback information
      vdpa/mlx5: Initialize CVQ vringh only once

Enguerrand de Ribaucourt (2):
      net: dp83822: disable false carrier interrupt
      net: dp83822: disable rx error interrupt

Eric Dumazet (5):
      net: clear msg_get_inq in __sys_recvfrom() and __copy_msghdr_from_user()
      tcp: add a missing nf_reset_ct() in 3WHS handling
      tunnels: do not assume mac header is set in skb_tunnel_check_pmtu()
      net: bonding: fix possible NULL deref in rlb code
      ipv6: fix lockdep splat in in6_dump_addrs()

Florian Westphal (2):
      netfilter: nf_tables: avoid skb access on nf_stolen
      netfilter: br_netfilter: do not skip all hooks with 0 priority

Gayatri Kammela (1):
      platform/x86: intel/pmc: Add Alder Lake N support to PMC core driver

Geliang Tang (1):
      mptcp: invoke MP_FAIL response when needed

Hangyu Hua (1):
      net: tipc: fix possible refcount leak in tipc_sk_create()

Hans de Goede (7):
      platform/x86: ideapad-laptop: Add allow_v4_dytc module parameter
      platform/x86: ideapad-laptop: Add Ideapad 5 15ITL05 to
ideapad_dytc_v4_allow_table[]
      ACPI: video: Change how we determine if brightness key-presses are handled
      platform/x86: panasonic-laptop: sort includes alphabetically
      platform/x86: panasonic-laptop: revert "Resolve hotkey double trigger bug"
      platform/x86: panasonic-laptop: don't report duplicate
brightness key-presses
      platform/x86: panasonic-laptop: filter out duplicate volume
up/down/mute keypresses

Heinz Mauelshagen (1):
      dm raid: fix accesses beyond end of raid member array

Helge Deller (2):
      parisc/unaligned: Fix emulate_ldw() breakage
      parisc: Fix vDSO signal breakage on 32-bit kernel

Hyunchul Lee (1):
      ksmbd: remove duplicate flag set in smb2_write

Ian Rogers (1):
      perf bpf: 8 byte align bpil data

Ivan Babrou (1):
      perf unwind: Fix unitialized 'offset' variable on aarch64

Jakub Kicinski (4):
      net: tun: unlink NAPI from device on destruction
      net: tun: stop NAPI when detaching queues
      net: tun: avoid disabling NAPI twice
      selftest: tun: add test for NAPI dismantle

Jakub Sitnicki (1):
      selftests/bpf: Test sockmap update when socket has ULP

Jason A. Donenfeld (2):
      ksmbd: use vfs_llseek instead of dereferencing NULL
      s390/archrandom: simplify back to earlier design and initialize earlier

Jason Wang (3):
      virtio: disable notification hardening by default
      virtio-net: fix race between ndo_open() and virtio_device_ready()
      caif_virtio: fix race between virtio_device_ready() and ndo_open()

Javier Martinez Canillas (3):
      firmware: sysfb: Make sysfb_create_simplefb() return a pdev pointer
      firmware: sysfb: Add sysfb_disable() helper function
      fbdev: Disable sysfb device registration when removing conflicting FBs

Jean Delvare (1):
      platform/x86: thinkpad_acpi: Fix a memory leak of EFCH MMIO resource

Jeff Layton (1):
      ceph: wait on async create before checking caps for syncfs

Jiang Jian (2):
      hwmon: (pmbus/ucd9200) fix typos in comments
      s390/sclp: Fix typo in comments

Jianglei Nie (1):
      net: sfp: fix memory leak in sfp_probe()

Jinzhou Su (1):
      cpufreq: amd-pstate: Add resume and suspend callbacks

John Garry (2):
      scsi: hisi_sas: Limit max hw sectors for v3 HW
      ata: pata_cs5535: Fix W=1 warnings

Jose Alonso (1):
      net: usb: ax88179_178a: Fix packet receiving

Kai-Heng Feng (1):
      platform/x86: hp-wmi: Ignore Sanitization Mode event

Kaixu Xia (2):
      xfs: factor out the common lock flags assert
      xfs: use invalidate_lock to check the state of mmap_lock

Kamal Heib (1):
      RDMA/qedr: Fix reporting QP timeout attribute

Krzysztof Kozlowski (2):
      net/ncsi: use proper "mellanox" DT vendor prefix
      nfc: nfcmrvl: Fix irq_of_parse_and_map() return value

Kuogee Hsieh (1):
      drm/msm/dp: reset drm_dev to NULL at dp_display_unbind()

Lamarque Vieira Souza (1):
      nvme-pci: add NVME_QUIRK_BOGUS_NID for ADATA IM2P33F8ABR1

Liam Howlett (1):
      powerpc/prom_init: Fix kernel config grep

Liang He (3):
      net/dsa/hirschmann: Add missing of_node_get() in hellcreek_led_setup()
      drivers: cpufreq: Add missing of_node_put() in qoriq-cpufreq.c
      cpufreq: pmac32-cpufreq: Fix refcount leak bug

Linus Torvalds (3):
      sparse: introduce conditional lock acquire function attribute
      lockref: remove unused 'lockref_get_or_lock()' function
      Linux 5.19-rc5

Lukas Bulwahn (2):
      MAINTAINERS: add include/dt-bindings/clock to COMMON CLK FRAMEWORK
      PM / devfreq: passive: revert an editing accident in SPDX-License line

Lukas Wunner (1):
      net: phy: Don't trigger state machine while in suspend

Mark Pearson (2):
      platform/x86: thinkpad-acpi: profile capabilities as integer
      platform/x86: thinkpad_acpi: do not use PSC mode on Intel platforms

Masahiro Yamada (4):
      tick/nohz: unexport __init-annotated tick_nohz_full_setup()
      s390: remove unneeded 'select BUILD_BIN2C'
      s390/purgatory: hard-code obj-y in Makefile
      s390/purgatory: remove duplicated build rule of kexec-purgatory.o

Mat Martineau (1):
      selftests: mptcp: Initialize variables to quiet gcc 12 warnings

Matthew Auld (1):
      drm/i915: tweak the ordering in cpu_write_needs_clflush

Maxime Ripard (1):
      drm/vc4: perfmon: Fix variable dereferenced before check

Miaoqian Lin (2):
      RDMA/cm: Fix memory leak in ib_cm_insert_listen
      PM / devfreq: exynos-ppmu: Fix refcount leak in of_get_devfreq_events

Michael Walle (3):
      MAINTAINERS: nfc: drop Charles Gorand from NXP-NCI
      NFC: nxp-nci: Don't issue a zero length i2c_master_read()
      NFC: nxp-nci: don't print header length mismatch on i2c error

Mikulas Patocka (2):
      dm raid: fix KASAN warning in raid5_remove_disk
      dm raid: fix KASAN warning in raid5_add_disks

Namhyung Kim (4):
      perf offcpu: Fix build failure on old kernels
      perf offcpu: Accept allowed sample types only
      perf synthetic-events: Don't sort the task scan result from /proc
      perf synthetic-events: Ignore dead threads during event synthesis

Namjae Jeon (3):
      ksmbd: use SOCK_NONBLOCK type for kernel_accept()
      ksmbd: set the range of bytes to zero without extending file
size in FSCTL_ZERO_DATA
      ksmbd: check invalid FileOffset and BeyondFinalZero in FSCTL_ZERO_DATA

Nathan Lynch (1):
      powerpc/xive/spapr: correct bitmap allocation size

Naveen N. Rao (1):
      powerpc/bpf: Fix use of user_pt_regs in uapi

NeilBrown (1):
      NFS: restore module put when manager exits.

Nicolas Dichtel (1):
      ipv6: take care of disable_policy when restoring routes

Oleksij Rempel (3):
      net: asix: fix "can't send until first packet is send" issue
      net: usb: asix: do not force pause frames support
      net: phy: ax88772a: fix lost pause advertisement configuration

Oliver Neukum (1):
      usbnet: fix memory allocation in helpers

Ossama Othman (1):
      mptcp: fix conflict with <netinet/in.h>

Pablo Greco (1):
      nvme-pci: add NVME_QUIRK_BOGUS_NID for ADATA XPG SX6000LNP (AKA
SPECTRIX S40G)

Pablo Neira Ayuso (1):
      netfilter: nft_dynset: restore set element counter when failing to update

Paolo Abeni (6):
      mptcp: fix error mibs accounting
      mptcp: introduce MAPPING_BAD_CSUM
      mptcp: fix shutdown vs fallback race
      mptcp: consistent map handling on failure
      mptcp: fix race on unaccepted mptcp sockets
      selftests: mptcp: more stable diag tests

Parav Pandit (1):
      vduse: Tie vduse mgmtdev and its device

Pavel Begunkov (1):
      io_uring: keep sendrecv flags in ioprio

Petr Machata (1):
      mlxsw: spectrum_router: Fix rollback in tunnel next hop init

Rob Clark (1):
      drm/msm/gem: Fix error return on fence id alloc fail

Ruili Ji (1):
      drm/amdgpu: To flush tlb for MMHUB of RAVEN series

Ruozhu Li (1):
      nvme: fix regression when disconnect a recovering ctrl

Sagi Grimberg (2):
      nvmet-tcp: fix regression in data_digest calculation
      nvme-tcp: always fail a request when sending it failed

Scott Mayhew (1):
      NFSv4: Add an fattr allocation to _nfs4_discover_trunking()

Shreenidhi Shedi (1):
      octeon_ep: use bitwise AND

Stefan Seyfried (1):
      platform/x86: panasonic-laptop: de-obfuscate button codes

Stefano Garzarella (1):
      vhost-vdpa: call vhost_vdpa_cleanup during the release

Stephan Gerhold (2):
      virtio_mmio: Add missing PM calls to freeze/restore
      virtio_mmio: Restore guest page size on resume

Stephen Boyd (2):
      drm/msm/dpu: Increment vsync_cnt before waking up userspace
      cpufreq: qcom-hw: Don't do lmh things without a throttle interrupt

Sumeet Pawnikar (1):
      thermal: intel_tcc_cooling: Add TCC cooling support for RaptorLake

Tao Liu (1):
      linux/dim: Fix divide by 0 in RDMA DIM

Tom Lendacky (1):
      crypto: ccp - Fix device IRQ counting by using platform_irq_count()

Tong Zhang (1):
      epic100: fix use after free on rmmod

Victor Nogueira (2):
      net/sched: act_api: Notify user space if any actions were
flushed before error
      selftests: tc-testing: Add testcases to test new flush behaviour

Vladimir Oltean (1):
      net: dsa: felix: fix race between reading PSFP stats and port stats

Wei Yongjun (1):
      clk: stm32: rcc_reset: Fix missing spin_lock_init()

Will Deacon (1):
      arm64: hugetlb: Restore TLB invalidation for BBM on contiguous ptes

Xin Long (1):
      tipc: move bc link creation back to tipc_node_create

Yang Yingliang (1):
      hwmon: (ibmaem) don't call platform_device_del() if
platform_device_add() fails

Yevhen Orlov (1):
      net: bonding: fix use-after-free after 802.3ad slave unbind

Yicong Yang (1):
      PM / devfreq: passive: Use HZ_PER_KHZ macro in units.h

YueHaibing (1):
      net: ipv6: unexport __init-annotated seg6_hmac_net_init()

Zhang Jiaming (1):
      s390/qdio: Fix spelling mistake

huangjie.albert (1):
      virtio_ring : keep used_wrap_counter in vq->last_used_idx

katrinzhou (2):
      drm/i915/gem: add missing else
      ipv6/sit: fix ipip6_tunnel_get_prl return value

sunliming (1):
      drm/msm/dpu: Fix variable dereferenced before check

wuchi (1):
      lib/sbitmap: Fix invalid loop in __sbitmap_queue_get_batch()
