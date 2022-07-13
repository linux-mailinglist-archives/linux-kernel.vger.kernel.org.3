Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2DC573748
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 15:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235906AbiGMNVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 09:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbiGMNVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 09:21:40 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C37E0B
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 06:21:39 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id v7so8168611pfb.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 06:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=cMTzm8TR8VZznkKhiX61e+NOOM0+A9cn//WdoqprJDk=;
        b=L+NswA4tP/nZ/OqQxm1TyKXSsVjeylE3VBWV3a84hMGylTbhDJExC2+MiZYuRq3G0u
         gUeiEipB59uNS1GXStBvKZU/YeYdY7fgkOYIRLDhPy3Sy8qsrfHwvcqaBojMAxDE8cYV
         Psmjf1Hfh68Qc/mAAiAftyvhSGnE7MqMSeC5wUXYM21Sl1Daw1MvoS3DXFMW7UR9rqPA
         HcmgjCz8XLc/ggRcBJMnLP09PCbsRnvJsvAgoZiuBoLZ6TX0rAcp8seEVu/Ex6XR6woc
         tQGvvYDD4mjXED9C6//odA2iEqF3/5j70MP/JcKAUTH7HvBogdsgJ/rhsSKhz8jOb9Kd
         TdcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=cMTzm8TR8VZznkKhiX61e+NOOM0+A9cn//WdoqprJDk=;
        b=1wjFkzFME3ffO+4HJ1GVMCZiyKRI++wG+CqZMi72BtDQdn8PviC0VLVFFfvfawiICF
         q0Yhhtcrvzd54/TSmbC/GY3qOJRi6T9HsxX1BlQAFk+aj/9C06IeeLonDAciOaROsdJn
         oKmTd5WdXAw37GttBSztV3dbCSHT6eyL+L0FZou6DHCAD7D9VsHf6Z7WrivnvvNkJStB
         g5908WXFKCJHuOVgm4a5Fw/Y9vfvfqdA0aR5YigPKo2K+8Y2jHEqAKpokA3IsIzYqfmL
         +aXy/U6rM1t/x+JgvHIcdpQuOenzTGI2DFsQKu1oJZ4krZo4wXmQbpWxNvXqG9WMkhE4
         64WQ==
X-Gm-Message-State: AJIora/TRoaTk9uXqCyV2fjwhjM020ttnNULjvO3qEr+74azsj5oxDz1
        tMZow0UMixnd5eIv1avhPDJlsQ==
X-Google-Smtp-Source: AGRyM1srBy4hw+/zYE+H+WwMbqHHsA5QVIDmyjV+PaRyvfr+VCGTQ4eYqL8SvlHJdgrqs4RZIZRbwQ==
X-Received: by 2002:a05:6a00:1acb:b0:525:b64b:79c3 with SMTP id f11-20020a056a001acb00b00525b64b79c3mr3297924pfv.76.1657718498829;
        Wed, 13 Jul 2022 06:21:38 -0700 (PDT)
Received: from [10.85.115.102] ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id f1-20020a63e301000000b0040c9df2b060sm8009425pgh.30.2022.07.13.06.21.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 06:21:38 -0700 (PDT)
Message-ID: <8bcb77e0-b893-f309-1b81-dc665f61fe84@bytedance.com>
Date:   Wed, 13 Jul 2022 21:21:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [External] Re: [PATCH] sched/topology: Optimized copy default
 topology in sched_init_numa()
To:     Valentin Schneider <vschneid@redhat.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org
References: <20220627105349.80715-1-jiahao.os@bytedance.com>
 <xhsmh35fhgcww.mognet@vschneid.remote.csb>
 <e5eed9c9-afd4-e88c-dbee-7fef2e76043a@bytedance.com>
 <xhsmhtu7m72fr.mognet@vschneid.remote.csb>
From:   Hao Jia <jiahao.os@bytedance.com>
In-Reply-To: <xhsmhtu7m72fr.mognet@vschneid.remote.csb>
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



On 2022/7/12 Valentin Schneider wrote:
> On 11/07/22 18:28, Hao Jia wrote:
>> On 2022/7/4 Valentin Schneider wrote:
>>>
>>> It's not a very hot path but I guess this lets you shave off a bit of boot
>>> time... While you're at it, you could add an early
>> Thanks for your time and suggestion.
>>>
>>>     if (nr_node_ids == 1)
>>>             return;
>>>
>>
>> This will cause the values of sched_domains_numa_levels and
>> sched_max_numa_distance to be different from before, and
>> sched_domains_numa_levels may cause the return value of
>> sched_numa_find_closest() to be different.
>> I'm not sure if it will cause problems.
>>
> 
> True, we need to be careful here, but those are all static so they get
> initialized to sensible defaults (zero / NULL pointer).
> 
> sched_numa_find_closest() will return nr_cpu_ids which make sense, so I
> think we can get away with an early return

Yes, this may affect the return value of housekeeping anycpu(), which 
doesn't seem to be a problem.

> 
>>> since !NUMA systems still go through sched_init_numa() if they have a
>>> kernel with CONFIG_NUMA (which should be most of them nowdays) and IIRC
>>> they end up with an unused NODE topology level.
>>>
>>
>> I'm confused why most !NUMA systems enable CONFIG_NUMA in the kernel?
>> Maybe for scalability?
>>
> 
> It just makes things easier on a distribution point of view - just ship a
> single kernel image everyone can use, rather than N different images for N
> different types of systems.
> 
> AFAIA having CONFIG_NUMA on an UMA (!NUMA) system isn't bad, it just adds
> more things in the sched_domain_topology during boot time which end up
> being unused.

Thank you very much for your answer.

Thinks,
Hao

> 
