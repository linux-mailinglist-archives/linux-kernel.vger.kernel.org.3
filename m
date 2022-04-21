Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 528D550A5A8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 18:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbiDUQ32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 12:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbiDUQYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 12:24:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1225721E39
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 09:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650558075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4OyiNir4ZgTY41pfhW45irabPPK8V8SYDVRCi06s/XI=;
        b=S0ntTkA0fHHnSZT4UTvVkC2rUIiyFAA0aZRho+PEi2IVJxnuY1HGJTZphmgGe869UR1DBP
        4xlSBobCwlfGq9NsXk4QylWB9vP9nx2KGsbjyx3w9HoAr1oPRspTLSS781OCxs/OKYSuZt
        JQt4IXgSbyGWEql8gE3pAM/FOqXcb3Y=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-228-Pms6O4N4MJODpzGl1iUqyw-1; Thu, 21 Apr 2022 12:21:14 -0400
X-MC-Unique: Pms6O4N4MJODpzGl1iUqyw-1
Received: by mail-ua1-f70.google.com with SMTP id w24-20020ab06518000000b0035d1e9751easo2074113uam.13
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 09:21:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4OyiNir4ZgTY41pfhW45irabPPK8V8SYDVRCi06s/XI=;
        b=lonsu/bOMEQy6nJZfEK5YdcbnfLZZVInUtzhn5GRCfACXf+Oqa0od723mximq0fssl
         nO3MbohFdpkNu3DQPCYAygj7gouvn8I/am0erT3GLGxjh2yFX+1QORfDPX3x+QLjAcJk
         0WY5RwkuMToAVU6v2BmmxoyMZPofyTmXjYC9ADu4N/GAXVhQZggCqhy/To/SDuFdFG6E
         8L9XgtRrc9ysrnyFcGxJnljGtGakJD2KRvE/ynhp+X8Y/nPlbc1CtI1QyVmGoKZq6if0
         AWZQrQx3qh5/DLT4oJapONqAKmESUgUmXp14NMF4iKxLU/Vn/wnDbYPYGYBmaMbSrhci
         KJZw==
X-Gm-Message-State: AOAM531Eu/wrwnEnko7K00ZoAMcHBsWCc6kYMnj5CoajuuJKR2lhnVkL
        C+3MU9BTvRlT61DoNs53c5u/O+ftp1lL2lvboXPgixrW9aNJ/PsrGTRhRVUYh0qGJzAAdAKN9Qt
        t3mdbhzHu1a3l5Tg3yYVMeYKb
X-Received: by 2002:a05:6102:20e:b0:32a:25f9:7bfc with SMTP id z14-20020a056102020e00b0032a25f97bfcmr52187vsp.82.1650558072570;
        Thu, 21 Apr 2022 09:21:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzSw9uWFv3sPW86/uomCqEfpzFut3ZdUkG+lVWMl42pzmzJbQ8M276lzcWeg9ejYO6t3Z59RQ==
X-Received: by 2002:a05:6102:20e:b0:32a:25f9:7bfc with SMTP id z14-20020a056102020e00b0032a25f97bfcmr52177vsp.82.1650558072295;
        Thu, 21 Apr 2022 09:21:12 -0700 (PDT)
Received: from [192.168.169.241] ([216.239.164.83])
        by smtp.gmail.com with ESMTPSA id g23-20020ac5c5d7000000b0034cda7c3ac1sm266051vkl.46.2022.04.21.09.21.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Apr 2022 09:21:11 -0700 (PDT)
Message-ID: <0e64ed24-e676-6cfc-376f-f404e759f6f1@redhat.com>
Date:   Thu, 21 Apr 2022 12:21:10 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3] vm_swappiness=0 should still try to avoid swapping
 anon memory
Content-Language: en-US
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, aquini@redhat.com,
        shakeelb@google.com, mhocko@suse.com, hakavlad@inbox.lv,
        David Hildenbrand <david@redhat.com>, llong@redhat.com
References: <20210809223740.59009-1-npache@redhat.com>
 <b5575449-08a2-2901-e7e1-a97150e4878c@redhat.com>
 <Yl8Dk+a1YDwupLMv@cmpxchg.org>
 <e495901c-f2f3-cc85-10a6-0d2944255b19@redhat.com>
 <YmASIHjTVndHHoL4@cmpxchg.org>
 <bc9f5209-5c59-c921-d85e-e2e54b2375db@redhat.com>
 <YmBUkNMVDQobgK4M@cmpxchg.org>
