Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEE82531D97
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 23:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbiEWVUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 17:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbiEWVUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 17:20:42 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D2C8FD7E
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 14:20:41 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-2ff155c239bso162898737b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 14:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lVCdEcPOuNQbc22FqV9EzuU83gZ4Bzbr8VZE3scJEd8=;
        b=nRfRYAeLBfIMYpVfIGaXD+gU5TvR3vjSKXlAu8bmocY7nO63bBI15zObpoEOW8EW6d
         ROCqVVYjfL+bcUBWduUk5Z+/irXyLo8xXLsONZBMDp/K/jZ8j5laB3qfoSpoLELG8itR
         oZlDQqF+BwSIbeQW50HMaKx57zSrCDUCHeeBzZtb8tdh3pOAEJdi418n/JxmnUtFUVNw
         0O11sXNN2Uas+xgVkV397h7nO6kpftJ4VoqL8SAutrDUIdJuP8qvoaYifF2e6/gQhbn0
         v1+y0zcHvxBFUlsLSIlieDPJ0zssX1UE4DWOm/badoEToKGLYj1x/d9jFnGar9lqZA7U
         NvsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lVCdEcPOuNQbc22FqV9EzuU83gZ4Bzbr8VZE3scJEd8=;
        b=KCj8OXkmCbQB4iGR4bbDB8hXuMTl5XbXptYwEqy9LIquJC9aN6CcUEl6Dtk5pz7p1K
         5e0mT1Sut6qtOuw82w9GvkKxrzuzzrqe1LynK8ogONp1XK44gvDYAhzec79A5GF40vE0
         aqLsW1glMPiWfotpiapNThz9LI/iQKaIhK9nXkpErx8fZ/XMyznh7SfVYG0y8EPhKfdX
         V8vBXF1H+nkqFoa/b4QHCbJEjHByUiJ8mP2FQZlEc4usFCmLoR6XGcXlz7BvkBxyyDee
         kF+Wj40RgdwibgYaY2SuPwzFpTunRvKf2xsiegvHiiXx7MYau8x7lGnDv4jsRdtuN2hW
         qEUw==
X-Gm-Message-State: AOAM531WwtQIEHYzS5/9K4QbKDs41ZYPIMmsCmsh38UD6EXvZrmDLEXo
        YW/SXFBv2nTRvQOblGTjE0XuyvKndUgZVMIms5WpAA==
X-Google-Smtp-Source: ABdhPJzMmsu2KyEO0vrg297yGGD36gTszQTAlpkz5jVLNvt/lvRoF3p8j5J4bCiRpjapJao9qzhXHIwW3Pn9uHCm4Mw=
X-Received: by 2002:a81:5206:0:b0:2ff:c26d:d58c with SMTP id
 g6-20020a815206000000b002ffc26dd58cmr11589716ywb.147.1653340840414; Mon, 23
 May 2022 14:20:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220520235138.3140590-1-joshdon@google.com> <202205211525.XlF6P8dM-lkp@intel.com>
