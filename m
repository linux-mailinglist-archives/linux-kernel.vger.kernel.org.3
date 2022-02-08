Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 161BB4AE110
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 19:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385136AbiBHSmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 13:42:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385145AbiBHSmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 13:42:16 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C765AC06157B
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 10:42:15 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id d187so20395283pfa.10
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 10:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/az7RkqUaZSIeoYuZW+qHEklI+WUcZiVSMlf0uKOOFw=;
        b=qyGzrxWYkcjR9EjdCMY7JyklNmxBpprp+ecWJHJrwG59QRTpk5dwSJl1iTlvN+Aio1
         axlCeZukQjMTgLi9WJw/+XDmDV6YdFYNYM4h7GbFDLDqzUE04ENYp+S79t16HySfB2C8
         KY2jv3Ukg8u+lCttMknubxu++olrKCGQsLdq9GUz4oj58Ux6MG4z81m4xlZ8OhYMAQFn
         XCZPFexwpIqouDYs2QwIyJrxG4POSqeeP7C9KdROfpX1dz8Vl7oTa2sipnQVxzFoplQ+
         CSMSzpTVn42nOjV3Yr4BgKcXpEH694+pKu8Ppj9JgnUOAVpvnoyJ3J+K6XbfCgwHvktz
         PZnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=/az7RkqUaZSIeoYuZW+qHEklI+WUcZiVSMlf0uKOOFw=;
        b=OPZK/9h2UnMZnkbRVzLECZIGNFjYolCASOioohRbJdNtwVWolbGBDiX0NoSyc1TpLN
         I4QZzm41WeWeN4N1zAfsy0KGPrH7MXmA6A9SnYPmGm8G9wDPAqEw9qijzn/ma17JyzDY
         TxH2VXk64CdIpK+sUAlqao3KjfxhNqmcIALSlsN6VDBhWzI97ZpC+QWttVLH/EvcyBQW
         nDD65g2PQQyBy0nxrcVFYHupxCS0TLcgapY02uR4L0gF5x/qtQoIagFMrOI6l696SDlS
         0AS3BUmFEKBXtKA0Pp1tY+oZSaCO+9Vq2bufVIoTE6QgFaZ7smVfeXMPvYKXY7+uGhdr
         yHQg==
X-Gm-Message-State: AOAM5311r3eDZMq+qtGG7tsK6G0LfokS7g/0bvinH8CVNsoqp86TD903
        eanNTnuXdqibL94Z+YUSfLs=
X-Google-Smtp-Source: ABdhPJzSf8azOcibcMQR3hC2U8BwjcmVF8bdrFUc+fFNq39d3azlPmEKvXXHIQzD8nA5B9tqHK9Umw==
X-Received: by 2002:a63:b141:: with SMTP id g1mr4598118pgp.269.1644345735222;
        Tue, 08 Feb 2022 10:42:15 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4800:c6f0:347f:e607:176:4358])
        by smtp.gmail.com with ESMTPSA id l14sm3517027pjf.1.2022.02.08.10.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 10:42:14 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Byungchul Park <byungchul.park@lge.com>,
        "Paul E. McKenney" <paul.mckenney@linaro.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Radoslaw Burny <rburny@google.com>
Subject: [PATCH 01/12] locking: Pass correct outer wait type info
Date:   Tue,  8 Feb 2022 10:41:57 -0800
Message-Id: <20220208184208.79303-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
In-Reply-To: <20220208184208.79303-1-namhyung@kernel.org>
References: <20220208184208.79303-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In lockdep_init_map_wait(), it didn't pass the given outer argument
to lockdep_init_map_type and use LD_WAIT_INV unconditionally.  It
seems like a copy-and-paste bug, let's fix it.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 include/linux/lockdep.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 467b94257105..0cc2b338a006 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -192,7 +192,7 @@ static inline void
 lockdep_init_map_waits(struct lockdep_map *lock, const char *name,
 		       struct lock_class_key *key, int subclass, u8 inner, u8 outer)
 {
-	lockdep_init_map_type(lock, name, key, subclass, inner, LD_WAIT_INV, LD_LOCK_NORMAL);
+	lockdep_init_map_type(lock, name, key, subclass, inner, outer, LD_LOCK_NORMAL);
 }
 
 static inline void
-- 
2.35.0.263.gb82422642f-goog

