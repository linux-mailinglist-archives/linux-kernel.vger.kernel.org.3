Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADAA511034
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 06:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357696AbiD0EiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 00:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233953AbiD0EiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 00:38:00 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C0F1D0D1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 21:34:50 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id e2so766845wrh.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 21:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TTJXiSDWHIQWPf5FraUDqTlRR8Y6SgL6OHC9Il99X2U=;
        b=JxePzmarDHATgXyxfsx8xj1Je7OSZmAGXbzPlPFbaLD4c3f5Y8nWhFcw5bulM6z9ai
         Vf9bWMSRKaI4kUFwP4nC9ce9hdb0l6CgU3r2obwHoV/rLotPq80lxKHsS3djL/ardRoi
         Asa17Uvk2TUBoCUa8SPA9cfEiz2PyCXy1KYGSIjxaQpxkjr4HtZxdYhy8WgY6aeuoaly
         jXHKxdOsDyTrdJ2y12p38gQz9833Wb+C+10ZOQLRzxudBdCRXNRG3gHujmLUMhcGBxHn
         TJ08m992tQwLIABKcCPxaxCLpcMDpD7VfgRIAMzgH+bUEGPFQm9sBV9Pk7WHK4WiI/eL
         t2zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TTJXiSDWHIQWPf5FraUDqTlRR8Y6SgL6OHC9Il99X2U=;
        b=nJJb+fA6fS0A0MY/HtW+wAxijildXk1E8fkKzqlrX3en9slsMOLUvzaskaS1/1QbW2
         3ha8HPUUTJx1BI8UQLEqnZHLMTQ/1s7i0jaCZICa0vRg25+r3AVJ9+bx0AjNx+X91x0K
         yLwe/DbzN00NoJw1rTYG5Or3Rh48wwGqAUvlysAl7RfcC07o/GjigZ9Hb/tvwWzbP9CZ
         UiB+HYEhrslUt3JMD50UZQrOwr+QUt9jMoiYYbBMrhCkQEMffpncg+bFIE6AJU0vuY+e
         6sw3IG6TLcpFQS/IQoLsmPg+xIH2GBEsmz3BBujvFarSASzVov7guuCw6MDhBVWYrHl4
         Ckow==
X-Gm-Message-State: AOAM530sa2xTBkt5cAUthdCiD/PVynFeN7fK5BM7/ipjSkh4eHq0Vycf
        DijrxswTQGYbsESwWObYvwx67aa/l7qpOhKIimrB6Q==
X-Google-Smtp-Source: ABdhPJyhiHSjESWU751fDEw8Ck6ArMasesVf1PgUxSMH/mWwqDSNuGBfFb8cqDhVknfE36f9yQYQWkiNOwDmi83QDEY=
X-Received: by 2002:adf:fb05:0:b0:20a:e113:8f3f with SMTP id
 c5-20020adffb05000000b0020ae1138f3fmr7312720wrr.534.1651034088776; Tue, 26
 Apr 2022 21:34:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220420055807.GA16310@xsang-OptiPlex-9020> <43598597-72e1-6750-9bee-031fd463fc3b@intel.com>
In-Reply-To: <43598597-72e1-6750-9bee-031fd463fc3b@intel.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 26 Apr 2022 21:34:12 -0700
Message-ID: <CAJD7tkaDWtgy3Ckhgo+vcbM7oYA8saPCVRvXLDKYHvRGYkKvoQ@mail.gmail.com>
Subject: Re: [memcg] a8c49af3be: hackbench.throughput -13.7% regression
To:     Yin Fengwei <fengwei.yin@intel.com>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, Ying <ying.huang@intel.com>, feng.tang@intel.com,
        zhengjun.xing@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yin,

