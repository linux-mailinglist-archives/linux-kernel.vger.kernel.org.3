Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1CE533BD9
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 13:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243141AbiEYLhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 07:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243002AbiEYLhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 07:37:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7C9DCA005A
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 04:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653478626;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M3hAOXoo6D5ZjzfUZf6OBWb/9SBl/lq9MIa99qLJlp4=;
        b=TYRYfCai+rfP+hTGRyZohTUZ838I3jPEhF4RmtGN2WVTu7/BIo3b6WMHQyQqcIDOQdHE1H
        I2kZ2rrG8WxjcDBjsMdl6a3h3ptzk8z95Sz2j6to7DOojCsK4e0G8/Pk9+rH/R7RHDVK3K
        ukpUPyzXDuacnlGL7kGk+dNPJQxlU/8=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-44-7nBBaDZ6Ng6jV-ghjZOH_A-1; Wed, 25 May 2022 07:37:03 -0400
X-MC-Unique: 7nBBaDZ6Ng6jV-ghjZOH_A-1
Received: by mail-lj1-f200.google.com with SMTP id a14-20020a2e88ce000000b00254078ad384so599165ljk.7
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 04:37:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=M3hAOXoo6D5ZjzfUZf6OBWb/9SBl/lq9MIa99qLJlp4=;
        b=wmoJGPJ5m1G+7PBVzUXUpUHmJ8+TN8kqRB3n+BObHzDe3DcfkzWZw8hJblRNNzW3Jz
         naxFgc2jSOFgxKRcQnRwHuv/qIeOW8MxX5xKXD3Zwkas0n3Fv3nAdTMti+k3XurI0TL7
         VtLBY6tCqP9YoI1BMqPDZ+mtXoFLgv5tZ/rpsmA8J5dIY1viOsYOf9/GLwP2v5Bk/5xX
         k5AjhOeZCBYgSAWuNCOjpI13HA1No9wocpCnom3jxPQCVJaAzezgK+2/GIK8XIySPRSB
         OpmJcvlCnJA+NY8/ddYZPabYV8mZuK5dFNwnQqEKwVznaBmcdvXJl7VyU0MDCv5Dj7Tm
         ep7A==
X-Gm-Message-State: AOAM533cOTEFNXhzFn94PxrJCDdXvJvR2GB/psD/FNpmMXLETb+goqVT
        VIh7iu/2nfdEyrMRppPxtSY260dIA62PH8i20jFbKdEWQFXLcdLzn097EIURZtY5prIFRSrnpAg
        13uY2LYqsvDp1t9N8yZfduBY=
X-Received: by 2002:a05:6512:b96:b0:478:5d7b:2e21 with SMTP id b22-20020a0565120b9600b004785d7b2e21mr15160521lfv.305.1653478621389;
        Wed, 25 May 2022 04:37:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwriGoreU0E3V6nOEG0nIMHCpIDDL6uaEAL1ptQBVTwiAybYB4y/6yMJsflVcf0aO7Cn3SYrg==
X-Received: by 2002:a05:6512:b96:b0:478:5d7b:2e21 with SMTP id b22-20020a0565120b9600b004785d7b2e21mr15160495lfv.305.1653478621052;
        Wed, 25 May 2022 04:37:01 -0700 (PDT)
Received: from [192.168.1.121] (91-145-109-188.bb.dnainternet.fi. [91.145.109.188])
        by smtp.gmail.com with ESMTPSA id m8-20020ac24288000000b0047255d211ecsm3057974lfh.283.2022.05.25.04.36.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 May 2022 04:37:00 -0700 (PDT)
Message-ID: <2d06932c-7d80-94c7-89ab-78375e58d3cc@redhat.com>
Date:   Wed, 25 May 2022 14:36:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: RFC: Memory Tiering Kernel Interfaces (v2)
Content-Language: en-US
To:     Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>,
        Ying Huang <ying.huang@intel.com>, Wei Xu <weixugc@google.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Thelen <gthelen@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Michal Hocko <mhocko@kernel.org>,
        Tim C Chen <tim.c.chen@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Alistair Popple <apopple@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Feng Tang <feng.tang@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dan Williams <dan.j.williams@intel.com>,
        David Rientjes <rientjes@google.com>,
        Linux MM <linux-mm@kvack.org>,
        Brice Goglin <brice.goglin@gmail.com>,
        Hesham Almatary <hesham.almatary@huawei.com>
