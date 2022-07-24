Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB2D057F714
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 22:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbiGXUml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 16:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiGXUmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 16:42:39 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB789D129
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 13:42:37 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id fy29so17092364ejc.12
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 13:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=q7aIKgEkk4TUrRIy5QkUx8aNXNWDG+x3OjbFDP7vTvY=;
        b=bpe0i5n/UlXADz4MwvmbVQc80d1jWajhCOD63N31aHzczIqNlDj7iuxG9KDllBgB4X
         2cqYnZ7zWUIp90gulvT3SZW9ilGbYAZ3IkgyuTwqD26jbkUPBBANNXz891WYDmN4KrRT
         OGVNYhvYCi7v45evvJlrBoy6UuUIPsvu/5OUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=q7aIKgEkk4TUrRIy5QkUx8aNXNWDG+x3OjbFDP7vTvY=;
        b=w0FNDpOHCgRaJIK+J0eG77LWEjwh29aIxbUJAa8+8JViml5qr5+IrK56cM6AWgmA7D
         +xKZ2PHnUpbRBgTpkhssB2evd90CDgq8DRjj0m0BKXZiq2QOk3nupe7haiNGRXDceagc
         4D8D5aB5nI9Ki8QHiLLnTJVDwrvSP2qi//NjX+z8C1X2A/LzvAc40KGeZ9jBkA0w6l8d
         /ZfuHWZRBWHMHtGRAcdJzsyT9R8SUkIJd0u3MyugT86h68nPBnJE5Gs57n7Ei8vdJYzA
         3doJAX0XYTnmmfzN9UHAARVthNZD04brIMLw8OCMiDG2NpmbP8QUh8Ajh6cxv7yEserD
         ZxPg==
X-Gm-Message-State: AJIora8V9OtiCZwQT7T8MaQ3sfF5o1nJ9tZI/hA+IJHcR/zvX7lo8iZY
        85K88vwv2cABXh75NrsbMfsRrd3EWbTXdVKX
X-Google-Smtp-Source: AGRyM1uEzvcFoz+vS3t7ymb73u1hOJGHxjVk30zMlGtXap8WpDwtFviuMiMNS1BGM6CfbZUh1fSQPw==
X-Received: by 2002:a17:907:94c3:b0:72f:3f8b:d628 with SMTP id dn3-20020a17090794c300b0072f3f8bd628mr7525365ejc.313.1658695355740;
        Sun, 24 Jul 2022 13:42:35 -0700 (PDT)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id g2-20020a170906538200b0072b1bb3cc08sm4586331ejo.120.2022.07.24.13.42.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Jul 2022 13:42:35 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id k11so12964010wrx.5
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 13:42:35 -0700 (PDT)
X-Received: by 2002:a5d:59a4:0:b0:21e:8704:ea35 with SMTP id
 p4-20020a5d59a4000000b0021e8704ea35mr1955387wrr.442.1658695354444; Sun, 24
 Jul 2022 13:42:34 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 24 Jul 2022 13:42:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiWwDYxNhnStS0e+p-NTFAQSHvab=2-8LwxunCVuY5-2A@mail.gmail.com>
Message-ID: <CAHk-=wiWwDYxNhnStS0e+p-NTFAQSHvab=2-8LwxunCVuY5-2A@mail.gmail.com>
Subject: Linux 5.19-rc8
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

As already mentioned last week, this release is one of those "extra
week of rc" ones, and here we are, with release candidate #8.

There's nothing really surprising in here - a few smaller fixups for
the retbleed mess as expected, and the usual random one-liners
elsewhere.

The diffstat shows mainly some documentation updates and a couple of
drivers with bigger fixes (eg the i916 GuC firmware thing), and the
networking sysctl data-race annotations.

So it all just makes me go "yeah, I'm happy to have done another rc,
but there is nothing particularly interesting here". Which is all
fine. Shortlog appended for the curious among you.

We'll let this simmer for another week, and please do give it another
round of testing to make this last week count, ok?

                  Linus

---

Aaron Lewis (1):
      KVM: x86: Protect the unused bits in MSR exiting flags

Adam Borowski (1):
      certs: make system keyring depend on x509 parser

Alexandru Elisei (1):
      ASoC: rockchip: i2s: Fix NULL pointer dereference when pinctrl
is not found

Andy Shevchenko (1):
      gpiolib: cdev: Fix kernel doc for struct line

Ben Dooks (1):
      riscv: add as-options for modules with assembly compontents

Ben Hutchings (1):
      x86/speculation: Make all RETbleed mitigations 64-bit only

