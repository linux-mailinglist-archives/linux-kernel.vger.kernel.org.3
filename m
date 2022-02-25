Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF09A4C472C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 15:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241474AbiBYOOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 09:14:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236789AbiBYOOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 09:14:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82421DA036
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 06:14:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4246360F13
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 14:14:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14895C340E7;
        Fri, 25 Feb 2022 14:14:10 +0000 (UTC)
Date:   Fri, 25 Feb 2022 09:14:09 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, x86@kernel.org,
        joao@overdrivepizza.com, hjl.tools@gmail.com, jpoimboe@redhat.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz,
        alexei.starovoitov@gmail.com
Subject: Re: [PATCH v2 15/39] x86/ibt,kprobes: Fix more +0 assumptions
Message-ID: <20220225091409.0963e7d2@gandalf.local.home>
In-Reply-To: <YhizfwoddLwWWl2J@hirez.programming.kicks-ass.net>
References: <20220224145138.952963315@infradead.org>
        <20220224151322.892372059@infradead.org>
        <20220225103215.77080de0b3edd0fa2839b8fa@kernel.org>
        <YhizfwoddLwWWl2J@hirez.programming.kicks-ass.net>
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

On Fri, 25 Feb 2022 11:46:23 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> Given all that, kprobe users are in a bit of a bind. Determining the
> __fentry__ point basically means they *have* to first read the function
> assembly to figure out where it is.

Technically I think that's what kprobes has been designed for. But
realistically, I do not think anyone actually does that (outside of
academic and niche uses).

Really, when people use func+0 they just want to trace the function, and
ftrace is the fastest way to do so, and if it's not *exactly* at function
entry, but includes the arguments, then it should be fine.

That said, perhaps we should add a config to know if the architecture
uses function entry or the old mcount that is after the frame set up (that
is, you can not get to the arguments).

CONFIG_HAVE_FTRACE_FUNCTION_START ?

Because, if the arch still uses the old mcount method (where it's after the
frame set up), then a kprobe at func+0 really wants the breakpoint.

-- Steve

