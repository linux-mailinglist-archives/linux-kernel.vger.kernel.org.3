Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F97B4E897A
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 21:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236405AbiC0TFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 15:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236118AbiC0TFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 15:05:02 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4108CB84
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 12:03:21 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id z92so14634648ede.13
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 12:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UuuTKN4O0hevo0fWbl0PX4v66/CcRTRSmi0nLyPTGn8=;
        b=hHCu0SRoJlzH9xT9kjWkHBG6HGy7wWhPL6/rqFc1ok6gEzihLb74ry6aI/UyNu6zLd
         RjtH+qN3YK2xd43ggNZRBhhXghLJzg/tvN91B6V/k3q7ucQvA5/Xfv2Mya2B2uV8ILLJ
         kDf+gEU53V/+i9XmDslyiI8wabshbSzkmXL8tIkQWc9WaTpaNLWLvBDGu0fk26oDQWCj
         jikLFzw9BmLxO0oKXCew1L7BKAmffnz+R9ZDhKiKGYvpAz9bzHcOlxqU3d4ZdcYXm7Jk
         WeyWwedNOJzRb64neDpQUpljkdtt9RzLu2V1kp3+/nHoWIwupsn8CpDAJB3aPlZe2xId
         dfYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=UuuTKN4O0hevo0fWbl0PX4v66/CcRTRSmi0nLyPTGn8=;
        b=bZKF07aB/Wrs8IsAeFvZYdSb8WGEu4KrmrB+VS1eCyQYYxSUpvl0qeSW/AFKoPe+7K
         FXZq5d0wnoekP5xXuLY6faj450LNY9zJqPfmadWaPDnDurwETko+nileIEzEtiqi2cZ3
         CSKiLtS4SOl5al8dbMK4HGCoOQBzGoI7bgpDC3u+5CYNywaHFA3eCdtiPzYJuYhsp/l1
         nNPk1MEl1K+8zNR99oR+ubn4ABIrfTB2y26flnIBAU8wPss3TWwNNi5pV6Of3pqnypoa
         CkzN/GfeC7mY0wKsg8GHFxcpQ9gk2GhT3Ht1Bq4DNAmCpupFpiP9RTK19F9ak1PsIpe1
         Hffg==
X-Gm-Message-State: AOAM530KhYDs+Bge5wTz3AxY0pcYVLF7f/kgNTn8mZmG+DOih9Yy82V3
        73xLR6Qd8CQbFcXX0o7sAnsW/WaL47g=
X-Google-Smtp-Source: ABdhPJyGoJ3zAb2lJ53SxOgBrqdr3Eln8e4P5s/J/kdUrVCn0o6Bln3RqJ7i8tNQlcwa7biV2M5G2g==
X-Received: by 2002:a05:6402:84b:b0:419:105:f516 with SMTP id b11-20020a056402084b00b004190105f516mr12011885edz.3.1648407799550;
        Sun, 27 Mar 2022 12:03:19 -0700 (PDT)
Received: from gmail.com (0526F2AE.dsl.pool.telekom.hu. [5.38.242.174])
        by smtp.gmail.com with ESMTPSA id m20-20020a056402431400b00419315cc3e2sm6093042edc.61.2022.03.27.12.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Mar 2022 12:03:17 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sun, 27 Mar 2022 21:03:14 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] x86/config: Make the x86 defconfigs a bit more usable
Message-ID: <YkC08gKqJOUM7CA8@gmail.com>
References: <YjhdcJB4FaLfsoyO@gmail.com>
 <CAHk-=wjS6ptr5=JqmmyEb_qTjDz_68+S=h1o1bL1fEyArVOymA@mail.gmail.com>
 <YjpLiKRUIB4TGJm0@zn.tnic>
 <CAHk-=wifoM9VOp-55OZCRcO9MnqQ109UTuCiXeZ-eyX_JcNVGg@mail.gmail.com>
 <YjsCpoRK7W4l6tSh@zn.tnic>
 <CAHk-=wi9pLxm+dXoCaiGO+f0EbhyfAR_L510vD0c2=hj6rbMXg@mail.gmail.com>
 <YjwsUT/6PkRPjnHE@gmail.com>
 <YjySjys3QZAWFlfo@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjySjys3QZAWFlfo@dev-arch.thelio-3990X>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75 autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Nathan Chancellor <nathan@kernel.org> wrote:

