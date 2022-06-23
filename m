Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7447B557E6B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 17:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbiFWPDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 11:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbiFWPDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 11:03:38 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FEE61EC78
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 08:03:36 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id s14so16913218ljs.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 08:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=4H3ceOwo0QWDBTksiBY1nTfnYze/Q04xjv0/hjoR1QE=;
        b=jAZaSHl/WL950DRTIHi6bVKfTCkAeNlBKZFbqzBO3gOEk7LKaX32kIlX07WpEZCiz0
         8G+aI1JqTLmysh+J300moZbLIcNCv++WFB0ojr1jQsBUBMcSFVHWLZWJz7XghvqcPpSm
         iNov6Zi/0JW8qHxs8svvnsceLLskWXq9yZlKEMKeMWxdAblWG1UKyzunLZqOjNIZaUxi
         KLnxlf2Te8z+3XiuCJloWU7WTwQmHw8F0mIwM/4Qf9tghtbT9kcOWc2ILKATdGpxsGVN
         MbxUrDuXfxc63NXnh0g98qScyfobiftrceqVId/NAayYbGtGgVwH6cWIzYNd2RgAbg9g
         eGIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=4H3ceOwo0QWDBTksiBY1nTfnYze/Q04xjv0/hjoR1QE=;
        b=pH0SIq2JXzRPASPChl6nbNaknVCnnMoAb2eshGbGG4qnOzAIVw0kiwLLty0unnttRp
         8a2FUPxSlADEu/DV0JvS7ESJLlq8hMg7VwHE8e8gkql8REjhwfAryr0fmVysdSrBZrQi
         YRzSI3zeAbYYjulLGvW/WG6VGNCBB1mwrDkg3iV5RNRBTpCD6jDxyjuTtr3z6Bdf9bSH
         gRktHR2f/yyHkN0rsl+w0d6epOokGg278yJ4hwktXQUcj7KdBQqgWedok9mjC4/D0toC
         jVH/YHPHbielT857JcCm2vS3umDWB9dHs9I927wgioHzdM4VrxZv/8ZLgx47ZkJV16jO
         pmTg==
X-Gm-Message-State: AJIora8pTYLvAXjPI/LuS3T1ExSkaRz/wmlUCEpkIDPjv82NaWu3FV3O
        8xqCSgII2TlqIqPgHwCFhbW4sg==
X-Google-Smtp-Source: AGRyM1tCSSWNE2nvbVxfjOHpauS9XcbDxDCn4l90o154YEvxcYZQPjkTEm9kW5yyxn8qV7cFd9CvsQ==
X-Received: by 2002:a2e:1411:0:b0:25a:6b41:feec with SMTP id u17-20020a2e1411000000b0025a6b41feecmr4993477ljd.270.1655996612863;
        Thu, 23 Jun 2022 08:03:32 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.129])
        by smtp.gmail.com with ESMTPSA id e6-20020a195006000000b0047f749df807sm1543373lfb.61.2022.06.23.08.03.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 08:03:32 -0700 (PDT)
Message-ID: <c516033f-a9e4-3485-26d9-a68afa694c1d@openvz.org>
Date:   Thu, 23 Jun 2022 18:03:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH mm v5 0/9] memcg: accounting for objects allocated by
 mkdir, cgroup
Content-Language: en-US
From:   Vasily Averin <vvs@openvz.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     kernel@openvz.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Muchun Song <songmuchun@bytedance.com>, cgroups@vger.kernel.org
References: <4e685057-b07d-745d-fdaa-1a6a5a681060@openvz.org>
 <0fe836b4-5c0f-0e32-d511-db816d359748@openvz.org>
In-Reply-To: <0fe836b4-5c0f-0e32-d511-db816d359748@openvz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Michal,
do you still have any concerns about this patch set?

Thank you,
	Vasily Averin

