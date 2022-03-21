Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 263164E24F1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 12:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345004AbiCULEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 07:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346615AbiCULD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 07:03:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412ED14B85C
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 04:02:31 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647860549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=G4TekWzzwQgRg/dcb8odDFRMS0m7UxzUUoz5DOrcUuI=;
        b=Z+qrIVMyjZvmSEq67nLBvdR1Ti7FrXn7UV9+3pZRfm2IW6Dq4CC9l10VtDRM3m+Ky/65uC
        ieePwWnr2xoYrtZf/Pt2DOVzj1c/2qtmyDJnmh3P4p701E5vF+IQUEYNtuC6AXEwnBQPmC
        YvbhDiorf29bsK+89JA9fGN2E9TBzUzyXvJRwnnQUrVOrQbbh47dEhhrlYQZJhc1E68Jqp
        0f+Aq2PRtjDBinBnX2fN/iHXTbcyAHeRfA3hjgAnn53zbc/oets7wCW0zxTf3u2kx6yZAw
        vkZ8D09+C78Q17UviZo+sePKCJmu3JodtDanQ9aIf7wVBKMXwB8JAd1i4Dhtzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647860549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=G4TekWzzwQgRg/dcb8odDFRMS0m7UxzUUoz5DOrcUuI=;
        b=IzxHxfQHXqJULkFrFRLhw71ffxxgyLL/vj6/rjy5ZmW0kYWzwT8dPkbIR/znmeAfz+U8g/
        GA2RI2jZMimzk6AA==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/pasid for v5.18-rc1
References: <164786042536.122591.4459156564791679956.tglx@xen13>
Message-ID: <164786043190.122591.9314646033947786445.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Mon, 21 Mar 2022 12:02:29 +0100 (CET)
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

please pull the latest x86/pasid branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-pasid-2022-0=
3-21

up to:  83aa52ffed5d: Documentation/x86: Update documentation for SVA (Shared=
 Virtual Addressing)


Reenable ENQCMD/PASID support:

 - Simplify the PASID handling to allocate the PASID once, associate it to
   the mm of a process and free it on mm_exit(). The previous attempt of
   refcounted PASIDs and dynamic alloc()/free() turned out to be error
   prone and too complex. The PASID space is 20bits, so the case of
   resource exhaustion is a pure academic concern.

 - Populate the PASID MSR on demand via #GP to avoid racy updates via IPIs.

 - Reenable ENQCMD and let objtool check for the forbidden usage of ENQCMD
   in the kernel.

 - Update the documentation for Shared Virtual Addressing accordingly.


Thanks,

	tglx

------------------>
Fenghua Yu (10):
      iommu/sva: Rename CONFIG_IOMMU_SVA_LIB to CONFIG_IOMMU_SVA
      mm: Change CONFIG option for mm->pasid field
      iommu/ioasid: Introduce a helper to check for valid PASIDs
      kernel/fork: Initialize mm's PASID
      iommu/sva: Assign a PASID to mm on PASID allocation and free it on mm e=
xit
      x86/fpu: Clear PASID when copying fpstate
      x86/traps: Demand-populate PASID MSR via #GP
      x86/cpufeatures: Re-enable ENQCMD
      tools/objtool: Check for use of the ENQCMD instruction in the kernel
      Documentation/x86: Update documentation for SVA (Shared Virtual Address=
ing)

Peter Zijlstra (1):
      sched: Define and initialize a flag to identify valid PASID in the task


 Documentation/x86/sva.rst                       | 53 ++++++++++++++++++------
 arch/x86/include/asm/disabled-features.h        |  7 +++-
 arch/x86/kernel/fpu/core.c                      |  7 ++++
 arch/x86/kernel/traps.c                         | 55 +++++++++++++++++++++++=
++
 drivers/iommu/Kconfig                           |  6 +--
 drivers/iommu/Makefile                          |  2 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c |  5 +--
 drivers/iommu/intel/Kconfig                     |  2 +-
 drivers/iommu/intel/iommu.c                     |  4 +-
 drivers/iommu/intel/svm.c                       |  9 ----
 drivers/iommu/ioasid.c                          | 39 ++----------------
 drivers/iommu/iommu-sva-lib.c                   | 39 ++++++------------
 drivers/iommu/iommu-sva-lib.h                   |  7 ++--
 include/linux/ioasid.h                          | 21 +++++-----
 include/linux/mm_types.h                        |  2 +-
 include/linux/sched.h                           |  3 ++
 include/linux/sched/mm.h                        | 26 ++++++++++++
 kernel/fork.c                                   | 15 ++++---
 mm/init-mm.c                                    |  4 ++
 tools/objtool/arch/x86/decode.c                 | 11 ++++-
 20 files changed, 197 insertions(+), 120 deletions(-)

