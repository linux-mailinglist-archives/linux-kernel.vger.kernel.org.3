Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6057C4D4324
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 10:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240672AbiCJJIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 04:08:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240706AbiCJJH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 04:07:56 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0499F138588;
        Thu, 10 Mar 2022 01:06:53 -0800 (PST)
Received: from quad ([82.142.8.122]) by mrelayeu.kundenserver.de (mreue109
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1Macay-1nzdTZ3jWk-00c6Ge; Thu, 10
 Mar 2022 10:00:56 +0100
From:   Laurent Vivier <laurent@vivier.eu>
To:     linux-kernel@vger.kernel.org
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-rtc@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-m68k@lists.linux-m68k.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v15 5/5] m68k: introduce a virtual m68k machine
Date:   Thu, 10 Mar 2022 10:00:48 +0100
Message-Id: <20220310090048.1933020-6-laurent@vivier.eu>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220310090048.1933020-1-laurent@vivier.eu>
References: <20220310090048.1933020-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:o0W1bKbKVmAx1FzRBBTB+YRGPUh3Ef5CxlFCAHOo3q7f38K/ZGx
 p0FNCp2HVukKXvsm21kHUby73g6tReQoLSnE5Hiw4gRg3UjQ9VfStHviOhZ0SHRrT5V8pvZ
 TipfkZp0wJHGs0SAsuQKqAsQ84vkyohj9znP/zCWttyc69uei0jrFp6D01CSzAkjNexSuJM
 Qd7+B4qZwfAyGgvPY927w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:C02DYTLq1G4=:hccwqmO/XxrKL5jexhuPB3
 ZiyJdTsBMAuwRfh78gm54RDquDeC6jHTpiIxClf7UWGFZ4sLj3wjusEqN4hccmp6+IdKjJrNc
 06NbSUBVp0IMQQSJWdFHkwlSS6yxWla+24zyqiljXlrMZC7l7m/FsksqGHOc+C+UTQzBZOuvn
 PSTtTFdzEUti9o0GhPmSzbHyUcn70fU9vpUewm6CeIzFg/dBwJ5+2sKOnW4yHsywoPw41ky2M
 DafKum3lgXKnpgjzDj/c6WtUQ7R6cJ6Udwa1csPh39MJb/46PxVQLwF2r1pYiZL5BLCMZ+lfA
 Oh6f3L9YYlrPTILWefxNGRhbJbBjeTaKxI6wk0vLbtRmlCOraPflO4gPM+cSCSsnzUKn6Eq4Z
 oCb53SKLI/TwVPH1QVIgVouozwNBxLslZV9Uymm6iul/0+EVOrGcxvoEzz1Q9DuQIj50f/ojF
 CCZMBu+lZinWDCkz0uNyNRezLau1MP8Rwxqwx7mnDXBolAi310q5XSzdyMFikdckSu90ZXoOL
 c7qf+8bpBSIgvOp4Bo7WSydCcCLXrS7lMyOJp285ZEgzCC1mWCSmmsqsholNVG4p9sjobYjmj
 Zq+lRpNILXRk5YQ/Z6/WjFE8gvxbtWwzO+mDqhfd+R4z9vJY/a1iViAd+Hiesi60/EM/Xkwwo
 5XfQVkLoKICdJjgZ5pBrwnhgYMC6p1P7HgmgU6+3GBBV6fY3hsz5c1xXc3ZwZVKp4daA=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This machine allows to have up to 3.2 GiB and 128 Virtio devices.

It is based on android goldfish devices.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 arch/m68k/Kbuild                           |   1 +
 arch/m68k/Kconfig.machine                  |  17 +++
 arch/m68k/configs/virt_defconfig           |  68 +++++++++
 arch/m68k/include/asm/config.h             |   2 +
 arch/m68k/include/asm/io.h                 |   3 +
 arch/m68k/include/asm/irq.h                |   3 +-
 arch/m68k/include/asm/pgtable_mm.h         |   7 +
 arch/m68k/include/asm/setup.h              |  44 ++++--
 arch/m68k/include/asm/virt.h               |  25 ++++
 arch/m68k/include/uapi/asm/bootinfo-virt.h |  18 +++
 arch/m68k/include/uapi/asm/bootinfo.h      |   1 +
 arch/m68k/kernel/Makefile                  |   1 +
 arch/m68k/kernel/head.S                    |  31 +++++
 arch/m68k/kernel/setup_mm.c                |   7 +
 arch/m68k/mm/kmap.c                        |  21 ++-
 arch/m68k/virt/Makefile                    |   6 +
 arch/m68k/virt/config.c                    | 130 +++++++++++++++++
 arch/m68k/virt/ints.c                      | 155 +++++++++++++++++++++
 arch/m68k/virt/platform.c                  |  72 ++++++++++
 19 files changed, 595 insertions(+), 17 deletions(-)
 create mode 100644 arch/m68k/configs/virt_defconfig
 create mode 100644 arch/m68k/include/asm/virt.h
 create mode 100644 arch/m68k/include/uapi/asm/bootinfo-virt.h
 create mode 100644 arch/m68k/virt/Makefile
 create mode 100644 arch/m68k/virt/config.c
 create mode 100644 arch/m68k/virt/ints.c
 create mode 100644 arch/m68k/virt/platform.c

diff --git a/arch/m68k/Kbuild b/arch/m68k/Kbuild
index 18abb35c26a1..7762af9f6def 100644
--- a/arch/m68k/Kbuild
+++ b/arch/m68k/Kbuild
@@ -17,3 +17,4 @@ obj-$(CONFIG_M68060)		+= ifpsp060/
 obj-$(CONFIG_M68KFPU_EMU)	+= math-emu/
 obj-$(CONFIG_M68000)		+= 68000/
 obj-$(CONFIG_COLDFIRE)		+= coldfire/
