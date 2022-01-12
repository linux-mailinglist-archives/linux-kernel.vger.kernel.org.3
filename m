Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 093E148C0E8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 10:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349416AbiALJWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 04:22:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:46577 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238292AbiALJWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 04:22:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641979324;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZkMJP6Kct1rran15fCHGX0wTP5ePzlWHQDky7Omxb9c=;
        b=WSkcuCbpKr2Yq92XTW/iizhDEQzxNgSJdoLgS3Zh9CgzLH2004vsUKE4lb8Xn+Yga6RnXE
        Puz20qff351aq+tLhWSORkMPLCILWbjFR7t/J5dSCD5Uc5kWM5uncwrvVMqwOAiBDl5P+q
        qGuDzfLFX8KXexnJkQihP0XuX9zrkhw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-657-WLIuCpP8Mx6Fqg2mGt-JHQ-1; Wed, 12 Jan 2022 04:22:03 -0500
X-MC-Unique: WLIuCpP8Mx6Fqg2mGt-JHQ-1
Received: by mail-ed1-f70.google.com with SMTP id l14-20020aa7cace000000b003f7f8e1cbbdso1682211edt.20
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 01:22:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=ZkMJP6Kct1rran15fCHGX0wTP5ePzlWHQDky7Omxb9c=;
        b=YY1dJYjofZ/LAHxeOQi1Nt3B7fFaHGyE6fpVFhtPJ29jnMSMiDEls+BrNf9FcOnvzQ
         kyeH8rSLJP8eHyTtsxo7r2WuMe+mEAcGk0FzTsEKlAT7FGJv4HaZjsIQnQK1BXgUeGiw
         1kLQkQxagz/NLDIJu8vHQVcVkT6IbdUxXDRUwtZyBUz4bKTKn7vE15MAvRadHHMoPXDF
         lfnddCzxoVSsm3q/I8gD/GllMVCnqQFDLnYs/KbPgn0dnmEt8+ANIN03JpBCLmxqhMvP
         tud9PSkzF80f1uhZ97Eyf6ZETUEYsqD62/YAL59KracF3Elrim9DPr5lqPQdOlp/DgbK
         mFgg==
X-Gm-Message-State: AOAM531vtFiCwEGEJN/T82ppKSWkHvtpHo+O3GB0T3G3Oh60aaToCvGR
        LFjqS6frcTc8T2nNvsZHN1wBJG3aMD6hMnfhI6DpB92ZqCGlGoKfZt3QvdkPpxlkBbpOgS5xeWl
        p5bKhNVGrgtfZa1ZjObFtIZNj
X-Received: by 2002:a17:906:9754:: with SMTP id o20mr5550566ejy.452.1641979322230;
        Wed, 12 Jan 2022 01:22:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyPDWe8+Rv8mGKTnrR5wrymtNU5ulfIG8wkZ/6tOwfne+hNzNx7U1tUD1XD7lB+6xV4pw95CA==
X-Received: by 2002:a17:906:9754:: with SMTP id o20mr5550550ejy.452.1641979321997;
        Wed, 12 Jan 2022 01:22:01 -0800 (PST)
Received: from ?IPV6:2003:cb:c702:4700:e25f:39eb:3cb8:1dec? (p200300cbc7024700e25f39eb3cb81dec.dip0.t-ipconnect.de. [2003:cb:c702:4700:e25f:39eb:3cb8:1dec])
        by smtp.gmail.com with ESMTPSA id d24sm4286245ejd.182.2022.01.12.01.22.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jan 2022 01:22:01 -0800 (PST)
Message-ID: <4cbe2f51-0654-dcfa-cd9c-1b5096cc5394@redhat.com>
Date:   Wed, 12 Jan 2022 10:22:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 2/2] Fix assgining cma_area_count
Content-Language: en-US
To:     Ercan Ersoy <ercanersoy@ercanersoy.net>,
        linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org
References: <775ae3ba4f7034a78769559fa1a3542a@ercanersoy.net>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <775ae3ba4f7034a78769559fa1a3542a@ercanersoy.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.01.22 08:39, Ercan Ersoy wrote:
> 
> I have patched "Contiguous Memory Allocator" of Linux kernel.
> 
> This fix of patch is for cma_init_reserved_mem function in
> mm/cma.c source file as creating area without specific name.
> 
> Without fix may be a problem a lot of cma as next cma2147483647 naming.
> Without fix may be a problem huge memory systems.
> 
> I think after "cma2147483647" naming is "cma-2147483648".
> 
> Thanks for interesting,
> Ercan
> 
> --- START PATCH ---
>  From 5d3d01a3a0f7339617d1df945c0bd0ec1ab91ae3 Mon Sep 17 00:00:00 2001
>  From: Ercan Ersoy <ercanersoy@ercanersoy.net>
> Date: Sun, 9 Jan 2022 10:01:14 +0300
> Subject: [PATCH 2/2] Fix assgining cma_area_count
> 
> Fix assigning to cma->name in cma_init_reserved_mem function
> in mm/cma.c source file.
> 

Honestly, how on earth are we supposed to have that many CMA areas?

It's limited by MAX_CMA_AREAS, which is usually ... 7 or 19.

Calling this a fix is a bit though. This is a cleanup we might not care
too much about.

> Signed-off-by: Ercan Ersoy <ercanersoy@ercanersoy.net>
> ---
>   mm/cma.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/cma.c b/mm/cma.c
> index bc9ca8f3c487..03f01d1f1b57 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -199,7 +199,7 @@ int __init cma_init_reserved_mem(phys_addr_t base, 
> phys_addr_t size,
>   	if (name)
>   		snprintf(cma->name, CMA_MAX_NAME, name);
>   	else
> -		snprintf(cma->name, CMA_MAX_NAME,  "cma%d\n", cma_area_count);
> +		snprintf(cma->name, CMA_MAX_NAME,  "cma%u\n", cma_area_count);
> 
>   	cma->base_pfn = PFN_DOWN(base);
>   	cma->count = size >> PAGE_SHIFT;


-- 
Thanks,

David / dhildenb

