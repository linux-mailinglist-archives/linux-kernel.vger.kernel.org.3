Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA06534210
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 19:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245628AbiEYRMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 13:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245623AbiEYRMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 13:12:34 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 25246366B6
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 10:12:34 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B0AA81424;
        Wed, 25 May 2022 10:12:33 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.0.228])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CAACE3F66F;
        Wed, 25 May 2022 10:12:31 -0700 (PDT)
Date:   Wed, 25 May 2022 18:12:27 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Wang ShaoBo <bobo.shaobowang@huawei.com>,
        cj.chengjian@huawei.com, huawei.libin@huawei.com,
        xiexiuqi@huawei.com, liwei391@huawei.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, will@kernel.org, zengshun.wu@outlook.com,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [RFC PATCH -next v2 3/4] arm64/ftrace: support dynamically
 allocated trampolines
Message-ID: <Yo5je4lFfticCPIC@FVFF77S0Q05N>
References: <YnJUTuOIX9YoJq23@FVFF77S0Q05N>
 <20220505121538.04773ac98e2a8ba17f675d39@kernel.org>
 <20220509142203.6c4f2913@gandalf.local.home>
 <20220510181012.d5cba23a2547f14d14f016b9@kernel.org>
 <20220510104446.6d23b596@gandalf.local.home>
 <20220511233450.40136cdf6a53eb32cd825be8@kernel.org>
 <20220511111207.25d1a693@gandalf.local.home>
 <20220512210231.f9178a98f20a37981b1e89e3@kernel.org>
 <Yo4eWqHA/IjNElNN@FVFF77S0Q05N>
 <20220525094307.1f1fb561@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220525094307.1f1fb561@gandalf.local.home>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 09:43:07AM -0400, Steven Rostedt wrote:
> On Wed, 25 May 2022 13:17:30 +0100
> Mark Rutland <mark.rutland@arm.com> wrote:
> 
> > For arm64 I'd like to make this static, and have ftrace *always* capture a
> > minimal set of ftrace_regs, which would be:
> > 
> >   X0 to X8 inclusive
> >   SP
> >   PC
> >   LR
> >   FP
> > 
> > Since X0 to X8 + SP is all that we need for arguments and return values (per
> > the calling convention we use), and PC+LR+FP gives us everything we need for
> > unwinding and live patching.
> > 
> > I *might* want to add x18 to that when SCS is enabled, but I'm not immediately
> > sure.
> 
> Does arm64 have HAVE_DYNAMIC_FTRACE_WITH_ARGS enabled?

Not yet. I'd like to implement it, but always only saving the values above and
never saving a full pt_regs (since as mentioned elsewhere we can't do that
correctly anyway).

> If so, then having the normal ftrace call back save the above so that all
> functions have it available would be useful.

I think that's what I'm saying: I'd want to have one trampoline which always
saved the above, so all functions would get that.

Thanks,
Mark.
