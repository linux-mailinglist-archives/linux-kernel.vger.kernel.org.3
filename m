Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7BEF4C565A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 14:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbiBZNyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 08:54:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231995AbiBZNxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 08:53:31 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 118CB9F6DA;
        Sat, 26 Feb 2022 05:52:52 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id a8so16113225ejc.8;
        Sat, 26 Feb 2022 05:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=amOEsl3ScCvMjAWWL/8NIQ9jBw9J+Nuno2OI527Aevc=;
        b=GuRftmLv7eSk02Gvq95F/5KqdjuGQFOobZI7lxeUOi5xTFLDeN869lLlNQ1zf79+AU
         HZhIa983Fmc9EtNYad5tNSQu4iz8MuiZ9aS6RmDeAQRTr4XILRb/+8MR4O1m4SN7L4Tk
         LJL/HVG0OnvvM46Z+XXetkA9guFuJIDb81vz2RMv+W2Yackt+DMSFm0vpTRB/8erAXjL
         z9peB3RzoSJMzhBBR1/CwLnrO94gZxZVsz60rrMFeXMskBryljGSy13hHxya1jTylXBh
         TqLS98AJBMjEi4na41vR3cLIVFNwKLn3TtXMl09aGashlNnNH3QS7G2N0BnN4E2c8V6Q
         6Osg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=amOEsl3ScCvMjAWWL/8NIQ9jBw9J+Nuno2OI527Aevc=;
        b=OWXi6r36IcMI4gq1pJFmTVWKmasp/Gu/DS/9HInuhaFZkQYNINrm0V6vCYHLqfCnww
         vYPzBm5ONENCrCgQkiRdJj+cKHmZgfybI5uoJZHD+1LIO55jG85Zr7cywKxZnXlDB2Gj
         NCuVA6O2FVn3iQ7f4XXWFbr0rbx2Ef7nHu6sV6P9NxuEV+I/Z22J6sZ0SZjs0TtGhlnJ
         S4H7SJNkd4gVN5ugHfxyG/B9RHnCW0iAaNvdIJH5vVUGyk2XUHlN4Gt3Hb61OPTfXjuR
         OEUZyHyHV2yr+nj/rRW+k0s6jtfvqSGyh4p9as42L4aLG5xUBQQSaAxqh+uQ8/ffAG+b
         6Btw==
X-Gm-Message-State: AOAM532jEpxDd9dFZM+vRPARU/xwYK/7ejsOUHSEB0yXqLjGtTwWQIV5
        oYrfARozDNJ580I2rtD08es=
X-Google-Smtp-Source: ABdhPJzWb3XVIF9/QCLyLBnGicx/4Mqp8NnEncC3/U2iUgsrca4WbO6mdRcPDF0y5lgofXRF2Q+Qcg==
X-Received: by 2002:a17:906:6d12:b0:6cd:6970:2d4c with SMTP id m18-20020a1709066d1200b006cd69702d4cmr9579105ejr.323.1645883570520;
        Sat, 26 Feb 2022 05:52:50 -0800 (PST)
Received: from Ansuel-xps.localdomain (host-95-251-226-220.retail.telecomitalia.it. [95.251.226.220])
        by smtp.googlemail.com with ESMTPSA id j21-20020aa7c415000000b004127ac9ddc3sm2836369edq.50.2022.02.26.05.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Feb 2022 05:52:50 -0800 (PST)
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
Subject: [PATCH v6 10/15] clk: qcom: gcc-ipq806x: add additional freq for sdc table
Date:   Sat, 26 Feb 2022 14:52:30 +0100
Message-Id: <20220226135235.10051-11-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220226135235.10051-1-ansuelsmth@gmail.com>
References: <20220226135235.10051-1-ansuelsmth@gmail.com>
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
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/qcom/gcc-ipq806x.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/gcc-ipq806x.c b/drivers/clk/qcom/gcc-ipq806x.c
index 983d07586930..f3d56519eee5 100644
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

