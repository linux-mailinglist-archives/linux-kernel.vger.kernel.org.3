Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0540856958C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 00:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233917AbiGFWym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 18:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233881AbiGFWya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 18:54:30 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB922A26C;
        Wed,  6 Jul 2022 15:54:29 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id f23so5228057ejc.4;
        Wed, 06 Jul 2022 15:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kUlxRQ1of3eu4XW5c6JjZr01Kt72atQDrgao/HtGT8o=;
        b=Co0ZfwzJmPPNkFd2X0BmEcNP//YqWh2YVZ82PyFVNjtMPNYgg9gFetMF4Eg472r+dp
         JNAOiVvs2eRLbDSHhHp2ZUeREgSFQqR6nP51zMN5HBng7oH/H//HWfzvN0Fo1HiiWkeb
         oHEFGfKrYv12/Ovf4uujxQp9ugT8t/t8G5hsqb/KZhquEp3eT2UPptV1F+JV70SUMHIB
         3vwWflMGn2v4EiWOFoOH8xULKpt06+TCBpFrOc7kVHLE4B7s022Ek2NrjbRWu6vWiZiL
         4SGBkSJ9Em4sgryn3VLqWBlY6/P5C1UUpI08Eir4w4Q3R91CnWPdr0g5AjLZC7SOg1WD
         /DjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kUlxRQ1of3eu4XW5c6JjZr01Kt72atQDrgao/HtGT8o=;
        b=oXkkQ6H8LaqVbwD1mTTYiV4uPpv/NFiwfoBD/DqXHW3YSnDUUXP8cUwYFbumwHSaeT
         OMw6wB60NXaqYZAQpgQtuSVLJshA3Cms+FhCzug7VcOfdrHMmY85oUcOqwC1igatI/h6
         XIAvnjJyKJnGZ/U9rRcC89pKdCZeQ4+h7gwoO+jN7wl2MpTcQpzPDpX4zJ4j90gGdaF6
         KzsnCLkDRvI1eFFLcdw9Flv3j7BcTrIzuR+pjLDdwjpn2EiLjTqLeeL/N2VgRuMpsThK
         yMzuKdlqC2U5m5bhvzAtNLyytD+MbI3CEtBoyVgEdBpRiKUpH95040HZhg0V2UTryXI1
         7A6g==
X-Gm-Message-State: AJIora82LrhmUKUWtQ8mEZ9sj00TwJnrqTXahPAmFhPn4+YE8ipXYDYX
        egETQFxc8JkrpIvykvXgcEU=
X-Google-Smtp-Source: AGRyM1sl3zn7M5HpfENfgEsJmy2imKNBcKqIyJc0owvAEo+ADQh0QqN5BKbz8QTeOfyfAhgLSgEeDA==
X-Received: by 2002:a17:907:1608:b0:726:a7b7:cd7a with SMTP id hb8-20020a170907160800b00726a7b7cd7amr40018657ejc.682.1657148068906;
        Wed, 06 Jul 2022 15:54:28 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id d7-20020a170906304700b006fe921fcb2dsm1767637ejd.49.2022.07.06.15.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 15:54:28 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH v2 4/4] clk: qcom: gcc-ipq806x: remove cc_register_board for pxo and cxo
Date:   Thu,  7 Jul 2022 00:53:21 +0200
Message-Id: <20220706225321.26215-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220706225321.26215-1-ansuelsmth@gmail.com>
References: <20220706225321.26215-1-ansuelsmth@gmail.com>
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

Now that these clock are defined as fixed clk in dts, we can drop the
register_board_clk for cxo_board and pxo_board in gcc_ipq806x_probe.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/gcc-ipq806x.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/clk/qcom/gcc-ipq806x.c b/drivers/clk/qcom/gcc-ipq806x.c
index 718de17a1e60..883629de2751 100644
--- a/drivers/clk/qcom/gcc-ipq806x.c
+++ b/drivers/clk/qcom/gcc-ipq806x.c
@@ -3384,14 +3384,6 @@ static int gcc_ipq806x_probe(struct platform_device *pdev)
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
 	if (of_machine_is_compatible("qcom,ipq8065")) {
 		ubi32_core1_src_clk.freq_tbl = clk_tbl_nss_ipq8065;
 		ubi32_core2_src_clk.freq_tbl = clk_tbl_nss_ipq8065;
-- 
2.36.1

