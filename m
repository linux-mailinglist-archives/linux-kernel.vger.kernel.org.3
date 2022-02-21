Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88C064BD387
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 03:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245424AbiBUCDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 21:03:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243379AbiBUCDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 21:03:03 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931BC3616C;
        Sun, 20 Feb 2022 18:02:40 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id d3so28178365qvb.5;
        Sun, 20 Feb 2022 18:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=14IQKnabNvgR8OGguYfeWyTOnUwjGU/hNLskrhkJteI=;
        b=IM4WFO1f7PBtcR378aivGGEwaqWijHGOAgpnr3H/EvLjnRBKLipbqBsExLG1HKyrUl
         Oxw0AfzdZqg6bPYwakKZ7EDHVGARIhAJxVsC0X6omqQwQZ32NYWeYcWZJyzvhMZ39ZlD
         fzbUBhw0gvUQJT5KyX0Z2PUXKKmURIRHUHiph5+nSe/F+ZY1lyKSyKk4kWKdWZDiLv/R
         ofSQtnpE6zviQ7eSF/ljy55rfd/yZGWnnAOQWVcMu4L2DZwHW8nFCEjEnvCLyazhXS97
         ZHGlDfBEAafRHt5KRduImcMq6pLo2nRBJTJctdmN90juyUBKH+1/8nc4/jS6XEPMaQ25
         A5jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=14IQKnabNvgR8OGguYfeWyTOnUwjGU/hNLskrhkJteI=;
        b=sDqVb+Z72rFlsvCL24euKu4Aafkky01wOjAH4QT+SMIe3fbz2/XnlAk/egTGcGRklT
         kyYCRYmfiLiBHO4gOq0HBSCsEEsj1MgV2NrhnwZPFFfWpA9IRaCyFXoMvnksIyKN2Vzq
         hxKNkIqKUQy3LE5zgGEKmQkvvLPY2m70hYCk0o5n6RQyKVGR0B7RFNynvBEmKkeN94jQ
         hw5HeTNXgGTS8Gol4lAQL2Qxuht0K2an9T3RCQ7bH2dsSHk+8hT4yn+dElAmi+rWGfx5
         r7cngoPHz+HStqgOU6D7Y6Tm9b569RILqm14nq/LgsUFg99V4FMWdfOddQLpjnBk4CY8
         xAOw==
X-Gm-Message-State: AOAM533p2cg8/rKWu7VfjomyWUUMuoEGa6VEKed2kaEZcvA9EATJATjt
        B6R7aGow09zXrpL2wDcVyEhFR6I+zbo=
X-Google-Smtp-Source: ABdhPJxo5/FT93J5O3ATvQALQR7wQMHOnuH9e4eNnHjjC8eas+70TLBGYq9eKKEIJM8lo+14Y0CWOQ==
X-Received: by 2002:ac8:598f:0:b0:2d2:2e55:d914 with SMTP id e15-20020ac8598f000000b002d22e55d914mr16000951qte.204.1645408959766;
        Sun, 20 Feb 2022 18:02:39 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id g24sm25917079qkk.1.2022.02.20.18.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 18:02:39 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Minghao Chi (CGEL ZTE)" <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] drivers/spi: Use of_device_get_match_data()
Date:   Mon, 21 Feb 2022 02:02:33 +0000
Message-Id: <20220221020233.1925154-1-chi.minghao@zte.com.cn>
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

From: "Minghao Chi (CGEL ZTE)" <chi.minghao@zte.com.cn>

Use of_device_get_match_data() to simplify the code.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>
---
 drivers/spi/spi-lantiq-ssc.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/spi/spi-lantiq-ssc.c b/drivers/spi/spi-lantiq-ssc.c
index bcb52601804a..aae26f62ea87 100644
--- a/drivers/spi/spi-lantiq-ssc.c
+++ b/drivers/spi/spi-lantiq-ssc.c
@@ -906,17 +906,11 @@ static int lantiq_ssc_probe(struct platform_device *pdev)
 	struct spi_master *master;
 	struct lantiq_ssc_spi *spi;
 	const struct lantiq_ssc_hwcfg *hwcfg;
-	const struct of_device_id *match;
 	u32 id, supports_dma, revision;
 	unsigned int num_cs;
 	int err;
 
-	match = of_match_device(lantiq_ssc_match, dev);
-	if (!match) {
-		dev_err(dev, "no device match\n");
-		return -EINVAL;
-	}
-	hwcfg = match->data;
+	hwcfg = of_device_get_match_data(dev);
 
 	master = spi_alloc_master(dev, sizeof(struct lantiq_ssc_spi));
 	if (!master)
-- 
2.25.1

