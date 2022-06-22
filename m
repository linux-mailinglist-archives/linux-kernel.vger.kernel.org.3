Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 008EF5543E4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 10:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353744AbiFVHqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 03:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiFVHqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 03:46:15 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005CD1EEC3;
        Wed, 22 Jun 2022 00:46:11 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LSb6V3FTrz4xZb;
        Wed, 22 Jun 2022 17:46:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1655883970;
        bh=JyR7+a2HfLmir0k9tnpgYr+Nys9thKlTrzQxbD2Jibw=;
        h=Date:From:To:Cc:Subject:From;
        b=HnKOvdd0iKuGcYrZCLrRfsOXflHQUGY5Kd1uDNjZh8RuDZT/o72y2Ku6its6kr5PY
         lt4QGu8COuUjcUtVFr+Z9tSKT89TYycXyJ673M6zxY3HkRNiMh3CT9HXWXrrgWGdeT
         YgIrMbg9EJWsRuHipkkJjmvOBjKmYjvxEBUtHar/r7TNB6EfvG4zNEPpq/c1Upch46
         rkX2bwpaL98dRHHGiCSbPhuG3ru17X6wj5GsFe+R5K9+lkWnm9K2nwHvu9iCOS5ZDp
         zaH50fU41/4xJPJU7XiOMT5u9Rs/DHkpSQ1MSHsIY3jOg/6ZNXl0jM8dKuEqZLR4DE
         2pBHDCR16s3Sg==
Date:   Wed, 22 Jun 2022 17:46:09 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Jun 22
Message-ID: <20220622174609.5fa177d7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/eLvO8/vIe/Hpoo+sjY25IpR";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,LOCALPART_IN_SUBJECT,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/eLvO8/vIe/Hpoo+sjY25IpR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20220621:

The drm-misc tree lost its build failure, but gained (exposed) another
so I used the version from next-20220620.

The battery tree still had its build failure so I used the version from
next-20220617.

The mm tree lost its build failures but gained a conflict against the
folio tree.  It also gained another build failure for which I applied
a patch.

The amdgpu tree still had its build failure, so I used the
version from next-20220601 again.

