Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B941D4DBC90
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 02:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350347AbiCQBmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 21:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235641AbiCQBmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 21:42:03 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE5110FE6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 18:40:47 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0V7PClT8_1647481244;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V7PClT8_1647481244)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 17 Mar 2022 09:40:44 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     arve@android.com
Cc:     tkjos@android.com, maco@android.com, joel@joelfernandes.org,
        brauner@kernel.org, hridya@google.com, surenb@google.com,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] binder: Fix some kernel-doc comments
Date:   Thu, 17 Mar 2022 09:40:42 +0800
Message-Id: <20220317014042.126282-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove some warnings found by running scripts/kernel-doc,
which is caused by using 'make W=1'.

drivers/android/binder.c:1155: warning: expecting prototype for
binder_dec_ref(). Prototype was for binder_dec_ref_olocked() instead
drivers/android/binder.c:2683: warning: Function parameter or member
'procp' not described in 'binder_get_node_refs_for_txn'
drivers/android/binder.c:2683: warning: Excess function parameter 'proc'
description in 'binder_get_node_refs_for_txn'

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/android/binder.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 8351c5638880..65e8145e6170 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -1143,7 +1143,7 @@ static int binder_inc_ref_olocked(struct binder_ref *ref, int strong,
 }
 
 /**
- * binder_dec_ref() - dec the ref for given handle
+ * binder_dec_ref_olocked() - dec the ref for given handle
  * @ref:	ref to be decremented
  * @strong:	if true, strong decrement, else weak
  *
@@ -2658,7 +2658,7 @@ static int binder_proc_transaction(struct binder_transaction *t,
 /**
  * binder_get_node_refs_for_txn() - Get required refs on node for txn
  * @node:         struct binder_node for which to get refs
- * @proc:         returns @node->proc if valid
+ * @procp:         returns @node->proc if valid
  * @error:        if no @proc then returns BR_DEAD_REPLY
  *
  * User-space normally keeps the node alive when creating a transaction
-- 
2.20.1.7.g153144c