diff --git a/Documentation/x86/sva.rst b/Documentation/x86/sva.rst
index 076efd51ef1f..2e9b8b0f9a0f 100644
--- a/Documentation/x86/sva.rst
+++ b/Documentation/x86/sva.rst
@@ -104,18 +104,47 @@ The MSR must be configured on each logical CPU before a=
ny application
 thread can interact with a device. Threads that belong to the same
 process share the same page tables, thus the same MSR value.
=20
-PASID is cleared when a process is created. The PASID allocation and MSR
-programming may occur long after a process and its threads have been created.
-One thread must call iommu_sva_bind_device() to allocate the PASID for the
-process. If a thread uses ENQCMD without the MSR first being populated, a #GP
-will be raised. The kernel will update the PASID MSR with the PASID for all
-threads in the process. A single process PASID can be used simultaneously
-with multiple devices since they all share the same address space.
-
-One thread can call iommu_sva_unbind_device() to free the allocated PASID.
-The kernel will clear the PASID MSR for all threads belonging to the process.
-
-New threads inherit the MSR value from the parent.
+PASID Life Cycle Management
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
+
+PASID is initialized as INVALID_IOASID (-1) when a process is created.
+
+Only processes that access SVA-capable devices need to have a PASID
+allocated. This allocation happens when a process opens/binds an SVA-capable
+device but finds no PASID for this process. Subsequent binds of the same, or
+other devices will share the same PASID.
+
+Although the PASID is allocated to the process by opening a device,
+it is not active in any of the threads of that process. It's loaded to the
+IA32_PASID MSR lazily when a thread tries to submit a work descriptor
+to a device using the ENQCMD.
+
+That first access will trigger a #GP fault because the IA32_PASID MSR
+has not been initialized with the PASID value assigned to the process
+when the device was opened. The Linux #GP handler notes that a PASID has
+been allocated for the process, and so initializes the IA32_PASID MSR
+and returns so that the ENQCMD instruction is re-executed.
+
+On fork(2) or exec(2) the PASID is removed from the process as it no
+longer has the same address space that it had when the device was opened.
+
+On clone(2) the new task shares the same address space, so will be
+able to use the PASID allocated to the process. The IA32_PASID is not
+preemptively initialized as the PASID value might not be allocated yet or
+the kernel does not know whether this thread is going to access the device
+and the cleared IA32_PASID MSR reduces context switch overhead by xstate
+init optimization. Since #GP faults have to be handled on any threads that
+were created before the PASID was assigned to the mm of the process, newly
+created threads might as well be treated in a consistent way.
+
+Due to complexity of freeing the PASID and clearing all IA32_PASID MSRs in
+all threads in unbind, free the PASID lazily only on mm exit.
+
+If a process does a close(2) of the device file descriptor and munmap(2)
+of the device MMIO portal, then the driver will unbind the device. The
+PASID is still marked VALID in the PASID_MSR for any threads in the
+process that accessed the device. But this is harmless as without the
+MMIO portal they cannot submit new work to the device.
=20
 Relationships
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/=
disabled-features.h
index 8f28fafa98b3..1231d63f836d 100644
--- a/arch/x86/include/asm/disabled-features.h
+++ b/arch/x86/include/asm/disabled-features.h
@@ -56,8 +56,11 @@
 # define DISABLE_PTI		(1 << (X86_FEATURE_PTI & 31))
 #endif
=20
-/* Force disable because it's broken beyond repair */
-#define DISABLE_ENQCMD		(1 << (X86_FEATURE_ENQCMD & 31))
+#ifdef CONFIG_INTEL_IOMMU_SVM
+# define DISABLE_ENQCMD		0
+#else
+# define DISABLE_ENQCMD		(1 << (X86_FEATURE_ENQCMD & 31))
+#endif
=20
 #ifdef CONFIG_X86_SGX
 # define DISABLE_SGX	0
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 8dea01ffc5c1..19821f027cb3 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -612,6 +612,13 @@ int fpu_clone(struct task_struct *dst, unsigned long clo=
ne_flags)
 		fpu_inherit_perms(dst_fpu);
 	fpregs_unlock();
