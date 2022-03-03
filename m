Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4B14CB482
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 02:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbiCCBtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 20:49:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbiCCBtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 20:49:47 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5EA21B71A0;
        Wed,  2 Mar 2022 17:49:03 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id n11so3402826qtk.8;
        Wed, 02 Mar 2022 17:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Anotryq1/JEstPBo/+p/ETt+CcRn9oPDl8FCPVS78QU=;
        b=DVrnbguOY2Kvqn3Z1fuMOjoBDxX0Wqo+j6Nr70wQhjiSGfizc7VmZOKJ8J1KoBQNto
         ADxMqtr1OycXlA1TbByToDW12s0SEtFaoZJLiXtr7QKuCduhVMmwnlydgIC8aslFTmOb
         bBWXbIb/mcX0AJwE3jfX0e5LTs9w2bsv7ytJhQwvYjwjbp/foZT0pI2vqfGhGu5ws/NZ
         hQkFo3LatNfh6iPTC7BwkeKd50ZSB3DJnBFTV2XGmjgg04d491lyLb5axLykVG+amcsr
         rZ2jTrnfXajKYCzvuTu5K3IEUsNeeJBRuHaWL3OxDtW1g+vypI59xDksolOtziyX9gSj
         UM/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Anotryq1/JEstPBo/+p/ETt+CcRn9oPDl8FCPVS78QU=;
        b=vBDff7/6zR+RYaUDV3mjnLcD+RN86NB2PyDtPhCYUszJcJwSaV1Jv60WIq70T852R0
         3WPmx7FvBFAHnza0TZ1N/2cSalS3vWKOt+lD19ZQ4M3fqUKGsSow5ITCOb6/7DnChC7u
         RHYC6NEsWxyfExOwi8hJH4oeQbqckFpnmsrn5DqUqnNi8MAcqftevNcK9UpTmu9PmaeU
         ia0Y0S6lDab9HWSVAES8mboDU7cNAb1EEqLjXW8ByRkZPvwnQv4cVRqWMHiMSgOHkF/J
         3mJDHmLATXGc9zl3ra5pTzuaYcFR0ocoqaC3nJ64eYk26C9ZA7EEuYxZfnr+eG7uDyju
         Dtbw==
X-Gm-Message-State: AOAM531Lv2KbjrPkz+ltgnFa0s75zm+na+KO4+IHekM/YExunPp2IJoF
        tLNcJlK0VXOHH5SAmfMZc9QDmK4axgE=
X-Google-Smtp-Source: ABdhPJzNfeZVmPQWUDx+smKOJTa6RTNbBgzABmVfjrEY0eqR+ftilZORquANV20T8Jh48KlcJyaVwQ==
X-Received: by 2002:ac8:5153:0:b0:2d0:e87c:8160 with SMTP id h19-20020ac85153000000b002d0e87c8160mr26048671qtn.332.1646272142867;
        Wed, 02 Mar 2022 17:49:02 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id a8-20020a05622a064800b002dd4f1eccc3sm527468qtb.35.2022.03.02.17.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 17:49:02 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     mturquette@baylibre.com
Cc:     sboyd@kernel.org, narmstrong@baylibre.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-oxnas@groups.io, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] clk: Use of_device_get_match_data()
Date:   Thu,  3 Mar 2022 01:48:56 +0000
Message-Id: <20220303014856.2059307-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
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

From: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>

Use of_device_get_match_data() to simplify the code.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>
---
 drivers/clk/clk-oxnas.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/clk/clk-oxnas.c b/drivers/clk/clk-oxnas.c
index 78d5ea669fea..cda5e258355b 100644
--- a/drivers/clk/clk-oxnas.c
+++ b/drivers/clk/clk-oxnas.c
@@ -209,15 +209,11 @@ static int oxnas_stdclk_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	const struct oxnas_stdclk_data *data;
-	const struct of_device_id *id;
 	struct regmap *regmap;
 	int ret;
 	int i;
 
-	id = of_match_device(oxnas_stdclk_dt_ids, &pdev->dev);
-	if (!id)
-		return -ENODEV;
-	data = id->data;
+	data = of_device_get_match_data(&pdev->dev);
 
 	regmap = syscon_node_to_regmap(of_get_parent(np));
 	if (IS_ERR(regmap)) {
-- 
2.25.1

