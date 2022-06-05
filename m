Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D63553DB07
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 11:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351029AbiFEJbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 05:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350969AbiFEJbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 05:31:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D064DF74
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 02:31:03 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1654421462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=oAlJjxoBptySWNVe/XYcpfjssL2B4XydOblVlpkAz/g=;
        b=MGX2aZ2/vb3Qz3nwFSO6ARJY/nxgeHF1qcPhSxefC4MQvRBv+tGr+/4w38BWTlZTkuhWFz
        mQhUMlq3F2OoM1YQtwrG9++gVuq+LbiGNRONIq23IEc0E4TuZeWTlNHqlUFvJuaQ8fEonY
        fKYG5lvMxxUEl4bSw11qSWzbQrYArTQAlmXVoaptfYnxHkc2059ah7a+ZrmfqSVzKZJ9Qj
        IkKZ1oXuRsy70IxtvgwyTEWyXs4UJ56sG3khw0BWoFCCtHQBzaoie2NNCrZC6qTwZOwEbD
        ubzv092scZm23jmdY1kOCpFesI+FTUJAOxzgng78KEi0978Ji4w29+XjCAmb5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1654421462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=oAlJjxoBptySWNVe/XYcpfjssL2B4XydOblVlpkAz/g=;
        b=+Je8cjdipGevZVj7xckhsouId7jape5po3OH8+gobwUrdEQKVaPuuFgV5RBifaup5Are/U
        eZXGusvEJtFE5OCg==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/microcode for v5.19-rc1
References: <165442136963.152751.14259048792272164569.tglx@xen13>
Message-ID: <165442137983.152751.6786767046026742462.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Sun,  5 Jun 2022 11:31:01 +0200 (CEST)
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

please pull the latest x86/microcode branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-microcode-20=
22-06-05

up to:  0c0fe08c7648: x86/microcode: Remove unnecessary perf callback


X86 microcode updates:

  - Disable late microcode loading by default. Unless the HW people get
    their act together and provide a required minimum version in the
    microcode header for making a halfways informed decision its just
    lottery and broken.

  - Warn and taint the kernel when microcode is loaded late

  - Remove the old unused microcode loader interface

  - Remove a redundant perf callback from the microcode loader

Thanks,

	tglx

------------------>
Borislav Petkov (4):
      x86/microcode: Rip out the OLD_INTERFACE
      x86/microcode: Default-disable late loading
      x86/microcode: Taint and warn on late loading
      x86/microcode: Remove unnecessary perf callback


 arch/x86/Kconfig                     |  15 +++--
 arch/x86/kernel/cpu/common.c         |   2 +
 arch/x86/kernel/cpu/microcode/core.c | 115 ++++-----------------------------=
--
 3 files changed, 20 insertions(+), 112 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 762a0b6ab8b6..976309d57a58 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1350,17 +1350,16 @@ config MICROCODE_AMD
 	  If you select this option, microcode patch loading support for AMD
 	  processors will be enabled.
=20
-config MICROCODE_OLD_INTERFACE
-	bool "Ancient loading interface (DEPRECATED)"
+config MICROCODE_LATE_LOADING
+	bool "Late microcode loading (DANGEROUS)"
 	default n
 	depends on MICROCODE
 	help
-	  DO NOT USE THIS! This is the ancient /dev/cpu/microcode interface
-	  which was used by userspace tools like iucode_tool and microcode.ctl.
-	  It is inadequate because it runs too late to be able to properly
-	  load microcode on a machine and it needs special tools. Instead, you
-	  should've switched to the early loading method with the initrd or
-	  builtin microcode by now: Documentation/x86/microcode.rst
+	  Loading microcode late, when the system is up and executing instructions
+	  is a tricky business and should be avoided if possible. Just the sequence
+	  of synchronizing all cores and SMT threads is one fragile dance which does
+	  not guarantee that cores might not softlock after the loading. Therefore,
+	  use this at your own risk. Late loading taints the kernel too.
=20
 config X86_MSR
 	tristate "/dev/cpu/*/msr - Model-specific register support"
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 2e9142797c99..c296cb1c0113 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2222,6 +2222,7 @@ void cpu_init_secondary(void)
 }
 #endif
