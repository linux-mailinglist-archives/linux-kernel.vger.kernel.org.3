Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A11E250FE4C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 15:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350574AbiDZNJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 09:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350640AbiDZNJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 09:09:53 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 930AD62C4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 06:06:45 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 37FC123A;
        Tue, 26 Apr 2022 06:06:45 -0700 (PDT)
Received: from airbuntu (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 87BAD3F774;
        Tue, 26 Apr 2022 06:06:43 -0700 (PDT)
Date:   Tue, 26 Apr 2022 14:06:27 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Xuewen Yan <xuewen.yan94@gmail.com>,
        Xuewen Yan <xuewen.yan@unisoc.com>, dietmar.eggemann@arm.com,
        lukasz.luba@arm.com, rafael@kernel.org, viresh.kumar@linaro.org,
        mingo@redhat.com, peterz@infradead.org, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, di.shen@unisoc.com
Subject: Re: [PATCH] sched: Take thermal pressure into account when determine
 rt fits capacity
Message-ID: <20220426130627.febddumioeffvtng@airbuntu>
References: <20220407051932.4071-1-xuewen.yan@unisoc.com>
 <20220420135127.o7ttm5tddwvwrp2a@airbuntu>
 <CAB8ipk-tWjkeAbV=BDhNy04Yq6rdLf80x_7twuLV=HqT4nc1+w@mail.gmail.com>
 <20220421161509.asz25zmh25eurgrk@airbuntu>
 <CAB8ipk_rZnwDrMaY-zJxR3pByYWD1XOP2waCgU9DZzQNpCN2zA@mail.gmail.com>
 <20220425161209.ydugtrs3b7gyy3kk@airbuntu>
 <CAB8ipk9hZXDcTV3hakRV+dE5dwKtg-Ka93WZ60ds0=4ErN1-0w@mail.gmail.com>
 <CAKfTPtBswQ6bk8MrvcLmqc-9V2-SeWn3H_-gRvF5isdjL_acqA@mail.gmail.com>
 <20220426093056.uxnsz4tv4vhvbipe@airbuntu>
 <CAKfTPtDtpYs38aZG8UVkbrrWxbARKwFnV204vjRoyf58K=+4oQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtDtpYs38aZG8UVkbrrWxbARKwFnV204vjRoyf58K=+4oQ@mail.gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/26/22 12:06, Vincent Guittot wrote:
> > Wouldn't this be expensive to have 3 loops? That was my other suggestion but
> > wasn't sure the complexity was worth it. So I suggested handling the capacity
> > inversion case only.
> 
> 3 loops might be too expensive. I mainly want to make sure to
> understand what should be done to fix Xuewen case without breaking
> others. Then we can see how to optimize this in a reasonable number of
> loop

The generic solution is what I tried to outline before:

> So if we want to handle this case, then we need to ensure the search returns
> false only if
>
>         1. Thermal pressure results in real OPP to be omitted.
>         2. Another CPU that can provide this performance level is available.
>
> Otherwise we should still fit it on this CPU because it'll give us the closest
> thing to what was requested.

And we can do this in 2 ways, 3 loops as you said, or by creating a fallback
cpumask as we search so that by the end we can resolve to it if we didn't find
the best fit.

My only worry here is that Xuewen doesn't see thermal issues on mids, so
testability is a problem. This generic solution will only help with the case of
mids losing some OPPs at the top, then we can do better by selecting a big core
instead of a medium (if not in capacity inversion itself).

I *think* (and I don't feel strongly about it at all), checking for capacity
inversion and bypassing that cpu, or only then consider its thermal pressure,
is the right approach to take here until someone reports more woes due to
thermal pressure.

That said, the generic solution might not be that bad actually and I'm just
being a bit conservative. So would be good to hear what others think.


Thanks

--
Qais Yousef
