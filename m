Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 708E252FF7E
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 22:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346114AbiEUUqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 16:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344206AbiEUUqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 16:46:44 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF9C3CFFD
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 13:46:43 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id h9so2300484pgl.4
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 13:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=subject:date:message-id:mime-version:content-transfer-encoding:cc
         :from:to;
        bh=usyhwP/KwRkMAAW3OjtqeLeezQkFXtj2bkw/kE19m5Q=;
        b=1YyhYIEIaB24tj28Re+FkAgGzvmYJUoPfz+vFi5S2BnvCTcUOa7KBTg4/TZsySrRb7
         XJs3RGcdcGVEoCnC39Un23ArHdivPh26Ss+unkT28Y5i7eCHbSbLijN/PyTh2pYZoCEo
         p2stm6cDp0Nw+iEhRYOb4U+x2Qo10Lxkzgdh/mDS8erQB3eLlV1u8Ur6dplcgV8km+oD
         3XfZ3m8Z/lia6JlGzBIdrr45kTV11Cx3aDnhghFHckspAPX0F/9+gR85ieAl2JrnEqxM
         faf51/ZmCHV/4VcgBvKNrl3dNVui9NIXH15JHg33cclg3/xDmE9VtWU5CXNxLZGFrcrb
         FVkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:date:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=usyhwP/KwRkMAAW3OjtqeLeezQkFXtj2bkw/kE19m5Q=;
        b=XI8Nl5OQlBJKwupgbDi+U5dzf/pvw3PBajbqfO7nXmnnB4qDSmabv9yN29NNJz88GG
         ThfTcC2kYu/6asOJ/nCr6mFui76XNEfj3A/gWEZjXzDmmxrj1re60Bjj4v+JcR7t3M6D
         c3aeiTBigStFxBZtqt8FIBPfIoz3+dv9DswalAvwfhn3VsbSjHr5/gAuh394fGCT5Pbl
         5Cdgq50/LgDos+NfjjLGry3K1mu4Ljflu+8ssbMRR0/U7DoMnCDcmzMPErgUbPEudNFB
         VQaqeGWwAs6j3TUH5esstTTMAbBxTrhPOViuO2Gg+gG8UYoa7myW1UqbxW9PH76fcGmB
         sgOg==
X-Gm-Message-State: AOAM53373QQc5V+2pqdBgsm7XNjAtF5cvJyXazQhkS2d6z/IaiQgXuNV
        RckRAuvRqT7KjRYiqt9yj/ETcA==
X-Google-Smtp-Source: ABdhPJxTe/x0IsEod7AHPDynxPnajNHzpIfJC5+mhuOEbsM1Ivf0vj0d66+wgOtLpXZXwq3QnVmMXg==
X-Received: by 2002:a63:4f1e:0:b0:3f5:cf9b:7b94 with SMTP id d30-20020a634f1e000000b003f5cf9b7b94mr13726257pgb.457.1653166002598;
        Sat, 21 May 2022 13:46:42 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id k2-20020a17090a62c200b001df3d5a441bsm4013626pjs.53.2022.05.21.13.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 13:46:42 -0700 (PDT)
Subject: [PATCH v3] RISC-V: Add CONFIG_{NON,}PORTABLE
Date:   Sat, 21 May 2022 12:33:57 -0700
Message-Id: <20220521193356.26562-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        rdunlap@infradead.org, Arnd Bergmann <arnd@arndb.de>,
        anup@brainfault.org, alexandre.ghiti@canonical.com,
        damien.lemoal@opensource.wdc.com,
        Atish Patra <atishp@rivosinc.com>, axboe@kernel.dk,
        guoren@kernel.org, mchitale@ventanamicro.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@rivosinc.com, Palmer Dabbelt <palmer@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:         linux-riscv@lists.infradead.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmer@rivosinc.com>

The RISC-V port has collected a handful of options that are
fundamentally non-portable.  To prevent users from shooting themselves
in the foot, hide them all behind a config entry that explicitly calls
out that non-portable binaries may be produced.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
Changes since v2:

* Update the nommu and rv32 defconfigs.  I'm still getting some ugliness
  like

    $ make.riscv rv32_defconfig
    *** Default configuration is based on 'defconfig'
    #
    # configuration written to .config
    #
    Using .config as base
    Merging ./arch/riscv/configs/32-bit.config
    Value of CONFIG_PORTABLE is redefined by fragment ./arch/riscv/configs/32-bit.config:
    Previous value: CONFIG_PORTABLE=y
    New value: # CONFIG_PORTABLE is not set
    
    Value of CONFIG_NONPORTABLE is redefined by fragment ./arch/riscv/configs/32-bit.config:
    Previous value: # CONFIG_NONPORTABLE is not set
    New value: CONFIG_NONPORTABLE=y
    
    #
    # merged configuration written to .config (needs make)
    #
    .config:3831:warning: override: ARCH_RV32I changes choice state
    #
    # configuration written to .config
    #

  not sure if there's a better way to do this.

Changes since v1:

* Fix a bunch of spelling mistakes.
* Move NONPORTABLE under the "Platform type" sub-heading.
* Fix the rv32i dependency.

---
 arch/riscv/Kconfig                            | 28 +++++++++++++++++--
 arch/riscv/configs/32-bit.config              |  2 ++
 arch/riscv/configs/nommu_k210_defconfig       |  1 +
 .../riscv/configs/nommu_k210_sdcard_defconfig |  1 +
 arch/riscv/configs/nommu_virt_defconfig       |  1 +
 arch/riscv/configs/rv32_defconfig             |  1 +
 6 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index f863065b478c..cd67b09a80f5 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -222,6 +222,21 @@ source "arch/riscv/Kconfig.erratas"
 
 menu "Platform type"
 
