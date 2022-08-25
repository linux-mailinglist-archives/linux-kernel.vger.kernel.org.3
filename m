Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC0B5A1026
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 14:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241452AbiHYMQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 08:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241090AbiHYMQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 08:16:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68CCAABF31
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 05:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661429806;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=50JDuznIcplANtCCRHF9PDcl3HjI31bAhYxaYQTlejM=;
        b=alLqyo/KOOS2Efd49QXlSmy+YbqkWXr6VvAsbCfXeyxYJjenjSyicX3dlQIRarem0PJdyh
        BLBNrO8qGuX4NdrGS3T7cdVLT25bNLtKsWYjegQ1PiElNW5ScGanEFYKEG1/a4bZFMI6J7
        gMqUCF6aE3/mEKkOokyG7NpF8uZfoxA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-468-sBdoXtwBNLm0EjdZnrFT3A-1; Thu, 25 Aug 2022 08:16:45 -0400
X-MC-Unique: sBdoXtwBNLm0EjdZnrFT3A-1
Received: by mail-wr1-f70.google.com with SMTP id j4-20020adfa544000000b002255264474bso2185098wrb.17
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 05:16:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=50JDuznIcplANtCCRHF9PDcl3HjI31bAhYxaYQTlejM=;
        b=Ee0BaQ5SLz1dPSvTENCf9IPHgrRFDpT4NjXotplzbF4n0Lkt+774MR4CaCkB/B+xud
         rb9TfrOSQdJOboGvhrwV2Qm0BZnQ/FjO13lmQSKs1BE5kbFsEEAkJNAMDsSBppD2OmLA
         mLQnM2eFYm0TBSpBvSG6QJ+272IVGyEgFr/rv+ed05wXHPRbTkY5DLk79JfPHGInwm9T
         iAhsygGpJNiN8UdqjuJ52f6ws3CwIFc0BnRBUVEamANQXIALB1/rBk56/e1MoNc4i0M7
         hraUjZveWVwqHEYrYgOqyfeYxjhITr7wDQ/NVwmQP+Kz8SmV2cnvNqeBT47xv58virIc
         bvTA==
X-Gm-Message-State: ACgBeo2SplX3ahJrIRITfN8SJ4widw1bk7PNP7/7hdaJfnFDbUyMAqDW
        rS6dpyb1yRsvnBnkJTlo5zsyebNvExkggTAsqnGjBc0lz4WKDVgbAIsfUBWF+owNRTiyrtnBW2E
        dMxgq+RRpvSWR5g8ws7NYz0ie
X-Received: by 2002:a05:600c:2248:b0:3a5:a469:b874 with SMTP id a8-20020a05600c224800b003a5a469b874mr7854877wmm.63.1661429803951;
        Thu, 25 Aug 2022 05:16:43 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4yMHS2Da8W3+l7WwcSWgXKwX1JSRL+OG+2q/EzEzRgH4HIZaKuOe2rXsQHEmuVi0vDa73wHQ==
X-Received: by 2002:a05:600c:2248:b0:3a5:a469:b874 with SMTP id a8-20020a05600c224800b003a5a469b874mr7854850wmm.63.1661429803698;
        Thu, 25 Aug 2022 05:16:43 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:20af:34be:985b:b6c8? ([2a09:80c0:192:0:20af:34be:985b:b6c8])
        by smtp.gmail.com with ESMTPSA id l6-20020a05600c4f0600b003a690f704absm4718162wmq.4.2022.08.25.05.16.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 05:16:43 -0700 (PDT)
Message-ID: <0602b3b4-214f-94b1-61fe-2b2528ff529b@redhat.com>
Date:   Thu, 25 Aug 2022 14:16:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] mm/demotion: Fix kernel error with memory hotplug
Content-Language: en-US
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linux-mm@kvack.org, akpm@linux-foundation.org
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220825092019.379069-1-aneesh.kumar@linux.ibm.com>
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

On 25.08.22 11:20, Aneesh Kumar K.V wrote:
> On memory hot unplug, the kernel removes the node memory type
> from the associated memory tier. Use list_del_init instead of
> list del such that the same memory type can be added back
> to a memory tier on hotplug.
> 
> Without this, we get the below warning and return error on
> adding memory type to a new memory tier.
> 
> [   33.596095] ------------[ cut here ]------------
> [   33.596099] WARNING: CPU: 3 PID: 667 at mm/memory-tiers.c:115 set_node_memory_tier+0xd6/0x2e0
> [   33.596109] Modules linked in: kmem
> 
> ...
> 
> [   33.596126] RIP: 0010:set_node_memory_tier+0xd6/0x2e0
> 
> ....
> [   33.596196]  memtier_hotplug_callback+0x48/0x68
> [   33.596204]  blocking_notifier_call_chain+0x80/0xc0
> [   33.596211]  online_pages+0x25e/0x280
> [   33.596218]  memory_block_change_state+0x176/0x1f0
> [   33.596225]  memory_subsys_online+0x37/0x40
> [   33.596230]  online_store+0x9b/0x130
> [   33.596236]  kernfs_fop_write_iter+0x128/0x1b0
> [   33.596242]  vfs_write+0x24b/0x2c0
> [   33.596249]  ksys_write+0x74/0xe0
> [   33.596254]  do_syscall_64+0x43/0x90
> [   33.596259]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> Fixes: mm/demotion: Add hotplug callbacks to handle new numa node onlined

Do we have a proper 12-digit commit id as well?

Do we have to cc stable?

> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>  mm/memory-tiers.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
> index a20795bb0e07..ba844fe9cc8c 100644
> --- a/mm/memory-tiers.c
> +++ b/mm/memory-tiers.c
> @@ -451,7 +451,7 @@ static bool clear_node_memory_tier(int node)
>  		memtype = node_memory_types[node];
>  		node_clear(node, memtype->nodes);
>  		if (nodes_empty(memtype->nodes)) {
> -			list_del(&memtype->tier_sibiling);
> +			list_del_init(&memtype->tier_sibiling);
>  			if (list_empty(&memtier->memory_types))
>  				destroy_memory_tier(memtier);
>  		}


-- 
Thanks,

David / dhildenb