+obj-$(CONFIG_VIRT)		+= virt/
diff --git a/arch/m68k/Kconfig.machine b/arch/m68k/Kconfig.machine
index eeab4f3e6c19..188a8f8a0104 100644
--- a/arch/m68k/Kconfig.machine
+++ b/arch/m68k/Kconfig.machine
@@ -149,6 +149,23 @@ config SUN3
 
 	  If you don't want to compile a kernel exclusively for a Sun 3, say N.
 
+config VIRT
+	bool "Virtual M68k Machine support"
+	depends on MMU
+	select GENERIC_CLOCKEVENTS
+	select GOLDFISH
+	select GOLDFISH_TIMER
+	select GOLDFISH_TTY
+	select M68040
+	select MMU_MOTOROLA if MMU
+	select RTC_CLASS
+	select RTC_DRV_GOLDFISH
+	select TTY
+	select VIRTIO_MMIO
+	help
+	  This options enable a pure virtual machine based on m68k,
+	  VIRTIO MMIO devices and GOLDFISH interfaces (TTY, RTC, PIC)
+
 config PILOT
 	bool
 
diff --git a/arch/m68k/configs/virt_defconfig b/arch/m68k/configs/virt_defconfig
new file mode 100644
index 000000000000..8059bd618370
--- /dev/null
+++ b/arch/m68k/configs/virt_defconfig
@@ -0,0 +1,68 @@
+CONFIG_LOCALVERSION="-virt"
+CONFIG_SYSVIPC=y
+CONFIG_CGROUPS=y
+CONFIG_BLK_CGROUP=y
+CONFIG_CGROUP_SCHED=y
+CONFIG_CGROUP_PIDS=y
+CONFIG_CGROUP_RDMA=y
+CONFIG_CGROUP_FREEZER=y
+CONFIG_CGROUP_DEVICE=y
+CONFIG_CGROUP_CPUACCT=y
+CONFIG_VIRT=y
+CONFIG_PROC_HARDWARE=y
+CONFIG_PARTITION_ADVANCED=y
+CONFIG_AMIGA_PARTITION=y
+CONFIG_ATARI_PARTITION=y
+CONFIG_MAC_PARTITION=y
+CONFIG_BSD_DISKLABEL=y
+CONFIG_MINIX_SUBPARTITION=y
+CONFIG_SOLARIS_X86_PARTITION=y
+CONFIG_UNIXWARE_DISKLABEL=y
+CONFIG_LDM_PARTITION=y
+CONFIG_LDM_DEBUG=y
+CONFIG_SUN_PARTITION=y
+CONFIG_SYSV68_PARTITION=y
+CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_UNIX=y
+CONFIG_INET=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+CONFIG_IP_PNP_BOOTP=y
+CONFIG_CGROUP_NET_PRIO=y
+CONFIG_CGROUP_NET_CLASSID=y
+CONFIG_NET_9P=y
+CONFIG_NET_9P_VIRTIO=y
+CONFIG_DEVTMPFS=y
+CONFIG_BLK_DEV_LOOP=y
+CONFIG_BLK_DEV_RAM=y
+CONFIG_VIRTIO_BLK=y
+CONFIG_SCSI=y
+CONFIG_BLK_DEV_SR=y
+CONFIG_SCSI_VIRTIO=y
+CONFIG_NETDEVICES=y
+CONFIG_VIRTIO_NET=y
+CONFIG_INPUT_MOUSEDEV=y
+CONFIG_INPUT_EVDEV=y
+CONFIG_VIRTIO_CONSOLE=y
+CONFIG_HW_RANDOM_VIRTIO=y
+CONFIG_DRM=y
+CONFIG_DRM_VIRTIO_GPU=y
+CONFIG_FB=y
+CONFIG_SOUND=y
+CONFIG_SND=y
+CONFIG_SND_VIRTIO=y
+CONFIG_VIRT_DRIVERS=y
+CONFIG_VIRTIO_INPUT=y
+CONFIG_EXT4_FS=y
+CONFIG_AUTOFS_FS=y
+CONFIG_ISO9660_FS=y
+CONFIG_JOLIET=y
+CONFIG_ZISOFS=y
+CONFIG_UDF_FS=y
+CONFIG_TMPFS=y
+CONFIG_TMPFS_POSIX_ACL=y
+CONFIG_9P_FS=y
+CONFIG_9P_FS_POSIX_ACL=y
+CONFIG_9P_FS_SECURITY=y
+CONFIG_EARLY_PRINTK=y
diff --git a/arch/m68k/include/asm/config.h b/arch/m68k/include/asm/config.h
index aae61070628b..b9dacc52f2c8 100644
--- a/arch/m68k/include/asm/config.h
+++ b/arch/m68k/include/asm/config.h
@@ -17,6 +17,7 @@ extern int mvme16x_parse_bootinfo(const struct bi_record *record);
 extern int mvme147_parse_bootinfo(const struct bi_record *record);
 extern int hp300_parse_bootinfo(const struct bi_record *record);
 extern int apollo_parse_bootinfo(const struct bi_record *record);
+extern int virt_parse_bootinfo(const struct bi_record *record);
 
 extern void config_amiga(void);
 extern void config_atari(void);
@@ -29,5 +30,6 @@ extern void config_bvme6000(void);
 extern void config_hp300(void);
 extern void config_q40(void);
 extern void config_sun3x(void);
+extern void config_virt(void);
 
 #endif /* _M68K_CONFIG_H */
