Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B73B44F0872
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 10:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240308AbiDCIqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 04:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233847AbiDCIqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 04:46:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D257735DC7
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 01:44:16 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1648975455;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=QmuM9CbNWBkcVUeot11rzMjyj3iMndWHjfyizz3AbHs=;
        b=kpgAwwzUtPH5sMXjFh3HjR2dj4dCqx0bpx9Q//oerZmbDVPyVfPwA/x8z7MPzMVl9bqokl
        X7ghLktnT5LWOHKnhfciA+DfaHMdaqutbYczqjftBc4wWWjYPCQFlUpD+s1+VdjdeWSY7H
        EEsBupxF1ahKrei5uKMNEly83tKT/pypSJw00ikdHozQ2uvIYLczQw1X0uHYI7TaPA2uHK
        3Wb1hcNRphwxuUkSxnp/u74GzLpef9bpPXyBrpPjQjxiU0wkDD8bqakJCEfyc2Su8vzq0w
        nuS+vvOgd+OEOUWYTniuHZjy78gt6sa/12Cg/xPF8XgatxsX19pu86SV+VMXIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1648975455;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=QmuM9CbNWBkcVUeot11rzMjyj3iMndWHjfyizz3AbHs=;
        b=OQrcAdKK8ls6A71J+7i0aVmMt2rP+XQb+ZI13KGr6nauciU9eD4cWmbqRkmmMDtHi1kw34
        2BvZu21Q8+TGuyBQ==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/urgent for v5.18-rc1
References: <164897466883.360450.8070511660014503126.tglx@xen13>
Message-ID: <164897467026.360450.9213450977031549110.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Sun,  3 Apr 2022 10:44:14 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2022-=
04-03

up to:  d6d6d50f1e80: x86/fpu/xstate: Consolidate size calculations


A set of x86 fixes and updates:

  - Make the prctl() for enabling dynamic XSTATE components correct so it
    adds the newly requested feature to the permission bitmap instead of
    overwriting it. Add a selftest which validates that.

  - Unroll string MMIO for encrypted SEV guests as the hypervisor cannot
    emulate it.

  - Handle supervisor states correctly in the FPU/XSTATE code so it takes
    the feature set of the fpstate buffer into account. The feature sets
    can differ between host and guest buffers. Guest buffers do not contain
    supervisor states. So far this was not an issue, but with enabling
    PASID it needs to be handled in the buffer offset calculation and in
    the permission bitmaps.

  - Avoid a gazillion of repeated CPUID invocations in by caching the values
    early in the FPU/XSTATE code.
 =20
  - Enable CONFIG_WERROR for X86.

  - Make the X86 defconfigs more useful by adapting them to Y2022 reality.

Thanks,

	tglx

------------------>
Borislav Petkov (1):
      x86/defconfig: Enable WERROR

Chang S. Bae (1):
      selftests/x86/amx: Update the ARCH_REQ_XCOMP_PERM test

Ingo Molnar (1):
      x86/config: Make the x86 defconfigs a bit more usable

Joerg Roedel (1):
      x86/sev: Unroll string mmio with CC_ATTR_GUEST_UNROLL_STRING_IO

Thomas Gleixner (7):
      x86/fpu: Remove redundant XCOMP_BV initialization
      x86/fpu: Remove unused supervisor only offsets
      x86/fpu/xsave: Initialize offset/size cache early
      x86/fpu: Cache xfeature flags from CPUID
      x86/fpu/xsave: Handle compacted offsets correctly with supervisor states
      x86/fpu/xstate: Handle supervisor states in XSTATE permissions
      x86/fpu/xstate: Consolidate size calculations

Yang Zhong (1):
      x86/fpu/xstate: Fix the ARCH_REQ_XCOMP_PERM implementation


 arch/x86/configs/i386_defconfig   |  50 ++++++---
 arch/x86/configs/x86_64_defconfig |  37 +++++--
 arch/x86/kernel/fpu/core.c        |   3 -
 arch/x86/kernel/fpu/xstate.c      | 216 ++++++++++++------------------------=
--
 arch/x86/lib/iomem.c              |  65 ++++++++++--
 tools/testing/selftests/x86/amx.c |  16 ++-
 6 files changed, 200 insertions(+), 187 deletions(-)

diff --git a/arch/x86/configs/i386_defconfig b/arch/x86/configs/i386_defconfig
index 71124cf8630c..98a4852ed6a0 100644
--- a/arch/x86/configs/i386_defconfig
+++ b/arch/x86/configs/i386_defconfig
@@ -1,5 +1,7 @@
+CONFIG_WERROR=3Dy
 CONFIG_SYSVIPC=3Dy
 CONFIG_POSIX_MQUEUE=3Dy
+CONFIG_USELIB=3Dy
 CONFIG_AUDIT=3Dy
 CONFIG_NO_HZ=3Dy
 CONFIG_HIGH_RES_TIMERS=3Dy
@@ -11,23 +13,30 @@ CONFIG_TASK_XACCT=3Dy
 CONFIG_TASK_IO_ACCOUNTING=3Dy
 CONFIG_LOG_BUF_SHIFT=3D18
 CONFIG_CGROUPS=3Dy
+CONFIG_BLK_CGROUP=3Dy
 CONFIG_CGROUP_SCHED=3Dy
