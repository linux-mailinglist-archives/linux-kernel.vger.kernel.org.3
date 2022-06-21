Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78173552C84
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 10:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347882AbiFUICG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 04:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345745AbiFUICE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 04:02:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E1E8B23BDA
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 01:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655798522;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=odfmvDZicXBGV9BNCqYRut3jKMvFr9kgGN63h8//0S8=;
        b=MzBEkmqP2HR5c1FCbvx2/NFXF/jtQwLT9W+x8Pm97f0lNDgnu5T3YSC1f1/7fWlus7notw
        NpS0V8kjAzgNC2hqEG22IckozvNiss3X2W0s1cKjs5Zo64iB8LLP6Zpjs56889ZVkUbOYi
        NVbExFpGZkVyDSn2yqjGtvJHT5BnWY8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-612-WLTzY7TGOnqnYvRIV1W30w-1; Tue, 21 Jun 2022 04:01:58 -0400
X-MC-Unique: WLTzY7TGOnqnYvRIV1W30w-1
Received: by mail-wm1-f72.google.com with SMTP id j31-20020a05600c1c1f00b0039c481c4664so3995383wms.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 01:01:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=odfmvDZicXBGV9BNCqYRut3jKMvFr9kgGN63h8//0S8=;
        b=M2k/nQsFdvTNXKd1MSt5Kcv/i/YPChbDOa9bPWjToDsmR8rEf02x76/hPreNu1e8Az
         C4qDCNAGYKBljh+V/BBOQMDFfs5yDDoSZKwydR25CkGFkJyA656a5JFQJH7Pr6eqOsmk
         0doMMU1r2/NuwTUuupwKCyO8Etp4orxk7NJcLQy7yT3kikrgbOUz0ls6DmPAWk/CJMoy
         uGF+WKGJUjld0WbRv1wR5JtWN2+R4l2AnnYeapW4Is5vFfBOm5B8hoGAvdkmpcPLsZKW
         XWh9D15gRl42wn7JbwadxF15BTmCJGqU81HRc/G2f24k2SPtQjrTd4dZOSQk000JNJWz
         Lzag==
X-Gm-Message-State: AJIora9tMpCPJPMEuXZiq6vgHdoHF++3xSiwMASZZWSPftg4aYKslNdw
        0wqH0m5GqSToUI33O4U0f89jpZjnqUxeIoUpIQ59e/BfxiybVUux/xAf7GEWOfY/YjPx2iEdE8q
        aCxKbmREvMV+us9OeWTaf1nUx
X-Received: by 2002:adf:dc09:0:b0:218:5f6a:f5db with SMTP id t9-20020adfdc09000000b002185f6af5dbmr26665210wri.480.1655798517535;
        Tue, 21 Jun 2022 01:01:57 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vZNwW8e6Rj6IHQIbhTyUdMFDurbwBo3yfnFs1OTbM2oN9e4yp1wELe2N9RSD7BZybV8QmNuA==
X-Received: by 2002:adf:dc09:0:b0:218:5f6a:f5db with SMTP id t9-20020adfdc09000000b002185f6af5dbmr26665186wri.480.1655798517242;
        Tue, 21 Jun 2022 01:01:57 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f04:2500:cdb0:9b78:d423:43f? (p200300d82f042500cdb09b78d423043f.dip0.t-ipconnect.de. [2003:d8:2f04:2500:cdb0:9b78:d423:43f])
        by smtp.gmail.com with ESMTPSA id y12-20020adff6cc000000b0021126891b05sm14987265wrp.61.2022.06.21.01.01.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jun 2022 01:01:56 -0700 (PDT)
Message-ID: <c45a6850-772e-8d2c-9261-7621f242dbae@redhat.com>
Date:   Tue, 21 Jun 2022 10:01:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] mm: fixup validation of buddy pfn
Content-Language: en-US
To:     Xianting Tian <xianting.tian@linux.alibaba.com>,
        akpm@linux-foundation.org, ziy@nvidia.com
Cc:     guoren@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220621031118.3650529-1-xianting.tian@linux.alibaba.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220621031118.3650529-1-xianting.tian@linux.alibaba.com>
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

On 21.06.22 05:11, Xianting Tian wrote:
> For RISC-V arch the first 2MB RAM could be reserved for opensbi,
> and the arch code may don't create pages for the first 2MB RAM,
> so it would have pfn_base=512 and mem_map began with 512th PFN when
> CONFIG_FLATMEM=y.
> 
> But __find_buddy_pfn algorithm thinks the start PFN 0, it could get
> 0 PFN or less than the pfn_base value, so page_is_buddy() can't
> verify the page whose PFN is 0 ~ 511, actually we don't have valid
> pages for PFN 0 ~ 511.
> 
> Actually, buddy system should not assume Arch cretaed pages for
> reserved memory, Arch may don't know the implied limitation.

Ehm, sorry, no. Archs have to stick to the rules of the buddy, not the
other way around. Why should we add additional overhead to the buddy
just because arch XYZ wants to be special?

If at all, we should fail hard if an arch doesn't play with the rules
and make this a VM_BUG_ON().

> With this patch, we can gurantee a valid buddy no matter what we
> have pages for reserved memory or not.
> 
> Fixes: 8170ac4700d26f65 ("mm: wrap __find_buddy_pfn() with a necessary buddy page validation")
> Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
> ---
>  mm/internal.h | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/internal.h b/mm/internal.h
> index c0f8fbe0445b..0ec446caeb2e 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -322,7 +322,8 @@ __find_buddy_pfn(unsigned long page_pfn, unsigned int order)
>   * The found buddy can be a non PageBuddy, out of @page's zone, or its order is
>   * not the same as @page. The validation is necessary before use it.
>   *
> - * Return: the found buddy page or NULL if not found.
> + * Return: the found buddy page or NULL if not found or NULL if buddy pfn is
> + *         not valid.
>   */
>  static inline struct page *find_buddy_page_pfn(struct page *page,
>  			unsigned long pfn, unsigned int order, unsigned long *buddy_pfn)
> @@ -330,6 +331,9 @@ static inline struct page *find_buddy_page_pfn(struct page *page,
>  	unsigned long __buddy_pfn = __find_buddy_pfn(pfn, order);
>  	struct page *buddy;
>  
> +	if (!pfn_valid(__buddy_pfn))
> +		return NULL;
> +
>  	buddy = page + (__buddy_pfn - pfn);
>  	if (buddy_pfn)
>  		*buddy_pfn = __buddy_pfn;


-- 
Thanks,

David / dhildenb