diff --git a/arch/m68k/include/asm/io.h b/arch/m68k/include/asm/io.h
index aabe6420ead2..aaeabc65e63c 100644
--- a/arch/m68k/include/asm/io.h
+++ b/arch/m68k/include/asm/io.h
@@ -8,6 +8,9 @@
 #include <asm/io_mm.h>
 #endif
 
+#define gf_ioread32 ioread32be
+#define gf_iowrite32 iowrite32be
+
 #include <asm-generic/io.h>
 
 #endif /* _M68K_IO_H */
diff --git a/arch/m68k/include/asm/irq.h b/arch/m68k/include/asm/irq.h
index 91dd493791d7..7829e955ca04 100644
--- a/arch/m68k/include/asm/irq.h
+++ b/arch/m68k/include/asm/irq.h
@@ -12,7 +12,8 @@
  */
 #if defined(CONFIG_COLDFIRE)
 #define NR_IRQS 256
-#elif defined(CONFIG_VME) || defined(CONFIG_SUN3) || defined(CONFIG_SUN3X)
+#elif defined(CONFIG_VME) || defined(CONFIG_SUN3) || \
+      defined(CONFIG_SUN3X) || defined(CONFIG_VIRT)
 #define NR_IRQS 200
 #elif defined(CONFIG_ATARI)
 #define NR_IRQS 141
diff --git a/arch/m68k/include/asm/pgtable_mm.h b/arch/m68k/include/asm/pgtable_mm.h
index 143ba7de9bda..9b4e2fe2ac82 100644
--- a/arch/m68k/include/asm/pgtable_mm.h
+++ b/arch/m68k/include/asm/pgtable_mm.h
@@ -80,6 +80,9 @@
 #elif defined(CONFIG_COLDFIRE)
 #define KMAP_START	0xe0000000
 #define KMAP_END	0xf0000000
+#elif defined(CONFIG_VIRT)
+#define	KMAP_START	0xdf000000
+#define	KMAP_END	0xff000000
 #else
 #define	KMAP_START	0xd0000000
 #define	KMAP_END	0xf0000000
@@ -92,6 +95,10 @@ extern unsigned long m68k_vmalloc_end;
 #elif defined(CONFIG_COLDFIRE)
 #define VMALLOC_START	0xd0000000
 #define VMALLOC_END	0xe0000000
