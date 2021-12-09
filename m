Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E23D46F270
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 18:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241298AbhLIRvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 12:51:15 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:53638 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbhLIRvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 12:51:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 45A50CE2778;
        Thu,  9 Dec 2021 17:47:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEDFEC004DD;
        Thu,  9 Dec 2021 17:47:36 +0000 (UTC)
Date:   Thu, 9 Dec 2021 12:47:35 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     mhiramat@kernel.org, linux-trace-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 02/13] user_events: Add minimal support for
 trace_event into ftrace
Message-ID: <20211209124735.3d1a9707@gandalf.local.home>
In-Reply-To: <20211209174050.GA21553@kbox>
References: <20211201182515.2446-1-beaub@linux.microsoft.com>
        <20211201182515.2446-3-beaub@linux.microsoft.com>
        <20211208181905.62f8f999@gandalf.local.home>
        <20211209005823.GA21399@kbox>
        <20211208210336.40c7741b@yoga.local.home>
        <20211209174050.GA21553@kbox>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Dec 2021 09:40:50 -0800
Beau Belgrave <beaub@linux.microsoft.com> wrote:

> No, this is not a fast path, and I don't have a problem moving to a
> mutex if you feel that is better. I've likely become too close to this
> code to know when things are confusing for others.

Yeah. I really dislike the "protection by algorithms" then protection by
locking unless it is a fast path.

If this was a fast path then I'd be more concerned. I dislike global locks
as well, but unless contention becomes a concern, I don't think we should
worry about it.

Also, for this comment:

+static int user_events_release(struct inode *node, struct file *file)
+{
+	struct user_event_refs *refs;
+	struct user_event *user;
+	int i;
+
+	/*
+	 * refs is protected by RCU and could in theory change immediately
+	 * before this call on another core. To ensure we read the latest
+	 * version of refs we acquire the RCU read lock again.
+	 */
+	rcu_read_lock_sched();
+	refs = rcu_dereference_sched(file->private_data);
+	rcu_read_unlock_sched();

How do you see refs changing on another core if this can only be called
when nothing has a reference to it?

I think this comment and grabbing the rcu locks is what is causing me
concern.

-- Steve
