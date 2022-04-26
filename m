Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC05350FA49
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 12:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245178AbiDZK0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 06:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348708AbiDZKXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 06:23:49 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642CC3FBEA;
        Tue, 26 Apr 2022 02:54:45 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Kncg53F6Tz4yST;
        Tue, 26 Apr 2022 19:54:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1650966881;
        bh=JklYf/5jQYMhrMCU0Lwnl8x77sfD8m43H5/Geu9NQL4=;
        h=Date:From:To:Cc:Subject:From;
        b=GLqxLaMMYy+ydpkG82u9Ul1igo+F+Kml8yY9dHKUXquIqvavu00eOTdNEwxmM892p
         b3oRFq9hjIPBDrUvnjcB548JnGAWFpDcVNu7P8bn3PS7irmhgNclfx3jGO+TwISo2Z
         XV5C2IXfMpmqA8BMELairXZVCTL18RZIm5Htf3P6rWaWKc9XECUTlnuEW6kn9PxPhG
         Xp5EMRC+L5Fec1EJM/YGXxi8izCuCuJmoMcoGUwVTx/qOEC9jm7SbSxR/5AptwtHlL
         M2ILC7fZ1TLnoUYhbsnbgkO4ARzN5izfWxfeclbNtAHqSSWO5ZCTsUT5fAnVD/Kks3
         eYbDhaxQCKLMw==
Date:   Tue, 26 Apr 2022 19:54:39 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Apr 26
Message-ID: <20220426195439.6a0b58cc@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/5RU0wzLeo73uf_QDykYU2aE";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,LOCALPART_IN_SUBJECT,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/5RU0wzLeo73uf_QDykYU2aE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20220422:

The drm-intel tree gained a build failure so I used the version from
next-20220422.

The sound-asoc tree gained 3 build failures for which I applied patches.

The block tree lost its build failure.

The kvm tree still had its build failure for which I applied a patch.

The usb tree gained a conflict against the usb.current tree.

The extcon tree gained a conflict against the usb tree.

The efi tree gained a conflict against the tip tree.

