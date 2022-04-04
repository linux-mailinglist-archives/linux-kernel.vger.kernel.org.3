Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9BC4F1792
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359808AbiDDOuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378420AbiDDOuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:50:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CDBF5F4D
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:47:57 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649083676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=Hc+PPX5M4MD7sbTwM3c6soY+sh8HaVD6wZyeehgD76o=;
        b=tm2fv/GMfo6WffqxuaqhyObnILkQ9hdlRbLmnmQANijZo3tYvIOAtLd7/ju3oIIUMTDvLY
        v6tHqP/sfeMbd6F6BhcPf+uo+WtH+/f5bOXUYR55nf3osG2sEVDvoxHHYww+snDrtRFOoj
        7UOhCHW4X/eExCyd1IRCol7mg65R71Q9gxZsZxcEMFepudro+21e7Dwv6sTpEWvSrXIa1w
        T83OlqYZ8m/TpqnDru0+iwOeTfFfi92Mpf2Mz+OjrR6+TFt9nm60BpOUtron/d41Zz7kaZ
        BdxJpztYGKD4KDjgUzoY5MmrdE8GfkKNSqIqXGpK2cXMmoCw7/sVOVaaQMx/NA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649083676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=Hc+PPX5M4MD7sbTwM3c6soY+sh8HaVD6wZyeehgD76o=;
        b=dHCIaAemvC3N/Iidsv8X1vO6u/3vD05YNpg/b5ZukBmPVTnWjZTx5BK0PO2UiAzskt240S
        l1OwlcdxISILHJDw==
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Artem Savkov <asavkov@redhat.com>
Subject: timers: Simplify calc_index()
Date:   Mon, 04 Apr 2022 16:47:55 +0200
Message-ID: <87h778j46c.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The level granularity round up of calc_index() does:

   (x + (1 << n)) >> n

which is obviously equivalent to

   (x >> n) + 1

but compilers can't figure that out despite the fact that the input range
is known to not cause an overflow. It's neither intuitive to read.

Just write out the obvious.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/timer.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -502,7 +502,7 @@ static inline unsigned calc_index(unsign
 	 *
 	 * Round up with level granularity to prevent this.
 	 */
-	expires = (expires + LVL_GRAN(lvl)) >> LVL_SHIFT(lvl);
+	expires = (expires >> LVL_SHIFT(lvl)) + 1;
 	*bucket_expiry = expires << LVL_SHIFT(lvl);
 	return LVL_OFFS(lvl) + (expires & LVL_MASK);
 }
