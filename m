Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75CAF4E5F1D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 08:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348377AbiCXHMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 03:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241560AbiCXHML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 03:12:11 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3C992858;
        Thu, 24 Mar 2022 00:10:40 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id bg10so7282552ejb.4;
        Thu, 24 Mar 2022 00:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EwHGNo4299brXkfx15j4GX5scza9emTqyVtoZOQKDeg=;
        b=mUjGObUl7C0bY7nCN6SUhdA9Uke/I0GKeZg30Rjqz7+hQfShrg2m5LPgKfjJnZcWh+
         2uLPDy+zPbyuNNIq24rohLVJfWV59EKAZpW19QlacMWFQQz2m0uiBzaUZbT/+30B84Oi
         yzaYAE56uZH1G+iRM/rRAO86SUv4q9rXf3mFMKYSAhSE7a6Lfpylcl/6XBnUc06CjQzW
         WB/mVyATDETVDO3jOo2FIvR0V2/jZoKkEwPbdBkjPZnc0YL98v9fbjgrRargUvUfzbli
         fDLpBtnATbFwkx/A5ixyeVagHX+E8n+e+/Kd4YNU2OJ8jGMMjUI7Q0rAkRzcu95htbH3
         Gj8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EwHGNo4299brXkfx15j4GX5scza9emTqyVtoZOQKDeg=;
        b=ah+2BI2LwDr3wsAJ9V+fYTV6FrEzbCb/xdugMflCXGZrMpRm1z/T7Fo0s8uP/eF2E+
         d87h2g166fBC7SP1BAid7DTjmA8Kc5Mx80vNFaei8TApYzpB2CWG3GQez8/L8yfJxULP
         S6uNOcu/GWqC+Na1wo9ZJFPo4vBSmlRreXFzaayvQKmb6Vk2kKJPEplVmb6h7NsADFvV
         MFpuTxZV02dhyswD4rsQoSrZPn6lf5asmrQE0dw6rUby6dsBPgYaiXwsjdCQunMhOM5g
         i/eHBDKgPHGP1s6A+YBaVhsuFUvcevhWrh6wandLZ6+SY5qhnuQtOFPo7ub8FkRfTCh+
         WANQ==
X-Gm-Message-State: AOAM531+x5dghTbfejhftv8zTsganwzrv4xVSyi4onDo0tEBBAV14neJ
        BleTXzsH47/JOoodFqscOAc=
X-Google-Smtp-Source: ABdhPJzuV9/GXeh9KjJYtEK7qcrmXHoJ7GxW2j+7tXUQg5zPZv084j7Alf0YIeEMISjnsuRCzFV2HQ==
X-Received: by 2002:a17:907:60c8:b0:6da:83f0:9eaa with SMTP id hv8-20020a17090760c800b006da83f09eaamr4081185ejc.605.1648105838649;
        Thu, 24 Mar 2022 00:10:38 -0700 (PDT)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id b7-20020a170906490700b006b2512921b2sm766465ejq.48.2022.03.24.00.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 00:10:38 -0700 (PDT)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Tero Kristo <kristo@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-omap@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>,
        "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jakobkoschel@gmail.com>
Subject: [PATCH] clk: ti: clkctrl: replace usage of found with dedicated list iterator variable
Date:   Thu, 24 Mar 2022 08:10:19 +0100
Message-Id: <20220324071019.59483-1-jakobkoschel@gmail.com>
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

To move the list iterator variable into the list_for_each_entry_*()
macro in the future it should be avoided to use the list iterator
variable after the loop body.

To *never* use the list iterator variable after the loop it was
concluded to use a separate iterator variable instead of a
found boolean [1].

This removes the need to use a found variable and simply checking if
the variable was set, can determine if the break/goto was hit.

Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 drivers/clk/ti/clkctrl.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/ti/clkctrl.c b/drivers/clk/ti/clkctrl.c
index 864c484bde1b..f12caef4f9bd 100644
--- a/drivers/clk/ti/clkctrl.c
+++ b/drivers/clk/ti/clkctrl.c
@@ -232,8 +232,7 @@ static struct clk_hw *_ti_omap4_clkctrl_xlate(struct of_phandle_args *clkspec,
 					      void *data)
 {
 	struct omap_clkctrl_provider *provider = data;
-	struct omap_clkctrl_clk *entry;
-	bool found = false;
+	struct omap_clkctrl_clk *entry = NULL, *iter;
 
 	if (clkspec->args_count != 2)
 		return ERR_PTR(-EINVAL);
@@ -241,15 +240,15 @@ static struct clk_hw *_ti_omap4_clkctrl_xlate(struct of_phandle_args *clkspec,
 	pr_debug("%s: looking for %x:%x\n", __func__,
 		 clkspec->args[0], clkspec->args[1]);
 
-	list_for_each_entry(entry, &provider->clocks, node) {
-		if (entry->reg_offset == clkspec->args[0] &&
-		    entry->bit_offset == clkspec->args[1]) {
-			found = true;
+	list_for_each_entry(iter, &provider->clocks, node) {
+		if (iter->reg_offset == clkspec->args[0] &&
+		    iter->bit_offset == clkspec->args[1]) {
+			entry = iter;
 			break;
 		}
 	}
 
-	if (!found)
+	if (!entry)
 		return ERR_PTR(-EINVAL);
 
 	return entry->clk;

base-commit: f443e374ae131c168a065ea1748feac6b2e76613
-- 
2.25.1

