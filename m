Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0F850660A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 09:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349449AbiDSHjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 03:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235388AbiDSHjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 03:39:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 125EA22BEF
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650353829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FM4KVGRiRcud5YspVdmyurfb+munCUhUXXDotfhbDB4=;
        b=SIHmfyy2BUMcDlOsCsHPu0UwKyZtQr1HVOwHU726raPdeDshITMujIfmObDGqA8GNz2A7c
        U0tWJpY1g+eUaa+Wxulw3iRoonnMygW25G7yPTgckuWofb7ogNAknmexAZZBAOr8p+cgc1
        wXf8v3jzjC4j9VVVLl1Gk14j1kUPVC8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-460-H1QKa6VxOAW14XRE9YeHKQ-1; Tue, 19 Apr 2022 03:37:06 -0400
X-MC-Unique: H1QKa6VxOAW14XRE9YeHKQ-1
Received: by mail-ed1-f70.google.com with SMTP id da8-20020a056402176800b0041d79488e29so10390262edb.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:37:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=FM4KVGRiRcud5YspVdmyurfb+munCUhUXXDotfhbDB4=;
        b=IbSXy5EOIjMA0vvUKi7SU8uE+s8s0RRQMI2dgwMOzlJDFpar1sUlHgxOoRKW9uMnsw
         AcKwUFkgkrLrp6n77ohiSPCHY8U1wJBS7rwgtZmvBD9H5zIiX90Q0dmSVeTstreX+LGc
         TwQCiJQOerW0lw/8PVilMCPItlAYTUUci/P+OHb62rscrKPayU9h+7+QFsPO466mde07
         Dc2OdTomciVpwkSSLHhmkGWNRKmU8zdbkKncy+P+aaBgkrDMed5hwgDKUt/zODM5Ufkj
         8SA1kXbhGgNWbvoFZllGt86QqRV0JaN4ql3sojORAu955BwLIIp9EVh4m1KbM0+WQkiY
         WsfA==
X-Gm-Message-State: AOAM530csb0vdsw93ehnBQVTnsE1EU3Tuuta6JDyLStamEDiKFdhfxry
        hUiHX9qrXYbTbA5Y/8zQJmOLvVCuKEBOL2IUTSXuvdiaHhSawHtL8M83yRiQONLNEpPSMnot0aL
        gX7qwMS16fJANcWlv3uzxpLj9
X-Received: by 2002:a17:907:2cc7:b0:6df:b76d:940d with SMTP id hg7-20020a1709072cc700b006dfb76d940dmr12199063ejc.742.1650353823736;
        Tue, 19 Apr 2022 00:37:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw3hG/W1nT/V3lbt+DapwBobEev6m6WKfqd6rBDyvMyzO4s4Jf3Z9XJXBOz1X7nb8ywMLE6pw==
X-Received: by 2002:a17:907:2cc7:b0:6df:b76d:940d with SMTP id hg7-20020a1709072cc700b006dfb76d940dmr12199035ejc.742.1650353823437;
        Tue, 19 Apr 2022 00:37:03 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:5d00:d8c2:fbf6:a608:957a? (p200300cbc7045d00d8c2fbf6a608957a.dip0.t-ipconnect.de. [2003:cb:c704:5d00:d8c2:fbf6:a608:957a])
        by smtp.gmail.com with ESMTPSA id p9-20020a05640243c900b0041facb9ac9esm7805598edc.1.2022.04.19.00.37.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 00:37:02 -0700 (PDT)
Message-ID: <b57fea1e-5c9b-f47e-f565-16b54f1e8782@redhat.com>
Date:   Tue, 19 Apr 2022 09:37:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v2] mm/swapfile: unuse_pte can map random data if swap
 read fails
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     willy@infradead.org, vbabka@suse.cz, dhowells@redhat.com,
        neilb@suse.de, apopple@nvidia.com, surenb@google.com,
        minchan@kernel.org, peterx@redhat.com, sfr@canb.auug.org.au,
        rcampbell@nvidia.com, naoya.horiguchi@nec.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220416030549.60559-1-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220416030549.60559-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.04.22 05:05, Miaohe Lin wrote:
> There is a bug in unuse_pte(): when swap page happens to be unreadable,
> page filled with random data is mapped into user address space. In case
> of error, a special swap entry indicating swap read fails is set to the
> page table. So the swapcache page can be freed and the user won't end up
> with a permanently mounted swap because a sector is bad. And if the page
> is accessed later, the user process will be killed so that corrupted data
> is never consumed. On the other hand, if the page is never accessed, the
> user won't even notice it.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
> v2:
>   use special swap entry to avoid permanently mounted swap
>   free the bad page in swapcache
> ---
>  include/linux/swap.h    |  7 ++++++-
>  include/linux/swapops.h | 10 ++++++++++
>  mm/memory.c             |  5 ++++-
>  mm/swapfile.c           | 11 +++++++++++
>  4 files changed, 31 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index d112434f85df..03c576111737 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -55,6 +55,10 @@ static inline int current_is_kswapd(void)
>   * actions on faults.
>   */
>  
> +#define SWAP_READ_ERROR_NUM 1
> +#define SWAP_READ_ERROR     (MAX_SWAPFILES + SWP_HWPOISON_NUM + \
> +			     SWP_MIGRATION_NUM + SWP_DEVICE_NUM + \
> +			     SWP_PTE_MARKER_NUM)

Does anything speak against reusing the hwpoison marker? At least from a
program POV it's similar "the previously well defined content at this
user space address is no longer readable/writable".

I recall that we can just set the pfn to 0 for the hwpoison marker.

There is e.g., check_hwpoisoned_entry() and it just stops if it finds
"pfn=0".


-- 
Thanks,

David / dhildenb

