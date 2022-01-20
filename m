Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9CC04956E6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 00:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378442AbiATXVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 18:21:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378158AbiATXUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 18:20:49 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5882C061746;
        Thu, 20 Jan 2022 15:20:48 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id r132-20020a1c448a000000b0034e043aaac7so1375327wma.5;
        Thu, 20 Jan 2022 15:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ETUvc/o8aObyUn/852ohaMGKgdelmVW4X0FnpFAGyTY=;
        b=blcAImInrA7OMX/4pKJ9wtamBVl2KLaS9ii7AGWG/i4ZcqfrRtZUJ46V46tTO+HePK
         gKvHhMUZLnoUCxXBqZHfcgxRSD7wBz6ipbbR3MIsDtYV6y14aA7z8bMydB+53L8mgpx9
         eC2BzPfQGwj+/USWgIrufUKx5c1oZUPq2s3GcDyychrg6G1ELiicXYFlje/+AtcGy7kN
         MVThxG3sttDqL3knc1G6okGsOA1DH5u10bTF/1GRtaWo8iNzj6GNE9jJosq1YbKyqdSW
         a2A1YWikx+guP86jIKLiZ/RMVOypNzAEQT4WIlUsKCNsZRJVxpFiSHefMi+IIBFb95yP
         2oWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ETUvc/o8aObyUn/852ohaMGKgdelmVW4X0FnpFAGyTY=;
        b=VgOOv0pkpXNw6cI87vcGI+AFCxFv7nC1s2oWu9WJEnQ9XnXznUOwdrGlzSwv1EWPv0
         2O8ONcHkHzXaV9YmVmnzk2eQGQTxeHEiiua0tNXQxnynFBoPOjKT/iQeqmrKx6AIIhvG
         iR9TrL6xcRvgEviIjeWUkOQ2TVpHDbGyCdO0yhot0KTuhovIMbyY4G+vhMpFtr9uocWT
         YiQyg1ZY6WTlZ6dXTTLErmQfXUe4hY0Q+qS1gOJkcS8brh6upsd2D+anZHJNnZdtzjRq
         oHcEXxvZ/437uJlYlOqaTwOBFQWqrg2ooYzG4pseoyhM7JKoF3x6ZoDo0oTgDrLusSsJ
         Ycyg==
X-Gm-Message-State: AOAM5310rRE5Y426AXLVDV8vpPvYWjkHodUvWkSHaIsQOrnsAoRzzyZr
        8mqOSt/o8LHekyggwf2CWwYJJD1RRUw=
X-Google-Smtp-Source: ABdhPJyIEuwTog2+Zu+Yt68Kvq8bRV0Zt4jzmgkS8KId/9vYCpFkNa7iXbPG4i+UjhvPnrlvbL61aQ==
X-Received: by 2002:a1c:1dd0:: with SMTP id d199mr1073134wmd.121.1642720847407;
        Thu, 20 Jan 2022 15:20:47 -0800 (PST)
Received: from localhost.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id a9sm3939283wmm.32.2022.01.20.15.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 15:20:47 -0800 (PST)
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
Subject: [PATCH v2 14/15] drivers: clk: qcom: gcc-ipq806x: add CryptoEngine resets
Date:   Fri, 21 Jan 2022 00:20:27 +0100
Message-Id: <20220120232028.6738-15-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220120232028.6738-1-ansuelsmth@gmail.com>
References: <20220120232028.6738-1-ansuelsmth@gmail.com>
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

