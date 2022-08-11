Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0CE58F5BF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 04:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233677AbiHKCLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 22:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233587AbiHKCLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 22:11:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C943E5C9D6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 19:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=h+uF+lQ30edn3NbcymNy0iGU9+MYf3yjA5N14fvFiPQ=; b=0Q8tq7jUc4A0SFcyDQhh3WdM+L
        S1OqTy69AA8CVe4JNPb4jRVFLx+KN2mSQsh6tpr82QmAWV5LLiF7/8MdDrLOMn8YU9uQdKTd+eCv+
        JOfhL/iF31PJjUxGiqfxV3lOKVbALeBqys41HYGEkqmjBLsXyHDQ3D4jrGXPOhkX0qtEZXdQLPd8x
        Cs1WO7YKQdjMcDuw7YjkUuu14qDb2eYSuh+3lQZ4vNWiXEH8EESxjC7X3iBxkx7A8L20aaFV6G4GP
        kUkz6PbQtWkilanOuLpebofSaQo/R95Y9csKdUoYqqujQcU8h+Us80eBmKq9ZY+rka0CfkfnIjbic
        872O4Gyw==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oLxfi-003NZE-Dq; Thu, 11 Aug 2022 02:11:42 +0000
Message-ID: <9d2f1a82-8e0f-c0ad-e23f-e0d00905a596@infradead.org>
Date:   Wed, 10 Aug 2022 19:11:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC][PATCH 1/2] sched: Avoid placing RT threads on cores
 handling long softirqs
Content-Language: en-US
To:     John Stultz <jstultz@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Connor O'Brien <connoro@google.com>,
        John Dias <joaodias@google.com>, Rick Yiu <rickyiu@google.com>,
        John Kacur <jkacur@redhat.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Chris Redpath <chris.redpath@arm.com>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com,
        "J . Avila" <elavila@google.com>
References: <20220811015758.3001641-1-jstultz@google.com>
 <20220811015758.3001641-2-jstultz@google.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220811015758.3001641-2-jstultz@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/10/22 18:57, John Stultz wrote:
> diff --git a/init/Kconfig b/init/Kconfig
> index c7900e8975f1..b0dde2771314 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1278,6 +1278,17 @@ config SCHED_AUTOGROUP
>  	  desktop applications.  Task group autogeneration is currently based
>  	  upon task session.
>  
> +config RT_SOFTIRQ_OPTIMIZATION
> +       bool "Improve RT scheduling during long softirq execution"
> +       depends on ARM64
> +       depends on SMP
> +       default n
> +       help
> +         Enable an optimization which tries to avoid placing RT tasks on CPUs

Above line is indented with spaces only. :(

> +	 occupied by nonpreemptible tasks, such as a long softirq or CPUs
> +	 which may soon block preemptions, such as a CPU running a ksoftirq
> +	 thread which handles slow softirqs.

All help text lines should be indented with one tab + 2 spaces,
per Documentation/process/coding-style.rst.
(The 3 lines above have one tab + one space.)

-- 
~Randy
