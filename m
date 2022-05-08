Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B59B51EE73
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 17:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234594AbiEHPMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 11:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234437AbiEHPM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 11:12:29 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6827BDFA6
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 08:08:39 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id l7-20020a17090aaa8700b001dd1a5b9965so267786pjq.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 May 2022 08:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fD2NKbHhBWw9eBsTe1mP9moLD1y5EWQbU6ALqfSO3Wk=;
        b=Ko5uJ/CgpE5N5MzJuVdoLFcIe/sxyftWIVZjtDxdgeLVWbZWp0M6rPUJPN1+PXytou
         qAvVZYxAiRj+V6jION1XzQFQPubTbA7zhrctojMA/iDOCSmMf6EMDiFhy/r8V0Q06Pde
         Z06oGmVf2UEf6ziTvny8IfiLye5VKghQ/36ETPbyo9VfUbNgznX3xLD8eOe+NyJLg/BQ
         f1rUXK0goNeVvCqA6juraDYy7J39zHYTw+gqLtduxTTAwUAgHCj2e/CEJ7BBV7i5e7ku
         zocBrpFUOUhuQxNTsLFBh6cLJreZjXAULTTBWeQi6crfiqLZ1RmbA1ww6ax/+LrO/+Mp
         rxUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fD2NKbHhBWw9eBsTe1mP9moLD1y5EWQbU6ALqfSO3Wk=;
        b=tI6ZcD0gX6jKPoDi1tX/BjGRdeqacWr/iWttbc9m4n+N1WpYZ2ApkvEPLu2OhM7G0r
         omSvesCsAOwg9dNNR0zFwO+fy+8nK9E0jkPbYyCgBMVhMr9V4PrDcIIye3wkM3wVDGRO
         AYC3IkExQceEvvkgBcQhic5Dk6AJNi6GW3noQTIj7gPGabCUsgI0RBTWYkyV60xX8sYJ
         ETasVZ6o/MdBxwasOJsSn52sXX3mdKa57xZWVBa0DA1UmIEpVeMGAHR17IwlvbyQHndU
         UWl4ZilpOM29WLqNbXNqh+6QL046l/SJzqJQqJPA0WDVziS2ep9XJQoqYWJ5T8ATj21y
         Z3RA==
X-Gm-Message-State: AOAM531Rs7ZsQlImbB2wzX7v00nU0qeBwdH/vuVitbTCpKwzSBo78CRp
        Iy2N3C5iUC2vqFwyjCHuLRDkpaohUd/FIPnoFUM=
X-Google-Smtp-Source: ABdhPJx3MQBXUbBbVVYmpzfJnFj1/Qtv2DRUENonD04/QNtnwvF0qPfte0ACHEjRM6aPJbZ1fN5sSg==
X-Received: by 2002:a17:90a:b307:b0:1bd:37f3:f0fc with SMTP id d7-20020a17090ab30700b001bd37f3f0fcmr22377422pjr.132.1652022518742;
        Sun, 08 May 2022 08:08:38 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (104-237-153-19.ip.linodeusercontent.com. [104.237.153.19])
        by smtp.gmail.com with ESMTPSA id c6-20020aa79526000000b0050dc7628155sm6881214pfp.47.2022.05.08.08.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 08:08:38 -0700 (PDT)
Date:   Sun, 8 May 2022 23:08:32 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, James Clark <James.Clark@arm.com>,
        German Gomez <german.gomez@arm.com>
Subject: Re: [PATCH V2 00/23] perf intel-pt: Better support for perf record
 --cpu
Message-ID: <20220508150832.GA278102@leoy-ThinkPad-X240s>
References: <20220506122601.367589-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220506122601.367589-1-adrian.hunter@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Fri, May 06, 2022 at 03:25:38PM +0300, Adrian Hunter wrote:
> Hi
> 
> Here are V2 patches to support capturing Intel PT sideband events such as
> mmap, task, context switch, text poke etc, on every CPU even when tracing
> selected user_requested_cpus.  That is, when using the perf record -C or
>  --cpu option.
> 
> This is needed for:
> 1. text poke: a text poke on any CPU affects all CPUs
> 2. tracing user space: a user space process can migrate between CPUs so
> mmap events that happen on a different CPU can be needed to decode a
> user_requested_cpus CPU.
> 
> For example:
> 
> 	Trace on CPU 1:
> 
> 	perf record --kcore -C 1 -e intel_pt// &
> 
> 	Start a task on CPU 0:
> 
> 	taskset 0x1 testprog &
> 
> 	Migrate it to CPU 1:
> 
> 	taskset -p 0x2 <testprog pid>
> 
> 	Stop tracing:
> 
> 	kill %1
> 
> 	Prior to these changes there will be errors decoding testprog
> 	in userspace because the comm and mmap events for testprog will not
> 	have been captured.

Thanks a lot for this patch set, I believe this is a common issue for
AUX trace (not only for Intel-PT), so I verified this patch set for both
Arm CoreSight and SPE; unfortunately both cannot see MMAP events for
migrated task.  I used below commands:

  # perf record -B -N --no-bpf-event -e cs_etm//u -C 0 -- taskset --cpu-list 1 uname
  # perf script  --no-itrace --show-mmap-events -C 1 2>/dev/null | grep MMAP | wc -l
  0


  # perf record -B -N --no-bpf-event -e arm_spe_0//u -C 0 -- taskset --cpu-list 1 uname
  # perf script --no-itrace --show-mmap-events -C 1 2>/dev/null | grep MMAP | wc -l
  0

I didn't dive into details for this patch set, so I cannot say the
failure is caused by any issue in this patch set.  But it's definitely
we need to look into for Arm platforms to root cause what's the reason
it cannot record MMAP events properly when migrate tasks.  Loop James
and German for this reason.

Thanks,
Leo
