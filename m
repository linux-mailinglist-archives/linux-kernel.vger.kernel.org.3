Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7612488E06
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 02:27:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233039AbiAJB1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 20:27:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232997AbiAJB1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 20:27:37 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885B7C06173F;
        Sun,  9 Jan 2022 17:27:37 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id t32so9847143pgm.7;
        Sun, 09 Jan 2022 17:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LDv7JMCajTvWRkb9oFZfffvF391JQT3ctnygAtOuA/o=;
        b=dXoKh26tcSdTAyYOWNnKHM5TpbnNqAkcI5eG1P+H1rUm5oeIgoDzJg1EP6Nvbwa3Dl
         gbOWYfb2Dl0ONP5xFeZKER1ZCYQ/6n1PRlvxUofJtsZH25YDr4dk+4abeBnxh0NzS76l
         fF9tK5h8mu4lzuIUW0TaG3b6Oah/I7N8OcdGaQ/c4JxnxNLtkDDnuJiqGiE+RL8/66S0
         524l88aCixFfP2QUGrj8Au3DsEnUNEw+m6byrvTM1Xcbi6XahojIu/cbKwJMZwLENIEO
         18jmvZwAzxJ9yM6OFRB6lEwObNEyMzG6Y3olkUbV1PnZqGRiMc5Aq8JucQQXLy/6wA8Y
         AeDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LDv7JMCajTvWRkb9oFZfffvF391JQT3ctnygAtOuA/o=;
        b=OmjrgDhv0bw66DtIYKy1P5DYGCR4oyuP5ku4VDRZZqbU+iR17H3ee+jD0QbuLRw7DJ
         sXdUGFmTMCZqG8kMrY51Sis1kx6nc286NTQtJA/b5f96ayLVepi+MTAL94ZNKn4jZJKm
         VGqIyL4jY42w/50oUX0oI7UYD9tgzqq6KS+VegcuwCsrq+f19tDrLcTJiEfHJkh5c27l
         Vjt15IrIDEh05coGRjyKAJgKMzMS3ounQxkujfgr4NzdWxInDKE2gFqtRjbj5UQ0M0H/
         0H66VMFGBIKt1izy5KBf0NRaGCGilEQgMkyf2xJfFJQu+BzBWgflAIDZSH68HMLN60p4
         M9kA==
X-Gm-Message-State: AOAM530W1SsN7HKz5zJcWRal3pQv0NbhYo9ZYlBJzRJzjsbA/hzuYP9k
        c5ofSeGYX/IDgno6XJH48T8=
X-Google-Smtp-Source: ABdhPJxloiE8/GN/bTThNxMFmfapFD0iuw8ohgqbsEZZnQGfUQRgEAwUBjUDoiYUVEaO2t3Vcp0+zw==
X-Received: by 2002:a63:368f:: with SMTP id d137mr2773216pga.0.1641778057157;
        Sun, 09 Jan 2022 17:27:37 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id z7sm3908869pgs.4.2022.01.09.17.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jan 2022 17:27:36 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     daniel@zonque.org
Cc:     haojian.zhuang@gmail.com, robert.jarzmik@free.fr,
        linus.walleij@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>, CGEL ZTE <cgel.zte@gmail.com>
Subject: [PATCH] drivers/pinctrl: remove redundant ret variable
Date:   Mon, 10 Jan 2022 01:27:30 +0000
Message-Id: <20220110012730.643927-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

Return value from pxa2xx_pinctrl_init() directly instead
of taking this in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
Signed-off-by: CGEL ZTE <cgel.zte@gmail.com>
---
 drivers/pinctrl/pxa/pinctrl-pxa27x.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/pxa/pinctrl-pxa27x.c b/drivers/pinctrl/pxa/pinctrl-pxa27x.c
index 48ccfb50b23e..ff9302e4803a 100644
--- a/drivers/pinctrl/pxa/pinctrl-pxa27x.c
+++ b/drivers/pinctrl/pxa/pinctrl-pxa27x.c
@@ -504,7 +504,7 @@ static const struct pxa_desc_pin pxa27x_pins[] = {
 
 static int pxa27x_pinctrl_probe(struct platform_device *pdev)
 {
-	int ret, i;
+	int i;
 	void __iomem *base_af[8];
 	void __iomem *base_dir[4];
 	void __iomem *base_sleep[4];
@@ -532,9 +532,8 @@ static int pxa27x_pinctrl_probe(struct platform_device *pdev)
 	for (i = 0; i < ARRAY_SIZE(base_sleep); i++)
 		base_sleep[i] = base_sleep[0] + sizeof(base_af[0]) * i;
 
-	ret = pxa2xx_pinctrl_init(pdev, pxa27x_pins, ARRAY_SIZE(pxa27x_pins),
+	return pxa2xx_pinctrl_init(pdev, pxa27x_pins, ARRAY_SIZE(pxa27x_pins),
 				  base_af, base_dir, base_sleep);
-	return ret;
 }
 
 static const struct of_device_id pxa27x_pinctrl_match[] = {
-- 
2.25.1