> Hi Ingo,
> 
> On Thu, Mar 24, 2022 at 09:31:13AM +0100, Ingo Molnar wrote:
> 
> <snip>
> 
> > ================>
> > 
> > From: Ingo Molnar <mingo@kernel.org>
> > Date: Thu, 24 Mar 2022 09:18:36 +0100
> > Subject: [PATCH] x86/config: Make the x86 defconfigs a bit more usable
> > 
> >  - Use 'make savedefconfig' to refresh & regenerate the files
> >  - Add in KVM boot enablers
> >  - Enable the cgroup features most distros rely on
> > 
> > Signed-off-by: Ingo Molnar <mingo@kernel.org>
> 
> This should be super helpful, especially for the "reference point and
> minimal test requirements" that you mentioned above, along with being
> able to boot more distributions in QEMU without fiddling with
> kvm_guest.config and menuconfig.

Thanks, I've added your Acked-by to the (fixed...) version of this commit.

> >  # CONFIG_COMPAT_BRK is not set
> >  CONFIG_PROFILING=y
> > -# CONFIG_64BIT is not set
> 
> I don't think this is right, this is repeating the problem that was fixed 
> by commit 76366050eb1b ("x86/defconfigs: Explicitly unset CONFIG_64BIT in 
> i386_defconfig").
> 
> $ make ARCH=i386 savedefconfig
> 
> ?

Yeah, good catch! ...

I use defconfigs by explicitly adding in the architecture:

  kepler:~/tip> make ARCH=i386 defconfig

  kepler:~/tip> kconfig-arch
  i386

... so never I noticed this bug.

I fixed this in the latest version (attached).

Arguably 'make ARCH=i386 savedefconfig' should preserve this, so that 
refreshing defconfigs on bi-arch architectures is idempotent, but that's no 
excuse to regress the existing defconfig behavior.

Thanks,

	Ingo

========================>
From: Ingo Molnar <mingo@kernel.org>
Date: Thu, 24 Mar 2022 09:31:13 +0100
Subject: [PATCH] x86/config: Make the x86 defconfigs a bit more usable

 - Use 'make savedefconfig' to refresh & regenerate the files
 - Add in KVM boot enablers
 - Enable the cgroup features most distros rely on

[ fix bug found by Nathan Chancellor ]

Acked-by: Nathan Chancellor <nathan@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/YjwsUT/6PkRPjnHE@gmail.com
---
 arch/x86/configs/i386_defconfig   | 51 +++++++++++++++++++++++++++------------
 arch/x86/configs/x86_64_defconfig | 38 +++++++++++++++++++++--------
 2 files changed, 63 insertions(+), 26 deletions(-)

diff --git a/arch/x86/configs/i386_defconfig b/arch/x86/configs/i386_defconfig
index 4b2085243aa3..98a4852ed6a0 100644
--- a/arch/x86/configs/i386_defconfig
+++ b/arch/x86/configs/i386_defconfig
@@ -1,5 +1,7 @@
+CONFIG_WERROR=y
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
+CONFIG_USELIB=y
 CONFIG_AUDIT=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
@@ -11,23 +13,30 @@ CONFIG_TASK_XACCT=y
 CONFIG_TASK_IO_ACCOUNTING=y
 CONFIG_LOG_BUF_SHIFT=18
 CONFIG_CGROUPS=y
+CONFIG_BLK_CGROUP=y
 CONFIG_CGROUP_SCHED=y
+CONFIG_CGROUP_PIDS=y
+CONFIG_CGROUP_RDMA=y
 CONFIG_CGROUP_FREEZER=y
+CONFIG_CGROUP_HUGETLB=y
 CONFIG_CPUSETS=y
+CONFIG_CGROUP_DEVICE=y
 CONFIG_CGROUP_CPUACCT=y
+CONFIG_CGROUP_PERF=y
+CONFIG_CGROUP_MISC=y
+CONFIG_CGROUP_DEBUG=y
 CONFIG_BLK_DEV_INITRD=y
+CONFIG_KALLSYMS_ALL=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_PROFILING=y
-# CONFIG_64BIT is not set
 CONFIG_SMP=y
-CONFIG_X86_GENERIC=y
-CONFIG_HPET_TIMER=y
+CONFIG_HYPERVISOR_GUEST=y
+CONFIG_PARAVIRT=y
+CONFIG_NR_CPUS=8
 CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
-CONFIG_X86_REBOOTFIXUPS=y
 CONFIG_MICROCODE_AMD=y
 CONFIG_X86_MSR=y
 CONFIG_X86_CPUID=y
-CONFIG_HIGHPTE=y
 CONFIG_X86_CHECK_BIOS_CORRUPTION=y
 # CONFIG_MTRR_SANITIZER is not set
 CONFIG_EFI=y
@@ -43,12 +52,15 @@ CONFIG_ACPI_BGRT=y
 CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE=y
 CONFIG_CPU_FREQ_GOV_ONDEMAND=y
 CONFIG_X86_ACPI_CPUFREQ=y
-CONFIG_EFI_VARS=y
 CONFIG_KPROBES=y
 CONFIG_JUMP_LABEL=y
+CONFIG_COMPAT_32BIT_TIME=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODULE_FORCE_UNLOAD=y
+CONFIG_BLK_CGROUP_IOLATENCY=y
+CONFIG_BLK_CGROUP_IOCOST=y
+CONFIG_BLK_CGROUP_IOPRIO=y
 CONFIG_BINFMT_MISC=y
 CONFIG_NET=y
 CONFIG_PACKET=y
@@ -103,12 +115,16 @@ CONFIG_IP6_NF_FILTER=y
 CONFIG_IP6_NF_TARGET_REJECT=y
 CONFIG_IP6_NF_MANGLE=y
 CONFIG_NET_SCHED=y
+CONFIG_NET_CLS_CGROUP=y
 CONFIG_NET_EMATCH=y
 CONFIG_NET_CLS_ACT=y
+CONFIG_CGROUP_NET_PRIO=y
 CONFIG_CFG80211=y
 CONFIG_MAC80211=y
 CONFIG_MAC80211_LEDS=y
 CONFIG_RFKILL=y
+CONFIG_NET_9P=y
+CONFIG_NET_9P_VIRTIO=y
 CONFIG_PCI=y
 CONFIG_PCIEPORTBUS=y
 CONFIG_PCI_MSI=y
@@ -119,13 +135,16 @@ CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_DEBUG_DEVRES=y
 CONFIG_CONNECTOR=y
+CONFIG_EFI_VARS=y
+CONFIG_EFI_CAPSULE_LOADER=y
 CONFIG_BLK_DEV_LOOP=y
+CONFIG_VIRTIO_BLK=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_BLK_DEV_SR=y
 CONFIG_CHR_DEV_SG=y
 CONFIG_SCSI_CONSTANTS=y
 CONFIG_SCSI_SPI_ATTRS=y
-# CONFIG_SCSI_LOWLEVEL is not set
+CONFIG_SCSI_VIRTIO=y
 CONFIG_ATA=y
 CONFIG_SATA_AHCI=y
 CONFIG_ATA_PIIX=y
@@ -143,6 +162,7 @@ CONFIG_MACINTOSH_DRIVERS=y
 CONFIG_MAC_EMUMOUSEBTN=y
 CONFIG_NETDEVICES=y
 CONFIG_NETCONSOLE=y
+CONFIG_VIRTIO_NET=y
 CONFIG_BNX2=y
 CONFIG_TIGON3=y
 CONFIG_NET_TULIP=y
@@ -170,6 +190,7 @@ CONFIG_SERIAL_8250_SHARE_IRQ=y
 CONFIG_SERIAL_8250_DETECT_IRQ=y
 CONFIG_SERIAL_8250_RSA=y
 CONFIG_SERIAL_NONSTANDARD=y
+CONFIG_VIRTIO_CONSOLE=y
 CONFIG_HW_RANDOM=y
 CONFIG_NVRAM=y
 CONFIG_HPET=y
@@ -181,12 +202,7 @@ CONFIG_AGP_AMD64=y
 CONFIG_AGP_INTEL=y
 CONFIG_DRM=y
 CONFIG_DRM_I915=y
-CONFIG_FB_MODE_HELPERS=y
-CONFIG_FB_TILEBLITTING=y
-CONFIG_FB_EFI=y
-CONFIG_LOGO=y
-# CONFIG_LOGO_LINUX_MONO is not set
-# CONFIG_LOGO_LINUX_VGA16 is not set
+CONFIG_DRM_VIRTIO_GPU=y
 CONFIG_SOUND=y
 CONFIG_SND=y
 CONFIG_SND_HRTIMER=y
@@ -219,6 +235,8 @@ CONFIG_USB_STORAGE=y
 CONFIG_RTC_CLASS=y
 # CONFIG_RTC_HCTOSYS is not set
 CONFIG_DMADEVICES=y
+CONFIG_VIRTIO_PCI=y
+CONFIG_VIRTIO_INPUT=y
 CONFIG_EEEPC_LAPTOP=y
 CONFIG_EXT4_FS=y
 CONFIG_EXT4_FS_POSIX_ACL=y
@@ -240,6 +258,7 @@ CONFIG_NFS_FS=y
 CONFIG_NFS_V3_ACL=y
 CONFIG_NFS_V4=y
 CONFIG_ROOT_NFS=y
+CONFIG_9P_FS=y
 CONFIG_NLS_DEFAULT="utf8"
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ASCII=y
@@ -251,15 +270,15 @@ CONFIG_SECURITY_SELINUX=y
 CONFIG_SECURITY_SELINUX_BOOTPARAM=y
 CONFIG_SECURITY_SELINUX_DISABLE=y
 CONFIG_PRINTK_TIME=y
+CONFIG_FRAME_WARN=1024
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_DEBUG_STACK_USAGE=y
-CONFIG_DEBUG_STACKOVERFLOW=y
 # CONFIG_SCHED_DEBUG is not set
 CONFIG_SCHEDSTATS=y
 CONFIG_BLK_DEV_IO_TRACE=y
 CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
 CONFIG_EARLY_PRINTK_DBGP=y
 CONFIG_DEBUG_BOOT_PARAMS=y
-CONFIG_KALLSYMS_ALL=y
-CONFIG_WERROR=y
+CONFIG_UNWINDER_FRAME_POINTER=y
+# CONFIG_64BIT is not set
diff --git a/arch/x86/configs/x86_64_defconfig b/arch/x86/configs/x86_64_defconfig
index 38c52e4eb30b..69784505a7a8 100644
--- a/arch/x86/configs/x86_64_defconfig
+++ b/arch/x86/configs/x86_64_defconfig
@@ -1,3 +1,4 @@
+CONFIG_WERROR=y
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 CONFIG_AUDIT=y
@@ -11,14 +12,25 @@ CONFIG_TASK_XACCT=y
 CONFIG_TASK_IO_ACCOUNTING=y
 CONFIG_LOG_BUF_SHIFT=18
 CONFIG_CGROUPS=y
+CONFIG_BLK_CGROUP=y
 CONFIG_CGROUP_SCHED=y
+CONFIG_CGROUP_PIDS=y
+CONFIG_CGROUP_RDMA=y
 CONFIG_CGROUP_FREEZER=y
+CONFIG_CGROUP_HUGETLB=y
 CONFIG_CPUSETS=y
+CONFIG_CGROUP_DEVICE=y
 CONFIG_CGROUP_CPUACCT=y
+CONFIG_CGROUP_PERF=y
+CONFIG_CGROUP_MISC=y
+CONFIG_CGROUP_DEBUG=y
 CONFIG_BLK_DEV_INITRD=y
+CONFIG_KALLSYMS_ALL=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_PROFILING=y
 CONFIG_SMP=y
+CONFIG_HYPERVISOR_GUEST=y
+CONFIG_PARAVIRT=y
 CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
 CONFIG_MICROCODE_AMD=y
 CONFIG_X86_MSR=y
@@ -41,12 +53,14 @@ CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE=y
 CONFIG_CPU_FREQ_GOV_ONDEMAND=y
 CONFIG_X86_ACPI_CPUFREQ=y
 CONFIG_IA32_EMULATION=y
-CONFIG_EFI_VARS=y
 CONFIG_KPROBES=y
 CONFIG_JUMP_LABEL=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODULE_FORCE_UNLOAD=y
+CONFIG_BLK_CGROUP_IOLATENCY=y
+CONFIG_BLK_CGROUP_IOCOST=y
+CONFIG_BLK_CGROUP_IOPRIO=y
 CONFIG_BINFMT_MISC=y
 CONFIG_NET=y
 CONFIG_PACKET=y
@@ -101,12 +115,16 @@ CONFIG_IP6_NF_FILTER=y
 CONFIG_IP6_NF_TARGET_REJECT=y
 CONFIG_IP6_NF_MANGLE=y
 CONFIG_NET_SCHED=y
+CONFIG_NET_CLS_CGROUP=y
 CONFIG_NET_EMATCH=y
 CONFIG_NET_CLS_ACT=y
+CONFIG_CGROUP_NET_PRIO=y
 CONFIG_CFG80211=y
 CONFIG_MAC80211=y
 CONFIG_MAC80211_LEDS=y
 CONFIG_RFKILL=y
+CONFIG_NET_9P=y
+CONFIG_NET_9P_VIRTIO=y
 CONFIG_PCI=y
 CONFIG_PCIEPORTBUS=y
 CONFIG_HOTPLUG_PCI=y
@@ -116,13 +134,15 @@ CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_DEBUG_DEVRES=y
 CONFIG_CONNECTOR=y
+CONFIG_EFI_VARS=y
 CONFIG_BLK_DEV_LOOP=y
+CONFIG_VIRTIO_BLK=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_BLK_DEV_SR=y
 CONFIG_CHR_DEV_SG=y
 CONFIG_SCSI_CONSTANTS=y
 CONFIG_SCSI_SPI_ATTRS=y
-# CONFIG_SCSI_LOWLEVEL is not set
+CONFIG_SCSI_VIRTIO=y
 CONFIG_ATA=y
 CONFIG_SATA_AHCI=y
 CONFIG_ATA_PIIX=y
@@ -138,6 +158,7 @@ CONFIG_MACINTOSH_DRIVERS=y
 CONFIG_MAC_EMUMOUSEBTN=y
 CONFIG_NETDEVICES=y
 CONFIG_NETCONSOLE=y
+CONFIG_VIRTIO_NET=y
 CONFIG_TIGON3=y
 CONFIG_NET_TULIP=y
 CONFIG_E100=y
@@ -162,6 +183,7 @@ CONFIG_SERIAL_8250_SHARE_IRQ=y
 CONFIG_SERIAL_8250_DETECT_IRQ=y
 CONFIG_SERIAL_8250_RSA=y
 CONFIG_SERIAL_NONSTANDARD=y
+CONFIG_VIRTIO_CONSOLE=y
 CONFIG_HW_RANDOM=y
 # CONFIG_HW_RANDOM_INTEL is not set
 # CONFIG_HW_RANDOM_AMD is not set
@@ -175,12 +197,7 @@ CONFIG_AGP_AMD64=y
 CONFIG_AGP_INTEL=y
 CONFIG_DRM=y
 CONFIG_DRM_I915=y
-CONFIG_FB_MODE_HELPERS=y
-CONFIG_FB_TILEBLITTING=y
-CONFIG_FB_EFI=y
-CONFIG_LOGO=y
-# CONFIG_LOGO_LINUX_MONO is not set
-# CONFIG_LOGO_LINUX_VGA16 is not set
+CONFIG_DRM_VIRTIO_GPU=y
 CONFIG_SOUND=y
 CONFIG_SND=y
 CONFIG_SND_HRTIMER=y
@@ -213,6 +230,8 @@ CONFIG_USB_STORAGE=y
 CONFIG_RTC_CLASS=y
 # CONFIG_RTC_HCTOSYS is not set
 CONFIG_DMADEVICES=y
+CONFIG_VIRTIO_PCI=y
+CONFIG_VIRTIO_INPUT=y
 CONFIG_EEEPC_LAPTOP=y
 CONFIG_AMD_IOMMU=y
 CONFIG_INTEL_IOMMU=y
@@ -237,6 +256,7 @@ CONFIG_NFS_FS=y
 CONFIG_NFS_V3_ACL=y
 CONFIG_NFS_V4=y
 CONFIG_ROOT_NFS=y
+CONFIG_9P_FS=y
 CONFIG_NLS_DEFAULT="utf8"
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ASCII=y
@@ -257,5 +277,3 @@ CONFIG_BLK_DEV_IO_TRACE=y
 CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
 CONFIG_EARLY_PRINTK_DBGP=y
 CONFIG_DEBUG_BOOT_PARAMS=y
-CONFIG_KALLSYMS_ALL=y
-CONFIG_WERROR=y