+#elif defined(CONFIG_VIRT)
+#define VMALLOC_OFFSET	PAGE_SIZE
+#define VMALLOC_START (((unsigned long) high_memory + VMALLOC_OFFSET) & ~(VMALLOC_OFFSET-1))
+#define VMALLOC_END     KMAP_START
 #else
 /* Just any arbitrary offset to the start of the vmalloc VM area: the
  * current 8MB value just means that there will be a 8MB "hole" after the
diff --git a/arch/m68k/include/asm/setup.h b/arch/m68k/include/asm/setup.h
index 8f2023f8c1c4..2c99477aaf89 100644
--- a/arch/m68k/include/asm/setup.h
+++ b/arch/m68k/include/asm/setup.h
@@ -37,7 +37,8 @@ extern unsigned long m68k_machtype;
 #elif defined(CONFIG_ATARI) || defined(CONFIG_MAC) || defined(CONFIG_APOLLO) \
 	|| defined(CONFIG_MVME16x) || defined(CONFIG_BVME6000)               \
 	|| defined(CONFIG_HP300) || defined(CONFIG_Q40)                      \
-	|| defined(CONFIG_SUN3X) || defined(CONFIG_MVME147)
+	|| defined(CONFIG_SUN3X) || defined(CONFIG_MVME147)                  \
+	|| defined(CONFIG_VIRT)
 #  define MACH_IS_AMIGA (m68k_machtype == MACH_AMIGA)
 #else
 #  define MACH_AMIGA_ONLY
@@ -50,7 +51,8 @@ extern unsigned long m68k_machtype;
 #elif defined(CONFIG_AMIGA) || defined(CONFIG_MAC) || defined(CONFIG_APOLLO) \
 	|| defined(CONFIG_MVME16x) || defined(CONFIG_BVME6000)               \
 	|| defined(CONFIG_HP300) || defined(CONFIG_Q40)                      \
-	|| defined(CONFIG_SUN3X) || defined(CONFIG_MVME147)
+	|| defined(CONFIG_SUN3X) || defined(CONFIG_MVME147)                  \
+	|| defined(CONFIG_VIRT)
 #  define MACH_IS_ATARI (m68k_machtype == MACH_ATARI)
 #else
 #  define MACH_ATARI_ONLY
@@ -63,7 +65,8 @@ extern unsigned long m68k_machtype;
 #elif defined(CONFIG_AMIGA) || defined(CONFIG_ATARI) || defined(CONFIG_APOLLO) \
 	|| defined(CONFIG_MVME16x) || defined(CONFIG_BVME6000)                 \
 	|| defined(CONFIG_HP300) || defined(CONFIG_Q40)                        \
-	|| defined(CONFIG_SUN3X) || defined(CONFIG_MVME147)
+	|| defined(CONFIG_SUN3X) || defined(CONFIG_MVME147)                    \
+	|| defined(CONFIG_VIRT)
 #  define MACH_IS_MAC (m68k_machtype == MACH_MAC)
 #else
 #  define MACH_MAC_ONLY
@@ -84,7 +87,8 @@ extern unsigned long m68k_machtype;
 #elif defined(CONFIG_AMIGA) || defined(CONFIG_MAC) || defined(CONFIG_ATARI) \
 	|| defined(CONFIG_MVME16x) || defined(CONFIG_BVME6000)              \
 	|| defined(CONFIG_HP300) || defined(CONFIG_Q40)                     \
-	|| defined(CONFIG_SUN3X) || defined(CONFIG_MVME147)
+	|| defined(CONFIG_SUN3X) || defined(CONFIG_MVME147)                 \
+	|| defined(CONFIG_VIRT)
 #  define MACH_IS_APOLLO (m68k_machtype == MACH_APOLLO)
 #else
 #  define MACH_APOLLO_ONLY
@@ -97,7 +101,8 @@ extern unsigned long m68k_machtype;
 #elif defined(CONFIG_AMIGA) || defined(CONFIG_MAC) || defined(CONFIG_ATARI) \
 	|| defined(CONFIG_APOLLO) || defined(CONFIG_BVME6000)               \
 	|| defined(CONFIG_HP300) || defined(CONFIG_Q40)                     \
-	|| defined(CONFIG_SUN3X) || defined(CONFIG_MVME16x)
+	|| defined(CONFIG_SUN3X) || defined(CONFIG_MVME16x)                 \
+	|| defined(CONFIG_VIRT)
 #  define MACH_IS_MVME147 (m68k_machtype == MACH_MVME147)
 #else
 #  define MACH_MVME147_ONLY
@@ -110,7 +115,8 @@ extern unsigned long m68k_machtype;
 #elif defined(CONFIG_AMIGA) || defined(CONFIG_MAC) || defined(CONFIG_ATARI) \
 	|| defined(CONFIG_APOLLO) || defined(CONFIG_BVME6000)               \
 	|| defined(CONFIG_HP300) || defined(CONFIG_Q40)                     \
-	|| defined(CONFIG_SUN3X) || defined(CONFIG_MVME147)
+	|| defined(CONFIG_SUN3X) || defined(CONFIG_MVME147)                 \
+	|| defined(CONFIG_VIRT)
 #  define MACH_IS_MVME16x (m68k_machtype == MACH_MVME16x)
 #else
 #  define MACH_MVME16x_ONLY
@@ -123,7 +129,8 @@ extern unsigned long m68k_machtype;
 #elif defined(CONFIG_AMIGA) || defined(CONFIG_MAC) || defined(CONFIG_ATARI) \
 	|| defined(CONFIG_APOLLO) || defined(CONFIG_MVME16x)                \
 	|| defined(CONFIG_HP300) || defined(CONFIG_Q40)                     \
-	|| defined(CONFIG_SUN3X) || defined(CONFIG_MVME147)
+	|| defined(CONFIG_SUN3X) || defined(CONFIG_MVME147)                 \
+	|| defined(CONFIG_VIRT)
 #  define MACH_IS_BVME6000 (m68k_machtype == MACH_BVME6000)
 #else
 #  define MACH_BVME6000_ONLY
@@ -136,7 +143,8 @@ extern unsigned long m68k_machtype;
 #elif defined(CONFIG_AMIGA) || defined(CONFIG_MAC) || defined(CONFIG_ATARI) \
 	|| defined(CONFIG_APOLLO) || defined(CONFIG_MVME16x) \
 	|| defined(CONFIG_BVME6000) || defined(CONFIG_Q40) \
-	|| defined(CONFIG_SUN3X) || defined(CONFIG_MVME147)
+	|| defined(CONFIG_SUN3X) || defined(CONFIG_MVME147) \
+	|| defined(CONFIG_VIRT)
 #  define MACH_IS_HP300 (m68k_machtype == MACH_HP300)
 #else
 #  define MACH_HP300_ONLY
@@ -149,7 +157,8 @@ extern unsigned long m68k_machtype;
 #elif defined(CONFIG_AMIGA) || defined(CONFIG_MAC) || defined(CONFIG_ATARI) \
 	|| defined(CONFIG_APOLLO) || defined(CONFIG_MVME16x)                \
 	|| defined(CONFIG_BVME6000) || defined(CONFIG_HP300)                \
-	|| defined(CONFIG_SUN3X) || defined(CONFIG_MVME147)
+	|| defined(CONFIG_SUN3X) || defined(CONFIG_MVME147)                 \
+	|| defined(CONFIG_VIRT)
 #  define MACH_IS_Q40 (m68k_machtype == MACH_Q40)
 #else
 #  define MACH_Q40_ONLY
@@ -162,7 +171,8 @@ extern unsigned long m68k_machtype;
 #elif defined(CONFIG_AMIGA) || defined(CONFIG_MAC) || defined(CONFIG_ATARI) \
 	|| defined(CONFIG_APOLLO) || defined(CONFIG_MVME16x)                \
 	|| defined(CONFIG_BVME6000) || defined(CONFIG_HP300)                \
-	|| defined(CONFIG_Q40) || defined(CONFIG_MVME147)
+	|| defined(CONFIG_Q40) || defined(CONFIG_MVME147)                   \
+	|| defined(CONFIG_VIRT)
 #  define MACH_IS_SUN3X (m68k_machtype == MACH_SUN3X)
 #else
 #  define CONFIG_SUN3X_ONLY
@@ -170,6 +180,20 @@ extern unsigned long m68k_machtype;
 #  define MACH_TYPE (MACH_SUN3X)
 #endif
 
+#if !defined(CONFIG_VIRT)
+#  define MACH_IS_VIRT (0)
+#elif defined(CONFIG_AMIGA) || defined(CONFIG_MAC) || defined(CONFIG_ATARI) \
+	|| defined(CONFIG_APOLLO) || defined(CONFIG_MVME16x)                \
+	|| defined(CONFIG_BVME6000) || defined(CONFIG_HP300)                \
+	|| defined(CONFIG_Q40) || defined(CONFIG_SUN3X)                     \
+	|| defined(CONFIG_MVME147)
+#  define MACH_IS_VIRT (m68k_machtype == MACH_VIRT)
+#else
+#  define MACH_VIRT_ONLY
+#  define MACH_IS_VIRT (1)
+#  define MACH_TYPE (MACH_VIRT)
+#endif
+
 #ifndef MACH_TYPE
 #  define MACH_TYPE (m68k_machtype)
 #endif
diff --git a/arch/m68k/include/asm/virt.h b/arch/m68k/include/asm/virt.h
new file mode 100644
index 000000000000..d3320c954796
--- /dev/null
+++ b/arch/m68k/include/asm/virt.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_VIRT_H
+#define __ASM_VIRT_H
+
+#define NUM_VIRT_SOURCES 200
+
+struct virt_booter_device_data {
+	u32 mmio;
+	u32 irq;
+};
+
+struct virt_booter_data {
+	u32 qemu_version;
+	struct virt_booter_device_data pic;
+	struct virt_booter_device_data rtc;
+	struct virt_booter_device_data tty;
+	struct virt_booter_device_data ctrl;
+	struct virt_booter_device_data virtio;
+};
+
+extern struct virt_booter_data virt_bi_data;
+
+extern void __init virt_init_IRQ(void);
+
+#endif
diff --git a/arch/m68k/include/uapi/asm/bootinfo-virt.h b/arch/m68k/include/uapi/asm/bootinfo-virt.h
new file mode 100644
index 000000000000..e4db7e2213ab
--- /dev/null
+++ b/arch/m68k/include/uapi/asm/bootinfo-virt.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * asm/bootinfo-virt.h -- Virtual-m68k-specific boot information definitions
+ */
+
+#ifndef _UAPI_ASM_M68K_BOOTINFO_VIRT_H
+#define _UAPI_ASM_M68K_BOOTINFO_VIRT_H
+
+#define BI_VIRT_QEMU_VERSION	0x8000
+#define BI_VIRT_GF_PIC_BASE	0x8001
+#define BI_VIRT_GF_RTC_BASE	0x8002
+#define BI_VIRT_GF_TTY_BASE	0x8003
+#define BI_VIRT_VIRTIO_BASE	0x8004
+#define BI_VIRT_CTRL_BASE	0x8005
+
+#define VIRT_BOOTI_VERSION	MK_BI_VERSION(2, 0)
+
+#endif /* _UAPI_ASM_M68K_BOOTINFO_MAC_H */
diff --git a/arch/m68k/include/uapi/asm/bootinfo.h b/arch/m68k/include/uapi/asm/bootinfo.h
index 38d3140381fa..203d9cbf9630 100644
--- a/arch/m68k/include/uapi/asm/bootinfo.h
+++ b/arch/m68k/include/uapi/asm/bootinfo.h
@@ -83,6 +83,7 @@ struct mem_info {
 #define MACH_SUN3X		11
 #define MACH_M54XX		12
 #define MACH_M5441X		13
+#define MACH_VIRT		14
 
 
     /*
diff --git a/arch/m68k/kernel/Makefile b/arch/m68k/kernel/Makefile
index dbac7f8743fc..c0833da6a2ca 100644
--- a/arch/m68k/kernel/Makefile
+++ b/arch/m68k/kernel/Makefile
@@ -11,6 +11,7 @@ extra-$(CONFIG_VME)	:= head.o
 extra-$(CONFIG_HP300)	:= head.o
 extra-$(CONFIG_Q40)	:= head.o
 extra-$(CONFIG_SUN3X)	:= head.o
+extra-$(CONFIG_VIRT)	:= head.o
 extra-$(CONFIG_SUN3)	:= sun3-head.o
 extra-y			+= vmlinux.lds
 
diff --git a/arch/m68k/kernel/head.S b/arch/m68k/kernel/head.S
index 493c95db0e51..9e812d8606be 100644
--- a/arch/m68k/kernel/head.S
+++ b/arch/m68k/kernel/head.S
@@ -262,6 +262,7 @@
 #include <asm/bootinfo-hp300.h>
 #include <asm/bootinfo-mac.h>
 #include <asm/bootinfo-q40.h>
+#include <asm/bootinfo-virt.h>
 #include <asm/bootinfo-vme.h>
 #include <asm/setup.h>
 #include <asm/entry.h>
@@ -534,6 +535,7 @@ func_define	putn,1
 #define is_not_apollo(lab) cmpl &MACH_APOLLO,%pc@(m68k_machtype); jne lab
 #define is_not_q40(lab) cmpl &MACH_Q40,%pc@(m68k_machtype); jne lab
 #define is_not_sun3x(lab) cmpl &MACH_SUN3X,%pc@(m68k_machtype); jne lab
+#define is_not_virt(lab) cmpl &MACH_VIRT,%pc@(m68k_machtype); jne lab
 
 #define hasnt_leds(lab) cmpl &MACH_HP300,%pc@(m68k_machtype); \
 			jeq 42f; \
@@ -647,6 +649,14 @@ ENTRY(__start)
 L(test_notmac):
 #endif /* CONFIG_MAC */
 
+#ifdef CONFIG_VIRT
+	is_not_virt(L(test_notvirt))
+
+	get_bi_record BI_VIRT_GF_TTY_BASE
+	lea	%pc@(L(virt_gf_tty_base)),%a1
+	movel	%a0@,%a1@
+L(test_notvirt):
+#endif /* CONFIG_VIRT */
 
 /*
  * There are ultimately two pieces of information we want for all kinds of
@@ -1237,6 +1247,13 @@ L(mmu_init_not_mac):
 L(notsun3x):
 #endif
 
+#ifdef CONFIG_VIRT
+	is_not_virt(L(novirt))
+	mmu_map_tt	#1,#0xFF000000,#0x01000000,#_PAGE_NOCACHE_S
+	jbra    L(mmu_init_done)
+L(novirt):
+#endif
+
 #ifdef CONFIG_APOLLO
 	is_not_apollo(L(notapollo))
 
@@ -3186,6 +3203,14 @@ func_start	serial_putc,%d0/%d1/%a0/%a1
 3:
 #endif
 
+#ifdef CONFIG_VIRT
+	is_not_virt(1f)
+
+	movel L(virt_gf_tty_base),%a1
+	movel %d0,%a1@(GF_PUT_CHAR)
+1:
+#endif
+
 L(serial_putc_done):
 func_return	serial_putc
 
@@ -3865,3 +3890,9 @@ q40_mem_cptr:
 L(q40_do_debug):
 	.long	0
 #endif
+
+#if defined(CONFIG_VIRT)
+GF_PUT_CHAR = 0x00
+L(virt_gf_tty_base):
+	.long 0
+#endif /* CONFIG_VIRT */
diff --git a/arch/m68k/kernel/setup_mm.c b/arch/m68k/kernel/setup_mm.c
index 8228275aae3e..39ba09ccb538 100644
--- a/arch/m68k/kernel/setup_mm.c
+++ b/arch/m68k/kernel/setup_mm.c
@@ -182,6 +182,8 @@ static void __init m68k_parse_bootinfo(const struct bi_record *record)
 				unknown = hp300_parse_bootinfo(record);
 			else if (MACH_IS_APOLLO)
 				unknown = apollo_parse_bootinfo(record);
+			else if (MACH_IS_VIRT)
+				unknown = virt_parse_bootinfo(record);
 			else
 				unknown = 1;
 		}
