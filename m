Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCD150A191
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 16:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388058AbiDUOJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 10:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358063AbiDUOJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 10:09:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D1F2C3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 07:06:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A711D61D4D
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 14:06:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0D01C385A5;
        Thu, 21 Apr 2022 14:06:41 +0000 (UTC)
Date:   Thu, 21 Apr 2022 10:06:39 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Wang ShaoBo <bobo.shaobowang@huawei.com>, cj.chengjian@huawei.com,
        huawei.libin@huawei.com, xiexiuqi@huawei.com, liwei391@huawei.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, will@kernel.org, zengshun.wu@outlook.com
Subject: Re: [RFC PATCH -next v2 3/4] arm64/ftrace: support dynamically
 allocated trampolines
Message-ID: <20220421100639.03c0d123@gandalf.local.home>
In-Reply-To: <YmFXrBG5AmX3+4f8@lakrids>
References: <20220316100132.244849-1-bobo.shaobowang@huawei.com>
        <20220316100132.244849-4-bobo.shaobowang@huawei.com>
        <YmFXrBG5AmX3+4f8@lakrids>
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

On Thu, 21 Apr 2022 14:10:04 +0100
Mark Rutland <mark.rutland@arm.com> wrote:

> On Wed, Mar 16, 2022 at 06:01:31PM +0800, Wang ShaoBo wrote:
> > From: Cheng Jian <cj.chengjian@huawei.com>
> > 
> > When tracing multiple functions customly, a list function is called
> > in ftrace_(regs)_caller, which makes all the other traced functions
> > recheck the hash of the ftrace_ops when tracing happend, apparently
> > it is inefficient.  
> 
> ... and when does that actually matter? Who does this and why?

I don't think it was explained properly. What dynamically allocated
trampolines give you is this.

Let's say you have 10 ftrace_ops registered (with bpf and kprobes this can
be quite common). But each of these ftrace_ops traces a function (or
functions) that are not being traced by the other ftrace_ops. That is, each
ftrace_ops has its own unique function(s) that they are tracing. One could
be tracing schedule, the other could be tracing ksoftirqd_should_run
(whatever).

Without this change, because the arch does not support dynamically
allocated trampolines, it means that all these ftrace_ops will be
registered to the same trampoline. That means, for every function that is
traced, it will loop through all 10 of theses ftrace_ops and check their
hashes to see if their callback should be called or not.

With dynamically allocated trampolines, each ftrace_ops will have their own
trampoline, and that trampoline will be called directly if the function
is only being traced by the one ftrace_ops. This is much more efficient.

If a function is traced by more than one ftrace_ops, then it falls back to
the loop.

-- Steve
