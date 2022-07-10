Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC7356D1B0
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 23:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiGJVyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 17:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiGJVyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 17:54:31 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71E6625F
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 14:54:29 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id eq6so4288673edb.6
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 14:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=mD71upxvZYt1p8WPmhWN3W3poGW+AfBNYb2hlkC/nSg=;
        b=Z+brttWUT2igSC7IURXoDyUOnaMq5ppIf798PJxkQnaOyGMqEAZjsaNFuNuesml+N7
         prU4WMxovXm/40HuG/2FnoOkoOb/+kunqo7Wcn3VNNXZ/fLNzbNMIzC+4smhpVbFzY16
         ZT1kc17XOfAadSig0a4ieTEAAjeaGrz5BDePo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=mD71upxvZYt1p8WPmhWN3W3poGW+AfBNYb2hlkC/nSg=;
        b=WnZN3TaCaUVlVsqMeQivVcGeBURtW+7vvezDvjVk8k/UixNXAcgOq5Pe3nLU1gQkk2
         UBR/CnxnJa7J2fpQ7HhhOpwMmAjCNvcP6JCvRofipcAOP2a6FcDcaGPiPppFO/6q+0Jb
         Iu/5wmgnY8FGZMsFLDNSJWhfXcEolNVDv4+DTv94+0xQMUMTzt036uVZ2qK7msaa6Qig
         Pt6krS78Z0wxj2l05PiM6Tb2QmGb3ceunG31GJqlKl0Yet+wYd6n03q0zeoqKlOqWR6L
         Zak9uvC/TA2VWteslsYYunmhfFrLchmw2x2jDWMtobq1Dxplx9iZGK7H1o3/5iHg3Chj
         warA==
X-Gm-Message-State: AJIora82gVhqRzhUupLHkZFeER5201BOZpy0t59sqJUmsxYNt2EfrpHl
        E74zYErKvIA0mpaM3WMVWuRpdVmqzGUAwPFl
X-Google-Smtp-Source: AGRyM1uK1d1/fT1nIu/iqBs/0gdfqpeTp0JM9UmRJqhnGC6Ey5RQqDti3EbaRhGK/EkIA1bE1ZXBAA==
X-Received: by 2002:a05:6402:5294:b0:43a:2b22:13f1 with SMTP id en20-20020a056402529400b0043a2b2213f1mr20499666edb.199.1657490068026;
        Sun, 10 Jul 2022 14:54:28 -0700 (PDT)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id e23-20020a170906315700b00726c0e60940sm1938300eje.100.2022.07.10.14.54.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Jul 2022 14:54:27 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id be14-20020a05600c1e8e00b003a04a458c54so2038153wmb.3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 14:54:27 -0700 (PDT)
X-Received: by 2002:a05:600c:34c9:b0:3a0:5072:9abe with SMTP id
 d9-20020a05600c34c900b003a050729abemr12175393wmq.8.1657490066764; Sun, 10 Jul
 2022 14:54:26 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 10 Jul 2022 14:54:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgTmGaToVFdSdoFqT2sNkk7jg2rSWasUYv-tASUZ2j_0Q@mail.gmail.com>
Message-ID: <CAHk-=wgTmGaToVFdSdoFqT2sNkk7jg2rSWasUYv-tASUZ2j_0Q@mail.gmail.com>
Subject: Linux 5.19-rc6
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

Things looking fairly normal for rc6, nothing here really stands out.
A number of small fixes all over, with the bulk being a collection of
sound and network driver fixes, along with some arm64 dts file
updates.

The rest is some selftest updates, and various (mostly) one-liners all
over the place. The shortlog below gives a good overview, and is short
enough to just scroll through to get a flavor of it all.

Perhaps somewhat unusually, I picked up a few fixes that were pending
in trees that haven't actually hit upstream yet.  It's already rc6,
and I wanted to close out a few of the regression reports and not have
to wait for another (possibly last, knock wood) rc to have them in the
tree.

             Linus

---

Alexei Starovoitov (1):
      bpf, docs: Better scale maintenance of BPF subsystem