@@ -312,6 +314,11 @@ void __init setup_arch(char **cmdline_p)
 		cf_mmu_context_init();
 		config_BSP(NULL, 0);
 		break;
+#endif
+#ifdef CONFIG_VIRT
+	case MACH_VIRT:
+		config_virt();
+		break;
 #endif
 	default:
 		panic("No configuration setup");
diff --git a/arch/m68k/mm/kmap.c b/arch/m68k/mm/kmap.c
index 20ddf71b43d0..7594a945732b 100644
--- a/arch/m68k/mm/kmap.c
+++ b/arch/m68k/mm/kmap.c
@@ -179,6 +179,12 @@ void __iomem *__ioremap(unsigned long physaddr, unsigned long size, int cachefla
 			return (void __iomem *)physaddr;
 	}
 #endif
+#ifdef CONFIG_VIRT
+	if (MACH_IS_VIRT) {
+		if (physaddr >= 0xff000000 && cacheflag == IOMAP_NOCACHE_SER)
+			return (void __iomem *)physaddr;
+	}
+#endif
 #ifdef CONFIG_COLDFIRE
 	if (__cf_internalio(physaddr))
 		return (void __iomem *) physaddr;
@@ -293,17 +299,20 @@ EXPORT_SYMBOL(__ioremap);
 void iounmap(void __iomem *addr)
 {
 #ifdef CONFIG_AMIGA
-	if ((!MACH_IS_AMIGA) ||
-	    (((unsigned long)addr < 0x40000000) ||
-	     ((unsigned long)addr > 0x60000000)))
-			free_io_area((__force void *)addr);
-#else
+	if (MACH_IS_AMIGA &&
+	    ((unsigned long)addr >= 0x40000000) &&
+	    ((unsigned long)addr < 0x60000000))
+		return;
+#endif
+#ifdef CONFIG_VIRT
+	if (MACH_IS_VIRT && (unsigned long)addr >= 0xff000000)
+		return;
+#endif
 #ifdef CONFIG_COLDFIRE
 	if (cf_internalio(addr))
 		return;
 #endif
 	free_io_area((__force void *)addr);
-#endif
 }
 EXPORT_SYMBOL(iounmap);
 
