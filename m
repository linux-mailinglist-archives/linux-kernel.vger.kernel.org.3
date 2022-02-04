Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93C9B4AA405
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 00:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377959AbiBDXIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 18:08:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234736AbiBDXII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 18:08:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19FBDF99CDC;
        Fri,  4 Feb 2022 15:08:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 812D961B9C;
        Fri,  4 Feb 2022 23:08:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D30CDC340EF;
        Fri,  4 Feb 2022 23:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644016086;
        bh=oGrMHn07x9XfkVQxwaEWPiDvFUjbNzIN/CwooO7F/ew=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QvcWvQ5U8uCqJRP4iTgCQNvSdUEH+kJiQdkYsoBOsDZ4WjPJ+x/+PJUjTLpkuhmAF
         hAqz4amEGFBL0MD+pYhLVKGjXEAVL8x/IO8/3mgsYaz4bq+JjMu7UiEYRgy1ROe8xo
         NrdWFtzIamgg/3Ygkwt5A+iv3ytCwJdUOLpFsg1nglJBgBGso6bY2wI3+IbBMh0Kc1
         4hcLDSvLifEcTAyjOWwpPIhc0bt03O0TF6BKh7XiUilIHArVTO9Lxd9zwAe5OwVT/m
         GM9kEowtj5TqTk3PauqhXrqSpzW1rqmLzXwqtzD9bwJML//JIGh5TwfHufDqyrPE94
         y5J6z/1ALTlpA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 98CC65C0829; Fri,  4 Feb 2022 15:08:06 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 2/9] rcu: Fix description of kvfree_rcu()
Date:   Fri,  4 Feb 2022 15:07:58 -0800
Message-Id: <20220204230805.4193767-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220204230751.GA4193671@paulmck-ThinkPad-P17-Gen-1>
References: <20220204230751.GA4193671@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>

The kvfree_rcu() header comment's description of the "ptr" parameter
is unclear, therefore rephrase it to make it clear that it is a pointer
to the memory to eventually be passed to kvfree().

Reported-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcupdate.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 88b42eb464068..9d7df8d36af07 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -924,7 +924,7 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
  *
  *     kvfree_rcu(ptr);
  *
- * where @ptr is a pointer to kvfree().
+ * where @ptr is the pointer to be freed by kvfree().
  *
  * Please note, head-less way of freeing is permitted to
  * use from a context that has to follow might_sleep()
-- 
2.31.1.189.g2e36527f23

