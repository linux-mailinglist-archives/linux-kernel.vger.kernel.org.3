Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98FA350B5D5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 13:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446989AbiDVLHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 07:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245078AbiDVLHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 07:07:14 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83F225C5B;
        Fri, 22 Apr 2022 04:04:21 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id b19so10495079wrh.11;
        Fri, 22 Apr 2022 04:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aX+af2NbLYVavvKgA4KwWpvzLYIlHAkPkYV9LErzorg=;
        b=RdHAhqBriPScMcrozEZlK7PFf9XAzS66rQDFLnBoBGAjWkJ7ciJZqrY/zzYe3YX17f
         7AokDza8jYTO67wDtahYdd39QdhtAGMTR1Z+fChGeL5RQ5s3mu+dE5QXdr4g5D0Nn2Lv
         r1eWsmVYpCq0eTUVG3+pS6mSWehXyAqz21wkoV6oiAyrwameuNpy3EwKEUu3AoZUmOWP
         vCgIHjGKOo6FkYp2AJFq5XSstiG/kCcQZsSJfps3gVrh/BGFhQDjSsMNlwMU2dIfn2pi
         ygilEu7iPO8Ej7VI6eX/jVxFCbTziPFMbs8as6KzKxodZMsgb5BvyaK4EmIn7wteA8Ry
         ZC8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aX+af2NbLYVavvKgA4KwWpvzLYIlHAkPkYV9LErzorg=;
        b=rE7aaaBPYZl/p13l5XcOyNEIcT344OGdNSGkCJeELkBbuPwLrbJdO9eR/eSi790k6t
         2znRXNCS0kMYxhZL2nLAQVOh43dr5rQOHYIrSFRB+AHrqnDKh3l7UOVXfpLYGl1NqJOh
         y3zJJZQh0og6Vf3yxsZ2NU4pnY5o9Gj/BUJfV7egOMEws2Rdk9Nu/dKJsqMZKjvrUygd
         D/FjAWpE8Ca8p1ocMUDzrIZXe1wZjrzKC24NRTF2NLnkrB6QlVlRS3+Ig9ZnCaiFENC9
         kbpLhZNJbYWqnvDWroOl3gGi6nHrIhErMLj6pyL8wEW3+uY2Qwgs2WF4+ZS9jqfw2ZtX
         ahXg==
X-Gm-Message-State: AOAM533ANesMSzDlSdr/Qgb9r+Om3KvAzaVkyBXTYiZhDLfgficHKXwC
        7r5SNXnSbEpXsfV7PjfrZ/4HrFfEc6w=
X-Google-Smtp-Source: ABdhPJyaWqhcVGDLHxDxRf5Wk/P202UvjQHRnNHU8QKJ6oMsRDnKf4mr9mgXnEEACMXB/grE982s0A==
X-Received: by 2002:adf:fb4d:0:b0:207:a376:7585 with SMTP id c13-20020adffb4d000000b00207a3767585mr3220431wrs.489.1650625460208;
        Fri, 22 Apr 2022 04:04:20 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id r5-20020adfa145000000b0020acc9de8c4sm705518wrr.38.2022.04.22.04.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 04:04:19 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>, Tom Rix <trix@redhat.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH] kernel/irq/matrix.c: remove redundant assignment to variable 'end'
Date:   Fri, 22 Apr 2022 12:04:18 +0100
Message-Id: <20220422110418.1264778-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

Variable end is being initialized with a value that is never read, it
is being re-assigned later with the same value. The initialization is
redundant and can be removed.

Cleans up clang scan build warning:
kernel/irq/matrix.c:289:25: warning: Value stored to 'end' during its
initialization is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 kernel/irq/matrix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/matrix.c b/kernel/irq/matrix.c
index bbfb26489aa1..1698e77645ac 100644
--- a/kernel/irq/matrix.c
+++ b/kernel/irq/matrix.c
@@ -286,7 +286,7 @@ void irq_matrix_remove_managed(struct irq_matrix *m, const struct cpumask *msk)
 int irq_matrix_alloc_managed(struct irq_matrix *m, const struct cpumask *msk,
 			     unsigned int *mapped_cpu)
 {
-	unsigned int bit, cpu, end = m->alloc_end;
+	unsigned int bit, cpu, end;
 	struct cpumap *cm;
 
 	if (cpumask_empty(msk))
-- 
2.35.1

