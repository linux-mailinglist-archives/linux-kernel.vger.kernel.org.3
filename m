Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3410C5AF21F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 19:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbiIFROP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 13:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239381AbiIFRNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 13:13:07 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E328E993
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 10:02:47 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id b5so16416786wrr.5
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 10:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=wHzaLeNQVCSBpl0uliw1oI1t3Vv7waInVuSDN9rCrD4=;
        b=k8U1G9bRxyqpso63N2PFNnVmHY6LUWgCTgQrkSyvHLGHl1JmRKJA/N+k+rYUtOB8FA
         4EUUHoJ4qLupudKinKgBMzDjyDPCxT64rOhsoZPhY7HRQYjVX6M5xbYKne7p5bPwzc1a
         eOADvQJ5J4nPk7YuwFbV6BLG61EqZpoxVkkSGlkaQiPcLC6H0s7B6o66qxEjQxGRxVz0
         3KWryMtXUVDYZEv3zeMOMa+2T6mFHg4uWw35hlS1WgTXc2l1PpR7Oi5M3T7GpoTelycg
         xw7onG3TVNnbKLzZYdbgPay5T8/tNwBEouWDB18+RqDAC1b0fU3jJa0zL0rxvEczAfbv
         unMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=wHzaLeNQVCSBpl0uliw1oI1t3Vv7waInVuSDN9rCrD4=;
        b=QLLy5vSniHF+LKqXL6/iOw8O4xa85O+tYktlcyEz8C3RfrOymUNZbcnrOpMED6aIbO
         SoAmBGPXdELtNkS2WzMm9p0MD+qTZ4cIDXHk1MnOQOXyRvW2tz8cu2w2VQS/M7a5yLbr
         m5XpDM/kdcUo88GlNlAbX7NgNZItpsckKanSZnOYcmuX2PihI3DrPY09T+nAqVkOKpxb
         d0rOykqmCCzEZKyefKWcLFkRvE/aQBrmi7j4QlucordlMkovR/lkXuYn5u/X5Bd6AN59
         tJPprg/3XPJVg52HbYB/bN7iqjn/Mf7iFuAYKKRBmfIMWsNxnAO17IPr9QodLL070UqW
         sFLw==
X-Gm-Message-State: ACgBeo1+TlOuxI+JqOijNV1aALfgfAEDyLosO25GfewG22+RES2c0X/u
        qymIwGBHN2LQC5DDVz7xXQpuAA==
X-Google-Smtp-Source: AA6agR4A0j1MQqOx9dgt2eesqRX/FLXrcfb71oW2fg138hd0nsF9LAMVvtyPJ40JMHKVpgs4f4W7xw==
X-Received: by 2002:a5d:6b8a:0:b0:228:d6f5:f83a with SMTP id n10-20020a5d6b8a000000b00228d6f5f83amr2850621wrx.381.1662483737282;
        Tue, 06 Sep 2022 10:02:17 -0700 (PDT)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id x13-20020a1c7c0d000000b003a5ca627333sm21085967wmc.8.2022.09.06.10.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 10:02:16 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, bgoswami@quicinc.com,
        perex@perex.cz, tiwai@suse.com, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 10/12] ASoC: codecs: rx-macro: add support for sm8450 and sc8280xp
Date:   Tue,  6 Sep 2022 18:01:10 +0100
Message-Id: <20220906170112.1984-11-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220906170112.1984-1-srinivas.kandagatla@linaro.org>
References: <20220906170112.1984-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible for sm8450 and sc8280xp.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/lpass-rx-macro.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/lpass-rx-macro.c b/sound/soc/codecs/lpass-rx-macro.c
index 338e3f0cad12..a9ef9d5ffcc5 100644
--- a/sound/soc/codecs/lpass-rx-macro.c
+++ b/sound/soc/codecs/lpass-rx-macro.c
@@ -3654,6 +3654,8 @@ static int rx_macro_remove(struct platform_device *pdev)
 static const struct of_device_id rx_macro_dt_match[] = {
 	{ .compatible = "qcom,sc7280-lpass-rx-macro" },
 	{ .compatible = "qcom,sm8250-lpass-rx-macro" },
+	{ .compatible = "qcom,sm8450-lpass-rx-macro" },
+	{ .compatible = "qcom,sc8280xp-lpass-rx-macro" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, rx_macro_dt_match);
-- 
2.21.0

