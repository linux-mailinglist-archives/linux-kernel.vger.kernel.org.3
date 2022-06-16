Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 106B354E085
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 14:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376881AbiFPMFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 08:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376991AbiFPMFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 08:05:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E7B1F5F277
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 05:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655381112;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TICsQghcR62JQXfxCsN53MgwAaUAtpaLR2E5wd3Qxuo=;
        b=MceYUEA3rGXtZbUKdpQDgBsAG/BM+MsGDnou3C4pTdxOX5AthKjIWtYdm1XUjxINbL8v9e
        ye2hqB5AKKhF0q1NVzkks2CAM6Ach51ogeG8ObgbdWUURkOjegxIVHNsHGxaIVLKA0pSBl
        EpDenDRLHpaG8IYocBedgaPAx61WhBE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-339-nZelTl9LNsafj9LSI5mfmQ-1; Thu, 16 Jun 2022 08:05:09 -0400
X-MC-Unique: nZelTl9LNsafj9LSI5mfmQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2DDE110665A4;
        Thu, 16 Jun 2022 12:05:08 +0000 (UTC)
Received: from localhost (ovpn-12-237.pek2.redhat.com [10.72.12.237])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 61FA6404E4C3;
        Thu, 16 Jun 2022 12:05:07 +0000 (UTC)
Date:   Thu, 16 Jun 2022 20:05:03 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     mike.kravetz@oracle.com, songmuchun@bytedance.com,
        akpm@linux-foundation.org, catalin.marinas@arm.com,
        will@kernel.org, anshuman.khandual@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] arm64/hugetlb: Implement arm64 specific
 hugetlb_mask_last_hp
Message-ID: <Yqscbw0l9dL9Eldd@MiWiFi-R3L-srv>
References: <7256dbe078d7231f45b0f47c2c52a3bd3aa10da7.1655350193.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7256dbe078d7231f45b0f47c2c52a3bd3aa10da7.1655350193.git.baolin.wang@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/16/22 at 11:34am, Baolin Wang wrote:
> The HugeTLB address ranges are linearly scanned during fork, unmap and
> remap operations, and the linear scan can skip to the end of range mapped
> by the page table page if hitting a non-present entry, which can help
> to speed linear scanning of the HugeTLB address ranges.
> 
> So hugetlb_mask_last_hp() is introduced to help to update the address in
> the loop of HugeTLB linear scanning with getting the last huge page mapped
> by the associated page table page[1], when a non-present entry is encountered.
> 
> Considering ARM64 specific cont-pte/pmd size HugeTLB, this patch implemented
> an ARM64 specific hugetlb_mask_last_hp() to help this case.
> 
> [1] https://lore.kernel.org/linux-mm/20220527225849.284839-1-mike.kravetz@oracle.com/
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
> Note: this patch is based on the series: "hugetlb: speed up linear
> address scanning" from Mike. Mike, please fold it into your series.
> Thanks.
> ---
>  arch/arm64/mm/hugetlbpage.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
> index e2a5ec9..958935c 100644
> --- a/arch/arm64/mm/hugetlbpage.c
> +++ b/arch/arm64/mm/hugetlbpage.c
> @@ -368,6 +368,26 @@ pte_t *huge_pte_offset(struct mm_struct *mm,
>  	return NULL;
>  }
>  
> +unsigned long hugetlb_mask_last_hp(struct hstate *h)
> +{
> +	unsigned long hp_size = huge_page_size(h);

hp_size may not be a good name, it reminds me of hotplug. I would name
it hpage_size even though a little more characters are added.

> +
> +	switch (hp_size) {
> +	case PUD_SIZE:
> +		return PGDIR_SIZE - PUD_SIZE;
> +	case CONT_PMD_SIZE:
> +		return PUD_SIZE - CONT_PMD_SIZE;
> +	case PMD_SIZE:
> +		return PUD_SIZE - PMD_SIZE;
> +	case CONT_PTE_SIZE:
> +		return PMD_SIZE - CONT_PTE_SIZE;
> +	default:
> +		break;
> +	}
> +
> +	return ~0UL;
> +}
> +
>  pte_t arch_make_huge_pte(pte_t entry, unsigned int shift, vm_flags_t flags)
>  {
>  	size_t pagesize = 1UL << shift;
> -- 
> 1.8.3.1
> 
> 

