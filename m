Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 105405305B9
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 22:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238967AbiEVUCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 16:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiEVUCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 16:02:30 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0ED25E8F
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 13:02:28 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id rq11so2691085ejc.4
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 13:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=9rvlCn9k+bNvmIzmHWKy3oy9qAI23d2e1zBVROAhV3o=;
        b=Kv+aTWv0Adn3OsroxoxMquPUIl5nRrNTAYsFXOMrtAIKo8osAdWjm+4+sSEmoQuoEk
         Ut/NA0z3hbRb2/3D4pzcexCNo87MFn4q4qCNNMevEN0686LkUtSADnKt6mmpdlbsWsSl
         M9MbRgqZsnh83PEfMGnK3KHFFhcsuLLuxHrQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=9rvlCn9k+bNvmIzmHWKy3oy9qAI23d2e1zBVROAhV3o=;
        b=ZrxxYcDwyxspB9TXIEPPmUEyk9OWo7rob9ZtGH+F7g5QRJ09ywyJ6muBsuAvSGPVVt
         v2QMRLIE/SDt0C9G7kHho6pXqJuDeB3LhKDq2D+xaZ1MO6lwjhk+69luGtaavJaJOofx
         lVexiFbJcbn/y+sslt+ENa8Hl/A/AyzKMNN73zwWa2Dtm/W67kd2syXbfG8XVxtvsPV+
         pLs7soVgp81Rv5Cy9EB5XHqb3775Je16JUDm3Bc1KVnRbrtLbdUlmgWjsJd3w9QQntRg
         UnoLHpW/LkGiN3m3khpwvFnN5HAdi7o/cmFbNhy78kS8MzjUu1SfLdGcGeDRdhNUXjo0
         j86Q==
X-Gm-Message-State: AOAM5320qlxzV/AK7+FHWcgkGkK+m8sFS1mW/2fB3A5Ozc6KsNqYDQ0h
        kHKfxaOeKpmUHHRJ0LjK0M9aRa68byE0dHMs
X-Google-Smtp-Source: ABdhPJwbj2e4naTDmoOsdTAlatKwpQ7t6nPZHm2OkTLVJfRmf45ikmbWnPTOKBd95vr7TYfGERV0CQ==
X-Received: by 2002:a17:907:1b19:b0:6f0:1022:1430 with SMTP id mp25-20020a1709071b1900b006f010221430mr17067378ejc.13.1653249747067;
        Sun, 22 May 2022 13:02:27 -0700 (PDT)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id h23-20020aa7c957000000b00428a42815aasm7313416edt.0.2022.05.22.13.02.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 May 2022 13:02:26 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id w4so18368533wrg.12
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 13:02:26 -0700 (PDT)
X-Received: by 2002:a5d:5484:0:b0:20f:bf64:cae1 with SMTP id
 h4-20020a5d5484000000b0020fbf64cae1mr9516876wrv.281.1653249745782; Sun, 22
 May 2022 13:02:25 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 22 May 2022 10:02:09 -1000
X-Gmail-Original-Message-ID: <CAHk-=wjiqyoH6qntYvYTjR1F2L-pHtgX9esZMRS13iktCOJ1zA@mail.gmail.com>
Message-ID: <CAHk-=wjiqyoH6qntYvYTjR1F2L-pHtgX9esZMRS13iktCOJ1zA@mail.gmail.com>
Subject: Linux 5.18
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

No unexpected nasty surprises this last week, so here we go with the
5.18 release right on schedule.

That obviously means that the merge window for 5.19 will open
tomorrow, and I already have a few pull requests pending. Thank you
everybody. I'd still like people to run boring old plain 5.18 just to
check, before we start with the excitement of all the new features for
the merge window.

The full shortlog for the last week is below, and nothing really odd
stands out. The diffstat looks a bit funny - unusually we have parsic
architecture patches being a big part of it due to some last-minute
cache flushing fixes, but that is probably more indicative of
everything else being pretty small.

So outside of the parisc fixes, there's random driver updates
(mellanox mlx5 stands out, again likely because everything else is
small), some other minor architecture fixes, some core networking, and
some tooling stuff. And random small noise. People who really care for
the details please just scroll down..

                Linus

---

Aaron Lewis (3):
      kvm: x86/pmu: Fix the compare function used by the pmu event filter
      selftests: kvm/x86: Add the helper function create_pmu_event_filter
      selftests: kvm/x86: Verify the pmu event filter matches the correct e=
