Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7A32465B2C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354794AbhLBAqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:46:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354869AbhLBAqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:46:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187EFC0613F1;
        Wed,  1 Dec 2021 16:42:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C425FB8219A;
        Thu,  2 Dec 2021 00:42:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ED8AC00446;
        Thu,  2 Dec 2021 00:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638405765;
        bh=E9snHBHA1C82rYhgFAsgQCnLqQ29UJLGTMZeZWrAGDA=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=ppYiPlUdSgFQ6KsJtT3FCZQeRUFeOiKjaMz8Xp/u9gA9bucSgCUcAAZyAb83pXS9o
         +G72S3UnKx0KWMaNyNiDvojnDV4XYHkI+6vNJt8NtwuObVxvZ4Qo0gts5i2AXeq5bp
         0dT9DwuD4Bq+Bb+1TECgPPqIBVppwiGq+p2zONFGtFprC93zeLgbiBPj63oGjbo0cc
         MFSibsmPo/e3EKPY+Km6R1DjtNVRd+Cckq3fXeblhYB9Cw3F1GQzU76MkTYg3cGj+s
         JPS8uQ9G0+f3DZTAIs2WKcTA06nKm5y3t+IE/tdLJ/8Ma5O1AeZIFKnZ93T9e+dWMX
         A9tcmmjyWmnRw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4085C5C0FCD; Wed,  1 Dec 2021 16:42:45 -0800 (PST)
Date:   Wed, 1 Dec 2021 16:42:45 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH rcu 0/17] Torture-test updates for v5.17
Message-ID: <20211202004245.GA3129966@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series contains torture-test updates:

1.	Sanitize RCUTORTURE_RDR_MASK.

2.	More thoroughly test nested readers.

3.	Suppress pi-lock-across read-unlock testing for Tiny SRCU.

4.	Simplify the errexit checkpoint, courtesy of Li Zhijian.

5.	Prevent buffer to pr_alert() being too long, courtesy of Li
	Zhijian.

6.	Always log the error message, courtesy of Li Zhijian.

7.	Add missing '\n' to flush message, courtesy of Li Zhijian.

8.	Add missing '\n' to flush message, courtesy of Li Zhijian.

9.	Remove unused SCFTORTOUT, courtesy of Li Zhijian.

10.	Always log error message, courtesy of Li Zhijian.

11.	Always log error message, courtesy of Li Zhijian.

12.	locktorture,rcutorture,torture: Always log error message,
	courtesy of Li Zhijian.

13.	Avoid soft lockup during cpu stall, courtesy of Wander Lairson
	Costa.

14.	Test RCU-tasks multiqueue callback queueing.

15.	Enable multiple concurrent callback-flood kthreads.

16.	Add ability to limit callback-flood intensity.

17.	Combine n_max_cbs from all kthreads in a callback flood.

						Thanx, Paul

------------------------------------------------------------------------

 b/Documentation/admin-guide/kernel-parameters.txt             |    6 
 b/include/linux/torture.h                                     |    9 
 b/kernel/locking/locktorture.c                                |    4 
 b/kernel/rcu/rcuscale.c                                       |   14 
 b/kernel/rcu/rcutorture.c                                     |    7 
 b/kernel/rcu/refscale.c                                       |   19 
 b/kernel/scftorture.c                                         |    6 
 b/kernel/torture.c                                            |    4 
 b/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcu.sh   |    2 
 b/tools/testing/selftests/rcutorture/configs/rcu/TASKS01.boot |    1 
 b/tools/testing/selftests/rcutorture/configs/rcu/TRACE01.boot |    1 
 kernel/rcu/rcutorture.c                                       |  235 +++++++---
 kernel/rcu/refscale.c                                         |   42 +
 kernel/scftorture.c                                           |   12 
 14 files changed, 236 insertions(+), 126 deletions(-)