=20
+#ifdef CONFIG_MICROCODE_LATE_LOADING
 /*
  * The microcode loader calls this upon late microcode load to recheck featu=
res,
  * only when microcode has been updated. Caller holds microcode_mutex and CPU
@@ -2251,6 +2252,7 @@ void microcode_check(void)
 	pr_warn("x86/CPU: CPU features have changed after loading microcode, but mi=
ght not take effect.\n");
 	pr_warn("x86/CPU: Please consider either early loading through initrd/built=
-in or a potential BIOS update.\n");
 }
+#endif
=20
 /*
  * Invoked from core CPU hotplug code after hotplug operations
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/micro=
code/core.c
index 239ff5fcec6a..ad57e0e4d674 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -373,101 +373,10 @@ static int apply_microcode_on_target(int cpu)
 	return ret;
 }
=20
-#ifdef CONFIG_MICROCODE_OLD_INTERFACE
-static int do_microcode_update(const void __user *buf, size_t size)
-{
-	int error =3D 0;
-	int cpu;
-
-	for_each_online_cpu(cpu) {
-		struct ucode_cpu_info *uci =3D ucode_cpu_info + cpu;
-		enum ucode_state ustate;
-
-		if (!uci->valid)
-			continue;
-
-		ustate =3D microcode_ops->request_microcode_user(cpu, buf, size);
-		if (ustate =3D=3D UCODE_ERROR) {
-			error =3D -1;
-			break;
-		} else if (ustate =3D=3D UCODE_NEW) {
-			apply_microcode_on_target(cpu);
-		}
-	}
-
-	return error;
-}
-
-static int microcode_open(struct inode *inode, struct file *file)
-{
-	return capable(CAP_SYS_RAWIO) ? stream_open(inode, file) : -EPERM;
-}
-
-static ssize_t microcode_write(struct file *file, const char __user *buf,
-			       size_t len, loff_t *ppos)
-{
-	ssize_t ret =3D -EINVAL;
-	unsigned long nr_pages =3D totalram_pages();
-
-	if ((len >> PAGE_SHIFT) > nr_pages) {
-		pr_err("too much data (max %ld pages)\n", nr_pages);
-		return ret;
-	}
-
-	cpus_read_lock();
-	mutex_lock(&microcode_mutex);
-
-	if (do_microcode_update(buf, len) =3D=3D 0)
-		ret =3D (ssize_t)len;
-
-	if (ret > 0)
-		perf_check_microcode();
-
-	mutex_unlock(&microcode_mutex);
-	cpus_read_unlock();
-
-	return ret;
-}
-
-static const struct file_operations microcode_fops =3D {
-	.owner			=3D THIS_MODULE,
-	.write			=3D microcode_write,
-	.open			=3D microcode_open,
-	.llseek		=3D no_llseek,
-};
-
-static struct miscdevice microcode_dev =3D {
-	.minor			=3D MICROCODE_MINOR,
-	.name			=3D "microcode",
-	.nodename		=3D "cpu/microcode",
-	.fops			=3D &microcode_fops,
-};
-
-static int __init microcode_dev_init(void)
-{
-	int error;
-
-	error =3D misc_register(&microcode_dev);
-	if (error) {
-		pr_err("can't misc_register on minor=3D%d\n", MICROCODE_MINOR);
-		return error;
-	}
-
-	return 0;
-}
-
-static void __exit microcode_dev_exit(void)
-{
-	misc_deregister(&microcode_dev);
-}
-#else
-#define microcode_dev_init()	0
-#define microcode_dev_exit()	do { } while (0)
-#endif
-
 /* fake device for request_firmware */
 static struct platform_device	*microcode_pdev;
=20
+#ifdef CONFIG_MICROCODE_LATE_LOADING
 /*
  * Late loading dance. Why the heavy-handed stomp_machine effort?
  *
@@ -584,6 +493,9 @@ static int microcode_reload_late(void)
 {
 	int ret;
=20
+	pr_err("Attempting late microcode loading - it is dangerous and taints the =
kernel.\n");
+	pr_err("You should switch to early loading, if possible.\n");
+
 	atomic_set(&late_cpus_in,  0);
 	atomic_set(&late_cpus_out, 0);
=20
@@ -632,9 +544,14 @@ static ssize_t reload_store(struct device *dev,
 	if (ret =3D=3D 0)
 		ret =3D size;
=20
+	add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
+
 	return ret;
 }
=20
+static DEVICE_ATTR_WO(reload);
+#endif
+
 static ssize_t version_show(struct device *dev,
 			struct device_attribute *attr, char *buf)
 {
@@ -651,7 +568,6 @@ static ssize_t pf_show(struct device *dev,
 	return sprintf(buf, "0x%x\n", uci->cpu_sig.pf);
 }
=20
-static DEVICE_ATTR_WO(reload);
 static DEVICE_ATTR(version, 0444, version_show, NULL);
 static DEVICE_ATTR(processor_flags, 0444, pf_show, NULL);
=20
@@ -804,7 +720,9 @@ static int mc_cpu_down_prep(unsigned int cpu)
 }
=20
 static struct attribute *cpu_root_microcode_attrs[] =3D {
+#ifdef CONFIG_MICROCODE_LATE_LOADING
 	&dev_attr_reload.attr,
+#endif
 	NULL
 };
=20
@@ -838,10 +756,7 @@ static int __init microcode_init(void)
=20
 	cpus_read_lock();
 	mutex_lock(&microcode_mutex);
-
 	error =3D subsys_interface_register(&mc_cpu_interface);
-	if (!error)
-		perf_check_microcode();
 	mutex_unlock(&microcode_mutex);
 	cpus_read_unlock();
=20
@@ -856,10 +771,6 @@ static int __init microcode_init(void)
 		goto out_driver;
 	}
=20
-	error =3D microcode_dev_init();
-	if (error)
-		goto out_ucode_group;
-
 	register_syscore_ops(&mc_syscore_ops);
 	cpuhp_setup_state_nocalls(CPUHP_AP_MICROCODE_LOADER, "x86/microcode:startin=
g",
 				  mc_cpu_starting, NULL);
@@ -870,10 +781,6 @@ static int __init microcode_init(void)
=20
 	return 0;
=20
- out_ucode_group:
-	sysfs_remove_group(&cpu_subsys.dev_root->kobj,
-			   &cpu_root_microcode_group);
-
  out_driver:
 	cpus_read_lock();
 	mutex_lock(&microcode_mutex);

