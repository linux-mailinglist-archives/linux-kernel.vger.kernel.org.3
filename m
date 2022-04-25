Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2B450E80B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 20:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244344AbiDYS0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 14:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244326AbiDYS0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 14:26:02 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC4F10783E;
        Mon, 25 Apr 2022 11:22:58 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id w16so10011664ejb.13;
        Mon, 25 Apr 2022 11:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m75BJZOFGksV9K5FuSEkA6hGYRiIrsUjCZWLuFWYFqk=;
        b=qFrO0EWvRwIyGjXnApcILNFr2JFmt5cXEsAaqpq1MDdv+jxQiZ9QTSTZTfDHBSCHI2
         Pv14kztnSHyTAq79UPvVQvTxxEyOI3em3eblVE17X2FFd+k1q4BPSP2eafBR3z7L+vyN
         E127xGnzRT5TsPzwfEqWvsxketn9v1NF8ItO0Ubj9wSACVvskSydpnRGKwdjY4+PbvvR
         Ij+AhlXPI0q5fSAknFKjZZlslGkuj51wDWdQBcoBSZcvHHrjYc54Q8YLci3ALUpx4wmT
         5uqHfTkgem7fCLD/5zqApqUNyTln5SmbQr9qZ04eNLcwN718lCVAJMRAthfQlfKH2E5N
         65jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m75BJZOFGksV9K5FuSEkA6hGYRiIrsUjCZWLuFWYFqk=;
        b=dzzF3XAD3zJFtT1Pm2a2uNROUAT+fNJ43g/QDU7gdt6vNAM2gZqlSx4OGumDZjlHbw
         P9YROG1aKOSuncNuAOlDLrZyqMKr+nUhzkCrryKujRfef46uC0+YNqZ2e2fBOIs3POz3
         b+oGrqOUbAzg/pI4eM9W+JOEcnbTByZryOQwNEb/23Kdai8RAd2Xym7X+BWPvs+HSTdR
         SIYXBGH5gLALK6IKO+D62mvfsgnc0q7glzQKgPWGSQBOZUspJ32DuAy/oAwoT4B6VZyV
         C+oKcpN4Q1Pe9oHPPVZ/vczGr2ZFRSYCVhS0o3PFV/2oz3+RFK0VPKlYLub2e4JIusjY
         R9qg==
X-Gm-Message-State: AOAM530YypPvaWGhy4EPfshMnzQf9FfbIKFaIPtgAAhpJPn4+MRh2QuL
        LDkXNavQvqqR3vezQNMWlpQQ5j3x7LkTDQ==
X-Google-Smtp-Source: ABdhPJzV/gEuu3H4IayAtKfQQpkAZpcN57oPHNKk3i+oLNAWHoY1ikvihU7vHVtiKtv40tq2LLvsYw==
X-Received: by 2002:a17:906:3289:b0:6ef:ebf3:388 with SMTP id 9-20020a170906328900b006efebf30388mr17419668ejw.202.1650910976686;
        Mon, 25 Apr 2022 11:22:56 -0700 (PDT)
Received: from fedora.robimarko.hr (cpe-94-253-165-91.zg.cable.xnet.hr. [94.253.165.91])
        by smtp.googlemail.com with ESMTPSA id h13-20020a170906590d00b006f39021e683sm1677210ejq.12.2022.04.25.11.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 11:22:56 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, absahu@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH 3/7] clk: qcom: ipq8074: SW workaround for UBI32 PLL lock
Date:   Mon, 25 Apr 2022 20:22:45 +0200
Message-Id: <20220425182249.2753690-3-robimarko@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220425182249.2753690-1-robimarko@gmail.com>
References: <20220425182249.2753690-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UBI32 Huayra PLL fails to lock in 5 us in some SoC silicon and thus it
will cause the wait_for_pll() to timeout and thus return the error
indicating that the PLL failed to lock.

This is bug in Huayra PLL HW for which SW workaround
is to set bit 26 of TEST_CTL register.

This is ported from the QCA 5.4 based downstream kernel.

Fixes: b8e7e519625f ("clk: qcom: ipq8074: add remaining PLL’s")
Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 drivers/clk/qcom/gcc-ipq8074.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/qcom/gcc-ipq8074.c b/drivers/clk/qcom/gcc-ipq8074.c
index 65249a03a672..969b38d4ba08 100644
--- a/drivers/clk/qcom/gcc-ipq8074.c
+++ b/drivers/clk/qcom/gcc-ipq8074.c
@@ -4811,6 +4811,9 @@ static int gcc_ipq8074_probe(struct platform_device *pdev)
 	/* Disable SW_COLLAPSE for USB1 GDSCR */
 	regmap_update_bits(regmap, 0x3f078, BIT(0), 0x0);
 
+	/* SW Workaround for UBI32 Huayra PLL */
+	regmap_update_bits(regmap, 0x2501c, BIT(26), BIT(26));
+
 	clk_alpha_pll_configure(&ubi32_pll_main, regmap, &ubi32_pll_config);
 	clk_alpha_pll_configure(&nss_crypto_pll_main, regmap,
 				&nss_crypto_pll_config);
-- 
2.35.1

