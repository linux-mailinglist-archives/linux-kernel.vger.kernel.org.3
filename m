Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB7C4966EC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 22:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233610AbiAUVEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 16:04:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233273AbiAUVED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 16:04:03 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF56C061748;
        Fri, 21 Jan 2022 13:04:03 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id r10so13787866edt.1;
        Fri, 21 Jan 2022 13:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=EXW/q6yX9wxCGxkY1EpqijRPyr0+7BNt2tp7DEwa3FY=;
        b=UdC/xozdghrR7wipNAqHVhJb4vbNlKh3k0bozRMY2NKauAeHPZ2VchII0bxl4C3PG4
         SqRNW6NlDZ8S2xHQzrtI7VM3a9uCtIS/n4/z0uClXRVWdEYGUGA3RO0SCQwY+bTzGnMS
         jtUuXO2TyXJ5vU25YVpK7uhjS2ulCm2HwHAtwoSBczwjdwLFc4HqTbzVpjzGKoCJRR+m
         xeIZMsQNYtMn8GaSuE3Ckdn9yzlOuP+lqvrQpZDkB8zMKXbUZDpNyiOcy93Vrh/Q3nk3
         HlKaMafd89yrAVJRJevLl27qJQswvXbcPgaN+XYYHHAUxHEFawTo58N7ogqhCzr6rSAS
         Bwog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EXW/q6yX9wxCGxkY1EpqijRPyr0+7BNt2tp7DEwa3FY=;
        b=tBZfP4FUY54OCbzVQ8tbTyJ9UXO41y2o2vCKPX/jodsXWsSxdvKeF2nO2xh+kNdBRz
         jCMVRdgiRSyAumwJcSssY7IZxZ+nT9FA3PKzMyh5UiHHEEwBly6aQR+DjtQ8caTbVVjO
         CTq0oSDkorsbJwoonL5fOMATWz81uQsnZz5fmYMOJu8iZWCtxg9MJ8u9Qm/P5Ah4Ti4T
         mqkCXgunHXjkTcmpPSwHe16eOauq1weu/bO17LDCCKvJbSi/d0u3ebKb8HYZvUfySAVJ
         TmqBO6f5A9CnFLhruM8nYSHOpDdybTWdoJZue6gUqBBr75Hx/fvJVDjD/D+Hg4SblvH8
         74nw==
X-Gm-Message-State: AOAM532Eei2iEA9sekMh2a8/or4R+K34GSxtJU0MQL8yEE6S2/HVfr9L
        c8ceB1Q8QuJBr7Ju/rkQ0QECxTuf5LI=
X-Google-Smtp-Source: ABdhPJxNez6dTFFZyWzE66suCITTdZnjexrqF9hdoU+Do6PNAxQ3wcdYSoOV2Vpr645Kyz/kP6XXkA==
X-Received: by 2002:a05:6402:50c6:: with SMTP id h6mr5922260edb.156.1642799041772;
        Fri, 21 Jan 2022 13:04:01 -0800 (PST)
Received: from localhost.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id p23sm2898595edx.86.2022.01.21.13.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 13:04:01 -0800 (PST)
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
Subject: [PATCH v3 10/15] drivers: clk: qcom: gcc-ipq806x: add additional freq for sdc table
Date:   Fri, 21 Jan 2022 22:03:35 +0100
Message-Id: <20220121210340.32362-11-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220121210340.32362-1-ansuelsmth@gmail.com>
References: <20220121210340.32362-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add additional freq supported for the sdc table.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/gcc-ipq806x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/qcom/gcc-ipq806x.c b/drivers/clk/qcom/gcc-ipq806x.c
index 77bc3d94f580..dbd61e4844b0 100644
--- a/drivers/clk/qcom/gcc-ipq806x.c
+++ b/drivers/clk/qcom/gcc-ipq806x.c
@@ -1292,6 +1292,7 @@ static const struct freq_tbl clk_tbl_sdc[] = {
 	{  20210000, P_PLL8,  1, 1,  19 },
 	{  24000000, P_PLL8,  4, 1,   4 },
 	{  48000000, P_PLL8,  4, 1,   2 },
+	{  52000000, P_PLL8,  1, 2,  15 }, /* 51.2 Mhz */
 	{  64000000, P_PLL8,  3, 1,   2 },
 	{  96000000, P_PLL8,  4, 0,   0 },
 	{ 192000000, P_PLL8,  2, 0,   0 },
-- 
2.33.1