Alison Schofield (1):
      cxl/mbox: Use __le32 in get,set_lsa mailbox structures

Amadeusz S=C5=82awi=C5=84ski (2):
      ASoC: Intel: avs: Fix parsing UUIDs in topology
      ASoC: Remove unused hw_write_t type

Andrei Lalaev (1):
      pinctrl: sunxi: sunxi_pconf_set: use correct offset

Andy Shevchenko (1):
      MAINTAINERS: Update Intel pin control to Supported

Ben Widawsky (2):
      MAINTAINERS: Update Ben's email address
      cxl/core: Use is_endpoint_decoder

Bill Wendling (1):
      soc: qcom: smem: use correct format characters

Bo Liu (1):
      firmware: arm_scmi: Remove usage of the deprecated ida_simple_xxx API

Borislav Petkov (1):
      x86/boot: Fix the setup data types max limit

Caleb Connolly (1):
      dmaengine: qcom: bam_dma: fix runtime PM underflow

Charles Keepax (8):
      ASoC: wm_adsp: Fix event for preloader
      ASoC: wm5110: Fix DRE control
      ASoC: cs35l41: Correct some control names
      ASoC: dapm: Initialise kcontrol data for mux/demux controls
      ASoC: cs35l41: Add ASP TX3/4 source to register patch
      ASoC: cs47l15: Fix event generation for low power mux control
      ASoC: madera: Fix event generation for OUT1 demux
      ASoC: madera: Fix event generation for rate controls

Christian Marangi (1):
      PM / devfreq: exynos-bus: Fix NULL pointer dereference

Christophe JAILLET (1):
      dmaengine: lgm: Fix an error handling path in intel_ldma_probe()

Claudiu Beznea (3):
      ARM: at91: pm: use proper compatible for sama5d2's rtc
      ARM: at91: pm: use proper compatibles for sam9x60's rtc and rtt
      ARM: at91: pm: use proper compatibles for sama7g5's rtc and rtt

Cristian Marussi (1):
      firmware: arm_scmi: Relax CLOCK_DESCRIBE_RATES out-of-spec checks

Dan Carpenter (1):
      ASoC: SOF: mediatek: Fix error code in probe

Dan Williams (1):
      memregion: Fix memregion_free() fallback definition

Daniel Borkmann (4):
      bpf: Fix incorrect verifier simulation around jmp32's jeq/jne
      bpf: Fix insufficient bounds propagation from adjust_scalar_min_max_v=
als
      bpf, selftests: Add verifier test case for imm=3D0,umin=3D0,umax=3D1 =
scalar
      bpf, selftests: Add verifier test case for jmp32's jeq/jne

Dave Jiang (1):
      dmaengine: idxd: force wq context cleanup on device disable path

David Howells (1):
      fscache: Fix invalidation/lookup race

Davidlohr Bueso (1):
      staging/wlan-ng: get the correct struct hfa384x in work callback

Dmitry Baryshkov (2):
      arm64: dts: qcom: sm8450 add ITS device tree node
      arm64: dts: qcom: sdm845: use dispcc AHB clock for mdss node

Dmitry Osipenko (1):
      dmaengine: pl330: Fix lockdep warning about non-static key

Duoming Zhou (1):
      net: rose: fix UAF bug caused by rose_t0timer_expiry

Duy Nguyen (1):
      can: rcar_canfd: Fix data transmission failed on R-Car V3U

Egor Vorontsov (2):
      ALSA: usb-audio: Add quirk for Fiero SC-01
      ALSA: usb-audio: Add quirk for Fiero SC-01 (fw v1.0.0)

Emil Renner Berthing (1):
      dmaengine: dw-axi-dmac: Fix RMW on channel suspend register

Etienne Carriere (1):
      ARM: dts: stm32: fix pwr regulators references to use scmi

Eugen Hristev (2):
      ARM: dts: at91: sam9x60ek: fix eeprom compatible and size
      ARM: dts: at91: sama5d2_icp: fix eeprom compatibles

