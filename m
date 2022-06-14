Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83B9554B33F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 16:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343840AbiFNOaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 10:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344821AbiFNOaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 10:30:15 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A763A1A6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 07:30:14 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id c196so8735869pfb.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 07:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uZyUFN1h39Go2K2KWm9NafLAQsTySckD7lRqVWd34t4=;
        b=IuVpxFjuwYst9xd5GO1emNka+Naj7tYrYGXam7aX9erF0js2DtCHt0KZuE87dodjD7
         MgiiCjskMo0TYL33wSYmZ2BZGDhAaepj/1eSmqNcmRkEWU9oNj4hNPor4RpibhItz+1F
         lrGklHWy4dTywMCA3RYjny8+wZUV0syw6tGrjhYYO4HMjIn6p/mQP2+N4Xe+wC0RVjz2
         lHbfDjRkG8l9vna7t78enRoYtY026tiUeFZZA8zPiUIzUJP0Ld8pH3FD/0yEKybCRjY8
         fRvUxNhLXvYVmjBVobHbg10rMyfVwOaZZBChw+2KgLwGlZAUGM+yYoxkA8C5FMLuyyK8
         YCiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uZyUFN1h39Go2K2KWm9NafLAQsTySckD7lRqVWd34t4=;
        b=2ZhP+0wc8m1dOgNckbB7r89Qe5C6RvNU2IZ40qItccwiPVgXatj+ipgCSfNNiZWvEa
         LllpJXzgx6AGJyOh+kgiULo+6GP62BP9WvqN1Rrl32eAyOvlx9ViPm2Rcun03XVceZ7k
         Gl9y+A0bdY2Og/wcHdX/skO3fTX8s+2pcxML9rqLlVSNLKPudtMz8tNdDYMyBeyhhOPh
         SbjulS9BT3L/8tOMRmylGsWA9uWy5aI6swtEty+T/ImjxMKU/ypuBsTuNDsrp/sMdv5g
         p3FQInQ3D6rQIsTa9ubT+YxAzrNbuEJr8MGuVp7q1+2bQajRZdKIg8rLLitYaE/8Dv3I
         nOCg==
X-Gm-Message-State: AOAM530U63rEBvUT+dhWaKzCf+SxGNLpSEbJ50WXXAr1MeTBglN/1Zjw
        KlCb1AnWaBBRjQd8Y9l9LICAQg==
X-Google-Smtp-Source: ABdhPJxr5hWWJGmhm8c7NVKnpLep0oS6xYZXOb6syMhCLLkPDj5P7501jtFUCR6bZZQZ005Qjt79yQ==
X-Received: by 2002:a63:5b04:0:b0:3fc:61a1:da0d with SMTP id p4-20020a635b04000000b003fc61a1da0dmr4775709pgb.177.1655217014472;
        Tue, 14 Jun 2022 07:30:14 -0700 (PDT)
Received: from n131-251-240.byted.org ([121.30.179.88])
        by smtp.gmail.com with ESMTPSA id m14-20020a17090a7f8e00b001e2ff3a1221sm7393256pjl.33.2022.06.14.07.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 07:30:13 -0700 (PDT)
From:   Zhi Song <zhi.song@bytedance.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, Zhi Song <zhi.song@bytedance.com>
Subject: [PATCH] node: put_device after failing to device_register
Date:   Tue, 14 Jun 2022 22:30:07 +0800
Message-Id: <20220614143007.1730171-1-zhi.song@bytedance.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

device_register() is used to register a device with the system.

We cannot directly free dev after calling this function,
even if it returns an error.

We should use put_device() to give up the reference
initialized in this function instead.

Signed-off-by: Zhi Song <zhi.song@bytedance.com>
---
 drivers/base/node.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 0ac6376ef7a1..88a3337c546e 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -154,6 +154,7 @@ static struct node_access_nodes *node_init_node_access(struct node *node,
 	list_add_tail(&access_node->list_node, &node->access_list);
 	return access_node;
 free_name:
+	put_device(dev);
 	kfree_const(dev->kobj.name);
 free:
 	kfree(access_node);
-- 
2.30.2

