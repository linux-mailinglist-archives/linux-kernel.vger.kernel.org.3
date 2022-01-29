Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5832E4A2B81
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 04:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352207AbiA2Dp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 22:45:29 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:49607 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238931AbiA2Dp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 22:45:27 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0V35CZvv_1643427916;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0V35CZvv_1643427916)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 29 Jan 2022 11:45:21 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     jiangshanlai@gmail.com
Cc:     paulmck@kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] srcu: make srcu_size_state_name static
Date:   Sat, 29 Jan 2022 11:45:02 +0800
Message-Id: <20220129034502.73912-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This symbol is not used outside of srcutree.c, so marks it static.

Fixes the following sparse warning:

kernel/rcu/srcutree.c:1426:12: warning: symbol 'srcu_size_state_name'
was not declared. Should it be static?

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 kernel/rcu/srcutree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 4201815744d8..31dbd41332f6 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1423,7 +1423,7 @@ void srcutorture_get_gp_data(enum rcutorture_type test_type,
 }
 EXPORT_SYMBOL_GPL(srcutorture_get_gp_data);
 
-const char * const srcu_size_state_name[] =
+static const char * const srcu_size_state_name[] =
 {
 	"SRCU_SIZE_SMALL",
 	"SRCU_SIZE_ALLOC",
-- 
2.20.1.7.g153144c

