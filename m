Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBFE858FF2B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 17:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235654AbiHKPTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 11:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234338AbiHKPTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 11:19:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A5F1C1AF3E
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 08:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660231179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VvBOzAkTVuIJDSaHKsvqxSvSouuZ1MXSA9Vu1AJkje8=;
        b=TM0Pkf4xl+lsnrHRWPBxDJrEpOU2iGAi3jN5AVCNIb4YxpoT1UYIaZHYRroLHZJ4LSzJld
        w4MROtB8/PEEQEnUxN2Q67HFR7IWcTWdlUPLW4zSpSw/lsOW89GJ71erfSeuTMFK4zgHkt
        sc2vIoh4bdJaud95IIJP55JdqchUGVQ=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-662-cUUm-XNUMmCH6FyZ3Xjvag-1; Thu, 11 Aug 2022 11:19:38 -0400
X-MC-Unique: cUUm-XNUMmCH6FyZ3Xjvag-1
Received: by mail-io1-f69.google.com with SMTP id v20-20020a5ec114000000b00682428f8d31so9754415iol.8
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 08:19:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=VvBOzAkTVuIJDSaHKsvqxSvSouuZ1MXSA9Vu1AJkje8=;
        b=vqHcbEe9oHsaTVed5waMhQpLg5T3olgaIeQcdtP0mNhArppJy1F3R8qD/pve7cy2L4
         5YHIeTa3G54Ns6IJtGqBKhbMJ9KGqhlkVfTnbFHg9W0GAXGl2lXVQ4JWrWK0T9V7m2+B
         hWBZhN8ir0kghXhiu7DTNC+hKjkcu3LWeIf3DGuitkw0lJWtT6yKyvszSjUit+jbIccJ
         NfhGXk8Km2Hzpgq+5KzExtVbehdSRvoY5PCcYTJQ8cAXytv8LkFCPXBwhIBEmJbnZ7wZ
         PGPWMTxN28HuFZBy0trBQGKFSu1hk2wWhCd7lOHTjylvhrNF2bf1A69DRXH5iBDbj5AW
         NDBA==
X-Gm-Message-State: ACgBeo2zcmzjWR7UOfiJASlXJPCjK9F88ZiO0W5JUiLyXorIwza3hqbU
        dgkRVnJWfhjjQhYoo3nCcp2O6m60zQXQiZmx2xg+QaZsgi1DhrCzvBEVoBpWboEauyDpFZYkfkW
        MamsSp0DnHXRxGSMktGRIdsbS
X-Received: by 2002:a05:6638:c53:b0:342:a7e7:6829 with SMTP id g19-20020a0566380c5300b00342a7e76829mr15031482jal.112.1660231177760;
        Thu, 11 Aug 2022 08:19:37 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4bA9pkpgxr2VweKV/k+f5M/wNYgeK6Vj6G9Kwge/U93Nvx9BpcVsfQGyy018iYlG4I4XIa0Q==
X-Received: by 2002:a05:6638:c53:b0:342:a7e7:6829 with SMTP id g19-20020a0566380c5300b00342a7e76829mr15031466jal.112.1660231177502;
        Thu, 11 Aug 2022 08:19:37 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id x3-20020a056602160300b0067a338211b3sm3640051iow.3.2022.08.11.08.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 08:19:36 -0700 (PDT)
Date:   Thu, 11 Aug 2022 11:19:35 -0400
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Minchan Kim <minchan@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Huang Ying <ying.huang@intel.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH v3 5/7] mm: Remember young/dirty bit for page migrations
Message-ID: <YvUeB0jc6clz59z5@xz-m1.local>
References: <20220809220100.20033-1-peterx@redhat.com>
 <20220809220100.20033-6-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220809220100.20033-6-peterx@redhat.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 09, 2022 at 06:00:58PM -0400, Peter Xu wrote:
> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
> index 27fb37d65476..699f821b8443 100644
> --- a/mm/migrate_device.c
> +++ b/mm/migrate_device.c
> @@ -221,6 +221,10 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
>  			else
>  				entry = make_readable_migration_entry(
>  							page_to_pfn(page));
> +			if (pte_young(pte))
> +				entry = make_migration_entry_young(entry);
> +			if (pte_dirty(pte))
> +				entry = make_migration_entry_dirty(entry);
>  			swp_pte = swp_entry_to_pte(entry);
>  			if (pte_present(pte)) {
>  				if (pte_soft_dirty(pte))

This change needs to be wrapped with pte_present() at least..

I also just noticed that this change probably won't help anyway because:

  (1) When ram->device, the pte will finally be replaced with a device
      private entry, and device private entry does not yet support A/D, it
      means A/D will be dropped again,

  (2) When device->ram, we are missing information on either A/D bits, or
      even if device private entries start to suport A/D, it's still not
      clear whether we should take device read/write into considerations
      too on the page A/D bits to be accurate.

I think I'll probably keep the code there for completeness, but I think it
won't really help much until more things are done.

-- 
Peter Xu