vent

Al Viro (2):
      percpu_ref_init(): clean ->percpu_count_ref on failure
      Fix double fget() in vhost_net_set_backend()

Alex Elder (3):
      net: ipa: certain dropped packets aren't accounted for
      net: ipa: record proper RX transaction count
      net: ipa: get rid of a duplicate initialization

Andre Przywara (1):
      pinctrl: sunxi: f1c100s: Fix signal name comment for PA2 SPI pin

Andrew Lunn (1):
      net: bridge: Clear offload_fwd_mark when passing frame up bridge
interface.

Andy Chi (1):
      ALSA: hda/realtek: fix right sounds and mute/micmute LEDs for HP mach=
ine

Anusha Srivatsa (1):
      drm/i915/dmc: Add MMIO range restrictions

Ard Biesheuvel (2):
      ARM: 9196/1: spectre-bhb: enable for Cortex-A15
      ARM: 9197/1: spectre-bhb: fix loop8 sequence for Thumb2

Arkadiusz Kubalewski (1):
      ice: fix crash when writing timestamp on RX rings

Arnaldo Carvalho de Melo (1):
      perf build: Fix check for btf__load_from_kernel_by_id() in libbpf

Athira Rajeev (3):
      perf test: Fix "all PMU test" to skip hv_24x7/hv_gpci tests on powerp=
c
      perf test session topology: Fix test to skip the test in guest enviro=
nment
      perf test bpf: Skip test if clang is not present

Aya Levin (1):
      net/mlx5e: Block rx-gro-hw feature in switchdev mode

Bart Van Assche (1):
      block/mq-deadline: Set the fifo_time member also if inserting at head

Bjorn Andersson (1):
      PCI: qcom: Remove ddrss_sf_tbu clock from SC8180X

Catalin Marinas (1):
      arm64: mte: Ensure the cleared tags are visible before setting the PT=
E

Charan Teja Kalla (1):
      dma-buf: ensure unique directory name for dmabuf stats

Chengdong Li (1):
      perf session: Fix Intel LBR callstack entries and nr print message

Christophe JAILLET (2):
      net: systemport: Fix an error handling path in bcm_sysport_probe()
      net/qla3xxx: Fix a test in ql_reset_work()

Codrin Ciubotariu (1):
      clk: at91: generated: consider range when calculating best rate

Conor Paxton (1):
      riscv: dts: microchip: fix gpio1 reg property typo

Daejun Park (1):
      scsi: ufs: core: Fix referencing invalid rsp field

David Howells (1):
      afs: Fix afs_getattr() to refetch file status if callback break occur=
red

Dmitry Baryshkov (1):
      arm64: dts: qcom: sm8250: don't enable rx/tx macro by default

Duoming Zhou (1):
      NFC: nci: fix sleep in atomic context bugs caused by nci_skb_alloc

Dustin L. Howett (1):
      ALSA: hda/realtek: Add quirk for the Framework Laptop

Dylan Yudaken (1):
      io_uring: fix ordering of args in io_uring_queue_async_work

Eli Cohen (1):
      vdpa/mlx5: Use consistent RQT size

Eric Dumazet (1):
      Revert "tcp/dccp: get rid of inet_twsk_purge()"

Eyal Birger (1):
      xfrm: fix "disable_policy" flag use when arriving from different devi=
ces

Felix Fietkau (4):
      netfilter: flowtable: fix excessive hw offload attempts after failure
      netfilter: nft_flow_offload: skip dst neigh lookup for ppp devices
      net: fix dev_fill_forward_path with pppoe + bridge
      netfilter: nft_flow_offload: fix offload with pppoe + vlan

Forest Crossman (1):
      ALSA: usb-audio: Don't get sample rate for MCT Trigger 5 USB-to-HDMI

Frank Wunderlich (2):
      arm64: dts: rockchip: Change io-domains of bpi-r2-pro
      arm64: dts: rockchip: Add gmac1 and change network settings of bpi-r2=
-pro

Gabriele Mazzotta (1):
      ALSA: hda/realtek: Add quirk for Dell Latitude 7520

Gal Pressman (1):
      net/mlx5e: Remove HW-GRO from reported features

Haibo Chen (1):
      gpio: gpio-vf610: do not touch other bits when set the target bit

Hangyu Hua (1):
      drm/dp/mst: fix a possible memory leak in fetch_monitor_name()

