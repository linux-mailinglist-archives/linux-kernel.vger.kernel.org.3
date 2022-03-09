Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A48A14D2E76
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 12:54:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232496AbiCILyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 06:54:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiCILyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 06:54:52 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4618D66FAF;
        Wed,  9 Mar 2022 03:53:51 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KD9Zj4P1Yz4xnG;
        Wed,  9 Mar 2022 22:53:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1646826829;
        bh=LLJJf529q6Jd1jvkFctRcwcOexvrEQErUjq5OFGzr6A=;
        h=Date:From:To:Cc:Subject:From;
        b=ZMXt+FhNHxnQOM0h/NQiMCGjLELAUPl1vSf6w7K9yBL+kdC760/Q6cflv4be+e4Cd
         KNHH0rabYXpw6igYZQv7ak1NM/U+vLLivIydm0fVJW9XTARqQmSmNHOLUS9KgPAgW/
         imMfgytcAqFq6bP1+ZKKGzwMBujtx2unU4TvPDKYzSq8ue/PgxLLc4Q9424WDpVn0+
         /73IkREMfGd/9/6MO+RqR2g0FgHTObKUFfqVeTCNEGFCB9f0hDc/9JoOdIl7u5YnAU
         S0oNnZ5E1/5lpD6BFl6hkr6wZ8hGnvClhdxPNbRrXeAHdmJuxTkWwBsGIwKatQPLvW
         pnIX+Ov6WNQdQ==
Date:   Wed, 9 Mar 2022 22:53:48 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Mar 9
Message-ID: <20220309225348.0dfc41ee@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/aZzfr_PzcvnOJS4QvlNR/Ks";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,LOCALPART_IN_SUBJECT,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/aZzfr_PzcvnOJS4QvlNR/Ks
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20220308:

The arm tree gained a conflict against Linus' tree.

The arm64 tree gained a conflict against Linus' tree.

The block tree gained a build failure so I used the version from
next-20220308.

The mfd tree gained a conflict against the arm-soc tree.

The kspp tree exposed a build failure in the drivers-x86 tree for which
I reverted a commit.

