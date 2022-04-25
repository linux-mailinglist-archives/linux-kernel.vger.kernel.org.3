Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77FAF50E8D9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 20:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244688AbiDYS4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 14:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244658AbiDYS4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 14:56:13 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B4B9B7C54;
        Mon, 25 Apr 2022 11:53:08 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id m23so8182272ljc.0;
        Mon, 25 Apr 2022 11:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Nj6eqnbP/GgROpu1brsyfiHpGDpgD6a78O1S1lHu9aY=;
        b=AHamvxBLZw2yYVCl4t9M+9QhNa/DTOFTQDa4/vCWXOoTLXuGblZpQmVLCv5YTVHX3B
         EiGSzPrU8FrzOK6P9A2LWGgJAesoluf1m9lXqgV62994zkr5VqnjelME9M1tDm7GhMLj
         DJfUAXsfc/cz8pLHF202IwZoP3qIMK7QGJXeeDT3hjirGgr2sBIJkl/o7n9xMRlsNA0I
         fzvfn+0r1i07WjYG/EVBu9emgq8kNfTONQh9Bc5q8uagQbjiZrQW2SewVg6JAH4YcLIk
         JfIBx3IavMFFxFhebghGAPwjCoaExZaPieAloVg/R6MrunWEUD16bVOt/H+8tOlnf9MD
         41vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nj6eqnbP/GgROpu1brsyfiHpGDpgD6a78O1S1lHu9aY=;
        b=4868ewat8o+D2oU4ND3XRi5NZ3hcF+qigh5mNj/Pfioyv2oBzqUQT5gu1poBca4vh2
         rEnoT+q/+UY1wyCkFV6gYTwJLVwn3YdP8inOQDbiTOOcML+bedI1GYn0TTkAyoyCnL1h
         evjfUAW2ttuVUyBd+dCnzacmTnfxhZ4GBYtfoKpmCk22pp6PeX8rorW5xf53TmZDnzf7
         Q8rjFSHPLRrVp1oJ9L04HZXWZ5Ph1yO55l+GZiSwIzYxNkLbJlSmRK9+2vu/hp3DjDWV
         Q74AOHKIfKfKyDphsGLQb+HNrIaJp9vmkEkHCQPC5QIc+6JKQtefmqfYmi8E5kMdwqpU
         YCmg==
X-Gm-Message-State: AOAM53244RfAEHSSax/il+QK8bSlNI1dq2rvAEeEfxwLg1XvHGTZyiMy
        Ecby4emM30UTcunt4EgYyZAg8Z6fMHU=
X-Google-Smtp-Source: ABdhPJzNwPjSPPd0jKCKkPua8sNceB93G4IKePYT8GgNmJosIkvJ01B3EuKWWdgZ+6WQC9zAQD5cMQ==
X-Received: by 2002:a2e:9497:0:b0:24e:eabd:bf61 with SMTP id c23-20020a2e9497000000b0024eeabdbf61mr12048155ljh.93.1650912786756;
        Mon, 25 Apr 2022 11:53:06 -0700 (PDT)
Received: from localhost.localdomain (adla4.neoplus.adsl.tpnet.pl. [79.185.4.4])
        by smtp.gmail.com with ESMTPSA id r20-20020ac25f94000000b00471fcf5b4basm913135lfe.90.2022.04.25.11.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 11:53:06 -0700 (PDT)
From:   Adam Skladowski <a39.skl@gmail.com>
To:     phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Adam Skladowski <a39.skl@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 1/3] clk: qcom: gcc-msm8976: Set floor ops for SDCC
Date:   Mon, 25 Apr 2022 20:51:38 +0200
Message-Id: <20220425185140.15154-2-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220425185140.15154-1-a39.skl@gmail.com>
References: <20220425185140.15154-1-a39.skl@gmail.com>
MIME-Version: 1.0
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

Just like in case of other SoCs change SDCC1/SDCC2 ops to floor to avoid overclocking controller.
This commit only sets SDCC1/SDCC2 which are used for EMMC/SDCARD.
It leaves SDCC3 because on this platform it's mostly used for WIFI/BT chips like on Sony Loire family devices.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 drivers/clk/qcom/gcc-msm8976.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/qcom/gcc-msm8976.c b/drivers/clk/qcom/gcc-msm8976.c
index a8b15814933e..5781a7bcecc6 100644
--- a/drivers/clk/qcom/gcc-msm8976.c
+++ b/drivers/clk/qcom/gcc-msm8976.c
@@ -1486,7 +1486,7 @@ static const struct clk_init_data sdcc1_apps_clk_src_8976v1_1_init = {
 	.name = "sdcc1_apps_clk_src",
 	.parent_data = gcc_parent_data_v1_1,
 	.num_parents = ARRAY_SIZE(gcc_parent_data_v1_1),
-	.ops = &clk_rcg2_ops,
+	.ops = &clk_rcg2_floor_ops,
 };
 
 static struct clk_rcg2 sdcc1_apps_clk_src = {
@@ -1499,7 +1499,7 @@ static struct clk_rcg2 sdcc1_apps_clk_src = {
 		.name = "sdcc1_apps_clk_src",
 		.parent_data = gcc_parent_data_1,
 		.num_parents = ARRAY_SIZE(gcc_parent_data_1),
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_floor_ops,
 	},
 };
 
@@ -1547,7 +1547,7 @@ static struct clk_rcg2 sdcc2_apps_clk_src = {
 		.name = "sdcc2_apps_clk_src",
 		.parent_data = gcc_parent_data_4_8,
 		.num_parents = ARRAY_SIZE(gcc_parent_data_4_8),
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_floor_ops,
 	},
 };
 
-- 
2.25.1