+CONFIG_CGROUP_PIDS=3Dy
+CONFIG_CGROUP_RDMA=3Dy
 CONFIG_CGROUP_FREEZER=3Dy
+CONFIG_CGROUP_HUGETLB=3Dy
 CONFIG_CPUSETS=3Dy
+CONFIG_CGROUP_DEVICE=3Dy
 CONFIG_CGROUP_CPUACCT=3Dy
+CONFIG_CGROUP_PERF=3Dy
+CONFIG_CGROUP_MISC=3Dy
+CONFIG_CGROUP_DEBUG=3Dy
 CONFIG_BLK_DEV_INITRD=3Dy
+CONFIG_KALLSYMS_ALL=3Dy
 # CONFIG_COMPAT_BRK is not set
 CONFIG_PROFILING=3Dy
-# CONFIG_64BIT is not set
 CONFIG_SMP=3Dy
-CONFIG_X86_GENERIC=3Dy
-CONFIG_HPET_TIMER=3Dy
+CONFIG_HYPERVISOR_GUEST=3Dy
+CONFIG_PARAVIRT=3Dy
+CONFIG_NR_CPUS=3D8
 CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=3Dy
-CONFIG_X86_REBOOTFIXUPS=3Dy
 CONFIG_MICROCODE_AMD=3Dy
 CONFIG_X86_MSR=3Dy
 CONFIG_X86_CPUID=3Dy
-CONFIG_HIGHPTE=3Dy
 CONFIG_X86_CHECK_BIOS_CORRUPTION=3Dy
 # CONFIG_MTRR_SANITIZER is not set
 CONFIG_EFI=3Dy
@@ -43,12 +52,15 @@ CONFIG_ACPI_BGRT=3Dy
 CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE=3Dy
 CONFIG_CPU_FREQ_GOV_ONDEMAND=3Dy
 CONFIG_X86_ACPI_CPUFREQ=3Dy
-CONFIG_EFI_VARS=3Dy
 CONFIG_KPROBES=3Dy
 CONFIG_JUMP_LABEL=3Dy
+CONFIG_COMPAT_32BIT_TIME=3Dy
 CONFIG_MODULES=3Dy
 CONFIG_MODULE_UNLOAD=3Dy
 CONFIG_MODULE_FORCE_UNLOAD=3Dy
+CONFIG_BLK_CGROUP_IOLATENCY=3Dy
+CONFIG_BLK_CGROUP_IOCOST=3Dy
+CONFIG_BLK_CGROUP_IOPRIO=3Dy
 CONFIG_BINFMT_MISC=3Dy
 CONFIG_NET=3Dy
 CONFIG_PACKET=3Dy
@@ -103,12 +115,16 @@ CONFIG_IP6_NF_FILTER=3Dy
 CONFIG_IP6_NF_TARGET_REJECT=3Dy
 CONFIG_IP6_NF_MANGLE=3Dy
 CONFIG_NET_SCHED=3Dy
+CONFIG_NET_CLS_CGROUP=3Dy
 CONFIG_NET_EMATCH=3Dy
 CONFIG_NET_CLS_ACT=3Dy
+CONFIG_CGROUP_NET_PRIO=3Dy
 CONFIG_CFG80211=3Dy
 CONFIG_MAC80211=3Dy
 CONFIG_MAC80211_LEDS=3Dy
 CONFIG_RFKILL=3Dy
+CONFIG_NET_9P=3Dy
+CONFIG_NET_9P_VIRTIO=3Dy
 CONFIG_PCI=3Dy
 CONFIG_PCIEPORTBUS=3Dy
 CONFIG_PCI_MSI=3Dy
@@ -119,13 +135,16 @@ CONFIG_DEVTMPFS=3Dy
 CONFIG_DEVTMPFS_MOUNT=3Dy
 CONFIG_DEBUG_DEVRES=3Dy
 CONFIG_CONNECTOR=3Dy
+CONFIG_EFI_VARS=3Dy
+CONFIG_EFI_CAPSULE_LOADER=3Dy
 CONFIG_BLK_DEV_LOOP=3Dy
+CONFIG_VIRTIO_BLK=3Dy
 CONFIG_BLK_DEV_SD=3Dy
 CONFIG_BLK_DEV_SR=3Dy
 CONFIG_CHR_DEV_SG=3Dy
 CONFIG_SCSI_CONSTANTS=3Dy
 CONFIG_SCSI_SPI_ATTRS=3Dy
-# CONFIG_SCSI_LOWLEVEL is not set
+CONFIG_SCSI_VIRTIO=3Dy
 CONFIG_ATA=3Dy
 CONFIG_SATA_AHCI=3Dy
 CONFIG_ATA_PIIX=3Dy
@@ -143,6 +162,7 @@ CONFIG_MACINTOSH_DRIVERS=3Dy
 CONFIG_MAC_EMUMOUSEBTN=3Dy
 CONFIG_NETDEVICES=3Dy
 CONFIG_NETCONSOLE=3Dy
+CONFIG_VIRTIO_NET=3Dy
 CONFIG_BNX2=3Dy
 CONFIG_TIGON3=3Dy
 CONFIG_NET_TULIP=3Dy
@@ -170,6 +190,7 @@ CONFIG_SERIAL_8250_SHARE_IRQ=3Dy
 CONFIG_SERIAL_8250_DETECT_IRQ=3Dy
 CONFIG_SERIAL_8250_RSA=3Dy
 CONFIG_SERIAL_NONSTANDARD=3Dy
