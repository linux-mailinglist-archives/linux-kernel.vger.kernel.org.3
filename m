Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00950570041
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 13:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbiGKLWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 07:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbiGKLWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 07:22:13 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790D729D;
        Mon, 11 Jul 2022 03:47:28 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id be14-20020a05600c1e8e00b003a04a458c54so2769184wmb.3;
        Mon, 11 Jul 2022 03:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EmmKDO3uSNG8KEjBRQCwO0eqGFCI/Gc3kxhTePWS+oA=;
        b=lu88mRBppIIfqRSXhSLApFkduMzkcU/MYd++hUvqpSneCZKuVtSxI7gZYLDnTK8YuE
         XR99aShIOhDWOthEWCDDjZ0nbtQO/AjbLBWoM1FqNC4x3LStMszrYm79RQK9zs2mTr23
         ahGWJe/WXL+f6jp+SAc+L/G4NcGyevKVz/K1Lvj6GgL1K4DrifYLv5UBkQY2QuF77Tdr
         /xUFATGR+srl9tufBfrB8so/IbBOXAGunt7ufqK0I9Qd0gVb0JL7QPrtnE6wczjoQv5Z
         Xl8yWW06qeHqUa3N7ZyrDB0UW8p1YMPSCeBS4WDe92pFeKqYMEDoVN7emXEjsplymimX
         7BLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EmmKDO3uSNG8KEjBRQCwO0eqGFCI/Gc3kxhTePWS+oA=;
        b=yMfrgnShWVf54QxE9Lfxt2QGm1CgVWYeBf0DiYtjO04ler7ocKaoYrIlO1HvF2TUbb
         9RMySnCsGCE9ifJjt+B1Nn4GnikgN2Uc9GElV8A3+YpQFVd36RpO3i34tnAV3EYX5KHD
         I1HIEE5JNS6q495B2h4orC0WuC/ckj1ef33CzRSiXDJwsNV6FHEx0v3DBwPs2AYkNjGU
         Nidl48GFjtmH7iR5r1gyak9ZOOga7KuPjwwOuBv+yMZGJdom4YUfdjhqu9DHcl5OdgjW
         T72VFzvzCpe7PWtAp+u0a70X9CgCfh1vjwZWx79McLeTTeEbNw2hhkLfOHeBT0qWxPWT
         4qPA==
X-Gm-Message-State: AJIora96XhrVTOc6ihw0QxLiYWar5WMpMIiPvVxseamjOnYNfHi8FMuk
        Mq3F96/YhnaMDk8qknWG7e0=
X-Google-Smtp-Source: AGRyM1saqJy8yDxoRKR0T3TrtOTforlsoeAZeizzqapkU7iORZzdTpxt1HeudfqsZIpl3xs/wB1hrw==
X-Received: by 2002:a1c:43c5:0:b0:3a2:e4f5:4b17 with SMTP id q188-20020a1c43c5000000b003a2e4f54b17mr8400927wma.26.1657536447072;
        Mon, 11 Jul 2022 03:47:27 -0700 (PDT)
Received: from fedora.robimarko.hr (cpezg-94-253-144-242-cbl.xnet.hr. [94.253.144.242])
        by smtp.googlemail.com with ESMTPSA id n3-20020a7bcbc3000000b003a05621dc53sm6338716wmi.29.2022.07.11.03.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 03:47:26 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     bjorn.andersson@linaro.org, agross@kernel.org,
        konrad.dybcio@somainline.org, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sivaprak@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH 3/6] clk: qcom: apss-ipq6018: mark apcs_alias0_core_clk as critical
Date:   Mon, 11 Jul 2022 12:47:16 +0200
Message-Id: <20220711104719.40939-3-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220711104719.40939-1-robimarko@gmail.com>
References: <20220711104719.40939-1-robimarko@gmail.com>
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

While fixing up the driver I noticed that my IPQ8074 board was hanging
after CPUFreq switched the frequency during boot, WDT would eventually
reset it.

So mark apcs_alias0_core_clk as critical since its the clock feeding the
CPU cluster and must never be disabled.

Fixes: 5e77b4ef1b19 ("clk: qcom: Add ipq6018 apss clock controller")
Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 drivers/clk/qcom/apss-ipq6018.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/apss-ipq6018.c b/drivers/clk/qcom/apss-ipq6018.c
index be952d417ded..f2f502e2d5a4 100644
--- a/drivers/clk/qcom/apss-ipq6018.c
+++ b/drivers/clk/qcom/apss-ipq6018.c
@@ -56,7 +56,7 @@ static struct clk_branch apcs_alias0_core_clk = {
 			.parent_hws = (const struct clk_hw *[]){
 				&apcs_alias0_clk_src.clkr.hw },
 			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
+			.flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
 			.ops = &clk_branch2_ops,
 		},
 	},
-- 
2.36.1

