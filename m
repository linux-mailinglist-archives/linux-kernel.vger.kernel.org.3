Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 937FB57CA7D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 14:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233594AbiGUMPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 08:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233589AbiGUMPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 08:15:07 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97DE286881
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 05:15:03 -0700 (PDT)
Received: from localhost (unknown [188.24.146.105])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 861BA6601AA7;
        Thu, 21 Jul 2022 13:15:01 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658405701;
        bh=vBTCRcHWGtDqiA4fxJOYlqI6XHGxo1rup1RqlhRSdD8=;
        h=From:To:Cc:Subject:Date:From;
        b=IKFaPwbl52WVwlaSmN54Nuw+s49PB1Zgk9vh8UoWwdTUNhU4w74QiBNIAS1n1DLIf
         KvV+fpoezwrTOfu07V3P9nIAd6Kx6yr/GxdMvARzLtEhw68kshrH4St6X3Ub45rdtz
         mOUsh0RtHzp52H7FyCr50FrYVVUrTXGxI8bp3piexc4JnLVPl282qP1xQlxWAOdgUK
         Y86bS6C63NAz/w+nV0z2HO8ukiueNjzCjziO+nDjl6CfOIsRA21F5r8m4EBJPE0ibr
         XHF0P6e8eOfrGK6rFqSd/cZVqI3kmesKAWp4aO5pzfsDWPAl7b6uS77Ae9fLaSTl00
         2W3G6PZO/wJYQ==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: [PATCH] ASoC: cs35l41: Set the new legacy DAI naming flag
Date:   Thu, 21 Jul 2022 15:14:54 +0300
Message-Id: <20220721121454.1378945-1-cristian.ciocaltea@collabora.com>
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
non_legacy_dai_naming set, meaning it uses the legacy naming.

The recent migration to the new legacy DAI naming style has broken
driver functionality because it is now expected to set the new legacy
DAI naming flag in order to instruct the core subsystem to use the
legacy name format on DAI registration.

Let's fix this by setting the legacy_dai_naming flag accordingly.

Fixes: bc949a3b4af3 ("ASoC: core: Switch core to new DAI naming flag")
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 sound/soc/codecs/cs35l41.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/cs35l41.c b/sound/soc/codecs/cs35l41.c
index c223d83e02cf..b49f9a32abf2 100644
--- a/sound/soc/codecs/cs35l41.c
+++ b/sound/soc/codecs/cs35l41.c
@@ -1028,6 +1028,7 @@ static const struct snd_soc_component_driver soc_component_dev_cs35l41 = {
 	.set_sysclk = cs35l41_component_set_sysclk,

 	.endianness = 1,
+	.legacy_dai_naming = 1,
 };

 static int cs35l41_handle_pdata(struct device *dev, struct cs35l41_hw_cfg *hw_cfg)
--
2.37.1
