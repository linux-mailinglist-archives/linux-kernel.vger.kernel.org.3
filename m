Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCA449FBBD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 15:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349250AbiA1Oc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 09:32:56 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:55290 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349286AbiA1Ocw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 09:32:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2534F61DF2;
        Fri, 28 Jan 2022 14:32:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EFCDC340E0;
        Fri, 28 Jan 2022 14:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643380371;
        bh=q/+SlKWLFfFYnY/uUsQHFniHbZLaOmbQkD9uTXnzcP8=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=uGvtbRDIhUurwgW0lEL45dAWO9bElyol3mNLZmo6fexrxyfpXWE+r2kYzWUQzM5fh
         DWU/5M5pKwFyT8nYzvpDW12ONzAkRnDVsfKNw4RPbxntORYF1M6ObAZcpPW0mszvoc
         lZlJLs9r/+NYnh34zeZBKQAYa00BNg3VH0dDqARiRtiDXi+ptrHDHlI4Srm8fD+iBV
         0Tn+Mk3oTmGHLF+xr0ivu6e2fJqCw8nRKj+WjcyJ99AYfVw+8gyxBLGsUMeyq41e7j
         p4uNJzUPtjHJ5RJ6yBkLUuCsx1R6H4S7FeO0jKsw3cJZhe64OD2WH5BZgxTbfHICam
         jMAsb1ZLyByJQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 55A1B5C010C; Fri, 28 Jan 2022 06:32:51 -0800 (PST)
Date:   Fri, 28 Jan 2022 06:32:51 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        andrii.nakryiko@gmail.com, kafai@fb.com, neeraj.iitr10@gmail.com,
        Mark.Rutland@arm.com, hca@linux.ibm.com, kernel-team@fb.com
Subject: [GIT PULL] RCU Tasks fix for systems with non-power-of-two numbers
 of CPUs
Message-ID: <20220128143251.GA2398275@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus,

This pull request fixes a brown-paper-bag bug in RCU tasks that
causes things like BPF and ftrace to fail miserably on systems with
non-power-of-two numbers of CPUs.

And yes, I will be adding non-power-of-two scenarios to rcutorture,
in case you were wondering.  But that can wait for v5.19.

The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/rcu-urgent.2022.01.26a

for you to fetch changes up to da123016ca8cb5697366c0b2dd55059b976e67e4:

  rcu-tasks: Fix computation of CPU-to-list shift counts (2022-01-26 13:04:05 -0800)

----------------------------------------------------------------
Urgent RCU pull request for v5.17

This pull request fixes a math error added in 7a30871b6a27 ("rcu-tasks:
Introduce ->percpu_enqueue_shift for dynamic queue selection') during the
v5.17 merge window.  This commit works correctly only on systems with a
power-of-two number of CPUs, which just so happens to be the kind that
rcutorture always uses by default.

This pull request fixes the math so that things also work on systems
that don't happen to have a power-of-two number of CPUs.

----------------------------------------------------------------
Paul E. McKenney (1):
      rcu-tasks: Fix computation of CPU-to-list shift counts

 kernel/rcu/tasks.h | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)
