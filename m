Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E552465B4F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344323AbhLBAuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:50:09 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:41068 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbhLBAtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:49:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2D531B80DAC;
        Thu,  2 Dec 2021 00:46:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFFB8C00446;
        Thu,  2 Dec 2021 00:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638405975;
        bh=yZ/GjqNse1gbEiHtbe8MzbbAcS1TJ6c0ItGmYFLKSB0=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=es8xLmK9ijNtcvOSpFgliN4JJesoVg9RcwwVKavx6ZaudN8TmZjc2asbi1A222c3W
         nWliNlQSwT9VVz9/EwgYaWw4pkNETKof0Q/rG4+RJbCU4F4SkRAl18QkRfnAqD/LQn
         iamRjI1vikSu8HiOMut+ojo1lftbRIegf/Q09u14Nt/E09kS4AqzmJf6AygmXO+5rP
         +TtqdJHNWhjYK+2xd43QyAaWc0rk0onLHlUSmQ1sGdPz5kAHE5QJdGT32Z2HgyZj/Z
         QW1YjXCCgMdvQVDsmVjBztDfiDKosgT58Zk6OjiAK+yuC0obE/xdN5maCs6CvAp1so
         GSgKHV7CJBXuA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 8DF8E5C0FCD; Wed,  1 Dec 2021 16:46:15 -0800 (PST)
Date:   Wed, 1 Dec 2021 16:46:15 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH rcu 0/8] Torture-script updates for v5.17
Message-ID: <20211202004615.GA3130415@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series contains torture-scripting updates:

1.	Add CONFIG_PREEMPT_DYNAMIC=n to tiny scenarios.

2.	Catch kvm.sh help text up with actual options.

3.	Make kvm-find-errors.sh report link-time undefined symbols.

4.	Retry download once before giving up.

5.	Cause TREE02 and TREE10 scenarios to do more callback flooding.

6.	Test RCU Tasks lock-contention detection.

7.	Fix incorrectly redirected "exit" in kvm-remote.sh.

8.	Properly redirect kvm-remote.sh "echo" commands.

						Thanx, Paul

------------------------------------------------------------------------

 b/tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh   |    4 +--
 b/tools/testing/selftests/rcutorture/bin/kvm-remote.sh        |   11 +++++++--
 b/tools/testing/selftests/rcutorture/bin/kvm.sh               |    9 +++++--
 b/tools/testing/selftests/rcutorture/bin/parse-build.sh       |    3 +-
 b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-T       |    1 
 b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-U       |    1 
 b/tools/testing/selftests/rcutorture/configs/rcu/TINY01       |    1 
 b/tools/testing/selftests/rcutorture/configs/rcu/TINY02       |    1 
 b/tools/testing/selftests/rcutorture/configs/rcu/TRACE02.boot |    1 
 b/tools/testing/selftests/rcutorture/configs/rcu/TREE02.boot  |    1 
 b/tools/testing/selftests/rcutorture/configs/rcu/TREE10.boot  |    1 
 b/tools/testing/selftests/rcutorture/configs/rcuscale/TINY    |    1 
 tools/testing/selftests/rcutorture/bin/kvm-remote.sh          |   12 +++++-----
 13 files changed, 33 insertions(+), 14 deletions(-)
