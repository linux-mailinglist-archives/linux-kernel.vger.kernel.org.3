Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD465A84F9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbiHaSGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232114AbiHaSGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:06:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20DCBE1902;
        Wed, 31 Aug 2022 11:06:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 069CC61BF0;
        Wed, 31 Aug 2022 18:06:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58934C43140;
        Wed, 31 Aug 2022 18:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661969187;
        bh=We5lyI+7f6SWu202lqcy/4q82tJxbRstsBHMbMVe9Zw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F4GZ/sk9gMawWzdvEX3ArkdMhIauSgivfCT3kCmZ82bEygfTM+qjfIbBqwu0G9lUN
         n20NW5MQ6vsoKmVSi85PpWTpRkvXIcWYoTQtXED7A/FEaJKRPgqJxO9fl/Y1s03NHU
         dWl/VRNrpsZzhM0GKUyMPLVFv6r6ady5qMZbel5YvRoXakk1gg2zlNotF1CLfGa7DQ
         IDKeKXzjIdUK5DDYmw48Z4+e3hiJj1Mhm8o+Yi3gD0aZWRRF/GH/l01ffxt1kDtp6C
         sE2S43ArxjLz5kjzIO+e5J9nvzg0NaB9AX63z4+B3M38edIfjyJdWh5QmiGyUCskAL
         0qvFCqVB/pzbw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 075505C06A7; Wed, 31 Aug 2022 11:06:27 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 5/7] doc: Update rcu_access_pointer() advice in rcu_dereference.rst
Date:   Wed, 31 Aug 2022 11:06:23 -0700
Message-Id: <20220831180625.2692892-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220831180617.GA2692480@paulmck-ThinkPad-P17-Gen-1>
References: <20220831180617.GA2692480@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit updates the rcu_access_pointer() advice, noting that its
return value should not be assigned to a local variable, and also noting
that there is little point in using rcu_access_pointer() within an RCU
read-side critical section.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/rcu_dereference.rst | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/Documentation/RCU/rcu_dereference.rst b/Documentation/RCU/rcu_dereference.rst
index 0b418a5b243c5..81e828c8313b8 100644
--- a/Documentation/RCU/rcu_dereference.rst
+++ b/Documentation/RCU/rcu_dereference.rst
@@ -128,10 +128,16 @@ Follow these rules to keep your RCU code working properly:
 		This sort of comparison occurs frequently when scanning
 		RCU-protected circular linked lists.
 
-		Note that if checks for being within an RCU read-side
-		critical section are not required and the pointer is never
-		dereferenced, rcu_access_pointer() should be used in place
-		of rcu_dereference().
+		Note that if the pointer comparison is done outside
+		of an RCU read-side critical section, and the pointer
+		is never dereferenced, rcu_access_pointer() should be
+		used in place of rcu_dereference().  In most cases,
+		it is best to avoid accidental dereferences by testing
+		the rcu_access_pointer() return value directly, without
+		assigning it to a variable.
+
+		Within an RCU read-side critical section, there is little
+		reason to use rcu_access_pointer().
 
 	-	The comparison is against a pointer that references memory
 		that was initialized "a long time ago."  The reason
-- 
2.31.1.189.g2e36527f23

