Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22DEF48B995
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 22:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245176AbiAKV0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 16:26:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245113AbiAKV0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 16:26:20 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B93C061748;
        Tue, 11 Jan 2022 13:26:19 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id bp39so753197qtb.6;
        Tue, 11 Jan 2022 13:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gcay47mnt+Y1wwFTi1j1d7+PqOItiKhQGaCcgWf4Lbk=;
        b=oG2Ny+TeQtdSRxOP3ix5if5Cl2gFBLNUu1Mu9cuGn3VcODR7MOXpPWwQL1hPjXvckn
         Ivc7BAPmHptEPWbJGSPhTVJxOvhOgPPA8GW0M0bMpAaABAgvm9w0v4ALDjytHX30FJHf
         CaR1eXoW7ozjKO/wMuTFJQJ5JdN2KkLpiNgTu1hUyEdBOVN8S8WC8zdHrGcFpoMoBDY/
         UiYs1Z2iXrldMNPmthsIn5ZpwuD6SPtw3Agyn8OLPvFSsMpYh8ZxSsMRL4P49re0/MJE
         NeQSYy66pQ4tAyeP+9X9ipS6QzAx5Uy06rvKfS4ZhQJhVRpDcQ3M3rvH/4Rke5iORo2S
         KAWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gcay47mnt+Y1wwFTi1j1d7+PqOItiKhQGaCcgWf4Lbk=;
        b=wDgmW2WVFXOLMsPQuRpMq/zvFJm93qZF1MDQS+IcPZj9GfZz8DRt2qowl4YF4sz5bV
         oNuRW60H8+/WwHddBdXc/A4pCNdzbjenb83gpjhThUF7JktLwxzsg0Zztvf23uHqvYNw
         0Dam4BDuKSmcJ94377PCotER9n0/FhkutLRCjlAXz8Kcp0oOv4g+cloH94HCYxQuI5dF
         V2QpmRsqMjmwO6u8tC2p1e4lKckItMqADKr/K9zzdOQoHC9NiZDcWgH9wm1r9/IwYXnG
         S593Jc5NcO/w1kIIIrrPJF0YdWOx+aHZkCB68sG7D5h89SQYggm6tjDH6evv8iElOw+t
         8Pcg==
X-Gm-Message-State: AOAM533RgZoHp9jesZCIEQw3EA1AFKjmMqmS2ZdFg2QVPD6Zmhjt1g47
        c0OxMYlS1rYyhj588Iqeps8=
X-Google-Smtp-Source: ABdhPJx8GNhR8MBa4dRgv9X5rfTXYQS6I2fB6veiXguggS8ptPd0f7DgzNfVw+c82mDldE/GCws/9A==
X-Received: by 2002:ac8:7c54:: with SMTP id o20mr5415359qtv.585.1641936379064;
        Tue, 11 Jan 2022 13:26:19 -0800 (PST)
Received: from jesse-desktop.jtp-bos.lab (146-115-144-188.s4282.c3-0.nwt-cbr1.sbo-nwt.ma.cable.rcncustomer.com. [146.115.144.188])
        by smtp.gmail.com with ESMTPSA id l15sm7761990qkp.16.2022.01.11.13.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 13:26:18 -0800 (PST)
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
Subject: [PATCH v7 7/7] ARM: imxrt_defconfig: Add i.MXRT family defconfig
Date:   Tue, 11 Jan 2022 16:26:06 -0500
Message-Id: <20220111212606.2072669-8-Mr.Bossman075@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220111212606.2072669-1-Mr.Bossman075@gmail.com>
References: <20220111212606.2072669-1-Mr.Bossman075@gmail.com>
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

