Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35FCE4E2BD0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 16:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350029AbiCUPTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 11:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349932AbiCUPTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 11:19:15 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D4B111DDC;
        Mon, 21 Mar 2022 08:17:50 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id m30so11324524wrb.1;
        Mon, 21 Mar 2022 08:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=XhL5PcXPAVYZIaqVjbCyrF3IgCwpUk1BeN4L/hsgGTo=;
        b=cHFxeW+dNxRnim5lHgkGnYGLUOXrAntyIXQ97bgPETSh50ci0sSBCoYftpHi8HNr45
         E5VVBYCnOoxRpeLzSxqZDGQQSZai4X1NzRWBwu08C/WoT00RwSqGymMFZf+J+KkO412i
         kegSRwz5mS3LFDjpt0OfbvkZ7JkEpuNgJGEX7KNOKXxVCFO3RqDhgQ1p/cZpeJpXcoP4
         YicRMjXgRDnD9sA6dh0Q3XlYMgr6sLEaQnsc/DI+fUHkK+x25q/Cch5ciktMxsAjyDLo
         r7fCbrCL6fR5JUqT+4kbKkFt5Q+y3+A/3yGKEZ3u+R0doExMbi+5S9PIbP4c55Hw8Beu
         D4fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XhL5PcXPAVYZIaqVjbCyrF3IgCwpUk1BeN4L/hsgGTo=;
        b=BSHn4fpFAKlmiTaokoyxfBsr16+lzMVKem+mAFca0VgZhxqt17qpLkP7gwHT6ynzHk
         pusOITr80WEaGm9h/yRixuA1fz1WD/A5+fSxTE16qU0uT70VQrwnWn6rhOwKmWN72tVg
         eQ/91ftTDVDA2lE45PvCSrc20dHyJwMPE5tfHBARh8ebVfVcSL6XX8vMWP13Eft/YSzp
         Hx0APkzR8iYSYw+9TbaRVF0Dx0B5biquzv6QWmTM6CjjIDXbrmK6FtY0UHiq6w8UabTM
         JSODF0T94M2w+x2ISsC0s7JZ4u6XL+l6FSBDo0efs2yv6oMRYIV95mMCcXA8P2LaCxzw
         hJGQ==
X-Gm-Message-State: AOAM53144HGU4EAS+T1XiduI7Ut0GWpiyHXpnhJ3iG/o2IZvIAWjxxNj
        Oe/idAe+rodSPBb9Y3lsBs8=
X-Google-Smtp-Source: ABdhPJy4fxPuhDbY7wiV30NpnJ0j4pmlrHKEwDEiCM3xIxrH7V/wV6fzz38BHzg62VuhqUHaM1UaCw==
X-Received: by 2002:adf:f50d:0:b0:203:f72c:e26a with SMTP id q13-20020adff50d000000b00203f72ce26amr12386883wro.620.1647875868677;
        Mon, 21 Mar 2022 08:17:48 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-69-170.ip85.fastwebnet.it. [93.42.69.170])
        by smtp.googlemail.com with ESMTPSA id 10-20020a5d47aa000000b00204012e4373sm7239729wrb.101.2022.03.21.08.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 08:17:48 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v4 03/18] clk: qcom: gcc-ipq806x: add PXO_SRC in clk table
Date:   Mon, 21 Mar 2022 15:48:10 +0100
Message-Id: <20220321144825.11736-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220321144825.11736-1-ansuelsmth@gmail.com>
References: <20220321144825.11736-1-ansuelsmth@gmail.com>
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

PXO_SRC is currently defined in the gcc include and referenced in the
ipq8064 DTSI. Correctly provide a clk after gcc probe to fix kernel
panic if a driver starts to actually use it.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/gcc-ipq806x.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/clk/qcom/gcc-ipq806x.c b/drivers/clk/qcom/gcc-ipq806x.c
index 27f6d7626abb..7271d3afdc89 100644
--- a/drivers/clk/qcom/gcc-ipq806x.c
+++ b/drivers/clk/qcom/gcc-ipq806x.c
@@ -26,6 +26,8 @@
 #include "clk-hfpll.h"
 #include "reset.h"
 
+static struct clk_regmap pxo = { };
+
 static struct clk_pll pll0 = {
 	.l_reg = 0x30c4,
 	.m_reg = 0x30c8,
@@ -2754,6 +2756,7 @@ static struct clk_dyn_rcg ubi32_core2_src_clk = {
 };
 
 static struct clk_regmap *gcc_ipq806x_clks[] = {
+	[PXO_SRC] = NULL,
 	[PLL0] = &pll0.clkr,
 	[PLL0_VOTE] = &pll0_vote,
 	[PLL3] = &pll3.clkr,
@@ -3083,6 +3086,10 @@ static int gcc_ipq806x_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	clk = clk_get(dev, "pxo");
+	pxo.hw = *__clk_get_hw(clk);
+	gcc_ipq806x_clks[PXO_SRC] = &pxo;
+
 	regmap = dev_get_regmap(dev, NULL);
 	if (!regmap)
 		return -ENODEV;
-- 
2.34.1

