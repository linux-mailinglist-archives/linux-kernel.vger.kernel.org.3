Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2746D4E2BE2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 16:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236683AbiCUPUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 11:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349954AbiCUPTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 11:19:19 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802E011174C;
        Mon, 21 Mar 2022 08:17:54 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id u16so20158885wru.4;
        Mon, 21 Mar 2022 08:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=uKLqUE0HqMblkYxTDEoLkraH8fYkNKsZ80vlgdu8msQ=;
        b=Kg32+44voPSZPfHfHlVLOInQdi2zziSL2WzKkR6lfRSiptD02bFTFLWkKUoD4OIBVM
         EeqKeFlP/I3s+1E1TnVG5mqPOrT46XpQBUAGrqr+WkNCQbzbSg4T1SfEMLIdhzhTXXmK
         DT/ThTdnxfvISyQy8W4PGzyL/CZNLyPtPbhF6D3/uB2/O0UgEd4SKA/WwPPvBD/Y/SLA
         QFY/v8VUNEy9yY6BSXoII6+7JakMYlAswigKJK149Qc+n3OXLF5RbjV9o6NL53EQ0XO8
         4crsVNRdeXRTDHJhB/1VCOCDhoIo9yue+1cISxialmm+jsL1ZO42AV33fEVW2AS7qLsD
         TBlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uKLqUE0HqMblkYxTDEoLkraH8fYkNKsZ80vlgdu8msQ=;
        b=yvYPMxIlNsjXP2bW7qVD5G4b7n4+cHsJkGBtiCm8aLl8ft4x/lo727vddsboibmP1r
         hVTBl19J7RWNO3CGDAqekkFu4znj39KDvxoig6zBhoOrN33zbv69bclHPH2VNz7m5sMu
         WazoHdMSNuUnsnnYOyw5uEvOUS8RhbEwn2xhusn4wfmKj+oA22jacBsBH+U17tdzabZA
         xrCLfIjbILn+vydcnEvf/SkcA3R9Vg2OuJywbVy0hpB1Sb8aTblSLy26sjOqsVLFClwf
         WiPZ6UkJZ/rciUsWAUrZGNvlHKx0faTlDA0L4gdjo0ho/c4CTtqp5TQ/ZrSb4I2/GAw7
         Lsew==
X-Gm-Message-State: AOAM533UCqEQB62d1SkWkdSjIpemgcWKZTkCx0ImSF9irohWQFv94cjh
        ssBIRbks0+hbx0OUcRC2EyE=
X-Google-Smtp-Source: ABdhPJyyZ5kPgpqQMhEsYC8BLymzgP/R8FO9Ybv6vdfhM/7iy3ATXmgl5qwQYzmMfqWCuUnIhw4IZg==
X-Received: by 2002:a5d:6d8a:0:b0:204:8aa:309f with SMTP id l10-20020a5d6d8a000000b0020408aa309fmr6607273wrs.38.1647875872948;
        Mon, 21 Mar 2022 08:17:52 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-69-170.ip85.fastwebnet.it. [93.42.69.170])
        by smtp.googlemail.com with ESMTPSA id 10-20020a5d47aa000000b00204012e4373sm7239729wrb.101.2022.03.21.08.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 08:17:52 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v4 07/18] clk: qcom: clk-krait: add hw_parent check for div2_round_rate
Date:   Mon, 21 Mar 2022 15:48:14 +0100
Message-Id: <20220321144825.11736-8-ansuelsmth@gmail.com>
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

Check if hw_parent is present before calculating the round_rate to
prevent kernel panic. On error -EINVAL is reported.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/clk-krait.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/clk-krait.c b/drivers/clk/qcom/clk-krait.c
index e447fcc3806d..b6b7650dbf15 100644
--- a/drivers/clk/qcom/clk-krait.c
+++ b/drivers/clk/qcom/clk-krait.c
@@ -80,7 +80,12 @@ EXPORT_SYMBOL_GPL(krait_mux_clk_ops);
 static long krait_div2_round_rate(struct clk_hw *hw, unsigned long rate,
 				  unsigned long *parent_rate)
 {
-	*parent_rate = clk_hw_round_rate(clk_hw_get_parent(hw), rate * 2);
+	struct clk_hw *hw_parent = clk_hw_get_parent(hw);
+
+	if (!hw_parent)
+		return -EINVAL;
+
+	*parent_rate = clk_hw_round_rate(hw_parent, rate * 2);
 	return DIV_ROUND_UP(*parent_rate, 2);
 }
 
-- 
2.34.1

