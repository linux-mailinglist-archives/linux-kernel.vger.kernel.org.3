Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40F0C58ECE8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 15:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbiHJNRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 09:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232520AbiHJNRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 09:17:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3F4261CB0E
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 06:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660137426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2VZ6L8jjXf4+HOhHElVvMwLB5fdp2KKJb8m9wQU3YtY=;
        b=bDXK8Nw6e7YkaRRJIKAYrEZEktwqU2rvRMMN5+73JR2jDhJZB4V8Tm+Nrwt5wFqQUx8zWM
        1xCBD6dXMozkfyIi6qK4WwsmT5DKjWA5FACRVTVtfr04f1/xzVKKw4xJE01O8BssrA4X8q
        KP+OHg/NoAT7EiUARa+KhZr492Ip/OY=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-320-sgACFe41NSWsOpHqs8SG2g-1; Wed, 10 Aug 2022 09:17:05 -0400
X-MC-Unique: sgACFe41NSWsOpHqs8SG2g-1
Received: by mail-il1-f199.google.com with SMTP id j13-20020a056e02154d00b002de828b4b63so10566593ilu.10
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 06:17:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=2VZ6L8jjXf4+HOhHElVvMwLB5fdp2KKJb8m9wQU3YtY=;
        b=cjJUGUPrlPSk9bbP8GJNh/hH1N6cgZ/4Ju06rebgMS5QwbCoRGbbF9li803irE8XFK
         9gwy9kxFMxFdsStN1SPEZDPx5IkkLk65oaFPSIFl6+F/9qIYDq8tdUw0rbqhPkoSfFu+
         voRJ8Q8LzMLQ233oEw295gZKdQ9VsxVFnZeY2flO3NsdPvWQVMDw721H273ORHPTIqY9
         wolejrKOxwQbdXc+/JidYhb99eMOdd6eYat9bA/z1MNcfHNElxco9i3WKmI/JIcuc/ZA
         /5yia5yQAzucPleUWa0L9SqDw7QW7RLxN3oT194yYu9KzlDZAdjfiCYgkp4dpWyKTJFo
         q67w==
X-Gm-Message-State: ACgBeo0YtNmKLV3vhmdIVmBujRkDQebgLNXT/k4jHwwxP0c/m+k+Z+mN
        xif2a5181lBu8Tic70ANxqiIErMUpY2y96CxYrp6fFfvho8/aX1RllusMbI+wZZfdePk76wFmiK
        YYHCok3yvPs7V+9QyvRuUFds6
X-Received: by 2002:a05:6e02:194d:b0:2df:8893:90bb with SMTP id x13-20020a056e02194d00b002df889390bbmr11119672ilu.242.1660137424949;
        Wed, 10 Aug 2022 06:17:04 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5yHoOuiq0aiGRx8np1v5C3vWpminLzjsgvwmOQ0Z4YZquxeRyC22w1yGAli2b2E00QDBrpkA==
X-Received: by 2002:a05:6e02:194d:b0:2df:8893:90bb with SMTP id x13-20020a056e02194d00b002df889390bbmr11119657ilu.242.1660137424674;
        Wed, 10 Aug 2022 06:17:04 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id q28-20020a02a99c000000b003431865d3c6sm2865412jam.7.2022.08.10.06.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 06:17:04 -0700 (PDT)
Date:   Wed, 10 Aug 2022 09:17:02 -0400
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
Subject: Re: [PATCH v3 3/7] mm/swap: Add swp_offset_pfn() to fetch PFN from
 swap entry
Message-ID: <YvOvzk76oQskFZKX@xz-m1.local>
References: <20220809220100.20033-1-peterx@redhat.com>
 <20220809220100.20033-4-peterx@redhat.com>
 <87bkssfxcf.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87bkssfxcf.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2022 at 02:04:32PM +0800, Huang, Ying wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > We've got a bunch of special swap entries that stores PFN inside the swap
> > offset fields.  To fetch the PFN, normally the user just calls swp_offset()
> > assuming that'll be the PFN.
> >
> > Add a helper swp_offset_pfn() to fetch the PFN instead, fetching only the
> > max possible length of a PFN on the host, meanwhile doing proper check with
> > MAX_PHYSMEM_BITS to make sure the swap offsets can actually store the PFNs
> > properly always using the BUILD_BUG_ON() in is_pfn_swap_entry().
> >
> > One reason to do so is we never tried to sanitize whether swap offset can
> > really fit for storing PFN.  At the meantime, this patch also prepares us
> > with the future possibility to store more information inside the swp offset
> > field, so assuming "swp_offset(entry)" to be the PFN will not stand any
> > more very soon.
> >
> > Replace many of the swp_offset() callers to use swp_offset_pfn() where
> > proper.  Note that many of the existing users are not candidates for the
> > replacement, e.g.:
> >
> >   (1) When the swap entry is not a pfn swap entry at all, or,
> >   (2) when we wanna keep the whole swp_offset but only change the swp type.
> >
> > For the latter, it can happen when fork() triggered on a write-migration
> > swap entry pte, we may want to only change the migration type from
> > write->read but keep the rest, so it's not "fetching PFN" but "changing
> > swap type only".  They're left aside so that when there're more information
> > within the swp offset they'll be carried over naturally in those cases.
> >
> > Since at it, dropping hwpoison_entry_to_pfn() because that's exactly what
> > the new swp_offset_pfn() is about.
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> 
> The patch itself looks good.  But I searched swp_entry() in kernel
> source code, and found that we need to do more.
> 
> For example, in pte_to_pagemap_entry()
> 
> 			frame = swp_type(entry) |
> 				(swp_offset(entry) << MAX_SWAPFILES_SHIFT);
> 
> If it's a migration entry, we need
> 
> 			frame = swp_type(entry) |
> 				(swp_offset_pfn(entry) << MAX_SWAPFILES_SHIFT);
> 
> So I think you need to search all swp_offset() calling in the kernel
> source and check whether they need to be changed.

Yeah I actually looked at all of them and explicitly left this one since I
wanted to dump the whole swp entry - even if it's called "show_pfn" it was
actually dumping the whole entries always, e.g., for genuine swap entries I
don't think it's PFN stored in swp offset, so it's nothing about PFN but
swp offset itself, IMHO.

But after a second thought I agree it should be specially handled here,
because the user app could be relying offset to be pfn for migration
entries.  The other thing is I'm not sure whether the encoding of pagemap
entries can always fit for both pfn and A/D bits (majorly, PM_PFRAME_MASK)
even if the arch swap pte fits; it needs more math.  So unless necessary,
it'll be good to still make the A/D bits internal to kernel too.

Thanks for the careful review, I'll fix that.

-- 
Peter Xu

