Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B643531474
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237958AbiEWPeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 11:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237865AbiEWPeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 11:34:17 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B4B6289A1
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 08:34:17 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id o13-20020a17090a9f8d00b001df3fc52ea7so17844308pjp.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 08:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W4RCFlHPKPzBpfZ4VSRaqmfuqEsVoa/sGTVsUgYmMkw=;
        b=YGoYoVqwdqHR20dUUiThyv7mSi+CuU7dvhVuKDwnSf55afYm8Xq8utr0ljcFgoU5GW
         zpCKB2yh8ZSQlJPZEKqm4ujVrHmMxNP8RnjYJfz/TF8/wYudZRnhVjY7UD5MdXuMTgfM
         mydwtqvtrXgQg7io3VCJ92Bq23W+uR1pqrqBHarN4OzCGuRGlRO8vR5qFT+7xg/UYt/M
         OTEvcbdSiIvoH8/KvTQr6J3cY8zPw/Dn57bZ4Qs/ryjn/Wm8mtPyFATqOhyaGsz9L50i
         GdTOX+RIbrnFiJWxCaI4Br6yirCtDZvUEDHiR0nSszHCcQjb1+BT8zs0cSe68Zf/AwMt
         nZNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W4RCFlHPKPzBpfZ4VSRaqmfuqEsVoa/sGTVsUgYmMkw=;
        b=PD68BD6CLwhm+KN7gtRFCfFkzTSxBlqwKPVRZ8THP/6UsVIwFBxlxDzWpZHjhfMw9B
         /EncNI/NiYhXb8/hZuNd3/lfUotb1qMWQRDaf2ergn0G6SqRXVq6qwkbCB1IYAMvQv99
         tqKxjjxgu+YXb1XU1B5VG1javw5nMcztK5NJGjOmpHtQJSZ6G3k+6Y7WmZ5AcqZfhU4K
         r0y7sH5ZpxcSROxYcnFhDv97Yn/q6W1fE9uLmmK66vp8vc32IjQ/ENSrUEChQvWCxEuW
         TVue4ZhaYyUerutwlRvSdM2Un4n5hdoloOapaZtsr/VVUZ6YYBlCMArkhMxte3so5gw8
         8MGQ==
X-Gm-Message-State: AOAM53015No0eUUIvA/J0T2lfdH4GK/NubAQ8vrj0q3PcKLvI9O2vTY7
        qDaomX4Gsr7bMXsxtkcaAz8=
X-Google-Smtp-Source: ABdhPJzljZ11lQunxi5u5KVqo9IYckGYCLPpmtlOuo+7t/bCcHtXT+XiPLzpWe6/z4+bvzkEyU285w==
X-Received: by 2002:a17:902:f549:b0:161:f216:4f46 with SMTP id h9-20020a170902f54900b00161f2164f46mr16620819plf.70.1653320056826;
        Mon, 23 May 2022 08:34:16 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id n8-20020a17090a160800b001d92e2e5694sm7316928pja.1.2022.05.23.08.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 08:34:16 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] bus: arm-integrator-lm: Fix refcount leak in integrator_ap_lm_probe
Date:   Mon, 23 May 2022 19:34:09 +0400
Message-Id: <20220523153409.22949-1-linmq006@gmail.com>
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

of_find_matching_node() returns a node pointer with refcount
incremented, we should use of_node_put() on it when not need anymore.
Add missing of_node_put() to avoid refcount leak.

Fixes: ccea5e8a5918 ("bus: Add driver for Integrator/AP logic modules")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/bus/arm-integrator-lm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bus/arm-integrator-lm.c b/drivers/bus/arm-integrator-lm.c
index 2344d560b144..ab5fad8aaa99 100644
--- a/drivers/bus/arm-integrator-lm.c
+++ b/drivers/bus/arm-integrator-lm.c
@@ -85,6 +85,7 @@ static int integrator_ap_lm_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 	map = syscon_node_to_regmap(syscon);
+	of_node_put(syscon);
 	if (IS_ERR(map)) {
 		dev_err(dev,
 			"could not find Integrator/AP system controller\n");
-- 
2.25.1