Non-merge commits (relative to Linus' tree): 6228
 7063 files changed, 283014 insertions(+), 128671 deletions(-)

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

I am currently merging 344 trees (counting Linus' and 93 trees of bug
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
Merging origin/master (d615b5416f8a Merge tag 'f2fs-fix-5.18' of git://git.=
kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs)
Merging fixes/fixes (d06c942efea4 Merge tag 'for_linus' of git://git.kernel=
.org/pub/scm/linux/kernel/git/mst/vhost)
Merging kbuild-current/fixes (312310928417 Linux 5.18-rc1)
Merging arc-current/for-curr (c6ed4d84a2c4 ARC: remove redundant READ_ONCE(=
) in cmpxchg loop)
Merging arm-current/fixes (9be4c88bb792 ARM: 9191/1: arm/stacktrace, kasan:=
 Silence KASAN warnings in unwind_frame())
Merging arm64-fixes/for-next/fixes (23bc8f69f0ec arm64: mm: fix p?d_leaf())
Merging arm-soc-fixes/arm/fixes (2f477ee3ed92 Revert "arm64: dts: tegra: Fi=
x boolean properties with values")
Merging drivers-memory-fixes/fixes (73039c6c7f36 memory: renesas-rpc-if: Fi=
x HF/OSPI data transfer in Manual Mode)
Merging tee-fixes/fixes (98268f2a2a9f Merge branch 'optee_ffa_probe_fix_for=
_v5.18' into fixes)
Merging m68k-current/for-linus (0d52a01a266b m68k: defconfig: Disable fbdev=
 on Sun3/3x)
Merging powerpc-fixes/fixes (bb82c574691d powerpc/perf: Fix 32bit compile)
Merging s390-fixes/fixes (af2d861d4cd2 Linux 5.18-rc4)
Merging sparc/master (05a59d79793d Merge git://git.kernel.org:/pub/scm/linu=
x/kernel/git/netdev/net)
Merging fscrypt-current/for-stable (80f6e3080bfc fs-verity: fix signed inte=
ger overflow with i_size near S64_MAX)
Merging net/master (c3e8d5a40685 Merge branch 'net-smc-two-fixes-for-smc-fa=
llback')
Merging bpf/master (b02d196c44ea bpf, lwt: Fix crash when using bpf_skb_set=
_tunnel_key() from bpf_xmit lwt hook)
Merging ipsec/master (5bd8baab087d esp: limit skb_page_frag_refill use to a=
 single page)
Merging netfilter/master (05ae2fba821c netfilter: nft_socket: make cgroup m=
atch work in input too)
Merging ipvs/master (05ae2fba821c netfilter: nft_socket: make cgroup match =
work in input too)
Merging wireless/main (4dd4e6f65985 MAINTAINERS: update iwlwifi driver main=
tainer)
Merging rdma-fixes/for-rc (ce522ba9ef7e Linux 5.18-rc2)
Merging sound-current/for-linus (eb9d84b0ffe3 ALSA: fireworks: fix wrong re=
turn count shorter than expected by 4 bytes)
Merging sound-asoc-fixes/for-linus (1d53dcf5d0be Merge remote-tracking bran=
ch 'asoc/for-5.17' into asoc-linus)
Merging regmap-fixes/for-linus (312310928417 Linux 5.18-rc1)
Merging regulator-fixes/for-linus (dfd2b37edf7e regulator: dt-bindings: Rev=
ise the rt5190a buck/ldo description)
Merging spi-fixes/for-linus (8868c03f3ca5 spi: spi-mem: check if data buffe=
rs are on stack)
Merging pci-current/for-linus (92597f97a40b PCI/PM: Avoid putting Elo i2 PC=
Ie Ports in D3cold)
Merging driver-core.current/driver-core-linus (c95ce3a23dcd topology: Fix u=
p build warning in topology_is_visible())
Merging tty.current/tty-linus (637674fa4005 serial: 8250: Correct the clock=
 for EndRun PTP/1588 PCIe device)
Merging usb.current/usb-linus (da609eda81a8 Merge tag 'usb-serial-5.18-rc4'=
 of https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into u=
sb-linus)
Merging usb-gadget-fixes/fixes (e49d033bddf5 Linux 5.12-rc6)
Merging usb-serial-fixes/usb-linus (e23e50e7acc8 USB: serial: whiteheat: fi=
x heap overflow in WHITEHEAT_GET_DTR_RTS)
Merging phy/fixes (2c8045d48dee phy: amlogic: fix error path in phy_g12a_us=
b3_pcie_probe())
Merging staging.current/staging-linus (ce522ba9ef7e Linux 5.18-rc2)
Merging iio-fixes/fixes-togreg (b5d6ba09b10d iio: imu: inv_icm42600: Fix I2=
C init possible nack)
Merging counter-fixes/fixes-togreg (ce522ba9ef7e Linux 5.18-rc2)
Merging char-misc.current/char-misc-linus (5b47b751b760 eeprom: at25: Use D=
MA safe buffers)
Merging soundwire-fixes/fixes (312310928417 Linux 5.18-rc1)
Merging thunderbolt-fixes/fixes (af2d861d4cd2 Linux 5.18-rc4)
Merging input-current/for-linus (470776c6b034 Input: add Marine Navigation =
Keycodes)
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
Merging mips-fixes/mips-fixes (b2d229d4ddb1 Linux 5.18-rc3)
Merging at91-fixes/at91-fixes (0c640d9544d0 ARM: dts: at91: fix pinctrl pha=
ndles)
Merging omap-fixes/fixes (46ff3df87215 ARM: dts: logicpd-som-lv: Fix wrong =
pinmuxing on OMAP35)
Merging kvm-fixes/master (e852be8b148e kvm: selftests: introduce and use mo=
re page size-related constants)
Merging kvms390-fixes/master (0e9ff65f455d KVM: s390: preserve deliverable_=
mask in __airqs_kick_single_vcpu)
Merging hwmon-fixes/hwmon (75d2b2b06bd8 hwmon: (pmbus) disable PEC if not e=
nabled)
Merging nvdimm-fixes/libnvdimm-fixes (d28820419ca3 cxl/pci: Drop shadowed v=
ariable)
Merging cxl-fixes/fixes (fae8817ae804 cxl/mem: Fix memory device capacity p=
robing)
Merging btrfs-fixes/next-fixes (fb95740ffb07 Merge branch 'misc-5.18' into =
next-fixes)
Merging vfs-fixes/fixes (9d2231c5d74e lib/iov_iter: initialize "flags" in n=
ew pipe_buffer)
Merging dma-mapping-fixes/for-linus (18a3c5f7abfd Merge tag 'for_linus' of =
git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost)
Merging i3c-fixes/i3c/fixes (fe07bfda2fb9 Linux 5.12-rc1)
Merging drivers-x86-fixes/fixes (b2dd71f9f728 tools/power/x86/intel-speed-s=
elect: fix build failure when using -Wl,--as-needed)
Merging samsung-krzk-fixes/fixes (436ce66003d5 ARM: s3c: mark as deprecated=
 and schedule removal)
Merging pinctrl-samsung-fixes/fixes (ac875df4d854 pinctrl: samsung: fix mis=
sing GPIOLIB on ARM64 Exynos config)
Merging devicetree-fixes/dt/linus (652980b1541c dt-bindings: display: panel=
-timing: Define a single type for properties)
Merging scsi-fixes/fixes (faad6cebded8 scsi: sr: Do not leak information in=
 ioctl)
Merging drm-fixes/drm-fixes (c18a2a280c07 Merge tag 'drm-misc-fixes-2022-04=
-22' of git://anongit.freedesktop.org/drm/drm-misc into drm-fixes)
Merging amdgpu-fixes/drm-fixes (2c409ba81be2 drm/radeon: fix si_enable_smc_=
cac() failed issue)
Merging drm-intel-fixes/for-linux-next-fixes (c05d8332f5d2 drm/i915: Check =
EDID for HDR static metadata when choosing blc)
Merging mmc-fixes/fixes (ce522ba9ef7e Linux 5.18-rc2)
Merging rtc-fixes/rtc-fixes (bd33335aa93d rtc: cmos: Disable irq around dir=
ect invocation of cmos_interrupt())
Merging gnss-fixes/gnss-linus (312310928417 Linux 5.18-rc1)
Merging hyperv-fixes/hyperv-fixes (eaa03d345358 Drivers: hv: vmbus: Replace=
 smp_store_mb() with virt_store_mb())
Merging soc-fsl-fixes/fix (a222fd854139 soc: fsl: qe: Check of ioremap retu=
rn value)
Merging risc-v-fixes/fixes (760d10a5b792 RISC-V: configs: Configs that had =
RPMSG_CHAR now get RPMSG_CTRL)
Merging pidfd-fixes/fixes (03ba0fe4d09f file: simplify logic in __close_ran=
ge())
Merging fpga-fixes/fixes (312310928417 Linux 5.18-rc1)
Merging spdx/spdx-linus (312310928417 Linux 5.18-rc1)
Merging gpio-brgl-fixes/gpio/for-current (cc7328af2f85 gpiolib: of: fix bou=
nds check for 'gpio-reserved-ranges')
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
Merging cel-fixes/for-rc (4d5004451ab2 SUNRPC: Fix the svc_deferred_event t=
race class)
Merging irqchip-fixes/irq/irqchip-fixes (544808f7e21c irqchip/gic, gic-v3: =
Prevent GSI to SGI translations)
Merging renesas-fixes/fixes (432b52eea3dc ARM: shmobile: defconfig: Restore=
 graphical consoles)
Merging perf-current/perf/urgent (22da5264abf4 Merge tag '5.18-rc3-ksmbd-fi=
xes' of git://git.samba.org/ksmbd)
Merging efi-fixes/urgent (9feaf8b387ee efi: fix return value of __setup han=
dlers)
Merging zstd-fixes/zstd-linus (88a309465b3f lib: zstd: clean up double word=
 in comment.)
Merging drm-misc-fixes/for-linux-next-fixes (94f4c4965e55 drm/amdgpu: parti=
al revert "remove ctx->lock" v2)
Merging kbuild/for-next (7c39c50dcb74 scripts: dummy-tools, add pahole)
Merging perf/perf/core (e0c1b8f9eba8 Merge remote-tracking branch 'torvalds=
/master' into perf/core)
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
Merging arc/for-next (e88856183749 ARC: bpf: define uapi for BPF_PROG_TYPE_=
PERF_EVENT program type)
Merging arm/for-next (012d2fb6c8c9 Merge branch 'devel-stable' into for-nex=
t)
CONFLICT (content): Merge conflict in arch/arm/Kconfig
CONFLICT (content): Merge conflict in arch/arm/Kconfig
CONFLICT (content): Merge conflict in arch/arm/Kconfig.debug
CONFLICT (content): Merge conflict in arch/arm/boot/compressed/Makefile
CONFLICT (content): Merge conflict in arch/arm/include/asm/switch_to.h
CONFLICT (content): Merge conflict in arch/arm/kernel/traps.c
Merging arm64/for-next/core (5c346f94d293 Merge branch 'for-next/misc' into=
 for-next/core)
Merging arm-perf/for-next/perf (602c873eb52e perf: Replace acpi_bus_get_dev=
ice())
Merging arm-soc/for-next (967ba514d3a6 Merge branch 'arm/multiplatform-late=
' into for-next)
CONFLICT (content): Merge conflict in arch/arm/Kconfig
Merging actions/for-next (444d018d8d38 ARM: dts: owl-s500-roseapplepi: Add =
ATC2603C PMIC)
Merging amlogic/for-next (ed532523b458 Merge branch 'v5.18/fixes' into for-=
next)
Merging aspeed/for-next (d9540eeaa3d1 Merge branches 'nuvoton-dt-for-v5.18'=
 and 'dt-for-v5.18' into for-next)
Merging at91/at91-next (0c640d9544d0 ARM: dts: at91: fix pinctrl phandles)
Merging drivers-memory/for-next (3b8e7e227bd5 Merge branch 'mem-ctrl-next' =
into for-next)
Merging imx-mxs/for-next (5565f35abe7b Merge branch 'imx/defconfig' into fo=
r-next)
Merging keystone/next (cb293d3b430e Merge branch 'for_5.15/drivers-soc' int=
o next)
Merging mediatek/for-next (e24b4c321107 Merge branch 'v5.18-next/soc' into =
for-next)
Merging mvebu/for-next (8885ae5142a4 Merge branch 'mvebu/dt64' into mvebu/f=
or-next)
Merging omap/for-next (e7b192fae27b Merge branch 'omap-for-v5.19/ti-sysc' i=
nto for-next)
Merging qcom/for-next (0d2ff8a1a075 Merge branches 'arm64-for-5.19', 'arm64=
-defconfig-for-5.19', 'clk-for-5.19', 'defconfig-for-5.19', 'drivers-for-5.=
19', 'dts-for-5.19' and 'arm64-fixes-for-5.18' into for-next)
Merging raspberrypi/for-next (c5915b53d4c2 dt-bindings: soc: bcm: Convert b=
rcm,bcm2835-vchiq to json-schema)
Merging renesas/next (36f093d12e3c Merge branches 'renesas-drivers-for-v5.1=
9' and 'renesas-dt-bindings-for-v5.19' into renesas-next)
Merging reset/reset/next (3f7bdc13154a dt-bindings: reset: uniphier-glue: C=
lean up clocks, resets, and their names using compatible string)
Merging rockchip/for-next (80ff2eb434b6 Merge branch 'v5.18-armsoc/dtsfixes=
' into for-next)
Merging samsung-krzk/for-next (9d53182805ec Merge branch 'next/drivers' int=
o for-next)
Merging scmi/for-linux-next (06fd9f1ceb6e Merge branch 'for-next/juno' of g=
it://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into for-li=
nux-next)
Merging stm32/stm32-next (448fb6ea127c ARM: dts: stm32: enable RTC support =
on stm32mp135f-dk)
Merging sunxi/sunxi/for-next (737a9ba0eeb8 Merge branch 'sunxi/fixes-for-5.=
18' into sunxi/for-next)
Merging tee/next (17522923771d Merge branch 'fixes' into next)
Merging tegra/for-next (115996bf2635 Merge branch for-5.19/arm64/dt into fo=
r-next)
Merging ti/ti-next (c0a75ca134c9 Merge branches 'ti-drivers-soc-next' and '=
ti-keystone-dts-next' into ti-next)
Merging xilinx/for-next (312310928417 Linux 5.18-rc1)
Merging clk/clk-next (2b7bd9ef856a Merge branch 'clk-renesas' into clk-next)
Merging clk-imx/for-next (39772efd98ad clk: imx8mp: Add DISP2 pixel clock)
Merging clk-renesas/renesas-clk (13b4d179c664 dt-bindings: clock: renesas,c=
pg-mssr: Document r8a779g0)
Merging clk-samsung/for-next (45bd8166a1d8 clk: samsung: Add initial Exynos=
7885 clock driver)
Merging csky/linux-next (c5acdf12cc24 csky: atomic: Add conditional atomic =
operations' optimization)
Merging m68k/for-next (a96e4ebf3ded m68k: defconfig: Update defconfigs for =
v5.18-rc1)
Merging m68knommu/for-next (b2d229d4ddb1 Linux 5.18-rc3)
Merging microblaze/next (68cbfae83a72 microblaze: Add support for reserved =
memory defined by DT)
Merging mips/mips-next (b2d229d4ddb1 Linux 5.18-rc3)
Merging nios2/for-next (7f7bc20bc41a nios2: Don't use _end for calculating =
min_low_pfn)
Merging openrisc/for-next (862cf8d5fd98 openrisc/boot: Remove unnecessary i=
nitialisation in memcpy().)
Merging parisc-hd/for-next (e34799ccc126 parisc: Change MAX_ADDRESS to beco=
me unsigned long long)
Merging powerpc/next (ce522ba9ef7e Linux 5.18-rc2)
Merging soc-fsl/next (1ce93cb102e7 soc: fsl: qe: Check of ioremap return va=
lue)
Merging risc-v/for-next (d26eee72d9b9 riscv: dts: rename the node name of d=
ma)
Merging s390/for-next (9a07731702d9 s390: add KCSAN instrumentation to barr=
iers and spinlocks)
Merging sh/for-next (8518e694203d sh: pgtable-3level: Fix cast to pointer f=
rom integer of different size)
Merging sparc-next/master (dd0d718152e4 Merge tag 'spi-fix-v5.8-rc2' of git=
://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi)
Merging uml/linux-next (82017457957a um: run_helper: Write error message to=
 kernel log on exec failure on host)
Merging xtensa/xtensa-for-next (c8b222cfc804 xtensa: enable ARCH_HAS_DEBUG_=
VM_PGTABLE)
Merging pidfd/for-next (0014edaedfd8 fs: unset MNT_WRITE_HOLD on failure)
Merging fscrypt/master (a7a5bc5fe8ac fscrypt: log when starting to use inli=
ne encryption)
Merging fscache/fscache-next (312310928417 Linux 5.18-rc1)
Merging afs/afs-next (26291c54e111 Linux 5.17-rc2)
Merging btrfs/for-next (4972fdf152fa Merge branch 'for-next-next-v5.18-2022=
0422' into for-next-20220422)
Merging ceph/master (7acae6183cf3 ceph: fix possible NULL pointer dereferen=
ce for req->r_session)
Merging cifs/for-next (88c5060d56d8 Merge tag '5.18-rc3-smb3-fixes' of git:=
//git.samba.org/sfrench/cifs-2.6)
Merging configfs/for-next (84ec758fb2da configfs: fix a race in configfs_{,=
un}register_subsystem())
Merging ecryptfs/next (682a8e2b41ef Merge tag 'ecryptfs-5.13-rc1-updates' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/tyhicks/ecryptfs)
Merging erofs/dev (a1108dcd9373 erofs: rename ctime to mtime)
Merging exfat/dev (1d404b899e32 exfat: reduce block requests when zeroing a=
 cluster)
Merging ext3/for_next (cfb73d370782 Pull evictable fsnotify marks work from=
 Amir.)
Merging ext4/dev (23e3d7f7061f jbd2: fix a potential race while discarding =
reserved buffers after an abort)
Merging f2fs/dev (6daa83cbee0d f2fs: extend stat_lock to avoid potential ra=
ce in statfs)
Merging fsverity/fsverity (07c99001312c fs-verity: support reading signatur=
e with ioctl)
Merging fuse/for-next (6b49bc9d8a5f fuse: avoid unnecessary spinlock bump)
Merging gfs2/for-next (1b2de0791571 gfs2: Mark the remaining process-indepe=
ndent glock holders as GL_NOPID)
Merging jfs/jfs-next (0d4837fdb796 fs: jfs: fix possible NULL pointer deref=
erence in dbFree())
Merging ksmbd/ksmbd-for-next (22da5264abf4 Merge tag '5.18-rc3-ksmbd-fixes'=
 of git://git.samba.org/ksmbd)
Merging nfs/linux-next (e13433b4416f SUNRPC release the transport of a relo=
cated task with an assigned transport)
Merging nfs-anna/linux-next (d19e0183a883 NFS: Do not report writeback erro=
rs in nfs_getattr())
Merging nfsd/for-next (5c2cb3833940 SUNRPC: Remove svc_rqst::rq_xprt_hlen)
Merging ntfs3/master (52e00ea6b26e fs/ntfs3: Update valid size if -EIOCBQUE=
UED)
Merging orangefs/for-next (40a74870b2d1 orangefs: Fix the size of a memory =
allocation in orangefs_bufmap_alloc())
Merging overlayfs/overlayfs-next (94fd19752b28 ovl: don't fail copy up if n=
o fileattr support on upper)
Merging ubifs/next (705757274599 ubifs: rename_whiteout: correct old_dir si=
ze computing)
Merging v9fs/9p-next (22e424feb665 Revert "fs/9p: search open fids first")
Merging xfs/for-next (a44a027a8b2a Merge tag 'large-extent-counters-v9' of =
https://github.com/chandanr/linux into xfs-5.19-for-next)
Merging zonefs/for-next (c907372552bb documentation: zonefs: Document sysfs=
 attributes)
Merging iomap/iomap-for-next (ebb7fb1557b1 xfs, iomap: limit individual ioe=
nd chain lengths in writeback)
Merging djw-vfs/vfs-for-next (49df34221804 fs: fix an infinite loop in ioma=
p_fiemap)
Merging file-locks/locks-next (80d8e4d3f313 fs/locks: fix fcntl_getlk64/fcn=
tl_setlk64 stub prototypes)
Merging vfs/for-next (fd78f28f9f50 Merge branch 'work.namei' into for-next)
Merging printk/for-next (248b050d8366 Merge branch 'rework/kthreads' into f=
or-next)
Merging pci/next (89905ffa4545 Merge branch 'remotes/lorenzo/pci/rockchip')
Merging pstore/for-next/pstore (8126b1c73108 pstore: Don't use semaphores i=
n always-atomic-context code)
Merging hid/for-next (22d0912fc3fd Merge branch 'for-5.18/upstream-fixes' i=
nto for-next)
CONFLICT (content): Merge conflict in drivers/hid/Kconfig
CONFLICT (content): Merge conflict in drivers/hid/Makefile
Merging i2c/i2c/for-next (05b42eff61a5 Merge branch 'i2c/for-mergewindow' i=
nto i2c/for-next)
Merging i3c/i3c/next (6cbf8b38dfe3 i3c: fix uninitialized variable use in i=
2c setup)
Merging dmi/dmi-for-next (f97a2103f1a7 firmware: dmi: Move product_sku info=
 to the end of the modalias)
Merging hwmon-staging/hwmon-next (e95c5a2ae0bf hwmon: (lm75) Add Atmel AT30=
TS74 support)
Merging jc_docs/docs-next (f5461124d59b Documentation: move watch_queue to =
core-api)
Merging v4l-dvb/master (3d59142ad94c media: dvb-usb: dib0700_devices: use a=
n enum for the device number)
Merging v4l-dvb-next/master (6c1c1eb8c87d media: ext-ctrls-codec.rst: fix i=
ndentation)
Merging pm/linux-next (c15e061fb0ab Merge branches 'acpi-processor' and 'th=
ermal-int340x-fixes' into linux-next)
Merging cpufreq-arm/cpufreq/arm/linux-next (8f705811d64b cpufreq: mediatek:=
 Make sram regulator optional)
Merging cpupower/cpupower (312310928417 Linux 5.18-rc1)
Merging devfreq/devfreq-next (5d521a307526 PM / devfreq: rk3399_dmc: Avoid =
static (reused) profile)
Merging opp/opp/linux-next (543256d239b4 PM: opp: simplify with dev_err_pro=
be())
Merging thermal/thermal/linux-next (c07a7c8dbcd8 tools/thermal: Add thermal=
 daemon skeleton)
Merging ieee1394/for-next (54b3bd99f094 firewire: nosy: switch from 'pci_' =
to 'dma_' API)
Merging dlm/next (e425ac99b157 fs: dlm: cast resource pointer to uintptr_t)
Merging rdma/for-next (98c8026331ce RDMA/rxe: Remove reliable datagram supp=
ort)
Merging net-next/master (cc271ab86606 wwan_hwsim: Avoid flush_scheduled_wor=
k() usage)
Merging bpf-next/for-next (d9d31cf88702 bpf: Use bpf_prog_run_array_cg_flag=
s everywhere)
Merging ipsec-next/master (b58b1f563ab7 xfrm: rework default policy structu=
re)
Merging mlx5-next/mlx5-next (2984287c4c19 net/mlx5: Remove not-implemented =
IPsec capabilities)
Merging netfilter-next/master (0c7b27616fbd selftests: netfilter: add fib e=
xpression forward test case)
Merging ipvs-next/master (0c7b27616fbd selftests: netfilter: add fib expres=
sion forward test case)
Merging bluetooth/master (df50527dbc32 Bluetooth: protect le accept and res=
olv lists with hdev->lock)
Merging wireless-next/main (2fb822f82a59 rtw89: 8852c: add chip_ops related=
 to BTC)
Merging mtd/mtd/next (ec8615bcd6f3 mtd: phram: Allow cached mappings)
Merging nand/nand/next (3380557fc7e2 mtd: rawnand: add support for Toshiba =
TC58NVG0S3HTA00 NAND flash)
Merging spi-nor/spi-nor/next (b2d229d4ddb1 Linux 5.18-rc3)
Merging crypto/master (b0c42232fce4 crypto: hisilicon/qm - remove hisi_qm_g=
et_free_qp_num())
Merging drm/drm-next (19df0cfa258c Merge tag 'drm-misc-next-2022-04-21' of =
git://anongit.freedesktop.org/drm/drm-misc into drm-next)
CONFLICT (content): Merge conflict in drivers/gpu/drm/radeon/radeon_sync.c
Merging drm-misc/for-linux-next (57e6f0562cb4 drm: mxsfb: Obtain bus flags =
from bridge state)
Merging amdgpu/drm-next (398bb283899b drm/amd/display: 3.2.183)
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/clk_mg=
r/dcn315/dcn315_clk_mgr.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/dcn10/=
dcn10_hw_sequencer.c
Applying: fix up for "drm/ttm: rework bulk move handling v5"
Merging drm-intel/for-linux-next (a8e85faaa51f drm/i915: Add crtc .crtc_get=
_shared_dpll())
$ git reset --hard HEAD^
Merging next-20220422 version of drm-intel
Merging drm-tegra/drm/tegra/for-next (b53c24f69199 drm/tegra: Support YVYU,=
 VYUY and YU24 formats)
Merging drm-msm/msm-next (78f815c1cf8f drm/msm: return the average load ove=
r the polling period)
Merging imx-drm/imx-drm/next (927d8fd465ad drm/imx: ipuv3-plane: Remove red=
undant color encoding and range initialisation)
Merging etnaviv/etnaviv/next (2829a9fcb738 drm/etnaviv: reap idle softpin m=
appings when necessary)
Merging fbdev/for-next (6fbe0cc53a1b video: fbdev: clps711x-fb: Use syscon_=
regmap_lookup_by_phandle)
CONFLICT (content): Merge conflict in drivers/video/fbdev/omap/lcdc.c
Merging regmap/for-next (d640947562ce regmap: cache: set max_register with =
reg_stride)
Merging sound/for-next (011b559be832 ALSA: pcm: Check for null pointer of p=
ointer substream before dereferencing it)
Merging sound-asoc/for-next (2edf5b3ec5a7 Merge remote-tracking branch 'aso=
c/for-5.19' into asoc-next)
Merging modules/modules-next (eeaec7801c42 powerpc: Select ARCH_WANTS_MODUL=
ES_DATA_IN_VMALLOC on book3s/32 and 8xx)
Merging input/next (b243018eafeb Input: sun4i-lradc-keys - add wakeup suppo=
rt)
Merging block/for-next (104390679b6e Merge branch 'for-5.19/io_uring' into =
for-next)
Merging device-mapper/for-next (e7ea9556985f dm: improve abnormal bio proce=
ssing)
Merging libata/for-next (0cb63670d505 ata: Make use of the helper function =
devm_platform_ioremap_resource())
Merging pcmcia/pcmcia-next (3928cf08334e pcmcia: db1xxx_ss: restrict to MIP=
S_DB1XXX boards)
Merging mmc/next (2363b0d9535b dt-bindings: mmc: imx-esdhc: Add i.MX8DXL co=
mpatible string)
Merging mfd/for-mfd-next (d99460ed5cdc dt-bindings: mfd: syscon: Add microc=
hip,lan966x-cpu-syscon compatible)
Merging backlight/for-backlight-next (023a8830a628 backlight: backlight: Sl=
ighly simplify devm_of_find_backlight())
Merging battery/for-next (312310928417 Linux 5.18-rc1)
Merging regulator/for-next (4f42615b0602 Merge remote-tracking branch 'regu=
lator/for-5.19' into regulator-next)
Merging security/next-testing (047843bdb316 Merge branch 'landlock_lsm_v34'=
 into next-testing)
Merging apparmor/apparmor-next (c2489617b3b9 apparmor: Fix undefined refere=
nce to `zlib_deflate_workspacesize')
Merging integrity/next-integrity (29d1c2b47ef3 ima: remove redundant initia=
lization of pointer 'file'.)
Merging keys/keys-next (2d743660786e Merge branch 'fixes' of git://git.kern=
el.org/pub/scm/linux/kernel/git/viro/vfs)
Merging safesetid/safesetid-next (1b8b71922919 LSM: SafeSetID: Mark safeset=
id_initialized as __initdata)
Merging selinux/next (6a9e261cbbee selinux: don't sleep when CONFIG_SECURIT=
Y_SELINUX_CHECKREQPROT_VALUE is true)
Merging smack/next (ba6b652bd863 smack: Remove redundant assignments)
Merging tomoyo/master (ae5d03879e63 workqueue: Warn flushing of kernel-glob=
al workqueues)
Merging tpmdd/next (fad7eba9464e certs: Explain the rationale to call panic=
())
Merging watchdog/master (b2d229d4ddb1 Linux 5.18-rc3)
Merging iommu/next (71ff461c3f41 iommu/omap: Fix regression in probe for NU=
LL pointer dereference)
Merging audit/next (312310928417 Linux 5.18-rc1)
Merging devicetree/for-next (c4f3f823c2a6 dt-bindings: timer: Add compatibl=
e for am6 for TI timer-dm)
Merging mailbox/mailbox-for-next (1b0d0f7c12d5 dt-bindings: mailbox: add de=
finition for mt8186)
Merging spi/for-next (3c557de9aa6f Merge remote-tracking branch 'spi/for-5.=
19' into spi-next)
Merging tip/master (8da18e1d2df3 Merge ras/core into tip/master)
CONFLICT (content): Merge conflict in Documentation/admin-guide/kernel-para=
meters.txt
CONFLICT (content): Merge conflict in kernel/sysctl.c
Merging clockevents/timers/drivers/next (49c14f94ccfe clocksource/drivers/t=
imer-of: check return value of of_iomap in timer_of_base_init())
Merging edac/edac-for-next (423279d81631 Merge branch 'edac-alloc-cleanup' =
into edac-for-next)
Merging irqchip/irq/irqchip-next (4bde53ab3370 Merge branch irq/gpio-immuta=
ble into irq/irqchip-next)
Merging ftrace/for-next (c87857e21486 Merge branch 'trace/for-next-rtla' in=
to trace/for-next)
Merging rcu/rcu/next (e5215598af9b rcu: Put panic_on_rcu_stall() after expe=
dited RCU CPU stall warnings)
Merging kvm/next (5d6c7de6446e KVM: x86: Bail to userspace if emulation of =
atomic user access faults)
Applying: fix up for "KVM, SEV: Add KVM_EXIT_SHUTDOWN metadata for SEV-ES"
Merging kvm-arm/next (21ea45784275 KVM: arm64: fix typos in comments)
Merging kvms390/next (4aa5ac75bf79 KVM: s390: Fix lockdep issue in vm memop)
Merging xen-tip/linux-next (533bec143a4c arm/xen: Fix some refcount leaks)
Merging percpu/for-next (4e1f82dce05b Merge branch 'for-5.16-fixes' into fo=
r-next)
Merging workqueues/for-next (10a5a651e3af workqueue: Restrict kworker in th=
e offline CPU pool running on housekeeping CPUs)
Merging drivers-x86/for-next (b0c07116c894 platform/x86: amd-pmc: Avoid rea=
ding SMU version at probe time)
Merging chrome-platform/for-next (57b888ca2541 platform/chrome: Re-introduc=
e cros_ec_cmd_xfer and use it for ioctls)
Merging hsi/for-next (43c14f8d18a7 HSI: omap_ssi: Fix refcount leak in ssi_=
probe)
Merging leds/for-next (312310928417 Linux 5.18-rc1)
Merging ipmi/for-next (b250fa7e0b68 ipmi: Make two logs unique)
Merging driver-core/driver-core-next (5b5bfecaa333 scripts/get_abi: Fix wro=
ng script file name in the help message)
Merging usb/usb-next (bdddc253b093 usb: rework usb_maxpacket() using usb_pi=
pe_endpoint())
CONFLICT (content): Merge conflict in drivers/usb/dwc3/drd.c
Merging thunderbolt/next (9d2d0a5cf0ca thunderbolt: Use different lane for =
second DisplayPort tunnel)
Merging usb-gadget/next (e49d033bddf5 Linux 5.12-rc6)
Merging usb-serial/usb-next (312310928417 Linux 5.18-rc1)
Merging tty/tty-next (8043b16f522c serial: stm32: add earlycon support)
Merging char-misc/char-misc-next (1f7142915d30 VMCI: Add support for ARM64)
Merging coresight/next (c86dd9869128 coresight: etm4x: Cleanup TRCRSCTLRn r=
egister accesses)
Merging fpga/for-next (eee1071ee7df fpga: Use tab instead of space indentat=
ion)
Merging icc/icc-next (2fb251c26560 interconnect: qcom: sdx55: Drop IP0 inte=
rconnects)
Merging iio/togreg (b28bc9ebbe23 iio: adc: ti-ads1015: Switch to read_avail)
Merging phy-next/next (f7f9abc5eab9 phy: freescale: imx8m-pcie: Handle IMX8=
_PCIE_REFCLK_PAD_UNUSED)
Merging soundwire/next (60657fb9b19d dt-bindings: soundwire: qcom: Add bind=
ings for audio clock reset control property)
Merging extcon/extcon-next (ddc1e8f1d478 extcon: ptn5150: Add usb role clas=
s support)
CONFLICT (content): Merge conflict in drivers/usb/dwc3/drd.c
Applying: fixup for "usb: dwc3: Don't switch OTG -> peripheral if extcon is=
 present"
Merging gnss/gnss-next (312310928417 Linux 5.18-rc1)
Merging vfio/next (f621eb13facb vfio-pci: Provide reviewers and acceptance =
criteria for variant drivers)
Merging staging/staging-next (1efba7ef1d7d staging: bcm2835-audio: delete T=
ODO)
Merging mux/for-next (0fcfb00b28c0 Linux 5.16-rc4)
Merging dmaengine/next (99faef48e7a3 dmaengine: mv_xor_v2 : Move spin_lock_=
bh() to spin_lock())
Merging cgroup/for-next (5c26993c31f0 cgroup: Add config file to cgroup sel=
ftest suite)
Merging scsi/for-next (adf47e8f2883 Merge branch 'misc' into for-next)
Merging scsi-mkp/for-next (a346f28ad231 scsi: lpfc: Remove unneeded variabl=
e)
Merging vhost/linux-next (1c80cf031e02 vdpa: mlx5: synchronize driver statu=
s with CVQ)
Merging rpmsg/for-next (76de1da77831 Merge branches 'rpmsg-next', 'rproc-ne=
xt', 'hwspinlock-next' and 'rproc-fixes' into for-next)
Merging gpio/for-next (7ac554888233 MAINTAINERS: Remove reference to non-ex=
isting file)
Merging gpio-brgl/gpio/for-next (fae74fb5d525 gpio: pcf857x: Make teardown =
callback return void)
Merging gpio-intel/for-next (edc5601db664 pinctrl: meson: Replace custom co=
de by gpiochip_node_count() call)
Merging gpio-sim/gpio/gpio-sim (0fcfb00b28c0 Linux 5.16-rc4)
Merging pinctrl/for-next (091304c65297 Merge branch 'devel' into for-next)
CONFLICT (content): Merge conflict in Documentation/devicetree/bindings/int=
errupt-controller/qcom,pdc.txt
Merging pinctrl-intel/for-next (0be0b70df661 pinctrl: alderlake: Fix regist=
er offsets for ADL-N variant)
Merging pinctrl-renesas/renesas-pinctrl (f7bc5f52d235 pinctrl: renesas: rzg=
2l: Restore pin config order)
Merging pinctrl-samsung/for-next (ac875df4d854 pinctrl: samsung: fix missin=
g GPIOLIB on ARM64 Exynos config)
Merging pwm/for-next (2bf8ee0faa98 dt-bindings: pwm: Add interrupts propert=
y for MediaTek MT8192)
Merging userns/for-next (9def41809e95 Merge of prlimit-tasklist_lock-for-v5=
.18, per-namespace-ipc-sysctls-for-v5.18, and ptrace-for-v5.18 for testing =
in linux-next)
Merging ktest/for-next (170f4869e662 ktest.pl: Fix the logic for truncating=
 the size of the log file for email)
Merging kselftest/next (68c4844985d1 selftests/resctrl: Add missing SPDX li=
cense to Makefile)
Merging livepatching/for-next (0e1b951d6de0 Merge branch 'for-5.18/selftest=
s-fixes' into for-next)
Merging rtc/rtc-next (312310928417 Linux 5.18-rc1)
Merging nvdimm/libnvdimm-for-next (ada8d8d337ee nvdimm/blk: Fix title level)
Merging at24/at24/for-next (312310928417 Linux 5.18-rc1)
Merging ntb/ntb-next (e9d0fa5e2482 IDT: Fix Build warnings on some 32bit ar=
chitectures.)
Merging seccomp/for-next/seccomp (8a3d3ea66f0d selftests/seccomp: Add SKIP =
for failed unshare())
Merging cisco/for-next (9e98c678c2d6 Linux 5.1-rc1)
Merging fsi/next (f2af60bb7ce2 fsi: Add trace events in initialization path)
Merging slimbus/for-next (54bf672111ee slimbus: qcom: Fix IRQ check in qcom=
_slim_probe)
Merging nvmem/for-next (2e26a810b679 nvmem: sunplus-ocotp: staticize sp_otp=
_v0)
Merging xarray/main (63b1898fffcd XArray: Disallow sibling entries of nodes)
Merging hyperv/hyperv-next (a765ed47e451 PCI: hv: Fix synchronization betwe=
en channel callback and hv_compose_msi_msg())
Merging auxdisplay/auxdisplay (13de23494f38 auxdisplay: lcd2s: Use array si=
ze explicitly in lcd2s_gotoxy())
Merging kgdb/kgdb/for-next (c1cb81429df4 kdb: Fix the putarea helper functi=
on)
Merging hmm/hmm (312310928417 Linux 5.18-rc1)
Merging kunit/test (312310928417 Linux 5.18-rc1)
Merging cfi/cfi/next (e783362eb54c Linux 5.17-rc1)
Merging kunit-next/kunit (59729170afcd kunit: Make kunit_remove_resource() =
idempotent)
CONFLICT (content): Merge conflict in drivers/thunderbolt/test.c
CONFLICT (content): Merge conflict in net/mctp/test/route-test.c
CONFLICT (content): Merge conflict in security/apparmor/policy_unpack_test.c
Merging trivial/for-next (081c8919b02b Documentation: remove trivial tree)
Merging mhi/mhi-next (17e6ff4937be bus: mhi: host: Add support for Cinterio=
n MV32-WA/MV32-WB)
Merging memblock/for-next (58ffc34896db memblock tests: Add TODO and README=
 files)
Merging init/init-user-pointers (38b082236e77 initramfs: use vfs_utimes in =
do_copy)
Merging counters/counters (e71ba9452f0b Linux 5.11-rc2)
Merging cxl/next (280302f0e8f6 cxl/mbox: Replace NULL check with IS_ERR() a=
fter vmemdup_user())
Merging folio-iomap/folio-iomap (4d7bd0eb72e5 iomap: Inline __iomap_zero_it=
er into its caller)
Merging zstd/zstd-next (88a309465b3f lib: zstd: clean up double word in com=
ment.)
Merging efi/next (21b68da7bf4a efi: x86: Set the NX-compatibility flag in t=
he PE header)
CONFLICT (content): Merge conflict in drivers/virt/Kconfig
CONFLICT (content): Merge conflict in drivers/virt/Makefile
Merging unicode/for-next (5298d4bfe80f unicode: clean up the Kconfig symbol=
 confusion)
Merging slab/for-next (48ae8244f719 Merge branches 'slab/for-5.19/stackdepo=
t' and 'slab/for-5.19/refactor' into slab/for-next)
Merging random/master (b9d7c7f46a7e random: insist on random_get_entropy() =
existing in order to simplify)
Merging landlock/next (312310928417 Linux 5.18-rc1)
Merging rust/rust-next (011150424cd9 rust: avoid all GCC plugins, not just =
the randstruct one)
CONFLICT (content): Merge conflict in Makefile
Merging sysctl/sysctl-next (8fd7c2144d12 ftrace: fix building with SYSCTL=
=3Dy but DYNAMIC_FTRACE=3Dn)
CONFLICT (content): Merge conflict in kernel/rcu/rcu.h
Merging folio/for-next (98ea02597b99 mm/rmap: Fix handling of hugetlbfs pag=
es in page_vma_mapped_walk)
Merging execve/for-next/execve (70578ff3367d binfmt_flat: Remove shared lib=
rary support)
Merging bitmap/bitmap-for-next (28bf2111f48c include/linux/find: Fix docume=
ntation)
Merging kspp/for-next/kspp (e6f3b3c9c109 cfi: Use __builtin_function_start)
Merging kspp-gustavo/for-next/kspp (452d059ea2b6 drm/amd/display: Fix Wstri=
ngop-overflow warnings in dc_link_dp.c)
Applying: fixup for "ASoC: Intel: avs: Configure modules according to their=
 type"
Applying: partial revert of "ASoC: Intel: avs: Enable AVS driver only on x8=
6 platforms"
Applying: Revert "ASoC: SOF: mediatek: Add DSP system PM callback for mt818=
6"
Applying: Revert "ASoC: SOF: mediatek: Add mt8186 dsp clock support"
Applying: Revert "ASoC: SOF: mediatek: Add mt8186 sof fw loader and dsp ops"
Merging akpm-current/current (4e4d1fead913 arm64: entry: use stackleak_eras=
e_on_task_stack())
CONFLICT (content): Merge conflict in arch/x86/mm/Makefile
$ git checkout -b akpm remotes/origin/akpm/master
$ git rebase --onto master remotes/origin/akpm/master-base
Merging akpm/master (8ffa7c5aad99 kselftest/vm: override TARGETS from argum=
ents)

--Sig_/5RU0wzLeo73uf_QDykYU2aE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJnwV8ACgkQAVBC80lX
0GzYVAf/ZXzrMsy4XpYorI47Ggn+EfFHAbDNeU5gB5FK1b2xyispi448kt/2iva3
wKQmW7KFCS6gHhmx3XI4j5mBp//R0U4yam6udwR8Yfeoib2SQDqtq/uJMaJrO35i
To2xOkHMFglNi0uAZyL6Q/c0viXau1/jVmH6xgcdQ4H/TeFaZNLsEaxmRwURGOxg
1FFsE8QwbjurfA4PjXi/Kx2248yJ6/XWRCCTkoIDYzv9Pz1FAPJdNpYDbHM2waWK
M8qv5P8BwQlqpa/G5q9bsuJ/3VOb4mp+AKCcWoUDZjO8MzTsyqqxYmoC82X8SNEm
EB5aIR9L1bKMo9mLhgnO23Oms3D3Ug==
=bed9
-----END PGP SIGNATURE-----

--Sig_/5RU0wzLeo73uf_QDykYU2aE--
