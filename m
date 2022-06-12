Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9DAC547CF0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 01:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237823AbiFLXgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 19:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232350AbiFLXgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 19:36:42 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5F056B3F
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 16:36:40 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id o7so8029951eja.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 16:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=z6DUI1BS+xluR5dJXmFJ7vvNzWyJyRYpr1Lz3xMrsFg=;
        b=G94iDnHjLUQniiBtUh/YlivTQ2GNun41jINygLl5zM854C4O7aI6cO1cp9KuVbAiko
         cDZSRc4ittO6dZCrSMQISac4mvVGNAJ/ieR4oVqNicPA2N5N9da4TJnvcpMxtT8OxOAb
         ooprVIS0bJzg+CXWeC03A04VWNdFYQtOHH26o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=z6DUI1BS+xluR5dJXmFJ7vvNzWyJyRYpr1Lz3xMrsFg=;
        b=Ls00eYMqdjFF67sfuUPc4JS1SI795Co0JOuEmYhjgLTjBQoG4mFMJwhQ01dOPYXRC1
         OgbI+QVCpDpQ7B9VLlHMDWkjcRL6XaeeSa7Jpej92Nf0lqTXxWgLvMDHzWSbxtr8dUVP
         pP1iP/0ZXGnXGx7+lHHKAT/SIBU57ZDTylRezjhF2vUkJCSDr2gvW3eiIvJAGDA5Cvtw
         AA6kwPkrK6XE0GjFvOE9dPtTf8DjXCQL53rIq0PCXcGQqL+SMUIUSWj02AuEGLDAfrNC
         iaA6/V/RvbVEanQ9779srMMhdqI00tZwqYmZKfbJzMoQo/9LPWteU8wQ9cA4u7hIwCdb
         jnZg==
X-Gm-Message-State: AOAM531EYZbnkrdHP47HmYLjke6lqS/xyScozqweUauzCG9K+O8bBIzf
        v8oUwsa2//cB1V0FCjr6vHVYiGLcRKqSAXd+
X-Google-Smtp-Source: ABdhPJwmaSRic4QRyzgc5jSIjdF44TWgSNM+VB9BjKLBqSwDbyfp0Z0ywFAsFZWVa08ngzs30g5j/w==
X-Received: by 2002:a17:906:729c:b0:715:702f:1e4a with SMTP id b28-20020a170906729c00b00715702f1e4amr7303400ejl.731.1655076998172;
        Sun, 12 Jun 2022 16:36:38 -0700 (PDT)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id za14-20020a170906878e00b00706c1327f4bsm3056199ejb.23.2022.06.12.16.36.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jun 2022 16:36:37 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id e5so2085889wma.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 16:36:37 -0700 (PDT)
X-Received: by 2002:a05:600c:4ec9:b0:39c:69c7:715d with SMTP id
 g9-20020a05600c4ec900b0039c69c7715dmr11224813wmq.154.1655076997006; Sun, 12
 Jun 2022 16:36:37 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 12 Jun 2022 16:36:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiLDbZ9ch9vSLxrYBdr-bBujr5sehH_HszWzSah54UiQw@mail.gmail.com>
Message-ID: <CAHk-=wiLDbZ9ch9vSLxrYBdr-bBujr5sehH_HszWzSah54UiQw@mail.gmail.com>
Subject: Linux 5.19-rc2
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

It's Sunday afternoon, so it must be time for another release candidate.

As usual, rc2 is fairly small, and there isn't really a ton going on
here. Fixes spread all over, and the diffstat is fairly flat apart
from a few notable things that had bigger changes: some amdgpu fixes,
the xen stub iommu driver, and some ceph and zonefs fixes. The rest is
all pretty much one- or few-liners spread out mostly everywhere.

And yes, because I expected the rc2 week to be fairly quiet, I did a
system update on my workstation, and as a result I spent a day or two
then sorting out most of the fallout from the resulting compiler
upgrade to gcc-12. Some of it ended up being a bit heavy-handed, and
we'll be tweaking things further. And some of it ends up being an
actual compiler misfeature, but it's being discussed too and is
limited to just one file on the 32-bit i386 side (and does not seem to
result in any actual bad code, just excessive stack use).

