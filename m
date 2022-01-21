Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49CE04966E5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 22:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233471AbiAUVEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 16:04:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233204AbiAUVEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 16:04:00 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA5FC061749;
        Fri, 21 Jan 2022 13:03:59 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id a18so44753353edj.7;
        Fri, 21 Jan 2022 13:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=RtUb0uNm8GCwaxKxVgq9cIPVLkXV4oSCeOPZFznLHNM=;
        b=AFbGQf7jDc5FFQyPVtJ9HIzjjCGEWxCvoFKNDaXDUx0oNK31FGeMGxt6/PS1Oz2deV
         nGtiUcyiKyI/RNg3uToMBrhtH3JPNZHfCCwiAPuqLivHDdc5prl2+YQ2ttCpCAyWqb4J
         lyMIXiwV7ognLAjZLnDPjzAKz03U316dRbTPr4EwpM/SAX4MVMRgEBJ+QDIIWHpKCzPa
         +48vV2fOMHf2KCOMLy+s3yuY84xukpzt64Ys1b6v+n8FclxesfdM6oG6mExT+jPkSle0
         MpCNKDrMdylJKTkJA/tW0EyfpcHY1nQhhpeQ4LVvYbCX4XS9TWOLnf5q28bQmMOxxb+J
         vbvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RtUb0uNm8GCwaxKxVgq9cIPVLkXV4oSCeOPZFznLHNM=;
        b=DduzpR9ycgK+dFYs5g9gZJXFpyBZP7vMO7GHrSB08Gi+5Pz0NdNlSyNYWgqwb9sAgs
         b/2sB2E0MMPKUFlRF0ZBCkt+i8l/qqRdaelYsze74wBTNc6tdRqJr3Pgae1V7kZmVMcX
         62jasIcIDKRGuOfimn9vBIh0JdoHDXBSuZxfU8ooxOP1MaiAB9pLz3SvFmywjY5nlUqO
         oLO3OuDLHmeDEqSEB3h2uxeOU6pXXalt0Hj7ESI1qysnEP3VrmwZ4hGWXpDHxhVY+ZDf
         21esN5xS/uc9IrWLJ+3JI9kAv+FVOuKz/ig9fMl040kc9URx/i1ZKcenGXYVeGfIjHpP
         ZD2A==
X-Gm-Message-State: AOAM5317V5hYKVk7zZqdBfiAJ4SAIoS44MfVvDioklX6Pv3GQ8/rMe0l
        mCtaMA6jGg/SaFlNxBeeIdE=
X-Google-Smtp-Source: ABdhPJzkz6Y0i6kHjYIL8msgv2r16C9YqtFHMuJBumIgeEN/m29hBALrc407O/kQlA3gD9pdTRpQ5w==
X-Received: by 2002:a50:9e0f:: with SMTP id z15mr5861386ede.278.1642799038353;
        Fri, 21 Jan 2022 13:03:58 -0800 (PST)
Received: from localhost.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id p23sm2898595edx.86.2022.01.21.13.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 13:03:57 -0800 (PST)
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
Subject: [PATCH v3 07/15] drivers: clk: qcom: gcc-ipq806x: drop hardcoded pxo and cxo source clk
Date:   Fri, 21 Jan 2022 22:03:32 +0100
Message-Id: <20220121210340.32362-8-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220121210340.32362-1-ansuelsmth@gmail.com>
References: <20220121210340.32362-1-ansuelsmth@gmail.com>
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
index f6db7247835e..a4bf78fe8678 100644
--- a/drivers/clk/qcom/gcc-ipq806x.c
+++ b/drivers/clk/qcom/gcc-ipq806x.c
@@ -3119,23 +3119,14 @@ MODULE_DEVICE_TABLE(of, gcc_ipq806x_match_table);
 
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