=20
+	/*
+	 * Children never inherit PASID state.
+	 * Force it to have its init value:
+	 */
+	if (use_xsave())
+		dst_fpu->fpstate->regs.xsave.header.xfeatures &=3D ~XFEATURE_MASK_PASID;
+
 	trace_x86_fpu_copy_src(src_fpu);
 	trace_x86_fpu_copy_dst(dst_fpu);
=20
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index c9d566dcf89a..7ef00dee35be 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -39,6 +39,7 @@
 #include <linux/io.h>
 #include <linux/hardirq.h>
 #include <linux/atomic.h>
+#include <linux/ioasid.h>
=20
 #include <asm/stacktrace.h>
 #include <asm/processor.h>
@@ -559,6 +560,57 @@ static bool fixup_iopl_exception(struct pt_regs *regs)
 	return true;
 }
=20
+/*
+ * The unprivileged ENQCMD instruction generates #GPs if the
+ * IA32_PASID MSR has not been populated.  If possible, populate
+ * the MSR from a PASID previously allocated to the mm.
+ */
+static bool try_fixup_enqcmd_gp(void)
+{
+#ifdef CONFIG_IOMMU_SVA
+	u32 pasid;
+
+	/*
+	 * MSR_IA32_PASID is managed using XSAVE.  Directly
+	 * writing to the MSR is only possible when fpregs
+	 * are valid and the fpstate is not.  This is
+	 * guaranteed when handling a userspace exception
+	 * in *before* interrupts are re-enabled.
+	 */
+	lockdep_assert_irqs_disabled();
+
+	/*
+	 * Hardware without ENQCMD will not generate
+	 * #GPs that can be fixed up here.
+	 */
+	if (!cpu_feature_enabled(X86_FEATURE_ENQCMD))
+		return false;
+
+	pasid =3D current->mm->pasid;
+
+	/*
+	 * If the mm has not been allocated a
+	 * PASID, the #GP can not be fixed up.
+	 */
+	if (!pasid_valid(pasid))
+		return false;
+
+	/*
+	 * Did this thread already have its PASID activated?
+	 * If so, the #GP must be from something else.
+	 */
+	if (current->pasid_activated)
+		return false;
+
+	wrmsrl(MSR_IA32_PASID, pasid | MSR_IA32_PASID_VALID);
+	current->pasid_activated =3D 1;
+
+	return true;
+#else
+	return false;
+#endif
+}
+
 DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
 {
 	char desc[sizeof(GPFSTR) + 50 + 2*sizeof(unsigned long) + 1] =3D GPFSTR;
@@ -567,6 +619,9 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
 	unsigned long gp_addr;
 	int ret;
=20
+	if (user_mode(regs) && try_fixup_enqcmd_gp())
+		return;
+
 	cond_local_irq_enable(regs);
=20
 	if (static_cpu_has(X86_FEATURE_UMIP)) {
diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 3eb68fa1b8cc..c79a0df090c0 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -144,8 +144,8 @@ config IOMMU_DMA
 	select IRQ_MSI_IOMMU
 	select NEED_SG_DMA_LENGTH
=20
-# Shared Virtual Addressing library
-config IOMMU_SVA_LIB
+# Shared Virtual Addressing
+config IOMMU_SVA
 	bool
 	select IOASID
=20
@@ -379,7 +379,7 @@ config ARM_SMMU_V3
 config ARM_SMMU_V3_SVA
 	bool "Shared Virtual Addressing support for the ARM SMMUv3"
 	depends on ARM_SMMU_V3
-	select IOMMU_SVA_LIB
+	select IOMMU_SVA
 	select MMU_NOTIFIER
 	help
 	  Support for sharing process address spaces with devices using the
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index bc7f730edbb0..44475a9b3eea 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -27,6 +27,6 @@ obj-$(CONFIG_FSL_PAMU) +=3D fsl_pamu.o fsl_pamu_domain.o
 obj-$(CONFIG_S390_IOMMU) +=3D s390-iommu.o
 obj-$(CONFIG_HYPERV_IOMMU) +=3D hyperv-iommu.o
 obj-$(CONFIG_VIRTIO_IOMMU) +=3D virtio-iommu.o
-obj-$(CONFIG_IOMMU_SVA_LIB) +=3D iommu-sva-lib.o io-pgfault.o
+obj-$(CONFIG_IOMMU_SVA) +=3D iommu-sva-lib.o io-pgfault.o
 obj-$(CONFIG_SPRD_IOMMU) +=3D sprd-iommu.o
 obj-$(CONFIG_APPLE_DART) +=3D apple-dart.o
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/=
arm/arm-smmu-v3/arm-smmu-v3-sva.c
index a737ba5f727e..22ddd05bbdcd 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -340,14 +340,12 @@ __arm_smmu_sva_bind(struct device *dev, struct mm_struc=
t *mm)
 	bond->smmu_mn =3D arm_smmu_mmu_notifier_get(smmu_domain, mm);
 	if (IS_ERR(bond->smmu_mn)) {
 		ret =3D PTR_ERR(bond->smmu_mn);
-		goto err_free_pasid;
+		goto err_free_bond;
 	}
=20
 	list_add(&bond->list, &master->bonds);
 	return &bond->sva;
=20
-err_free_pasid:
-	iommu_sva_free_pasid(mm);
 err_free_bond:
 	kfree(bond);
 	return ERR_PTR(ret);
@@ -377,7 +375,6 @@ void arm_smmu_sva_unbind(struct iommu_sva *handle)
 	if (refcount_dec_and_test(&bond->refs)) {
 		list_del(&bond->list);
 		arm_smmu_mmu_notifier_put(bond->smmu_mn);
-		iommu_sva_free_pasid(bond->mm);
 		kfree(bond);
 	}
 	mutex_unlock(&sva_lock);
diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
index 247d0f2d5fdf..39a06d245f12 100644
--- a/drivers/iommu/intel/Kconfig
+++ b/drivers/iommu/intel/Kconfig
@@ -52,7 +52,7 @@ config INTEL_IOMMU_SVM
 	select PCI_PRI
 	select MMU_NOTIFIER
 	select IOASID
-	select IOMMU_SVA_LIB
+	select IOMMU_SVA
 	help
 	  Shared Virtual Memory (SVM) provides a facility for devices
 	  to access DMA resources through process address space by
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 92fea3fbbb11..ef03b2176bbd 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4781,7 +4781,7 @@ static int aux_domain_add_dev(struct dmar_domain *domai=
n,
 link_failed:
 	spin_unlock_irqrestore(&device_domain_lock, flags);
 	if (list_empty(&domain->subdevices) && domain->default_pasid > 0)
-		ioasid_put(domain->default_pasid);
+		ioasid_free(domain->default_pasid);
=20
 	return ret;
 }
@@ -4811,7 +4811,7 @@ static void aux_domain_remove_dev(struct dmar_domain *d=
omain,
 	spin_unlock_irqrestore(&device_domain_lock, flags);
=20
 	if (list_empty(&domain->subdevices) && domain->default_pasid > 0)
-		ioasid_put(domain->default_pasid);
+		ioasid_free(domain->default_pasid);
 }
=20
 static int prepare_domain_attach_device(struct iommu_domain *domain,
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 5b5d69b04fcc..51ac2096b3da 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -514,11 +514,6 @@ static int intel_svm_alloc_pasid(struct device *dev, str=
uct mm_struct *mm,
 	return iommu_sva_alloc_pasid(mm, PASID_MIN, max_pasid - 1);
 }
=20
-static void intel_svm_free_pasid(struct mm_struct *mm)
-{
-	iommu_sva_free_pasid(mm);
-}
-
 static struct iommu_sva *intel_svm_bind_mm(struct intel_iommu *iommu,
 					   struct device *dev,
 					   struct mm_struct *mm,
@@ -662,8 +657,6 @@ static int intel_svm_unbind_mm(struct device *dev, u32 pa=
sid)
 				kfree(svm);
 			}
 		}
-		/* Drop a PASID reference and free it if no reference. */
-		intel_svm_free_pasid(mm);
 	}
 out:
 	return ret;
@@ -1047,8 +1040,6 @@ struct iommu_sva *intel_svm_bind(struct device *dev, st=
ruct mm_struct *mm, void
 	}
=20
 	sva =3D intel_svm_bind_mm(iommu, dev, mm, flags);
-	if (IS_ERR_OR_NULL(sva))
-		intel_svm_free_pasid(mm);
 	mutex_unlock(&pasid_mutex);
=20
 	return sva;
diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
index 06fee7416816..a786c034907c 100644
--- a/drivers/iommu/ioasid.c
+++ b/drivers/iommu/ioasid.c
@@ -2,7 +2,7 @@
 /*
  * I/O Address Space ID allocator. There is one global IOASID space, split i=
nto
  * subsets. Users create a subset with DECLARE_IOASID_SET, then allocate and
- * free IOASIDs with ioasid_alloc and ioasid_put.
+ * free IOASIDs with ioasid_alloc() and ioasid_free().
  */
 #include <linux/ioasid.h>
 #include <linux/module.h>
@@ -15,7 +15,6 @@ struct ioasid_data {
 	struct ioasid_set *set;
 	void *private;
 	struct rcu_head rcu;
-	refcount_t refs;
 };
=20
 /*
@@ -315,7 +314,6 @@ ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t mi=
n, ioasid_t max,
=20
 	data->set =3D set;
 	data->private =3D private;
-	refcount_set(&data->refs, 1);
=20
 	/*
 	 * Custom allocator needs allocator data to perform platform specific
@@ -348,35 +346,11 @@ ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t =
min, ioasid_t max,
 EXPORT_SYMBOL_GPL(ioasid_alloc);
=20
 /**
- * ioasid_get - obtain a reference to the IOASID
- * @ioasid: the ID to get
- */
-void ioasid_get(ioasid_t ioasid)
-{
-	struct ioasid_data *ioasid_data;
-
-	spin_lock(&ioasid_allocator_lock);
-	ioasid_data =3D xa_load(&active_allocator->xa, ioasid);
-	if (ioasid_data)
-		refcount_inc(&ioasid_data->refs);
-	else
-		WARN_ON(1);
-	spin_unlock(&ioasid_allocator_lock);
-}
-EXPORT_SYMBOL_GPL(ioasid_get);
-
-/**
- * ioasid_put - Release a reference to an ioasid
+ * ioasid_free - Free an ioasid
  * @ioasid: the ID to remove
- *
- * Put a reference to the IOASID, free it when the number of references drop=
s to
- * zero.
- *
- * Return: %true if the IOASID was freed, %false otherwise.
  */
-bool ioasid_put(ioasid_t ioasid)
+void ioasid_free(ioasid_t ioasid)
 {
-	bool free =3D false;
 	struct ioasid_data *ioasid_data;
=20
 	spin_lock(&ioasid_allocator_lock);
@@ -386,10 +360,6 @@ bool ioasid_put(ioasid_t ioasid)
 		goto exit_unlock;
 	}
=20
-	free =3D refcount_dec_and_test(&ioasid_data->refs);
-	if (!free)
-		goto exit_unlock;
-
 	active_allocator->ops->free(ioasid, active_allocator->ops->pdata);
 	/* Custom allocator needs additional steps to free the xa element */
 	if (active_allocator->flags & IOASID_ALLOCATOR_CUSTOM) {
@@ -399,9 +369,8 @@ bool ioasid_put(ioasid_t ioasid)
=20
 exit_unlock:
 	spin_unlock(&ioasid_allocator_lock);
-	return free;
 }
-EXPORT_SYMBOL_GPL(ioasid_put);
+EXPORT_SYMBOL_GPL(ioasid_free);
=20
 /**
  * ioasid_find - Find IOASID data
diff --git a/drivers/iommu/iommu-sva-lib.c b/drivers/iommu/iommu-sva-lib.c
index bd41405d34e9..106506143896 100644
--- a/drivers/iommu/iommu-sva-lib.c
+++ b/drivers/iommu/iommu-sva-lib.c
@@ -18,8 +18,7 @@ static DECLARE_IOASID_SET(iommu_sva_pasid);
  *
  * Try to allocate a PASID for this mm, or take a reference to the existing =
one
  * provided it fits within the [@min, @max] range. On success the PASID is
- * available in mm->pasid, and must be released with iommu_sva_free_pasid().
- * @min must be greater than 0, because 0 indicates an unused mm->pasid.
+ * available in mm->pasid and will be available for the lifetime of the mm.
  *
  * Returns 0 on success and < 0 on error.
  */
@@ -33,38 +32,24 @@ int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t =
min, ioasid_t max)
 		return -EINVAL;
