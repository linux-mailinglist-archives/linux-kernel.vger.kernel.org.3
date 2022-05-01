Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A790B5163C3
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 12:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241256AbiEAKkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 06:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345491AbiEAKjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 06:39:03 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44655E41
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 03:35:37 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id y21so13715607edo.2
        for <linux-kernel@vger.kernel.org>; Sun, 01 May 2022 03:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h9YZjRwoHC6GaFFb1SDwA29ZxpNfUjxNdlL96hvSsO0=;
        b=YY6qFncodP37LtEhEAtatrQ82fz/hPWy6G+dDcAafnW8/Lila7XInflVXwajnJNKcS
         JNYDc9UkVSLbYrChCHIcyMzmc+UtYg1jLNiWSa69AIrTB2M9yt89MNKI6DPyNAWHXUJz
         pwozzUisJWWhvadt+p3BEcDySyWLYXssYSrxwKbPNS9ZwcM5FUzofRSuru894YsOguUf
         NyZ9gBJJCi6X6WdjNIv/ph4MaIZ8Ou0xvZFPDZCsFZQSB7cBXMTFoiz+EJ4bpZrSpmAI
         XynyMXuzVv0orW+ui+Pb/4HlIwEjDklhauFgP+++nn8JAAYppqEIc5bRVgS0pORJrKN0
         WQeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h9YZjRwoHC6GaFFb1SDwA29ZxpNfUjxNdlL96hvSsO0=;
        b=YaF1jeeJmdoJuONg06w7I/xQFZZ/iBWwuZsOaZjMsXQTDJtV7Aa83x+z0wkyZuadrP
         u3iHkEu8VoskPnBtxWRM+yJkPTrg1ST0YSQs26yQuE6knWZswntwHkq2nrAGoI0EMoLx
         3ZsrVKUOogTX3BHVAMNCImmevmCeaaMcSuQ3n11047/1iLlog+zDIDjp7GoJGLWXqaGv
         wq1hbdCyqQszXANHDMf1fi7/5rUFTBDwdauVaJioyhJPtRBDvXgbprof4toEQRy5lwLk
         7Wqq5gMF25lH6zwMMpQ3xA0LBQiYnChp9HW+NkoP106p9aQ1Y6Hbj+O21WtSZ8NekoX/
         Qh+A==
X-Gm-Message-State: AOAM533MULFCbMSL+6kVGMYpgfWUEqmljBtTQZIu4wyTGK+hBTBg8QQK
        5uoM4T0thQXJYkMZB8hQ6aHUJA==
X-Google-Smtp-Source: ABdhPJw7iJwj9jQ5tU/50tMqagxdWh7joTS/ou6UwmV14fytS26n1/8N5nLzSNI34O3clqBJelNflQ==
X-Received: by 2002:a05:6402:2d6:b0:425:ed85:46bf with SMTP id b22-20020a05640202d600b00425ed8546bfmr8106806edx.6.1651401335819;
        Sun, 01 May 2022 03:35:35 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id zp1-20020a17090684e100b006f3ef214df1sm2464438ejb.87.2022.05.01.03.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 May 2022 03:35:35 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 8/8] soc: qcom: correct kerneldoc
Date:   Sun,  1 May 2022 12:35:20 +0200
Message-Id: <20220501103520.111561-8-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220501103520.111561-1-krzysztof.kozlowski@linaro.org>
References: <20220501103520.111561-1-krzysztof.kozlowski@linaro.org>
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

Correct kerneldoc warnings like:

  drivers/soc/qcom/mdt_loader.c:126:
    warning: Function parameter or member 'fw_name' not described in 'qcom_mdt_read_metadata'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/soc/qcom/mdt_loader.c | 4 +++-
 drivers/soc/qcom/smp2p.c      | 3 +++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
index 366db493579b..3f11554df2f3 100644
--- a/drivers/soc/qcom/mdt_loader.c
+++ b/drivers/soc/qcom/mdt_loader.c
@@ -108,6 +108,8 @@ EXPORT_SYMBOL_GPL(qcom_mdt_get_size);
  * qcom_mdt_read_metadata() - read header and metadata from mdt or mbn
  * @fw:		firmware of mdt header or mbn
  * @data_len:	length of the read metadata blob
+ * @fw_name:	name of the firmware, for construction of segment file names
+ * @dev:	device handle to associate resources with
  *
  * The mechanism that performs the authentication of the loading firmware
  * expects an ELF header directly followed by the segment of hashes, with no
@@ -192,7 +194,7 @@ EXPORT_SYMBOL_GPL(qcom_mdt_read_metadata);
  * qcom_mdt_pas_init() - initialize PAS region for firmware loading
  * @dev:	device handle to associate resources with
  * @fw:		firmware object for the mdt file
- * @firmware:	name of the firmware, for construction of segment file names
+ * @fw_name:	name of the firmware, for construction of segment file names
  * @pas_id:	PAS identifier
  * @mem_phys:	physical address of allocated memory region
  * @ctx:	PAS metadata context, to be released by caller
diff --git a/drivers/soc/qcom/smp2p.c b/drivers/soc/qcom/smp2p.c
index 59dbf4b61e6c..d9c28a8a7cbf 100644
--- a/drivers/soc/qcom/smp2p.c
+++ b/drivers/soc/qcom/smp2p.c
@@ -119,6 +119,9 @@ struct smp2p_entry {
  * @out:	pointer to the outbound smem item
  * @smem_items:	ids of the two smem items
  * @valid_entries: already scanned inbound entries
+ * @ssr_ack_enabled: SMP2P_FEATURE_SSR_ACK feature is supported and was enabled
+ * @ssr_ack: current cached state of the local ack bit
+ * @negotiation_done: whether negotiating finished
  * @local_pid:	processor id of the inbound edge
  * @remote_pid:	processor id of the outbound edge
  * @ipc_regmap:	regmap for the outbound ipc
-- 
2.32.0

