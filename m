Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E29054B6BB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 18:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344261AbiFNQsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 12:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344578AbiFNQrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 12:47:32 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E838328E2E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 09:47:27 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id o33-20020a17090a0a2400b001ea806e48c6so9598203pjo.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 09:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Rja/xqJpInMBVEwkvWVoS3z/NTqM46xGTOY1nGLtTP4=;
        b=c0/2Jg0T7L+z1nbcSGzT2UA5kcQKZYD2/jDTCOgaTbGoDRZMSWTqXG7Y47maGOIgtP
         XdFtiQPBaFYhT283cnF6YU7i96s6njpSgxspC2dx/iVPibsnr7C0lo2ctutphs4gj0Fa
         Yu6LY5uPpV5+YYLsU7G1+f3c914iaoKuH/dFNCtB/wwteR5X8t48ye3/8/CD17OSnmrR
         2BQUKkVvIBhRtE0nKZy7+wx+fxG0nCaynZ4CToyJybcAodbjl8qxbxnjv4EyIg8Nf4zs
         NEEsyq5WtCrfGZJKud45ptKXboR9Ula1dAXPhD17ObIp6AZcUIhEPu03VngXJ7faP/U6
         AFbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Rja/xqJpInMBVEwkvWVoS3z/NTqM46xGTOY1nGLtTP4=;
        b=iF7pB5q7sVuSybibtByXyaGO002cULwLqjmL+gKAcDwKm8/65x+mIUW2zOd5K4ceSz
         xwVpt+qTW1iTebD2x7FV/j41J6R2mV6CyhWkrM9nq3qhXDJcC/ccwyeJRAbMovpunBJl
         Ruav5qs9V1KcDJmRuozWjpXVUySLwUlA8DP0u0H96Sm/NmBJ1SlYq8DfXNrQbu06OXLv
         Kb+peQXQ86icpGwRxZ+46V9x6vE7YTSYL//bvpSTcWi+0sx2eNETrwvucdYiGTZoe4+5
         5/sn6KfwIhof3ET0TfsI0ZG/4JKNc0gyLeHK+nl379b0hxoF7RNt7NGA0P9wagEO0G2c
         hgEQ==
X-Gm-Message-State: AJIora+eg2/E+nJyTwJozjYwrcogSVreIh8w5ZiS+piosezc7jA/Z3SF
        xR56JKrpbozpZDgP+yNpDixzNg==
X-Google-Smtp-Source: AGRyM1txgGrdwH6AfNhk8sm7ibTTgS/8GprMFi/Je9F9NsO9TFEvhYmngMyYULKpZjYKm19/D098cw==
X-Received: by 2002:a17:902:e80b:b0:168:b645:849e with SMTP id u11-20020a170902e80b00b00168b645849emr5195520plg.26.1655225247407;
        Tue, 14 Jun 2022 09:47:27 -0700 (PDT)
Received: from n131-251-240.byted.org ([121.30.179.156])
        by smtp.gmail.com with ESMTPSA id g23-20020aa78197000000b0051bd9981ccbsm7761557pfi.39.2022.06.14.09.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 09:47:27 -0700 (PDT)
From:   Zhi Song <zhi.song@bytedance.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, Zhi Song <zhi.song@bytedance.com>
Subject: [PATCH v2] node: put_device after failing to device_register
Date:   Wed, 15 Jun 2022 00:47:22 +0800
Message-Id: <20220614164722.1744799-1-zhi.song@bytedance.com>
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
We need to call put_device() to give up the reference initialized
in device_register() when it returns an error and this will clean
up correctly.

Signed-off-by: Zhi Song <zhi.song@bytedance.com>
---
Fix the changelog text correct.
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

