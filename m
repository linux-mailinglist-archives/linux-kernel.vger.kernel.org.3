Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC9D5B0662
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 16:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbiIGOWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 10:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbiIGOWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 10:22:25 -0400
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7902379EDB;
        Wed,  7 Sep 2022 07:22:15 -0700 (PDT)
Received: from booty.fritz.box (unknown [77.244.183.192])
        (Authenticated sender: luca.ceresoli@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 0E4D3200019;
        Wed,  7 Sep 2022 14:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1662560533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0x0N8xdASNNGJim+/6TTRqaoE75eCBfHEEUyRn2uUTs=;
        b=CCM0A87KExaQlKFFsYRXly065FI86fsGob/0RhItQzNDnScAjh7sOUNNcoL5Adu/N/ZzgI
        N/5BYEhHZkPJy/sMG6DhmtT/qWCVKqd4CUMg/HihWZbDmguNpAQssSgPfMQdld0kC3ObrO
        B16fCiUAayyyd9DMA3D1obcNhpb59k0sKKzsoBQDnPZgfDXwzfDaFu2a/djAo6l0i948er
        Mv5ZTZNVYQXYg4DMpGb/itY7Zcf81HWGALFdVvZANTuw20isR5VsyPoEgfVwtwOr8j43J2
        iIKLpa/jg/hGDAB0G1iw/ijnXPVfHdQTnYQd27Lu+p5QwMApGb9PvZKrqgP5Iw==
From:   luca.ceresoli@bootlin.com
To:     alsa-devel@alsa-project.org, linux-rockchip@lists.infradead.org
Cc:     Luca Ceresoli <luca.ceresoli@bootlin.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Jonker <jbx6244@gmail.com>,
        Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 6/8] ASoC: audio-graph: let dai_link->init be overridable
Date:   Wed,  7 Sep 2022 16:21:22 +0200
Message-Id: <20220907142124.2532620-7-luca.ceresoli@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220907142124.2532620-1-luca.ceresoli@bootlin.com>
References: <20220907142124.2532620-1-luca.ceresoli@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luca Ceresoli <luca.ceresoli@bootlin.com>

We can already override dai_link->ops via a custom pointer in
asoc_simple_priv. Do the same for dai_link->init.

This is needed for a card that need to call .set_sysclk multiple times to
initialize more than one clock. The current code does not allow to do it
cleanly.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 include/sound/simple_card_utils.h    | 1 +
 sound/soc/generic/audio-graph-card.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/include/sound/simple_card_utils.h b/include/sound/simple_card_utils.h
index a0b827f0c2f6..60dab5f68f5e 100644
--- a/include/sound/simple_card_utils.h
+++ b/include/sound/simple_card_utils.h
@@ -75,6 +75,7 @@ struct asoc_simple_priv {
 	struct snd_soc_dai_link_component dummy;
 	struct snd_soc_codec_conf *codec_conf;
 	struct gpio_desc *pa_gpio;
+	int (*init)(struct snd_soc_pcm_runtime *rtd);
 	const struct snd_soc_ops *ops;
 	unsigned int dpcm_selectable:1;
 	unsigned int force_dpcm:1;
diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
index b327372f2e4a..38c05eb1c650 100644
--- a/sound/soc/generic/audio-graph-card.c
+++ b/sound/soc/generic/audio-graph-card.c
@@ -263,6 +263,8 @@ static int graph_link_init(struct asoc_simple_priv *priv,
 
 	dai_link->init		= asoc_simple_dai_init;
 	dai_link->ops		= &graph_ops;
+	if (priv->init)
+		dai_link->init	= priv->init;
 	if (priv->ops)
 		dai_link->ops	= priv->ops;
 
-- 
2.34.1

