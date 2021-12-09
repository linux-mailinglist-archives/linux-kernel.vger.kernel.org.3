Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFEF746F293
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 18:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242731AbhLIR7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 12:59:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39398 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237660AbhLIR7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 12:59:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639072571;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uYM/uEwyPPSNBueH9KlRGmLqVhLohtnkG/cOSjtrS3g=;
        b=Ahv0En4Bu284xtAXy0P9AUQmiLyhveD/IGymglMM4y2NAWockeCEElsmAE/ruTD8l9fe21
        qkM5TsmlA0CoNYTPIY6E+tZlcta3as1utV9pkweafjzemCqzemCOyduWcV+sx/y2BNe10Q
        Iuurtx/8hEgVFh+7bb+xtU/VW1286mI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-98-Mq1n5S1DPjCbbwl4zBmdOw-1; Thu, 09 Dec 2021 12:56:10 -0500
X-MC-Unique: Mq1n5S1DPjCbbwl4zBmdOw-1
Received: by mail-wm1-f71.google.com with SMTP id a64-20020a1c7f43000000b003335e5dc26bso3485604wmd.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 09:56:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uYM/uEwyPPSNBueH9KlRGmLqVhLohtnkG/cOSjtrS3g=;
        b=rM4/UvMY0QdLYnYL66h4ToqHE7djeNbiPeuo9yL4zkjASJCxTizhtqDd574Q2b4s2e
         /3hhMMEjNm6wqrjnnj+WfTAXL+hP7+pj2P5A0SXhjAXB+cToa5TJSqRSKSkLhALl7g28
         aDkgs1DTMUCvnm3YFfCLQa0okmee4rGxQ3bIIam1m9OMQywChPagpETUl0vxlDXYLLsX
         gu5KZ4tX7bvTBkqqGOtnyD8KLrbXcKFl0TezpkFQDr+wKvs6KN0djH/FTFF+dASNOnYJ
         NFRTUT/FiwDClKo93cJpukR2sO8gSeOtGteDlDux1hY5X/vHgitum7PknuGgc1YOPi3i
         c+BQ==
X-Gm-Message-State: AOAM530t2Mec31M7AIrMu2UBi0aBEdLRix1iY11TPB+Bemwt7Txt97o/
        a+mZK4ww2aMU+ENAAyAumgTf/fzTKqUUiMKcLNSYaegc8pzqHSpos4BMsg4MSl7QIuoc3Z0yNWV
        pT6dGaOgRmQv/PaKOftviwolx
X-Received: by 2002:a05:600c:4108:: with SMTP id j8mr8966144wmi.139.1639072568856;
        Thu, 09 Dec 2021 09:56:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwqmvNbHp3vmqZAoJGGIjuRvt+F1+ATtneQSrB8xh99ZyEve8aQX/UKS5ujWVvoA0bb7pYrpw==
X-Received: by 2002:a05:600c:4108:: with SMTP id j8mr8966118wmi.139.1639072568682;
        Thu, 09 Dec 2021 09:56:08 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id l11sm345842wrp.61.2021.12.09.09.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 09:56:08 -0800 (PST)
Date:   Thu, 9 Dec 2021 18:56:06 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Alexei Budankov <abudankov@huawei.com>,
        Riccardo Mancini <rickyman7@gmail.com>
Subject: Re: [PATCH v12 00/16] Introduce threaded trace streaming for basic
 perf record operation
Message-ID: <YbJDNoTIrCQv4O9Z@krava>
References: <cover.1637675515.git.alexey.v.bayduraev@linux.intel.com>
 <YazXfO9CoCaR4THO@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YazXfO9CoCaR4THO@krava>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 05, 2021 at 04:15:10PM +0100, Jiri Olsa wrote:
> On Tue, Nov 23, 2021 at 05:07:56PM +0300, Alexey Bayduraev wrote:
> > Changes in v12:
> > - fixed nr_threads=1 cases
> > - fixed "Woken up %ld times" message
> > - removed unnecessary record__fini_thread_masks function
> > - moved bytes written/compressed statistics to struct record_thread
> > - moved all unnecessary debug messages to verbose=2 level
> > - renamed "socket" option to "package" for consistency with util/cputopo.h
> > - excluded single trace file reading patches
> > 
> > v11: https://lore.kernel.org/lkml/cover.1629186429.git.alexey.v.bayduraev@linux.intel.com/
> 
> 
> I'm getting perf record hang with:
> 
> [root@krava perf]# ./perf record --threads
> ^C[ perf record: Woken up 1 times to write data ]
> 
> ^C^C^C^C^C
> 
> 
> 
> 
> with following backtrace:
> 
> 
> (gdb) bt
> #0  0x00007f8115d2885f in __GI___poll (fds=fds@entry=0x7ffd2116b930, nfds=1, timeout=1000) at ../sysdeps/unix/sysv/linux/poll.c:29
> #1  0x00007f811574029e in poll (__timeout=<optimized out>, __nfds=<optimized out>, __fds=0x7ffd2116b930) at /usr/include/bits/poll2.h:48
> #2  Curl_poll (timeout_ms=<optimized out>, nfds=<optimized out>, ufds=0x7ffd2116b930) at ../../lib/select.c:374
> #3  Curl_poll (ufds=0x7ffd2116b930, nfds=<optimized out>, timeout_ms=<optimized out>) at ../../lib/select.c:329
> #4  0x00007f8115739cf7 in multi_wait (multi=multi@entry=0x3458c50, extra_fds=extra_fds@entry=0x0, extra_nfds=extra_nfds@entry=0, timeout_ms=<optimized out>, 
>     timeout_ms@entry=1000, ret=ret@entry=0x0, extrawait=extrawait@entry=false, use_wakeup=<optimized out>) at ../../lib/multi.c:1282
> #5  0x00007f8115739f26 in multi_wait (use_wakeup=false, extrawait=false, ret=0x0, timeout_ms=1000, extra_nfds=0, extra_fds=0x0, multi=0x3458c50)
>     at ../../lib/multi.c:1410
> #6  curl_multi_wait (multi=multi@entry=0x3458c50, extra_fds=extra_fds@entry=0x0, extra_nfds=extra_nfds@entry=0, timeout_ms=timeout_ms@entry=1000, 
>     ret=ret@entry=0x0) at ../../lib/multi.c:1411
> #7  0x00007f811653a7f2 in debuginfod_query_server (c=c@entry=0x2571fb0, build_id=build_id@entry=0x7ffd2116ed70 "c6eee0984964c63e328d13be49d68bd52595ad00", 
>     build_id_len=build_id_len@entry=0, type=type@entry=0x7f811653c3ba "debuginfo", filename=filename@entry=0x0, path=path@entry=0x7ffd2116dcf8)
>     at /usr/src/debug/elfutils-0.186-1.fc35.x86_64/debuginfod/debuginfod-client.c:1057
> #8  0x00007f811653b2a6 in debuginfod_find_debuginfo (client=client@entry=0x2571fb0, 
>     build_id=build_id@entry=0x7ffd2116ed70 "c6eee0984964c63e328d13be49d68bd52595ad00", build_id_len=build_id_len@entry=0, path=path@entry=0x7ffd2116dcf8)
>     at /usr/src/debug/elfutils-0.186-1.fc35.x86_64/debuginfod/debuginfod-client.c:1511

ok, I should have looked closer on that before sending,
it seems to be unrelated issues on fedora 35, because it
triggers the debuginfo retrieval on exit.. and that might
hang forever apparently, please disregard this one

thanks,
jirka

