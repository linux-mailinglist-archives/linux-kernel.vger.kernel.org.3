Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 899C357B6D5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 14:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232833AbiGTMwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 08:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiGTMwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 08:52:18 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC1C419C38;
        Wed, 20 Jul 2022 05:52:14 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LnwZj03BMz4xG2;
        Wed, 20 Jul 2022 22:52:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1658321533;
        bh=KF2pCTbGMkO3y7a2swDCDKRiskZq0w4a0fsRkyh0FXQ=;
        h=Date:From:To:Cc:Subject:From;
        b=KZqeyawZHM/7u7spnDzuQSXJOyTVHLLtvMjQWFx3NKRpSn+i0JemYKvMnBc6zphvP
         vWR/RHgQpFAC87kjtZUrc2v2PU9t4CCKwRAbmwZ+blgbgZxGZAuftzrTRcQV9C7rCW
         BhQW4AIquvd3XEX0UOukmx3zKuvMnEhOxHS5FgJ0papesl+yud4FtWBih+Z+1hfEJO
         XSTPpwIp7lRmVrxk4/uw3Kpr08k38u9wRKyRzqPJOWwVIlEMhDcZBm9cOcFmC78iDN
         OzbvXiesVESHeACy9OGFYwtb9rPIFAm1tVRYkCHlrgI6OMlGU0V+jYPOF7t1hrH+3C
         2jPlTug2ccrYA==
Date:   Wed, 20 Jul 2022 22:52:11 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Jul 20
Message-ID: <20220720225211.20f9fa80@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Gpkxq7fEg1UOBSv_6vED62h";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,LOCALPART_IN_SUBJECT,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Gpkxq7fEg1UOBSv_6vED62h
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20220719:

The asm-generic tree change revealed a preexisting bug, so I revereted
a commit.

The bpf-next tree gained a build failure for which I reverted a commit.

The amdgpu tree still had part of its build failure so I used the version
from next-20220718 again.

The block tree gained a build failure for which I applied a patch.

