Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F76A58EF15
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 17:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233018AbiHJPN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 11:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233062AbiHJPNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 11:13:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9890576953
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 08:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660144423;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VuHszj4L1r9q9EYspHE6rVD8WDtJziprQeMYsIFB++M=;
        b=MQjSjsZCo7Gw7YGMybHWyziFU07I1uwLYIg7QI3gBHi/4ocBp+D282nAIN6NzBQH++2E15
        xt6gjq+7doKdm73Bt/rXR5HoWTCgYYvMDvUZvY3hkih5D7siqSqiUqvPztVu/oArVxxrRX
        X/R5X+FeiSK8aOMEn8gvxeg0abggOiA=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-216-desA1vLpMKOiHil534jb4Q-1; Wed, 10 Aug 2022 11:13:42 -0400
X-MC-Unique: desA1vLpMKOiHil534jb4Q-1
Received: by mail-io1-f70.google.com with SMTP id j8-20020a6b7948000000b0067c2923d1b8so8103226iop.6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 08:13:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=VuHszj4L1r9q9EYspHE6rVD8WDtJziprQeMYsIFB++M=;
        b=Lme18QfDswGAwF/ne7vus2r9fwMLGWQXWJgGb6U+e9YaQK08vI1NlTMPWlL2KRCp03
         I4C8oQOVzYrUw0iYoO/zxu+H5/3kAR0WvW1PXD6aGV6p5NjEhxRYqIDHOlVFKwz8m2Zi
         VXlsTic/dMUtqpSaiNlhY5UDpQuGB2jibx/V/Su2xZZTqymNcz/HN9MbsNGL8wFSx2BA
         ZcapqRuwCrGGLli8eX5Avk1Zistq2PGEWwATezQqDeJ9sVn8qaA67HVDSgjhwvsOM+Ck
         /sLoKsW5sa3gHWX+65MyP4iN7tte5xHzGhLD1z49Jx6PZtKWlfgLUR9ATFjQrm5+kFR4
         nxFQ==
X-Gm-Message-State: ACgBeo0f4/EcEEx5KrlpIGdHFsxseXcsilbS7ukP9IQ36JtEL7LGkxs5
        UcAqR/qdN+CRwERmq7a4hD1cyJNtL5dwNaUk3TnkU/fxMvJcmtw2emVcaOzDc2yYViOd4KYDEBm
        TsIDwEzs5Xa96OyWWhkXkLnaY
X-Received: by 2002:a6b:b548:0:b0:67b:fb71:9b22 with SMTP id e69-20020a6bb548000000b0067bfb719b22mr11630909iof.164.1660144421744;
        Wed, 10 Aug 2022 08:13:41 -0700 (PDT)
X-Google-Smtp-Source: AA6agR58Zmo3JphRCV1dvwo1ydhZTdMnJnzqTvCJD5Jx2PD8aJZzXAXHXuj4C+qYhejwg9wwtr0mow==
X-Received: by 2002:a6b:b548:0:b0:67b:fb71:9b22 with SMTP id e69-20020a6bb548000000b0067bfb719b22mr11630892iof.164.1660144421468;
        Wed, 10 Aug 2022 08:13:41 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id o9-20020a056e0214c900b002de990656f5sm2248531ilk.32.2022.08.10.08.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 08:13:40 -0700 (PDT)
Date:   Wed, 10 Aug 2022 11:13:39 -0400
From:   Peter Xu <peterx@redhat.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Minchan Kim <minchan@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andi Kleen <andi.kleen@intel.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH v3 4/7] mm/thp: Carry over dirty bit when thp splits on
 pmd
Message-ID: <YvPLI0GdrlEWF959@xz-m1.local>
References: <20220809220100.20033-1-peterx@redhat.com>
 <20220809220100.20033-5-peterx@redhat.com>
 <877d3gfwf2.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <877d3gfwf2.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2022 at 02:24:33PM +0800, Huang, Ying wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > Carry over the dirty bit from pmd to pte when a huge pmd splits.  It
> > shouldn't be a correctness issue since when pmd_dirty() we'll have the page
> > marked dirty anyway, however having dirty bit carried over helps the next
> > initial writes of split ptes on some archs like x86.
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  mm/huge_memory.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index 0611b2fd145a..e8e78d1bac5f 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -2005,7 +2005,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
> >  	pgtable_t pgtable;
> >  	pmd_t old_pmd, _pmd;
> >  	bool young, write, soft_dirty, pmd_migration = false, uffd_wp = false;
> > -	bool anon_exclusive = false;
> > +	bool anon_exclusive = false, dirty = false;
> >  	unsigned long addr;
> >  	int i;
> >  
> > @@ -2098,6 +2098,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
> >  			SetPageDirty(page);
> >  		write = pmd_write(old_pmd);
> >  		young = pmd_young(old_pmd);
> > +		dirty = pmd_dirty(old_pmd);
> 
> Nitpick: This can be put under
> 
> 		if (pmd_dirty(old_pmd))
> 			SetPageDirty(page);
> 
> Not a big deal.
> 
> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

Yeah will do, thanks.

-- 
Peter Xu