+CONFIG_VIRTIO_CONSOLE=3Dy
 CONFIG_HW_RANDOM=3Dy
 CONFIG_NVRAM=3Dy
 CONFIG_HPET=3Dy
@@ -181,12 +202,7 @@ CONFIG_AGP_AMD64=3Dy
 CONFIG_AGP_INTEL=3Dy
 CONFIG_DRM=3Dy
 CONFIG_DRM_I915=3Dy
-CONFIG_FB_MODE_HELPERS=3Dy
-CONFIG_FB_TILEBLITTING=3Dy
-CONFIG_FB_EFI=3Dy
-CONFIG_LOGO=3Dy
-# CONFIG_LOGO_LINUX_MONO is not set
-# CONFIG_LOGO_LINUX_VGA16 is not set
+CONFIG_DRM_VIRTIO_GPU=3Dy
 CONFIG_SOUND=3Dy
 CONFIG_SND=3Dy
 CONFIG_SND_HRTIMER=3Dy
@@ -219,6 +235,8 @@ CONFIG_USB_STORAGE=3Dy
 CONFIG_RTC_CLASS=3Dy
 # CONFIG_RTC_HCTOSYS is not set
 CONFIG_DMADEVICES=3Dy
+CONFIG_VIRTIO_PCI=3Dy
+CONFIG_VIRTIO_INPUT=3Dy
 CONFIG_EEEPC_LAPTOP=3Dy
 CONFIG_EXT4_FS=3Dy
 CONFIG_EXT4_FS_POSIX_ACL=3Dy
@@ -240,6 +258,7 @@ CONFIG_NFS_FS=3Dy
 CONFIG_NFS_V3_ACL=3Dy
 CONFIG_NFS_V4=3Dy
 CONFIG_ROOT_NFS=3Dy
+CONFIG_9P_FS=3Dy
 CONFIG_NLS_DEFAULT=3D"utf8"
 CONFIG_NLS_CODEPAGE_437=3Dy
 CONFIG_NLS_ASCII=3Dy
@@ -251,14 +270,15 @@ CONFIG_SECURITY_SELINUX=3Dy
 CONFIG_SECURITY_SELINUX_BOOTPARAM=3Dy
 CONFIG_SECURITY_SELINUX_DISABLE=3Dy
 CONFIG_PRINTK_TIME=3Dy
+CONFIG_FRAME_WARN=3D1024
 CONFIG_MAGIC_SYSRQ=3Dy
 CONFIG_DEBUG_KERNEL=3Dy
 CONFIG_DEBUG_STACK_USAGE=3Dy
-CONFIG_DEBUG_STACKOVERFLOW=3Dy
 # CONFIG_SCHED_DEBUG is not set
 CONFIG_SCHEDSTATS=3Dy
 CONFIG_BLK_DEV_IO_TRACE=3Dy
 CONFIG_PROVIDE_OHCI1394_DMA_INIT=3Dy
 CONFIG_EARLY_PRINTK_DBGP=3Dy
 CONFIG_DEBUG_BOOT_PARAMS=3Dy
-CONFIG_KALLSYMS_ALL=3Dy
+CONFIG_UNWINDER_FRAME_POINTER=3Dy
+# CONFIG_64BIT is not set
diff --git a/arch/x86/configs/x86_64_defconfig b/arch/x86/configs/x86_64_defc=
onfig
index 92b1169ec90b..69784505a7a8 100644
--- a/arch/x86/configs/x86_64_defconfig
+++ b/arch/x86/configs/x86_64_defconfig
@@ -1,3 +1,4 @@
+CONFIG_WERROR=3Dy
 CONFIG_SYSVIPC=3Dy
 CONFIG_POSIX_MQUEUE=3Dy
 CONFIG_AUDIT=3Dy
@@ -11,14 +12,25 @@ CONFIG_TASK_XACCT=3Dy
 CONFIG_TASK_IO_ACCOUNTING=3Dy
 CONFIG_LOG_BUF_SHIFT=3D18
 CONFIG_CGROUPS=3Dy
+CONFIG_BLK_CGROUP=3Dy
 CONFIG_CGROUP_SCHED=3Dy
+CONFIG_CGROUP_PIDS=3Dy
+CONFIG_CGROUP_RDMA=3Dy
 CONFIG_CGROUP_FREEZER=3Dy
+CONFIG_CGROUP_HUGETLB=3Dy
 CONFIG_CPUSETS=3Dy
+CONFIG_CGROUP_DEVICE=3Dy
 CONFIG_CGROUP_CPUACCT=3Dy
+CONFIG_CGROUP_PERF=3Dy
+CONFIG_CGROUP_MISC=3Dy
+CONFIG_CGROUP_DEBUG=3Dy
 CONFIG_BLK_DEV_INITRD=3Dy
+CONFIG_KALLSYMS_ALL=3Dy
 # CONFIG_COMPAT_BRK is not set
 CONFIG_PROFILING=3Dy
 CONFIG_SMP=3Dy
+CONFIG_HYPERVISOR_GUEST=3Dy
+CONFIG_PARAVIRT=3Dy
 CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=3Dy
 CONFIG_MICROCODE_AMD=3Dy
 CONFIG_X86_MSR=3Dy
