Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7C64D9909
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 11:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347217AbiCOKo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 06:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347204AbiCOKov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 06:44:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7C92AC42;
        Tue, 15 Mar 2022 03:43:39 -0700 (PDT)
Date:   Tue, 15 Mar 2022 10:43:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647341018;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NE1Bc8eBtvMQIVsj/8i4jrUdXf78iQ3DGFEwtb/eb7w=;
        b=ckIkg7KBDkbXU2cGLrxBRl0uTlnj5cYaOanF3CcOsiZmV/M8+tAsylHu6Cyb/YW11OI05h
        amyCFwYNuwnxAEetkoFIEi5sAvnhxFwC+DdJU7jWZsC8H17YN6LpBFMyPh31zkjhKcFYOD
        Gy/qVqiNz9gytm2NkL9aMUkg1aCDk61xwVlUA8driXKX843yOabd0YFX1M+LuSCVx8mhUb
        TH43LQTAe9gclAWJ5rM+6EdokVIZnHYctZ9+XAZGt6xc1oJ10J3RA1Ev6TxIsqzgADoUuA
        8uQq9Lqz3paad9MhX0AIzxvrzv/yI9wz/QQa4GWyTiM9vr0a5xb2dF1P64lNXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647341018;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NE1Bc8eBtvMQIVsj/8i4jrUdXf78iQ3DGFEwtb/eb7w=;
        b=S4Rd3ALeWzBcMSoClomTpXakCJpt69KVMvq+QCyCKgArwcAHN7rAWwXI4fo+Conacja5Iy
        5lRhS46o5zwKIxDA==
From:   "tip-bot2 for Masahiro Yamada" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86: Remove toolchain check for X32 ABI capability
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220314194842.3452-2-nathan@kernel.org>
References: <20220314194842.3452-2-nathan@kernel.org>
MIME-Version: 1.0
Message-ID: <164734101734.16921.1472305779164669937.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     83a44a4f47ad20997aebb311fc678a13cde391d7
Gitweb:        https://git.kernel.org/tip/83a44a4f47ad20997aebb311fc678a13cde391d7
Author:        Masahiro Yamada <masahiroy@kernel.org>
AuthorDate:    Mon, 14 Mar 2022 12:48:41 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 15 Mar 2022 10:32:48 +01:00

x86: Remove toolchain check for X32 ABI capability

