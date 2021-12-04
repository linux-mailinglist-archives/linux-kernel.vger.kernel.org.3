Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CACC4468595
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 15:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385307AbhLDOl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 09:41:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244644AbhLDOlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 09:41:13 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A14C061751;
        Sat,  4 Dec 2021 06:37:47 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id t26so13735015lfk.9;
        Sat, 04 Dec 2021 06:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vJMd0+EtuV8FsgOp2tgrhJ12mBC/qiVsCflNDi5Px6s=;
        b=J4nAQrAkwH/Gnv10HYyAjYclVHwZ+Dc+e/HU24jpCQyfQIGuL/LYsyHcT9aqu9mBlx
         2ZHGA6QHLDHz50XWqOBT+vAeYt6WoD+kq5GEPUMaGtalmcJLgDCYbGDhPww7PTQnoFd3
         TdDvinyvBhzu/c+25gWOGq2vRncyxEQeLYZORThcTukOn5+6KGofzmtR3Qb/rf7mdzYZ
         dhm9fQTmPgZQrrQxvnsoRoy1U28BLOLbQp43sjLlU2REomLfcKEyLWvJz25ftJzrh2C5
         Dhl9Eq0R/X3teSl9udi6jfE/tTEND4svSK+icdKmX3EQDfRvdMrJNUi/A3D0N5iU4h12
         9gIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vJMd0+EtuV8FsgOp2tgrhJ12mBC/qiVsCflNDi5Px6s=;
        b=212di1+Avpse8WJgw4QupoPOxiONQWF06AefzvXti9FKWR7c2GOxfbp90NziGe3gh+
         EBbKmmWV1st82gTx5VeVDecC7DjcKtgclBHO/bsnLsoJAPW+xxvxzkGjPkDcV1oY4DG8
         2cUUI9in4HtwOfYJwEjdwPFeIORaH2qzv3uuyemT0+t4PjQq6NItewUqJ41QkKu9Bci7
         bpM2vvSa9bjG5+mMJ8nwU1R21EuckAWKpgu63+2i1pvZSrUcDm+iwAMfNI+a26LuM+hg
         tmzNm5y5pkU9f9uaEIQa6c2huhgSdAH61UQfA4dX5wtGXMtmmu+7vk5TLXWdgBgIPqdg
         Jd7A==
X-Gm-Message-State: AOAM532ULdhCK8ZeTt/w0jbkW4yNBaBpTUyCemFfiEd48bjtw0sDPXad
        Lmhw3Jl0uh0rUP5LdQSCgJI=
X-Google-Smtp-Source: ABdhPJxC+zJx/5U6pfryZSqx3wxezgPHC4eT68U4AvDzjCAnen7V41d2UBAvXQDOy6dpXUUxt/FC9w==
X-Received: by 2002:a05:6512:22d3:: with SMTP id g19mr23416505lfu.404.1638628665976;
        Sat, 04 Dec 2021 06:37:45 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id g36sm782934lfv.16.2021.12.04.06.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 06:37:45 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Agneli <poczt@protonmail.ch>
Cc:     linux-tegra@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v4 18/22] ARM: config: multi v7: Enable NVIDIA Tegra20 APB DMA driver
Date:   Sat,  4 Dec 2021 17:37:21 +0300
Message-Id: <20211204143725.31646-19-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211204143725.31646-1-digetx@gmail.com>
References: <20211204143725.31646-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All Tegra20/30/114 serial and audio drivers depend on the Tegra20 APB DMA
driver, enable this DMA driver.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 172838566ecd..8863fa969ede 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -958,6 +958,7 @@ CONFIG_ST_FDMA=m
 CONFIG_STM32_DMA=y
 CONFIG_STM32_DMAMUX=y
 CONFIG_STM32_MDMA=y
+CONFIG_TEGRA20_APB_DMA=y
 CONFIG_UNIPHIER_MDMAC=y
 CONFIG_XILINX_DMA=y
 CONFIG_QCOM_BAM_DMA=y
-- 
2.33.1

