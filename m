Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC25A50D425
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 20:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237060AbiDXSZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 14:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiDXSZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 14:25:31 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD61935DFC;
        Sun, 24 Apr 2022 11:22:29 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id e2so11661463wrh.7;
        Sun, 24 Apr 2022 11:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wT0yCkCPfUh9wJVGH/cyL5YlmE2FY+B2AtzYeQRFBe8=;
        b=PBRNOBspxhZH6xkWDOVGcD03fAg9QSzA1SVbhHueRaV9B0/ta7fzOXc3vRDfgowf/u
         wL4jkSX3CF8Mp83GhbUT3zNIdfM9Cw2dwB0LvJrPjygAVM23pvT1L0yd/LGK/QpJEWL5
         lFTqpE7uJr0y/j5ucF9FnnGdA6fMjRlOu/l9bdvSsAAwh7sXs7u8JNjNUpI7ttS8JM/Y
         w4O7nGAmu9W3SCKRoZtvH6n774nvi/DnmUjJJ8XGCCNewrRPwby/XIf6UcjyQZ2IICYa
         9VA2jFJtwZ9piMTeRAw4FuUCBFusghFperqQ/9f+RJ2REhpIygGbvt3QMojnLI2JIjqV
         /FtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wT0yCkCPfUh9wJVGH/cyL5YlmE2FY+B2AtzYeQRFBe8=;
        b=TPuiraGCstj9pnrAmNcej8oXrp2GnP6Oqy8CUDC1ey1iDkVtnp49HaMNATSXvnFG5A
         74lb0xHsvWvBm5xKx+DPhmkk17EF+ShzbRvr9+92OJJ07HPLU8w81038mfE1tligAk5J
         ow83NKA6Jj9SfQnZpxDtL5E3JDiwZEBIrA1dvviaVm7vuRuiethxmp/G+TEMPchoXpnA
         eIXWeicXgAg6P/4NS834i/9qgIhp21RA07oKvXuAPFMyypmBf9cFyClYT9PMMVAUICt/
         MksWAzCP5CUQp2rndj+caEM7SD+FQnd694MvmFJSA23FiGkh0zHVqeoerWANvDuJm+gZ
         UgOA==
X-Gm-Message-State: AOAM532oCWJXjSXQpEbsQYjjEdXCDiQwc5ILfd+AK4FuKnqDpFf+bage
        7lkgkrlxun0D2rrxbF2Sf3E=
X-Google-Smtp-Source: ABdhPJz6/5wQ5Ppxi30Gf0C/oy0GxYq51PUK+QDtwAXOR9uXYefeoH5f8FB6BX+AU3iUm42KxnpEzw==
X-Received: by 2002:a5d:64a4:0:b0:20a:d322:9765 with SMTP id m4-20020a5d64a4000000b0020ad3229765mr5931891wrp.536.1650824548232;
        Sun, 24 Apr 2022 11:22:28 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id az30-20020a05600c601e00b0038ebd950caesm6854328wmb.30.2022.04.24.11.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 11:22:27 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clk: mux: remove redundant initialization of variable width
Date:   Sun, 24 Apr 2022 19:22:27 +0100
Message-Id: <20220424182227.1364966-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

Variable width is being ininitialized with a value that is never read.
The ininitializtion is redundant and can be removed. Move the variable
to the scope it is required.

Cleans up cppcheck warning:
Variable 'width' is assigned a value that is never used.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/clk/clk-mux.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-mux.c b/drivers/clk/clk-mux.c
index 214045f6e989..fa817c317c2a 100644
--- a/drivers/clk/clk-mux.c
+++ b/drivers/clk/clk-mux.c
@@ -157,11 +157,11 @@ struct clk_hw *__clk_hw_register_mux(struct device *dev, struct device_node *np,
 	struct clk_mux *mux;
 	struct clk_hw *hw;
 	struct clk_init_data init = {};
-	u8 width = 0;
 	int ret = -EINVAL;
 
 	if (clk_mux_flags & CLK_MUX_HIWORD_MASK) {
-		width = fls(mask) - ffs(mask) + 1;
+		u8 width = fls(mask) - ffs(mask) + 1;
+
 		if (width + shift > 16) {
 			pr_err("mux value exceeds LOWORD field\n");
 			return ERR_PTR(-EINVAL);
-- 
2.35.1

