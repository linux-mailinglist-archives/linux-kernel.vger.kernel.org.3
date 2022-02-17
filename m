Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B7C4BADE6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 01:05:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbiBQX62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 18:58:28 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:58658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbiBQX60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 18:58:26 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AAB03CFC9;
        Thu, 17 Feb 2022 15:57:52 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id l12-20020a7bc34c000000b003467c58cbdfso7371508wmj.2;
        Thu, 17 Feb 2022 15:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Ouu8iFl9UmHYXMl1PXSnG6kCU3E9ZCC3IhbJ5iz0c18=;
        b=DEF2qP0N7yseisFAarOe7CX5oi1e6oxYKx1hsQ2iGI6+M4bLJ4IFz1ZAZyNyAoQeLz
         tfLg4Bj2ljLGV+IgAoiYDFIS6EoAbZDKuuuVIX05qBEqqBcA61L3LOQfRdqukwqE5JTQ
         bOY/lp1fNW88R60ArJ1PobPcCMdxyCb+6B/DkvBsUAaIvISAURVWc3S0v5JTTIq/3YH0
         04iKBKabTGAXuasv63tzdAKhW/M2UxM4QZWLJK8AZzdf8qAsqoLMA/GM/A7ac81KTWe4
         3RB9I9VEBHSj4EcOezyRryT8+G8zTYeILgs+ntrV/xY6aeOSWANQeeLPNGgkGcWjlTLK
         ipVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ouu8iFl9UmHYXMl1PXSnG6kCU3E9ZCC3IhbJ5iz0c18=;
        b=7g/qFgdz87rFNv71MRVQu2/snUeU/JVn3VmGdhqU07rgHKp5Qe6MwNOCXCnzl7MVx3
         VEPl/WWXzaL6yxVQQUbEZu2pUjritX5HuyhDAhQ1esuAEx7josUIlUeYkVEGaPc/h+Uc
         4ZPb0NY8fojocD3ysMYT0qb86TDVm61JyZKwEkA92mQOXFHYif9zAHyz6DxDvNlcjAfJ
         g/KdIbmrMx635rbUuaQMlG+nyliuUPUicmQNS8NlRJyVAP26ZAGGW4NFNwdZkz766Ben
         TDEljpZq5SMeVf9VIpXpo3tblns7s9aLL5ijsHe9B4Aawj3JMmaUCA3zb5U5P3RdwvsF
         EfNA==
X-Gm-Message-State: AOAM530nonLJdaClDPaqd9Dnn/5eHZ3ITSjhDkec7Zc0ZDTkYLceTqZC
        eUZyMLvnVNlvMyy+q6+CH3k=
X-Google-Smtp-Source: ABdhPJxaEJA1wDg3bxEJZR1L1T8P6nBDGe97+klkGQ73jibFd//ZTF3cTWOxFnH1ddLkDdQkRvmvLw==
X-Received: by 2002:a7b:cd91:0:b0:37c:f44b:9c93 with SMTP id y17-20020a7bcd91000000b0037cf44b9c93mr8228136wmj.106.1645142235303;
        Thu, 17 Feb 2022 15:57:15 -0800 (PST)
Received: from Ansuel-xps.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id r2sm3691694wmq.24.2022.02.17.15.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 15:57:15 -0800 (PST)
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
Subject: [PATCH v4 11/16] clk: qcom: gcc-ipq806x: add additional freq for sdc table
Date:   Fri, 18 Feb 2022 00:56:58 +0100
Message-Id: <20220217235703.26641-12-ansuelsmth@gmail.com>
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

Add additional freq supported for the sdc table. The ops are changed to
the floor_ops to handle a freq request of 52kHz where we need to provide
a freq of 51.2kHz instead for stability reason.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/gcc-ipq806x.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/gcc-ipq806x.c b/drivers/clk/qcom/gcc-ipq806x.c
index 77bc3d94f580..0912abc3af32 100644
--- a/drivers/clk/qcom/gcc-ipq806x.c
+++ b/drivers/clk/qcom/gcc-ipq806x.c
@@ -1292,6 +1292,7 @@ static const struct freq_tbl clk_tbl_sdc[] = {
 	{  20210000, P_PLL8,  1, 1,  19 },
 	{  24000000, P_PLL8,  4, 1,   4 },
 	{  48000000, P_PLL8,  4, 1,   2 },
+	{  51200000, P_PLL8,  1, 2,  15 },
 	{  64000000, P_PLL8,  3, 1,   2 },
 	{  96000000, P_PLL8,  4, 0,   0 },
 	{ 192000000, P_PLL8,  2, 0,   0 },
@@ -1325,7 +1326,7 @@ static struct clk_rcg sdc1_src = {
 			.name = "sdc1_src",
 			.parent_data = gcc_pxo_pll8,
 			.num_parents = ARRAY_SIZE(gcc_pxo_pll8),
-			.ops = &clk_rcg_ops,
+			.ops = &clk_rcg_floor_ops,
 		},
 	}
 };
-- 
2.34.1