=20
 	mutex_lock(&iommu_sva_lock);
-	if (mm->pasid) {
-		if (mm->pasid >=3D min && mm->pasid <=3D max)
-			ioasid_get(mm->pasid);
-		else
+	/* Is a PASID already associated with this mm? */
+	if (pasid_valid(mm->pasid)) {
+		if (mm->pasid < min || mm->pasid >=3D max)
 			ret =3D -EOVERFLOW;
-	} else {
-		pasid =3D ioasid_alloc(&iommu_sva_pasid, min, max, mm);
-		if (pasid =3D=3D INVALID_IOASID)
-			ret =3D -ENOMEM;
-		else
-			mm->pasid =3D pasid;
+		goto out;
 	}
+
+	pasid =3D ioasid_alloc(&iommu_sva_pasid, min, max, mm);
+	if (!pasid_valid(pasid))
+		ret =3D -ENOMEM;
+	else
+		mm_pasid_set(mm, pasid);
+out:
 	mutex_unlock(&iommu_sva_lock);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(iommu_sva_alloc_pasid);
=20
-/**
- * iommu_sva_free_pasid - Release the mm's PASID
- * @mm: the mm
- *
- * Drop one reference to a PASID allocated with iommu_sva_alloc_pasid()
- */
-void iommu_sva_free_pasid(struct mm_struct *mm)
-{
-	mutex_lock(&iommu_sva_lock);
-	if (ioasid_put(mm->pasid))
-		mm->pasid =3D 0;
-	mutex_unlock(&iommu_sva_lock);
-}
-EXPORT_SYMBOL_GPL(iommu_sva_free_pasid);
-
 /* ioasid_find getter() requires a void * argument */
 static bool __mmget_not_zero(void *mm)
 {
diff --git a/drivers/iommu/iommu-sva-lib.h b/drivers/iommu/iommu-sva-lib.h
index 031155010ca8..8909ea1094e3 100644
--- a/drivers/iommu/iommu-sva-lib.h
+++ b/drivers/iommu/iommu-sva-lib.h
@@ -9,7 +9,6 @@
 #include <linux/mm_types.h>
=20
 int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max);
-void iommu_sva_free_pasid(struct mm_struct *mm);
 struct mm_struct *iommu_sva_find(ioasid_t pasid);
=20
 /* I/O Page fault */
@@ -17,7 +16,7 @@ struct device;
 struct iommu_fault;
 struct iopf_queue;
=20
-#ifdef CONFIG_IOMMU_SVA_LIB
+#ifdef CONFIG_IOMMU_SVA
 int iommu_queue_iopf(struct iommu_fault *fault, void *cookie);
=20
 int iopf_queue_add_device(struct iopf_queue *queue, struct device *dev);
@@ -28,7 +27,7 @@ struct iopf_queue *iopf_queue_alloc(const char *name);
 void iopf_queue_free(struct iopf_queue *queue);
 int iopf_queue_discard_partial(struct iopf_queue *queue);
=20
-#else /* CONFIG_IOMMU_SVA_LIB */
+#else /* CONFIG_IOMMU_SVA */
 static inline int iommu_queue_iopf(struct iommu_fault *fault, void *cookie)
 {
 	return -ENODEV;
@@ -64,5 +63,5 @@ static inline int iopf_queue_discard_partial(struct iopf_qu=
eue *queue)
 {
 	return -ENODEV;
 }
-#endif /* CONFIG_IOMMU_SVA_LIB */
+#endif /* CONFIG_IOMMU_SVA */
 #endif /* _IOMMU_SVA_LIB_H */
diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
index e9dacd4b9f6b..af1c9d62e642 100644
--- a/include/linux/ioasid.h
+++ b/include/linux/ioasid.h
@@ -34,13 +34,16 @@ struct ioasid_allocator_ops {
 #if IS_ENABLED(CONFIG_IOASID)
 ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
 		      void *private);
-void ioasid_get(ioasid_t ioasid);
-bool ioasid_put(ioasid_t ioasid);
+void ioasid_free(ioasid_t ioasid);
 void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
 		  bool (*getter)(void *));
 int ioasid_register_allocator(struct ioasid_allocator_ops *allocator);
 void ioasid_unregister_allocator(struct ioasid_allocator_ops *allocator);
 int ioasid_set_data(ioasid_t ioasid, void *data);
+static inline bool pasid_valid(ioasid_t ioasid)
+{
+	return ioasid !=3D INVALID_IOASID;
+}
=20
 #else /* !CONFIG_IOASID */
 static inline ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min,
@@ -49,14 +52,7 @@ static inline ioasid_t ioasid_alloc(struct ioasid_set *set=
, ioasid_t min,
 	return INVALID_IOASID;
 }
=20
-static inline void ioasid_get(ioasid_t ioasid)
-{
-}
-
-static inline bool ioasid_put(ioasid_t ioasid)
-{
-	return false;
-}
+static inline void ioasid_free(ioasid_t ioasid) { }
=20
 static inline void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
 				bool (*getter)(void *))