From:   Nico Pache <npache@redhat.com>
In-Reply-To: <YmBUkNMVDQobgK4M@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/20/22 14:44, Johannes Weiner wrote:
>>
>> The larger issue is that our workload has regressed in performance.
>>
>> With V2 and swappiness=10 we are still seeing some swap, but very little tearing
>> down of THPs over time. With swappiness=0 it did some when swap but we are not
>> losings GBs of THPS (with your patch swappiness=0 has swap or THP issues on V2).
I meant to say `with your patch swappiness=0 does not swap or have thp issues on v2`
>>
>> With V1 and swappiness=(0|10)(with and without your patch), it swaps a ton and
>> ultimately leads to a significant amount of THP splitting. So the longer the
>> system/workload runs, the less likely we are to get THPs backing the guest and
>> the performance gain from THPs is lost.
> 
> I hate to ask, but is it possible this is a configuration issue
Im very glad you asked :)
> 
> One significant difference between V1 and V2 is that V1 has per-cgroup
> swappiness, which is inherited when the cgroup is created. So if you
> set sysctl vm.swappiness=0 after cgroups have been created, it will
> not update them. V2 cgroups do use vm.swappiness:

This is something I did not consider... Thank you for pointing that out!

The issue still occurs weather or not I set the swappiness value before the VM
boot. However this led me to find the icing on the cake :)

Even if I set vm.swappiness=0 at boot using sysctl.conf I was not considering
the fact that libvirtd was creating its own cgroup for the machines you start it
with... additionally it does not inherit the sysctl value (even when set at
boot)?!? How annoying...

The cgroups swappiness value is defaulted to 60. This to me seems wrong from a
libvirt/systemd POV. If the system is booted with swappiness=0 then why does the
(user|machine|system).splice cgroup ignore this value when it creates it cgroups
(see below).

I will have to dig a little further to find a cause/fix for this. This requires
the libvirt users to understand a number of intricacies that they really
shouldnt have to consider, and may lead to headaches like these ;P

Values of the memcgs created on boot (with sysctl.swappiness=0 on V1 boot)
------------------------------------------------------------------------
/sys/fs/cgroup/memory/memory.swappiness 				=0
/sys/fs/cgroup/memory/dev-hugepages.mount/memory.swappiness		=60
/sys/fs/cgroup/memory/dev-mqueue.mount/memory.swappiness		=60
/sys/fs/cgroup/memory/machine.slice/memory.swappiness			=60
/sys/fs/cgroup/memory/proc-sys-fs-binfmt_misc.mount/memory.swappiness	=0
/sys/fs/cgroup/memory/sys-fs-fuse-connections.mount/memory.swappiness	=0
/sys/fs/cgroup/memory/sys-kernel-config.mount/memory.swappiness		=0
/sys/fs/cgroup/memory/sys-kernel-debug.mount/memory.swappiness		=60
/sys/fs/cgroup/memory/sys-kernel-tracing.mount/memory.swappiness	=60
/sys/fs/cgroup/memory/system.slice/memory.swappiness			=60
/sys/fs/cgroup/memory/user.slice/memory.swappiness			=60

Some seem to inherit the cgroup/memory/memory.swappiness value and some do
not... This issue was brought up in a systemd issue with no solution or
documentation [1].

Libvirt in particular is using the machine.splice cgroup so it inherits the 60.
If i change that value to 0, then start the machine it now has swappiness 0.
$ echo 0 > /sys/fs/cgroup/memory/machine.slice/memory.swappiness
$ virsh start <guest-name>
$ cat /sys/fs/cgroup/memory/machine.slice/machine-qemu.scope/memory.swappiness
0

Thank you so much for your very insightful note that led to the real issue :)

> Thanks for verifying. I'll prepare a proper patch.

my issue with v1 vs v2 seems to go away with a much more sane value of
swappiness=10 on v1 (when actually set properly lol).

Also as per my results below, I actually dont think your patch caused much
change to my workload. Im not sure what happened the first time I ran it that
caused the swapping on v2 (before your patch)... perhaps I ran the older kernel
(~v5.14) that was still having issues with v2 or its the fact that the results
can differ between runs. sorry about that.

