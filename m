Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA054C3208
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 17:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbiBXQuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 11:50:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbiBXQth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 11:49:37 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CBF61CD9FF;
        Thu, 24 Feb 2022 08:49:01 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id r10so606453wrp.3;
        Thu, 24 Feb 2022 08:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=cc/EjjQVTzpSxPIn9B48rvEfAxhfCuLg0CsFHUnC6wU=;
        b=D6KWuaK2Qa49n0SO/DryM0q7YdXx9hyCrsFAcGFWwW92YFAlrCgZjrQAu34GV0+lxZ
         LSnU4qsAhZuGBM12I5JlI+H+dm8W6szX6AJA/LzvZf3nZFYN0/86lgVIc5ebMrsIDI5f
         3Bsg13TbEBx3XECJqRSv7qNtm82cnEJSnh7T0vd8y4Ay4HzEUrCD3wQ3KkLRIoFXdujH
         g3qk5cq044Fow+Sr5wwlkKyzK6Cy+8VsxVRp1CI3P9KZCGhg/Fq6YIbYoIiGIwCD9oMB
         NkNOpn0ItmCEpRU+l4owpMYsJxkqxsiUS/WnX0TwCkPOooHI84gV77Hs2AqeRemzvE8s
         q3rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cc/EjjQVTzpSxPIn9B48rvEfAxhfCuLg0CsFHUnC6wU=;
        b=WWxhO5KLASOxf+zgBa4SjcA467eGrAvuYGzaqoM+FWPCcTTLOVdCSKWo52K+Q2KVX/
         wezAZqZoUusl0ghEm5ahS6cFUtGUU6ixxJjAXQ+GCpCkhCO5dBxbyZsziI7VZ46SJ+SP
         23tnOmQXsMFKBPcToxoCI/irHbu62bZ8LVH+4Wp4kEyE/x/hHcGT1VLTNwzsc8nnpJTu
         PqitwOz/lC2zoOkmjctOO5XLoS+F+iLPkOf7qFCDayLlknUNakuHfeRpUY+T/m2kS4IF
         VChgWRH9CMn5erAK1eFg9GJTpzy2pxK5PNhr0OueQk5x2jF7m+xDIF8g64xyDP76eCe4
         F8kA==
X-Gm-Message-State: AOAM532VJ43uyNBuomVNwdsEQvB24J/lyqsgIA/u0k4LS4o3ff7vmWMa
        PmQxRazQo2meErLGJwhE/u0=
X-Google-Smtp-Source: ABdhPJw9ei33LKMOQzgitxsBdECJ63ZP2r+J5WsHTIgcsumOuU8PDWGvlyidZNU7+lC8YcZIV7bqIw==
X-Received: by 2002:adf:f991:0:b0:1ed:c156:b6e3 with SMTP id f17-20020adff991000000b001edc156b6e3mr3028891wrr.411.1645721340027;
        Thu, 24 Feb 2022 08:49:00 -0800 (PST)
Received: from Ansuel-xps.localdomain ([5.170.140.187])
        by smtp.googlemail.com with ESMTPSA id k18sm2694095wrp.104.2022.02.24.08.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 08:48:59 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Taniya Das <tdas@codeaurora.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 13/15] dt-bindings: reset: add ipq8064 ce5 resets
Date:   Thu, 24 Feb 2022 17:48:29 +0100
Message-Id: <20220224164831.21475-14-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220224164831.21475-1-ansuelsmth@gmail.com>
References: <20220224164831.21475-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ipq8064 ce5 resets needed for CryptoEngine gcc driver.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 include/dt-bindings/reset/qcom,gcc-ipq806x.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/dt-bindings/reset/qcom,gcc-ipq806x.h b/include/dt-bindings/reset/qcom,gcc-ipq806x.h
index 26b6f9200620..020c9cf18751 100644
--- a/include/dt-bindings/reset/qcom,gcc-ipq806x.h
+++ b/include/dt-bindings/reset/qcom,gcc-ipq806x.h
@@ -163,5 +163,10 @@
 #define NSS_CAL_PRBS_RST_N_RESET			154
 #define NSS_LCKDT_RST_N_RESET				155
 #define NSS_SRDS_N_RESET				156
+#define CRYPTO_ENG1_RESET				157
+#define CRYPTO_ENG2_RESET				158
+#define CRYPTO_ENG3_RESET				159
+#define CRYPTO_ENG4_RESET				160
+#define CRYPTO_AHB_RESET				161
 
 #endif
-- 
2.34.1