Non-merge commits (relative to Linus' tree): 4371
 4917 files changed, 254950 insertions(+), 80589 deletions(-)

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
Merging origin/master (ca1fdab7fd27 Merge tag 'efi-urgent-for-v5.19-1' of g=
it://git.kernel.org/pub/scm/linux/kernel/git/efi/efi)
Merging fixes/fixes (d06c942efea4 Merge tag 'for_linus' of git://git.kernel=
.org/pub/scm/linux/kernel/git/mst/vhost)
Merging mm-hotfixes/mm-hotfixes-unstable (3f2cc95a65b9 mm: userfaultfd: fix=
 UFFDIO_CONTINUE on fallocated shmem pages)
Merging kbuild-current/fixes (291810be4227 Documentation/llvm: Update Suppo=
rted Arch table)
Merging arc-current/for-curr (f978e8023f33 ARC: bitops: Change __fls to ret=
urn unsigned long)
Merging arm-current/fixes (3cfb30199796 ARM: 9197/1: spectre-bhb: fix loop8=
 sequence for Thumb2)
Merging arm64-fixes/for-next/fixes (c50f11c6196f arm64: mm: Don't invalidat=
e FROM_DEVICE buffers at start of DMA transfer)
Merging arm-soc-fixes/arm/fixes (5e93207e962a bus: bt1-axi: Don't print err=
or on -EPROBE_DEFER)
Merging drivers-memory-fixes/fixes (1332661e0930 memory: samsung: exynos542=
2-dmc: Fix refcount leak in of_get_dram_timings)
Merging tee-fixes/fixes (98268f2a2a9f Merge branch 'optee_ffa_probe_fix_for=
_v5.18' into fixes)
Merging m68k-current/for-linus (30b5e6ef4a32 m68k: atari: Make Atari ROM po=
rt I/O write macros return void)
Merging powerpc-fixes/fixes (7bc08056a6da powerpc/rtas: Allow ibm,platform-=
dump RTAS call with null buffer address)
Merging s390-fixes/fixes (f2906aa86338 Linux 5.19-rc1)
Merging sparc/master (05a59d79793d Merge git://git.kernel.org:/pub/scm/linu=
x/kernel/git/netdev/net)
Merging fscrypt-current/for-stable (80f6e3080bfc fs-verity: fix signed inte=
ger overflow with i_size near S64_MAX)
Merging net/master (69135c572d1f net/tls: fix tls_sk_proto_close executed r=
epeatedly)
Merging bpf/master (a2b1a5d40bd1 net/sched: sch_netem: Fix arithmetic in ne=
tem_dump() for 32-bit platforms)
Merging ipsec/master (f85daf0e7253 xfrm: xfrm_policy: fix a possible double=
 xfrm_pols_put() in xfrm_bundle_lookup())
Merging netfilter/master (7fb0269720d7 Merge tag 'for-net-2022-05-23' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth)
Merging ipvs/master (7fb0269720d7 Merge tag 'for-net-2022-05-23' of git://g=
it.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth)
Merging wireless/for-next (c2b3a0759c76 dt-bindings: net: wireless: ath11k:=
 change Kalle's email)
Merging rdma-fixes/for-rc (118f767413ad RDMA/qedr: Fix reporting QP timeout=
 attribute)
Merging sound-current/for-linus (36a38c53b4ee ALSA: hda: Fix discovery of i=
915 graphics PCI device)
Merging sound-asoc-fixes/for-linus (e6fc5297c7b0 Merge remote-tracking bran=
ch 'asoc/for-5.18' into asoc-linus)
Merging regmap-fixes/for-linus (2a166929bc0a regmap: Wire up regmap_config =
provided bulk write in missed functions)
Merging regulator-fixes/for-linus (122e951eb804 regulator: qcom_smd: correc=
t MP5496 ranges)
Merging spi-fixes/for-linus (419bc8f681a0 spi: rockchip: Unmask IRQ at the =
final to avoid preemption)
Merging pci-current/for-linus (a2b36ffbf5b6 x86/PCI: Revert "x86/PCI: Clip =
only host bridge windows for E820 regions")
Merging driver-core.current/driver-core-linus (f2906aa86338 Linux 5.19-rc1)
Merging tty.current/tty-linus (a111daf0c53a Linux 5.19-rc3)
Merging usb.current/usb-linus (9ef165406308 usb: typec: wcove: Drop wrong d=
ependency to INTEL_SOC_PMIC)
Merging usb-gadget-fixes/fixes (e49d033bddf5 Linux 5.12-rc6)
Merging usb-serial-fixes/usb-linus (342fc0c3b345 USB: serial: option: add T=
elit LE910Cx 0x1250 composition)
Merging phy/fixes (9293ee00cc1c phy: ti: tusb1210: Don't check for write er=
rors when powering on)
Merging staging.current/staging-linus (a111daf0c53a Linux 5.19-rc3)
Merging iio-fixes/fixes-togreg (315f7e15c261 Merge tag 'iio-fixes-for-5.19a=
' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-mi=
sc-next)
Merging counter-fixes/fixes-togreg (f2906aa86338 Linux 5.19-rc1)
Merging char-misc.current/char-misc-linus (315f7e15c261 Merge tag 'iio-fixe=
s-for-5.19a' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio i=
nto char-misc-next)
Merging soundwire-fixes/fixes (f2906aa86338 Linux 5.19-rc1)
Merging thunderbolt-fixes/fixes (a111daf0c53a Linux 5.19-rc3)
Merging input-current/for-linus (6ab2e51898cd Input: soc_button_array - als=
o add Lenovo Yoga Tablet2 1051F to dmi_use_low_level_irq)
Merging crypto-current/master (abfed87e2a12 crypto: memneq - move into lib/)
Merging vfio-fixes/for-linus (1ef3342a934e vfio/pci: Fix vf_token mechanism=
 when device-specific VF drivers are used)
Merging kselftest-fixes/fixes (9b4d5c01eb23 selftests: make use of GUP_TEST=
_FILE macro)
Merging modules-fixes/modules-linus (7390b94a3c2d module: merge check_expor=
ted_symbol() into find_exported_symbol_in_section())
Merging dmaengine-fixes/fixes (a7cd3cf0b2e5 dmaengine: imx-sdma: Allow imx8=
m for imx7 FW revs)
Merging backlight-fixes/for-backlight-fixes (a38fd8748464 Linux 5.12-rc2)
Merging mtd-fixes/mtd/fixes (06781a502635 mtd: rawnand: gpmi: Fix setting b=
usy timeout setting)
Merging mfd-fixes/for-mfd-fixes (a61f4661fba4 mfd: intel_quark_i2c_gpio: Re=
vert "Constify static struct resources")
Merging v4l-dvb-fixes/fixes (d3daf73380ce media: dvb_vb2: fix possible out =
of bound access)
Merging reset-fixes/reset/fixes (03cb66463b55 dt-bindings: reset: Add paren=
t "resets" property as optional)
Merging mips-fixes/mips-fixes (3748d2185ac4 mips: lantiq: Add missing of_no=
de_put() in irq.c)
Merging at91-fixes/at91-fixes (0c640d9544d0 ARM: dts: at91: fix pinctrl pha=
ndles)
Merging omap-fixes/fixes (46ff3df87215 ARM: dts: logicpd-som-lv: Fix wrong =
pinmuxing on OMAP35)
Merging kvm-fixes/master (e0f3f46e4206 KVM: selftests: Restrict test region=
 to 48-bit physical addresses when using nested)
Merging kvms390-fixes/master (242c04f01377 KVM: s390: selftests: Use TAP in=
terface in the reset test)
Merging hwmon-fixes/hwmon (a111daf0c53a Linux 5.19-rc3)
Merging nvdimm-fixes/libnvdimm-fixes (d28820419ca3 cxl/pci: Drop shadowed v=
ariable)
Merging cxl-fixes/fixes (fae8817ae804 cxl/mem: Fix memory device capacity p=
robing)
Merging btrfs-fixes/next-fixes (5f414c4e30de Merge branch 'misc-5.19' into =
next-fixes)
Merging vfs-fixes/fixes (1c7c0f168f97 fix short copy handling in copy_mc_pi=
pe_to_iter())
Merging dma-mapping-fixes/for-linus (18a3c5f7abfd Merge tag 'for_linus' of =
git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost)
Merging i3c-fixes/i3c/fixes (fe07bfda2fb9 Linux 5.12-rc1)
Merging drivers-x86-fixes/fixes (d4fe9cc4ff86 platform/x86/intel: hid: Add =
Surface Go to VGBS allow list)
Merging samsung-krzk-fixes/fixes (c4c79525042a ARM: exynos: Fix refcount le=
ak in exynos_map_pmu)
Merging pinctrl-samsung-fixes/fixes (f2906aa86338 Linux 5.19-rc1)
Merging devicetree-fixes/dt/linus (0b9431c8221c dt-bindings: display: arm,m=
alidp: remove bogus RQOS property)
Merging dt-krzk-fixes/fixes (f2906aa86338 Linux 5.19-rc1)
Merging scsi-fixes/fixes (aeaadcde1a60 scsi: ibmvfc: Store vhost pointer du=
ring subcrq allocation)
Merging drm-fixes/drm-fixes (a111daf0c53a Linux 5.19-rc3)
Merging amdgpu-fixes/drm-fixes (2c409ba81be2 drm/radeon: fix si_enable_smc_=
cac() failed issue)
Merging drm-intel-fixes/for-linux-next-fixes (c7b28f52f406 drm/i915/display=
: Re-add check for low voltage sku for max dp source rate)
Merging mmc-fixes/fixes (89bcd9a64b84 mmc: mediatek: wait dma stop bit rese=
t to 0)
Merging rtc-fixes/rtc-fixes (bd33335aa93d rtc: cmos: Disable irq around dir=
ect invocation of cmos_interrupt())
Merging gnss-fixes/gnss-linus (a111daf0c53a Linux 5.19-rc3)
Merging hyperv-fixes/hyperv-fixes (49d6a3c062a1 x86/Hyper-V: Add SEV negoti=
ate protocol support in Isolation VM)
Merging soc-fsl-fixes/fix (4b0986a3613c Linux 5.18)
Merging risc-v-fixes/fixes (e83031564137 riscv: Fix ALT_THEAD_PMA's asm par=
ameters)
Merging risc-v-mc-fixes/dt-fixes (5e757deddd91 riscv: dts: microchip: re-ad=
d pdma to mpfs device tree)
Merging pidfd-fixes/fixes (03ba0fe4d09f file: simplify logic in __close_ran=
ge())
Merging fpga-fixes/fixes (f2906aa86338 Linux 5.19-rc1)
Merging spdx/spdx-linus (de0130355306 x86/crypto: Remove stray comment term=
inator)
Merging gpio-brgl-fixes/gpio/for-current (a01a40e33499 gpio: realtek-otto: =
Make the irqchip immutable)
Merging gpio-intel-fixes/fixes (b93a8b2c5161 gpio: dln2: make irq_chip immu=
table)
Merging pinctrl-intel-fixes/fixes (ba79c5e45eec MAINTAINERS: Update Intel p=
in control to Supported)
Merging erofs-fixes/fixes (8b1ac84dcf2c Documentation/ABI: sysfs-fs-erofs: =
Fix Sphinx errors)
Merging integrity-fixes/fixes (843385694721 evm: Fix a small race in init_d=
esc())
Merging kunit-fixes/kunit-fixes (f2906aa86338 Linux 5.19-rc1)
Merging ubifs-fixes/fixes (c3c07fc25f37 ubi: fastmap: Return error code if =
memory allocation fails in add_aeb())
Merging memblock-fixes/fixes (c94afc46cae7 memblock: use kfree() to release=
 kmalloced memblock regions)
Merging cel-fixes/for-rc (da9e94fe000e SUNRPC: Remove pointer type casts fr=
om xdr_get_next_encode_buffer())
Merging irqchip-fixes/irq/irqchip-fixes (4deb96e35c5c irqchip/gicv3: Handle=
 resource request failure consistently)
Merging renesas-fixes/fixes (432b52eea3dc ARM: shmobile: defconfig: Restore=
 graphical consoles)
Merging broadcom-fixes/fixes (0070ff32d9fc Merge branch 'maintainers/fixes'=
 into fixes)
Merging perf-current/perf/urgent (140cd9ec8fdd tools headers UAPI: Sync lin=
ux/prctl.h with the kernel sources)
Merging efi-fixes/urgent (aa6d1ed107eb efi/x86: libstub: Fix typo in __efi6=
4_argmap* name)
Merging zstd-fixes/zstd-linus (88a309465b3f lib: zstd: clean up double word=
 in comment.)
Merging battery-fixes/fixes (093d27bb6f2d power: supply: core: Fix boundary=
 conditions in interpolation)
Merging drm-misc-fixes/for-linux-next-fixes (be33d52ef5b4 drm: panel-orient=
ation-quirks: Add quirk for Aya Neo Next)
Merging kbuild/for-next (b13baccc3850 Linux 5.19-rc2)
Merging clang-format/clang-format (781121a7f6d1 clang-format: Fix space aft=
er for_each macros)
Merging perf/perf/core (9886142c7a22 Merge tag 'input-for-v5.19-rc1' of git=
://git.kernel.org/pub/scm/linux/kernel/git/dtor/input)
Merging compiler-attributes/compiler-attributes (7c00621dcaee compiler_type=
s: mark __compiletime_assert failure as __noreturn)
Merging dma-mapping/for-next (e15db62bc564 swiotlb: fix setting ->force_bou=
nce)
Merging asm-generic/master (6f1de1da8156 soc: qcom: geni: Disable MMIO trac=
ing for GENI SE)
Merging arc/for-next (f2906aa86338 Linux 5.19-rc1)
Merging arm/for-next (bafa10435c4f ARM: 9209/1: Spectre-BHB: avoid pr_info(=
) every time a CPU comes out of idle)
Merging arm64/for-next/core (a111daf0c53a Linux 5.19-rc3)
Merging arm-perf/for-next/perf (c5781212985a perf/arm-cmn: Decode CAL devic=
es properly in debugfs)
Merging arm-soc/for-next (3949559bf346 arm: document merges)
Merging actions/for-next (444d018d8d38 ARM: dts: owl-s500-roseapplepi: Add =
ATC2603C PMIC)
Merging amlogic/for-next (147c83586707 Merge branch 'v5.20/drivers' into fo=
r-next)
Merging aspeed/for-next (bfcbea2c93e5 ARM: dts: aspeed: nuvia: rename vendo=
r nuvia to qcom)
Merging at91/at91-next (3519476d99a4 Merge branch 'at91-dt' into at91-next)
Merging broadcom/next (d5a4ebb64049 Merge branch 'devicetree/next' into nex=
t)
Merging drivers-memory/for-next (44a5f0330d32 Merge branch 'mem-ctrl-next' =
into for-next)
Merging imx-mxs/for-next (8ba5923278b5 Merge branch 'imx/defconfig' into fo=
r-next)
Merging keystone/next (cb293d3b430e Merge branch 'for_5.15/drivers-soc' int=
o next)
Merging mediatek/for-next (c17a6281b45f Merge branch 'v5.19-next/soc' into =
for-next)
Merging mvebu/for-next (58ec0844bd13 Merge branch 'mvebu/dt64' into mvebu/f=
or-next)
Merging omap/for-next (b5418fc0478c Merge branch 'omap-for-v5.19/dt' into f=
or-next)
Merging qcom/for-next (5faa5cd718a4 Merge branches 'arm64-for-5.19', 'arm64=
-defconfig-for-5.19', 'clk-for-5.19', 'defconfig-for-5.19', 'drivers-for-5.=
19', 'dts-for-5.19' and 'arm64-fixes-for-5.18' into for-next)
Merging raspberrypi/for-next (c5915b53d4c2 dt-bindings: soc: bcm: Convert b=
rcm,bcm2835-vchiq to json-schema)
Merging renesas/next (64d15244c480 Merge branch 'renesas-dt-bindings-for-v5=
.20' into renesas-next)
Merging reset/reset/next (2ca065dc9468 dt-bindings: reset: st,sti-powerdown=
: Convert to yaml)
Merging rockchip/for-next (bee3751c8803 Merge branch 'v5.19-armsoc/socfixes=
' into for-next)
Merging samsung-krzk/for-next (bf4e96644efc Merge branch 'for-v5.20/exynos7=
885-emmc-clk' into for-next)
Merging scmi/for-linux-next (04dbc874a2f5 Merge branch 'for-next/scmi' of g=
it://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into for-li=
nux-next)
Merging stm32/stm32-next (3fc30e640f52 ARM: dts: stm32: add fake interrupt =
propoerty for ASync notif - TEMP/TO REMOVE)
Merging sunxi/sunxi/for-next (ba585a9e1791 Merge branch 'sunxi/dt-for-5.20'=
 into sunxi/for-next)
Merging tee/next (db30e53bf897 Merge branch 'tee_cleanup_for_v5.19' into ne=
xt)
Merging tegra/for-next (22cd13a29127 Merge branch for-5.20/arm64/defconfig =
into for-next)
Merging ti/ti-next (9b123c7c630c Merge branches 'ti-keystone-dts-next', 'ti=
-drivers-soc-next' and 'ti-k3-dts-next' into ti-next)
Merging xilinx/for-next (63623390c0d6 arm64: dts: zynqmp: add AMS driver to=
 device tree)
Merging clk/clk-next (71b8138dea9a Merge branch 'clk-ti-dt' into clk-next)
Merging clk-imx/for-next (c196175acdd3 clk: imx: clk-fracn-gppll: Add more =
freq config for video pll)
Merging clk-renesas/renesas-clk (080bcd8d5997 clk: renesas: r8a779f0: Add H=
SCIF clocks)
Merging clk-samsung/for-next (b35f27fe73d8 clk: samsung: exynosautov9: add =
cmu_peric1 clock support)
Merging csky/linux-next (64d83f067746 csky: Move $(core-y) into arch/csky/K=
build)
Merging loongarch/loongarch-next (b13baccc3850 Linux 5.19-rc2)
Merging m68k/for-next (bcc94f9a2581 m68k: sun3: Use __func__ to get functio=
n's name in an output message)
Merging m68knommu/for-next (8c6c2af9a4ed m68k: Fix syntax errors in comment=
s)
Merging microblaze/next (78b5f52ab6f6 microblaze: fix typos in comments)
Merging mips/mips-next (a111daf0c53a Linux 5.19-rc3)
Merging nios2/for-next (7f7bc20bc41a nios2: Don't use _end for calculating =
min_low_pfn)
Merging openrisc/for-next (83da38d82b2f openrisc: Allow power off handler o=
verriding)
Merging parisc-hd/for-next (1d0811b03eb3 parisc/stifb: Fix fb_is_primary_de=
vice() only available with CONFIG_FB_STI)
Merging powerpc/next (b13baccc3850 Linux 5.19-rc2)
Merging soc-fsl/next (4b0986a3613c Linux 5.18)
Merging risc-v/for-next (73448ae6204f RISC-V: Some Svpbmt fixes and cleanup=
s)
Merging risc-v-mc/dt-for-next (3f8ccf5f1a8c riscv: dts: microchip: remove s=
pi-max-frequency property)
Merging s390/for-next (f2906aa86338 Linux 5.19-rc1)
Merging sh/for-next (8518e694203d sh: pgtable-3level: Fix cast to pointer f=
rom integer of different size)
Merging sparc-next/master (dd0d718152e4 Merge tag 'spi-fix-v5.8-rc2' of git=
://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi)
Merging uml/linux-next (2a4a62a14be1 um: Fix out-of-bounds read in LDT setu=
p)
Merging xtensa/xtensa-for-next (a2d9b75b19dc xtensa: change '.bss' to '.sec=
tion .bss')
Merging pidfd/for-next (168f91289340 fs: account for group membership)
Merging fscrypt/master (218d921b581e fscrypt: add new helper functions for =
test_dummy_encryption)
Merging fscache/fscache-next (0885eacdc81f Merge tag 'nfsd-5.19-1' of git:/=
/git.kernel.org/pub/scm/linux/kernel/git/cel/linux)
Merging afs/afs-next (26291c54e111 Linux 5.17-rc2)
Merging btrfs/for-next (bcf40758bfd5 Merge branch 'for-next-next-v5.19-2022=
0617' into for-next-20220617)
Merging ceph/master (45d719fe7562 fscrypt: add fscrypt_context_for_new_inod=
e)
Merging cifs/for-next (f26578737294 cifs: periodically query network interf=
aces from server)
Merging configfs/for-next (84ec758fb2da configfs: fix a race in configfs_{,=
un}register_subsystem())
Merging ecryptfs/next (682a8e2b41ef Merge tag 'ecryptfs-5.13-rc1-updates' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/tyhicks/ecryptfs)
Merging erofs/dev (94f870f13595 MAINTAINERS: erofs: add myself as reviewer)
Merging exfat/dev (204e6ceaa103 exfat: use updated exfat_chain directly dur=
ing renaming)
Merging ext3/for_next (4bca7e80b645 init: Initialize noop_backing_dev_info =
early)
Merging ext4/dev (729e657ab8d4 ext4: fix a doubled word "need" in a comment)
Merging f2fs/dev (82c7863ed95d f2fs: do not count ENOENT for error case)
Merging fsverity/fsverity (e6af1bb07704 fs-verity: Use struct_size() helper=
 in enable_verity())
Merging fuse/for-next (6b49bc9d8a5f fuse: avoid unnecessary spinlock bump)
Merging gfs2/for-next (565f82b57abe gfs2: Rewrap overlong comment in do_pro=
mote)
Merging jfs/jfs-next (e471e5942c00 fs/jfs: Remove dead code)
Merging ksmbd/ksmbd-for-next (06ee1c0aebd5 ksmbd: smbd: Remove useless lice=
nse text when SPDX-License-Identifier is already used)
Merging nfs/linux-next (a111daf0c53a Linux 5.19-rc3)
Merging nfs-anna/linux-next (5ee3d10f84d0 NFSv4: Add FMODE_CAN_ODIRECT afte=
r successful open of a NFS4.x file)
Merging nfsd/for-next (b13baccc3850 Linux 5.19-rc2)
Merging ntfs3/master (f759942b72a9 fs/ntfs3: Add missing error check)
Merging orangefs/for-next (40a74870b2d1 orangefs: Fix the size of a memory =
allocation in orangefs_bufmap_alloc())
Merging overlayfs/overlayfs-next (bc70682a497c ovl: support idmapped layers)
Merging ubifs/next (8c03a1c21d72 ubi: ubi_create_volume: Fix use-after-free=
 when volume creation failed)
Merging v9fs/9p-next (b0017602fdf6 9p: fix EBADF errors in cached mode)
Merging xfs/for-next (e89ab76d7e25 xfs: preserve DIFLAG2_NREXT64 when setti=
ng other inode attributes)
Merging zonefs/for-next (31a644b3c2ae documentation: zonefs: Document sysfs=
 attributes)
Merging iomap/iomap-for-next (e9c3a8e820ed iomap: don't invalidate folios a=
fter writeback errors)
Merging djw-vfs/vfs-for-next (49df34221804 fs: fix an infinite loop in ioma=
p_fiemap)
Merging file-locks/locks-next (80d8e4d3f313 fs/locks: fix fcntl_getlk64/fcn=
tl_setlk64 stub prototypes)
Merging vfs/for-next (e9921ffd594f Merge branches 'work.namei', 'work.mount=
' and 'work.fd' into for-next)
Merging printk/for-next (e1d9d8011258 Merge branch 'rework/kthreads' into f=
or-next)
Merging pci/next (20ba3070acb6 Merge branch 'pci/ctrl/vmd')
Merging pstore/for-next/pstore (8126b1c73108 pstore: Don't use semaphores i=
n always-atomic-context code)
Merging hid/for-next (6c55e6cce170 Merge branch 'for-5.20/nintendo' into fo=
r-next)
Merging i2c/i2c/for-next (bc1801ec0931 Merge branch 'i2c/for-mergewindow' i=
nto i2c/for-next)
Merging i3c/i3c/next (f2906aa86338 Linux 5.19-rc1)
Merging dmi/dmi-for-next (f97a2103f1a7 firmware: dmi: Move product_sku info=
 to the end of the modalias)
Merging hwmon-staging/hwmon-next (c59ed392a4a3 hwmon: (dell-smm) Improve as=
sembly code)
Merging jc_docs/docs-next (387c67afccbb docs: arm: tcm: Fix typo in descrip=
tion of TCM and MMU usage)
Merging v4l-dvb/master (945a9a8e448b media: pvrusb2: fix memory leak in pvr=
_probe)
Merging v4l-dvb-next/master (945a9a8e448b media: pvrusb2: fix memory leak i=
n pvr_probe)
Merging pm/linux-next (4abf3e80fc98 Merge branch 'thermal-core' into linux-=
next)
Merging cpufreq-arm/cpufreq/arm/linux-next (c40bffd189af cpufreq: Add MT818=
6 to cpufreq-dt-platdev blocklist)
Merging cpupower/cpupower (f2906aa86338 Linux 5.19-rc1)
Merging devfreq/devfreq-next (9f3ec0f65421 PM / devfreq: mediatek: Introduc=
e MediaTek CCI devfreq driver)
Merging opp/opp/linux-next (27aaff9d8e89 OPP: Provide a simple implementati=
on to configure multiple clocks)
Merging thermal/thermal/linux-next (72b3fc61c752 thermal: k3_j72xx_bandgap:=
 Add the bandgap driver support)
Merging ieee1394/for-next (54b3bd99f094 firewire: nosy: switch from 'pci_' =
to 'dma_' API)
Merging dlm/next (8e51ec6146fd dlm: use kref_put_lock in __put_lkb)
Merging rdma/for-next (686141bc02f2 Merge branch 'mlx5-next' into wip/leon-=
for-next)
Merging net-next/master (8720bd951b8e Merge branch 'net-dsa-microchip-commo=
n-spi-probe-for-the-ksz-series-switches-part-1')
CONFLICT (content): Merge conflict in arch/arm64/boot/dts/rockchip/rk3568-b=
pi-r2-pro.dts
Merging bpf-next/for-next (d4609a5d8c70 bpf, arm64: Keep tail call count ac=
ross bpf2bpf calls)
Merging ipsec-next/master (0f9008e5c510 Merge  branch 'Be explicit with XFR=
M offload direction')
Merging mlx5-next/mlx5-next (cdcdce948d64 net/mlx5: Add bits and fields to =
support enhanced CQE compression)
Merging netfilter-next/master (677fb7525331 Merge git://git.kernel.org/pub/=
scm/linux/kernel/git/netdev/net)
Merging ipvs-next/master (677fb7525331 Merge git://git.kernel.org/pub/scm/l=
inux/kernel/git/netdev/net)
Merging bluetooth/master (d9cc9d78ca85 Bluetooth: mgmt: Fix refresh cached =
connection info)
Merging wireless-next/for-next (683a4647a7a3 wifi: rtw89: 8852a: rfk: fix d=
iv 0 exception)
Merging mtd/mtd/next (278811d5a7b2 mtd: parsers: scpart: add missing of_nod=
e_put() in scpart_parse())
Merging nand/nand/next (5278cc93a97f dt-bindings: mtd: qcom_nandc: document=
 qcom,boot-partitions binding)
Merging spi-nor/spi-nor/next (c47452194641 mtd: spi-nor: debugfs: fix forma=
t specifier)
Merging crypto/master (bffa1fc06589 crypto: hisilicon/sec - only HW V2 need=
s to change the BD err detection)
Merging drm/drm-next (0f95ee9a0c57 Merge tag 'drm-misc-next-2022-06-08' of =
git://anongit.freedesktop.org/drm/drm-misc into drm-next)
Merging drm-misc/for-linux-next (7c021558929f drm/nouveau/mmu: drop unexpec=
ted word "the" in the comments)
$ git reset --hard HEAD^
Merging next-20220620 version of drm-misc
CONFLICT (content): Merge conflict in include/uapi/linux/dma-buf.h
[master 3304460e24d5] next-20220620/drm-misc
Merging drm-intel/for-linux-next (6434cf630086 drm/i915/bios: calculate pan=
el type as per child device index in VBT)
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/display/intel_dm=
c_regs.h
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/display/intel_dp=
.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/gt/intel_rps.c
Merging drm-tegra/drm/tegra/for-next (fd27de58b0ad dt-bindings: display: te=
gra: Convert to json-schema)
Merging drm-msm/msm-next (24df12013853 MAINTAINERS: Add Dmitry as MSM DRM d=
river co-maintainer)
Merging drm-msm-lumag/msm-next-lumag (24c23f234c07 Merge branches 'msm-next=
-lumag-core', 'msm-next-lumag-dpu', 'msm-next-lumag-dp', 'msm-next-lumag-ds=
i', 'msm-next-lumag-hdmi', 'msm-next-lumag-mdp5' and 'msm-next-lumag-mdp4' =
into msm-next-lumag)
Merging imx-drm/imx-drm/next (927d8fd465ad drm/imx: ipuv3-plane: Remove red=
undant color encoding and range initialisation)
Merging etnaviv/etnaviv/next (2829a9fcb738 drm/etnaviv: reap idle softpin m=
appings when necessary)
Merging fbdev/for-next (5491424d17bd video: fbdev: simplefb: Check before c=
lk_put() not needed)
Merging regmap/for-next (1c6b27f701e8 Merge remote-tracking branch 'regmap/=
for-5.20' into regmap-next)
Merging sound/for-next (3809db6430bf ALSA: rawmidi: Take buffer refcount wh=
ile draining output)
Merging sound-asoc/for-next (cd08da60db98 Merge remote-tracking branch 'aso=
c/for-5.20' into asoc-next)
Merging modules/modules-next (7390b94a3c2d module: merge check_exported_sym=
bol() into find_exported_symbol_in_section())
Merging input/next (69cf890d8b28 Input: mtk-pmic-keys - move long press deb=
ounce mask to mtk_pmic_regs)
Merging block/for-next (89df7b51d65c Merge branch 'for-5.20/io_uring-cancel=
' into for-next)
Merging device-mapper/for-next (85e123c27d5c dm mirror log: round up region=
 bitmap size to BITS_PER_LONG)
Merging libata/for-next (2b5960a0e33b ata: pata_macio: Fix compilation warn=
ing)
Merging pcmcia/pcmcia-next (2ef4bb24ff39 pcmcia: Use platform_get_irq() to =
get the interrupt)
Merging mmc/next (bdc997a769ee mmc: core: Do not evaluate HS400 capabilitie=
s if bus has no MMC capability)
Merging mfd/for-mfd-next (198057c06f54 mfd: twl: Remove platform data suppo=
rt)
Merging backlight/for-backlight-next (023a8830a628 backlight: backlight: Sl=
ighly simplify devm_of_find_backlight())
Merging battery/for-next (f94ba7039fb4 Merge tag 'at91-reset-sama7g5-signed=
' into psy-next)
$ git reset --hard HEAD^
Merging next-20220617 version of battery
Merging regulator/for-next (901a2827fdf9 Merge remote-tracking branch 'regu=
lator/for-5.20' into regulator-next)
Merging security/next-testing (88c9c5679a06 Merge tag 'v5.18' into next-tes=
ting)
Merging apparmor/apparmor-next (c2489617b3b9 apparmor: Fix undefined refere=
nce to `zlib_deflate_workspacesize')
CONFLICT (content): Merge conflict in security/apparmor/policy_unpack_test.c
Merging integrity/next-integrity (51dd64bb99e4 Revert "evm: Fix memleak in =
init_desc")
Merging keys/keys-next (2d743660786e Merge branch 'fixes' of git://git.kern=
el.org/pub/scm/linux/kernel/git/viro/vfs)
Merging safesetid/safesetid-next (1b8b71922919 LSM: SafeSetID: Mark safeset=
id_initialized as __initdata)
Merging selinux/next (ef54ccb61616 selinux: selinux_add_opt() callers free =
memory)
Merging smack/next (b50503990d88 smack: Remove the redundant lsm_inode_allo=
c)
Merging tomoyo/master (b13baccc3850 Linux 5.19-rc2)
Merging tpmdd/next (27b5b22d252c certs: fix and refactor CONFIG_SYSTEM_BLAC=
KLIST_HASH_LIST build)
Merging watchdog/master (a111daf0c53a Linux 5.19-rc3)
Merging iommu/next (b0dacee202ef Merge branches 'apple/dart', 'arm/mediatek=
', 'arm/msm', 'arm/smmu', 'ppc/pamu', 'x86/vt-d', 'x86/amd' and 'vfio-notif=
ier-fix' into next)
Merging audit/next (546093206ba1 audit: make is_audit_feature_set() static)
Merging devicetree/for-next (cfda05c1ddb8 dt-bindings: vexpress-sysreg: All=
ow for no child nodes)
Merging dt-krzk/for-next (ba5203932582 dt-bindings: leds: qcom-wled: fix nu=
mber of addresses)
Merging mailbox/mailbox-for-next (79f9fbe30352 mailbox: qcom-ipcc: Fix -Wun=
used-function with CONFIG_PM_SLEEP=3Dn)
Merging spi/for-next (0cb24a68abbe Merge remote-tracking branch 'spi/for-5.=
20' into spi-next)
Merging tip/master (84bf7291902a Merge branch into tip/master: 'x86/mm')
Merging clockevents/timers/drivers/next (ff714ee7191b clocksource/drivers/t=
imer-ti-dm: Add compatible for am6 SoCs)
Merging edac/edac-for-next (92705c9f9956 Merge edac-misc into for-next)
Merging irqchip/irq/irqchip-next (492449ae4f0a Merge branch irq/gic-v3-nmi-=
fixes-5.19 into irq/irqchip-next)
Merging ftrace/for-next (01dca6d03bb3 Merge branch 'trace/for-next-rtla' in=
to trace/for-next)
Merging rcu/rcu/next (19743f8bb51c rcu/nocb: Choose the right rcuog/rcuop k=
threads to output)
Merging kvm/next (e20918f6d112 x86: kvm: remove NULL check before kfree)
CONFLICT (content): Merge conflict in tools/testing/selftests/kvm/s390x/mem=
op.c
CONFLICT (content): Merge conflict in tools/testing/selftests/kvm/s390x/res=
ets.c
CONFLICT (content): Merge conflict in tools/testing/selftests/kvm/s390x/syn=
c_regs_test.c
CONFLICT (content): Merge conflict in tools/testing/selftests/kvm/s390x/tpr=
ot.c
Merging kvm-arm/next (5c0ad551e9aa Merge branch kvm-arm64/its-save-restore-=
fixes-5.19 into kvmarm-master/next)
Merging kvms390/next (b1edf7f159a6 KVM: s390: selftests: Use TAP interface =
in the reset test)
Merging xen-tip/linux-next (ca6969013d13 drm/xen: Add missing VM_DONTEXPAND=
 flag in mmap callback)
Merging percpu/for-next (4e1f82dce05b Merge branch 'for-5.16-fixes' into fo=
r-next)
Merging workqueues/for-next (8bee9dd953b6 workqueue: Switch to new kerneldo=
c syntax for named variable macro argument)
Merging drivers-x86/for-next (f2906aa86338 Linux 5.19-rc1)
Merging chrome-platform/for-next (74bb746407bf platform/chrome: cros_ec: Al=
ways expose last resume result)
Merging hsi/for-next (43c14f8d18a7 HSI: omap_ssi: Fix refcount leak in ssi_=
probe)
Merging leds/for-next (f2906aa86338 Linux 5.19-rc1)
Merging ipmi/for-next (a508e33956b5 ipmi:ipmb: Fix refcount leak in ipmi_ip=
mb_probe)
Merging driver-core/driver-core-next (c21b0837983d spi: Use device_find_any=
_child() instead of custom approach)
Merging usb/usb-next (485394c63f47 MAINTAINERS: Repair file entry in ASPEED=
 USB UDC DRIVER)
Merging thunderbolt/next (34b9715b7cae thunderbolt: Fix typo in comment)
Merging usb-gadget/next (e49d033bddf5 Linux 5.12-rc6)
Merging usb-serial/usb-next (a111daf0c53a Linux 5.19-rc3)
Merging tty/tty-next (df36f3e3fbb7 Merge tag 'v5.19-rc3' into tty-next)
Merging char-misc/char-misc-next (a111daf0c53a Linux 5.19-rc3)
Merging coresight/next (f685bd9c03f5 coresight: Clear the connection field =
properly)
Merging fpga/for-next (2df84a757d87 fpga: altera-pr-ip: fix unsigned compar=
ison with less than zero)
Merging icc/icc-next (b3d5304b64e7 Merge branch 'icc-sm6350' into icc-next)
Merging iio/togreg (88cb99daa2b5 iio: adc: stm32-adc: Use generic_handle_do=
main_irq())
Merging phy-next/next (18b3eb79b1cf MAINTAINERS: add include/dt-bindings/ph=
y to GENERIC PHY FRAMEWORK)
Merging soundwire/next (f2906aa86338 Linux 5.19-rc1)
Merging extcon/extcon-next (51bd0abd873d extcon: fsa9480: Drop no-op remove=
 function)
Merging gnss/gnss-next (c0c725d7350e gnss: replace ida_simple API)
Merging vfio/next (421cfe6596f6 vfio: remove VFIO_GROUP_NOTIFY_SET_KVM)
Merging staging/staging-next (4175971d0eff Staging: r8188eu: core: rtw_xmit=
: Fixed a coding style issue)
Merging mux/for-next (0fcfb00b28c0 Linux 5.16-rc4)
Merging dmaengine/next (f7a03501b090 dmaengine: stm32-mdma: Remove dead cod=
e in stm32_mdma_irq_handler())
Merging cgroup/for-next (507c8695c65a Merge branch 'for-5.19-fixes' into fo=
r-next)
Merging scsi/for-next (9a54029e312d Merge branch 'fixes' into for-next)
Merging scsi-mkp/for-next (e34cc16a8042 scsi: MAINTAINERS: Update cxgb3i an=
d cxgb4i maintainer)
Merging vhost/linux-next (eacea844594f um: virt-pci: set device ready in pr=
obe())
Merging rpmsg/for-next (e088c15dc457 Merge branches 'rproc-next' and 'rpmsg=
-next' into for-next)
Merging gpio/for-next (7ac554888233 MAINTAINERS: Remove reference to non-ex=
isting file)
Merging gpio-brgl/gpio/for-next (f2906aa86338 Linux 5.19-rc1)
Merging gpio-intel/for-next (b93a8b2c5161 gpio: dln2: make irq_chip immutab=
le)
Merging gpio-sim/gpio/gpio-sim (0fcfb00b28c0 Linux 5.16-rc4)
Merging pinctrl/for-next (f5143c44df51 Merge branch 'devel' into for-next)
Merging pinctrl-intel/for-next (487b87717b85 pinctrl: intel: Drop no more u=
sed members of struct intel_pingroup)
Merging pinctrl-renesas/renesas-pinctrl (5223c511eb4f pinctrl: renesas: rzg=
2l: Return -EINVAL for pins which have input disabled)
Merging pinctrl-samsung/for-next (c98ebe065e07 pinctrl: samsung: do not use=
 bindings header with constants)
Merging pwm/for-next (3d593b6e80ad pwm: pwm-cros-ec: Add channel type suppo=
rt)
Merging userns/for-next (a58ea318d8b9 Merge of per-namespace-ipc-sysctls-fo=
r-v5.19, kthread-cleanups-for-v5.19, ptrace_stop-cleanup-for-v5.19, and uco=
unt-rlimits-cleanups-for-v5.19 for testing in linux-next)
Merging ktest/for-next (170f4869e662 ktest.pl: Fix the logic for truncating=
 the size of the log file for email)
Merging kselftest/next (cb6849a14c90 userfaultfd/selftests: Fix typo in com=
ment)
Merging livepatching/for-next (df44b1ee72f4 Merge branch 'for-5.20/selftest=
s-fixes' into for-next)
Merging rtc/rtc-next (f2906aa86338 Linux 5.19-rc1)
Merging nvdimm/libnvdimm-for-next (f42e8e5088b9 pmem: implement pmem_recove=
ry_write())
Merging at24/at24/for-next (312310928417 Linux 5.18-rc1)
Merging ntb/ntb-next (0c4b285d9636 Documentation: PCI: Add specification fo=
r the PCI vNTB function device)
Merging seccomp/for-next/seccomp (73a8dbafd31a selftests/seccomp: Fix compi=
le warning when CC=3Dclang)
Merging cisco/for-next (9e98c678c2d6 Linux 5.1-rc1)
Merging fsi/next (f2af60bb7ce2 fsi: Add trace events in initialization path)
Merging slimbus/for-next (4ad3deabeea2 slimbus: messaging: fix typos in com=
ments)
Merging nvmem/for-next (ccba200e4801 dt-bindings: nvmem: mediatek: efuse: a=
dd support mt8183)
Merging xarray/main (63b1898fffcd XArray: Disallow sibling entries of nodes)
Merging hyperv/hyperv-next (d27423bf048d hv_balloon: Fix balloon_probe() an=
d balloon_remove() error handling)
Merging auxdisplay/auxdisplay (13de23494f38 auxdisplay: lcd2s: Use array si=
ze explicitly in lcd2s_gotoxy())
Merging kgdb/kgdb/for-next (c1cb81429df4 kdb: Fix the putarea helper functi=
on)
Merging hmm/hmm (457c42326fb9 RDMA/erdma: Add driver to kernel build enviro=
nment)
Merging kunit/test (f2906aa86338 Linux 5.19-rc1)
Merging cfi/cfi/next (312310928417 Linux 5.18-rc1)
Merging kunit-next/kunit (f2906aa86338 Linux 5.19-rc1)
Merging trivial/for-next (081c8919b02b Documentation: remove trivial tree)
Merging mhi/mhi-next (48a23ec6ff2b Merge tag 'net-5.19-rc3' of git://git.ke=
rnel.org/pub/scm/linux/kernel/git/netdev/net)
Merging memblock/for-next (000605cd1b14 memblock tests: remove completed TO=
DO item)
Merging init/init-user-pointers (38b082236e77 initramfs: use vfs_utimes in =
do_copy)
Merging counters/counters (e71ba9452f0b Linux 5.11-rc2)
Merging cxl/next (34e37b4c432c cxl/port: Enable HDM Capability after valida=
ting DVSEC Ranges)
Merging folio-iomap/folio-iomap (4d7bd0eb72e5 iomap: Inline __iomap_zero_it=
er into its caller)
Merging zstd/zstd-next (88a309465b3f lib: zstd: clean up double word in com=
ment.)
Merging efi/next (98e152c19b66 brcmfmac: Switch to appropriate helper to lo=
ad EFI variable contents)
Merging unicode/for-next (b500d6d7243d unicode: Handle memory allocation fa=
ilures in mkutf8data)
Merging slab/for-next (c01651bc1ae4 Merge branches 'slab/for-5.20/trivial',=
 'slab/for-5.20/cleanup', 'slab/for-5.20/tracing' and 'slab/for-5.20/optimi=
zations' into slab/for-next)
Merging random/master (63b8ea5e4f1a random: update comment from copy_to_use=
r() -> copy_to_iter())
Merging landlock/next (b13baccc3850 Linux 5.19-rc2)
Merging rust/rust-next (9a5fe747d99e init/Kconfig: Specify the interpreter =
for rust-is-available.sh)
CONFLICT (content): Merge conflict in Makefile
CONFLICT (content): Merge conflict in include/uapi/linux/android/binder.h
Merging sysctl/sysctl-next (acdc07ace871 kernel/sysctl.c: Clean up indentat=
ion, replace spaces with tab.)
Merging folio/for-next (e0183897944e fs: remove the NULL get_block case in =
mpage_writepages)
Merging execve/for-next/execve (6342140db660 selftests/timens: add a test f=
or vfork+exit)
Merging bitmap/bitmap-for-next (0dfe54071d7c nodemask: Fix return values to=
 be unsigned)
Merging hte/hte/for-next (85ff37e302ef gpiolib: cdev: Fix kernel doc for st=
ruct line)
Merging kspp/for-next/kspp (e1d337335207 cfi: Fix __cfi_slowpath_diag RCU u=
sage with cpuidle)
CONFLICT (content): Merge conflict in kernel/cfi.c
Merging kspp-gustavo/for-next/kspp (f2906aa86338 Linux 5.19-rc1)
Merging mm-stable/mm-stable (6edda04ccc7c mm/kmemleak: prevent soft lockup =
in first object iteration loop of kmemleak_scan())
Merging mm-nonmm-stable/mm-nonmm-stable (00c9d5632277 lib/error-inject: con=
vert to DEFINE_SEQ_ATTRIBUTE)
Merging mm/mm-everything (56bf50e6fdfd Merge branch 'mm-nonmm-unstable' int=
o mm-everything)
CONFLICT (content): Merge conflict in include/linux/pagevec.h
CONFLICT (content): Merge conflict in mm/vmscan.c
Merging amdgpu/drm-next (eec53143b7fe drm/amd/display: fix incorrect compar=
ison in DML)
$ git reset --hard HEAD^
Merging next-20220601 version of amdgpu
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/dcn31/=
dcn31_dccg.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/inc/hw=
/dccg.h
[master a1b3d4e2d26d] next-20220601/amdgpu
Applying: hugetlb: fix an unused variable warning/error
$ git checkout -b akpm remotes/origin/akpm/master
$ git rebase --onto master remotes/origin/akpm/master-base
Merging akpm/master (8bb461d24234 hugetlb: fix an unused variable warning/e=
rror)

--Sig_/eLvO8/vIe/Hpoo+sjY25IpR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKyyMEACgkQAVBC80lX
0Gy+3AgAifjwmuyLDqLauJPhQzATzpraalb/nwwMsZbQ0ouhUcULvXsmY5UDdQq6
BEC66LDufhl7T3kzQ/hBPW6c9IKKrlpHuXM3e5HlVOdH0cREMJc5DBy/UyrwqKQH
CiTHS7IRtLcrjKpovKr3H1+mukjN3c90/gtBRyiSRGJyNe5rSDnq+yoxWw9isYAi
+0/+E+o3JeNkGdYB86ci6x1Cp0gOMx6ra5Z+0p5Kf/TWehe4vevi1w4bNKRYYofj
aai5u54x1/Zwd31o6rrFFc7p8Kh2uVL4rUfMnhiOuuxOKVIktU/5BIOB1Tc2pjFL
RhHKPAovAqP4ngFqWpzoHkUEiV1j9g==
=U1ZY
-----END PGP SIGNATURE-----

--Sig_/eLvO8/vIe/Hpoo+sjY25IpR--
