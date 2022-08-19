Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD01F599504
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 08:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346787AbiHSGJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 02:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346634AbiHSGJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 02:09:03 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675AE24BD7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 23:08:30 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id i14so6977916ejg.6
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 23:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=nqYvJwkPyhGWw+zs1FTUvC87NAtZOXSQ3RqOerl0RrE=;
        b=fiuYIZZteuYPevbr1jm85MKPd5CH4K37Lu4s75kvjuumhqQNFhJ070aTDxlo8rddZH
         i+SLkKBHFRU3yeK8DOPjK8gtAyWibQEuXvJ8eP9IHSg/vRac7WgRAymuwe9+ZobzdLFN
         PxR14UjJQUSwykQ7XL3yHLtQ4vIhSNDABxzAuHo0Xmno3tATOenqwGlRgr3r4XJhrefO
         D77YhaODhrbxs5QaR/3iE+LF0FPSh9Ss0hm+76qlQi4ZO1yohXeMcT2tciZbP4zjCTWi
         ITu0PHFBTopfTT6ON3pqalPDv/DMSFxCS4bqvqWVeoQK7zX6Pur+EiSUCX6SB3Idc4bs
         hj3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=nqYvJwkPyhGWw+zs1FTUvC87NAtZOXSQ3RqOerl0RrE=;
        b=GDZaU947nwywFIEBeyezAm0vOkAcqhtKBBd9rdp1/9plyz8RDbFPHYKpD7F01BhBpS
         L3ScGaMrtyFntTuRW8qeA4qAJK7j+cGoX4G6hJaPgubqE3BxqsA/zurXzUnyMnnQuyq9
         j1hcVoAWHxhKvzB+dHsRj8jEoIB1zq+Xzc2rZN249MzQnryYYk/lyQIpuKIlo/SktBbV
         6Yxr11aapeZSqJBioodiQSr2KAooycQwM+4ke++AogqJsoFsNnrdiT4sESKrLG/frNB+
         JbCPUlr+Ge/+AOsmyKfA3tRto2HSkTd6lBiyyf0j6CxH4Bhmv/czlxyAAePzLONrZ+D9
         0tzA==
X-Gm-Message-State: ACgBeo1Gj8OYpF8g3XJaeV22pxWf+8I1AhBfOmtTZfD7mSunSewaGpEp
        OqHSYz5vh9zjBoM5cQHYuSjSrdUO6fQllH35
X-Google-Smtp-Source: AA6agR63MvipYuGx9P2SlYQNDL6T8+iUmE8z45ilOguyJ5frm1741Qd6zDL+S52D+AlEU7kMb3PpMg==
X-Received: by 2002:a17:907:7628:b0:730:b755:4414 with SMTP id jy8-20020a170907762800b00730b7554414mr3907267ejc.11.1660889310244;
        Thu, 18 Aug 2022 23:08:30 -0700 (PDT)
Received: from lb02065.fritz.box ([2001:9e8:143b:fd00:5207:8c7f:747a:b80d])
        by smtp.gmail.com with ESMTPSA id y14-20020a1709063a8e00b0073a644ef803sm1809660ejd.101.2022.08.18.23.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 23:08:28 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH v1 17/19] mmc: meson-mx-sdhc: Fix error check for dma_map_sg
Date:   Fri, 19 Aug 2022 08:07:59 +0200
Message-Id: <20220819060801.10443-18-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220819060801.10443-1-jinpu.wang@ionos.com>
References: <20220819060801.10443-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dma_map_sg return 0 on error.

Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-amlogic@lists.infradead.org
Cc: linux-kernel@vger.kernel.org

Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/mmc/host/meson-mx-sdhc-mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/meson-mx-sdhc-mmc.c b/drivers/mmc/host/meson-mx-sdhc-mmc.c
index e92e63cb5641..b32364f20c32 100644
--- a/drivers/mmc/host/meson-mx-sdhc-mmc.c
+++ b/drivers/mmc/host/meson-mx-sdhc-mmc.c
@@ -388,7 +388,7 @@ static int meson_mx_sdhc_map_dma(struct mmc_host *mmc, struct mmc_request *mrq)
 
 	dma_len = dma_map_sg(mmc_dev(mmc), data->sg, data->sg_len,
 			     mmc_get_dma_dir(data));
-	if (dma_len <= 0) {
+	if (!dma_len) {
 		dev_err(mmc_dev(mmc), "dma_map_sg failed\n");
 		return -ENOMEM;
 	}
-- 
2.34.1

