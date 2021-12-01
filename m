Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51C7A464454
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 02:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232098AbhLABD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 20:03:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbhLABDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 20:03:54 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B3AC061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 17:00:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 704A9CE1D57
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 01:00:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0A17C53FC7;
        Wed,  1 Dec 2021 01:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638320430;
        bh=HgaPnaRIXqXE+7FqSdh9liEUqKs7knvux6p2yxsSNYU=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=Peqa4QEjk9qrSKd0iGn9u9NgTfx71cB1dd9O/L7GEy9BUU+c8LTSYZubPgUd8tNhR
         GgxU+PgY29C3Nh8qB+u2Op6a39LaOfdBuv5Jf/hZcgsbcwbLWsfKF6T+i/QK5AWXHF
         3AD5hlOmByTeaAtgH+0X8HmxQDGss7GWDQVZCPSqxdvPajKKOWu8NjijWSbT7XfjXi
         L0iD1tcmiam45AmdKz70ENdvHuQNvqKLSWGlWutze67dPa8uk/e8cUMZYYcq1ADVT7
         WQmb6OTwT4DZEmJNYxgTKWr9YuL+Q5q304ARtmgtNwVvAPeR8CqPLDmWZm+1WHog3G
         Ont5CE+RCu8/w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 526595C0E58; Tue, 30 Nov 2021 17:00:30 -0800 (PST)
Date:   Tue, 30 Nov 2021 17:00:30 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     tj@kernel.org, jiangshanlai@gmail.com
Cc:     linux-kernel@vger.kernel.org, frederic@kernel.org
Subject: [PATCH] workqueue: Upgrade queue_work_on() comment
Message-ID: <20211201010030.GA3071988@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current queue_work_on() docbook comment says that the caller must
ensure that the specified CPU can't go away, but does not spell out the
consequences, which turn out to be quite mild.  Therefore expand this
comment to explicitly say that the penalty for failing to nail down the
specified CPU is that the workqueue handler might find itself executing
on some other CPU.

Cc: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 613917bbc4e73..332361cf215fc 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1531,7 +1531,8 @@ static void __queue_work(int cpu, struct workqueue_struct *wq,
  * @work: work to queue
  *
  * We queue the work to a specific CPU, the caller must ensure it
- * can't go away.
+ * can't go away.  Callers that fail to ensure that the specified
+ * CPU cannot go away will execute on a randomly chosen CPU.
  *
  * Return: %false if @work was already on a queue, %true otherwise.
  */
