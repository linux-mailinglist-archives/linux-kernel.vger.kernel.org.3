Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33E0847C3D8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 17:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239834AbhLUQf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 11:35:56 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:58700 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239831AbhLUQfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 11:35:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2429861687;
        Tue, 21 Dec 2021 16:35:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85005C36AEC;
        Tue, 21 Dec 2021 16:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640104554;
        bh=37IMHVJWT8iFSW/Zorv/QJp1kD8U97EWQ2fm9ilMpcc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VfEInCc2gJ4DYuWbzUYNrwXfVQGQjJAMy91gcX96jrWtFEc29ZVC7UnokxDKgBzSh
         a9x1wEB96ZmjCL7OfQKIgr/f5kSzJe3XqtPnT596EG6n99f8KjhHvHWVBbWQKFbXle
         rfRv98Icm3wXYg/4FvFUlNNQwHRqPuJYRQ7lbiJzPf61nWstQBQOyfNeGPL/T5MeyT
         79zCVZ+79QIGx5KwYAwSQLFvxgIfK7CJSTWEDjLIw3j6RwKKAUNK1QQpvY9dqadVsf
         6uB85ssbwsCR2zticdQLEcnTtdB7XkwxhYSSDO1GfwhJpyShJS+XVjdI172ra2x/kQ
         Lf7h36qQ+L9HA==
From:   guoren@kernel.org
To:     guoren@kernel.org, palmer@dabbelt.com, arnd@arndb.de,
        anup.patel@wdc.com, gregkh@linuxfoundation.org,
        liush@allwinnertech.com, wefu@redhat.com, drew@beagleboard.org,
        wangjunqiang@iscas.ac.cn, lazyparser@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH 02/13] riscv: Fixup difference with defconfig
Date:   Wed, 22 Dec 2021 00:35:21 +0800
Message-Id: <20211221163532.2636028-3-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211221163532.2636028-1-guoren@kernel.org>
References: <20211221163532.2636028-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Let's follow the origin patch's spirit.

The only difference between rv32_defconfig and defconfig is that
rv32_defconfig has  CONFIG_ARCH_RV32I=y.

This is helpful to compare rv64-compat-rv32 v.s. rv32-linux.

Fixes: 1b937e8faa87ccfb ("RISC-V: Add separate defconfig for 32bit systems")
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Anup Patel <anup.patel@wdc.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
---
 arch/riscv/configs/rv32_defconfig | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/configs/rv32_defconfig b/arch/riscv/configs/rv32_defconfig
index 6e9f12ff968a..d858906cff2d 100644
--- a/arch/riscv/configs/rv32_defconfig
+++ b/arch/riscv/configs/rv32_defconfig
@@ -1,3 +1,4 @@
+CONFIG_ARCH_RV32I=y
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 CONFIG_NO_HZ_IDLE=y
@@ -16,7 +17,7 @@ CONFIG_EXPERT=y
 CONFIG_BPF_SYSCALL=y
 CONFIG_SOC_SIFIVE=y
 CONFIG_SOC_VIRT=y
-CONFIG_ARCH_RV32I=y
+CONFIG_SOC_MICROCHIP_POLARFIRE=y
 CONFIG_SMP=y
 CONFIG_HOTPLUG_CPU=y
 CONFIG_VIRTUALIZATION=y
@@ -41,10 +42,12 @@ CONFIG_PCI=y
 CONFIG_PCIEPORTBUS=y
 CONFIG_PCI_HOST_GENERIC=y
 CONFIG_PCIE_XILINX=y
+CONFIG_PCIE_FU740=y
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_VIRTIO_BLK=y
+CONFIG_BLK_DEV_NVME=m
 CONFIG_BLK_DEV_SD=y
 CONFIG_BLK_DEV_SR=y
 CONFIG_SCSI_VIRTIO=y
@@ -68,11 +71,14 @@ CONFIG_HW_RANDOM=y
 CONFIG_HW_RANDOM_VIRTIO=y
 CONFIG_SPI=y
 CONFIG_SPI_SIFIVE=y
+CONFIG_GPIOLIB=y
+CONFIG_GPIO_SIFIVE=y
 # CONFIG_PTP_1588_CLOCK is not set
 CONFIG_POWER_RESET=y
-CONFIG_DRM=y
-CONFIG_DRM_RADEON=y
-CONFIG_DRM_VIRTIO_GPU=y
+CONFIG_DRM=m
+CONFIG_DRM_RADEON=m
+CONFIG_DRM_NOUVEAU=m
+CONFIG_DRM_VIRTIO_GPU=m
 CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
@@ -83,6 +89,9 @@ CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_OHCI_HCD_PLATFORM=y
 CONFIG_USB_STORAGE=y
 CONFIG_USB_UAS=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_PLTFM=y
+CONFIG_MMC_SDHCI_CADENCE=y
 CONFIG_MMC=y
 CONFIG_MMC_SPI=y
 CONFIG_RTC_CLASS=y
@@ -105,6 +114,8 @@ CONFIG_NFS_V4_1=y
 CONFIG_NFS_V4_2=y
 CONFIG_ROOT_NFS=y
 CONFIG_9P_FS=y
+CONFIG_NLS_CODEPAGE_437=y
+CONFIG_NLS_ISO8859_1=m
 CONFIG_CRYPTO_USER_API_HASH=y
 CONFIG_CRYPTO_DEV_VIRTIO=y
 CONFIG_PRINTK_TIME=y
@@ -133,3 +144,4 @@ CONFIG_RCU_EQS_DEBUG=y
 # CONFIG_RUNTIME_TESTING_MENU is not set
 CONFIG_MEMTEST=y
 # CONFIG_SYSFS_SYSCALL is not set
+CONFIG_EFI=y
-- 
2.25.1

