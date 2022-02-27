Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BABB4C5FA8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 00:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbiB0XB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 18:01:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiB0XBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 18:01:25 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62206D84C
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 15:00:46 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id t14so14980335ljh.8
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 15:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=cQZti5CAyuwnnc7WsM+TUVmQM11QikoIIy4W1padvHo=;
        b=iGAVvU5ujOkDbS/YNbcAoJLgD4dr9DBWLTBy430aNn4rNzzfZXMKYRrUtYrnfEhDwe
         LJxfbR3LsAuDKAlDBKPVe/3TpRCk4PCCiq9eFp464ivj+6tH7JgB8CXKIRZsCmZ2CwQ6
         p8LEVjKgSOUQimyvq+mj6nX0fRMBUpnEE15gc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=cQZti5CAyuwnnc7WsM+TUVmQM11QikoIIy4W1padvHo=;
        b=ZBemPssmVuQQeukUochhkU3EPttLOjdLy/tku2wWKHZ+ol7dPh8/UvjA7EyN5Zgbdw
         Ep315csWSHR9q2RJvuhcsMvOi/bRr31IXDM/+/e6+XUrEe7Bs+0i65fDBYc7COjLE+1r
         xIRUyEj+9vqBKdFKypLSorHUEyrR5dbl4/3fOOSJTX1Jx4eNenchG0IB7JXeclrpXqM8
         oHSwAy617bRB695G9TSbrdrRb/RvdEhvYrlkJLGLwbqhEqma0VeARmu3/tD3xnKHxNeX
         5YI/UueuYPoa05XW7dZkPHJSpBZw5Skkt7c7rriTEu+cyD9uRZ8cDEhHNZW+rJXjqFby
         QAvQ==
X-Gm-Message-State: AOAM532IL31Op7tT/4n1FfRxR3+fBXmhIqQy6cO3JqASuGOy8h4Speit
        2I+WvecYn6AoQ9fMbAat5sTTV9L3ySQgAKPM5eE=
X-Google-Smtp-Source: ABdhPJzOtufhq5A/HZZcpCS/fuZ8aJelLR2cYVQ4VS+kkeNAyvJEWri2HhncnJ01hj79zxdCO1pw9g==
X-Received: by 2002:a2e:9915:0:b0:23c:ed8f:7dab with SMTP id v21-20020a2e9915000000b0023ced8f7dabmr12396419lji.190.1646002844212;
        Sun, 27 Feb 2022 15:00:44 -0800 (PST)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id c40-20020a05651223a800b00443d571f25csm750275lfv.214.2022.02.27.15.00.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Feb 2022 15:00:43 -0800 (PST)
Received: by mail-lf1-f53.google.com with SMTP id g39so18347978lfv.10
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 15:00:43 -0800 (PST)
X-Received: by 2002:ac2:4c8c:0:b0:445:6c26:3cff with SMTP id
 d12-20020ac24c8c000000b004456c263cffmr11280351lfl.435.1646002843125; Sun, 27
 Feb 2022 15:00:43 -0800 (PST)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 27 Feb 2022 15:00:26 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjWKEQUG2Z5a=2FGUfO5+choQ0jhszqyDmHfZoTXVJYJQ@mail.gmail.com>
Message-ID: <CAHk-=wjWKEQUG2Z5a=2FGUfO5+choQ0jhszqyDmHfZoTXVJYJQ@mail.gmail.com>
Subject: Linux 5.17-rc6
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