Anyway, nothing hugely scary going on, let's just keep testing and
fixing things.

                   Linus

---

Adam Ford (1):
      ASoC: wm8962: Fix suspend while playing music

Adrian Hunter (1):
      mmc: block: Fix CQE recovery reset success

Alejandro Tafalla (1):
      arm64/sysreg: Fix typo in Enum element regex

Alex Deucher (1):
      drm/amdgpu: update VCN codec support for Yellow Carp

Alexey Kardashevskiy (1):
      KVM: Don't null dereference ops->destroy

Alvin (1):
      drm/amd/display: Don't clear ref_dtbclk value

Alvin =C5=A0ipraga (1):
      net: dsa: realtek: rtl8365mb: fix GMII caps for ports with internal P=
HY

Amadeusz S=C5=82awi=C5=84ski (1):
      ASoC: SOF: Fix potential NULL pointer dereference

Andre Przywara (1):
      dt-bindings: display: arm,malidp: remove bogus RQOS property

Andrea Mayer (1):
      net: seg6: fix seg6_lookup_any_nexthop() to handle VRFs using flowi_l=
3mdev

Andy Shevchenko (7):
      gpio: crystalcove: make irq_chip immutable
      gpio: crystalcove: Use specific type and API for IRQ number
      gpio: crystalcove: Join function declarations and long lines
      gpio: wcove: make irq_chip immutable
      gpio: merrifield: make irq_chip immutable
      gpio: sch: make irq_chip immutable
      gpio: dln2: make irq_chip immutable

Aric Cyr (1):
      drm/amd/display: 3.2.187

Arnd Bergmann (1):
      au1000_eth: stop using virt_to_bus()

August Wikerfors (1):
      platform/x86: gigabyte-wmi: Add support for B450M DS3H-CF

Aurabindo Pillai (1):
      drm/amd/display: remove stale config guards

Bedant Patnaik (1):
      platform/x86: hp-wmi: Use zero insize parameter only when supported

Ben Chuang (1):
      mmc: sdhci-pci-gli: Fix GL9763E runtime PM when the system
resumes from suspend

Ben Gardon (1):
      KVM: x86/MMU: Zap non-leaf SPTEs when disabling dirty logging

Bo Liu (1):
      virtio: Fix all occurences of the "the the" typo

Brian Norris (2):
      drm/bridge: analogix_dp: Support PSR-exit to disable transition
      drm/atomic: Force bridge self-refresh-exit on CRTC switch

Cameron Berkenpas (1):
      ALSA: hda/realtek: Fix for quirk to enable speaker output on the
Lenovo Yoga DuetITL 2021

Candice Li (1):
      drm/amdgpu: Resolve RAS GFX error count issue after cold boot on Arct=
urus

Catalin Marinas (1):
      arm64: Add kasan_hw_tags_enable() prototype to silence sparse

Charles Keepax (6):
      ASoC: cs42l52: Fix TLV scales for mixer controls
      ASoC: cs35l36: Update digital volume TLV
      ASoC: cs53l30: Correct number of volume levels on SX controls
      ASoC: cs42l52: Correct TLV for Bypass Volume
      ASoC: cs42l56: Correct typo in minimum level for SX volume controls
      ASoC: cs42l51: Correct minimum value for SX volume control

Chen Lin (1):
      net: ethernet: mtk_eth_soc: fix misuse of mem alloc interface
netdev[napi]_alloc_frag

Chengguang Xu (2):
      scsi: ipr: Fix missing/incorrect resource cleanup in error case
      scsi: pmcraid: Fix missing resource cleanup in error case

Christian K=C3=B6nig (2):
      drm/amdgpu: fix limiting AV1 to the first instance on VCN3
      drm/amdgpu: always flush the TLB on gfx8

Christoph Hellwig (3):
      swiotlb: fix setting ->force_bounce
      dm: fix bio_set allocation
      block: remove bioset_init_from_src

Christophe JAILLET (1):
      stmmac: intel: Fix an error handling path in intel_eth_pci_probe()

