Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCFEF578CCA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 23:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235437AbiGRVe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 17:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236035AbiGRVeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 17:34:22 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3B428724
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 14:34:20 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id l14so7412438qtv.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 14:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=suUG4NbxQ9Jc3ynJZYSSIg0ST38XjFLBT9pq2CkXbaQ=;
        b=b0pxV4EfxBXsSBC2H3gma7vsR1kQNKR2IEM+ZlJTjB6+KE9bMMdkfPugTlRcm2Gy7o
         F50+Slq8nFJGAmp1b4+kcJ/PmUSNBSl5P5T8cZZRupf5GdWDpZlvxo4kUaJ7zIuVnZ/k
         o1ncUXcuiKonkqAuQyuo11YJCxDbb+JK7S+NTTJ8wi8gCdd0+dCkdUE9EEQ6yjVmRsRM
         8S2jTk9A3MaoTdXAxDbqpN2H2jcs4y/wGQJ4zJQDkt0vu4OXSNv14Hn1sP7spyXBPO8n
         VUbV6mFd4MJQSsvqp2Mr1WARi5qZDfM9soD3kVT0qVkhTkdvBBuE3tgdhNZuWz4nQjOR
         9c2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=suUG4NbxQ9Jc3ynJZYSSIg0ST38XjFLBT9pq2CkXbaQ=;
        b=HXjqANZFHGDnKvAuoTWbKlFjRPIo4mrtb4d9ZS7LK9wmnHsYJtu5/VjrhyIZESvR29
         62cxu/lqL4V0ZwL5JCr18SiawQtC0/A+K+rI0DlByJHa3j4bh70jt52qXQT5wiT3hFoQ
         Qsar77KH8/v/6ZzloFlq+wE9FbUTJdRw6sdKDb5ILw9xHSuvA6LVHW4ZHdNGvw66Ko4j
         PTPUn20Ca4mBxg3+xN6YNEAQsyd4fxEyn28EhswHr+V6bi717W/GrD45Lx0R+E54gmS1
         obnm75UUyI99OD+eFo/E8YcDS6vZRHl5I/IIm49Das/j8IvX/92acCIihnXXlw/40mX9
         YhUw==
X-Gm-Message-State: AJIora+uz+NEO6yRzhyvmhxCSaMTdBAaLPGrRk0Jb1GMyO6WERAb2Ges
        EZNoqsY2gqBr6F1DfHrUBTtJGg==
X-Google-Smtp-Source: AGRyM1uQvjddRJ8GTU4jNcb8q7gfa6t0XJN3XwYL2TU+081VWIyu/CfILm0ovHBg/Rjy20DpC/4D9w==
X-Received: by 2002:ac8:5f09:0:b0:31e:9704:dfab with SMTP id x9-20020ac85f09000000b0031e9704dfabmr22960730qta.375.1658180059610;
        Mon, 18 Jul 2022 14:34:19 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id ez12-20020a05622a4c8c00b0031eb0bb5c3csm10047906qtb.28.2022.07.18.14.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 14:34:18 -0700 (PDT)
Date:   Mon, 18 Jul 2022 14:34:01 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Liam Howlett <liam.howlett@oracle.com>
cc:     Hugh Dickins <hughd@google.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] maple_tree: Fix sparse reported issues
In-Reply-To: <20220718174733.dya2xjigqeud6clx@revolver>
Message-ID: <a6736ccf-fb45-5777-ca28-575297f1879f@google.com>
References: <20220713132926.3sl7gs67dyjj7kit@revolver> <44a478e8-2ccc-e82-bd5a-172778c01529@google.com> <20220713175013.aoemaelds45aavc4@revolver> <20220715195301.r7ozt6ph2scti7vz@revolver> <fc9c2193-f5d7-d494-8e4e-c9f340ae8625@google.com>
 <20220718022718.wtlw7grwp6dv5fcp@revolver> <1098dd4d-8f12-4493-5aff-1ee489d8e7@google.com> <20220718125649.cpatlh7ublgf7bvg@revolver> <20220718134541.ucbpuqdfcnfxravx@revolver> <7db5a8c5-9084-a7fe-6e83-713e52ed8539@google.com>
 <20220718174733.dya2xjigqeud6clx@revolver>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Jul 2022, Liam Howlett wrote:
> > 
> > I said before that I expected the test run to hit the swapops.h
> > migration entry !PageLocked BUG, but it did not.  It ran for
> > nearly 7 hours, and then one of its builds terminated with
> > 
> > {standard input}: Assembler messages:
> > {standard input}: Error: open CFI at the end of file;
> >  missing .cfi_endproc directive
> > gcc: fatal error: Killed signal terminated program cc1
> > compilation terminated.
> > 
> > which I've never seen before.  Usually I'd put something like that down
> > to a error in swap, or a TLB flushing error (but I include Nadav's fix
> > in my kernel, and wouldn't get very far without it): neither related to
> > the maple tree patchset.
> > 
> > But on this occasion, my guess is that it's actually an example of what
> > the swapops.h migration entry !PageLocked BUG is trying to alert us to.
> > 
> > Imagine when such a "stale" migration entry is found, but the page it
> > points to (now reused for something else) just happens to be PageLocked
> > at that instant.  Then the BUG won't fire, and we proceed to use the
> > page as if it's ours, but it's not.  I think that's what happened.
> > 
> > I must get on with the day: more testing, and thinking.
> 
> 
> I think this is the same issue seen here:
> https://lore.kernel.org/linux-mm/YsQt3IHbJnAhsSWl@casper.infradead.org/

Yes, that's a swapops.h migration entry !PageLocked BUG on brk.

> 
> Note that on 20220616, the maple tree was in the next.
> 
> I suspect I am doing something wrong in do_brk_munmap().  I am using a
> false VMA to munmap a partial vma by setting it up like the part of the
> VMA that would have been split, inserted into the tree, then removed and
> freed.  I must be missing something necessary for this to function
> correctly.

Thanks for pointing to that, yes, the vma_init(&unmap, mm) etc in
do_brk_munmap(): I hadn't noticed struct vma_area_struct unmap before.

And almost coincident with your mail, my next test run crashed on
kernel BUG at mm/huge_memory.c:2013, VM_BUG_ON_VMA(vma->vm_start > haddr),
in __split_huge_pmd_locked(), while servicing do_brk_munmap():
no doubt for a (different but) related reason.

Presumably you noticed an opportunity to optimize out some maple tree
operations by giving do_brk_munmap() its own processing.  But I think
you're going to have to undo all that, and make do_brk_munmap() do
things in the standard, less direct, munmap() way - using
do_mas_align_munmap() I presume.

(Oh dear, I see that doing mas_preallocate() at the beginning,
but then __split_vma()s inside, and __split_vma() will do a
vma_adjust(), which will do a mas_preallocate().  Ah, but they
are on distinct "mas"es at different levels, so it's probably okay.)

If rmap is to be sure to find migration entries that it inserted
earlier, you must hold anon_vma_lock_write() (in the brk case) across
the tricky vma manipulations.  No doubt you could write an optimized
do_brk_munmap() which does everything under anon_vma_lock_write(), but
you'd then be duplicating far too much of the care in __vma_adjust()
for my taste (I'm already not so happy to find it duplicated in
vma_expand()).

I'll continue with some testing, but expect it to keep hitting these
issues until do_brk_munmap() is rewritten - perhaps it reduces to
little more than a wrapper like do_munmap() or do_mas_munmap().

Hugh
