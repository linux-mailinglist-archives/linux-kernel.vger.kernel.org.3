Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 712ED5A2A2F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 16:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238219AbiHZO7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 10:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbiHZO7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 10:59:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA78A5726
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 07:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661525949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VCoqmDkCw52ZjfvCeznHWt8v+BcY6BkeXMWVAHo1irw=;
        b=bplU55cQqGnpvFM8S9041D7y0HZ0JZChBnrTFkPXYMDTggUmGNWR7U9sr2+aDliLSGVhlD
        wPi1BSjAAsIwiBeZ3DuhyAjQvs+DT3wSSSkK2JkuHd1qtWZnGOYFopMhBAn339m8rSgQaL
        fkdSl9+MKJ+rpLm2N4FqqjCh5kSboC0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-43-Tagnu3lvN7CNkcz954K9Eg-1; Fri, 26 Aug 2022 10:59:08 -0400
X-MC-Unique: Tagnu3lvN7CNkcz954K9Eg-1
Received: by mail-wm1-f70.google.com with SMTP id x16-20020a1c7c10000000b003a5cefa5578so602282wmc.7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 07:59:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=VCoqmDkCw52ZjfvCeznHWt8v+BcY6BkeXMWVAHo1irw=;
        b=kE/r89gdlQ6CMWSQu1haQ0ee2EKH1E4cnNkEdKCkrJBs0tMht/IJ7/bCJ+C4AOyZoN
         ecxVQceyjPLzqDKrOXN26YfzBXN9IJElGK+SKyHN6fIkZLILPaBPkmtrFTx4YYAxGpD1
         VQrhJ6RCyBQIdRH3FgxqC0KbYpcIXnLKYmz9NhsL2+dKjZr0tWqHAE+MIUKOI6s+1FqK
         zIIQHqImwcRXXwKSVTSWy19BnmTHSdVLzkttnkdQ0xrEdsPe4KTF2AeDoiTxMvYyd2Cn
         BldNuJByCEeuKcsJwjvDfbMI/NAwsWUfrWPcqP9SIHTVbEBTjujlN01UoEPaN1qvcq/q
         N6AA==
X-Gm-Message-State: ACgBeo2JeYbb356nYrYfPz3gLGmqP5stJhaTQBGAsg5dKHeZ82r4sqJg
        2Ps4xsUx8IG7QYyQnw2+dFrM//scj4EfeyuU6V2Gx162CKx2dKSGZZI7qcN+v5ZrN/HnbOKaWBs
        Z0q5B11k8sXqkUqc6GBirrICgMySoJgNijdMLur35F1QokZ0uq+mvxEFKKV1WianOaFkhibaY
X-Received: by 2002:a5d:5487:0:b0:225:3fa7:41c2 with SMTP id h7-20020a5d5487000000b002253fa741c2mr26948wrv.195.1661525946954;
        Fri, 26 Aug 2022 07:59:06 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7xr/jbetH+c5iW+sG0tLDSXLeY9dAI1yiL6jrCbIJeSWgxnxkV4zii1bC05+N5VNSup0x1dg==
X-Received: by 2002:a5d:5487:0:b0:225:3fa7:41c2 with SMTP id h7-20020a5d5487000000b002253fa741c2mr26928wrv.195.1661525946638;
        Fri, 26 Aug 2022 07:59:06 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:f600:abad:360:c840:33fa? (p200300cbc708f600abad0360c84033fa.dip0.t-ipconnect.de. [2003:cb:c708:f600:abad:360:c840:33fa])
        by smtp.gmail.com with ESMTPSA id r18-20020a05600c425200b003a603f96db7sm9034891wmm.36.2022.08.26.07.59.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 07:59:06 -0700 (PDT)
Message-ID: <1892f6de-fd22-0e8b-3ff6-4c8641e1c68e@redhat.com>
Date:   Fri, 26 Aug 2022 16:59:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v1 2/3] mm/gup: use gup_can_follow_protnone() also in
 GUP-fast
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>, Peter Xu <peterx@redhat.com>
References: <20220825164659.89824-1-david@redhat.com>
 <20220825164659.89824-3-david@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220825164659.89824-3-david@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.08.22 18:46, David Hildenbrand wrote:
> There seems to be no reason why FOLL_FORCE during GUP-fast would have to
> fallback to the slow path when stumbling over a PROT_NONE mapped page. We
> only have to trigger hinting faults in case FOLL_FORCE is not set, and any
> kind of fault handling naturally happens from the slow path -- where
> NUMA hinting accounting/handling would be performed.
> 
> Note that the comment regarding THP migration is outdated:
> commit 2b4847e73004 ("mm: numa: serialise parallel get_user_page against
> THP migration") described that this was required for THP due to lack of PMD
> migration entries. Nowadays, we do have proper PMD migration entries in
> place -- see set_pmd_migration_entry(), which does a proper
> pmdp_invalidate() when placing the migration entry.
> 
> So let's just reuse gup_can_follow_protnone() here to make it
> consistent and drop the somewhat outdated comments.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/gup.c | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index a1355dbd848e..dfef23071dc8 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2350,11 +2350,7 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
>  		struct page *page;
>  		struct folio *folio;
>  
> -		/*
> -		 * Similar to the PMD case below, NUMA hinting must take slow
> -		 * path using the pte_protnone check.
> -		 */
> -		if (pte_protnone(pte))
> +		if (pte_protnone(pte) && !gup_can_follow_protnone(flags))
>  			goto pte_unmap;
>  
>  		if (!pte_access_permitted(pte, flags & FOLL_WRITE))
> @@ -2736,12 +2732,8 @@ static int gup_pmd_range(pud_t *pudp, pud_t pud, unsigned long addr, unsigned lo
>  
>  		if (unlikely(pmd_trans_huge(pmd) || pmd_huge(pmd) ||
>  			     pmd_devmap(pmd))) {
> -			/*
> -			 * NUMA hinting faults need to be handled in the GUP
> -			 * slowpath for accounting purposes and so that they
> -			 * can be serialised against THP migration.
> -			 */
> -			if (pmd_protnone(pmd))
> +			if (pmd_protnone(pmd) &&
> +			    !gup_can_follow_protnone(flags))
>  				return 0;
>  
>  			if (!gup_huge_pmd(pmd, pmdp, addr, next, flags,


I just stumbled over something interesting. If we have a pte_protnone()
entry, ptep_clear_flush() might not flush, because the !pte_accessible()
 does not hold.

Consequently, we could be in trouble when using ptep_clear_flush() on a
pte_protnone() PTE to make sure that GUP cannot run anymore.

Will give this a better thought, but most probably I'll replace this
patch by a proper documentation update here.

-- 
Thanks,

David / dhildenb

