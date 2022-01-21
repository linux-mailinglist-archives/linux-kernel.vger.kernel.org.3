Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 808034966F1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 22:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233815AbiAUVEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 16:04:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233248AbiAUVEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 16:04:08 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E68C061753;
        Fri, 21 Jan 2022 13:04:07 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id k25so3317696ejp.5;
        Fri, 21 Jan 2022 13:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ETUvc/o8aObyUn/852ohaMGKgdelmVW4X0FnpFAGyTY=;
        b=U8dWSor/0YyFBqGMqi9a6UpicY5NAJY62a+F1s+KYcg8fNSiuXtmhxzEObqfUDF0dv
         DCRszTQSnPn/NZHbv7dj+wN07M0U7+WyApMv6fjNs80/02v8ryXWQ1XdAghU6JbMgHXo
         kRtENAxBoy4xG0+1AA2+Cn8ldvgu8eCaV7vFV8EjckLfBeWlW0krIy5yeoUHpcH+yu9c
         vZxAuWHH8JeR6xXEbVAO8Y3uoHal7kVblMFF27cESd9xulopSHBVazTpxYpL8vF5OvzS
         eFB21nwt0yB70BdGKiXcYUoUYUFne7rYojW9oDAuOgtoBq+Y+bIkSFIVsAEqs1f39Gg4
         UBVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ETUvc/o8aObyUn/852ohaMGKgdelmVW4X0FnpFAGyTY=;
        b=jKDZG5IfJNtZZcKxX39kfdbhC0XCra/DxCjpWVrF9O3H2rpTDKR2A5gvvZxZXcEXoX
         K2CsYdW/odUx+6rNwJB1I+ndRv+58VSDbra0g3k++hm0BTDtTofGGBNhgaW755ttsmQ/
         tBta4zR1r1KrXZJ7Xle4heZ6wA0C/sL81hgMACrhDuVmY8wB23qELHqyxetbyQQXqmEJ
         ni2+oSWgCYJhC3E9K5EkJzJc61ehwZLBHZya1Md2E8uyR2ePP3yv5D8Mpvt/9FzAtqeq
         I1BYpkUX+fbs+4T03WXIoU7NBnCWbzQSIFKDZxAxSy4Y2p9pzvFnxr8bCYlAhCZT4JDF
         GVUA==
X-Gm-Message-State: AOAM531RFFyB10lMN78RhA8sMq7T6l9F5mEdKjsQqWisGdDuNz2aJO47
        HlHeVnmQLUEvISmNSWUyggc=
X-Google-Smtp-Source: ABdhPJzn/KRg26oikuPegx58DPOkjFlNQ/1WvK13ekvmie0j1EjoXI/VIE2cIIJ8eYBkRt7J1ECQ4g==
X-Received: by 2002:a17:907:3e07:: with SMTP id hp7mr4585504ejc.469.1642799046269;
        Fri, 21 Jan 2022 13:04:06 -0800 (PST)
Received: from localhost.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id p23sm2898595edx.86.2022.01.21.13.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 13:04:05 -0800 (PST)
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
Subject: [PATCH v3 14/15] drivers: clk: qcom: gcc-ipq806x: add CryptoEngine resets
Date:   Fri, 21 Jan 2022 22:03:39 +0100
Message-Id: <20220121210340.32362-15-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220121210340.32362-1-ansuelsmth@gmail.com>
References: <20220121210340.32362-1-ansuelsmth@gmail.com>
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
index a86d1504a149..8f025cef2ec3 100644
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
2.33.1

