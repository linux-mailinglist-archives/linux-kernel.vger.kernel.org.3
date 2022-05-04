Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 147CB519FCB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 14:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349890AbiEDMrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 08:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235027AbiEDMrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 08:47:07 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8D62A33A1B
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 05:43:30 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F0661042;
        Wed,  4 May 2022 05:43:30 -0700 (PDT)
Received: from lakrids (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E24503FA50;
        Wed,  4 May 2022 05:43:28 -0700 (PDT)
Date:   Wed, 4 May 2022 13:43:26 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Wang ShaoBo <bobo.shaobowang@huawei.com>, cj.chengjian@huawei.com,
        huawei.libin@huawei.com, xiexiuqi@huawei.com, liwei391@huawei.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, will@kernel.org, zengshun.wu@outlook.com
Subject: Re: [RFC PATCH -next v2 3/4] arm64/ftrace: support dynamically
 allocated trampolines
Message-ID: <YnJ07mRU3wCd9G/G@lakrids>
References: <20220316100132.244849-1-bobo.shaobowang@huawei.com>
 <20220316100132.244849-4-bobo.shaobowang@huawei.com>
 <YmFXrBG5AmX3+4f8@lakrids>
 <20220421100639.03c0d123@gandalf.local.home>
 <YmF0xYpTMoWOIl00@lakrids>
 <20220421114201.21228eeb@gandalf.local.home>
 <YmGF/OpIhAF8YeVq@lakrids>
 <20220421130648.56b21951@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421130648.56b21951@gandalf.local.home>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 01:06:48PM -0400, Steven Rostedt wrote:
> On Thu, 21 Apr 2022 17:27:40 +0100
> Mark Rutland <mark.rutland@arm.com> wrote:
> 
> > We can initialize the ops pointer to a default ops that does the whole
> > __do_for_each_ftrace_ops() dance.
> 
> OK, I think I understand now. What you are doing is instead of creating a
> trampoline that has all the information in the trampoline, you add nops to
> all the functions where you can place the information in the nops (before
> the function), and then have the trampoline just read that information to
> find the ops pointer as well as the function to call.

FWIW, I had a go at mocking that up:

  https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=arm64/ftrace/per-callsite-ops

Aside from some bodges required to ensure the patch site is suitably aligned
(which I think can be cleaned up somewhat), I don't think it looks that bad.

I wasn't sure how exactly to wire that up in the core code, so all the patch
sites are initialized with a default ops that calls
arch_ftrace_ops_list_func(), but it looks like it should be possible to wire
that up in the core with some refactoring.

> I guess you could have two trampolines as well. One that always calls the
> list loop, and one that calls the data stored in front of the function that
> was just called the trampoline. As it is always safe to call the loop
> function, you could have the call call that trampoline first, set up the
> specific data before the function, then call the trampoline that will read
> it. 

I was thinking we could just patch the ops with a default ops that called the
list loop, as my patches default them to.

> And same thing for tear down.

I wasn't sure how teardown was meant to work in general. When we want to
remove an ops structure, or a trampoline, how do we ensure those are no
longer in use before we remove them? I can see how we can synchronize
the updates to the kernel text, but I couldn't spot how we handle a
thread being in the middle of a trampoline.

Thanks,
Mark.
