Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3BE576466
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 17:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235365AbiGOPZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 11:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235037AbiGOPZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 11:25:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4625E419A1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 08:25:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 717C5B82D08
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 15:25:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6BF6C34115;
        Fri, 15 Jul 2022 15:25:17 +0000 (UTC)
Date:   Fri, 15 Jul 2022 11:25:16 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
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
Message-ID: <20220715112516.58e9e5f8@gandalf.local.home>
In-Reply-To: <20220715151000.GY1790663@paulmck-ThinkPad-P17-Gen-1>
References: <20220715120152.17760-1-pmladek@suse.com>
        <CANpmjNOHY1GC_Fab4T6J06vqW0vRf=4jQR0dG0MJoFOPpKzcUA@mail.gmail.com>
        <20220715095156.12a3a0e3@gandalf.local.home>
        <20220715151000.GY1790663@paulmck-ThinkPad-P17-Gen-1>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jul 2022 08:10:00 -0700
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> So if preemption is enabled at that point in tracing, you really want
> to be using rcu_is_watching().

And yes, at that point in tracing, preemption is still enabled if the
tracepoint was called with preemption enabled.

Thus, we really need to convert that to rcu_is_watching().

-- Steve
