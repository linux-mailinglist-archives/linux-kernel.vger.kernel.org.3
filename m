Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0C650B4C2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 12:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446451AbiDVKPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 06:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233775AbiDVKPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 06:15:40 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8CDC253A7E
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 03:12:46 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4CAD31576;
        Fri, 22 Apr 2022 03:12:46 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.74.110])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7D0D33F766;
        Fri, 22 Apr 2022 03:12:44 -0700 (PDT)
Date:   Fri, 22 Apr 2022 11:12:39 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Wang ShaoBo <bobo.shaobowang@huawei.com>, cj.chengjian@huawei.com,
        huawei.libin@huawei.com, xiexiuqi@huawei.com, liwei391@huawei.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, will@kernel.org, zengshun.wu@outlook.com
Subject: Re: [RFC PATCH -next v2 3/4] arm64/ftrace: support dynamically
 allocated trampolines
Message-ID: <YmJ/l4vJoEpFt68l@FVFF77S0Q05N>
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Yup!

> I guess you could have two trampolines as well. One that always calls the
> list loop, and one that calls the data stored in front of the function that
> was just called the trampoline. As it is always safe to call the loop
> function, you could have the call call that trampoline first, set up the
> specific data before the function, then call the trampoline that will read
> it. And same thing for tear down.

Having separate trampolines is possible, but there are some complications, and
we might end up with an explosion of trampolines (and associated module PLTs)
due to needing BTI/!BTI and REGs/!REGS variants, so if it's possible to have a
default ops that handled the list case, that'd be my preference to keep that
simple and manageable.

As an aside, I'd also love to remove the REGS/!REGs distinction, and always
save a minimum amount of state (like ARGS, but never saving a full pt_regs),
since on arm64 the extra state stored for the REGS case isn't useful (and we
can't reliably capture all of the pt_regs state anyway, so bits of it are made
up or not filled in).

Thanks,
Mark.
