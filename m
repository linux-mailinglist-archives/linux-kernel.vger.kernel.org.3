Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB4885375BE
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 09:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233811AbiE3HqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 03:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233801AbiE3Hp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 03:45:58 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F213E25EAF
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 00:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zPMYFl+F6N/pp7h3JSIEvf+AEouWokHfixPufYFbcX4=; b=hxWYFgZKi5QZHfJo6T/VLFTWzy
        Z73fL1E4gXQ5GSua8vWYUjBKva+8KdWbUFEHekXdoygWLS/+8+Rk4+LrCy8FEuW0BTOejelQyHjzM
        eIxholpZckPtDJqbCjdLyG1ant1E1khVZDFYqeLpvl9FZnZ/G73XvLo8/javFfJY0oIgjuNXFK5G8
        UTx0LTKvQgwjipo+RHrR1nIqE/m8RfLzUyuPFFTa+De04luv0biPtTf0yMqzjIpKZIAHGIoHXmvsZ
        DE4HqYpBNXYG+1UbpqHnpyZcuEG/YtEK0ycA7cQ4gXIB0FOVEeve5Z3x6vFYBHdF1/f7d6wOskqJR
        KlnSNoLQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nva5s-002yVF-E3; Mon, 30 May 2022 07:45:41 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2EF0F980DE7; Mon, 30 May 2022 09:45:38 +0200 (CEST)
Date:   Mon, 30 May 2022 09:45:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ivan Kozik <ivan@ludios.org>
Cc:     linux-kernel@vger.kernel.org, nizhen@uniontech.com,
        mingo@kernel.org
Subject: Re: 5.18 missing /proc/sys/kernel/sched_autogroup_enabled?
Message-ID: <YpR2IqndgsyMzN00@worktop.programming.kicks-ass.net>
References: <CAKynti+AtijnHPG-hR-zDM9eCX9HawLgB+p2C9VzS8GN-4+UsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKynti+AtijnHPG-hR-zDM9eCX9HawLgB+p2C9VzS8GN-4+UsQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 29, 2022 at 11:52:42PM +0000, Ivan Kozik wrote:
> Hello,
> 
> I noticed that /proc/sys/kernel/sched_autogroup_enabled seems to have
> gone missing in 5.18. Am I doing something wrong, or is this a
> regression?
> 
> I also noticed that booting 5.18 with "noautogroup" results in a
> "kernel: failed when register_sysctl sched_autogroup_sysctls to
> kernel" message.  Because of the error and the missing
> /proc/sys/kernel/sched_autogroup_enabled, it is unclear whether
> autogroup is enabled or not.

*sigh*, I think this is yet another one of the sysctl move patches gone
bad :/ Specifically:

 c8eaf6ac76f4 ("sched: move autogroup sysctls into its own file")

Does something like the below help?

---

diff --git a/kernel/sched/autogroup.c b/kernel/sched/autogroup.c
index 16092b49ff6a..4ebaf97f7bd8 100644
--- a/kernel/sched/autogroup.c
+++ b/kernel/sched/autogroup.c
@@ -36,6 +36,7 @@ void __init autogroup_init(struct task_struct *init_task)
 	kref_init(&autogroup_default.kref);
 	init_rwsem(&autogroup_default.lock);
 	init_task->signal->autogroup = &autogroup_default;
+	sched_autogroup_sysctl_init();
 }
 
 void autogroup_free(struct task_group *tg)
@@ -219,7 +220,6 @@ void sched_autogroup_exit(struct signal_struct *sig)
 static int __init setup_autogroup(char *str)
 {
 	sysctl_sched_autogroup_enabled = 0;
-	sched_autogroup_sysctl_init();
 
 	return 1;
 }
