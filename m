Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF0650DE47
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 12:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240952AbiDYK5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 06:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236870AbiDYK5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 06:57:23 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4433783011
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 03:54:17 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id t11so3081941qto.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 03:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VE7hLnL2JzRWXBL+x2KNohSUhmDWu5UxatJoTC8eSZw=;
        b=l2FcOdRwsh6qq4j24xk78eBC9Z8WD4+I4ThlceSG6NfKkURxWys6zBSGDcC+3Yxrgs
         6IfTQnSbiP6D7EhuiMICx3ZuYnNSwTkHGCGkpwQGnSIhcPtvoZSJHmDBvYHUhJXB7xy3
         bD8/z/m5I3WDL7bymmNvWNcwknlqlkqUxDCV4E0lffylHyR9UN6lKz9ZmbYOiNuzI8hQ
         3Z+SGYFuAwV98LDtZtzhGgjdLfav5+C2w/p+CqNqZ+NLwIxCNcuvrn7fsZY6iF6VD3ps
         QMEWPFzcp1KzPd0aX5J6YvYR9Fd2Z2A9nA65ssz0gbiLRfdyIDKdhSY00XUqFQvmGxix
         /KZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VE7hLnL2JzRWXBL+x2KNohSUhmDWu5UxatJoTC8eSZw=;
        b=72A57WOwY8kzYEIxAUKfYxd+pTbh1ZY7bGT4ezf/ivGkqKZ6Uj26pAw+pcPp3OvUCt
         4wqU2v4O/6KJnEgCX8FdrrhL5U84cxBhOx/fDVj5mlZWFf2gJHb8dmqbzk5YNG0L83jn
         kreXrWfh9z0I08s2eEvhoXbcHUsBfUghppUsvrI8Nn32Jt+TmM1sQyYWpYwO+Eol4plo
         E3YK/eO+FYhPkb1nUnUR29coV1L/LGAIkQTVSwjYfpXjWeVJAQXMgZanVdJJyPKn2i7m
         zeWcusnB0jng2cDmRG1I8LwJBWRAFkBkVL+GzuRHoDnnCKWtRreIbduCx/XpN6DdL1wg
         54tg==
X-Gm-Message-State: AOAM5322B2HHkPoaWjcCgtsY0KZte1CItwBTcjWm7qE5/aTKzJwe2rZX
        wK79NCDYSHQB5fZzCpoUsSI=
X-Google-Smtp-Source: ABdhPJxK8392ELC/VE00huZoYudJKEZoU3OodsWWeiGYf+b55ZMR4GSr+F6YXtPGed3PR+ijfJyt7Q==
X-Received: by 2002:a05:622a:144:b0:2f3:3bbd:3db5 with SMTP id v4-20020a05622a014400b002f33bbd3db5mr11540024qtw.95.1650884056495;
        Mon, 25 Apr 2022 03:54:16 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id g4-20020ac87d04000000b002e06b4674a1sm6423576qtb.61.2022.04.25.03.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 03:54:15 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     dan.j.williams@intel.com
Cc:     vishal.l.verma@intel.com, dave.jiang@intel.com,
        ira.weiny@intel.com, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] libnvdimm: use kobj_to_dev()
Date:   Mon, 25 Apr 2022 10:54:09 +0000
Message-Id: <20220425105409.3515505-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

Use kobj_to_dev() instead of open-coding it.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/nvdimm/namespace_devs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
index 62b83b2e26e3..e9f021da743c 100644
--- a/drivers/nvdimm/namespace_devs.c
+++ b/drivers/nvdimm/namespace_devs.c
@@ -1380,7 +1380,7 @@ static struct attribute *nd_namespace_attributes[] = {
 static umode_t namespace_visible(struct kobject *kobj,
 		struct attribute *a, int n)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 
 	if (is_namespace_pmem(dev)) {
 		if (a == &dev_attr_size.attr)
-- 
2.25.1


