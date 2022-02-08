Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D29284AD3C1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 09:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351052AbiBHImr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 03:42:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350719AbiBHImo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 03:42:44 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B49C03FED4
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 00:42:43 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id f10so31845555lfu.8
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 00:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zAs8Yatfb5icRPps4ZaWoN14zXIRZ/fIsgdyAPNGOb4=;
        b=SfuD4cs0uNn4xZ7k3QGNDYawj1deQWy1OQ/+n1lA0GxfdK0Q1uRJB2bg5CtViFAkJ8
         icuGxWaJ7CaR8hyZy2JGgU5BKVeUCabeHxN5mCuHSf/f1xHANr+o3XzwBDHbIM6I7EsT
         UXq6UNMwG5wreMRA8Tj9Bw5jvP4y6S0y09CDEpfXbPEuzmFvyC/Fm0h/aGMj+67HhD2g
         vhEjZv2aihkNPwK5knvQFdxoxIGS1LUVQKkxiWULZ8qkIj9//0gyXkpSp6BBpyKTkbOS
         rUuO1rSwTm5r/vnk4Bh4fROhGrycSBPystmyVqUeFfLrszN7qcp2BoDdv6kks9ApsWAd
         mhRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zAs8Yatfb5icRPps4ZaWoN14zXIRZ/fIsgdyAPNGOb4=;
        b=ZfvX+SW71fT+QfJTtD55TduGlKFXWKnr6cIaqwbj1wEKyzI+yu5Q71RRLFaY95EwnQ
         ratpVBc4QR6v0g9QcHSorTtMOKqUdNlZ8Qddnt9BkL7v/NOcpF+h/gEGl14aBG8UnO4H
         xNJ5U+wcMKcbJ4Ste1yLQZx7KEtjIYf4Fbv6m9qpJ6N7UM1aOash2ga18wZ+5whameDC
         VaUUlfUM5JLnVIi6pWb95oixT7xJoZee9BQkVsY71PnTdkEe7ZP0RrOVbOKis12mXCaP
         DEtvm9OvT54rCmYQrpSVqaKAQH91zGLjAnqSC2yxibW1FeNQAnkcoLW1rHCZ6txmxr/o
         Mtbg==
X-Gm-Message-State: AOAM532vXkRqLmy0ymKQMQHaeqgaW5hgWjZUJXhDzpmEIiTOifD+Jywk
        xDhAv3+G5Clz90THkqVjx7tfmA==
X-Google-Smtp-Source: ABdhPJyScCD/zHSIZnBLnovm2lIeHylddool/rNUHBAjMxezHHhiSO5YvqwnGzUQRB10qdhFJgQPnA==
X-Received: by 2002:ac2:560a:: with SMTP id v10mr2359890lfd.260.1644309761652;
        Tue, 08 Feb 2022 00:42:41 -0800 (PST)
Received: from cobook.home (nikaet.starlink.ru. [94.141.168.29])
        by smtp.gmail.com with ESMTPSA id o12sm1830361lfu.96.2022.02.08.00.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 00:42:41 -0800 (PST)
From:   Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH 1/4] ASoC: pcm3168a: cleanup unintuitive mask usage
Date:   Tue,  8 Feb 2022 11:42:17 +0300
Message-Id: <20220208084220.1289836-2-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220208084220.1289836-1-nikita.yoush@cogentembedded.com>
References: <20220208084220.1289836-1-nikita.yoush@cogentembedded.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When checking if the requested parameters are supported, the driver uses
PCM3168A_FMT_DSP_MASK to check for PCM3168A_FMT_DSP_* values.

However, formally not only PCM3168A_FMT_DSP_* values match that
condition, PCM3168A_FMT_I2S_TDM and PCM3168A_FMT_LEFT_J_TDM also do.

The check still gives correct result because those extra values can't
be in 'fmt' at the check location. Still, to make the code less cryptic,
better to compare 'fmt' with PCM3168A_FMT_DSP_* values explicitly.

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
 sound/soc/codecs/pcm3168a.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/pcm3168a.c b/sound/soc/codecs/pcm3168a.c
index fdf92c8b28e1..987c5845f769 100644
--- a/sound/soc/codecs/pcm3168a.c
+++ b/sound/soc/codecs/pcm3168a.c
@@ -33,7 +33,6 @@
 #define PCM3168A_FMT_DSP_B		0x5
 #define PCM3168A_FMT_I2S_TDM		0x6
 #define PCM3168A_FMT_LEFT_J_TDM		0x7
-#define PCM3168A_FMT_DSP_MASK		0x4
 
 #define PCM3168A_NUM_SUPPLIES 6
 static const char *const pcm3168a_supply_names[PCM3168A_NUM_SUPPLIES] = {
@@ -511,7 +510,8 @@ static int pcm3168a_hw_params(struct snd_pcm_substream *substream,
 		fmt = PCM3168A_FMT_RIGHT_J_16;
 		break;
 	case 24:
-		if (master_mode || (fmt & PCM3168A_FMT_DSP_MASK)) {
+		if (master_mode || (fmt == PCM3168A_FMT_DSP_A) ||
+				   (fmt == PCM3168A_FMT_DSP_B)) {
 			dev_err(component->dev, "24-bit slots not supported in master mode, or slave mode using DSP\n");
 			return -EINVAL;
 		}
-- 
2.30.2

