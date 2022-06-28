Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1289A55EAA7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 19:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232516AbiF1RId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 13:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiF1RIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 13:08:30 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36C72C113
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 10:08:29 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id g7so8138206pjj.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 10:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QFV2WnYNeaDY0J8D3DnyqJ0OcOi782Ccy54kvG1tyHE=;
        b=oAkICj/+ZyN8qPXqe9kShQ/snbNFhTGd0rgmxxy+FfN4hkyVSdT9dDhDNH9UVT4j3D
         5iFALxNdYoSZDDHeBa8bqZT8C9M4XwsAJt6BZENTwjXNOCvHd8haaIz9BkJJoJGU6hXi
         BZvPt1pljnePXzfcZbYlzgY+EHBirVKdIN3QFttXSlG/Ehpyr/W5mpl/awZHsFSVOUTK
         l/Iv9cOFV/CyemWDI/b7uS1aaeF/CD6CM8Il/8q6G/1qP/NXEs6Iu8WplAcvz0Rz6yje
         55XuzdphDAee7nJxtXHok/9X+Pg20/fIztvFbhYUVJp1ngKqbX1ZMTeiN80ssGVhHAna
         Uc3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QFV2WnYNeaDY0J8D3DnyqJ0OcOi782Ccy54kvG1tyHE=;
        b=JqCwEgPm83u+riuFFU4VJES9pSPWYXh6ZXy6f2L8fs5v54ey4gITjpf2URA55lcdNO
         u9Lf/Qwncpjvey9JPr3s2s8a5t5Heaghs79bMP9NT2rKOMuG7xHJVGuZUA4xQuQUk8/T
         nfCPo4Sq+oohbR97RlE1//LtCNXs6Ugd4RqWrIszQ1O6EnmJEnzbn8VM+BdEBE/kkRVr
         UTTi/XdXd/q4oXRsRGSmTEiPwlJa463Q4Q0NEY4dgRl4wHbeRPQfX/ZJM4gcpCxL7yLT
         MTdKNDg9XSIZ6YR5/nmarzrWKv+axPzK2S0FiUM5t6ePp+dA7ORbvFTwjBRVLMxk8BKy
         6WxQ==
X-Gm-Message-State: AJIora9LV21ns2Mf6YF6u42zuu7bXVA7EGp5vugcFr1gjAQrKGW+541y
        DrxsYAA5G8T9QZluc6dP3M6DeDisyApSJgmcmhdkfA==
X-Google-Smtp-Source: AGRyM1tH5SSZQk6DAH0mC95qYZ5+THIX8CIOWKNGgx4CLL16zjo5paPViUVRD51b3QHtWGTwT+/Get8p3c2v7m7Dnt8=
X-Received: by 2002:a17:90b:4f45:b0:1ed:3fe:e54 with SMTP id
 pj5-20020a17090b4f4500b001ed03fe0e54mr732682pjb.32.1656436108709; Tue, 28 Jun
 2022 10:08:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220624173656.2033256-1-jthoughton@google.com>
 <20220624173656.2033256-2-jthoughton@google.com> <e55f90f5-ba14-5d6e-8f8f-abf731b9095e@nutanix.com>
 <bb903be9-546d-04a7-e9e4-f5ba313319de@nutanix.com>
In-Reply-To: <bb903be9-546d-04a7-e9e4-f5ba313319de@nutanix.com>
From:   James Houghton <jthoughton@google.com>
Date:   Tue, 28 Jun 2022 10:08:18 -0700
Message-ID: <CADrL8HUBqYWYuwKnHiwQ9Fpdt_UFf5hXG+sYTQGSmUopfbWKvA@mail.gmail.com>
Subject: Re: [RFC PATCH 01/26] hugetlb: make hstate accessor functions const
To:     "manish.mishra" <manish.mishra@nutanix.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Jue Wang <juew@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 5:09 AM manish.mishra <manish.mishra@nutanix.com> wrote:
>
>
> On 27/06/22 5:06 pm, manish.mishra wrote:
>
>
> On 24/06/22 11:06 pm, James Houghton wrote:
>
> This is just a const-correctness change so that the new hugetlb_pte
> changes can be const-correct too.
>
> Acked-by: David Rientjes <rientjes@google.com>
>
> Signed-off-by: James Houghton <jthoughton@google.com>
> ---
>  include/linux/hugetlb.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index e4cff27d1198..498a4ae3d462 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -715,7 +715,7 @@ static inline struct hstate *hstate_vma(struct vm_area_struct *vma)
>   return hstate_file(vma->vm_file);
>  }
>
> -static inline unsigned long huge_page_size(struct hstate *h)
> +static inline unsigned long huge_page_size(const struct hstate *h)
>  {
>   return (unsigned long)PAGE_SIZE << h->order;
>  }
> @@ -729,27 +729,27 @@ static inline unsigned long huge_page_mask(struct hstate *h)
>   return h->mask;
>  }
>
> -static inline unsigned int huge_page_order(struct hstate *h)
> +static inline unsigned int huge_page_order(const struct hstate *h)
>  {
>   return h->order;
>  }
>
> -static inline unsigned huge_page_shift(struct hstate *h)
> +static inline unsigned huge_page_shift(const struct hstate *h)
>  {
>   return h->order + PAGE_SHIFT;
>  }
>
> -static inline bool hstate_is_gigantic(struct hstate *h)
> +static inline bool hstate_is_gigantic(const struct hstate *h)
>  {
>   return huge_page_order(h) >= MAX_ORDER;
>  }
>
> -static inline unsigned int pages_per_huge_page(struct hstate *h)
> +static inline unsigned int pages_per_huge_page(const struct hstate *h)
>  {
>   return 1 << h->order;
>  }
>
> -static inline unsigned int blocks_per_huge_page(struct hstate *h)
> +static inline unsigned int blocks_per_huge_page(const struct hstate *h)
>  {
>   return huge_page_size(h) / 512;
>  }
>
> James, Just wanted to check why you did it selectively only for these functions
>
> why not for something like hstate_index which too i see used in your code.

I'll look into which other functions can be made const. We need
huge_page_shift() to take `const struct hstate *h` so that the hstates
can be sorted, and it then followed to make the surrounding, related
functions const as well. I could also just leave it at
huge_page_shift().

The commit message here is wrong -- the hugetlb_pte const-correctness
is a separate issue that doesn't depend the constness of hstates. I'll
fix that -- sorry about that.
