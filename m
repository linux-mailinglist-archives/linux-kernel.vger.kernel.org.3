Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22A954AECD5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 09:42:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243038AbiBIIlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 03:41:32 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:55432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242982AbiBIIlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 03:41:25 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F529C03C180
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 00:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=43mWB+dy+19LJZoXitvaw8vs0PKmJKCLw7aLXD/RtUc=; b=PXDghF8AE4NdBWLdWz4nIRYJy2
        U8n4/hIA4rWCw/ppVyHI1bMRxYXvzohqf8k1XNEo65PGAMoyfrq+Ey+Zj8bVl3/I/jgnzv+TFRauA
        wwP5ItXrH9z/BjOV9RF9EG8ToHnBAp18aUKxOYM7iV7MVFJ+d9iahax390NNz7d0jeOhGb+o6HmgD
        6DsJfcXC9PMYyoM8osmkBZ7lB3/DKikZf9CRLTpFObf4ULA0SG/d8pOv3cqCoKV3pXmuF5W6BVbvL
        Sa1DFlTyPxVYjIM15jPtgIBszQfPxwRNsF3umyifdNh3LppMj8E5VdsnS41IUD78bqkZ9/Akn+jNL
        sUPlhg1Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHiWo-007AWZ-MI; Wed, 09 Feb 2022 08:40:42 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2858A986226; Wed,  9 Feb 2022 09:40:41 +0100 (CET)
Date:   Wed, 9 Feb 2022 09:40:41 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Byungchul Park <byungchul.park@lge.com>,
        "Paul E. McKenney" <paul.mckenney@linaro.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Radoslaw Burny <rburny@google.com>
Subject: Re: [PATCH 11/12] locking/mutex: Revive fast functions for
 CONFIG_LOCK_TRACEPOINTS
Message-ID: <20220209084041.GJ23216@worktop.programming.kicks-ass.net>
References: <20220208184208.79303-1-namhyung@kernel.org>
 <20220208184208.79303-12-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208184208.79303-12-namhyung@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 10:42:07AM -0800, Namhyung Kim wrote:
> I'm not entirely sure why it removed the fast versions when lockdep is
> on.  It seems easy to add the required annotation when the fast
> version is succeeded as far as the tracpoints are concerned.

IIRC it was something like, lockdep depends on MUTEX_DEBUG and that in
turn relied on not having the fast path enabled. MUTEX_DEBUG used to
always take the wait_lock to ensure the debug state is consistent with
the lock state.