Harini Katakam (1):
      net: macb: Increment rx bd head after allocating skb and buffer

Horatiu Vultur (2):
      pinctrl: ocelot: Fix for lan966x alt mode
      net: lan966x: Fix assignment of the MAC address

Howard Chiu (1):
      ARM: dts: aspeed: Add video engine to g6

Ian Rogers (2):
      perf stat: Fix and validate CPU map inputs in synthetic
PERF_RECORD_STAT events
      perf test: Avoid shell test description infinite loop

Ilya Dryomov (2):
      libceph: fix potential use-after-free on linger ping and resends
      libceph: fix misleading ceph_osdc_cancel_request() comment

IotaHydrae (1):
      pinctrl: sunxi: fix f1c100s uart2 function

Jae Hyun Yoo (5):
      ARM: dts: aspeed-g6: remove FWQSPID group in pinctrl dtsi
      pinctrl: pinctrl-aspeed-g6: remove FWQSPID group in pinctrl
      dt-bindings: pinctrl: aspeed-g6: remove FWQSPID group
      dt-bindings: pinctrl: aspeed-g6: add FWQSPI function/group
      ARM: dts: aspeed-g6: fix SPI1/SPI2 quad pin group

Jarkko Nikula (2):
      Revert "can: m_can: pci: use custom bit timings for Elkhart Lake"
      can: m_can: remove support for custom bit timing, take #2

Jens Axboe (1):
      io_uring: don't attempt to IOPOLL for MSG_RING requests

Jernej Skrabec (1):
      Revert "clk: sunxi-ng: sun6i-rtc: Add support for H6"

Jiasheng Jiang (1):
      net: af_key: add check for pfkey_broadcast in function pfkey_process

Joachim Wiberg (1):
      selftests: forwarding: fix missing backslash

Joel Stanley (1):
      net: ftgmac100: Disable hardware checksum on AST2600

John David Anglin (3):
      parisc: Disable debug code regarding cache flushes in
handle_nadtlb_fault()
      parisc: Rewrite cache flush code for PA8800/PA8900
      parisc: Fix patch code locking and flushing

Johnny Huang (2):
      pinctrl: pinctrl-aspeed-g6: add FWQSPI function-group
      ARM: dts: aspeed-g6: add FWQSPI group in pinctrl dtsi

Jonathan Lemon (2):
      ptp: ocp: have adjtime handle negative delta_ns correctly
      ptp: ocp: change sysfs attr group handling

Julian Orth (1):
      audit,io_uring,io-wq: call __audit_uring_exit for dummy contexts

J=C3=A9r=C3=B4me Pouiller (1):
      dma-buf: fix use of DMA_BUF_SET_NAME_{A,B} in userspace

Kan Liang (1):
      perf regs x86: Fix arch__intr_reg_mask() for the hybrid platform

Kevin Mitchell (1):
      igb: skip phy status check where unavailable

Krzysztof Kozlowski (1):
      riscv: dts: sifive: fu540-c000: align dma node name with dtschema

Lin Ma (1):
      nfc: pn533: Fix buggy cleanup order

Linus Torvalds (1):
      Linux 5.18

Maarten Lankhorst (1):
      drm/i915: Use i915_gem_object_ggtt_pin_ww for reloc_iomap

Maor Dickman (1):
      net/mlx5: DR, Fix missing flow_source when creating
multi-destination FW table

Marc Zyngier (1):
      KVM: arm64: vgic-v3: Consistently populate ID_AA64PFR0_EL1.GIC

Marek Vasut (2):
      Input: ili210x - fix reset timing
      Input: ili210x - use one common reset implementation

Mario Limonciello (1):
      drm/amd: Don't reset dGPUs if the system is going to s2idle

Mark Rutland (1):
      arm64: kexec: load from kimage prior to clobbering

Mat Martineau (1):
      mptcp: Do TCP fallback on early DSS checksum failure

Mattijs Korpershoek (2):
      dt-bindings: input: mediatek,mt6779-keypad: update maintainer
      pinctrl: mediatek: mt8365: fix IES control pins

Maxim Mikityanskiy (3):
      net/mlx5e: Wrap mlx5e_trap_napi_poll into rcu_read_lock
      net/mlx5e: Properly block LRO when XDP is enabled
      net/mlx5e: Properly block HW GRO when XDP is enabled

Michal Wilczynski (1):
      ice: Fix interrupt moderation settings getting cleared

