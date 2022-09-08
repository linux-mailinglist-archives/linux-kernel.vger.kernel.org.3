Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524EA5B11C8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 03:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbiIHBEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 21:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbiIHBEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 21:04:40 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB3213D45;
        Wed,  7 Sep 2022 18:04:33 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 202so15181468pgc.8;
        Wed, 07 Sep 2022 18:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=wNKiIid70ddO5HK7Kf/HL/uTDbI5S7VTuQvBJHoq9wc=;
        b=mcugKyjTjiCh+od+vys0XWknuhXh88Wkz66hdlWHJjJOsaVY4Bn51h+iIWSTD580kU
         U6QVQ4MrUGeytrjE5I4DTXVnbQ9mzIqfBOfcgw3bOAo10anMot3Xbbcq/ZFPIVwWkXPB
         RXvND8jYuVwcrw223A2jndqikzIBplfM2KtkLaMnKjVQ9MQVSPPPhWG/Y/nFYglbBvQb
         pJRu06waAikSHBbcsu9C/iB8FWn8uR1mLRD10hPuWE93ALVJkp2F4S2QDsVZdFU5byns
         e8/1PdQhVeTUJ/WM4isqtZyy/W0qdMToOGCQn7fqSX1uH6ffXoqN7En2obzIxy3zo99N
         o5Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=wNKiIid70ddO5HK7Kf/HL/uTDbI5S7VTuQvBJHoq9wc=;
        b=UmfgDQrOorNEzl/RQOfuB1PNpJTDpEk/vZ72TsCelTIJo6FRKjfFGzycL8U/IJozbv
         BjoeuegRnPQdrb8Uyv8p68S45pN2Wu8lsCucWKYBpf8Y5qDDzJyyVsM3nYINtsoQcxtQ
         QqrzWFpHqf5uacYyDobZA5oreHSyuddATYer0MGYoznWil4ZQ44v/0bhnH04Y0sYs6et
         Xl6mCEwwuROXFx81DQxHe0Nf4z7igJeTCGsCm4MggtjcZZmq6WJ5zf/+pqUIJlcA7e+R
         JOJAdbOGUEcURmJTEa6N5tzR56+9pokEle7IhADTpURURTy1T6nWPuQxtEQsqLbr8JOG
         TOcw==
X-Gm-Message-State: ACgBeo2MTs3D9J4mDAuELzjay0yenJ/FkO+5DR7Dv9BZjk0ZKmOexLhB
        Y6tjGkED1fctH4i65LzcRLg=
X-Google-Smtp-Source: AA6agR5hTZ5fXa0kQIbxnENJJayEKkjAi7cx5ZhcoHMGFTbxUvT6uIMq8nUYWe2W+7v8gmPvnU1Tmg==
X-Received: by 2002:a65:6d14:0:b0:41d:5f95:179d with SMTP id bf20-20020a656d14000000b0041d5f95179dmr5525541pgb.580.1662599073511;
        Wed, 07 Sep 2022 18:04:33 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id h3-20020a170902680300b001714fa07b74sm12968624plk.108.2022.09.07.18.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 18:04:33 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] spi: lpspi: Remove the unneeded result variable
Date:   Thu,  8 Sep 2022 01:04:29 +0000
Message-Id: <20220908010429.342875-1-ye.xingchen@zte.com.cn>
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

From: ye xingchen <ye.xingchen@zte.com.cn>

Return the value pm_runtime_force_suspend() directly instead of storing
it in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/spi/spi-fsl-lpspi.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index cbbe8bbef90a..13147377b2d6 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -947,11 +947,8 @@ static int fsl_lpspi_remove(struct platform_device *pdev)
 
 static int __maybe_unused fsl_lpspi_suspend(struct device *dev)
 {
-	int ret;
-
 	pinctrl_pm_select_sleep_state(dev);
-	ret = pm_runtime_force_suspend(dev);
-	return ret;
+	return pm_runtime_force_suspend(dev);
 }
 
 static int __maybe_unused fsl_lpspi_resume(struct device *dev)
-- 
2.25.1