Biao Huang (3):
      stmmac: dwmac-mediatek: fix clock issue
      net: stmmac: fix pm runtime issue in stmmac_dvr_remove()
      net: stmmac: fix unbalanced ptp clock issue in suspend/resume flow

Biju Das (1):
      spi: spi-rspi: Fix PIO fallback on RZ platforms

Christian K=C3=B6nig (1):
      drm/ttm: fix locking in vmap/vunmap TTM GEM helpers

Dan Carpenter (1):
      md/raid5: missing error code in setup_conf()

Daniele Ceraolo Spurio (1):
      drm/i915/guc: support v69 in parallel to v70

Dawid Lukwinski (1):
      i40e: Fix erroneous adapter reinitialization during recovery process

Dmitry Osipenko (1):
      drm/scheduler: Don't kill jobs in interrupt context

Dylan Yudaken (2):
      io_uring: fix free of unallocated buffer list
      io_uring: do not recycle buffer in READV

Eric Snowberg (1):
      lockdown: Fix kexec lockdown bypass with ima policy

Flavio Suligoi (1):
      i2c: imx: fix typo in comment

Gavin Shan (1):
      KVM: selftests: Fix target thread to be migrated in rseq_test

Haibo Chen (3):
      gpio: pca953x: only use single read/write for No AI mode
      gpio: pca953x: use the correct range when do regmap sync
      gpio: pca953x: use the correct register address when regcache
sync during init

Hangyu Hua (1):
      xfrm: xfrm_policy: fix a possible double xfrm_pols_put() in
xfrm_bundle_lookup()

Hayes Wang (1):
      r8152: fix a WOL issue

Herve Codina (1):
      clk: lan966x: Fix the lan966x clock gate register address

Horatiu Vultur (7):
      pinctrl: ocelot: Fix pincfg for lan966x
      pinctrl: ocelot: Fix pincfg
      net: lan966x: Fix taking rtnl_lock while holding spin_lock
      net: lan966x: Fix usage of lan966x->mac_lock when entry is added
      net: lan966x: Fix usage of lan966x->mac_lock when entry is removed
      net: lan966x: Fix usage of lan966x->mac_lock inside
lan966x_mac_irq_handler
      net: lan966x: Fix usage of lan966x->mac_lock when used by FDB

Hristo Venev (1):
      be2net: Fix buffer overflow in be_get_module_eeprom

Ido Schimmel (1):
      mlxsw: spectrum_router: Fix IPv4 nexthop gateway indication

Jacky Bai (1):
      MAINTAINERS: Update freescale pin controllers maintainer

Josh Poimboeuf (1):
      lkdtm: Disable return thunks in rodata.c

Junxiao Chang (1):
      net: stmmac: fix dma queue left shift overflow issue

Juri Lelli (1):
      sched/deadline: Fix BUG_ON condition for deboosted tasks

Justin Stitt (1):
      net: ipv4: fix clang -Wformat warnings

Kan Liang (1):
      perf/x86/intel/lbr: Fix unchecked MSR access error on HSW

Kees Cook (1):
      x86/alternative: Report missing return thunk details

Kent Gibson (1):
      selftests: gpio: fix include path to kernel headers for out of tree b=
uilds

Khalid Masum (1):
      scripts/gdb: Fix gdb 'lx-symbols' command

Krzysztof Kozlowski (1):
      riscv: dts: align gpio-key node names with dtschema

