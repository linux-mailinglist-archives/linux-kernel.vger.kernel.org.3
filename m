Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3D7D53DAD8
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 10:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244782AbiFEIdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 04:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236304AbiFEIdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 04:33:44 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0398377E1;
        Sun,  5 Jun 2022 01:33:42 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id w3so9917230plp.13;
        Sun, 05 Jun 2022 01:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1XynJUO5aAAYX/xCNCu1+sq4mTp/XcAazdfl0dSPwkE=;
        b=HJRR11UTNvFUTyNZaNrqwzGJuWtUZ4I2ZKI1ZFLnjeyvqyfb0Vg3z4/q5K+4PXYkW6
         NEZ+Gz2epzUZ/2gl5jPCffWL4olKfliCaXcAbVlQ9bcLlkujBWo4665rfhi6NaeINY1j
         mwXO5DlPxuQf0gS1O1lAgO7euB8YbvPR35geAUiZ8AMoeNj7Sb3wlTxrCkKiAtV2hzmH
         20JqdS9UTF4FzDBd7iC+llUCcHlIHfsT0jHyPW46/eW8OHuL+O97jpVbaC/mZDmWE9nY
         +0ataNa+VAjlKtbh3zyQTQaQBNjzjW/WBPDxtTpFnVzOQIXkTHNxcfsleMzV8A+Wvy2+
         rkxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1XynJUO5aAAYX/xCNCu1+sq4mTp/XcAazdfl0dSPwkE=;
        b=aXYxWnRCqx0NlunV0JKmw4v/uOGhrytnHEe8pq3jFL0z2YS7NXuO2aG/QaIiWWS4kM
         NDZ+RPu5LTZPI6QUkSlKXBulf6+DNdvH84fB7aYquqbyjbvknc9g4iPR7YPGyYxMQ59I
         quKhcNpra6HLRGHNxOiMvVd9Yb8/TR+sVL35uEJi4ZXqp/VkFY0vy0SDtm3pKPSo6k2n
         njY0abDaAkNYanBN3oX/l36+XZZGKWb7JjrZi6STNjJKxsJXvdYOsM8343hxS+jF+5Dy
         tBxXhYKE6m9jdJwcniJ3tu8IhYc+uBTTuOXfnVxd0CJ6FNejNr2ctpiybCPeiXk52ZBi
         AyFw==
X-Gm-Message-State: AOAM531KXvTk7yV6O56q2lHrdE4a3QY6cWcWEEB8vusVXnhIht8PRz77
        MUuBNvnsJ27hC0RgE4uf5d4=
X-Google-Smtp-Source: ABdhPJyZ+37YegClUoL+IO6Krkp0Vi3gUJ/RpM3fh+GWzhWBlqmsVOnAg9cEKB+068RGiqSDQmudtg==
X-Received: by 2002:a17:902:d4c2:b0:166:46c9:577b with SMTP id o2-20020a170902d4c200b0016646c9577bmr15187821plg.66.1654418022259;
        Sun, 05 Jun 2022 01:33:42 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id w8-20020a1709029a8800b0016405375132sm4232935plp.25.2022.06.05.01.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 01:33:41 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suman Anna <s-anna@ti.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] remoteproc: k3-r5: Fix refcount leak in k3_r5_cluster_of_init
Date:   Sun,  5 Jun 2022 12:33:34 +0400
Message-Id: <20220605083334.23942-1-linmq006@gmail.com>
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

Every iteration of for_each_available_child_of_node() decrements
the reference count of the previous node.
When breaking early from a for_each_available_child_of_node() loop,
we need to explicitly call of_node_put() on the child node.
Add missing of_node_put() to avoid refcount leak.

Fixes: 6dedbd1d5443 ("remoteproc: k3-r5: Add a remoteproc driver for R5F subsystem")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/remoteproc/ti_k3_r5_remoteproc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/remoteproc/ti_k3_r5_remoteproc.c b/drivers/remoteproc/ti_k3_r5_remoteproc.c
index 4840ad906018..0481926c6975 100644
--- a/drivers/remoteproc/ti_k3_r5_remoteproc.c
+++ b/drivers/remoteproc/ti_k3_r5_remoteproc.c
@@ -1655,6 +1655,7 @@ static int k3_r5_cluster_of_init(struct platform_device *pdev)
 		if (!cpdev) {
 			ret = -ENODEV;
 			dev_err(dev, "could not get R5 core platform device\n");
+			of_node_put(child);
 			goto fail;
 		}
 
@@ -1663,6 +1664,7 @@ static int k3_r5_cluster_of_init(struct platform_device *pdev)
 			dev_err(dev, "k3_r5_core_of_init failed, ret = %d\n",
 				ret);
 			put_device(&cpdev->dev);
+			of_node_put(child);
 			goto fail;
 		}
 
-- 
2.25.1

