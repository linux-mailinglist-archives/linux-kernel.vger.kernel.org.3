Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2624D8896
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 16:53:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242786AbiCNPyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 11:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242775AbiCNPyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 11:54:05 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B4213D57;
        Mon, 14 Mar 2022 08:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=YPjKuh1WORHuHsKRyd3ugLDmy9mAtje1baZB7sPm6bI=; b=l4gH9/ZN8SbfjmV4CN5o82JaT5
        RIPRxKdoZgmtGb8Te5bhMN6pjAqiYEoemzQGtAhKuVPJ/O9DDyTbM/mwglTioZCvjg3r2RS3XYvxD
        GfpQloC7ECWbdUn4uL5dZLNxp5vgpX/DNfL39Ewc87QYKUC63IT5BykHy2ohcC9rXerjZeBDMWo1n
        ZDZPwgBgX4Ewi61W514MXRKmd+6EuwtCVSL5zETo4vQMTXfwmX4rMcYSooSIz2DaFzm4AItL+BjVq
        5VexDwM1iQG8ywFr6ZGc/nkvAsZ2+aGDfBZsCQEEvSLOZT6Tb4TrpYY2/gqdyeWMl5aliQXgDvU1y
        Q4HOPpmQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nTmzt-000tJu-BG; Mon, 14 Mar 2022 15:52:37 +0000
Message-ID: <617e1903-fd21-3394-0e27-cd514c32f89b@infradead.org>
Date:   Mon, 14 Mar 2022 08:52:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] docs/scheduler: Introduce the doc of load average
Content-Language: en-US
To:     Jui-Tse Huang <juitse.huang@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Huaixin Chang <changhuaixin@linux.alibaba.com>,
        Beata Michalska <beata.michalska@arm.com>,
        Chun-Hung Tseng <henrybear327@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
        Yiwei Lin <s921975628@gmail.com>
References: <20220314084759.9849-1-juitse.huang@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220314084759.9849-1-juitse.huang@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/14/22 01:47, Jui-Tse Huang wrote:
> The load average is one of a common as well as easy observed statistic
> provied by Linux, but still not well documented, which makes the numbers
> that users observes from the output of top, htop or other system
> monitoring application are only numbers. This patch gives a discussion
> on how Linux calculates the load average as well as what metrics are
> concerned while calculating the load average.
> 
> The discussion flow is divided into several parts:
> 1. The expression used to get the load average.
> 2. Why Linux choose such average method from the other.
> 2. The meaning of each term in the expression.
> 3. The metrics, that is, the type of tasks that will be covered in the
>    calculation.
> 4. A brief explanation over the fixed-point nubmer since the weights
>    defined in the Linux kernel are based on it.
> 
> Signed-off-by: Jui-Tse Huang <juitse.huang@gmail.com>
> Signed-off-by: Yiwei Lin <s921975628@gmail.com>
> Co-Developed-by: Yiwei Lin <s921975628@gmail.com>
> 
> ---
> v1 -> v2:
>     fix typo: '$cat /proc/laodavg' -> '$cat /proc/loadavg'
> 
>  Documentation/scheduler/index.rst        |  1 +
>  Documentation/scheduler/load-average.rst | 77 ++++++++++++++++++++++++
>  2 files changed, 78 insertions(+)
>  create mode 100644 Documentation/scheduler/load-average.rst
> 
> diff --git a/Documentation/scheduler/index.rst b/Documentation/scheduler/index.rst
> index 88900aabdbf7..bdc779b4190f 100644
> --- a/Documentation/scheduler/index.rst
> +++ b/Documentation/scheduler/index.rst
> @@ -17,6 +17,7 @@ Linux Scheduler
>      sched-nice-design
>      sched-rt-group
>      sched-stats
> +    load-average
>  
>      text_files
>  
> diff --git a/Documentation/scheduler/load-average.rst b/Documentation/scheduler/load-average.rst
> new file mode 100644
> index 000000000000..589320ee1cd7
> --- /dev/null
> +++ b/Documentation/scheduler/load-average.rst
> @@ -0,0 +1,77 @@
> +============
> +Load Average
> +============
> +
> +Load average is a basic statistic provided by almost all operating systems that
> +aims to report the usage of system hardware resources. In Linux kernel, the
> +load average is calculated via the following expression::
> +
> +                / 0                                      , if t = 0
> +    load_{t} = |
> +                \ laod_{t - 1} * exp + active * (1 - exp), otherwise

                     load_

