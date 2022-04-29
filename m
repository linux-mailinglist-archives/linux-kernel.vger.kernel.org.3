Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 497A6514610
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 11:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357113AbiD2J6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 05:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347684AbiD2J57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 05:57:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BC9F869CF8
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 02:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651226080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=taFIyfF8aQ8L/XDSdTbfsKUW0s/xVxGlxL7GYD+pc+4=;
        b=hchFIvGbBSbiIGtFOkYRtZoo4yhegZvKRWUbUInHQmyH+qHyp5la8XCQ9HdIK/SX5bfH9e
        IUg2VHAFGaanCZB95be4Pla2vg7FHD6QYBCLO6XeQNvJc3Rj3XrXH45QSGhOvEeZUGBvvo
        re7N/tYeApclYBZiLjG/3NOJlJDW1wo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-630-38f76S8wMWiqblgdFxz3Jw-1; Fri, 29 Apr 2022 05:54:39 -0400
X-MC-Unique: 38f76S8wMWiqblgdFxz3Jw-1
Received: by mail-wr1-f72.google.com with SMTP id l7-20020adfa387000000b0020acc61dbaeso2897691wrb.7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 02:54:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=taFIyfF8aQ8L/XDSdTbfsKUW0s/xVxGlxL7GYD+pc+4=;
        b=7YMQeof9FF76hjL5tVC+xb1mIPdpqB5bFK4VzpCM0Mavs2wR3QVFu3feP9Cln8uvBO
         yfb++5+9maywEmoDQdWJpEEPJuNFgqOqnMqL7ec8tc0T54ezkIQiQ/xqy+hi7erw7Tnv
         X1hNUXY+YKCFcDYs/QZfl6f0iIu/ePImCImpufwONcQ/NPYfk+Prl5EPNBd1MaOn6ZS+
         +5ThKms5a/NkaBVL75sy0fs52DO6FkL/IOtb0/yAx8qI/47P3xBdLtGF5xFd5Cdv6C0i
         wE727ApZ6rFpGcZHzvg8E5jFnNMpcweUKu1NUc4HnfIX2q6aZacZHu6gKl8R7sramBxV
         /YjQ==
X-Gm-Message-State: AOAM532ZxlrOr7aUA4fYru52sXXpZgKC8Ptz6KmLIxEHxbfsHj9pxAZ4
        SDWXS2cK8iLKX3fsa7ZV2bbf9lxiFlIAsb8Mmn/TReQHWr20XD+9/7riARiqX9n5z4w02p04of3
        WRCQSP7TtngC1SAZEJ0GXSeV4
X-Received: by 2002:a05:600c:1e85:b0:391:ca59:76be with SMTP id be5-20020a05600c1e8500b00391ca5976bemr2386605wmb.184.1651226078098;
        Fri, 29 Apr 2022 02:54:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxyuz74y5fMW0AcrjTHiajh/StenTy5kkz2aFzsCAM/mvBiSzOFfrIe3mpO9zSvUfJEwurviA==
X-Received: by 2002:a05:600c:1e85:b0:391:ca59:76be with SMTP id be5-20020a05600c1e8500b00391ca5976bemr2386577wmb.184.1651226077822;
        Fri, 29 Apr 2022 02:54:37 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:fe00:bbeb:98e6:617a:dea1? (p200300cbc707fe00bbeb98e6617adea1.dip0.t-ipconnect.de. [2003:cb:c707:fe00:bbeb:98e6:617a:dea1])
        by smtp.gmail.com with ESMTPSA id bi7-20020a05600c3d8700b0038eb78569aasm5961159wmb.20.2022.04.29.02.54.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 02:54:37 -0700 (PDT)
Message-ID: <eeda05fb-b0bb-3e1d-37e0-0021dd72e144@redhat.com>
Date:   Fri, 29 Apr 2022 11:54:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v2 1/4] mm/migration: reduce the rcu lock duration
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, naoya.horiguchi@nec.com
Cc:     ying.huang@intel.com, hch@lst.de, dhowells@redhat.com,
        cl@linux.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220425132723.34824-1-linmiaohe@huawei.com>
 <20220425132723.34824-2-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220425132723.34824-2-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.04.22 15:27, Miaohe Lin wrote:
> rcu_read_lock is required by grabbing the task refcount but it's not
> needed for ptrace_may_access. So we could release the rcu lock after
> task refcount is successfully grabbed to reduce the rcu holding time.
> 
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Christoph Lameter <cl@linux.com>
> ---
>  mm/migrate.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index b2678279eb43..b779646665fe 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1902,17 +1902,16 @@ static struct mm_struct *find_mm_struct(pid_t pid, nodemask_t *mem_nodes)
>  		return ERR_PTR(-ESRCH);
>  	}
>  	get_task_struct(task);
> +	rcu_read_unlock();
>  
>  	/*
>  	 * Check if this process has the right to modify the specified
>  	 * process. Use the regular "ptrace_may_access()" checks.
>  	 */
>  	if (!ptrace_may_access(task, PTRACE_MODE_READ_REALCREDS)) {
> -		rcu_read_unlock();
>  		mm = ERR_PTR(-EPERM);
>  		goto out;
>  	}
> -	rcu_read_unlock();
>  
>  	mm = ERR_PTR(security_task_movememory(task));
>  	if (IS_ERR(mm))

Similar pattern in:

mm/mempolicy.c:kernel_migrate_pages()
kernel/futex/syscalls.c:get_robust_list()
kernel/nsproxy.c:validate_nsset()

Exception:

sched/core_sched.c:sched_core_share_pid()


Should we unify -- i.e., adjust the remaining 3 as well?

-- 
Thanks,

David / dhildenb

