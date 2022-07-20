Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F39757BB6B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 18:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233196AbiGTQ35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 12:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbiGTQ3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 12:29:54 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB5A643DB
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 09:29:52 -0700 (PDT)
Date:   Wed, 20 Jul 2022 09:29:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1658334590;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oIF8C4tLXhUvOb04ANxj7OtA+px5pKcxAabhLuX/vYg=;
        b=QLCe9BJ5Pv8NRxMO6iDcnY/G8grMnld0cTNXt8qdYp12/Np3SLU1HlzYx9cpcTQVm3si+x
        23W378OyWAPo+t7o8b+azii7ZV+csFMQba6JxDqkW80jxln7BEhqhZeSMbOoWwVtC98LAG
        BI6NzSwdTZgSWEmTPEpeOQ3c6w5RGA0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: shrinkers: fix double kfree on shrinker name
Message-ID: <YtgteTnQTgyuKUSY@castle>
References: <ffa62ece-6a42-2644-16cf-0d33ef32c676@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ffa62ece-6a42-2644-16cf-0d33ef32c676@I-love.SAKURA.ne.jp>
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

On Wed, Jul 20, 2022 at 11:47:55PM +0900, Tetsuo Handa wrote:
> syzbot is reporting double kfree() at free_prealloced_shrinker() [1], for
> destroy_unused_super() calls free_prealloced_shrinker() even if
> prealloc_shrinker() returned an error. Explicitly clear shrinker name
> when prealloc_shrinker() called kfree().
> 
> Link: https://syzkaller.appspot.com/bug?extid=8b481578352d4637f510 [1]
> Reported-by: syzbot <syzbot+8b481578352d4637f510@syzkaller.appspotmail.com>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Fixes: e33c267ab70de424 ("mm: shrinkers: provide shrinkers with names")

Hi Tetsuo!

Thank you for the fix! It looks good to me, however I think we should go a bit
further and and zero shrinker->name in all 4 cases where shrinker->name is
freed (an example code below).

Please, feel free to add my ack:
Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks!

---
 mm/shrinker_debug.c | 1 +
 mm/vmscan.c         | 9 +++++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/mm/shrinker_debug.c b/mm/shrinker_debug.c
index e5b40c43221d..b05295bab322 100644
--- a/mm/shrinker_debug.c
+++ b/mm/shrinker_debug.c
@@ -251,6 +251,7 @@ void shrinker_debugfs_remove(struct shrinker *shrinker)
 	lockdep_assert_held(&shrinker_rwsem);
 
 	kfree_const(shrinker->name);
+	shrinker->name = NULL;
 
 	if (!shrinker->debugfs_entry)
 		return;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 8fa03fb5c5c1..9e7d8db42918 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -647,8 +647,10 @@ int prealloc_shrinker(struct shrinker *shrinker, const char *fmt, ...)
 		return -ENOMEM;
 
 	err = __prealloc_shrinker(shrinker);
-	if (err)
+	if (err) {
 		kfree_const(shrinker->name);
+		shrinker->name = NULL;
+	}
 
 	return err;
 }
@@ -663,6 +665,7 @@ void free_prealloced_shrinker(struct shrinker *shrinker)
 {
 #ifdef CONFIG_SHRINKER_DEBUG
 	kfree_const(shrinker->name);
+	shrinker->name = NULL;
 #endif
 	if (shrinker->flags & SHRINKER_MEMCG_AWARE) {
 		down_write(&shrinker_rwsem);
@@ -707,8 +710,10 @@ int register_shrinker(struct shrinker *shrinker, const char *fmt, ...)
 		return -ENOMEM;
 
 	err = __register_shrinker(shrinker);
-	if (err)
+	if (err) {
 		kfree_const(shrinker->name);
+		shrinker->name = NULL;
+	}
 	return err;
 }
 #else
-- 
2.36.1