Fabien Dessenne (1):
      pinctrl: stm32: fix optional IRQ support to gpios

Fabio Estevam (3):
      ARM: dts: imx7d-smegw01: Fix the SDIO description
      ARM: mxs_defconfig: Enable the framebuffer
      ARM: at91: pm: Mark at91_pm_secure_init as __init

Fabrice Gasnier (1):
      ARM: dts: stm32: add missing usbh clock and fix clk order on stm32mp1=
5

Gabriel Fernandez (3):
      ARM: dts: stm32: use the correct clock source for CEC on stm32mp151
      ARM: dts: stm32: DSI should use LSE SCMI clock on DK1/ED1 STM32 board
      ARM: dts: stm32: delete fixed clock node on STM32MP15-SCMI

Gal Pressman (1):
      Revert "tls: rx: move counting TlsDecryptErrors for sync"

Geert Uytterhoeven (1):
      eeprom: at25: Rework buggy read splitting

Geliang Tang (1):
      mptcp: update MIB_RMSUBFLOW in cmd_sf_destroy

Guiling Deng (1):
      fbdev: fbmem: Fix logo center image dx issue

Hangbin Liu (1):
      selftests/net: fix section name when using xdp_dummy.o

Hans de Goede (1):
      ASoC: Intel: bytcr_wm5102: Fix GPIO related probe-ordering problem

Haowen Bai (1):
      pinctrl: aspeed: Fix potential NULL dereference in aspeed_pinmux_set_=
mux()

Heiner Kallweit (1):
      r8169: fix accessing unset transport header

Helge Deller (4):
      fbcon: Disallow setting font bigger than screen size
      fbcon: Prevent that screen size is smaller than font size
      fbmem: Check virtual screen sizes in fb_set_var()
      fbcon: Use fbcon_info_from_console() in fbcon_modechange_possible()

Hsin-Yi Wang (1):
      video: of_display_timing.h: include errno.h

Huacai Chen (1):
      LoongArch: Fix build errors for tinyconfig

Ivan Malov (1):
      xsk: Clear page contiguity bit when unmapping pool

Jacky Bai (1):
      pinctrl: imx: Add the zero base flag for imx93

Jakub Kicinski (3):
      docs: netdev: document that patch series length limit
      docs: netdev: document reverse xmas tree
      docs: netdev: add a cheat sheet for the rules

Jamie Iles (1):
      irqchip/xilinx: Add explicit dependency on OF_ADDRESS

Jan Beulich (1):
      xen-netfront: restore __skb_queue_tail() positioning in
xennet_get_responses()

Jason A. Donenfeld (6):
      powerpc/powernv: delay rng platform device creation until later in bo=
ot
      wireguard: selftests: set fake real time in init
      wireguard: selftests: use virt machine on m68k
      wireguard: selftests: always call kernel makefile
      wireguard: selftests: use microvm on x86
      crypto: s390 - do not depend on CRYPTO_HW for SIMD implementations

Jean Delvare (1):
      i2c: piix4: Fix a memory leak in the EFCH MMIO support

Jens Axboe (1):
      io_uring: check that we have a file table when allocating update slot=
s

Jerry Snitselaar (1):
      dmaengine: idxd: Only call idxd_enable_system_pasid() if
succeeded in enabling SVA feature

Jia Zhu (1):
      cachefiles: narrow the scope of flushed requests when releasing fd

Jimmy Assarsson (3):
      can: kvaser_usb: replace run-time checks with struct
kvaser_usb_driver_info
      can: kvaser_usb: kvaser_usb_leaf: fix CAN clock frequency regression
      can: kvaser_usb: kvaser_usb_leaf: fix bittiming limits

Joerg Roedel (1):
      MAINTAINERS: Remove iommu@lists.linux-foundation.org

John Hubbard (1):
      gen_compile_commands: handle multiple lines per .mod file

John Veness (1):
      ALSA: usb-audio: Add quirks for MacroSilicon MS2100/MS2106 devices

Jonathan Cameron (1):
      cxl: Fix cleanup of port devices on failure to probe driver.

