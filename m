Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03BDE521616
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 14:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242079AbiEJM7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 08:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242128AbiEJM7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 08:59:14 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16832AD779;
        Tue, 10 May 2022 05:55:08 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KyJ0q1Psyz4xPw;
        Tue, 10 May 2022 22:55:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1652187307;
        bh=hUDF5EiKrUfhNX1uznbnRV47DenelTDmczv/bQu9Dls=;
        h=Date:From:To:Cc:Subject:From;
        b=gmIMQSR77yoszX/aVzOxK0xKVwf1Y8VgLgy2sq6CJPx7Y27lO+ZtUXFciINxMOWih
         OA+5GL39DlGqG2rII40JN4DbpaDigLfo0HLiS7cZPfD7g4W/uQjH3QFHh/8n0Idcac
         C+QlawNIzztTEWn5bRZdQESeURBKBbRcolB9MCjzO4FBdz/cG4c7cr08ukESFi+Acl
         issV4Us9rnOG0Kmn8I9MSTy61DV8nj10bjnILRaBdIqiLWKRKlF7VyXWcLaiua18G9
         hzs0Yd85RU95OhnZij/9xXPYhz6kXphalusJEZOmFCCD5yO2CqXaLsySSu1YpyAssR
         ywTJE7zMjYhpg==
Date:   Tue, 10 May 2022 22:55:05 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for May 10
Message-ID: <20220510225505.054a2b37@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Wr=1kiPO4=GNye.W4PIk=0S";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,LOCALPART_IN_SUBJECT,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Wr=1kiPO4=GNye.W4PIk=0S
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20220509:

The mvebu tree gained a conflict against the arm-soc tree.

The m68knommu tree gained a conflict against the m68k tree.

The gfs2 tree gained a conflict against the btrfs tree.

The hwmon-staging tree gained a build failure for which I reverted
3 commits.

The net-next tree gained a semantic conflict against the net tree.

The crypto tree still had its build failure for which I reverted a commit.

The folio tree gained a conflict against the btrfs tree.

The mm tree still had its build failures for which I applied a supplied
patch.  It gained another build failure so I have used the version from
next-20220509.

