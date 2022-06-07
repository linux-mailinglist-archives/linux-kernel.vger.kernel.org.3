Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 198EA53FEBB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 14:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242511AbiFGMZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 08:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234970AbiFGMZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 08:25:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6F82DF6F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 05:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654604753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mf4QQ8b/9HcGL5J+sznsLy7f+ZtpXa7DM56pD/5wHRY=;
        b=QZdUjLJdDMTedDPRnSLCZ+grDpFvVdwSypmj7uIx9cVEBRr7hGT+/17myGIx6uO0B8y7Xn
        LywoXQgXDR0bV5MFi4oQETG6Uz2zIYBZ5GN9tsSxvay0t7lqSnlT5FdvwlY/mYg0L810Qb
        6SGuJYfLq3w8zcCeRIDg2wtugRo1Z8o=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-527-6M6HgGfEPGSI3eohY6x81Q-1; Tue, 07 Jun 2022 08:25:52 -0400
X-MC-Unique: 6M6HgGfEPGSI3eohY6x81Q-1
Received: by mail-wm1-f72.google.com with SMTP id k32-20020a05600c1ca000b0039c4cf75023so3720187wms.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 05:25:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=Mf4QQ8b/9HcGL5J+sznsLy7f+ZtpXa7DM56pD/5wHRY=;
        b=58N3z6Jt2BSUeBo8IFXqy/lO/GGqk4N31ELAEizaDnAqq/72BdDSUzwlvId8XtpzdT
         Xb3beTDAgA3mAh7HaN4y9T4JZp3p563x8Ann8rH4GhH7SdagyhTlBaHJn9Ikb8RP4ow7
         ioiKU3zIUUQXYaF1z14z2h3OfiSRWZHPaKBG8BJgQBf0Bm83+Vkb7fvyjMm5Yq9ZfCOS
         nfwrPrxWIE1DoykSWTYExFxWSFd88uOil0GPHNTPk/JhVmJ9otuLfA5SAXIuHyDAjDr5
         vFgUrGXzubhrXQHlpgR6c/2gRVlCYt8J6YbaDmuS/OxlOJZxGXzUS1UYm3kRSlwpUUl6
         WkKg==
X-Gm-Message-State: AOAM533/+u59xwXN4Fz+apGst77S3RHQ5S3lkQTYC8b2PPE3Wo/Ywqo9
        EnWdsRgQdn6nl/dZz4Eit6E5JdgGRP7k6UoOhCc16+BXDAY1wNAMuF+izoJGN5TIXNv9Pf//oUr
        S7mGn5uu3HmcQxLri/21l/21/
X-Received: by 2002:a05:600c:190d:b0:394:8241:6454 with SMTP id j13-20020a05600c190d00b0039482416454mr29078090wmq.198.1654604751325;
        Tue, 07 Jun 2022 05:25:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxEuwOaCR67pR222FFFc/vDtB6DVVouzt2vgnHsRtqi2r3pc13yypWYxPfO2mRuKCd4JmPjUQ==
X-Received: by 2002:a05:600c:190d:b0:394:8241:6454 with SMTP id j13-20020a05600c190d00b0039482416454mr29078055wmq.198.1654604751070;
        Tue, 07 Jun 2022 05:25:51 -0700 (PDT)
Received: from ?IPV6:2003:cb:c709:500:4c8d:4886:f874:7b6f? (p200300cbc70905004c8d4886f8747b6f.dip0.t-ipconnect.de. [2003:cb:c709:500:4c8d:4886:f874:7b6f])
        by smtp.gmail.com with ESMTPSA id m19-20020a05600c4f5300b003942a244f2esm26245306wmq.7.2022.06.07.05.25.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 05:25:50 -0700 (PDT)
Message-ID: <b1975f44-2552-a03c-bb6f-1452f1fd99c0@redhat.com>
Date:   Tue, 7 Jun 2022 14:25:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v3 4/6] mm: Demote warning message in vmemmap_verify() to
 debug level
Content-Language: en-US
To:     Wupeng Ma <mawupeng1@huawei.com>, corbet@lwn.net, will@kernel.org,
        ardb@kernel.org, catalin.marinas@arm.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        dvhart@infradead.org, andy@infradead.org, rppt@kernel.org,
        akpm@linux-foundation.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, paulmck@kernel.org,
        keescook@chromium.org, songmuchun@bytedance.com,
        rdunlap@infradead.org, damien.lemoal@opensource.wdc.com,
        swboyd@chromium.org, wei.liu@kernel.org, robin.murphy@arm.com,
        anshuman.khandual@arm.com, thunder.leizhen@huawei.com,
        wangkefeng.wang@huawei.com, gpiccoli@igalia.com,
        chenhuacai@kernel.org, geert@linux-m68k.org, chenzhou10@huawei.com,
        vijayb@linux.microsoft.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org
References: <20220607093805.1354256-1-mawupeng1@huawei.com>
 <20220607093805.1354256-5-mawupeng1@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220607093805.1354256-5-mawupeng1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.06.22 11:38, Wupeng Ma wrote:
> From: Ma Wupeng <mawupeng1@huawei.com>
> 
> For a system only have limited mirrored memory or some numa node without
> mirrored memory, the per node vmemmap page_structs prefer to allocate
> memory from mirrored region, which will lead to vmemmap_verify() in
> vmemmap_populate_basepages() report lots of warning message.
> 
> This patch demote the "potential offnode page_structs" warning messages
> to debug level to avoid a very long print during bootup.
> 
> Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
> ---
>  mm/sparse-vmemmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
> index f4fa61dbbee3..78debdb89eb1 100644
> --- a/mm/sparse-vmemmap.c
> +++ b/mm/sparse-vmemmap.c
> @@ -528,7 +528,7 @@ void __meminit vmemmap_verify(pte_t *pte, int node,
>  	int actual_node = early_pfn_to_nid(pfn);
>  
>  	if (node_distance(actual_node, node) > LOCAL_DISTANCE)
> -		pr_warn("[%lx-%lx] potential offnode page_structs\n",
> +		pr_debug("[%lx-%lx] potential offnode page_structs\n",
>  			start, end - 1);
>  }
>  

This will possibly hide it in environments where this might indeed
indicate performance issues.

What about a pr_warn_once()?

-- 
Thanks,

David / dhildenb

