Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37427520FE6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 10:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238168AbiEJIro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 04:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238172AbiEJIrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 04:47:36 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB88F2A2F7E;
        Tue, 10 May 2022 01:43:32 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id p8so14363991pfh.8;
        Tue, 10 May 2022 01:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tJe6pgxZ+gDU+8TgeNG6K3G9p+pmLX8CiaYNABT14ok=;
        b=TedREOUfNyXrWCkWsDDLkyIkxPjXKbiQIkQ1PKTrKThn+hMK5nsINWJ+EFZDslRto7
         tHfO5GVJdxd3qo50FwUObz+/oAfA9PZrQBB/QgB+T9wYfJ3kRbg4cjAhJhnnkZWdv/Uk
         /4Nx5z1nlpBIKQdPKn0DXXA7tqcwy4QKU7QiSGjd0cnChXRvoF1fk5/L46EsrYlMDjWS
         r8uFJNAHgu2LDEwAwkFxjUaetRe3O0wgUUzjtt+AVL9exKHuegZLXESfGJDZzTmmaVaQ
         Qfn9F1kG1lASqGBfyPFTM9v2nK9Dl0uQxuRjUE+cdPD+p/lmx6B5fpH/dRai65mIEm17
         I7pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tJe6pgxZ+gDU+8TgeNG6K3G9p+pmLX8CiaYNABT14ok=;
        b=uI9qnspr4UMC2TyRtyxoV3t9VlKgSX1uNHRGPk/Jkr7WvW45JBoaJy2tpT0VpXSe6T
         fUTOTycvbAmib4ZZND4yqjEgpioe5xynd3qtWKFSfaiVSR+VtGAqnaqbloNgb119Qb6s
         w5V3LlVHydzmFQqOhVrNC46yBYqY5+m7cEa1ApvOFzAqtMcZQUJgM9ehuDbIobI1XUEs
         1ldlHtvLxus/CjzPbe7yDixKRSXML0zdCngmHfdTSRuj2YWSDNu/Pxt2jifmE0GUjDtN
         VZ80F7/KfBWjE/bUKi7nhlnsIOm/IpS0CsO9FJiLwWrTcmDO1UNbxksjinHLAsaAX1Pv
         0ESA==
X-Gm-Message-State: AOAM531nFv7pmofZ48TcFbV1mVa3sZTQqe9GKS8x7jo8zwTYQ9lKncrz
        Gli2S21xGTr4sA50UpFse/zbdOLMvD6XeTM=
X-Google-Smtp-Source: ABdhPJy4LZ2wBmFcVLxCVuiPRPA04pxkaJK+9X0zESpKqxOMrDYn1c0omnr/27Cf2a4loSaApcij2w==
X-Received: by 2002:a05:6a02:113:b0:3c6:4389:cd6e with SMTP id bg19-20020a056a02011300b003c64389cd6emr15731681pgb.414.1652172212151;
        Tue, 10 May 2022 01:43:32 -0700 (PDT)
Received: from localhost.localdomain ([144.202.91.207])
        by smtp.gmail.com with ESMTPSA id i130-20020a628788000000b0051082ab4de0sm7935048pfe.44.2022.05.10.01.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 01:43:31 -0700 (PDT)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     mturquette@baylibre.com, sboyd@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH] clk: max9485: Register a callback to disable the regulator
Date:   Tue, 10 May 2022 16:43:15 +0800
Message-Id: <20220510084315.1706978-1-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver should register a callback which can disable the regulator
when it fails to probe.

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
 drivers/clk/clk-max9485.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/clk/clk-max9485.c b/drivers/clk/clk-max9485.c
index 5f85b0a32872..7f521205fd7b 100644
--- a/drivers/clk/clk-max9485.c
+++ b/drivers/clk/clk-max9485.c
@@ -254,6 +254,13 @@ max9485_of_clk_get(struct of_phandle_args *clkspec, void *data)
 	return &drvdata->hw[idx].hw;
 }
 
+static void max9485_disable_regulator(void *arg)
+{
+	struct max9485_driver_data *drvdata = arg;
+
+	regulator_disable(drvdata->supply);
+}
+
 static int max9485_i2c_probe(struct i2c_client *client)
 {
 	struct max9485_driver_data *drvdata;
@@ -279,6 +286,10 @@ static int max9485_i2c_probe(struct i2c_client *client)
 	if (ret < 0)
 		return ret;
 
+	ret = devm_add_action_or_reset(dev, max9485_disable_regulator, drvdata->supply);
+	if (ret)
+		return ret;
+
 	drvdata->reset_gpio =
 		devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(drvdata->reset_gpio))
-- 
2.25.1

