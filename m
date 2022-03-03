Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6264CB477
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 02:57:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbiCCBpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 20:45:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbiCCBph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 20:45:37 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E612D1B60BF;
        Wed,  2 Mar 2022 17:44:52 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id n11so3396454qtk.8;
        Wed, 02 Mar 2022 17:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2lALShrG5RlRyQzYP8HYz1ltaWcC6YOSE434382jSik=;
        b=AHfLukQ8L5IgWu3TtC+euDoaI8JMHRYW5pG/xAT+3Y2qagtp379mkmvHoEYmoS00Jd
         6fNqA1u9CEjIJ1c61c9Td7ZNSeMxTXOD+inF0hP/5f5vsXLczw85UO/tJcUn/Totenqv
         Y81ruuXldGJx9QoEf0ORVAK4L4zY8WjKROmxfUtfxrKugsG6d4W40v7kYKHB+sVkp1Ai
         YLYA6wZtnPLV9jKKbq8SiMVbnWaHH7u/CAXNv8ql5lhcMxt4WvmNowS82X8LMSNaLpZP
         hO4rhivJzemlBIYznVTjR81MgUcWpPLrDgNqnvSpxQw5pRK9t6w0etkTbiJKb8QfOfSK
         xYMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2lALShrG5RlRyQzYP8HYz1ltaWcC6YOSE434382jSik=;
        b=a0kSMKji/5fyc67Iz37ok7lTi81mqQAfWzriORrpzUBXnqrxbRrGEvdcbyNZ8RpydW
         qxn+YbqS62Hc5e/B9kiMYJqnsjxJwLiLibcV6dV1fu53bD4M1e7qxr8aReTtzRCK7kQ+
         nrO45ea4SPYdBoTp6SLjn9j14jlbeKeuSO3WSWjtDcDcDLj7KTl3/90Zvs30kJv1kBYc
         KMSzVl+mBZ5D9c+u6syhubDibGo2E+JkETqaYByNNr5Gm5XFTEKyLKKW9gjFzjWKrf/q
         EAnqwtlSZgyKVQGfJHWlvUqxcYMRvyM7Mbpv1YTC2vzZ/ElYfHl6xcbS8LqUAc7ebULw
         l65A==
X-Gm-Message-State: AOAM533tVHIBKPjRLmbThwMtLyVdNV6u3kiswMHSAqEVlrtgyr72Aasc
        t7K/h+Ih/7VS3MGoLSruBUY=
X-Google-Smtp-Source: ABdhPJwjRZtpAMgc2peRXFSfN5eGwNeknli9RFBbBAeDq5oXMxbyUtWyHDb35n22lckGuwSdO92tdQ==
X-Received: by 2002:ac8:5d49:0:b0:2df:f30e:3fb5 with SMTP id g9-20020ac85d49000000b002dff30e3fb5mr20254433qtx.118.1646271891942;
        Wed, 02 Mar 2022 17:44:51 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id g202-20020a379dd3000000b0064932a7b992sm396739qke.98.2022.03.02.17.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 17:44:51 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     jic23@kernel.org
Cc:     lars@metafoo.de, tangbin@cmss.chinamobile.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] iio/adc: Use of_device_get_match_data()
Date:   Thu,  3 Mar 2022 01:44:45 +0000
Message-Id: <20220303014445.2059205-1-chi.minghao@zte.com.cn>
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

