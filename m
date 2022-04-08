Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB19B4F908B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 10:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbiDHIS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 04:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbiDHISY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 04:18:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA28657A0
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 01:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9waK1GE6Xo1fRvL2g920wRma1kjG5tt3UIqXpis3+Gg=; b=lUGzIaWdoZwMt2kUyFEN2QSwYH
        7Yyi5jmaN7iUzK0vnVvs+sltz+iF5E6vpTGjt9skfyJbOKYxnC9FekrYfsGYAfoDPHFBX4cJgNskk
        UX4oL+V/9oe+00qlR+L0ython3kkTMO19+FbJZGZjhiqvFll1axcPhH8FRYBNjalBai1+rpYJN99f
        N09hlKKQ6zpu67MtCqT+g7mBC1jLmc/ApUx0oWLp7ntAS0E9uffmUTc4Hq2d0n4KO63uxr45RbLLG
        yZw0blKpD1jj8PcWU4Exs0/8bcdjrsKbcrpZ9ZDcTP6dgEIM9ZSJSAslvPpjIZwgBx/wns8KWS53X
        MuWjj+rA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ncjmZ-009dKd-NG; Fri, 08 Apr 2022 08:15:51 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id ACBDF9862CF; Fri,  8 Apr 2022 10:15:49 +0200 (CEST)
Date:   Fri, 8 Apr 2022 10:15:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nico Pache <npache@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Rafael Aquini <aquini@redhat.com>,
        Waiman Long <longman@redhat.com>, Baoquan He <bhe@redhat.com>,
        Christoph von Recklinghausen <crecklin@redhat.com>,
        Don Dutile <ddutile@redhat.com>,
        "Herton R . Krzesinski" <herton@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>,
        Darren Hart <dvhart@infradead.org>, stable@kernel.org
Subject: Re: [PATCH v8] oom_kill.c: futex: Don't OOM reap the VMA containing
 the robust_list_head
Message-ID: <20220408081549.GM2731@worktop.programming.kicks-ass.net>
References: <20220408032809.3696798-1-npache@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220408032809.3696798-1-npache@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2022 at 11:28:09PM -0400, Nico Pache wrote:
> The pthread struct is allocated on PRIVATE|ANONYMOUS memory [1] which can
> be targeted by the oom reaper. This mapping is used to store the futex
> robust list head; the kernel does not keep a copy of the robust list and
> instead references a userspace address to maintain the robustness during
> a process death. A race can occur between exit_mm and the oom reaper that
> allows the oom reaper to free the memory of the futex robust list before
> the exit path has handled the futex death:
> 
>     CPU1                               CPU2
> ------------------------------------------------------------------------
>     page_fault
>     do_exit "signal"
>     wake_oom_reaper
>                                         oom_reaper
>                                         oom_reap_task_mm (invalidates mm)
>     exit_mm
>     exit_mm_release
>     futex_exit_release
>     futex_cleanup
>     exit_robust_list
>     get_user (EFAULT- can't access memory)
> 
> If the get_user EFAULT's, the kernel will be unable to recover the
> waiters on the robust_list, leaving userspace mutexes hung indefinitely.
> 
> Use the robust_list address stored in the kernel to skip the VMA that holds
> it, allowing a successful futex_cleanup.
> 
> Theoretically a failure can still occur if there are locks mapped as
> PRIVATE|ANON; however, the robust futexes are a best-effort approach.
> This patch only strengthens that best-effort.
> 
> The following case can still fail:
> robust head (skipped) -> private lock (reaped) -> shared lock (skipped)

This is still all sorts of confused.. it's a list head, the entries can
be in any random other VMA. You must not remove *any* user memory before
doing the robust thing. Not removing the VMA that contains the head is
pointless in the extreme.

Did you not read the previous discussion?