@@ -41,12 +53,14 @@ CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE=3Dy
 CONFIG_CPU_FREQ_GOV_ONDEMAND=3Dy
 CONFIG_X86_ACPI_CPUFREQ=3Dy
 CONFIG_IA32_EMULATION=3Dy
-CONFIG_EFI_VARS=3Dy
 CONFIG_KPROBES=3Dy
 CONFIG_JUMP_LABEL=3Dy
 CONFIG_MODULES=3Dy
 CONFIG_MODULE_UNLOAD=3Dy
 CONFIG_MODULE_FORCE_UNLOAD=3Dy
+CONFIG_BLK_CGROUP_IOLATENCY=3Dy
+CONFIG_BLK_CGROUP_IOCOST=3Dy
+CONFIG_BLK_CGROUP_IOPRIO=3Dy
 CONFIG_BINFMT_MISC=3Dy
 CONFIG_NET=3Dy
 CONFIG_PACKET=3Dy
@@ -101,12 +115,16 @@ CONFIG_IP6_NF_FILTER=3Dy
 CONFIG_IP6_NF_TARGET_REJECT=3Dy
 CONFIG_IP6_NF_MANGLE=3Dy
 CONFIG_NET_SCHED=3Dy
+CONFIG_NET_CLS_CGROUP=3Dy
 CONFIG_NET_EMATCH=3Dy
 CONFIG_NET_CLS_ACT=3Dy
+CONFIG_CGROUP_NET_PRIO=3Dy
 CONFIG_CFG80211=3Dy
 CONFIG_MAC80211=3Dy
 CONFIG_MAC80211_LEDS=3Dy
 CONFIG_RFKILL=3Dy
+CONFIG_NET_9P=3Dy
+CONFIG_NET_9P_VIRTIO=3Dy
 CONFIG_PCI=3Dy
 CONFIG_PCIEPORTBUS=3Dy
 CONFIG_HOTPLUG_PCI=3Dy
@@ -116,13 +134,15 @@ CONFIG_DEVTMPFS=3Dy
 CONFIG_DEVTMPFS_MOUNT=3Dy
 CONFIG_DEBUG_DEVRES=3Dy
 CONFIG_CONNECTOR=3Dy
+CONFIG_EFI_VARS=3Dy
 CONFIG_BLK_DEV_LOOP=3Dy
+CONFIG_VIRTIO_BLK=3Dy
 CONFIG_BLK_DEV_SD=3Dy
 CONFIG_BLK_DEV_SR=3Dy
 CONFIG_CHR_DEV_SG=3Dy
 CONFIG_SCSI_CONSTANTS=3Dy
 CONFIG_SCSI_SPI_ATTRS=3Dy
-# CONFIG_SCSI_LOWLEVEL is not set
+CONFIG_SCSI_VIRTIO=3Dy
 CONFIG_ATA=3Dy
 CONFIG_SATA_AHCI=3Dy
 CONFIG_ATA_PIIX=3Dy
@@ -138,6 +158,7 @@ CONFIG_MACINTOSH_DRIVERS=3Dy
 CONFIG_MAC_EMUMOUSEBTN=3Dy
 CONFIG_NETDEVICES=3Dy
 CONFIG_NETCONSOLE=3Dy
+CONFIG_VIRTIO_NET=3Dy
 CONFIG_TIGON3=3Dy
 CONFIG_NET_TULIP=3Dy
 CONFIG_E100=3Dy
@@ -162,6 +183,7 @@ CONFIG_SERIAL_8250_SHARE_IRQ=3Dy
 CONFIG_SERIAL_8250_DETECT_IRQ=3Dy
 CONFIG_SERIAL_8250_RSA=3Dy
 CONFIG_SERIAL_NONSTANDARD=3Dy
+CONFIG_VIRTIO_CONSOLE=3Dy
 CONFIG_HW_RANDOM=3Dy
 # CONFIG_HW_RANDOM_INTEL is not set
 # CONFIG_HW_RANDOM_AMD is not set
@@ -175,12 +197,7 @@ CONFIG_AGP_AMD64=3Dy
 CONFIG_AGP_INTEL=3Dy
 CONFIG_DRM=3Dy
 CONFIG_DRM_I915=3Dy
-CONFIG_FB_MODE_HELPERS=3Dy
-CONFIG_FB_TILEBLITTING=3Dy
-CONFIG_FB_EFI=3Dy
-CONFIG_LOGO=3Dy
-# CONFIG_LOGO_LINUX_MONO is not set
-# CONFIG_LOGO_LINUX_VGA16 is not set
+CONFIG_DRM_VIRTIO_GPU=3Dy
 CONFIG_SOUND=3Dy
 CONFIG_SND=3Dy
 CONFIG_SND_HRTIMER=3Dy
@@ -213,6 +230,8 @@ CONFIG_USB_STORAGE=3Dy
 CONFIG_RTC_CLASS=3Dy
 # CONFIG_RTC_HCTOSYS is not set
 CONFIG_DMADEVICES=3Dy
+CONFIG_VIRTIO_PCI=3Dy
+CONFIG_VIRTIO_INPUT=3Dy
 CONFIG_EEEPC_LAPTOP=3Dy
 CONFIG_AMD_IOMMU=3Dy
 CONFIG_INTEL_IOMMU=3Dy
