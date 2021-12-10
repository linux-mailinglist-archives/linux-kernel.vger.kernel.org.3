Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D19047067A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 17:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244280AbhLJQ6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 11:58:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244269AbhLJQ6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 11:58:16 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFCAAC0617A1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 08:54:40 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id q16so8535115pgq.10
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 08:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pmeRkqZDK00GW81o5V76FJNx8cnKybCMVGo2V/GvQbU=;
        b=BgrY4m9/7KdpGZ/v9yUtCOOuyUcziugxMmdJO/AzA1KbDU9SMFMC64iY5DJBHNshtp
         q5IUUz5vGaN9ks+P7aXSl7qLR4nH5Dk29sAaZHub7ZijcnzvpH0JsfgHexXmCAYJrOXj
         kANf10P+Ay/3+2AHzbAJUrBeamaHEOwHOPBv9veQSMLy5dTxhxxHI81byMGdfuu5RY+U
         UJ9ifUWRNNL+v8X5qU+4ShMo220uG8Y2KJgz6qgKO5bpJvOPMdHzqlwL6V0whapVICJ1
         aGY/6YxsYfOsnEmdkqXMXyRNCsrbB+MQhR0asbUmaoSs7svBDLCRYS3w6K8yO4S5ukwA
         vAkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pmeRkqZDK00GW81o5V76FJNx8cnKybCMVGo2V/GvQbU=;
        b=5oiwKmQogO7YLOLvxCVXpP3rTfoKSX/v5kG8shLIui64ShCDMEUn/UjcEbqVfjuvJB
         pkk6uA7+v5ulyHoVG7eCGz4VZCfBLrI6EVN56eixwt6J8ygDNZbr/dSlVGgvG3j2oQcE
         lait6pQxAYYWxcxA7HleVMOeHivieWmeOsvkFKvf0YSUPLSLwj0yFlFCrNQzycChAkuf
         MLfCn2ZbW0+ce1weV45pmkekwuCHVgj/fZqglJnEtIpgu4ff5fwoyfVZnaPGfYaTm1Tt
         3Qd/kxoT+keTh4CKhFyPom7PytIYbbULrwklKN3pD1VLsz+AY+Rw0LL+aOo0hmoq8WJ0
         DAwA==
X-Gm-Message-State: AOAM532JLuBtCfjdmByrwomikGWBqpZaldV1mOSrFNdyRM0V7ZnjEs48
        NGp4vt2PtRC83IKN55EpzRC61YDbZI85dQ==
X-Google-Smtp-Source: ABdhPJxHROttO6bm9CXzM9iK3z0M2D/k5KQih15Yy1kSvs/gXnl0V1Hx/hy+tJFs38RMU1nllXe/Sg==
X-Received: by 2002:a63:6ecb:: with SMTP id j194mr39322605pgc.46.1639155280299;
        Fri, 10 Dec 2021 08:54:40 -0800 (PST)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id ot18sm3435741pjb.14.2021.12.10.08.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 08:54:39 -0800 (PST)
Date:   Fri, 10 Dec 2021 09:54:36 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     Leo Yan <leo.yan@linaro.org>, coresight@lists.linaro.org,
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
Message-ID: <20211210165436.GA1236662@p14s>
References: <20211208115435.610101-1-james.clark@arm.com>
 <20211208131753.GC273781@leoy-ThinkPad-X240s>
 <269d2f14-0594-c73e-97b5-82e72f76e826@arm.com>
 <20211209134413.GA622826@leoy-ThinkPad-X240s>
 <6a7fd600-91f3-5feb-d21f-ec7cb704f84c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a7fd600-91f3-5feb-d21f-ec7cb704f84c@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021 at 02:16:43PM +0000, James Clark wrote:
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

Arnaldo is not on the recipient list and as such he won't see this patch...

