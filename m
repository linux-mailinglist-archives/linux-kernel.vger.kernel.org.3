Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51E4751CF01
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 04:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388334AbiEFCci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 22:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356352AbiEFCcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 22:32:36 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C01F460D9D
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 19:28:54 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id bo5so5139878pfb.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 19:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=u4HKeG270L/jN8SAhLqpcEmSK8EaW/IJUsz5DJfPsg0=;
        b=cxDO6SExYy63yup4qE0H2Xls1X/edJo7KS92SiyLaiaJXY1zwBMO4XlaiBSe5iHQJF
         WsV43Qyz3O3gukoVvtmVc0a47kdC+naHUFtIS47yA12ifIjhvZjc3CAsghampYABTGhW
         N3svjaqQ8nMgp7GWK1scGH+o1YBMYPZWv190b/lWheFEmD8iqtmsSGTVzJjFzdj+lzAi
         Ou4QJ8rSkWUe42M7V+dvY9e0DHbFE/9opY6iHK7lnqOEbN2zwwokHaTFZbXkAqdvzIcg
         GhqedwYI9R/79hoZ9Th9eVsVzB8VJHNHO5EKQQBM+Ltq/ABwJdc+f+PGFje7V2FDqBp2
         ObwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=u4HKeG270L/jN8SAhLqpcEmSK8EaW/IJUsz5DJfPsg0=;
        b=UnBNrfWyq4E2no+CUkUs/zddDFBN4hoyotn5alsiu4mFz7/iA0Kvakgy+/cQTeHkTd
         c47vegQpLTvodSg84Vu10Z4HyeS4bQpV6Y0gEZqjz08ZuGmqORpjyItiLRKrfkYTJ5eU
         ymYwGpQdcnZ/YnKJnt9TI8sHF1ghWidTKn89ks3vX/7UlWO7nqP07QcKPDX6qASUdMRC
         Xm/pq19PWuv9FSP1oQUGt98x5B+zaO39hG20eAPlLWIut+ZKkiQuqCyYp/o6I8r44nY8
         U5zYR04jIL3raU6nS0foaPyk8k/lgPi71Nmb0OYhKP39v24nxDvcoXO2zZkJMJ85S4pS
         lXtw==
X-Gm-Message-State: AOAM5303g2VrgtOpqe/JdlyfYInNv9E1QLyG2YWyJzuTfI+fITSbJEfR
        ltcULiPdmMp3Jj8h8wN1+78=
X-Google-Smtp-Source: ABdhPJyZHHlwk2lNfD8pB7g4LRaAelgzu7BjKKCHZgxegoYpLP2gL3+Y2dhC2hltOMW5a/8gEd5rrw==
X-Received: by 2002:a63:5755:0:b0:3ab:a0ef:9227 with SMTP id h21-20020a635755000000b003aba0ef9227mr928502pgm.541.1651804134270;
        Thu, 05 May 2022 19:28:54 -0700 (PDT)
Received: from localhost.localdomain ([183.14.31.73])
        by smtp.gmail.com with ESMTPSA id p43-20020a056a0026eb00b0050dc7628184sm2154856pfw.94.2022.05.05.19.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 19:28:53 -0700 (PDT)
From:   Puyou Lu <puyou.lu@gmail.com>
Cc:     puyou.lu@gmail.com, Andy Shevchenko <andy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Chris Down <chris@chrisdown.name>, linux-kernel@vger.kernel.org
Subject: [PATCH] lib/string_helpers: add allocated strarray to device resource.
Date:   Fri,  6 May 2022 10:28:43 +0800
Message-Id: <20220506022845.26750-1-puyou.lu@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a must to automatically release strarray when the device
disappears.

Signed-off-by: Puyou Lu <puyou.lu@gmail.com>
---
 lib/string_helpers.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/string_helpers.c b/lib/string_helpers.c
index 4f877e9551d5..b4497c068172 100644
--- a/lib/string_helpers.c
+++ b/lib/string_helpers.c
@@ -757,6 +757,7 @@ char **devm_kasprintf_strarray(struct device *dev, const char *prefix, size_t n)
 		return ERR_PTR(-ENOMEM);
 	}
 
+	devres_add(dev, ptr);
 	return ptr->array;
 }
 EXPORT_SYMBOL_GPL(devm_kasprintf_strarray);
-- 
2.17.1