@@ -237,6 +256,7 @@ CONFIG_NFS_FS=3Dy
 CONFIG_NFS_V3_ACL=3Dy
 CONFIG_NFS_V4=3Dy
 CONFIG_ROOT_NFS=3Dy
+CONFIG_9P_FS=3Dy
 CONFIG_NLS_DEFAULT=3D"utf8"
 CONFIG_NLS_CODEPAGE_437=3Dy
 CONFIG_NLS_ASCII=3Dy
@@ -257,4 +277,3 @@ CONFIG_BLK_DEV_IO_TRACE=3Dy
 CONFIG_PROVIDE_OHCI1394_DMA_INIT=3Dy
 CONFIG_EARLY_PRINTK_DBGP=3Dy
 CONFIG_DEBUG_BOOT_PARAMS=3Dy
-CONFIG_KALLSYMS_ALL=3Dy
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 19821f027cb3..c049561f373a 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -415,9 +415,6 @@ int fpu_copy_uabi_to_guest_fpstate(struct fpu_guest *gfpu=
, const void *buf,
 		xpkru =3D get_xsave_addr(&kstate->regs.xsave, XFEATURE_PKRU);
 		*vpkru =3D xpkru->pkru;
 	}
-
-	/* Ensure that XCOMP_BV is set up for XSAVES */
-	xstate_init_xcomp_bv(&kstate->regs.xsave, kstate->xfeatures);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(fpu_copy_uabi_to_guest_fpstate);
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 7c7824ae7862..39e1c8626ab9 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -81,10 +81,10 @@ static unsigned int xstate_offsets[XFEATURE_MAX] __ro_aft=
er_init =3D
 	{ [ 0 ... XFEATURE_MAX - 1] =3D -1};
 static unsigned int xstate_sizes[XFEATURE_MAX] __ro_after_init =3D
 	{ [ 0 ... XFEATURE_MAX - 1] =3D -1};
-static unsigned int xstate_comp_offsets[XFEATURE_MAX] __ro_after_init =3D
-	{ [ 0 ... XFEATURE_MAX - 1] =3D -1};
-static unsigned int xstate_supervisor_only_offsets[XFEATURE_MAX] __ro_after_=
init =3D
-	{ [ 0 ... XFEATURE_MAX - 1] =3D -1};
+static unsigned int xstate_flags[XFEATURE_MAX] __ro_after_init;
+
+#define XSTATE_FLAG_SUPERVISOR	BIT(0)
+#define XSTATE_FLAG_ALIGNED64	BIT(1)
=20
 /*
  * Return whether the system supports a given xfeature.
@@ -124,17 +124,41 @@ int cpu_has_xfeatures(u64 xfeatures_needed, const char =
**feature_name)
 }
 EXPORT_SYMBOL_GPL(cpu_has_xfeatures);
=20
+static bool xfeature_is_aligned64(int xfeature_nr)
+{
+	return xstate_flags[xfeature_nr] & XSTATE_FLAG_ALIGNED64;
+}
+
 static bool xfeature_is_supervisor(int xfeature_nr)
 {
+	return xstate_flags[xfeature_nr] & XSTATE_FLAG_SUPERVISOR;
+}
+
+static unsigned int xfeature_get_offset(u64 xcomp_bv, int xfeature)
+{
+	unsigned int offs, i;
+
 	/*
-	 * Extended State Enumeration Sub-leaves (EAX =3D 0DH, ECX =3D n, n > 1)
-	 * returns ECX[0] set to (1) for a supervisor state, and cleared (0)
-	 * for a user state.
+	 * Non-compacted format and legacy features use the cached fixed
+	 * offsets.
 	 */
-	u32 eax, ebx, ecx, edx;
+	if (!cpu_feature_enabled(X86_FEATURE_XSAVES) || xfeature <=3D XFEATURE_SSE)
+		return xstate_offsets[xfeature];
=20
-	cpuid_count(XSTATE_CPUID, xfeature_nr, &eax, &ebx, &ecx, &edx);
-	return ecx & 1;
+	/*
+	 * Compacted format offsets depend on the actual content of the
+	 * compacted xsave area which is determined by the xcomp_bv header
+	 * field.
+	 */
+	offs =3D FXSAVE_SIZE + XSAVE_HDR_SIZE;
+	for_each_extended_xfeature(i, xcomp_bv) {
+		if (xfeature_is_aligned64(i))
+			offs =3D ALIGN(offs, 64);
+		if (i =3D=3D xfeature)
+			break;
+		offs +=3D xstate_sizes[i];
+	}
+	return offs;
 }
=20
 /*
@@ -182,7 +206,7 @@ static bool xfeature_enabled(enum xfeature xfeature)
  * Record the offsets and sizes of various xstates contained
  * in the XSAVE state memory layout.
  */
