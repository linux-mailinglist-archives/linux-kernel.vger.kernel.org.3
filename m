Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAF63561882
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 12:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232212AbiF3KqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 06:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiF3KqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 06:46:15 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05BD5D65
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 03:46:14 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id r1so16675920plo.10
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 03:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=AHRCCBW/JYhqCHWOVbSogrUe2u3TyZz98/JcPRt3vOM=;
        b=IicN9pLM0nICiRtnqiY88yj2ZaU+Nb/b/PnRYuAyLzX/hEOX8t4SzAFodnLYTWlXRz
         DPVEOzR1r2U39H89xXjdq9zYYoYYtNmc2cRFXBCAAHv05qvePfx3EHvI6grx+hvcZtW8
         fXDvt6sCT4w+6xGYENjw0/NdJCwJGCy1ul40L1MG9E5nZCWEXEMajLlLLo5DDaY6dtOK
         2HS6KJdWdplHLw+iKj9Hm5byXMvDcKaFBzwjXWMk3IMiomeCa50tkTGxbdgOYJ5cA3Pq
         ppO0fNfeG9ObHxh/DywqXOWr0psylqZnvI0qZyvkH0bbn1QdZn62H7lvSW/OJcLMswgY
         RTbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AHRCCBW/JYhqCHWOVbSogrUe2u3TyZz98/JcPRt3vOM=;
        b=Yj3HpKfS4NzRi9UqYg3c8i0UXqrACR4KM0aeQLaHKc6+ybQDWaHwiEXAWnz/ZUhNEZ
         zMiCi+8z4Rw8KfAMaiGG7V1smKHhmtvAs9cL9R8aiVtxpfDC5OOwWWw/PbzhgeUdu24M
         nDCjDa9tmvj5CdTXFysFUM5v/ZnxEbFrg3JG4BAXK8M0ASLLtujDGUsbAV/PX5j7gspG
         6jWS4dZhjuGHsY/I7Y+UVQsNwSBgS9JZWEjvUtrsslRSWVkVgwJERpPIjiHs/03Mfnoy
         Hl+jYeTg5zBLsJTWhl1YlPVb+4WoujZ+nANt2onKW6sgXQ2QlnmbIBcS4c88D4PS5XnM
         UFlw==
X-Gm-Message-State: AJIora9PE26a4+b633rez3bxRdlThBm5BK+gm0ouEpEF2I9vQ3705VnP
        0HU2mQgGRUUmEhprERRGRVTD3+1juK8rNg==
X-Google-Smtp-Source: AGRyM1t1rfYwPCSnYs9iDgfAbHPrQu203uWt+ZTuuf6fPirLXRLU9qsp862QAit9TQ7AZws/PJOclQ==
X-Received: by 2002:a17:90b:1b07:b0:1ec:c617:a314 with SMTP id nu7-20020a17090b1b0700b001ecc617a314mr9200091pjb.214.1656585973552;
        Thu, 30 Jun 2022 03:46:13 -0700 (PDT)
Received: from [10.4.105.41] ([139.177.225.225])
        by smtp.gmail.com with ESMTPSA id y5-20020a62ce05000000b0052514384f02sm2465676pfg.54.2022.06.30.03.46.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 03:46:13 -0700 (PDT)
Message-ID: <a72bf17e-f633-87e1-1166-6a4bff122500@bytedance.com>
Date:   Thu, 30 Jun 2022 18:46:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH v4 6/7] sched/fair: skip busy cores in SIS search
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
 <20220619120451.95251-7-wuyun.abel@bytedance.com>
 <20220621181442.GA37168@chenyu5-mobl1>
 <543d55e1-fad8-3df3-8bae-d79c0c8d8340@bytedance.com>
 <20220624033032.GA14945@chenyu5-mobl1>
 <3e4d2594-f678-b77a-4883-0b893daf19f6@bytedance.com>
 <2d18453d-9c9b-b57b-1616-d4a9229abd5a@bytedance.com>
 <20220630041645.GA9253@chenyu5-mobl1>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <20220630041645.GA9253@chenyu5-mobl1>
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


On 6/30/22 12:16 PM, Chen Yu Wrote:
> On Tue, Jun 28, 2022 at 03:58:55PM +0800, Abel Wu wrote:
>>
>> On 6/27/22 6:13 PM, Abel Wu Wrote:
>> There seems like not much difference except hackbench pipe test at
>> certain groups (30~110).
> OK, smaller LLC domain seems to not have much difference, which might
> suggest that by leveraging load balance code path, the read/write
> to LLC shared mask might not be the bottleneck. I have an vague
> impression that during Aubrey's cpumask searching for idle CPUs
> work[1], there is concern that updating the shared mask in large LLC
> has introduced cache contention and performance degrading. Maybe we
> can find that regressed test case to verify.
> [1] https://lore.kernel.org/all/1615872606-56087-1-git-send-email-aubrey.li@intel.com/

I just went through Aubrey's v1-v11 patches and didn't find any
particular tests other than hackbench/tbench/uperf. Please let
me know if I missed something, thanks!

>> I am intended to provide better scalability
>> by applying the filter which will be enabled when:
>>
>>    - The LLC is large enough that simply traversing becomes
>>      in-sufficient, and/or
>>
>>    - The LLC is loaded that unoccupied cpus are minority.
>>
>> But it would be very nice if a more fine grained pattern works well
>> so we can drop the above constrains.
>>
> We can first try to push a simple version, and later optimize it.
> One concern about v4 is that, we changed the logic in v3, which recorded
> the overloaded CPU, while v4 tracks unoccupied CPUs. An overloaded CPU is
> more "stable" because there are more than 1 running tasks on that runqueue.
> It is more likely to remain "occupied" for a while. That is to say,
> nr_task = 1, 2, 3... will all be regarded as occupied, while only nr_task = 0
> is unoccupied. The former would bring less false negative/positive.

Yes, I like the 'overloaded mask' too, but the downside is extra
cpumask ops needed in the SIS path (the added cpumask_andnot).
Besides, in this patch, the 'overloaded mask' is also unstable due
to the state is maintained at core level rather than per-cpu, some
more thoughts are in cover letter.

> 
> By far I have tested hackbench/schbench/netperf on top of Peter's sched/core branch,
> with SIS_UTIL enabled. Overall it looks good, and netperf has especially
> significant improvement when the load approaches overloaded(which is aligned
> with your comment above). I'll re-run the netperf for several cycles to check the
> standard deviation. And I'm also curious about v3's performance because it
> tracks overloaded CPUs, so I'll also test on v3 with small modifications.

Thanks very much for your reviewing and testing.

Abel
