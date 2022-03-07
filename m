Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11FE44CFCD0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 12:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241927AbiCGL3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 06:29:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242204AbiCGL2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 06:28:00 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D6ADF2;
        Mon,  7 Mar 2022 03:07:33 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id e2so13422275pls.10;
        Mon, 07 Mar 2022 03:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id;
        bh=wtN3Z4hu9DNNZsfVCCWCUX7EPIjeuOZMz8lPtSM94AA=;
        b=JVKWDWuGuWf8NOgIhnT7t6MzO2VBqqigFqsTn47zX1sjFQ2OZJZyGIl6bU7oVya5wO
         fcIUNsnJs9CQ0EXft03h5g/13d7GQlFxIUayP6atyXPJrXGTovx674hQaizBLhuPGjb5
         iTsUaNiwBrOA7Bl3trfN8boQLEnBdnGZE5YQMSTlKplHMW50usJ1KtIESfzHkvsWFHz7
         uuNlVUkeJ2bjcgRyYn6lXXYUuNku5kBMTNr8Ij+hwBAApXN+wWu7qcTDPUc2HX0hL/5n
         0hecOfpWPyDyJVyyHAhOApoCbCZrHQvQGlGCn5W5Bv/ZYLHPNjkit/Qq81AtgzMGF+cX
         U68Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=wtN3Z4hu9DNNZsfVCCWCUX7EPIjeuOZMz8lPtSM94AA=;
        b=r+UI3tpGCx52Le6vvattU9+zbeP7PgqPTqFXLmXEdmYkhyo2f66qnuB1T1EmfpHkDP
         VtB5x6sb4mynpNSixAVeBTitpg/NwYVN1DbfCsFovZa58KIokXr84t/EGMloqwizenLd
         EYm0noPU2nwCqLQa/a7kuf/Mv1jR/i8H0yUbQ7e8yqlXiZ80cWixqptdUEVOAto1dxP4
         dNTHxp+VtMfdbz0mMhpQSN/vqeuiICdiztIiKM0LfNGFgQoJlGsulnzQgr3a/QdDHUGb
         LbTpZzTulD8Psacbj0UrwcJGyGEM9LGx6oSEApWRbNqivR5HmLadK3BasazPBAUbhVPw
         jCsw==
X-Gm-Message-State: AOAM532p4Rzyi/p+ezY8VLrhOJ+p9w+z98u2kX1ll6AVse/C9UXAWbMV
        2bRIzxnqLTB0dXjeENjtmic=
X-Google-Smtp-Source: ABdhPJxJlr2TmxJIPSEAagsB9lKMYvMjMJKCv7dNT+TRvwB+QyldjyevwGf/Fvb1qbTU3aNXCpGG7Q==
X-Received: by 2002:a17:903:1209:b0:14e:e31c:b8c4 with SMTP id l9-20020a170903120900b0014ee31cb8c4mr11655809plh.153.1646651253190;
        Mon, 07 Mar 2022 03:07:33 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id a22-20020a056a000c9600b004f10137a096sm16363458pfv.50.2022.03.07.03.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 03:07:33 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Miaoqian Lin <linmq006@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hwrng: nomadik: Change clk_disable to clk_disable_unprepare
Date:   Mon,  7 Mar 2022 11:07:24 +0000
Message-Id: <20220307110728.15635-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The corresponding API for clk_prepare_enable is clk_disable_unprepare,
other than clk_disable_unprepare.

Fix this by changing clk_disable to clk_disable_unprepare.

Fixes: beca35d05cc2 ("hwrng: nomadik - use clk_prepare_enable()")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/char/hw_random/nomadik-rng.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/hw_random/nomadik-rng.c b/drivers/char/hw_random/nomadik-rng.c
index 67947a19aa22..e8f9621e7954 100644
--- a/drivers/char/hw_random/nomadik-rng.c
+++ b/drivers/char/hw_random/nomadik-rng.c
@@ -65,14 +65,14 @@ static int nmk_rng_probe(struct amba_device *dev, const struct amba_id *id)
 out_release:
 	amba_release_regions(dev);
 out_clk:
-	clk_disable(rng_clk);
+	clk_disable_unprepare(rng_clk);
 	return ret;
 }
 
 static void nmk_rng_remove(struct amba_device *dev)
 {
 	amba_release_regions(dev);
-	clk_disable(rng_clk);
+	clk_disable_unprepare(rng_clk);
 }
 
 static const struct amba_id nmk_rng_ids[] = {
-- 
2.17.1

