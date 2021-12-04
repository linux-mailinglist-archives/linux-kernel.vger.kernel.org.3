Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1CC4682E2
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 07:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384420AbhLDGOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 01:14:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384250AbhLDGOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 01:14:31 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97F3C061D7E;
        Fri,  3 Dec 2021 22:11:04 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id m192so5854214qke.2;
        Fri, 03 Dec 2021 22:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9ZCWkWDq48UBrai2D1TmmTdR94DXJ7wnNUbZMk//cy0=;
        b=I9LQ1IKEGyvcAR3A0a3KP68qCAVxBVNMzdKp5+/XJFuQS8vHQQw+dQkr7PewYJ+tDG
         dROhPyxEo3vSN32ugBWmMDwJBFdkSWoaYGT9bmgh+OzFog68gRlUk0b4vXfDStVjIa2y
         lLp7ecVo06SK+LeWBlISSXMHHMiLgbn1OZ9kD+xWy88mf/cEuHsdHt9/Aq5pnSMOA0ih
         0bj94+9mjaYqyn3TUYCfU0cmScJKIBw1NiS9CV1BYF0mzFhEk0p/a70Cjh9l8Cyc11Bp
         P8T3ZSLCMAmtzFpOlKzpSo+HjqG7wC9Y5gqvRk6VJJ4qtOJ1mWL4SP+lUFP407XLuDOD
         pOcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9ZCWkWDq48UBrai2D1TmmTdR94DXJ7wnNUbZMk//cy0=;
        b=iYXE+Z7hfAuhdk9hji2723pm4EIhsB/J2c4qVEQxv0NftX40KQn0rTE00u8seURSAM
         2xexSzvSVmVzZBjWMSkUxBIaZKbl4B4o8gLeJmblpK5LLE5g5cqqcCKh8sYK6uM5hsja
         8UFv2WIXih/KjRvz56ER12WL6Sl1B1KHNAwleG+hIdVoZu41dpzmolZovPi3I6UD/uo5
         nOtRnpULfrVz9riOZnrdherkfb/qsaTv4+sl4/riDDct9RjbI8p0PFfL56z7d5CzptDv
         ddNrzM5YUBFdZw7gH6SFhriUluW4S8yzyMpqliPmIEsF/e6pOLcOmtamFJ2+4o/jk8sZ
         /POw==
X-Gm-Message-State: AOAM5314jwmlBLkt2dOS2ubNat5QmCKAoXWzY5VITAusTuui8ix9e2BK
        pGzuxfy2x7M2v4GmtXh5R8w=
X-Google-Smtp-Source: ABdhPJxa7N3sj9y3U0qhseSAE9RbeBnuLXpuDSxXyLC5PHjjucbquP8Bcd5yPE3s/LDy99YXV1GcBA==
X-Received: by 2002:a05:620a:4087:: with SMTP id f7mr21508305qko.56.1638598263928;
        Fri, 03 Dec 2021 22:11:03 -0800 (PST)
Received: from jesse-desktop.jtp-bos.lab (146-115-144-188.s4282.c3-0.nwt-cbr1.sbo-nwt.ma.cable.rcncustomer.com. [146.115.144.188])
        by smtp.gmail.com with ESMTPSA id l1sm3500913qkp.125.2021.12.03.22.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 22:11:03 -0800 (PST)
From:   Jesse Taube <mr.bossman075@gmail.com>
X-Google-Original-From: Jesse Taube <Mr.Bossman075@gmail.com>
To:     linux-imx@nxp.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, ulf.hansson@linaro.org, aisheng.dong@nxp.com,
        stefan@agner.ch, linus.walleij@linaro.org,
        gregkh@linuxfoundation.org, arnd@arndb.de, olof@lixom.net,
        soc@kernel.org, linux@armlinux.org.uk, abel.vesa@nxp.com,
        adrian.hunter@intel.com, jirislaby@kernel.org,
        giulio.benetti@benettiengineering.com,
        nobuhiro1.iwamatsu@toshiba.co.jp, Mr.Bossman075@gmail.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: [PATCH v4 13/13] ARM: imxrt1050_defconfig: add i.MXRT1050 defconfig
Date:   Sat,  4 Dec 2021 01:10:42 -0500
Message-Id: <20211204061042.1248028-14-Mr.Bossman075@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211204061042.1248028-1-Mr.Bossman075@gmail.com>
References: <20211204061042.1248028-1-Mr.Bossman075@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Giulio Benetti <giulio.benetti@benettiengineering.com>

Add i.MXRT1050 defconfig, that will be the basis for the i.MXRT family.

Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
---
V1->V2:
* Nothing done
V2->V3:
* Nothing done
V3->V4:
* Remove unnecessary CONFIGs
* Add futex suport after "ARM: 9122/1: select HAVE_FUTEX_CMPXCHG"
9d417cbe36eee7afdd85c2e871685f8dab7c2dba
---
 arch/arm/configs/imxrt_defconfig | 35 ++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 arch/arm/configs/imxrt_defconfig

diff --git a/arch/arm/configs/imxrt_defconfig b/arch/arm/configs/imxrt_defconfig
new file mode 100644
index 000000000000..52dba3762996
--- /dev/null
+++ b/arch/arm/configs/imxrt_defconfig
@@ -0,0 +1,35 @@
+# CONFIG_LOCALVERSION_AUTO is not set
+CONFIG_BPF_SYSCALL=y
+CONFIG_SCHED_AUTOGROUP=y
+# CONFIG_MMU is not set
+CONFIG_ARCH_MXC=y
+CONFIG_SOC_IMXRT=y
+CONFIG_SET_MEM_PARAM=y
+CONFIG_DRAM_BASE=0x80000000
+CONFIG_DRAM_SIZE=0x02000000
+CONFIG_BINFMT_FLAT=y
+CONFIG_UEVENT_HELPER=y
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
+CONFIG_IMX_WEIM=y
+CONFIG_LEGACY_PTY_COUNT=2
+CONFIG_SERIAL_FSL_LPUART=y
+CONFIG_SERIAL_FSL_LPUART_CONSOLE=y
+CONFIG_SERIAL_DEV_BUS=y
+CONFIG_PINCTRL_IMXRT1050=y
+CONFIG_GPIO_MXC=y
+CONFIG_MMC=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_PLTFM=y
+CONFIG_MMC_SDHCI_ESDHC_IMX=y
+CONFIG_DMADEVICES=y
+CONFIG_FSL_EDMA=y
+CONFIG_CLK_IMXRT1050=y
+CONFIG_EXT4_FS=y
+CONFIG_EXT4_FS_POSIX_ACL=y
+CONFIG_EXT4_FS_SECURITY=y
+CONFIG_VFAT_FS=y
+CONFIG_FAT_DEFAULT_UTF8=y
+CONFIG_EXFAT_FS=y
+CONFIG_NLS_ASCII=y
+CONFIG_NLS_UTF8=y
-- 
2.34.0

