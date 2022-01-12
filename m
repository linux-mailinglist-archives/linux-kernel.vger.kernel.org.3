Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD84448BC1F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 02:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344866AbiALBDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 20:03:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344077AbiALBDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 20:03:06 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A53C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 17:03:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0A393CE1BBB
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 01:03:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B244C36AE3;
        Wed, 12 Jan 2022 01:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641949383;
        bh=175gygNvX/igOQyHqyBDa6ice4DXkW9ovpC1HV7NYf8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=qPbVAd37NkIJ4rKHTPYTMlgNUGKVsXrwBbVC+iJhiX9euf2gI9U1KaPjHk3Ek9hdC
         tvxWdAa2mpx/b654GnISkJNBgNvzm0lJees8WJ2bT95CKq6fDoWP+3hgfcEgGbuEPc
         1/C5ew0aLceZfcLxj7bF5GswGypm0TAPrAPk9m3VMYvtCmL6ABRKU0nXCbZpMO+uAd
         +UMz47e6ZTKQ3EAAeUiv6eb9GDDpR6aIIMG+WeJxy7ZfkNd49fiXrsOD6bB4KllpRi
         wPOwjTzUgwVgqg7djrPd5vj6A/24TRfYBN3wPxy7P2UERQle16d2A9V8CW24XOrDwn
         w1OcXL8WpLAxA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id BA94D5C0DA1; Tue, 11 Jan 2022 17:03:02 -0800 (PST)
Date:   Tue, 11 Jan 2022 17:03:02 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alison Chaiken <achaiken@aurora.tech>
Cc:     tglx@linutronix.de, peterz@infradead.org,
        valentin.schneider@arm.com, frederic@kernel.org,
        linux-kernel@vger.kernel.org, glenn@aurora.tech,
        alison@she-devel.com
Subject: Re: [PATCH 0/5] handle kthread_prio kernel cmdline parameter
 consistently
Message-ID: <20220112010302.GL947480@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220111233253.21692-1-achaiken@aurora.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220111233253.21692-1-achaiken@aurora.tech>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 03:32:49PM -0800, Alison Chaiken wrote:
> When CONFIG_PREEMPT_RT=y, RCU_SOFTIRQ work is moved to dedicated rcuc
> per-core threads.  The rcutree.kthread_prio kernel cmdline parameter
> controls the priority of those threads.
> 
> A provided kthread_prio kernel cmdline parameter also elevates the
> priority of rcuog threads, but only if they are launched from
> rcu_spawn_gp_kthread(), not if they are launched from
> rcu_spawn_one_nocb_kthread().  Fix this inconsistency.
> 
> When CONFIG_RCU_NOCB_CPU=y, an rcu_nocbs command-line parameter
> offloads the work of rcuc on designated cores to new rcuop threads
> that are not pinned to the cores whose expired grace-period timer
> callbacks they run.  While rcuop threads have the same function as
> rcuc threads, their priority is not controlled by the kthread_prio
> parameter.  Add this feature and update the documentation accordingly.
> 
> Alison Chaiken (4):
>   RCU: move kthread_prio bounds-check to a separate function
>   RCU: make priority of grace-period thread consistent
>   RCU: elevate priority of offloaded callback threads
>   RCU: update documentation regarding kthread_prio cmdline parameter

I have queued these for review and testing, thank you!

2/4 appears to have been produced against a pre-merge-window mainline,
so I had to adjust it a bit to queue it on -rcu.  Please check to make
sure that I did not mess anything up.

							Thanx, Paul
