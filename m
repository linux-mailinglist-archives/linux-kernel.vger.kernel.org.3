Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4FD959EE96
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 00:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbiHWWFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 18:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiHWWFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 18:05:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478E5659E1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 15:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661292302;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R2o9KL5zJfRlNaW0ivmyyVUxydW3mUT+lo+e3IQKKzo=;
        b=D/ReJvxO7bWV3nlSO/NtM9lNWwYhqqlg6knIdTqHpeaSjQT+CfLqbHlUJfJ/BqvqLceH3x
        feiViJEUm4F2nInKk9rm5FSOCjn4873S5W9chcTqsExncDMsqhbcIy1ipUvLBXfVMTiuc5
        DjsdgN18pbzSrClmwEJ5M3jE44D3jZ4=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-73-YJmEwt4eMmaU16ghb-Vtlw-1; Tue, 23 Aug 2022 18:04:53 -0400
X-MC-Unique: YJmEwt4eMmaU16ghb-Vtlw-1
Received: by mail-qv1-f69.google.com with SMTP id ly9-20020a0562145c0900b00496e3810e40so4217186qvb.12
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 15:04:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=R2o9KL5zJfRlNaW0ivmyyVUxydW3mUT+lo+e3IQKKzo=;
        b=plCzRNX3uG3dKbVgATbD8daiYe7Cn5824o6EW0YIqpTgHnwR7Ch2xYKVzltX21bidr
         ev+DjBdGUsnwaxHaMsD8hHbrPXVDmFnWhj8jjDAZf7YZjpJF9elSu5O4ZZUlt9+nYeqV
         O+xIBBlkLIwQloaanMENz+ls8Z8UwwuK0jPkW1VVKu9Dz8gWdH2faE1r0lGfhL2CuA0w
         1vHBhs/om9YOuy+XAyjiNlAap0SZBK6pY7bZ+oKeQZUpFe8vUhUm4M6v53BPImvdq8kD
         qf+8Q2OYzAr0FsZl1Thg1kks/9yLPudkXY7AJtYzEz6QQwbD4MJUG+W25HAon5pGZm1F
         w0Vg==
X-Gm-Message-State: ACgBeo0xa9Twof1TIz0Ya//l0cXg5Y4SDskwJHwJvehHixDDv/+8EEFl
        ToJ6l6qzUye/E3D+CH9hPh+5PM2oHAnpXzmDUDQf9IuVrs6fATCBeJxmxQBzEIDEhAzYhIcEMM6
        14b3qCqirA679Nyew4ED2Osl1
X-Received: by 2002:ac8:5bcd:0:b0:343:7d45:ee05 with SMTP id b13-20020ac85bcd000000b003437d45ee05mr21566031qtb.653.1661292292942;
        Tue, 23 Aug 2022 15:04:52 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4EUSU9wZacJpr3l6kWOwcXBazf6jqi3Mt/oSu6SfGvNLvUWP2Cr6dhy4eV3Vp7pKAzN+m6vw==
X-Received: by 2002:ac8:5bcd:0:b0:343:7d45:ee05 with SMTP id b13-20020ac85bcd000000b003437d45ee05mr21566000qtb.653.1661292292702;
        Tue, 23 Aug 2022 15:04:52 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id s21-20020ac85295000000b00343028a9425sm11334798qtn.16.2022.08.23.15.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 15:04:52 -0700 (PDT)
Date:   Tue, 23 Aug 2022 18:04:50 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Huang, Ying" <ying.huang@intel.com>,
        Linux-MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Alistair Popple <apopple@nvidia.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v4 3/7] mm/swap: Add swp_offset_pfn() to fetch PFN from
 swap entry
Message-ID: <YwVPArKuo+bWxe6e@xz-m1.local>
References: <20220811161331.37055-1-peterx@redhat.com>
 <20220811161331.37055-4-peterx@redhat.com>
 <87lerudwcb.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CAOUHufaVC2Za-p8m0aiHw6YkheDcrO-C3wRGixwDS32VTS+k1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOUHufaVC2Za-p8m0aiHw6YkheDcrO-C3wRGixwDS32VTS+k1w@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022 at 03:01:09PM -0600, Yu Zhao wrote:
