Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0F63491320
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 02:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244104AbiARBCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 20:02:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243878AbiARBB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 20:01:59 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C46C061574;
        Mon, 17 Jan 2022 17:01:58 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id u21so72585771edd.5;
        Mon, 17 Jan 2022 17:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ciuwc03q2BGkK4WAOq0QYpQJkVPGRMXxXF8I3KXs9ZY=;
        b=aO996fTOi8uCivGeZHAIolHhksWaqKkgdA1xdywUzF+1XQLlA7BBK0oRHPDySiIIkO
         ooa/KpAbFZay4dg9IRRJzZk/NrI272l1+GPRB52IK6E5/NkKD954Ey7iKtK3DnlBypC8
         VpSuxP/UtDd7BwnANA8f0o97go8FVpY9IrQGoYXalEr4wgvk1ovvxe6pHaGkq4m8d1at
         wuEO5DT46aCumoW81LdJDG2vmf8WAxLAd6qhcw1rPwDnhF7BgFVrKGoytbEAfsdCUNUf
         d3C9IORC0op9XeUbZbvTBwbNKb4lu9kj61I7dqXp7mA//wfK3iMrRmg6k98dAS6wsPKb
         bsgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ciuwc03q2BGkK4WAOq0QYpQJkVPGRMXxXF8I3KXs9ZY=;
        b=w8JJgluc7+WPRBH7RHyWJa+nXZL91SmNrdTPx3ew27QXqZYO0FEif+ElpgFMgtw+zd
         KzcqyY8b3rZEHDdI3sdCxY9DCY5cKuSCFMmoJnt6uPgjkK7wuS101oIn5MCRdo1GfNkf
         Xoqh2b8FmS0q0qOmUiRZfEWHDKgza4+jfMu7CnxlY0zTQOwbqYd8nyu/DX2BN26QaSaL
         aWi6iTHrfTfP3YuaUqfdgRX+TozaO6W1Au1dWwmzkBPxcRrr6rUsdbQ52ZHiGuq7B3Yj
         rrT4NYwxnoa4kxIvt9o0R+wsmbNWU2SYNoBeC0hpWFIfcyxvnhVyRUWIotvEDnhlbdBE
         kP6g==
X-Gm-Message-State: AOAM532K0Q3HC92r9u/N/dkvZphPJY7L08ih0VlqpQ98jUlWsLvbLrFc
        bMG/6VRij5OXcYMt6cn0zKQ=
X-Google-Smtp-Source: ABdhPJwadbQQhQFwwou3GrAenFFGLoM7xgWnNr+7WUqN1Io6TuBfb+T9O36lvtsRgXoA1pnn36VmvQ==
X-Received: by 2002:a17:906:5d0f:: with SMTP id g15mr5271614ejt.167.1642467717023;
        Mon, 17 Jan 2022 17:01:57 -0800 (PST)
Received: from localhost.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id 24sm4892127ejg.47.2022.01.17.17.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 17:01:56 -0800 (PST)
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
Subject: [PATCH 05/14] drivers: clk: qcom: gcc-ipq806x: drop hardcoded pxo and cxo source clk
Date:   Tue, 18 Jan 2022 01:44:25 +0100
Message-Id: <20220118004434.17095-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220118004434.17095-1-ansuelsmth@gmail.com>
References: <20220118004434.17095-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We now define these clk in dts. Drop pxo and cxo hardcoded in the gcc
probe function.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/gcc-ipq806x.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/clk/qcom/gcc-ipq806x.c b/drivers/clk/qcom/gcc-ipq806x.c
index 17ce61f36b08..383494280e3e 100644
--- a/drivers/clk/qcom/gcc-ipq806x.c
+++ b/drivers/clk/qcom/gcc-ipq806x.c
@@ -3133,23 +3133,14 @@ MODULE_DEVICE_TABLE(of, gcc_ipq806x_match_table);
 
 static int gcc_ipq806x_probe(struct platform_device *pdev)
 {
-	struct device *dev = &pdev->dev;
 	struct regmap *regmap;
 	int ret;
 
-	ret = qcom_cc_register_board_clk(dev, "cxo_board", "cxo", 25000000);
-	if (ret)
-		return ret;
-
-	ret = qcom_cc_register_board_clk(dev, "pxo_board", "pxo", 25000000);
-	if (ret)
-		return ret;
-
 	ret = qcom_cc_probe(pdev, &gcc_ipq806x_desc);
 	if (ret)
 		return ret;
 
-	regmap = dev_get_regmap(dev, NULL);
+	regmap = dev_get_regmap(&pdev->dev, NULL);
 	if (!regmap)
 		return -ENODEV;
 
-- 
2.33.1

