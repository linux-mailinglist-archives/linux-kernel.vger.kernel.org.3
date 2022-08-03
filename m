Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1D91588753
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 08:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237056AbiHCGZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 02:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbiHCGZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 02:25:02 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197664A80F;
        Tue,  2 Aug 2022 23:25:01 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1659507899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=OzId+F46IaLnzWfW2BSyAFKdP9KBL4ckAbH6G9go3O4=;
        b=OMxCPuEpWoKH0M7VnBlll4RRmC3J3I0AfRjI5zOVDD0kApvjp9qzWgzmlmL79DzkYio6+f
        bw3LkESEBOWdqawAyOULKoBJQzX7572bml5HNNa2Ct8ipaSKYTTxz4DB9tYBlRmeHD56dt
        tiEQeMbBY8zEfjfW9UNONnVxZHRbzIg=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        bigeasy@linutronix.de
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH 5.10-rt] locking/rtmutex: switch to EXPORT_SYMBOL() for ww_mutex_lock{,_interruptible}()
Date:   Wed,  3 Aug 2022 14:24:30 +0800
Message-Id: <20220803062430.1307312-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can use EXPORT_SYMBOL() instead of EXPORT_SYMBOL_GPL() in
ww_mutex_lock_interruptible() and ww_mutex_lock(). That match
ww_mutex_unlock() well. And also good for 3rd kernel modules.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 kernel/locking/rtmutex.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 31b374d36d04..b110fc57f733 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -2513,7 +2513,7 @@ ww_mutex_lock_interruptible(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(ww_mutex_lock_interruptible);
+EXPORT_SYMBOL(ww_mutex_lock_interruptible);
 
 int __sched
 ww_mutex_lock(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
@@ -2533,7 +2533,7 @@ ww_mutex_lock(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(ww_mutex_lock);
+EXPORT_SYMBOL(ww_mutex_lock);
 
 void __sched ww_mutex_unlock(struct ww_mutex *lock)
 {
-- 
2.25.1

