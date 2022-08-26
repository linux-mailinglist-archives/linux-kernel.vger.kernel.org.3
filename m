Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D173E5A2236
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 09:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245602AbiHZHq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 03:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245594AbiHZHqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 03:46:49 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F99D3997;
        Fri, 26 Aug 2022 00:46:38 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MDX310nsGz4wgv;
        Fri, 26 Aug 2022 17:46:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1661499997;
        bh=tiLXuA6zYODIP64YqhXKNfLWwlPobGytDr5VbHT7n6o=;
        h=Date:From:To:Cc:Subject:From;
        b=VkhUjM/WMP61V225GVHB/2yOT+WQccTlFz4apXHMR80r9FM/vN3uaQNAf4LIh5m2Z
         FLElKZO/7QbBrzaXkHXOYnQEbzDk51MOBkxrEzz63esTFr2Vqtxvl31H8r8tGFq0tL
         0EX8/cMvh7M8LbGHAWvDgYhVDJTH3LLrDdvukibHXrdvIFZT4dEeUDn3RcvcjrTmI9
         v8Wg+z+mXqxL6fwATFag71352xj3t/bNkaaWl8kZ+BsfgbcbDv1cUNcLqdrGd2Dh2V
         W4hOHVYMWO+mYlGAfeOW5unbhQkAPAp0mHn9KuMIAiyBPRujjFo1LNeIuekrw9YMAh
         lbGBEMHF7FAhg==
Date:   Fri, 26 Aug 2022 17:46:35 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Aug 26
Message-ID: <20220826174635.628e180f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/zfB5=UTI74i.pas7qIvJpec";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,LOCALPART_IN_SUBJECT,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/zfB5=UTI74i.pas7qIvJpec
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20220825:

The bpf-next tree gained a conflict against the bpf trees.

The drm-intel tree gained a semantic conflict against the drm tree.

The scsi-mkp tree still had its build failure so I used the version from
next-20220823.

The pinctrl tree gained a semantic conflict against the i2c tree.

The mm tree gained a build failure for which I reverted a commit.

