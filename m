Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADAAA4879DA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 16:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348138AbiAGPno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 10:43:44 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:49761 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239665AbiAGPnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 10:43:42 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JVnZ45KKyz4xmx;
        Sat,  8 Jan 2022 02:43:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1641570220;
        bh=VqnBPYiQq5f2oqZZdVC8C+WiY1FMqBY82fVDU1ukFIE=;
        h=Date:From:To:Cc:Subject:From;
        b=g3VWlyPUxNmHlJLDOWAyvTu6xuUJ8R/R96W6WlwhV51ckNSXJfTotEXGN2GBjN0vk
         lUeqIOYiAQG18RdMRjpuhf7c3zWAGbawYpZlWRluIG/u6exEwiUrtHlxaCzRIZJHW1
         MN5WWCPp91NLJ5sUILIVa9UHIt5Vc/hgKNKK1KXgY7lH/d0VuOF1ZS3pzpJYgWnWM4
         Uau9+ptARhKpbl5OkP52YJWgLpbs86sfmHbo+LS7algtyNNk4dfPyMq/kssbI5zd9i
         idY0QjgDTK67dLa1mexp3X8RnNs4o67JT44v4knmwKaWggrL6hQEXF62qCwmoaSypp
         C6sm8G9m5T/Jw==
Date:   Sat, 8 Jan 2022 02:43:36 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Jan 7
Message-ID: <20220108024336.0b7b8b9d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/KB90JE6Yz2JJPHH3WlGcswW";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/KB90JE6Yz2JJPHH3WlGcswW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20220106:

The perf tree still had its build failure.

The libata tree lost its build failure.

The tpmdd tree gained conflicts against the kbuild tree.

