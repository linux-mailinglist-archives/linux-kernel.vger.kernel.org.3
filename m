Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E02494AC286
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 16:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244329AbiBGPHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 10:07:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441895AbiBGOqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 09:46:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2C42CC03FEF1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 06:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644245160;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=goUbMo4pjupJNfgiLpXay7HxZsEBzbQy6nHdnUofwtE=;
        b=i7mcWJvRWxXa5zWNLviI3xkMCmkf46w1KxM3q2Y58ATTBT9xN8q0wi60YEXMH0y1gGj15U
        MCq/zX53v1bf+ibsEcJzh2hkaeZ/cDZmQL3GmJYiIy+MUg+ZDt2W2qi36q3/nlBWj2fcCl
        LvOIduL0sYs76ABQmDsqGOn5sryqWyI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-357-k9xNaHDaMxKjp9bzqmV6qw-1; Mon, 07 Feb 2022 09:45:59 -0500
X-MC-Unique: k9xNaHDaMxKjp9bzqmV6qw-1
Received: by mail-wr1-f70.google.com with SMTP id g16-20020adfa490000000b001e30139d1fbso2178326wrb.6
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 06:45:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=goUbMo4pjupJNfgiLpXay7HxZsEBzbQy6nHdnUofwtE=;
        b=PvDPdV1ZE3mEO1ZjfvY9dPdkDw5o2uQUFmOKtcbBPAxQ+HOlopbEDYS4GM0pEhXBc7
         OqCIOgMvG5R+fKc1hzdtFHV7YXn9dcWWBBYBLq3R8xniCII6XLKlytXBDN5OtezBGYxK
         hmGYHAeHlEENaYWw8/p+77Z2f2IpAVRisajddaT0FCK4yqwky23OnFeimmA9iFaKqzIy
         0/VKauSGErOO8yq9OezUpSENbd7W30NzMwQcjU3gDAKc0L7+Insdguh1nLsqZYhGaaMm
         vB3y54q75PjNDFXZLnDD8HtEShu9PQ4i8zSwbTctOTJxg+eVzKQRkVjsHdhmipgaa61k
         VKUg==
X-Gm-Message-State: AOAM533cP0ShJ2lDxh2dv//C3ES2w61uz0SqLsQsLtlTts/fwIC0FC0B
        uUbMxUjxhNvbcgHCf3Ll160yo/ltws4kYRlUYJVdWohxsLCTsFS1FI4d1uIYffWwNVMFVCAv4hs
        bhdt9kOycTRG6iCudFVcO7gWS
X-Received: by 2002:a5d:564a:: with SMTP id j10mr3584882wrw.473.1644245157940;
        Mon, 07 Feb 2022 06:45:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz5CdjL9GsaPE6SSkw6cwOsU8nZRXi8nUiJucgXQJ5gYIfBfGTfnsdMKLHfFj68uvft/N/gMQ==
X-Received: by 2002:a5d:564a:: with SMTP id j10mr3584873wrw.473.1644245157765;
        Mon, 07 Feb 2022 06:45:57 -0800 (PST)
Received: from ?IPV6:2003:cb:c709:6300:a751:d742:1f76:8639? (p200300cbc7096300a751d7421f768639.dip0.t-ipconnect.de. [2003:cb:c709:6300:a751:d742:1f76:8639])
        by smtp.gmail.com with ESMTPSA id r2sm1848405wrt.65.2022.02.07.06.45.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 06:45:57 -0800 (PST)
Message-ID: <1dd210fa-ac44-6da3-d128-add35fba468e@redhat.com>
Date:   Mon, 7 Feb 2022 15:45:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 4/4] mm/memory_hotplug: fix misplaced comment in
 offline_pages
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220207133643.23427-1-linmiaohe@huawei.com>
 <20220207133643.23427-5-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220207133643.23427-5-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.02.22 14:36, Miaohe Lin wrote:
> It's misplaced since commit 7960509329c2 ("mm, memory_hotplug: print reason
> for the offlining failure"). Move it to the right place.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/memory_hotplug.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 4b9eef861ee4..7dc7e12302db 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1966,6 +1966,7 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
>  	return 0;
>  
>  failed_removal_isolated:
> +	/* pushback to free area */
>  	undo_isolate_page_range(start_pfn, end_pfn, MIGRATE_MOVABLE);
>  	memory_notify(MEM_CANCEL_OFFLINE, &arg);
>  failed_removal_pcplists_disabled:
> @@ -1976,7 +1977,6 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
>  		 (unsigned long long) start_pfn << PAGE_SHIFT,
>  		 ((unsigned long long) end_pfn << PAGE_SHIFT) - 1,
>  		 reason);
> -	/* pushback to free area */
>  	mem_hotplug_done();
>  	return ret;
>  }

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

