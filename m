Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3CFC4AA3FC
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 00:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377872AbiBDXHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 18:07:55 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:57936 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377869AbiBDXHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 18:07:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41F9861B9C;
        Fri,  4 Feb 2022 23:07:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4358C340ED;
        Fri,  4 Feb 2022 23:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644016071;
        bh=mfM6gV8PutUgVnXpIy9BRzgd9V2JaZPFwLF5/yUxIgE=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=eWZX08lMyfvyJDfY17zllLarfiKj/YpsNhlM9IKmsqOeMvf8eyRvWxKXvWyl6a3St
         CxvivRlvAAzCD1PTzYEjxyikrWeMpePDGU8wWkz7C0UTSkgM9E/kSnEHLNTY3SlHCB
         dNRq8dFVPLVf+EDuUn/ab89wJx3ZrCS6E5UEzrQ2S8QCkQeG2H1GGhrFBKxOsbOQdH
         84NSIuoZYHAf5C8gqJi3VrujhoPb5fztPS8Ugvf9kE60VEdHI4yWmOiyd0FIssC4RV
         zqeqxyTQXNEbUlPxiOrB68io8RLcpfdXP8k4AHlqZ5PdoKIDD3Ibax5jPQs3zEmoie
         Yj9d++nXIZ4Ng==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 70CFE5C0418; Fri,  4 Feb 2022 15:07:51 -0800 (PST)
Date:   Fri, 4 Feb 2022 15:07:51 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org
Subject: [PATCH rcu 0/9] Miscellaneous fixes for v5.18
Message-ID: <20220204230751.GA4193671@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series provides miscellaneous fixes:

1.	MAINTAINERS:  Add Frederic and Neeraj to their RCU files.

2.	Fix description of kvfree_rcu(), courtesy of "Uladzislau Rezki
	(Sony)".

3.	Add mutex for rcu boost kthread spawning and affinity setting,
	courtesy of David Woodhouse.

4.	Inline __call_rcu() into call_rcu().

5.	Record work creation stack trace with interrupts enabled,
	courtesy of Zqiang.

6.	Mark writes to the rcu_segcblist structure's ->flags field.

7.	Uninline multi-use function: finish_rcuwait(), courtesy of
	Ingo Molnar.

8.	Remove __read_mostly annotations from rcu_scheduler_active
	externs, courtesy of Ingo Molnar.

9.	Replace cpumask_weight with cpumask_empty where appropriate,
	courtesy of Yury Norov.

						Thanx, Paul

------------------------------------------------------------------------

 b/MAINTAINERS                |    2 
 b/include/linux/rcupdate.h   |    2 
 b/include/linux/rcutree.h    |    2 
 b/include/linux/rcuwait.h    |    6 --
 b/kernel/rcu/rcu_segcblist.h |    4 -
 b/kernel/rcu/tree.c          |    1 
 b/kernel/rcu/tree.h          |    3 +
 b/kernel/rcu/tree_nocb.h     |    4 -
 b/kernel/rcu/tree_plugin.h   |   10 +++-
 b/kernel/rcu/update.c        |    7 +++
 include/linux/rcupdate.h     |    2 
 kernel/rcu/tree.c            |   93 +++++++++++++++++++------------------------
 kernel/rcu/tree_plugin.h     |    2 
 13 files changed, 73 insertions(+), 65 deletions(-)
