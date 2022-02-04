Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7444AA4A5
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 00:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378436AbiBDXxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 18:53:37 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:55808 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378292AbiBDXxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 18:53:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5212661CCE;
        Fri,  4 Feb 2022 23:53:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3BADC340F3;
        Fri,  4 Feb 2022 23:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644018809;
        bh=6YCDxc9if9WixflkeRLov5G7IDGmcJP5BCW5Y7LJKBU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bxcvrbOQEa9zelWGdVI1WCSUBtIUp2FJilBh1uHzj/A2qu06hZVNTMD8iKqEitrY5
         Zr1ym2xlaWrR+ZNfzRLgU1PwT5vbRXS2uR5Wb6zfMBZvG9KN+OMK7aEzyF6T7T6yPh
         L0ipUAN40MtDK4kVbFi+ewCtp6cswLJhgtjFi4SKs1YprXzZ7t7cyve68WdGX1Sy4V
         U1a6IA1kugnSqSMPUXxJ9c1ZeCDkSD37e8V97pKHxl8BH/dAnJBQ2bNAQtpbk2wxRE
         60wQaDnqc+wPuzbGie6/1eZg0x1XOtHkt3bSkT5rLxW2+JCZ/1lhA2N1WbTI+vRq4G
         tm/pXf83zpdAw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7CDED5C0992; Fri,  4 Feb 2022 15:53:29 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 5/8] rcutorture: Add end-of-test check to rcu_torture_fwd_prog() loop
Date:   Fri,  4 Feb 2022 15:53:24 -0800
Message-Id: <20220204235327.2948-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220204235321.GA2511@paulmck-ThinkPad-P17-Gen-1>
References: <20220204235321.GA2511@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The second and subsequent forward-progress kthreads loop waiting for
the first forward-progress kthread to start the next test interval.
Unfortunately, if the test ends while one of those kthreads is waiting,
the test will hang.  This hang occurs because that wait loop fails to
check for the end of the test.  This commit therefore adds an end-of-test
check to that wait loop.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index afe95c6948957..e99658efd97f4 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2515,7 +2515,7 @@ static int rcu_torture_fwd_prog(void *args)
 			firsttime = false;
 			WRITE_ONCE(rcu_fwd_seq, rcu_fwd_seq + 1);
 		} else {
-			while (READ_ONCE(rcu_fwd_seq) == oldseq)
+			while (READ_ONCE(rcu_fwd_seq) == oldseq && !torture_must_stop())
 				schedule_timeout_interruptible(1);
 			oldseq = READ_ONCE(rcu_fwd_seq);
 		}
-- 
2.31.1.189.g2e36527f23

