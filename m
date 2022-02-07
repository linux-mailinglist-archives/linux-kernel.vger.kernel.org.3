Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 379D44AC2A0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 16:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442802AbiBGPJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 10:09:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442026AbiBGOrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 09:47:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3C9BBC03FEF9
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 06:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644245194;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q5t79iozaE2m1xAHOPqGRMffMv8r6J72j302frUn+qI=;
        b=LtLtZBjUVRn7XOI16Rm33AyVBLaZdrsThpomhyNYCwzeg/Hq7bh+3tksxcWir5IewuTBHB
        ONV6ChWTkySxD1zuoc8DGtK1LKukHuPi6XgC6IXMtLds4o+0QRV6vjYpUuPgqDmTA79UqN
        07rUu2whVDxU+cSfuLvTPSGjIUn64+g=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-544-NdaVxt5qMaWX012cjtR1Vw-1; Mon, 07 Feb 2022 09:46:33 -0500
X-MC-Unique: NdaVxt5qMaWX012cjtR1Vw-1
Received: by mail-wm1-f72.google.com with SMTP id c7-20020a1c3507000000b0034a0dfc86aaso12353216wma.6
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 06:46:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=q5t79iozaE2m1xAHOPqGRMffMv8r6J72j302frUn+qI=;
        b=Q8tUJy4vC80C/1RTd2ygSehA5rIkiZUFo/bW3+uG/hiK80Gr+QS8WcsrENSIgkjaf3
         fsVzs1/6QrmsyXzN+MvyJw2UeVXwrFzbg/I+NQ93UEayhMhI6XLDOyDqg933sgRyCBlQ
         5cVX6ybio5FSGCOfGWZrfQdVQC55UCTTiZyop9jgek706EhcN4XvUmQiyY508rmRbOdd
         35Esu6ETzCrrJMZnXw0JNCvJTvnZY3ErZbRvXkDCvBaBMX+T2b3AJ3zCX8ydCNo7f2JT
         IXuEqIN9VgBomLXuvgj12QNXr6n2Bgk7YK/eDZkYFrfebdXhj0Z0r5Vw6JABac1a39sG
         sYsA==
X-Gm-Message-State: AOAM533c4TbdEz0u2x7vmkuvp++86bIievkgK7Q2YB4j6kDoXZdva2Yp
        a3g0NYCVTH2Tvz5ROJSmRFubwCLSKSRcsPRjAmtYqbBh1V7H4BsDGkIk2yvIiaZI1AuYG9JZoly
        TmhUzxxvhAWOM7IShb3hgZ8W6
X-Received: by 2002:a05:600c:3552:: with SMTP id i18mr14940655wmq.21.1644245192310;
        Mon, 07 Feb 2022 06:46:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzMVrR+RBrnlh8AzddSCKZ1Ca+zUuQZLn9WpRkM1MqzW2/120srKfxv4zFbFiH8BjRv6BS54w==
X-Received: by 2002:a05:600c:3552:: with SMTP id i18mr14940642wmq.21.1644245192085;
        Mon, 07 Feb 2022 06:46:32 -0800 (PST)
Received: from ?IPV6:2003:cb:c709:6300:a751:d742:1f76:8639? (p200300cbc7096300a751d7421f768639.dip0.t-ipconnect.de. [2003:cb:c709:6300:a751:d742:1f76:8639])
        by smtp.gmail.com with ESMTPSA id bg26sm18421742wmb.48.2022.02.07.06.46.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 06:46:31 -0800 (PST)
Message-ID: <ba692f24-794e-300d-248a-93165acd18e5@redhat.com>
Date:   Mon, 7 Feb 2022 15:46:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 3/4] mm/memory_hotplug: clean up try_offline_node
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220207133643.23427-1-linmiaohe@huawei.com>
 <20220207133643.23427-4-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220207133643.23427-4-linmiaohe@huawei.com>
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
> We can use helper macro node_spanned_pages to check whether node spans
> pages. And we can change the parameter of check_cpu_on_node to nid as
> that's what it really cares. Thus we can further get rid of the local
> variable pgdat and improve the readability a bit.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/memory_hotplug.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 140809e60e9a..4b9eef861ee4 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -2008,12 +2008,12 @@ static int get_nr_vmemmap_pages_cb(struct memory_block *mem, void *arg)
>  	return mem->nr_vmemmap_pages;
>  }
>  
> -static int check_cpu_on_node(pg_data_t *pgdat)
> +static int check_cpu_on_node(int nid)
>  {
>  	int cpu;
>  
>  	for_each_present_cpu(cpu) {
> -		if (cpu_to_node(cpu) == pgdat->node_id)
> +		if (cpu_to_node(cpu) == nid)
>  			/*
>  			 * the cpu on this node isn't removed, and we can't
>  			 * offline this node.
> @@ -2047,7 +2047,6 @@ static int check_no_memblock_for_node_cb(struct memory_block *mem, void *arg)
>   */
>  void try_offline_node(int nid)
>  {
> -	pg_data_t *pgdat = NODE_DATA(nid);
>  	int rc;
>  
>  	/*
> @@ -2055,7 +2054,7 @@ void try_offline_node(int nid)
>  	 * offline it. A node spans memory after move_pfn_range_to_zone(),
>  	 * e.g., after the memory block was onlined.
>  	 */
> -	if (pgdat->node_spanned_pages)
> +	if (node_spanned_pages(nid))
>  		return;
>  
>  	/*
> @@ -2067,7 +2066,7 @@ void try_offline_node(int nid)
>  	if (rc)
>  		return;
>  
> -	if (check_cpu_on_node(pgdat))
> +	if (check_cpu_on_node(nid))
>  		return;
>  
>  	/*

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