Nobody can claim that last week was *normal*, but whatever crazy
things are going on in the world (and I personally had "Zombie
apocalypse" on my bingo card, not "Putin has a mental breakdown"), it
doesn't seem to have affected the kernel much.

Things continue to look normal both in commit numbers and in
diffstats. We have the usual bulk being drivers (networking, gpu, iio,
clk, and usb stand out, but there's a smattering of other stuff), with
the rest being mixed. The only thing that stands out as a bit unusual
is some further btrfs defrag fixes.  But even they stand out not so
much because they are enormous, as just because they are bigger than
most of the rest, which is pretty small.

Other notable areas: core networking, tracing, and selftests. As
usual, details are in the appended shortlog.

While things look reasonably normal, we _are_ getting pretty late in
the release, and we still have a number of known regressions. They
don't seem all that big and scary, but some of them were reported
right after the rc1 release, so they are getting a bit long in the
tooth. I'd hate to have to delay 5.17 just because of them, and I'm
starting to be a bit worried here. I think all the affected
maintainers know who they are...

So if you are a subsystem maintainer, and you have one of those
regressions on your list, please go make them a priority. And if you
don't know what I'm talking about, please do look up the reports by
regzbot and Guenter Roeck. I added links below to make it really easy.

But on the whole things look fine. Just a few remaining warts is all.
But the more testing to verify, the better.

               Linus

https://lore.kernel.org/all/164598944963.346832.10219407090470852309@leemhu=
is.info/
https://lore.kernel.org/all/20220221024743.GA4097766@roeck-us.net/

---

Aaron Lewis (1):
      KVM: x86: Add KVM_CAP_ENABLE_CAP to x86

Adam Ward (3):
      regulator: da9121: Fix DA914x current values
      regulator: da9121: Fix DA914x voltage value
      regulator: da9121: Remove surplus DA9141 parameters

Alex Deucher (1):
      PCI: Mark all AMD Navi10 and Navi14 GPU ATS as broken

Alexey Bayduraev (1):
      perf data: Fix double free in perf_session__delete()

Alvin =C5=A0ipraga (2):
      net: dsa: fix panic when removing unoffloaded port from bridge
      MAINTAINERS: add myself as co-maintainer for Realtek DSA switch drive=
rs

Andrey Konovalov (1):
      kasan: test: prevent cache merging in kmem_cache_double_destroy

Andy Shevchenko (1):
      pinctrl: tigerlake: Revert "Add Alder Lake-M ACPI ID"

Aneesh Kumar K.V (2):
      mm/hugetlb: fix kernel crash with hugetlb mremap
      selftest/vm: fix map_fixed_noreplace test failure

Anton Romanov (1):
      kvm: x86: Disable KVM_HC_CLOCK_PAIRING if tsc is in always catchup mo=
de

Ariel Levkovich (1):
      net/mlx5: Fix wrong limitation of metadata match on ecpf

Arnaldo Carvalho de Melo (2):
      tools arch x86: Sync the msr-index.h copy with the kernel sources
      rtla: Fix systme -> system typo on man page

Bart Van Assche (1):
      RDMA/ib_srp: Fix a deadlock

Baruch Siach (1):
      net: mdio-ipq4019: add delay after clock enable

Bas Nieuwenhuizen (1):
      drm/amd/display: Protect update_bw_bounding_box FPU code.

Bjorn Andersson (2):
      cpufreq: Reintroduce ready() callback
      cpufreq: qcom-hw: Delay enabling throttle_irq

Changbin Du (1):
      riscv: fix oops caused by irqsoff latency tracer

Chen Gong (1):
      drm/amdgpu: do not enable asic reset for raven2

ChenXiaoSong (1):
      configfs: fix a race in configfs_{,un}register_subsystem()

Chris Mi (1):
      net/mlx5: Fix tc max supported prio for nic mode

Christian Brauner (1):
      cgroup: clarify cgroup_css_set_fork()

Christian K=C3=B6nig (1):
      drm/radeon: fix variable type

Christoph Hellwig (2):
      nvme: don't return an error from nvme_configure_metadata
      nvme: also mark passthrough-only namespaces ready in nvme_update_ns_i=
nfo

Christophe JAILLET (2):
      iio: adc: men_z188_adc: Fix a resource leak in an error handling path
      nfp: flower: Fix a potential leak in nfp_tunnel_add_shared_mac()

Christophe Kerello (2):
      nvmem: core: Fix a conflict between MTD and NVMEM on wp-gpios propert=
y
      mtd: core: Fix a conflict between MTD and NVMEM on wp-gpios property

Christophe Leroy (3):
      net: Force inlining of checksum functions in net/checksum.h
      tracing: Uninline trace_trigger_soft_disabled() partly
      tracing: Fix selftest config check for function graph start up test

Chuansheng Liu (1):
      thermal: int340x: fix memory leak in int3400_notify()

Cosmin Tanislav (3):
      iio: adc: ad7124: fix mask used for setting AIN_BUFP & AIN_BUFM bits
      iio: addac: ad74413r: use ngpio size when iterating over mask
      iio: addac: ad74413r: correct comparator gpio getters mask usage

Daehwan Jung (1):
      usb: gadget: rndis: add spinlock for rndis response list

Damien Le Moal (1):
      riscv: fix nommu_k210_sdcard_defconfig

Dan Carpenter (3):
      pinctrl: fix loop in k210_pinconf_get_drive()
      udp_tunnel: Fix end of loop test in udp_tunnel_nic_unregister()
      tipc: Fix end of loop tests for list_for_each_entry()

Daniel Bristot de Oliveira (5):
      tracing: Dump stacktrace trigger to the corresponding instance
      tracing/osnoise: Make osnoise_main to sleep for microseconds
      rtla/hist: Make -E the short version of --entries
      rtla/osnoise: Free params at the exit
      rtla/osnoise: Fix error message when failing to enable trace instance

Daniel Scally (1):
      platform/x86: int3472: Add terminator to gpiod_lookup_table

Daniele Palmas (1):
      USB: serial: option: add Telit LE910R1 compositions

Darrick J. Wong (1):
      xfs: only bother with sync_filesystem during readonly remount

Dmitry Osipenko (1):
      gpu: host1x: Fix hang on Tegra186+

Dmytro Bagrii (1):
      Revert "USB: serial: ch341: add new Product ID for CH341A"

Duoming Zhou (1):
      drivers: hamradio: 6pack: fix UAF bug caused by mod_timer()

Dylan Yudaken (1):
      io_uring: disallow modification of rsrc_data during quiesce

D=C4=81vis Mos=C4=81ns (1):
      btrfs: prevent copying too big compressed lzo segment

Eric Dumazet (4):
      io_uring: add a schedule point in io_add_buffers()
      bpf: Add schedule points in batch ops
      net-timestamp: convert sk->sk_tskey to atomic_t
      net: __pskb_pull_tail() & pskb_carve_frag_list() drop_monitor friends

Evan Quan (2):
      drm/amdgpu: disable MMHUB PG for Picasso
      drm/amd/pm: fix some OEM SKU specific stability issues

Fabio M. De Francesco (1):
      net/smc: Use a mutex for locking "struct smc_pnettable"

Fabrice Gasnier (1):
      usb: dwc2: drd: fix soft connect when gadget is unconfigured

Felix Maurer (2):
      bpf: Do not try bpf_msg_push_data with len 0
      selftests: bpf: Check bpf_msg_push_data return value

Florian Westphal (2):
      netfilter: nft_limit: fix stateful object memory leak
      netfilter: nf_tables: fix memory leak during stateful obj update

Frank Rowand (1):
      of: unittest: update text of expected warnings

Gal Pressman (2):
      net/mlx5e: Fix wrong return value on ioctl EEPROM query failure
      net/mlx5e: Fix VF min/max rate parameters interchange mistake

German Gomez (1):
      perf script: Fix error when printing 'weight' field

Greg Kroah-Hartman (1):
      slab: remove __alloc_size attribute from __kmalloc_track_caller

Guchun Chen (2):
      Revert "drm/amdgpu: add modifiers in amdgpu_vkms_plane_init()"
      drm/amdgpu: bypass tiling flag check in virtual display case (v2)

Guenter Roeck (1):
      hwmon: Handle failure to register sensor with thermal zone correctly

Halil Pasic (1):
      swiotlb: fix info leak with DMA_FROM_DEVICE

Hans de Goede (5):
      platform/x86: thinkpad_acpi: Add dual-fan quirk for T15g (2nd gen)
      platform/x86: asus-wmi: Fix regression when probing for fan curve con=
trol
      usb: dwc3: pci: Add "snps,dis_u2_susphy_quirk" for Intel Bay Trail
      usb: dwc3: pci: Fix Bay Trail phy GPIO mappings
      surface: surface3_power: Fix battery readings on batteries
without a serial number

Heikki Krogerus (1):
      usb: dwc3: pci: add support for the Intel Raptor Lake-S

Helge Deller (2):
      parisc/unaligned: Fix fldd and fstd unaligned handlers on 32-bit kern=
el
      parisc/unaligned: Fix ldw() and stw() unalignment handlers

Heyi Guo (3):
      drivers/net/ftgmac100: refactor ftgmac100_reset_task to enable
direct function call
      drivers/net/ftgmac100: adjust code place for function call dependency
      drivers/net/ftgmac100: fix DHCP potential failure with systemd

Hongyu Xie (1):
      xhci: Prevent futile URB re-submissions due to incorrect return value=
.

Imre Deak (1):
      drm/i915: Disconnect PHYs left connected by BIOS on disabled ports

Jacob Keller (1):
      ice: fix concurrent reset and removal of VFs

Jason Gunthorpe (1):
      RDMA/cma: Do not change route.addr.src_addr outside state checks

Jens Axboe (2):
      tps6598x: clear int mask on probe failure
      io_uring: don't convert to jiffies for waiting on timeouts

Jeremy Linton (1):
      net: mvpp2: always set port pcs ops

Jiapeng Chong (1):
      cpuset: Fix kernel-doc

John Garry (1):
      perf test: Skip failing sigtrap test for arm+aarch64

Jon Hunter (1):
      drm/tegra: Fix cast to restricted __le32

Jon Lin (2):
      spi: rockchip: Fix error in getting num-cs property
      spi: rockchip: terminate dma transmission when slave abort

Kalesh AP (2):
      bnxt_en: Restore the resets_reliable flag in bnxt_open()
      bnxt_en: Fix devlink fw_activate

Kees Cook (1):
      iio: addac: ad74413r: Do not reference negative array offsets

Konrad Dybcio (1):
      clk: qcom: gcc-msm8994: Remove NoC clocks

Krzysztof Kozlowski (2):
      MAINTAINERS: sifive: drop Yash Shah
      dt-bindings: update Roger Quadros email

Kumar Kartikeya Dwivedi (3):
      bpf: Fix crash due to incorrect copy_map_value
      selftests/bpf: Add test for bpf_timer overwriting crash
      bpf: Fix crash due to out of bounds access into reg2btf_ids.

Lama Kayal (2):
      net/mlx5e: Add feature check for set fec counters
      net/mlx5e: Add missing increment of count

Leonardo Bras (3):
      x86/kvm/fpu: Limit guest user_xfeatures to supported bits of XCR0
      x86/kvm/fpu: Remove kvm_vcpu_arch.guest_supported_xcr0
      x86/kvm: Fix compilation warning in non-x86_64 builds

Liang Zhang (1):
      KVM: x86/mmu: make apf token non-zero to fix bug

Linus Torvalds (1):
      Linux 5.17-rc6

Linus Walleij (1):
      hwmon: (ntc_thermistor) Underscore Samsung thermistor

Liu Yuntao (1):
      hugetlbfs: fix a truncation issue in hugepages parameter

Lorenzo Bianconi (1):
      iio: imu: st_lsm6dsx: wait for settling time in st_lsm6dsx_read_onesh=
ot

Luis Chamberlain (1):
      MAINTAINERS: add sysctl-next git tree

Maher Sanalla (1):
      net/mlx5: Update log_max_qp value to be 17 at most

Manish Chopra (1):
      bnx2x: fix driver load from initrd

Maor Dickman (2):
      net/mlx5e: Fix MPLSoUDP encap to use MPLS action information
      net/mlx5e: MPLSoUDP decap, fix check for unsupported matches

Maor Gottlieb (1):
      net/mlx5: Fix possible deadlock on rule deletion

Marc Zyngier (2):
      pinctrl: starfive: Use a static name for the GPIO irq_chip
      gpio: tegra186: Fix chip_data type confusion

Marek Marczykowski-G=C3=B3recki (2):
      Revert "xen-netback: remove 'hotplug-status' once it has served
its purpose"
      Revert "xen-netback: Check for hotplug-status existence before watchi=
ng"

Mario Limonciello (2):
      drm/amd: Check if ASPM is enabled from PCIe subsystem
      platform/x86: amd-pmc: Set QOS during suspend on CZN w/ timer wakeup

Mateusz Palczewski (1):
      Revert "i40e: Fix reset bw limit when DCB enabled with 1 TC"

Matt Roper (1):
      drm/i915/dg2: Print PHY name properly on calibration error

Mauri Sandberg (1):
      net: mv643xx_eth: process retval from of_get_mac_address

Max Kellermann (1):
      lib/iov_iter: initialize "flags" in new pipe_buffer

Maxim Levitsky (1):
      KVM: x86: nSVM: disallow userspace setting of
MSR_AMD64_TSC_RATIO to non default value when tsc scaling disabled

Maxime Ripard (3):
      drm/vc4: hdmi: Unregister codec device on unbind
      drm/vc4: crtc: Fix runtime_pm reference counting
      drm/edid: Always set RGB444

Md Haris Iqbal (2):
      RDMA/rtrs-clt: Fix possible double free in error case
      RDMA/rtrs-clt: Move free_permit from free_clt to rtrs_clt_close

Meir Lichtinger (1):
      net/mlx5: Update the list of the PCI supported devices

Miaohe Lin (1):
      memblock: use kfree() to release kmalloced memblock regions

Miaoqian Lin (1):
      iio: Fix error handling for PM

Michael Chan (3):
      bnxt_en: Fix offline ethtool selftest with RDMA enabled
      bnxt_en: Fix occasional ethtool -t loopback test failures
      bnxt_en: Increase firmware message response DMA wait time

Michal Koutn=C3=BD (1):
      cgroup-v1: Correct privileges check in release_agent writes

Michal Swiatkowski (1):
      ice: fix setting l4 port flag when adding filter

Michel D=C3=A4nzer (1):
      drm/amd/display: For vblank_disable_immediate, check PSR is really us=
ed

Mike Kravetz (1):
      selftests/memfd: clean up mapping in mfd_fail_write

Mike Marciniszyn (1):
      IB/qib: Fix duplicate sysfs directory name

Mikko Perttunen (1):
      gpu: host1x: Always return syncpoint value when waiting

Muhammad Usama Anjum (1):
      iio: frequency: admv1013: remove the always true condition

M=C3=A5rten Lindahl (1):
      driver core: Free DMA range map when device is released

Nathan Chancellor (1):
      ftrace: Remove unused ftrace_startup_enable() stub

Nicholas Kazlauskas (1):
      drm/amd/display: Fix stream->link_enc unassigned during stream remova=
l

Nicholas Piggin (1):
      KVM: PPC: reserve capability 210 for KVM_CAP_PPC_AIL_MODE_3

Niels Dossche (1):
      ipv6: prevent a possible race condition with lifetimes

Nikhil Gupta (1):
      of/fdt: move elfcorehdr reservation early for crash dump kernel

Nuno S=C3=A1 (1):
      iio:imu:adis16480: fix buffering for devices with no burst mode

Oleksij Rempel (1):
      iio: adc: tsc2046: fix memory corruption by preventing array overflow

Oliver Graute (1):
      staging: fbtft: fb_st7789v: reset display before initialization

Oliver Neukum (1):
      sr9700: sanity check for packet length

Ondrej Mosnacek (1):
      selinux: fix misuse of mutex_is_locked()

Pablo Neira Ayuso (3):
      netfilter: xt_socket: missing ifdef CONFIG_IP6_NF_IPTABLES dependency
      netfilter: nf_tables_offload: incorrect flow offload action array siz=
e
      netfilter: nf_tables: unregister flowtable hooks on netns exit

Pali Roh=C3=A1r (1):
      PCI: mvebu: Fix device enumeration regression

Paolo Abeni (7):
      selftests: mptcp: fix diag instability
      selftests: mptcp: improve 'fair usage on close' stability
      mptcp: fix race in overlapping signal events
      mptcp: fix race in incoming ADD_ADDR option processing
      mptcp: add mibs counter for ignored incoming options
      selftests: mptcp: more robust signal race test
      selftests: mptcp: be more conservative with cookie MPJ limits

Paul Blakey (2):
      net/sched: act_ct: Fix flow table lookup after ct clear or switching =
zones
      openvswitch: Fix setting ipv6 fields causing hw csum failure

Pavan Chebbi (1):
      bnxt_en: Fix incorrect multicast rx mask setting when not requested

Phil Elwell (1):
      sc16is7xx: Fix for incorrect data being transmitted

Prasad Kumpatla (1):
      regmap-irq: Update interrupt clear register for proper reset

Puma Hsu (1):
      xhci: re-initialize the HC during resume if HCE was set

Qiang Yu (1):
      drm/amdgpu: check vm ready by amdgpu_vm->evicting flag

Qu Wenruo (8):
      btrfs: defrag: allow defrag_one_cluster() to skip large extent
which is not a target
      btrfs: defrag: don't try to merge regular extents with
preallocated extents
      btrfs: defrag: don't defrag extents which are already at max capacity
      btrfs: defrag: remove an ambiguous condition for rejection
      btrfs: defrag: bring back the old file extent search behavior
      btrfs: defrag: don't use merged extent map for their generation check
      btrfs: autodefrag: only scan one inode once
      btrfs: reduce extent threshold for autodefrag

Roi Dayan (3):
      net/mlx5e: TC, Reject rules with drop and modify hdr action
      net/mlx5e: TC, Reject rules with forward and drop actions
      net/mlx5e: TC, Skip redundant ct clear actions

Roman Gushchin (3):
      tools/cgroup/slabinfo: update to work with struct slab
      MAINTAINERS: add Roman as a memcg co-maintainer
      mailmap: update Roman Gushchin's email

Rudi Heitbaum (1):
      drm/imx/dcss: i.MX8MQ DCSS select DRM_GEM_CMA_HELPER

Samuel Holland (1):
      gpio: rockchip: Reset int_bothedge when changing trigger

Sean Anderson (1):
      pinctrl: k210: Fix bias-pull-up

Sean Nyekjaer (1):
      iio: accel: fxls8962af: add padding to regmap for SPI

Sebastian Andrzej Siewior (1):
      usb: dwc3: gadget: Let the interrupt handler disable bottom halves.

Sergey Shtylyov (2):
      ata: pata_hpt37x: fix PCI clock detection
      ata: pata_hpt37x: disable primary channel on HPT371

Shakeel Butt (1):
      MAINTAINERS: add Shakeel as a memcg co-maintainer

Shreeya Patel (1):
      gpio: Return EPROBE_DEFER if gc->to_irq is NULL

Siarhei Volkau (1):
      clk: jz4725b: fix mmc0 clock gating

Slark Xiao (1):
      USB: serial: option: add support for DW5829e

Somnath Kotur (1):
      bnxt_en: Fix active FEC reporting to ethtool

Stefano Garzarella (2):
      block: clear iocb->private in blkdev_bio_end_io_async()
      vhost/vsock: don't check owner in vhost_vsock_stop() while releasing

Steven Rostedt (Google) (3):
      tracing: Have traceon and traceoff trigger honor the instance
      eprobes: Remove redundant event type information
      tracefs: Set the group ownership in apply_options() not parse_options=
()

Subash Abhinov Kasiviswanathan (1):
      MAINTAINERS: rmnet: Update email addresses

Sukadev Bhattiprolu (1):
      ibmvnic: schedule failover only if vioctl fails

Suren Baghdasaryan (1):
      mm: fix use-after-free bug when mm->mmap is reused after being freed

Sven Schnelle (1):
      tracing: Ensure trace buffer is at least 4096 bytes large

Svenning S=C3=B8rensen (1):
      net: dsa: microchip: fix bridging with more than two member ports

Szymon Heidrich (1):
      USB: gadget: validate endpoint index for xilinx udc

Tao Liu (1):
      gso: do not skip outer ip header in case of ipip and net_failover

Tariq Toukan (1):
      net/mlx5e: kTLS, Use CHECKSUM_UNNECESSARY for device-offloaded packet=
s

Thierry Reding (1):
      drm/tegra: dpaux: Populate AUX bus

Thomas Gleixner (1):
      PCI: vmd: Prevent recursive locking on interrupt allocation

Tom Rix (2):
      ice: check the return of ice_ptp_gettimex64
      ice: initialize local variable 'tlv'

Varun Prakash (1):
      nvme-tcp: send H2CData PDUs based on MAXH2CDATA

Vikash Chandola (1):
      hwmon: (pmbus) Clear pmbus fault/warning bits after read

Ville Syrj=C3=A4l=C3=A4 (3):
      drm/i915: Widen the QGV point mask
      drm/i915: Correctly populate use_sagv_wm for all pipes
      drm/i915: Fix bw atomic check when switching between SAGV vs. no SAGV

Vladimir Davydov (1):
      MAINTAINERS: remove Vladimir from memcg maintainers

Vladimir Oltean (1):
      net: dsa: avoid call to __dev_set_promiscuity() while rtnl_mutex
isn't held

Vlastimil Babka (1):
      MAINTAINERS, SLAB: add Roman as reviewer, git tree

Wan Jiabing (1):
      net: sched: avoid newline at end of message in NL_SET_ERR_MSG_MOD

Wanpeng Li (2):
      KVM: Fix lockdep false negative during host resume
      x86/kvm: Don't use pv tlb/ipi/sched_yield if on 1 vCPU

Wojciech Drewek (1):
      ice: Match on all profiles in slow-path

Xiaoke Wang (1):
      net: ll_temac: check the return value of devm_kmalloc()

Xin Long (1):
      ping: remove pr_err from ping_lookup

Yevgeny Kliteynik (4):
      net/mlx5: DR, Cache STE shadow memory
      net/mlx5: DR, Fix slab-out-of-bounds in mlx5_cmd_dr_create_fte
      net/mlx5: DR, Don't allow match on IP w/o matching on full
ethertype/ip_version
      net/mlx5: DR, Fix the threshold that defines when pool sync is initia=
ted

Yonghong Song (2):
      bpf: Emit bpf_timer in vmlinux BTF
      bpf: Fix a bpf_timer initialization issue

Zhang Qiao (1):
      cgroup/cpuset: Fix a race between cpuset_attach() and cpu hotplug

Zhengjun Xing (1):
      perf evlist: Fix failed to use cpu list for uncore events

Zhou Qingyang (1):
      spi: spi-zynq-qspi: Fix a NULL pointer dereference in
zynq_qspi_exec_mem_op()

daniel.starke@siemens.com (7):
      tty: n_gsm: fix encoding of control signal octet bit DV
      tty: n_gsm: fix encoding of command/response bit
      tty: n_gsm: fix proper link termination after failed open
      tty: n_gsm: fix NULL pointer access due to DLCI release
      tty: n_gsm: fix wrong tty control line for flow control
      tty: n_gsm: fix wrong modem processing in convergence layer type 2
      tty: n_gsm: fix deadlock in gsmtty_open()

suresh kumar (1):
      net-sysfs: add check for netdevice being present to speed_show
