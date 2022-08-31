Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0FD5A84FC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbiHaSGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbiHaSGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:06:34 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870C4E2C77;
        Wed, 31 Aug 2022 11:06:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 08F37CE205C;
        Wed, 31 Aug 2022 18:06:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43737C43470;
        Wed, 31 Aug 2022 18:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661969187;
        bh=sun+T8lzCvE9Y/BRrlU22ISf75bNVcTgeX9rLFqYRB8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iCaRESPLHwkWlJoW9d0TkE9FRZlHhA2uF3DyFY1pucQ/RM3ugsObCtlFes/gkHP9E
         O6Vb011GJ9V21qlWUeeEbHYb0rjt2N33wHXUkrF7vTw1375Xg/RiX33fd5q3wH7zIA
         7aip6Vv3j6gWbpl8mNWvs3d6iWk/7TlsfgcvA77GKMimPf8YWe2V9Z2QTY9ara/cny
         6nsq7daNg7GyruvI+BVR4aClH4nddTvlB1xcoEQ1RuE+4W7FSBlT4V8dgc0XApejta
         amqng886nnnq9cfRd+La5WPNr2HJck3jGn8RpVG5aFsmRPXq3Y3HHYRFT3SinGG4M+
         RWnb1/FekwgPA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0578F5C0513; Wed, 31 Aug 2022 11:06:27 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 4/7] doc: Fix list: rcu_access_pointer() is not lockdep-checked
Date:   Wed, 31 Aug 2022 11:06:22 -0700
Message-Id: <20220831180625.2692892-4-paulmck@kernel.org>
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

The rcu_access_pointer() macro does not consult lockdep by design because
it is intended to be used outside of RCU read-side critical sections.
This commit therefore makes a separate list for it in whatisRCU.rst.

Similarly, RCU_LOCKDEP_WARN(), rcu_sleep_check(), and RCU_NONIDLE()
do not do anything with pointer access.  This commit therefore creates
a separate utility-API list for them.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/whatisRCU.rst | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/RCU/whatisRCU.rst b/Documentation/RCU/whatisRCU.rst
index 77ea260efd120..6940e0fe8599b 100644
--- a/Documentation/RCU/whatisRCU.rst
+++ b/Documentation/RCU/whatisRCU.rst
@@ -1057,14 +1057,20 @@ SRCU: Initialization/cleanup::
 	init_srcu_struct
 	cleanup_srcu_struct
 
-All: lockdep-checked RCU-protected pointer access::
+All: lockdep-checked RCU utility APIs::
 
-	rcu_access_pointer
-	rcu_dereference_raw
 	RCU_LOCKDEP_WARN
 	rcu_sleep_check
 	RCU_NONIDLE
 
+All: Unchecked RCU-protected pointer access::
+
+	rcu_dereference_raw
+
+All: Unchecked RCU-protected pointer access with dereferencing prohibited::
+
+	rcu_access_pointer
+
 See the comment headers in the source code (or the docbook generated
 from them) for more information.
 
-- 
2.31.1.189.g2e36527f23

