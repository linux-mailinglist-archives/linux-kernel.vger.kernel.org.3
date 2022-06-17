Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0D8354F32F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 10:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381017AbiFQIiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 04:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380352AbiFQIio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 04:38:44 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A52369298
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 01:38:39 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id u37so3622370pfg.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 01:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ak/3+BuQZPayyHcZgGcyHRrIZ/8v8tKL6L3S32n4JYk=;
        b=EpUGberfrYQ9nVCS5lYRWlTyhUO4ZoVu1Da8yhexf+xots8csRHJG8I1O0kr08bTiK
         UyFMjNP3Dpv1TrfycA7YM55pgJMT7wBkAZWSPbpZZh212nLXRV8GCL8cAqyMdlhwSs3P
         qRbPWlbxQoZzLBe1qsPs/XMlyF3ctrxxvHAjSWOyZppO0eF8dF+BKJvl/BzCayYqwIxE
         FxCC0GhNlmzjz1yAfrzAHSsWIoCjmgRI0TNH2LToGN2YpsvIQoBL0AT1g7YiU6fPjXJ1
         SqbJCO1d5IYbC21C8UykgyOC6MQQx2pbL8Ol+aZYiPfm2tfaWGyYkC7O181ltBe1UADg
         d95Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ak/3+BuQZPayyHcZgGcyHRrIZ/8v8tKL6L3S32n4JYk=;
        b=tRXvfxWekPrXHwaiqVPPRJ98BEvjF9ndSj9IyUU1PkqlP36sRyI378/SvsLZn0Be6h
         ri9ajPaV0svH5bgg/YT0sntxljEeTfex/qa4uS59St0cYqF+vRmTBN4CN189vacWsNyY
         fA/NlwlekNgLTSfXheDyU4vOsJB7luNqjQ57m2yiXFet4H6s7t2oEEDSs8GazQjbpMBP
         s2Ykz9o8X2RrXQKeQy51D2exJUFIObNCkVCX42c+tA610aas8SoyuPWyK3wkNlYqY8z2
         +BmnSNOg9MF93nhWrPtMDdOSJe33UCJoTF5A4KdqyppeWWDTgBJfa9seKhoZ/riqSyHU
         4dnw==
X-Gm-Message-State: AJIora+VJzf1Fd/B8gpncM2rTsOqGfeg9A4OrD/qyGp1VJGW5qlAgKIb
        2y4IMC5YsBsduT4WZzfedPigZaAf/BuJewch3pM=
X-Google-Smtp-Source: AGRyM1sML4mzdm2IzfHLLLIFa1pM+mhWo+dk8gDIqG/7wtIC5Vr0Pb47JfVpwWQ8v4Ta/5cP6D8P9A==
X-Received: by 2002:a62:7cca:0:b0:4fd:e594:fac0 with SMTP id x193-20020a627cca000000b004fde594fac0mr8931045pfc.79.1655455118327;
        Fri, 17 Jun 2022 01:38:38 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id z14-20020a170902ccce00b001635b86a790sm2988179ple.44.2022.06.17.01.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 01:38:37 -0700 (PDT)
From:   wuchi <wuchi.zero@gmail.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] lib/kobject: Simplify checking of parameters in kobj_ns_type_register.
Date:   Fri, 17 Jun 2022 16:38:32 +0800
Message-Id: <20220617083832.85287-1-wuchi.zero@gmail.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
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

1. Merge checking of following code:
    if (type >= KOBJ_NS_TYPES)
    ...
    if (type <= KOBJ_NS_TYPE_NONE)

2. Move the checking of parameters out of critical section, there is
no need to check that with spinlock.

Signed-off-by: wuchi <wuchi.zero@gmail.com>
---
 lib/kobject.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/lib/kobject.c b/lib/kobject.c
index 5f0e71ab292c..6a8b009682b8 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -996,19 +996,13 @@ static const struct kobj_ns_type_operations *kobj_ns_ops_tbl[KOBJ_NS_TYPES];
 int kobj_ns_type_register(const struct kobj_ns_type_operations *ops)
 {
 	enum kobj_ns_type type = ops->type;
-	int error;
-
-	spin_lock(&kobj_ns_type_lock);
+	int error = -EBUSY;
 
-	error = -EINVAL;
-	if (type >= KOBJ_NS_TYPES)
-		goto out;
+	if (unlikely(type >= KOBJ_NS_TYPES || type <= KOBJ_NS_TYPE_NONE))
+		return -EINVAL;
 
-	error = -EINVAL;
-	if (type <= KOBJ_NS_TYPE_NONE)
-		goto out;
+	spin_lock(&kobj_ns_type_lock);
 
-	error = -EBUSY;
 	if (kobj_ns_ops_tbl[type])
 		goto out;
 
-- 
2.20.1

