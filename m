Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6E75A858F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbiHaS1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232818AbiHaS12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:27:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BEDEF4906
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 11:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661970200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2pJGHwIH41qnK/ZRflZS9Bo8zc0dE9GkgGdGB0wqaq8=;
        b=hqj8Wd+UeoyyYPvl5KUEgrvAdI5WgJHUq9uj+D5JkjJUktcudkd5TM9gRp1XhyMSF2pUeN
        BgKaGF3ULjm6pS0Tr1JIyHaavP9dnrZGiLG+N3ayXp2AXUUDvGP8UCVNbxz6asY0xUTDmd
        tO+39MXqmEhHXrUAzUs6/tQX1s+2itA=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-327-gFZF4xrHNoSv5gYcS4l48w-1; Wed, 31 Aug 2022 14:23:19 -0400
X-MC-Unique: gFZF4xrHNoSv5gYcS4l48w-1
Received: by mail-qv1-f72.google.com with SMTP id e17-20020ad44431000000b00498f6fa689eso7557236qvt.9
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 11:23:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=2pJGHwIH41qnK/ZRflZS9Bo8zc0dE9GkgGdGB0wqaq8=;
        b=ggTCIE13PwXBEnQzumOOKmucmCahNWeyQ639X9JlsvmhC+sMuobUFhRZp1mszhZLa0
         nIv878IgpbdJUyLnVPjAuuNcxHvyuWiuBxhxu/vHqqrKeWNKmxnvWqxupUgctSgfdbNG
         J32Q38YWJmh7/X8fuSQ9a2eExo6jxTi5/gwPb6xLD85oTyTtoZujVon8O6ttBrKhGlhe
         UXic9/Yf58TlF3Gi84l4gExBd4mam7tw2xgzHnMDwnRFd72x3uo3Vj10U/hqVkV0/w8e
         i2oAx/Fpuxj+JxFLErvhbDPyAik1ZenAS3C25KNeZKbDoWakDYU/8UK+Nbzzqa8V8ZXr
         nrcg==
X-Gm-Message-State: ACgBeo1DtWY1yjzauMfKJ8fDOlQLuzbNhhEF7Qo51WHERq65p9tUigZq
        aSvvk9g/HZ2SBLURtTcc9JanLmvazHAnbx473XM4uTZOcVgVaWVFcxs2lVPQIwcXEMs9t/aDTcG
        nuTpm0PgHFrT+nYqzMdtltZEr
X-Received: by 2002:a05:622a:1196:b0:342:f7a9:a138 with SMTP id m22-20020a05622a119600b00342f7a9a138mr20722285qtk.344.1661970198934;
        Wed, 31 Aug 2022 11:23:18 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5JiQXbGkEyG5vJaYlgD/UYSCVkRqXCwqDm3kNuu/0S+5AS1GcIC/36UbzLV4IxBIObHjjphw==
X-Received: by 2002:a05:622a:1196:b0:342:f7a9:a138 with SMTP id m22-20020a05622a119600b00342f7a9a138mr20722276qtk.344.1661970198740;
        Wed, 31 Aug 2022 11:23:18 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id o15-20020a05620a2a0f00b006bb49cfe147sm11163767qkp.84.2022.08.31.11.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 11:23:18 -0700 (PDT)
Date:   Wed, 31 Aug 2022 14:23:16 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Alistair Popple <apopple@nvidia.com>
Subject: Re: [PATCH v1 2/3] mm/gup: use gup_can_follow_protnone() also in
 GUP-fast
Message-ID: <Yw+nFBgnSH9WWYHv@xz-m1.local>
References: <20220825164659.89824-1-david@redhat.com>
 <20220825164659.89824-3-david@redhat.com>
 <1892f6de-fd22-0e8b-3ff6-4c8641e1c68e@redhat.com>
 <2e20c90d-4d1f-dd83-aa63-9d8d17021263@redhat.com>
 <Yw5a1paQJ9MNdgmW@nvidia.com>
 <9ce3aaaa-71a6-5a81-16a3-36e6763feb91@redhat.com>
 <9a4fe603-950e-785b-6281-2e309256463f@nvidia.com>
 <68b38ac4-c680-b694-21a9-1971396d63b9@redhat.com>
 <Yw+KnRTrZ74qFUAA@xz-m1.local>
 <4d067a99-1112-3b3d-bedf-35c1124904fd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4d067a99-1112-3b3d-bedf-35c1124904fd@redhat.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 06:31:23PM +0200, David Hildenbrand wrote:
> >> +	/* Clear/invalidate the PTE before checking for PINs. */
> >> +	if (IS_ENABLED(CONFIG_HAVE_FAST_GUP))
> >> +		smp_mb();
> > 
> > Wondering whether this could be smp_mb__before_atomic().
> 
> We'll read via atomic_read().
> 
> That's a non-RMW operation. smp_mb__before_atomic() only applies to
> RMW (Read Modify Write) operations.

Ah right.

> >> diff --git a/mm/ksm.c b/mm/ksm.c
> >> index d7526c705081..971cf923c0eb 100644
> >> --- a/mm/ksm.c
> >> +++ b/mm/ksm.c
> >> @@ -1091,6 +1091,7 @@ static int write_protect_page(struct vm_area_struct *vma, struct page *page,
> >>  			goto out_unlock;
> >>  		}
> >>  
> >> +		/* See page_try_share_anon_rmap(): clear PTE first. */
> >>  		if (anon_exclusive && page_try_share_anon_rmap(page)) {
> >>  			set_pte_at(mm, pvmw.address, pvmw.pte, entry);
> >>  			goto out_unlock;
> >> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
> >> index 27fb37d65476..47e955212f15 100644
> >> --- a/mm/migrate_device.c
> >> +++ b/mm/migrate_device.c
> >> @@ -193,20 +193,16 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
> >>  			bool anon_exclusive;
> >>  			pte_t swp_pte;
> >>  
> > 
> > flush_cache_page() missing here?
> 
> Hmm, wouldn't that already be missing on the !anon path right now?

Yes, I think Alistair plans to fix it too in the other patchset.  So either
this will rebase to that or it should fix it too.  Thanks,

-- 
Peter Xu

