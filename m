Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAAF547EE7A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 12:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352542AbhLXLLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 06:11:32 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:33266
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231580AbhLXLLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 06:11:30 -0500
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com [209.85.208.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C6AB03F1EE
        for <linux-kernel@vger.kernel.org>; Fri, 24 Dec 2021 11:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1640344289;
        bh=kD4Oxt4jcQYvgn3l02cM0PdutVIC1JUiDrLy60gpB1w=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=vAGhcAr9E3OuoJoGYw0bJN7AnWNb/8Rn0mImK697imUlb4rFfaNwpp1QZWdrvViOr
         8+QpUSU0sIhpgs3G4xDqR9dxQZJezbeHdB94l1DIjFbIi1M1JZXyVFcY3zqD2XmIp0
         N7K0qnY2V0lRcemogRBFqIoRDIz/60/u0ch5RTHtdtTnneEydMuXiSeth2KMer9fmY
         94t5Xy7s9GCEyyBbWEtjtHt4ISzQklyiCml0HA/EL6MVW0/tTVx8pbkxqF3+X5x1Rg
         HFURGfwB8cW1u7wRrq/Lm8YMl5YR2jfHVunpkn5Q/YN8uD/0mkFbr/MQ3Dw4YmSai0
         1oEKxqW35+tTA==
Received: by mail-lj1-f197.google.com with SMTP id a29-20020a2e7f1d000000b0022d7438b7e4so2320246ljd.15
        for <linux-kernel@vger.kernel.org>; Fri, 24 Dec 2021 03:11:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kD4Oxt4jcQYvgn3l02cM0PdutVIC1JUiDrLy60gpB1w=;
        b=6E6ycyopgcXOXypmLi/QDy6gkWlg9CCiCPSARDtvPAmZ80AcXOKsFwsbfnCgGPisT2
         BNTPd5xZwtJjscIDknV8yoUyWs5V6Whehi7JYYQmrNZjLiLfJxsXsj29phA7cRIw2beh
         zp03ple/9sLWi4Mpr0Ie16/m23gRt1OHsjxRU9Vs3TcWCQu4NtvvDwc0+4zybSd6M+zq
         oux8dwmZnrMJMWdh0e9ikKEGtnC0J453E6ycHU70Tj7lnLAWOtrdC2OLHF5mv688fktw
         R2/6BrATAsjiK+daJUg014Ob5oUFGMYs5Bt5BvXvMzrpWBrR+9PfTLVPhI8v76BDtQU/
         efOA==
X-Gm-Message-State: AOAM530gCkmiDn9Sbx5SonMAo/9fkGezpp00qSnssiDOOWH+IeVaUfx5
        L0lLuQT3uxvl2RWKEcnex/2Vi1YyyZ4SRmE3h1DH/tS3tu2iRiegErvoY6sfmFkhkWMLq/aZW/v
        rYdPhxuNfTKxT4CLLWQZEbYxpOhY8+5t/yl3xfjfVTQ==
X-Received: by 2002:a2e:9253:: with SMTP id v19mr4468024ljg.74.1640344288783;
        Fri, 24 Dec 2021 03:11:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxTfs7N22KGq3U7wkuIP6XzvggWdsbNzZIU0QA+V5Zqphz+iG9QPpXvadTM+EjZ9GS+e1xNVg==
X-Received: by 2002:a2e:9253:: with SMTP id v19mr4468014ljg.74.1640344288550;
        Fri, 24 Dec 2021 03:11:28 -0800 (PST)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id y36sm773870lfa.75.2021.12.24.03.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Dec 2021 03:11:27 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [GIT PULL 2/2] memory: omap: drivers for v5.17
Date:   Fri, 24 Dec 2021 12:11:24 +0100
Message-Id: <20211224111124.6097-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211224111124.6097-1-krzysztof.kozlowski@canonical.com>
References: <20211224111124.6097-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd and Olof,

Separate topic branch for omap-gpmc driver. This includes changes to
mtd-nand-omap2 driver (acked by Miquel) *which will conflict NAND tree*:

1. The "of_device_id omap_nand_ids" is moved to header
   ../platform_data/mtd-nand-omap2.h.
2. New compatible is added to above "of_device_id omap_nand_ids".

One way to avoid pushing this conflict to Linus, would be if Miquel would
actually pull this request instead of soc tree.

Proper resolution looks like:
----------------------------------------------------------------
diff --git a/include/linux/platform_data/mtd-nand-omap2.h b/include/linux/platform_data/mtd-nand-omap2.h
index 92f011805ad4..8c2f1f185353 100644
--- a/include/linux/platform_data/mtd-nand-omap2.h
+++ b/include/linux/platform_data/mtd-nand-omap2.h
@@ -65,6 +65,7 @@ struct gpmc_nand_regs {
 
 static const struct of_device_id omap_nand_ids[] = {
 	{ .compatible = "ti,omap2-nand", },
+	{ .compatible = "ti,am64-nand", },
 	{},
 };
----------------------------------------------------------------

Best regards,
Krzysztof


The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl.git tags/memory-controller-drv-omap-5.17

for you to fetch changes up to dbcb124acebd8148e9e858a231f1798956dd3ca6:

  mtd: rawnand: omap2: Select GPMC device driver for ARCH_K3 (2021-12-22 16:51:43 +0100)

----------------------------------------------------------------
Memory controller drivers for v5.14 - OMAP GPMC

1. Add support for AM64 SoC.
2. Minor improvement: use platform_get_irq().

----------------------------------------------------------------
Lad Prabhakar (1):
      memory: omap-gpmc: Use platform_get_irq() to get the interrupt

Roger Quadros (4):
      dt-bindings: memory-controllers: ti,gpmc: Add compatible for AM64
      memory: omap-gpmc: Add support for GPMC on AM64 SoC
      memory: omap-gpmc: Use a compatible match table when checking for NAND controller
      mtd: rawnand: omap2: Select GPMC device driver for ARCH_K3

 .../bindings/memory-controllers/ti,gpmc.yaml       | 23 +++++++++-
 drivers/memory/omap-gpmc.c                         | 50 ++++++++++++++--------
 drivers/mtd/nand/raw/Kconfig                       |  1 +
 drivers/mtd/nand/raw/omap2.c                       |  5 +--
 include/linux/platform_data/mtd-nand-omap2.h       |  9 +++-
 5 files changed, 65 insertions(+), 23 deletions(-)
