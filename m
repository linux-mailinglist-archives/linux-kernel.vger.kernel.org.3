Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49F3C48FAE3
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 06:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbiAPFin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 00:38:43 -0500
Received: from out162-62-57-49.mail.qq.com ([162.62.57.49]:42887 "EHLO
        out162-62-57-49.mail.qq.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230025AbiAPFim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 00:38:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1642311518;
        bh=+2LM+SczSHz+FBaJcHC0eWw+7fFZDut/nzx8cE5g3Pk=;
        h=From:To:Cc:Subject:Date;
        b=VSuZ6Lm9lVKqRAtYVEGd9PLPR/3N6t9Jl7cfxXy/UMynaolXSXNWf8BzoS18dJ+ve
         2ZRo21jnY9cRCRCEiaL2qCbeCqh0ujnbmrQhbRg+pXi3juMaCYdUxrhI63dBH9OBJL
         snd+VVHuBqwcnU6ky77oSZ8Zn2Atccg9D48LzTRg=
Received: from localhost.localdomain ([43.227.138.48])
        by newxmesmtplogicsvrsza5.qq.com (NewEsmtp) with SMTP
        id 95A2BC55; Sun, 16 Jan 2022 13:37:26 +0800
X-QQ-mid: xmsmtpt1642311446t2njfay55
Message-ID: <tencent_0F8E090AA07050A5857F1E9067E6B9DC0C07@qq.com>
X-QQ-XMAILINFO: M2QCdMyLnance75j6VAMOjid3HELJLkG+ubJAjKE+y0IN++DdWHdBUo2HQYWpq
         0VqaMvpWwH20Bq+IPHzje/7EdgUClL6em9eqXg2n+kRXNddGGIe8zmhhmG/X+5hS0Bdd04EXfb6L
         ZLjJ9lsB9ZsZ8qKiKO8iW+uHY/BfRsdy9GulwrUcDxWrzXyAaOwuGbsS5M7OXtOOmAk0kDCi6ita
         /M4t4EFRqgxLKPzUZ0beuIayLrOPF0iDH/5nTRz7XAc/FK8+25raUX5VEnAojqFKD14NlG1qJU8l
         eCD2q4gkzYQ1wEuoSC7VWiJNXpcTB5zfJ8dofyyHLWk4cKG6UrayPxnZAkyzHnr3QcVfH903xuj7
         4kOLs+8pOTWD6ZRiluXQTpHepEORMX8CVCxuFFO1AOFW0qQx70C0196nzVmkwnm3MNfECaNOLy1L
         aQjoxwmHBW2Z1PHrJxIS21R/jCpvPIxXXoewYitM29tnv0KGKF8oAVplMu6aG3ywKxdQzTL8+erK
         O2x8vGz7N11LWAf2wfyMnQnyMd0DedEGX2olzYHIvtyn6heIYAYlCNhPhCbwQtYR7koFu6MyZ+vY
         hhnf7T7vv0e7NeTqMbHN7nI89pMfbMeASoL+NHunqUsrYjYPJbsyvKpeQW9y2l1/BrN5CCy+GvRr
         S0VSML1r1K133nq+Z2j36zWQhmSoNWGSKJ9MKod3hIsmdCTp6VLQHBBErBheHt3Oo5qNpO9XFrrI
         JEH9G1rOmnlEEcqv9d3bUaoG0rz9FBdE1vupzKo0wh0C4VCfe8BbV69LtENCXcZmDKxuAS8YSHN3
         UbbMhe9XYvP5VynaJ89PL1p3VKqXH8K/NERnF/eGOSSnMwG1n6QUd6ltKumTHroWQCbQTm+KNLI3
         l4vFXqM7XpHXylRkTjVxGYjHa0mOXhRigOlCkRMiqJMCx8GDBDvTjHZk7kB/g7DQ==
From:   xkernel.wang@foxmail.com
To:     srinivas.kandagatla@linaro.org, narmstrong@baylibre.com,
        khilman@baylibre.com
Cc:     jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH] nvmem: meson-mx-efuse: check the return value of devm_kstrdup()
Date:   Sun, 16 Jan 2022 13:34:50 +0800
X-OQ-MSGID: <20220116053450.2440-1-xkernel.wang@foxmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaoke Wang <xkernel.wang@foxmail.com>

devm_kstrdup() returns pointer to allocated string on success,
NULL on failure. So it is better to check the return value of it.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
 drivers/nvmem/meson-mx-efuse.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvmem/meson-mx-efuse.c b/drivers/nvmem/meson-mx-efuse.c
index 07c9f38..38e6a5f 100644
--- a/drivers/nvmem/meson-mx-efuse.c
+++ b/drivers/nvmem/meson-mx-efuse.c
@@ -211,6 +211,9 @@ static int meson_mx_efuse_probe(struct platform_device *pdev)
 
 	efuse->config.name = devm_kstrdup(&pdev->dev, drvdata->name,
 					  GFP_KERNEL);
+	if (!efuse->config.name)
+		return -ENOMEM;
+
 	efuse->config.owner = THIS_MODULE;
 	efuse->config.dev = &pdev->dev;
 	efuse->config.priv = efuse;
-- 
