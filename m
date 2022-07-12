Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79BBF571B77
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 15:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232810AbiGLNjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 09:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiGLNjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 09:39:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92EA7B523D
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 06:39:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4AACBB818CE
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 13:39:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B06EC3411C;
        Tue, 12 Jul 2022 13:39:42 +0000 (UTC)
Date:   Tue, 12 Jul 2022 09:39:40 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
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
Message-ID: <20220712093940.45012e47@gandalf.local.home>
In-Reply-To: <20220712114954.GA3870114@paulmck-ThinkPad-P17-Gen-1>
References: <20220503073844.4148944-1-elver@google.com>
        <20220711182918.338f000f@gandalf.local.home>
        <20220712002128.GQ1790663@paulmck-ThinkPad-P17-Gen-1>
        <20220711205319.1aa0d875@gandalf.local.home>
        <20220712025701.GS1790663@paulmck-ThinkPad-P17-Gen-1>
        <20220712114954.GA3870114@paulmck-ThinkPad-P17-Gen-1>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jul 2022 04:49:54 -0700
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> > But a quick fix that stopped the bleeding and allowed printk() to
> > progress would be useful in the short term, regardless of whether or
> > not in the longer term it makes sense to make srcu_read_lock_trace()
> > and srcu_read_unlock_trace() NMI-safe.  
> 
> Except that doesn't rcuidle && in_nmi() imply a misplaced trace event?
> 
> Isn't it still the case that you are not supposed to have trace events
> in NMI handlers before RCU is watching or after it is no longer watching,
> just as for entry/exit code in general?  Once in the body of the handler,
> rcuidle should be false and all should be well.
> 
> Or am I missing something here?

I guess the question is, can we have printk() in such a place? Because this
tracepoint is attached to printk and where ever printk is done so is this
tracepoint.

-- Steve
