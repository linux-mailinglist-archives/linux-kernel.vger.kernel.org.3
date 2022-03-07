Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C51A54D0533
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 18:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244440AbiCGR3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 12:29:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239259AbiCGR3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 12:29:13 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC3424F22
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 09:28:17 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id e24so11499093wrc.10
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 09:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0aca7PGM0OOt+s62Ger5VE4L2FTdXu/cKWB3mcPl5eE=;
        b=lN4C898iF5MAu5mIrpBWdhJL/mKXDLwX1pry3EKlOp6dNCizRjdyFJpQ89vzDtu4mE
         nSaecph5oJbQ7VrMnP5hTd5UDkK828WrNfuMWi/scr40bCuxIwOVOufaZ0WDyLtxEjSq
         N6jW7qHuP++Jy2zmTD8UPJ+xhxT0WE7Lux9R89jxtZUBslVJSxHICZ/RkCokFpF5FF/8
         fFPthTmohNSSZByIV+o9knKDQluUhN5tA/b1OOhBQuWDwLV5qsG/jYwyHm0sDW7P4rfi
         2757GF+tZYrofXZYXI7zgqIZ4d4JIECmYng5c0k1lYGDXU2cjv0NptjFjjKXLyX49ISj
         TF+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0aca7PGM0OOt+s62Ger5VE4L2FTdXu/cKWB3mcPl5eE=;
        b=MfHObftqoHNsmBrJO4QjepTEG2CU3Ne4pvNPlITdtQSAgFQJGY+0NzMehp7sE7TzUS
         KJNBo9FZiUcKCWSMET1Dk2CBzVgM0SWkZq60DZlmue8GOv7bfWWwxgykAtGjB7u4AgrW
         GqbCAefzD/atZmNsNrW65uFcpV+2hX7TcsG8wa2r383daX2i4UajRHRQrE1tDoVjhGWd
         s6WP2QoYr61SWoNrcVpXzEIKdiAezJ7gHKKmkkJAfbPvrXJ/BjN2hQhxD+DaTRTkrWVD
         lFh4o1VdRw8JrkbHA3L6SbrLGvL3k4HISVo6lcZnwLWP3vM6/+hOL2M8zwUaXFtyD3Fe
         NOhw==
X-Gm-Message-State: AOAM531JiMVUc195vbacpN38I4042nTbup00/IqgidUt8eLV+CV9sGLQ
        OsM3h/W6dXbHGGBOPIJUVoRWOA==
X-Google-Smtp-Source: ABdhPJz9WSJ2ss2LCkhOIeZgkhsc9+1FYaepo+0UFPPw3eoqCL66Yhu3k/icBuzrslz//AZhQZvc6Q==
X-Received: by 2002:a05:6000:18a5:b0:1eb:93a3:ebcb with SMTP id b5-20020a05600018a500b001eb93a3ebcbmr8985257wri.291.1646674096265;
        Mon, 07 Mar 2022 09:28:16 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id m128-20020a1ca386000000b003898b148bf0sm8775191wme.20.2022.03.07.09.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 09:28:15 -0800 (PST)
From:   Guillaume Ranquet <granquet@baylibre.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] clocksource/drivers/timer-of: check return value of of_iomap in timer_of_base_init()
Date:   Mon,  7 Mar 2022 18:26:56 +0100
Message-Id: <20220307172656.4836-1-granquet@baylibre.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_base->base can either be iomapped using of_io_request_and_map() or
of_iomap() depending whether or not an of_base->name has been set.

Thus check of_base->base against NULL as of_iomap() does not return a
PTR_ERR() in case of error.

Fixes: 9aea417afa6b ("clocksource/drivers/timer-of: Don't request the resource by name")
Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
---
 drivers/clocksource/timer-of.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/timer-of.c b/drivers/clocksource/timer-of.c
index 529cc6a51cdb3..c3f54d9912be7 100644
--- a/drivers/clocksource/timer-of.c
+++ b/drivers/clocksource/timer-of.c
@@ -157,9 +157,9 @@ static __init int timer_of_base_init(struct device_node *np,
 	of_base->base = of_base->name ?
 		of_io_request_and_map(np, of_base->index, of_base->name) :
 		of_iomap(np, of_base->index);
-	if (IS_ERR(of_base->base)) {
-		pr_err("Failed to iomap (%s)\n", of_base->name);
-		return PTR_ERR(of_base->base);
+	if (IS_ERR_OR_NULL(of_base->base)) {
+		pr_err("Failed to iomap (%s:%s)\n", np->name, of_base->name);
+		return of_base->base ? PTR_ERR(of_base->base) : -ENOMEM;
 	}
 
 	return 0;
-- 
2.34.1

