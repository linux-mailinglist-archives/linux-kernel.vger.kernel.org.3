Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE484CCB80
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 03:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236998AbiCDCAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 21:00:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232535AbiCDCA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 21:00:28 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE9B12168D;
        Thu,  3 Mar 2022 17:59:41 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id b13so5406455qkj.12;
        Thu, 03 Mar 2022 17:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hPxZniYbsdME7IwFNKIAC4U4H+A/bP4PnATkKwGBL9g=;
        b=FR+E635Su1qePwmL2VjYxRW7K8qihJu9NkgOUP9/0BpZzaV2gI0j9+If3EyUwTRkH5
         1cRkhXvR4MmbFNJAInLu5PvrVuQOflv+3zDMwrdNKpQ3FFlv1btIs4NJdDGo+pzt/wMa
         EC5Y89rS58mLFRQ6b6IfvRTp0JHqAIgor8qf70HUVyg7CR/w36MsOa+Eu7yui9ay5i3X
         N7UlJWrIJh9uK60XsSxA8Lh57eXABCqvFFIRWXCb1mLWOclZ8TCTh1FUGF0t24BHSu4y
         GqduVyFFVCSCl+OSQCRLBEz2LM7fnvC9rETT/OHIwKAc2/nvmuCJHVLQP/g7canRPkN1
         SZeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hPxZniYbsdME7IwFNKIAC4U4H+A/bP4PnATkKwGBL9g=;
        b=KD1CM0qul0hopHQz1kN0cATIxIvBDr3bQfPFkkzAs4gRKND3EtweFkDB/4gpc2vxgQ
         Eiu4JcAkFcNdU/iu/OoP1MluNr6Pn7Obn1bg0+3ygTUa58wyNuZZHQzof3i/XO1pzXjd
         aO/HVGSxwAlTNpczM+NU3uSV7Df8VCU+wl7CKtTiAIl1UA36Hls1c92QOP/rs9TuHO80
         ZS7m+kDAgVZUyi34rQ6e/BdPM2OzuH+W6fWRKh7zELFz9gGrnXG2wO33A//bPXJH8pJr
         cJ3hsG8cYIWmrhaEYlnpCU55ZxOvcOVUawaH/GanEQeaCXXLIShlrFljLVXDYkJOo6Wu
         Bs2g==
X-Gm-Message-State: AOAM533gya8KfVsD3KaBe2rQVAZJkmCTbXHp44LYTJmAssaGUmxW60Uc
        8DDbWxWPZ5lYMWk2cKAuB7Q=
X-Google-Smtp-Source: ABdhPJyaNKmVUoEK6j9JEv8+I6Pe+grVQ6B9KPcnMorkG8Er/9o+d4uPDiLE3dpttVFUL0Siu/CTFw==
X-Received: by 2002:a37:bc45:0:b0:47e:292:4b8d with SMTP id m66-20020a37bc45000000b0047e02924b8dmr1295977qkf.484.1646359180557;
        Thu, 03 Mar 2022 17:59:40 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id j18-20020ac85c52000000b002deaca065dfsm2620349qtj.10.2022.03.03.17.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 17:59:40 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     jic23@kernel.org
Cc:     lars@metafoo.de, tangbin@cmss.chinamobile.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] iio:adc:twl6030: Use of_device_get_match_data()
Date:   Fri,  4 Mar 2022 01:59:32 +0000
Message-Id: <20220304015932.2061712-1-chi.minghao@zte.com.cn>
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

From: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>

Use of_device_get_match_data() to simplify the code.

v1->v2:
  iio:adc:->iio:adc:twl6030:

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>
---
 drivers/iio/adc/twl6030-gpadc.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/iio/adc/twl6030-gpadc.c b/drivers/iio/adc/twl6030-gpadc.c
index afdb59e0b526..6a022e583658 100644
--- a/drivers/iio/adc/twl6030-gpadc.c
+++ b/drivers/iio/adc/twl6030-gpadc.c
@@ -867,16 +867,11 @@ static int twl6030_gpadc_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct twl6030_gpadc_data *gpadc;
 	const struct twl6030_gpadc_platform_data *pdata;
-	const struct of_device_id *match;
 	struct iio_dev *indio_dev;
 	int irq;
 	int ret;
 
-	match = of_match_device(of_twl6030_match_tbl, dev);
-	if (!match)
-		return -EINVAL;
-
-	pdata = match->data;
+	pdata = of_device_get_match_data(dev);
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*gpadc));
 	if (!indio_dev)
-- 
2.25.1

