Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B24A7598497
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 15:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235717AbiHRNrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 09:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245187AbiHRNqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 09:46:52 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E81EB56EB
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 06:46:51 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id bs25so1812980wrb.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 06:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=6rZZaOHOvolmccYyL5qbkZM57p/vVPxvzfbkv6kGURE=;
        b=st0tuLfjyZg4OwhWSH6GgD154EBVCs8begrdGXw66Y1wqcN6jG6vXa+K8NfbEtYg3I
         cHMjVPOLJKyvx+O0D/84ISQ2yukD3qKOuE74+kLVOC64t9RnIhNEoBMcpxMtwRX4JzGY
         RgNCqCYO8QYohBdJn2ZKNkg01259d9rfRkbKteUgMD+2F3lse3oF4uMV889ZVXG66QvZ
         QwxTyNwRxY/hcFqwZsQK0jKA9+aAX6U8g8Qt+s3G3j4d6LVBFHJZmakmXaNFyF2YQMlx
         WEnK9npc0xRahj/rWdMDKWHTw454VWiAvILMkxVkgmgjhJ7dGdAYFNjO+6wyr/uSCO/a
         zFzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=6rZZaOHOvolmccYyL5qbkZM57p/vVPxvzfbkv6kGURE=;
        b=qogl3dU+AceRgXe/6cmSDS+iH39Xte/RKUCZfojzkpeFss5H42vwSIkwqNs5QQXzPg
         kmQqLmnhbNuOThPC4UGz1ToaTvMn5vcLGhH1KJ44Z13AHIi+93dklLz5aZ60b9iTcHif
         VovlYKbR96fBQEL+dN8Zit3oI7X/6aZNzPFSx/P4B27Q6iOgSjLeRCAcGuum3fkVOyYw
         VWARPwYAKmIE4Me8mlW/XtGO4jgFDrS2/X6VrPB6FNMuAFKljEarW68ygLDx3GQVI/DF
         5JiiY2u0/TJxZiYHTlzQJ+XKyYgpvCW2OxiBs1OA8Wd6p7SCZivLDwnqhaRzd2jgtO+i
         BFPg==
X-Gm-Message-State: ACgBeo20S3Y4xzrVeDSG4bS+xpDZ099ZNYBjq/8W6w3V3B0qF3vlY2bg
        TcsZoFjH+BqPIOR38N7155hJzg==
X-Google-Smtp-Source: AA6agR4xmEGJW0LUvkQoK3lSqIY/p6u2vP1m7hMR0AVYvVbe1XxwyKkiRlTRVtKQx5SY6c6WkmMJGQ==
X-Received: by 2002:a5d:5a9a:0:b0:220:6309:5c87 with SMTP id bp26-20020a5d5a9a000000b0022063095c87mr1600521wrb.107.1660830410046;
        Thu, 18 Aug 2022 06:46:50 -0700 (PDT)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id v5-20020a5d6785000000b0021e47fb24a2sm1454549wru.19.2022.08.18.06.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 06:46:49 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 5/6] ASoC: codecs: va-macro: clear the frame sync counter before enabling
Date:   Thu, 18 Aug 2022 14:46:18 +0100
Message-Id: <20220818134619.3432-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220818134619.3432-1-srinivas.kandagatla@linaro.org>
References: <20220818134619.3432-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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

