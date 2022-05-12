Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01DEF524E8C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 15:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354574AbiELNpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 09:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352991AbiELNp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 09:45:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 30B2F149A8E
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 06:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652363123;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BD6+/+j7gLqdpqs370bTvBjU//A0VeuM+56oLRoJjhU=;
        b=brGQhCDXTV3dmheKt7Btj4+iaDDvjCwKWv8Fdt7i4CeH/+cRBqRHhDenfmFaOTg+x82vah
        HZSi8eBNVYwi9acXmv2INwhZd9WQtYuW+f3lEwCOPIxv4hePjMt/mmot2nGNBew/KW5r3a
        EWBm9ROrTsfbVc5ESN7iSmwH2eQaFC4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-316-xxrwhAX8P32JBF4UoGfKyg-1; Thu, 12 May 2022 09:45:21 -0400
X-MC-Unique: xxrwhAX8P32JBF4UoGfKyg-1
Received: by mail-wr1-f72.google.com with SMTP id y12-20020a5d4acc000000b0020cdff2382fso1799636wrs.11
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 06:45:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=BD6+/+j7gLqdpqs370bTvBjU//A0VeuM+56oLRoJjhU=;
        b=5pkWehV8BHqclGKq1RD3BDf3TLNZRuhQYbzkTXRzLuJm8QvCe5axX1kAFpP4Ah7ZIP
         hS3a0U4C4ndxG/w0kkFhZVZyfPZsOBs+F44bCBWGfa4eKuFCyE6E5WXA/bk1e5ro8Fu6
         5xTpp6xNt7WyRaeCFV/16/Q7LhVx/PUX3PtJtxz7jjN/ntwGLPjfMIFH2GKx5Y6i/icg
         KLGgD+yYEC+GNI6kRxpglMKhaXu+zfveyDnTbld/ArJ/0f3mCiT+Q5Cl1oMZ89r0px35
         XRq5SGUliJ+WQEd67ewj6Iz8lvxye8rwFQTd4FTX9eBsX4wBhmODN2WQMV+0Dp+Q6NBU
         sSiA==
X-Gm-Message-State: AOAM5303HRRrQfh0o4Fr2HjXMmmU1wBqnYAraZgY4DOpchzzNm+CQmcJ
        eDlvhqBV30n6CWe3BF8FkE/o0a2IMUiMpR01F3Tem2cjUD0xA99RDt56WBgR4ZW9HRurNdW82iA
        plqfrMvqiVDTAmWXhiRnlEdJP
X-Received: by 2002:adf:f543:0:b0:20a:e059:2f80 with SMTP id j3-20020adff543000000b0020ae0592f80mr28127615wrp.495.1652363120591;
        Thu, 12 May 2022 06:45:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzJhV9G34rWleiSGUVhEcVRqPAvJLjDDPBAB4htT7VKWFBhCUgdTAhposrPnuRf59EN8b5sjg==
X-Received: by 2002:adf:f543:0:b0:20a:e059:2f80 with SMTP id j3-20020adff543000000b0020ae0592f80mr28127600wrp.495.1652363120330;
        Thu, 12 May 2022 06:45:20 -0700 (PDT)
Received: from ?IPV6:2003:cb:c701:d200:ee5d:1275:f171:136d? (p200300cbc701d200ee5d1275f171136d.dip0.t-ipconnect.de. [2003:cb:c701:d200:ee5d:1275:f171:136d])
        by smtp.gmail.com with ESMTPSA id t18-20020adfeb92000000b0020c5253d8fasm4477016wrn.70.2022.05.12.06.45.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 06:45:19 -0700 (PDT)
Message-ID: <3f9e663a-2045-81d1-509e-abbe0e1fa14e@redhat.com>
Date:   Thu, 12 May 2022 15:45:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 14/15] mm/swap: fix the comment of get_kernel_pages
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     willy@infradead.org, vbabka@suse.cz, dhowells@redhat.com,
        neilb@suse.de, apopple@nvidia.com, surenb@google.com,
        peterx@redhat.com, naoya.horiguchi@nec.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220509131416.17553-1-linmiaohe@huawei.com>
 <20220509131416.17553-15-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220509131416.17553-15-linmiaohe@huawei.com>
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

On 09.05.22 15:14, Miaohe Lin wrote:
> If no pages were pinned, 0 is returned in fact. Fix the corresponding
> comment.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/swap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/swap.c b/mm/swap.c
> index 6d2c37f781f8..236b37663a1a 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -168,8 +168,8 @@ EXPORT_SYMBOL(put_pages_list);
>   *
>   * Returns number of pages pinned. This may be fewer than the number
>   * requested. If nr_pages is 0 or negative, returns 0. If no pages

Ehm, there is only "nr_segs", no "nr_pages" :/ Want to fix that up in
the same patch?

> - * were pinned, returns -errno. Each page returned must be released
> - * with a put_page() call when it is finished with.
> + * were pinned, returns 0. Each page returned must be released with
> + * a put_page() call when it is finished with.
>   */
>  int get_kernel_pages(const struct kvec *kiov, int nr_segs, int write,
>  		struct page **pages)

Apart from that

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