Judy Hsiao (1):
      ASoC: rockchip: i2s: switch BCLK to GPIO

Juergen Gross (3):
      x86/xen: Use clear_bss() for Xen PV guests
      x86: Clear .brk area at early boot
      x86: Fix .brk attribute in linker script

Karsten Graul (1):
      MAINTAINERS: add Wenjia as SMC maintainer

Keith Busch (2):
      nvme-pci: phison e16 has bogus namespace ids
      nvme: use struct group for generic command dwords

Kent Gibson (1):
      gpiolib: cdev: fix null pointer dereference in linereq_free()

Kishen Maloor (2):
      mptcp: netlink: issue MP_PRIO signals from userspace PMs
      selftests: mptcp: userspace PM support for MP_PRIO signals

Konrad Dybcio (2):
      arm64: dts: qcom: msm8994: Fix CPU6/7 reg values
      MAINTAINERS: Add myself as a reviewer for Qualcomm ARM/64 support

Kuninori Morimoto (1):
      ASoC: ak4613: cares Simple-Audio-Card case for TDM

Leon Romanovsky (1):
      gpio: vf610: fix compilation error

Li kunyu (1):
      net: usb: Fix typo in code

Liang He (1):
      can: grcan: grcan_probe(): remove extra of_node_get()

Linus Torvalds (3):
      signal handling: don't use BUG_ON() for debugging
      ida: don't use BUG_ON() for debugging
      Linux 5.19-rc6

Linus Walleij (1):
      soc: ixp4xx/npe: Fix unused match warning

Lu Baolu (1):
      iommu/vt-d: Fix RID2PASID setup/teardown failure

Lukas Bulwahn (1):
      LoongArch: Drop these obsolete selects in Kconfig

Lukasz Cieplicki (1):
      i40e: Fix dropped jumbo frames statistics

Marc Kleine-Budde (5):
      can: m_can: m_can_chip_config(): actually enable internal timestampin=
g
      can: m_can: m_can_{read_fifo,echo_tx_event}(): shift timestamp
to full 32 bits
      can: mcp251xfd: mcp251xfd_stop(): add missing hrtimer_cancel()
      can: mcp251xfd: mcp251xfd_register_get_dev_id(): use correct
length to read dev_id
      can: mcp251xfd: mcp251xfd_register_get_dev_id(): fix endianness conve=
rsion

Mario Limonciello (2):
      ACPI: CPPC: Only probe for _CPC if CPPC v2 is acked
      ACPI: CPPC: Don't require _OSC if X86_FEATURE_CPPC is supported

Mark Brown (3):
      ASoC: ops: Fix off by one in range control validation
      ASoC: wcd9335: Fix spurious event generation
      ASoC: wcd938x: Fix event generation for some controls

Masahiro Yamada (1):
      kbuild: remove unused cmd_none in scripts/Makefile.modinst

Masami Hiramatsu (Google) (1):
      fprobe, samples: Add module parameter descriptions

Mat Martineau (2):
      mptcp: Avoid acquiring PM lock for subflow priority changes
      mptcp: Acquire the subflow socket lock before modifying MP_PRIO flags

Miaoqian Lin (3):
      dmaengine: ti: Fix refcount leak in ti_dra7_xbar_route_allocate
      dmaengine: ti: Add missing put_device in ti_dra7_xbar_route_allocate
      ARM: meson: Fix refcount leak in meson_smp_prepare_cpus

Michael Roth (1):
      x86/compressed/64: Add identity mappings for setup_data entries

Michael Walle (2):
      dmaengine: at_xdma: handle errors of at_xdmac_alloc_desc() correctly
      net: lan966x: hardcode the number of external ports

Mihai Sain (1):
      ARM: at91: fix soc detection for SAM9X60 SiPs

Norbert Zulinski (1):
      i40e: Fix VF's MAC Address change on VM

Oleksandr Tyshchenko (1):
      xen/arm: Fix race in RB-tree based P2M accounting

