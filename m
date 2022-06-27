Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47E3255D4EE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233552AbiF0JJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 05:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232634AbiF0JJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 05:09:43 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A6C25CD
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 02:09:42 -0700 (PDT)
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 85C783F210
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 09:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1656320981;
        bh=s566ipww91mKnS3Ml2xQ5GbO9Dmtu286N5Zfo5g5Lhs=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=rsVQTYLeqdOQ4Sb5IDNIuGm0lvjDw5fXqYQUqBXEXeSvrK0OMPhbs8SwDW6sbJnUo
         YpK6Mh80gu08FthsjLaRuf3wplPfA4rohV1Xg+/+e95F5ymk/KmMj/d/mQU4bd89HW
         RWZfMMUvBC+q37KteaI7ZGNeyWVJZVt/HOYZ9uzc/9lNHgOZ8AJlbY9n3xvlAcaskg
         Mi/3Fwo8s4uqwwapMJrXwaTGpqpQZBDnNKA3OfQFaLs6YLMNwasZuJTxAx9G/bhbd5
         gLAitSUiqKopXd+3fAHraPh7oYxowi9jk+30z85LcgDVxvYswi/DqmwGsvmE+rwSJM
         IE0DZisXuqttQ==
Received: by mail-ej1-f71.google.com with SMTP id p7-20020a170906614700b006f87f866117so2140307ejl.21
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 02:09:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s566ipww91mKnS3Ml2xQ5GbO9Dmtu286N5Zfo5g5Lhs=;
        b=o+CPMd+ZtEzDF+I6QL36n0bBLBlWvXzadFKCXq1BJgKrk9T8NzfKwmH/wYqJ3ZYAEI
         ak3urUzyNAba5CmZZQ+G+tA9u5DbxTEzhZEOSw+UIipKY/hywTDeEd0nbuu+WBD7h84J
         sHoU0h8+yx8hAkgB73fhMWKc1XKb7vNvVsjxwHNJolwDRPMXJcmHmlHbiJGPwJUm2lGi
         ab/aTd+RLj8p1dF8tbLE2mR+PHWzIuQbsIlbbPu5NmsvRTmGDJiqY1Dt9ADuWLYo2c3o
         SyFhp4bgRQ5cpWiaSjFxWIcFKQ5hylaeCPluV3eiiaalZLZLQIZMQn7saAUWyCNOc2Pe
         wfJw==
X-Gm-Message-State: AJIora8dm/E3URPUjGeyIO9yPg7W0hb9QSNr1iJ3DgaGsd6gPwED7h0N
        JwGC7oyiyntg4+/3i9qT2a1hEUSVsZbVKNX4HoQI1h6FHi9R6TGqqlhBlqHy9eWP7TcMAiW16LL
        BVcz/ssJz4SiOxxBERuAgZNCaSJxixpa7xS4FC67BDg==
X-Received: by 2002:a17:906:a245:b0:708:ce69:e38b with SMTP id bi5-20020a170906a24500b00708ce69e38bmr11816136ejb.100.1656320980905;
        Mon, 27 Jun 2022 02:09:40 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t2/dRjKlfbsFr1REuQ8B/eBBS2/XPQR4aiwvOT5IFkq44OQXYNt3It3POSVHQrMzyK1rgtZQ==
X-Received: by 2002:a17:906:a245:b0:708:ce69:e38b with SMTP id bi5-20020a170906a24500b00708ce69e38bmr11816125ejb.100.1656320980724;
        Mon, 27 Jun 2022 02:09:40 -0700 (PDT)
Received: from stitch.. (80.71.140.73.ipv4.parknet.dk. [80.71.140.73])
        by smtp.gmail.com with ESMTPSA id fi9-20020a170906da0900b00722e5b234basm4821607ejb.179.2022.06.27.02.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 02:09:40 -0700 (PDT)
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        dmaengine@vger.kernel.org
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        Vinod Koul <vkoul@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Pandith N <pandith.n@intel.com>,
        Michael Zhu <michael.zhu@starfivetech.com>,
        linux-kernel@vger.kernel.org,
        Samin Guo <samin.guo@starfivetech.com>
Subject: [PATCH] dmaengine: dw-axi-dmac: Fix RMW on channel suspend register
Date:   Mon, 27 Jun 2022 11:09:39 +0200
Message-Id: <20220627090939.1775717-1-emil.renner.berthing@canonical.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Emil Renner Berthing <kernel@esmil.dk>

When the DMA is configured for more than 8 channels the bits controlling
suspend moves to another register. However when adding support for this
the new register would be completely overwritten in one case and
overwritten with values from the old register in another case.

Found by comparing the parallel implementation of more than 8 channel
support for the StarFive JH7100 SoC by Samin.

Fixes: 824351668a41 ("dmaengine: dw-axi-dmac: support DMAX_NUM_CHANNELS > 8")
Co-developed-by: Samin Guo <samin.guo@starfivetech.com>
Signed-off-by: Samin Guo <samin.guo@starfivetech.com>
Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index e9c9bcb1f5c2..c741da02b67e 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -1164,8 +1164,9 @@ static int dma_chan_pause(struct dma_chan *dchan)
 			BIT(chan->id) << DMAC_CHAN_SUSP_WE_SHIFT;
 		axi_dma_iowrite32(chan->chip, DMAC_CHEN, val);
 	} else {
-		val = BIT(chan->id) << DMAC_CHAN_SUSP2_SHIFT |
-		      BIT(chan->id) << DMAC_CHAN_SUSP2_WE_SHIFT;
+		val = axi_dma_ioread32(chan->chip, DMAC_CHSUSPREG);
+		val |= BIT(chan->id) << DMAC_CHAN_SUSP2_SHIFT |
+			BIT(chan->id) << DMAC_CHAN_SUSP2_WE_SHIFT;
 		axi_dma_iowrite32(chan->chip, DMAC_CHSUSPREG, val);
 	}
 
@@ -1190,12 +1191,13 @@ static inline void axi_chan_resume(struct axi_dma_chan *chan)
 {
 	u32 val;
 
-	val = axi_dma_ioread32(chan->chip, DMAC_CHEN);
 	if (chan->chip->dw->hdata->reg_map_8_channels) {
+		val = axi_dma_ioread32(chan->chip, DMAC_CHEN);
 		val &= ~(BIT(chan->id) << DMAC_CHAN_SUSP_SHIFT);
 		val |=  (BIT(chan->id) << DMAC_CHAN_SUSP_WE_SHIFT);
 		axi_dma_iowrite32(chan->chip, DMAC_CHEN, val);
 	} else {
+		val = axi_dma_ioread32(chan->chip, DMAC_CHSUSPREG);
 		val &= ~(BIT(chan->id) << DMAC_CHAN_SUSP2_SHIFT);
 		val |=  (BIT(chan->id) << DMAC_CHAN_SUSP2_WE_SHIFT);
 		axi_dma_iowrite32(chan->chip, DMAC_CHSUSPREG, val);
-- 
2.36.1

