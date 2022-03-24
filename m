Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5EF4E67F1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 18:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352353AbiCXRlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 13:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352327AbiCXRlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 13:41:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53EDC887A4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 10:39:45 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1648143584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sqozYXnqHX0EsWoXfQvZzN68iU7pMU+FQPHZRVNv12s=;
        b=K17dgMFuo4ar6ml8TOh8B80I5sifIsv3CQ1mJLO28r4DPnuGPskL1FhoBA2+uyjta5Y3TN
        CVS6kIoWlz8TuGCO0bnbsKUbVadvacN6Bn4s4KBZ/wdanhYtlGH/YKiEjMVNn++9VZap6q
        Sp/IdjRf+P0sg4xtnNMkLSI3FgSo6aG+FVtPOb5fS2ziLHwq2HuWBDrU5/FtYxuD4cCTgr
        8Ak52Iie6xJ6hkQupYDIyCoLjnw3fU3MdTWDRjFVM8TjrIdXz01l678Hd5Sf8KvgHx4GPc
        zECXuwngRdgaBm5UYpFub1rsTVH0jdWFolFEzmq2SBO6UE/LliwI+CQG25UhDQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1648143584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sqozYXnqHX0EsWoXfQvZzN68iU7pMU+FQPHZRVNv12s=;
        b=hHpUYOYHXRjOHhW6btjl3H7cLf8hnEg1m6mErJ9CGZc7xba4x2VO4VyYn19tm+JfOW6fcf
        9LM6RCr25g3I0sDA==
To:     torvalds@linux-foundation.org
Cc:     akpm@linux-foundation.org, bigeasy@linutronix.de,
        boqun.feng@gmail.com, bp@alien8.de, linux-kernel@vger.kernel.org,
        longman@redhat.com, mingo@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, will@kernel.org,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>
Subject: [PATCH 3/3] Revert "mm/page_alloc: mark pagesets as __maybe_unused"
Date:   Thu, 24 Mar 2022 18:39:27 +0100
Message-Id: <20220324173927.2230447-4-bigeasy@linutronix.de>
In-Reply-To: <20220324173927.2230447-1-bigeasy@linutronix.de>
References: <CAHk-=wh81PAKxapicYOby3WWOFJV2htR5KWCRdKNgw68mOc0Zg@mail.gmail.com>
 <20220324173927.2230447-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The local_lock() is now using a proper static inline function which is
enough for llvm to accept that the variable is used.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 mm/page_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 6e0b4596cde9b..8f83e9929c7d2 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -128,7 +128,7 @@ static DEFINE_MUTEX(pcp_batch_high_lock);
 struct pagesets {
 	local_lock_t lock;
 };
-static DEFINE_PER_CPU(struct pagesets, pagesets) __maybe_unused =3D {
+static DEFINE_PER_CPU(struct pagesets, pagesets) =3D {
 	.lock =3D INIT_LOCAL_LOCK(lock),
 };
=20
--=20
2.35.1

