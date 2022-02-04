Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C842E4AA449
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 00:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378128AbiBDXYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 18:24:14 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:45774 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231625AbiBDXYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 18:24:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9C4DCCE24BD;
        Fri,  4 Feb 2022 23:24:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5082C004E1;
        Fri,  4 Feb 2022 23:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644017047;
        bh=om82ARS4XbnxrZfOOyNn+KdAReXpStBVl0i5dOwAfCc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eH9L3qfUwFpU1qxP9tcvZ3+1JxgGPh2mh8iXH8s0bpgBkH1tdPxemeEil2VwEVOjC
         HdGLUveCUhPyU2x4av3UXkvEtNC+XVRwJH59rftrQxBYhMhNwyiO1YMLsS1Z6iJPwv
         ts9IzhUNJxm/d3QROQOqEL2dxfDK3cJSAa11DrnC17j2CxiE1sRwoR23GELmAIBenN
         CI2xbR+R6iLc+boGgk2+xrrxGuFahMB0jDG77hJvp9lA+lGBAVtXp5HuMUb2cODoot
         HGAKbNWurGw9NKub3JMNzT1zxeZuxT3FDflZ7GMhL5X2+zBVUuKj3GNFUn/AibDYdO
         3UuL85/84bhrw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id BDB145C0418; Fri,  4 Feb 2022 15:24:07 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 01/10] rcu: Mark accesses to boost_starttime
Date:   Fri,  4 Feb 2022 15:23:57 -0800
Message-Id: <20220204232406.814-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220204232355.GA728@paulmck-ThinkPad-P17-Gen-1>
References: <20220204232355.GA728@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The boost_starttime shared variable has conflicting unmarked C-language
accesses, which are dangerous at best.  This commit therefore adds
appropriate marking.  This was found by KCSAN.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 422f7e4cc08de..829ae0b7d3c04 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -997,7 +997,7 @@ static int rcu_torture_boost(void *arg)
 			goto checkwait;
 
 		/* Wait for the next test interval. */
-		oldstarttime = boost_starttime;
+		oldstarttime = READ_ONCE(boost_starttime);
 		while (time_before(jiffies, oldstarttime)) {
 			schedule_timeout_interruptible(oldstarttime - jiffies);
 			if (stutter_wait("rcu_torture_boost"))
@@ -1041,10 +1041,11 @@ static int rcu_torture_boost(void *arg)
 		 * interval.  Besides, we are running at RT priority,
 		 * so delays should be relatively rare.
 		 */
-		while (oldstarttime == boost_starttime && !kthread_should_stop()) {
+		while (oldstarttime == READ_ONCE(boost_starttime) && !kthread_should_stop()) {
 			if (mutex_trylock(&boost_mutex)) {
 				if (oldstarttime == boost_starttime) {
-					boost_starttime = jiffies + test_boost_interval * HZ;
+					WRITE_ONCE(boost_starttime,
+						   jiffies + test_boost_interval * HZ);
 					n_rcu_torture_boosts++;
 				}
 				mutex_unlock(&boost_mutex);
-- 
2.31.1.189.g2e36527f23

