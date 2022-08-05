Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED0DA58AF9D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 20:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241056AbiHESOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 14:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiHESOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 14:14:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C0EDB2A24E
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 11:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659723280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JFlgXAOeQvAo2VQxtr1S0aAKuStavDrI9zg1bwCkjgk=;
        b=gbPzl3P8t9u3j6INGbXY49RH8ULM8DkQdyqar+t2ly/x3/bu7MlifPYzbGD1m/zhuKGQIh
        mTfI0BMxja5XlUSG3ni+NE21iALJH0oyTpHvcokS87GwjAbMRKwPpakwkUEA8twVHtqfyf
        50Jnvj/qhcOv/rEmXSDlYzKRdubSqk8=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-128-96Icx7sjO02qqvkTzDR7zQ-1; Fri, 05 Aug 2022 14:14:37 -0400
X-MC-Unique: 96Icx7sjO02qqvkTzDR7zQ-1
Received: by mail-qt1-f199.google.com with SMTP id u12-20020a05622a010c00b0031ef5b46dc0so2405215qtw.16
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 11:14:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=JFlgXAOeQvAo2VQxtr1S0aAKuStavDrI9zg1bwCkjgk=;
        b=2bbKakwOT986CHghW4jdGewYe0FNPuieQkXc4XnBb8TQW5QQz1eUIbAdvlc2KFU2wm
         P0M+70T292WViPA30tNRpKkJDlAatz95xQP4pJyOfpRUeFEKmaohoD3BbE9lCLQG4LKe
         jho65lUh/3xfv3q8FfPcOCyFGMBIVIE0+00AVdqRaPF4HU28xzILevKGLTcE21I3jsLc
         DSx5no5FJiT27TUcobd2mgugIPrgCJ/w4ELBaNGz/SON2/ctsy/nnlLsGmirufCDiY1s
         +s8WzsFXOjX4lk8Hi4zdxApHvlAhRHqNvHRBV7CZKuxOPE10gDcX+Qa2TiFGdqXB7jtJ
         n/hw==
X-Gm-Message-State: ACgBeo267wSTfKK+Rrf5Zb1JkUEpN/KbnbfqEWhkCzuxbLs7IUCaq4jn
        XkBZUF6xcweGl+w+0FywJeq7vV0xRO8BralV9Hgt7OCJ5LXpMuLnhNk6Ch+W5Ep5E3ag4uzLxHr
        fr3I6WJgV6PzW6NotH50K1j2s
X-Received: by 2002:a05:6214:c6c:b0:476:97d8:4445 with SMTP id t12-20020a0562140c6c00b0047697d84445mr6758408qvj.19.1659723276931;
        Fri, 05 Aug 2022 11:14:36 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5j1hEQTJoVPFydvn1kx4gLZZz+vdtoIGznvH6S3I2ZX5BXyCUql4S5PuEXABKZUBzzNHN/FQ==
X-Received: by 2002:a05:6214:c6c:b0:476:97d8:4445 with SMTP id t12-20020a0562140c6c00b0047697d84445mr6758393qvj.19.1659723276683;
        Fri, 05 Aug 2022 11:14:36 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id j7-20020ac86647000000b0031f0485aee0sm2971335qtp.88.2022.08.05.11.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 11:14:36 -0700 (PDT)
Date:   Fri, 5 Aug 2022 14:14:34 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Feiner <pfeiner@google.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH v1 1/2] mm/hugetlb: fix hugetlb not supporting
 write-notify
Message-ID: <Yu1eCsMqa641zj5C@xz-m1.local>
References: <20220805110329.80540-1-david@redhat.com>
 <20220805110329.80540-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220805110329.80540-2-david@redhat.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2022 at 01:03:28PM +0200, David Hildenbrand wrote:
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 61e6135c54ef..462a6b0344ac 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1683,6 +1683,13 @@ int vma_wants_writenotify(struct vm_area_struct *vma, pgprot_t vm_page_prot)
>  	if ((vm_flags & (VM_WRITE|VM_SHARED)) != ((VM_WRITE|VM_SHARED)))
>  		return 0;
>  
> +	/*
> +	 * Hugetlb does not require/support writenotify; especially, it does not
> +	 * support softdirty tracking.
> +	 */
> +	if (is_vm_hugetlb_page(vma))
> +		return 0;

I'm kind of confused here..  you seems to be fixing up soft-dirty for
hugetlb but here it's explicitly forbidden.

Could you explain a bit more on why this patch is needed if (assume
there'll be a working) patch 2 being provided?

Thanks,

-- 
Peter Xu

