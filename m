Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE914E992F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 16:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243735AbiC1OSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 10:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243731AbiC1OSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 10:18:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AD48B2C642
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 07:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648477008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B4R1I/hCcAQyQZ62VKidYDJvIMBja7RGHE6ljlNOv9w=;
        b=HNXL1DOmjO7jQtIdsLaAPORm6oxNB9jfl0EZe8qs9CkD4qDxDG44Zif5hPMq6zskVqZzVq
        WJantjtfepWCnzf+JWUqgvqWol91WfnoS1cxFq+OVdMdGWmagOhnd6wXWCJ+5Rb4DLSt2U
        Ik2xjigdWEVYs91Gk3YBQHEuHSIL+Fw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-397-BEclIUC2OhKpyJh01xPkfw-1; Mon, 28 Mar 2022 10:16:47 -0400
X-MC-Unique: BEclIUC2OhKpyJh01xPkfw-1
Received: by mail-wr1-f70.google.com with SMTP id a17-20020a5d6cb1000000b00203f85a2ed9so4375634wra.7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 07:16:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=B4R1I/hCcAQyQZ62VKidYDJvIMBja7RGHE6ljlNOv9w=;
        b=yz2Ok2ZMQzwsqUrKSjdjJ65Dbbvy4ZsEejtonCpgWn2Fds7fRRaxIQdYBh/t6r+Owu
         6d9vz7U/r/Uc6SyYd1V5KWZ5qc0apsC+Y5CnpbTpLf8SanYpom56I5yxfsmiJ3mWu6Xu
         2AIhTMUC/IYYaKuzRFgl538JXjVH+mat+QBXw4UddPnOlgDEJ1HnGPopjlpwSDWKsMSn
         4D0A6/JMdRJ4BKojZA4FsjB6cz2XpNrlKPouJntqKFLkZ/kP+R2f6ji77ZiT2mqz45ht
         5QBEMfKY/+vY9VF8rCgA9G4bTM4j8/ptn5Xjrxw5dRLC1moB1Byi4Jqh6JSX7PJQCzn4
         SDJw==
X-Gm-Message-State: AOAM531r47R50S/89RlbCvaYwSuVp9/F9rF2unDqmE3TDOfM+duPIbRb
        AFwz5Oo6FhIy/SkqjpIor8DVAEGyUiqJp8Hwn5nc0yKeK8TS8t5dCT2d3vGgOIpHItJshch0iEn
        ryGaOepy5LDjnPP1nX+hI1gc9
X-Received: by 2002:a05:600c:4f10:b0:38c:ae36:d305 with SMTP id l16-20020a05600c4f1000b0038cae36d305mr36616795wmq.34.1648477006082;
        Mon, 28 Mar 2022 07:16:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzM/wkx2pd1yQoAPHFS3vBpvM7gEfUh55GK9MMKNDNabHDPAdxAyQh1rCMVvya/5AbYTk3taw==
X-Received: by 2002:a05:600c:4f10:b0:38c:ae36:d305 with SMTP id l16-20020a05600c4f1000b0038cae36d305mr36616748wmq.34.1648477005630;
        Mon, 28 Mar 2022 07:16:45 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:2200:50d1:ff5c:5927:203a? (p200300cbc704220050d1ff5c5927203a.dip0.t-ipconnect.de. [2003:cb:c704:2200:50d1:ff5c:5927:203a])
        by smtp.gmail.com with ESMTPSA id 3-20020a5d47a3000000b0020412ba45f6sm14367828wrb.8.2022.03.28.07.16.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Mar 2022 07:16:40 -0700 (PDT)
Message-ID: <02a7f297-b9fd-1c32-b4ea-92779dfe56ab@redhat.com>
Date:   Mon, 28 Mar 2022 16:16:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] mm/memcg: remove unneeded nr_scanned
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, hannes@cmpxchg.org,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        akpm@linux-foundation.org
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220328114144.53389-1-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220328114144.53389-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.03.22 13:41, Miaohe Lin wrote:
> The local variable nr_scanned is unneeded as mem_cgroup_soft_reclaim always
> does *total_scanned += nr_scanned. So we can pass total_scanned directly to
> the mem_cgroup_soft_reclaim to simplify the code and save some cpu cycles
> of adding nr_scanned to total_scanned.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/memcontrol.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index b686ec4f42c6..79341365ec90 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3384,7 +3384,6 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
>  	int loop = 0;
>  	struct mem_cgroup_tree_per_node *mctz;
>  	unsigned long excess;
> -	unsigned long nr_scanned;
>  
>  	if (order > 0)
>  		return 0;
> @@ -3412,11 +3411,9 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
>  		if (!mz)
>  			break;
>  
> -		nr_scanned = 0;
>  		reclaimed = mem_cgroup_soft_reclaim(mz->memcg, pgdat,
> -						    gfp_mask, &nr_scanned);
> +						    gfp_mask, total_scanned);
>  		nr_reclaimed += reclaimed;
> -		*total_scanned += nr_scanned;
>  		spin_lock_irq(&mctz->lock);
>  		__mem_cgroup_remove_exceeded(mz, mctz);
>  

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

