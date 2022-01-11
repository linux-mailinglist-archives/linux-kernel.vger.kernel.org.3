Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7BF948BA24
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 22:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344822AbiAKVyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 16:54:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343613AbiAKVya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 16:54:30 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA1AC061751;
        Tue, 11 Jan 2022 13:54:29 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id iw1so837130qvb.1;
        Tue, 11 Jan 2022 13:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gcay47mnt+Y1wwFTi1j1d7+PqOItiKhQGaCcgWf4Lbk=;
        b=pBTor3+wP7S0SOqary/oB7az5TpEZWSB3ynmH0oeeEp2xF3q/CFzJjzqQeeAN/Sj6r
         SFIfEEJPy7BU64kDC7uWgTG9IQZ7/VgzawNpMiP07Cq31J2l3trJeNdoIuZmErUyg2dS
         XcWX4nmlXL9madFJ10uKxUCI7KoL29Shtd8tzegWVFEAaV49wlkSpnyS5ymFWvcI/Rl8
         FAIBV3d0JeWLuQ0FRNfOpXJGKYTmgQd+qguA/lFc+6GgHx6jhkLsI5WcodGoVMCAsRxs
         IdSCwIArwV6n6Q+KyVrW/gj6zb2re+B+7aqfwMIBXl3zFcdV53+n2KRlRX25OxZUIdLI
         I4ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gcay47mnt+Y1wwFTi1j1d7+PqOItiKhQGaCcgWf4Lbk=;
        b=c3xkxVHxdy3mL69edM+iIFmwZUZsT+q0i+lQVESlGXep5Bww3mnGTac525RBmc0iFJ
         +6GhUslFxYQL1cQ40z4wEr3Xb778jZQBSi5+40mIgR3hIg33VNFKVnVH4VlMdX2dk0Na
         SoGo+ENDjSK2HWrHuIMfMgPgxnBx+vwP/Jmvf32JD6031zl62QBhEKN8NECycpJDCoWb
         vBeYv9LEol5vAWxuzUYyMt++A4B7IOhNun/wTZHkdPB+Z9zeUsn9OuSGGv5P6iMgthOC
         ltrl7RWOMy/jiHBZussnBiQy7g6eGaFks6Zl5p+lvzMaGaxlqEVXPY1WJUWqG9TaGW3L
         nkCQ==
X-Gm-Message-State: AOAM531vk2EIsj/YguF6plK9+eQhk7PPnWLry/Kh4w3M+E6x6UwJ+Luz
        R2eM530yBBQZwiKfD1iNq5I=
X-Google-Smtp-Source: ABdhPJzALPYqChRutdtzquXDFIRPBPOJyNZxQ9ygFSsLztYwti//GeSdU4E5Zlfzdb86+BFSUlUBSA==
X-Received: by 2002:a05:6214:c22:: with SMTP id a2mr5742820qvd.71.1641938069182;
        Tue, 11 Jan 2022 13:54:29 -0800 (PST)
Received: from jesse-desktop.jtp-bos.lab (146-115-144-188.s4282.c3-0.nwt-cbr1.sbo-nwt.ma.cable.rcncustomer.com. [146.115.144.188])
        by smtp.gmail.com with ESMTPSA id l10sm7591020qtk.18.2022.01.11.13.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 13:54:28 -0800 (PST)
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
Subject: [PATCH v8 7/7] ARM: imxrt_defconfig: Add i.MXRT family defconfig
Date:   Tue, 11 Jan 2022 16:54:15 -0500
Message-Id: <20220111215415.2075257-8-Mr.Bossman075@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220111215415.2075257-1-Mr.Bossman075@gmail.com>
References: <20220111212606.2072669-1-Mr.Bossman075@gmail.com>
 <20220111215415.2075257-1-Mr.Bossman075@gmail.com>
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
V6->V7:
* Nothing done
V7->V8:
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

