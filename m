Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1521950A020
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 14:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386431AbiDUM50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 08:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386306AbiDUM5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 08:57:23 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25ECD338AD
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 05:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1650545673; x=1682081673;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5fez7wr8uqc+IWPhOReqP+qP7BSjjeMLlqht5y+cQyI=;
  b=eFPvhOYJTrxi9WnivQXmo79xTsgOdYAsUPmTrtoQqK42l54r7Tw2X1h7
   8gWupFTHI+G8xncd+aAi9HGPp4hzea/v1lmGM064CKd4HNh3grJHRXuKk
   ohCoFbuvy5fshf3ca/l1N6iTcoBwS2LtrfQcblnER4jRfBW79UuMCoEmu
   TVqhXNfBplCMpN4YR8JFWSbrt2nUFkp3fN7vD+Bp32J0HGOMuM0novEl/
   QMXH/+kFJMD4x9EUoWulRU4lIssCusP3e/af7ItqDogXaVG0GZh6Kw0Ou
   DNu86gNphLDnTLPRBw5VX08nxLKWrFB9MV1C3v4DXZJ+/xnuu1rR0JjUp
   w==;
X-IronPort-AV: E=Sophos;i="5.90,278,1643698800"; 
   d="scan'208";a="156304300"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Apr 2022 05:54:24 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 21 Apr 2022 05:54:24 -0700
Received: from rob-ult-m19940.amer.actel.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 21 Apr 2022 05:54:21 -0700
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
        <alexandre.belloni@bootlin.com>, <sha@pengutronix.de>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Subject: [PATCH 2/2] ASoC: atmel: mchp-pdmc: set prepare_slave_config
Date:   Thu, 21 Apr 2022 15:54:03 +0300
Message-ID: <20220421125403.2180824-2-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220421125403.2180824-1-codrin.ciubotariu@microchip.com>
References: <20220421125403.2180824-1-codrin.ciubotariu@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since a pointer to struct snd_dmaengine_pcm_config is passed,
snd_dmaengine_pcm_prepare_slave_config() is no longer called unless it's
explicitly set in prepare_slave_config.

Fixes: 50291652af52 ("ASoC: atmel: mchp-pdmc: add PDMC driver")
Suggested-by: Sascha Hauer <sha@pengutronix.de>
Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---
 sound/soc/atmel/mchp-pdmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/atmel/mchp-pdmc.c b/sound/soc/atmel/mchp-pdmc.c
index 1a7802fbf23c1..a3856c73e2214 100644
--- a/sound/soc/atmel/mchp-pdmc.c
+++ b/sound/soc/atmel/mchp-pdmc.c
@@ -966,6 +966,7 @@ static int mchp_pdmc_process(struct snd_pcm_substream *substream,
 
 static struct snd_dmaengine_pcm_config mchp_pdmc_config = {
 	.process = mchp_pdmc_process,
+	.prepare_slave_config = snd_dmaengine_pcm_prepare_slave_config,
 };
 
 static int mchp_pdmc_probe(struct platform_device *pdev)
-- 
2.32.0

