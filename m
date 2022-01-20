Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4615F4956E4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 00:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378376AbiATXVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 18:21:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378181AbiATXUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 18:20:43 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6F5C061746;
        Thu, 20 Jan 2022 15:20:43 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id bg19-20020a05600c3c9300b0034565e837b6so8027519wmb.1;
        Thu, 20 Jan 2022 15:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=clnqaNqyzpxcBB6mJhgn58xxBFPn79gkEl2JvXBz70c=;
        b=NGpxLUYhGZRwkdTAA14yVKPz9M2xEFxsfxWEDicVhK/Lodv7MaCKU6PE4alcwBwPZk
         jjDd+MqOLx+IdT089YxnpRKa5yjd8R1op9q8cuPwDgMyvOMeYCRmk8aaIPu1pfXUwtWo
         /qiYXTEQ/zED0kV4nuBV4UA7dSQcrcnPQqoGtin8/1TcPFE8wPOrim7q6m5ZccRqXn2G
         UaLBU/dUM3GvfRNYhb5rUU3cnozD32CMRacnMFdpAOY5hZ3m6olJr4psgxUpcA+2o7Gf
         C7YKbiEbHvDnxdV1O+H206uPUBsdmPJUioltt6Sfjnuep9ozFcZSvCM+SzKE3GKz/pgI
         hb0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=clnqaNqyzpxcBB6mJhgn58xxBFPn79gkEl2JvXBz70c=;
        b=NB9nO3p6CqbVonIKgJjTD5NGD1Vw3SXdog5jJLKiLAye8ODLnMwDgxMYYU97FnZXZX
         YqTidzojl1eSG+Z6ISaYVBH7sUtyOYpiw1618n8vXKrSJNRXDHToxwLX5gwe73Hrx4Jw
         96OJ0lyktfodr2lmnAb6MGEKCmLp/axnov1OHxPpkMql5d9QR0oZYxrfPIlGZj+KEwjL
         6Zd5EWiCNkcZDoEVhhgYwHsAYAosw4+Cz1oemgTtIV+4JIraNIkNKaK6Xi0yBRy8qB6k
         68pQVLQ5g5P1w1jGIPJy8f+pQjnbYBei4YZd3MYj4wuRfvAoR0oE0QCH1TWTORO3uwGd
         5Rog==
X-Gm-Message-State: AOAM531Nru5EsP0xLyK9S1eyl6G4564JZyF2riakfgN1BGXKAqPr/vXb
        D39P8rhsyKttHe7+7gvpVQA=
X-Google-Smtp-Source: ABdhPJysxGudcpVSLa5mWnl2o8dgYwXuaz9Jla/fRyikTcQJIMVLZEPM5/il8c0u5EzYY7t7x8nfYw==
X-Received: by 2002:a05:600c:3d12:: with SMTP id bh18mr1120431wmb.4.1642720842004;
        Thu, 20 Jan 2022 15:20:42 -0800 (PST)
Received: from localhost.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id a9sm3939283wmm.32.2022.01.20.15.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 15:20:41 -0800 (PST)
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
Subject: [PATCH v2 09/15] drivers: clk: qcom: gcc-ipq806x: add unusued flag for critical clock
Date:   Fri, 21 Jan 2022 00:20:22 +0100
Message-Id: <20220120232028.6738-10-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220120232028.6738-1-ansuelsmth@gmail.com>
References: <20220120232028.6738-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some clocks are used by other devices present on the SoC. For example
the gsbi4_h_clk is used by RPM and is if disabled cause the RPM to
reject any regulator change command. These clock should never be
disabled.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/gcc-ipq806x.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/qcom/gcc-ipq806x.c b/drivers/clk/qcom/gcc-ipq806x.c
index 53a61860063d..77bc3d94f580 100644
--- a/drivers/clk/qcom/gcc-ipq806x.c
+++ b/drivers/clk/qcom/gcc-ipq806x.c
@@ -798,7 +798,7 @@ static struct clk_rcg gsbi4_qup_src = {
 			.parent_data = gcc_pxo_pll8,
 			.num_parents = ARRAY_SIZE(gcc_pxo_pll8),
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_PARENT_GATE,
+			.flags = CLK_SET_PARENT_GATE | CLK_IGNORE_UNUSED,
 		},
 	},
 };
@@ -816,7 +816,7 @@ static struct clk_branch gsbi4_qup_clk = {
 			},
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
-			.flags = CLK_SET_RATE_PARENT,
+			.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
 		},
 	},
 };
@@ -900,7 +900,7 @@ static struct clk_rcg gsbi6_qup_src = {
 			.parent_data = gcc_pxo_pll8,
 			.num_parents = ARRAY_SIZE(gcc_pxo_pll8),
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_PARENT_GATE,
+			.flags = CLK_SET_PARENT_GATE | CLK_IGNORE_UNUSED,
 		},
 	},
 };
@@ -969,7 +969,7 @@ static struct clk_branch gsbi7_qup_clk = {
 			},
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
-			.flags = CLK_SET_RATE_PARENT,
+			.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
 		},
 	},
 };
@@ -1015,6 +1015,7 @@ static struct clk_branch gsbi4_h_clk = {
 		.hw.init = &(struct clk_init_data){
 			.name = "gsbi4_h_clk",
 			.ops = &clk_branch_ops,
+			.flags = CLK_IGNORE_UNUSED,
 		},
 	},
 };
-- 
2.33.1