References: <CAAPL-u-DGLcKRVDnChN9ZhxPkfxQvz9Sb93kVoX_4J2oiJSkUw@mail.gmail.com>
 <20220512160010.00005bc4@Huawei.com>
 <CAAPL-u_diGYEb7+WsgqNBLRix-nRCk2SsDj6p9r8j5JZwOABZQ@mail.gmail.com>
 <6b7c472b50049592cde912f04ca47c696caa2227.camel@intel.com>
 <CAAPL-u-NAJkSXHzQr8OtEEGnnUrsCE9US6c5S5Rv0xutASxv1Q@mail.gmail.com>
 <ad1bc96a86b21b8f46d356f0c0b7449be38b2220.camel@intel.com>
 <CAAPL-u8XzJnrew4vuFq7GgwgjjBff8MwRFGTDmUc9DOwa+q=FA@mail.gmail.com>
 <6ce724e5c67d4f7530457897fa08d0a8ba5dd6d0.camel@intel.com>
 <594046f8-9ab3-786a-fc48-8a61f1238f52@linux.ibm.com>
From:   =?UTF-8?Q?Mika_Penttil=c3=a4?= <mpenttil@redhat.com>
In-Reply-To: <594046f8-9ab3-786a-fc48-8a61f1238f52@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25.5.2022 13.01, Aneesh Kumar K V wrote:
> On 5/25/22 2:33 PM, Ying Huang wrote:
>> On Tue, 2022-05-24 at 22:32 -0700, Wei Xu wrote:
>>> On Tue, May 24, 2022 at 1:24 AM Ying Huang <ying.huang@intel.com> wrote:
>>>>
>>>> On Tue, 2022-05-24 at 00:04 -0700, Wei Xu wrote:
>>>>> On Thu, May 19, 2022 at 8:06 PM Ying Huang <ying.huang@intel.com> 
>>>>> wrote:
>>>>>>
> 
> ...
> 
>>
>> OK.  Just to confirm.  Does this mean that we will have fixed device ID,
>> for example,
>>
>> GPU            memtier255
>> DRAM (with CPU)        memtier0
>> PMEM            memtier1
>>
>> When we add a new memtier, it can be memtier254, or memter2?  The rank
>> value will determine the real demotion order.
>>
>> I think you may need to send v3 to make sure everyone is at the same
>> page.
>>
> 
> What we have implemented which we will send as RFC shortly is below.
> 
> cd /sys/dekvaneesh@ubuntu-guest:~$ cd /sys/devices/system/
> kvaneesh@ubuntu-guest:/sys/devices/system$ pwd
> /sys/devices/system
> kvaneesh@ubuntu-guest:/sys/devices/system$ ls
> clockevents  clocksource  container  cpu  edac  memory  memtier  mpic 
> node  power
> kvaneesh@ubuntu-guest:/sys/devices/system$ cd memtier/
> kvaneesh@ubuntu-guest:/sys/devices/system/memtier$ pwd
> /sys/devices/system/memtier
> kvaneesh@ubuntu-guest:/sys/devices/system/memtier$ ls
> default_rank  max_rank  memtier1  power  uevent
> kvaneesh@ubuntu-guest:/sys/devices/system/memtier$ cat default_rank
> 1
> kvaneesh@ubuntu-guest:/sys/devices/system/memtier$ cat max_rank
> 3
> kvaneesh@ubuntu-guest:/sys/devices/system/memtier$ cd memtier1/
> kvaneesh@ubuntu-guest:/sys/devices/system/memtier/memtier1$ ls
> nodelist  power  rank  subsystem  uevent
> kvaneesh@ubuntu-guest:/sys/devices/system/memtier/memtier1$ cat nodelist
> 0-3
> kvaneesh@ubuntu-guest:/sys/devices/system/memtier/memtier1$ cat rank
> 1
> kvaneesh@ubuntu-guest:/sys/devices/system/memtier/memtier1$ cd 
> ../../node/node1/
> kvaneesh@ubuntu-guest:/sys/devices/system/node/node1$ cat memtier
> 1
> kvaneesh@ubuntu-guest:/sys/devices/system/node/node1$
> root@ubuntu-guest:/sys/devices/system/node/node1# echo 0 > memtier
> root@ubuntu-guest:/sys/devices/system/node/node1# cat memtier
> 0
> root@ubuntu-guest:/sys/devices/system/node/node1# cd ../../memtier/
> root@ubuntu-guest:/sys/devices/system/memtier# ls
> default_rank  max_rank  memtier0  memtier1  power  uevent
> root@ubuntu-guest:/sys/devices/system/memtier# cd memtier0/
> root@ubuntu-guest:/sys/devices/system/memtier/memtier0# cat nodelist
> 1
> root@ubuntu-guest:/sys/devices/system/memtier/memtier0# cat rank
> 0
> root@ubuntu-guest:/sys/devices/system/memtier/memtier0# echo 4 > rank
> bash: rank: Permission denied
> root@ubuntu-guest:/sys/devices/system/memtier/memtier0#
> 

Just to confirm, unlike today's demotion code, the demotion target 
allocation is planned to honor mempolicies?


--Mika


