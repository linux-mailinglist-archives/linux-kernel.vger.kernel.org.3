Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9556F553D83
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 23:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355605AbiFUVWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 17:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356160AbiFUVWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 17:22:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E1A4D3152E
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 14:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655845826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SdUI0K3w6UZwdwxK9UpEw+8+48uw2ZOlT+wIg6Q8bOY=;
        b=GyVraEluMpblzLgAtQ48fi4nq+80XgXevq1mtO+b34ughabKGWLsQNDzgGXgwiquc/QzXV
        PMQlewO3bKY6ggz8kZ9N8Nc4xL5GLl768otRaw8iEE/Lbt9njMu0nS0PKdZdPBTe6XAq02
        qqBDImRcKu8GqN/Dvug2RY1PjTWD9h0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-651-p-ZhjlvFOCOJ4O7Z5tultQ-1; Tue, 21 Jun 2022 17:10:23 -0400
X-MC-Unique: p-ZhjlvFOCOJ4O7Z5tultQ-1
Received: by mail-wm1-f69.google.com with SMTP id m23-20020a05600c3b1700b0039c6e3c169aso6750413wms.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 14:10:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=SdUI0K3w6UZwdwxK9UpEw+8+48uw2ZOlT+wIg6Q8bOY=;
        b=Bnr4fjDdfh+N2NATaVcQ86LzeDydc9EWiFmnXRfbIDN7Jhoh8NttUHWdV94Sf7OBrq
         AMdQHdeE1ks7IKZfYplZ2+ojLuXyED9Lc8rCekL9gEXjfyDw+VN8p1w3bSe+X+oe5Yan
         4vod7pSnCHgouz4SXTum6jGq5f5CGj/ZBTOp1nSJYMORF/byiIN62fSOT0eon8zcQwfD
         NVSH77cnv8ronl8d5afc77MgixyaDnKkJdeHBORltdmgFzzfyQkSJFEb1K3ROCfYZ5iL
         J7Mzfse5pnaobRt9R7hw477Vkeo/4hXe/Lzu3etoYnkbmw74nirgLAQVE157iFQ5q7hD
         1XAg==
X-Gm-Message-State: AJIora9JO2UcGAc7kId7iFCwKhDRTIGOTqhKxhqpxVBpsgzGKDRoln//
        z6QgSoVuYmscFuVqwrUAi1oruz1brAXH5u7mpTAvDixQkXJCT9Z5yu9UCqbcE/Pvnpy9Nks7TKA
        BK5cyoZOGu9fLBPEL9CORLQA1
X-Received: by 2002:a05:600c:2215:b0:39c:55a0:9531 with SMTP id z21-20020a05600c221500b0039c55a09531mr108967wml.29.1655845822339;
        Tue, 21 Jun 2022 14:10:22 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1ud+bHPP4KWO8KY35eiF30xNySOOWliDKJe6HtrrpkxxAj+WdmqBBYwA8RLBb2B32014Zn5TA==
X-Received: by 2002:a05:600c:2215:b0:39c:55a0:9531 with SMTP id z21-20020a05600c221500b0039c55a09531mr108952wml.29.1655845822122;
        Tue, 21 Jun 2022 14:10:22 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:bc00:a63c:7e37:6061:1706? (p200300cbc705bc00a63c7e3760611706.dip0.t-ipconnect.de. [2003:cb:c705:bc00:a63c:7e37:6061:1706])
        by smtp.gmail.com with ESMTPSA id p14-20020a5d48ce000000b0021020517639sm17018132wrs.102.2022.06.21.14.10.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jun 2022 14:10:21 -0700 (PDT)
Message-ID: <20192b57-30de-1426-6694-238e018104eb@redhat.com>
Date:   Tue, 21 Jun 2022 23:10:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v10 09/69] mm: add VMA iterator
Content-Language: en-US
To:     Liam Howlett <liam.howlett@oracle.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "damon @ lists . linux . dev" <damon@lists.linux.dev>,
        SeongJae Park <sj@kernel.org>
References: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
 <20220621204632.3370049-10-Liam.Howlett@oracle.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220621204632.3370049-10-Liam.Howlett@oracle.com>
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

On 21.06.22 22:46, Liam Howlett wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> This thin layer of abstraction over the maple tree state is for iterating
> over VMAs.  You can go forwards, go backwards or ask where the iterator
> is.  Rename the existing vma_next() to __vma_next() -- it will be removed
> by the end of this series.
> 
> Link: https://lkml.kernel.org/r/20220504010716.661115-11-Liam.Howlett@oracle.com
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: SeongJae Park <sj@kernel.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
>  include/linux/mm.h       | 31 +++++++++++++++++++++++++++++++
>  include/linux/mm_types.h | 21 +++++++++++++++++++++
>  mm/mmap.c                | 10 +++++-----
>  3 files changed, 57 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 810b3dd929e4..f22c6f71a18c 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -658,6 +658,37 @@ static inline bool vma_is_accessible(struct vm_area_struct *vma)
>  	return vma->vm_flags & VM_ACCESS_FLAGS;
>  }
>  
> +static inline
> +struct vm_area_struct *vma_find(struct vma_iterator *vmi, unsigned long max)
> +{
> +	return mas_find(&vmi->mas, max);
> +}
> +
> +static inline struct vm_area_struct *vma_next(struct vma_iterator *vmi)
> +{
> +	/*
> +	 * Uses vma_find() to get the first VMA when the iterator starts.
> +	 * Calling mas_next() could skip the first entry.
> +	 */
> +	return vma_find(vmi, ULONG_MAX);
> +}
> +
> +static inline struct vm_area_struct *vma_prev(struct vma_iterator *vmi)
> +{
> +	return mas_prev(&vmi->mas, 0);
> +}
> +
> +static inline unsigned long vma_iter_addr(struct vma_iterator *vmi)
> +{
> +	return vmi->mas.index;
> +}
> +
> +#define for_each_vma(vmi, vma)		while ((vma = vma_next(&(vmi))) != NULL)
> +
> +/* The MM code likes to work with exclusive end addresses */
> +#define for_each_vma_range(vmi, vma, end)				\
> +	while ((vma = vma_find(&(vmi), (end) - 1)) != NULL)
> +
>  #ifdef CONFIG_SHMEM
>  /*
>   * The vma_is_shmem is not inline because it is used only by slow
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 254c30def2b2..1485a24796be 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -696,6 +696,27 @@ static inline cpumask_t *mm_cpumask(struct mm_struct *mm)
>  	return (struct cpumask *)&mm->cpu_bitmap;
>  }
>  
> +struct vma_iterator {
> +	struct ma_state mas;
> +};
> +
> +#define VMA_ITERATOR(name, mm, addr) 					\
> +	struct vma_iterator name = {					\
> +		.mas = {						\
> +			.tree = &mm->mm_mt,				\
> +			.index = addr,					\
> +			.node = MAS_START,				\
> +		},							\
> +	}
> +

No __* and () macro magic?

I'd have expected at least

tree = &(__mm)->mm_mt,
.index = (__addr),

;)


Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

