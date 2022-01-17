Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDDF4490969
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 14:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235121AbiAQNVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 08:21:55 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:52952 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbiAQNVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 08:21:51 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: adalessandro)
        with ESMTPSA id B7ED71F439D4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1642425710;
        bh=jVy2ZoyycuiS4S7ICSr7v6N/6BqeqbOkelv81GUI3Eo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YPyLSGZVQCMiiyR4gGxztKCKj8+YvXGtun60zrrNLm87nWT7qB9prTaf/CZOSJ5PP
         mKshbaLW+kQe7J0Uyu2lVBIIGgsFbSOEHK3+i4ZVo3Li7o3gZyfRUfr+Zr/GN3put2
         EKgBW9J5ZjCWUs+DM0Yy5tKyZQGCAwgtJWE1YFKAX2dqrIk77PLflVB1ZK40UokjGZ
         N2uWzTgIVxQ7xg40oC/8N54ZjaYq1FjF6x10YP8QXWHV9ZJh45XgY5uCfwBqQlQ07j
         +sULxKH1xX54SvzS0YMQUyZnJHOToDlf/KExChYbIpdagVwjwoTq0qrunGl1OGwct6
         UDAGtTCob1yCA==
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
Subject: [PATCH v2 4/5] ASoC: fsl-asoc-card: Add optional dt property for setting mclk-id
Date:   Mon, 17 Jan 2022 10:21:08 -0300
Message-Id: <20220117132109.283365-5-ariel.dalessandro@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220117132109.283365-1-ariel.dalessandro@collabora.com>
References: <20220117132109.283365-1-ariel.dalessandro@collabora.com>
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
 sound/soc/fsl/fsl-asoc-card.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index 5ee945505281..156d3c669274 100644
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
2.34.1

