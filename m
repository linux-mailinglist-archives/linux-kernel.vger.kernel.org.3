Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ADD5570C71
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 23:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbiGKVLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 17:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiGKVLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 17:11:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61D22B609;
        Mon, 11 Jul 2022 14:11:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C57161699;
        Mon, 11 Jul 2022 21:11:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7967C34115;
        Mon, 11 Jul 2022 21:11:31 +0000 (UTC)
Date:   Mon, 11 Jul 2022 17:11:30 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Qais Yousef <qais.yousef@arm.com>,
        Xuewen Yan <xuewen.yan@unisoc.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        ke.wang@unisoc.com, xuewyan@foxmail.com, linux-pm@vger.kernel.org,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH] sched/schedutil: Fix deadlock between cpuset and cpu
 hotplug when using schedutil
Message-ID: <20220711171130.6390600b@gandalf.local.home>
In-Reply-To: <YsyO9GM9mCydaybo@slm.duckdns.org>
References: <20220705123705.764-1-xuewen.yan@unisoc.com>
        <20220711174629.uehfmqegcwn2lqzu@wubuntu>
        <YsyO9GM9mCydaybo@slm.duckdns.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Jul 2022 10:58:28 -1000
Tejun Heo <tj@kernel.org> wrote:

> I don't think lockdep would be able to track CPU1 -> CPU2 dependency here
> unfortunately.
> 
> > AFAIU:
> > 
> > 
> > CPU0                                     CPU1                                   CPU2
> > 
> > // attach task to a different
> > // cpuset cgroup via sysfs
> > __acquire(cgroup_threadgroup_rwsem)
> > 
> >                                          // pring up CPU2 online
> >                                          __acquire(cpu_hotplug_lock)
> >                                          // wait for CPU2 to come online

Should there be some annotation here that tells lockdep that CPU1 is now
blocked on CPU2?

Then this case would be caught by lockdep.

-- Steve


> >                                                                                 // bringup cpu online
> >                                                                                 // call cpufreq_online() which tries to create sugov kthread
> > __acquire(cpu_hotplug_lock)                                                     copy_process()
> >                                                                                    cgroup_can_fork()
> >                                                                                       cgroup_css_set_fork()
> >                                                                                       __acquire(cgroup_threadgroup_rwsem)
> > // blocks forever                        // blocks forever                            // blocks forever
> > 
