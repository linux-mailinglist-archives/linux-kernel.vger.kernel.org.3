Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6BF512B31
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 07:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbiD1F70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 01:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243415AbiD1F7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 01:59:11 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 007E134B9C
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 22:55:54 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id bg9so3139171pgb.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 22:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=OmWboORltJDtK22Ml4YLWVJ4IYLqmhFFeju3DQyJN9k=;
        b=7wEby7WZpYLiIm29N1XA/YqtYC0pLS1v428ehj5J4t8iB3tIf5AVgTpuwo3tOoK0Qp
         RAO+mhuAo53l0Z+XoDOgvgVPw6y1Qay/TaRM3aDggZxnW9lNOhKKzp2+L6TlJSt40cRM
         OX6eHh4XBy/8ms8Hvvxa2yjZJBRhBLEZRqbkIEYDbeMMGf/DkTV0cY08oQr0txjRS/Dr
         7nRb5jSHGfYuy6PQseVOzK0NKrmkCAoelFuEx+fegs0qt+KDrCFhwbcWdrd05BFXYexL
         x2exmG6PEXaC2bo2KPGUbR6lsFBAb3W+01mrOus+zBTyyY+8en+GtaHJjrA+hxbg7CQ6
         Ba/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=OmWboORltJDtK22Ml4YLWVJ4IYLqmhFFeju3DQyJN9k=;
        b=yG3gcCIcdmoXzi7mo7AhN8WT3PfN3SXdtkCru/VstAYA33vjuiJeyezmIA3UYlgc6J
         d9m4rdZQbpeVTYu4/AhMvQYXk64qFgAeeekeCELbtcSr94XleVJccc/HrXnbmD4N7ZQ8
         P7jlodnDubvPzphTmuKJi/15tIO6Tu8NV6b0e4xJe50qJGTmeuvddfrfEPQeaMlph5jv
         QLAL1Ki8GEnpLIO/P5IeHHc+RKQHupXmg8Tg7j9YAR+DONV0TDJJ0xVWLJar01iWeEQc
         Hjp/poHjGfrTXZgXMAgTwYi2EGlEdWMZ1LiMqXUE0VcMU33NQxspSDI0Xig1Spfj+5Cu
         CNzA==
X-Gm-Message-State: AOAM532mA2EadlgKmepzunhGibBhNI/dAYTTqEuH/hc7myYiU7uCnfdy
        87Drf43MeeikMaizj5xJNJWP8A==
X-Google-Smtp-Source: ABdhPJxmxbtMOA2ZNFO2CETwLqP2cOouytBK7GT6+vU44mwGy5qDzo/+nItIBe+ck/HYuOo/Zz1wmQ==
X-Received: by 2002:a05:6a00:1145:b0:4f6:3ebc:a79b with SMTP id b5-20020a056a00114500b004f63ebca79bmr33588283pfm.41.1651125354465;
        Wed, 27 Apr 2022 22:55:54 -0700 (PDT)
Received: from localhost ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id c18-20020a056a000ad200b004f0f9696578sm23424519pfl.141.2022.04.27.22.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 22:55:54 -0700 (PDT)
Date:   Thu, 28 Apr 2022 13:55:50 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, mike.kravetz@oracle.com,
        almasrymina@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] mm: rmap: Move the cache flushing to the correct
 place for hugetlb PMD sharing
Message-ID: <YmosZpGwSoB8TlnK@FVFYT0MHHV2J.usts.net>
References: <cover.1651056365.git.baolin.wang@linux.alibaba.com>
 <4f7ae6dfdc838ab71e1655188b657c032ff1f28f.1651056365.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4f7ae6dfdc838ab71e1655188b657c032ff1f28f.1651056365.git.baolin.wang@linux.alibaba.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 06:52:06PM +0800, Baolin Wang wrote:
> The cache level flush will always be first when changing an existing
> virtual–>physical mapping to a new value, since this allows us to
> properly handle systems whose caches are strict and require a
> virtual–>physical translation to exist for a virtual address. So we
> should move the cache flushing before huge_pmd_unshare().
>

Right.

> As Muchun pointed out[1], now the architectures whose supporting hugetlb
> PMD sharing have no cache flush issues in practice. But I think we
> should still follow the cache/TLB flushing rules when changing a valid
> virtual address mapping in case of potential issues in future.

Right. One point i need to clarify. I do not object this change but
want you to clarify this (not an issue in practice) in commit log
to let others know they do not need to bp this.

> 
> [1] https://lore.kernel.org/all/YmT%2F%2FhuUbFX+KHcy@FVFYT0MHHV2J.usts.net/
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  mm/rmap.c | 40 ++++++++++++++++++++++------------------
>  1 file changed, 22 insertions(+), 18 deletions(-)
> 
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 61e63db..4f0d115 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1535,15 +1535,16 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>  			 * do this outside rmap routines.
>  			 */
>  			VM_BUG_ON(!(flags & TTU_RMAP_LOCKED));
> +			/*
> +			 * huge_pmd_unshare may unmap an entire PMD page.
> +			 * There is no way of knowing exactly which PMDs may
> +			 * be cached for this mm, so we must flush them all.
> +			 * start/end were already adjusted above to cover this
> +			 * range.
> +			 */
> +			flush_cache_range(vma, range.start, range.end);
> +

flush_cache_range() is always called even if we do not need to flush.
How about introducing a new helper like hugetlb_pmd_shared() which
returns true for shared PMD? Then:

	if (hugetlb_pmd_shared(mm, vma, pvmw.pte)) {
		flush_cache_range(vma, range.start, range.end);
		huge_pmd_unshare(mm, vma, &address, pvmw.pte);
		flush_tlb_range(vma, range.start, range.end);
	}

The code could be a little simpler. Right?

Thanks.

