Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA1446E948
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 14:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238120AbhLINsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 08:48:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238104AbhLINr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 08:47:59 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76912C0617A1
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 05:44:25 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id o20so19723649eds.10
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 05:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/P7JyKzF/v/3ZO7cpw/ewb9zmhNlHQlGSxlJdVFxVKM=;
        b=J6dkM2Cjw2bKv0h+Jm7zaQhhCzcDE3NK+JhEds0Adhn+jEdJCkbL9TuYvk0LbRdpDi
         KFCTB3LYSVGw4EeR8nBWpZ+OBmD4jbRE1fKJvpjd7Q4xctKdJd62OOcX3jFvdBPDcN0w
         R5xTtEI4cM516WioF0QR5OlROWue2wdpYWdUQSsGF92kpKPde9ZbQsNTVFcm9HWl2v1g
         aR//L0SmctBpWwyRmKqbXt/I50Sp5Uc42eOKLiJBYPdeNZe8XQEbei/19j8AMZ6gEUm4
         AWN4OcUm5N428IWaNU2sOm4NC5NOQ6PvkbJvEo64qwnBWLgjmmjX9sBL33nGCmfy0XcP
         j9qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/P7JyKzF/v/3ZO7cpw/ewb9zmhNlHQlGSxlJdVFxVKM=;
        b=qTu3g9xGkMLGMRhT9axEU0d1EG11/mIYFkNy4Gh4r8FswRmjzwATUT2rIgXnFAe0Vg
         UKryCxa5UQqfC1fN+bdGDe72tdUe+Mnxgxqrsk3sF63Do2//BYnQq4z9TdxG0xye2DNM
         ilH43cMFrO523vXsEdDue5/JfsPNduswpxPFTAhK4ltKUNuPtgZ6wqLmvkhXnLDalxmv
         7H6Pw+Qggb8rGkP57Eiq2B9u+fraRncmYXCr/GP0XvhrZ2R4WLk7xM8lJRFjmCx7w/7T
         5l/6dv3ukgIJK2rb3HHF2l1t5Mpp11HGjBZkq9OlJJC9rhFyndDTaiLc/laG1DlDTnGM
         TJHA==
X-Gm-Message-State: AOAM531duqVDOnRElYpwPz9T13+hxG4fCKOQx2KZluNtypnpdlaFPQM5
        VMLpNbbQaeq5VdDM6PJik71Hzw==
X-Google-Smtp-Source: ABdhPJyBCkgKJy1pCncpkj5tRHY7I6oOkDUgk02zHCUY9oeeGY3D/c2xkBHHYAJYLm0D57jgvSKtLg==
X-Received: by 2002:a17:907:1629:: with SMTP id hb41mr16490427ejc.328.1639057463705;
        Thu, 09 Dec 2021 05:44:23 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([104.245.96.202])
        by smtp.gmail.com with ESMTPSA id t3sm3546168edr.63.2021.12.09.05.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 05:44:23 -0800 (PST)
Date:   Thu, 9 Dec 2021 21:44:13 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     mathieu.poirier@linaro.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, Mike Leach <mike.leach@linaro.org>,
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
Message-ID: <20211209134413.GA622826@leoy-ThinkPad-X240s>
References: <20211208115435.610101-1-james.clark@arm.com>
 <20211208131753.GC273781@leoy-ThinkPad-X240s>
 <269d2f14-0594-c73e-97b5-82e72f76e826@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <269d2f14-0594-c73e-97b5-82e72f76e826@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2021 at 02:08:04PM +0000, James Clark wrote:
> On 08/12/2021 13:17, Leo Yan wrote:
> > Hi James,
> > 
> > On Wed, Dec 08, 2021 at 11:54:35AM +0000, James Clark wrote:
> >> There are two checks, one is for size when running without admin, but
> >> this one is covered by the driver and reported on in more detail here
> >> (builtin-record.c):
> >>
> >>   pr_err("Permission error mapping pages.\n"
> >>          "Consider increasing "
> >>          "/proc/sys/kernel/perf_event_mlock_kb,\n"
> >>          "or try again with a smaller value of -m/--mmap_pages.\n"
> >>          "(current value: %u,%u)\n",
> > 
> > I looked into the kernel code and found:
> > 
> >   sysctl_perf_event_mlock = 512 + (PAGE_SIZE / 1024);  // 512KB + 1 page
> > 
> > If the system have multiple cores, let's say 8 cores, then kernel even
> > can relax the limitaion with:
> > 
> >   user_lock_limit *= num_online_cpus();
> > 
> > So means the memory lock limitation is:
> > 
> >   (512KB + 1 page) * 8 = 4MB + 8 pages.
> > 
> > Seems to me, it's much relax than the user space's limitaion 128KB.
> > And let's imagine for Arm server, the permitted buffer size can be a
> > huge value (e.g. for a system with 128 cores).
> > 
> > Could you confirm if this is right?
> 
> Yes that seems to be the case. And the commit message for that addition
> states the reasoning:
> 
>   perf_counter: Increase mmap limit
>   
>   In a default 'perf top' run the tool will create a counter for
>   each online CPU. With enough CPUs this will eventually exhaust
>   the default limit.
> 
>   So scale it up with the number of online CPUs.
> 
> To me that makes sense. Normally the memory installed also scales with the
> number of cores.
> 
> Are you saying that we should look into modifying that scaling factor in
> perf_mmap()? Or that we should still add something to userspace for
> coresight to limit user supplied buffer sizes?

I don't think we should modify the scaling factor in perf_mmap(), the
logic is not only used by AUX buffer, it's shared by normal event
ring buffer.

> I think it makes sense to allow the user to specify any value that will work,
> it's up to them.

Understand, I verified this patch with below steps:

root@debian:~# echo 0 > /proc/sys/kernel/perf_event_paranoid

leoy@debian:~$ perf record -e cs_etm// -m 4M,8M -o perf_test.data -- sleep 1
Permission error mapping pages.
Consider increasing /proc/sys/kernel/perf_event_mlock_kb,
or try again with a smaller value of -m/--mmap_pages.
(current value: 1024,2048)

leoy@debian:~$ perf record -e cs_etm// -m 4M,4M -o perf_test.data -- sleep 1
Couldn't synthesize bpf events.
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.607 MB perf_test.data ]

So this patch looks good for me:

Reviewed-by: Leo Yan <leo.yan@linaro.org>
