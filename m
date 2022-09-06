Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86CFB5AF22A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 19:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234884AbiIFROY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 13:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232812AbiIFRNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 13:13:15 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD548E461
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 10:02:50 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id c11so12186935wrp.11
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 10:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=6rZZaOHOvolmccYyL5qbkZM57p/vVPxvzfbkv6kGURE=;
        b=q2IY/FkU+EwGOenHoZWLdAfnChVyNwkkKF265iraI9ckc9qsk4ijm6+VtskJ1Yl4km
         gyKLldmdt+ArT2wzUC5YhY9dAtSPVVEZrCyzAZwtSwI6ZJdCAADOPf1bNV/J2myzxFUe
         4Q/7WM3TfSJ5FYOEpidot4YT3zHRbkN/o+rlrvJJd81skHfbIS8kk+i72kvYzc7Zzdgn
         FAoKv+eiBPgP+5nBNSMUmN6IIbKqRsPLcNM6IPY8sC0CwwifmPOJ2rpgR9fgnVI5MpCf
         IodpkBTvCNYyOltuSRiy2I3sVyG5zXlpm7+cQBmg8EA4v3hrue2XVAwsfW8xBZ9JF11p
         4a5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=6rZZaOHOvolmccYyL5qbkZM57p/vVPxvzfbkv6kGURE=;
        b=qhyOjbIZK+JX2kyxntXWk1NhQpSWjxPBOHEONBhUokIy9Z+mAUx9nc//b12TrhWvQb
         VxsKxANyWZJWywwFzsTbLsoCHc2eMPjFUBzVS4Hqv98czaW6zBeTVObcX04yNLH81Drd
         QuRmcN5Vrx67gxq+KJC1mzqFrHEMbJD9TshJwCIHd4ks1OEk0xnAI4t97b9R8vnA2Tiv
         ZebEED1+KCQKn3WeUl5IpJteMlAIuXgL/wnmOzwP03pyKC10QUaqjXSWjSL35jIuI3HA
         fl6/aGDM1nn8Bov20igtfwas3/yll8ZMHNTxTaqTsw1xBCxH6KXDHPFFcc2GsUQt7HCm
         BjhQ==
X-Gm-Message-State: ACgBeo1xmkFhpVSz/KqGaIXmb0wNa1pEHmWIAdvvnJ5Bq0A1WIWzdWPl
        YIMrZ3fwMdAqaUxONgZRSqAhSfe8iyqJ3A==
X-Google-Smtp-Source: AA6agR6xo1FAChxVoeiRn2bx7M9PwmgUTLBhxXbtcOodF7LPMsDMGwBd+1zBJleXM4zI+yUzl5IHhQ==
X-Received: by 2002:a5d:6dad:0:b0:228:46ed:856 with SMTP id u13-20020a5d6dad000000b0022846ed0856mr11454644wrs.225.1662483738389;
        Tue, 06 Sep 2022 10:02:18 -0700 (PDT)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id x13-20020a1c7c0d000000b003a5ca627333sm21085967wmc.8.2022.09.06.10.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 10:02:17 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, bgoswami@quicinc.com,
        perex@perex.cz, tiwai@suse.com, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 11/12] ASoC: codecs: va-macro: clear the frame sync counter before enabling
Date:   Tue,  6 Sep 2022 18:01:11 +0100
Message-Id: <20220906170112.1984-12-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220906170112.1984-1-srinivas.kandagatla@linaro.org>
References: <20220906170112.1984-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clear the frame sync counter before enabling it.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/lpass-va-macro.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/lpass-va-macro.c b/sound/soc/codecs/lpass-va-macro.c
index 1ea10dc70748..a35f684053d2 100644
--- a/sound/soc/codecs/lpass-va-macro.c
+++ b/sound/soc/codecs/lpass-va-macro.c
@@ -23,6 +23,7 @@
 #define CDC_VA_MCLK_CONTROL_EN			BIT(0)
 #define CDC_VA_CLK_RST_CTRL_FS_CNT_CONTROL	(0x0004)
 #define CDC_VA_FS_CONTROL_EN			BIT(0)
+#define CDC_VA_FS_COUNTER_CLR			BIT(1)
 #define CDC_VA_CLK_RST_CTRL_SWR_CONTROL		(0x0008)
 #define CDC_VA_TOP_CSR_TOP_CFG0			(0x0080)
 #define CDC_VA_FS_BROADCAST_EN			BIT(1)
@@ -423,9 +424,12 @@ static int va_clk_rsc_fs_gen_request(struct va_macro *va, bool enable)
 		regmap_update_bits(regmap, CDC_VA_CLK_RST_CTRL_MCLK_CONTROL,
 				   CDC_VA_MCLK_CONTROL_EN,
 				   CDC_VA_MCLK_CONTROL_EN);
-
+		/* clear the fs counter */
+		regmap_update_bits(regmap, CDC_VA_CLK_RST_CTRL_FS_CNT_CONTROL,
+				   CDC_VA_FS_CONTROL_EN | CDC_VA_FS_COUNTER_CLR,
+				   CDC_VA_FS_CONTROL_EN | CDC_VA_FS_COUNTER_CLR);
 		regmap_update_bits(regmap, CDC_VA_CLK_RST_CTRL_FS_CNT_CONTROL,
-				   CDC_VA_FS_CONTROL_EN,
+				   CDC_VA_FS_CONTROL_EN | CDC_VA_FS_COUNTER_CLR,
 				   CDC_VA_FS_CONTROL_EN);
 
 		regmap_update_bits(regmap, CDC_VA_TOP_CSR_TOP_CFG0,
-- 
2.21.0