Mika Westerberg (1):
      i2c: ismt: Provide a DMA buffer for Interrupt Cause Logging

Mingzhe Zou (1):
      scsi: target: Fix incorrect use of cpumask_t

Ondrej Mosnacek (2):
      crypto: qcom-rng - fix infinite loop on requests not multiple of WORD=
_SZ
      selinux: fix bad cleanup on error in hashtab_duplicate()

Pablo Neira Ayuso (2):
      netfilter: flowtable: fix TCP flow teardown
      netfilter: nf_tables: disable expression reduction infra

Pali Roh=C3=A1r (1):
      Revert "PCI: aardvark: Rewrite IRQ code to chained IRQ handler"

Paolo Abeni (4):
      mptcp: fix subflow accounting on close
      selftests: mptcp: add subflow limits test-cases
      net/sched: act_pedit: sanitize shift argument before usage
      mptcp: fix checksum byte order

Paolo Bonzini (1):
      KVM: x86/mmu: fix NULL pointer dereference on guest INVPCID

Paul Blakey (2):
      net/mlx5e: CT: Fix support for GRE tuples
      net/mlx5e: CT: Fix setting flow_source for smfs ct tuples

Paul Greenwalt (1):
      ice: fix possible under reporting of ethtool Tx and Rx statistics

Peter Zijlstra (1):
      perf: Fix sys_perf_event_open() race against self

Piyush Malgujar (1):
      drivers: i2c: thunderx: Allow driver to work with ACPI defined
TWSI controllers

Prakruthi Deepak Heragu (1):
      arm64: paravirt: Use RCU read locks to guard stolen_time

Quentin Perret (1):
      KVM: arm64: Don't hypercall before EL2 init

Rafael J. Wysocki (1):
      PCI/PM: Avoid putting Elo i2 PCIe Ports in D3cold

Rajendra Nayak (1):
      MAINTAINERS: omap: remove me as a maintainer

Randy Dunlap (1):
      ALSA: hda - fix unused Realtek function when PM is not enabled

Ritaro Takenaka (1):
      netfilter: flowtable: move dst_check to packet path

Sean Christopherson (2):
      KVM: x86/mmu: Update number of zapped pages even if page list is stab=
le
      KVM: Free new dirty bitmap if creating a new memslot fails

Shay Drory (2):
      net/mlx5: Initialize flow steering during driver probe
      net/mlx5: Drain fw_reset when removing device

Srinivas Pandruvada (1):
      thermal: int340x: Mode setting with new OS handshake

Stefan Wahren (1):
      clk: bcm2835: fix bcm2835_clock_choose_div

Takashi Iwai (2):
      ALSA: wavefront: Proper check of get_user() error
      ALSA: usb-audio: Restore Rane SL-1 quirk

Thomas Bartschies (1):
      net: af_key: check encryption module availability consistency

Thomas Richter (1):
      perf bench numa: Address compiler error on s390

Ulf Hansson (1):
      mmc: core: Fix busy polling for MMC_SEND_OP_COND again

Umesh Nerlige Ramappa (1):
      i915/guc/reset: Make __guc_reset_context aware of guilty engines

Uwe Kleine-K=C3=B6nig (1):
      gpio: mvebu/pwm: Refuse requests with inverted polarity

Wanpeng Li (1):
      KVM: eventfd: Fix false positive RCU usage warning

Werner Sembach (1):
      ALSA: hda/realtek: Add quirk for TongFang devices with pop noise

Xin Long (1):
      xfrm: set dst dev to blackhole_netdev instead of loopback_dev in ifdo=
wn

Yang Yingliang (1):
      i2c: mt7621: fix missing clk_disable_unprepare() on error in
mtk_i2c_probe()

Yevgeny Kliteynik (1):
      net/mlx5: DR, Ignore modify TTL on RX if device doesn't support it

Yury Norov (1):
      KVM: x86: hyper-v: fix type of valid_bank_mask

Zev Weiss (2):
      ARM: dts: aspeed: romed8hm3: Add lm25066 sense resistor values
      ARM: dts: aspeed: romed8hm3: Fix GPIOB0 name

Zixuan Fu (2):
      net: vmxnet3: fix possible use-after-free bugs in
vmxnet3_rq_alloc_rx_buf()
      net: vmxnet3: fix possible NULL pointer dereference in
vmxnet3_rq_cleanup()
