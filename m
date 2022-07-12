Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C337571BAF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 15:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233230AbiGLNtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 09:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233416AbiGLNtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 09:49:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4726E4F195
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 06:49:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F2A58B817D2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 13:49:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A82DDC3411C;
        Tue, 12 Jul 2022 13:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657633756;
        bh=3ZHbpCASO7F/9OAQZczcQxK6Z78ZRcAd0qGnuMuG9xU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=vMguKPxddNuWFBigAtc6alDqrdbseqfwt3fJN+73n4B3BU5RrCRhzKWzpTyCypkXJ
         VgSO+RjWvPlxNCPxdR1ZddO6ve7aNjjzUNiIYPei8+/8Wy9DT+j5Thnx61GYs+Lxtq
         6YT9dexeenlA9hMT96ZvyrtKGn99UKsW8jvwfJQY3vjs2MF5nEGA2pW70RtXXBr14E
         i4l3l0F3DtCOxg/Ph629eQBUMkvYi67aayKY63BUan7+L3+99OfuCER3vikNj8E6pB
         9qVjPvpmZvvPVYimLJJKdQ52nRaS4euio6TUvsKUB3BLzVnxUdWGFJEwFXa9hTUIYZ
         w0Fe9d4GPjX9Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3CFA45C0516; Tue, 12 Jul 2022 06:49:16 -0700 (PDT)
Date:   Tue, 12 Jul 2022 06:49:16 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Marco Elver <elver@google.com>,
        John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Johannes Berg <johannes.berg@intel.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Linux Kernel Functional Testing <lkft@linaro.org>
Subject: Re: [PATCH -printk] printk, tracing: fix console tracepoint
Message-ID: <20220712134916.GT1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220503073844.4148944-1-elver@google.com>
 <20220711182918.338f000f@gandalf.local.home>
 <20220712002128.GQ1790663@paulmck-ThinkPad-P17-Gen-1>
 <20220711205319.1aa0d875@gandalf.local.home>
 <20220712025701.GS1790663@paulmck-ThinkPad-P17-Gen-1>
 <20220712114954.GA3870114@paulmck-ThinkPad-P17-Gen-1>
 <20220712093940.45012e47@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220712093940.45012e47@gandalf.local.home>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 09:39:40AM -0400, Steven Rostedt wrote:
> On Tue, 12 Jul 2022 04:49:54 -0700
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > > But a quick fix that stopped the bleeding and allowed printk() to
> > > progress would be useful in the short term, regardless of whether or
> > > not in the longer term it makes sense to make srcu_read_lock_trace()
> > > and srcu_read_unlock_trace() NMI-safe.  
> > 
> > Except that doesn't rcuidle && in_nmi() imply a misplaced trace event?
> > 
> > Isn't it still the case that you are not supposed to have trace events
> > in NMI handlers before RCU is watching or after it is no longer watching,
> > just as for entry/exit code in general?  Once in the body of the handler,
> > rcuidle should be false and all should be well.
> > 
> > Or am I missing something here?
> 
> I guess the question is, can we have printk() in such a place? Because this
> tracepoint is attached to printk and where ever printk is done so is this
> tracepoint.

As I understand it, code in such a place should be labeled noinstr.
Then the call to printk() would be complained about as an illegal
noinstr-to-non-noinstr call.

But where exactly is that printk()?

							Thanx, Paul
