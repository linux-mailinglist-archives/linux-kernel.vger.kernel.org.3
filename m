Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB0B490588
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 10:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238405AbiAQJ5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 04:57:24 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:37166
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233448AbiAQJ5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 04:57:21 -0500
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 704CB3F1E1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 09:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642413438;
        bh=EydrzfONuvCJ3GDZ6a2m2aD/U8coEqSGBnCJGhzxmq8=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=TznLwHsyE5vk6JXWN5Sq0WamoHQO8p+QtfbSwxEaeJDZUfNKXDk7g6S5oWGTWgZ/7
         0kmN+jbsNAkXDjpEFAbsAS8hNERrEwVFyx8/Pz4NOpSpl8LpF+IA2mq8aoNIkXJk9H
         mCrUIuJs/1/99+2JqrJqDv7U40FPabdZtaAD4gUmHj8+0w0UUPwiIZLtHh02WlrheX
         YlD7fSLPfCty/6TZDzFbJ4U+Gnwb7Sh1YktnThcPKJKARfXyYIo9JvNMKvhJMJPWg3
         kKoyXvziMHohlHBsqPAOAsDCSTYzqjUmPRR+VoZQcep7SLJfPx8hCAgvyGCzkAyBBU
         U+jbD2KBF9oDQ==
Received: by mail-wm1-f71.google.com with SMTP id v190-20020a1cacc7000000b0034657bb6a66so4966084wme.6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 01:57:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EydrzfONuvCJ3GDZ6a2m2aD/U8coEqSGBnCJGhzxmq8=;
        b=TE5+AfzkFdTQCDNlEeAQy5WxKaXfhEkbHL62/p2PJ/IBnTxhOa8cUU3vKnNkc3JYUq
         UjblngwDBRtgnFTbRAJ17RLaxXVTC6+y3WqbDUSeeMGPE9zvA/ewqnxUT7IoOW+0wBEW
         kJu0V0olEmYdtBov4Qg7OVbF5nlmVUM2NcDj9j+9fsucT5nmxBJdKUKLK7q3bZJIO59X
         7JmWb3hs0VBEQRm5IR0ui9x+pLh5Qwk18FwVba0izIq+Ig+xz2B7K8zw/fyEHFAuYhPn
         PS8f62ePuIGpfSCA4hg6rHmqij9LJRvPJswMDevd5JJ/yUced3ONrxYdGrgyARdrglEf
         d1Aw==
X-Gm-Message-State: AOAM53244qV3Ryxf/ksrQEYhyrXSNJqo0iH8OW6gMDqlV+wsu0YW2m4F
        IZj598v8TkSaliEXeisdLL+LmrnJNCp5HGO7Zb0AKgEmzEz+KFtEMCoyVwk3GGfBxLbgnq4E2VL
        RzX0PWTW00R8w9k0j5/2Fb4GcOhimrRqRhA2haZsbxQ==
X-Received: by 2002:a5d:64e3:: with SMTP id g3mr6090714wri.450.1642413438146;
        Mon, 17 Jan 2022 01:57:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw/4vcuV9y3MHHQHy6ByzoTMq/wmxrv5ThZ2hY99ztSdfnFZx1hQWh4V1k/sVSLvXnIbRjdvQ==
X-Received: by 2002:a5d:64e3:: with SMTP id g3mr6090701wri.450.1642413437950;
        Mon, 17 Jan 2022 01:57:17 -0800 (PST)
Received: from localhost.localdomain (lfbn-gre-1-195-1.w90-112.abo.wanadoo.fr. [90.112.158.1])
        by smtp.gmail.com with ESMTPSA id r132sm13691305wma.34.2022.01.17.01.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 01:57:17 -0800 (PST)
From:   Alexandre Ghiti <alexandre.ghiti@canonical.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alex@ghiti.fr>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Conor Dooley <Conor.Dooley@microchip.com>
Subject: [PATCH -next] riscv: Get rid of MAXPHYSMEM configs
Date:   Mon, 17 Jan 2022 10:57:16 +0100
Message-Id: <20220117095716.2512405-1-alexandre.ghiti@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_MAXPHYSMEM_* are actually never used, even the nommu defconfigs
selecting the MAXPHYSMEM_2GB had no effects on PAGE_OFFSET since it was
preempted by !MMU case right before.

