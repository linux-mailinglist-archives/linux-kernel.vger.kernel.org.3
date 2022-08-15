Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ACA4593F83
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 23:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347457AbiHOVSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 17:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244087AbiHOVJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 17:09:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D72D255082
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 12:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660591134;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=trYiUZWGHSUh+Fi/mUD7Vj9TWPb8FmuPVtaP1Bo49SM=;
        b=Sp3BtlDzZGXKUSB5ED1mDrxz5KXpE5SdfJnFXsyMdu9keO69E5vaxuC4c0/sahVHWvNmIb
        Xssf6QUmC1z/cyIRyRZf7CpG5dEvoYywKz0jjb4S+tzgGayZT+DGD2Io7f24l4iI4qzOKC
        31fKxjW8qO+IVIPhvcepG92DmWfEMrU=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-520-_zc38eWzOaCR0ifSMl8uyQ-1; Mon, 15 Aug 2022 15:18:53 -0400
X-MC-Unique: _zc38eWzOaCR0ifSMl8uyQ-1
Received: by mail-qk1-f198.google.com with SMTP id j19-20020a05620a289300b006b949aff6ddso7642890qkp.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 12:18:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=trYiUZWGHSUh+Fi/mUD7Vj9TWPb8FmuPVtaP1Bo49SM=;
        b=DPUrmudcmhvc21eIcK+YJAp+S6C4exydKKEb2zLxyRM5KP/TkWEjLAkQ0lQY0vaR6E
         EcAa6h2hClwzBxfrB7A4s7Kld8UqZrcNLUBDQ+R1kdVaY2GR6XOZoxRdGGfU1kAO68n6
         CBYzFlJx0dytE2p0yjLXv1IHX0aJphbTrY1XByc6EWtbB1uUUaKEJnGHmRFGItz8vl+h
         9y3q7QZu/9j8jtSh0ZUve68hRGoNgZ1HwyfNxkr/66cO4G8uKd+vTje9gOtO+Df97LUI
         jNmhWQTfatvBbACdYs6CAtJTnEYJu70tX+NBuqWP439TNixTOyHs/dJM1d66cGcxB8NN
         w01A==
X-Gm-Message-State: ACgBeo1GpJEatwPxZc+Ma/lQTSx5Qi7md2h/ueAFBTma+lmEmVbias2l
        uA8XP0WhWzHsdnlkDiqpxLphg1xG5FXpUPrWPUm/R3qT+ymIA/DmTuhFaW9PJBrIYae7XMXz9ch
        9MPPcU2l3rhfLf8s93fn5U5RW
X-Received: by 2002:a05:622a:30d:b0:343:63d1:3751 with SMTP id q13-20020a05622a030d00b0034363d13751mr15450249qtw.679.1660591133251;
        Mon, 15 Aug 2022 12:18:53 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6J0tMp+p84xYVRm1RNDQxrWF79DfIoMrksUSH4K5nPKwTdkxuhOXkdYZ5vNOGu4LScwGYtJQ==
X-Received: by 2002:a05:622a:30d:b0:343:63d1:3751 with SMTP id q13-20020a05622a030d00b0034363d13751mr15450229qtw.679.1660591133009;
        Mon, 15 Aug 2022 12:18:53 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id bs30-20020a05620a471e00b006b910e588a4sm9888488qkb.129.2022.08.15.12.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 12:18:52 -0700 (PDT)
Date:   Mon, 15 Aug 2022 15:18:50 -0400
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
Subject: Re: [PATCH v3 5/7] mm: Remember young/dirty bit for page migrations
Message-ID: <YvqcGq44oonHNyCO@xz-m1.local>
References: <20220809220100.20033-1-peterx@redhat.com>
 <20220809220100.20033-6-peterx@redhat.com>
 <YvUeB0jc6clz59z5@xz-m1.local>
 <87pmh6dwdr.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87pmh6dwdr.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 12, 2022 at 10:32:48AM +0800, Huang, Ying wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Tue, Aug 09, 2022 at 06:00:58PM -0400, Peter Xu wrote:
> >> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
> >> index 27fb37d65476..699f821b8443 100644
> >> --- a/mm/migrate_device.c
> >> +++ b/mm/migrate_device.c
> >> @@ -221,6 +221,10 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
> >>  			else
> >>  				entry = make_readable_migration_entry(
> >>  							page_to_pfn(page));
> >> +			if (pte_young(pte))
> >> +				entry = make_migration_entry_young(entry);
> >> +			if (pte_dirty(pte))
> >> +				entry = make_migration_entry_dirty(entry);
> >>  			swp_pte = swp_entry_to_pte(entry);
> >>  			if (pte_present(pte)) {
> >>  				if (pte_soft_dirty(pte))
> >
> > This change needs to be wrapped with pte_present() at least..
> >
> > I also just noticed that this change probably won't help anyway because:
> >
> >   (1) When ram->device, the pte will finally be replaced with a device
> >       private entry, and device private entry does not yet support A/D, it
> >       means A/D will be dropped again,
> >
> >   (2) When device->ram, we are missing information on either A/D bits, or
> >       even if device private entries start to suport A/D, it's still not
> >       clear whether we should take device read/write into considerations
> >       too on the page A/D bits to be accurate.
> >
> > I think I'll probably keep the code there for completeness, but I think it
> > won't really help much until more things are done.
> 
> It appears that there are more issues.  Between "pte = *ptep" and pte
> clear, CPU may set A/D bit in PTE, so we may need to update pte when
> clearing PTE.

Agreed, I didn't see it a huge problem with current code, but it should be
better in that way.

> And I don't find the TLB is flushed in some cases after PTE is cleared.

I think it's okay to not flush tlb if pte not present.  But maybe you're
talking about something else?

Thanks,

-- 
Peter Xu