+config NONPORTABLE
+	bool "Allow configurations that result in non-portable kernels"
+	help
+	  RISC-V kernel binaries are compatible between all known systems
+	  whenever possible, but there are some use cases that can only be
+	  satisfied by configurations that result in kernel binaries that are
+	  not portable between systems.
+
+	  Selecting N does not guarantee kernels will be portable to all known
+	  systems.  Selecting any of the options guarded by NONPORTABLE will
+	  result in kernel binaries that are unlikely to be portable between
+	  systems.
+
+	  If unsure, say N.
+
 choice
 	prompt "Base ISA"
 	default ARCH_RV64I
@@ -231,6 +246,7 @@ choice
 
 config ARCH_RV32I
 	bool "RV32I"
+	depends on NONPORTABLE
 	select 32BIT
 	select GENERIC_LIB_ASHLDI3
 	select GENERIC_LIB_ASHRDI3
@@ -541,6 +557,7 @@ config STACKPROTECTOR_PER_TASK
 
 config PHYS_RAM_BASE_FIXED
 	bool "Explicitly specified physical RAM address"
+	depends on NONPORTABLE
 	default n
 
 config PHYS_RAM_BASE
@@ -554,7 +571,7 @@ config PHYS_RAM_BASE
 
 config XIP_KERNEL
 	bool "Kernel Execute-In-Place from ROM"
-	depends on MMU && SPARSEMEM
+	depends on MMU && SPARSEMEM && NONPORTABLE
 	# This prevents XIP from being enabled by all{yes,mod}config, which
 	# fail to build since XIP doesn't support large kernels.
 	depends on !COMPILE_TEST
@@ -594,9 +611,16 @@ endmenu
 
 config BUILTIN_DTB
 	bool
-	depends on OF
+	depends on OF && NONPORTABLE
 	default y if XIP_KERNEL
 
+config PORTABLE
+	bool
+	default !NONPORTABLE
+	select EFI
+	select OF
+	select MMU
+
 menu "Power management options"
 
 source "kernel/power/Kconfig"
diff --git a/arch/riscv/configs/32-bit.config b/arch/riscv/configs/32-bit.config
index 43f41323b67e..f6af0f708df4 100644
--- a/arch/riscv/configs/32-bit.config
+++ b/arch/riscv/configs/32-bit.config
@@ -1,2 +1,4 @@
 CONFIG_ARCH_RV32I=y
 CONFIG_32BIT=y
+# CONFIG_PORTABLE is not set
+CONFIG_NONPORTABLE=y
diff --git a/arch/riscv/configs/nommu_k210_defconfig b/arch/riscv/configs/nommu_k210_defconfig
index 2438fa39f8ae..96fe8def644c 100644
--- a/arch/riscv/configs/nommu_k210_defconfig
+++ b/arch/riscv/configs/nommu_k210_defconfig
@@ -28,6 +28,7 @@ CONFIG_EMBEDDED=y
 CONFIG_SLOB=y
 # CONFIG_MMU is not set
 CONFIG_SOC_CANAAN=y
+CONFIG_NONPORTABLE=y
 CONFIG_SMP=y
 CONFIG_NR_CPUS=2
 CONFIG_CMDLINE="earlycon console=ttySIF0"
diff --git a/arch/riscv/configs/nommu_k210_sdcard_defconfig b/arch/riscv/configs/nommu_k210_sdcard_defconfig
index 9a133e63ae5b..379740654373 100644
--- a/arch/riscv/configs/nommu_k210_sdcard_defconfig
+++ b/arch/riscv/configs/nommu_k210_sdcard_defconfig
@@ -20,6 +20,7 @@ CONFIG_EMBEDDED=y
 CONFIG_SLOB=y
 # CONFIG_MMU is not set
 CONFIG_SOC_CANAAN=y
+CONFIG_NONPORTABLE=y
 CONFIG_SMP=y
 CONFIG_NR_CPUS=2
 CONFIG_CMDLINE="earlycon console=ttySIF0 root=/dev/mmcblk0p1 rootwait ro"
diff --git a/arch/riscv/configs/nommu_virt_defconfig b/arch/riscv/configs/nommu_virt_defconfig
index 5269fbb6b4fc..1a56eda5ce46 100644
--- a/arch/riscv/configs/nommu_virt_defconfig
+++ b/arch/riscv/configs/nommu_virt_defconfig
@@ -25,6 +25,7 @@ CONFIG_EXPERT=y
 CONFIG_SLOB=y
 # CONFIG_MMU is not set
 CONFIG_SOC_VIRT=y
+CONFIG_NONPORTABLE=y
 CONFIG_SMP=y
 CONFIG_CMDLINE="root=/dev/vda rw earlycon=uart8250,mmio,0x10000000,115200n8 console=ttyS0"
 CONFIG_CMDLINE_FORCE=y
diff --git a/arch/riscv/configs/rv32_defconfig b/arch/riscv/configs/rv32_defconfig
index 7e5efdc3829d..77bdb1d05a88 100644
--- a/arch/riscv/configs/rv32_defconfig
+++ b/arch/riscv/configs/rv32_defconfig
@@ -18,6 +18,7 @@ CONFIG_EXPERT=y
 CONFIG_PROFILING=y
 CONFIG_SOC_SIFIVE=y
 CONFIG_SOC_VIRT=y
+CONFIG_NONPORTABLE=y
 CONFIG_ARCH_RV32I=y
 CONFIG_SMP=y
 CONFIG_HOTPLUG_CPU=y
-- 
2.34.1

