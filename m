Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 500E55A4EE7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 16:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbiH2OL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 10:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbiH2OLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 10:11:45 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9036CD35
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 07:11:44 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id l3so8103389plb.10
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 07:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=DT6f6u8imkxY5bllPWjtXEedW4yQBCVlllzbHnArMB0=;
        b=gP1eqEunokKgkf/aYahy/dEMrHX3SRKBlyG063v3mTCd2scihJUIKEjxnGAk1IVFfM
         +AbtWbKAMIMGx6DG4f8Ny7RnR4dsFFyMXm8ymJ3vhRPPXWKATytYg9ldw/p9PGfsdmXv
         aA2kq6b0AehWw4gamo5PS9uyRuVdJHqvty7hTIfJ3qyAotNsDig8eorFNfRXDeooiHka
         7+Wi/bkJvWOkjztJ3jtt8axmrP5YeQA8bxSKx4gn/er+CuU30FZDrzL2UL8UPPKGDTYN
         eGOAb9rgGLK0jXlEIEv3mHehT3WZv+5RkrwfQqBEx0YeJZXXiS9y4p/kSWLib/SvIA+T
         slrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=DT6f6u8imkxY5bllPWjtXEedW4yQBCVlllzbHnArMB0=;
        b=BVbHEifzn+C6lJmf/ARUfSwKEquPA/4Ck/g2/J2AYiB1empvIn1/c3hzCer/Ir+ZsJ
         sZvD3VWcetp0F04BhL/i0680EutHIAGPobkXDQISG4khRSIKu0dx8o1g+zXPM9eCyUwk
         ZTID+VMw5XJDTo/sTIr+8p+CZe4X01cJmXCYlbuWa71oQ61rNE4m8Loc3MhYJQoPl0xA
         MS2sEg2QDMydfmD0biI8m8U7VMrttqgfmg6ZNQpzeFwbvCd0pHJ2G9/GV3KhSaRg2HjY
         AWWrYwlyKqge9GNrbsjGLpwKfg8qJMTHmPsy09SDiv/g3Si+FVMCWlvNJPG2ECYHHVOf
         wsYQ==
X-Gm-Message-State: ACgBeo1ABMBtFfz4cdcH5e2zoW4KBUd8aTdtSwswf8wC9xCqR3BZBLsr
        zthdtaPC0aDL8XLYk568EspZ2Q==
X-Google-Smtp-Source: AA6agR7E5lujQ84zLbN29cEFNUXyehJ3iEtcShLHBV4zY7ozg0FFu+e4iNEjsGy2v5lqIO+LHQF2Sg==
X-Received: by 2002:a17:90a:6001:b0:1fa:e851:3480 with SMTP id y1-20020a17090a600100b001fae8513480mr18822733pji.153.1661782304280;
        Mon, 29 Aug 2022 07:11:44 -0700 (PDT)
Received: from [10.255.81.39] ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id l3-20020a632503000000b0042a06dc9a75sm6412260pgl.13.2022.08.29.07.11.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 07:11:43 -0700 (PDT)
Message-ID: <51009414-5ffb-b6ec-a501-7b2514a0f3cc@bytedance.com>
Date:   Mon, 29 Aug 2022 22:11:39 +0800
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
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <20220829130831.odhemmcmuecqxkbz@techsingularity.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mel, thanks for reviewing!

On 8/29/22 9:08 PM, Mel Gorman Wrote:
> On Tue, Jul 12, 2022 at 04:20:32PM +0800, Abel Wu wrote:
>> When SIS_UTIL is enabled, SIS domain scan will be skipped if
>> the LLC is overloaded. Since the overloaded status is checked
>> in the load balancing at LLC level, the interval is llc_size
>> miliseconds. The duration might be long enough to affect the
>> overall system throughput if idle cores are out of reach in
>> SIS domain scan.
>>
>> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
> 
> Split this patch to move the this_sd lookup into the SIS_PROP section.

OK

> 
> Otherwise, this is the most controversial patch in the series and the
> most likely to cause problems where it wins on some machines and
> workloads and loses on others.
> 
> The corner case to worry about is a workload that is rapidly idling and
> the has_idle_core hint is often wrong. This can happen with hackbench for
> example, or at least this was true when I last looked which is quite some
> time ago. If this hint is often wrong, then there will be full scan cost
> incurred regardless of SIS_UTIL that often fails to find a core.

Yes, I can't agree more. And the situation can become worse when LLC
gets bigger as you mentioned below. I will exclude this part from v2.

> 
> So, first suggestion is to move this patch to the end of the series as
> the other patches are relatively harmless. They could even be merged in
> isolation as a cleanup.
> 
> Second, using the other patches as your baseline, include in the
> changelog what you tested that showed a benefit, what type of machine
> it was and in particular include the number of cores, nodes and the
> span of the LLC.  If you measured any regressions, include that as well
> and make a call on whether you think the patch wins more than it loses.
> The reason to include that information is because the worst corner case
> (all CPUs scanned uselessly) costs more the larger the span of LLC is.
> If all the testing was done on a 2-core SMT-2 machine, the overhead of the
> patch would be negligible but very different if the LLC span is 20 cores.
> While the patch is not obviously wrong, it definitely needs better data,
> Even if you do not have a large test machine available, it's still helpful
> to have it in the changelog because a reviewer like me can decide "this
> needs testing on a larger machine".

Thanks for your detailed suggestions. I will attach benchmark results
along with some analysis next time when posting performance related
patches.

> 
> I did queue this up the entire series for testing and while it sometimes
> benefitted, there were large counter-examples. tbench4 on Zen3 showed some
> large regressions (e.g. 41% loss on 64 clients with a massive increase in
> variability) which has multiple small L3 caches per node. tbench4 (slightly
> modified in mmtests to produce a usable metric) in general showed issues
> across multiple x86-64 machines both AMD and Intel, multiple generations
> with a noticable increase in system CPU usage when the client counts reach
> the stage where the machine is close to saturated. perfpipe for some
> weird reason showed a large regression apparent regresion on Broadwell
> but the variability was also crazy so probably can be ignored. hackbench
> overall looked ok so it's possible I'm wrong about the idle_cores hint
> being often wrong on that workload and I should double check that. It's
> possible the hint is wrong some of the times but right often enough to
> either benefit from using an idle core or by finding an idle sibling which
> may be preferable to stacking tasks on the same CPU.

I attached my test result in one of my replies[1]: netperf showed ~3.5%
regression, hackbench improved a lot, and tbench4 drew. I tested several
times and the results didn't seem vary much.

> 
> The lack of data and the lack of a note on the potential downside is the
> main reason why I'm not acking patch. tbench4 was a particular concern on
> my own tests and it's possible a better patch would be a hybrid approach
> where a limited search of two cores (excluding target) is allowed even if
> SIS_UTIL indicates overload but has_idle_cores is true.
> 

Agreed. And the reason I will exclude this part in v2 is that I plan to
make it part of another feature, SIS filter [2]. The latest version of
SIS filter (not posted yet but soon) will contain all the idle cpus so
we don't need a full scan when has_idle_core. Scanning the filter then
is enough. While it may still cost too much if too many false positive
bits in the filter. Does this direction make sense to you?

[1] 
https://lore.kernel.org/lkml/eaa543fa-421d-2194-be94-6a5e24a33b37@bytedance.com/
[2] 
https://lore.kernel.org/lkml/20220619120451.95251-1-wuyun.abel@bytedance.com/

Thanks & Best Regards,
Abel
