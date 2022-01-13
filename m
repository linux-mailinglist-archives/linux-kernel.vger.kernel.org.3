Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F77A48D544
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 11:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233562AbiAMJxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 04:53:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233545AbiAMJxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 04:53:10 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA9CC061748
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 01:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=l3z8gXX3r34f3mCfTNzd/+YfafO8nqkYhu6OMM7X+vI=; b=IzEgmcAYHgn4qQNftz9NP5dM1F
        FU2zJiOGo4esUqK/ygcuRz3GfJ6NBiZ2iyj3i0/BdB82n7t4SBoG4jgtmwMZeO2WJXyaeeSRPD0r0
        HM9Hd0vKqyLWwDhyx3YSCD5tD9nVvzmD6of3EBAUafSWhL1bzgMa9Emy61xDIlqYSfw25u3UvrE/j
        UcO04P5Qbc4Im35VnoyXcFy603KUcc4W+gvZBqr3GdQUKj3Lm6qDBwIRnyKb2xr22pxihyZILlV3A
        wXxuM52P5+HZiwR0ClX9qm94Qj5aoHHWETpGZ3LusoVJ0EI9KDj8t/KSuRUyr/i95baSJnzaJLDSm
        jOYaN59Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n7wmh-004pQa-F5; Thu, 13 Jan 2022 09:52:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 704173000E6;
        Thu, 13 Jan 2022 10:52:41 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2D919264EE43F; Thu, 13 Jan 2022 10:52:41 +0100 (CET)
Date:   Thu, 13 Jan 2022 10:52:41 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     =?utf-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Chris Down <chris@chrisdown.name>,
        Vipin Sharma <vipinsh@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Cruz Zhao <cruzzhao@linux.alibaba.com>,
        Tianchen Ding <dtcccc@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>
Subject: Re: [RFC PATCH] sched: introduce group balancer
Message-ID: <Yd/2aRcQlxm3Sh41@hirez.programming.kicks-ass.net>
References: <98f41efd-74b2-198a-839c-51b785b748a6@linux.alibaba.com>
 <Yd6Xlw1qvEbWFSwU@hirez.programming.kicks-ass.net>
 <11d4c86a-40ef-6ce5-6d08-e9d0bc9b512a@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <11d4c86a-40ef-6ce5-6d08-e9d0bc9b512a@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022 at 03:18:01PM +0800, 王贇 wrote:

> > > How To Use:
> > > 
> > > To create partition, for example run:
> > >    echo disable > /proc/gb_ctrl
> > >    echo "0-15;16-31;32-47;48-63;" > /proc/gb_ctrl
> > >    echo enable > /proc/gb_ctrl
> > 
> > That's just never going to happen; please look at the cpuset partition
> > stuff.
> 
> Could you please give more details in here?
> 
> We actually looking forward a way to config several cpuset partition
> together, like here 4 cpuset partitions 0-15, 16-31, 32-47 and 48-63,
> but can't find any existing approach...

You could extend the partitions support:

 https://lkml.kernel.org/r/20211205183220.818872-1-longman@redhat.com

And have a parent partition type that soft balances between child
partitions or something.


