Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 364CF53755A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 09:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233136AbiE3GzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 02:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233096AbiE3GzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 02:55:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9829D694B0
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 23:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653893698;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cW5xo99K8NrpbNwecJUSYiEDfaIs12UK7aKWMx8Wt/A=;
        b=crTceKyqzEw8YVTt8ZnDcd57Vg5wk+iRxfx2Z1D5MubTDbm5ZQyCMfochA1NHpt7sjV0OB
        24Aq8tvOqXJyt3QMlxudliOZxMih9vFgnOAJonSwldllO//OlaGdDmVfjKVIbfhgIw7rr5
        3szRgKqbBdtswzB3isDHoq/1ub4ZEAY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-657-e7q_DNl_PGiyfUK6WlRUXw-1; Mon, 30 May 2022 02:54:56 -0400
X-MC-Unique: e7q_DNl_PGiyfUK6WlRUXw-1
Received: by mail-wm1-f70.google.com with SMTP id n18-20020a05600c3b9200b0039746f3d9faso4149173wms.4
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 23:54:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=cW5xo99K8NrpbNwecJUSYiEDfaIs12UK7aKWMx8Wt/A=;
        b=4gxnfPA71vvZn74Yk7P6GttFJoantP/9X0yKYJuNC/gZlM7Z+ZU/o0tIB0gKjAySRP
         ZaRk7aT68yX9PJVLQPk3FIXmlESqQAAu6EjWWMP0vlLQi7fkQ9/eaCD+6qwq2yhTWrJZ
         qQZafXqXCbYU1DsGcBfT5o4YweTxS+zr+F3KGjPaOULUZ8Hxt0SOMgnNY76F9B6vVUE0
         Rfh5F3nFO6ldfHX3vaBX+1CRtTDBSL9CYIrYQ1/49EVXrGpYtTh5nSpHQM1BRfIaQQHQ
         RkIA1Ec5xx4lPKVEvWuPqBfMRs7HTpGDG7TpYK3Htz8pRBFjVvY/RF39gNNOiK3Go9Xf
         Yz1A==
X-Gm-Message-State: AOAM5332qUT/ACjPTYaznTQqv3Eoh5bQxmzQa97IyGhef59GCrgFXsFg
        MCIedDCC/aSRaQDlwEj2ziMVKLqaozBqH/67kyxdSnrvAcfkPqELtrgPtTGCRFO/VA+pU6TDn73
        936m9Gxt6vBUqJy/t6ESNhW8g
X-Received: by 2002:a05:6000:348:b0:210:323c:769a with SMTP id e8-20020a056000034800b00210323c769amr3647052wre.411.1653893694924;
        Sun, 29 May 2022 23:54:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyICxlknhx3Jy2L9ApC8AN3s3zIcSZThNHOhs6y6eptBkQeGBfv0C8nT+vtfVHYxEDjG14G0g==
X-Received: by 2002:a05:6000:348:b0:210:323c:769a with SMTP id e8-20020a056000034800b00210323c769amr3647039wre.411.1653893694715;
        Sun, 29 May 2022 23:54:54 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:7c00:aaa9:2ce5:5aa0:f736? (p200300cbc7047c00aaa92ce55aa0f736.dip0.t-ipconnect.de. [2003:cb:c704:7c00:aaa9:2ce5:5aa0:f736])
        by smtp.gmail.com with ESMTPSA id m19-20020a7bca53000000b003942a244ee6sm9038107wml.43.2022.05.29.23.54.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 May 2022 23:54:54 -0700 (PDT)
Message-ID: <8c5c5bd6-fea6-4c27-9a84-4b9c937068d7@redhat.com>
Date:   Mon, 30 May 2022 08:54:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH V2] mm/memory_hotplug: Drop 'reason' argument from
 check_pfn_span()
Content-Language: en-US
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <20220526021258.4030749-1-anshuman.khandual@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220526021258.4030749-1-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.05.22 04:12, Anshuman Khandual wrote:
> In check_pfn_span(), a 'reason' string is being used to recreate the caller
> function name, while printing the warning message. It is really unnecessary
> as the warning message could just be printed inside the caller depending on
> the return code. Currently there are just two callers for check_pfn_span()
> i.e  __add_pages() and __remove_pages(). Let's clean this up.
> 
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> Changes in V2:
> 
> - Fixed typo in commit message
> - Dropped using 'ret' to capture check_pfn_span() return value in __add_pages()
> 
> Changes in V1:
> 
> https://lore.kernel.org/all/20220525033910.3781764-1-anshuman.khandual@arm.com/
> 
>  mm/memory_hotplug.c | 20 +++++++++-----------
>  1 file changed, 9 insertions(+), 11 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 416b38ca8def..3b24386e9276 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -220,8 +220,7 @@ static void release_memory_resource(struct resource *res)
>  	kfree(res);
>  }
>  
> -static int check_pfn_span(unsigned long pfn, unsigned long nr_pages,
> -		const char *reason)
> +static int check_pfn_span(unsigned long pfn, unsigned long nr_pages)
>  {
>  	/*
>  	 * Disallow all operations smaller than a sub-section and only
> @@ -238,12 +237,8 @@ static int check_pfn_span(unsigned long pfn, unsigned long nr_pages,
>  		min_align = PAGES_PER_SUBSECTION;
>  	else
>  		min_align = PAGES_PER_SECTION;
> -	if (!IS_ALIGNED(pfn, min_align)
> -			|| !IS_ALIGNED(nr_pages, min_align)) {
> -		WARN(1, "Misaligned __%s_pages start: %#lx end: #%lx\n",
> -				reason, pfn, pfn + nr_pages - 1);
> +	if (!IS_ALIGNED(pfn, min_align) || !IS_ALIGNED(nr_pages, min_align))

We could do

if (!IS_ALIGNED(pfn | nr_pages, min_align))


Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

