Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C62004ED0A5
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 02:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352026AbiCaAHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 20:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiCaAHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 20:07:21 -0400
Received: from hutie.ust.cz (hutie.ust.cz [185.8.165.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A0C2BB18;
        Wed, 30 Mar 2022 17:05:33 -0700 (PDT)
From:   =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1648685132; bh=SeiIUiZeJW/WU1eEvgOIqMuWCeT5CiLubwaCNwTIB44=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=aN/8a0qfTlacb8dkUsL9qNzNhslN5RAhSevBw6Ynn92QaDWLBR/+XW0cT6sDqo6Mk
         E2/xOWMdeUhPjHnUAIK+KYx93csU11L+jqfr5v7cswdYDU5sktP9sBxD8hG1hNDJkl
         I7PW6+g6HIA4W7v9ejkAvnTSXoyvnLB22q6pz2To=
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Kettenis <kettenis@openbsd.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>
Subject: [RFC PATCH 3/5] HACK: ASoC: Tolerate N-cpus-to-M-codecs links
Date:   Thu, 31 Mar 2022 02:04:47 +0200
Message-Id: <20220331000449.41062-4-povik+lin@cutebit.org>
In-Reply-To: <20220331000449.41062-1-povik+lin@cutebit.org>
References: <20220331000449.41062-1-povik+lin@cutebit.org>
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

Tolerate N-to-M DAI links while using the first CPU DAI to decide
playback/capture abilities.

Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
---
 sound/soc/soc-pcm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 9a954680d492..770cf367a147 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -2781,9 +2781,12 @@ static int soc_get_playback_capture(struct snd_soc_pcm_runtime *rtd,
 			} else if (rtd->num_cpus == rtd->num_codecs) {
 				cpu_dai = asoc_rtd_to_cpu(rtd, i);
 			} else {
+#if 0
 				dev_err(rtd->card->dev,
 					"N cpus to M codecs link is not supported yet\n");
 				return -EINVAL;
+#endif
+				cpu_dai = asoc_rtd_to_cpu(rtd, 0);
 			}
 
 			if (snd_soc_dai_stream_valid(codec_dai, SNDRV_PCM_STREAM_PLAYBACK) &&
-- 
2.33.0