Kuniyuki Iwashima (46):
      ip: Fix data-races around sysctl_ip_default_ttl.
      ip: Fix data-races around sysctl_ip_no_pmtu_disc.
      ip: Fix data-races around sysctl_ip_fwd_use_pmtu.
      ip: Fix data-races around sysctl_ip_fwd_update_priority.
      ip: Fix data-races around sysctl_ip_nonlocal_bind.
      ip: Fix a data-race around sysctl_ip_autobind_reuse.
      ip: Fix a data-race around sysctl_fwmark_reflect.
      tcp/dccp: Fix a data-race around sysctl_tcp_fwmark_accept.
      tcp: Fix data-races around sysctl_tcp_l3mdev_accept.
      tcp: Fix data-races around sysctl_tcp_mtu_probing.
      tcp: Fix data-races around sysctl_tcp_base_mss.
      tcp: Fix data-races around sysctl_tcp_min_snd_mss.
      tcp: Fix a data-race around sysctl_tcp_mtu_probe_floor.
      tcp: Fix a data-race around sysctl_tcp_probe_threshold.
      tcp: Fix a data-race around sysctl_tcp_probe_interval.
      tcp/udp: Make early_demux back namespacified.
      igmp: Fix data-races around sysctl_igmp_llm_reports.
      igmp: Fix a data-race around sysctl_igmp_max_memberships.
      igmp: Fix data-races around sysctl_igmp_max_msf.
      igmp: Fix data-races around sysctl_igmp_qrv.
      tcp: Fix data-races around keepalive sysctl knobs.
      tcp: Fix data-races around sysctl_tcp_syn(ack)?_retries.
      tcp: Fix data-races around sysctl_tcp_syncookies.
      tcp: Fix data-races around sysctl_tcp_migrate_req.
      tcp: Fix data-races around sysctl_tcp_reordering.
      tcp: Fix data-races around some timeout sysctl knobs.
      tcp: Fix a data-race around sysctl_tcp_notsent_lowat.
      tcp: Fix a data-race around sysctl_tcp_tw_reuse.
      tcp: Fix data-races around sysctl_max_syn_backlog.
      tcp: Fix data-races around sysctl_tcp_fastopen.
      tcp: Fix data-races around sysctl_tcp_fastopen_blackhole_timeout.
      ipv4: Fix a data-race around sysctl_fib_multipath_use_neigh.
      ipv4: Fix data-races around sysctl_fib_multipath_hash_policy.
      ipv4: Fix data-races around sysctl_fib_multipath_hash_fields.
      ip: Fix data-races around sysctl_ip_prot_sock.
      udp: Fix a data-race around sysctl_udp_l3mdev_accept.
      tcp: Fix data-races around sysctl knobs related to SYN option.
      tcp: Fix a data-race around sysctl_tcp_early_retrans.
      tcp: Fix data-races around sysctl_tcp_recovery.
      tcp: Fix a data-race around sysctl_tcp_thin_linear_timeouts.
      tcp: Fix data-races around sysctl_tcp_slow_start_after_idle.
      tcp: Fix a data-race around sysctl_tcp_retrans_collapse.
      tcp: Fix a data-race around sysctl_tcp_stdurg.
      tcp: Fix a data-race around sysctl_tcp_rfc1337.
      tcp: Fix a data-race around sysctl_tcp_abort_on_overflow.
      tcp: Fix data-races around sysctl_tcp_max_reordering.

Lennert Buytenhek (1):
      igc: Reinstate IGC_REMOVED logic and implement it properly

Li Zhengyu (2):
      RISCV: kexec: Fix build error without CONFIG_MODULES
      RISC-V: kexec: Fix build error without CONFIG_KEXEC

Liang He (3):
      net: dsa: microchip: ksz_common: Fix refcount leak bug
      drm/imx/dcss: Add missing of_node_put() in fail path
      can: rcar_canfd: Add missing of_node_put() in rcar_canfd_probe()

Linus Torvalds (4):
      watchqueue: make sure to serialize 'wqueue->defunct' properly
      watch-queue: remove spurious double semicolon
      mmu_gather: fix the CONFIG_MMU_GATHER_NO_RANGE case
      Linux 5.19-rc8

Lorenzo Bianconi (1):
      net: ethernet: mtk_ppe: fix possible NULL pointer dereference in
mtk_flow_get_wdma_info

Luben Tuikov (1):
      drm/amdgpu: Protect the amdgpu_bo_list list with a mutex v2

Maksym Glubokiy (1):
      net: prestera: acl: use proper mask for port selector

Marc Kleine-Budde (2):
      can: mcp251xfd: fix detection of mcp251863
      spi: bcm2835: bcm2835_spi_handle_err(): fix NULL pointer deref
for non DMA transfers

Mario Limonciello (2):
      pinctrl: Don't allow PINCTRL_AMD to be a module
      ACPI: CPPC: Don't require flexible address space if
X86_FEATURE_CPPC is supported

Mark Brown (1):
      ASoC: rockchip-i2s: Undo BCLK pinctrl changes

Matthew Brost (1):
      drm/i915/guc: Support programming the EU priority in the GuC descript=
or

Mustafa Ismail (2):
      RDMA/irdma: Do not advertise 1GB page size for x722
      RDMA/irdma: Fix sleep from invalid context BUG

Neeraj Upadhyay (1):
      srcu: Make expedited RCU grace periods block even less frequently

N=C3=ADcolas F. R. A. Prado (1):
      drm/panel-edp: Fix variable typo when saving hpd absent delay from DT

Oleksij Rempel (2):
      net: dsa: sja1105: silent spi_device_id warnings
      net: dsa: vitesse-vsc73xx: silent spi_device_id warnings

