Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57ED94DC5D6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 13:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233562AbiCQMac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 08:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbiCQMaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 08:30:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0D2061DDFC6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 05:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647520153;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OR8FPIU54nAtKIYmPBp3wH3w+/iiohWrYlbeO55Ka1Q=;
        b=JH6Bv4c6KhTq4wA+ZuqJMip4VxiWuJtL8C+/i3ZkMiAbBJueFIcY2tAsmg/pzHvMdF/CQ7
        z+QY4sBetqGSwo90N95USY0jxnu7CAg8CFjaDv2f+jY9s8qa0O+N7a+jnCAauOAwqvyeN4
        hQRIrxx9O/ZvbJ8YlPvR5tgyCSc+V/8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-631-mxOHEzGgP7qf6vs7pOIXnA-1; Thu, 17 Mar 2022 08:29:11 -0400
X-MC-Unique: mxOHEzGgP7qf6vs7pOIXnA-1
Received: by mail-wm1-f71.google.com with SMTP id c126-20020a1c3584000000b00380dee8a62cso1579189wma.8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 05:29:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=OR8FPIU54nAtKIYmPBp3wH3w+/iiohWrYlbeO55Ka1Q=;
        b=7Jap7zKRpjI9AdoDxGlr5GKOpfZ+SYf6SHNOFh7Yw0ShmawfZkdfBZyJpv2RTyeYNS
         meK8rQXSk7FRoc4UOWTMA8kkN4Tb9Jz44/lITdyhk3UoWr7Mz95Y8qJrQJltzTgYJYk9
         UfMjYeWxyDGoI4cDlAGOC2maSId11TFmPBOWiYSl0Pb4x/RSt1V6vdlf9L1kQXd9y0qi
         sZTwsJ8LwljZGa7NDIPjBKKkC9f76Ufmy1s8nk7sUiAWC3+mEfeDk9+nobq/l3OBd11j
         Ibxv8c7l0eV+ad608shkTf1O27/5+iyzEBkWWay6bSFytzOWOoOFqlVer5LOta+Ip275
         OADw==
X-Gm-Message-State: AOAM530KGg1KRmQ5tbpFOs6bw6As51d7mxlRLBMMMvzBiThpuHo9+ltS
        b5nveoonoxLAui+t8AJtDwje51YC+9JVcx8feBvFowRs04mKlZITVV91zKaXeYHpEXd3+J4Pdlf
        fLUa7XjP/PenqyOisHvYxyqDR
X-Received: by 2002:a5d:4392:0:b0:1f1:e683:de90 with SMTP id i18-20020a5d4392000000b001f1e683de90mr3962546wrq.551.1647520150670;
        Thu, 17 Mar 2022 05:29:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwztFIjSTfrh/Pnb4zbDJ2gsMcOFsG/vVgG9Rt4Z4Wb5WXu7mBT8uqW87+Rv7vn9IAvIllz9w==
X-Received: by 2002:a5d:4392:0:b0:1f1:e683:de90 with SMTP id i18-20020a5d4392000000b001f1e683de90mr3962526wrq.551.1647520150384;
        Thu, 17 Mar 2022 05:29:10 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:20af:34be:985b:b6c8? ([2a09:80c0:192:0:20af:34be:985b:b6c8])
        by smtp.gmail.com with ESMTPSA id m3-20020a5d6a03000000b001f06621641fsm3867611wru.96.2022.03.17.05.29.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Mar 2022 05:29:10 -0700 (PDT)
Message-ID: <79e0be67-341d-34cb-bb48-30f122d9e239@redhat.com>
Date:   Thu, 17 Mar 2022 13:29:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v3 1/2] mm/memory-failure.c: avoid calling
 invalidate_inode_page() with unexpected pages
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org,
        naoya.horiguchi@nec.com, shy828301@gmail.com,
        mike.kravetz@oracle.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220318073945.62164-1-linmiaohe@huawei.com>
 <20220318073945.62164-2-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220318073945.62164-2-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.03.22 08:39, Miaohe Lin wrote:
> invalidate_inode_page() can invalidate the pages in the swap cache because
> the check of page->mapping != mapping is removed via Matthew's patch titled
> "mm/truncate: Inline invalidate_complete_page() into its one caller". But
> invalidate_inode_page() is not expected to deal with the pages in the swap
> cache. Also non-lru movable page can reach here too. They're not page cache
> pages. Skip these pages by checking PageSwapCache and PageLRU to fix this
> unexpected issue.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/memory-failure.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 5444a8ef4867..ecf45961f3b6 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -2178,7 +2178,7 @@ static int __soft_offline_page(struct page *page)
>  		return 0;
>  	}
>  
> -	if (!PageHuge(page))
> +	if (!PageHuge(page) && PageLRU(page) && !PageSwapCache(page))
>  		/*
>  		 * Try to invalidate first. This should work for
>  		 * non dirty unmapped page cache pages.

I'm not familiar with this code to ack this, but it looks sane to me.

-- 
Thanks,

David / dhildenb

