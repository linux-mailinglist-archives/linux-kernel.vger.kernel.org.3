Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 457C447CB20
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 02:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241978AbhLVBxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 20:53:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241786AbhLVBw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 20:52:57 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4562AC061574;
        Tue, 21 Dec 2021 17:52:57 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id kk22so1040991qvb.0;
        Tue, 21 Dec 2021 17:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=07Syrs0mol4aP5r4tQ4Umh+2XxC+VkRyobBBx7Xa8m0=;
        b=X/T3wcupFk6ZOaPM3UrjnTpC9p6uX5Olp62tItlPf6I6+3L8Z8PsrtYzA/DH+Xt+ln
         jXehlN38FDZ7qNGLwIXe/VNoDmecdpGpaoA6mm7rkloJxILPy+TIFJ9CprNGXcg4UFo6
         A5gRTGMhVNWWeLexAO3IMyvVSw3mTDimDC5+gouKyiwC1T17qXuLIs++wnUs4/4OEya1
         CkggCNJW0/6W8aqPzS0Jv8S+1QHxMpIq+cVQJx6fA4vvJBuASNpetoJFUEzIY4swjjIS
         +IH1pncZv2EIGkrpZEwIEWKdMi9RCb08VbFFzKpCfCKv14OwD/RayDlW4h1XYWQNh8r9
         xIyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=07Syrs0mol4aP5r4tQ4Umh+2XxC+VkRyobBBx7Xa8m0=;
        b=njud/2SkBSnFZeuMDpIjE7r9RNy8Z/3dtd9Yrjnlsix9P6bmaDStvFlJrWgAC3blGU
         4if4oz2zmdkxqGFl1B8V3y0qAH8f7a1khh/cwNAIJoNeR6VKZ9piUb8PoLCMR5u50ftk
         OF+SdQZFteFafsZ9XrrInKLRvPjg37i8piFnQ6YvMnCB4XCpqmolYPCjhgS97o7DEFBQ
         WyPx2qbfXl4vur6+qyqFet9qwCJmu/mDYNy/7azDQQzC0mkIVzWlYYZa5+bqAv95++bl
         qEloYLKDf2GN7iMa7b2evnMHWLTclOpT7Ak8+Pbk47zt6UBoXfw4d+s2/7dSswMOwkmC
         f/sA==
X-Gm-Message-State: AOAM532MCofKmNo0G9YFNuzPTyKKv8KQX5QNxhkzxDUailAQVnBf4a3X
        Cxg77edyDX17SjKsdCvk9O8=
X-Google-Smtp-Source: ABdhPJz2ReMMBRF5tpUHQ359iYZEJF5OTseW1Y/LUdoaS272T9QSfmOM9c0MiYN6fax7//s0aMVJBQ==
X-Received: by 2002:a05:6214:4015:: with SMTP id kd21mr901299qvb.41.1640137976494;
        Tue, 21 Dec 2021 17:52:56 -0800 (PST)
Received: from jesse-desktop.jtp-bos.lab (146-115-144-188.s4282.c3-0.nwt-cbr1.sbo-nwt.ma.cable.rcncustomer.com. [146.115.144.188])
        by smtp.gmail.com with ESMTPSA id d4sm658161qkn.79.2021.12.21.17.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 17:52:56 -0800 (PST)
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
Subject: [PATCH v6 7/7] ARM: imxrt_defconfig: Add i.MXRT family defconfig
Date:   Tue, 21 Dec 2021 20:52:44 -0500
Message-Id: <20211222015244.2464671-8-Mr.Bossman075@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211222015244.2464671-1-Mr.Bossman075@gmail.com>
References: <20211222015244.2464671-1-Mr.Bossman075@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Giulio Benetti <giulio.benetti@benettiengineering.com>

Add generic i.MXRT family defconfig.

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
V4->V5:
* Change commit description
V5->V6:
* Nothing done
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
2.34.1

