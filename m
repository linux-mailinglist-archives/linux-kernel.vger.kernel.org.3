Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C250537B15
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 15:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236441AbiE3NJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 09:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236381AbiE3NJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 09:09:06 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2048198E
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 06:09:04 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id w23so763730ljd.11
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 06:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=NzV8dfvq8cM1l3XimLO2tX+6Q+tj9m2ZJPGNF/NhjTo=;
        b=yhuJl6kgzdEsB6MDpBTkzDuIqI/wRbimnVLT6eSntaZc6lWCsxW2wrBPEL3gUZsDBQ
         kt7rSdHWA9c1as0IPZMH6dqVC7eR/eoshPwpiRNaxS2rd/8T+IHsxklwl0SQhX3+IE7h
         /Yej+6rAGirETCjtvpHewEhik6BmYoJwI9pVIfnRAou/ThMFyfB07ZeamdtfGJOf8YkU
         tF3X6JSQcT+QO+h0POANTn+JyY5OPapGHnK2rqcabhbVPiXAXFXw0f8PDR8kbz9ZxMUB
         JLEuSo3jNxb4w3QKYhAGoTPfJoJx4Vw2h0zr8dEJxMcYahoP1kEJq72EfUtjGpnsPuDd
         H7Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NzV8dfvq8cM1l3XimLO2tX+6Q+tj9m2ZJPGNF/NhjTo=;
        b=xeBzdn0dKtCNBzw13kC9HQ98H5cnLQGppItrH/U+ero3y+Td7maxtJfZlrcT4i7UjX
         WBIYSrX/CrIjfaV4xA78UxYP1O6ntUe1uBDEd1LdIj0TVeTd4/goYhLzwL8laYEnTVhu
         V1/vNcEV+/Pi17WGtLyaxjcLtiWVMmml5jr/5RyDMMWhk1VZAXPvVyyhrk1WO4/lExfQ
         ByQW5yD4jIepb7XkmJ2IbgvtsPNkU76gPy+vUA/Z9v7+NSusMyy6Oi50nwfRcj3e5U+P
         She/zruNxGpcnRgSzYPGEP31Q1EfbgLHtofV1lxzYnGEIxUYx452/IliPVgA2jmWL54s
         a+WA==
X-Gm-Message-State: AOAM532KxYkt1/wtEvqruNiAnZTooOak1kx0fqFKBJxru6GQZgPK56X+
        pPEzCtW+zMd5KOqWjGqOVhXooiN02HWOfQ==
X-Google-Smtp-Source: ABdhPJyGEmw4OOsueL6lBotf/Xe/ex21rgqNILXZQYJpAEatNT/bo2JEBuXL1R2Rijfpp90G6vOHfA==
X-Received: by 2002:a2e:7d18:0:b0:254:1e86:a3c with SMTP id y24-20020a2e7d18000000b002541e860a3cmr13281239ljc.77.1653916142662;
        Mon, 30 May 2022 06:09:02 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.129])
        by smtp.gmail.com with ESMTPSA id s20-20020a056512203400b00477b0779016sm1162502lfs.264.2022.05.30.06.09.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 May 2022 06:09:02 -0700 (PDT)
Message-ID: <ef9f7516-853d-ffe4-9a7a-5e87556bdbbe@openvz.org>
Date:   Mon, 30 May 2022 16:09:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH mm v3 0/9] memcg: accounting for objects allocated by
 mkdir cgroup
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, kernel@openvz.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Muchun Song <songmuchun@bytedance.com>, cgroups@vger.kernel.org
References: <06505918-3b8a-0ad5-5951-89ecb510138e@openvz.org>
 <3e1d6eab-57c7-ba3d-67e1-c45aa0dfa2ab@openvz.org>
 <YpSwvii5etfnOYC9@dhcp22.suse.cz>
From:   Vasily Averin <vvs@openvz.org>
In-Reply-To: <YpSwvii5etfnOYC9@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/30/22 14:55, Michal Hocko wrote:
> On Mon 30-05-22 14:25:45, Vasily Averin wrote:
>> Below is tracing results of mkdir /sys/fs/cgroup/vvs.test on 
>> 4cpu VM with Fedora and self-complied upstream kernel. The calculations
>> are not precise, it depends on kernel config options, number of cpus,
>> enabled controllers, ignores possible page allocations etc.
>> However this is enough to clarify the general situation.
>> All allocations are splited into:
>> - common part, always called for each cgroup type
>> - per-cgroup allocations
>>
>> In each group we consider 2 corner cases:
>> - usual allocations, important for 1-2 CPU nodes/Vms
>> - percpu allocations, important for 'big irons'
>>
>> common part: 	~11Kb	+  318 bytes percpu
>> memcg: 		~17Kb	+ 4692 bytes percpu
>> cpu:		~2.5Kb	+ 1036 bytes percpu
>> cpuset:		~3Kb	+   12 bytes percpu
>> blkcg:		~3Kb	+   12 bytes percpu
>> pid:		~1.5Kb	+   12 bytes percpu		
>> perf:		 ~320b	+   60 bytes percpu
>> -------------------------------------------
>> total:		~38Kb	+ 6142 bytes percpu
>> currently accounted:	  4668 bytes percpu
>>
>> - it's important to account usual allocations called
>> in common part, because almost all of cgroup-specific allocations
>> are small. One exception here is memory cgroup, it allocates a few
>> huge objects that should be accounted.
>> - Percpu allocation called in common part, in memcg and cpu cgroups
>> should be accounted, rest ones are small an can be ignored.
>> - KERNFS objects are allocated both in common part and in most of
>> cgroups 
>>
>> Details can be found here:
>> https://lore.kernel.org/all/d28233ee-bccb-7bc3-c2ec-461fd7f95e6a@openvz.org/
>>
>> I checked other cgroups types was found that they all can be ignored.
>> Additionally I found allocation of struct rt_rq called in cpu cgroup 
>> if CONFIG_RT_GROUP_SCHED was enabled, it allocates huge (~1700 bytes)
>> percpu structure and should be accounted too.
> 
> One thing that the changelog is missing is an explanation why do we need
> to account those objects. Users are usually not empowered to create
> cgroups arbitrarily. Or at least they shouldn't because we can expect
> more problems to happen.
> 
> Could you clarify this please?

The problem is actual for OS-level containers: LXC or OpenVz.
They are widely used for hosting and allow to run containers
by untrusted end-users. Root inside such containers is able
to create groups inside own container and consume host memory
without its proper accounting.

Thank you,
	Vasily Averin
