Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66AC14678C8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 14:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381275AbhLCNxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 08:53:32 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57088 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381259AbhLCNxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 08:53:31 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: adalessandro)
        with ESMTPSA id 480331F46E6E
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1638539406; bh=hJG58SYAVGNpPYo2IcIUWsajkYlXBANCyhYcff6ZNmA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ezOB+UXh06vKoBdD+FQrYCJoW+clB2VJVJFPYn8itvWBcBR23nHjSXtLe7HEq6N5Q
         lRPKyMKRqk5oa4iJu3ZbMGJ6npcdZpydysHrCh0TFKUM3+C2V+Jy/K2VMxbn2ugmFL
         b2TdQ1wE10ZBOpehM/4htHj/Wb2NqpwcEZJ6CgSfRbLVEm6mPJ2iut11INo40TL957
         aVN+V/cm74me8bw+F+TOwZBDLOG53k5aCjLKpBN+OAF2M+haJY7mz0HnR5YYHa1obV
         r5/Cs6TmwMWliNKWESVQ3zDI4y0UhC7v1ztfkzIRZefp1GJTr0Dldq9HHVC/QWYL9o
         SbpNOmKK7sKrA==
From:   Ariel D'Alessandro <ariel.dalessandro@collabora.com>
To:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc:     Xiubo.Lee@gmail.com, ariel.dalessandro@collabora.com,
        bcousson@baylibre.com, broonie@kernel.org, festevam@gmail.com,
        kuninori.morimoto.gx@renesas.com, lgirdwood@gmail.com,
        michael@amarulasolutions.com, nicoleotsuka@gmail.com,
        perex@perex.cz, robh+dt@kernel.org, shengjiu.wang@gmail.com,
        tiwai@suse.com, tony@atomide.com
Subject: [PATCH 3/4] ASoC: fsl-asoc-card: Add optional dt property for setting mclk-id
Date:   Fri,  3 Dec 2021 10:49:29 -0300
Message-Id: <20211203134930.128703-4-ariel.dalessandro@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211203134930.128703-1-ariel.dalessandro@collabora.com>
References: <20211203134930.128703-1-ariel.dalessandro@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sound cards may allow using different main clock inputs. In the generic
fsl-asoc-card driver, these values are hardcoded for each specific card
configuration.

Let's make it more flexible, allowing setting mclk-id from the
device-tree node. Otherwise, the default value for each card
configuration is used.

Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
---
 Documentation/devicetree/bindings/sound/fsl-asoc-card.txt | 1 +
 sound/soc/fsl/fsl-asoc-card.c                             | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt b/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt
index 23d83fa7609f..b219626a5403 100644
--- a/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt
+++ b/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt
@@ -82,6 +82,7 @@ Optional properties:
   - dai-format		: audio format, for details see simple-card.yaml.
   - frame-inversion	: dai-link uses frame clock inversion, for details see simple-card.yaml.
   - bitclock-inversion	: dai-link uses bit clock inversion, for details see simple-card.yaml.
+  - mclk-id		: main clock id, specific for each card configuration.
 
 Optional unless SSI is selected as a CPU DAI:
 
diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index 90cbed496f98..bb962e04d40b 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -693,6 +693,12 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 		goto asrc_fail;
 	}
 
+	/*
+	 * Allow setting mclk-id from the device-tree node. Otherwise, the
+	 * default value for each card configuration is used.
+	 */
+	of_property_read_u32(np, "mclk-id", &priv->codec_priv.mclk_id);
+
 	/* Format info from DT is optional. */
 	snd_soc_daifmt_parse_clock_provider_as_phandle(np, NULL, &bitclkprovider, &frameprovider);
 	if (bitclkprovider || frameprovider) {
-- 
2.30.2

