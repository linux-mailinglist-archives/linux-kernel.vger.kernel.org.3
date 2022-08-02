Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351D4587538
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 03:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235655AbiHBBwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 21:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235538AbiHBBwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 21:52:16 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF69D459BA;
        Mon,  1 Aug 2022 18:51:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id BAB20CE19F4;
        Tue,  2 Aug 2022 01:51:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F04A1C433D6;
        Tue,  2 Aug 2022 01:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659405116;
        bh=Fw0Ia1iEfR3XQXeyNPpl1I2TsQCvoh0210MCyVioh0Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WfJdhsjFIO2nL6Da4nDBoErNNC4vh+je7JLmNT3OVa0AjEXyhfp7TI50Ge95RU/mg
         XnFREnFCCtWCZH7ywC1Y2ffO+1itSx2/Tm8YPPiro5SPmNpP98dB6C8QuVASEsxxfq
         WjugVkpSD9dXVd3EbeDFegUAFLsZqzJxmKzSMN3JkfZ7173Qu1jV7wVcu77dcITFAL
         cJqHZTMRQk8v5TIhzRybezgYRhhwTaL0yPdhE0uadkOMgDni2EiYn9xEwl0sOvk7T0
         Pi7GZdanYh9fdhfWi/F7beqQhrkSNIszKUDBm4vICu4bkkbtYmcaIyqGvE4mJ/tqiG
         kNzAKMvq92e9w==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH v8 07/31] locking/spinlock: introduce `__spin_lock_init`
Date:   Tue,  2 Aug 2022 03:49:54 +0200
Message-Id: <20220802015052.10452-8-ojeda@kernel.org>
In-Reply-To: <20220802015052.10452-1-ojeda@kernel.org>
References: <20220802015052.10452-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wedson Almeida Filho <wedsonaf@google.com>

A Rust helper (introduced in a later patch) needs to call
`spin_lock_init` with a passed key, rather than define
one in place.

In order to do that, this changes the `spin_lock_init` macro
to call a new `__spin_lock_init` function which takes the key
as an extra parameter.

Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
Co-developed-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 include/linux/spinlock.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index 5c0c5174155d..ad1c91884ed8 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -326,12 +326,17 @@ static __always_inline raw_spinlock_t *spinlock_check(spinlock_t *lock)
 
 #ifdef CONFIG_DEBUG_SPINLOCK
 
+static inline void __spin_lock_init(spinlock_t *lock, const char *name,
+				    struct lock_class_key *key)
+{
+	__raw_spin_lock_init(spinlock_check(lock), name, key, LD_WAIT_CONFIG);
+}
+
 # define spin_lock_init(lock)					\
 do {								\
 	static struct lock_class_key __key;			\
 								\
-	__raw_spin_lock_init(spinlock_check(lock),		\
-			     #lock, &__key, LD_WAIT_CONFIG);	\
+	__spin_lock_init(lock, #lock, &__key);			\
 } while (0)
 
 #else
-- 
2.37.1

