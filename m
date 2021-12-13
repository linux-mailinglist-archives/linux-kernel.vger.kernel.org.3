Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89B23472B1C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 12:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235140AbhLMLRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 06:17:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234981AbhLMLRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 06:17:09 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36273C06173F;
        Mon, 13 Dec 2021 03:17:09 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id q3so26392986wru.5;
        Mon, 13 Dec 2021 03:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MzHXXewWvbCPeLWsiXq0T6cQlH5SjAcTgmhcmqPDqco=;
        b=Jkjlf6xLPEmPRoLvcEOsCr2UlOCv+lN+fGgJQmKzdbP8ej3f+FVE/NTy37c2AdZewZ
         d3z047dt6Vh+s9zJV/d2QTyl+hgxwPKTntHLcj0UF6WQdhUpsvSfaqBLoh/nEATU9ws7
         ztURJqD6tkSZhIDeriDF+tDAqYgPYtF3bXlCYkpmwcLmHL6wv0G3NEamR9osZ9fGwAjv
         6NbxyxhfLPdO5qYZok5PT+88jqFEnmwBG27A/UhQFSadSNQdWKq8USEBjYe3v4tJxLlA
         tmvX98O8m+Y+Y55KE0t9ljzRysnjaLBGkvJxnfhX97AXCwyOyL8sU0OaaS6h4Z1s5Bu1
         mvEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MzHXXewWvbCPeLWsiXq0T6cQlH5SjAcTgmhcmqPDqco=;
        b=5DYnzM23TH82LUDFCO5Eu0gN1E0U699JeA5FxeH/EvCxD0jNcl+pYsy4h8k1U5iKDa
         UO6QYwE2DOoNG/kB55bPNxlFSVSNny7o0rb9m6IG3Bp2PY3s/8N4tz/RMd+0KHtTSAum
         3aquAbv6k+pPTwPeYwE2TBQtkodR8G6XRnd7xTrtYYbXKzMgvEITJmMMh5WsC+SvMqPs
         UkpxMkLuyL3QIlKnRYZWMFpPSttKQjI3jgbvr0S7jfBvZsMtC3wE27CE+uOSgzx0bA5V
         N042hWMzTNOgBOY9hOAj24UysZWqOKYt9i0zp88+rOQA+ujAGg+UQCy/p2FjxAsYk0k2
         1tBA==
X-Gm-Message-State: AOAM532LjhQWx7vsKN4H/gnrSB0pLVlkataeS5bQ9sfoqG0PaJthP7HJ
        V+QMEgAlzJ7lDrgx+CXJVmg=
X-Google-Smtp-Source: ABdhPJyIQz7Q5rXBFJuHpiGSNTI9gL8i7nxybUm3T3OGJqkuMZCsEQVhzUOSGdn7DHHBRXLezti0cg==
X-Received: by 2002:a5d:648b:: with SMTP id o11mr15776677wri.633.1639394227743;
        Mon, 13 Dec 2021 03:17:07 -0800 (PST)
Received: from DEL01603w.ebgroup.elektrobit.com (eth1-fw1-nbg6.eb.noris.de. [213.95.148.172])
        by smtp.gmail.com with ESMTPSA id t17sm7255255wmq.15.2021.12.13.03.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 03:17:07 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Maciej W . Rozycki" <macro@orcam.me.uk>,
        Sander Vanheule <sander@svanheule.net>,
        Bert Vermeulen <bert@biot.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Paul Burton <paulburton@kernel.org>,
        Daniel Silsby <dansilsby@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 8/9] mips: txx9: remove left-over for removed TXX9_ACLC configs
Date:   Mon, 13 Dec 2021 12:16:41 +0100
Message-Id: <20211213111642.11317-9-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211213111642.11317-1-lukas.bulwahn@gmail.com>
References: <20211213111642.11317-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch series "Remove support for TX49xx" (see Link) was only partially
applied: The ASoC driver was removed with commit a8644292ea46 ("ASoC:
txx9: Remove driver"), which was patch 10/10 from that series. The mips
architecture code to be removed with patch 1/10 from that series was not
applied.

This partial patch series application leaves the build config setup and
code in the mips architecture in a slightly unclean, intermediate state.
The configs HAS_TXX9_ACLC and SND_SOC_TXX9ACLC were removed, but are still
referenced in the txx9-architecture Kconfig and generic setup.

The script ./scripts/checkkconfigsymbols.py warns about this:

  HAS_TXX9_ACLC
  Referencing files: arch/mips/txx9/Kconfig

  SND_SOC_TXX9ACLC
  Referencing files: arch/mips/txx9/generic/setup.c

Clean up the code for those removed references.

Link: https://lore.kernel.org/all/20210105140305.141401-1-tsbogend@alpha.franken.de/
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 arch/mips/txx9/Kconfig         |  3 ---
 arch/mips/txx9/generic/setup.c | 28 ----------------------------
 2 files changed, 31 deletions(-)

diff --git a/arch/mips/txx9/Kconfig b/arch/mips/txx9/Kconfig
index a5484c284353..d9710fddac4f 100644
--- a/arch/mips/txx9/Kconfig
+++ b/arch/mips/txx9/Kconfig
@@ -64,7 +64,6 @@ config SOC_TX4927
 	select IRQ_TXX9
 	select PCI_TX4927
 	select GPIO_TXX9
-	imply HAS_TXX9_ACLC
 
 config SOC_TX4938
 	bool
@@ -74,7 +73,6 @@ config SOC_TX4938
 	select IRQ_TXX9
 	select PCI_TX4927
 	select GPIO_TXX9
-	imply HAS_TXX9_ACLC
 
 config SOC_TX4939
 	bool
@@ -82,7 +80,6 @@ config SOC_TX4939
 	imply HAS_TXX9_SERIAL
 	select HAVE_PCI
 	select PCI_TX4927
-	imply HAS_TXX9_ACLC
 
 config TXX9_7SEGLED
 	bool
diff --git a/arch/mips/txx9/generic/setup.c b/arch/mips/txx9/generic/setup.c
index 5c42da622b8b..c7c1e30e8f3b 100644
--- a/arch/mips/txx9/generic/setup.c
+++ b/arch/mips/txx9/generic/setup.c
@@ -835,34 +835,6 @@ void __init txx9_aclc_init(unsigned long baseaddr, int irq,
 			   unsigned int dma_chan_out,
 			   unsigned int dma_chan_in)
 {
-#if IS_ENABLED(CONFIG_SND_SOC_TXX9ACLC)
-	unsigned int dma_base = dmac_id * TXX9_DMA_MAX_NR_CHANNELS;
-	struct resource res[] = {
-		{
-			.start = baseaddr,
-			.end = baseaddr + 0x100 - 1,
-			.flags = IORESOURCE_MEM,
-		}, {
-			.start = irq,
-			.flags = IORESOURCE_IRQ,
-		}, {
-			.name = "txx9dmac-chan",
-			.start = dma_base + dma_chan_out,
-			.flags = IORESOURCE_DMA,
-		}, {
-			.name = "txx9dmac-chan",
-			.start = dma_base + dma_chan_in,
-			.flags = IORESOURCE_DMA,
-		}
-	};
-	struct platform_device *pdev =
-		platform_device_alloc("txx9aclc-ac97", -1);
-
-	if (!pdev ||
-	    platform_device_add_resources(pdev, res, ARRAY_SIZE(res)) ||
-	    platform_device_add(pdev))
-		platform_device_put(pdev);
-#endif
 }
 
 static struct bus_type txx9_sramc_subsys = {
-- 
2.26.2

