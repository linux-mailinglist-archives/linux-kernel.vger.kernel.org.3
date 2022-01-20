Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A642D4956E2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 00:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378289AbiATXVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 18:21:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378174AbiATXUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 18:20:42 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CCC2C061574;
        Thu, 20 Jan 2022 15:20:42 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id az27-20020a05600c601b00b0034d2956eb04so17624765wmb.5;
        Thu, 20 Jan 2022 15:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=cBE+j0nomJ1s8ZdluzXzBh2EPO3NhAaZtGzkoFt0ias=;
        b=Whyb03my8IFhPEptRVlGr4URhZBE38JrzGRa6OZPM1l9NvAhz6dnlhFLm7ZcTBVkTI
         qp14N9itW0nIw/izG1Ymngd9AiAgtQdLVM0B35iBktN3y3Euln6wAgqlsuH2O34uJhMk
         HcQ3xYSfqJWT4u39UDGiXAD8mrByL9scx7ALgayE1UELY8tPzvkqi2iHFKBNVLIQyI5q
         GLlZ0eIjt1PnBbI6DSt2L2FYe12L2rZXtl6tSohsAFbzzEY/D1Kho9GGg9BSnP40F5Ve
         FImm3pUQzJG6WuXJBo61NUUW/o4C7yZZwHz1DpNn85D/wo+iGQuqJORhPKgvxfaQ0D8U
         o0EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cBE+j0nomJ1s8ZdluzXzBh2EPO3NhAaZtGzkoFt0ias=;
        b=f66Uk1aBJ/MJfhqYGuBGcaMTVWbwCxS+vjhKHsDr2P1qMhOcSidV03q4yqhdIBwVUD
         zOmY7lRK6p2j2uCzva3PpN56B8z7mMfHBbMr3aKFFJi5yCq6vH+p6h+8uggj+lhpzaoc
         4xKdSuKos9Ul0TsHoj2+u1KUYoDO54vH+LEjGR3vOWMK9Tr6dNSqeGpRgI8k6xWsYPiO
         dZ41s9Jvm37+8kNRlF4bBKLnzc9FHKMst/ihUgkAW97cCOajl+jVnZWL3vhLiEcrMUs3
         +UwNIeHJ3Ze2F/mP0qr3diyFtmX22aWkm+hFZdg0Im07ETFIPJzfQ2NqdlGJvjI4tMxM
         LGxw==
X-Gm-Message-State: AOAM532jJ+xzLPtf8pas4plNgE16cBeqGMsu9AGNPZgUWJXIk16k3Ipr
        xGGXDkTJmZcBQ7uBfbozaKc=
X-Google-Smtp-Source: ABdhPJx9wHd3mKhqjNGyUqybkNbuUoivja0ogM0Tz2QwlOoqewFC0ZktNmyjY0JjN5aavyUw6LVfOA==
X-Received: by 2002:adf:fb4f:: with SMTP id c15mr1145070wrs.509.1642720840908;
        Thu, 20 Jan 2022 15:20:40 -0800 (PST)
Received: from localhost.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id a9sm3939283wmm.32.2022.01.20.15.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 15:20:40 -0800 (PST)
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
Subject: [PATCH v2 08/15] drivers: clk: qcom: gcc-ipq806x: add additional freq nss cores
Date:   Fri, 21 Jan 2022 00:20:21 +0100
Message-Id: <20220120232028.6738-9-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220120232028.6738-1-ansuelsmth@gmail.com>
References: <20220120232028.6738-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ipq8065 SoC (an evolution of ipq8064 SoC) contains nss cores that can be
clocked to 800MHz. Add these missing freq to the gcc driver.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/gcc-ipq806x.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/qcom/gcc-ipq806x.c b/drivers/clk/qcom/gcc-ipq806x.c
index a4bf78fe8678..53a61860063d 100644
--- a/drivers/clk/qcom/gcc-ipq806x.c
+++ b/drivers/clk/qcom/gcc-ipq806x.c
@@ -232,7 +232,9 @@ static struct clk_regmap pll14_vote = {
 
 static struct pll_freq_tbl pll18_freq_tbl[] = {
 	NSS_PLL_RATE(550000000, 44, 0, 1, 0x01495625),
+	NSS_PLL_RATE(600000000, 48, 0, 1, 0x01495625),
 	NSS_PLL_RATE(733000000, 58, 16, 25, 0x014b5625),
+	NSS_PLL_RATE(800000000, 64, 0, 1, 0x01495625),
 };
 
 static struct clk_pll pll18 = {
@@ -2702,7 +2704,9 @@ static const struct freq_tbl clk_tbl_nss[] = {
 	{ 110000000, P_PLL18, 1, 1, 5 },
 	{ 275000000, P_PLL18, 2, 0, 0 },
 	{ 550000000, P_PLL18, 1, 0, 0 },
+	{ 600000000, P_PLL18, 1, 0, 0 },
 	{ 733000000, P_PLL18, 1, 0, 0 },
+	{ 800000000, P_PLL18, 1, 0, 0 },
 	{ }
 };
 
-- 
2.33.1