Non-merge commits (relative to Linus' tree): 10957
 10930 files changed, 1083564 insertions(+), 281762 deletions(-)

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

I am currently merging 357 trees (counting Linus' and 98 trees of bug
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
Merging origin/master (ca85855bdcae Merge tag 'for-linus' of git://git.kern=
el.org/pub/scm/linux/kernel/git/rdma/rdma)
Merging fixes/fixes (4a57a8400075 vf/remap: return the amount of bytes actu=
ally deduplicated)
Merging mm-hotfixes/mm-hotfixes-unstable (7ca6e0e75e10 userfaultfd: provide=
 properly masked address for huge-pages)
Merging kbuild-current/fixes (32346491ddf2 Linux 5.19-rc6)
Merging arc-current/for-curr (952deecb065e arc: dts: Harmonize EHCI/OHCI DT=
 nodes name)
Merging arm-current/fixes (29589ca09a74 ARM: 9208/1: entry: add .ltorg dire=
ctive to keep literals in range)
Merging arm64-fixes/for-next/fixes (410982303772 arm64: hugetlb: Restore TL=
B invalidation for BBM on contiguous ptes)
Merging arm-soc-fixes/arm/fixes (d332a1f6b4c4 Merge tag 'qcom-dts-fixes-for=
-5.19' of git://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into arm=
/fixes)
Merging drivers-memory-fixes/fixes (1332661e0930 memory: samsung: exynos542=
2-dmc: Fix refcount leak in of_get_dram_timings)
Merging tee-fixes/fixes (98268f2a2a9f Merge branch 'optee_ffa_probe_fix_for=
_v5.18' into fixes)
Merging m68k-current/for-linus (30b5e6ef4a32 m68k: atari: Make Atari ROM po=
rt I/O write macros return void)
Merging powerpc-fixes/fixes (887502826549 powerpc/powernv: delay rng platfo=
rm device creation until later in boot)
Merging s390-fixes/fixes (2f23256c0ea2 s390/ap: fix error handling in __ver=
ify_queue_reservations())
Merging sparc/master (05a59d79793d Merge git://git.kernel.org:/pub/scm/linu=
x/kernel/git/netdev/net)
Merging fscrypt-current/for-stable (80f6e3080bfc fs-verity: fix signed inte=
ger overflow with i_size near S64_MAX)
Merging net/master (b3fcfc4f0c50 Merge branch 'amt-fix-validation-and-synch=
ronization-bugs')
Merging bpf/master (f946964a9f79 net: marvell: prestera: fix missed deinit =
sequence)
Merging ipsec/master (e79b9473e9b5 net: ipv4: fix clang -Wformat warnings)
Merging netfilter/master (7fb0269720d7 Merge tag 'for-net-2022-05-23' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth)
Merging ipvs/master (677fb7525331 Merge git://git.kernel.org/pub/scm/linux/=
kernel/git/netdev/net)
Merging wireless/for-next (11052589cf5c tcp/udp: Make early_demux back name=
spacified.)
Merging rdma-fixes/for-rc (cc0315564d6e RDMA/irdma: Fix sleep from invalid =
context BUG)
Merging sound-current/for-linus (cf33ce6f0c22 Merge tag 'asoc-fix-v5.19-rc4=
-2' of https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound into f=
or-linus)
Merging sound-asoc-fixes/for-linus (08911909b4e8 Merge remote-tracking bran=
ch 'asoc/for-5.18' into asoc-linus)
Merging regmap-fixes/for-linus (3f05010f243b regmap-irq: Fix offset/index m=
ismatch in read_sub_irq_data())
Merging regulator-fixes/for-linus (122e951eb804 regulator: qcom_smd: correc=
t MP5496 ranges)
Merging spi-fixes/for-linus (73d5fe046270 spi: cadence-quadspi: Remove spi_=
master_put() in probe failure path)
Merging pci-current/for-linus (a2b36ffbf5b6 x86/PCI: Revert "x86/PCI: Clip =
only host bridge windows for E820 regions")
Merging driver-core.current/driver-core-linus (f2906aa86338 Linux 5.19-rc1)
Merging tty.current/tty-linus (ff6992735ade Linux 5.19-rc7)
Merging usb.current/usb-linus (ff6992735ade Linux 5.19-rc7)
Merging usb-gadget-fixes/fixes (e49d033bddf5 Linux 5.12-rc6)
Merging usb-serial-fixes/usb-linus (7c239a071d1f USB: serial: ftdi_sio: add=
 Belimo device ids)
Merging phy/fixes (f2906aa86338 Linux 5.19-rc1)
Merging staging.current/staging-linus (32346491ddf2 Linux 5.19-rc6)
Merging iio-fixes/fixes-togreg (315f7e15c261 Merge tag 'iio-fixes-for-5.19a=
' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-mi=
sc-next)
Merging counter-fixes/fixes-togreg (f2906aa86338 Linux 5.19-rc1)
Merging char-misc.current/char-misc-linus (32346491ddf2 Linux 5.19-rc6)
Merging soundwire-fixes/fixes (f2906aa86338 Linux 5.19-rc1)
Merging thunderbolt-fixes/fixes (03c765b0e3b4 Linux 5.19-rc4)
Merging input-current/for-linus (2a96271fb66c Input: document the units for=
 resolution of size axes)
Merging crypto-current/master (87d044096ea6 crypto: ccp - Fix device IRQ co=
unting by using platform_irq_count())
Merging vfio-fixes/for-linus (afe4e376ac5d vfio: Move IOMMU_CAP_CACHE_COHER=
ENCY test to after we know we have a group)
Merging kselftest-fixes/fixes (9b4d5c01eb23 selftests: make use of GUP_TEST=
_FILE macro)
Merging modules-fixes/modules-linus (e69a66147d49 module: kallsyms: Ensure =
preemption in add_kallsyms() with PREEMPT_RT)
Merging dmaengine-fixes/fixes (607a48c78e6b dt-bindings: dma: allwinner,sun=
50i-a64-dma: Fix min/max typo)
Merging backlight-fixes/for-backlight-fixes (a38fd8748464 Linux 5.12-rc2)
Merging mtd-fixes/mtd/fixes (0fddf9ad06fd mtd: rawnand: gpmi: Set WAIT_FOR_=
READY timeout based on program/erase times)
Merging mfd-fixes/for-mfd-fixes (a61f4661fba4 mfd: intel_quark_i2c_gpio: Re=
vert "Constify static struct resources")
Merging v4l-dvb-fixes/fixes (3bcc2c1eade4 media: rkvdec: Disable H.264 erro=
r detection)
Merging reset-fixes/reset/fixes (a57f68ddc886 reset: Fix devm bulk optional=
 exclusive control getter)
Merging mips-fixes/mips-fixes (88084a3df167 Linux 5.19-rc5)
Merging at91-fixes/at91-fixes (ef0324b6415d ARM: dts: lan966x: fix sys_clk =
frequency)
Merging omap-fixes/fixes (2eb502f496f7 ARM: dts: am33xx: Fix MMCHS0 dma pro=
perties)
Merging kvm-fixes/master (79629181607e KVM: emulate: do not adjust size of =
fastop and setcc subroutines)
Merging kvms390-fixes/master (242c04f01377 KVM: s390: selftests: Use TAP in=
terface in the reset test)
Merging hwmon-fixes/hwmon (88084a3df167 Linux 5.19-rc5)
Merging nvdimm-fixes/libnvdimm-fixes (69053101e096 ndtest: Cleanup all of b=
lk namespace specific code)
Merging cxl-fixes/fixes (e35f5718903b cxl/mbox: Fix missing variable payloa=
d checks in cmd size validation)
Merging btrfs-fixes/next-fixes (af39011ec0c7 Merge branch 'misc-5.19' into =
next-fixes)
Merging vfs-fixes/fixes (c3497fd009ef fix short copy handling in copy_mc_pi=
pe_to_iter())
Merging dma-mapping-fixes/for-linus (3be4562584bb dma-direct: use the corre=
ct size for dma_set_encrypted())
Merging i3c-fixes/i3c/fixes (fe07bfda2fb9 Linux 5.12-rc1)
Merging drivers-x86-fixes/fixes (5ad26161a371 ACPI: video: Fix acpi_video_h=
andles_brightness_key_presses())
Merging samsung-krzk-fixes/fixes (c4c79525042a ARM: exynos: Fix refcount le=
ak in exynos_map_pmu)
Merging pinctrl-samsung-fixes/fixes (f2906aa86338 Linux 5.19-rc1)
Merging devicetree-fixes/dt/linus (0b9431c8221c dt-bindings: display: arm,m=
alidp: remove bogus RQOS property)
Merging dt-krzk-fixes/fixes (f2906aa86338 Linux 5.19-rc1)
Merging scsi-fixes/fixes (355bf2e036c9 scsi: pm80xx: Set stopped phy's link=
rate to Disabled)
Merging drm-fixes/drm-fixes (093f8d8f10aa Merge tag 'amd-drm-fixes-5.19-202=
2-07-13' of https://gitlab.freedesktop.org/agd5f/linux into drm-fixes)
Merging amdgpu-fixes/drm-fixes (2c409ba81be2 drm/radeon: fix si_enable_smc_=
cac() failed issue)
Merging drm-intel-fixes/for-linux-next-fixes (ff6992735ade Linux 5.19-rc7)
Merging mmc-fixes/fixes (51189eb9ddc8 mmc: sdhci-omap: Fix a lockdep warnin=
g for PM runtime init)
Merging rtc-fixes/rtc-fixes (bd33335aa93d rtc: cmos: Disable irq around dir=
ect invocation of cmos_interrupt())
Merging gnss-fixes/gnss-linus (a111daf0c53a Linux 5.19-rc3)
Merging hyperv-fixes/hyperv-fixes (49d6a3c062a1 x86/Hyper-V: Add SEV negoti=
ate protocol support in Isolation VM)
Merging soc-fsl-fixes/fix (4b0986a3613c Linux 5.18)
Merging risc-v-fixes/fixes (89551fdd44a2 riscv: dts: align gpio-key node na=
mes with dtschema)
Merging risc-v-mc-fixes/dt-fixes (efa310ba0071 riscv: dts: microchip: hook =
up the mpfs' l2cache)
Merging pidfd-fixes/fixes (03ba0fe4d09f file: simplify logic in __close_ran=
ge())
Merging fpga-fixes/fixes (f2906aa86338 Linux 5.19-rc1)
Merging spdx/spdx-linus (58301e1c15db Documentation: samsung-s3c24xx: Add b=
lank line after SPDX directive)
Merging gpio-brgl-fixes/gpio/for-current (b8c768ccdd83 gpio: pca953x: use t=
he correct register address when regcache sync during init)
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
Merging cel-fixes/for-rc (1197eb5906a5 lockd: fix nlm_close_files)
Merging irqchip-fixes/irq/irqchip-fixes (1357d2a65601 irqchip/apple-aic: Ma=
ke symbol 'use_fast_ipi' static)
Merging renesas-fixes/fixes (432b52eea3dc ARM: shmobile: defconfig: Restore=
 graphical consoles)
Merging broadcom-fixes/fixes (a26f045984e7 Merge branch 'devicetree/fixes' =
into fixes)
Merging perf-current/perf/urgent (4b335e1e0d6f perf trace: Fix SIGSEGV when=
 processing syscall args)
Merging efi-fixes/urgent (aa6d1ed107eb efi/x86: libstub: Fix typo in __efi6=
4_argmap* name)
Merging zstd-fixes/zstd-linus (88a309465b3f lib: zstd: clean up double word=
 in comment.)
Merging battery-fixes/fixes (093d27bb6f2d power: supply: core: Fix boundary=
 conditions in interpolation)
Merging drm-misc-fixes/for-linux-next-fixes (dbd0da2453c6 drm/ttm: fix lock=
ing in vmap/vunmap TTM GEM helpers)
Applying: Revert "Revert "drm/amdgpu: add drm buddy support to amdgpu""
Merging kbuild/for-next (e8c79d98b73c kbuild: error out if $(INSTALL_MOD_PA=
TH) contains % or :)
Merging clang-format/clang-format (781121a7f6d1 clang-format: Fix space aft=
er for_each macros)
Merging perf/perf/core (0d2997f750d1 perf lock: Look up callchain for the c=
ontended locks)
CONFLICT (content): Merge conflict in tools/perf/util/evsel.c
Merging compiler-attributes/compiler-attributes (7c00621dcaee compiler_type=
s: mark __compiletime_assert failure as __noreturn)
Merging dma-mapping/for-next (0568e6122574 ata: libata-scsi: cap ata_device=
->max_sectors according to shost->max_sectors)
Merging asm-generic/master (9f913e175376 Merge branch 'asm-generic-fixes' i=
nto asm-generic)
Merging arc/for-next (f2906aa86338 Linux 5.19-rc1)
Merging arm/for-next (e035a96f2536 Merge branches 'misc' and 'fixes' into f=
or-next)
Merging arm64/for-next/core (eff044f1b04e Merge branch 'for-next/boot' into=
 for-next/core)
Merging arm-perf/for-next/perf (aaaee7b55c9e docs: perf: Include hns3-pmu.r=
st in toctree to fix 'htmldocs' WARNING)
Merging arm-soc/for-next (9d08a6c65b5d soc: document merges)
CONFLICT (modify/delete): arch/arm/mach-bcm/bcm63xx.c deleted in arm-soc/fo=
r-next and modified in HEAD.  Version HEAD of arch/arm/mach-bcm/bcm63xx.c l=
eft in tree.
CONFLICT (modify/delete): arch/arm/mach-davinci/board-dm644x-evm.c deleted =
in arm-soc/for-next and modified in HEAD.  Version HEAD of arch/arm/mach-da=
vinci/board-dm644x-evm.c left in tree.
CONFLICT (modify/delete): arch/arm/mach-davinci/board-dm646x-evm.c deleted =
in arm-soc/for-next and modified in HEAD.  Version HEAD of arch/arm/mach-da=
vinci/board-dm646x-evm.c left in tree.
CONFLICT (modify/delete): arch/arm/mach-davinci/board-neuros-osd2.c deleted=
 in arm-soc/for-next and modified in HEAD.  Version HEAD of arch/arm/mach-d=
avinci/board-neuros-osd2.c left in tree.
CONFLICT (modify/delete): arch/arm/mach-davinci/dm644x.c deleted in arm-soc=
/for-next and modified in HEAD.  Version HEAD of arch/arm/mach-davinci/dm64=
4x.c left in tree.
CONFLICT (modify/delete): arch/arm/mach-davinci/dm646x.c deleted in arm-soc=
/for-next and modified in HEAD.  Version HEAD of arch/arm/mach-davinci/dm64=
6x.c left in tree.
$ git rm -f arch/arm/mach-bcm/bcm63xx.c arch/arm/mach-davinci/board-dm644x-=
evm.c arch/arm/mach-davinci/board-dm646x-evm.c arch/arm/mach-davinci/board-=
neuros-osd2.c arch/arm/mach-davinci/dm644x.c arch/arm/mach-davinci/dm646x.c
Merging actions/for-next (444d018d8d38 ARM: dts: owl-s500-roseapplepi: Add =
ATC2603C PMIC)
Merging amlogic/for-next (147c83586707 Merge branch 'v5.20/drivers' into fo=
r-next)
Merging aspeed/for-next (bfcbea2c93e5 ARM: dts: aspeed: nuvia: rename vendo=
r nuvia to qcom)
Merging at91/at91-next (96937c6f18e9 Merge branch 'at91-dt' into at91-next)
Merging broadcom/next (e765eb9133f2 Merge branch 'devicetree/next' into nex=
t)
Merging drivers-memory/for-next (1b33eb4acdc8 Merge branch 'for-v5.20/mem-c=
trl-next-late' into for-next)
Merging imx-mxs/for-next (37960df982d0 Merge branch 'imx/defconfig' into fo=
r-next)
Merging keystone/next (cb293d3b430e Merge branch 'for_5.15/drivers-soc' int=
o next)
Merging mediatek/for-next (5281655db0e1 Merge branch 'v5.19-next/soc' into =
for-next)
Merging mvebu/for-next (bc50bfd4f018 Merge branch 'mvebu/dt64' into mvebu/f=
or-next)
Merging omap/for-next (ad2fe4582c48 Merge branches 'omap-for-v5.20/omap1', =
'omap-for-v5.20/ti-sysc' and 'omap-for-v5.20/soc' into for-next)
Merging qcom/for-next (26c84bd37d0a Merge branches 'arm64-for-5.20', 'arm64=
-defconfig-for-5.20', 'clk-for-5.20', 'dts-for-5.20', 'dts-fixes-for-5.19' =
and 'drivers-for-5.20' into for-next)
Merging raspberrypi/for-next (c5915b53d4c2 dt-bindings: soc: bcm: Convert b=
rcm,bcm2835-vchiq to json-schema)
Merging renesas/next (b5468cb7909f Merge branches 'renesas-arm-dt-for-v5.20=
' and 'renesas-dt-bindings-for-v5.20' into renesas-next)
Merging reset/reset/next (096e772b1cdc Revert "reset: microchip-sparx5: all=
ow building as a module")
Merging rockchip/for-next (2e1170c71ec0 Merge branch 'v5.20-armsoc/dts64' i=
nto for-next)
Merging samsung-krzk/for-next (5642cb8ce0f1 Merge branch 'next/dt' into for=
-next)
Merging scmi/for-linux-next (d18d6aa0cbe3 Merge branch 'for-next/arch_topol=
ogy' of git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux in=
to for-linux-next)
Merging stm32/stm32-next (4b43ff02d2a4 ARM: dts: stm32: Add ST MIPID02 bind=
ings to AV96)
Merging sunxi/sunxi/for-next (3a83b092dd59 Merge branch 'sunxi/dt-for-5.20'=
 into sunxi/for-next)
Merging tee/next (db30e53bf897 Merge branch 'tee_cleanup_for_v5.19' into ne=
xt)
Merging tegra/for-next (393c6c3a6152 Merge branch for-5.20/arm64/defconfig =
into for-next)
Merging ti/ti-next (62b9e4033c13 Merge branches 'ti-drivers-soc-next' and '=
ti-k3-dts-next' into ti-next)
Merging xilinx/for-next (516de80d448f Merge branch 'zynqmp/soc' into for-ne=
xt)
Merging clk/clk-next (b293bc9286ee Merge branch 'clk-fixes' into clk-next)
Merging clk-imx/for-next (c196175acdd3 clk: imx: clk-fracn-gppll: Add more =
freq config for video pll)
Merging clk-renesas/renesas-clk (0e704f6c42dc clk: renesas: rcar-gen4: Fix =
initconst confusion for cpg_pll_config)
Merging clk-samsung/for-next (b35f27fe73d8 clk: samsung: exynosautov9: add =
cmu_peric1 clock support)
Merging csky/linux-next (f5ac0fb05b23 csky: Move HEAD_TEXT_SECTION out of _=
_init_begin-end)
Merging loongarch/loongarch-next (a111daf0c53a Linux 5.19-rc3)
Merging m68k/for-next (b508128bb0d1 m68k: defconfig: Update defconfigs for =
v5.19-rc1)
Merging m68knommu/for-next (483e7343bd40 m68k: Fix syntax errors in comment=
s)
Merging microblaze/next (78b5f52ab6f6 microblaze: fix typos in comments)
Merging mips/mips-next (466ab2ea239b MIPS: BMIPS: Utilize cfe_die() for inv=
alid DTB)
Merging nios2/for-next (7f7bc20bc41a nios2: Don't use _end for calculating =
min_low_pfn)
Merging openrisc/for-next (48bddb89d59e openrisc: unwinder: Fix grammar iss=
ue in comment)
Merging parisc-hd/for-next (e818884c382e parisc: Drop pa_swapper_pg_lock sp=
inlock)
Merging powerpc/next (ac2a2303016b Merge branch 'topic/ppc-kvm' into next)
Merging soc-fsl/next (4b0986a3613c Linux 5.18)
Merging risc-v/for-next (b49816611eac riscv: dts: sifive: "fix" pmic watchd=
og node name)
Merging risc-v-mc/dt-for-next (88d319c6abae riscv: dts: microchip: Add mpfs=
' topology information)
Merging s390/for-next (f36be09f90d3 Merge branch 'features' into for-next)
Merging sh/for-next (8518e694203d sh: pgtable-3level: Fix cast to pointer f=
rom integer of different size)
Merging sparc-next/master (dd0d718152e4 Merge tag 'spi-fix-v5.8-rc2' of git=
://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi)
Merging uml/linux-next (af3e16101cee um: include sys/types.h for size_t)
Merging xtensa/xtensa-for-next (0847d167d0f9 xtensa: enable ARCH_HAS_GCOV_P=
ROFILE_ALL)
Merging pidfd/for-next (7c4d37c269ac Revert "ovl: turn of SB_POSIXACL with =
idmapped layers temporarily")
Merging fscrypt/master (218d921b581e fscrypt: add new helper functions for =
test_dummy_encryption)
Merging fscache/fscache-next (0885eacdc81f Merge tag 'nfsd-5.19-1' of git:/=
/git.kernel.org/pub/scm/linux/kernel/git/cel/linux)
Merging afs/afs-next (26291c54e111 Linux 5.17-rc2)
Merging btrfs/for-next (3b44197b769a Merge branch 'for-next-next-v5.19-2022=
0719' into for-next-20220719)
Merging ceph/master (91c08da8e7fc fscrypt: add fscrypt_context_for_new_inod=
e)
Merging cifs/for-next (53c0fd4057df cifs: Fix memory leak when using fscach=
e)
Merging configfs/for-next (84ec758fb2da configfs: fix a race in configfs_{,=
un}register_subsystem())
Merging ecryptfs/next (682a8e2b41ef Merge tag 'ecryptfs-5.13-rc1-updates' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/tyhicks/ecryptfs)
Merging erofs/dev (410bae521617 erofs: introduce multi-reference pclusters =
(fully-referenced))
Merging exfat/dev (204e6ceaa103 exfat: use updated exfat_chain directly dur=
ing renaming)
Merging ext3/for_next (7fd0dbb80f46 Merge ext2 min_t() cleanup from Jiangsh=
an Yi.)
Merging ext4/dev (f8dc286e4d94 jbd2: fix outstanding credits assert in jbd2=
_journal_commit_transaction())
Merging f2fs/dev (785c1904b28d f2fs: add a sysfs entry to show zone capacit=
y)
Merging fsverity/fsverity (8da572c52a9b fs-verity: mention btrfs support)
Merging fuse/for-next (6b49bc9d8a5f fuse: avoid unnecessary spinlock bump)
Merging gfs2/for-next (44dab005fd42 gfs2: Minor gfs2_glock_nq_m cleanup)
Merging jfs/jfs-next (e471e5942c00 fs/jfs: Remove dead code)
Merging ksmbd/ksmbd-for-next (732f30694325 Merge tag '5.19-rc4-ksmbd-server=
-fixes' of git://git.samba.org/ksmbd)
Merging nfs/linux-next (51fd2eb52c0c NFSv4: Fix races in the legacy idmappe=
r upcall)
Merging nfs-anna/linux-next (4f40a5b55446 NFSv4: Add an fattr allocation to=
 _nfs4_discover_trunking())
Merging nfsd/for-next (bbeefc0ad610 SUNRPC: Fix xdr_encode_bool())
Merging ntfs3/master (604a9d272dc3 fs/ntfs3: Remove unnecessary 'NULL' valu=
es from pointers)
Merging orangefs/for-next (40a74870b2d1 orangefs: Fix the size of a memory =
allocation in orangefs_bufmap_alloc())
Merging overlayfs/overlayfs-next (4a47c6385bb4 ovl: turn of SB_POSIXACL wit=
h idmapped layers temporarily)
Merging ubifs/next (8c03a1c21d72 ubi: ubi_create_volume: Fix use-after-free=
 when volume creation failed)
Merging v9fs/9p-next (aa7aeee16948 net/9p: Initialize the iounit field duri=
ng fid creation)
Merging xfs/for-next (95ff0363f3f6 xfs: fix use-after-free in xattr node bl=
ock inactivation)
Merging zonefs/for-next (6bac30bb8ff8 zonefs: Call page_address() on page a=
cquired with GFP_KERNEL flag)
Merging iomap/iomap-for-next (f8189d5d5fbf dax: set did_zero to true when z=
eroing successfully)
Merging djw-vfs/vfs-for-next (49df34221804 fs: fix an infinite loop in ioma=
p_fiemap)
Merging file-locks/locks-next (0064b3d9f96f fs/lock: Rearrange ops in flock=
 syscall.)
Merging vfs/for-next (52935d5f0f36 Merge branches 'work.misc', 'work.iov_it=
er', 'work.namei' and 'work.lseek-2' into for-next)
CONFLICT (content): Merge conflict in fs/btrfs/file.c
CONFLICT (content): Merge conflict in net/9p/client.c
Merging printk/for-next (efc9d3c5e803 Merge branch 'rework/kthreads' into f=
or-next)
Merging pci/next (778aca71a6c0 Merge branch 'pci/misc')
Merging pstore/for-next/pstore (2c09d1443b9b pstore/zone: cleanup "rcnt" ty=
pe)
Merging hid/for-next (6c55e6cce170 Merge branch 'for-5.20/nintendo' into fo=
r-next)
Merging i2c/i2c/for-next (50dacfb030f3 Merge branch 'i2c/for-mergewindow' i=
nto i2c/for-next)
Merging i3c/i3c/next (f2906aa86338 Linux 5.19-rc1)
Merging dmi/dmi-for-next (f97a2103f1a7 firmware: dmi: Move product_sku info=
 to the end of the modalias)
Merging hwmon-staging/hwmon-next (03508eea5385 hwmon: (mcp3021) improve dri=
ver support for newer hwmon interface)
Merging jc_docs/docs-next (bb6279d8ed25 Merge branch 'submitting-drivers-re=
moval' into docs-next)
Merging v4l-dvb/master (e670f5d672ef media: amphion: only insert the first =
sequence startcode for vc1l format)
Merging v4l-dvb-next/master (8bd1dbf8d580 media: rkisp1: debug: Add dump fi=
le in debugfs for MI main path registers)
Merging pm/linux-next (66de314cd08f Merge branch 'pm-devfreq' into linux-ne=
xt)
Merging cpufreq-arm/cpufreq/arm/linux-next (33fe1cb20cf4 cpufreq: tegra194:=
 Staticize struct tegra_cpufreq_soc instances)
Merging cpupower/cpupower (f2906aa86338 Linux 5.19-rc1)
Merging devfreq/devfreq-next (53f853d55e31 PM / devfreq: tegra30: Add error=
 message for devm_devfreq_add_device())
Merging opp/opp/linux-next (3466ea2cd6b6 OPP: Don't drop opp->np reference =
while it is still in use)
Merging thermal/thermal/linux-next (e308c85b1b92 thermal/drivers/rzg2l: Fix=
 comments)
Merging ieee1394/for-next (54b3bd99f094 firewire: nosy: switch from 'pci_' =
to 'dma_' API)
Merging dlm/next (0f24debbb847 fs: dlm: move kref_put assert for lkb struct=
s)
Merging rdma/for-next (03905ac2852c RDMA/rxe: Remove unused mask parameter)
Merging net-next/master (c2fe9ec3975d Merge branch '1GbE' of git://git.kern=
el.org/pub/scm/linux/kernel/git/tnguy/next-queue)
CONFLICT (content): Merge conflict in arch/arm64/boot/dts/marvell/armada-70=
40-mochabin.dts
CONFLICT (content): Merge conflict in arch/arm64/boot/dts/marvell/armada-80=
40-mcbin.dtsi
CONFLICT (content): Merge conflict in arch/arm64/boot/dts/marvell/armada-80=
40-puzzle-m801.dts
CONFLICT (content): Merge conflict in arch/arm64/boot/dts/rockchip/rk3568-b=
pi-r2-pro.dts
Merging bpf-next/for-next (b77ffb30cfc5 libbpf: fix an snprintf() overflow =
check)
Applying: Revert "bpf: fix lsm_cgroup build errors on esoteric configs"
Merging ipsec-next/master (5e25c25aa2c0 xfrm: improve wording of comment ab=
ove XFRM_OFFLOAD flags)
Merging mlx5-next/mlx5-next (b0bb369ee451 net/mlx5: fs, allow flow table cr=
eation with a UID)
Merging netfilter-next/master (677fb7525331 Merge git://git.kernel.org/pub/=
scm/linux/kernel/git/netdev/net)
Merging ipvs-next/master (677fb7525331 Merge git://git.kernel.org/pub/scm/l=
inux/kernel/git/netdev/net)
Merging bluetooth/master (ff1688aab0d1 Bluetooth: hci_sync: Don't remove co=
nnected devices from accept list)
Merging wireless-next/for-next (f1cee996f185 wifi: wl1251: fix repeated wor=
ds in comments)
Merging mtd/mtd/next (ad9b10d1eaad mtd: core: introduce of support for dyna=
mic partitions)
Merging nand/nand/next (e16eceea863b mtd: rawnand: arasan: Fix clock rate i=
n NV-DDR)
Merging spi-nor/spi-nor/next (41e4f15f02af mtd: spi-nor: esmt: Use correct =
name of f25l32qa)
Merging crypto/master (ec8f7f4821d5 crypto: lib - make the sha1 library opt=
ional)
CONFLICT (content): Merge conflict in MAINTAINERS
Merging drm/drm-next (891ce1c9623f Merge tag 'drm-misc-next-fixes-2022-07-1=
4' of git://anongit.freedesktop.org/drm/drm-misc into drm-next)
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/amdgpu_dm=
/amdgpu_dm.c
Merging drm-misc/for-linux-next (6f2c8d5f1659 drm/amdgpu: Fix for drm buddy=
 memory corruption)
Merging amdgpu/drm-next (b23f0b8b2baa drm/amd/display: reduce stack size in=
 dcn32 dml)
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/Kconfig
$ git reset --hard HEAD^
Merging next-20220718 version of amdgpu
Merging drm-intel/for-linux-next (9899834ae5f2 drm/i915/display: Add debug =
print for scaler filter)
Merging drm-tegra/for-next (135f4c551d51 drm/tegra: vic: Use devm_platform_=
ioremap_resource())
Merging drm-msm/msm-next (cb77085b1f0a drm/msm/dpu: Fix for non-visible pla=
nes)
Merging drm-msm-lumag/msm-next-lumag (1ff1da40d6fc Merge branches 'msm-next=
-lumag-core', 'msm-next-lumag-dpu', 'msm-next-lumag-dp', 'msm-next-lumag-ds=
i', 'msm-next-lumag-hdmi', 'msm-next-lumag-mdp5' and 'msm-next-lumag-mdp4' =
into msm-next-lumag)
Merging imx-drm/imx-drm/next (927d8fd465ad drm/imx: ipuv3-plane: Remove red=
undant color encoding and range initialisation)
Merging etnaviv/etnaviv/next (2829a9fcb738 drm/etnaviv: reap idle softpin m=
appings when necessary)
Merging fbdev/for-next (075fbf0ab8dd video: fbdev: omapfb: Unexport omap*_u=
pdate_window_async())
Merging regmap/for-next (739f872e48d4 regmap: permit to set reg_update_bits=
 with bulk implementation)
Merging sound/for-next (53f07e9b010b Revert "ALSA: hda: Fix page fault in s=
nd_hda_codec_shutdown()")
Merging sound-asoc/for-next (ab1dabba4dd9 Merge remote-tracking branch 'aso=
c/for-5.20' into asoc-next)
Merging modules/modules-next (6f1dae1d84b6 module: Show the last unloaded m=
odule's taint flag(s))
Merging input/next (39636805cab2 dt-bindings: input: iqs7222: Use central '=
linux,code' definition)
Merging block/for-next (399c3bf72892 Merge branch 'for-5.20/io_uring-zeroco=
py-send' into for-next)
CONFLICT (content): Merge conflict in block/fops.c
CONFLICT (content): Merge conflict in fs/btrfs/extent_io.c
CONFLICT (content): Merge conflict in fs/btrfs/raid56.c
CONFLICT (modify/delete): fs/io_uring.c deleted in block/for-next and modif=
ied in HEAD.  Version HEAD of fs/io_uring.c left in tree.
$ git rm -f fs/io_uring.c
Applying: fixup for "keep iocb_flags() result cached in struct file"
Merging device-mapper/for-next (3534e5a5ed29 dm thin: fix use-after-free cr=
ash in dm_sm_register_threshold_callback)
Merging libata/for-next (0184898dd14d ata: libata-scsi: fix result type of =
ata_ioc32())
Merging pcmcia/pcmcia-next (2ef4bb24ff39 pcmcia: Use platform_get_irq() to =
get the interrupt)
Merging mmc/next (886201c70a1c mmc: sdhci-brcmstb: use clk_get_rate(base_cl=
k) in PM resume)
Merging mfd/for-mfd-next (0a2de5bb0216 dt-bindings: mfd: syscon: Update Lee=
 Jones' email address)
Merging backlight/for-backlight-next (f2ac0a8f8a03 backlight: lp855x: Switc=
h to atomic PWM API)
Merging battery/for-next (c9d8468158ad power: supply: olpc_battery: Hold th=
e reference returned by of_find_compatible_node)
Merging regulator/for-next (218320fec294 regulator: core: Fix off-on-delay-=
us for always-on/boot-on regulators)
Merging security/next (ed56f4b5173e MAINTAINERS: update the LSM maintainer =
info)
Merging apparmor/apparmor-next (eac931254d99 apparmor: move ptrace mediatio=
n to more logical task.{h,c})
Merging integrity/next-integrity (1d212f9037b0 Merge remote-tracking branch=
 'linux-integrity/kexec-keyrings' into next-integrity)
Merging keys/keys-next (2d743660786e Merge branch 'fixes' of git://git.kern=
el.org/pub/scm/linux/kernel/git/viro/vfs)
Merging safesetid/safesetid-next (cd5fc01e17e1 LSM: SafeSetID: fix bug duri=
ng GID policy check)
Merging selinux/next (ef54ccb61616 selinux: selinux_add_opt() callers free =
memory)
Merging smack/next (b50503990d88 smack: Remove the redundant lsm_inode_allo=
c)
Merging tomoyo/master (ca85855bdcae Merge tag 'for-linus' of git://git.kern=
el.org/pub/scm/linux/kernel/git/rdma/rdma)
Merging tpmdd/next (1679eb4a6194 tpm: eventlog: Fix section mismatch for DE=
BUG_SECTION_MISMATCH)
Merging watchdog/master (a111daf0c53a Linux 5.19-rc3)
Merging iommu/next (ebd0c9c85fdc Merge branches 'arm/exynos', 'arm/mediatek=
', 'virtio', 'x86/vt-d', 'x86/amd' and 'core' into next)
Merging audit/next (546093206ba1 audit: make is_audit_feature_set() static)
Merging devicetree/for-next (e76f4a6107eb of: overlay: Simplify of_overlay_=
fdt_apply() tail)
Merging dt-krzk/for-next (ad0d6ea39195 Merge branch 'for-v5.20/dt-bindings-=
qcom' into next/dt-bindings)
CONFLICT (content): Merge conflict in Documentation/devicetree/bindings/arm=
/qcom.yaml
Merging mailbox/mailbox-for-next (79f9fbe30352 mailbox: qcom-ipcc: Fix -Wun=
used-function with CONFIG_PM_SLEEP=3Dn)
Merging spi/for-next (43979072706d Merge remote-tracking branch 'spi/for-5.=
20' into spi-next)
Merging tip/master (96ff3a14815b Merge x86/urgent into tip/master)
CONFLICT (content): Merge conflict in arch/x86/kernel/kexec-bzimage64.c
Merging clockevents/timers/drivers/next (aa84506ea644 clocksource/drivers/s=
h_cmt: Add R-Car Gen4 support)
Merging edac/edac-for-next (92705c9f9956 Merge edac-misc into for-next)
Merging irqchip/irq/irqchip-next (1d77af7599f9 Merge branch irq/misc-5.20 i=
nto irq/irqchip-next)
Merging ftrace/for-next (41065bf81386 selftests/kprobe: Update test for no =
event name syntax error)
Merging rcu/rcu/next (f8466c532f55 rcu-tasks: Ensure RCU Tasks Trace loops =
have quiescent states)
CONFLICT (content): Merge conflict in arch/loongarch/Kconfig
Merging kvm/next (4b88b1a518b3 KVM: selftests: Enhance handling WRMSR ICR r=
egister in x2APIC mode)
CONFLICT (content): Merge conflict in arch/x86/kvm/vmx/capabilities.h
CONFLICT (content): Merge conflict in arch/x86/kvm/x86.c
CONFLICT (content): Merge conflict in tools/testing/selftests/kvm/lib/aarch=
64/ucall.c
CONFLICT (content): Merge conflict in tools/testing/selftests/kvm/s390x/mem=
op.c
CONFLICT (content): Merge conflict in tools/testing/selftests/kvm/s390x/res=
ets.c
CONFLICT (content): Merge conflict in tools/testing/selftests/kvm/s390x/syn=
c_regs_test.c
CONFLICT (content): Merge conflict in tools/testing/selftests/kvm/s390x/tpr=
ot.c
Merging kvm-arm/next (ae98a4a98993 Merge branch kvm-arm64/sysreg-cleanup-5.=
20 into kvmarm-master/next)
CONFLICT (content): Merge conflict in tools/testing/selftests/kvm/aarch64/v=
gic_init.c
Merging kvms390/next (52db9dcc7b3b KVM: s390: resetting the Topology-Change=
-Report)
Merging xen-tip/linux-next (a47336535f0f xen: don't require virtio with gra=
nts for non-PV guests)
Merging percpu/for-next (a111daf0c53a Linux 5.19-rc3)
Merging workqueues/for-next (8bee9dd953b6 workqueue: Switch to new kerneldo=
c syntax for named variable macro argument)
Merging drivers-x86/for-next (7a4a04f4e90d platform/surface: tabletsw: Fix =
__le32 integer access)
Merging chrome-platform/for-next (1ff5d97f070c platform/chrome: cros_ec_typ=
ec: Register port altmodes)
Merging hsi/for-next (43c14f8d18a7 HSI: omap_ssi: Fix refcount leak in ssi_=
probe)
Merging leds/for-next (92cfc71ee2dd leds: leds-bcm63138: get rid of LED_OFF)
Merging ipmi/for-next (79c87b8f8ba7 ipmi: Fix comment typo)
Merging driver-core/driver-core-next (7ee951acd31a drivers/base: fix usersp=
ace break from using bin_attributes for cpumap and cpulist)
Merging usb/usb-next (32f02a211b0a Revert "platform/chrome: Add Type-C mux =
set command definitions")
CONFLICT (content): Merge conflict in MAINTAINERS
Merging thunderbolt/next (34b9715b7cae thunderbolt: Fix typo in comment)
Merging usb-gadget/next (e49d033bddf5 Linux 5.12-rc6)
Merging usb-serial/usb-next (9ec7e8d5fae3 USB: serial: fix repeated word "t=
he" in comments)
Merging tty/tty-next (af77c56aa353 tty: vt: initialize unicode screen buffe=
r)
Merging char-misc/char-misc-next (fe5fc9873af0 Merge tag 'phy-for-5.20' of =
git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy into char-misc-=
next)
CONFLICT (content): Merge conflict in drivers/gpu/drm/msm/dp/dp_parser.h
CONFLICT (content): Merge conflict in drivers/soundwire/intel.c
Merging coresight/next (4d45bc82df66 coresight: etm4x: avoid build failure =
with unrolled loops)
Merging fpga/for-next (ee794221a6f6 fpga: fpga-mgr: Fix spelling mistake "b=
itsream" -> "bitstream")
Merging icc/icc-next (009c963eefa0 Merge branch 'icc-rpm' into icc-next)
Merging iio/togreg (180c6cb6b9b7 dt-bindings: iio: adc: Add compatible for =
MT8188)
Merging phy-next/next (08680588d340 dt-bindings: phy: mediatek: tphy: add c=
ompatible for mt8188)
Merging soundwire/next (3f4a70268d54 soundwire: qcom: Enable software clock=
 gating requirement flag)
Merging extcon/extcon-next (3a06ed80265f extcon: Add EXTCON_DISP_CVBS and E=
XTCON_DISP_EDP)
Merging gnss/gnss-next (c0c725d7350e gnss: replace ida_simple API)
Merging vfio/next (2a8ed7ef00b9 Merge branches 'v5.20/vfio/spapr_tce-unused=
-arg-v1', 'v5.20/vfio/comment-typo-v1' and 'v5.20/vfio/vfio-ccw-rework-v4' =
into v5.20/vfio/next)
CONFLICT (content): Merge conflict in drivers/vfio/vfio.c
CONFLICT (content): Merge conflict in include/linux/vfio_pci_core.h
Merging staging/staging-next (8af028c2b22b staging: vt6655: Convert macro v=
t6655_mac_word_reg_bits_off to function)
Merging mux/for-next (0fcfb00b28c0 Linux 5.16-rc4)
Merging dmaengine/next (4348d99efa01 dmaengine: altera-msgdma: Fixed some i=
nconsistent function name descriptions)
Merging cgroup/for-next (27924b13fcce Merge branch 'for-5.20' into for-next)
Merging scsi/for-next (e7dfe3bc7687 Merge branch 'misc' into for-next)
Merging scsi-mkp/for-next (70f58e3e07e6 scsi: sd: Support multiple LBA rang=
es in an UNMAP command)
Merging vhost/linux-next (6a9720576cd0 virtio: VIRTIO_HARDEN_NOTIFICATION i=
s broken)
Merging rpmsg/for-next (441b664035a2 Merge branches 'rpmsg-next', 'rproc-ne=
xt' and 'hwspinlock-next' into for-next)
Merging gpio/for-next (e73f0f0ee754 Linux 5.14-rc1)
Merging gpio-brgl/gpio/for-next (c4371c563973 gpio: remove VR41XX related g=
pio driver)
Merging gpio-intel/for-next (b65bb2c14891 gpio: pch: Change PCI device macr=
os)
Merging gpio-sim/gpio/gpio-sim (0fcfb00b28c0 Linux 5.16-rc4)
Merging pinctrl/for-next (1a24a177564a Merge branch 'devel' into for-next)
Merging pinctrl-intel/for-next (25097de7b236 pinctrl: intel: Add Intel Mete=
or Lake pin controller support)
Merging pinctrl-renesas/renesas-pinctrl (36611d28f513 pinctrl: renesas: r8a=
779g0: Add missing MODSELx for AVBx)
Merging pinctrl-samsung/for-next (c98ebe065e07 pinctrl: samsung: do not use=
 bindings header with constants)
Merging pwm/for-next (394b517585da pwm: mediatek: Add MT8365 support)
Merging userns/for-next (864b0954e4d9 Merge of ucount-rlimits-cleanups-for-=
v5.19, interrupting_kthread_stop-for-v5.20, signal-for-v5.20, and retire_mq=
_sysctls-for-v5.19 for testing in linux-next)
Merging ktest/for-next (170f4869e662 ktest.pl: Fix the logic for truncating=
 the size of the log file for email)
Merging kselftest/next (a917dd94b832 selftests/landlock: drop deprecated he=
aders dependency)
Merging livepatching/for-next (df44b1ee72f4 Merge branch 'for-5.20/selftest=
s-fixes' into for-next)
Merging rtc/rtc-next (592ff0c8d064 rtc: Directly use ida_alloc()/free())
CONFLICT (content): Merge conflict in MAINTAINERS
Merging nvdimm/libnvdimm-for-next (53fc59511fc4 nvdimm/namespace: drop unne=
eded temporary variable in size_store())
Merging at24/at24/for-next (312310928417 Linux 5.18-rc1)
Merging ntb/ntb-next (e8c04e435db5 NTB: EPF: Mark pci_read and pci_write as=
 static)
Merging seccomp/for-next/seccomp (73a8dbafd31a selftests/seccomp: Fix compi=
le warning when CC=3Dclang)
Merging cisco/for-next (9e98c678c2d6 Linux 5.1-rc1)
Merging fsi/next (04823dd2af87 fsi: master-ast-cf: Fix missing of_node_put =
in fsi_master_acf_probe)
Merging slimbus/for-next (4ad3deabeea2 slimbus: messaging: fix typos in com=
ments)
Merging nvmem/for-next (432ee5a3cfcf nvmem: mtk-efuse: Simplify with devm_p=
latform_get_and_ioremap_resource())
Merging xarray/main (69cb69ea5542 ida: Remove assertions that an ID was all=
ocated)
Merging hyperv/hyperv-next (d180e0a1be6c Drivers: hv: Create debugfs file w=
ith hyper-v balloon usage information)
Merging auxdisplay/auxdisplay (13de23494f38 auxdisplay: lcd2s: Use array si=
ze explicitly in lcd2s_gotoxy())
Merging kgdb/kgdb/for-next (c1cb81429df4 kdb: Fix the putarea helper functi=
on)
Merging hmm/hmm (bea86a8116f6 RDMA/erdma: Add driver to kernel build enviro=
nment)
Merging kunit/test (f2906aa86338 Linux 5.19-rc1)
Merging cfi/cfi/next (312310928417 Linux 5.18-rc1)
Merging kunit-next/kunit (94681e289bf5 kunit: executor: Fix a memory leak o=
n failure in kunit_filter_tests)
Merging trivial/for-next (081c8919b02b Documentation: remove trivial tree)
Merging mhi/mhi-next (9df125af0822 bus: mhi: ep: Check dev_set_name() retur=
n value)
Merging memblock/for-next (fe833b4edc59 memblock tests: remove completed TO=
DO items)
Merging init/init-user-pointers (38b082236e77 initramfs: use vfs_utimes in =
do_copy)
Merging counters/counters (e71ba9452f0b Linux 5.11-rc2)
Merging cxl/next (b060edfd8cdd cxl/pmem: Delete unused nvdimm attribute)
Merging folio-iomap/folio-iomap (4d7bd0eb72e5 iomap: Inline __iomap_zero_it=
er into its caller)
Merging zstd/zstd-next (88a309465b3f lib: zstd: clean up double word in com=
ment.)
Merging efi/next (df3c9072ef90 Merge branch 'efivars-cleanup' into efi/next)
Merging unicode/for-next (b500d6d7243d unicode: Handle memory allocation fa=
ilures in mkutf8data)
Merging slab/for-next (b77d5b1b83e3 mm: slab: optimize memcg_slab_free_hook=
())
Merging random/master (d1c438c228c8 random: handle archrandom with multiple=
 longs)
CONFLICT (content): Merge conflict in arch/arm64/kernel/kaslr.c
CONFLICT (content): Merge conflict in arch/powerpc/Kconfig
Merging landlock/next (b13baccc3850 Linux 5.19-rc2)
Merging rust/rust-next (9a5fe747d99e init/Kconfig: Specify the interpreter =
for rust-is-available.sh)
CONFLICT (content): Merge conflict in Makefile
CONFLICT (content): Merge conflict in arch/x86/Makefile
CONFLICT (content): Merge conflict in include/uapi/linux/android/binder.h
Merging sysctl/sysctl-next (acdc07ace871 kernel/sysctl.c: Clean up indentat=
ion, replace spaces with tab.)
Merging folio/for-next (03b33c09ea22 fs: remove the NULL get_block case in =
mpage_writepages)
CONFLICT (content): Merge conflict in fs/buffer.c
Merging execve/for-next/execve (5036793d7dbd exec: Fix a spelling mistake)
Merging bitmap/bitmap-for-next (3a2ba42cbd0b x86/olpc: fix 'logical not is =
only applied to the left hand side')
CONFLICT (content): Merge conflict in include/linux/gfp.h
Applying: fix up for "mm: kasan: Skip unpoisoning of user pages"
Applying: fix up for bitmap_weight return value changing
Merging hte/hte/for-next (85ff37e302ef gpiolib: cdev: Fix kernel doc for st=
ruct line)
Merging kspp/for-next/kspp (e1d337335207 cfi: Fix __cfi_slowpath_diag RCU u=
sage with cpuidle)
CONFLICT (content): Merge conflict in kernel/cfi.c
Merging kspp-gustavo/for-next/kspp (94dfc73e7cf4 treewide: uapi: Replace ze=
ro-length arrays with flexible-array members)
Merging mm-stable/mm-stable (13c1c74af764 zram: fix unused 'zram_wb_devops'=
 warning)
CONFLICT (content): Merge conflict in Documentation/translations/zh_CN/mm/f=
ree_page_reporting.rst
CONFLICT (content): Merge conflict in Documentation/translations/zh_CN/mm/f=
rontswap.rst
CONFLICT (content): Merge conflict in Documentation/translations/zh_CN/mm/p=
age_frags.rst
CONFLICT (file location): Documentation/translations/zh_CN/vm/page_migratio=
n.rst added in HEAD inside a directory that was renamed in mm-stable/mm-sta=
ble, suggesting it should perhaps be moved to Documentation/translations/zh=
_CN/mm/page_migration.rst.
CONFLICT (file location): Documentation/translations/zh_CN/vm/vmalloced-ker=
nel-stacks.rst added in HEAD inside a directory that was renamed in mm-stab=
le/mm-stable, suggesting it should perhaps be moved to Documentation/transl=
ations/zh_CN/mm/vmalloced-kernel-stacks.rst.
CONFLICT (content): Merge conflict in Documentation/translations/zh_CN/mm/z=
smalloc.rst
CONFLICT (content): Merge conflict in include/linux/pagevec.h
Merging mm-nonmm-stable/mm-nonmm-stable (233eb8d6894e fs/ocfs2: Fix spellin=
g typo in comment)
CONFLICT (content): Merge conflict in include/linux/cpumask.h
Merging mm/mm-everything (d59759a5e9aa Merge branch 'mm-nonmm-unstable' int=
o mm-everything)
CONFLICT (content): Merge conflict in include/linux/gfp.h
CONFLICT (content): Merge conflict in lib/Makefile
Applying: fix up for "xfs: pass perag to xfs_alloc_read_agf()"
Applying: fix up for "headers/deps: mm: Split <linux/gfp_types.h> out of <l=
inux/gfp.h>"
Applying: fix up for "io_uring: sendzc with fixed buffers"
Applying: Revert "asm-generic: correct reference to GENERIC_LIB_DEVMEM_IS_A=
LLOWED"

--Sig_/Gpkxq7fEg1UOBSv_6vED62h
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLX+nsACgkQAVBC80lX
0GwKWQgAj41JU6DaRWKoytqcUIjQR9S9Q3Uby0EAfjj+B7uTL4BwOA4NgO7tZkju
YOtdYt3ILOHN+fwaJRCq2Ch4A1ZIhiBvioKBUf8QqmFZj0wBxXnO4kG949Fy59/Q
EDmOd1eTg81lLp3w9v8Av5fhKwsY2Jw/39GhWDDgSPcB6J+Phg8E8BgVoPPndof/
sAeB+IPrceSb6QjHFp37y7XxBIFriFee0wWP+wPZbsjNCLO93KEgYi22uvGBrbfW
kiHaQBGSgtUf3vyt+/sJgyxBVhkHgRj+om9aVLIiwCKaOq23v9x5ddFzTZbnHUBx
of4cs77PQfe+4bKb9KhJwIIDeFGHBA==
=fGZT
-----END PGP SIGNATURE-----

--Sig_/Gpkxq7fEg1UOBSv_6vED62h--
