Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00941465AF8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354581AbhLBAgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:36:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234629AbhLBAgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:36:48 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A2DC061574;
        Wed,  1 Dec 2021 16:33:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0A57ECE1DC7;
        Thu,  2 Dec 2021 00:33:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B983C00446;
        Thu,  2 Dec 2021 00:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638405203;
        bh=Ds/eO3dfiMAcQ/6iKBSMK4xpLlZdjck5M+IsTr0LZSI=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=ItYZaJmdHOeyp3JiWqPdSjfXse+RS08UpC8Nm95vOcWlfJ5nKaTDvVy5cj7fSKTmK
         0t2pXhJ5awCROoCVM53Sf5DPvr9Pp8iuKHoCATqcDJGZ05hjlNPtPPggbDMD+hooir
         BEJF7vZhFWm//pofSWBNQZJYzom3F/3kEPqtuN2LQ6AGiqWsOAcBtSk8fNaIYSjSHO
         gfYtzJ8Ar8FAgwv/JpsqRLxFZJcbo7/5+ZGsU/PsYajfj/fQC1acC+winoSnxkk7Py
         /swDa+ro/oPfsQYSlzXKpBPy7Ohkbec7SHRbOA55Jdxj4ptJ3gKHqrSgmYonMkmiNN
         F07UQIRKk/d4A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 01F7D5C0FCD; Wed,  1 Dec 2021 16:33:22 -0800 (PST)
Date:   Wed, 1 Dec 2021 16:33:22 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH rcu 0/6] nolibc updates for v5.17
Message-ID: <20211202003322.GA3128775@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series provides nolibc updates, perhaps most notably the addition
of the gettid() system call:

1.	x86-64: Fix startup code bug, courtesy of Ammar Faizi.

2.	i386: fix initial stack alignment, courtesy of Willy Tarreau.

3.	fix incorrect truncation of exit code, courtesy of Willy Tarreau.

4.	x86: Remove `r8`, `r9` and `r10` from the clobber list, courtesy
	of Ammar Faizi.

5.	x86-64: Use `mov $60,%eax` instead of `mov $60,%rax`, courtesy
	of Ammar Faizi.

6.	Implement gettid(), courtesy of Mark Brown.

						Thanx, Paul

------------------------------------------------------------------------

 b/tools/include/nolibc/nolibc.h |   10 ++++-
 tools/include/nolibc/nolibc.h   |   76 +++++++++++++++++++++++++++-------------
 2 files changed, 60 insertions(+), 26 deletions(-)