Chuck Lever (7):
      NFSD: Fix potential use-after-free in nfsd_file_put()
      SUNRPC: Trap RDMA segment overflows
      SUNRPC: Fix the calculation of xdr->end in xdr_get_next_encode_buffer=
()
      SUNRPC: Optimize xdr_reserve_space()
      SUNRPC: Clean up xdr_commit_encode()
      SUNRPC: Clean up xdr_get_next_encode_buffer()
      SUNRPC: Remove pointer type casts from xdr_get_next_encode_buffer()

Damien Le Moal (3):
      zonefs: fix handling of explicit_open option on mount
      zonefs: Do not ignore explicit_open with active zone limit
      zonefs: fix zonefs_iomap_begin() for reads

Dan Carpenter (5):
      ASoC: SOF: ipc-msg-injector: Propagate write errors correctly
      ASoC: SOF: ipc-msg-injector: Fix reversed if statement
      bpf: Use safer kvmalloc_array() where possible
      vdpa/mlx5: fix error code for deleting vlan
      vdpa/mlx5: clean up indenting in handle_ctrl_vlan()

David Arcari (1):
      platform/x86/intel: Fix pmt_crashlog array reference

David Howells (5):
      netfs: Fix gcc-12 warning by embedding vfs inode in netfs_i_context
      certs: Convert spaces in certs/Makefile to a tab
      afs: Fix some checker issues
      netfs: Rename the netfs_io_request cleanup op and give it an op point=
er
      iov_iter: Fix iter_xarray_get_pages{,_alloc}()

David Safford (1):
      KEYS: trusted: tpm2: Fix migratable logic

Dmitry Osipenko (2):
      kernel/reboot: Use static handler for register_platform_power_off()
      kernel/reboot: Fix powering off using a non-syscall code paths

Duke Lee (1):
      platform/x86/intel: hid: Add Surface Go to VGBS allow list

Eric Dumazet (1):
      bpf, arm64: Clear prog->jited_len along prog->jited

Etienne van der Linde (1):
      nfp: flower: restructure flow-key for gre+vlan combination

Evan Quan (2):
      drm/amd/pm: suppress compile warnings about possible unaligned access=
es
      drm/amdgpu: suppress the compile warning about 64 bit type

Fei Qin (1):
      nfp: avoid unnecessary check warnings in nfp_app_get_vf_config

Feras Daoud (1):
      net/mlx5: Rearm the FW tracer after each tracer event

Florian Westphal (1):
      netfilter: nat: really support inet nat without l3 address

Gal Pressman (1):
      net/mlx4_en: Fix wrong return value on ioctl EEPROM query failure

Geert Uytterhoeven (1):
      platform/mellanox: Spelling s/platfom/platform/

George D Sworo (1):
      platform/x86/intel: pmc: Support Intel Raptorlake P

Guchun Chen (1):
      Revert "drm/amdgpu: Ensure the DMA engine is deactivated during set u=
ps"

Hannes Reinecke (1):
      ata: libata: drop 'sas_last_tag'

He Ying (1):
      powerpc/kasan: Silence KASAN warnings in __get_wchan()

Helge Deller (1):
      scsi: mpt3sas: Fix out-of-bounds compiler warning

Huacai Chen (2):
      LoongArch: Fix the !CONFIG_SMP build
      LoongArch: Fix copy_thread() build errors

Hui Wang (1):
      ASoC: nau8822: Add operation for internal PLL off and on

