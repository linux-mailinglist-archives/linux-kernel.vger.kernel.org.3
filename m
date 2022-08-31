Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944EC5A84FE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232313AbiHaSG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232143AbiHaSGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:06:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8072AE395B;
        Wed, 31 Aug 2022 11:06:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E40D61C11;
        Wed, 31 Aug 2022 18:06:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1410C433B5;
        Wed, 31 Aug 2022 18:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661969187;
        bh=kpYKwMnffVl1nsj+jg2r15lnrXjU997U2XZSk+XwMCw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lcosIxom1w6n589swGSjYVyxOy0WWlOjPSWmLPz1RWc3RBFuybkPWoKbGBI7pclgg
         ZUquTdoerz5JsV2KTDpU2POTgRcVft49OhyFWjOZR3R4/dMv/Qfu2q76pxImQBiQFF
         ygql/vhgJHuJodsJ2ktyjDZuzoD0An0gAuLble+w2ufEuFSP2hqgGtuhMxDO72xUsP
         VfLaqgfxm54gv4hleGgkuCY4nX/4MZWZYFA0BOhSet7EAGkqVJ5V/afy+f8moocxVY
         nv5gcMjGYM00uop1FL/hDR7Y4uBRpu2J+KdduUEUatbydnjHd6FnUGX3kf4wwdTLHx
         tqg3H0yb5x1wQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 091545C090A; Wed, 31 Aug 2022 11:06:27 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 6/7] doc: SLAB_TYPESAFE_BY_RCU uses cannot rely on spinlocks
Date:   Wed, 31 Aug 2022 11:06:24 -0700
Message-Id: <20220831180625.2692892-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220831180617.GA2692480@paulmck-ThinkPad-P17-Gen-1>
References: <20220831180617.GA2692480@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because the SLAB_TYPESAFE_BY_RCU code does not zero pages that are
to be broken up into slabs, the memory returned by kmem_cache_alloc()
must be fully initialized, including any spinlocks included in the newly
allocated structure.  This means that readers attempting to look up an
SLAB_TYPESAFE_BY_RCU object must use a reference-counting approach.
A spinlock may be acquired only after a reference is obtained, which
prevents that object from being passed to kmem_struct_free(), but only
while that reference continues to be held.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/whatisRCU.rst | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/Documentation/RCU/whatisRCU.rst b/Documentation/RCU/whatisRCU.rst
index 6940e0fe8599b..97f2d0fa84dfa 100644
--- a/Documentation/RCU/whatisRCU.rst
+++ b/Documentation/RCU/whatisRCU.rst
@@ -915,13 +915,18 @@ which an RCU reference is held include:
 The understanding that RCU provides a reference that only prevents a
 change of type is particularly visible with objects allocated from a
 slab cache marked ``SLAB_TYPESAFE_BY_RCU``.  RCU operations may yield a
-reference to an object from such a cache that has been concurrently
-freed and the memory reallocated to a completely different object,
-though of the same type.  In this case RCU doesn't even protect the
-identity of the object from changing, only its type.  So the object
-found may not be the one expected, but it will be one where it is safe
-to take a reference or spinlock and then confirm that the identity
-matches the expectations.
+reference to an object from such a cache that has been concurrently freed
+and the memory reallocated to a completely different object, though of
+the same type.  In this case RCU doesn't even protect the identity of the
+object from changing, only its type.  So the object found may not be the
+one expected, but it will be one where it is safe to take a reference
+(and then potentially acquiring a spinlock), allowing subsequent code
+to check whether the identity matches expectations.  It is tempting
+to simply acquire the spinlock without first taking the reference, but
+unfortunately any spinlock in a ``SLAB_TYPESAFE_BY_RCU`` object must be
+initialized after each and every call to kmem_cache_alloc(), which renders
+reference-free spinlock acquisition completely unsafe.  Therefore, when
+using ``SLAB_TYPESAFE_BY_RCU``, make proper use of a reference counter.
 
 With traditional reference counting -- such as that implemented by the
 kref library in Linux -- there is typically code that runs when the last
-- 
2.31.1.189.g2e36527f23