Commit 0bf6276392e9 ("x32: Warn and disable rather than error if
binutils too old") added a small test in arch/x86/Makefile because
binutils 2.22 or newer is needed to properly support elf32-x86-64. This
check is no longer necessary, as the minimum supported version of
binutils is 2.23, which is enforced at configuration time with
scripts/min-tool-version.sh.

Remove this check and replace all uses of CONFIG_X86_X32 with
CONFIG_X86_X32_ABI, as two symbols are no longer necessary.

[nathan: Rebase, fix up a few places where CONFIG_X86_X32 was still
         used, and simplify commit message to satisfy -tip requirements]

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220314194842.3452-2-nathan@kernel.org
---
 arch/x86/Kconfig                       |  8 ++------
 arch/x86/Makefile                      | 16 ----------------
 arch/x86/entry/syscalls/Makefile       |  2 +-
 arch/x86/include/asm/syscall_wrapper.h |  6 +++---
 arch/x86/include/asm/vdso.h            |  2 +-
 arch/x86/kernel/process_64.c           |  2 +-
 fs/fuse/ioctl.c                        |  2 +-
 fs/xfs/xfs_ioctl32.c                   |  2 +-
 sound/core/control_compat.c            | 16 ++++++++--------
 sound/core/pcm_compat.c                | 20 ++++++++++----------
 10 files changed, 28 insertions(+), 48 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 870e0d1..b903bfc 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2861,7 +2861,7 @@ config IA32_AOUT
 	help
 	  Support old a.out binaries in the 32bit emulation.
 
-config X86_X32
+config X86_X32_ABI
 	bool "x32 ABI for 64-bit mode"
 	depends on X86_64
 	help
@@ -2870,10 +2870,6 @@ config X86_X32
 	  full 64-bit register file and wide data path while leaving
 	  pointers at 32 bits for smaller memory footprint.
 
-	  You will need a recent binutils (2.22 or later) with
-	  elf32_x86_64 support enabled to compile a kernel with this
-	  option set.
-
 config COMPAT_32
 	def_bool y
 	depends on IA32_EMULATION || X86_32
@@ -2882,7 +2878,7 @@ config COMPAT_32
 
 config COMPAT
 	def_bool y
-	depends on IA32_EMULATION || X86_X32
+	depends on IA32_EMULATION || X86_X32_ABI
 
 if COMPAT
 config COMPAT_FOR_U64_ALIGNMENT
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index f29c2c9..63d50f6 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -152,22 +152,6 @@ else
         KBUILD_CFLAGS += -mcmodel=kernel
 endif
 
-ifdef CONFIG_X86_X32
-	x32_ld_ok := $(call try-run,\
-			/bin/echo -e '1: .quad 1b' | \
-			$(CC) $(KBUILD_AFLAGS) -c -x assembler -o "$$TMP" - && \
-			$(OBJCOPY) -O elf32-x86-64 "$$TMP" "$$TMP.o" && \
-			$(LD) -m elf32_x86_64 "$$TMP.o" -o "$$TMP",y,n)
-        ifeq ($(x32_ld_ok),y)
-                CONFIG_X86_X32_ABI := y
-                KBUILD_AFLAGS += -DCONFIG_X86_X32_ABI
-                KBUILD_CFLAGS += -DCONFIG_X86_X32_ABI
-        else
-                $(warning CONFIG_X86_X32 enabled but no binutils support)
-        endif
-endif
-export CONFIG_X86_X32_ABI
-
 #
 # If the function graph tracer is used with mcount instead of fentry,
 # '-maccumulate-outgoing-args' is needed to prevent a GCC bug
diff --git a/arch/x86/entry/syscalls/Makefile b/arch/x86/entry/syscalls/Makefile
index 5b3efed..7f3886e 100644
--- a/arch/x86/entry/syscalls/Makefile
+++ b/arch/x86/entry/syscalls/Makefile
@@ -67,7 +67,7 @@ uapisyshdr-y			+= unistd_32.h unistd_64.h unistd_x32.h
 syshdr-y			+= syscalls_32.h
 syshdr-$(CONFIG_X86_64)		+= unistd_32_ia32.h unistd_64_x32.h
 syshdr-$(CONFIG_X86_64)		+= syscalls_64.h
-syshdr-$(CONFIG_X86_X32)	+= syscalls_x32.h
+syshdr-$(CONFIG_X86_X32_ABI)	+= syscalls_x32.h
 syshdr-$(CONFIG_XEN)		+= xen-hypercalls.h
 
 uapisyshdr-y	:= $(addprefix $(uapi)/, $(uapisyshdr-y))
diff --git a/arch/x86/include/asm/syscall_wrapper.h b/arch/x86/include/asm/syscall_wrapper.h
index 6a2827d..59358d1 100644
--- a/arch/x86/include/asm/syscall_wrapper.h
+++ b/arch/x86/include/asm/syscall_wrapper.h
@@ -159,7 +159,7 @@ extern long __ia32_sys_ni_syscall(const struct pt_regs *regs);
 #endif /* CONFIG_IA32_EMULATION */
 
 
-#ifdef CONFIG_X86_X32
+#ifdef CONFIG_X86_X32_ABI
 /*
  * For the x32 ABI, we need to create a stub for compat_sys_*() which is aware
  * of the x86-64-style parameter ordering of x32 syscalls. The syscalls common
@@ -177,12 +177,12 @@ extern long __ia32_sys_ni_syscall(const struct pt_regs *regs);
 
 #define __X32_COMPAT_SYS_NI(name)					\
 	__SYS_NI(x64, compat_sys_##name)
-#else /* CONFIG_X86_X32 */
+#else /* CONFIG_X86_X32_ABI */
 #define __X32_COMPAT_SYS_STUB0(name)
 #define __X32_COMPAT_SYS_STUBx(x, name, ...)
 #define __X32_COMPAT_COND_SYSCALL(name)
 #define __X32_COMPAT_SYS_NI(name)
-#endif /* CONFIG_X86_X32 */
+#endif /* CONFIG_X86_X32_ABI */
 
 
 #ifdef CONFIG_COMPAT
diff --git a/arch/x86/include/asm/vdso.h b/arch/x86/include/asm/vdso.h
index 98aa103..2963a2f 100644
--- a/arch/x86/include/asm/vdso.h
+++ b/arch/x86/include/asm/vdso.h
@@ -37,7 +37,7 @@ struct vdso_image {
 extern const struct vdso_image vdso_image_64;
 #endif
 
-#ifdef CONFIG_X86_X32
+#ifdef CONFIG_X86_X32_ABI
 extern const struct vdso_image vdso_image_x32;
 #endif
 
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 3402ede..e459253 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -681,7 +681,7 @@ void set_personality_64bit(void)
 
 static void __set_personality_x32(void)
 {
-#ifdef CONFIG_X86_X32
+#ifdef CONFIG_X86_X32_ABI
 	if (current->mm)
 		current->mm->context.flags = 0;
 
diff --git a/fs/fuse/ioctl.c b/fs/fuse/ioctl.c
index df58966..33cde4b 100644
--- a/fs/fuse/ioctl.c
+++ b/fs/fuse/ioctl.c
@@ -170,7 +170,7 @@ long fuse_do_ioctl(struct file *file, unsigned int cmd, unsigned long arg,
 #else
 	if (flags & FUSE_IOCTL_COMPAT) {
 		inarg.flags |= FUSE_IOCTL_32BIT;
-#ifdef CONFIG_X86_X32
+#ifdef CONFIG_X86_X32_ABI
 		if (in_x32_syscall())
 			inarg.flags |= FUSE_IOCTL_COMPAT_X32;
 #endif
diff --git a/fs/xfs/xfs_ioctl32.c b/fs/xfs/xfs_ioctl32.c
index 004ed2a..ca25ed8 100644
--- a/fs/xfs/xfs_ioctl32.c
+++ b/fs/xfs/xfs_ioctl32.c
@@ -217,7 +217,7 @@ xfs_compat_ioc_fsbulkstat(
 	inumbers_fmt_pf		inumbers_func = xfs_fsinumbers_fmt_compat;
 	bulkstat_one_fmt_pf	bs_one_func = xfs_fsbulkstat_one_fmt_compat;
 
-#ifdef CONFIG_X86_X32
+#ifdef CONFIG_X86_X32_ABI
 	if (in_x32_syscall()) {
 		/*
 		 * ... but on x32 the input xfs_fsop_bulkreq has pointers
diff --git a/sound/core/control_compat.c b/sound/core/control_compat.c
index edff063..d8a86d1 100644
--- a/sound/core/control_compat.c
+++ b/sound/core/control_compat.c
@@ -150,7 +150,7 @@ struct snd_ctl_elem_value32 {
         unsigned char reserved[128];
 };
 
-#ifdef CONFIG_X86_X32
+#ifdef CONFIG_X86_X32_ABI
 /* x32 has a different alignment for 64bit values from ia32 */
 struct snd_ctl_elem_value_x32 {
 	struct snd_ctl_elem_id id;
@@ -162,7 +162,7 @@ struct snd_ctl_elem_value_x32 {
 	} value;
 	unsigned char reserved[128];
 };
-#endif /* CONFIG_X86_X32 */
+#endif /* CONFIG_X86_X32_ABI */
 
 /* get the value type and count of the control */
 static int get_ctl_type(struct snd_card *card, struct snd_ctl_elem_id *id,
@@ -347,7 +347,7 @@ static int snd_ctl_elem_write_user_compat(struct snd_ctl_file *file,
 	return ctl_elem_write_user(file, data32, &data32->value);
 }
 
-#ifdef CONFIG_X86_X32
+#ifdef CONFIG_X86_X32_ABI
 static int snd_ctl_elem_read_user_x32(struct snd_card *card,
 				      struct snd_ctl_elem_value_x32 __user *data32)
 {
@@ -359,7 +359,7 @@ static int snd_ctl_elem_write_user_x32(struct snd_ctl_file *file,
 {
 	return ctl_elem_write_user(file, data32, &data32->value);
 }
-#endif /* CONFIG_X86_X32 */
+#endif /* CONFIG_X86_X32_ABI */
 
 /* add or replace a user control */
 static int snd_ctl_elem_add_compat(struct snd_ctl_file *file,
@@ -418,10 +418,10 @@ enum {
 	SNDRV_CTL_IOCTL_ELEM_WRITE32 = _IOWR('U', 0x13, struct snd_ctl_elem_value32),
 	SNDRV_CTL_IOCTL_ELEM_ADD32 = _IOWR('U', 0x17, struct snd_ctl_elem_info32),
 	SNDRV_CTL_IOCTL_ELEM_REPLACE32 = _IOWR('U', 0x18, struct snd_ctl_elem_info32),
-#ifdef CONFIG_X86_X32
+#ifdef CONFIG_X86_X32_ABI
 	SNDRV_CTL_IOCTL_ELEM_READ_X32 = _IOWR('U', 0x12, struct snd_ctl_elem_value_x32),
 	SNDRV_CTL_IOCTL_ELEM_WRITE_X32 = _IOWR('U', 0x13, struct snd_ctl_elem_value_x32),
-#endif /* CONFIG_X86_X32 */
+#endif /* CONFIG_X86_X32_ABI */
 };
 
 static inline long snd_ctl_ioctl_compat(struct file *file, unsigned int cmd, unsigned long arg)
@@ -460,12 +460,12 @@ static inline long snd_ctl_ioctl_compat(struct file *file, unsigned int cmd, uns
 		return snd_ctl_elem_add_compat(ctl, argp, 0);
 	case SNDRV_CTL_IOCTL_ELEM_REPLACE32:
 		return snd_ctl_elem_add_compat(ctl, argp, 1);
-#ifdef CONFIG_X86_X32
+#ifdef CONFIG_X86_X32_ABI
 	case SNDRV_CTL_IOCTL_ELEM_READ_X32:
 		return snd_ctl_elem_read_user_x32(ctl->card, argp);
 	case SNDRV_CTL_IOCTL_ELEM_WRITE_X32:
 		return snd_ctl_elem_write_user_x32(ctl, argp);
-#endif /* CONFIG_X86_X32 */
+#endif /* CONFIG_X86_X32_ABI */
 	}
 
 	down_read(&snd_ioctl_rwsem);
diff --git a/sound/core/pcm_compat.c b/sound/core/pcm_compat.c
index e4e1768..917c5b4 100644
--- a/sound/core/pcm_compat.c
+++ b/sound/core/pcm_compat.c
@@ -147,13 +147,13 @@ static int snd_pcm_ioctl_channel_info_compat(struct snd_pcm_substream *substream
 	return err;
 }
 
-#ifdef CONFIG_X86_X32
+#ifdef CONFIG_X86_X32_ABI
 /* X32 ABI has the same struct as x86-64 for snd_pcm_channel_info */
 static int snd_pcm_channel_info_user(struct snd_pcm_substream *substream,
 				     struct snd_pcm_channel_info __user *src);
 #define snd_pcm_ioctl_channel_info_x32(s, p)	\
 	snd_pcm_channel_info_user(s, p)
-#endif /* CONFIG_X86_X32 */
+#endif /* CONFIG_X86_X32_ABI */
 
 struct compat_snd_pcm_status64 {
 	snd_pcm_state_t state;
@@ -375,7 +375,7 @@ static int snd_pcm_ioctl_xfern_compat(struct snd_pcm_substream *substream,
 	return err;
 }
 
-#ifdef CONFIG_X86_X32
+#ifdef CONFIG_X86_X32_ABI
 /* X32 ABI has 64bit timespec and 64bit alignment */
 struct snd_pcm_mmap_status_x32 {
 	snd_pcm_state_t state;
@@ -468,7 +468,7 @@ static int snd_pcm_ioctl_sync_ptr_x32(struct snd_pcm_substream *substream,
 
 	return 0;
 }
-#endif /* CONFIG_X86_X32 */
+#endif /* CONFIG_X86_X32_ABI */
 
 #ifdef __BIG_ENDIAN
 typedef char __pad_before_u32[4];
@@ -560,10 +560,10 @@ enum {
 	SNDRV_PCM_IOCTL_READN_FRAMES32 = _IOR('A', 0x53, struct snd_xfern32),
 	SNDRV_PCM_IOCTL_STATUS_COMPAT64 = _IOR('A', 0x20, struct compat_snd_pcm_status64),
 	SNDRV_PCM_IOCTL_STATUS_EXT_COMPAT64 = _IOWR('A', 0x24, struct compat_snd_pcm_status64),
-#ifdef CONFIG_X86_X32
+#ifdef CONFIG_X86_X32_ABI
 	SNDRV_PCM_IOCTL_CHANNEL_INFO_X32 = _IOR('A', 0x32, struct snd_pcm_channel_info),
 	SNDRV_PCM_IOCTL_SYNC_PTR_X32 = _IOWR('A', 0x23, struct snd_pcm_sync_ptr_x32),
-#endif /* CONFIG_X86_X32 */
+#endif /* CONFIG_X86_X32_ABI */
 };
 
 static long snd_pcm_ioctl_compat(struct file *file, unsigned int cmd, unsigned long arg)
@@ -607,10 +607,10 @@ static long snd_pcm_ioctl_compat(struct file *file, unsigned int cmd, unsigned l
 	case __SNDRV_PCM_IOCTL_SYNC_PTR32:
 		return snd_pcm_common_ioctl(file, substream, cmd, argp);
 	case __SNDRV_PCM_IOCTL_SYNC_PTR64:
-#ifdef CONFIG_X86_X32
+#ifdef CONFIG_X86_X32_ABI
 		if (in_x32_syscall())
 			return snd_pcm_ioctl_sync_ptr_x32(substream, argp);
-#endif /* CONFIG_X86_X32 */
+#endif /* CONFIG_X86_X32_ABI */
 		return snd_pcm_ioctl_sync_ptr_buggy(substream, argp);
 	case SNDRV_PCM_IOCTL_HW_REFINE32:
 		return snd_pcm_ioctl_hw_params_compat(substream, 1, argp);
@@ -642,10 +642,10 @@ static long snd_pcm_ioctl_compat(struct file *file, unsigned int cmd, unsigned l
 		return snd_pcm_status_user_compat64(substream, argp, false);
 	case SNDRV_PCM_IOCTL_STATUS_EXT_COMPAT64:
 		return snd_pcm_status_user_compat64(substream, argp, true);
-#ifdef CONFIG_X86_X32
+#ifdef CONFIG_X86_X32_ABI
 	case SNDRV_PCM_IOCTL_CHANNEL_INFO_X32:
 		return snd_pcm_ioctl_channel_info_x32(substream, argp);
-#endif /* CONFIG_X86_X32 */
+#endif /* CONFIG_X86_X32_ABI */
 	}
 
 	return -ENOIOCTLCMD;