@@ -78,5 +74,10 @@ static inline int ioasid_set_data(ioasid_t ioasid, void *d=
ata)
 	return -ENOTSUPP;
 }
=20
+static inline bool pasid_valid(ioasid_t ioasid)
+{
+	return false;
+}
+
 #endif /* CONFIG_IOASID */
 #endif /* __LINUX_IOASID_H */
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 5140e5feb486..c5cbfd7915ad 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -631,7 +631,7 @@ struct mm_struct {
 #endif
 		struct work_struct async_put_work;
=20
-#ifdef CONFIG_IOMMU_SUPPORT
+#ifdef CONFIG_IOMMU_SVA
 		u32 pasid;
 #endif
 	} __randomize_layout;
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 75ba8aa60248..4e5de3aed410 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -938,6 +938,9 @@ struct task_struct {
 	/* Recursion prevention for eventfd_signal() */
 	unsigned			in_eventfd_signal:1;
 #endif
+#ifdef CONFIG_IOMMU_SVA
+	unsigned			pasid_activated:1;
+#endif
=20
 	unsigned long			atomic_flags; /* Flags requiring atomic access. */
=20
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index aa5f09ca5bcf..a80356e9dc69 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -8,6 +8,7 @@
 #include <linux/mm_types.h>
 #include <linux/gfp.h>
 #include <linux/sync_core.h>
+#include <linux/ioasid.h>
=20
 /*
  * Routines for handling mm_structs
@@ -433,4 +434,29 @@ static inline void membarrier_update_current_mm(struct m=
m_struct *next_mm)
 }
 #endif
=20
+#ifdef CONFIG_IOMMU_SVA
+static inline void mm_pasid_init(struct mm_struct *mm)
+{
+	mm->pasid =3D INVALID_IOASID;
+}
+
+/* Associate a PASID with an mm_struct: */
+static inline void mm_pasid_set(struct mm_struct *mm, u32 pasid)
+{
+	mm->pasid =3D pasid;
+}
+
+static inline void mm_pasid_drop(struct mm_struct *mm)
+{
+	if (pasid_valid(mm->pasid)) {
+		ioasid_free(mm->pasid);
+		mm->pasid =3D INVALID_IOASID;
+	}
+}
+#else
+static inline void mm_pasid_init(struct mm_struct *mm) {}
+static inline void mm_pasid_set(struct mm_struct *mm, u32 pasid) {}
+static inline void mm_pasid_drop(struct mm_struct *mm) {}
+#endif
+
 #endif /* _LINUX_SCHED_MM_H */
diff --git a/kernel/fork.c b/kernel/fork.c
index d75a528f7b21..51fd1df994b7 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -97,6 +97,7 @@
 #include <linux/scs.h>
 #include <linux/io_uring.h>
 #include <linux/bpf.h>
+#include <linux/sched/mm.h>
=20
 #include <asm/pgalloc.h>
 #include <linux/uaccess.h>
@@ -967,6 +968,10 @@ static struct task_struct *dup_task_struct(struct task_s=
truct *orig, int node)
 	tsk->use_memdelay =3D 0;
 #endif
=20
+#ifdef CONFIG_IOMMU_SVA
+	tsk->pasid_activated =3D 0;
+#endif
+
 #ifdef CONFIG_MEMCG
 	tsk->active_memcg =3D NULL;
 #endif
@@ -1019,13 +1024,6 @@ static void mm_init_owner(struct mm_struct *mm, struct=
 task_struct *p)
 #endif
 }