Oliver Hartkopp (1):
      can: bcm: use call_rcu() instead of costly synchronize_rcu()

Oliver Neukum (1):
      usbnet: fix memory leak in error case

Pablo Neira Ayuso (2):
      netfilter: nf_tables: stricter validation of element data
      netfilter: nft_set_pipapo: release elements in clone from abort path

Paolo Abeni (2):
      mptcp: fix locking in mptcp_nl_cmd_sf_destroy()
      mptcp: fix local endpoint accounting

Pavel Begunkov (1):
      io_uring: explicit sqe padding for ioctl commands

Peng Fan (14):
      arm64: dts: imx8mp: correct clock of pgc_ispdwp
      arm64: dts: imx8mp-evk: correct mmc pad settings
      arm64: dts: imx8mp-evk: correct gpio-led pad settings
      arm64: dts: imx8mp-evk: correct vbus pad settings
      arm64: dts: imx8mp-evk: correct eqos pad settings
      arm64: dts: imx8mp-evk: correct vbus pad settings
      arm64: dts: imx8mp-evk: correct I2C5 pad settings
      arm64: dts: imx8mp-evk: correct I2C1 pad settings
      arm64: dts: imx8mp-evk: correct I2C3 pad settings
      arm64: dts: imx8mp-venice-gw74xx: correct pad settings
      arm64: dts: imx8mp-phyboard-pollux-rdk: correct uart pad settings
      arm64: dts: imx8mp-phyboard-pollux-rdk: correct eqos pad settings
      arm64: dts: imx8mp-phyboard-pollux-rdk: correct i2c2 & mmc settings
      arm64: dts: imx8mp-icore-mx8mp-edim2.2: correct pad settings

Peter Robinson (1):
      dmaengine: imx-sdma: Allow imx8m for imx7 FW revs

Peter Ujfalusi (5):
      ASoC: SOF: Intel: hda-dsp: Expose hda_dsp_core_power_up()
      ASoC: SOF: Intel: hda-loader: Make sure that the fw load
sequence is followed
      ASoC: SOF: Intel: hda-loader: Clarify the cl_dsp_init() flow
      ASoC: SOF: ipc3-topology: Move and correct size checks in
sof_ipc3_control_load_bytes()
      ASoC: SOF: Intel: hda: Fix compressed stream position tracking

Peter Zijlstra (1):
      x86/ibt, objtool: Don't discard text references from tracepoint secti=
on

Pierre-Louis Bossart (11):
      ASoC: Realtek/Maxim SoundWire codecs: disable pm_runtime on remove
      ASoC: rt711-sdca-sdw: fix calibrate mutex initialization
      ASoC: Intel: sof_sdw: handle errors on card registration
      ASoC: rt711: fix calibrate mutex initialization
      ASoC: rt7*-sdw: harden jack_detect_handler
      ASoC: codecs: rt700/rt711/rt711-sdca: initialize workqueues in probe
      ASoC: codecs: rt700/rt711/rt711-sdca: resume bus/codec in .set_jack_d=
etect
      MAINTAINERS: update ASoC/Intel/SOF maintainers
      ASoC: SOF: pm: add explicit behavior for ACPI S1 and S2
      ASoC: SOF: pm: add definitions for S4 and S5 states
      ASoC: SOF: Intel: disable IMR boot when resuming from ACPI S4
and S5 states

Qi Hu (1):
      LoongArch: Remove obsolete mentions of vcsr

Rafael J. Wysocki (2):
      PM: runtime: Redefine pm_runtime_release_supplier()
      PM: runtime: Fix supplier device management during consumer probe

Rhett Aultman (1):
      can: gs_usb: gs_usb_open/close(): fix memory leak

Rick Lindsley (1):
      ibmvnic: Properly dispose of all skbs during a failover.

Robin Murphy (1):
      irqchip/gicv3: Handle resource request failure consistently

Roger Pau Monne (4):
      xen/blkfront: fix leaking data in shared pages
      xen/netfront: fix leaking data in shared pages
      xen/netfront: force data bouncing when backend is untrusted
      xen/blkfront: force data bouncing when backend is untrusted

