Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8043254DEC6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 12:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376366AbiFPKQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 06:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345993AbiFPKQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 06:16:42 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E9C5D659
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 03:16:41 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 123so837175pgb.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 03:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iPRG78ac7inBmDs1bk7VF2TAFXWPtFDuV+zoozPjimU=;
        b=A9BdQs8S2qTsKhErtvYF/3G0zmeLlzOdl4btPSNB3FyyFs1x3UC3h3qL9eNtq+dVld
         VDz/kR9rVZHVnxvn2Kbq3A852qM4i8OWBZ733LuXzRvdM8KgiJQqRx3tfnpE1dd9ABSY
         9DcUHpd0B9PibMBgkl/XzYVbSC8odtUH0+d3y9SGO7Ecr23B60+ImxriniFlHXjprAqA
         8aJBb7gQ1EYrd9jr2E37p7NxNszZVoklj5chq6ZjrcrlpYAv4HvneGg2sE1gIEi1OuXt
         0Ev4M1Lx+dJuVy8mVzT4AnBpc4vJBk8w6UKKNuf1C5/2e147UaWRfmFV6x+lXhMH7ncd
         jzAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iPRG78ac7inBmDs1bk7VF2TAFXWPtFDuV+zoozPjimU=;
        b=oDovJSzztOn+cHSFqubYwzV4JQ6VDSXpyJc2cQYPIN0t+Bod3jyGm4u0MjA9FhOzsV
         JO8ECARqu5MnAy+TQTFNOWaIvUW7LvKwk0GCztp2QBT01Gawbpaffo3xDJolB9ZFZ7CL
         wfjZLBDM+7gxz1k9CwQoHd5SjaT9MkKKuiCbmg9MlkSiKYMbXaL5/UkK9OlK5KwsP4NC
         54EOT2eCMg3UI+ylR7WwJlIxCWr4GCqG6nLjv5q+M7K573wJfAbS2DfYbeKnXBGi0U19
         5uDuKeymjFLQ9nvskX/aLnBFwyccm6RHLBr4Qs0WuZHh5KgNO+EH161DRp6ijqKpProC
         ulxw==
X-Gm-Message-State: AJIora8uuf/bIbCKDmo/0wQ0i9QxqBpIQhfXfROknZY1T79oAkwfb/Vb
        tgxHwgzXAAEdfXoQZu+af2gutQ==
X-Google-Smtp-Source: AGRyM1vgeCdn+EFaZZ8SW1oYuIciTRc5/67yBPikjMuukfUd9Gv2GE4VScrC72M8C/IOKqlNyjOWgQ==
X-Received: by 2002:a05:6a00:2344:b0:51c:157f:83d5 with SMTP id j4-20020a056a00234400b0051c157f83d5mr4056234pfj.5.1655374600828;
        Thu, 16 Jun 2022 03:16:40 -0700 (PDT)
Received: from localhost ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id t5-20020a1709027fc500b001690d398401sm214048plb.88.2022.06.16.03.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 03:16:40 -0700 (PDT)
Date:   Thu, 16 Jun 2022 18:16:36 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     corbet@lwn.net, akpm@linux-foundation.org, paulmck@kernel.org,
        mike.kravetz@oracle.com, osalvador@suse.de,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com, smuchun@gmail.com
Subject: Re: [PATCH v2 2/2] mm: memory_hotplug: introduce
 SECTION_CANNOT_OPTIMIZE_VMEMMAP
Message-ID: <YqsDBPslAQ6IJZ6P@FVFYT0MHHV2J.usts.net>
References: <20220520025538.21144-1-songmuchun@bytedance.com>
 <20220520025538.21144-3-songmuchun@bytedance.com>
 <53024884-0182-df5f-9ca2-00652c64ce36@redhat.com>
 <YqqZOj+zby1fLGv/@FVFYT0MHHV2J.usts.net>
 <abf6bd60-b944-100e-b327-97365d366ed8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abf6bd60-b944-100e-b327-97365d366ed8@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 09:21:35AM +0200, David Hildenbrand wrote:
> On 16.06.22 04:45, Muchun Song wrote:
> > On Wed, Jun 15, 2022 at 11:51:49AM +0200, David Hildenbrand wrote:
> >> On 20.05.22 04:55, Muchun Song wrote:
> >>> For now, the feature of hugetlb_free_vmemmap is not compatible with the
> >>> feature of memory_hotplug.memmap_on_memory, and hugetlb_free_vmemmap
> >>> takes precedence over memory_hotplug.memmap_on_memory. However, someone
> >>> wants to make memory_hotplug.memmap_on_memory takes precedence over
> >>> hugetlb_free_vmemmap since memmap_on_memory makes it more likely to
> >>> succeed memory hotplug in close-to-OOM situations.  So the decision
> >>> of making hugetlb_free_vmemmap take precedence is not wise and elegant.
> >>> The proper approach is to have hugetlb_vmemmap.c do the check whether
> >>> the section which the HugeTLB pages belong to can be optimized.  If
> >>> the section's vmemmap pages are allocated from the added memory block
> >>> itself, hugetlb_free_vmemmap should refuse to optimize the vmemmap,
> >>> otherwise, do the optimization.  Then both kernel parameters are
> >>> compatible.  So this patch introduces SECTION_CANNOT_OPTIMIZE_VMEMMAP
> >>> to indicate whether the section could be optimized.
> >>>
> >>
> >> In theory, we have that information stored in the relevant memory block,
> >> but I assume that lookup in the xarray + locking is impractical.
> >>
> >> I wonder if we can derive that information simply from the vmemmap pages
> >> themselves, because *drumroll*
> >>
> >> For one vmemmap page (the first one), the vmemmap corresponds to itself
> >> -- what?!
> >>
> >>
> >> [	hotplugged memory	]
> >> [ memmap ][      usable memory	]
> >>       |    |                    |
> >>   ^---     |                    |
> >>    ^-------                     |
> >>          ^----------------------
> >>
> >> The memmap of the first page of hotplugged memory falls onto itself.
> >> We'd have to derive from actual "usable memory" that condition.
> >>
> >>
> >> We currently support memmap_on_memory memory only within fixed-size
> >> memory blocks. So "hotplugged memory" is guaranteed to be aligned to
> >> memory_block_size_bytes() and the size is memory_block_size_bytes().
> >>
> >> If we'd have a page falling into usbale memory, we'd simply lookup the
> >> first page and test if the vmemmap maps to itself.
> >>
> > 
> > I think this can work. Should we use this approach in next version?
> > 
> 
> Either that or more preferable, flagging the vmemmap pages eventually.
> That's might be future proof.
>

All right. I think we can go with the above approach, we can improve it
to flagging-base approach in the future if needed.

> >>
> >> Of course, once we'd support variable-sized memory blocks, it would be
> >> different.
> >>
> >>
> >> An easier/future-proof approach might simply be flagging the vmemmap
> >> pages as being special. We reuse page flags for that, which don't have
> >> semantics yet (i.e., PG_reserved indicates a boot-time allocation via
> >> memblock).
> >>
> > 
> > I think you mean flag vmemmap pages' struct page as PG_reserved if it
> > can be optimized, right? When the vmemmap pages are allocated in
> > hugetlb_vmemmap_alloc(), is it valid to flag them as PG_reserved (they
> > are allocated from buddy allocator not memblock)?
> > 
> 
> Sorry I wasn't clear. I'd flag them with some other
> not-yet-used-for-vmemmap-pages flag. Reusing PG_reserved could result in
> trouble.
>

Sorry. I thought you suggest reusing "PG_reserved". My bad misreading.

Thanks.