Here is the test results for your patch with V1 and V2 (swappiness=0/10):

Before Patch
-------------
-- V1(swappiness=0):
               total        used        free      shared  buff/cache   available
Mem:       264071432   257465704     1100160        4224     5505568     5064964
Swap:        4194300       47828     4146472

Node 0 AnonPages:      128068580 kB	Node 1 AnonPages:      128120400 kB
Node 0 AnonHugePages:  128012288 kB	Node 1 AnonHugePages:  128090112 kB
                                                               ^^^^^ no loss

-- V1(swappiness=10):
               total        used        free	  shared  buff/cache   available
Mem:	   264071432   257364436      972048        3972     5734948     5164520
Swap:        4194300      235028     3959272

Node 0 AnonPages:      128015404 kB     Node 1 AnonPages:      128002788 kB
Node 0 AnonHugePages:  128002048 kB     Node 1 AnonHugePages:  120576000 kB
                                                               ^^^^^ some loss

-- V2(swappiness=0):
               total        used        free	  shared  buff/cache   available
Mem:	   264071432   257609352      924692        4664     5537388     4921236
Swap:        4194300           0     4194300
                           ^^^^^ No Swap
Node 0 AnonPages:      128083104 kB     Node 1 AnonPages:      128180576 kB
Node 0 AnonHugePages:  128002048 kB     Node 1 AnonHugePages:  128124928 kB
                                                               ^^^^^ No loss

-- V2(swappiness=10):
               total        used        free	  shared  buff/cache   available
Mem:	   264071432   257407576      918124        4632     5745732     5101764
Swap:        4194300      220424     3973876
                           ^^^^^ Some Swap
Node 0 AnonPages:      128109700 kB	Node 1 AnonPages:      127918164 kB
Node 0 AnonHugePages:  128006144 kB	Node 1 AnonHugePages:  120569856 kB
                                                               ^^^^^ some loss

After Patch
-------------
-- V1:swappiness=0
               total        used        free	  shared  buff/cache   available
Mem:	   264071432   257538832      945276        4368     5587324     4991852
Swap:        4194300        9276     4185024

Node 0 AnonPages:      128133932 kB	Node 1 AnonPages:      128100540 kB
Node 0 AnonHugePages:  128047104 kB	Node 1 AnonHugePages:  128061440 kB


-- V1:swappiness=10
               total        used        free	  shared  buff/cache   available
Mem:	   264071432   257428564      969252        4384     5673616     5100824
Swap:        4194300      138936     4055364
                           ^^^^^ Some Swap
Node 0 AnonPages:      128161724 kB     Node 1 AnonPages:      127945368 kB
Node 0 AnonHugePages:  128043008 kB     Node 1 AnonHugePages:  120221696 kB
                                                               ^^^^^ some loss

-- V2(swappiness=0):
               total        used        free      shared  buff/cache   available
Mem:       264071432   257536896      927424        4664     5607112     4993184
Swap:        4194300           0     4194300

Node 0 AnonPages:      128145476 kB	Node 1 AnonPages:      128111908 kB
Node 0 AnonHugePages:  128026624 kB	Node 1 AnonHugePages:  128090112 kB

-- V2(swappiness=10):
               total        used        free	  shared  buff/cache   available
Mem:	   264071432   257423936     1007076        4548     5640420     5106544
Swap:        4194300	  156016     4038284

Node 0 AnonPages:      128133264 kB     Node 1 AnonPages:      127955952 kB
Node 0 AnonHugePages:  128018432 kB     Node 1 AnonHugePages:  122507264 kB
                                                           ^^^^ slightly better

The only notable difference between before/after your patch is that with your
patch the THP tearing was slightly better, resulting in an extra 2GB as seen in
the last result. This may just be noise.

I'll have to see if I can find a fix for this in either the kernel, libvirt, or
systemd, and will follow up if I do. If not this should at least be documented
correctly. Given the fact cgroupV1 is in limited support mode upstream, and
systemd's hesitancy to make changes for V1, we may how to go down our own
avenues to ensure our customers dont run into this issue.

Big Thanks!
-- Nico

[1] - https://github.com/systemd/systemd/issues/9276