Non-merge commits (relative to Linus' tree): 9713
 9723 files changed, 874489 insertions(+), 203297 deletions(-)

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
Merging origin/master (9be9ed2612b5 Merge tag 'platform-drivers-x86-v5.18-4=
' of git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x=
86)
Merging fixes/fixes (d06c942efea4 Merge tag 'for_linus' of git://git.kernel=
.org/pub/scm/linux/kernel/git/mst/vhost)
Merging mm-hotfixes/mm-hotfixes-unstable (b388e00b95b6 Revert "mm/cma.c: re=
move redundant cma_mutex lock")
Merging kbuild-current/fixes (312310928417 Linux 5.18-rc1)
Merging arc-current/for-curr (c6ed4d84a2c4 ARC: remove redundant READ_ONCE(=
) in cmpxchg loop)
Merging arm-current/fixes (9be4c88bb792 ARM: 9191/1: arm/stacktrace, kasan:=
 Silence KASAN warnings in unwind_frame())
Merging arm64-fixes/for-next/fixes (c35fe2a68f29 elf: Fix the arm64 MTE ELF=
 segment name and value)
Merging arm-soc-fixes/arm/fixes (e81c07e25e5b Merge tag 'qcom-arm64-fixes-f=
or-5.18' of git://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into a=
rm/fixes)
Merging drivers-memory-fixes/fixes (73039c6c7f36 memory: renesas-rpc-if: Fi=
x HF/OSPI data transfer in Manual Mode)
Merging tee-fixes/fixes (98268f2a2a9f Merge branch 'optee_ffa_probe_fix_for=
_v5.18' into fixes)
Merging m68k-current/for-linus (0d52a01a266b m68k: defconfig: Disable fbdev=
 on Sun3/3x)
Merging powerpc-fixes/fixes (348c71344111 powerpc/papr_scm: Fix buffer over=
flow issue with CONFIG_FORTIFY_SOURCE)
Merging s390-fixes/fixes (a06afe838308 KVM: s390: vsie/gmap: reduce gmap_rm=
ap overhead)
Merging sparc/master (05a59d79793d Merge git://git.kernel.org:/pub/scm/linu=
x/kernel/git/netdev/net)
Merging fscrypt-current/for-stable (80f6e3080bfc fs-verity: fix signed inte=
ger overflow with i_size near S64_MAX)
Merging net/master (51ca86b4c9c7 ethernet: tulip: fix missing pci_disable_d=
evice() on error in tulip_init_one())
Merging bpf/master (a0df71948e95 tls: Skip tls_append_frag on zero copy siz=
e)
Merging ipsec/master (79396934e289 net: dsa: b53: convert to phylink_pcs)
Merging netfilter/master (05ae2fba821c netfilter: nft_socket: make cgroup m=
atch work in input too)
Merging ipvs/master (05ae2fba821c netfilter: nft_socket: make cgroup match =
work in input too)
Merging wireless/main (a36e07dfe6ee rfkill: uapi: fix RFKILL_IOCTL_MAX_SIZE=
 ioctl request definition)
Merging rdma-fixes/for-rc (c5eb0a61238d Linux 5.18-rc6)
Merging sound-current/for-linus (1efcdd9c1f34 ALSA: hda/realtek: Add quirk =
for Dell Latitude 7520)
Merging sound-asoc-fixes/for-linus (aef7b18a3a19 Merge remote-tracking bran=
ch 'asoc/for-5.17' into asoc-linus)
Merging regmap-fixes/for-linus (312310928417 Linux 5.18-rc1)
Merging regulator-fixes/for-linus (b11b3d21a94d regulator: qcom_smd: Fix up=
 PM8950 regulator configuration)
Merging spi-fixes/for-linus (f724c296f2f2 spi: cadence-quadspi: fix Direct =
Access Mode disable for SoCFPGA)
Merging pci-current/for-linus (134b5ce3ed33 PCI: qcom: Remove ddrss_sf_tbu =
clock from SC8180X)
Merging driver-core.current/driver-core-linus (29ad05fd6760 Documentation/p=
rocess: Add embargoed HW contact for Ampere Computing)
Merging tty.current/tty-linus (401fb66a355e fsl_lpuart: Don't enable interr=
upts too early)
Merging usb.current/usb-linus (b81ac4395bbe usb: gadget: uvc: allow for app=
lication to cleanly shutdown)
Merging usb-gadget-fixes/fixes (e49d033bddf5 Linux 5.12-rc6)
Merging usb-serial-fixes/usb-linus (870b1eee2d84 USB: serial: qcserial: add=
 support for Sierra Wireless EM7590)
Merging phy/fixes (2c8045d48dee phy: amlogic: fix error path in phy_g12a_us=
b3_pcie_probe())
Merging staging.current/staging-linus (ce522ba9ef7e Linux 5.18-rc2)
Merging iio-fixes/fixes-togreg (fe18894930a0 iio: mma8452: fix probe fail w=
hen device tree compatible is used.)
Merging counter-fixes/fixes-togreg (ce522ba9ef7e Linux 5.18-rc2)
Merging char-misc.current/char-misc-linus (fe503887eed6 slimbus: qcom: Fix =
IRQ check in qcom_slim_probe)
Merging soundwire-fixes/fixes (312310928417 Linux 5.18-rc1)
Merging thunderbolt-fixes/fixes (c5eb0a61238d Linux 5.18-rc6)
Merging input-current/for-linus (4352e23a7ff2 Input: cros-ec-keyb - only re=
gister keyboard if rows/columns exist)
Merging crypto-current/master (aa8e73eed7d3 crypto: x86/sm3 - Fixup SLS)
Merging vfio-fixes/for-linus (1ef3342a934e vfio/pci: Fix vf_token mechanism=
 when device-specific VF drivers are used)
Merging kselftest-fixes/fixes (e8f0c8965932 selftest/vm: add skip support t=
o mremap_test)
Merging modules-fixes/modules-linus (dc0ce6cc4b13 lib/test: use after free =
in register_test_dev_kmod())
Merging dmaengine-fixes/fixes (9889fc4f19e0 dmaengine: idxd: Fix the error =
handling path in idxd_cdev_register())
Merging backlight-fixes/for-backlight-fixes (a38fd8748464 Linux 5.12-rc2)
Merging mtd-fixes/mtd/fixes (ba7542eb2dd5 mtd: rawnand: qcom: fix memory co=
rruption that causes panic)
Merging mfd-fixes/for-mfd-fixes (a61f4661fba4 mfd: intel_quark_i2c_gpio: Re=
vert "Constify static struct resources")
Merging v4l-dvb-fixes/fixes (d4cb77112c7b media: isl7998x: select V4L2_FWNO=
DE to fix build error)
Merging reset-fixes/reset/fixes (03cb66463b55 dt-bindings: reset: Add paren=
t "resets" property as optional)
Merging mips-fixes/mips-fixes (f0a6c68f6998 MIPS: Fix CP0 counter erratum d=
etection for R4k CPUs)
Merging at91-fixes/at91-fixes (0c640d9544d0 ARM: dts: at91: fix pinctrl pha=
ndles)
Merging omap-fixes/fixes (46ff3df87215 ARM: dts: logicpd-som-lv: Fix wrong =
pinmuxing on OMAP35)
Merging kvm-fixes/master (053d2290c030 KVM: VMX: Exit to userspace if vCPU =
has injected exception and invalid state)
Merging kvms390-fixes/master (4aa5ac75bf79 KVM: s390: Fix lockdep issue in =
vm memop)
Merging hwmon-fixes/hwmon (3481551f0357 hwmon: (tmp401) Add OF device ID ta=
ble)
Merging nvdimm-fixes/libnvdimm-fixes (d28820419ca3 cxl/pci: Drop shadowed v=
ariable)
Merging cxl-fixes/fixes (fae8817ae804 cxl/mem: Fix memory device capacity p=
robing)
Merging btrfs-fixes/next-fixes (48de4dc26894 Merge branch 'misc-5.18' into =
next-fixes)
Merging vfs-fixes/fixes (9d2231c5d74e lib/iov_iter: initialize "flags" in n=
ew pipe_buffer)
Merging dma-mapping-fixes/for-linus (18a3c5f7abfd Merge tag 'for_linus' of =
git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost)
Merging i3c-fixes/i3c/fixes (fe07bfda2fb9 Linux 5.12-rc1)
Merging drivers-x86-fixes/fixes (44acfc22c7d0 platform/surface: aggregator:=
 Fix initialization order when compiling as builtin module)
Merging samsung-krzk-fixes/fixes (436ce66003d5 ARM: s3c: mark as deprecated=
 and schedule removal)
Merging pinctrl-samsung-fixes/fixes (ac875df4d854 pinctrl: samsung: fix mis=
sing GPIOLIB on ARM64 Exynos config)
Merging devicetree-fixes/dt/linus (5dc463042651 dt-bindings: pci: apple,pci=
e: Drop max-link-speed from example)
Merging scsi-fixes/fixes (26f9ce53817a scsi: qla2xxx: Fix missed DMA unmap =
for aborted commands)
Merging drm-fixes/drm-fixes (c5eb0a61238d Linux 5.18-rc6)
Merging amdgpu-fixes/drm-fixes (2c409ba81be2 drm/radeon: fix si_enable_smc_=
cac() failed issue)
Merging drm-intel-fixes/for-linux-next-fixes (3220c3b21151 drm/i915: Fix ra=
ce in __i915_vma_remove_closed)
Merging mmc-fixes/fixes (3e5a8e8494a8 mmc: sdhci-msm: Reset GCC_SDCC_BCR re=
gister for SDHC)
Merging rtc-fixes/rtc-fixes (bd33335aa93d rtc: cmos: Disable irq around dir=
ect invocation of cmos_interrupt())
Merging gnss-fixes/gnss-linus (312310928417 Linux 5.18-rc1)
Merging hyperv-fixes/hyperv-fixes (eaa03d345358 Drivers: hv: vmbus: Replace=
 smp_store_mb() with virt_store_mb())
Merging soc-fsl-fixes/fix (a222fd854139 soc: fsl: qe: Check of ioremap retu=
rn value)
Merging risc-v-fixes/fixes (c6fe81191bd7 RISC-V: relocate DTB if it's outsi=
de memory region)
Merging pidfd-fixes/fixes (03ba0fe4d09f file: simplify logic in __close_ran=
ge())
Merging fpga-fixes/fixes (312310928417 Linux 5.18-rc1)
Merging spdx/spdx-linus (312310928417 Linux 5.18-rc1)
Merging gpio-brgl-fixes/gpio/for-current (dba785798526 gpio: pca953x: fix i=
rq_stat not updated when irq is disabled (irq_mask not set))
Merging gpio-intel-fixes/fixes (0c2cae09a765 gpiolib: acpi: Convert type fo=
r pin to be unsigned)
Merging pinctrl-intel-fixes/fixes (0be0b70df661 pinctrl: alderlake: Fix reg=
ister offsets for ADL-N variant)
Merging erofs-fixes/fixes (8b1ac84dcf2c Documentation/ABI: sysfs-fs-erofs: =
Fix Sphinx errors)
Merging integrity-fixes/fixes (843385694721 evm: Fix a small race in init_d=
esc())
Merging kunit-fixes/kunit-fixes (02c7efa43627 Documentation: kunit: fix pat=
h to .kunitconfig in start.rst)
Merging ubifs-fixes/fixes (c3c07fc25f37 ubi: fastmap: Return error code if =
memory allocation fails in add_aeb())
Merging memblock-fixes/fixes (c94afc46cae7 memblock: use kfree() to release=
 kmalloced memblock regions)
Merging cel-fixes/for-rc (c5eb0a61238d Linux 5.18-rc6)
Merging irqchip-fixes/irq/irqchip-fixes (544808f7e21c irqchip/gic, gic-v3: =
Prevent GSI to SGI translations)
Merging renesas-fixes/fixes (432b52eea3dc ARM: shmobile: defconfig: Restore=
 graphical consoles)
Merging perf-current/perf/urgent (474e76c4075c tools headers UAPI: Sync lin=
ux/kvm.h with the kernel sources)
Merging efi-fixes/urgent (9feaf8b387ee efi: fix return value of __setup han=
dlers)
Merging zstd-fixes/zstd-linus (88a309465b3f lib: zstd: clean up double word=
 in comment.)
Merging drm-misc-fixes/for-linux-next-fixes (1b5853dfab7f fbdev: efifb: Fix=
 a use-after-free due early fb_info cleanup)
Merging kbuild/for-next (a24e06a3db44 kbuild: record symbol versions in *.c=
md files)
Merging perf/perf/core (33cd6928039c perf evlist: Clear all_cpus before pro=
pagating)
Merging compiler-attributes/compiler-attributes (7c00621dcaee compiler_type=
s: mark __compiletime_assert failure as __noreturn)
Merging dma-mapping/for-next (3cb4503a3301 x86: remove cruft from <asm/dma-=
mapping.h>)
Merging asm-generic/master (fba2689ee77e Merge branch 'remove-h8300' of git=
://git.infradead.org/users/hch/misc into asm-generic)
CONFLICT (modify/delete): Documentation/devicetree/bindings/memory-controll=
ers/renesas,h8300-bsc.yaml deleted in asm-generic/master and modified in HE=
AD.  Version HEAD of Documentation/devicetree/bindings/memory-controllers/r=
enesas,h8300-bsc.yaml left in tree.
$ git rm -f Documentation/devicetree/bindings/memory-controllers/renesas,h8=
300-bsc.yaml
Merging arc/for-next (6aa98f621786 ARC: bpf: define uapi for BPF_PROG_TYPE_=
PERF_EVENT program type)
Merging arm/for-next (012d2fb6c8c9 Merge branch 'devel-stable' into for-nex=
t)
CONFLICT (content): Merge conflict in arch/arm/Kconfig
CONFLICT (content): Merge conflict in arch/arm/Kconfig
CONFLICT (content): Merge conflict in arch/arm/Kconfig.debug
CONFLICT (content): Merge conflict in arch/arm/boot/compressed/Makefile
CONFLICT (content): Merge conflict in arch/arm/include/asm/switch_to.h
CONFLICT (content): Merge conflict in arch/arm/kernel/traps.c
Merging arm64/for-next/core (01ce2f5af527 Merge branch 'for-next/crashkerne=
l' into for-next/core)
Merging arm-perf/for-next/perf (6b79738b6ed9 drivers/perf: hisi: Add Suppor=
t for CPA PMU)
Merging arm-soc/for-next (306cd09cef03 soc: document merges)
CONFLICT (content): Merge conflict in arch/arm/Kconfig
Merging actions/for-next (444d018d8d38 ARM: dts: owl-s500-roseapplepi: Add =
ATC2603C PMIC)
Merging amlogic/for-next (ed532523b458 Merge branch 'v5.18/fixes' into for-=
next)
Merging aspeed/for-next (d9540eeaa3d1 Merge branches 'nuvoton-dt-for-v5.18'=
 and 'dt-for-v5.18' into for-next)
Merging at91/at91-next (386d0503c1eb ARM: configs: at91: Enable AUTOFS_FS r=
equired by systemd)
Merging drivers-memory/for-next (1e2b798e9664 Merge branch 'for-v5.19/tegra=
-mc' into for-next)
Merging imx-mxs/for-next (6ed2affe8f7f Merge branch 'imx/defconfig' into fo=
r-next)
Merging keystone/next (cb293d3b430e Merge branch 'for_5.15/drivers-soc' int=
o next)
Merging mediatek/for-next (54715794cbcd Merge branch 'v5.18-next/soc' into =
for-next)
Merging mvebu/for-next (b93b6e704ac8 Merge branch 'mvebu/dt64' into mvebu/f=
or-next)
CONFLICT (content): Merge conflict in arch/arm64/boot/dts/marvell/armada-37=
20-uDPU.dts
Merging omap/for-next (b5418fc0478c Merge branch 'omap-for-v5.19/dt' into f=
or-next)
Merging qcom/for-next (b0362ef88de4 Merge branches 'arm64-for-5.19', 'arm64=
-defconfig-for-5.19', 'clk-for-5.19', 'defconfig-for-5.19', 'drivers-for-5.=
19', 'dts-for-5.19' and 'arm64-fixes-for-5.18' into for-next)
Merging raspberrypi/for-next (c5915b53d4c2 dt-bindings: soc: bcm: Convert b=
rcm,bcm2835-vchiq to json-schema)
Merging renesas/next (7ae962c56cea Merge branch 'renesas-arm-dt-for-v5.19' =
into renesas-next)
Merging reset/reset/next (2ca065dc9468 dt-bindings: reset: st,sti-powerdown=
: Convert to yaml)
Merging rockchip/for-next (29cd342258c8 Merge branch 'v5.19-armsoc/dts64' i=
nto for-next)
Merging samsung-krzk/for-next (88fb0c4d0aff Merge branch 'next/dt64' into f=
or-next)
Merging scmi/for-linux-next (7d9c90c48ca9 Merge tag 'ffa-updates-5.19' of g=
it://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into for-li=
nux-next)
Merging stm32/stm32-next (5b7e58313a77 ARM: dts: stm32: Add SCMI version of=
 STM32 boards (DK1/DK2/ED1/EV1))
Merging sunxi/sunxi/for-next (073220ee354d Merge branch 'sunxi/dt-for-5.19'=
 into sunxi/for-next)
Merging tee/next (db30e53bf897 Merge branch 'tee_cleanup_for_v5.19' into ne=
xt)
Merging tegra/for-next (864067632632 Merge branch for-5.19/arm64/defconfig =
into for-next)
Merging ti/ti-next (4cc89036bc4f Merge branch 'ti-k3-dts-next' into ti-next)
Merging xilinx/for-next (312310928417 Linux 5.18-rc1)
Merging clk/clk-next (b473708bf4b5 Merge branch 'clk-airoha' into clk-next)
Merging clk-imx/for-next (43896f56b59e clk: imx8mp: add clkout1/2 support)
Merging clk-renesas/renesas-clk (23426d1be3c2 clk: renesas: r9a09g011: Add =
eth clock and reset entries)
Merging clk-samsung/for-next (45bd8166a1d8 clk: samsung: Add initial Exynos=
7885 clock driver)
Merging csky/linux-next (c5acdf12cc24 csky: atomic: Add conditional atomic =
operations' optimization)
Merging m68k/for-next (4fbdb1a9e9e5 m68k: math-emu: Fix typos in comments)
Merging m68knommu/for-next (5c2b20c83e40 m68knommu: add definitions to supp=
ort elf_fdpic program loader)
CONFLICT (content): Merge conflict in arch/m68k/kernel/ptrace.c
Merging microblaze/next (78b5f52ab6f6 microblaze: fix typos in comments)
Merging mips/mips-next (912a4427bec0 MIPS: adding a safety check for cpu_ha=
s_fpu)
Merging nios2/for-next (7f7bc20bc41a nios2: Don't use _end for calculating =
min_low_pfn)
Merging openrisc/for-next (862cf8d5fd98 openrisc/boot: Remove unnecessary i=
nitialisation in memcpy().)
Merging parisc-hd/for-next (ffdc7d66e5e4 parisc: Don't enforce DMA completi=
on order in cache flushes)
Merging powerpc/next (f06351f8c0c8 powerpc/eeh: Remove unused inline functi=
ons)
Merging soc-fsl/next (1ce93cb102e7 soc: fsl: qe: Check of ioremap return va=
lue)
Merging risc-v/for-next (d26eee72d9b9 riscv: dts: rename the node name of d=
ma)
Merging s390/for-next (1236258a73f2 Merge branch 'features' into for-next)
Merging sh/for-next (8518e694203d sh: pgtable-3level: Fix cast to pointer f=
rom integer of different size)
Merging sparc-next/master (dd0d718152e4 Merge tag 'spi-fix-v5.8-rc2' of git=
://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi)
Merging uml/linux-next (82017457957a um: run_helper: Write error message to=
 kernel log on exec failure on host)
Merging xtensa/xtensa-for-next (7f9c97417481 xtensa: clean up labels in the=
 kernel entry assembly)
Merging pidfd/for-next (ccbd0c991985 docs: Add small intro to idmap example=
s)
Merging fscrypt/master (218d921b581e fscrypt: add new helper functions for =
test_dummy_encryption)
Merging fscache/fscache-next (312310928417 Linux 5.18-rc1)
Merging afs/afs-next (26291c54e111 Linux 5.17-rc2)
Merging btrfs/for-next (f7a855b7b2cb Merge branch 'for-next-next-v5.18-2022=
0510' into for-next-20220510)
Merging ceph/master (ecba84bec2e0 fs: change test in inode_insert5 for addi=
ng to the sb list)
Merging cifs/for-next (4cfa6d6563b6 cifs: cache dirent names for cached dir=
ectories)
Merging configfs/for-next (84ec758fb2da configfs: fix a race in configfs_{,=
un}register_subsystem())
Merging ecryptfs/next (682a8e2b41ef Merge tag 'ecryptfs-5.13-rc1-updates' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/tyhicks/ecryptfs)
Merging erofs/dev (d4ac2f657664 erofs: add 'fsid' mount option)
Merging exfat/dev (1d404b899e32 exfat: reduce block requests when zeroing a=
 cluster)
Merging ext3/for_next (40c7b28ce8a9 Pull stricter handling of dirent events=
 from Amir.)
Merging ext4/dev (23e3d7f7061f jbd2: fix a potential race while discarding =
reserved buffers after an abort)
Merging f2fs/dev (5ba96ef31793 f2fs: kill volatile write support)
Merging fsverity/fsverity (07c99001312c fs-verity: support reading signatur=
e with ioctl)
Merging fuse/for-next (6b49bc9d8a5f fuse: avoid unnecessary spinlock bump)
Merging gfs2/for-next (db0c1968e935 gfs2: Variable rename)
CONFLICT (content): Merge conflict in fs/gfs2/file.c
Merging jfs/jfs-next (0d4837fdb796 fs: jfs: fix possible NULL pointer deref=
erence in dbFree())
Merging ksmbd/ksmbd-for-next (22da5264abf4 Merge tag '5.18-rc3-ksmbd-fixes'=
 of git://git.samba.org/ksmbd)
Merging nfs/linux-next (085d16d5f949 nfs: fix broken handling of the softre=
val mount option)
Merging nfs-anna/linux-next (d19e0183a883 NFS: Do not report writeback erro=
rs in nfs_getattr())
Merging nfsd/for-next (c026d0af3890 NFSD: Show state of courtesy client in =
client info)
Merging ntfs3/master (52e00ea6b26e fs/ntfs3: Update valid size if -EIOCBQUE=
UED)
Merging orangefs/for-next (40a74870b2d1 orangefs: Fix the size of a memory =
allocation in orangefs_bufmap_alloc())
Merging overlayfs/overlayfs-next (94fd19752b28 ovl: don't fail copy up if n=
o fileattr support on upper)
Merging ubifs/next (705757274599 ubifs: rename_whiteout: correct old_dir si=
ze computing)
Merging v9fs/9p-next (22e424feb665 Revert "fs/9p: search open fids first")
Merging xfs/for-next (86810a9ebd9e Merge branch 'guilt/xfs-5.19-fuzz-fixes'=
 into xfs-5.19-for-next)
Merging zonefs/for-next (31a644b3c2ae documentation: zonefs: Document sysfs=
 attributes)
CONFLICT (content): Merge conflict in fs/zonefs/super.c
Merging iomap/iomap-for-next (ebb7fb1557b1 xfs, iomap: limit individual ioe=
nd chain lengths in writeback)
Merging djw-vfs/vfs-for-next (49df34221804 fs: fix an infinite loop in ioma=
p_fiemap)
Merging file-locks/locks-next (80d8e4d3f313 fs/locks: fix fcntl_getlk64/fcn=
tl_setlk64 stub prototypes)
Merging vfs/for-next (fd78f28f9f50 Merge branch 'work.namei' into for-next)
Merging printk/for-next (a110b11164a5 Merge branch 'rework/kthreads' into f=
or-next)
Merging pci/next (99ddcbbf5ade Merge branch 'remotes/lorenzo/pci/versatile')
Merging pstore/for-next/pstore (8126b1c73108 pstore: Don't use semaphores i=
n always-atomic-context code)
Merging hid/for-next (9a149c0f3f67 Merge branch 'for-5.18/upstream-fixes' i=
nto for-next)
CONFLICT (content): Merge conflict in drivers/hid/Kconfig
CONFLICT (content): Merge conflict in drivers/hid/Makefile
Merging i2c/i2c/for-next (ef736ba3ca8e Merge branch 'i2c/for-mergewindow' i=
nto i2c/for-next)
Merging i3c/i3c/next (6742ca620bd9 dt-bindings: i3c: Convert snps,dw-i3c-ma=
ster to DT schema)
Merging dmi/dmi-for-next (f97a2103f1a7 firmware: dmi: Move product_sku info=
 to the end of the modalias)
Merging hwmon-staging/hwmon-next (5a47f29a0c83 hwmon: (asus-ec-sensors) add=
 ROG STRIX X570-E GAMING WIFI II)
Merging jc_docs/docs-next (4a840d5fdcfc Documentation: drop more IDE boot o=
ptions and ide-cd.rst)
CONFLICT (content): Merge conflict in Documentation/process/embargoed-hardw=
are-issues.rst
Merging v4l-dvb/master (6c1c1eb8c87d media: ext-ctrls-codec.rst: fix indent=
ation)
Merging v4l-dvb-next/master (be938c70e292 media: uvcvideo: Add UVC_GUID_FOR=
MAT_H265)
Merging pm/linux-next (96a231dae3ae Merge branches 'thermal-int340x' and 't=
hermal-misc' into linux-next)
Merging cpufreq-arm/cpufreq/arm/linux-next (c210063b40ac cpufreq: mediatek:=
 Add opp notification support)
Merging cpupower/cpupower (312310928417 Linux 5.18-rc1)
Merging devfreq/devfreq-next (2e691421a2c9 PM / devfreq: rk3399_dmc: Block =
PMU during transitions)
Merging opp/opp/linux-next (22079af7df5a opp: Reorder definition of ceil/fl=
oor helpers)
Merging thermal/thermal/linux-next (c07a7c8dbcd8 tools/thermal: Add thermal=
 daemon skeleton)
Merging ieee1394/for-next (54b3bd99f094 firewire: nosy: switch from 'pci_' =
to 'dma_' API)
Merging dlm/next (8e51ec6146fd dlm: use kref_put_lock in __put_lkb)
Merging rdma/for-next (08d709d5e124 RDMA/rxe: Optimize the mr pool struct)
Merging net-next/master (9eab75d45ddc Merge branch 'nfp-support-corigine-pc=
ie-vendor-id')
Applying: fix up for "net: sfc: fix memory leak due to ptp channel"
Merging bpf-next/for-next (43bf087848ab bpf: Remove unused parameter from f=
ind_kfunc_desc_btf())
Merging ipsec-next/master (0f9008e5c510 Merge  branch 'Be explicit with XFR=
M offload direction')
Merging mlx5-next/mlx5-next (2984287c4c19 net/mlx5: Remove not-implemented =
IPsec capabilities)
Merging netfilter-next/master (0c7b27616fbd selftests: netfilter: add fib e=
xpression forward test case)
Merging ipvs-next/master (0c7b27616fbd selftests: netfilter: add fib expres=
sion forward test case)
Merging bluetooth/master (a99a4899aae6 Bluetooth: btusb: Add a new PID/VID =
0489/e0c8 for MT7921)
Merging wireless-next/main (f63bc788727c bcma: gpio: Switch to use fwnode i=
nstead of of_node)
Merging mtd/mtd/next (43823c5c56f2 mtd: cfi_cmdset_0002: Rename chip_ready =
variables)
Merging nand/nand/next (079d6348f3be Merge tag 'mtd/mtk-spi-nand-for-5.19' =
into nand/next)
Merging spi-nor/spi-nor/next (94f697c5384b mtd: spi-nor: move spi_nor_write=
_ear() to winbond module)
Merging crypto/master (b52455a73db9 crypto: vmx - Align the short log with =
Makefile cleanups)
Applying: Revert "crypto: vmx - Align the short log with Makefile cleanups"
Merging drm/drm-next (98bcaafd7fb0 Merge tag 'mediatek-drm-next-5.19' of ht=
tps://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux into drm-n=
ext)
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/i915_vma.c
Merging drm-misc/for-linux-next (6c01aa13894f dma-buf: add the name field t=
o the table header)
Merging amdgpu/drm-next (3170f5f23427 drm/amdgpu: Implement get_vmid_pasid_=
mapping for gfx11)
Merging drm-intel/for-linux-next (949665a6e237 drm/i915: Respect VBT seamle=
ss DRRS min refresh rate)
Merging drm-tegra/drm/tegra/for-next (b53c24f69199 drm/tegra: Support YVYU,=
 VYUY and YU24 formats)
Merging drm-msm/msm-next (24df12013853 MAINTAINERS: Add Dmitry as MSM DRM d=
river co-maintainer)
CONFLICT (content): Merge conflict in drivers/gpu/drm/msm/Kconfig
CONFLICT (modify/delete): drivers/gpu/drm/msm/edp/edp.h deleted in drm-msm/=
msm-next and modified in HEAD.  Version HEAD of drivers/gpu/drm/msm/edp/edp=
.h left in tree.
CONFLICT (modify/delete): drivers/gpu/drm/msm/edp/edp_ctrl.c deleted in drm=
-msm/msm-next and modified in HEAD.  Version HEAD of drivers/gpu/drm/msm/ed=
p/edp_ctrl.c left in tree.
$ git rm -f drivers/gpu/drm/msm/edp/edp.h drivers/gpu/drm/msm/edp/edp_ctrl.c
Applying: fix up for "drm/display: Move DSC header and helpers into display=
-helper module"
Applying: fix up for "drm: Rename dp/ to display/"
Merging imx-drm/imx-drm/next (927d8fd465ad drm/imx: ipuv3-plane: Remove red=
undant color encoding and range initialisation)
Merging etnaviv/etnaviv/next (2829a9fcb738 drm/etnaviv: reap idle softpin m=
appings when necessary)
Merging fbdev/for-next (f443e374ae13 Linux 5.17)
Merging regmap/for-next (5c422f0b970d regmap: Add missing map->bus check)
Merging sound/for-next (ec6a8aaafbc5 ALSA: hda/cs8409: Support manual mode =
detection for CS42L42)
Merging sound-asoc/for-next (812fe35aa774 Merge remote-tracking branch 'aso=
c/for-5.19' into asoc-next)
Merging modules/modules-next (0759813b38a8 module: merge check_exported_sym=
bol() into find_exported_symbol_in_section())
Merging input/next (ec648fc0a003 Input: sun4i-lradc-keys - add support for =
R329 and D1)
Merging block/for-next (c1fe8ce2e9ac Merge branch 'for-5.19/io_uring-passth=
rough' into for-next)
Merging device-mapper/for-next (d254c3699fdd dm cache metadata: remove unne=
cessary variable in __dump_mapping)
Merging libata/for-next (fa82cabb8883 doc: admin-guide: Update libata kerne=
l parameters)
Merging pcmcia/pcmcia-next (3928cf08334e pcmcia: db1xxx_ss: restrict to MIP=
S_DB1XXX boards)
Merging mmc/next (0c9ee5ba7555 mmc: sdhci-brcmstb: Fix compiler warning)
Merging mfd/for-mfd-next (3474b838f420 dt-bindings: Drop undocumented i.MX =
iomuxc-gpr bindings in examples)
Merging backlight/for-backlight-next (023a8830a628 backlight: backlight: Sl=
ighly simplify devm_of_find_backlight())
Merging battery/for-next (d96a89407e5f power: supply: bq24190_charger: usin=
g pm_runtime_resume_and_get instead of pm_runtime_get_sync)
Merging regulator/for-next (0459108bf5d1 Merge remote-tracking branch 'regu=
lator/for-5.19' into regulator-next)
Merging security/next-testing (047843bdb316 Merge branch 'landlock_lsm_v34'=
 into next-testing)
Merging apparmor/apparmor-next (c2489617b3b9 apparmor: Fix undefined refere=
nce to `zlib_deflate_workspacesize')
Merging integrity/next-integrity (88338edebe37 Merge branch 'next-integrity=
.fsverity-v9' into next-integrity)
Merging keys/keys-next (2d743660786e Merge branch 'fixes' of git://git.kern=
el.org/pub/scm/linux/kernel/git/viro/vfs)
Merging safesetid/safesetid-next (1b8b71922919 LSM: SafeSetID: Mark safeset=
id_initialized as __initdata)
Merging selinux/next (c29722fad4aa selinux: log anon inode class name)
Merging smack/next (ba6b652bd863 smack: Remove redundant assignments)
Merging tomoyo/master (5015b3b61696 workqueue: Wrap flush_workqueue() using=
 a macro)
Merging tpmdd/next (fad7eba9464e certs: Explain the rationale to call panic=
())
Merging watchdog/master (5b38db0ed51e dt-bindings: watchdog: sunxi: clarify=
 clock support)
Merging iommu/next (faf93cfaadfa Merge branches 'iommu/fixes', 'apple/dart'=
, 'arm/mediatek', 'arm/msm', 'ppc/pamu', 'x86/amd' and 'core' into next)
CONFLICT (content): Merge conflict in MAINTAINERS
CONFLICT (content): Merge conflict in drivers/iommu/amd/iommu.c
Merging audit/next (312310928417 Linux 5.18-rc1)
Merging devicetree/for-next (52bf4b7147e5 Merge branch 'dt/linus' into dt/n=
ext)
Merging mailbox/mailbox-for-next (1b0d0f7c12d5 dt-bindings: mailbox: add de=
finition for mt8186)
Merging spi/for-next (f5fcfe2bdd88 Merge remote-tracking branch 'spi/for-5.=
19' into spi-next)
Merging tip/master (4ff6de27ce83 Merge branch into tip/master: 'x86/asm')
CONFLICT (content): Merge conflict in Documentation/admin-guide/kernel-para=
meters.txt
CONFLICT (content): Merge conflict in arch/x86/kvm/cpuid.c
CONFLICT (content): Merge conflict in kernel/sysctl.c
Merging clockevents/timers/drivers/next (49c14f94ccfe clocksource/drivers/t=
imer-of: check return value of of_iomap in timer_of_base_init())
Merging edac/edac-for-next (cd2ef50eb483 Merge edac-alloc-cleanup into for-=
next)
Merging irqchip/irq/irqchip-next (c34d97c52b85 Merge branch irq/misc-5.19 i=
nto irq/irqchip-next)
Merging ftrace/for-next (c87857e21486 Merge branch 'trace/for-next-rtla' in=
to trace/for-next)
Merging rcu/rcu/next (bfba784d6846 rcu: Add rnp->cbovldmask check in rcutre=
e_migrate_callbacks())
Merging kvm/next (71d7c575a673 Merge branch 'kvm-fixes-for-5.18-rc5' into H=
EAD)
Merging kvm-arm/next (8c22fd2d4cfa Merge branch kvm-arm64/misc-5.19 into kv=
marm-master/next)
CONFLICT (content): Merge conflict in Documentation/virt/kvm/api.rst
CONFLICT (content): Merge conflict in arch/arm64/kvm/sys_regs.c
CONFLICT (content): Merge conflict in include/uapi/linux/kvm.h
Applying: fix up for "VM: arm64: Implement PSCI SYSTEM_SUSPEND"
Merging kvms390/next (4aa5ac75bf79 KVM: s390: Fix lockdep issue in vm memop)
Merging xen-tip/linux-next (533bec143a4c arm/xen: Fix some refcount leaks)
Merging percpu/for-next (4e1f82dce05b Merge branch 'for-5.16-fixes' into fo=
r-next)
Merging workqueues/for-next (10a5a651e3af workqueue: Restrict kworker in th=
e offline CPU pool running on housekeeping CPUs)
Merging drivers-x86/for-next (619695fab3ba platform/x86: pmc_atom: dont exp=
ort pmc_atom_read - no modular users)
Merging chrome-platform/for-next (c9bc1a0ef9f6 platform/chrome: cros_ec_lpc=
s: reserve the MEC LPC I/O ports first)
Merging hsi/for-next (43c14f8d18a7 HSI: omap_ssi: Fix refcount leak in ssi_=
probe)
Merging leds/for-next (73bce575ed90 leds: lp50xx: Remove duplicated error r=
eporting in .remove())
Merging ipmi/for-next (4a00e5fff2c2 ipmi: remove unnecessary type castings)
Merging driver-core/driver-core-next (bc443c31def5 driver core: location: C=
heck for allocations failure)
Merging usb/usb-next (a2673d570bd6 usb: gadget: uvc: track frames in format=
 entries)
Merging thunderbolt/next (8e1de7042596 thunderbolt: Add support for XDomain=
 lane bonding)
Merging usb-gadget/next (e49d033bddf5 Linux 5.12-rc6)
Merging usb-serial/usb-next (1b30499ace5b USB: serial: ftdi_sio: clean up p=
rintk format specifier)
Merging tty/tty-next (4419da5d5d4b tty: hvc: dcc: Bind driver to CPU core0 =
for reads and writes)
Merging char-misc/char-misc-next (35a7609639c4 Merge 5.18-rc5 into char-mis=
c-next)
Merging coresight/next (1adff542d67a coresight: cpu-debug: Replace mutex wi=
th mutex_trylock on panic notifier)
Merging fpga/for-next (7269868818a4 fpga: fpga-region: fix kernel-doc forma=
tting issues)
Merging icc/icc-next (cc64beca6cd4 Merge branch 'icc-const' into icc-next)
Merging iio/togreg (eda75f8238b0 iio: ti-ads8688: use of_device_id for OF m=
atching)
Merging phy-next/next (d413a34932f9 phy: qcom-qmp: rename error labels)
Merging soundwire/next (74da272400b4 soundwire: qcom: adjust autoenumeratio=
n timeout)
Merging extcon/extcon-next (ef799ab8dc5c extcon: Modify extcon device to be=
 created after driver data is set)
CONFLICT (content): Merge conflict in drivers/usb/dwc3/drd.c
Applying: fixup for "usb: dwc3: Don't switch OTG -> peripheral if extcon is=
 present"
Merging gnss/gnss-next (312310928417 Linux 5.18-rc1)
Merging vfio/next (af2d861d4cd2 Linux 5.18-rc4)
Merging staging/staging-next (e41f7a5521d7 staging: r8188eu: remove unused =
IEEE_* defines)
Merging mux/for-next (0fcfb00b28c0 Linux 5.16-rc4)
Merging dmaengine/next (99faef48e7a3 dmaengine: mv_xor_v2 : Move spin_lock_=
bh() to spin_lock())
Merging cgroup/for-next (953da11e98e0 Merge branch 'for-5.18-fixes' into fo=
r-next)
Merging scsi/for-next (f223697cc840 Merge branch 'misc' into for-next)
Merging scsi-mkp/for-next (f304d35e5995 scsi: mpi3mr: Update driver version=
 to 8.0.0.69.0)
Merging vhost/linux-next (1c80cf031e02 vdpa: mlx5: synchronize driver statu=
s with CVQ)
Merging rpmsg/for-next (6d6ea28a160d Merge branches 'rproc-next', 'rpmsg-ne=
xt' and 'hwspinlock-next' into for-next)
Merging gpio/for-next (7ac554888233 MAINTAINERS: Remove reference to non-ex=
isting file)
Merging gpio-brgl/gpio/for-next (86bfb916df59 Merge branch 'irq/gpio-immuta=
ble' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms int=
o gpio/for-next)
Merging gpio-intel/for-next (edc5601db664 pinctrl: meson: Replace custom co=
de by gpiochip_node_count() call)
Merging gpio-sim/gpio/gpio-sim (0fcfb00b28c0 Linux 5.16-rc4)
Merging pinctrl/for-next (b2d71227cf09 Merge branch 'devel' into for-next)
CONFLICT (content): Merge conflict in Documentation/devicetree/bindings/int=
errupt-controller/qcom,pdc.txt
Merging pinctrl-intel/for-next (0be0b70df661 pinctrl: alderlake: Fix regist=
er offsets for ADL-N variant)
Merging pinctrl-renesas/renesas-pinctrl (fc883ed5a43e pinctrl: renesas: che=
cker: Add reserved field checks)
Merging pinctrl-samsung/for-next (ac875df4d854 pinctrl: samsung: fix missin=
g GPIOLIB on ARM64 Exynos config)
Merging pwm/for-next (2bf8ee0faa98 dt-bindings: pwm: Add interrupts propert=
y for MediaTek MT8192)
Merging userns/for-next (2910e5f4a1f8 Merge of per-namespace-ipc-sysctls-fo=
r-v5.19, and kthread-cleanups-for-v5.19 for testing in linux-next)
CONFLICT (modify/delete): arch/h8300/kernel/process.c deleted in HEAD and m=
odified in userns/for-next.  Version userns/for-next of arch/h8300/kernel/p=
rocess.c left in tree.
CONFLICT (content): Merge conflict in arch/x86/kernel/process.c
$ git rm -f arch/h8300/kernel/process.c
Merging ktest/for-next (170f4869e662 ktest.pl: Fix the logic for truncating=
 the size of the log file for email)
Merging kselftest/next (c7b607fa9325 selftests/resctrl: Fix null pointer de=
reference on open failed)
Merging livepatching/for-next (0e1b951d6de0 Merge branch 'for-5.18/selftest=
s-fixes' into for-next)
Merging rtc/rtc-next (312310928417 Linux 5.18-rc1)
Merging nvdimm/libnvdimm-for-next (d43fae7c4d3e testing: nvdimm: asm/mce.h =
is not needed in nfit.c)
Merging at24/at24/for-next (312310928417 Linux 5.18-rc1)
Merging ntb/ntb-next (e9d0fa5e2482 IDT: Fix Build warnings on some 32bit ar=
chitectures.)
Merging seccomp/for-next/seccomp (5e91d2a41469 selftests/seccomp: Fix spell=
ing mistake "Coud" -> "Could")
Merging cisco/for-next (9e98c678c2d6 Linux 5.1-rc1)
Merging fsi/next (f2af60bb7ce2 fsi: Add trace events in initialization path)
Merging slimbus/for-next (54bf672111ee slimbus: qcom: Fix IRQ check in qcom=
_slim_probe)
Merging nvmem/for-next (0f07cbb92a28 nvmem: sfp: Add support for TA 2.1 dev=
ices)
CONFLICT (content): Merge conflict in MAINTAINERS
Merging xarray/main (63b1898fffcd XArray: Disallow sibling entries of nodes)
Merging hyperv/hyperv-next (6733dd4af781 drm/hyperv: Add error message for =
fb size greater than allocated)
Merging auxdisplay/auxdisplay (13de23494f38 auxdisplay: lcd2s: Use array si=
ze explicitly in lcd2s_gotoxy())
Merging kgdb/kgdb/for-next (c1cb81429df4 kdb: Fix the putarea helper functi=
on)
Merging hmm/hmm (312310928417 Linux 5.18-rc1)
Merging kunit/test (312310928417 Linux 5.18-rc1)
Merging cfi/cfi/next (312310928417 Linux 5.18-rc1)
Merging kunit-next/kunit (38289a26e1b8 kunit: fix debugfs code to use enum =
kunit_status, not bool)
CONFLICT (content): Merge conflict in drivers/thunderbolt/test.c
CONFLICT (content): Merge conflict in net/mctp/test/route-test.c
CONFLICT (content): Merge conflict in security/apparmor/policy_unpack_test.c
Merging trivial/for-next (081c8919b02b Documentation: remove trivial tree)
Merging mhi/mhi-next (13b9b814da2d bus: mhi: host: Add support for Foxconn =
T99W373 and T99W368)
Merging memblock/for-next (000605cd1b14 memblock tests: remove completed TO=
DO item)
Merging init/init-user-pointers (38b082236e77 initramfs: use vfs_utimes in =
do_copy)
Merging counters/counters (e71ba9452f0b Linux 5.11-rc2)
Merging cxl/next (280302f0e8f6 cxl/mbox: Replace NULL check with IS_ERR() a=
fter vmemdup_user())
Merging folio-iomap/folio-iomap (4d7bd0eb72e5 iomap: Inline __iomap_zero_it=
er into its caller)
Merging zstd/zstd-next (88a309465b3f lib: zstd: clean up double word in com=
ment.)
Merging efi/next (a6cfe03c34ba efi: stub: prefer mirrored memory for random=
ized allocations)
CONFLICT (content): Merge conflict in drivers/virt/Kconfig
CONFLICT (content): Merge conflict in drivers/virt/Makefile
Merging unicode/for-next (b500d6d7243d unicode: Handle memory allocation fa=
ilures in mkutf8data)
Merging slab/for-next (6b2d72729581 Merge branches 'slab/for-5.19/stackdepo=
t' and 'slab/for-5.19/refactor' into slab/for-next)
Merging random/master (923da5d2251e random: remove ratelimiting for in-kern=
el unseeded randomness)
Merging landlock/next (b0fab2b8e5da landlock: Add design choices documentat=
ion for filesystem access rights)
Merging rust/rust-next (425a9fd52cc6 init/Kconfig: Specify the interpreter =
for rust-is-available.sh)
CONFLICT (content): Merge conflict in Makefile
Merging sysctl/sysctl-next (494dcdf46e5c sched: Fix build warning without C=
ONFIG_SYSCTL)
CONFLICT (content): Merge conflict in kernel/rcu/rcu.h
Merging folio/for-next (12a155458aeb Appoint myself page cache maintainer)
CONFLICT (content): Merge conflict in fs/btrfs/ctree.h
CONFLICT (content): Merge conflict in fs/btrfs/inode.c
CONFLICT (content): Merge conflict in fs/btrfs/send.c
CONFLICT (content): Merge conflict in fs/f2fs/data.c
Applying: fix up for "btrfs: move btrfs_readpage to extent_io.c"
Applying: fixup for "mm,fs: Remove stray references to ->readpage"
Merging execve/for-next/execve (70578ff3367d binfmt_flat: Remove shared lib=
rary support)
Merging bitmap/bitmap-for-next (a64dd2225fa6 drm/amd/pm: use bitmap_{from,t=
o}_arr32 where appropriate)
Merging hte/hte/for-next (e263d33ceccf MAINTAINERS: Add HTE Subsystem)
Merging kspp/for-next/kspp (932c12ae7963 lkdtm/stackleak: fix CONFIG_GCC_PL=
UGIN_STACKLEAK=3Dn)
CONFLICT (content): Merge conflict in drivers/misc/lkdtm/stackleak.c
Merging kspp-gustavo/for-next/kspp (0cf2b91d74b7 Merge branch 'for-next/ksp=
p-stringop-overflow' into for-next/kspp)
Merging mm-stable/mm-stable (a862ffa444c5 Docs/admin-guide/mm/damon/reclaim=
: document 'commit_inputs' parameter)
CONFLICT (content): Merge conflict in arch/x86/mm/Makefile
CONFLICT (content): Merge conflict in fs/nfs/file.c
CONFLICT (content): Merge conflict in include/linux/slab.h
CONFLICT (content): Merge conflict in mm/page_io.c
$ git reset --hard HEAD^
Merging next-20220509 version of mm-stable
CONFLICT (content): Merge conflict in arch/x86/mm/Makefile
[master e15894e53c42] next-20220509/mm-stable
Merging mm-nonmm-stable/mm-nonmm-stable (d60c4d01a98b ipc/mqueue: use get_t=
ree_nodev() in mqueue_get_tree())
$ git reset --hard HEAD^
Merging next-20220509 version of mm-nonmm-stable
Merging mm/mm-everything (abf5ce66461d Merge branch 'mm-nonmm-unstable' int=
o mm-everything)
CONFLICT (content): Merge conflict in fs/nfs/file.c
CONFLICT (content): Merge conflict in include/linux/slab.h
CONFLICT (content): Merge conflict in mm/page_io.c
$ git reset --hard HEAD^
Merging next-20220509 version of mm
CONFLICT (content): Merge conflict in fs/nfs/file.c
CONFLICT (content): Merge conflict in include/linux/slab.h
CONFLICT (content): Merge conflict in mm/page_io.c
[master d77a98f2696e] next-20220509/mm
Applying: linux-next: build failure after merge of the mm tree
[master cf874bdd5437] next-20220509/mm
Applying: Revert "hwmon: (nct6775) Add i2c driver"
Applying: Revert "hwmon: (nct6775) add ASUS PRO H410T / PRIME H410M-R / ROG=
 X570-E GAMING WIFI II"
Applying: Revert "hwmon: (nct6775) Split core and platform driver"
$ git checkout -b akpm remotes/origin/akpm/master
$ git rebase --onto master remotes/origin/akpm/master-base
CONFLICT (content): Merge conflict in tools/testing/selftests/vm/Makefile
Merging akpm/master (526a655c5849 kselftest/vm: override TARGETS from argum=
ents)

--Sig_/Wr=1kiPO4=GNye.W4PIk=0S
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJ6YKkACgkQAVBC80lX
0GzZ5QgAlMXWmipWdyK2eHUC5iwSqzqjZPnpxZO9dcGY0IibW1vrYuIERDE27R1N
POFI7OzkoHxXlYkIPPXx0YiXP4Ys5TR5pF4uigkp+XVF8m0n2XBX3leNnMS71kCg
M/VHYZKMukQ4e6camKgdf0xVzr8kCfQYXa2ObZ2mpcNNIeo8jXSK3KN2JhP+2Zwc
fPDVKxfB7rdUsK5mis2QeqEECDv4LXScYp6XZX/ecuIMVYZeJTe4SUlZfm/psIUC
YYCvDZ4xd+8pvU5XsEYwglU0WYvBTcrpERAQN5yM30SgAACVbSDZZAFb5wtmtgCQ
r+sULOopKML4SulKYzkcwM1v4q0ClA==
=2P+2
-----END PGP SIGNATURE-----

--Sig_/Wr=1kiPO4=GNye.W4PIk=0S--
