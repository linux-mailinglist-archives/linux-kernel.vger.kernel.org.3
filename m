Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4915AF0EA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 18:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234062AbiIFQkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 12:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233378AbiIFQjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 12:39:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F13452478
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 09:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662481062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QbEAVozP5z9DgYb519JusCiR/Mr6KkCiRqjjrveYQJ0=;
        b=Mm3avHXFWH/59Rd0DAtFwPtb33nb55l7UxP+G7PYhEVE1vDAnbIn/9JJ+PNmF6dQZZyjMs
        WqWdjz6n1m207jFu9anBNvPoDq/Meh5AJx3Uf1G1aT+6oK9k9CwW5Gw0VuFHx9Um84H6Y+
        Z6TiT9bNpx+BYEoGKqFyOEiPQxfVB8E=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-620-BpmD576pNH6n0eJ27Avm2A-1; Tue, 06 Sep 2022 12:17:41 -0400
X-MC-Unique: BpmD576pNH6n0eJ27Avm2A-1
Received: by mail-wm1-f69.google.com with SMTP id f7-20020a1c6a07000000b003a60ede816cso2190605wmc.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 09:17:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=QbEAVozP5z9DgYb519JusCiR/Mr6KkCiRqjjrveYQJ0=;
        b=tYQGNvTVkicIOSqoDluuIk26M+7/tHPszgSVmMf0Pfs7R5LP2D8HFgccZCDo5nYyp9
         l6mIWALzBWWD7jFotWVi+uvBcGdWvGdBHscK8iXs3+eBL5xUP46yJrN42oyGDypSv/UR
         15xF0t3vto5kCrDY0IWRdtp9777lOQsEymQTdxbGalbuuWxsDRS6lxAi9p1ez0zcfnBv
         tVwF1gv/0xir8+18HHnIg2e+XdrjaK22MaXeycLB5GePbAqc1H/LAJxNvkz2lCBKmIbW
         JWPQaqWAPfFlwbOhe3mVWN8AWGaDgP2BqD9bH/2S1pDIW8h+znQnnLOHupIElT/sosPl
         dWjQ==
X-Gm-Message-State: ACgBeo2MkozduSsMtMewLfUfW4KtR9MVa+5LuD8x3cf4LYFUZXBPzhEE
        8zmsLlJCO4th3GCGiW0gHepRZht4k2Mchgp43iAMIeJcfrau261hKv57uFMXHm41IticPLx/i6E
        piUB5yfhbANA14kURiJ+5b/5o
X-Received: by 2002:a7b:ca58:0:b0:3a5:3c1c:6d71 with SMTP id m24-20020a7bca58000000b003a53c1c6d71mr14510978wml.118.1662481058467;
        Tue, 06 Sep 2022 09:17:38 -0700 (PDT)
X-Google-Smtp-Source: AA6agR587zZfYYYSd9LRmNgFXusKjtHsvckcftFheSRW3HEr+cQZfB4g8iYRmqolIrzoO875XIzMFw==
X-Received: by 2002:a7b:ca58:0:b0:3a5:3c1c:6d71 with SMTP id m24-20020a7bca58000000b003a53c1c6d71mr14510970wml.118.1662481058232;
        Tue, 06 Sep 2022 09:17:38 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id t12-20020a05600c198c00b003a2e92edeccsm23003662wmq.46.2022.09.06.09.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 09:17:37 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Yair Podemsky <ypodemsk@redhat.com>
Cc:     x86@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        rafael.j.wysocki@intel.com, pauld@redhat.com, frederic@kernel.org,
        ggherdovich@suse.cz, linux-kernel@vger.kernel.org, lenb@kernel.org,
        jlelli@redhat.com, mtosatti@redhat.com, ppandit@redhat.com,
        alougovs@redhat.com, lcapitul@redhat.com, nsaenz@kernel.org
Subject: Re: [PATCH] x86/aperfmperf: Fix arch_scale_freq_tick() on tickless
 systems
In-Reply-To: <YxdfO/5/Yfodm18i@hirez.programming.kicks-ass.net>
References: <20220804131728.58513-1-ypodemsk@redhat.com>
 <YxdfO/5/Yfodm18i@hirez.programming.kicks-ass.net>
Date:   Tue, 06 Sep 2022 17:17:36 +0100
Message-ID: <xhsmhsfl4bhpb.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/09/22 16:54, Peter Zijlstra wrote:
> On Thu, Aug 04, 2022 at 04:17:28PM +0300, Yair Podemsky wrote:
>> @@ -392,7 +400,12 @@ void arch_scale_freq_tick(void)
>>      s->mcnt = mcnt;
>>      raw_write_seqcount_end(&s->seq);
>>
>> -	scale_freq_tick(acnt, mcnt);
>> +	/*
>> +	 * Avoid calling scale_freq_tick() when the last update was too long ago,
>> +	 * as it might overflow during calulation.
>> +	 */
>> +	if ((jiffies - last) <= MAX_SAMPLE_AGE_NOHZ)
>> +		scale_freq_tick(acnt, mcnt);
>>  }
>
> All this patch does is avoid the warning; but afaict it doesn't make it
> behave in a sane way.
>
> I'm thinking that on nohz_full cpus you don't have load balancing, I'm
> also thinking that on nohz_full cpus you don't have DVFS.
>
> So *why* the heck are we setting this stuff to random values ? Should
> you not simply kill th entire thing for nohz_full cpus?

IIRC this stems from systems where nohz_full CPUs are not running tickless
at all times (you get transitions to/from latency-sensitive work). Also
from what I've seen isolation is (intentionally) done with just
isolcpus=managed_irq,<nohz_cpus>; there isn't the 'domain' flag so load
balancing isn't permanently disabled.

DVFS is another point, I don't remember seeing cpufreq governor changes in
the transitions, but I wouldn't be suprised if there were - so we'd move
from tickless, no-DVFS to ticking with DVFS (and would like that to behave
"sanely").

FWIW arm64 does something similar in that it just saves the counters but
doesn't update the scale when the delta overflows/wrapsaround, so that the
next tick can work with a sane delta, cf

  arch/arm64/kernel/topology.c::amu_scale_freq_tick()

