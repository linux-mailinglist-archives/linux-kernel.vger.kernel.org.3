Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3702E4C7D75
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 23:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbiB1Wh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 17:37:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiB1WhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 17:37:25 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B4D113AD6;
        Mon, 28 Feb 2022 14:36:46 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id 185so11623838qkh.1;
        Mon, 28 Feb 2022 14:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NqNLCNZbfRzdZ6s+RPZUVSDu53vbe0qWHYGyNkt893E=;
        b=XftIddrMAmhmuVKIlxOi7ezAmFRdps3UDkEEbl2ZeQMGo2H+ELXtV+4e9DhnZAMsyL
         D/pDeeWj49sL9GZwHUnnj7n3RGyrUTegADjvReidPUORqC64NeyziR5G+yT6oAKr6A2d
         Vdk+FWwex1AuVPvENWoJB6Ej44hGNZptg3xEBBphTsCS8U8UUkUxFpOUgebJdUc2qjrN
         ox0phf1gLwEbJqPCbyajU3SIVtC/zaTN1s3koJIojHtROjDUYqV56hheoywgjYgCNSYz
         vxCzJtshV5w34Hu9TntuiYVCrJxoLt0yfBW6VGutDNiE8lv73o7vOn34u0tiBsX6p2Gg
         aRMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NqNLCNZbfRzdZ6s+RPZUVSDu53vbe0qWHYGyNkt893E=;
        b=F0cm/T9jY9h4ZNZBw/vLoF6O2ymLSPe4K7qzX19jVgj9mQ8o5cBg8A5+BHpYsW8P/R
         lXArAcZjE2/nvdb/ghcTH0iG/+KT2ph8scjy30BvWH88ALFCtm003NL5NQne2CcHyone
         WbMpDy4DUOOXKbnbHBlzE9EDt4VpQuPLFmZ+JWtskfmgxl0NiC5nkefzJ3qi9ZpWjWhz
         m6ss4qZxRL2uIML9t0DoxkwN5C6SGupTb76T+npVQ1enf0rB5DeuQeFKsHIHeMvmRcmG
         +Lux2ccucJOUXKd/yDJmeK6TEIglD1wk4kurpToTzy/ih7BHEplI2M6wmucRNFoJR9Ff
         himw==
X-Gm-Message-State: AOAM531SIqqo/IC3Q4WL0cbI/oagBHe3nlo2Mw1yJQoPc/pBw464IbLH
        28suTeHDbBaZuwEBje9VviQ=
X-Google-Smtp-Source: ABdhPJxzocr7KcKfiyTO0gDJ53raBvOlFPXC+nmpx349DwcEXm+eD7Ij9yg7XQVuxFESGg/JvDVyWw==
X-Received: by 2002:a05:620a:45:b0:508:176a:8892 with SMTP id t5-20020a05620a004500b00508176a8892mr12549250qkt.731.1646087805470;
        Mon, 28 Feb 2022 14:36:45 -0800 (PST)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id v9-20020a05622a144900b002dfedb4dccasm6632068qtx.66.2022.02.28.14.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 14:36:45 -0800 (PST)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Peter Geis <pgwipeout@gmail.com>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: host: dw-mmc-rockchip: avoid logspam when cd-broken
Date:   Mon, 28 Feb 2022 17:36:42 -0500
Message-Id: <20220228223642.1136229-1-pgwipeout@gmail.com>
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

The dw_mmc-rockchip driver drops a large amound of logspam constantly
when the cd-broken flag is enabled.
Set the warning to be debug ratelimited in this case.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
 drivers/mmc/host/dw_mmc-rockchip.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
index 95d0ec0f5f3a..d0ebf0afa42a 100644
--- a/drivers/mmc/host/dw_mmc-rockchip.c
+++ b/drivers/mmc/host/dw_mmc-rockchip.c
@@ -50,8 +50,13 @@ static void dw_mci_rk3288_set_ios(struct dw_mci *host, struct mmc_ios *ios)
 		cclkin = ios->clock * RK3288_CLKGEN_DIV;
 
 	ret = clk_set_rate(host->ciu_clk, cclkin);
-	if (ret)
-		dev_warn(host->dev, "failed to set rate %uHz\n", ios->clock);
+	if (ret) {
+		/* this screams when card detection is broken */
+		if (host->slot->mmc->caps & MMC_CAP_NEEDS_POLL)
+			dev_dbg_ratelimited(host->dev, "failed to set rate %uHz\n", ios->clock);
+		else
+			dev_warn(host->dev, "failed to set rate %uHz\n", ios->clock);
+	}
 
 	bus_hz = clk_get_rate(host->ciu_clk) / RK3288_CLKGEN_DIV;
 	if (bus_hz != host->bus_hz) {
-- 
2.25.1

