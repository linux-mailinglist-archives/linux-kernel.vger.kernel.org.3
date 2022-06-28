Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA8755F0C4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 23:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiF1V6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 17:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiF1V6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 17:58:47 -0400
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995242126B
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 14:58:45 -0700 (PDT)
Received: by mail-vk1-xa36.google.com with SMTP id j26so6607101vki.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 14:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gsr4+tcY+roUGgRtfBsLjJViwTozeORRsEF6iLI2O8c=;
        b=HsAM0rUxxxvjb0YqXNby4zGp7qL2ackwldIMeQzwN/BYg59wNx5b+HF1VjuI0M1QUL
         txMZzsVE18hqXfsYYpdcmWJKhRZziT8z4Bs+FexBNvjqHTZhXOn8Yjg/wTSa9Y/H8Y6n
         TyY2tkh7ke4QLjRERx7goch9JasBaZTUsPeuxNDP543SWXCFMwrXGQ0iPpDFWgZvM6TW
         gYbhU9YRa3F/nAjvy4DD67wUUvqUxKSX6a/gzrY+/ADMpKDCojBt60oc1qRgqOBRAwhN
         36HvsNATdoNS+zyqT5BZ8gsTmzI2QJ+faZ7+fgKgsYllKKqo1e8T0qq0j1BtKpd5TCai
         n4xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gsr4+tcY+roUGgRtfBsLjJViwTozeORRsEF6iLI2O8c=;
        b=3R7xIWcKaExlB8v34+G+9EypaqJxJjm1bzkDElVUpKDLDcT/2rgAdmUK1YoWQvKF1D
         et3cF0LL41ZS03WAoBi3TUEuyZH08PZQA1Iz+RK37cwH4EXJpEpXaYSLzqwvk2xdKd1d
         YNCNaVNz+a0zNWADYXzO6lE+byeEf0X17Atlo/teHbDuWnSitAMhRpkiYvt62+Xt0oOI
         9L26FjdwtOPUOXBAVp2gJPjAQRV5tdX0ztBJ7cCiz/TxxLCE0RgulQl/qvszjZ9FoYzc
         3XTcCGan3ytZEP3bk9F0Ldi+R+Hgti/ihX12cjbC16n0OWi/KhnEaxz3/VMMSGUTLu70
         tJ5A==
X-Gm-Message-State: AJIora/kHXL4367aIydwNxcQiteLuAHt7eAJvWRZVAadB6EOos/CVTsE
        W6z3EEKoei3mPqcAs0jXQfeTqgxjRZkP0dEHHlxO7Q==
X-Google-Smtp-Source: AGRyM1s97I/toNISSZZbGxhiPclKf8DPsv3gPZ98ckqTKPQ0xeDopF7bIABUpPyFuSfw+0N9eV8473hhSHms4JMh2zA=
X-Received: by 2002:a05:6122:714:b0:36b:ff43:3af6 with SMTP id
 20-20020a056122071400b0036bff433af6mr2736073vki.15.1656453524515; Tue, 28 Jun
 2022 14:58:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220624173656.2033256-1-jthoughton@google.com> <20220624173656.2033256-11-jthoughton@google.com>
In-Reply-To: <20220624173656.2033256-11-jthoughton@google.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Tue, 28 Jun 2022 14:58:32 -0700
Message-ID: <CAHS8izNO+4Nzg=rgr1R027i2Evo-UKiFEK1gQcMHtF8uxcHzeQ@mail.gmail.com>
Subject: Re: [RFC PATCH 10/26] hugetlb: add for_each_hgm_shift
To:     James Houghton <jthoughton@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Jue Wang <juew@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
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

On Fri, Jun 24, 2022 at 10:37 AM James Houghton <jthoughton@google.com> wrote:
>
> This is a helper macro to loop through all the usable page sizes for a
> high-granularity-enabled HugeTLB VMA. Given the VMA's hstate, it will
> loop, in descending order, through the page sizes that HugeTLB supports
> for this architecture; it always includes PAGE_SIZE.
>
> Signed-off-by: James Houghton <jthoughton@google.com>
> ---
>  mm/hugetlb.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 8b10b941458d..557b0afdb503 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -6989,6 +6989,16 @@ bool hugetlb_hgm_enabled(struct vm_area_struct *vma)
>         /* All shared VMAs have HGM enabled. */
>         return vma->vm_flags & VM_SHARED;
>  }
> +static unsigned int __shift_for_hstate(struct hstate *h)
> +{
> +       if (h >= &hstates[hugetlb_max_hstate])
> +               return PAGE_SHIFT;

h > &hstates[hugetlb_max_hstate] means that h is out of bounds, no? am
I missing something here?

So is this intending to do:

if (h == hstates[hugetlb_max_hstate]
    return PAGE_SHIFT;

? If so, could we write it as so?

I'm also wondering why __shift_for_hstate(hstate[hugetlb_max_hstate])
== PAGE_SHIFT? Isn't the last hstate the smallest hstate which should
be 2MB on x86? Shouldn't this return PMD_SHIFT in that case?

> +       return huge_page_shift(h);
> +}
> +#define for_each_hgm_shift(hstate, tmp_h, shift) \
> +       for ((tmp_h) = hstate; (shift) = __shift_for_hstate(tmp_h), \
> +                              (tmp_h) <= &hstates[hugetlb_max_hstate]; \
> +                              (tmp_h)++)
>  #endif /* CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING */
>
>  /*
> --
> 2.37.0.rc0.161.g10f37bed90-goog
>
