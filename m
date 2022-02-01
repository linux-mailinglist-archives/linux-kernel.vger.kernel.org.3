Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3741B4A6887
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 00:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242883AbiBAX3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 18:29:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238665AbiBAX3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 18:29:37 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31002C061714;
        Tue,  1 Feb 2022 15:29:37 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id BBE886110;
        Tue,  1 Feb 2022 23:29:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net BBE886110
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1643758176; bh=KnpV4g9gN0KTh6HOrvOccnplvDHyNUQe8yueWZH6+8c=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=i5gCpFY+oFCr8JAwXxHVvgh0aj6T/z4zb4L/hZ4fGASQOxIut1A6ShPiGUH6COHx9
         iW5c+XUiHdizAatlziIZqgC0e0fq5/ySqdLUSIgJp08C9ha81gDBd3tLP7EtknUPh4
         6kIyqlQwtKqVmcm0FMCUW/6krCJkZjtG1P7k2r/qfKul+z2mqmAO6Q0As434mqpxpO
         Q79I1p2KfcQwfH66W2TfK0SxDijyHlhBsuHlRfBDUxT7giiGZErd9CEB8QR2UbQa1G
         CxhZuQRnjf5AJ1eWasARkdqMAndFPVcBJrr4ebDKuCh2bGYP0TSy+sciGi8S0CrTLR
         wMACK4YFXkkfg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Tang Yizhou <tangyizhou@huawei.com>, peterz@infradead.org,
        mingo@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        zhengbin13@huawei.com, tangyeechou@gmail.com,
        Tang Yizhou <tangyizhou@huawei.com>
Subject: Re: [PATCH] docs: scheduler: Fix outdated parameter of
 rebalance_domains
In-Reply-To: <20211221031818.23186-1-tangyizhou@huawei.com>
References: <20211221031818.23186-1-tangyizhou@huawei.com>
Date:   Tue, 01 Feb 2022 16:30:09 -0700
Message-ID: <8735l25fni.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tang Yizhou <tangyizhou@huawei.com> writes:

> According to the function prototype of rebalance_domains(), its first
> parameter is *rq* and the document need to be updated.
>
> Signed-off-by: Tang Yizhou <tangyizhou@huawei.com>
> ---
>  Documentation/scheduler/sched-domains.rst | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/scheduler/sched-domains.rst b/Documentation/scheduler/sched-domains.rst
> index 84dcdcd2911c..e57ad28301bd 100644
> --- a/Documentation/scheduler/sched-domains.rst
> +++ b/Documentation/scheduler/sched-domains.rst
> @@ -37,10 +37,10 @@ rebalancing event for the current runqueue has arrived. The actual load
>  balancing workhorse, run_rebalance_domains()->rebalance_domains(), is then run
>  in softirq context (SCHED_SOFTIRQ).
>  
> -The latter function takes two arguments: the current CPU and whether it was idle
> -at the time the scheduler_tick() happened and iterates over all sched domains
> -our CPU is on, starting from its base domain and going up the ->parent chain.
> -While doing that, it checks to see if the current domain has exhausted its
> +The latter function takes two arguments: the runqueue of current CPU and whether
> +the CPU was idle at the time the scheduler_tick() happened and iterates over all
> +sched domains our CPU is on, starting from its base domain and going up the ->parent
> +chain. While doing that, it checks to see if the current domain has exhausted its
>  rebalance interval. If so, it runs load_balance() on that domain. It then checks
>  the parent sched_domain (if it exists), and the parent of the parent and so
>  forth.

This seems to make sense.  Applied, thanks.

jon