Samuel Holland (2):
      pinctrl: sunxi: a83t: Fix NAND function name for some pins
      dt-bindings: dma: allwinner,sun50i-a64-dma: Fix min/max typo

Sascha Hauer (1):
      dmaengine: imx-sdma: only restart cyclic channel when enabled

Satish Nagireddy (1):
      i2c: cadence: Unregister the clk notifier in error path

Sherry Sun (1):
      arm64: dts: imx8mp-evk: correct the uart2 pinctl value

Shuah Khan (3):
      misc: rtsx_usb: fix use of dma mapped buffer for usb bulk transfer
      misc: rtsx_usb: use separate command and response buffers
      misc: rtsx_usb: set return value in rsp_buf alloc err path

Shuming Fan (1):
      ASoC: rt711-sdca: fix kernel NULL pointer dereference when IO error

Srinivas Kandagatla (2):
      ASoC: qdsp6: q6apm-dai: unprepare stream if its already prepared
      MAINTAINERS: update ASoC Qualcomm maintainer email-id

Srinivas Neeli (1):
      Revert "can: xilinx_can: Limit CANFD brp to 2"

Stafford Horne (1):
      irqchip: or1k-pic: Undefine mask_ack for level triggered hardware

Stephan Gerhold (1):
      arm64: dts: qcom: msm8992-*: Fix vdd_lvs1_2-supply typo

Stephen Boyd (1):
      arm64: dts: qcom: Remove duplicate sc7180-trogdor include on
lazor/homestar

Sven Schnelle (1):
      ptrace: fix clearing of JOBCTL_TRACED in ptrace_unfreeze_traced()

Takashi Iwai (2):
      ALSA: usb-audio: Workarounds for Behringer UMC 204/404 HD
      ALSA: cs46xx: Fix missing snd_card_free() call at probe error

Thomas Kopp (2):
      can: mcp251xfd: mcp251xfd_regmap_crc_read(): improve workaround
handling for mcp2517fd
      can: mcp251xfd: mcp251xfd_regmap_crc_read(): update workaround
broken CRC on TBC register

Thomas Zimmermann (1):
      drm/aperture: Run fbdev removal before internal helpers

Tiezhu Yang (1):
      LoongArch: Fix section mismatch warning

Tim Crawford (1):
      ALSA: hda/realtek: Add quirk for Clevo L140PU

Vasyl Vavrychuk (1):
      Bluetooth: core: Fix deadlock on hci_power_on_sync.

Vincent Guittot (1):
      firmware: arm_scmi: Fix response size warning for OPTEE transport

Vinod Koul (1):
      dmaengine: Revert "dmaengine: add verification of DMA_INTERRUPT
capability for dmatest"

Vishal Verma (1):
      cxl/mbox: Fix missing variable payload checks in cmd size validation

Vlad Buslov (2):
      net/sched: act_police: allow 'continue' action offload
      net/mlx5e: Fix matchall police parameters validation

Vladimir Oltean (3):
      selftests: forwarding: fix flood_unicast_test when h2 supports
IFF_UNICAST_FLT
      selftests: forwarding: fix learning_test when h1 supports IFF_UNICAST=
_FLT
      selftests: forwarding: fix error message in learning_test

Vladimir Zapolskiy (1):
      arm64: dts: qcom: sm8450: fix interconnects property of UFS node

Vladis Dronov (1):
      wireguard: Kconfig: select CRYPTO_CHACHA_S390

Wei Yongjun (1):
      irqchip/apple-aic: Make symbol 'use_fast_ipi' static

Xiang wangx (1):
      openrisc: unwinder: Fix grammar issue in comment

Yassine Oudjana (1):
      ASoC: wcd9335: Remove RX channel from old list before adding it
to a new one

Yian Chen (1):
      iommu/vt-d: Fix PCI bus rescan device hot add

Yue Hu (2):
      fscache: Fix if condition in fscache_wait_on_volume_collision()
      fscache: Introduce fscache_cookie_is_dropped()
