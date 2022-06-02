Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08F9A53B945
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 15:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235128AbiFBNCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 09:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235119AbiFBNC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 09:02:29 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8A8183
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 06:02:29 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id s12so4522254plp.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 06:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XdxxRvNPqFgVB4QJaeaHAzMjj0lVYGxn3dldB8u/Zr4=;
        b=pEVgysGf3LJ/rw3xxHkq4t2G/Mh5jq0fS7dPhhVc0eFcSxs7j7DVRCc5NPnOOQE6En
         ro82zoh9lPKDxsRnKXS8z/pcJPAuoxXpP2yUmqZDj85NFbWo4DjK7K3eZqZF7ckz6XyP
         wCTrr36K7FKehCH0BPeVg7CBPAHIT1EZ2MVHmBQox45X0AH4nc3yvmUUzTEpMTZGv06k
         mBWZzLJaqJge+PHqw8x2yLS6XW+7IEPn3L6TOCe5zYZfRYnBSvKP+FXML2d39FPYB8tu
         brAkXmSOmwRR74eZ8D2ImNTfB78g/g6dtCyEnYwAzK2wYA/R4FZxEaoowjGXXh/sRstQ
         mWlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XdxxRvNPqFgVB4QJaeaHAzMjj0lVYGxn3dldB8u/Zr4=;
        b=qg9O1ox9G7m6sXybnesIofFMJ6CRCleSEbhlRyRUjuQLxmHCdVLMed610KCK3A2pkL
         n1von0kS4Y/KNLlC5vkEm5pKUcV8LQBLc64AmepuKXg/ftPBrF1BJpmwa5F7y9BLf8Z2
         DnNLju+caJuyXX3QYtzAmegjydZ0af1Y7sucK5xpPjWwq+5HKlUQ8/CxOdrvgofOFhLQ
         LufX/ARiq1AFPDgbovIW9SKXc5HQYYdonf9ik71sB9sa5IrhjyCceRR0a6veEtm1i4do
         t7fjn/7ep8+H+pLKfFe5Yi2CeFrk06EPihIZwZpRtE4LMJq6HYrtMqUUuxIoaECGrrkE
         VcFQ==
X-Gm-Message-State: AOAM533qqrbVjARE8W+dUWDThH4+aTkph7NZ7p+f2lNN4mfoYvqOD/yW
        dnzWcEOWy8KAm2mbfsTPFvI=
X-Google-Smtp-Source: ABdhPJzNRjRgYVZM2ebupFUL1SqAFM9zF1iVEify9KqJCZ1syK4D1jMK1M6fBvdZ3QasUHTe/nrQLQ==
X-Received: by 2002:a17:902:bf4c:b0:15c:3d1b:8a47 with SMTP id u12-20020a170902bf4c00b0015c3d1b8a47mr4955096pls.118.1654174948528;
        Thu, 02 Jun 2022 06:02:28 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id j23-20020a63ec17000000b003fc37053c82sm3240443pgh.12.2022.06.02.06.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 06:02:27 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] ASoC: samsung: Fix error handling in aries_audio_probe
Date:   Thu,  2 Jun 2022 17:02:17 +0400
Message-Id: <20220602130218.14901-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_get_child_by_name() returns a node pointer with refcount
incremented, we should use of_node_put() on it when not need anymore.
This function is missing of_node_put(cpu) in the error path.
Fix this by goto out label. of_node_put() will check NULL pointer.

Fixes: format:7a3a7671fa6c ("ASoC: samsung: Add driver for Aries boards")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 sound/soc/samsung/aries_wm8994.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/samsung/aries_wm8994.c b/sound/soc/samsung/aries_wm8994.c
index bb0cf4244e00..edee02d7f100 100644
--- a/sound/soc/samsung/aries_wm8994.c
+++ b/sound/soc/samsung/aries_wm8994.c
@@ -628,8 +628,10 @@ static int aries_audio_probe(struct platform_device *pdev)
 		return -EINVAL;
 
 	codec = of_get_child_by_name(dev->of_node, "codec");
-	if (!codec)
-		return -EINVAL;
+	if (!codec) {
+		ret = -EINVAL;
+		goto out;
+	}
 
 	for_each_card_prelinks(card, i, dai_link) {
 		dai_link->codecs->of_node = of_parse_phandle(codec,
-- 
2.25.1

