Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09CA55AD558
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 16:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238674AbiIEOnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 10:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238443AbiIEOmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 10:42:38 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552285F13C
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 07:40:06 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id c2so8712704plo.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 07:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=RYQnTXZZuWcGbpSqaq35fWZqtZ1qJ4UulAZxlrVbUnc=;
        b=FmnhmNmCe/85eAvm6JEc6G9mLNA0RF3y9jR22W5oHBdwVIKaVMQcZrd427Iny3GYj2
         YG3Sq7RSmjuqlupdSmd+SgW1N7L0KkT3Z0LhUeskHZUNCTGd/04qTjiuRPtuGzOmFx17
         2Fum2DJIfKRbERXPd7mYFbsuJXpWpTJ+g0oNXv3xSocLRXKJv9i7jV5rB3bbU60dmTe4
         wINF4D536t9zBdk6VUHOg8Ct1ZqS6oSvItJjcMZF1D5cBSXGrM1uh8tZRqpaC639Lvyi
         aR+bAHgmY+AhaVdbQ2K3JfqZZ2hmortzeioFQUTZ8nca5zapzbhevoK8ubWMCJA1C0sj
         SLZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=RYQnTXZZuWcGbpSqaq35fWZqtZ1qJ4UulAZxlrVbUnc=;
        b=fzOtmz5VUTcwwwwmA0rGi9kh2KJ/aOD9sKo+FkygpZLuqc61y9fHUbBwpZkDHAhFK4
         MFT32IliP46sQ6MSITesMwh4fR5IqVaP5LS/d66ke8B9RAfxYLfDOBBwcxyhN5YAfMyi
         /NZT9Jf/1lE2CgnXaCZxGm1eIRz05si9vI+eh9koPTmdyvi/c3xZGybjNtUYkwbeSbLZ
         bozHcfo2zl9kohj3FbANBiTSKfCSmBhvAqrjOXGGKmFu2sTFufWz9D1gGPrCTIhdOxvS
         RHS9mGuHdRNsEPE8YLclU9YubytjECTB4xdWOBK4dPHJ+e4ZtQR1R7Zzb0qFygQYPgD/
         cXZg==
X-Gm-Message-State: ACgBeo1e5gAszICGb4UBYanJM44BaMvJZv/3WpumH62To3H4UG0JNVX/
        I9KsFi7sViOJx3E7kxao+rr6kw==
X-Google-Smtp-Source: AA6agR7oR+wxM9Eh3rLCYVo+NMA3EMkITmNNgcLoUWAlvYnryd6xrFd1mnstgtcfCwiHF+kWMc8XVw==
X-Received: by 2002:a17:90b:3ecb:b0:200:211:9bb1 with SMTP id rm11-20020a17090b3ecb00b0020002119bb1mr16206291pjb.4.1662388805573;
        Mon, 05 Sep 2022 07:40:05 -0700 (PDT)
Received: from [10.255.175.119] ([139.177.225.224])
        by smtp.gmail.com with ESMTPSA id d7-20020a170903230700b0016d785ef6d2sm7636431plh.223.2022.09.05.07.40.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Sep 2022 07:40:05 -0700 (PDT)
Message-ID: <1fc40679-b7c3-24f2-aa27-f1edab71228e@bytedance.com>
Date:   Mon, 5 Sep 2022 22:40:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: Re: [PATCH 1/5] sched/fair: ignore SIS_UTIL when has idle core
Content-Language: en-US
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Josh Don <joshdon@google.com>, Chen Yu <yu.c.chen@intel.com>,
        linux-kernel@vger.kernel.org
References: <20220712082036.5130-1-wuyun.abel@bytedance.com>
 <20220712082036.5130-2-wuyun.abel@bytedance.com>
 <20220829130831.odhemmcmuecqxkbz@techsingularity.net>
 <51009414-5ffb-b6ec-a501-7b2514a0f3cc@bytedance.com>
 <20220829145621.7cxrywgxow5ov7ki@techsingularity.net>
 <0ffb0903-431f-88fe-3a56-150b283f5304@bytedance.com>
 <20220902102528.keooutttg3hq3sy5@techsingularity.net>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <20220902102528.keooutttg3hq3sy5@techsingularity.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/2/22 6:25 PM, Mel Gorman Wrote:
> For the simple case, I was expecting the static depth to *not* match load
> because it's unclear what the scaling should be for load or if it had a
> benefit. If investigating scaling the scan depth to load, it would still
> make sense to compare it to a static depth. The depth of 2 cores was to
> partially match the old SIS_PROP behaviour of the minimum depth to scan.
> 
>                  if (span_avg > 4*avg_cost)
>                          nr = div_u64(span_avg, avg_cost);
>                  else
>                          nr = 4;
> 
> nr is not proportional to cores although it could be
> https://lore.kernel.org/all/20210726102247.21437-7-mgorman@techsingularity.net/
> 
> This is not tested or properly checked for correctness but for
> illustrative purposes something like this should conduct a limited scan when
> overloaded. It has a side-effect that the has_idle_cores hint gets cleared
> for a partial scan for idle cores but the hint is probably wrong anyway.
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 6089251a4720..59b27a2ef465 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6427,21 +6427,36 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
>   		if (sd_share) {
>   			/* because !--nr is the condition to stop scan */
>   			nr = READ_ONCE(sd_share->nr_idle_scan) + 1;
> -			/* overloaded LLC is unlikely to have idle cpu/core */
> -			if (nr == 1)
> -				return -1;
> +
> +			/*
> +			 * Non-overloaded case: Scan full domain if there is
> +			 * 	an idle core. Otherwise, scan for an idle
> +			 * 	CPU based on nr_idle_scan
> +			 * Overloaded case: Unlikely to have an idle CPU but
> +			 * 	conduct a limited scan if there is potentially
> +			 * 	an idle core.
> +			 */
> +			if (nr > 1) {
> +				if (has_idle_core)
> +					nr = sd->span_weight;
> +			} else {
> +				if (!has_idle_core)
> +					return -1;
> +				nr = 2;
> +			}
>   		}
>   	}
>   
>   	for_each_cpu_wrap(cpu, cpus, target + 1) {
> +		if (!--nr)
> +			break;
> +
>   		if (has_idle_core) {
>   			i = select_idle_core(p, cpu, cpus, &idle_cpu);
>   			if ((unsigned int)i < nr_cpumask_bits)
>   				return i;
>   
>   		} else {
> -			if (!--nr)
> -				return -1;
>   			idle_cpu = __select_idle_cpu(cpu, p);
>   			if ((unsigned int)idle_cpu < nr_cpumask_bits)
>   				break;

I spent last few days testing this, with 3 variations (assume
has_idle_core):

  a) full or limited (2cores) scan when !nr_idle_scan
  b) whether clear sds->has_idle_core when partial scan failed
  c) scale scan depth with load or not

some observations:

  1) It seems always bad if not clear sds->has_idle_core when
     partial scan fails. It is due to over partially scanned
     but still can not find an idle core. (Following ones are
     based on clearing has_idle_core even in partial scans.)

  2) Unconditionally full scan when has_idle_core is not good
     for netperf_{udp,tcp} and tbench4. It is probably because
     the SIS success rate of these workloads is already high
     enough (netperf ~= 100%, tbench4 ~= 50%, compared to that
     hackbench ~= 3.5%) which negate a lot of the benefit full
     scan brings.

  3) Scaling scan depth with load seems good for the hackbench
     socket tests, and neutral in pipe tests. And I think this
     is just the case you mentioned before, under fast wake-up
     workloads the has_idle_core will become not that reliable,
     so a full scan won't always win.

Best Regards,
Abel
