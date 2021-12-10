Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2944709A3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 20:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245364AbhLJTHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 14:07:08 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:58572 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235573AbhLJTHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 14:07:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B523BB829BB;
        Fri, 10 Dec 2021 19:03:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FE5BC00446;
        Fri, 10 Dec 2021 19:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639163009;
        bh=JOiolUAx3L5MxkUAVXE7PyChsErEriCCe8q1eTmoOgU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZRDysF11OdoxdSegspzuBZX3mQ4nnhL0+Mcy62/cAzNdIUmMNl0e/kd5LBce6f+qL
         dVkljIKl18a4PeLsEi7ItQpYMaKqBpGkWhTctWIaY/A8bnmGvcx7fQr3/Fvo0tuHSh
         JzeNF6vkO0lL1VwkKG7IgWdc5n+vZ9KXurVtT2/YYAwJ1Gn6Rt8B2y6r2PwfFBvF5L
         2Zy1W9S3defbLesjC8RtgRvo3yDVlKcYX0GrSGJTjf3/DN2WekW+e2Gfs8/TW5vufd
         r4njAV1XPLI4ldoFygn6X6xoW+B16c3qKEq8NxnBDp0vBMBoMdc+FI0w3dJFsJmQjC
         jamuMkXzFx+Qw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5B6DC405D8; Fri, 10 Dec 2021 16:03:27 -0300 (-03)
Date:   Fri, 10 Dec 2021 16:03:27 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     James Clark <james.clark@arm.com>
Cc:     Leo Yan <leo.yan@linaro.org>, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org, suzuki.poulose@arm.com,
        Mike Leach <mike.leach@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf cs-etm: Remove duplicate and incorrect aux size
 checks
Message-ID: <YbOkf5C46OZGEJVM@kernel.org>
References: <20211208115435.610101-1-james.clark@arm.com>
 <20211208131753.GC273781@leoy-ThinkPad-X240s>
 <269d2f14-0594-c73e-97b5-82e72f76e826@arm.com>
 <20211209134413.GA622826@leoy-ThinkPad-X240s>
 <6a7fd600-91f3-5feb-d21f-ec7cb704f84c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a7fd600-91f3-5feb-d21f-ec7cb704f84c@arm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Dec 09, 2021 at 02:16:43PM +0000, James Clark escreveu:
> 
> 
> On 09/12/2021 13:44, Leo Yan wrote:
> > On Wed, Dec 08, 2021 at 02:08:04PM +0000, James Clark wrote:
> >> On 08/12/2021 13:17, Leo Yan wrote:
> >>> Hi James,
> >>>
> >>> On Wed, Dec 08, 2021 at 11:54:35AM +0000, James Clark wrote:
> >>>> There are two checks, one is for size when running without admin, but
> >>>> this one is covered by the driver and reported on in more detail here
> >>>> (builtin-record.c):
> >>>>
> >>>>   pr_err("Permission error mapping pages.\n"
> >>>>          "Consider increasing "
> >>>>          "/proc/sys/kernel/perf_event_mlock_kb,\n"
> >>>>          "or try again with a smaller value of -m/--mmap_pages.\n"
> >>>>          "(current value: %u,%u)\n",
> >>>
> >>> I looked into the kernel code and found:
> >>>
> >>>   sysctl_perf_event_mlock = 512 + (PAGE_SIZE / 1024);  // 512KB + 1 page
> >>>
> >>> If the system have multiple cores, let's say 8 cores, then kernel even
> >>> can relax the limitaion with:
> >>>
> >>>   user_lock_limit *= num_online_cpus();
> >>>
> >>> So means the memory lock limitation is:
> >>>
> >>>   (512KB + 1 page) * 8 = 4MB + 8 pages.
> >>>
> >>> Seems to me, it's much relax than the user space's limitaion 128KB.
> >>> And let's imagine for Arm server, the permitted buffer size can be a
> >>> huge value (e.g. for a system with 128 cores).
> >>>
> >>> Could you confirm if this is right?
> >>
> >> Yes that seems to be the case. And the commit message for that addition
> >> states the reasoning:
> >>
> >>   perf_counter: Increase mmap limit
> >>   
> >>   In a default 'perf top' run the tool will create a counter for
> >>   each online CPU. With enough CPUs this will eventually exhaust
> >>   the default limit.
> >>
> >>   So scale it up with the number of online CPUs.
> >>
> >> To me that makes sense. Normally the memory installed also scales with the
> >> number of cores.
> >>
> >> Are you saying that we should look into modifying that scaling factor in
> >> perf_mmap()? Or that we should still add something to userspace for
> >> coresight to limit user supplied buffer sizes?
> > 
> > I don't think we should modify the scaling factor in perf_mmap(), the
> > logic is not only used by AUX buffer, it's shared by normal event
> > ring buffer.
> > 
> >> I think it makes sense to allow the user to specify any value that will work,
> >> it's up to them.
> > 
> > Understand, I verified this patch with below steps:
> > 
> > root@debian:~# echo 0 > /proc/sys/kernel/perf_event_paranoid
> > 
> > leoy@debian:~$ perf record -e cs_etm// -m 4M,8M -o perf_test.data -- sleep 1
> > Permission error mapping pages.
> > Consider increasing /proc/sys/kernel/perf_event_mlock_kb,
> > or try again with a smaller value of -m/--mmap_pages.
> > (current value: 1024,2048)
> > 
> > leoy@debian:~$ perf record -e cs_etm// -m 4M,4M -o perf_test.data -- sleep 1
> > Couldn't synthesize bpf events.
> > [ perf record: Woken up 1 times to write data ]
> > [ perf record: Captured and wrote 0.607 MB perf_test.data ]
> > 
> > So this patch looks good for me:
> > 
> > Reviewed-by: Leo Yan <leo.yan@linaro.org>
> > 
> Thanks Leo!


Thanks, applied.

- Arnaldo

