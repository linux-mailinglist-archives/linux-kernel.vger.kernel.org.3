Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E96B8524886
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 11:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351759AbiELJEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 05:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235555AbiELJEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 05:04:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1D5301C06F4
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 02:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652346271;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6sQcqAYa2g0Ny9nhwKlQtaEoOvA7oM/vQxwpgMFwV6g=;
        b=PKDtcEXQ62DlV/wQKZO8HekyUTkcJqxf7VZs8Ybx7vUG20v26xBhlFtGZ7dXKfpxIf08dM
        3e0APVgdON/D4Z0Z2aaf8A3A2wHQY4kCwSkqWr8OMX9+BUaaHz9+IK0WIz0PAoWvT7bEvP
        xmOu7HrrmPGkZTpsUgaRmPvfH/cSXnM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-112-WgA30_ZxPHGX_O4rfh-L1Q-1; Thu, 12 May 2022 05:04:27 -0400
X-MC-Unique: WgA30_ZxPHGX_O4rfh-L1Q-1
Received: by mail-wm1-f70.google.com with SMTP id 205-20020a1c02d6000000b003928cd3853aso4101166wmc.9
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 02:04:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=6sQcqAYa2g0Ny9nhwKlQtaEoOvA7oM/vQxwpgMFwV6g=;
        b=rbCT94skQw2wsrso8Vt0rmcqhfeXp8022v367+pyk002vkrbLlpmbL1LOVRZ1EJsnd
         SK5UAiTzLuoxTURCgyMNpyguCTh0l/y4at6j6yM+7CEn2kXz8FDFNNCs6TO+bpQaM/QO
         S/It+Fu9VS6+1h4B17amSyuxJh301z+IThGNMhD2vzzj9KZlnsgPs8ly4XHCysXW8dpx
         Qy7YUdTcB2c4fudTAb1tjoPoGT6OJY0++bxy/qmNw6zQWNfUyFxr4FtTeDM0a5yI/OaR
         Nmpc2ABW1wiieDOOS8lZxzxsjuYQIVPpLlr+NMpw1D4bngAvGX1MJkArzA7+vHuR9Amb
         tAKg==
X-Gm-Message-State: AOAM530fZB/w28bCdc4aPHbGy5AgiL7mN8AUsqu+hZ8t1gMQtkaggP+o
        hVGOglU4VGcbJ4t769XI+l1gYpLqDvny/FxjucYSNKD4LQbStdpXyFU/D+n215jUGBrpKoMXAOu
        IRCWNRm4jGfzN7R/PoNEpMc3l
X-Received: by 2002:a05:600c:1d9f:b0:394:7a51:cb8b with SMTP id p31-20020a05600c1d9f00b003947a51cb8bmr9020115wms.163.1652346266043;
        Thu, 12 May 2022 02:04:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzp1ISu6PPULzoE8l/q8W72KZf8BfW97byHFvPuiQThQtQpRsNu88feZLxked2oo9eyxI7NOw==
X-Received: by 2002:a05:600c:1d9f:b0:394:7a51:cb8b with SMTP id p31-20020a05600c1d9f00b003947a51cb8bmr9020083wms.163.1652346265761;
        Thu, 12 May 2022 02:04:25 -0700 (PDT)
Received: from ?IPV6:2003:cb:c701:d200:ee5d:1275:f171:136d? (p200300cbc701d200ee5d1275f171136d.dip0.t-ipconnect.de. [2003:cb:c701:d200:ee5d:1275:f171:136d])
        by smtp.gmail.com with ESMTPSA id v3-20020a05600c428300b00394867d66ddsm1931393wmc.35.2022.05.12.02.04.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 02:04:25 -0700 (PDT)
Message-ID: <8f2af450-1080-2dcd-9c85-6190e7e14f27@redhat.com>
Date:   Thu, 12 May 2022 11:04:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] x86/mm: Fix marking of unused sub-pmd ranges
Content-Language: en-US
To:     Adrian-Ken Rueegsegger <ken@codelabs.ch>,
        dave.hansen@linux.intel.com, osalvador@suse.de
Cc:     luto@kernel.org, peterz@infradead.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20220509090637.24152-1-ken@codelabs.ch>
 <20220509090637.24152-2-ken@codelabs.ch>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220509090637.24152-2-ken@codelabs.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.05.22 11:06, Adrian-Ken Rueegsegger wrote:
> The unused part precedes the new range spanned by the start, end
> parameters of vmemmap_use_new_sub_pmd. This means it actually goes from
> ALIGN_DOWN(start, PMD_SIZE) up to start. Use the correct address when
> applying the mark using memset.
> 
> Fixes: 8d400913c231 ("x86/vmemmap: handle unpopulated sub-pmd ranges")
> Signed-off-by: Adrian-Ken Rueegsegger <ken@codelabs.ch>
> ---
>  arch/x86/mm/init_64.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> index 96d34ebb20a9..e2942335d143 100644
> --- a/arch/x86/mm/init_64.c
> +++ b/arch/x86/mm/init_64.c
> @@ -902,6 +902,8 @@ static void __meminit vmemmap_use_sub_pmd(unsigned long start, unsigned long end
>  
>  static void __meminit vmemmap_use_new_sub_pmd(unsigned long start, unsigned long end)
>  {
> +	const unsigned long page = ALIGN_DOWN(start, PMD_SIZE);
> +
>  	vmemmap_flush_unused_pmd();
>  
>  	/*
> @@ -914,8 +916,7 @@ static void __meminit vmemmap_use_new_sub_pmd(unsigned long start, unsigned long
>  	 * Mark with PAGE_UNUSED the unused parts of the new memmap range
>  	 */
>  	if (!IS_ALIGNED(start, PMD_SIZE))
> -		memset((void *)start, PAGE_UNUSED,
> -			start - ALIGN_DOWN(start, PMD_SIZE));
> +		memset((void *)page, PAGE_UNUSED, start - page);
>  
>  	/*
>  	 * We want to avoid memset(PAGE_UNUSED) when populating the vmemmap of

As the x86 code was based on my s390x code, I assume that this was
accidentally introduced in the x86 variant.


We'd be marking the wrong range PAGE_UNUSED.


Your fix looks correct to me:

Reviewed-by: David Hildenbrand <david@redhat.com>


Do we want to cc stable?

-- 
Thanks,

David / dhildenb

