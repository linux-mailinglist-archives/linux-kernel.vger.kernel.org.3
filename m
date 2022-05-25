Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C444534229
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 19:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245659AbiEYR0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 13:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244575AbiEYR0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 13:26:11 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6E9811116E
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 10:26:10 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2BF4A1424;
        Wed, 25 May 2022 10:26:10 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.0.228])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 27C4C3F66F;
        Wed, 25 May 2022 10:26:08 -0700 (PDT)
Date:   Wed, 25 May 2022 18:26:04 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Wangshaobo (bobo)" <bobo.shaobowang@huawei.com>,
        cj.chengjian@huawei.com, huawei.libin@huawei.com,
        xiexiuqi@huawei.com, liwei391@huawei.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, will@kernel.org, zengshun.wu@outlook.com
Subject: Re: [RFC PATCH -next v2 0/4] arm64/ftrace: support dynamic trampoline
Message-ID: <Yo5mrDnNctKmG2PQ@FVFF77S0Q05N>
References: <20220316100132.244849-1-bobo.shaobowang@huawei.com>
 <20220420141143.23286faa@gandalf.local.home>
 <5ddc2722-4489-f66d-552d-1f4c755b5d30@huawei.com>
 <20220421083758.37b239a4@gandalf.local.home>
 <Yo4k2Y8oNcKG5ca0@FVFF77S0Q05N>
 <20220525095845.53ec8fe0@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220525095845.53ec8fe0@gandalf.local.home>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 09:58:45AM -0400, Steven Rostedt wrote:
> On Wed, 25 May 2022 13:45:13 +0100
> Mark Rutland <mark.rutland@arm.com> wrote:
> 
> > ... the compiler places 3 NOPs *before* any BTI, and 2 NOPs *after* any BTI,
> > still recording the location of the first NOP. So in the two cases we get:
> > 
> > 		NOP		<--- recorded location
> > 		NOP
> > 		NOP
> > 	__func_without_bti:
> > 		NOP
> > 		NOP
> > 
> > 		NOP		<--- recorded location
> > 		NOP
> > 		NOP
> > 	__func_with_bti:
> > 		BTI
> > 		NOP
> > 		NOP
> 
> Are you saying that the above "recorded location" is what we have in
> mcount_loc section?

Yes; I'm saying that with this series, the compiler would record that into the
mcount_loc section.

Note that's not necessarily what goes into rec->ip, which we can adjust at
initialization time to be within the function. We'd need to record the
presence/absence of the BTI somewhere (I guess in dyn_arch_ftrace).

> If that's the case, we will need to modify it to point to something that
> kallsyms will recognize (ie. sym+0 or greater). Because that will cause
> set_ftrace_filter to fail as well.

Yup, understood. Like I mentioned it also wrecks the unwinder and would make it
really hard to implement RELIABLE_STACKTRACE.

Just to be clear, I don't think we should follow this specific approach. I just
wrote the examples to clarify what was being proposed.

Thanks,
Mark.
