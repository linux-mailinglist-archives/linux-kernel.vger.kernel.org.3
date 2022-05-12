Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA205244A5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 07:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348840AbiELFDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 01:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236899AbiELFDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 01:03:02 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C5C134826;
        Wed, 11 May 2022 22:03:01 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id c11so3804552plg.13;
        Wed, 11 May 2022 22:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xbcrdAwKj+Ij54Ml9ka4/NdqN5N/T+xmKnU7uRGQyRI=;
        b=fOAe+jfDANq0AupJtVi1gfIbeV196nhTZWRsb63ZsWljYAeHMBP++onf83uk/3oPYZ
         TFqKqxVYJRpuEkobS6iVlwwWiInrrPnPyGu3FvlPWlTTke1dW1UwijYeptL0PM5N/0uT
         Yrp1r2H/DeTjL+D9f/dmk8RrZBLPvTbxigiHPbNM7o8D5ewzY2doCcU3KNNWxoNjx3Vk
         5GFStz1DY7ct3z0ZuGbNtT79PgQva3JSywym8D+RJ2afFR2qsjnMWRG31kE8oFeqSFkG
         iJ3NNnafghl4fvpHaAzN5kt+jevwF1QU7vmyzKn7fi51zmvAPrAx4HnNyRYJIUQdPM0H
         BeKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xbcrdAwKj+Ij54Ml9ka4/NdqN5N/T+xmKnU7uRGQyRI=;
        b=74IzJDRX1YDMybyUJickwEU6dn7iE+Rw0mrxw0OoJH2LW1WL1aOQ+5r+NmxJzoeMkr
         7Zpb4BkOUtXJpBxcUDR7INCm7537I0WR98RhYg5dZ9I4ySTrf9hNVF0Er9b/BQuvoUg1
         SKJBm9/zAx0nIgHPJz+4WE2neKmf90941/bGYe5IoZDvvxYDZboX6yO07axlBb0lw31s
         ilxjomLk5BxmvelJIxdp4KBnUPq8YF9L16NjRzV28KX9dBnZ9rib0ego/vDz29657ICe
         Jv/bR7Wfcy72j42mN5xu2g8/uia/5ofaK4WouLhzURFJ1GLUfb4xxgIuw6EQFf7vfoVE
         ZSWA==
X-Gm-Message-State: AOAM533FvcZM5g2oCOzNEXfaTMFHpUe3HGy/JRHveJlKP3y6qRt0jUlp
        Od8yol8GwN92VuvGgAPpwKs=
X-Google-Smtp-Source: ABdhPJzO8d0Zbjp/afNVaVm72C1DkLqXQSapP81yK0gNOkijQqnDeub7nX6jY/tlh6bxYktA64lA0w==
X-Received: by 2002:a17:90b:380f:b0:1dc:596c:bb0 with SMTP id mq15-20020a17090b380f00b001dc596c0bb0mr9083088pjb.212.1652331781075;
        Wed, 11 May 2022 22:03:01 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id u85-20020a627958000000b0050dc7628178sm2671782pfc.82.2022.05.11.22.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 22:03:00 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] leds: netxbig: Fix refcount leak in netxbig_leds_get_of_pdata
Date:   Thu, 12 May 2022 09:02:53 +0400
Message-Id: <20220512050253.8987-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_parse_phandle() returns a node pointer with refcount
incremented, we should use of_node_put() on it when not needed anymore.
When of_find_device_by_node() fails, of_node_put() is missing.

Fixes: 9af512e81964 ("leds: netxbig: Convert to use GPIO descriptors")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/leds/leds-netxbig.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/leds/leds-netxbig.c b/drivers/leds/leds-netxbig.c
index 77213b79f84d..ceb046500469 100644
--- a/drivers/leds/leds-netxbig.c
+++ b/drivers/leds/leds-netxbig.c
@@ -441,6 +441,7 @@ static int netxbig_leds_get_of_pdata(struct device *dev,
 	gpio_ext_pdev = of_find_device_by_node(gpio_ext_np);
 	if (!gpio_ext_pdev) {
 		dev_err(dev, "Failed to find platform device for gpio-ext\n");
+		of_node_put(gpio_ext_np);
 		return -ENODEV;
 	}
 	gpio_ext_dev = &gpio_ext_pdev->dev;
-- 
2.25.1

