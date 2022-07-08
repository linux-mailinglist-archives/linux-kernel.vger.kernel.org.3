Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 993F456B8BD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 13:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237907AbiGHLkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 07:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237509AbiGHLki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 07:40:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7307B24F14
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 04:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657280436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wXQSLj7N0OPVrbql97FSOxJxi1gzgZ5rqCr//cm7fcI=;
        b=ctTYfaJZENyaLzHZGGSUnTypAT5BM65S/TWKanlgrszc+buYAt6BNk8I+2mRKBlKeV7lZS
        eZGUhXqedatkcAkp+e1roOUK+JbDbxgIsb0ksbVXR+2E4K+uD01hyZfWWAIyaMuX5r9hdb
        znOLEN4KdmBiYWQ1c0HBeLqK4kGgbps=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-294-R8C7gWqeOZq481-V6QcY9A-1; Fri, 08 Jul 2022 07:40:35 -0400
X-MC-Unique: R8C7gWqeOZq481-V6QcY9A-1
Received: by mail-wm1-f69.google.com with SMTP id v67-20020a1cac46000000b003a2be9fa09cso3884607wme.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 04:40:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=wXQSLj7N0OPVrbql97FSOxJxi1gzgZ5rqCr//cm7fcI=;
        b=h2k1JNd6ioN5AE3E9JRxu+jr2SUHm9JBzkWIzH2QIJ6+nQ+9D4bApPIxxu/q0vyWBM
         Chele8pndweiX06BuOYz0SLLY6q4c5DvBngNMrqptLQQATOV2uAp4xf8rEKvDnhNeTdX
         BcIhmrvo7rmQKszlO8RYp7LOgztkdK/2C3zARl3MgCDk9ADBsbpTKTES3IQtpDSLgAPT
         e134ZffHV8K/sYSp78rwik5PoG8oMvM640+h6icbeUd+b6yit+62fdiWZNlK2iLrR0IV
         XzGyyyYfbit6m3dQVPB0XhxN/vzTMkdxJ4Y5W0c1ZUGOvmlfpgalwFJgu06nsRSubYy4
         en6w==
X-Gm-Message-State: AJIora/dJoqEMqyPqj2p7U+OVEVIVJmcpfD2F9JnUloczT+ebZpSiYub
        MHO9486Ljxzd0/awtNwltg8wRj904RzB/8jKl/ZQPxvn/5BL4ODcBb+uq9TIPIqWRAoKstrUe5P
        UnOO9suvGHPv8nYtfZo3uVn+v
X-Received: by 2002:a05:600c:3594:b0:3a2:b918:fc99 with SMTP id p20-20020a05600c359400b003a2b918fc99mr10447689wmq.46.1657280434239;
        Fri, 08 Jul 2022 04:40:34 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sleJHiOa+wExrCN0/v8cRomeDekDTZvjWj0FUXinjSVbAalf0ycjKaPNjpP8yzp8DxqMxtlA==
X-Received: by 2002:a05:600c:3594:b0:3a2:b918:fc99 with SMTP id p20-20020a05600c359400b003a2b918fc99mr10447657wmq.46.1657280434013;
        Fri, 08 Jul 2022 04:40:34 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:6300:c44f:789a:59b5:91e9? (p200300cbc7026300c44f789a59b591e9.dip0.t-ipconnect.de. [2003:cb:c702:6300:c44f:789a:59b5:91e9])
        by smtp.gmail.com with ESMTPSA id bh21-20020a05600c3d1500b003a2d6c623f3sm1954808wmb.19.2022.07.08.04.40.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jul 2022 04:40:33 -0700 (PDT)
Message-ID: <b573a9c6-2ee0-20dc-1f28-84d3a81d40a2@redhat.com>
Date:   Fri, 8 Jul 2022 13:40:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] x86/mm/tlb: ignore f->new_tlb_gen when zero
Content-Language: en-US
To:     Nadav Amit <nadav.amit@gmail.com>, linux-kernel@vger.kernel.org,
        Hugh Dickins <hughd@google.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Linux MM <linux-mm@kvack.org>,
        Nadav Amit <namit@vmware.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
References: <20220708003053.158480-1-namit@vmware.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220708003053.158480-1-namit@vmware.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.07.22 02:30, Nadav Amit wrote:
> From: Nadav Amit <namit@vmware.com>
> 
> Commit aa44284960d5 ("x86/mm/tlb: Avoid reading mm_tlb_gen when
> possible") introduced an optimization of skipping the flush if the TLB
> generation that is flushed (as provided in flush_tlb_info) was already
> flushed.
> 
> However, arch_tlbbatch_flush() does not provide any generation in
> flush_tlb_info. As a result, try_to_unmap_one() would not perform any
> TLB flushes.
> 
> Fix it by checking whether f->new_tlb_gen is nonzero. Zero value is
> anyhow is an invalid generation value.
> 
> In addition, add the missing unlikely() and jump to get tracing right.
> 
> Fixes: aa44284960d5 ("x86/mm/tlb: Avoid reading mm_tlb_gen when possible")
> Reported-by: Hugh Dickins <hughd@google.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Nadav Amit <namit@vmware.com>
> ---
>  arch/x86/mm/tlb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
> index d9314cc8b81f..d81b4084bb8a 100644
> --- a/arch/x86/mm/tlb.c
> +++ b/arch/x86/mm/tlb.c
> @@ -771,14 +771,14 @@ static void flush_tlb_func(void *info)
>  		return;
>  	}
>  
> -	if (f->new_tlb_gen <= local_tlb_gen) {
> +	if (unlikely(f->new_tlb_gen != 0 && f->new_tlb_gen <= local_tlb_gen)) {
>  		/*
>  		 * The TLB is already up to date in respect to f->new_tlb_gen.
>  		 * While the core might be still behind mm_tlb_gen, checking
>  		 * mm_tlb_gen unnecessarily would have negative caching effects
>  		 * so avoid it.
>  		 */
> -		return;
> +		goto done;

Does this affect the performance numbers from aa44284960d5 ("x86/mm/tlb:
Avoid reading mm_tlb_gen when possible")?

-- 
Thanks,

David / dhildenb