In-Reply-To: <202205211525.XlF6P8dM-lkp@intel.com>
From:   Josh Don <joshdon@google.com>
Date:   Mon, 23 May 2022 14:20:29 -0700
Message-ID: <CABk29NsNvAs_GFpUEObMWHUw75jp5aBoK3RkPaUL_tDxwxDR=w@mail.gmail.com>
Subject: Re: [PATCH v2] sched/core: add forced idle accounting for cgroups
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Tejun Heo <tj@kernel.org>, 0day robot <lkp@intel.com>,
        kbuild-all@lists.01.org,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Cruz Zhao <CruzZhao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 4:28 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> Hi Josh,
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Josh-Don/sched-core-add-forced-idle-accounting-for-cgroups/20220521-075311
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
> config: x86_64-randconfig-m001 (https://download.01.org/0day-ci/archive/20220521/202205211525.XlF6P8dM-lkp@intel.com/config)
> compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
>
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> smatch warnings:
> kernel/cgroup/rstat.c:489 cgroup_base_stat_cputime_show() error: uninitialized symbol 'forceidle_time'.
>
> vim +/forceidle_time +489 kernel/cgroup/rstat.c
>
> d4ff749b5e0f1e kernel/cgroup/rstat.c Tejun Heo    2018-04-26  460  void cgroup_base_stat_cputime_show(struct seq_file *seq)
> 041cd640b2f3c5 kernel/cgroup/stat.c  Tejun Heo    2017-09-25  461  {
> 041cd640b2f3c5 kernel/cgroup/stat.c  Tejun Heo    2017-09-25  462       struct cgroup *cgrp = seq_css(seq)->cgroup;
> 041cd640b2f3c5 kernel/cgroup/stat.c  Tejun Heo    2017-09-25  463       u64 usage, utime, stime;
> 0575a42c9f10cd kernel/cgroup/rstat.c Josh Don     2022-05-20  464       struct cgroup_base_stat bstat;
> 0575a42c9f10cd kernel/cgroup/rstat.c Josh Don     2022-05-20  465       u64 __maybe_unused forceidle_time;
> 041cd640b2f3c5 kernel/cgroup/stat.c  Tejun Heo    2017-09-25  466
> 936f2a70f2077f kernel/cgroup/rstat.c Boris Burkov 2020-05-27  467       if (cgroup_parent(cgrp)) {
> 6162cef0f741c7 kernel/cgroup/rstat.c Tejun Heo    2018-04-26  468               cgroup_rstat_flush_hold(cgrp);
> d4ff749b5e0f1e kernel/cgroup/rstat.c Tejun Heo    2018-04-26  469               usage = cgrp->bstat.cputime.sum_exec_runtime;
> 936f2a70f2077f kernel/cgroup/rstat.c Boris Burkov 2020-05-27  470               cputime_adjust(&cgrp->bstat.cputime, &cgrp->prev_cputime,
> 936f2a70f2077f kernel/cgroup/rstat.c Boris Burkov 2020-05-27  471                              &utime, &stime);
> 0575a42c9f10cd kernel/cgroup/rstat.c Josh Don     2022-05-20  472  #ifdef CONFIG_SCHED_CORE
> 0575a42c9f10cd kernel/cgroup/rstat.c Josh Don     2022-05-20  473               forceidle_time = cgrp->bstat.forceidle_sum;
> 0575a42c9f10cd kernel/cgroup/rstat.c Josh Don     2022-05-20  474  #endif
> 6162cef0f741c7 kernel/cgroup/rstat.c Tejun Heo    2018-04-26  475               cgroup_rstat_flush_release();
> 936f2a70f2077f kernel/cgroup/rstat.c Boris Burkov 2020-05-27  476       } else {
> 0575a42c9f10cd kernel/cgroup/rstat.c Josh Don     2022-05-20  477               root_cgroup_cputime(&bstat);
> 0575a42c9f10cd kernel/cgroup/rstat.c Josh Don     2022-05-20  478               usage = bstat.cputime.sum_exec_runtime;
> 0575a42c9f10cd kernel/cgroup/rstat.c Josh Don     2022-05-20  479               utime = bstat.cputime.utime;
> 0575a42c9f10cd kernel/cgroup/rstat.c Josh Don     2022-05-20  480               stime = bstat.cputime.stime;
> 0575a42c9f10cd kernel/cgroup/rstat.c Josh Don     2022-05-20  481  #ifdef CONFIG_SCHED_CORE
> 0575a42c9f10cd kernel/cgroup/rstat.c Josh Don     2022-05-20  482               forceidle_time = bstat.forceidle_sum;
> 0575a42c9f10cd kernel/cgroup/rstat.c Josh Don     2022-05-20  483  #endif
> 936f2a70f2077f kernel/cgroup/rstat.c Boris Burkov 2020-05-27  484       }
> 041cd640b2f3c5 kernel/cgroup/stat.c  Tejun Heo    2017-09-25  485
> 041cd640b2f3c5 kernel/cgroup/stat.c  Tejun Heo    2017-09-25  486       do_div(usage, NSEC_PER_USEC);
> 041cd640b2f3c5 kernel/cgroup/stat.c  Tejun Heo    2017-09-25  487       do_div(utime, NSEC_PER_USEC);
> 041cd640b2f3c5 kernel/cgroup/stat.c  Tejun Heo    2017-09-25  488       do_div(stime, NSEC_PER_USEC);
> 0575a42c9f10cd kernel/cgroup/rstat.c Josh Don     2022-05-20 @489       do_div(forceidle_time, NSEC_PER_USEC);
>
> I think this will cause MEMSan warnings at run time.

Whoops, I missed wrapping this usage with an #ifdef CONFIG_SCHED_CORE.

> 041cd640b2f3c5 kernel/cgroup/stat.c  Tejun Heo    2017-09-25  490
> d41bf8c9deaed1 kernel/cgroup/stat.c  Tejun Heo    2017-10-23  491       seq_printf(seq, "usage_usec %llu\n"
> d41bf8c9deaed1 kernel/cgroup/stat.c  Tejun Heo    2017-10-23  492                  "user_usec %llu\n"
> d41bf8c9deaed1 kernel/cgroup/stat.c  Tejun Heo    2017-10-23  493                  "system_usec %llu\n",
> d41bf8c9deaed1 kernel/cgroup/stat.c  Tejun Heo    2017-10-23  494                  usage, utime, stime);
> 0575a42c9f10cd kernel/cgroup/rstat.c Josh Don     2022-05-20  495
>
> --
> 0-DAY CI Kernel Test Service
> https://01.org/lkp
>