On 6/23/22 17:50, Vasily Averin wrote:
> In some cases, creating a cgroup allocates a noticeable amount of memory.
> This operation can be executed from inside memory-limited container,
> but currently this memory is not accounted to memcg and can be misused.
> This allow container to exceed the assigned memory limit and avoid
> memcg OOM. Moreover, in case of global memory shortage on the host,
> the OOM-killer may not find a real memory eater and start killing
> random processes on the host.
> 
> This is especially important for OpenVZ and LXC used on hosting,
> where containers are used by untrusted end users.
> 
> Below is tracing results of mkdir /sys/fs/cgroup/vvs.test on 
> 4cpu VM with Fedora and self-complied upstream kernel. The calculations
> are not precise, it depends on kernel config options, number of cpus,
> enabled controllers, ignores possible page allocations etc.
> However this is enough to clarify the general situation.
> All allocations are splitted into:
> - common part, always called for each cgroup type
> - per-cgroup allocations
> 
> In each group we consider 2 corner cases:
> - usual allocations, important for 1-2 CPU nodes/Vms
> - percpu allocations, important for 'big irons'
> 
> common part: 	~11Kb	+  318 bytes percpu
> memcg: 		~17Kb	+ 4692 bytes percpu
> cpu:		~2.5Kb	+ 1036 bytes percpu
> cpuset:		~3Kb	+   12 bytes percpu
> blkcg:		~3Kb	+   12 bytes percpu
> pid:		~1.5Kb	+   12 bytes percpu		
> perf:		 ~320b	+   60 bytes percpu
> -------------------------------------------
> total:		~38Kb	+ 6142 bytes percpu
> currently accounted:	  4668 bytes percpu
> 
> - it's important to account usual allocations called
> in common part, because almost all of cgroup-specific allocations
> are small. One exception here is memory cgroup, it allocates a few
> huge objects that should be accounted.
> - Percpu allocation called in common part, in memcg and cpu cgroups
> should be accounted, rest ones are small an can be ignored.
> - KERNFS objects are allocated both in common part and in most of
> cgroups 
> 
> Details can be found here:
> https://lore.kernel.org/all/d28233ee-bccb-7bc3-c2ec-461fd7f95e6a@openvz.org/
> 
> I checked other cgroups types was found that they all can be ignored.
> Additionally I found allocation of struct rt_rq called in cpu cgroup 
> if CONFIG_RT_GROUP_SCHED was enabled, it allocates huge (~1700 bytes)
> percpu structure and should be accounted too.
> 
> v5:
>  1) re-based to linux-mm (mm-everything-2022-06-22-20-36)
> 
> v4:
>  1) re-based to linux-next (next-20220610)
>    now psi_group is not a part of struct cgroup and is allocated on demand
>  2) added received approval from Muchun Song
>  3) improved cover letter description according to akpm@ request
> 
> v3:
>  1) re-based to current upstream (v5.18-11267-gb00ed48bb0a7)
>  2) fixed few typos
>  3) added received approvals
> 
> v2:
>  1) re-split to simplify possible bisect, re-ordered
>  2) added accounting for percpu psi_group_cpu and cgroup_rstat_cpu,
>      allocated in common part
>  3) added accounting for percpu allocation of struct rt_rq
>      (actual if CONFIG_RT_GROUP_SCHED is enabled)
>  4) improved patches descriptions 
> 
> Vasily Averin (9):
>   memcg: enable accounting for struct cgroup
>   memcg: enable accounting for kernfs nodes
>   memcg: enable accounting for kernfs iattrs
>   memcg: enable accounting for struct simple_xattr
>   memcg: enable accounting for percpu allocation of struct psi_group_cpu
>   memcg: enable accounting for percpu allocation of struct
>     cgroup_rstat_cpu
>   memcg: enable accounting for large allocations in mem_cgroup_css_alloc
>   memcg: enable accounting for allocations in alloc_fair_sched_group
>   memcg: enable accounting for perpu allocation of struct rt_rq
> 
>  fs/kernfs/mount.c      | 6 ++++--
>  fs/xattr.c             | 2 +-
>  kernel/cgroup/cgroup.c | 2 +-
>  kernel/cgroup/rstat.c  | 3 ++-
>  kernel/sched/fair.c    | 4 ++--
>  kernel/sched/psi.c     | 2 +-
>  kernel/sched/rt.c      | 2 +-
>  mm/memcontrol.c        | 4 ++--
>  8 files changed, 14 insertions(+), 11 deletions(-)
> 