diff --git a/arch/m68k/virt/Makefile b/arch/m68k/virt/Makefile
new file mode 100644
index 000000000000..54b9b2866654
--- /dev/null
+++ b/arch/m68k/virt/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Makefile for Linux arch/m68k/virt source directory
+#
+
+obj-y		:= config.o ints.o platform.o
diff --git a/arch/m68k/virt/config.c b/arch/m68k/virt/config.c
new file mode 100644
index 000000000000..68d29c8b87e1
--- /dev/null
+++ b/arch/m68k/virt/config.c
@@ -0,0 +1,130 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/serial_core.h>
+#include <clocksource/timer-goldfish.h>
+
+#include <asm/bootinfo.h>
+#include <asm/bootinfo-virt.h>
+#include <asm/byteorder.h>
+#include <asm/machdep.h>
+#include <asm/virt.h>
+#include <asm/config.h>
+
+struct virt_booter_data virt_bi_data;
+
+#define VIRT_CTRL_REG_FEATURES	0x00
+#define VIRT_CTRL_REG_CMD	0x04
+
+static struct resource ctrlres;
+
+enum {
+	CMD_NOOP,
+	CMD_RESET,
+	CMD_HALT,
+	CMD_PANIC,
+};
+
+static void virt_get_model(char *str)
+{
+	/* str is 80 characters long */
+	sprintf(str, "QEMU Virtual M68K Machine (%u.%u.%u)",
+		(u8)(virt_bi_data.qemu_version >> 24),
+		(u8)(virt_bi_data.qemu_version >> 16),
+		(u8)(virt_bi_data.qemu_version >> 8));
+}
+
+static void virt_halt(void)
+{
+	void __iomem *base = (void __iomem *)virt_bi_data.ctrl.mmio;
+
+	iowrite32be(CMD_HALT, base + VIRT_CTRL_REG_CMD);
+	local_irq_disable();
+	while (1)
+		;
+}
+
+static void virt_reset(void)
+{
+	void __iomem *base = (void __iomem *)virt_bi_data.ctrl.mmio;
+
+	iowrite32be(CMD_RESET, base + VIRT_CTRL_REG_CMD);
+	local_irq_disable();
+	while (1)
+		;
+}
+
+/*
+ * Parse a virtual-m68k-specific record in the bootinfo
+ */
+
+int __init virt_parse_bootinfo(const struct bi_record *record)
+{
+	int unknown = 0;
+	const void *data = record->data;
+
+	switch (be16_to_cpu(record->tag)) {
+	case BI_VIRT_QEMU_VERSION:
+		virt_bi_data.qemu_version = be32_to_cpup(data);
+		break;
+	case BI_VIRT_GF_PIC_BASE:
+		virt_bi_data.pic.mmio = be32_to_cpup(data);
+		data += 4;
+		virt_bi_data.pic.irq = be32_to_cpup(data);
+		break;
+	case BI_VIRT_GF_RTC_BASE:
+		virt_bi_data.rtc.mmio = be32_to_cpup(data);
+		data += 4;
+		virt_bi_data.rtc.irq = be32_to_cpup(data);
+		break;
+	case BI_VIRT_GF_TTY_BASE:
+		virt_bi_data.tty.mmio = be32_to_cpup(data);
+		data += 4;
+		virt_bi_data.tty.irq = be32_to_cpup(data);
+		break;
+	case BI_VIRT_CTRL_BASE:
+		virt_bi_data.ctrl.mmio = be32_to_cpup(data);
+		data += 4;
+		virt_bi_data.ctrl.irq = be32_to_cpup(data);
+		break;
+	case BI_VIRT_VIRTIO_BASE:
+		virt_bi_data.virtio.mmio = be32_to_cpup(data);
+		data += 4;
+		virt_bi_data.virtio.irq = be32_to_cpup(data);
+		break;
+	default:
+		unknown = 1;
+		break;
+	}
+	return unknown;
+}
+
+static void __init virt_sched_init(void)
+{
+	goldfish_timer_init(virt_bi_data.rtc.irq,
+			    (void __iomem *)virt_bi_data.rtc.mmio);
+}
+
+void __init config_virt(void)
+{
+	char earlycon[24];
+
+	snprintf(earlycon, sizeof(earlycon), "early_gf_tty,0x%08x",
+		 virt_bi_data.tty.mmio);
+	setup_earlycon(earlycon);
+
+	ctrlres = (struct resource)
+		   DEFINE_RES_MEM_NAMED(virt_bi_data.ctrl.mmio, 0x100,
+					"virtctrl");
+
+	if (request_resource(&iomem_resource, &ctrlres)) {
+		pr_err("Cannot allocate virt controller resource\n");
+		return;
+	}
+
+	mach_init_IRQ = virt_init_IRQ;
+	mach_sched_init = virt_sched_init;
+	mach_get_model = virt_get_model;
+	mach_reset = virt_reset;
+	mach_halt = virt_halt;
+	mach_power_off = virt_halt;
+}
diff --git a/arch/m68k/virt/ints.c b/arch/m68k/virt/ints.c
new file mode 100644
index 000000000000..95818f901ebe
--- /dev/null
+++ b/arch/m68k/virt/ints.c
@@ -0,0 +1,155 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/sched/debug.h>
+#include <linux/types.h>
+#include <linux/ioport.h>
+
+#include <asm/hwtest.h>
+#include <asm/irq.h>
+#include <asm/irq_regs.h>
+#include <asm/virt.h>
+
+#define GFPIC_REG_IRQ_PENDING           0x04
+#define GFPIC_REG_IRQ_DISABLE_ALL       0x08
+#define GFPIC_REG_IRQ_DISABLE           0x0c
+#define GFPIC_REG_IRQ_ENABLE            0x10
+
+extern void show_registers(struct pt_regs *regs);
+
+static struct resource picres[6];
+static const char *picname[6] = {
+	"goldfish_pic.0",
+	"goldfish_pic.1",
+	"goldfish_pic.2",
+	"goldfish_pic.3",
+	"goldfish_pic.4",
+	"goldfish_pic.5"
+};
+
+/*
+ * 6 goldfish-pic for CPU IRQ #1 to IRQ #6
+ * CPU IRQ #1 -> PIC #1
+ *               IRQ #1 to IRQ #31 -> unused
+ *               IRQ #32 -> goldfish-tty
+ * CPU IRQ #2 -> PIC #2
+ *               IRQ #1 to IRQ #32 -> virtio-mmio from 1 to 32
+ * CPU IRQ #3 -> PIC #3
+ *               IRQ #1 to IRQ #32 -> virtio-mmio from 33 to 64
+ * CPU IRQ #4 -> PIC #4
+ *               IRQ #1 to IRQ #32 -> virtio-mmio from 65 to 96
+ * CPU IRQ #5 -> PIC #5
+ *               IRQ #1 to IRQ #32 -> virtio-mmio from 97 to 128
+ * CPU IRQ #6 -> PIC #6
+ *               IRQ #1 -> goldfish-timer
+ *               IRQ #2 -> goldfish-rtc
+ *               IRQ #3 to IRQ #32 -> unused
+ * CPU IRQ #7 -> NMI
+ */
+
+static u32 gfpic_read(int pic, int reg)
+{
+	void __iomem *base = (void __iomem *)(virt_bi_data.pic.mmio +
+					      pic * 0x1000);
+
+	return ioread32be(base + reg);
+}
+
+static void gfpic_write(u32 value, int pic, int reg)
+{
+	void __iomem *base = (void __iomem *)(virt_bi_data.pic.mmio +
+					      pic * 0x1000);
+
+	iowrite32be(value, base + reg);
+}
+
+#define GF_PIC(irq) ((irq - IRQ_USER) / 32)
+#define GF_IRQ(irq) ((irq - IRQ_USER) % 32)
+
+static void virt_irq_enable(struct irq_data *data)
+{
+	gfpic_write(BIT(GF_IRQ(data->irq)), GF_PIC(data->irq),
+		    GFPIC_REG_IRQ_ENABLE);
+}
+
+static void virt_irq_disable(struct irq_data *data)
+{
+	gfpic_write(BIT(GF_IRQ(data->irq)), GF_PIC(data->irq),
+		    GFPIC_REG_IRQ_DISABLE);
+}
+
+static unsigned int virt_irq_startup(struct irq_data *data)
+{
+	virt_irq_enable(data);
+	return 0;
+}
+
+static irqreturn_t virt_nmi_handler(int irq, void *dev_id)
+{
+	static int in_nmi;
+
+	if (READ_ONCE(in_nmi))
+		return IRQ_HANDLED;
+	WRITE_ONCE(in_nmi, 1);
+
+	pr_warn("Non-Maskable Interrupt\n");
+	show_registers(get_irq_regs());
+
+	WRITE_ONCE(in_nmi, 0);
+	return IRQ_HANDLED;
+}
+
+static struct irq_chip virt_irq_chip = {
+	.name		= "virt",
+	.irq_enable	= virt_irq_enable,
+	.irq_disable	= virt_irq_disable,
+	.irq_startup	= virt_irq_startup,
+	.irq_shutdown	= virt_irq_disable,
+};
+
+static void goldfish_pic_irq(struct irq_desc *desc)
+{
+	u32 irq_pending;
+	unsigned int irq_num;
+	unsigned int pic = desc->irq_data.irq - 1;
+
+	irq_pending = gfpic_read(pic, GFPIC_REG_IRQ_PENDING);
+	irq_num = IRQ_USER + pic * 32;
+
+	do {
+		if (irq_pending & 1)
+			generic_handle_irq(irq_num);
+		++irq_num;
+		irq_pending >>= 1;
+	} while (irq_pending);
+}
+
+void __init virt_init_IRQ(void)
+{
+	unsigned int i;
+
+	m68k_setup_irq_controller(&virt_irq_chip, handle_simple_irq, IRQ_USER,
+				  NUM_VIRT_SOURCES - IRQ_USER);
+
+	for (i = 0; i < 6; i++) {
+
+		picres[i] = (struct resource)
+		    DEFINE_RES_MEM_NAMED(virt_bi_data.pic.mmio + i * 0x1000,
+					 0x1000, picname[i]);
+		if (request_resource(&iomem_resource, &picres[i])) {
+			pr_err("Cannot allocate %s resource\n", picname[i]);
+			return;
+		}
+
+		irq_set_chained_handler(virt_bi_data.pic.irq + i,
+					goldfish_pic_irq);
+	}
+
+	if (request_irq(IRQ_AUTO_7, virt_nmi_handler, 0, "NMI",
+			virt_nmi_handler))
+		pr_err("Couldn't register NMI\n");
+}
diff --git a/arch/m68k/virt/platform.c b/arch/m68k/virt/platform.c
new file mode 100644
index 000000000000..cb820f19a221
--- /dev/null
+++ b/arch/m68k/virt/platform.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/platform_device.h>
+#include <linux/interrupt.h>
+#include <linux/memblock.h>
+#include <asm/virt.h>
+#include <asm/irq.h>
+
+#define VIRTIO_BUS_NB	128
+
+static int __init virt_virtio_init(unsigned int id)
+{
+	const struct resource res[] = {
+		DEFINE_RES_MEM(virt_bi_data.virtio.mmio + id * 0x200, 0x200),
+		DEFINE_RES_IRQ(virt_bi_data.virtio.irq + id),
+	};
+	struct platform_device *pdev;
+
+	pdev = platform_device_register_simple("virtio-mmio", id,
+					       res, ARRAY_SIZE(res));
+	if (IS_ERR(pdev))
+		return PTR_ERR(pdev);
+
+	return 0;
+}
+
+static int __init virt_platform_init(void)
+{
+	const struct resource goldfish_tty_res[] = {
+		DEFINE_RES_MEM(virt_bi_data.tty.mmio, 1),
+		DEFINE_RES_IRQ(virt_bi_data.tty.irq),
+	};
+	/* this is the second gf-rtc, the first one is used by the scheduler */
+	const struct resource goldfish_rtc_res[] = {
+		DEFINE_RES_MEM(virt_bi_data.rtc.mmio + 0x1000, 0x1000),
+		DEFINE_RES_IRQ(virt_bi_data.rtc.irq + 1),
+	};
+	struct platform_device *pdev;
+	unsigned int i;
+
+	if (!MACH_IS_VIRT)
+		return -ENODEV;
+
+	/* We need this to have DMA'able memory provided to goldfish-tty */
+	min_low_pfn = 0;
+
+	pdev = platform_device_register_simple("goldfish_tty",
+					       PLATFORM_DEVID_NONE,
+					       goldfish_tty_res,
+					       ARRAY_SIZE(goldfish_tty_res));
+	if (IS_ERR(pdev))
+		return PTR_ERR(pdev);
+
+	pdev = platform_device_register_simple("goldfish_rtc",
+					       PLATFORM_DEVID_NONE,
+					       goldfish_rtc_res,
+					       ARRAY_SIZE(goldfish_rtc_res));
+	if (IS_ERR(pdev))
+		return PTR_ERR(pdev);
+
+	for (i = 0; i < VIRTIO_BUS_NB; i++) {
+		int err;
+
+		err = virt_virtio_init(i);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+arch_initcall(virt_platform_init);
-- 
2.35.1

