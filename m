Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E021E4AA433
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 00:20:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378003AbiBDXUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 18:20:30 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:59414 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233885AbiBDXU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 18:20:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 76448B83968;
        Fri,  4 Feb 2022 23:20:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 449FBC004E1;
        Fri,  4 Feb 2022 23:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644016827;
        bh=GfCkjzsfVNABMf46P+mNJkGnvDu0PQgKZ94eQR22RO4=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=sCiWSpOuddLFACqG/EEtiNpZaNSdlqFF27huReh2PDGnzetBqR1Qz4hFhxQ+hqk4l
         SVbJchnLaDgdxEo3KXCatuZ3A1y8fdZ7pK86SdH1jdVSEgTQG64es++F0xQdb7B0ds
         YdVXL52sdMMsnMPU7lNZvFdwXDGTVD1Eiub0d2FZN5pI6WIetFeLH8fxKvpI9ZYyrB
         1BvANZ/rK9Ob7GiIuItBsKHCFVHgj+K5z4jT0bX5h/EWMU/0N4S1npPgTsp/ZwGtR4
         zevGy0kdLSLSVryFFiN+MnyIa2ALHcz4CSc2HrWFViH/ZoePc5MYpEX2Iup9UiZmxV
         VPmzWOAnt6W1g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 102B55C0418; Fri,  4 Feb 2022 15:20:27 -0800 (PST)
Date:   Fri, 4 Feb 2022 15:20:27 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org
Subject: [PATCH rcu 0/5] Extricate rcu_barrier() from CPU hotplug
Message-ID: <20220204232027.GA4194214@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series reworks rcu_barrier() to remove its calls to cpus_read_lock()
and cpus_read_unlock().  This improves modularity, gets rid of an
acquisition of a wide-spectrum synchronization mechanism, and allows
rcu_barrier() to be invoked from CPU-hotplug notifiers that permit
blocking.  Not that this last is necessarily a good idea.

1.	Kill rnp->ofl_seq and use only rcu_state.ofl_lock for exclusion,
	courtesy of David Woodhouse.

2.	Refactor rcu_barrier() empty-list handling.

3.	Rework rcu_barrier() and callback-migration logic.

4.	Make rcu_barrier() no longer block CPU-hotplug operations.

5.	Create and use an rcu_rdp_cpu_online().

						Thanx, Paul

------------------------------------------------------------------------

 b/include/trace/events/rcu.h |    9 +-
 b/kernel/rcu/tree.c          |   71 ++++++++++----------
 b/kernel/rcu/tree.h          |    4 -
 b/kernel/rcu/tree_plugin.h   |    6 -
 kernel/rcu/tree.c            |  151 +++++++++++++++++++++++++++----------------
 kernel/rcu/tree.h            |    5 +
 6 files changed, 143 insertions(+), 103 deletions(-)