-static void __init setup_xstate_features(void)
+static void __init setup_xstate_cache(void)
 {
 	u32 eax, ebx, ecx, edx, i;
 	/* start at the beginning of the "extended state" */
@@ -205,6 +229,7 @@ static void __init setup_xstate_features(void)
 		cpuid_count(XSTATE_CPUID, i, &eax, &ebx, &ecx, &edx);
=20
 		xstate_sizes[i] =3D eax;
+		xstate_flags[i] =3D ecx;
=20
 		/*
 		 * If an xfeature is supervisor state, the offset in EBX is
@@ -263,94 +288,6 @@ static void __init print_xstate_features(void)
 	WARN_ON(nr >=3D XFEATURE_MAX);	\
 } while (0)
=20
-/*
- * We could cache this like xstate_size[], but we only use
- * it here, so it would be a waste of space.
- */
-static int xfeature_is_aligned(int xfeature_nr)
-{
-	u32 eax, ebx, ecx, edx;
-
-	CHECK_XFEATURE(xfeature_nr);
-
-	if (!xfeature_enabled(xfeature_nr)) {
-		WARN_ONCE(1, "Checking alignment of disabled xfeature %d\n",
-			  xfeature_nr);
-		return 0;
-	}
-
-	cpuid_count(XSTATE_CPUID, xfeature_nr, &eax, &ebx, &ecx, &edx);
-	/*
-	 * The value returned by ECX[1] indicates the alignment
-	 * of state component 'i' when the compacted format
-	 * of the extended region of an XSAVE area is used:
-	 */
-	return !!(ecx & 2);
-}
-
-/*
- * This function sets up offsets and sizes of all extended states in
- * xsave area. This supports both standard format and compacted format
- * of the xsave area.
- */
-static void __init setup_xstate_comp_offsets(void)
-{
-	unsigned int next_offset;
-	int i;
-
-	/*
-	 * The FP xstates and SSE xstates are legacy states. They are always
-	 * in the fixed offsets in the xsave area in either compacted form
-	 * or standard form.
-	 */
-	xstate_comp_offsets[XFEATURE_FP] =3D 0;
-	xstate_comp_offsets[XFEATURE_SSE] =3D offsetof(struct fxregs_state,
-						     xmm_space);
-
-	if (!cpu_feature_enabled(X86_FEATURE_XSAVES)) {
-		for_each_extended_xfeature(i, fpu_kernel_cfg.max_features)
-			xstate_comp_offsets[i] =3D xstate_offsets[i];
-		return;
-	}
-
-	next_offset =3D FXSAVE_SIZE + XSAVE_HDR_SIZE;
-
-	for_each_extended_xfeature(i, fpu_kernel_cfg.max_features) {
-		if (xfeature_is_aligned(i))
-			next_offset =3D ALIGN(next_offset, 64);
-
-		xstate_comp_offsets[i] =3D next_offset;
-		next_offset +=3D xstate_sizes[i];
-	}
-}
-
-/*
- * Setup offsets of a supervisor-state-only XSAVES buffer:
- *
- * The offsets stored in xstate_comp_offsets[] only work for one specific
- * value of the Requested Feature BitMap (RFBM).  In cases where a different
- * RFBM value is used, a different set of offsets is required.  This set of
- * offsets is for when RFBM=3Dxfeatures_mask_supervisor().
- */
-static void __init setup_supervisor_only_offsets(void)
-{
-	unsigned int next_offset;
-	int i;
-
-	next_offset =3D FXSAVE_SIZE + XSAVE_HDR_SIZE;
-
-	for_each_extended_xfeature(i, fpu_kernel_cfg.max_features) {
-		if (!xfeature_is_supervisor(i))
-			continue;
-
-		if (xfeature_is_aligned(i))
-			next_offset =3D ALIGN(next_offset, 64);
-
-		xstate_supervisor_only_offsets[i] =3D next_offset;
-		next_offset +=3D xstate_sizes[i];
-	}
-}
-
 /*
  * Print out xstate component offsets and sizes
  */
@@ -360,7 +297,8 @@ static void __init print_xstate_offset_size(void)
=20
 	for_each_extended_xfeature(i, fpu_kernel_cfg.max_features) {
 		pr_info("x86/fpu: xstate_offset[%d]: %4d, xstate_sizes[%d]: %4d\n",
-			 i, xstate_comp_offsets[i], i, xstate_sizes[i]);
+			i, xfeature_get_offset(fpu_kernel_cfg.max_features, i),
+			i, xstate_sizes[i]);
 	}
 }
=20
@@ -419,7 +357,6 @@ static void __init setup_init_fpu_buf(void)
 	if (!boot_cpu_has(X86_FEATURE_XSAVE))
 		return;
=20
-	setup_xstate_features();
 	print_xstate_features();
=20
 	xstate_init_xcomp_bv(&init_fpstate.regs.xsave, fpu_kernel_cfg.max_features);
@@ -448,25 +385,6 @@ static void __init setup_init_fpu_buf(void)
 	fxsave(&init_fpstate.regs.fxsave);
 }
