Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F55D556EAA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 00:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359700AbiFVWvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 18:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235515AbiFVWvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 18:51:42 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6717040A3E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 15:51:41 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id cs6so22935352qvb.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 15:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K8zLqAuQGGInMEO/tC5oFW9jqhiZEM0UzbeIkjAgT/E=;
        b=u6ATeb3gtaca1zArGlTV20bvGnJYCnyGi0lrVTh4JYP4rTbIjKfKdeM9RDdwdI9RAi
         ujrJtVDrjaCtmGg5lfrv26gOYUGzGdvprVDIpOwUgQm35vlAlgg6z/uQvruLfpgAqFnf
         LBh4FHH8YPXW9tWhspYhEKaA5r2GbBI4MSxtM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K8zLqAuQGGInMEO/tC5oFW9jqhiZEM0UzbeIkjAgT/E=;
        b=7wwznK2J8JpW32YcTuzA5tkJud5ivcNl9OSgmtfu1zJAHhBbaBRsa68lCsFk30d5ox
         7Q8d8t1OxV7jKLkZL/rbQDlyuCLqH4iDUN07SYqwMgMs8GxPyfoc1INCwOvR1qPBBv5L
         UQdBXyXcnz07KD13+sSCBirNCHOOxzlQv0OBKfBH8injJawKKLYApQi458DaHpcLNzWO
         VAhUSu/Hpzp8e6zbO0mXb/KDS1pOHuq8QZ9YOyT4u+T3QKcksJn7NZhkBpBAt3ZJW5Qa
         VsGxR0oUJATQ8PBXWdPjExoQ2Rwq4c0El7jhnq8r2dGqrBUAE3WqzHXs06+e81nFQDr5
         t0Yw==
X-Gm-Message-State: AJIora8CKGmK+3RIpdy9RzlDgaKOda3+npkTOTGWL+fE6WwTIULCnEiI
        cabHiYMG92UlgaYGdybPIhnJEA==
X-Google-Smtp-Source: AGRyM1vNLmCVtta0shMDBQ0BoHzenJeOoo6ATvfQjsRBrP8Iu05+Inum8C5HKWzZ9QzXs2v3TExN7g==
X-Received: by 2002:a05:6214:2501:b0:470:3f6d:c075 with SMTP id gf1-20020a056214250100b004703f6dc075mr16486903qvb.95.1655938300584;
        Wed, 22 Jun 2022 15:51:40 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id k66-20020a37a145000000b006ab91fd03fasm1794022qke.19.2022.06.22.15.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 15:51:39 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org, vineeth@bitbyteword.org,
        Marco Elver <elver@google.com>
Subject: [PATCH v2 1/1] context_tracking: Use arch_atomic_read() in __ct_state for KASAN
Date:   Wed, 22 Jun 2022 22:50:54 +0000
Message-Id: <20220622225102.2112026-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.37.0.rc0.104.g0611611a94-goog
In-Reply-To: <20220622225102.2112026-1-joel@joelfernandes.org>
References: <20220622225102.2112026-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Context tracking's __ct_state() function can be invoked from noinstr state
where RCU is not watching.  This means that its use of atomic_read()
causes KASAN to invoke the non-noinstr __kasan_check_read() function
from the noinstr function __ct_state().  This is problematic because
someone tracing the __kasan_check_read() function could get a nasty
surprise because of RCU not watching.

This commit therefore replaces the __ct_state() function's use of
atomic_read() with arch_atomic_read(), which KASAN does not attempt to
add instrumention to.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Marco Elver <elver@google.com>
Reviewed-by: Marco Elver <elver@google.com>
---
 include/linux/context_tracking_state.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/context_tracking_state.h b/include/linux/context_tracking_state.h
index 0aecc07fb4f5..81c51e5f0314 100644
--- a/include/linux/context_tracking_state.h
+++ b/include/linux/context_tracking_state.h
@@ -49,7 +49,7 @@ DECLARE_PER_CPU(struct context_tracking, context_tracking);
 
 static __always_inline int __ct_state(void)
 {
-	return atomic_read(this_cpu_ptr(&context_tracking.state)) & CT_STATE_MASK;
+	return arch_atomic_read(this_cpu_ptr(&context_tracking.state)) & CT_STATE_MASK;
 }
 #endif
 
-- 
2.37.0.rc0.104.g0611611a94-goog

