Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1FF54A446B
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 12:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378916AbiAaL3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 06:29:35 -0500
Received: from foss.arm.com ([217.140.110.172]:47680 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1378380AbiAaLUG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 06:20:06 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9BB62D6E;
        Mon, 31 Jan 2022 03:20:04 -0800 (PST)
Received: from FVFF7649Q05P (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E600C3F774;
        Mon, 31 Jan 2022 03:20:02 -0800 (PST)
Date:   Mon, 31 Jan 2022 11:19:57 +0000
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Yuan ZhaoXiong <yuanzhaoxiong@baidu.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/cpu.c: fix init_cpu_online
Message-ID: <YffF3e+uUIDVO7hm@FVFF7649Q05P>
References: <20220131014648.941629-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220131014648.941629-1-yury.norov@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yury,

On Sun, Jan 30, 2022 at 05:46:48PM -0800, Yury Norov wrote:
> cpu_online_mask has an associate counter of online cpus, which must be
> initialized in init_cpu_online().
> 
> Fixes: 0c09ab96fc82010 (cpu/hotplug: Cache number of online CPUs)

Aren't the increments/decrements from set_cpu_online() enough?

I guess we could argue that this isn't a private function and the
num_online_cpus should be updated here. But unless I missed something,
init_cpu_online() is only called in ia64 arch, in the !SMP case. Is
this the problem you're trying to tackle? If not, I'm not sure that warrants a
"Fixes:" tag

> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
>  kernel/cpu.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 407a2568f35e..cd7605204d4d 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -2616,6 +2616,7 @@ void init_cpu_possible(const struct cpumask *src)
>  void init_cpu_online(const struct cpumask *src)
>  {
>  	cpumask_copy(&__cpu_online_mask, src);
> +	atomic_set(&__num_online_cpus, cpumask_weight(cpu_online_mask));
>  }
>  
>  void set_cpu_online(unsigned int cpu, bool online)
> -- 
> 2.30.2
> 