Non-merge commits (relative to Linus' tree): 10634
 10627 files changed, 934253 insertions(+), 240852 deletions(-)

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

I am currently merging 346 trees (counting Linus' and 94 trees of bug
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
Merging origin/master (330f4c53d3c2 ARM: fix build error when BPF_SYSCALL i=
s disabled)
Merging fixes/fixes (d06c942efea4 Merge tag 'for_linus' of git://git.kernel=
.org/pub/scm/linux/kernel/git/mst/vhost)
Merging kbuild-current/fixes (754e0b0e3560 Linux 5.17-rc4)
Merging arc-current/for-curr (e783362eb54c Linux 5.17-rc1)
Merging arm-current/fixes (7b83299e5b93 ARM: 9182/1: mmu: fix returns from =
early_param() and __setup() functions)
Merging arm64-fixes/for-next/fixes (4f6de676d94e arm64: Correct wrong label=
 in macro __init_el2_gicv3)
Merging arm-soc-fixes/arm/fixes (d3258737afc0 Revert "arm64: dts: mt8183: j=
acuzzi: Fix bus properties in anx's DSI endpoint")
Merging drivers-memory-fixes/fixes (e783362eb54c Linux 5.17-rc1)
Merging tee-fixes/fixes (6d8df1f9e8ae Merge tag 'optee-fix2-for-v5.17' into=
 fixes)
Merging m68k-current/for-linus (1a0ae068bf6b m68k: defconfig: Update defcon=
figs for v5.16-rc1)
Merging powerpc-fixes/fixes (48015b632f77 powerpc: Fix STACKTRACE=3Dn build)
Merging s390-fixes/fixes (c194dad21025 s390/extable: fix exception table so=
rting)
Merging sparc/master (05a59d79793d Merge git://git.kernel.org:/pub/scm/linu=
x/kernel/git/netdev/net)
Merging fscrypt-current/for-stable (80f6e3080bfc fs-verity: fix signed inte=
ger overflow with i_size near S64_MAX)
Merging net/master (e5417cbf7ab5 net: dsa: mt7530: fix incorrect test in mt=
753x_phylink_validate())
Merging bpf/master (18b1ab7aa76b xsk: Fix race at socket teardown)
Merging ipsec/master (23c7f8d7989e net: Fix esp GSO on inter address family=
 tunnels.)
Merging netfilter/master (f8e9bd34cedd Merge branch 'smc-fix')
Merging ipvs/master (277f2bb14361 ibmvnic: schedule failover only if vioctl=
 fails)
Merging wireless/main (e6e91ec966db iwlwifi: mvm: return value for request_=
ownership)
Merging rdma-fixes/for-rc (7e57714cd0ad Linux 5.17-rc6)
Merging sound-current/for-linus (cd94df179541 ALSA: usb-audio: add mapping =
for new Corsair Virtuoso SE)
Merging sound-asoc-fixes/for-linus (5e02fb590e83 ASoC: cs35l41: Fix DSP mbo=
x start command and global enable order)
Merging regmap-fixes/for-linus (d04ad245d67a regmap-irq: Update interrupt c=
lear register for proper reset)
Merging regulator-fixes/for-linus (1a69f6b8c034 Merge remote-tracking branc=
h 'regulator/for-5.16' into regulator-linus)
Merging spi-fixes/for-linus (194a533b9841 Merge remote-tracking branch 'spi=
/for-5.16' into spi-linus)
Merging pci-current/for-linus (3f1271b54edc PCI: Mark all AMD Navi10 and Na=
vi14 GPU ATS as broken)
Merging driver-core.current/driver-core-linus (7e57714cd0ad Linux 5.17-rc6)
Merging tty.current/tty-linus (7e57714cd0ad Linux 5.17-rc6)
Merging usb.current/usb-linus (7e57714cd0ad Linux 5.17-rc6)
Merging usb-gadget-fixes/fixes (e49d033bddf5 Linux 5.12-rc6)
Merging usb-serial-fixes/usb-linus (7e57714cd0ad Linux 5.17-rc6)
Merging usb-chipidea-fixes/for-usb-fixes (f130d08a8d79 usb: chipidea: ci_hd=
rc_imx: Also search for 'phys' phandle)
CONFLICT (content): Merge conflict in drivers/usb/chipidea/ci_hdrc_imx.c
Merging phy/fixes (9a8406ba1a9a phy: dphy: Correct clk_pre parameter)
Merging staging.current/staging-linus (342e7c6ea582 staging: rtl8723bs: Imp=
rove the comment explaining the locking rules)
Merging iio-fixes/fixes-togreg (123d838c4e7d iio: adc: xilinx-ams: Fix sing=
le channel switching sequence)
Merging counter-fixes/fixes-togreg (4a14311a3b93 counter: Stop using dev_ge=
t_drvdata() to get the counter device)
Merging char-misc.current/char-misc-linus (7e57714cd0ad Linux 5.17-rc6)
Merging soundwire-fixes/fixes (e783362eb54c Linux 5.17-rc1)
Merging thunderbolt-fixes/fixes (ffb217a13a2e Linux 5.17-rc7)
Merging input-current/for-linus (327b89f0acc4 HID: add mapping for KEY_ALL_=
APPLICATIONS)
Merging crypto-current/master (c6ce9c5831ca crypto: api - Move cryptomgr so=
ft dependency into algapi)
Merging vfio-fixes/for-linus (8704e8934908 vfio/pci: Fix OpRegion read)
Merging kselftest-fixes/fixes (6fec1ab67f8d selftests/ftrace: Do not trace =
do_softirq because of PREEMPT_RT)
Merging modules-fixes/modules-linus (a8e8f851e829 module: fix building with=
 sysfs disabled)
Merging dmaengine-fixes/fixes (cfb92440ee71 Linux 5.17-rc5)
Merging backlight-fixes/for-backlight-fixes (a38fd8748464 Linux 5.12-rc2)
Merging mtd-fixes/mtd/fixes (42da5a4ba170 mtd: rawnand: omap2: Actually pre=
vent invalid configuration and build error)
Merging mfd-fixes/for-mfd-fixes (a61f4661fba4 mfd: intel_quark_i2c_gpio: Re=
vert "Constify static struct resources")
Merging v4l-dvb-fixes/fixes (d40f0b133b44 media: meson-ir-tx: remove incorr=
ect doc comment)
Merging reset-fixes/reset/fixes (92c959bae2e5 reset: renesas: Fix Runtime P=
M usage)
Merging mips-fixes/mips-fixes (5d8965704fe5 MIPS: ralink: mt7621: use bitwi=
se NOT instead of logical)
Merging at91-fixes/at91-fixes (26077968f838 dt-bindings: ARM: at91: update =
maintainers entry)
Merging omap-fixes/fixes (8840f5460a23 ARM: dts: Use 32KiHz oscillator on d=
evkit8000)
Merging kvm-fixes/master (8d25b7beca7e KVM: x86: pull kvm->srcu read-side t=
o kvm_arch_vcpu_ioctl_run)
Merging kvms390-fixes/master (0e9ff65f455d KVM: s390: preserve deliverable_=
mask in __airqs_kick_single_vcpu)
Merging hwmon-fixes/hwmon (686d303ee630 hwmon: (pmbus) Add mutex to regulat=
or ops)
Merging nvdimm-fixes/libnvdimm-fixes (3dd60fb9d95d nvdimm/pmem: stop using =
q_usage_count as external pgmap refcount)
Merging cxl-fixes/fixes (fae8817ae804 cxl/mem: Fix memory device capacity p=
robing)
Merging btrfs-fixes/next-fixes (e3727c6aef80 Merge branch 'misc-5.17' into =
next-fixes)
Merging vfs-fixes/fixes (9d2231c5d74e lib/iov_iter: initialize "flags" in n=
ew pipe_buffer)
Merging dma-mapping-fixes/for-linus (18a3c5f7abfd Merge tag 'for_linus' of =
git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost)
Merging i3c-fixes/i3c/fixes (fe07bfda2fb9 Linux 5.12-rc1)
Merging drivers-x86-fixes/fixes (21d90aaee8d5 surface: surface3_power: Fix =
battery readings on batteries without a serial number)
Merging samsung-krzk-fixes/fixes (442b0c08db7e soc: samsung: Fix typo in CO=
NFIG_EXYNOS_USI description)
Merging pinctrl-samsung-fixes/fixes (e783362eb54c Linux 5.17-rc1)
Merging devicetree-fixes/dt/linus (f6eafa4022dd dt-bindings: phy: ti,tcan10=
4x-can: Document mux-states property)
Merging scsi-fixes/fixes (10af11564617 scsi: ufs: core: Fix divide by zero =
in ufshcd_map_queues())
Merging drm-fixes/drm-fixes (8fdb19679722 Merge tag 'drm-misc-fixes-2022-03=
-03' of git://anongit.freedesktop.org/drm/drm-misc into drm-fixes)
Merging amdgpu-fixes/drm-fixes (2c409ba81be2 drm/radeon: fix si_enable_smc_=
cac() failed issue)
Merging drm-intel-fixes/for-linux-next-fixes (804f46885317 drm/i915/psr: Se=
t "SF Partial Frame Enable" also on full update)
Merging mmc-fixes/fixes (1760fdb6fe9f mmc: core: Restore (almost) the busy =
polling for MMC_SEND_OP_COND)
Merging rtc-fixes/rtc-fixes (bd33335aa93d rtc: cmos: Disable irq around dir=
ect invocation of cmos_interrupt())
Merging gnss-fixes/gnss-linus (e783362eb54c Linux 5.17-rc1)
Merging hyperv-fixes/hyperv-fixes (ffc58bc4af93 Drivers: hv: utils: Make us=
e of the helper macro LIST_HEAD())
Merging soc-fsl-fixes/fix (a222fd854139 soc: fsl: qe: Check of ioremap retu=
rn value)
Merging risc-v-fixes/fixes (74583f1b92cb riscv: dts: k210: fix broken IRQs =
on hart1)
Merging pidfd-fixes/fixes (03ba0fe4d09f file: simplify logic in __close_ran=
ge())
Merging fpga-fixes/fixes (8bb7eca972ad Linux 5.15)
Merging spdx/spdx-linus (d8152cfe2f21 Merge tag 'pci-v5.17-fixes-5' of git:=
//git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci)
Merging gpio-brgl-fixes/gpio/for-current (a9a5b720dc82 gpio: sim: Declare g=
pio_sim_hog_config_item_ops static)
Merging gpio-intel-fixes/fixes (e783362eb54c Linux 5.17-rc1)
Merging pinctrl-intel-fixes/fixes (6f66db29e241 pinctrl: tigerlake: Revert =
"Add Alder Lake-M ACPI ID")
Merging erofs-fixes/fixes (24331050a3e6 erofs: fix small compressed files i=
nlining)
Merging integrity-fixes/fixes (843385694721 evm: Fix a small race in init_d=
esc())
Merging kunit-fixes/kunit-fixes (92a68053c346 Documentation: KUnit: Fix usa=
ge bug)
Merging ubifs-fixes/fixes (c3c07fc25f37 ubi: fastmap: Return error code if =
memory allocation fails in add_aeb())
Merging memblock-fixes/fixes (c94afc46cae7 memblock: use kfree() to release=
 kmalloced memblock regions)
Merging cel-fixes/for-rc (c306d737691e NFSD: Deprecate NFS_OFFSET_MAX)
Merging irqchip-fixes/irq/irqchip-fixes (1d4df649cbb4 irqchip/sifive-plic: =
Add missing thead,c900-plic match string)
Merging renesas-fixes/fixes (432b52eea3dc ARM: shmobile: defconfig: Restore=
 graphical consoles)
Merging perf-current/perf/urgent (ac84e82f78cb Merge tag 'block-5.17-2022-0=
3-04' of git://git.kernel.dk/linux-block)
Merging efi-fixes/urgent (9feaf8b387ee efi: fix return value of __setup han=
dlers)
Merging zstd-fixes/zstd-linus (88a309465b3f lib: zstd: clean up double word=
 in comment.)
Merging drm-misc-fixes/for-linux-next-fixes (9470c29faa91 drm/sun4i: mixer:=
 Fix P010 and P210 format numbers)
Merging kbuild/for-next (d4c858643263 kallsyms: ignore all local labels pre=
fixed by '.L')
Merging perf/perf/core (56dce868198c libperf: Add API for allocating new th=
read map array)
Merging compiler-attributes/compiler-attributes (7c00621dcaee compiler_type=
s: mark __compiletime_assert failure as __noreturn)
Merging dma-mapping/for-next (80e439098161 dma-debug: fix return value of _=
_setup handlers)
Merging asm-generic/master (3edb65f4e8fd nds32: Remove the architecture)
Merging arc/for-next (6880fa6c5660 Linux 5.15-rc1)
Merging arm/for-next (341c6c03da34 Merge branch 'devel-stable' into for-nex=
t)
CONFLICT (content): Merge conflict in arch/arm/kernel/traps.c
Merging arm64/for-next/core (a866fe492730 Merge branch 'for-next/fpsimd' in=
to for-next/core)
CONFLICT (content): Merge conflict in arch/arm64/include/asm/sysreg.h
CONFLICT (content): Merge conflict in arch/arm64/kernel/cpufeature.c
Merging arm-perf/for-next/perf (602c873eb52e perf: Replace acpi_bus_get_dev=
ice())
Merging arm-soc/for-next (4d0d3c7a6571 soc: document merges)
CONFLICT (content): Merge conflict in arch/arm/Kconfig
Merging actions/for-next (444d018d8d38 ARM: dts: owl-s500-roseapplepi: Add =
ATC2603C PMIC)
Merging amlogic/for-next (305cab6f7645 Merge branch 'v5.18/drivers' into fo=
r-next)
Merging aspeed/for-next (d9540eeaa3d1 Merge branches 'nuvoton-dt-for-v5.18'=
 and 'dt-for-v5.18' into for-next)
Merging at91/at91-next (a845fa592554 Merge branch 'clk-at91' into at91-next)
Merging drivers-memory/for-next (560f9d092a9d Merge branch 'mem-ctrl-next' =
into for-next)
Merging imx-mxs/for-next (45550ada88f0 Merge branch 'imx/defconfig' into fo=
r-next)
Merging keystone/next (cb293d3b430e Merge branch 'for_5.15/drivers-soc' int=
o next)
Merging mediatek/for-next (6ceb6a96db4e Merge branch 'v5.17-fixes' into for=
-next)
Merging mvebu/for-next (89756932b780 Merge branch 'mvebu/dt64' into mvebu/f=
or-next)
Merging omap/for-next (f9ecc209330a Merge branch 'omap-for-v5.18/dt' into f=
or-next)
Merging qcom/for-next (22139a9091fd Merge branches 'arm64-defconfig-for-5.1=
8', 'arm64-for-5.18', 'clk-for-5.18', 'defconfig-for-5.18', 'drivers-for-5.=
18', 'dts-for-5.18', 'arm64-fixes-for-5.17' and 'dts-fixes-for-5.17' into f=
or-next)
CONFLICT (content): Merge conflict in arch/arm/configs/multi_v7_defconfig
CONFLICT (content): Merge conflict in arch/arm64/configs/defconfig
Merging raspberrypi/for-next (c5915b53d4c2 dt-bindings: soc: bcm: Convert b=
rcm,bcm2835-vchiq to json-schema)
Merging renesas/next (dff7b84b4d2a Merge branch 'renesas-arm-dt-for-v5.18' =
into renesas-next)
Merging reset/reset/next (89e7a6698fdd reset: uniphier-glue: Use devm_add_a=
ction_or_reset())
Merging rockchip/for-next (ea80f22c4edd Merge branch 'v5.18-armsoc/dts64' i=
nto for-next)
CONFLICT (content): Merge conflict in arch/arm64/boot/dts/rockchip/rk356x.d=
tsi
Merging samsung-krzk/for-next (b2d5c4016a34 Merge branch 'for-v5.18/dt-clea=
nup' into for-next)
Merging scmi/for-linux-next (210b966b7e2f Merge tag 'scmi-updates-5.18' of =
git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into for-l=
inux-next)
Merging stm32/stm32-next (74fa56279651 ARM: dts: stm32: Switch DWMAC RMII c=
lock to MCO2 on DHCOM)
Merging sunxi/sunxi/for-next (f25c47c67629 Merge branch 'sunxi/dt-for-5.18'=
 into sunxi/for-next)
Merging tee/next (3e53bb2bd87b Merge branch 'tee_shm_vmalloc_for_v5.19' int=
o next)
Merging tegra/for-next (6d746e1eb2f6 Merge branch for-5.18/arm64/defconfig =
into for-next)
Merging ti/ti-next (183a6f5c6e1e Merge branches 'ti-k3-dts-next' and 'ti-dr=
ivers-soc-next' into ti-next)
Merging xilinx/for-next (3a14f0e61408 arm64: zynqmp: Rename dma to dma-cont=
roller)
Merging clk/clk-next (7da5e77a1b5f Merge branch 'clk-fixes' into clk-next)
Merging clk-imx/for-next (b09c68dc57c9 clk: imx: pll14xx: Support dynamic r=
ates)
Merging clk-renesas/renesas-clk (73421f2a48e6 clk: renesas: r8a779f0: Add P=
FC clock)
Merging clk-samsung/for-next (45bd8166a1d8 clk: samsung: Add initial Exynos=
7885 clock driver)
Merging csky/linux-next (a0793fdad9a1 csky: fix typo of fpu config macro)
Merging h8300/h8300-next (1ec10274d436 h8300: don't implement set_fs)
CONFLICT (modify/delete): arch/h8300/mm/memory.c deleted in h8300/h8300-nex=
t and modified in HEAD.  Version HEAD of arch/h8300/mm/memory.c left in tre=
e.
$ git rm -f arch/h8300/mm/memory.c
Merging m68k/for-next (0d52a01a266b m68k: defconfig: Disable fbdev on Sun3/=
3x)
Merging m68knommu/for-next (e6e1e7b19fa1 m68k: coldfire/device.c: only buil=
d for MCF_EDMA when h/w macros are defined)
Merging microblaze/next (fcc619621df5 microblaze/PCI: Remove pci_phys_mem_a=
ccess_prot() dead code)
Merging mips/mips-next (3f059a7e8c13 mips: remove reference to "newer Loong=
son-3")
Merging nios2/for-next (7f7bc20bc41a nios2: Don't use _end for calculating =
min_low_pfn)
Merging openrisc/for-next (862cf8d5fd98 openrisc/boot: Remove unnecessary i=
nitialisation in memcpy().)
Merging parisc-hd/for-next (d21d3f34cf6e parisc/unaligned: Enhance user-spa=
ce visible output)
CONFLICT (content): Merge conflict in arch/parisc/lib/memcpy.c
Merging powerpc/next (1a76e520ee18 powerpc/64e: Tie PPC_BOOK3E_64 to PPC_FS=
L_BOOK3E)
Merging soc-fsl/next (1ce93cb102e7 soc: fsl: qe: Check of ioremap return va=
lue)
Merging risc-v/for-next (d56201d9440d riscv: defconfig: enable hugetlbfs op=
tion)
Merging s390/for-next (e32b16884708 Merge branch 'features' into for-next)
Merging sh/for-next (8518e694203d sh: pgtable-3level: Fix cast to pointer f=
rom integer of different size)
Merging sparc-next/master (dd0d718152e4 Merge tag 'spi-fix-v5.8-rc2' of git=
://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi)
Merging uml/linux-next (db0dd9cee822 um: virtio_uml: Allow probing from dev=
icetree)
Merging xtensa/xtensa-for-next (5b835d4cade1 xtensa: use XCHAL_NUM_AREGS as=
 pt_regs::areg size)
Merging pidfd/for-next (d52c14f5f9b3 Merge branch 'pidfd.fd_install' into f=
or-next)
Merging fscrypt/master (cdaa1b1941f6 fscrypt: update documentation for dire=
ct I/O support)
Merging fscache/fscache-next (3cb8fe4cadd5 netfs: Change the docs to match =
the renaming)
Merging afs/afs-next (26291c54e111 Linux 5.17-rc2)
Merging btrfs/for-next (77848115626f Merge branch 'for-next-current-v5.16-2=
0220308' into for-next-20220308)
Merging ceph/master (ad5255c1ea9c ceph: misc fix for code style and logs)
Merging cifs/for-next (0ad98124279a Adjust cifssb maximum read size)
Merging configfs/for-next (84ec758fb2da configfs: fix a race in configfs_{,=
un}register_subsystem())
Merging ecryptfs/next (682a8e2b41ef Merge tag 'ecryptfs-5.13-rc1-updates' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/tyhicks/ecryptfs)
Merging erofs/dev (5e397957c517 erofs: clean up preload_compressed_pages())
Merging exfat/dev (dd81e1c7d5fb Merge tag 'powerpc-5.17-2' of git://git.ker=
nel.org/pub/scm/linux/kernel/git/powerpc/linux)
Merging ext3/for_next (487606687984 Merge reiserfs deprecation patch.)
Merging ext4/dev (cc5095747edf ext4: don't BUG if someone dirty pages witho=
ut asking ext4 first)
Merging f2fs/dev (6c4d1a169863 f2fs: introduce F2FS_UNFAIR_RWSEM to support=
 unfair rwsem)
Merging fsverity/fsverity (07c99001312c fs-verity: support reading signatur=
e with ioctl)
Merging fuse/for-next (0c4bcfdecb1a fuse: fix pipe buffer lifetime for dire=
ct_io)
Merging gfs2/for-next (cf8da18f6c4d gfs2: Fix window size in should_fault_i=
n_pages)
Merging jfs/jfs-next (c48a14dca2cb JFS: fix memleak in jfs_mount)
Merging ksmbd/ksmbd-for-next (1a927cda94ac Documentation: ksmbd: update Fea=
ture Status table)
Merging nfs/linux-next (6c984083ec24 NFS: Use of mapping_set_error() result=
s in spurious errors)
Merging nfs-anna/linux-next (d19e0183a883 NFS: Do not report writeback erro=
rs in nfs_getattr())
Merging nfsd/for-next (bf27a962851b fs/lock: only call lm_breaker_owns_leas=
e if there is conflict.)
Merging ntfs3/master (52e00ea6b26e fs/ntfs3: Update valid size if -EIOCBQUE=
UED)
Merging orangefs/for-next (40a74870b2d1 orangefs: Fix the size of a memory =
allocation in orangefs_bufmap_alloc())
Merging overlayfs/overlayfs-next (94fd19752b28 ovl: don't fail copy up if n=
o fileattr support on upper)
Merging ubifs/next (aa39cc675799 jffs2: GC deadlock reading a page that is =
used in jffs2_write_begin())
Merging v9fs/9p-next (22e424feb665 Revert "fs/9p: search open fids first")
Merging xfs/for-next (b97cca3ba909 xfs: only bother with sync_filesystem du=
ring readonly remount)
Merging zonefs/for-next (95b115332a83 zonefs: remove redundant null bio che=
ck)
Merging iomap/iomap-for-next (ebb7fb1557b1 xfs, iomap: limit individual ioe=
nd chain lengths in writeback)
Merging djw-vfs/vfs-for-next (2d86293c7075 xfs: return errors in xfs_fs_syn=
c_fs)
Merging file-locks/locks-next (80d8e4d3f313 fs/locks: fix fcntl_getlk64/fcn=
tl_setlk64 stub prototypes)
Merging vfs/for-next (124f75f864f3 clean overflow checks in count_mounts() =
a bit)
CONFLICT (content): Merge conflict in arch/x86/um/Kconfig
Merging printk/for-next (c5f75d490fc2 Merge branch 'for-5.18' into for-next)
Merging pci/next (b3c57902bef6 Merge branch 'remotes/lorenzo/pci/uniphier')
Merging pstore/for-next/pstore (023bbde3db41 pstore: Add prefix to ECC mess=
ages)
Merging hid/for-next (cde4b57a1c51 Merge branch 'for-5.17/upstream-fixes' i=
nto for-next)
Merging i2c/i2c/for-next (867dfe1041a0 Merge branch 'i2c/for-mergewindow' i=
nto i2c/for-next)
Merging i3c/i3c/next (6cbf8b38dfe3 i3c: fix uninitialized variable use in i=
2c setup)
Merging dmi/dmi-for-next (f97a2103f1a7 firmware: dmi: Move product_sku info=
 to the end of the modalias)
Merging hwmon-staging/hwmon-next (5d4a2ea96b79 hwmon: (axi-fan-control) Use=
 hwmon_notify_event)
Merging jc_docs/docs-next (0d6356d6cdd0 docs: fix 'make htmldocs' warning i=
n perf)
Merging v4l-dvb/master (2b891d3980f6 media: xilinx: csi2rxss: Use mipi-csi2=
.h)
Merging v4l-dvb-next/master (b3627647f9ea Merge tag 'br-v5.18s' of git://li=
nuxtv.org/hverkuil/media_tree into media_stage)
Merging pm/linux-next (8a43cf068643 Merge branch 'thermal-hfi' into linux-n=
ext)
Merging cpufreq-arm/cpufreq/arm/linux-next (72951a77c00f cpufreq: blocklist=
 Qualcomm sc8280xp and sa8540p in cpufreq-dt-platdev)
Merging cpupower/cpupower (8382dce5e483 cpupower: Add "perf" option to prin=
t AMD P-State information)
Merging devfreq/devfreq-next (26291c54e111 Linux 5.17-rc2)
Merging opp/opp/linux-next (f48a0c475c2a Documentation: EM: Describe new re=
gistration method using DT)
Merging thermal/thermal/linux-next (a7da8a0955cb MAINTAINERS: thermal: sams=
ung: update Krzysztof Kozlowski's email)
Merging ieee1394/for-next (54b3bd99f094 firewire: nosy: switch from 'pci_' =
to 'dma_' API)
Merging dlm/next (feae43f8aa88 fs: dlm: print cluster addr if non-cluster n=
ode connects)
Merging rdma/for-next (73f7e05609ec RDMA/hns: Refactor the alloc_cqc())
Merging net-next/master (d307eab593b2 Merge branch 'net-phy-lan87xx-use-gen=
phy_read_master_slave-function')
CONFLICT (content): Merge conflict in drivers/hwmon/adt7310.c
CONFLICT (content): Merge conflict in drivers/staging/gdm724x/gdm_lte.c
CONFLICT (content): Merge conflict in net/dsa/dsa2.c
Merging bpf-next/for-next (7fd9fd46a459 tools: Fix unavoidable GCC call in =
Clang builds)
Merging ipsec-next/master (2ecda181682e xfrm: delete duplicated functions t=
hat calls same xfrm_api_check())
Merging mlx5-next/mlx5-next (45fee8edb4b3 net/mlx5: Add clarification on sy=
nc reset failure)
Merging netfilter-next/master (c828414ac935 netfilter: nft_compat: suppress=
 comment match)
Merging ipvs-next/master (c828414ac935 netfilter: nft_compat: suppress comm=
ent match)
Merging bluetooth/master (035e54ae7b1d Bluetooth: mgmt: remove redundant as=
signment to variable cur_len)
Merging wireless-next/main (e715f10f3d05 rtw89: get channel parameters of 1=
60MHz bandwidth)
CONFLICT (content): Merge conflict in net/mac80211/mlme.c
Merging mtd/mtd/next (2365f91c861c mtd: parsers: trx: allow to use on Media=
Tek MIPS SoCs)
Merging nand/nand/next (ffb16c1c4267 mtd: rawnand: stm32_fmc2: Add NAND Wri=
te Protect support)
CONFLICT (content): Merge conflict in Documentation/devicetree/bindings/mtd=
/nand-controller.yaml
Merging spi-nor/spi-nor/next (151c6b49d679 mtd: spi-nor: Skip erase logic w=
hen SPI_NOR_NO_ERASE is set)
Merging crypto/master (280ee3c3aaa8 crypto: octeontx2 - fix missing unlock)
Merging drm/drm-next (6de7e4f02640 Merge tag 'drm-msm-next-2022-03-01' of h=
ttps://gitlab.freedesktop.org/drm/msm into drm-next)
CONFLICT (modify/delete): Documentation/devicetree/bindings/display/mediate=
k/mediatek,disp.txt deleted in drm/drm-next and modified in HEAD.  Version =
HEAD of Documentation/devicetree/bindings/display/mediatek/mediatek,disp.tx=
t left in tree.
$ git rm -f Documentation/devicetree/bindings/display/mediatek/mediatek,dis=
p.txt
Applying: fix up for "media: dt-binding: mediatek: Get rid of mediatek,larb=
 for multimedia HW"
Applying: fix up for "spi: make remove callback a void function"
Merging drm-misc/for-linux-next (07f380da3ebd drm/panel: simple: Fix Innolu=
x G070Y2-L01 BPP settings)
Merging amdgpu/drm-next (4a7e452774c1 drm/radeon: Add HD-audio component no=
tifier support (v2))
Merging drm-intel/for-linux-next (4546281e8ab2 Merge tag 'gvt-next-2022-03-=
07' of https://github.com/intel/gvt-linux into drm-intel-next-fixes)
Merging drm-tegra/drm/tegra/for-next (b53c24f69199 drm/tegra: Support YVYU,=
 VYUY and YU24 formats)
Merging drm-msm/msm-next (aaa743d838da drm/msm/adreno: fix cast in adreno_g=
et_param())
Merging imx-drm/imx-drm/next (20fbfc81e390 drm/imx: imx-tve: Make use of th=
e helper function devm_platform_ioremap_resource())
Merging etnaviv/etnaviv/next (cdd156955f94 drm/etnaviv: consider completed =
fence seqno in hang check)
Merging fbdev/for-next (a58c22cfbbf6 video: fbdev: omapfb: Add missing of_n=
ode_put() in dvic_probe_of)
Merging regmap/for-next (2d2329787ba2 regmap: irq: cleanup comments)
Merging sound/for-next (fc4cf4293f0d ALSA: x86: Use standard mmap helper fo=
r Intel HDMI LPE audio)
Merging sound-asoc/for-next (0b7daa6bd0a4 Merge remote-tracking branch 'aso=
c/for-5.18' into asoc-next)
Merging modules/modules-next (719fce7539cd Merge tag 'soc-fixes-5.17-2' of =
git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc)
Merging input/next (f28af984e771 Input: mt6779-keypad - add MediaTek keypad=
 driver)
Merging block/for-next (5bef72001c62 Merge branch 'for-5.18/alloc-cleanups'=
 into for-next)
CONFLICT (content): Merge conflict in drivers/block/virtio_blk.c
CONFLICT (content): Merge conflict in fs/iomap/direct-io.c
$ git reset --hard HEAD^
Merging next-20220308 version of block
CONFLICT (content): Merge conflict in drivers/block/virtio_blk.c
CONFLICT (content): Merge conflict in fs/iomap/direct-io.c
[master f0476306c7d1] next-20220308/block
Merging device-mapper/for-next (37c3f24df8a1 dm thin: use dm_submit_bio_rem=
ap)
Merging libata/for-next (5e776d7b20f0 ata: Drop commas after OF match table=
 sentinels)
Merging pcmcia/pcmcia-next (3928cf08334e pcmcia: db1xxx_ss: restrict to MIP=
S_DB1XXX boards)
Merging mmc/next (52c92286b71e mmc: dw-mmc-rockchip: Fix handling invalid c=
lock rates)
Merging mfd/for-mfd-next (022bd5cae497 mfd: intel-lpss: Provide an SSP type=
 to the driver)
CONFLICT (content): Merge conflict in Documentation/devicetree/bindings/soc=
/samsung/exynos-usi.yaml
Merging backlight/for-backlight-next (ec961cf32411 backlight: qcom-wled: Re=
spect enabled-strings in set_brightness)
Merging battery/for-next (75853406fa27 power: supply: Add a driver for Injo=
inic power bank ICs)
Merging regulator/for-next (7d37c5592332 Merge remote-tracking branch 'regu=
lator/for-5.18' into regulator-next)
Merging security/next-testing (047843bdb316 Merge branch 'landlock_lsm_v34'=
 into next-testing)
Merging apparmor/apparmor-next (c2489617b3b9 apparmor: Fix undefined refere=
nce to `zlib_deflate_workspacesize')
Merging integrity/next-integrity (cd3bc044af48 KEYS: encrypted: Instantiate=
 key with user-provided decrypted data)
Merging keys/keys-next (2d743660786e Merge branch 'fixes' of git://git.kern=
el.org/pub/scm/linux/kernel/git/viro/vfs)
Merging safesetid/safesetid-next (1b8b71922919 LSM: SafeSetID: Mark safeset=
id_initialized as __initdata)
Merging selinux/next (cdbec3ede0b8 selinux: shorten the policy capability e=
num names)
Merging smack/next (a5cd1ab7ab67 Fix incorrect type in assignment of ipv6 p=
ort for audit)
Merging tomoyo/master (b9c20da356db workqueue: Warn flushing of kernel-glob=
al workqueues)
Merging tpmdd/next (f4fe76112c8f tpm: use try_get_ops() in tpm-space.c)
Merging watchdog/master (cfb92440ee71 Linux 5.17-rc5)
Merging iommu/next (e17c6debd4b2 Merge branches 'arm/mediatek', 'arm/msm', =
'arm/renesas', 'arm/rockchip', 'arm/smmu', 'x86/vt-d' and 'x86/amd' into ne=
xt)
Merging audit/next (272ceeaea355 audit: log AUDIT_TIME_* records only from =
rules)
Merging devicetree/for-next (17bf6b7c7835 dt-bindings: firmware: arm,scpi: =
Add missing maxItems to mboxes/shmem)
Merging mailbox/mailbox-for-next (869b6ca39c08 dt-bindings: mailbox: Add mo=
re protocol and client ID)
Merging spi/for-next (064017096835 Merge remote-tracking branch 'spi/for-5.=
18' into spi-next)
CONFLICT (modify/delete): arch/arm/mach-pxa/stargate2.c deleted in HEAD and=
 modified in spi/for-next.  Version spi/for-next of arch/arm/mach-pxa/starg=
ate2.c left in tree.
$ git rm -f arch/arm/mach-pxa/stargate2.c
Merging tip/auto-latest (7b03446f992d Merge x86/urgent into tip/master)
CONFLICT (content): Merge conflict in drivers/iommu/intel/iommu.c
Merging clockevents/timers/drivers/next (49c14f94ccfe clocksource/drivers/t=
imer-of: check return value of of_iomap in timer_of_base_init())
Merging edac/edac-for-next (1e2e0e53092b Merge branch 'edac-amd64' into eda=
c-for-next)
Merging irqchip/irq/irqchip-next (409f87333182 Merge branch irq/aic-pmu int=
o irq/irqchip-next)
Merging ftrace/for-next (864ea0e10cc9 user_events: Add documentation file)
Merging rcu/rcu/next (1498a74770d7 torture: Enable CSD-lock stall reports f=
or scftorture)
CONFLICT (content): Merge conflict in kernel/rcu/tree_plugin.h
Merging kvm/next (4a204f789587 KVM: SVM: Allow AVIC support on system w/ ph=
ysical APIC ID > 255)
Merging kvm-arm/next (947a4a402d9d Merge branch kvm-arm64/misc-5.18 into kv=
marm-master/next)
Merging kvms390/next (032884362e9e KVM: s390x: fix SCK locking)
Merging xen-tip/linux-next (f66edf684edc xen/pci: Make use of the helper ma=
cro LIST_HEAD())
Merging percpu/for-next (4e1f82dce05b Merge branch 'for-5.16-fixes' into fo=
r-next)
Merging workqueues/for-next (bc35f7ef9628 workqueue: Convert the type of po=
ol->nr_running to int)
Merging drivers-x86/for-next (e1c21608e3cf platform/x86: thinkpad_acpi: Add=
 PSC mode support)
CONFLICT (content): Merge conflict in drivers/platform/x86/thinkpad_acpi.c
Merging chrome-platform/for-next (b579f139e470 platform/chrome: cros_ec_typ=
ec: Update mux flags during partner removal)
Merging hsi/for-next (e783362eb54c Linux 5.17-rc1)
Merging leds/for-next (e26557a0aa68 leds: pca955x: Allow zero LEDs to be sp=
ecified)
Merging ipmi/for-next (f4676c8ec396 ipmi: kcs: aspeed: Remove old bindings =
support)
Merging driver-core/driver-core-next (4a248f85b3dd Merge 5.17-rc6 into driv=
er-core-next)
CONFLICT (content): Merge conflict in drivers/power/supply/ab8500_chargalg.c
Merging usb/usb-next (98d107b84614 usb: host: xhci: Remove some unnecessary=
 return value initializations)
CONFLICT (content): Merge conflict in arch/arm64/boot/dts/qcom/ipq6018.dtsi
CONFLICT (content): Merge conflict in arch/arm64/boot/dts/xilinx/zynqmp.dtsi
Merging usb-gadget/next (e49d033bddf5 Linux 5.12-rc6)
Merging usb-serial/usb-next (4ac56b1f1ef8 USB: serial: usb_wwan: remove red=
undant assignment to variable i)
Merging usb-chipidea-next/for-usb-next (78665f57c3fa usb: chipidea: udc: ma=
ke controller hardware endpoint primed)
Merging tty/tty-next (3631e48df0db serial: samsung: Add samsung_early_read =
to support early kgdboc)
CONFLICT (content): Merge conflict in MAINTAINERS
Merging char-misc/char-misc-next (3dd9a926ec23 mmc: rtsx: Fix build errors/=
warnings for unused variable)
CONFLICT (content): Merge conflict in MAINTAINERS
Merging extcon/extcon-next (7f3e22d68905 extcon: Fix some kernel-doc commen=
ts)
CONFLICT (content): Merge conflict in drivers/power/supply/max8997_charger.c
Merging gnss/gnss-next (26291c54e111 Linux 5.17-rc2)
Merging phy-next/next (c6455af54899 phy: qcom-qmp: add sc8280xp UFS PHY)
CONFLICT (modify/delete): Documentation/devicetree/bindings/phy/qcom,usb-hs=
-phy.txt deleted in phy-next/next and modified in HEAD.  Version HEAD of Do=
cumentation/devicetree/bindings/phy/qcom,usb-hs-phy.txt left in tree.
$ git rm -f Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.txt
Applying: merge fix for "dt-bindings: phy: qcom,usb-hs-phy: add MSM8226 com=
patible"
Merging soundwire/next (266fa94673d3 soundwire: qcom: use __maybe_unused fo=
r swrm_runtime_resume())
Merging thunderbolt/next (144c4a77a3e1 thunderbolt: Rename EEPROM handling =
bits to match USB4 spec)
Merging vfio/next (8d26c4328b46 PCI/IOV: Fix wrong kernel-doc identifier)
Merging staging/staging-next (b25c7dc13fb8 staging: rts5208: fix Lines shou=
ld not end with a '('.)
CONFLICT (content): Merge conflict in drivers/staging/fbtft/fbtft.h
Merging iio/togreg (0bf126163c3e iio: adc: xilinx-ams: Fix single channel s=
witching sequence)
CONFLICT (content): Merge conflict in .mailmap
CONFLICT (content): Merge conflict in drivers/iio/accel/fxls8962af-core.c
Merging mux/for-next (0fcfb00b28c0 Linux 5.16-rc4)
Merging icc/icc-next (52c85167e413 Merge branch 'icc-msm8939' into icc-next)
Merging dmaengine/next (ea7c8f598c32 dmaengine: idxd: restore traffic class=
 defaults after wq reset)
Merging cgroup/for-next (88ea791b5665 Merge branch 'for-5.17-fixes' into fo=
r-next)
Merging scsi/for-next (f6de306274ab Merge branch 'misc' into for-next)
CONFLICT (content): Merge conflict in block/blk-lib.c
CONFLICT (content): Merge conflict in block/blk-merge.c
CONFLICT (content): Merge conflict in drivers/block/drbd/drbd_worker.c
CONFLICT (content): Merge conflict in drivers/block/rnbd/rnbd-clt.c
Merging scsi-mkp/for-next (2bd3b6b75946 scsi: ufs: core: scsi_get_lba() err=
or fix)
Merging vhost/linux-next (20c76355f915 crypto: virtio - Select new dependen=
cies)
Merging rpmsg/for-next (c060cc0014c9 Merge branch 'rproc-next' into for-nex=
t)
Merging gpio/for-next (7ac554888233 MAINTAINERS: Remove reference to non-ex=
isting file)
Merging gpio-brgl/gpio/for-next (243cfa6a6782 gpiolib: Use list_first_entry=
()/list_last_entry())
Merging gpio-intel/for-next (a1ce76e89907 gpio: tps68470: Allow building as=
 module)
Merging gpio-sim/gpio/gpio-sim (0fcfb00b28c0 Linux 5.16-rc4)
Merging pinctrl/for-next (842366d7cb68 Merge branch 'devel' into for-next)
Merging pinctrl-intel/for-next (d25478e1d8f9 pinctrl: icelake: Add Ice Lake=
-N PCH pin controller support)
Merging pinctrl-renesas/renesas-pinctrl (babe298e9caa pinctrl: renesas: r8a=
779f0: Add Ethernet pins, groups, and functions)
Merging pinctrl-samsung/for-next (3652dc070bad pinctrl: samsung: improve wa=
ke irq info on console)
Merging pwm/for-next (ed14d36498c8 pwm: rcar: Simplify multiplication/shift=
 logic)
Merging userns/for-next (69915559aac4 Merge of prlimit-tasklist_lock-for-v5=
.18, per-namespace-ipc-sysctls-for-v5.18, and coredump-vma-snapshot-fix-for=
-v5.18 for testing in linux-next)
Merging ktest/for-next (170f4869e662 ktest.pl: Fix the logic for truncating=
 the size of the log file for email)
Merging kselftest/next (f6d344cd5fa6 selftests: Fix build when $(O) points =
to a relative path)
Merging livepatching/for-next (b44a7f076ce1 Merge branch 'for-5.18/selftest=
s-fixes' into for-next)
Merging coresight/next (b54f53bc11a5 coresight: Drop unused 'none' enum val=
ue for each component)
Merging rtc/rtc-next (5e086367298d rtc: wm8350: Handle error for wm8350_reg=
ister_irq)
Merging nvdimm/libnvdimm-for-next (2166a9974902 dax: make sure inodes are f=
lushed before destroy cache)
Merging at24/at24/for-next (e783362eb54c Linux 5.17-rc1)
Merging ntb/ntb-next (d2bda1500aa8 IDT: Fix Build warnings on some 32bit ar=
chitectures.)
Merging seccomp/for-next/seccomp (eed09ad26182 samples/seccomp: Adjust samp=
le to also provide kill option)
Merging cisco/for-next (9e98c678c2d6 Linux 5.1-rc1)
Merging fsi/next (f2af60bb7ce2 fsi: Add trace events in initialization path)
Merging slimbus/for-next (e783362eb54c Linux 5.17-rc1)
Merging nvmem/for-next (bdf79b27260b dt-bindings: nvmem: brcm,nvram: add ba=
sic NVMEM cells)
CONFLICT (add/add): Merge conflict in Documentation/devicetree/bindings/nvm=
em/sunplus,sp7021-ocotp.yaml
CONFLICT (content): Merge conflict in MAINTAINERS
Merging xarray/main (22f56b8e890d XArray: Include bitmap.h from xarray.h)
Merging hyperv/hyperv-next (eeda29db98f4 x86/hyperv: Output host build info=
 as normal Windows version number)
Merging auxdisplay/auxdisplay (9ed331f8a0fb auxdisplay: lcd2s: Use proper A=
PI to free the instance of charlcd object)
Merging kgdb/kgdb/for-next (b77dbc86d604 kdb: Adopt scheduler's task classi=
fication)
Merging hmm/hmm (6880fa6c5660 Linux 5.15-rc1)
Merging fpga/for-next (21f0a239ecab fpga: dfl: pci: Remove usage of the dep=
recated "pci-dma-compat.h" API)
Merging kunit/test (e783362eb54c Linux 5.17-rc1)
Merging cfi/cfi/next (e783362eb54c Linux 5.17-rc1)
Merging kunit-next/kunit (5debe5bfa02c list: test: Add a test for list_entr=
y_is_head())
Merging trivial/for-next (081c8919b02b Documentation: remove trivial tree)
Merging mhi/mhi-next (74fa3cd1db2a bus: mhi: ep: Add uevent support for mod=
ule autoloading)
Merging memblock/for-next (2a7ceac9e581 memblock tests: Fix testing with 32=
-bit physical addresses)
Merging init/init-user-pointers (38b082236e77 initramfs: use vfs_utimes in =
do_copy)
Merging counters/counters (e71ba9452f0b Linux 5.11-rc2)
Merging cxl/next (e6e17cc6ed75 cxl/core: Fix cxl_device_lock() class detect=
ion)
Merging folio-iomap/folio-iomap (4d7bd0eb72e5 iomap: Inline __iomap_zero_it=
er into its caller)
Merging zstd/zstd-next (88a309465b3f lib: zstd: clean up double word in com=
ment.)
Merging efi/next (e783362eb54c Linux 5.17-rc1)
Merging unicode/for-next (5298d4bfe80f unicode: clean up the Kconfig symbol=
 confusion)
Merging slab/for-next (1aa71e6ce480 Merge branch 'slab/for-5.18/cleanups' i=
nto slab/for-next)
Merging random/master (597ead139f93 random: make consistent usage of crng_r=
eady())
Merging landlock/next (7325fd5614aa Merge Landlock fixes into next)
Merging rust/rust-next (847245fe812e init/Kconfig: Specify the interpreter =
for rust-is-available.sh)
Merging sysctl/sysctl-next (fc12aa67daba kernel/do_mount_initrd: move real_=
root_dev sysctls to its own file)
CONFLICT (content): Merge conflict in include/linux/sched/sysctl.h
CONFLICT (content): Merge conflict in kernel/sysctl.c
Merging folio/for-next (0488343ba3dd selftests/vm/transhuge-stress: Support=
 file-backed PMD folios)
CONFLICT (modify/delete): arch/nds32/include/asm/pgtable.h deleted in HEAD =
and modified in folio/for-next.  Version folio/for-next of arch/nds32/inclu=
de/asm/pgtable.h left in tree.
CONFLICT (content): Merge conflict in drivers/gpu/drm/drm_cache.c
$ git rm -f arch/nds32/include/asm/pgtable.h
Merging execve/for-next/execve (14256a63a561 Merge branch 'coredump-vma-sna=
pshot-fix' of https://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user=
-namespace into for-next/execve)
Merging kspp/for-next/kspp (1b01a23d9a48 Merge branch 'for-next/hardening' =
into for-next/kspp)
Applying: Revert "platform/x86: thinkpad_acpi: Add PSC mode support"
Merging kspp-gustavo/for-next/kspp (91adfbb14c00 Merge branch 'for-next/ksp=
p-fam0' into for-next/kspp)
Merging akpm-current/current (a36f330518af ipc/mqueue: use get_tree_nodev()=
 in mqueue_get_tree())
CONFLICT (content): Merge conflict in Documentation/admin-guide/sysctl/kern=
el.rst
CONFLICT (modify/delete): arch/nds32/mm/init.c deleted in HEAD and modified=
 in akpm-current/current.  Version akpm-current/current of arch/nds32/mm/in=
it.c left in tree.
CONFLICT (content): Merge conflict in include/linux/sched/sysctl.h
CONFLICT (content): Merge conflict in lib/Kconfig.debug
CONFLICT (content): Merge conflict in mm/Kconfig
CONFLICT (content): Merge conflict in mm/huge_memory.c
CONFLICT (content): Merge conflict in mm/internal.h
CONFLICT (content): Merge conflict in mm/memcontrol.c
CONFLICT (content): Merge conflict in mm/memory-failure.c
CONFLICT (content): Merge conflict in mm/memory.c
CONFLICT (content): Merge conflict in mm/memremap.c
CONFLICT (content): Merge conflict in mm/rmap.c
CONFLICT (content): Merge conflict in mm/vmscan.c
CONFLICT (modify/delete): tools/testing/radix-tree/linux/gfp.h deleted in H=
EAD and modified in akpm-current/current.  Version akpm-current/current of =
tools/testing/radix-tree/linux/gfp.h left in tree.
$ git rm -f tools/testing/radix-tree/linux/gfp.h arch/nds32/mm/init.c
Applying: fix up for "tools: Move gfp.h and slab.h from radix-tree to lib"
$ git checkout -b akpm remotes/origin/akpm/master
$ git rebase --onto master remotes/origin/akpm/master-base
Merging akpm/master (917bb9458c6a kselftest/vm: override TARGETS from argum=
ents)

--Sig_/aZzfr_PzcvnOJS4QvlNR/Ks
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIolU0ACgkQAVBC80lX
0GwaUQf+MouKfzbRtQXwdCq95DxT7e+j+XsUWFuq06Dz1I78cuBvEXHbjsjaF+ZU
7i4VJShe00VifTKqGmV2dvJlBmfXbroR5L+nwHc/WRGKiWjiKxhvDOSNTfTBXLeu
cQIuaOgIEgoc8YaU5EO5v7I0Sasz/2z5/5bQDD5lIL1bsfrmnjsz8USYVRi0DeYm
jhASBwFzNtXzYLnjQBiFXLPB+D1HCTDw0jbeTLmsccS8PI0/9divCMsArBlY6qwg
QBW9M45t3jLF+I3c3fOBcfPrRGiNniBjph+phzIdluq3obDJSucANCkxrJ4DBC7d
ZXh4kDktEnz0zD6F3+5VwlHfkUqjEQ==
=R/d1
-----END PGP SIGNATURE-----

--Sig_/aZzfr_PzcvnOJS4QvlNR/Ks--