On Tue, Apr 26, 2022 at 7:53 PM Yin Fengwei <fengwei.yin@intel.com> wrote:
>
> Hi Yosry,
>
> On 4/20/2022 1:58 PM, kernel test robot wrote:
> >
> >
> > Greeting,
> >
> > FYI, we noticed a -13.7% regression of hackbench.throughput due to comm=
it:
> >
> >
> > commit: a8c49af3be5f0b4e105ef678bcf14ef102c270be ("memcg: add per-memcg=
 total kernel memory stat")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> >
> > in testcase: hackbench
> > on test machine: 144 threads 4 sockets Intel(R) Xeon(R) Gold 5318H CPU =
@ 2.50GHz with 128G memory
> > with following parameters:
> >
> >       nr_threads: 100%
> >       iterations: 4
> >       mode: process
> >       ipc: socket
> >       cpufreq_governor: performance
> >       ucode: 0x7002402
> >
> > test-description: Hackbench is both a benchmark and a stress test for t=
he Linux kernel scheduler.
> > test-url: https://github.com/linux-test-project/ltp/blob/master/testcas=
es/kernel/sched/cfs-scheduler/hackbench.c
> >
> >
> >
> > If you fix the issue, kindly add following tag
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> >
> >
> > Details are as below:
> > -----------------------------------------------------------------------=
--------------------------->
> >
> >
> > To reproduce:
> >
> >         git clone https://github.com/intel/lkp-tests.git
> >         cd lkp-tests
> >         sudo bin/lkp install job.yaml           # job file is attached =
in this email
> >         bin/lkp split-job --compatible job.yaml # generate the yaml fil=
e for lkp run
> >         sudo bin/lkp run generated-yaml-file
> >
> >         # if come across any failure that blocks the test,
> >         # please remove ~/.lkp and /lkp dir to run from a clean state.
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > compiler/cpufreq_governor/ipc/iterations/kconfig/mode/nr_threads/rootfs=
/tbox_group/testcase/ucode:
> >   gcc-11/performance/socket/4/x86_64-rhel-8.3/process/100%/debian-10.4-=
x86_64-20200603.cgz/lkp-cpl-4sp1/hackbench/0x7002402
> >
> > commit:
> >   086f694a75 ("memcg: replace in_interrupt() with !in_task()")
> >   a8c49af3be ("memcg: add per-memcg total kernel memory stat")
> >
> > 086f694a75e1a283 a8c49af3be5f0b4e105ef678bcf
> > ---------------- ---------------------------
> >          %stddev     %change         %stddev
> >              \          |                \
> >     146519           -13.7%     126397        hackbench.throughput
> >     465.89           +16.0%     540.43        hackbench.time.elapsed_ti=
me
> >     465.89           +16.0%     540.43        hackbench.time.elapsed_ti=
me.max
> >  1.365e+08          +134.1%  3.195e+08 =C2=B1  4%  hackbench.time.invol=
untary_context_switches
> >    1081515            -1.2%    1068489        hackbench.time.minor_page=
_faults
> >      64911           +16.3%      75465        hackbench.time.system_tim=
e
>
> Just FYI.
>
> If I comment out one line added by the commit <a8c49af3be> :
> static void memcg_account_kmem(struct mem_cgroup *memcg, int nr_pages)
> {
>         /* mod_memcg_state(memcg, MEMCG_KMEM, nr_pages); */  <--- comment=
 out this line.

Thanks so much for looking into this. Unfortunately this line is
essentially the commit core, all the other changes are more or less
refactoring or adding interfaces to read this stat through.

I am not sure why this specific callsite causes regression, there are
many callsites that modify stats similarly (whether through
mod_memcg_state() directly or through other variants like
mod_lruvec_state()). Maybe the kmem call path is exercised more
heavily in this benchmark than other call paths that update stats.

The only seemingly expensive operation in the mod_memcg_state() path
is the call to cgroup_rstat_updated() (through memcg_rstat_updated()).
One idea off the top of my head is to batch calls to
cgroup_rstat_updated(), similar to what 11192d9c124d ("memcg: flush
stats only if updated") did on the flush side. I am interested to see
what memcg maintainers think about this problem (and the proposed
solution).

>         if (!cgroup_subsys_on_dfl(memory_cgrp_subsys)) {
>                 if (nr_pages > 0)
>                         page_counter_charge(&memcg->kmem, nr_pages);
>                 else
>                         page_counter_uncharge(&memcg->kmem, -nr_pages);
>         }
> }
>
> The regression is almost gone:
>
> 086f694a75e1a283 9ff9ec89a6dcf39f901ff0a84fd
> ---------------- ---------------------------
>        fail:runs  %reproduction    fail:runs
>            |             |             |
>        7632:13      -44932%        1791:3     dmesg.timestamp:last
>           1:13          -8%            :3     kmsg.common_interrupt:#No_i=
rq_handler_for_vector
>           2:13         -20%            :3     kmsg.timestamp:common_inter=
rupt:#No_irq_handler_for_vector
>        4072:13      -24827%         844:3     kmsg.timestamp:last
>          %stddev     %change         %stddev
>              \          |                \
>     144327 =C2=B1  3%      -1.9%     141594 =C2=B1  5%  hackbench.through=
put
>                       regression dropped to -1.9% from -13.7%
>
>     473.44 =C2=B1  3%      +1.9%     482.23 =C2=B1  5%  hackbench.time.el=
apsed_time
>
>
> Regards
> Yin, Fengwei
