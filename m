Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFCCB587536
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 03:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235585AbiHBBwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 21:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235532AbiHBBwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 21:52:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8562E48C87;
        Mon,  1 Aug 2022 18:51:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0BC761085;
        Tue,  2 Aug 2022 01:51:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88CB5C433D7;
        Tue,  2 Aug 2022 01:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659405112;
        bh=8ZkynlYQyKINIYvVDmoUlY90LXh1vGqtb0aKnxbwfBE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fXhGRqtRpu72zj7VrpWfhzD9J69bYFX8mKtCcJIrWshqhvJBz05htr29mbu21o0F9
         Sk5LziU6keVk3oMR9EwwnQ/BDUUEdZak91bFJ4CtXVXTvXnAV4RYrfFA9tnVUNLA3V
         qGssLgcJXye/ofJmtTNHGSR9sNbsTmicGH824wMAFA1i1cananQcUySDMo529lgWpx
         DEVrmoVOedvgRFC3CwS08LFU6vh6fRZO7Raqx4U4O8cMkknPwV/WWTgdUhfS0kr6tn
         WwegRxJszQUp28GIHOxhl7l/Aab1WqfMhv45TfMA36Lbe3XV0ewfMLTmyZ1EB8SdUJ
         8jEBtznZBOlSQ==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Alex Gaynor <alex.gaynor@gmail.com>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH v8 06/31] workqueue: introduce `__INIT_WORK_WITH_KEY`
Date:   Tue,  2 Aug 2022 03:49:53 +0200
Message-Id: <20220802015052.10452-7-ojeda@kernel.org>
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
`__INIT_WORK` with a passed key, rather than define one in place.

In order to do that, this moves the initialization code from
the `__INIT_WORK` macro into a new `__INIT_WORK_WITH_KEY` macro
which takes the key as an extra parameter.

Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
Co-developed-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 include/linux/workqueue.h | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 62e75dd40d9a..06c24805e666 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -221,24 +221,31 @@ static inline unsigned int work_static(struct work_struct *work) { return 0; }
  * to generate better code.
  */
 #ifdef CONFIG_LOCKDEP
+#define __INIT_WORK_WITH_KEY(_work, _func, _onstack, _key)		\
+	do {								\
+		__init_work((_work), _onstack);				\
+		(_work)->data = (atomic_long_t) WORK_DATA_INIT();	\
+		lockdep_init_map(&(_work)->lockdep_map, "(work_completion)"#_work, _key, 0); \
+		INIT_LIST_HEAD(&(_work)->entry);			\
+		(_work)->func = (_func);				\
+	} while (0)
+
 #define __INIT_WORK(_work, _func, _onstack)				\
 	do {								\
 		static struct lock_class_key __key;			\
-									\
-		__init_work((_work), _onstack);				\
-		(_work)->data = (atomic_long_t) WORK_DATA_INIT();	\
-		lockdep_init_map(&(_work)->lockdep_map, "(work_completion)"#_work, &__key, 0); \
-		INIT_LIST_HEAD(&(_work)->entry);			\
-		(_work)->func = (_func);				\
+		__INIT_WORK_WITH_KEY(_work, _func, _onstack, &__key);	\
 	} while (0)
 #else
-#define __INIT_WORK(_work, _func, _onstack)				\
+#define __INIT_WORK_WITH_KEY(_work, _func, _onstack, _key)		\
 	do {								\
 		__init_work((_work), _onstack);				\
 		(_work)->data = (atomic_long_t) WORK_DATA_INIT();	\
 		INIT_LIST_HEAD(&(_work)->entry);			\
 		(_work)->func = (_func);				\
 	} while (0)
+
+#define __INIT_WORK(_work, _func, _onstack)				\
+	__INIT_WORK_WITH_KEY(_work, _func, _onstack, NULL)
 #endif
 
 #define INIT_WORK(_work, _func)						\
-- 
2.37.1

