Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 089CF576432
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 17:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232870AbiGOPKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 11:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiGOPKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 11:10:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A147BE38
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 08:10:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0CAA62040
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 15:10:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F9EFC34115;
        Fri, 15 Jul 2022 15:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657897801;
        bh=nxfXNsnqYstmD29o+5IdQlBgebahXtNZ5XkjmAqKmkg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=h9kv48vg5F4c9IczeU9GMH+HJZKdXz6H3hHht971ds3O0kSgYdx9W08csOeiWbCJ3
         BhXAfwmI3jCWydJxBn1LiUvZSEInWCmxJhKaYQgxZnLOKPx5VkoPsc5x7Ce43qEjiu
         elrDEkF71TuwElftwdp+vml0bztsDLNXKqS/ZvxlLqwMuUbo6xXGxKSkn1nh8JKZpU
         //Jz88NrD/m3a0dS3c/+GkFR46n9Dp7uEjDjQLuHoQoxjEKVg6hrDc23unAEZztDtk
         83hrPn2DUpKWlAnsiQOKiI5CG5knXXLWYs2eKZKMVF3G/gwJYWtOpEpaLJ9u+UY61/
         LkoC/lauX31KQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id BFF325C015D; Fri, 15 Jul 2022 08:10:00 -0700 (PDT)
Date:   Fri, 15 Jul 2022 08:10:00 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Marco Elver <elver@google.com>, Petr Mladek <pmladek@suse.com>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        kasan-dev@googlegroups.com, Thomas Gleixner <tglx@linutronix.de>,
        Johannes Berg <johannes.berg@intel.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: Make console tracepoint safe in NMI() context
Message-ID: <20220715151000.GY1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220715120152.17760-1-pmladek@suse.com>
 <CANpmjNOHY1GC_Fab4T6J06vqW0vRf=4jQR0dG0MJoFOPpKzcUA@mail.gmail.com>
 <20220715095156.12a3a0e3@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220715095156.12a3a0e3@gandalf.local.home>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 09:51:56AM -0400, Steven Rostedt wrote:
> On Fri, 15 Jul 2022 14:39:52 +0200
> Marco Elver <elver@google.com> wrote:
> 
> > Couldn't this just use rcu_is_watching()?
> > 
> >   | * rcu_is_watching - see if RCU thinks that the current CPU is not idle
> 
> Maybe, but I was thinking that Petr had a way to hit the issue that we
> worry about. But since the non _rcuide() call requires rcu watching,
> prehaps that is better to use.

In case this helps...  ;-)

The rcu_is_watching() function is designed to be used from the current
CPU, so it dispenses with memory ordering.  However, it explicitly
disables preemption in order to avoid weird preemption patterns.

The formulation that Marco used is designed to be used from a remote
CPU, and so it includes explicit memory ordering that is not needed
in this case.  But it does not disable preemption.

So if preemption is enabled at that point in tracing, you really want
to be using rcu_is_watching().

							Thanx, Paul
