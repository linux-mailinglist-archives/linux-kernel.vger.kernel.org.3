Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 319FA5A2523
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 11:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245079AbiHZJyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 05:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiHZJyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 05:54:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66FC8D87DA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 02:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661507649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gxGpACUZugSb6gistk/DMyJom0Pp6sbkUgL6hlrJ7UI=;
        b=Gf/D9cbDwoz+xPgnQ5i9wasJgDc+ItG7LUMoTX4natNPYcNOY5Ho8Oj+tAHF268FoGHeqL
        aVcdtxoNmymu1nsx9dnlz88+G7+kxelNEfd5PvKQyrLymQ1HVjRDrQB0l6/e25WcJHU8J6
        HebMCSmDkDbUAf6mMBOUVME/dBFaC8o=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-298--QLonjsJN8aRhx2FSZsyBg-1; Fri, 26 Aug 2022 05:54:00 -0400
X-MC-Unique: -QLonjsJN8aRhx2FSZsyBg-1
Received: by mail-wm1-f72.google.com with SMTP id f7-20020a1c6a07000000b003a60ede816cso289531wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 02:54:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=gxGpACUZugSb6gistk/DMyJom0Pp6sbkUgL6hlrJ7UI=;
        b=wNtoUMf4uaVOusfdmCeSKu3nzIbuuN24G6YYBGwHG8aehCm664ZQE9s4X05CMoicMf
         iGdYajKb7o3mIT+vEkMEFqFgrm19MAQ075kBu7b4UFvcs0lzUGCxAGq+sFT2m3NoTP+S
         /b+F7TBfMgD+hW0WbBhXvZJNqJ4CSTzjP5gQVuBne33XpGpL7/COrBIc54HiLx6ldH88
         e/WaxNoRraSSGuM6tvp18siaS3B/DJ6xOAqSA9HBuzmrvc2RdLQPzYF5Yn+QxoORh095
         SJEoOi4TCLFi/KHVj52dqBzXI2Qioak5cq38zDJogGOtj/rPYmu01zE5wXYPpVvTXKtb
         o2yg==
X-Gm-Message-State: ACgBeo3V0WRwZPdFBPvGgAZv7JrtEJkvrarkqZt15fAktidFs4+Wf9Sr
        9tWyBZS6z9GK0DU2VdAKCcwi9gFlN5OECwy1nFisxp1pQtIrAj7FeGvieHGghOqRzOaqWGpBMvO
        IYoVMBp6U7d20eOs6g3xU6lcz
X-Received: by 2002:a05:6000:1a42:b0:225:8b5e:e0f8 with SMTP id t2-20020a0560001a4200b002258b5ee0f8mr1160327wry.710.1661507639316;
        Fri, 26 Aug 2022 02:53:59 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7OtQPy8Lm0bdpcz01XQN4p2UT47Y+kVemr6tDelSv1bI7UiNdLH1R+YF0s1vXJMQxqxwNRCg==
X-Received: by 2002:a05:6000:1a42:b0:225:8b5e:e0f8 with SMTP id t2-20020a0560001a4200b002258b5ee0f8mr1160302wry.710.1661507639072;
        Fri, 26 Aug 2022 02:53:59 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:f600:abad:360:c840:33fa? (p200300cbc708f600abad0360c84033fa.dip0.t-ipconnect.de. [2003:cb:c708:f600:abad:360:c840:33fa])
        by smtp.gmail.com with ESMTPSA id h21-20020a05600c351500b003a60ff7c082sm8338300wmq.15.2022.08.26.02.53.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 02:53:58 -0700 (PDT)
Message-ID: <204b7465-0d30-d305-64fb-60fe46ca1dba@redhat.com>
Date:   Fri, 26 Aug 2022 11:53:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] mm/demotion: Fix kernel error with memory hotplug
Content-Language: en-US
To:     Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org
Cc:     Wei Xu <weixugc@google.com>, Huang Ying <ying.huang@intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>, jvgediya.oss@gmail.com,
        Bharata B Rao <bharata@amd.com>
References: <20220825092019.379069-1-aneesh.kumar@linux.ibm.com>
 <0602b3b4-214f-94b1-61fe-2b2528ff529b@redhat.com>
 <5b0d911b-4cc2-f1ae-b33b-79aca6e3124c@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <5b0d911b-4cc2-f1ae-b33b-79aca6e3124c@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.08.22 14:53, Aneesh Kumar K V wrote:
> On 8/25/22 5:46 PM, David Hildenbrand wrote:
>> On 25.08.22 11:20, Aneesh Kumar K.V wrote:
>>> On memory hot unplug, the kernel removes the node memory type
>>> from the associated memory tier. Use list_del_init instead of
>>> list del such that the same memory type can be added back
>>> to a memory tier on hotplug.
>>>
>>> Without this, we get the below warning and return error on
>>> adding memory type to a new memory tier.
>>>
>>> [   33.596095] ------------[ cut here ]------------
>>> [   33.596099] WARNING: CPU: 3 PID: 667 at mm/memory-tiers.c:115 set_node_memory_tier+0xd6/0x2e0
>>> [   33.596109] Modules linked in: kmem
>>>
>>> ...
>>>
>>> [   33.596126] RIP: 0010:set_node_memory_tier+0xd6/0x2e0
>>>
>>> ....
>>> [   33.596196]  memtier_hotplug_callback+0x48/0x68
>>> [   33.596204]  blocking_notifier_call_chain+0x80/0xc0
>>> [   33.596211]  online_pages+0x25e/0x280
>>> [   33.596218]  memory_block_change_state+0x176/0x1f0
>>> [   33.596225]  memory_subsys_online+0x37/0x40
>>> [   33.596230]  online_store+0x9b/0x130
>>> [   33.596236]  kernfs_fop_write_iter+0x128/0x1b0
>>> [   33.596242]  vfs_write+0x24b/0x2c0
>>> [   33.596249]  ksys_write+0x74/0xe0
>>> [   33.596254]  do_syscall_64+0x43/0x90
>>> [   33.596259]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>>
>>> Fixes: mm/demotion: Add hotplug callbacks to handle new numa node onlined
>>
>> Do we have a proper 12-digit commit id as well?
>>
>> Do we have to cc stable?
>>
> 
> That patch is not yet merged upstream. It is in mm-unstable. I guess Andrew can fold the change
> into the original patch?
> 

Please make that clearer next time somehow -- either via "[PATCH
mm-unstable]" or just by stating "Andrew, please squash this into XYZ".

I know, akpm headquarter tracks all pending patches, but for other
reviewers this really helps to figure out how urgent this is and where
this applies to (+ saves time).


-- 
Thanks,

David / dhildenb

