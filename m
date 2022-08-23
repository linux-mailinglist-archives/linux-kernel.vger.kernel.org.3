Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9758859EDEA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 23:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbiHWVBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 17:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiHWVBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 17:01:48 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901757E837
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 14:01:46 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id p6so15306514vsr.9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 14:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=pO7ZqfRiAmnavkU8GmZ06Kcz4TLBMS10b+H3mC3wfmU=;
        b=OVGYBmdyPJ8RRrVeNjcQD3+Vq4FTxBUG+dj4v4VrW40FjbP+uLaK80uyXaHoGi3pYd
         Nps0IxRCRhlJJZZL66k1c2eYBrBNCZEUz4hLFXZbXNFnBXZT7l8orRKsAS3lAF4JO8rp
         abCtDO2uJepmv+wMMo/k4GcRE9k7pNRdYcTE7J6eKAg3zM5U5gYUMkfJQXly/WbI7Ct2
         TjqPyvCZZGPgfy9hT9rrNaYN5w8S4eiuiA8yVOht4sObJnUWJ4tVWH6BWeKgItVpp+CX
         RbwZMUP/ee+xhz1KPgTOblF3/wQ2aDRQEYvoDa5VoH4llMnXfYNacxwq5/0SN7sCxGUp
         Zxjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=pO7ZqfRiAmnavkU8GmZ06Kcz4TLBMS10b+H3mC3wfmU=;
        b=D4/KuJm3qe3j3bxsRphgBdk2Tth0FaJH41QqX/f2rAqFD0BTKz9lEFLw5Teb2sqS1w
         PXtHaVkqFWGupm4RZY/Lvns4SCRx8K0UUMketwbWAfQ2dL/3lII8cw3uEa2JcKzE8N6O
         4wbA/mKVBuRZMry1t3/MZHPD0ZUGM51b2goE5MG9LrpxmfrLZHxWKKoYlJGXMXyDGn4b
         J2qvY2LWbC2TC3VWotPv2pMtUZqm9ECxLdBj4k7OTc8b0R4e4sZFdQEB1a1Zy33zjeYr
         eXeGZljBiv2+1wcY5B/9h/SYvKTWc7pQxue37oYXstwJv8EDas0KWap0c/eQ0nExhOyT
         zBSQ==
X-Gm-Message-State: ACgBeo0n3dEZgmrjmIvwSycChNdi0psrnE5lgjFkE8Fjx0AJxn92dpE2
        YBTgHW4L5bGDeJcTvXnyADnmRk0ISYWzxMdH4QrYo0YtSr7JxrLi
X-Google-Smtp-Source: AA6agR61EaCs5pkD4JW0vpgV7j5D9H/ME8bnIG4kRzC8Mj9moq2yJIOm6N7SLV6Cl5LVKp8JI2qh5mo1Jz1pHeGfqkk=
X-Received: by 2002:a05:6102:3005:b0:390:5c54:7aea with SMTP id
 s5-20020a056102300500b003905c547aeamr4855722vsa.50.1661288505413; Tue, 23 Aug
 2022 14:01:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220811161331.37055-1-peterx@redhat.com> <20220811161331.37055-4-peterx@redhat.com>
 <87lerudwcb.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87lerudwcb.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Tue, 23 Aug 2022 15:01:09 -0600
Message-ID: <CAOUHufaVC2Za-p8m0aiHw6YkheDcrO-C3wRGixwDS32VTS+k1w@mail.gmail.com>
Subject: Re: [PATCH v4 3/7] mm/swap: Add swp_offset_pfn() to fetch PFN from
 swap entry
To:     Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     "Huang, Ying" <ying.huang@intel.com>,
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2022 at 8:33 PM Huang, Ying <ying.huang@intel.com> wrote:
>
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
> LGTM, Thanks!
>
> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

Hi,

I hit the following crash on mm-everything-2022-08-22-22-59. Please take a look.

Thanks.

  kernel BUG at include/linux/swapops.h:117!
  CPU: 46 PID: 5245 Comm: EventManager_De Tainted: G S         O L
6.0.0-dbg-DEV #2
  RIP: 0010:pfn_swap_entry_to_page+0x72/0xf0
  Code: c6 48 8b 36 48 83 fe ff 74 53 48 01 d1 48 83 c1 08 48 8b 09 f6
c1 01 75 7b 66 90 48 89 c1 48 8b 09 f6 c1 01 74 74 5d c3 eb 9e <0f> 0b
48 ba ff ff ff ff 03 00 00 00 eb ae a9 ff 0f 00 00 75 13 48
  RSP: 0018:ffffa59e73fabb80 EFLAGS: 00010282
  RAX: 00000000ffffffe8 RBX: 0c00000000000000 RCX: ffffcd5440000000
  RDX: 1ffffffffff7a80a RSI: 0000000000000000 RDI: 0c0000000000042b
  RBP: ffffa59e73fabb80 R08: ffff9965ca6e8bb8 R09: 0000000000000000
  R10: ffffffffa5a2f62d R11: 0000030b372e9fff R12: ffff997b79db5738
  R13: 000000000000042b R14: 0c0000000000042b R15: 1ffffffffff7a80a
  FS:  00007f549d1bb700(0000) GS:ffff99d3cf680000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 0000440d035b3180 CR3: 0000002243176004 CR4: 00000000003706e0
  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
  Call Trace:
   <TASK>
   change_pte_range+0x36e/0x880
   change_p4d_range+0x2e8/0x670
   change_protection_range+0x14e/0x2c0
   mprotect_fixup+0x1ee/0x330
   do_mprotect_pkey+0x34c/0x440
   __x64_sys_mprotect+0x1d/0x30
