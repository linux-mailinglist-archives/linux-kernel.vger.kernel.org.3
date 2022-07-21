Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2610757D75E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 01:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233214AbiGUXdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 19:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232488AbiGUXdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 19:33:08 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9E592848
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 16:33:06 -0700 (PDT)
Received: from localhost (unknown [188.24.146.105])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BE2FF6601AB4;
        Fri, 22 Jul 2022 00:33:04 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658446384;
        bh=oo2+O9BB8Qmzpv1tcToj+qItiPJ98pNfn+AXvTBYbfU=;
        h=From:To:Cc:Subject:Date:From;
        b=aEJOje+UkZlurTkF8NLKuv8m34YKwNmSxY38UiwaCKt0+vzcMQYvL0q6ujuKKrO0h
         pQq7u7y6bd6TQwkyIQClE2ys8fwWdd2q7jzeR/sPU1/0wf03bTCbKybmtu/DWQSv+i
         tuZFFxEWbo0iTa9Ed7hjF33iC1roqZy6BLN9Zm569eEQ/daf1MdX0bu77tYrkIx/tF
         EDMA5H2qQ04DmdMEPRzG32BD82XjvZdLtCQRjJylZLISC+diGcM35U3AyWv8EiLGLD
         9bucarg5pEOdqrkThvtH6Kb1ooTJ8qqy64rr4BKs+h3S7QC1VH7kKju9p/CUgiRlZf
         WUF+LlEq/mBZw==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: [PATCH] ASoC: amd: vangogh: Use non-legacy DAI naming for cs35l41
Date:   Fri, 22 Jul 2022 02:32:27 +0300
Message-Id: <20220721233227.1459374-1-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unlike most CODEC drivers, the CS35L41 driver did not have the
non_legacy_dai_naming set, meaning the corresponding DAI has been
traditionally registered using the legacy naming: spi-VLV1776:0x

The recent migration to the new legacy DAI naming style has implicitly
corrected that behavior and DAI gets now registered via the non-legacy
naming, i.e. cs35l41-pcm.

The problem is the acp5x platform driver is now broken as it continues
to refer to the above mentioned codec using the legacy DAI naming in
function acp5x_cs35l41_hw_params() and, therefore, the related setup
is not being executed anymore.

Let's fix that by replacing the obsolete DAI name with the correct one.

Fixes: bc949a3b4af3 ("ASoC: core: Switch core to new DAI naming flag")
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 sound/soc/amd/vangogh/acp5x-mach.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/amd/vangogh/acp5x-mach.c b/sound/soc/amd/vangogh/acp5x-mach.c
index 727de46860b1..af3737ef9707 100644
--- a/sound/soc/amd/vangogh/acp5x-mach.c
+++ b/sound/soc/amd/vangogh/acp5x-mach.c
@@ -178,8 +178,7 @@ static int acp5x_cs35l41_hw_params(struct snd_pcm_substream *substream,
 	ret = 0;
 	for (i = 0; i < num_codecs; i++) {
 		codec_dai = asoc_rtd_to_codec(rtd, i);
-		if ((strcmp(codec_dai->name, "spi-VLV1776:00") == 0) ||
-		    (strcmp(codec_dai->name, "spi-VLV1776:01") == 0)) {
+		if (strcmp(codec_dai->name, "cs35l41-pcm") == 0) {
 			switch (params_rate(params)) {
 			case 48000:
 				bclk_val = 1536000;
-- 
2.37.1

