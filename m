Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D064BCF5F
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 16:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244240AbiBTPQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 10:16:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244126AbiBTPQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 10:16:23 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196F734BA7
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 07:16:02 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id u1so22822359wrg.11
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 07:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s4avYTwyzOebeNnD3c9KYG3x29F/g/qJAaU+xvILJYI=;
        b=CyvN1XIDtWg75xXtJrI6e/JFb+l8W5fc/x1tgXu/uo/QvyxASasB0e/Ucgk5cL22uq
         J4iO65m4myKX0yElNJ1CjsjgFDOflMyuL3xmRq0LsqriZkfb/da21PMaxtEZP598xGUD
         vjehGlzrausTrJIc7Ki6n/FkCN3GmOwxakwYrIilX+u+Ok4Nl+8DOTi+kzhpQrRHXzZ9
         LNARSTjyeUMzFrd0JoInhyg1HaDShd4jxp4htwdBo3aOkNGXn/lwwqL2nlh/rOI9owMe
         KQKIdqrp7q4qruOdpG6p9JT2ZZ08LLNrSHIZbofnparUcKl+Q14tWD/XQ/kRcEasl2GF
         v5mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s4avYTwyzOebeNnD3c9KYG3x29F/g/qJAaU+xvILJYI=;
        b=sRyTzag6N9a3x4utfyUY11UtaYr3solq9fI2c4ZXGtnef6RRRv0ihl9ZTJhkKt5HnW
         kjNyyDC03f80okqpNMxT3jPIGUQNAz7PGwyc69+KxNy06q/Gjw7hOctXjN87tAlZtmlB
         MbxZZscx8ncGSGt/K0IG7+SWFrtuBHoV8nATfxjT6pfV3ppVXcTPmK1gqy+HzMR+KsrH
         aHsRnMSD0HggphUCdFB3S+av9fe0XEwOd9+iMieCknyYnXDt5HU913bS1yw3BN+sDnXD
         c1iyt8objnBeSr8cXBZqsoGZN6xRuLkHmRrtX+DPhEMJmcC9ok3Y4FTiHqcSlZaUFSb0
         MOWw==
X-Gm-Message-State: AOAM530bbXEz3n3+Lj1ZoD3tw5+PkkkFL/uUB3VX3ZeUeD94R/We8oEj
        Rdo2SQThG9QkXeEDl13snTkCYQ==
X-Google-Smtp-Source: ABdhPJzruCjXO7Zg4NObI0xSV/ELqzdIvudg+xrfspTKPluY+yIrtpO5Xi22cw+86bnCaxdV3z9o1Q==
X-Received: by 2002:adf:fb4e:0:b0:1e3:3e66:d5f6 with SMTP id c14-20020adffb4e000000b001e33e66d5f6mr13203959wrs.615.1645370160720;
        Sun, 20 Feb 2022 07:16:00 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id h7sm28687749wru.41.2022.02.20.07.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 07:16:00 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 12/13] mtd: core: Drop duplicate NULL checks around nvmem_unregister()
Date:   Sun, 20 Feb 2022 15:15:26 +0000
Message-Id: <20220220151527.17216-13-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220220151527.17216-1-srinivas.kandagatla@linaro.org>
References: <20220220151527.17216-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Since nvmem_unregister() checks for NULL, no need to repeat in
the caller. Drop duplicate NULL checks.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/mtd/mtdcore.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index eef87b28d6c8..fc6090366684 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -743,8 +743,7 @@ int del_mtd_device(struct mtd_info *mtd)
 		debugfs_remove_recursive(mtd->dbg.dfs_dir);
 
 		/* Try to remove the NVMEM provider */
-		if (mtd->nvmem)
-			nvmem_unregister(mtd->nvmem);
+		nvmem_unregister(mtd->nvmem);
 
 		device_unregister(&mtd->dev);
 
@@ -923,8 +922,7 @@ static int mtd_otp_nvmem_add(struct mtd_info *mtd)
 	return 0;
 
 err:
-	if (mtd->otp_user_nvmem)
-		nvmem_unregister(mtd->otp_user_nvmem);
+	nvmem_unregister(mtd->otp_user_nvmem);
 	return err;
 }
 
@@ -1028,11 +1026,8 @@ int mtd_device_unregister(struct mtd_info *master)
 		memset(&master->reboot_notifier, 0, sizeof(master->reboot_notifier));
 	}
 
-	if (master->otp_user_nvmem)
-		nvmem_unregister(master->otp_user_nvmem);
-
-	if (master->otp_factory_nvmem)
-		nvmem_unregister(master->otp_factory_nvmem);
+	nvmem_unregister(master->otp_user_nvmem);
+	nvmem_unregister(master->otp_factory_nvmem);
 
 	err = del_mtd_partitions(master);
 	if (err)
-- 
2.21.0