Hung, Cruise (1):
      drm/amd/display: Fix DMUB outbox trace in S4 (#4465)

Ilya (1):
      drm/amd/display: Fix possible infinite loop in DP LT fallback

Ilya Maximets (1):
      net: openvswitch: fix misuse of the cached connection on tuple change=
s

James Smart (9):
      scsi: lpfc: Correct BDE type for XMIT_SEQ64_WQE in lpfc_ct_reject_eve=
nt()
      scsi: lpfc: Resolve some cleanup issues following abort path refactor=
ing
      scsi: lpfc: Resolve some cleanup issues following SLI path refactorin=
g
      scsi: lpfc: Address NULL pointer dereference after starget_to_rport()
      scsi: lpfc: Resolve NULL ptr dereference after an ELS LOGO is aborted
      scsi: lpfc: Fix port stuck in bypassed state after LIP in PT2PT topol=
ogy
      scsi: lpfc: Add more logging of cmd and cqe information for
aborted NVMe cmds
      scsi: lpfc: Allow reduced polling rate for
nvme_admin_async_event cmd completion
      scsi: lpfc: Update lpfc version to 14.2.0.4

Jan Beulich (1):
      x86: drop bogus "cc" clobber from __try_cmpxchg_user_asm()

Jason A. Donenfeld (8):
      LoongArch: Remove MIPS comment about cycle counter
      random: avoid checking crng_ready() twice in random_init()
      random: mark bootloader randomness code as __init
      random: account for arch randomness in bits
      random: do not use jump labels before they are initialized
      random: credit cpu and bootloader seeds by default
      random: remove rng_has_arch_random()
      wireguard: selftests: use maximum cpu features and allow rng seeding

Jason Wang (2):
      virtio-rng: make device ready before making request
      vdpa: make get_vq_group and set_group_asid optional

Jchao Sun (1):
      writeback: Fix inode->i_io_list not be protected by inode->i_lock err=
or

Jeff Layton (1):
      MAINTAINERS: reciprocal co-maintainership for file locking and nfsd

Jeremy Soller (1):
      ALSA: hda/realtek: Add quirk for HP Dev One

Jesse Zhang (1):
      drm/amdkfd:Fix fw version for 10.3.6

Jiapeng Chong (1):
      drm/amdgpu: make program_imu_rlc_ram static

Jiasheng Jiang (1):
      platform/x86: barco-p50-gpio: Add check for platform_driver_register

Jonathan Corbet (1):
      docs: Move the HTE documentation to driver-api/

Jonathan Neusch=C3=A4fer (1):
      workqueue: Switch to new kerneldoc syntax for named variable
macro argument

Jorge Lopez (1):
      platform/x86: hp-wmi: Resolve WMI query failures on some devices

Joseph Greathouse (1):
      drm/amdgpu: Add MODE register to wave debug info in gfx11

Juergen Gross (5):
      kernel: add platform_has() infrastructure
      virtio: replace arch_has_restricted_virtio_memory_access()
      xen/grants: support allocating consecutive grants
      xen/grant-dma-ops: Add option to restrict memory access under Xen
      xen/virtio: Enable restricted memory access using Xen grant mappings

Justin Stitt (1):
      net: amd-xgbe: fix clang -Wformat warning

Justin Swartz (1):
      docs: usb: fix literal block marker in usbmon verification example

Kevin Locke (1):
      kbuild: avoid regex RS for POSIX awk

Krishna Manikandan (1):
      dt-bindings: msm: update maintainers list with proper id

Krzysztof Kozlowski (1):
      dt-bindings: vendor-prefixes: document deprecated Atheros

Kuan-Ying Lee (1):
      scripts/gdb: change kernel config dumping method

Kuniyuki Iwashima (1):
      af_unix: Fix a data-race in unix_dgram_peer_wake_me().

Lang Yu (1):
      drm/amdkfd: add pinned BOs to kfd_bo_list

Leung, Martin (1):
      drm/amd/display: revert Blank eDP on disable/enable drv

Lina Wang (1):
      selftests net: fix bpf build error

Linus Torvalds (9):
      cert host tools: Stop complaining about deprecated OpenSSL functions
      drm: imx: fix compiler warning with gcc-12
      gcc-12: disable '-Wdangling-pointer' warning for now
      mellanox: mlx5: avoid uninitialized variable warning with gcc-12
      gcc-12: disable '-Warray-bounds' universally for now
      netfs: gcc-12: temporarily disable '-Wattribute-warning' for now
      netfs: Further cleanups after struct netfs_inode wrapper introduced
      iov_iter: fix build issue due to possible type mis-match
      Linux 5.19-rc2

Luca Ceresoli (1):
      dt-bindings: update Luca Ceresoli's e-mail address

Lukas Bulwahn (2):
      MAINTAINERS: rectify entries for ARM DRM DRIVERS after dt conversion
      MAINTAINERS: adjust MELLANOX ETHERNET INNOVA DRIVERS to TLS
support removal

Maciej Fijalkowski (1):
      xsk: Fix handling of invalid descriptors in XSK TX batching API

Marek Beh=C3=BAn (1):
      net: dsa: mv88e6xxx: use BMSR_ANEGCOMPLETE bit for filling an_complet=
e

Marek Vasut (1):
      drm/bridge: ti-sn65dsi83: Handle dsi_lanes =3D=3D 0 as invalid

Mario Limonciello (1):
      drm/amdkfd: Add GC 10.3.6 and 10.3.7 KFD definitions

Marius Hoch (1):
      Input: soc_button_array - also add Lenovo Yoga Tablet2 1051F to
dmi_use_low_level_irq

Mark Bloch (2):
      net/mlx5: E-Switch, pair only capable devices
      net/mlx5: fs, fail conflicting actions

Mark Brown (5):
      ASoC: es8328: Fix event generation for deemphasis control
      ASoC: wm_adsp: Fix event generation for wm_adsp_fw_put()
      arm64/sme: Fix tests for 0b1111 value ID registers
      arm64/sme: Fix SVE/SME typo in ABI documentation
      arm64/sme: Fix EFI save/restore

Martin Faltesek (3):
      nfc: st21nfca: fix incorrect validating logic in EVT_TRANSACTION
      nfc: st21nfca: fix memory leaks in EVT_TRANSACTION handling
      nfc: st21nfca: fix incorrect sizing calculations in EVT_TRANSACTION

Masahiro Yamada (7):
      powerpc/book3e: get rid of #include <generated/compile.h>
      xen: unexport __init-annotated xen_xlate_map_ballooned_pages()
      scripts/nsdeps: adjust to the format change of *.mod files
      net: mdio: unexport __init-annotated mdio_bus_init()
      net: xfrm: unexport __init-annotated xfrm4_protocol_init()
      net: ipv6: unexport __init-annotated seg6_hmac_init()
      scripts/check-local-export: avoid 'wait $!' for process substitution

Mathias Nyman (1):
      Input: bcm5974 - set missing URB_NO_TRANSFER_DMA_MAP urb flag

Matthew Wilcox (Oracle) (5):
      quota: Prevent memory allocation recursion while holding dq_lock
      filemap: Don't release a locked folio
      filemap: Cache the value of vm_flags
      mm/huge_memory: Fix xarray node memory leak
      mm: Add kernel-doc for folio->mlock_count

Mauro Carvalho Chehab (8):
      dt-bindings: mfd: bd9571mwv: update rohm,bd9571mwv.yaml reference
      dt-bindings: interrupt-controller: update brcm,l2-intc.yaml reference
      dt-bindings: arm: update vexpress-config.yaml references
      dt-bindings: reset: update st,stih407-powerdown.yaml references
      dt-bindings: mfd: rk808: update rockchip,rk808.yaml reference
      MAINTAINERS: update cortina,gemini-ethernet.yaml reference
      MAINTAINERS: update dongwoon,dw9807-vcm.yaml reference
      MAINTAINERS: update snps,axs10x-reset.yaml reference

Maxim Levitsky (1):
      KVM: SVM: fix tsc scaling cache logic

Maxim Mikityanskiy (1):
      tls: Rename TLS_INFO_ZC_SENDFILE to TLS_INFO_ZC_TX

Miaoqian Lin (4):
      ata: pata_octeon_cf: Fix refcount leak in octeon_cf_probe
      net: ethernet: bgmac: Fix refcount leak in bcma_mdio_mii_register
      net: dsa: lantiq_gswip: Fix refcount leak in gswip_gphy_fw_list
      net: altera: Fix refcount leak in altera_tse_mdio_create

Michael Ellerman (3):
      powerpc: Don't select HAVE_IRQ_EXIT_ON_IRQ_STACK
      powerpc/kasan: Force thread size increase with KASAN
      powerpc/32: Fix overread/overwrite of thread_struct via ptrace

Michael Shych (1):
      platform/mellanox: Add static in struct declaration.

Mike Snitzer (1):
      dm: fix zoned locking imbalance due to needless check in clone_endio

Mohammad Zafar Ziya (1):
      drm/amdgpu/jpeg2: Add jpeg vmid update under IB submit

Muchun Song (1):
      tcp: use alloc_large_system_hash() to allocate table_perturb

Nicholas Kazlauskas (2):
      drm/amd/display: Pass the new context into disable OTG WA
      Revert "drm/amd/display: Pass the new context into disable OTG WA"

Oleksandr Tyshchenko (5):
      arm/xen: Introduce xen_setup_dma_ops()
      dt-bindings: Add xen,grant-dma IOMMU description for xen-grant DMA op=
s
      xen/grant-dma-iommu: Introduce stub IOMMU driver
      xen/grant-dma-ops: Retrieve the ID of backend's domain for DT devices
      arm/xen: Assign xen-grant DMA ops for xen-grant DMA devices

Olivier Matz (2):
      ixgbe: fix bcast packets Rx on VF after promisc removal
      ixgbe: fix unexpected VLAN Rx in promisc mode on VF

Pablo Neira Ayuso (6):
      netfilter: nf_tables: use kfree_rcu(ptr, rcu) to release hooks
in clean_net path
      netfilter: nf_tables: delete flowtable hooks via transaction list
      netfilter: nf_tables: always initialize flowtable hook list in transa=
ction
      netfilter: nf_tables: release new hooks on unsupported flowtable flag=
s
      netfilter: nf_tables: memleak flow rule from commit path
      netfilter: nf_tables: bail out early if hardware offload is not suppo=
rted

Paolo Bonzini (2):
      KVM: x86: do not set st->preempted when going back to user space
      KVM: x86: do not report a vCPU as preempted outside instruction bound=
aries

Paul Blakey (1):
      net/mlx5e: CT: Fix cleanup of CT before cleanup of TC ct rules

Paul Mackerras (1):
      powerpc/kasan: Mark more real-mode code as not to be instrumented

Paulo Alcantara (1):
      cifs: fix reconnect on smb3 mount types

Peter Zijlstra (1):
      cpuidle,intel_idle: Fix CPUIDLE_FLAG_IRQ_ENABLE

Philip Yang (3):
      drm/amdkfd: Use mmget_not_zero in MMU notifier
      drm/amdgpu: Update PDEs flush TLB if PTB/PDB moved
      drm/amdkfd: Fix partial migration bugs

Piotr Chmura (1):
      platform/x86: gigabyte-wmi: Add Z690M AORUS ELITE AX DDR4 support

Quentin Monnet (1):
      MAINTAINERS: Add a maintainer for bpftool

Randy Dunlap (1):
      Input: raspberrypi-ts - add missing HAS_IOMEM dependency

Rob Clark (1):
      dma-debug: make things less spammy under memory pressure

Rob Herring (4):
      dt-bindings: mmc: Fix unevaluatedProperties warnings in examples
      dt-bindings: nvme: apple,nvme-ans: Drop 'maxItems' from 'apple,sart'
      dt-bindings: Drop more redundant 'maxItems/minItems' in if/then schem=
as
      dt-bindings: pinctrl: ralink: Fix 'enum' lists with duplicate entries

Roger Knecht (1):
      crc-itu-t: fix typo in CRC ITU-T polynomial comment

Roman Li (1):
      drm/amdgpu: fix aper_base for APU

Russell King (Oracle) (2):
      net: dsa: mv88e6xxx: fix BMSR error to be consistent with others
      net: dsa: mv88e6xxx: correctly report serdes link failure

Saeed Mahameed (1):
      Revert "net/mlx5e: Allow relaxed ordering over VFs"

Serge Semin (1):
      gpio: dwapb: Don't print error on -EPROBE_DEFER

Sergey Shtylyov (3):
      ata: libata-core: fix NULL pointer deref in ata_host_alloc_pinfo()
      ata: libata-transport: fix {dma|pio|xfer}_mode sysfs files
      MAINTAINERS: add ATA sysfs file documentation to libata entry

Seth Forshee (1):
      entry/kvm: Exit to user mode when TIF_NOTIFY_SIGNAL is set

Shaoqin Huang (1):
      KVM: x86/mmu: Check every prev_roots in __kvm_mmu_free_obsolete_roots=
()

Shengjiu Wang (1):
      ASoC: fsl_sai: Add support for i.MX8MN

Sherry Wang (1):
      drm/amd/display: Read Golden Settings Table from VBIOS

Shyam Prasad N (2):
      cifs: return errors during session setup during reconnects
      cifs: populate empty hostnames for extra channels

Simon Horman (1):
      docs: arm: tcm: Fix typo in description of TCM and MMU usage

Srinivasa Rao Mandadapu (1):
      ASoC: qcom: lpass-platform: Update VMA access permissions in mmap cal=
lback

Stanley.Yang (1):
      drm/amdgpu: fix ras supported check

Steven Price (1):
      drm/panfrost: Job should reference MMU not file_priv

Sunil Khatri (1):
      drm/amdgpu: enable tmz by default for GC 10.3.7

Taehee Yoo (3):
      amt: fix wrong usage of pskb_may_pull()
      amt: fix possible null-ptr-deref in amt_rcv()
      amt: fix wrong type string definition

Takashi Iwai (2):
      ALSA: usb-audio: Skip generic sync EP parse for secondary EP
      ALSA: usb-audio: Set up (implicit) sync for Saffire 6

Tan Tee Min (1):
      net: phy: dp83867: retrigger SGMII AN when link change

Tetsuo Handa (1):
      workqueue: Wrap flush_workqueue() using a macro

Thomas Zimmermann (1):
      drm/ast: Support multiple outputs

Toke H=C3=B8iland-J=C3=B8rgensen (2):
      bpf: Fix calling global functions from BPF_PROG_TYPE_EXT programs
      selftests/bpf: Add selftest for calling global functions from freplac=
e

Tyler Erickson (3):
      scsi: sd: Fix interpretation of VPD B9h length
      libata: fix reading concurrent positioning ranges log
      libata: fix translation of concurrent positioning ranges

Vaibhav Jain (1):
      powerpc/papr_scm: don't requests stats with '0' sized stats buffer

Vincent Whitchurch (1):
      um: virt-pci: set device ready in probe()

Vitaly Kuznetsov (1):
      KVM: selftests: Make hyperv_clock selftest more stable

Wang Yufen (2):
      ipv6: Fix signed integer overflow in __ip6_append_data
      ipv6: Fix signed integer overflow in l2tp_ip6_sendmsg

Wentao Wang (1):
      scsi: vmw_pvscsi: Expand vcpuHint to 16 bits

Wesley Cheng (1):
      dt-bindings: Update QCOM USB subsystem maintainer information

Willem de Bruijn (1):
      ip_gre: test csum_start instead of transport header

Wonhyuk Yang (1):
      workqueue: Fix type of cpu in trace event

Xiang wangx (3):
      fs: Fix syntax errors in comments
      vdpa/mlx5: Fix syntax errors in comments
      arm64/fpsimd: Fix typo in comment

Xiaohui Zhang (1):
      nfc: nfcmrvl: Fix memory leak in nfcmrvl_play_deferred

Xie Yongji (2):
      vringh: Fix loop descriptors check in the indirect cases
      vduse: Fix NULL pointer dereference on sysfs access

Yifan Zhang (1):
      drm/amdgpu/mes: only invalid/prime icache when finish loading
both pipe MES FWs.

Yong Zhi (1):
      ALSA: hda: MTL: add HD Audio PCI ID and HDMI codec vendor ID

Yupeng Li (1):
      MIPS: Loongson-3: fix compile mips cpu_hwmon as module build error.

Zheng Zengkai (1):
      Documentation/features: Update the arch support status files

chengkaitao (1):
      virtio-mmio: fix missing put_device() when vm_cmdline_parent
registration failed

hengzhou (1):
      drm/amd/display: Wait DMCUB to idle state before reset.

huangwenhui (2):
      ALSA: hda/conexant - Fix loopback issue with CX20632
      ALSA: hda/realtek - Add HW8326 support

sunliming (2):
      drm/amdgpu: fix a missing break in gfx_v11_0_handle_priv_fault
      drm/amdgpu: make gfx_v11_0_rlc_stop static

xliu (1):
      ASoC: Intel: cirrus-common: fix incorrect channel mapping
