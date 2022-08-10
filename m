Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77D1658F2FA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 21:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232784AbiHJTVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 15:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233139AbiHJTV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 15:21:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 86A295E326
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 12:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660159286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IKtPa1b3cUCAoD5B4a66OaPs8cv/e+sQ8MAuok0BMJk=;
        b=NBcniuvUQDISALSFPDZJ0+OsvgM+cDo6BH5JNyAbCBF0huiteZZzkcBLs24TXeOJQnWO3N
        GUZ2dnliRK6V9UKYyIrp7XqJ27d4XRiSGhOW5bIeoeBqytjDwxbYhUcji7qbuIzY7VuMvX
        tmZgpN5/cgi63Qx/bcC2ewsSswzO+4w=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-49-S_z1xAFjM2G2TgDyTpXayg-1; Wed, 10 Aug 2022 15:21:23 -0400
X-MC-Unique: S_z1xAFjM2G2TgDyTpXayg-1
Received: by mail-io1-f69.google.com with SMTP id u5-20020a6b4905000000b00681e48dbd92so8623469iob.21
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 12:21:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=IKtPa1b3cUCAoD5B4a66OaPs8cv/e+sQ8MAuok0BMJk=;
        b=XizOq90Y3vIV4yxq+IdZ+vu2MAfe0c63kloIlV0J25MZEeD/njy60bNjNnI1ZRJzQx
         LvfN9qM+/C8Hl2wx2YLiGrAz1wa7PS3DaJPKWEry0aQcBVRN+3kfAJOmnDSHfIq+h4B/
         6YyiEnAe19VYTGC0CGDOIVyl41wckQaqPjI55NIyl6dMfNxsJYKgfpE38AuvQ+CGgjEe
         zQ4FAFPtxLndYG9UbGzbxVX5oFSWccpgLDB7MGjh7UCjd7+Nyaqtx5OYvm5o/zm/bwaK
         4y6WgGQEkYiGWtA7CSDp5/KbUpi8a8h1PyGWrdqlrgcgq+8PLAoUBKwfSScJqy45xahM
         i/sQ==
X-Gm-Message-State: ACgBeo2BY9Lz4akzb9RfyQ38tCe5lsgzwpmm4u3nxjsZMbrKh5Nswrnj
        /j4BsbRj4S9uaSFmWzzP7Twtv2lWFg2A5tpBTT83e4lsB2/fD8Y1a5rdPR3fICkFXD/eVEbeltU
        50AO6CdnA9zWzOUpOvI06LKxd
X-Received: by 2002:a05:6638:24d1:b0:343:25c0:a2d with SMTP id y17-20020a05663824d100b0034325c00a2dmr5549457jat.76.1660159282508;
        Wed, 10 Aug 2022 12:21:22 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4Zr+K6kcQFSlk0EDzaIxLZX04rwSbXbxvY4k9mieXk0+MMJr5Dg2hqHkj3y5+L+2pU6lMo7Q==
X-Received: by 2002:a05:6638:24d1:b0:343:25c0:a2d with SMTP id y17-20020a05663824d100b0034325c00a2dmr5549442jat.76.1660159282311;
        Wed, 10 Aug 2022 12:21:22 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id bo20-20020a056638439400b00339ef592279sm7636398jab.127.2022.08.10.12.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 12:21:21 -0700 (PDT)
Date:   Wed, 10 Aug 2022 15:21:20 -0400
From:   Peter Xu <peterx@redhat.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Nadav Amit <nadav.amit@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Andi Kleen <andi.kleen@intel.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Christoph Hellwig <hch@lst.de>,
        Alistair Popple <apopple@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v2 2/2] mm: Remember young/dirty bit for page migrations
Message-ID: <YvQFMMKxO2SD0T1T@xz-m1.local>
References: <20220804203952.53665-1-peterx@redhat.com>
 <20220804203952.53665-3-peterx@redhat.com>
 <877d3hhksz.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <YvKglA2LQkYeznZ9@xz-m1.local>
 <87wnbggbqa.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87wnbggbqa.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2022 at 08:53:49AM +0800, Huang, Ying wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Tue, Aug 09, 2022 at 04:40:12PM +0800, Huang, Ying wrote:
> [snip]
> >
> >> I don't find pte_dirty() is synced to PageDirty() as in
> >> try_to_migrate_one().  Is it a issue in the original code?
> >
> > I think it has?  There is:
> >
> > 		/* Set the dirty flag on the folio now the pte is gone. */
> > 		if (pte_dirty(pteval))
> > 			folio_mark_dirty(folio);
> >
> 
> Sorry, my original words are confusing.  Yes, there's dirty bit syncing
> in try_to_migrate_one().  But I don't find that in migrate_device.c
> 
>  $ grep dirty mm/migrate_device.c
> 				if (pte_soft_dirty(pte))
> 					swp_pte = pte_swp_mksoft_dirty(swp_pte);
> 				if (pte_swp_soft_dirty(pte))
> 					swp_pte = pte_swp_mksoft_dirty(swp_pte);
> 			entry = pte_mkwrite(pte_mkdirty(entry));
> 
> I guess that migrate_device.c is used to migrate between CPU visible
> page to CPU un-visible page (device visible), so the rule is different?

IIUC migrate_vma_collect() handles migrations for both directions (RAM <->
device mem).

Yeah, indeed I also didn't see how migrate_vma_collect_pmd() handles the
carry-over of pte dirty to page dirty, which looks a bit odd.  I also don't
see why the dirty bit doesn't need to be maintained, e.g. when a previous
page was dirty then after migration of ram->dev->ram it seems to be clean
with current code.

Another scenario is, even if the page was clean, as long as page migrated
to device mem, device DMAed to the page, then page migrated back to RAM.  I
also didn't see how we could detect the DMAs and set pte/page dirty
properly after migrated back.

Copy Alistair and Jason..

-- 
Peter Xu