> On Thu, Aug 11, 2022 at 8:33 PM Huang, Ying <ying.huang@intel.com> wrote:
> >
> > Peter Xu <peterx@redhat.com> writes:
> >
> > > We've got a bunch of special swap entries that stores PFN inside the swap
> > > offset fields.  To fetch the PFN, normally the user just calls swp_offset()
> > > assuming that'll be the PFN.
> > >
> > > Add a helper swp_offset_pfn() to fetch the PFN instead, fetching only the
> > > max possible length of a PFN on the host, meanwhile doing proper check with
> > > MAX_PHYSMEM_BITS to make sure the swap offsets can actually store the PFNs
> > > properly always using the BUILD_BUG_ON() in is_pfn_swap_entry().
> > >
> > > One reason to do so is we never tried to sanitize whether swap offset can
> > > really fit for storing PFN.  At the meantime, this patch also prepares us
> > > with the future possibility to store more information inside the swp offset
> > > field, so assuming "swp_offset(entry)" to be the PFN will not stand any
> > > more very soon.
> > >
> > > Replace many of the swp_offset() callers to use swp_offset_pfn() where
> > > proper.  Note that many of the existing users are not candidates for the
> > > replacement, e.g.:
> > >
> > >   (1) When the swap entry is not a pfn swap entry at all, or,
> > >   (2) when we wanna keep the whole swp_offset but only change the swp type.
> > >
> > > For the latter, it can happen when fork() triggered on a write-migration
> > > swap entry pte, we may want to only change the migration type from
> > > write->read but keep the rest, so it's not "fetching PFN" but "changing
> > > swap type only".  They're left aside so that when there're more information
> > > within the swp offset they'll be carried over naturally in those cases.
> > >
> > > Since at it, dropping hwpoison_entry_to_pfn() because that's exactly what
> > > the new swp_offset_pfn() is about.
> > >
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> >
> > LGTM, Thanks!
> >
> > Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
> 
> Hi,
> 
> I hit the following crash on mm-everything-2022-08-22-22-59. Please take a look.
> 
> Thanks.
> 
>   kernel BUG at include/linux/swapops.h:117!
>   CPU: 46 PID: 5245 Comm: EventManager_De Tainted: G S         O L
> 6.0.0-dbg-DEV #2
>   RIP: 0010:pfn_swap_entry_to_page+0x72/0xf0
>   Code: c6 48 8b 36 48 83 fe ff 74 53 48 01 d1 48 83 c1 08 48 8b 09 f6
> c1 01 75 7b 66 90 48 89 c1 48 8b 09 f6 c1 01 74 74 5d c3 eb 9e <0f> 0b
> 48 ba ff ff ff ff 03 00 00 00 eb ae a9 ff 0f 00 00 75 13 48
>   RSP: 0018:ffffa59e73fabb80 EFLAGS: 00010282
>   RAX: 00000000ffffffe8 RBX: 0c00000000000000 RCX: ffffcd5440000000
>   RDX: 1ffffffffff7a80a RSI: 0000000000000000 RDI: 0c0000000000042b
>   RBP: ffffa59e73fabb80 R08: ffff9965ca6e8bb8 R09: 0000000000000000
>   R10: ffffffffa5a2f62d R11: 0000030b372e9fff R12: ffff997b79db5738
>   R13: 000000000000042b R14: 0c0000000000042b R15: 1ffffffffff7a80a
>   FS:  00007f549d1bb700(0000) GS:ffff99d3cf680000(0000) knlGS:0000000000000000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: 0000440d035b3180 CR3: 0000002243176004 CR4: 00000000003706e0
>   DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>   DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>   Call Trace:
>    <TASK>
>    change_pte_range+0x36e/0x880
>    change_p4d_range+0x2e8/0x670
>    change_protection_range+0x14e/0x2c0
>    mprotect_fixup+0x1ee/0x330
>    do_mprotect_pkey+0x34c/0x440
>    __x64_sys_mprotect+0x1d/0x30

The VM_BUG_ON added in this patch seems to have revealed a real bug,
because we probably shouldn't call pfn_swap_entry_to_page() upon e.g. a
genuine swap pte.

I'll post a patch shortly, thanks.

-- 
Peter Xu

