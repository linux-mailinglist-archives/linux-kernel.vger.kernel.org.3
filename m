Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 457104AA475
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 00:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378357AbiBDXjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 18:39:23 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:47900 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378235AbiBDXjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 18:39:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73FF761CAF;
        Fri,  4 Feb 2022 23:39:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C936C34107;
        Fri,  4 Feb 2022 23:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644017944;
        bh=fIwHLIzRVHxcHsAxuneAYdfjPuEOFZXTqbxd4AMS7xs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L4/BtovDZUIEjpWVSFR5ZCHl1jn7TXZvk8AogxvhS70GdwNHAQeXwRgrPmsLEjzmM
         qNgKrdPTuicRul4l6laB8ANcoOgXi16jlPWXlRiiXxa4wdhWkmedhm7qL7SKKTXJSE
         S2TRjfvQiR5tOzXtR6rA7HegO7quW6x9bhxrQiGEg33Jrr21T6lqqRlb2Wrti0UmTu
         x0OI6rML3+NvSuIC6NvXuJn6gWkzJT9cCcC2fdoR2QDeAacT1y9PAqscsRy/xvdVpX
         ihSKwxqwd4vnO4SJ1ihg4pK1sGmIVbnEMKUNRHvLwnQx8zsO6dnEbE97QUECr3Vl/0
         ls/XlK88bmUgQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 124125C1234; Fri,  4 Feb 2022 15:39:04 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 17/19] srcu: Make srcu_size_state_name static
Date:   Fri,  4 Feb 2022 15:39:00 -0800
Message-Id: <20220204233902.1902-17-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220204233858.GA1469@paulmck-ThinkPad-P17-Gen-1>
References: <20220204233858.GA1469@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

This symbol is not used outside of srcutree.c, so this commit marks it static.

Doing so fixes the following sparse warning:

kernel/rcu/srcutree.c:1426:12: warning: symbol 'srcu_size_state_name'
was not declared. Should it be static?

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 1d72c7e3c33b5..f13e84ecbca6a 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1512,7 +1512,7 @@ void srcutorture_get_gp_data(enum rcutorture_type test_type,
 }
 EXPORT_SYMBOL_GPL(srcutorture_get_gp_data);
 
-const char * const srcu_size_state_name[] =
+static const char * const srcu_size_state_name[] =
 {
 	"SRCU_SIZE_SMALL",
 	"SRCU_SIZE_ALLOC",
-- 
2.31.1.189.g2e36527f23

