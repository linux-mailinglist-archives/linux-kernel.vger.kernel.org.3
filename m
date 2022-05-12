Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5FA524772
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 09:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351253AbiELHyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 03:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351247AbiELHyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 03:54:12 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2623745067;
        Thu, 12 May 2022 00:54:09 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id a191so3906306pge.2;
        Thu, 12 May 2022 00:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yd+3K9O+oKYKp4WQzjdXzUWrrw6l9PVvVvltLhrauLs=;
        b=ViUCmgCCHkSV5PoG+pLqBqDboIl56NMsQMHnGs1OFApJRIU5j7lVaM9KzdUM/lbrf+
         R/2r8amIfMZ1S7mzhk092MUZkqMQVpzw3zk35QrF/QdP05Mpnqaeng43TOjs7Y+FNoGy
         h9JuTIYZsLt/0X8m7Xwq6Bd9bjzdqcpkEDbxztGii3r0uhG4/8ahaDmb72OUlLGAkslq
         Ee3KjM9ZeCtYYjBxZOLPv8s3A6JTKHv1Dy3jUyLXUW5d+eRYUZmyh91/KYV8SxtTl+Qn
         vRkreBaZ3NEH9QsHeLoBYwuQk37NRatny9DAiEViXV61kJiTObjyqhS2L5+WlksT9GLD
         UCrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yd+3K9O+oKYKp4WQzjdXzUWrrw6l9PVvVvltLhrauLs=;
        b=PDVU9TwHjv0bkYBkb5SRW18ZmvEJwQZcbvIUuLFgB7I8vWD6bqw1aDLuZOkFVSydHI
         cUdoqhyOLYWSwgvgFJuBcC0iIazJkgSoWtg4/bORUSjXtSTd0iPRC55PFnrbmwvEmWuD
         y0EkI+jl+Le8d49zqWYwOcDC3kNz6xZXeAHKjiL1XmPJ4dWw/eh4YsDmHHo4Yf9UtK9k
         RSva9giIqHwTgdB5c7TefKxA0rb83R/zR1/atD7Ml6K7xZjpZPUUNfVBFoNN7rA0tmmR
         EvZTZkoqCWd/B+0c5nSCPDM1LW00s+7/zrxaq3tT1pqNTIiYTTjwLYBTmDD+0Ovz1Pac
         /SEQ==
X-Gm-Message-State: AOAM531RlvRZy/QY3ZvsNffZ45OCbgcklOOqHlEvS9loSZr1SCjCyXLt
        qDf0/jTVfreZtrUVUPYjXkI=
X-Google-Smtp-Source: ABdhPJz8VQ+OjBnv7xShYfiFs0wTHFpiKtpfT3DpIdoDxbiJWwxorpuDk8XDlyi+rGH16tlwiYQSPg==
X-Received: by 2002:a63:2103:0:b0:3d5:dff1:30e1 with SMTP id h3-20020a632103000000b003d5dff130e1mr10258223pgh.376.1652342048591;
        Thu, 12 May 2022 00:54:08 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id t9-20020a1709028c8900b0015e8d4eb271sm3183874plo.187.2022.05.12.00.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 00:54:08 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH v2] leds: netxbig: Fix refcount leak in netxbig_leds_get_of_pdata
Date:   Thu, 12 May 2022 11:54:00 +0400
Message-Id: <20220512075400.18269-1-linmq006@gmail.com>
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
Changes in v2:
- call of_node_put() right after of_find_device_by_node() to clean code.
v1 link: https://lore.kernel.org/all/20220512050253.8987-1-linmq006@gmail.com/
---
 drivers/leds/leds-netxbig.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/leds/leds-netxbig.c b/drivers/leds/leds-netxbig.c
index 77213b79f84d..bf9e51aa9d84 100644
--- a/drivers/leds/leds-netxbig.c
+++ b/drivers/leds/leds-netxbig.c
@@ -439,6 +439,7 @@ static int netxbig_leds_get_of_pdata(struct device *dev,
 		return -EINVAL;
 	}
 	gpio_ext_pdev = of_find_device_by_node(gpio_ext_np);
+	of_node_put(gpio_ext_np);
 	if (!gpio_ext_pdev) {
 		dev_err(dev, "Failed to find platform device for gpio-ext\n");
 		return -ENODEV;
@@ -447,12 +448,10 @@ static int netxbig_leds_get_of_pdata(struct device *dev,
 
 	gpio_ext = devm_kzalloc(dev, sizeof(*gpio_ext), GFP_KERNEL);
 	if (!gpio_ext) {
-		of_node_put(gpio_ext_np);
 		ret = -ENOMEM;
 		goto put_device;
 	}
 	ret = netxbig_gpio_ext_get(dev, gpio_ext_dev, gpio_ext);
-	of_node_put(gpio_ext_np);
 	if (ret)
 		goto put_device;
 	pdata->gpio_ext = gpio_ext;
-- 
2.25.1

