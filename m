Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 573764F2BED
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 13:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354595AbiDEKOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 06:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241157AbiDEIcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:32:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3447E165A8;
        Tue,  5 Apr 2022 01:28:57 -0700 (PDT)
Date:   Tue, 05 Apr 2022 08:28:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649147335;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oVHWhjMftF/LEuPWxtLPZ5M8sn8Gmtt2r0kEYlkYSIE=;
        b=f3Yohau+hyHlgaF1VsU14KBQ5Wab+cMxXADSgud/bcQwyMrcooRdBHE+rKjtXtTlYXbl0o
        lnI3vCnJdkA88Uroi27KX6OvZoexcJ/+iUSJQd3Q/2eoWv9IROF+mUci7ba2ys0iVJGFkf
        SEndYsz+Gfehrs6bdLF0xb49dhevd4TEKN3E6l9PuXXIxcayYB7HFo7MEw5ZKEaMrtX8n2
        +llx3++CPS/sPP7JAagXB0AO+JW5J37clhIgnG1KsER47eiIQayZSHIuz6Qt23TnRX8VcZ
        FnduGJEylzBRXoZLEtYxi4yY4NZt/6nJgGKBJ2AT72FXz8FJMnV1BpKObuNLYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649147335;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oVHWhjMftF/LEuPWxtLPZ5M8sn8Gmtt2r0kEYlkYSIE=;
        b=BQRDD3TPGKsudoQNaCEiiz1Si2IWkOzC39JrO+jnhicMRMw3pCKwq15l4Y7L5sp+sEfpw4
        frsjzMFOK0wXVeDw==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] Revert "mm/page_alloc: mark pagesets as __maybe_unused"
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220328145810.86783-4-bigeasy@linutronix.de>
References: <20220328145810.86783-4-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <164914733438.389.6056031728611068498.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     273ba85b5e8b971ed28eb5c17e1638543be9237d
Gitweb:        https://git.kernel.org/tip/273ba85b5e8b971ed28eb5c17e1638543be9237d
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Mon, 28 Mar 2022 16:58:10 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 05 Apr 2022 09:59:39 +02:00

Revert "mm/page_alloc: mark pagesets as __maybe_unused"

The local_lock() is now using a proper static inline function which is
enough for llvm to accept that the variable is used.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220328145810.86783-4-bigeasy@linutronix.de
---
 mm/page_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2db9578..6e5b448 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -128,7 +128,7 @@ static DEFINE_MUTEX(pcp_batch_high_lock);
 struct pagesets {
 	local_lock_t lock;
 };
-static DEFINE_PER_CPU(struct pagesets, pagesets) __maybe_unused = {
+static DEFINE_PER_CPU(struct pagesets, pagesets) = {
 	.lock = INIT_LOCAL_LOCK(lock),
 };
 
