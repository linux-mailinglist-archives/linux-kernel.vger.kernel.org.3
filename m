Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4A874BADC7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 01:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbiBQX7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 18:59:44 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:38672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbiBQX7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 18:59:38 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54730340E7;
        Thu, 17 Feb 2022 15:59:13 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id o34so4150472wms.1;
        Thu, 17 Feb 2022 15:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=B14RXekfxiu9IJQBjutFPMfgOtWFLH7yvqNN/Ern10E=;
        b=orxlCMBVLOOw22wYpLq9Ckrlq4RBwaeZYlKFVnrvxZ61x/f4gq/pYAlcplD4tRJmE9
         oxsB/bfVgl89czXpiOWDwKOW3r/flMtVUvAnzPgkftFob2fJuW5MiiKIEBKcufA72J3K
         HlHb4MwJzsBX7w2HUcFZLl7O6NcL8aY2YFX/PWvaM5ISDx+Mf79FhkUfC1+LFkbhlPVO
         /o/re8Yn9/N0s+ZZ779W3/slm6DhNW+kRc8PKMplQ6MYg2kvT4QuOwAMX3nR3PNdSTEN
         yFVMZ5Yfx+gNvF3KrXEjahUGb96tdVf0aaFq5V05Ee2jTTy5uN8WJ8/NHnQ2eP4J6wbk
         D2SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B14RXekfxiu9IJQBjutFPMfgOtWFLH7yvqNN/Ern10E=;
        b=wdAXTVnXW3+57vbJjcSMf0dnWkATBpJSyzCQ4zVOsteEQoaiguAM7DBoQZq2MyrL7k
         h+dvTh5H4aH8R342wGXSNmimZH2zVGCSPjP/OipQA3d2DJ8IX57qB+acFqJCuwFnmHZ0
         rPj/SqQLL8S2cKX94g07ImTL2/bztgBoHRdrQ4R480zCADqcA3Bp2lgb4YMH9J8xyRZ3
         ns5pYiNQIhknDlolxljeKxhmmYLMzDiP/j2i2+em1DxuF7Qw4RNZmnR3nVRmW88/wu1Z
         56paS37N5uBM2kez2MQW5MmW/m9eMUFjM897sgRY4zTKwhp7NvWNxVBEbEo81ep6ScAU
         lCMw==
X-Gm-Message-State: AOAM532OSwCcP2SZoOHErnbwpc9EjSCnsz2S5wO5YjVK9Fr8PF11ljgn
        XrJN+JKkEzd95S0KWUBhApA=
X-Google-Smtp-Source: ABdhPJw69H81Yx7gNzNrFAP/Jca7/yApEEGDZOMOgy+45RPBbsHiB8aFCWLKxj4sLXe7lNd1JKqPEw==
X-Received: by 2002:a05:600c:34c4:b0:37b:f84d:d55a with SMTP id d4-20020a05600c34c400b0037bf84dd55amr8016876wmq.123.1645142239442;
        Thu, 17 Feb 2022 15:57:19 -0800 (PST)
Received: from Ansuel-xps.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id r2sm3691694wmq.24.2022.02.17.15.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 15:57:19 -0800 (PST)
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
Subject: [PATCH v4 15/16] clk: qcom: gcc-ipq806x: add CryptoEngine resets
Date:   Fri, 18 Feb 2022 00:57:02 +0100
Message-Id: <20220217235703.26641-16-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220217235703.26641-1-ansuelsmth@gmail.com>
References: <20220217235703.26641-1-ansuelsmth@gmail.com>
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

Add missing CryptoEngine resets.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/gcc-ipq806x.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/clk/qcom/gcc-ipq806x.c b/drivers/clk/qcom/gcc-ipq806x.c
index e2b310fbc7c0..fd2ee7cd337e 100644
--- a/drivers/clk/qcom/gcc-ipq806x.c
+++ b/drivers/clk/qcom/gcc-ipq806x.c
@@ -3314,6 +3314,11 @@ static const struct qcom_reset_map gcc_ipq806x_resets[] = {
 	[GMAC_CORE3_RESET] = { 0x3cfc, 0 },
 	[GMAC_CORE4_RESET] = { 0x3d1c, 0 },
 	[GMAC_AHB_RESET] = { 0x3e24, 0 },
+	[CRYPTO_ENG1_RESET] = { 0x3e00, 0},
+	[CRYPTO_ENG2_RESET] = { 0x3e04, 0},
+	[CRYPTO_ENG3_RESET] = { 0x3e08, 0},
+	[CRYPTO_ENG4_RESET] = { 0x3e0c, 0},
+	[CRYPTO_AHB_RESET] = { 0x3e10, 0},
 	[NSS_CH0_RST_RX_CLK_N_RESET] = { 0x3b60, 0 },
 	[NSS_CH0_RST_TX_CLK_N_RESET] = { 0x3b60, 1 },
 	[NSS_CH0_RST_RX_125M_N_RESET] = { 0x3b60, 2 },
-- 
2.34.1