In addition, the move of the kernel mapping at the end of the address
space broke the use of MAXPHYSMEM_2G with MMU since it defines PAGE_OFFSET
at the same address as the kernel mapping.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Fixes: 2bfc6cd81bd1 ("riscv: Move kernel mapping outside of linear mapping")
Signed-off-by: Alexandre Ghiti <alexandre.ghiti@canonical.com>
Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Tested-by: Conor Dooley <Conor.Dooley@microchip.com>
---
 arch/riscv/Kconfig                            | 23 ++-----------------
 arch/riscv/configs/nommu_k210_defconfig       |  1 -
 .../riscv/configs/nommu_k210_sdcard_defconfig |  1 -
 arch/riscv/configs/nommu_virt_defconfig       |  1 -
 4 files changed, 2 insertions(+), 24 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index de89279c8f57..f961a81e58af 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -160,10 +160,9 @@ config PA_BITS
 
 config PAGE_OFFSET
 	hex
-	default 0xC0000000 if 32BIT && MAXPHYSMEM_1GB
+	default 0xC0000000 if 32BIT
 	default 0x80000000 if 64BIT && !MMU
-	default 0xffffffff80000000 if 64BIT && MAXPHYSMEM_2GB
-	default 0xffffffe000000000 if 64BIT && MAXPHYSMEM_128GB
+	default 0xffffffe000000000 if 64BIT
 
 config KASAN_SHADOW_OFFSET
 	hex
@@ -272,24 +271,6 @@ config MODULE_SECTIONS
 	bool
 	select HAVE_MOD_ARCH_SPECIFIC
 
-choice
-	prompt "Maximum Physical Memory"
-	default MAXPHYSMEM_1GB if 32BIT
-	default MAXPHYSMEM_2GB if 64BIT && CMODEL_MEDLOW
-	default MAXPHYSMEM_128GB if 64BIT && CMODEL_MEDANY
-
-	config MAXPHYSMEM_1GB
-		depends on 32BIT
-		bool "1GiB"
-	config MAXPHYSMEM_2GB
-		depends on 64BIT
-		bool "2GiB"
-	config MAXPHYSMEM_128GB
-		depends on 64BIT && CMODEL_MEDANY
-		bool "128GiB"
-endchoice
-
-
 config SMP
 	bool "Symmetric Multi-Processing"
 	help
diff --git a/arch/riscv/configs/nommu_k210_defconfig b/arch/riscv/configs/nommu_k210_defconfig
index e8ceab678e8b..3f42ed87dde8 100644
--- a/arch/riscv/configs/nommu_k210_defconfig
+++ b/arch/riscv/configs/nommu_k210_defconfig
@@ -29,7 +29,6 @@ CONFIG_EMBEDDED=y
 CONFIG_SLOB=y
 # CONFIG_MMU is not set
 CONFIG_SOC_CANAAN=y
-CONFIG_MAXPHYSMEM_2GB=y
 CONFIG_SMP=y
 CONFIG_NR_CPUS=2
 CONFIG_CMDLINE="earlycon console=ttySIF0"
diff --git a/arch/riscv/configs/nommu_k210_sdcard_defconfig b/arch/riscv/configs/nommu_k210_sdcard_defconfig
index 46aa3879f19c..2a82a3b2992b 100644
--- a/arch/riscv/configs/nommu_k210_sdcard_defconfig
+++ b/arch/riscv/configs/nommu_k210_sdcard_defconfig
@@ -21,7 +21,6 @@ CONFIG_EMBEDDED=y
 CONFIG_SLOB=y
 # CONFIG_MMU is not set
 CONFIG_SOC_CANAAN=y
-CONFIG_MAXPHYSMEM_2GB=y
 CONFIG_SMP=y
 CONFIG_NR_CPUS=2
 CONFIG_CMDLINE="earlycon console=ttySIF0 rootdelay=2 root=/dev/mmcblk0p1 ro"
diff --git a/arch/riscv/configs/nommu_virt_defconfig b/arch/riscv/configs/nommu_virt_defconfig
index 385cca741b01..5f078156dfcd 100644
--- a/arch/riscv/configs/nommu_virt_defconfig
+++ b/arch/riscv/configs/nommu_virt_defconfig
@@ -27,7 +27,6 @@ CONFIG_SLOB=y
 # CONFIG_SLAB_MERGE_DEFAULT is not set
 # CONFIG_MMU is not set
 CONFIG_SOC_VIRT=y
-CONFIG_MAXPHYSMEM_2GB=y
 CONFIG_SMP=y
 CONFIG_CMDLINE="root=/dev/vda rw earlycon=uart8250,mmio,0x10000000,115200n8 console=ttyS0"
 CONFIG_CMDLINE_FORCE=y
-- 
2.32.0

