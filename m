Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5010F598499
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 15:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244519AbiHRNq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 09:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244831AbiHRNqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 09:46:49 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F42BB56DE
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 06:46:48 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ba1so1805939wrb.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 06:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=3+p1RU9Ekkat1LJvUzvA3of/Y+G9mmoh8xJKlE/HMlk=;
        b=UskYjoNdcSqoK6rr8xlCC/hvPPRwqGyeMjYq6y+TF6YJ+X8iPUTMmBM6maVK2N/ta6
         WhTgRWw6OhRs6Rz6ALUf6AHhtuOcynjmaInTzTFhkgvOHAOhHZJG3AjuXSlglWTCOuQL
         Vafgi9VI/2wWAFjs/vLGQRTgbnsgKtWqAr81hB+q66XlU/eelaschaJYXIvDhdAa75yz
         wf9E+w2qPPzkXQUmsVoTtLOxWMmqTMxBfh1agpx8spVjjSRKEfSN1/WXItQgS9f4NrrV
         ACOdCkEm1fDNctoIKKjdkJxYr1g5Fj26SPEgLrn9axDVXzg1HtjJXWiEwqCNmqcMHY4n
         X2kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=3+p1RU9Ekkat1LJvUzvA3of/Y+G9mmoh8xJKlE/HMlk=;
        b=BemyfSYtbd7Ys0XOuwQrXUG2g11G30TMY4Q1YqiirrPccXJQNEnjqXPap6k9vpmNrF
         KJ4nhDM9FEKESQaFilDso5AO+DuEOyNSHCwect9gSYjuL9R/7QJtz8Jpm7dlJbYG3GPJ
         QJWtWBjQkTIaHKYQJ8ixpaU1hWwQSnpJ+k3adaCHbGV7K9gwdhaya5RpIsQ8d1o+ell9
         ennrkDMCWry13Yy+kDr+DgrSBTnB4yyB6LQaeVRaOZlex4hM8zfSF8soDCZawPqAWSy0
         BgnjuOpB0ppX7Y4wNHbuoJdm7Lm8RCirHxb89MD7pzz6UBG/AZxLs0FYn/jGvzM2XLud
         gpFg==
X-Gm-Message-State: ACgBeo2yK30xfBpohC2B9g7/drtvA9Rhzqza74Jdt+Z5Hg3MTcNdblNh
        Bw+OWO/jvUh3+iDbJ2r6amFvlw==
X-Google-Smtp-Source: AA6agR7Pq5Rnsp1gu2xJq+iWh5Mc1TQ3eMrM0e7OaEqO4LqUJqBbOYq3wSCx1+y8WarrIk0ZtVGImA==
X-Received: by 2002:a05:6000:1561:b0:225:337b:454b with SMTP id 1-20020a056000156100b00225337b454bmr410757wrz.660.1660830407083;
        Thu, 18 Aug 2022 06:46:47 -0700 (PDT)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id v5-20020a5d6785000000b0021e47fb24a2sm1454549wru.19.2022.08.18.06.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 06:46:46 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 3/6] ASoC: codecs: tx-macro: add support for sm8450 and sc8280xp
Date:   Thu, 18 Aug 2022 14:46:16 +0100
Message-Id: <20220818134619.3432-4-srinivas.kandagatla@linaro.org>
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

Add compatible for sm8450 and sc8280xp.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/lpass-tx-macro.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/lpass-tx-macro.c b/sound/soc/codecs/lpass-tx-macro.c
index 55503ba480bb..4384266847ad 100644
--- a/sound/soc/codecs/lpass-tx-macro.c
+++ b/sound/soc/codecs/lpass-tx-macro.c
@@ -1988,6 +1988,8 @@ static const struct dev_pm_ops tx_macro_pm_ops = {
 static const struct of_device_id tx_macro_dt_match[] = {
 	{ .compatible = "qcom,sc7280-lpass-tx-macro" },
 	{ .compatible = "qcom,sm8250-lpass-tx-macro" },
+	{ .compatible = "qcom,sm8450-lpass-tx-macro" },
+	{ .compatible = "qcom,sc8280xp-lpass-tx-macro" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, tx_macro_dt_match);
-- 
2.21.0