Non-merge commits (relative to Linus' tree): 2993
 4337 files changed, 169921 insertions(+), 65395 deletions(-)

----------------------------------------------------------------------------

I have created today's linux-next tree at
git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
(patches at http://www.kernel.org/pub/linux/kernel/next/ ).  If you
are tracking the linux-next tree using git, you should not use "git pull"
to do so as that will try to merge the new linux-next release with the
old one.  You should use "git fetch" and checkout or reset to the new
master.

You can see which trees have been included by looking in the Next/Trees
file in the source.  There are also quilt-import.log and merge.log
files in the Next directory.  Between each merge, the tree was built
with a ppc64_defconfig for powerpc, an allmodconfig for x86_64, a
multi_v7_defconfig for arm and a native build of tools/perf. After
the final fixups (if any), I do an x86_64 modules_install followed by
builds for x86_64 allnoconfig, powerpc allnoconfig (32 and 64 bit),
ppc44x_defconfig, allyesconfig and pseries_le_defconfig and i386,
arm64, sparc and sparc64 defconfig and htmldocs. And finally, a simple
boot test of the powerpc pseries_le_defconfig kernel in qemu (with and
without kvm enabled).

Below is a summary of the state of the merge.

I am currently merging 358 trees (counting Linus' and 98 trees of bug
fix patches pending for the current merge release).

Stats about the size of the tree over time can be seen at
http://neuling.org/linux-next-size.html .

Status of my local build tests will be at
http://kisskb.ellerman.id.au/linux-next .  If maintainers want to give
advice about cross compilers/configs that work, we are always open to add
more builds.

Thanks to Randy Dunlap for doing many randconfig builds.  And to Paul
Gortmaker for triage and bug fixes.

--=20
Cheers,
Stephen Rothwell

$ git checkout master
$ git reset --hard stable
Merging origin/master (4c612826bec1 Merge tag 'net-6.0-rc3' of git://git.ke=
rnel.org/pub/scm/linux/kernel/git/netdev/net)
Merging fixes/fixes (1c23f9e627a7 Linux 6.0-rc2)
Merging mm-hotfixes/mm-hotfixes-unstable (c5044de8a23c mm-page_alloc-fix-ra=
ce-condition-between-build_all_zonelists-and-page-allocation-fix)
Merging kbuild-current/fixes (15b3f48a4339 Merge tag 'kbuild-fixes-v6.0' of=
 git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild)
Merging arc-current/for-curr (952deecb065e arc: dts: Harmonize EHCI/OHCI DT=
 nodes name)
Merging arm-current/fixes (ec85bd369fd2 ARM: findbit: fix overflowing offse=
t)
Merging arm64-fixes/for-next/fixes (714f3cbd70a4 arm64/sme: Don't flush SVE=
 register state when handling SME traps)
Merging arm-soc-fixes/arm/fixes (3cbd67384677 MAINTAINERS: add the Polarfir=
e SoC's i2c driver)
Merging drivers-memory-fixes/fixes (568035b01cfb Linux 6.0-rc1)
Merging tee-fixes/fixes (98268f2a2a9f Merge branch 'optee_ffa_probe_fix_for=
_v5.18' into fixes)
Merging m68k-current/for-linus (b508128bb0d1 m68k: defconfig: Update defcon=
figs for v5.19-rc1)
Merging powerpc-fixes/fixes (f889a2e89ea5 selftests/powerpc: Add missing PM=
U selftests to .gitignores)
Merging s390-fixes/fixes (41ac42f13708 s390/mm: do not trigger write fault =
when vma does not allow VM_WRITE)
Merging sparc/master (05a59d79793d Merge git://git.kernel.org:/pub/scm/linu=
x/kernel/git/netdev/net)
Merging fscrypt-current/for-stable (80f6e3080bfc fs-verity: fix signed inte=
ger overflow with i_size near S64_MAX)
Merging net/master (4c612826bec1 Merge tag 'net-6.0-rc3' of git://git.kerne=
l.org/pub/scm/linux/kernel/git/netdev/net)
Merging bpf/master (a657182a5c51 bpf: Don't use tnum_range on array range c=
hecking for poke descriptors)
Merging ipsec/master (17ecd4a4db47 xfrm: policy: fix metadata dst->dev xmit=
 null pointer dereference)
Merging netfilter/master (7fb0269720d7 Merge tag 'for-net-2022-05-23' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth)
Merging ipvs/master (7fb0269720d7 Merge tag 'for-net-2022-05-23' of git://g=
it.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth)
Merging wireless/for-next (55f0a4894484 wifi: mac80211: potential NULL dere=
ference in ieee80211_tx_control_port())
Merging rdma-fixes/for-rc (56c310de0b4b RDMA/rtrs-srv: Pass the correct num=
ber of entries for dma mapped SGL)
Merging sound-current/for-linus (6ab55ec0a938 ALSA: control: Fix an out-of-=
bounds bug in get_ctl_id_hash())
Merging sound-asoc-fixes/for-linus (b1cd3fd42db7 ASoC: fsl_aud2htx: Add err=
or handler for pm_runtime_enable)
Merging regmap-fixes/for-linus (f5723cfc0193 regmap: spi: Reserve space for=
 register address/padding)
Merging regulator-fixes/for-linus (78e1e867f44e regulator: pfuze100: Fix th=
e global-out-of-bounds access in pfuze100_regulator_probe())
Merging spi-fixes/for-linus (9ee5b6d53b8c spi: cadence-quadspi: Disable irq=
s during indirect reads)
Merging pci-current/for-linus (0e1fa5155a36 MAINTAINERS: Add Mahesh J Salga=
onkar as EEH maintainer)
Merging driver-core.current/driver-core-linus (a4f124908617 Revert "iommu/o=
f: Delete usage of driver_deferred_probe_check_state()")
Merging tty.current/tty-linus (b5a5b9d5f28d serial: document start_rx membe=
r at struct uart_ops)
Merging usb.current/usb-linus (8531aa1659f7 Revert "xhci: turn off port pow=
er in shutdown")
Merging usb-gadget-fixes/fixes (e49d033bddf5 Linux 5.12-rc6)
Merging usb-serial-fixes/usb-linus (1c23f9e627a7 Linux 6.0-rc2)
Merging phy/fixes (568035b01cfb Linux 6.0-rc1)
Merging staging.current/staging-linus (e01f5c8d6af2 staging: r8188eu: Add R=
osewill USB-N150 Nano to device tables)
Merging iio-fixes/fixes-togreg (0096fc879358 iio: light: cm32181: make cm32=
181_pm_ops static)
Merging counter-fixes/fixes-togreg (568035b01cfb Linux 6.0-rc1)
Merging char-misc.current/char-misc-linus (a582123d6f4c Merge tag 'iio-fixe=
s-for-6.0a' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio in=
to char-misc-linus)
Merging soundwire-fixes/fixes (c6e50787889c soundwire: qcom: remove duplica=
te reset control get)
Merging thunderbolt-fixes/fixes (93a3c0d4e8bf thunderbolt: Check router gen=
eration before connecting xHCI)
Merging input-current/for-linus (80b9ebd3e478 Input: goodix - add compatibl=
e string for GT1158)
Merging crypto-current/master (af5d35b83f64 crypto: tcrypt - Remove the sta=
tic variable initialisations to NULL)
Merging vfio-fixes/for-linus (afe4e376ac5d vfio: Move IOMMU_CAP_CACHE_COHER=
ENCY test to after we know we have a group)
Merging kselftest-fixes/fixes (bdbf0617bbc3 selftests/vm: fix inability to =
build any vm tests)
Merging modules-fixes/modules-linus (e69a66147d49 module: kallsyms: Ensure =
preemption in add_kallsyms() with PREEMPT_RT)
Merging dmaengine-fixes/fixes (568035b01cfb Linux 6.0-rc1)
Merging backlight-fixes/for-backlight-fixes (a38fd8748464 Linux 5.12-rc2)
Merging mtd-fixes/mtd/fixes (0fddf9ad06fd mtd: rawnand: gpmi: Set WAIT_FOR_=
READY timeout based on program/erase times)
Merging mfd-fixes/for-mfd-fixes (a61f4661fba4 mfd: intel_quark_i2c_gpio: Re=
vert "Constify static struct resources")
Merging v4l-dvb-fixes/fixes (3bcc2c1eade4 media: rkvdec: Disable H.264 erro=
r detection)
Merging reset-fixes/reset/fixes (a57f68ddc886 reset: Fix devm bulk optional=
 exclusive control getter)
Merging mips-fixes/mips-fixes (568035b01cfb Linux 6.0-rc1)
Merging at91-fixes/at91-fixes (ef0324b6415d ARM: dts: lan966x: fix sys_clk =
frequency)
Merging omap-fixes/fixes (2eb502f496f7 ARM: dts: am33xx: Fix MMCHS0 dma pro=
perties)
Merging kvm-fixes/master (372d07084593 KVM: selftests: Fix ambiguous mov in=
 KVM_ASM_SAFE())
Merging kvms390-fixes/master (cf5029d5dd7c KVM: x86: Protect the unused bit=
s in MSR exiting flags)
Merging hwmon-fixes/hwmon (ed3590561f5d hwmon: (pmbus) Fix vout margin cach=
ing)
Merging nvdimm-fixes/libnvdimm-fixes (17d9c15c9b9e fsdax: Fix infinite loop=
 in dax_iomap_rw())
Merging cxl-fixes/fixes (e35f5718903b cxl/mbox: Fix missing variable payloa=
d checks in cmd size validation)
Merging btrfs-fixes/next-fixes (af39011ec0c7 Merge branch 'misc-5.19' into =
next-fixes)
Merging vfs-fixes/fixes (3f61631d47f1 take care to handle NULL ->proc_lseek=
())
Merging dma-mapping-fixes/for-linus (3be4562584bb dma-direct: use the corre=
ct size for dma_set_encrypted())
Merging i3c-fixes/i3c/fixes (fe07bfda2fb9 Linux 5.12-rc1)
Merging drivers-x86-fixes/fixes (6b2caaafc5df platform/surface: aggregator_=
registry: Add HID devices for sensors and UCSI client to SP8)
Merging samsung-krzk-fixes/fixes (568035b01cfb Linux 6.0-rc1)
Merging pinctrl-samsung-fixes/fixes (568035b01cfb Linux 6.0-rc1)
Merging devicetree-fixes/dt/linus (40bfe7a86d84 of/device: Fix up of_dma_co=
nfigure_id() stub)
Merging dt-krzk-fixes/fixes (568035b01cfb Linux 6.0-rc1)
Merging scsi-fixes/fixes (785538bfdd68 scsi: sd: Revert "Rework asynchronou=
s resume support")
Merging drm-fixes/drm-fixes (100d0ae82b5c Merge tag 'amd-drm-fixes-6.0-2022=
-08-25' of https://gitlab.freedesktop.org/agd5f/linux into drm-fixes)
Merging amdgpu-fixes/drm-fixes (2c409ba81be2 drm/radeon: fix si_enable_smc_=
cac() failed issue)
Merging drm-intel-fixes/for-linux-next-fixes (6067c82c576a drm/i915/backlig=
ht: Disable pps power hook for aux based backlight)
Merging mmc-fixes/fixes (63f1560930e4 mmc: core: Fix inconsistent sd3_bus_m=
ode at UHS-I SD voltage switch failure)
Merging rtc-fixes/rtc-fixes (568035b01cfb Linux 6.0-rc1)
Merging gnss-fixes/gnss-linus (a111daf0c53a Linux 5.19-rc3)
Merging hyperv-fixes/hyperv-fixes (f15f39fabed2 tools: hv: Remove an extran=
eous "the")
Merging soc-fsl-fixes/fix (4b0986a3613c Linux 5.18)
Merging risc-v-fixes/fixes (1709c70c31e0 Merge branch 'riscv-variable_fixes=
_without_kvm' of git://git.kernel.org/pub/scm/linux/kernel/git/palmer/linux=
.git into fixes)
Merging risc-v-mc-fixes/dt-fixes (e4009c5fa77b riscv: dts: microchip: mpfs:=
 remove pci axi address translation property)
Merging pidfd-fixes/fixes (03ba0fe4d09f file: simplify logic in __close_ran=
ge())
Merging fpga-fixes/fixes (568035b01cfb Linux 6.0-rc1)
Merging spdx/spdx-linus (568035b01cfb Linux 6.0-rc1)
Merging gpio-brgl-fixes/gpio/for-current (3f4e432fb9c6 gpio: pxa: use devre=
s for the clock struct)
Merging gpio-intel-fixes/fixes (b93a8b2c5161 gpio: dln2: make irq_chip immu=
table)
Merging pinctrl-intel-fixes/fixes (ba79c5e45eec MAINTAINERS: Update Intel p=
in control to Supported)
Merging erofs-fixes/fixes (8b1ac84dcf2c Documentation/ABI: sysfs-fs-erofs: =
Fix Sphinx errors)
Merging integrity-fixes/fixes (843385694721 evm: Fix a small race in init_d=
esc())
Merging kunit-fixes/kunit-fixes (41a55567b9e3 module: kunit: Load .kunit_te=
st_suites section when CONFIG_KUNIT=3Dm)
Merging ubifs-fixes/fixes (c3c07fc25f37 ubi: fastmap: Return error code if =
memory allocation fails in add_aeb())
Merging memblock-fixes/fixes (c94afc46cae7 memblock: use kfree() to release=
 kmalloced memblock regions)
Merging cel-fixes/for-rc (6930bcbfb6ce lockd: detect and reject lock argume=
nts that overflow)
Merging irqchip-fixes/irq/irqchip-fixes (c3e88d91e409 irqchip/stm32-exti: R=
emove check on always false condition)
Merging renesas-fixes/fixes (432b52eea3dc ARM: shmobile: defconfig: Restore=
 graphical consoles)
Merging broadcom-fixes/fixes (a26f045984e7 Merge branch 'devicetree/fixes' =
into fixes)
Merging perf-current/perf/urgent (15b3f48a4339 Merge tag 'kbuild-fixes-v6.0=
' of git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild)
Merging efi-fixes/urgent (1a3887924a7e efi: libstub: Disable struct randomi=
zation)
Merging zstd-fixes/zstd-linus (88a309465b3f lib: zstd: clean up double word=
 in comment.)
Merging battery-fixes/fixes (568035b01cfb Linux 6.0-rc1)
Merging drm-misc-fixes/for-linux-next-fixes (a3f7c10a269d dma-buf/dma-resv:=
 check if the new fence is really later)
Merging kbuild/for-next (15b3f48a4339 Merge tag 'kbuild-fixes-v6.0' of git:=
//git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild)
Merging clang-format/clang-format (781121a7f6d1 clang-format: Fix space aft=
er for_each macros)
Merging perf/perf/core (4e8827acb5e1 perf metrics: Use 'unsigned int' inste=
ad of just 'unsigned'.)
Merging compiler-attributes/compiler-attributes (7c00621dcaee compiler_type=
s: mark __compiletime_assert failure as __noreturn)
Merging dma-mapping/for-next (5c850d31880e swiotlb: fix passing local varia=
ble to debugfs_create_ulong())
Merging asm-generic/master (82dc270146a8 Merge branch 'asm-generic-fixes' i=
nto asm-generic)
Merging arc/for-next (f2906aa86338 Linux 5.19-rc1)
Merging arm/for-next (3eaecd0677e1 Merge branches 'misc' and 'fixes' into f=
or-next)
Merging arm64/for-next/core (892f7237b3ff arm64: Delay initialisation of cp=
uinfo_arm64::reg_{zcr,smcr})
Merging arm-perf/for-next/perf (aaaee7b55c9e docs: perf: Include hns3-pmu.r=
st in toctree to fix 'htmldocs' WARNING)
Merging arm-soc/for-next (87a5b37a8f02 Merge branch 'arm/late' into for-nex=
t)
CONFLICT (content): Merge conflict in arch/arm/mach-s3c/Kconfig.s3c64xx
CONFLICT (content): Merge conflict in arch/arm64/configs/defconfig
Merging actions/for-next (444d018d8d38 ARM: dts: owl-s500-roseapplepi: Add =
ATC2603C PMIC)
Merging amlogic/for-next (045dd6b2fcf9 Merge branch 'v6.1/dt64' into for-ne=
xt)
Merging aspeed/for-next (7bc156fbb726 ARM: config: aspeed_g5: Enable PECI)
Merging at91/at91-next (38b729bf1ee6 Merge branch 'at91-dt' into at91-next)
Merging broadcom/next (ade0d6ecf54a Merge branch 'drivers/next' into next)
Merging drivers-memory/for-next (cf4b4433946c Merge branch 'for-v6.1/brcm-s=
tb' into for-next)
Merging imx-mxs/for-next (a554a9e72736 Merge branch 'imx/dt64' into for-nex=
t)
Merging keystone/next (cb293d3b430e Merge branch 'for_5.15/drivers-soc' int=
o next)
Merging mediatek/for-next (39e1c2b211d0 Merge branch 'v6.0-next/soc' into f=
or-next)
Merging mvebu/for-next (bc50bfd4f018 Merge branch 'mvebu/dt64' into mvebu/f=
or-next)
Merging omap/for-next (ad2fe4582c48 Merge branches 'omap-for-v5.20/omap1', =
'omap-for-v5.20/ti-sysc' and 'omap-for-v5.20/soc' into for-next)
Merging qcom/for-next (964421bec6ed Merge branches 'arm64-defconfig-for-6.1=
', 'arm64-for-6.1', 'clk-for-6.1', 'defconfig-for-6.1', 'drivers-for-6.1' a=
nd 'dts-for-6.1' into for-next)
Merging raspberrypi/for-next (c5915b53d4c2 dt-bindings: soc: bcm: Convert b=
rcm,bcm2835-vchiq to json-schema)
Merging renesas/next (64f8982ca069 Merge branch 'renesas-arm-dt-for-v6.1' i=
nto renesas-next)
Merging reset/reset/next (d985db836226 reset: tps380x: Fix spelling mistake=
 "Voltags" -> "Voltage")
Merging rockchip/for-next (a6eeda46092d Merge branch 'v6.1-armsoc/dts64' in=
to for-next)
Merging samsung-krzk/for-next (9990f043d543 Merge branch 'next/dt64' into f=
or-next)
Merging scmi/for-linux-next (2cdcbfae5be5 Merge tag 'scmi-fixes-6.0' of git=
://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into for-linu=
x-next)
Merging stm32/stm32-next (4b43ff02d2a4 ARM: dts: stm32: Add ST MIPID02 bind=
ings to AV96)
Merging sunxi/sunxi/for-next (3930624c3936 clk: sunxi-ng: d1: Limit PLL rat=
es to stable ranges)
Merging tee/next (db30e53bf897 Merge branch 'tee_cleanup_for_v5.19' into ne=
xt)
Merging tegra/for-next (393c6c3a6152 Merge branch for-5.20/arm64/defconfig =
into for-next)
Merging ti/ti-next (62b9e4033c13 Merge branches 'ti-drivers-soc-next' and '=
ti-k3-dts-next' into ti-next)
Merging xilinx/for-next (0413dd4d95da ARM: dts: zynq: add QSPI controller n=
ode)
Merging clk/clk-next (640b47fe2f82 Merge branch 'clk-fixes' into clk-next)
Merging clk-imx/for-next (c196175acdd3 clk: imx: clk-fracn-gppll: Add more =
freq config for video pll)
Merging clk-renesas/renesas-clk (57746e993442 clk: renesas: r9a07g044: Add =
conditional compilation for r9a07g044_cpg_info)
Merging clk-samsung/for-next (b35f27fe73d8 clk: samsung: exynosautov9: add =
cmu_peric1 clock support)
Merging csky/linux-next (45fef4c4b9c9 csky: abiv1: Fixup compile error)
Merging loongarch/loongarch-next (568035b01cfb Linux 6.0-rc1)
Merging m68k/for-next (1afdc013672b m68k: Move from strlcpy with unused ret=
val to strscpy)
Merging m68knommu/for-next (1c23f9e627a7 Linux 6.0-rc2)
Merging microblaze/next (568035b01cfb Linux 6.0-rc1)
Merging mips/mips-next (568035b01cfb Linux 6.0-rc1)
Merging nios2/for-next (7f7bc20bc41a nios2: Don't use _end for calculating =
min_low_pfn)
Merging openrisc/for-next (52e0ea900202 openrisc: io: Define iounmap argume=
nt as volatile)
Merging parisc-hd/for-next (b3b4f321a9ca parisc: ccio-dma: Add missing ioun=
map in error path in ccio_probe())
Merging powerpc/next (568035b01cfb Linux 6.0-rc1)
Merging soc-fsl/next (4b0986a3613c Linux 5.18)
Merging risc-v/for-next (789f3fa9dca0 Merge tag 'riscv-topo-on-6.0-rc1' of =
https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/ into for-n=
ext)
Merging risc-v-mc/dt-for-next (7eac0081a8e9 riscv: dts: microchip: add qspi=
 compatible fallback)
Merging s390/for-next (67a933343b48 Merge branch 'fixes' into for-next)
Merging sh/for-next (8518e694203d sh: pgtable-3level: Fix cast to pointer f=
rom integer of different size)
Merging sparc-next/master (dd0d718152e4 Merge tag 'spi-fix-v5.8-rc2' of git=
://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi)
Merging uml/linux-next (af3e16101cee um: include sys/types.h for size_t)
Merging xtensa/xtensa-for-next (0847d167d0f9 xtensa: enable ARCH_HAS_GCOV_P=
ROFILE_ALL)
Merging pidfd/for-next (6a857ab5b57c Merge branch 'fs.idmapped.overlay.acl'=
 into for-next)
Merging vfs-idmapping/for-next (985b4f6faa27 Merge branch 'fixes' into for-=
next)
Merging fscrypt/master (deb4c809d7e8 fscrypt: work on block_devices instead=
 of request_queues)
Merging fscache/fscache-next (0885eacdc81f Merge tag 'nfsd-5.19-1' of git:/=
/git.kernel.org/pub/scm/linux/kernel/git/cel/linux)
Merging afs/afs-next (26291c54e111 Linux 5.17-rc2)
Merging btrfs/for-next (00535da77b92 Merge branch 'for-next-next-v6.0-20220=
823' into for-next-20220823)
Merging ceph/master (a8af0d682ae0 libceph: clean up ceph_osdc_start_request=
 prototype)
Merging cifs/for-next (b816251ee876 smb3: fix temporary data corruption in =
insert range)
Merging configfs/for-next (84ec758fb2da configfs: fix a race in configfs_{,=
un}register_subsystem())
Merging ecryptfs/next (682a8e2b41ef Merge tag 'ecryptfs-5.13-rc1-updates' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/tyhicks/ecryptfs)
Merging erofs/dev (0d53d2e882f9 erofs: avoid the potentially wrong m_plen f=
or big pcluster)
Merging exfat/dev (df13a3477635 MAINTAINERS: Add Namjae's exfat git tree)
Merging ext3/for_next (5b02b6900c8d Pull fsnotify typo fix.)
Merging ext4/dev (d95efb14c0b8 ext4: add ioctls to get/set the ext4 superbl=
ock uuid)
Merging f2fs/dev (48c8706cbaa7 f2fs: complete checkpoints during remount)
Merging fsverity/fsverity (8377e8a24bba fs-verity: use kmap_local_page() in=
stead of kmap())
Merging fuse/for-next (247861c325c2 fuse: retire block-device-based superbl=
ock on force unmount)
Merging gfs2/for-next (86934198eefa gfs2: Clear flags when withdraw prevent=
s xmote)
Merging jfs/jfs-next (e471e5942c00 fs/jfs: Remove dead code)
Merging ksmbd/ksmbd-for-next (8c9073fa857c ksmbd: constify struct path)
Merging nfs/linux-next (ed06fce0b034 SUNRPC: RPC level errors should set ta=
sk->tk_rpc_status)
Merging nfs-anna/linux-next (4f40a5b55446 NFSv4: Add an fattr allocation to=
 _nfs4_discover_trunking())
Merging nfsd/for-next (deb33fa8542e NFSD enforce filehandle check for sourc=
e file in COPY)
Merging ntfs3/master (3b06a2755758 Merge tag 'ntfs3_for_6.0' of https://git=
hub.com/Paragon-Software-Group/linux-ntfs3)
Merging orangefs/for-next (40a74870b2d1 orangefs: Fix the size of a memory =
allocation in orangefs_bufmap_alloc())
Merging overlayfs/overlayfs-next (4f1196288dfb ovl: fix spelling mistakes)
Merging ubifs/next (8c03a1c21d72 ubi: ubi_create_volume: Fix use-after-free=
 when volume creation failed)
Merging v9fs/9p-next (aa7aeee16948 net/9p: Initialize the iounit field duri=
ng fid creation)
Merging xfs/for-next (031d166f968e xfs: fix inode reservation space for rem=
oving transaction)
Merging zonefs/for-next (6bac30bb8ff8 zonefs: Call page_address() on page a=
cquired with GFP_KERNEL flag)
Merging iomap/iomap-for-next (478af190cb6c iomap: remove iomap_writepage)
Merging djw-vfs/vfs-for-next (49df34221804 fs: fix an infinite loop in ioma=
p_fiemap)
Merging file-locks/locks-next (072e51356cd5 Merge tag 'nfs-for-5.20-2' of g=
it://git.linux-nfs.org/projects/trondmy/linux-nfs)
Merging vfs/for-next (0a97e98ab197 Merge branches 'work.path' and 'work.fil=
e_inode' into for-next)
Merging printk/for-next (c0a684057235 Merge branch 'for-6.1/trivial' into f=
or-next)
Merging pci/next (c918c1a14084 Merge branch 'remotes/lorenzo/pci/qcom')
Merging pstore/for-next/pstore (2c09d1443b9b pstore/zone: cleanup "rcnt" ty=
pe)
Merging hid/for-next (1f21e5bfbac7 Merge branch 'for-6.0/upstream-fixes' in=
to for-next)
Merging i2c/i2c/for-next (b7cfdf99ca4c Merge branch 'i2c/for-current-fixed'=
 into i2c/for-next)
Merging i3c/i3c/next (568035b01cfb Linux 6.0-rc1)
Merging dmi/dmi-for-next (d2139dfca361 firmware: dmi: Use the proper access=
or for the version field)
Merging hwmon-staging/hwmon-next (1ad7a62d52e8 MAINTAINERS: Update Juerg Ha=
efliger's email address)
Merging jc_docs/docs-next (b68015a37f58 Merge branch 'docs-mw' into docs-ne=
xt)
Merging v4l-dvb/master (568035b01cfb Linux 6.0-rc1)
Merging v4l-dvb-next/master (1ff8334f0a4e media: MAINTAINERS: add entry for=
 i.MX8MP DW100 v4l2 mem2mem driver)
Merging pm/linux-next (149c50bccdd5 Merge branch 'thermal-next' into linux-=
next)
Merging cpufreq-arm/cpufreq/arm/linux-next (0612d928b7ff cpufreq: Add SM611=
5 to cpufreq-dt-platdev blocklist)
Merging cpupower/cpupower (568035b01cfb Linux 6.0-rc1)
Merging devfreq/devfreq-next (68831c5f94cb PM / devfreq: mtk-cci: Handle sr=
am regulator probe deferral)
Merging opp/opp/linux-next (c7e31e36d8a2 dt-bindings: opp: Add missing (une=
valuated|additional)Properties on child nodes)
Merging thermal/thermal/linux-next (06f360551217 Revert "mlxsw: core: Add t=
he hottest thermal zone detection")
Merging ieee1394/for-next (54b3bd99f094 firewire: nosy: switch from 'pci_' =
to 'dma_' API)
Merging dlm/next (56171e0db23a fs: dlm: const void resource name parameter)
Merging rdma/for-next (2c34bb6dea48 IB: move from strlcpy with unused retva=
l to strscpy)
Merging net-next/master (880b0dd94f03 Merge git://git.kernel.org/pub/scm/li=
nux/kernel/git/netdev/net)
Merging bpf-next/for-next (d4ffb6f39f1a bpf: Add CGROUP prefix to cgroup_it=
er_order)
CONFLICT (content): Merge conflict in net/core/filter.c
CONFLICT (content): Merge conflict in tools/testing/selftests/bpf/DENYLIST.=
s390x
Merging ipsec-next/master (93d7c52a6eb9 selftests/net: Refactor xfrm_fill_k=
ey() to use array of structs)
Merging mlx5-next/mlx5-next (b0bb369ee451 net/mlx5: fs, allow flow table cr=
eation with a UID)
Merging netfilter-next/master (677fb7525331 Merge git://git.kernel.org/pub/=
scm/linux/kernel/git/netdev/net)
Merging ipvs-next/master (677fb7525331 Merge git://git.kernel.org/pub/scm/l=
inux/kernel/git/netdev/net)
Merging bluetooth/master (808765508e8e Bluetooth: hci_sync: hold hdev->lock=
 when cleanup hci_conn)
Merging wireless-next/for-next (b8c9024e0ed0 wifi: cfg80211: Add link_id to=
 cfg80211_ch_switch_started_notify())
Merging mtd/mtd/next (7ec4cdb32173 mtd: core: check partition before derefe=
rence)
Merging nand/nand/next (e16eceea863b mtd: rawnand: arasan: Fix clock rate i=
n NV-DDR)
Merging spi-nor/spi-nor/next (f8cd9f632f44 mtd: spi-nor: fix spi_nor_spimem=
_setup_op() call in spi_nor_erase_{sector,chip}())
Merging crypto/master (47d35bf22b69 hwrng: imx-rngc - use KBUILD_MODNAME as=
 driver name)
Merging drm/drm-next (2c2d7a67defa Merge tag 'drm-intel-gt-next-2022-08-24'=
 of git://anongit.freedesktop.org/drm/drm-intel into drm-next)
Merging drm-misc/for-linux-next (3007dc2af6e8 drm/virtio: Fix same-context =
optimization)
CONFLICT (content): Merge conflict in drivers/gpu/drm/tiny/simpledrm.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/vc4/vc4_hdmi.c
Merging amdgpu/drm-next (a9c5e9c82039 drm/amd: remove possible condition wi=
th no effect (if =3D=3D else))
Merging drm-intel/for-linux-next (f02c7d5a8fa3 drm/i915/display/mtl: Extend=
 MBUS programming)
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/display/icl_dsi.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/display/vlv_dsi.c
Applying: fix up for "drm/i915/guc: Add GuC <-> kernel time stamp translati=
on information"
Merging drm-tegra/for-next (135f4c551d51 drm/tegra: vic: Use devm_platform_=
ioremap_resource())
Merging drm-msm/msm-next (568035b01cfb Linux 6.0-rc1)
Merging drm-msm-lumag/msm-next-lumag (12c71c0c3dbc Merge branch 'msm-next-l=
umag-dpu' into msm-next-lumag)
Merging imx-drm/imx-drm/next (927d8fd465ad drm/imx: ipuv3-plane: Remove red=
undant color encoding and range initialisation)
Merging etnaviv/etnaviv/next (6cffb1c27f2d drm/etnaviv: Remove duplicate ca=
ll to drm_gem_free_mmap_offset)
Merging fbdev/for-next (529dc9303ea8 fbdev: fbcon: Properly revert changes =
when vc_resize() failed)
Merging regmap/for-next (1bfa8e736383 Merge remote-tracking branch 'regmap/=
for-6.1' into regmap-next)
Merging sound/for-next (384c687fb4ad Merge branch 'topic/memalloc-cleanup' =
into for-next)
Merging sound-asoc/for-next (d0c485957caa Merge remote-tracking branch 'aso=
c/for-6.1' into asoc-next)
Merging modules/modules-next (554694ba120b module: Replace kmap() with kmap=
_local_page())
Merging input/next (a9da7251ac8b Input: gameport - move from strlcpy with u=
nused retval to strscpy)
Merging block/for-next (09621f178ff0 Merge branch 'for-6.1/block' into for-=
next)
Merging device-mapper/for-next (e3a7c2947b9e dm bufio: fix some cases where=
 the code sleeps with spinlock held)
Merging libata/for-next (9587264aea50 ata: libata-core: Simplify ata_dev_se=
t_xfermode())
Merging pcmcia/pcmcia-next (2ef4bb24ff39 pcmcia: Use platform_get_irq() to =
get the interrupt)
Merging mmc/next (6b77110b282c mmc: core: Switch to basic workqueue API for=
 sdio_irq_work)
Merging mfd/for-mfd-next (3d021aaca7c7 dt-bindings: mfd: mt8195: Add bindin=
gs for MediaTek SCPSYS)
CONFLICT (modify/delete): drivers/mfd/intel_soc_pmic_core.c deleted in mfd/=
for-mfd-next and modified in HEAD.  Version HEAD of drivers/mfd/intel_soc_p=
mic_core.c left in tree.
$ git rm -f drivers/mfd/intel_soc_pmic_core.c
Applying: mfd: fix up for "i2c: Make remove callback return void"
Merging backlight/for-backlight-next (fe201f6fa4cf MAINTAINERS: Use Lee Jon=
es' kernel.org address for Backlight submissions)
Merging battery/for-next (568035b01cfb Linux 6.0-rc1)
Merging regulator/for-next (e89e9017a478 Merge remote-tracking branch 'regu=
lator/for-6.1' into regulator-next)
Merging security/next (ed5d44d42c95 selinux: Implement userns_create hook)
Merging apparmor/apparmor-next (79eb2711c919 apparmor: correct config refer=
ence to intended one)
Merging integrity/next-integrity (88b61b130334 Merge remote-tracking branch=
 'linux-integrity/kexec-keyrings' into next-integrity)
Merging keys/keys-next (2d743660786e Merge branch 'fixes' of git://git.kern=
el.org/pub/scm/linux/kernel/git/viro/vfs)
Merging safesetid/safesetid-next (64b634830c91 LSM: SafeSetID: add setgroup=
s() testing to selftest)
Merging selinux/next (568035b01cfb Linux 6.0-rc1)
Merging smack/next (b50503990d88 smack: Remove the redundant lsm_inode_allo=
c)
Merging tomoyo/master (05fe531eb3f1 kernel/hung_task: show backtrace of tas=
ks with locks held)
Merging tpmdd/next (863ed94c589f tpm: Add check for Failure mode for TPM2 m=
odules)
Merging watchdog/master (1c23f9e627a7 Linux 6.0-rc2)
Merging iommu/next (c10100a416c1 Merge branches 'arm/exynos', 'arm/mediatek=
', 'arm/msm', 'arm/smmu', 'virtio', 'x86/vt-d', 'x86/amd' and 'core' into n=
ext)
Merging audit/next (0351dc57b95b audit: fix repeated words in comments)
Merging devicetree/for-next (dd3cb467ebb5 dt-bindings: Remove 'Device Tree =
Bindings' from end of title:)
Merging dt-krzk/for-next (568035b01cfb Linux 6.0-rc1)
Merging mailbox/mailbox-for-next (8a8dc2b9596e mailbox: imx: clear pending =
interrupts)
Merging spi/for-next (8379bb2d4e68 Merge remote-tracking branch 'spi/for-6.=
1' into spi-next)
Merging tip/master (920357712207 Merge x86/urgent into tip/master)
Merging clockevents/timers/drivers/next (c19e18637d89 clocksource/drivers/s=
un4i: Remove unnecessary (void*) conversions)
Merging edac/edac-for-next (35636db93725 Merge edac-misc into for-next)
Merging irqchip/irq/irqchip-next (2bd1753e8c43 Merge branch irq/misc-5.20 i=
nto irq/irqchip-next)
Merging ftrace/for-next (07a451dae367 Merge branch 'trace/for-next-core' in=
to trace/for-next)
Merging rcu/rcu/next (942703b9450e rcutorture: Limit read-side polling-API =
testing)
Merging kvm/next (372d07084593 KVM: selftests: Fix ambiguous mov in KVM_ASM=
_SAFE())
Merging kvm-arm/next (0982c8d859f8 Merge branch kvm-arm64/nvhe-stacktrace i=
nto kvmarm-master/next)
Merging kvms390/next (f5ecfee94493 KVM: s390: resetting the Topology-Change=
-Report)
Merging xen-tip/linux-next (5f3925e34594 xen/privcmd: fix error exit of pri=
vcmd_ioctl_dm_op())
Merging percpu/for-next (a111daf0c53a Linux 5.19-rc3)
Merging workqueues/for-next (c0feea594e05 workqueue: don't skip lockdep wor=
k dependency in cancel_work_sync())
Merging drivers-x86/for-next (1ea0d3b46798 platform/x86: asus-wmi: Simplify=
 tablet-mode-switch handling)
Merging chrome-platform/for-next (8a07b45fd3c2 platform/chrome: fix memory =
corruption in ioctl)
Merging hsi/for-next (43c14f8d18a7 HSI: omap_ssi: Fix refcount leak in ssi_=
probe)
Merging leds/for-next (568035b01cfb Linux 6.0-rc1)
Merging ipmi/for-next (4aebcc9059d8 dt-binding: ipmi: add fallback to npcm8=
45 compatible)
Merging driver-core/driver-core-next (1c23f9e627a7 Linux 6.0-rc2)
Merging usb/usb-next (4dce3b375179 usb/hcd: Fix dma_map_sg error check)
Merging thunderbolt/next (32249fd8c8cc thunderbolt: Add support for Intel M=
eteor Lake)
Merging usb-gadget/next (e49d033bddf5 Linux 5.12-rc6)
Merging usb-serial/usb-next (1c23f9e627a7 Linux 6.0-rc2)
Merging tty/tty-next (568035b01cfb Linux 6.0-rc1)
Merging char-misc/char-misc-next (568035b01cfb Linux 6.0-rc1)
Merging coresight/next (84fa8f159022 dt-bindings: arm: coresight-tmc: Add '=
iommu' property)
Merging fpga/for-next (e167b2c3a0e6 dt-bindings: fpga: microchip,mpf-spi-fp=
ga-mgr: use spi-peripheral-props.yaml)
Merging icc/icc-next (aff72c797ff0 Merge branch 'icc-ignore-return-val' int=
o icc-next)
Merging iio/togreg (682ca76bc60a iio: Avoid multiple line dereference for m=
ask)
Merging phy-next/next (568035b01cfb Linux 6.0-rc1)
Merging soundwire/next (63198aaa91ac soundwire: intel: remove use of __func=
__ in dev_dbg)
Merging extcon/extcon-next (822a6200734c extcon: usbc-tusb320: Add USB TYPE=
-C support)
Merging gnss/gnss-next (c0c725d7350e gnss: replace ida_simple API)
Merging vfio/next (0f3e72b5c8cf vfio: Move vfio.c to vfio_main.c)
Merging staging/staging-next (dba908967df5 staging: r8188eu: remove unneces=
sary null check)
CONFLICT (content): Merge conflict in drivers/staging/r8188eu/os_dep/os_int=
fs.c
Merging mux/for-next (0fcfb00b28c0 Linux 5.16-rc4)
Merging dmaengine/next (568035b01cfb Linux 6.0-rc1)
Merging cgroup/for-next (b48dc0e02bb6 Merge branch 'for-6.0-fixes' into for=
-next)
Merging scsi/for-next (785538bfdd68 scsi: sd: Revert "Rework asynchronous r=
esume support")
Merging scsi-mkp/for-next (8750aa54da43 scsi: megaraid_sas: Use struct_size=
() in code related to struct MR_PD_CFG_SEQ_NUM_SYNC)
$ git reset --hard HEAD^
Merging next-20220823 version of scsi-mkp
Merging vhost/linux-next (8f113a4ad40d virtio: drop vp_legacy_set_queue_siz=
e)
Merging rpmsg/for-next (729c16326b7f remoteproc: imx_dsp_rproc: fix argumen=
t 2 of rproc_mem_entry_init)
Merging gpio/for-next (e73f0f0ee754 Linux 5.14-rc1)
Merging gpio-brgl/gpio/for-next (1e65d136d956 dt-bindings: gpio: fairchild,=
74hc595: use spi-peripheral-props.yaml)
Merging gpio-intel/for-next (b65bb2c14891 gpio: pch: Change PCI device macr=
os)
Merging gpio-sim/gpio/gpio-sim (0fcfb00b28c0 Linux 5.16-rc4)
Merging pinctrl/for-next (a0d281349ac5 Merge branch 'devel' into for-next)
Applying: pinctrl: fixup for "i2c: Make remove callback return void"
Merging pinctrl-intel/for-next (25097de7b236 pinctrl: intel: Add Intel Mete=
or Lake pin controller support)
Merging pinctrl-renesas/renesas-pinctrl (96355be8f0a2 dt-bindings: pinctrl:=
 renesas: Document RZ/Five SoC)
Merging pinctrl-samsung/for-next (9d9292576810 dt-bindings: pinctrl: samsun=
g: deprecate header with register constants)
Merging pwm/for-next (8933d30c5f46 pwm: lpc18xx: Fix period handling)
Merging userns/for-next (a0b88362d2c7 Merge of ucount-rlimits-cleanups-for-=
v5.19, interrupting_kthread_stop-for-v5.20, signal-for-v5.20, and retire_mq=
_sysctls-for-v5.19 for testing in linux-next)
Merging ktest/for-next (170f4869e662 ktest.pl: Fix the logic for truncating=
 the size of the log file for email)
Merging kselftest/next (ab7039dbcc61 selftests/vm: use top_srcdir instead o=
f recomputing relative paths)
Merging livepatching/for-next (df44b1ee72f4 Merge branch 'for-5.20/selftest=
s-fixes' into for-next)
Merging rtc/rtc-next (509451ac03eb rtc: gamecube: Always reset HW_SRNPROT a=
fter read)
Merging nvdimm/libnvdimm-for-next (53fc59511fc4 nvdimm/namespace: drop unne=
eded temporary variable in size_store())
Merging at24/at24/for-next (568035b01cfb Linux 6.0-rc1)
Merging ntb/ntb-next (568035b01cfb Linux 6.0-rc1)
Merging seccomp/for-next/seccomp (1c23f9e627a7 Linux 6.0-rc2)
Merging cisco/for-next (9e98c678c2d6 Linux 5.1-rc1)
Merging fsi/next (04823dd2af87 fsi: master-ast-cf: Fix missing of_node_put =
in fsi_master_acf_probe)
Merging slimbus/for-next (568035b01cfb Linux 6.0-rc1)
Merging nvmem/for-next (47c88c8216cf nvmem: brcm_nvram: Use kzalloc for all=
ocating only one element)
Merging xarray/main (69cb69ea5542 ida: Remove assertions that an ID was all=
ocated)
Merging hyperv/hyperv-next (d180e0a1be6c Drivers: hv: Create debugfs file w=
ith hyper-v balloon usage information)
Merging auxdisplay/auxdisplay (13de23494f38 auxdisplay: lcd2s: Use array si=
ze explicitly in lcd2s_gotoxy())
Merging kgdb/kgdb/for-next (c1cb81429df4 kdb: Fix the putarea helper functi=
on)
Merging hmm/hmm (568035b01cfb Linux 6.0-rc1)
Merging kunit/test (568035b01cfb Linux 6.0-rc1)
Merging cfi/cfi/next (312310928417 Linux 5.18-rc1)
Merging kunit-next/kunit (568035b01cfb Linux 6.0-rc1)
Merging trivial/for-next (081c8919b02b Documentation: remove trivial tree)
Merging mhi/mhi-next (bb3c64f6a017 bus: mhi: host: Fix up null pointer acce=
ss in mhi_irq_handler)
Merging memblock/for-next (8f6e32c6bd09 memblock tests: update reference to=
 obsolete build option in comments)
Merging init/init-user-pointers (38b082236e77 initramfs: use vfs_utimes in =
do_copy)
Merging counters/counters (e71ba9452f0b Linux 5.11-rc2)
Merging cxl/next (1cd8a2537eb0 cxl/hdm: Fix skip allocations vs multiple pm=
em allocations)
Merging folio-iomap/folio-iomap (4d7bd0eb72e5 iomap: Inline __iomap_zero_it=
er into its caller)
Merging zstd/zstd-next (88a309465b3f lib: zstd: clean up double word in com=
ment.)
Merging efi/next (6c3a9c9ae02a efi/x86-mixed: move unmitigated RET into .ro=
data)
Merging unicode/for-next (b500d6d7243d unicode: Handle memory allocation fa=
ilures in mkutf8data)
Merging slab/for-next (68704dd63c5e Merge branch 'slab/for-6.1/slub_validat=
ion_locking' into slab/for-next)
Merging random/master (4e23eeebb2e5 Merge tag 'bitmap-6.0-rc1' of https://g=
ithub.com/norov/linux)
Merging landlock/next (a37efa83a49a landlock: Document Landlock's file trun=
cation support)
Merging rust/rust-next (07a3263c2554 init/Kconfig: Specify the interpreter =
for rust_is_available.sh)
CONFLICT (content): Merge conflict in Makefile
Merging sysctl/sysctl-next (374a723c7448 kernel/sysctl.c: Remove trailing w=
hite space)
Merging folio/for-next (03b33c09ea22 fs: remove the NULL get_block case in =
mpage_writepages)
Merging execve/for-next/execve (1c23f9e627a7 Linux 6.0-rc2)
Merging bitmap/bitmap-for-next (5d7fef0804b0 lib/cpumask_kunit: add tests f=
ile to MAINTAINERS)
Merging hte/hte/for-next (85ff37e302ef gpiolib: cdev: Fix kernel doc for st=
ruct line)
Merging kspp/for-next/kspp (1c23f9e627a7 Linux 6.0-rc2)
Merging kspp-gustavo/for-next/kspp (568035b01cfb Linux 6.0-rc1)
Merging mm-stable/mm-stable (ec6624452e36 Merge branch 'linus')
Merging mm-nonmm-stable/mm-nonmm-stable (ec6624452e36 Merge branch 'linus')
Merging mm/mm-everything (fddfb0911108 Merge branch 'mm-nonmm-unstable' int=
o mm-everything)
CONFLICT (content): Merge conflict in mm/page_alloc.c
CONFLICT (content): Merge conflict in mm/vmscan.c
Applying: Revert "mm: reduce noise in show_mem for lowmem allocations"
Applying: Revert "mm-reduce-noise-in-show_mem-for-lowmem-allocations-fix"

--Sig_/zfB5=UTI74i.pas7qIvJpec
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMIelsACgkQAVBC80lX
0GzWSAgAiWVu5EejZp2dgZDayD0gIxJqrR5gecI6p7kKToPjIEk4hprO6Jdf7YkZ
K4GgmAk+3Q3X5JIeBpxy8aVRXn4B13MTqD8fTtcmgKBRan40gejdvM+be/BcxCAI
RtcxlBN6gTBVYUOfcjMwC0uy7K62Ke8nVeLSwj5R5SI6I61bgjLlAzcPN2oa1ISo
AaTcZzucXl/M02p7cFSwz1+h/wbsGqi67YA/qHU1J1zWPZoOSzTgoMjs7pr/YGXJ
mSQk+3VM19181hVmtI4Md7/svB9EnI/vz4x5gXKSGXimAlUaM927RndXXjIsvivF
dyG5wympTnRGBTzmw8oHkuS704HEJA==
=qOKW
-----END PGP SIGNATURE-----

--Sig_/zfB5=UTI74i.pas7qIvJpec--
