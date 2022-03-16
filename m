Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 285BA4DA887
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 03:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353155AbiCPCnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 22:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241292AbiCPCnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 22:43:19 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9BC532E5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 19:42:06 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id f8so1965711pfj.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 19:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id;
        bh=8ioeaOWDbVGBIXTk1/liuZxwNqXWqg046f4+0LKsF84=;
        b=V/ADqYGCGhx5uv9I7YQBHVpCngTc6sPr0ijmHlyN23yq7ax0ofGYgBGNSFTbUNNASx
         yjCW7Ei6O8AywFf45TQsogO/S/0j77w93/AROEqQdn6ds6m8vl7bTVpJMbcH1KVUf5dZ
         Y+sWlMT6pSyZzTNR2qlX1wT9Dc+F0faSFNfTofcYI0gGHzHuNMWG2q1Qqp3BBnLZUGx0
         UUrOuoA+qcnaCDIwo3k5nZZKF9C3+1NWdmuQXEZ3xiQds8tjlcW+KmOU2MGu0zDNiueY
         wgdodNgu8k3OzE061SKJJapxvonkVvmzFYWWHXPu9G37u1CldjI/y6UQGwHsrmWGvX9F
         yAKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=8ioeaOWDbVGBIXTk1/liuZxwNqXWqg046f4+0LKsF84=;
        b=bk9nRwC9rIq3MACYdZSRVZfrYA5Ui5BidJZdAW++H5dyT7m5dYHdSPG/54nR7ZaSko
         kt69SaYjUPFSZRGwD0FYEBzQ69LZp1XeajhPsj/VOdoxviR8QT46RG0tzhlPT7ZpaP4T
         4mmAiZBTIul/CZnVhA9eKrP58pem0AzXSmNkwmgjh/XKLPX/Xp0NtdxUAO3Hp1uWvCme
         MrDPkpXhlxf7avvQbXEjYnvp240Ed8/qqdSgWtrJeNGrOC85DFVzErVCreJqzJar93n6
         FvoOezwFBKS6jo1foMFRm/fQiUMCCcZqjGqvKAYR7aZ92tCdk5cFAgWj5CT1fG0+x8PA
         mWZg==
X-Gm-Message-State: AOAM532/6Gs0fXSFugkeBKahuKcGr3N4wcpWQeeo/hRYl4LIvwsEQ4YC
        LJ0RZblpNlZ3eE4wXE95Lkg=
X-Google-Smtp-Source: ABdhPJzEhV3Hvy6vvvMYGaO8fcwY7zeE2116AnOQGp/Pl0nqBoeJeRk9qsQNHjAMb7kCC8Xf2aN8uQ==
X-Received: by 2002:a62:7c03:0:b0:4f7:6a0:6835 with SMTP id x3-20020a627c03000000b004f706a06835mr31679842pfc.72.1647398526414;
        Tue, 15 Mar 2022 19:42:06 -0700 (PDT)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id v16-20020a056a00149000b004f7ae2cbd3asm517089pfu.166.2022.03.15.19.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 19:42:06 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Liam Beguin <liambeguin@gmail.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Roger Quadros <rogerq@ti.com>, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] phy: ti: omap-usb2: Fix error handling in omap_usb2_enable_clocks
Date:   Wed, 16 Mar 2022 02:41:53 +0000
Message-Id: <20220316024155.23464-1-linmq006@gmail.com>
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

Fixes: ed31ee7cf1fe ("phy: ti: usb2: Fix logic on -EPROBE_DEFER")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/phy/ti/phy-omap-usb2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/ti/phy-omap-usb2.c b/drivers/phy/ti/phy-omap-usb2.c
index 3a505fe5715a..31a775877f6e 100644
--- a/drivers/phy/ti/phy-omap-usb2.c
+++ b/drivers/phy/ti/phy-omap-usb2.c
@@ -215,7 +215,7 @@ static int omap_usb2_enable_clocks(struct omap_usb *phy)
 	return 0;
 
 err1:
-	clk_disable(phy->wkupclk);
+	clk_disable_unprepare(phy->wkupclk);
 
 err0:
 	return ret;
-- 
2.17.1

