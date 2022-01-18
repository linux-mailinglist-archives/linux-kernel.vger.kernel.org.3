Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3740A49132F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 02:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244131AbiARBCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 20:02:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244097AbiARBCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 20:02:07 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C11CDC061574;
        Mon, 17 Jan 2022 17:02:06 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id m4so72502025edb.10;
        Mon, 17 Jan 2022 17:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=wfWF7NDErASivxj8coRKrOvkTRbtA/JEwudCiRXB7sw=;
        b=gJeeDhfI9NgKF4swBHQ5YHzu4vJe66KrAxl7Ifoj3w9/bD3d/KOHwWjiBK2JXT/sB1
         jZm9FDEeViMtHqh4XwVy2/MUb+jhcoA4ZkL8mINGaNfvNYhhJAxESHl+QdiHF4uN9EMD
         I31cM6BQDaVdTzfHwTrAMN+7ZPBx+F5aVkIYV2PPQzv8bkrk2jnjU19KgMCG7wuN9CcH
         foDBDiCz2g01H3W45j3yyJdZTPhWkQyjqYX8lT11+82wdQ7IPrUyEun+HEa0/UlhSPq8
         Wh3bHb6oVkWo2u4THxLCbDTWRuOcRuUgPQ6sCPOeGi7U1cXOvgIIxa+9obaFZ4IfvPz8
         ZUeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wfWF7NDErASivxj8coRKrOvkTRbtA/JEwudCiRXB7sw=;
        b=FL7Y8cFy2pFS7tcAPpwtoGAi3+meCHJBUeO6qB+YfM6+GxSCNwond4BMbUSQebb71n
         b6joMCZGnOMeAH2D1jNpO+8R2KtraDeDBK/OXPpTz5JjNqRzMck/Q1XAs/8fRkFLEGel
         gLXQ4AxzETHHQjgVYs0BfNdtHfQ4UO2+viEVsUvAHIV3nabHAGkxjuaATr+m9E8XaBv/
         lr4jUHEqGvXDJIqJ/oZtthvxi344FWPVGVECvgKmFJlBO2o4Ip17sHT8TUscnDMcFfgw
         HaGh/iM8z43PFV56SH15A7feMJjksuZACo9aYqgA3mpp51Gk0JOaSsSaNJyCe5BDxDCp
         nnTQ==
X-Gm-Message-State: AOAM530tBlT6ur4hLR6evp7+5R7Ixb5ME2ir0Q4Vph0DieE936Q9OTw1
        lmS4T+CNb2+raIzUYkJkaww=
X-Google-Smtp-Source: ABdhPJyvfKYO/3BoNpEfSP+7U1xiuEgEyE24wlSi8o03TL8IVJWsaGLTfrDpk3cAlV6hZr1u5ditgQ==
X-Received: by 2002:a17:906:58cf:: with SMTP id e15mr90480ejs.439.1642467725281;
        Mon, 17 Jan 2022 17:02:05 -0800 (PST)
Received: from localhost.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id 24sm4892127ejg.47.2022.01.17.17.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 17:02:04 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 13/14] drivers: clk: qcom: gcc-ipq806x: add CryptoEngine resets
Date:   Tue, 18 Jan 2022 01:44:33 +0100
Message-Id: <20220118004434.17095-14-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220118004434.17095-1-ansuelsmth@gmail.com>
References: <20220118004434.17095-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing CryptoEngine resets.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/gcc-ipq806x.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/clk/qcom/gcc-ipq806x.c b/drivers/clk/qcom/gcc-ipq806x.c
index 46d0fe511868..201c967fc74d 100644
--- a/drivers/clk/qcom/gcc-ipq806x.c
+++ b/drivers/clk/qcom/gcc-ipq806x.c
@@ -3328,6 +3328,11 @@ static const struct qcom_reset_map gcc_ipq806x_resets[] = {
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
2.33.1

