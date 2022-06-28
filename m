Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03C0A55E24E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242002AbiF1HVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 03:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241877AbiF1HVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 03:21:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4352CE15
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 00:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BfwuO3yToSKKNpMuSUtAZ3qwE6LV09InSfgFlwAkYX0=; b=NBDZqIgaz1sZFsdEWewwgbTfbQ
        vdyi/GgCsDZOlWIgrMbEY3ZsH0JRaBNV8d2FVp0ddXCvzeTHyPU1UQ0vL5YSu+7waDMj83O326IWy
        6nmQDEYdnviKL1UFPtMd8JDVlFNwdNTWq0/oxZUrqIpNy3J86oCG8sXN/1f7KJHlrZUHlYQ52azBY
        aJHx7dRHFtpT+mgm1Mc2+e22XgEs5xu2tcPDzq2oJL1AnsZzVvHyvSRzQXGY0TUtiEEpx2kIyX5NM
        T3aZNIsGktbJSgggrc504X0wpRlJiDZZvTVTAOfj0oQiWndavEc+9ojqlV80AvXk/97ZcZIfBLyGp
        fs7q/LIg==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o65XJ-00C4cq-O2; Tue, 28 Jun 2022 07:21:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A741B30017D;
        Tue, 28 Jun 2022 09:21:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 78CA5200BE346; Tue, 28 Jun 2022 09:21:23 +0200 (CEST)
Date:   Tue, 28 Jun 2022 09:21:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Donnefort <vdonnefort@google.com>
Cc:     mingo@redhat.com, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        qperret@google.com, tao.zhou@linux.dev, kernel-team@android.com
Subject: Re: [PATCH v11 0/7] feec() energy margin removal
Message-ID: <Yrqr84h5xe2GYMVb@hirez.programming.kicks-ass.net>
References: <20220621090414.433602-1-vdonnefort@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621090414.433602-1-vdonnefort@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 10:04:07AM +0100, Vincent Donnefort wrote:

> Dietmar Eggemann (3):
>   sched, drivers: Remove max param from
>     effective_cpu_util()/sched_cpu_util()
>   sched/fair: Rename select_idle_mask to select_rq_mask
>   sched/fair: Use the same cpumask per-PD throughout
>     find_energy_efficient_cpu()
> 
> Vincent Donnefort (4):
>   sched/fair: Provide u64 read for 32-bits arch helper
>   sched/fair: Decay task PELT values during wakeup migration
>   sched/fair: Remove task_util from effective utilization in feec()
>   sched/fair: Remove the energy margin in feec()
> 
>  drivers/powercap/dtpm_cpu.c       |  33 +--
>  drivers/thermal/cpufreq_cooling.c |   6 +-
>  include/linux/sched.h             |   2 +-
>  kernel/sched/core.c               |  15 +-
>  kernel/sched/cpufreq_schedutil.c  |   5 +-
>  kernel/sched/fair.c               | 470 +++++++++++++++++++-----------
>  kernel/sched/pelt.h               |  40 ++-
>  kernel/sched/sched.h              |  53 +++-
>  8 files changed, 400 insertions(+), 224 deletions(-)

Thanks!
