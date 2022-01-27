Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B82A49E3A4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 14:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242037AbiA0Nh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 08:37:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241898AbiA0NfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 08:35:19 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D7AC061762
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 05:33:42 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id e8so4928587wrc.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 05:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wBYBbfKnJeYUc1b/K/sTSN+3xZ7MU+5mXvQbL+YBpf0=;
        b=cvPQcV2+PDwUikYRGtN5buRuUCbCyeHatX24qTROl5cP0nZft/HvlADmJb3FsIMn1f
         fjLp2P9E5DTJISf+1KsyACgSb5gMrobgOnLq5ULTIgPRe/6Hn+WOg5WxW4zfAgwMMFTg
         3/wJnwuKUpAdXO/JcEtYKbV1ImMSu7S+bn0BWxAXKTq9XPcpkjrMriBsW5KPnnpkrq7v
         bJ5n8m/T7+/oc5kiAhuiYqB4gKE4WxMu/ngxO4aSAAYNszNC+jqwBp65Zq4QYWbTHSXs
         EcbsRhQfQJkHf0pmYGfOfxBOYVjzYdrYI7VXZCy6fOFIPKhhB07JjOVREZaxu7GN9fT6
         p6CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wBYBbfKnJeYUc1b/K/sTSN+3xZ7MU+5mXvQbL+YBpf0=;
        b=Qe4UUufQST3axs5RAOkOzqZz8m+oltrsJPDAIXNj3L0ied04iVD53+XRYAnkTCqdVL
         6ORFsL/ZKY/0wIe0bq55CEuIw2lie5qdrICTs8kzv+qzDkFPQGvaAULpvA0ARgDid+5A
         7xVuM3F6QFWjndi7NZKC3laiUEWn2dT/a+PCw/jqcj/FGanf2Sh2v8F898adQZQ3v+Kw
         wqO1X0f+PRuyQsNca7IX9Rv9IXPmethtHjhk5l9NF+Q+uFHBZ75KYqDYoWmqP0EmSwvG
         mPA0ZDSvDvwzqQ92Vs803jYnVyP4UUYiDEN4dsG4npMwFGzsfDvkX6hCT037Oye218tb
         519w==
X-Gm-Message-State: AOAM533RZkLf08I0wVeMrYbrYUIdyteJVwqsavz9Ynp8LXNYJ7NXWKjn
        9bNGZUVz+s87WNvFSA4oQzK0Ng==
X-Google-Smtp-Source: ABdhPJw7/2XzmcS9TsTU/CyIVS/eE4HyfQhTzGPBJzPM3C0dRA1zgz92f00V7ixt0lmnb4l9Fk/cSw==
X-Received: by 2002:a5d:4c81:: with SMTP id z1mr3090423wrs.568.1643290421013;
        Thu, 27 Jan 2022 05:33:41 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id w8sm2173912wrq.3.2022.01.27.05.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 05:33:40 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] crypto: engine: disable BH during completion
Date:   Thu, 27 Jan 2022 13:33:32 +0000
Message-Id: <20220127133332.4011509-1-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When doing iperf over ipsec with crypto hardware sun8i-ce, I hit some
spinlock recursion bug.

This is due to crypto/crypto_engine not disabling BH when calling
completion function.

Fixes: 735d37b5424b ("crypto: engine - Introduce the block request crypto engine framework")
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 crypto/crypto_engine.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/crypto/crypto_engine.c b/crypto/crypto_engine.c
index fb07da9920ee..b3844f6d98a3 100644
--- a/crypto/crypto_engine.c
+++ b/crypto/crypto_engine.c
@@ -7,6 +7,7 @@
  * Author: Baolin Wang <baolin.wang@linaro.org>
  */
 
+#include <linux/bottom_half.h>
 #include <linux/err.h>
 #include <linux/delay.h>
 #include <linux/device.h>
@@ -53,7 +54,9 @@ static void crypto_finalize_request(struct crypto_engine *engine,
 				dev_err(engine->dev, "failed to unprepare request\n");
 		}
 	}
+	local_bh_disable();
 	req->complete(req, err);
+	local_bh_enable();
 
 	kthread_queue_work(engine->kworker, &engine->pump_requests);
 }
-- 
2.34.1