=20
-static int xfeature_uncompacted_offset(int xfeature_nr)
-{
-	u32 eax, ebx, ecx, edx;
-
-	/*
-	 * Only XSAVES supports supervisor states and it uses compacted
-	 * format. Checking a supervisor state's uncompacted offset is
-	 * an error.
-	 */
-	if (XFEATURE_MASK_SUPERVISOR_ALL & BIT_ULL(xfeature_nr)) {
-		WARN_ONCE(1, "No fixed offset for xstate %d\n", xfeature_nr);
-		return -1;
-	}
-
-	CHECK_XFEATURE(xfeature_nr);
-	cpuid_count(XSTATE_CPUID, xfeature_nr, &eax, &ebx, &ecx, &edx);
-	return ebx;
-}
-
 int xfeature_size(int xfeature_nr)
 {
 	u32 eax, ebx, ecx, edx;
@@ -644,29 +562,15 @@ static bool __init check_xstate_against_struct(int nr)
=20
 static unsigned int xstate_calculate_size(u64 xfeatures, bool compacted)
 {
-	unsigned int size =3D FXSAVE_SIZE + XSAVE_HDR_SIZE;
-	int i;
+	unsigned int topmost =3D fls64(xfeatures) -  1;
+	unsigned int offset =3D xstate_offsets[topmost];
=20
-	for_each_extended_xfeature(i, xfeatures) {
-		/* Align from the end of the previous feature */
-		if (xfeature_is_aligned(i))
-			size =3D ALIGN(size, 64);
-		/*
-		 * In compacted format the enabled features are packed,
-		 * i.e. disabled features do not occupy space.
-		 *
-		 * In non-compacted format the offsets are fixed and
-		 * disabled states still occupy space in the memory buffer.
-		 */
-		if (!compacted)
-			size =3D xfeature_uncompacted_offset(i);
-		/*
-		 * Add the feature size even for non-compacted format
-		 * to make the end result correct
-		 */
-		size +=3D xfeature_size(i);
-	}
-	return size;
+	if (topmost <=3D XFEATURE_SSE)
+		return sizeof(struct xregs_state);
+
+	if (compacted)
+		offset =3D xfeature_get_offset(xfeatures, topmost);
+	return offset + xstate_sizes[topmost];
 }
=20
 /*
@@ -935,6 +839,10 @@ void __init fpu__init_system_xstate(unsigned int legacy_=
size)
=20
 	/* Enable xstate instructions to be able to continue with initialization: */
 	fpu__init_cpu_xstate();
+
+	/* Cache size, offset and flags for initialization */
+	setup_xstate_cache();
+
 	err =3D init_xstate_size();
 	if (err)
 		goto out_disable;
@@ -950,8 +858,6 @@ void __init fpu__init_system_xstate(unsigned int legacy_s=
ize)
 				  fpu_user_cfg.max_features);
=20
 	setup_init_fpu_buf();
-	setup_xstate_comp_offsets();
-	setup_supervisor_only_offsets();
=20
 	/*
 	 * Paranoia check whether something in the setup modified the
@@ -1006,13 +912,19 @@ void fpu__resume_cpu(void)
  */
 static void *__raw_xsave_addr(struct xregs_state *xsave, int xfeature_nr)
 {
-	if (!xfeature_enabled(xfeature_nr)) {
-		WARN_ON_FPU(1);
+	u64 xcomp_bv =3D xsave->header.xcomp_bv;
+
+	if (WARN_ON_ONCE(!xfeature_enabled(xfeature_nr)))
 		return NULL;
+
+	if (cpu_feature_enabled(X86_FEATURE_XSAVES)) {
+		if (WARN_ON_ONCE(!(xcomp_bv & BIT_ULL(xfeature_nr))))
+			return NULL;
 	}
=20
-	return (void *)xsave + xstate_comp_offsets[xfeature_nr];
+	return (void *)xsave + xfeature_get_offset(xcomp_bv, xfeature_nr);
 }
+
 /*
  * Given the xsave area and a state inside, this function returns the
  * address of the state.
@@ -1043,8 +955,9 @@ void *get_xsave_addr(struct xregs_state *xsave, int xfea=
ture_nr)
 	 * We should not ever be requesting features that we
 	 * have not enabled.
 	 */
-	WARN_ONCE(!(fpu_kernel_cfg.max_features & BIT_ULL(xfeature_nr)),
-		  "get of unsupported state");
+	if (WARN_ON_ONCE(!xfeature_enabled(xfeature_nr)))
+		return NULL;
+
 	/*
 	 * This assumes the last 'xsave*' instruction to
 	 * have requested that 'xfeature_nr' be saved.
@@ -1625,6 +1538,9 @@ static int __xstate_request_perm(u64 permitted, u64 req=
uested, bool guest)
=20
 	/* Calculate the resulting kernel state size */
 	mask =3D permitted | requested;
+	/* Take supervisor states into account on the host */
+	if (!guest)
+		mask |=3D xfeatures_mask_supervisor();
 	ksize =3D xstate_calculate_size(mask, compacted);
=20
 	/* Calculate the resulting user state size */
@@ -1639,7 +1555,7 @@ static int __xstate_request_perm(u64 permitted, u64 req=
uested, bool guest)
=20
 	perm =3D guest ? &fpu->guest_perm : &fpu->perm;
 	/* Pairs with the READ_ONCE() in xstate_get_group_perm() */
-	WRITE_ONCE(perm->__state_perm, requested);
+	WRITE_ONCE(perm->__state_perm, mask);
 	/* Protected by sighand lock */
 	perm->__state_size =3D ksize;
 	perm->__user_state_size =3D usize;
diff --git a/arch/x86/lib/iomem.c b/arch/x86/lib/iomem.c
index df50451d94ef..3e2f33fc33de 100644
--- a/arch/x86/lib/iomem.c
+++ b/arch/x86/lib/iomem.c
@@ -22,7 +22,7 @@ static __always_inline void rep_movs(void *to, const void *=
from, size_t n)
 		     : "memory");
 }