Oliver Upton (1):
      KVM: stats: Fix value for KVM_STATS_UNIT_MAX for boolean stats

Oz Shlomo (1):
      net/sched: cls_api: Fix flow action initialization

Paolo Bonzini (1):
      tools headers UAPI: Sync linux/kvm.h with the kernel sources

Paul E. McKenney (1):
      srcu: Block less aggressively for expedited grace periods

Pawan Gupta (1):
      x86/bugs: Warn when "ibrs" mitigation is selected on Enhanced IBRS pa=
rts

Peter Zijlstra (5):
      x86/amd: Use IBPB for firmware calls
      mmu_gather: Remove per arch tlb_{start,end}_vma()
      csky/tlb: Remove tlb_flush() define
      mmu_gather: Let there be one tlb_{start,end}_vma() implementation
      mmu_gather: Force tlb-flush VM_PFNMAP vmas

Piotr Skajewski (1):
      ixgbe: Add locking to prevent panic when setting sriov_numvfs to zero

Przemyslaw Patynowski (4):
      iavf: Fix VLAN_V2 addition/rejection
      iavf: Disallow changing rx/tx-frames and rx/tx-frames-irq
      iavf: Fix handling of dummy receive descriptors
      iavf: Fix missing state logs

Robert Hancock (1):
      i2c: cadence: Change large transfer count reset logic to be unconditi=
onal

Sai Krishna Potthuri (1):
      spi: spi-cadence: Fix SPI NO Slave Select macro definition

Sascha Hauer (1):
      mtd: rawnand: gpmi: Set WAIT_FOR_READY timeout based on
program/erase times

Sasha Neftin (2):
      e1000e: Enable GPT clock before sending message to CSME
      Revert "e1000e: Fix possible HW unit hang after an s0ix exit"

Srinivas Neeli (1):
      gpio: gpio-xilinx: Fix integer overflow

Stylon Wang (1):
      drm/amd/display: Fix new dmub notification enabling in DM

Taehee Yoo (8):
      amt: use workqueue for gateway side message handling
      amt: remove unnecessary locks
      amt: use READ_ONCE() in amt module
      amt: add missing regeneration nonce logic in request logic
      amt: drop unexpected advertisement message
      amt: drop unexpected query message
      amt: drop unexpected multicast data
      amt: do not use amt->nr_tunnels outside of lock

Tariq Toukan (1):
      net/tls: Fix race in TLS device down flow

Tom Lendacky (1):
      virt: sev-guest: Pass the appropriate argument type to iounmap()

Tom Rix (1):
      net: ethernet: mtk_eth_soc: fix off by one check of ARRAY_SIZE

Tony Lindgren (1):
      mmc: sdhci-omap: Fix a lockdep warning for PM runtime init

Vadim Pasternak (1):
      i2c: mlxcpld: Fix register setting for 400KHz frequency

Vladimir Oltean (19):
      docs: net: dsa: update probing documentation
      docs: net: dsa: document the shutdown behavior
      docs: net: dsa: rename tag_protocol to get_tag_protocol
      docs: net: dsa: add more info about the other arguments to
get_tag_protocol
      docs: net: dsa: document change_tag_protocol
      docs: net: dsa: document the teardown method
      docs: net: dsa: document port_setup and port_teardown
      docs: net: dsa: document port_fast_age
      docs: net: dsa: remove port_bridge_tx_fwd_offload
      docs: net: dsa: remove port_vlan_dump
      docs: net: dsa: delete port_mdb_dump
      docs: net: dsa: add a section for address databases
      docs: net: dsa: re-explain what port_fdb_dump actually does
      docs: net: dsa: delete misinformation about -EOPNOTSUPP for FDB/MDB/V=
LAN
      docs: net: dsa: mention that VLANs are now refcounted on shared ports
      pinctrl: armada-37xx: make irq_lock a raw spinlock to avoid
invalid wait context
      pinctrl: armada-37xx: use raw spinlocks for regmap to avoid
invalid wait context
      net: dsa: fix dsa_port_vlan_filtering when global
      net: dsa: fix NULL pointer dereference in dsa_port_reset_vlan_filteri=
ng

William Dean (2):
      pinctrl: ralink: Check for null return of devm_kcalloc
      pinctrl: sunplus: Add check for kcalloc

Wong Vee Khee (2):
      net: stmmac: switch to use interrupt for hw crosstimestamping
      net: stmmac: remove redunctant disable xPCS EEE call

Xin Long (1):
      Documentation: fix udp_wmem_min in ip-sysctl.rst

xinhui pan (1):
      drm/amdgpu: Remove one duplicated ef removal
