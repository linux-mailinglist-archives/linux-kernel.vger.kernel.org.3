Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A420D4FD912
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 12:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386820AbiDLJEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 05:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359036AbiDLHm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 03:42:27 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B6F54FBB
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 00:20:03 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id s6so3938807qta.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 00:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XvbKywfbm/xW7byqKZQzUxfarlYd7JRaSauDk7cot/s=;
        b=R8F5T5+9GDyIxEi/DKA9g4pcixd9+sQKyQvYDCAo/eL4g9kmL0xUQb4FUzjPaRMS47
         sOfG15j4SuMQf0pOCoe2h0vQkgr4GQeH6qdvrTNdYtdDzUY4mj9Ck1NzCErFI7dSFPQ7
         azysapIySswploKHk3qMTX71RL4oF/zuqd2zxvLKam0sGwvLSsr4Bxhnz3c+qs9hPAxV
         ydHmzj/Kv4Q0OCwR5/FeZUeu4adf1x6QwhUN8DHnEaKXxJTM76XTouyqfgBclt9ZFGXF
         3b1CsSanEEREH8pCsGLb+q3TVVmJoRXGTc8EwFY8C02KdHcF6J3Hi6YGShc5g3OMNG7R
         XSyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XvbKywfbm/xW7byqKZQzUxfarlYd7JRaSauDk7cot/s=;
        b=zVp4q2KB+0PZZlRPqjLrqv1JiFK0RMOt5wscWv2+hYgcCHzXvYgJAU6bPwGCNVQ51T
         EvH6QgGVYkMu4GdRM2Kg+UbzJebRNtEaDe+22OUb22/hNKnBFpykJhvJGUMZ9SUVz+4V
         FgH4dnSjYpVzcWlxgiAIcUguferWGNcFOXjGHfIL8smR8kTm1hkTv7rh/WwLo+aTSrYu
         p164KIs0KQBQDaZHRhtE/rKOhZ2nQwAjWkwoQum652hDTHGFVpmM12j+W+lxfuYmeL9v
         e6Tpx+u7TVg6oCasiqfA5O1pmPTHE1OkNfQ/E+DOZECbto2KZHx1Ufrt4Ws8uop0dZxB
         9GRg==
X-Gm-Message-State: AOAM533WmWiiaaHWO4HdmJUWUKGF5Yd5puhY1VV2thRMQJtJ5Mk9zsQ+
        iLAgcoQOrsVbrsoGQKfe69KUqa62QuM=
X-Google-Smtp-Source: ABdhPJxEovphxMbVpe6bGcAdFG8wBzxYcIjvyJGtjzWiHCnDTOKXjW9BJhvdYMMObfsvCtRjPH5dEg==
X-Received: by 2002:ac8:5e13:0:b0:2e1:cd7e:a29e with SMTP id h19-20020ac85e13000000b002e1cd7ea29emr2229127qtx.31.1649748002212;
        Tue, 12 Apr 2022 00:20:02 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id e19-20020a05620a209300b0069c0bef5892sm4701145qka.78.2022.04.12.00.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 00:20:01 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: xu.xin16@zte.com.cn
To:     bsingharora@gmail.com, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, yang.yang29@zte.com.cn,
        xu xin <xu.xin16@zte.com.cn>
Subject: [PATCH] kernel: make taskstats available from all net namespaces
Date:   Tue, 12 Apr 2022 07:19:46 +0000
Message-Id: <20220412071946.2532318-1-xu.xin16@zte.com.cn>
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

From: xu xin <xu.xin16@zte.com.cn>

If getdelays run in a non-init network namespace, it will fail in
getting delayacct stats even if it has privilege of root user, which
seems to be not very reasonable. We can simply reproduce this by
executing commands:
	unshare -n
	getdelays -d -p <pid>

I don't think net namespace should be an obstacle to the normal
execution of getdelay function. So let's make it available from
all net namespaces.

Signed-off-by: xu xin <xu.xin16@zte.com.cn>
---
 kernel/taskstats.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/taskstats.c b/kernel/taskstats.c
index 72415e22342b..f7e246336218 100644
--- a/kernel/taskstats.c
+++ b/kernel/taskstats.c
@@ -688,6 +688,7 @@ static struct genl_family family __ro_after_init = {
 	.module		= THIS_MODULE,
 	.ops		= taskstats_ops,
 	.n_ops		= ARRAY_SIZE(taskstats_ops),
+	.netnsok	= true,
 };
 
 /* Needed early in initialization */
-- 
2.25.1

