Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A52DD514850
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 13:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358624AbiD2Ljd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 07:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358580AbiD2Ljb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 07:39:31 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033B792D26
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 04:36:13 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id p12so6740770pfn.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 04:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5qUXGCF9AGuwVC1iTJpuUcJbkoFNkd+P9LIidzVotos=;
        b=bfQr51xrs9FtI21KSefs0zZ1ihw1LAv6w7I3X1g8AnFPyonM8MdvuT2A9ngE8QFp+q
         O4z0y8eiB/q6xeJBpL5stCotC3j7A3WwVTHeTGKo/sR11C/8tNo7Qdf1OCoMRRlFTnp5
         SOvWHTJQzb69dkNt5FbH/o9QP1lUttnqL/mhHW5AmBjLCB2Nb7kRW3GNNjsoZPGvcA7w
         0A9xrhE8x1N3xi4lmnvhkg7jNxIYj6ugBTju4TR/+u40AnErvBONm4jMDAB3c8LyljrK
         g+OZUNlY9xU6Cvl5Ec9/ga37bUzn6qL20Thb0+MTRHJtRf111Ompu2WrLHqIVtSHNgP4
         Gctw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5qUXGCF9AGuwVC1iTJpuUcJbkoFNkd+P9LIidzVotos=;
        b=LvFCbiaCwcZvq7KQl3GhxY0dGo3U37Siz5GFBAgHqpZAd2nmjCEl5D/BEmtEFCdX84
         R406G8RK/Hgj9y5WB+t2g84wBqDdLa7XJyPodtNe+NdCdeqpvpJLnWqZM+s/PIHgSQ1Y
         Esl+FSHRH4K2MMd4OjaOXn6MnK41kmIr6SjOmS9tCAuniN0AeE3jjAvMzi0PPjfMoWUl
         8e+OCeLMsN8YFJfQTjEwR/UPrRzkSacz7zTL9PPwVDFqwZXKtUUQaGAVIhB1b+oExY2A
         9KuPl8SJt963T3drXHW9Ft1nUf6Y41b1UmZA0nHIt7H8sShp8bDefHr2FAYPNLAzYgEC
         djKA==
X-Gm-Message-State: AOAM5326lNl9+6LecnM+EKT1RkXv7Wy832luKr/k7hxFr0MsyjnfI4MD
        oTP0ggzsnw+jKCNbDiQkHz79Fw==
X-Google-Smtp-Source: ABdhPJyH5uWVKw0STd5Fcnd3XA9AY/TjWha8CcbSuTVN81N8D2DsNXSmgPcdLUKoobMlNXu73d/wNQ==
X-Received: by 2002:a05:6a02:197:b0:382:a4b0:b9a8 with SMTP id bj23-20020a056a02019700b00382a4b0b9a8mr31689034pgb.325.1651232172519;
        Fri, 29 Apr 2022 04:36:12 -0700 (PDT)
Received: from localhost ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id g15-20020aa7818f000000b00505ce2e4640sm2794583pfi.100.2022.04.29.04.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 04:36:12 -0700 (PDT)
Date:   Fri, 29 Apr 2022 19:36:09 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, mike.kravetz@oracle.com,
        naoya.horiguchi@nec.com, ying.huang@intel.com, hch@lst.de,
        dhowells@redhat.com, cl@linux.com, david@redhat.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] mm/migration: return errno when isolate_huge_page
 failed
Message-ID: <YmvNqWhC0uBwJ2yF@FVFYT0MHHV2J.usts.net>
References: <20220425132723.34824-1-linmiaohe@huawei.com>
 <20220425132723.34824-4-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220425132723.34824-4-linmiaohe@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 09:27:22PM +0800, Miaohe Lin wrote:
> We might fail to isolate huge page due to e.g. the page is under migration
> which cleared HPageMigratable. So we should return -EBUSY in this case
> rather than always return 1 which could confuse the user. Also we make
> the prototype of isolate_huge_page consistent with isolate_lru_page to
> improve the readability.
> 
> Fixes: e8db67eb0ded ("mm: migrate: move_pages() supports thp migration")
> Suggested-by: Huang Ying <ying.huang@intel.com>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  include/linux/hugetlb.h |  6 +++---
>  mm/gup.c                |  2 +-
>  mm/hugetlb.c            | 11 +++++------
>  mm/memory-failure.c     |  2 +-
>  mm/mempolicy.c          |  2 +-
>  mm/migrate.c            |  5 +++--
>  6 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 04f0186b089b..306d6ef3fa22 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -170,7 +170,7 @@ bool hugetlb_reserve_pages(struct inode *inode, long from, long to,
>  						vm_flags_t vm_flags);
>  long hugetlb_unreserve_pages(struct inode *inode, long start, long end,
>  						long freed);
> -bool isolate_huge_page(struct page *page, struct list_head *list);
> +int isolate_huge_page(struct page *page, struct list_head *list);
>  int get_hwpoison_huge_page(struct page *page, bool *hugetlb);
>  int get_huge_page_for_hwpoison(unsigned long pfn, int flags);
>  void putback_active_hugepage(struct page *page);
> @@ -376,9 +376,9 @@ static inline pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr,
>  	return NULL;
>  }
>  
> -static inline bool isolate_huge_page(struct page *page, struct list_head *list)
> +static inline int isolate_huge_page(struct page *page, struct list_head *list)

Since you already touched all the call sites, how about renaming this
to hugetlb_isolate()? I've always felt that huge_page is not a
straightforward and clear name since we also have another type of
huge page (THP).  I think hugetlb is more specific.

Thanks.
 
