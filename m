Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E998B4EF97E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 20:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350981AbiDASGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 14:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350958AbiDASGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 14:06:12 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32A22E9
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 11:04:21 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id 10so2794791qtz.11
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 11:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WT1tpbzDbSP9t8G1jkgJMnxYn25i+YOBCOQG5IXPFh8=;
        b=GmHGsqgjUA5ThgaQ/EEn1tKYzNrTGE3cXgpyV10qyAlM0IKCS/ggdPzSAXMnVQGjEQ
         BbFr/PPpxCUUTBrvUAl3WP2WUPSbMMbm0BuzDL7+NXwNy36mA9psXidT+QMnO5JBZaTg
         qKa8/0ffzYYSQUe4IsK73NreZXTQhJ6bv7IWFZtjDRTYtvfadqvg0hCK+sK+SkgayMiV
         qXEWImeyaatLv8joK/00U5NDta1pmrKQrb0x74bmTEbyzuuOlDAog03V1yhOBjPMGB6i
         ipV089G8IzawUaB8O3LZu45FiF9Lkv9rCYxPG5KbBUsHR4vqLfVcQvNkqre38NxPfuCW
         cqNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WT1tpbzDbSP9t8G1jkgJMnxYn25i+YOBCOQG5IXPFh8=;
        b=UqdEG4/m+nrjEDYY3hzO9zNGDgeFOwhIaCD3Inei5E5F1GFC6OH3Jf3943ywlvFN97
         1aFvKpOIiEtmYMFUviP/dzTsmh3m55KwgRnOPmsOVZRNbdKR6bq2CwSY4Gv8MHQ+hOEr
         Maw/PiLvnjgrIKjF8ASaDTTE8ZowbqdwymNZ7A6wbltsFyPqHj2HtC069/HRWGIpjVX+
         g9o/qP6Ey/B+vXMJ4+y4ymU57+nmYIzxJ9Nzbe7sxSzdK+AJjF6ZZdX/MVykX+K897av
         pYM1zWy3EjIEuIKfS4ukiP3uND0M3I/xJzsc6k1M9G1bBRTrR6ogepzHPdlh6yAad+nz
         IFXA==
X-Gm-Message-State: AOAM5316HSIDNFWeAJpNlLlGjTUAPUEHF+ejYazyIfeuVc0Gbo3u4LPP
        4bhS5pA+Nge+GDGLaIRZrmR51aNRK62UVSEGBCg6BHS9NCJrIg==
X-Google-Smtp-Source: ABdhPJziwM7EiqcAjKItqmHEsi9uYsDUw8S0qqKX+rkxNhBJiejPhNnC+ybF8Crwy6M9YipadjH9KA7FjhAYo7NqVcQ=
X-Received: by 2002:a05:622a:155:b0:2e1:cc60:8947 with SMTP id
 v21-20020a05622a015500b002e1cc608947mr9325218qtw.243.1648836260945; Fri, 01
 Apr 2022 11:04:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220330094632.GB6999@xsang-OptiPlex-9020> <7aa67fedb4b6dc9126bc59ee993fa18d0e472475.camel@linux.intel.com>
In-Reply-To: <7aa67fedb4b6dc9126bc59ee993fa18d0e472475.camel@linux.intel.com>
From:   Chen Yu <yu.chen.surf@gmail.com>
Date:   Sat, 2 Apr 2022 02:04:09 +0800
Message-ID: <CADjb_WQsTkdbwrvtzWwjt2O_jiuQTx+=Xy=yMPbAwKPmFDX-0w@mail.gmail.com>
Subject: Re: [sched/fair] ddb3b1126f: hackbench.throughput -25.9% regression
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     kernel test robot <oliver.sang@intel.com>,
        0day robot <lkp@intel.com>, Chen Yu <yu.c.chen@intel.com>,
        Walter Mack <walter.mack@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Huang Ying <ying.huang@intel.com>, feng.tang@intel.com,
        zhengjun.xing@linux.intel.com, fengwei.yin@intel.com,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@elte.hu>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Aubrey Li <aubrey.li@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 11:42 AM Tim Chen <tim.c.chen@linux.intel.com> wrote:
>
> On Wed, 2022-03-30 at 17:46 +0800, kernel test robot wrote:
> >
> > Greeting,
> >
> > FYI, we noticed a -25.9% regression of hackbench.throughput due to commit:
> >
>
> Will try to check the regression seen.
>
Double check  that the regression could be reproduced on top of the
latest sched/core branch:
parent ("sched/fair: Don't rely on ->exec_start for migration")
fbc  ("sched/fair: Simple runqueue order on migrate")

parent                                fbc
91107           -40.8%      53897        hackbench.throughput

and it is consistent with lkp's original report that the  context
switch count is much higher with patch applied:
9591919          +510.3%   58534937
hackbench.time.involuntary_context_switches
36451523          +281.5%  1.391e+08
hackbench.time.voluntary_context_switches

Considering that this patch  'raises' the priority of the migrated
task, by giving it the cfs_rq->min_vruntime,
it is possible that the migrated task would preempt the current
running task more easily.

0.00           +12.2       12.21
perf-profile.calltrace.cycles-pp.enqueue_entity.enqueue_task_fair.ttwu_do_activate.try_to_wake_up.autoremove_wake_function
and the patched version has  spent more time on enqueue_entity(),
which might be caused by setting sched entity hierarchy from leaf to
root,
which was mentioned in another thread.

-- 
Thanks,
Chenyu
