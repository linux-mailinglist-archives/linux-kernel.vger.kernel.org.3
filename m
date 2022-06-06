Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC82353EE6B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 21:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbiFFTUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 15:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbiFFTT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 15:19:58 -0400
Received: from hutie.ust.cz (hutie.ust.cz [185.8.165.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87BFA118027;
        Mon,  6 Jun 2022 12:19:56 -0700 (PDT)
From:   =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1654543194; bh=QRlMmTx37FIKTUzJOBJewRJ+ymrpkMI9OoQilWk1xqQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=pCqAUtR5QapOooJvOBPYyu6davbskVeHkuQPoBRndcKKCB1ayMa43zPdunPZ8BdEz
         hqwIFeXKXSAzIiaJloXlHVS4XBW2OiJcYOcvxEpGzXL3TILws63LPcNosFqrqNnF5h
         BDeut6J0fhsCyD1wCOIaeQ88CR2aUEVF2Yedmjs8=
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Kettenis <kettenis@openbsd.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>, asahi@lists.linux.dev
Subject: [RFC PATCH v2 4/5] ASoC: Introduce 'fixup_controls' card method
Date:   Mon,  6 Jun 2022 21:19:09 +0200
Message-Id: <20220606191910.16580-5-povik+lin@cutebit.org>
In-Reply-To: <20220606191910.16580-1-povik+lin@cutebit.org>
References: <20220606191910.16580-1-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new method is called just before the card is registered, providing
an opportune time for machine-level drivers to do some final controls
amending: deactivating individual controls or obtaining control
references for later use.

Some controls can be created by DAPM after 'late_probe' has been called,
hence the need for this new method.

Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
---
 include/sound/soc-card.h | 1 +
 include/sound/soc.h      | 1 +
 sound/soc/soc-card.c     | 6 ++++++
 sound/soc/soc-core.c     | 1 +
 4 files changed, 9 insertions(+)

diff --git a/include/sound/soc-card.h b/include/sound/soc-card.h
index 4f2cc4fb56b7..fd8a6bd2bb4c 100644
--- a/include/sound/soc-card.h
+++ b/include/sound/soc-card.h
@@ -26,6 +26,7 @@ int snd_soc_card_resume_post(struct snd_soc_card *card);
 
 int snd_soc_card_probe(struct snd_soc_card *card);
 int snd_soc_card_late_probe(struct snd_soc_card *card);
+void snd_soc_card_fixup_controls(struct snd_soc_card *card);
 int snd_soc_card_remove(struct snd_soc_card *card);
 
 int snd_soc_card_set_bias_level(struct snd_soc_card *card,
diff --git a/include/sound/soc.h b/include/sound/soc.h
index d3d3a26e8867..8be0258c74e9 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -895,6 +895,7 @@ struct snd_soc_card {
 
 	int (*probe)(struct snd_soc_card *card);
 	int (*late_probe)(struct snd_soc_card *card);
+	void (*fixup_controls)(struct snd_soc_card *card);
 	int (*remove)(struct snd_soc_card *card);
 
 	/* the pre and post PM functions are used to do any PM work before and
diff --git a/sound/soc/soc-card.c b/sound/soc/soc-card.c
index 41c586b86dc3..377e4f9eda91 100644
--- a/sound/soc/soc-card.c
+++ b/sound/soc/soc-card.c
@@ -167,6 +167,12 @@ int snd_soc_card_late_probe(struct snd_soc_card *card)
 	return 0;
 }
 
+void snd_soc_card_fixup_controls(struct snd_soc_card *card)
+{
+	if (card->fixup_controls)
+		card->fixup_controls(card);
+}
+
 int snd_soc_card_remove(struct snd_soc_card *card)
 {
 	int ret = 0;
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index aa687fd126db..ef4d9cb67bb2 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2074,6 +2074,7 @@ static int snd_soc_bind_card(struct snd_soc_card *card)
 		goto probe_end;
 
 	snd_soc_dapm_new_widgets(card);
+	snd_soc_card_fixup_controls(card);
 
 	ret = snd_card_register(card->snd_card);
 	if (ret < 0) {
-- 
2.33.0

