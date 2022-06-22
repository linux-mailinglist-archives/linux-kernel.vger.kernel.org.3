Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3175554118
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 06:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355715AbiFVEBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 00:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234648AbiFVEBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 00:01:14 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA08133EA8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 21:01:11 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id o18so7227014plg.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 21:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=sUWCotzxhcDBzuZSXVcRXHKpFF4YO9jXHOqw+wZMvvo=;
        b=R/xMtRsY432hg4H27noXB+7c7Zq8M9BeDCG8j62C3vYRImFPt/l9f+XsdNa9D3AAuB
         4dESMVsb6Kwp7+rg3dF4HgsmoR9B86ueeJ7LoDmtPxoy2S6z0JDhlOzbhMzXPRPntZwB
         KQcF0uZ77GXR53HCa/JmVkLWN23j+eqG/mp4/Vz1TMpIUtOeEObCUGtG8pdxBO/ltEzm
         jo6lxvd+CDZ4o5yk6CneDO1K/jLbR8MprkfFhWsUPOknAlLha6dcyrbzy6HeRKvrE4ke
         ha8NqCcHkCrTnFgdSdnIUri+tcqO7zQL8bKY8UyBjHInwxd49USCtDFdgHzzeajNbI8e
         gkqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=sUWCotzxhcDBzuZSXVcRXHKpFF4YO9jXHOqw+wZMvvo=;
        b=4f6wQwSFUAaLIITDije0OJUA4LDA82RGqhMLgzCGzrU4WeJBzBRwr40/7ctdQgOHVw
         hoEkUmfDCQQuxBdIfUwyt/7WWUvRhuU8SOBWLHXX2bOPdmhab2NG8JpKGlZ1hbxSz6QU
         VvpptsgoKQr053nX5n+Z4iRSL5jvH6P3weqsEjMjlLAmJrAJN1zFBx6HxVyJI0H9YrHv
         rfLRuBHQuNFRdRvPTdJl+gaQLbJiM5xVDVdjDFILapYuMw0VveEIChN1RusmM/PDWfhc
         ICE5F97iaRszRPokpTs/hWpsT2Gyu7QWswCLoQzkgY2d+7Y5fE9EsDG8W6stKDZrMpwM
         okhQ==
X-Gm-Message-State: AJIora9cUXG3JDciBUojZCdAZ8T+SeJsx3juew1529jJQlA9o//YnDjw
        IYew/tACq444fBVg0GzPQlRZWiIIe5uuXr04
X-Google-Smtp-Source: AGRyM1uvgqOyFpFKJ6HNjw2GDJ/pDraaeS25KAJnME4FvfpoMH4mxbdTdqdBFQhIWnuVlR++Gqm+rw==
X-Received: by 2002:a17:902:d64a:b0:168:fc10:7f5f with SMTP id y10-20020a170902d64a00b00168fc107f5fmr31469588plh.123.1655870471289;
        Tue, 21 Jun 2022 21:01:11 -0700 (PDT)
Received: from [10.94.58.189] ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id ji5-20020a170903324500b0015e8d4eb1d7sm5933189plb.33.2022.06.21.21.01.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jun 2022 21:01:11 -0700 (PDT)
Message-ID: <839de679-4c29-217d-5f80-4bcb70af5f5d@bytedance.com>
Date:   Wed, 22 Jun 2022 12:01:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH v4 7/7] sched/fair: de-entropy for SIS filter
Content-Language: en-US
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Josh Don <joshdon@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        linux-kernel@vger.kernel.org
References: <20220619120451.95251-1-wuyun.abel@bytedance.com>
 <20220619120451.95251-8-wuyun.abel@bytedance.com>
 <20220621182342.GA50611@chenyu5-mobl1>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <20220621182342.GA50611@chenyu5-mobl1>
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


On 6/22/22 2:23 AM, Chen Yu Wrote:
> On Sun, Jun 19, 2022 at 08:04:51PM +0800, Abel Wu wrote:
>> ...
>> @@ -8777,7 +8778,11 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>>   		nr_running = rq->nr_running;
>>   		sgs->sum_nr_running += nr_running;
>>   
>> -		if (update_core)
>> +		/*
>> +		 * The dst_cpu is not preferred since it might
>> +		 * be fed with tasks soon.
>> +		 */
>> +		if (update)
> maybe if (update_core && (env->dst_cpu != i)) so that the comment would
> be near the code logic and meanwhile without introducing a update variable?

Makes sense.

>> ...
>> @@ -9331,6 +9337,22 @@ static void sd_update_state(struct lb_env *env, struct sd_lb_stats *sds)
>>   	if (cmpxchg(&sd_smt_shared->updating, 0, 1))
>>   		return;
>>   
>> +	/*
>> +	 * The dst_cpu is likely to be fed with tasks soon.
>> +	 * If it is the only unoccupied cpu in this domain,
>> +	 * we still handle it the same way as as_has_icpus
>> +	 * but turn the SMT into the unstable state, rather
>> +	 * than waiting to the end of load balancing since
>> +	 * it's also important that update the filter as
>> +	 * early as possible to keep it fresh.
>> +	 */
>> +	if (new == sd_is_busy) {
>> +		if (idle_cpu(this) || sched_idle_cpu(this)) {
> available_idle_cpu()?
> 

It is used for choosing an idle cpu that will be immediately used,
so generally inside the wakeup path. But here we just want to know
the idle state of the cpus (and later inside wakeup path these cpus
will still be re-checked to see if they are preempted).

Thanks & BR,
Abel
