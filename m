Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 829A8587539
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 03:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235608AbiHBBw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 21:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235596AbiHBBwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 21:52:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD3A48CBC;
        Mon,  1 Aug 2022 18:52:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF8C861083;
        Tue,  2 Aug 2022 01:52:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F78EC433B5;
        Tue,  2 Aug 2022 01:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659405120;
        bh=59TymRezo4AowK7BYVDr168MBiVlGWeji5p02ankQ3A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OhMjMUVSnExbAiphhJuOmteyMAD8UK8qKnI76JZjTcj4qm7UDrmjKhdqxDA31G1X5
         s2VJuUoLD+HQ+pr5wM3QWL9H/SF20/CIgaTcLVfwwIfK6C4S8HoE4pXO45y71Kq3i8
         lfCWk2wXPhm26ZubpAf7ohEoA+E5VMRXReCeD22ltIsZHbZ5eNSNGNSd3HGX0VlZxd
         LcCRirFJt+pBDsVbncbMarzZZTbp9lvhks6xNIsuFPYBMgmV5CYPhb0s+O3LqNpu3S
         wWFzgx5zLSW14nRP+gg6H/vHpuw1/IxZdrizTHLH93/SyK4MalTMzubeobO+pnNlgJ
         17v1xvibEolcg==
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
Subject: [PATCH v8 08/31] locking/spinlock: introduce `_raw_spin_lock_init`
Date:   Tue,  2 Aug 2022 03:49:55 +0200
Message-Id: <20220802015052.10452-9-ojeda@kernel.org>
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
`raw_spin_lock_init` with a passed key, rather than define
one in place.

In order to do that, this changes the `raw_spin_lock_init` macro
to call a new `_raw_spin_lock_init` function which takes the key
as an extra parameter.

Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
Co-developed-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 include/linux/spinlock.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index ad1c91884ed8..27df5380c1e4 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -99,11 +99,17 @@
   extern void __raw_spin_lock_init(raw_spinlock_t *lock, const char *name,
 				   struct lock_class_key *key, short inner);
 
+static inline void _raw_spin_lock_init(raw_spinlock_t *lock, const char *name,
+				       struct lock_class_key *key)
+{
+	__raw_spin_lock_init(lock, name, key, LD_WAIT_SPIN);
+}
+
 # define raw_spin_lock_init(lock)					\
 do {									\
 	static struct lock_class_key __key;				\
 									\
-	__raw_spin_lock_init((lock), #lock, &__key, LD_WAIT_SPIN);	\
+	_raw_spin_lock_init((lock), #lock, &__key);			\
 } while (0)
 
 #else
-- 
2.37.1