Non-merge commits (relative to Linus' tree): 10445
 10202 files changed, 465879 insertions(+), 215511 deletions(-)

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

I am currently merging 348 trees (counting Linus' and 94 trees of bug
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
Merging origin/master (75acfdb6fd92 Merge tag 'net-5.16-final' of git://git=
.kernel.org/pub/scm/linux/kernel/git/netdev/net)
Merging fixes/fixes (d06c942efea4 Merge tag 'for_linus' of git://git.kernel=
.org/pub/scm/linux/kernel/git/mst/vhost)
Merging kbuild-current/fixes (e851dfae4371 Merge tag 'kgdb-5.16-rc1' of git=
://git.kernel.org/pub/scm/linux/kernel/git/danielt/linux)
Merging arc-current/for-curr (8f67f65d121c arc: use swap() to make code cle=
aner)
Merging arm-current/fixes (8536a5ef8860 ARM: 9169/1: entry: fix Thumb2 bug =
in iWMMXt exception handling)
Merging arm64-fixes/for-next/fixes (9c5d89bc1055 arm64: kexec: Fix missing =
error code 'ret' warning in load_other_segments())
Merging arm-soc-fixes/arm/fixes (8922bb6526ac Merge tag 'socfpga_fix_for_v5=
.16_part_3' of git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux=
 into arm/fixes)
Merging drivers-memory-fixes/fixes (8c5ba21c16bd memory: mtk-smi: Fix a nul=
l dereference for the ostd)
Merging tee-fixes/fixes (d58071a8a76d Linux 5.16-rc3)
Merging m68k-current/for-linus (8a3c0a74ae87 m68k: defconfig: Update defcon=
figs for v5.15-rc1)
Merging powerpc-fixes/fixes (8d84fca4375e powerpc/ptdump: Fix DEBUG_WX sinc=
e generic ptdump conversion)
Merging s390-fixes/fixes (4eb1782eaa9f recordmcount.pl: fix typo in s390 mc=
ount regex)
Merging sparc/master (05a59d79793d Merge git://git.kernel.org:/pub/scm/linu=
x/kernel/git/netdev/net)
Merging fscrypt-current/for-stable (80f6e3080bfc fs-verity: fix signed inte=
ger overflow with i_size near S64_MAX)
Merging net/master (36595d8ad46d net/smc: Reset conn->lgr when link group r=
egistration fails)
Merging bpf/master (d6d86830705f net ticp:fix a kernel-infoleak in __tipc_s=
endmsg())
Merging ipsec/master (45a98ef4922d net/xfrm: IPsec tunnel mode fix inner_ip=
proto setting in sec_path)
Merging netfilter/master (1d5a47424040 sfc: The RX page_ring is optional)
Merging ipvs/master (5471d5226c3b selftests: Calculate udpgso segment count=
 without header adjustment)
Merging wireless-drivers/master (f7d55d2e439f mt76: mt7921: fix build regre=
ssion)
Merging mac80211/master (6f89ecf10af1 Merge tag 'mac80211-for-net-2022-01-0=
4' of git://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211)
Merging rdma-fixes/for-rc (b35a0f4dd544 RDMA/core: Don't infoleak GRH field=
s)
Merging sound-current/for-linus (08977fe8cfb7 ALSA: hda/realtek: Use ALC285=
_FIXUP_HP_GPIO_LED on another HP laptop)
Merging sound-asoc-fixes/for-linus (347de64ec4fd Merge remote-tracking bran=
ch 'asoc/for-5.15' into asoc-linus)
Merging regmap-fixes/for-linus (459e1cd0d5ec Merge remote-tracking branch '=
regmap/for-5.15' into regmap-linus)
Merging regulator-fixes/for-linus (85223d609c99 regulator: dt-bindings: sam=
sung,s5m8767: add missing op_mode to bucks)
Merging spi-fixes/for-linus (f1a7ba015313 Merge remote-tracking branch 'spi=
/for-5.15' into spi-linus)
Merging pci-current/for-linus (87620512681a PCI: apple: Fix PERST# polarity)
Merging driver-core.current/driver-core-linus (136057256686 Linux 5.16-rc2)
Merging tty.current/tty-linus (a7904a538933 Linux 5.16-rc6)
Merging usb.current/usb-linus (c9e6606c7fe9 Linux 5.16-rc8)
Merging usb-gadget-fixes/fixes (e49d033bddf5 Linux 5.12-rc6)
Merging usb-serial-fixes/usb-linus (a7904a538933 Linux 5.16-rc6)
Merging usb-chipidea-fixes/for-usb-fixes (f130d08a8d79 usb: chipidea: ci_hd=
rc_imx: Also search for 'phys' phandle)
CONFLICT (content): Merge conflict in drivers/usb/chipidea/ci_hdrc_imx.c
Merging phy/fixes (f0ae8685b285 phy: HiSilicon: Fix copy and paste bug in e=
rror handling)
Merging staging.current/staging-linus (d58071a8a76d Linux 5.16-rc3)
Merging iio-fixes/fixes-togreg (8f80931a3a4d iio: adc: ti-adc081c: Partial =
revert of removal of ACPI IDs)
Merging char-misc.current/char-misc-linus (c9e6606c7fe9 Linux 5.16-rc8)
Merging soundwire-fixes/fixes (fa55b7dcdc43 Linux 5.16-rc1)
Merging thunderbolt-fixes/fixes (c9e6606c7fe9 Linux 5.16-rc8)
Merging input-current/for-linus (bc7ec91718c4 Input: spaceball - fix parsin=
g of movement data packets)
Merging crypto-current/master (27750a315aba crypto: qat - do not handle PFV=
F sources for qat_4xxx)
Merging vfio-fixes/for-linus (8704e8934908 vfio/pci: Fix OpRegion read)
Merging kselftest-fixes/fixes (fa55b7dcdc43 Linux 5.16-rc1)
Merging modules-fixes/modules-linus (2a987e65025e Merge tag 'perf-tools-fix=
es-for-v5.16-2021-12-07' of git://git.kernel.org/pub/scm/linux/kernel/git/a=
cme/linux)
Merging dmaengine-fixes/fixes (822c9f2b833c dmaengine: st_fdma: fix MODULE_=
ALIAS)
Merging backlight-fixes/for-backlight-fixes (a38fd8748464 Linux 5.12-rc2)
Merging mtd-fixes/mtd/fixes (27a030e87292 mtd: dataflash: Add device-tree S=
PI IDs)
Merging mfd-fixes/for-mfd-fixes (a61f4661fba4 mfd: intel_quark_i2c_gpio: Re=
vert "Constify static struct resources")
Merging v4l-dvb-fixes/fixes (d40f0b133b44 media: meson-ir-tx: remove incorr=
ect doc comment)
Merging reset-fixes/reset/fixes (92c959bae2e5 reset: renesas: Fix Runtime P=
M usage)
Merging mips-fixes/mips-fixes (09d97da660ff MIPS: Only define pci_remap_ios=
pace() for Ralink)
Merging at91-fixes/at91-fixes (fa55b7dcdc43 Linux 5.16-rc1)
Merging omap-fixes/fixes (80d680fdccba ARM: dts: omap3430-sdp: Fix NAND dev=
ice node)
Merging kvm-fixes/master (fdba608f15e2 KVM: VMX: Wake vCPU when delivering =
posted IRQ even if vCPU =3D=3D this vCPU)
Merging kvms390-fixes/master (0e9ff65f455d KVM: s390: preserve deliverable_=
mask in __airqs_kick_single_vcpu)
Merging hwmon-fixes/hwmon (fc74e0a40e4f Linux 5.16-rc7)
Merging nvdimm-fixes/libnvdimm-fixes (3dd60fb9d95d nvdimm/pmem: stop using =
q_usage_count as external pgmap refcount)
Merging cxl-fixes/fixes (fae8817ae804 cxl/mem: Fix memory device capacity p=
robing)
Merging btrfs-fixes/next-fixes (c748b846dab6 Merge branch 'misc-5.16' into =
next-fixes)
Merging vfs-fixes/fixes (25f54d08f12f autofs: fix wait name hash calculatio=
n in autofs_wait())
Merging dma-mapping-fixes/for-linus (18a3c5f7abfd Merge tag 'for_linus' of =
git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost)
Merging i3c-fixes/i3c/fixes (fe07bfda2fb9 Linux 5.12-rc1)
Merging drivers-x86-fixes/fixes (26a8b0943780 platform/x86: intel_pmc_core:=
 fix memleak on registration failure)
Merging samsung-krzk-fixes/fixes (4f5d06d381ba arm64: dts: exynos: drop sam=
sung,ufs-shareability-reg-offset in ExynosAutov9)
Merging pinctrl-samsung-fixes/fixes (fa55b7dcdc43 Linux 5.16-rc1)
Merging devicetree-fixes/dt/linus (b398123bff3b efi: apply memblock cap aft=
er memblock_add())
Merging scsi-fixes/fixes (142c779d05d1 scsi: vmw_pvscsi: Set residual data =
length conditionally)
Merging drm-fixes/drm-fixes (936a93775b7c Merge tag 'amd-drm-fixes-5.16-202=
1-12-31' of ssh://gitlab.freedesktop.org/agd5f/linux into drm-fixes)
Merging amdgpu-fixes/drm-fixes (2c409ba81be2 drm/radeon: fix si_enable_smc_=
cac() failed issue)
Merging drm-intel-fixes/for-linux-next-fixes (c9e6606c7fe9 Linux 5.16-rc8)
Merging mmc-fixes/fixes (ff31ee0a0f47 mmc: mmci: stm32: clear DLYB_CR after=
 sending tuning command)
Merging rtc-fixes/rtc-fixes (bd33335aa93d rtc: cmos: Disable irq around dir=
ect invocation of cmos_interrupt())
Merging gnss-fixes/gnss-linus (136057256686 Linux 5.16-rc2)
Merging hyperv-fixes/hyperv-fixes (1dc2f2b81a6a hv: utils: add PTP_1588_CLO=
CK to Kconfig to fix build)
Merging soc-fsl-fixes/fix (7e5e744183bb soc: fsl: dpio: fix qbman alignment=
 error in the virtualization context)
Merging risc-v-fixes/fixes (f6f7fbb89bf8 riscv: dts: sifive unmatched: Link=
 the tmp451 with its power supply)
Merging pidfd-fixes/fixes (03ba0fe4d09f file: simplify logic in __close_ran=
ge())
Merging fpga-fixes/fixes (8bb7eca972ad Linux 5.15)
Merging spdx/spdx-linus (bc128349588d LICENSES/LGPL-2.1: Add LGPL-2.1-or-la=
ter as valid identifiers)
Merging gpio-brgl-fixes/gpio/for-current (32e246b02f53 MAINTAINERS: update =
gpio-brcmstb maintainers)
Merging gpio-intel-fixes/fixes (fa55b7dcdc43 Linux 5.16-rc1)
Merging pinctrl-intel-fixes/fixes (fa55b7dcdc43 Linux 5.16-rc1)
Merging erofs-fixes/fixes (57bbeacdbee7 erofs: fix deadlock when shrink ero=
fs slab)
Merging integrity-fixes/fixes (843385694721 evm: Fix a small race in init_d=
esc())
Merging kunit-fixes/kunit-fixes (fa55b7dcdc43 Linux 5.16-rc1)
Merging ubifs-fixes/fixes (78c7d49f55d8 ubifs: journal: Make sure to not di=
rty twice for auth nodes)
Merging memblock-fixes/fixes (d7f55471db27 memblock: fix memblock_phys_allo=
c() section mismatch error)
Merging cel-fixes/for-rc (c9e6606c7fe9 Linux 5.16-rc8)
Merging irqchip-fixes/irq/irqchip-fixes (c3fbab7767c5 irqchip/irq-bcm7120-l=
2: Add put_device() after of_find_device_by_node())
Merging renesas-fixes/fixes (432b52eea3dc ARM: shmobile: defconfig: Restore=
 graphical consoles)
Merging perf-current/perf/urgent (c9e6606c7fe9 Linux 5.16-rc8)
Merging efi-fixes/urgent (4bc5e64e6cf3 efi: Move efifb_setup_from_dmi() pro=
totype from arch headers)
Merging zstd-fixes/zstd-linus (d58071a8a76d Linux 5.16-rc3)
Merging drm-misc-fixes/for-linux-next-fixes (22bf4047d269 dt-bindings: disp=
lay: meson-dw-hdmi: add missing sound-name-prefix property)
Merging kbuild/for-next (42c0b7463716 doc: kbuild: fix default in `imply` t=
able)
Merging perf/perf/core (65f8d08cf838 Merge remote-tracking branch 'torvalds=
/master' into perf/core)
$ git reset --hard HEAD^
Merging next-20220105 version of perf
Merging compiler-attributes/compiler-attributes (7c00621dcaee compiler_type=
s: mark __compiletime_assert failure as __noreturn)
Merging dma-mapping/for-next (f857acfc457e lib/scatterlist: cleanup macros =
into static inline functions)
Merging asm-generic/master (733e417518a6 asm-generic/error-injection.h: fix=
 a spelling mistake, and a coding style issue)
Merging arc/for-next (6880fa6c5660 Linux 5.15-rc1)
Merging arm/for-next (957ac8868410 Merge branch 'devel-stable' into for-nex=
t)
Merging arm64/for-next/core (945409a6ef44 Merge branches 'for-next/misc', '=
for-next/cache-ops-dzp', 'for-next/stacktrace', 'for-next/xor-neon', 'for-n=
ext/kasan', 'for-next/armv8_7-fp', 'for-next/atomics', 'for-next/bti', 'for=
-next/sve', 'for-next/kselftest' and 'for-next/kcsan', remote-tracking bran=
ch 'arm64/for-next/perf' into for-next/core)
Merging arm-perf/for-next/perf (3da4390bcdf4 arm64: perf: Don't register us=
er access sysctl handler multiple times)
Merging arm-soc/for-next (b6b2e59680e7 ARM: Document merges)
CONFLICT (content): Merge conflict in arch/arm/Kconfig
Merging actions/for-next (444d018d8d38 ARM: dts: owl-s500-roseapplepi: Add =
ATC2603C PMIC)
Merging amlogic/for-next (996b0777eaca Merge branch 'v5.17/dt64' into for-n=
ext)
Merging aspeed/for-next (a7e02e92755c Merge branches 'dt-for-v5.17', 'defco=
nfig-for-v5.17' and 'soc-for-v5.17' into for-next)
Merging at91/at91-next (9be3df0e718c Merge branch 'at91-defconfig' into at9=
1-next)
Merging drivers-memory/for-next (ff086e15d838 Merge branch 'for-v5.17/omap-=
gpmc' into for-next)
Merging imx-mxs/for-next (b95a3922f285 Merge branch 'imx/defconfig' into fo=
r-next)
Merging keystone/next (cb293d3b430e Merge branch 'for_5.15/drivers-soc' int=
o next)
Merging mediatek/for-next (ccf7b63aac3e Merge branch 'v5.16-next/dts64' int=
o for-next)
Merging mvebu/for-next (d835946fc3d8 Merge branch 'mvebu/dt' into mvebu/for=
-next)
Merging omap/for-next (61b6b9cfada4 Merge branch 'omap-for-v5.17/fixes-not-=
urgent' into for-next)
Merging qcom/for-next (7e5fe035d019 Merge branches 'arm64-defconfig-for-5.1=
7', 'arm64-for-5.17', 'clk-for-5.17', 'defconfig-for-5.17' and 'drivers-for=
-5.17' into for-next)
CONFLICT (content): Merge conflict in arch/arm/configs/multi_v7_defconfig
Merging raspberrypi/for-next (c5915b53d4c2 dt-bindings: soc: bcm: Convert b=
rcm,bcm2835-vchiq to json-schema)
Merging renesas/next (743002730737 Merge branch 'renesas-arm-dt-for-v5.17' =
into renesas-next)
Merging reset/reset/next (89e7a6698fdd reset: uniphier-glue: Use devm_add_a=
ction_or_reset())
Merging rockchip/for-next (2a9ed9fa8fe5 Merge branch 'v5.17-armsoc/dts64' i=
nto for-next)
Merging samsung-krzk/for-next (b1cbda0fc343 Merge branch 'next/dt64' into f=
or-next)
Merging scmi/for-linux-next (a0708ab07633 Merge branch 'for-next/scmi' of g=
it://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into for-li=
nux-next)
Merging stm32/stm32-next (3ff0810ffc47 ARM: dts: stm32: Add Engicam i.Core =
STM32MP1 C.TOUCH 2.0 10.1" OF)
Merging sunxi/sunxi/for-next (1d21ba6546a5 Merge branch 'sunxi/dt-for-5.17'=
 into sunxi/for-next)
Merging tee/next (ce352be35ba0 Merge branch 'async_notif' into next)
Merging tegra/for-next (707b88674206 Merge branch for-5.17/arm/defconfig in=
to for-next)
Merging ti/ti-next (e66d73b2aa76 Merge branch 'ti-k3-dts-next' into ti-next)
Merging xilinx/for-next (2eb48e610ef7 Merge remote-tracking branch 'zynqmp/=
dt' into for-next)
Merging clk/clk-next (044af4bbabf7 Merge branch 'clk-st' into clk-next)
Merging clk-imx/for-next (9dd81021084f clk: imx8mp: Fix the parent clk of t=
he audio_root_clk)
Merging clk-renesas/renesas-clk (f0b62b0bbedc clk: renesas: r9a07g044: Add =
GPU clock and reset entries)
Merging clk-samsung/for-next (45bd8166a1d8 clk: samsung: Add initial Exynos=
7885 clock driver)
Merging csky/linux-next (a0793fdad9a1 csky: fix typo of fpu config macro)
Merging h8300/h8300-next (1ec10274d436 h8300: don't implement set_fs)
Merging m68k/for-next (1a0ae068bf6b m68k: defconfig: Update defconfigs for =
v5.16-rc1)
Merging m68knommu/for-next (a7904a538933 Linux 5.16-rc6)
Merging microblaze/next (7b94b7f0ae24 microblaze: add const to of_device_id)
Merging mips/mips-next (f0b7ddbd794b MIPS: retire "asm/llsc.h")
Merging nds32/next (07cd7745c6f2 nds32/setup: remove unused memblock_region=
 variable in setup_memory())
CONFLICT (content): Merge conflict in arch/nds32/Kconfig
CONFLICT (content): Merge conflict in arch/nds32/Kbuild
Merging nios2/for-next (7f7bc20bc41a nios2: Don't use _end for calculating =
min_low_pfn)
Merging openrisc/for-next (433fe39f674d openrisc: Add clone3 ABI wrapper)
Merging parisc-hd/for-next (96e0dcb9c06b parisc: io: Improve the outb(), ou=
tw() and outl() macros)
Merging powerpc/next (f1aa0e47c292 powerpc/xmon: Dump XIVE information for =
online-only processors.)
Merging soc-fsl/next (67a4fa80561f soc: fsl: Correct MAINTAINERS database (=
SOC))
Merging risc-v/for-next (d4cb5d3630ec RISC-V: Clean up the defconfigs)
CONFLICT (content): Merge conflict in arch/riscv/boot/dts/sifive/hifive-unm=
atched-a00.dts
Merging s390/for-next (f29b15079e35 Merge branch 'features' into for-next)
Merging sh/for-next (8518e694203d sh: pgtable-3level: Fix cast to pointer f=
rom integer of different size)
Merging sparc-next/master (dd0d718152e4 Merge tag 'spi-fix-v5.8-rc2' of git=
://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi)
Merging uml/linux-next (db0dd9cee822 um: virtio_uml: Allow probing from dev=
icetree)
Merging xtensa/xtensa-for-next (71874374b46b xtensa: use strscpy to copy st=
rings)
Merging pidfd/for-next (317465bcc6f4 Merge branch 'fs.idmapped' into for-ne=
xt)
Merging fscrypt/master (b7e072f9b77f fscrypt: improve a few comments)
Merging fscache/fscache-next (cdf0fa7e16e2 9p, afs, ceph, cifs, nfs: Use cu=
rrent_is_kswapd() rather than gfpflags_allow_blocking())
CONFLICT (content): Merge conflict in fs/cifs/inode.c
CONFLICT (modify/delete): fs/cachefiles/bind.c deleted in fscache/fscache-n=
ext and modified in HEAD. Version HEAD of fs/cachefiles/bind.c left in tree.
$ git rm -f fs/cachefiles/bind.c
Applying: fix up for "fs: add is_idmapped_mnt() helper"
Merging afs/afs-next (52af7105eceb afs: Set mtime from the client for yfs c=
reate operations)
Merging btrfs/for-next (65381cbd44b3 Merge branch 'for-next-next-v5.16-2022=
0106' into for-next-20220106)
Merging ceph/master (fd84bfdddd16 ceph: fix up non-directory creation in SG=
ID directories)
Merging cifs/for-next (e468ffa9bb21 cifs: Fix smb311_update_preauth_hash() =
kernel-doc comment)
Merging configfs/for-next (c42dd069be8d configfs: fix a race in configfs_lo=
okup())
Merging ecryptfs/next (682a8e2b41ef Merge tag 'ecryptfs-5.13-rc1-updates' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/tyhicks/ecryptfs)
Merging erofs/dev (09c543798c3c erofs: use meta buffers for zmap operations)
Merging exfat/dev (4b095fcf2d43 exfat: fix missing REQ_SYNC in exfat_update=
_bhs())
Merging ext3/for_next (5f0a61886e30 Pull Amir's FAN_RENAME and FAN_REPORT_T=
ARGET_FID support for fanotify.)
Merging ext4/dev (412aac1d161a ext4: don't use the orphan list when migrati=
ng an inode)
Merging f2fs/dev (2b642898e5ea f2fs: remove redunant invalidate compress pa=
ges)
Merging fsverity/fsverity (07c99001312c fs-verity: support reading signatur=
e with ioctl)
Merging fuse/for-next (073c3ab6ae01 Documentation/filesystem/dax: DAX on vi=
rtiofs)
Merging gfs2/for-next (9fc8bbcbb697 gfs2: dump inode object for iopen glock=
s)
Merging jfs/jfs-next (c48a14dca2cb JFS: fix memleak in jfs_mount)
Merging ksmbd/ksmbd-for-next (d4eeb82674ac ksmbd: Fix smb2_get_name() kerne=
l-doc comment)
Merging nfs/linux-next (064a91771f7a SUNRPC: use different lock keys for IN=
ET6 and LOCAL)
Merging nfs-anna/linux-next (3e0a5877834c NFSv42: Fallocate and clone shoul=
d also request 'blocks used')
Merging nfsd/nfsd-next (2e3f00c5f29f nfsd: improve stateid access bitmask d=
ocumentation)
Merging cel/for-next (fd649799dae6 nfsd: fix crash on COPY_NOTIFY with spec=
ial stateid)
CONFLICT (content): Merge conflict in fs/nfsd/nfs4state.c
Merging ntfs3/master (52e00ea6b26e fs/ntfs3: Update valid size if -EIOCBQUE=
UED)
Merging orangefs/for-next (40a74870b2d1 orangefs: Fix the size of a memory =
allocation in orangefs_bufmap_alloc())
Merging overlayfs/overlayfs-next (5b0a414d06c3 ovl: fix filattr copy-up fai=
lure)
Merging ubifs/next (aa39cc675799 jffs2: GC deadlock reading a page that is =
used in jffs2_write_begin())
Merging v9fs/9p-next (a403e2bd0026 9p: only copy valid iattrs in 9P2000.L s=
etattr implementation)
Merging xfs/for-next (7e937bb3cbe1 xfs: warn about inodes with project id o=
f -1)
Merging zonefs/for-next (95b115332a83 zonefs: remove redundant null bio che=
ck)
Merging iomap/iomap-for-next (5ad448ce2976 iomap: iomap_read_inline_data cl=
eanup)
Merging djw-vfs/vfs-for-next (d03ef4daf33a fs: forbid invalid project ID)
Merging file-locks/locks-next (80d8e4d3f313 fs/locks: fix fcntl_getlk64/fcn=
tl_setlk64 stub prototypes)
Merging vfs/for-next (8f40da9494cf Merge branch 'misc.namei' into for-next)
Merging printk/for-next (395cc1cdcbd4 Merge branch 'for-5.17' into for-next)
Merging pci/next (c5897649436b Merge branch 'pci/driver-cleanup')
Merging pstore/for-next/pstore (a5d05b07961a pstore/ftrace: Allow immediate=
 recording)
Merging hid/for-next (1bec0754eaa0 Merge branches 'for-5.16/upstream-fixes'=
, 'for-5.17/apple', 'for-5.17/core', 'for-5.17/hidraw', 'for-5.17/i2c-hid',=
 'for-5.17/letsketch', 'for-5.17/logitech', 'for-5.17/magicmouse' and 'for-=
5.17/thrustmaster' into for-next)
Merging i2c/i2c/for-next (2f7a136069f7 Merge branch 'i2c/for-mergewindow' i=
nto i2c/for-next)
Merging i3c/i3c/next (7a2bccd1a27f i3c: master: mipi-i3c-hci: correct the c=
onfig reference for endianness)
Merging dmi/dmi-for-next (f97a2103f1a7 firmware: dmi: Move product_sku info=
 to the end of the modalias)
Merging hwmon-staging/hwmon-next (660d187887cf hwmon: (xgene-hwmon) Add fre=
e before exiting xgene_hwmon_probe)
Merging jc_docs/docs-next (db05e1ca8fb9 scripts: sphinx-pre-install: Fix ct=
ex support on Debian)
Merging v4l-dvb/master (68b9bcc8a534 media: ipu3-cio2: Add support for inst=
antiating i2c-clients for VCMs)
Merging v4l-dvb-next/master (68b9bcc8a534 media: ipu3-cio2: Add support for=
 instantiating i2c-clients for VCMs)
Merging pm/linux-next (f099fd60c342 Merge branch 'acpi-pfrut' into linux-ne=
xt)
Merging cpufreq-arm/cpufreq/arm/linux-next (d776790a5536 cpufreq: mediatek-=
hw: Fix double devm_remap in hotplug case)
Merging cpupower/cpupower (e173bc6e950a tools: cpupower: fix typo in cpupow=
er-idle-set(1) manpage)
Merging devfreq/devfreq-next (4667431419e9 PM / devfreq: Reduce log severit=
y for informative message)
Merging opp/opp/linux-next (489a00ef46c9 Documentation: power: Update outda=
ted contents in opp.rst)
Merging thermal/thermal/linux-next (8ee1c0f6526c thermal/drivers/rz2gl: Add=
 error check for reset_control_deassert())
Merging ieee1394/for-next (54b3bd99f094 firewire: nosy: switch from 'pci_' =
to 'dma_' API)
Merging dlm/next (feae43f8aa88 fs: dlm: print cluster addr if non-cluster n=
ode connects)
Merging rdma/for-next (ca2770c65b56 IB/iser: Align coding style across driv=
er)
CONFLICT (content): Merge conflict in drivers/infiniband/hw/mlx5/mlx5_ib.h
Merging net-next/master (710ad98c363a veth: Do not record rx queue hint in =
veth_xmit)
Merging bpf-next/for-next (44bab87d8ca6 bpf/selftests: Test bpf_d_path on r=
donly_mem.)
Merging ipsec-next/master (4e484b3e969b xfrm: rate limit SA mapping change =
message to user space)
Merging mlx5-next/mlx5-next (685b1afd7911 net/mlx5: Introduce log_max_curre=
nt_uc_list_wr_supported bit)
Merging netfilter-next/master (2b71e2c7b56c netfilter: nft_set_pipapo_avx2:=
 remove redundant pointer lt)
Merging ipvs-next/master (2b71e2c7b56c netfilter: nft_set_pipapo_avx2: remo=
ve redundant pointer lt)
Merging wireless-drivers-next/master (d430dffbe9dd mt76: mt7921: fix a poss=
ible race enabling/disabling runtime-pm)
Merging bluetooth/master (72279d17df54 Bluetooth: hci_event: Rework hci_inq=
uiry_result_with_rssi_evt)
Merging mac80211-next/master (18343b806915 Merge tag 'mac80211-next-for-net=
-next-2022-01-04' of git://git.kernel.org/pub/scm/linux/kernel/git/jberg/ma=
c80211-next)
Merging mtd/mtd/next (9ce47e43a0f0 Merge tag 'nand/for-5.17' into mtd/next)
Merging nand/nand/next (2997e4871621 Merge tag 'memory-controller-drv-omap-=
5.17' into nand/next)
Merging spi-nor/spi-nor/next (5f340402bbfc mtd: spi-nor: Remove debugfs ent=
ries that duplicate sysfs entries)
Merging crypto/master (4cab5dfd15b7 crypto: qat - fix definition of ring re=
set results)
CONFLICT (content): Merge conflict in drivers/crypto/qat/qat_4xxx/adf_4xxx_=
hw_data.c
Merging drm/drm-next (cb6846fbb83b Merge tag 'amd-drm-next-5.17-2021-12-30'=
 of ssh://gitlab.freedesktop.org/agd5f/linux into drm-next)
CONFLICT (content): Merge conflict in drivers/gpu/drm/nouveau/nouveau_fence=
.c
Merging drm-misc/for-linux-next (5da8b49de472 dt-bindings: display: bridge:=
 lvds-codec: Fix duplicate key)
Merging amdgpu/drm-next (c4f21bcaf4ac drm/amdgpu: bump driver version for n=
ew CTX OP to set/get stable pstates)
Merging drm-intel/for-linux-next (c65fe9cbbfd6 drm/i915/fbc: Remember to up=
date FBC state even when not reallocating CFB)
Merging drm-intel-gt/for-linux-next-gt (c65fe9cbbfd6 drm/i915/fbc: Remember=
 to update FBC state even when not reallocating CFB)
Merging drm-tegra/drm/tegra/for-next (d210919dbdc8 drm/tegra: Add back arm_=
iommu_detach_device())
Merging drm-msm/msm-next (6ed95285382d drm/msm/a5xx: Fix missing CP_PROTECT=
 for SMMU on A540)
Merging imx-drm/imx-drm/next (20fbfc81e390 drm/imx: imx-tve: Make use of th=
e helper function devm_platform_ioremap_resource())
Merging etnaviv/etnaviv/next (cdd156955f94 drm/etnaviv: consider completed =
fence seqno in hang check)
Merging regmap/for-next (02d6fdecb9c3 regmap: allow to define reg_update_bi=
ts for no bus configuration)
Merging sound/for-next (b81e9e5c723d ALSA: hda: ALC287: Add Lenovo IdeaPad =
Slim 9i 14ITL5 speaker quirk)
Merging sound-asoc/for-next (f6fdf773daa3 ASoC: imx-card: several improveme=
nt and fixes)
Merging modules/modules-next (d457f9e1ae29 MAINTAINERS: Remove myself as mo=
dules maintainer)
Merging input/next (08a6df090638 Input: gpio-keys - avoid clearing twice so=
me memory)
Merging block/for-next (c1537fd063e2 Merge branch 'for-5.17/drivers' into f=
or-next)
Merging device-mapper/for-next (eaac0b590a47 dm sysfs: use default_groups i=
n kobj_type)
Merging libata/for-next (423fd00f8639 ata: pata_samsung_cf: add compile tes=
t support)
Merging pcmcia/pcmcia-next (05159e32aa3f MAINTAINERS: update PCMCIA tree)
Merging mmc/next (356f3f2c5756 dt-bindings: mmc: synopsys-dw-mshc: integrat=
e Altera and Imagination)
Merging mfd/for-mfd-next (8ae4069acdee dt-bindings: mfd: Add Freecom system=
 controller)
Merging backlight/for-backlight-next (ec961cf32411 backlight: qcom-wled: Re=
spect enabled-strings in set_brightness)
Merging battery/for-next (25fd330370ac power: supply_core: Pass pointer to =
battery info)
Merging regulator/for-next (14e2976fbabd regulator: qcom_smd: Align probe f=
unction with rpmh-regulator)
Merging security/next-testing (047843bdb316 Merge branch 'landlock_lsm_v34'=
 into next-testing)
Merging apparmor/apparmor-next (875e5cc6b065 lsm: Fix kernel-doc)
Merging integrity/next-integrity (65e38e32a959 selftests/kexec: Enable secu=
reboot tests for PowerPC)
Merging keys/keys-next (e377c31f788f integrity: Load mokx variables into th=
e blacklist keyring)
CONFLICT (content): Merge conflict in security/integrity/platform_certs/loa=
d_uefi.c
CONFLICT (content): Merge conflict in certs/system_keyring.c
CONFLICT (content): Merge conflict in certs/Makefile
Applying: merge fix up for scripts/Makefile extract-cert
Merging safesetid/safesetid-next (1b8b71922919 LSM: SafeSetID: Mark safeset=
id_initialized as __initdata)
Merging selinux/next (6cd9d4b97891 selinux: minor tweaks to selinux_add_opt=
())
Merging smack/next (0934ad42bb2c smackfs: use netlbl_cfg_cipsov4_del() for =
deleting cipso_v4_doi)
Merging tomoyo/master (f702e1107601 tomoyo: use hwight16() in tomoyo_domain=
_quota_is_ok())
Merging tpmdd/next (0e8edc181698 certs: Allow root user to append signed ha=
shes to the blacklist keyring)
CONFLICT (content): Merge conflict in certs/Makefile
CONFLICT (content): Merge conflict in certs/.gitignore
CONFLICT (content): Merge conflict in MAINTAINERS
Merging watchdog/master (ffd264bd152c watchdog: msc313e: Check if the WDT w=
as running at boot)
Merging iommu/next (66dc1b791c58 Merge branches 'arm/smmu', 'virtio', 'x86/=
amd', 'x86/vt-d' and 'core' into next)
Merging audit/next (ed98ea2128b6 audit: replace zero-length array with flex=
ible-array member)
Merging devicetree/for-next (c2abcf30efb8 dt-bindings: display: novatek,nt3=
6672a: Fix unevaluated properties warning)
CONFLICT (content): Merge conflict in include/linux/of_fdt.h
Merging mailbox/mailbox-for-next (97961f78e8bc mailbox: imx: support i.MX8U=
LP S4 MU)
Merging spi/for-next (3e718b44756e spi: dt-bindings: mediatek,spi-mtk-nor: =
Fix example 'interrupts' property)
Merging tip/auto-latest (30fddd0b8484 Merge ras/core into tip/master)
CONFLICT (content): Merge conflict in drivers/net/ethernet/mellanox/mlx5/co=
re/pci_irq.c
CONFLICT (content): Merge conflict in arch/arm64/kernel/perf_callchain.c
Merging clockevents/timers/drivers/next (7647204c2e81 dt-bindings: timer: A=
dd Mstar MSC313e timer devicetree bindings documentation)
Merging edac/edac-for-next (3a8cccd0b519 Merge branch 'edac-amd64' into eda=
c-for-next)
Merging irqchip/irq/irqchip-next (cd448b24c621 Merge branch irq/misc-5.17 i=
nto irq/irqchip-next)
Merging ftrace/for-next (2768c1e7f9d7 tracing: Use trace_iterator_reset() i=
n tracing_read_pipe())
Merging rcu/rcu/next (4dabd7096bfe rcu: Mark writes to the rcu_segcblist st=
ructure's ->flags field)
Merging kvm/next (5e4e84f1124a Merge tag 'kvm-s390-next-5.17-1' of git://gi=
t.kernel.org/pub/scm/linux/kernel/git/kvms390/linux into HEAD)
CONFLICT (content): Merge conflict in arch/arm64/kvm/Makefile
CONFLICT (content): Merge conflict in arch/arm64/kvm/Kconfig
Merging kvm-arm/next (1c53a1ae3612 Merge branch kvm-arm64/misc-5.17 into kv=
marm-master/next)
CONFLICT (content): Merge conflict in arch/arm64/kvm/arm.c
Merging kvms390/next (812de04661c4 KVM: s390: Clarify SIGP orders versus ST=
OP/RESTART)
Merging xen-tip/linux-next (54bb4a91b281 dt-bindings: xen: Clarify "reg" pu=
rpose)
Merging percpu/for-next (4e1f82dce05b Merge branch 'for-5.16-fixes' into fo=
r-next)
Merging workqueues/for-next (7f224759dbdf Merge branch 'for-5.17' into for-=
next)
Merging drivers-x86/for-next (b40082d0b033 platform/x86: x86-android-tablet=
s: Add TM800A550L data)
Merging chrome-platform/for-next (fa55b7dcdc43 Linux 5.16-rc1)
Merging hsi/for-next (a1ee1c08fcd5 HSI: core: Fix return freed object in hs=
i_new_client)
Merging leds/for-next (d949edb503b1 leds: lp55xx: initialise output directi=
on from dts)
Merging ipmi/for-next (42e941eae9c0 ipmi: ssif: replace strlcpy with strscp=
y)
Merging driver-core/driver-core-next (f54dfdf7c625 firmware: memmap: use de=
fault_groups in kobj_type)
CONFLICT (content): Merge conflict in drivers/platform/x86/intel/Kconfig
Merging usb/usb-next (01ec4a2e8f01 headers/deps: USB: Optimize <linux/usb/c=
h9.h> dependencies, remove <linux/device.h>)
Merging usb-gadget/next (e49d033bddf5 Linux 5.12-rc6)
Merging usb-serial/usb-next (2585cf9dfaad Linux 5.16-rc5)
Merging usb-chipidea-next/for-usb-next (78665f57c3fa usb: chipidea: udc: ma=
ke controller hardware endpoint primed)
Merging tty/tty-next (99a507a8ea28 Revert "serdev: BREAK/FRAME/PARITY/OVERR=
UN notification prototype V2")
Merging char-misc/char-misc-next (8f2cade5da97 dt-bindings: mux: Document m=
ux-states property)
Merging extcon/extcon-next (2da3db7f498d extcon: Deduplicate code in extcon=
_set_state_sync())
Merging phy-next/next (09d976b3e8e2 phy: cadence: Sierra: Add support for d=
erived reference clock output)
Merging soundwire/next (bb349fd2d580 soundwire: qcom: remove redundant vers=
ion number read)
Merging thunderbolt/next (fa487b2a900d thunderbolt: Add module parameter fo=
r CLx disabling)
Merging vfio/next (2bed2ced40c9 vfio/iommu_type1: replace kfree with kvfree)
Merging staging/staging-next (0640d18b15d8 staging: r8188eu: add spaces aro=
und P2P_AP_P2P_CH_SWITCH_PROCESS_WK)
Merging iio/togreg (38ac2f038666 iio: chemical: sunrise_co2: set val parame=
ter only on success)
Merging mux/for-next (0fcfb00b28c0 Linux 5.16-rc4)
Merging icc/icc-next (01f8938ad036 Merge branch 'icc-qcm2290' into icc-next)
Merging dmaengine/next (e77e561925df dmaengine: at_xdmac: Fix race over irq=
_status)
Merging cgroup/for-next (a091b198ba1a Merge branch 'for-5.17' into for-next)
Merging scsi/for-next (083f067c8257 Merge branch 'misc' into for-next)
Merging scsi-mkp/for-next (c3b48443ba7c scsi: aic79xx: Remove redundant err=
or variable)
Merging vhost/linux-next (4f48d30af284 vdpa: clean up get_config_size ret v=
alue handling)
CONFLICT (content): Merge conflict in include/uapi/linux/virtio_iommu.h
CONFLICT (content): Merge conflict in drivers/iommu/virtio-iommu.c
Merging rpmsg/for-next (feb19d833fa1 Merge branches 'rproc-next', 'rpmsg-ne=
xt' and 'hwspinlock-next' into for-next)
Merging gpio/for-next (7ac554888233 MAINTAINERS: Remove reference to non-ex=
isting file)
Merging gpio-brgl/gpio/for-next (ffe31c9ed35d gpio: rcar: Propagate errors =
from devm_request_irq())
CONFLICT (content): Merge conflict in tools/testing/selftests/gpio/Makefile
Merging gpio-intel/for-next (9d5f0f6644b1 gpio: sch: fix typo in a comment)
Merging gpio-sim/gpio/gpio-sim (0fcfb00b28c0 Linux 5.16-rc4)
Merging pinctrl/for-next (7442936633bd pinctrl: imx: fix assigning groups n=
ames)
CONFLICT (content): Merge conflict in drivers/pinctrl/Makefile
CONFLICT (content): Merge conflict in drivers/pinctrl/Kconfig
Merging pinctrl-intel/for-next (db1b2a8caf5b pinctrl: cherryview: Use tempo=
rary variable for struct device)
Merging pinctrl-renesas/renesas-pinctrl (ea7e26ebe6a9 pinctrl: renesas: r8a=
779a0: Align comments)
Merging pinctrl-samsung/for-next (a382d568f144 pinctrl: samsung: Use platfo=
rm_get_irq_optional() to get the interrupt)
Merging pwm/for-next (3f0565451cc0 dt-bindings: pwm: Avoid selecting schema=
 on node name match)
Merging userns/for-next (2de7290d1e9c Merge of signal-for-v5.17, and ucount=
-rlimit-fixes-for-v5.16 for testing in linux-next)
CONFLICT (content): Merge conflict in fs/nfsd/nfssvc.c
Applying: fix up for "lockd: use svc_set_num_threads() for thread start and=
 stop"
Applying: fix 2 for "vhost: use user_worker to check RLIMITs"
Merging ktest/for-next (170f4869e662 ktest.pl: Fix the logic for truncating=
 the size of the log file for email)
Merging kselftest/next (e89908201e25 selftests/vm: remove ARRAY_SIZE define=
 from individual tests)
Merging livepatching/for-next (8cdf3792526a Merge branch 'for-5.17/fixes' i=
nto for-next)
Merging coresight/next (efa56eddf5d5 coresight: core: Fix typo in a comment)
Merging rtc/rtc-next (a12ac1f0ffa4 dt-bindings: rtc: qcom-pm8xxx-rtc: updat=
e register numbers)
Merging nvdimm/libnvdimm-for-next (9e05e95ca8da iomap: Fix error handling i=
n iomap_zero_iter())
CONFLICT (content): Merge conflict in fs/ext4/super.c
Merging at24/at24/for-next (d08aea21c89d eeprom: at24: Add support for 24c1=
025 EEPROM)
Merging ntb/ntb-next (dee871b3979e ntb_hw_switchtec: Fix a minor issue in c=
onfig_req_id_table())
Merging seccomp/for-next/seccomp (1e6d69c7b9cd selftests/seccomp: Report ev=
ent mismatches more clearly)
Merging kspp/for-next/kspp (136057256686 Linux 5.16-rc2)
Merging kspp-gustavo/for-next/kspp (64bc5a949ae1 Merge branch 'for-linus/ks=
pp' into for-next/kspp)
Merging cisco/for-next (9e98c678c2d6 Linux 5.1-rc1)
Merging gnss/gnss-next (547d2167c5c3 gnss: usb: add support for Sierra Wire=
less XM1210)
Merging fsi/next (7cc2f34e1f4d fsi: sbefifo: Use interruptible mutex lockin=
g)
Merging slimbus/for-next (fa55b7dcdc43 Linux 5.16-rc1)
Merging nvmem/for-next (779809c07324 dt-bindings: nvmem: Add missing 'reg' =
property)
Merging xarray/main (1c9f4b00b3cf XArray: Document the locking requirement =
for the xa_state)
Merging hyperv/hyperv-next (6a27e396ebb1 Drivers: hv: vmbus: Initialize req=
uest offers message for Isolation VM)
CONFLICT (content): Merge conflict in drivers/net/hyperv/netvsc.c
Merging auxdisplay/auxdisplay (4daa9ff89ef2 auxdisplay: charlcd: checking f=
or pointer reference before dereferencing)
Merging kgdb/kgdb/for-next (b77dbc86d604 kdb: Adopt scheduler's task classi=
fication)
Merging hmm/hmm (6880fa6c5660 Linux 5.15-rc1)
Merging fpga/for-next (98ceca2f2932 fpga: region: fix kernel-doc)
Merging kunit/test (fa55b7dcdc43 Linux 5.16-rc1)
Merging cfi/cfi/next (baaf965f9430 mtd: hyperbus: rpc-if: fix bug in rpcif_=
hb_remove)
Merging kunit-next/kunit (ad659ccb5412 kunit: tool: Default --jobs to numbe=
r of CPUs)
CONFLICT (content): Merge conflict in Documentation/dev-tools/kunit/start.r=
st
CONFLICT (content): Merge conflict in Documentation/dev-tools/kunit/index.r=
st
Merging trivial/for-next (9ff9b0d392ea Merge tag 'net-next-5.10' of git://g=
it.kernel.org/pub/scm/linux/kernel/git/netdev/net-next)
Merging mhi/mhi-next (00776ac534cc bus: mhi: pci_generic: Introduce Sierra =
EM919X support)
Merging memblock/for-next (e888fa7bb882 memblock: Check memory add/cap orde=
ring)
Merging init/init-user-pointers (38b082236e77 initramfs: use vfs_utimes in =
do_copy)
Merging counters/counters (e71ba9452f0b Linux 5.11-rc2)
Merging rust/rust-next (075c05e2eb5d [RFC] drivers: android: Binder IPC in =
Rust)
CONFLICT (modify/delete): tools/include/linux/lockdep.h deleted in HEAD and=
 modified in rust/rust-next. Version rust/rust-next of tools/include/linux/=
lockdep.h left in tree.
CONFLICT (content): Merge conflict in samples/Makefile
CONFLICT (content): Merge conflict in samples/Kconfig
CONFLICT (content): Merge conflict in Documentation/process/changes.rst
$ git rm -f tools/include/linux/lockdep.h
Merging cxl/next (be185c2988b4 cxl/core: Remove cxld_const_init in cxl_deco=
der_alloc())
Merging folio/for-next (b45608e6c6db mm: Use multi-index entries in the pag=
e cache)
CONFLICT (content): Merge conflict in mm/filemap.c
Merging folio-iomap/folio-iomap (4d7bd0eb72e5 iomap: Inline __iomap_zero_it=
er into its caller)
CONFLICT (content): Merge conflict in fs/iomap/buffered-io.c
Merging bitmap/bitmap-master-5.15 (785cb064e2f8 vsprintf: rework bitmap_lis=
t_string)
CONFLICT (content): Merge conflict in drivers/dma/ti/edma.c
CONFLICT (content): Merge conflict in arch/s390/kvm/kvm-s390.c
CONFLICT (content): Merge conflict in arch/powerpc/include/asm/cputhreads.h
CONFLICT (content): Merge conflict in arch/parisc/include/asm/bitops.h
Merging zstd/zstd-next (fa55b7dcdc43 Linux 5.16-rc1)
Merging efi/next (42f4046bc4ba efi: use default_groups in kobj_type)
Merging unicode/for-next (e2a58d2d3416 unicode: only export internal symbol=
s for the selftests)
CONFLICT (content): Merge conflict in fs/f2fs/sysfs.c
Merging slab/for-next (7bd4f7aaa4e7 Merge branch 'for-5.17/struct-slab' int=
o for-next)
Merging random/master (6c8e11e08a5b random: don't reset crng_init_cnt on ur=
andom_read())
Merging landlock/next (2585cf9dfaad Linux 5.16-rc5)
Merging akpm-current/current (bd2b315ce5d7 ipc/sem: do not sleep with a spi=
n lock held)
CONFLICT (content): Merge conflict in mm/zsmalloc.c
CONFLICT (content): Merge conflict in mm/memremap.c
CONFLICT (content): Merge conflict in kernel/kthread.c
CONFLICT (content): Merge conflict in include/linux/kthread.h
$ git checkout -b akpm remotes/origin/akpm/master
$ git rebase --onto master remotes/origin/akpm/master-base
Merging akpm/master (3e4d9032d1a2 mm: hide the FRONTSWAP Kconfig symbol)

--Sig_/KB90JE6Yz2JJPHH3WlGcswW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHYX6gACgkQAVBC80lX
0Gy06QgAgHArwGl6R6KQ0W4XAo510Gwi+ss/V2eVm0Z24Q6ItFvnzhdOchTjT/uU
BDejQqayN4oeUBflm3/ab5tJcqnqQHtgFa7nzchXCt34k6XlJnrKhU0FmuzKefgx
q/ZjwtPj3sU8TqfWNWBdnLODnp0gpRfQaW+74CazMznsWmfSE52fELzYKhzeZ+h0
zNTL45jTMeFQzIfO8kEyiyoe2mCLirgJAyVnBGYyDIAFL7XjlTZZcfWRG6jX0kAn
4cuo+hfNfMjWU+kFd9OSN89YiU3MLO7pPR3cnsuVfZsjHGlKhed1UJRcLsvWyfSh
E4E9HbKZzFebZZlXlqhLwUeoFJQmZg==
=gLQO
-----END PGP SIGNATURE-----

--Sig_/KB90JE6Yz2JJPHH3WlGcswW--