=20
-void memcpy_fromio(void *to, const volatile void __iomem *from, size_t n)
+static void string_memcpy_fromio(void *to, const volatile void __iomem *from=
, size_t n)
 {
 	if (unlikely(!n))
 		return;
@@ -38,9 +38,8 @@ void memcpy_fromio(void *to, const volatile void __iomem *f=
rom, size_t n)
 	}
 	rep_movs(to, (const void *)from, n);
 }
-EXPORT_SYMBOL(memcpy_fromio);
=20
-void memcpy_toio(volatile void __iomem *to, const void *from, size_t n)
+static void string_memcpy_toio(volatile void __iomem *to, const void *from, =
size_t n)
 {
 	if (unlikely(!n))
 		return;
@@ -56,14 +55,64 @@ void memcpy_toio(volatile void __iomem *to, const void *f=
rom, size_t n)
 	}
 	rep_movs((void *)to, (const void *) from, n);
 }
+
+static void unrolled_memcpy_fromio(void *to, const volatile void __iomem *fr=
om, size_t n)
+{
+	const volatile char __iomem *in =3D from;
+	char *out =3D to;
+	int i;
+
+	for (i =3D 0; i < n; ++i)
+		out[i] =3D readb(&in[i]);
+}
+
+static void unrolled_memcpy_toio(volatile void __iomem *to, const void *from=
, size_t n)
+{
+	volatile char __iomem *out =3D to;
+	const char *in =3D from;
+	int i;
+
+	for (i =3D 0; i < n; ++i)
+		writeb(in[i], &out[i]);
+}
+
+static void unrolled_memset_io(volatile void __iomem *a, int b, size_t c)
+{
+	volatile char __iomem *mem =3D a;
+	int i;
+
+	for (i =3D 0; i < c; ++i)
+		writeb(b, &mem[i]);
+}
+
+void memcpy_fromio(void *to, const volatile void __iomem *from, size_t n)
+{
+	if (cc_platform_has(CC_ATTR_GUEST_UNROLL_STRING_IO))
+		unrolled_memcpy_fromio(to, from, n);
+	else
+		string_memcpy_fromio(to, from, n);
+}
+EXPORT_SYMBOL(memcpy_fromio);
+
+void memcpy_toio(volatile void __iomem *to, const void *from, size_t n)
+{
+	if (cc_platform_has(CC_ATTR_GUEST_UNROLL_STRING_IO))
+		unrolled_memcpy_toio(to, from, n);
+	else
+		string_memcpy_toio(to, from, n);
+}
 EXPORT_SYMBOL(memcpy_toio);
=20
 void memset_io(volatile void __iomem *a, int b, size_t c)
 {
-	/*
-	 * TODO: memset can mangle the IO patterns quite a bit.
-	 * perhaps it would be better to use a dumb one:
-	 */
-	memset((void *)a, b, c);
+	if (cc_platform_has(CC_ATTR_GUEST_UNROLL_STRING_IO)) {
+		unrolled_memset_io(a, b, c);
+	} else {
+		/*
+		 * TODO: memset can mangle the IO patterns quite a bit.
+		 * perhaps it would be better to use a dumb one:
+		 */
+		memset((void *)a, b, c);
+	}
 }
 EXPORT_SYMBOL(memset_io);
diff --git a/tools/testing/selftests/x86/amx.c b/tools/testing/selftests/x86/=
amx.c
index 3615ef4a48bb..2189f0322d8b 100644
--- a/tools/testing/selftests/x86/amx.c
+++ b/tools/testing/selftests/x86/amx.c
@@ -368,9 +368,16 @@ static void req_xtiledata_perm(void)
=20
 static void validate_req_xcomp_perm(enum expected_result exp)
 {
-	unsigned long bitmask;
+	unsigned long bitmask, expected_bitmask;
 	long rc;
=20
+	rc =3D syscall(SYS_arch_prctl, ARCH_GET_XCOMP_PERM, &bitmask);
+	if (rc) {
+		fatal_error("prctl(ARCH_GET_XCOMP_PERM) error: %ld", rc);
+	} else if (!(bitmask & XFEATURE_MASK_XTILECFG)) {
+		fatal_error("ARCH_GET_XCOMP_PERM returns XFEATURE_XTILECFG off.");
+	}
+
 	rc =3D syscall(SYS_arch_prctl, ARCH_REQ_XCOMP_PERM, XFEATURE_XTILEDATA);
 	if (exp =3D=3D FAIL_EXPECTED) {
 		if (rc) {
@@ -383,10 +390,15 @@ static void validate_req_xcomp_perm(enum expected_resul=
t exp)
 		fatal_error("ARCH_REQ_XCOMP_PERM saw unexpected failure.\n");
 	}
=20
+	expected_bitmask =3D bitmask | XFEATURE_MASK_XTILEDATA;
+
 	rc =3D syscall(SYS_arch_prctl, ARCH_GET_XCOMP_PERM, &bitmask);
 	if (rc) {
 		fatal_error("prctl(ARCH_GET_XCOMP_PERM) error: %ld", rc);
-	} else if (bitmask & XFEATURE_MASK_XTILE) {
+	} else if (bitmask !=3D expected_bitmask) {
+		fatal_error("ARCH_REQ_XCOMP_PERM set a wrong bitmask: %lx, expected: %lx.\=
n",
+			    bitmask, expected_bitmask);
+	} else {
 		printf("\tARCH_REQ_XCOMP_PERM is successful.\n");
 	}
 }

