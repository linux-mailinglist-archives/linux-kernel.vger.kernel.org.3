Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10892504F43
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 13:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbiDRLKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 07:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiDRLKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 07:10:02 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10EDE167CA
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 04:07:23 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id c1so10863846qkf.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 04:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YtZQpaaWbMrmADVoPCdPpxC8ZR7IPW9qoPme8mbi74w=;
        b=SJt1SbOVYwj556mS40EglaAHYPCgeeZn4MzKjfH//wsHx5wxsZu/f8s55Ro/UHQzsy
         ZzLE7mGiYSpXL027iNMD1WdVA48+FKVVwl80ZdAMGrSHOG9S5LDjSkJnv6bESoyq6HgO
         wxIH9jszMvMsX0MnlfUZ8JtWOGOmLSNMPW3Zyqf8uudE/69X5n/7J2Ly/nJhR1giBtIN
         2c+jUC+gRPXAf93eLYAJfMrYerjuY8JmS/JtORbCfnR/NDD99gY6ilyNGHVVofx0pKJs
         q0UbYa62v0MkYogPKSEw3BVqjGLAc6KcVr0qv3SY8RfH7XICjvxuzXsYMXpBImbQEoRk
         z2kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YtZQpaaWbMrmADVoPCdPpxC8ZR7IPW9qoPme8mbi74w=;
        b=MGgr1jf4u9h71QsJVN+IjXjNlz8eH6KzhRvurPlM9qCXyIDsiKLn21ILDRP03UCa+h
         Fv8eK5qEyCDhYYH+MvMoZiklKq55EE1fFdOScVHbNP6bcvAJWMOeYGYiypU+IF7h6Zng
         d2NZp+aCrW6ER8Mhamr2wGBcWc4iNGJBytMbcJc4wPyofPkCHPLcxflVJDjYMdr6LXMB
         5g7XLQbvN8WIS7MP5Q4hRoE4rTA+x24U9yGBwHIaszki5f/ER8W3LK6CF+R1GeDfHijG
         kg/mmlcsIL5G0K7g/YcvhXXvlHO39DD2xDwHbCZ0apjNqo1ZOy55dd1UxUlbuX5hM2r+
         Gplg==
X-Gm-Message-State: AOAM531z5Yb4LIyETwOLc5pdJsJPj2NvVNMXguMQBpkAteR696McLuHr
        1lhcsB3mFmxGIqF17wGqMPC5I8KzBtA=
X-Google-Smtp-Source: ABdhPJzSQIZQ7c8wqMzy48voYrZmIZbVN599Zrordhf9jIJuUx9g+vhUJHJq3mO0BqoAgL4jVdRqrA==
X-Received: by 2002:a05:620a:4626:b0:69c:3796:5c1f with SMTP id br38-20020a05620a462600b0069c37965c1fmr6237838qkb.422.1650280042236;
        Mon, 18 Apr 2022 04:07:22 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id m10-20020a05622a054a00b002eb965bbc3esm7499529qtx.93.2022.04.18.04.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 04:07:21 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] genirq: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
Date:   Mon, 18 Apr 2022 11:07:16 +0000
Message-Id: <20220418110716.2559453-1-chi.minghao@zte.com.cn>
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

From: Minghao Chi <chi.minghao@zte.com.cn>

Using pm_runtime_resume_and_get is more appropriate
for simplifing code

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 kernel/irq/chip.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 54af0deb239b..8ddcb8e883d7 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -1576,11 +1576,9 @@ int irq_chip_pm_get(struct irq_data *data)
 	int retval;
 
 	if (IS_ENABLED(CONFIG_PM) && dev) {
-		retval = pm_runtime_get_sync(dev);
-		if (retval < 0) {
-			pm_runtime_put_noidle(dev);
+		retval = pm_runtime_resume_and_get(dev);
+		if (retval < 0)
 			return retval;
-		}
 	}
 
 	return 0;
-- 
2.25.1