=20
-static void mm_init_pasid(struct mm_struct *mm)
-{
-#ifdef CONFIG_IOMMU_SUPPORT
-	mm->pasid =3D INIT_PASID;
-#endif
-}
-
 static void mm_init_uprobes_state(struct mm_struct *mm)
 {
 #ifdef CONFIG_UPROBES
@@ -1054,7 +1052,7 @@ static struct mm_struct *mm_init(struct mm_struct *mm, =
struct task_struct *p,
 	mm_init_cpumask(mm);
 	mm_init_aio(mm);
 	mm_init_owner(mm, p);
-	mm_init_pasid(mm);
+	mm_pasid_init(mm);
 	RCU_INIT_POINTER(mm->exe_file, NULL);
 	mmu_notifier_subscriptions_init(mm);
 	init_tlb_flush_pending(mm);
@@ -1121,6 +1119,7 @@ static inline void __mmput(struct mm_struct *mm)
 	}
 	if (mm->binfmt)
 		module_put(mm->binfmt->module);
+	mm_pasid_drop(mm);
 	mmdrop(mm);
 }
=20
diff --git a/mm/init-mm.c b/mm/init-mm.c
index b4a6f38fb51d..fbe7844d0912 100644
--- a/mm/init-mm.c
+++ b/mm/init-mm.c
@@ -10,6 +10,7 @@
=20
 #include <linux/atomic.h>
 #include <linux/user_namespace.h>
