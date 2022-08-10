Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78C3058E8CB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 10:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbiHJIce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 04:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbiHJIcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 04:32:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D907F57245
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 01:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660120351;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XGNRL7RXjtq0mKAACNMvTHAR+zCxpXxi84pe8w824HU=;
        b=HF1+lNP2XWhzgvVjc6xIZGWk2QQi2yH+clbVDIQ7hMOTdf9bhQ70T5Bw+3AfE/J+1DO2W4
        cuwie8q0oAs3i065Y7Fcka/xgCtW978pUrRaq4KMoG/vjGMnTiisgl/plwen3GiE1Blp3D
        UPNSJC8TrUydrTGPig0TBZDz3UEawz0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-37-Gt-AURWtPx2OXqEtZWhTjQ-1; Wed, 10 Aug 2022 04:32:29 -0400
X-MC-Unique: Gt-AURWtPx2OXqEtZWhTjQ-1
Received: by mail-wm1-f71.google.com with SMTP id m4-20020a7bce04000000b003a386063752so322165wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 01:32:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=XGNRL7RXjtq0mKAACNMvTHAR+zCxpXxi84pe8w824HU=;
        b=ygaSjx0rMllkfIPKLZk2tRm+bk1m+kSK611lbah+H2ALhQFPcw7n3mcI0AGCDvYKcU
         /s/CfbLa/Q2C1V/oWnMHORE94iAK9VpJRRolJ/cvlNuXa42KFgRRx5ec4cunaLIFgPU6
         I2MWU3nPVSxCa1wvjBovqvcf0TpKtmDC7k2tjHC7tm7UPLfW2Uum1ZZbsELVc7RZJxu+
         DcxYyHv4bwnSht3NiQWki/jpVtnn79YtAJgww2FbNmXRTUVTivZVhozYCLti39uC1SW7
         7nEU/tBf3gpbqLYQ7z9mDGd1SQFbkEg7fyOh3T2p7OPsO2Q9TBqKy16/nOAMcRn52qTv
         z5iQ==
X-Gm-Message-State: ACgBeo3RLU4Omxl4eBZucSR8sa8yoBoDWB0lND0uKCfX/g18glGwHf8k
        iN+sbmtYX3FyGpCPEmkaDTkVIXTFyx3T8tH+gSDczUasKARMy9Do380dOBwHYsweIHjclSkdOum
        Y/Bg9PmbnsuvacSeg6RFb5ZHM
X-Received: by 2002:a05:600c:4e03:b0:3a5:1755:8498 with SMTP id b3-20020a05600c4e0300b003a517558498mr1619494wmq.137.1660120348459;
        Wed, 10 Aug 2022 01:32:28 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5qxjbgUdwuQgliLtypD01fweSDVzMfPiufIkKAYAH4GBeQyjU+/MsIMI+BYxf4zmWEP/Y+2w==
X-Received: by 2002:a05:600c:4e03:b0:3a5:1755:8498 with SMTP id b3-20020a05600c4e0300b003a517558498mr1619476wmq.137.1660120348253;
        Wed, 10 Aug 2022 01:32:28 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:1600:a3ce:b459:ef57:7b93? (p200300cbc7071600a3ceb459ef577b93.dip0.t-ipconnect.de. [2003:cb:c707:1600:a3ce:b459:ef57:7b93])
        by smtp.gmail.com with ESMTPSA id p13-20020a05600c358d00b003a4c6e67f01sm1552735wmq.6.2022.08.10.01.32.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Aug 2022 01:32:27 -0700 (PDT)
Message-ID: <f3da23f5-950a-9569-20b3-f7d4779a69f7@redhat.com>
Date:   Wed, 10 Aug 2022 10:32:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] mm: add warning if __vm_enough_memory fails
Content-Language: en-US
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Yongqiang Liu <liuyongqiang13@huawei.com>
References: <20220726145428.8030-1-wangkefeng.wang@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220726145428.8030-1-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.07.22 16:54, Kefeng Wang wrote:
> If a process has no enough memory to allocate a new virtual mapping, we
> may meet kinds of error, eg, fork cannot allocate memory, SIGBUS error
> in shmem, but it is difficult to confirm them, let's add some debug
> information to easy to check this scenario if __vm_enough_memory fails.
> 
> Reported-by: Yongqiang Liu <liuyongqiang13@huawei.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
> v2: use pr_warn_ratelimited, suggested by David Hildenbrand
> 
>  mm/util.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/util.c b/mm/util.c
> index 1266a33a49ea..c786e21c6051 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -1020,6 +1020,8 @@ int __vm_enough_memory(struct mm_struct *mm, long pages, int cap_sys_admin)
>  	if (percpu_counter_read_positive(&vm_committed_as) < allowed)
>  		return 0;
>  error:
> +	pr_warn_ratelimited("%s: pid: %d, comm: %s, no enough memory for the allocation\n",
> +			    __func__, current->pid, current->comm);
>  	vm_unacct_memory(pages);
>  
>  	return -ENOMEM;

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

