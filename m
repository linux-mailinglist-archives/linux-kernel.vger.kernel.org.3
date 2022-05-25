Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 931E4533CE1
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 14:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239481AbiEYMpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 08:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbiEYMpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 08:45:21 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6A018703CF
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 05:45:20 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 246621FB;
        Wed, 25 May 2022 05:45:20 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.0.228])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D68203F73D;
        Wed, 25 May 2022 05:45:17 -0700 (PDT)
Date:   Wed, 25 May 2022 13:45:13 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Wangshaobo (bobo)" <bobo.shaobowang@huawei.com>,
        cj.chengjian@huawei.com, huawei.libin@huawei.com,
        xiexiuqi@huawei.com, liwei391@huawei.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, will@kernel.org, zengshun.wu@outlook.com
Subject: Re: [RFC PATCH -next v2 0/4] arm64/ftrace: support dynamic trampoline
Message-ID: <Yo4k2Y8oNcKG5ca0@FVFF77S0Q05N>
References: <20220316100132.244849-1-bobo.shaobowang@huawei.com>
 <20220420141143.23286faa@gandalf.local.home>
 <5ddc2722-4489-f66d-552d-1f4c755b5d30@huawei.com>
 <20220421083758.37b239a4@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220421083758.37b239a4@gandalf.local.home>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 08:37:58AM -0400, Steven Rostedt wrote:
> On Thu, 21 Apr 2022 09:13:01 +0800
> "Wangshaobo (bobo)" <bobo.shaobowang@huawei.com> wrote:
> 
> > Not yet, Steve, ftrace_location() looks has no help to find a right 
> > rec->ip in our case,
> > 
> > ftrace_location() can find a right rec->ip when input ip is in the range 
> > between
> > 
> > sym+0 and sym+$end, but our question is how to  identify rec->ip from 
> > __mcount_loc,
> 
> Are you saying that the "ftrace location" is not between sym+0 and sym+$end?

IIUC yes -- this series as-is moves the call to the trampoline *before* sym+0.

Among other things that completely wrecks backtracing, so I'd *really* like to
avoid that (hance my suggested alternative).

> > this changed the patchable entry before bti to after in gcc:
> > 
> >     [1] https://reviews.llvm.org/D73680
> > 
> > gcc tells the place of first nop of the 5 NOPs when using 
> > -fpatchable-function-entry=5,3,
> > 
> > but not tells the first nop after bti, so we don't know how to adjust 
> > our rec->ip for ftrace.
> 
> OK, so I do not understand how the compiler is injecting bti with mcount
> calls, so I'll just walk away for now ;-)

When using BTI, the compiler has to drop a BTI *at* the function entry point
(i.e. sym+0) for any function that can be called indirectly, but can omit this
when the function is only directly called (which is the case for most functions
created via insterprocedural specialization, or for a number of static
functions).

Today, when we pass:

	-fpatchable-function-entry=2

... the compiler places 2 NOPs *after* any BTI, and records the location of the
first NOP. So the two cases we get are:

	__func_without_bti:
		NOP		<--- recorded location
		NOP

	__func_with_bti:
		BTI
		NOP		<--- recorded location
		NOP

... which works just fine, since either sym+0 or sym+4 are reasonable
locations for the patch-site to live.

However, if we were to pass:

	-fpatchable-function-entry=5,3

... the compiler places 3 NOPs *before* any BTI, and 2 NOPs *after* any BTI,
still recording the location of the first NOP. So in the two cases we get:

		NOP		<--- recorded location
		NOP
		NOP
	__func_without_bti:
		NOP
		NOP

		NOP		<--- recorded location
		NOP
		NOP
	__func_with_bti:
		BTI
		NOP
		NOP

... so where we want to patch one of the later nops to banch to a pre-function
NOP, we need to know whether or not the compiler generated a BTI. We can
discover discover that either by:

* Checking whether the recorded location is at sym+0 (no BTI) or sym+4 (BTI).

* Reading the instruction before the recorded location, and seeing if this is a
  BTI.

... and depending on how we handle thigns the two cases *might* need different
trampolines.

Thanks,
Mark.
