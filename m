Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5A6D4F7AD7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 11:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243547AbiDGJCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 05:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243529AbiDGJCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 05:02:07 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F1911DD18;
        Thu,  7 Apr 2022 02:00:08 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id dr20so9375209ejc.6;
        Thu, 07 Apr 2022 02:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VbFDVmTFBsd/3PPMbLnd0zhFg5hlSy27/q7PHNvEkAU=;
        b=L4OO6eb7ni5fxfWYjcoc1AJlIPg5JcpoXNN12PfSY9eA57qm2EUg5RVLIHGBK3VNbf
         RFHNi0kNwvI9iT+7c0Hb6apznk/SvQ1WsHaKj+i/wYdVG1Hr/cCgFNJHFECCiAcgaIWG
         5kXJmsWr7eM5aFIGc/eV/NlPLgi/riHhwoVbHHqZCFube8OUfza+H5hFgVG3O7CwytrA
         RgunR52+1F2wDi8pSJnOFn0PIJKgJMUxzOHFYYRZKZXjn51LrxUfkcYZjcl+4s7OFvON
         6TSv1XA0xJ9KyafbipSjeswu6Wvq1C64YEh1/5T9Ayq4BH9auU/fHwIO1+1Q2lfPFIo1
         RuVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VbFDVmTFBsd/3PPMbLnd0zhFg5hlSy27/q7PHNvEkAU=;
        b=D++dPA/mSTeSCWj1NiCvyq83mkoXhSeK49GhJurWUrTI6RqWD7bCB/RyvONgbM8OP/
         DE3B1sCJOusjqlNXui8bLl8KibIeNYzGPQQg85V9GSxGJ70J6qApCDf0Y9QQZUirwKzY
         K+DktevV7qGGuREYGzMn+FHWyS3VqhpGSATLvcGfkJc7cQxRz9hvQ8h2d7s0LsUj89KI
         cRKYZSdy9xqYp+sCV5HEkp4sbM+3WNiX0l9tROsYkU1RpmdSK+z/Lolaff84+/bm8HG9
         xagSTOu+R1QuJ4qZlsln0ArDW+64bzUP9g9vPxhpIVVASpTVRxzd4eAWB2nX6GzwWfB+
         cnAQ==
X-Gm-Message-State: AOAM531hZ5wMmO3vYtSiCsm1w26B2DhhFVvKhpTB0lmCY7R3lxfJJP+7
        dq+IGeIkK+3ucCP6+yF8SHo=
X-Google-Smtp-Source: ABdhPJwcwlCuBQZ5LEDFL+WbGTxNe8cavosIh6OlGUwJxIjCDdIzBgTE+UAYL0o8qUk83C1jHYYuYw==
X-Received: by 2002:a17:906:9397:b0:6e7:eb3a:ec2d with SMTP id l23-20020a170906939700b006e7eb3aec2dmr12172316ejx.257.1649322006685;
        Thu, 07 Apr 2022 02:00:06 -0700 (PDT)
Received: from able.fritz.box (p57b0b9e1.dip0.t-ipconnect.de. [87.176.185.225])
        by smtp.gmail.com with ESMTPSA id h26-20020a170906111a00b006e778bd4fc8sm5186563eja.38.2022.04.07.02.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 02:00:06 -0700 (PDT)
From:   "=?UTF-8?q?Christian=20K=C3=B6nig?=" 
        <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
To:     daniel.vetter@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        intel-gfx@lists.freedesktop.org
Cc:     =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 15/15] seqlock: drop seqcount_ww_mutex_t
Date:   Thu,  7 Apr 2022 10:59:46 +0200
Message-Id: <20220407085946.744568-16-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220407085946.744568-1-christian.koenig@amd.com>
References: <20220407085946.744568-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Daniel pointed out that this series removes the last user of
seqcount_ww_mutex_t, so let's drop this.

Signed-off-by: Christian König <christian.koenig@amd.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org
---
 include/linux/seqlock.h | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 37ded6b8fee6..3926e9027947 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -17,7 +17,6 @@
 #include <linux/kcsan-checks.h>
 #include <linux/lockdep.h>
 #include <linux/mutex.h>
-#include <linux/ww_mutex.h>
 #include <linux/preempt.h>
 #include <linux/spinlock.h>
 
@@ -164,7 +163,7 @@ static inline void seqcount_lockdep_reader_access(const seqcount_t *s)
  * static initializer or init function. This enables lockdep to validate
  * that the write side critical section is properly serialized.
  *
- * LOCKNAME:	raw_spinlock, spinlock, rwlock, mutex, or ww_mutex.
+ * LOCKNAME:	raw_spinlock, spinlock, rwlock or mutex
  */
 
 /*
@@ -184,7 +183,6 @@ static inline void seqcount_lockdep_reader_access(const seqcount_t *s)
 #define seqcount_spinlock_init(s, lock)		seqcount_LOCKNAME_init(s, lock, spinlock)
 #define seqcount_rwlock_init(s, lock)		seqcount_LOCKNAME_init(s, lock, rwlock)
 #define seqcount_mutex_init(s, lock)		seqcount_LOCKNAME_init(s, lock, mutex)
-#define seqcount_ww_mutex_init(s, lock)		seqcount_LOCKNAME_init(s, lock, ww_mutex)
 
 /*
  * SEQCOUNT_LOCKNAME()	- Instantiate seqcount_LOCKNAME_t and helpers
@@ -277,7 +275,6 @@ SEQCOUNT_LOCKNAME(raw_spinlock, raw_spinlock_t,  false,    s->lock,        raw_s
 SEQCOUNT_LOCKNAME(spinlock,     spinlock_t,      __SEQ_RT, s->lock,        spin,     spin_lock(s->lock))
 SEQCOUNT_LOCKNAME(rwlock,       rwlock_t,        __SEQ_RT, s->lock,        read,     read_lock(s->lock))
 SEQCOUNT_LOCKNAME(mutex,        struct mutex,    true,     s->lock,        mutex,    mutex_lock(s->lock))
-SEQCOUNT_LOCKNAME(ww_mutex,     struct ww_mutex, true,     &s->lock->base, ww_mutex, ww_mutex_lock(s->lock, NULL))
 
 /*
  * SEQCNT_LOCKNAME_ZERO - static initializer for seqcount_LOCKNAME_t
@@ -304,8 +301,7 @@ SEQCOUNT_LOCKNAME(ww_mutex,     struct ww_mutex, true,     &s->lock->base, ww_mu
 	__seqprop_case((s),	raw_spinlock,	prop),			\
 	__seqprop_case((s),	spinlock,	prop),			\
 	__seqprop_case((s),	rwlock,		prop),			\
-	__seqprop_case((s),	mutex,		prop),			\
-	__seqprop_case((s),	ww_mutex,	prop))
+	__seqprop_case((s),	mutex,		prop))
 
 #define seqprop_ptr(s)			__seqprop(s, ptr)
 #define seqprop_sequence(s)		__seqprop(s, sequence)
-- 
2.25.1

