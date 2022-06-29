Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC8D55F666
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 08:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbiF2GS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 02:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiF2GSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 02:18:25 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9842EE16
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 23:18:24 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id a15so14097612pfv.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 23:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FurANPoXFgLl4yATK+0eEznj1edHZa5nVDv5uuc4bDo=;
        b=SgHO+LNGTa1ZjEU1fOMIoa78TDbXDU0lSMDcOCNqg0P90+bK2g9CGB4PHOz1BHZOzU
         A/KQWOveXJNoOlNAY02aABLZHERdexNI663akY+LgpXN1DUAHH9eCJ+22DdUpvnI/UCu
         tn97Z8uK2JPGB8CY3Qw9eezEHLDyofmdFw7CNsVtAbKu2DL7KpjlMtk4wLNj6rTiWTS1
         diY4j1pPbUfu+IlCcOa6XUSMqAB2FmGHRdf5SV1nzTYI0z3qx9NKXucW3idRY15a/bnv
         mtUybon/6E1Vyjdpvg63bGY4RbGOwHCIOjJoE7ZKmQv7MjsxaEkAm4wvkz++hcHfmYyC
         ebzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FurANPoXFgLl4yATK+0eEznj1edHZa5nVDv5uuc4bDo=;
        b=hHZZre/2Y4yvF5bfn6OCf+15LXuop8mGAr75vdNEiQZrCtHEQ3XowgbJEPAIgR+egc
         wcnG0pa7bVmGhSphm5SoPhCYpZ77k3RxYsgOB2vHtG95XYrRTz+Gl9uH1xpJxVvjiI5Q
         aPFR5d/0ZC2femZbfYkf403Su0boBQUMnMi6PsaP3E34cUPssh7o6pvfuslYeAsPRavS
         UpZup1io1djLBuqLbTNkhAcY1UKZPOXDZb59nOx8V3ZndPQ+NbKyAaGIRW8dowdaoSei
         vnM/Dnzskr0fVO9+oX6QC8wt1cGxFSW1Ty4GcnFxwb1h4iyi7Z9LLxxZpoFVtG6Yagb4
         I9qg==
X-Gm-Message-State: AJIora8RbVr42GFLhV9ghDPm9kUvT521MDvS3jrYkx2l/PDRbgYkrvRE
        Od6hibNbe1T8Uxsgvq/wURMkOg==
X-Google-Smtp-Source: AGRyM1vANek9OiayC/2ujEUHE3FEBKVKdj5W/Tw2CSX8G/sEnkwcrLJnI9wP1/KcysSgjag/O9gCqQ==
X-Received: by 2002:a63:ee54:0:b0:3fe:30cc:899f with SMTP id n20-20020a63ee54000000b003fe30cc899fmr1703757pgk.234.1656483504443;
        Tue, 28 Jun 2022 23:18:24 -0700 (PDT)
Received: from localhost ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id q13-20020a170902a3cd00b0016403cae7desm10453132plb.276.2022.06.28.23.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 23:18:24 -0700 (PDT)
Date:   Wed, 29 Jun 2022 14:18:20 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     James Houghton <jthoughton@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Jue Wang <juew@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 01/26] hugetlb: make hstate accessor functions const
Message-ID: <YrvurKK7FZz/KBCG@FVFYT0MHHV2J.usts.net>
References: <20220624173656.2033256-1-jthoughton@google.com>
 <20220624173656.2033256-2-jthoughton@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624173656.2033256-2-jthoughton@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2022 at 05:36:31PM +0000, James Houghton wrote:
> This is just a const-correctness change so that the new hugetlb_pte
> changes can be const-correct too.
> 
> Acked-by: David Rientjes <rientjes@google.com>
> 
> Signed-off-by: James Houghton <jthoughton@google.com>

This is a good start. I also want to make those helpers take
const type parameter. Seems you have forgotten to update them
when !CONFIG_HUGETLB_PAGE.

Thanks.

> ---
>  include/linux/hugetlb.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index e4cff27d1198..498a4ae3d462 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -715,7 +715,7 @@ static inline struct hstate *hstate_vma(struct vm_area_struct *vma)
>  	return hstate_file(vma->vm_file);
>  }
>  
> -static inline unsigned long huge_page_size(struct hstate *h)
> +static inline unsigned long huge_page_size(const struct hstate *h)
>  {
>  	return (unsigned long)PAGE_SIZE << h->order;
>  }
> @@ -729,27 +729,27 @@ static inline unsigned long huge_page_mask(struct hstate *h)
>  	return h->mask;
>  }
>  
> -static inline unsigned int huge_page_order(struct hstate *h)
> +static inline unsigned int huge_page_order(const struct hstate *h)
>  {
>  	return h->order;
>  }
>  
> -static inline unsigned huge_page_shift(struct hstate *h)
> +static inline unsigned huge_page_shift(const struct hstate *h)
>  {
>  	return h->order + PAGE_SHIFT;
>  }
>  
> -static inline bool hstate_is_gigantic(struct hstate *h)
> +static inline bool hstate_is_gigantic(const struct hstate *h)
>  {
>  	return huge_page_order(h) >= MAX_ORDER;
>  }
>  
> -static inline unsigned int pages_per_huge_page(struct hstate *h)
> +static inline unsigned int pages_per_huge_page(const struct hstate *h)
>  {
>  	return 1 << h->order;
>  }
>  
> -static inline unsigned int blocks_per_huge_page(struct hstate *h)
> +static inline unsigned int blocks_per_huge_page(const struct hstate *h)
>  {
>  	return huge_page_size(h) / 512;
>  }
> -- 
> 2.37.0.rc0.161.g10f37bed90-goog
> 
> 