+#include <linux/ioasid.h>
 #include <asm/mmu.h>
=20
 #ifndef INIT_MM_CONTEXT
@@ -38,6 +39,9 @@ struct mm_struct init_mm =3D {
 	.mmlist		=3D LIST_HEAD_INIT(init_mm.mmlist),
 	.user_ns	=3D &init_user_ns,
 	.cpu_bitmap	=3D CPU_BITS_NONE,
+#ifdef CONFIG_IOMMU_SVA
+	.pasid		=3D INVALID_IOASID,
+#endif
 	INIT_MM_CONTEXT(init_mm)
 };
=20
diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index c10ef78df050..479e769ca324 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -112,7 +112,7 @@ int arch_decode_instruction(struct objtool_file *file, co=
nst struct section *sec
 	const struct elf *elf =3D file->elf;
 	struct insn insn;
 	int x86_64, ret;
-	unsigned char op1, op2,
+	unsigned char op1, op2, op3,
 		      rex =3D 0, rex_b =3D 0, rex_r =3D 0, rex_w =3D 0, rex_x =3D 0,
 		      modrm =3D 0, modrm_mod =3D 0, modrm_rm =3D 0, modrm_reg =3D 0,
 		      sib =3D 0, /* sib_scale =3D 0, */ sib_index =3D 0, sib_base =3D 0;
@@ -139,6 +139,7 @@ int arch_decode_instruction(struct objtool_file *file, co=
nst struct section *sec
=20
 	op1 =3D insn.opcode.bytes[0];
 	op2 =3D insn.opcode.bytes[1];
+	op3 =3D insn.opcode.bytes[2];
=20
 	if (insn.rex_prefix.nbytes) {
 		rex =3D insn.rex_prefix.bytes[0];
@@ -491,6 +492,14 @@ int arch_decode_instruction(struct objtool_file *file, c=
onst struct section *sec
 			/* nopl/nopw */
 			*type =3D INSN_NOP;
=20
+		} else if (op2 =3D=3D 0x38 && op3 =3D=3D 0xf8) {
+			if (insn.prefixes.nbytes =3D=3D 1 &&
+			    insn.prefixes.bytes[0] =3D=3D 0xf2) {
+				/* ENQCMD cannot be used in the kernel. */
+				WARN("ENQCMD instruction at %s:%lx", sec->name,
+				     offset);
+			}
+
 		} else if (op2 =3D=3D 0xa0 || op2 =3D=3D 0xa8) {
=20
 			/* push fs/gs */