> +
> +The expression represents the exponential moving average of the historical
> +loading of the system. There are several reasons that Linux kernel chooses
> +exponential moving average from other similar average equations such as simple
> +moving average or cumulative moving average:
> +
> +#. The exponential moving average consumes fixed memory space, while the simple
> +   moving average has O(n) space complexity where n is the number of timeslice

                                                                        timeslices

> +   within a given interval.
> +#. The exponential moving average not only applies a higher weight to the most
> +   recent record but also declines the weight exponentially, which makes the
> +   resulting load average reflect the situation of the current system. Neither
> +   the simple moving average nor cumulative moving average has this feature.
> +
> +In the expression, the load_{t} in the expression indicates the calculated load

Don't need the second             "in the expression" above.

> +average at the given time t.
> +The active is the most recent recorded system load. In Linux, the system load
> +means the number of tasks in the state of TASK_RUNNING or TASK_UNINTERRUPTIBLE
> +of the entire system. Tasks with TASK_UNINTERRUPTIBLE state are usually waiting
> +for disk I/O or holding an uninterruptible lock, which is considered as a part
> +of system resource, thus, Linux kernel covers them while calculating the load
> +average.
> +The exp means the weight applied to the previous report of load average, while
> +(1 - exp) is the weight applied to the most recently recorded system load.
> +There are three different weights defined in the Linux kernel, in
> +include/linux/sched/loadavg.h, to perform statistics in various timescales::
> +
> +    // include/linux/sched/loadavg.h
> +    ...
> +    #define EXP_1    1884    /* 1/exp(5sec/1min) as fixed-point */
> +    #define EXP_5    2014    /* 1/exp(5sec/5min) */
> +    #define EXP_15   2037    /* 1/exp(5sec/15min) */
> +    ...
> +
> +According to the expression shown on the top of this page, the weight (exp)
> +controls how much of the last load load_{t - 1} will take place in the
> +calculation of current load, while (1 - exp) is the weight applied to the most
> +recent record of system load active.
> +
> +Due to the security issue, the weights are defined as fixed-point numbers based
> +on the unsigned integer rather than floating-pointing numbers. The introduction
> +of the fixed-point number keeps the FPU away from the calculation process. Since
> +the precession of the fixed-point used in the Linux kernel is 11 bits, a
> +fixed-point can be converted to a floating-point by dividing it by 2048, as the
> +expression shown below::

              shows below::
or
  as in the expressions shown below::

> +
> +    EXP_1  = 1884 / 2048 = 0.919922
> +    EXP_5  = 2014 / 2048 = 0.983398
> +    EXP_15 = 2037 / 2048 = 0.994629
> +
> +Which indicates the weights applied to active are::
> +
> +    (1 - EXP_1)  = (1 - 0.919922) = 0.080078
> +    (1 - EXP_5)  = (1 - 0.983398) = 0.016602
> +    (1 - EXP_15) = (1 - 0.994629) = 0.005371
> +
> +The load average will be updated every 5 seconds. Each time the scheduler_tick()
> +be called, the function calc_global_load_tick() will also be invoked, which
> +makes the active of each CPU core be calculated and be merged globally, finally,

                                                                 globally. Finally,

> +the load average will be updated with that global active.
> +
> +As a user, the load average can be observed via top, htop, or other system
> +monitor application, or more directly, by the following command::
> +
> +    $ cat /proc/loadavg
> +

thanks.
-- 
~Randy
