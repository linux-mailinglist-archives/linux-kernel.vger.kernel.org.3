Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0EA25A3F9C
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 22:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiH1UUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 16:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiH1UUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 16:20:33 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC641B784;
        Sun, 28 Aug 2022 13:20:32 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id bg22so6179576pjb.2;
        Sun, 28 Aug 2022 13:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=cdXy/2p9rsMPIOWZ0T02JFAzo0QjAdnfO9SJ8dve+cc=;
        b=JgNeHCW2GSjwYdA5dGJu4BJGArLGwm+pMLYUUjc+6OlwAbE6fFdvuNLZRZ0Xt39aZ3
         lMXqRhaYagnluWpa5we1Gt31mw8TCM0nEjhYvwD1TdFD0XbYgdghrpBpGWhiwzcZDWVJ
         6jm9XwjRQBmA53V65DSSlx0G/p9y+0d4L9mbLB10QmfopkOY+Eozt4pCqTRISRtFku+I
         4NpXGdG0K+Hh2wdxpolPEZqHzH6vSfMuuvMCVzL6ECWxDNbeEy3lKCzorwMQBmkIiUuM
         okaLGv44gWiQCP7bRp07cOUGqrB9X8ygaUB2XD9MrxMxQFn3yWR7oAylT+oUdNmmt8HE
         lPrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=cdXy/2p9rsMPIOWZ0T02JFAzo0QjAdnfO9SJ8dve+cc=;
        b=z5P1B+tL2zBcY5AsfDc07gSscSk5O8bIo6N3WgMw55FoFLGuXAjA6MSQkYw1dZeIFn
         JF5rmJjb7C+1aX8WNohBErdkhsSHKp1/PUZcSrAWaHfTXrCn0Eg2aAGsLsVgA7EEGVUM
         sgR5TbdBwVm3qbU4+4pVyAgGZ5w53bveVw9k8ViCRCFHvENzIrHI7Pa/uGzch+ED1Zwt
         MH+vHDqbuqWgNXe5RVI6OdoajX42ZjXmLNMNciTc1lLs4wDeWYxBfjtjCDpqpxp5IxZ3
         ty0pBKZn3Ovsa+7h/tNRTg52Ej42l6OUTYT7DJ0tOFkxznoBhr0ZHRYzCpiDtTDfKoaz
         DE5g==
X-Gm-Message-State: ACgBeo03LB82gzLc+0irau8tA1foAFl5XRewLgp4ZHP0cMBYUAoB1aaV
        V8YsvRQpyKBl1W2WlfPiWCldo55lHU7pGg==
X-Google-Smtp-Source: AA6agR4u7YKBG/AKP0OmFj31pCo2MKGpy9d/z1b9f4ys4jGXU5e1E8J7AY2b7g5Kv2KrQ84KZQzmeA==
X-Received: by 2002:a17:902:b090:b0:172:deae:b990 with SMTP id p16-20020a170902b09000b00172deaeb990mr13186031plr.31.1661718031355;
        Sun, 28 Aug 2022 13:20:31 -0700 (PDT)
Received: from localhost.localdomain (lily-optiplex-3070.dynamic.ucsd.edu. [2607:f720:1300:3033::1:4dd])
        by smtp.googlemail.com with ESMTPSA id u71-20020a62794a000000b005368341381fsm5671048pfc.106.2022.08.28.13.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Aug 2022 13:20:30 -0700 (PDT)
From:   Li Zhong <floridsleeves@gmail.com>
To:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        lily <floridsleeves@gmail.com>
Subject: [PATCH v1] drivers/clk/clk: check return value of clk_pm_runtime_get()
Date:   Sun, 28 Aug 2022 13:20:25 -0700
Message-Id: <20220828202025.1948848-1-floridsleeves@gmail.com>
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

From: lily <floridsleeves@gmail.com>

clk_pm_runtime_get() could fail. Check the return status.

Signed-off-by: Li Zhong <floridsleeves@gmail.com>
---
 drivers/clk/clk.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 7fc191c15507..f22b86dfe2f2 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2981,8 +2981,11 @@ static void clk_summary_show_subtree(struct seq_file *s, struct clk_core *c,
 				     int level)
 {
 	struct clk_core *child;
-
-	clk_pm_runtime_get(c);
+	int ret;
+	
+	ret = clk_pm_runtime_get(c);
+    if (ret)
+        return;
 	clk_summary_show_one(s, c, level);
 	clk_pm_runtime_put(c);
 
-- 
2.25.1

