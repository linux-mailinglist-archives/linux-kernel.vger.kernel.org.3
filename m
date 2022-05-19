Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 369BD52C93B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 03:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbiESBaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 21:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232424AbiESBaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 21:30:18 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6248DDFF
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 18:30:17 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id c1so3779107qkf.13
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 18:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=Vctvs+yLST0ladkxVngSqvQUozt/YOrV+kKx1mu8aJA=;
        b=HLVHydgvgbmMDpw1rj4PjhbTGGTqhSOBCKM1afw/p50es6EyWkVCtEGGecQAxyuN/D
         0odjMkW1hUryO0AvAiAHLmQXlkTJnm6tAv6y1HGh86MuGS4IvK1JVJwNpRfye+MpVDyB
         oxrT64vf4E2NlfkriEDTVvNoqrqhb+FNvs8bB2LF/hTdfGyPkGnS2YHi5Gc8aYUUjT36
         7NtkYJykqGQDpatDfRjiSmfoLcVTRtC5jDk6bKhKfbSBkuk4Xsqo4mQKYJoE3uuL/9Rx
         rN+p8QEK0sETgd7BdwMT/TXWzTPMQ/mjvf1tjgu7OfiSzx+DCeRiPeRyXy8Vsyf+p+TB
         GsxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=Vctvs+yLST0ladkxVngSqvQUozt/YOrV+kKx1mu8aJA=;
        b=GY18u7U85r9sb72s73QyWGYxB2eMX/sINwiJA1l2E4oKzgv159Lm4macw/6KEovDYm
         MV/mAWOs8eVz2UMQnx7v/xvSH7+6i9nkWpzmpldmnMJfhCoT/CfkHA9cAOmiMY4I46r8
         RlzElQFv8Vf8/gWzTgqGSDi4ZATiUCsSGtF0TX+fPNZnZ+lXd0Gia9S8l9Q446VavqfF
         2dvmxflzzJqBlbH6RmOcfPzq7pXRhfun/VBhTOnaEp0Y+NcIaTIDoBlGpvxcOnJNKlFS
         QVR923cQy1j0H3u/C1wQ/OSXmxlxl2UioX2DxJHsmuNbvrFDpBvsY7OZCH/u47xC3aMH
         CT/Q==
X-Gm-Message-State: AOAM530adpdvGHhGBS7qIOdc8ZkoeEqldIKQ6pKvlSrhe6JNiCJNxv+U
        FFiH+4nfyWwiXpex9VCYD4Cd3A==
X-Google-Smtp-Source: ABdhPJxJH+K2i0AvHY4rT9AU1ucarCVHI0V+Qi/EtshWI9oGclaUc6guPBsrY1vw6csBfv/yLrmnOA==
X-Received: by 2002:a37:9144:0:b0:69f:789b:7581 with SMTP id t65-20020a379144000000b0069f789b7581mr1617411qkd.773.1652923816375;
        Wed, 18 May 2022 18:30:16 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id b7-20020a379907000000b0069fcc501851sm496304qke.78.2022.05.18.18.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 18:30:15 -0700 (PDT)
Date:   Wed, 18 May 2022 18:30:03 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Mike Kravetz <mike.kravetz@oracle.com>
cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Hugh Dickins <hughd@google.com>, Peter Xu <peterx@redhat.com>,
        Nick Piggin <npiggin@gmail.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: vma_needs_copy always true for VM_HUGETLB ?
In-Reply-To: <a7ccd8b2-c659-44c9-cb18-1496f99aa5a8@oracle.com>
Message-ID: <872b743d-ac21-59a3-bd31-109229f63112@google.com>
References: <a7ccd8b2-c659-44c9-cb18-1496f99aa5a8@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Wed, 18 May 2022, Mike Kravetz wrote:

> For most non-anonymous vmas, we do not copy page tables at fork time, but
> rather lazily populate the tables after fork via faults.  The routine
> vma_needs_copy() is used to make this decision. For VM_HUGETLB vmas, it always
> returns true.

"vma_needs_copy()" is *very* recent coinage, not reached Linus yet.

> 
> Anyone know/remember why?  The code was added more than 15 years ago and
> my search for why hugetlb vmas were excluded came up empty.
> 
> I do not see a reason why VM_HUGETLB is in this list.  Initial testing did
> not reveal any problems when I removed the VM_HUGETLB check.
> 
> FYI - I am looking at the performance of fork and exec (unmap) of processes
> with very large hugetlb mappings.  Skipping the copy at fork time would
> certainly speed things up.  Of course, there could some users who would
> notice if hugetlb page tables are not copied at fork time.  However, this
> is the behavior for 'normal' mappings.  I am inclined to make hugetlb be
> 'more normal'.

Good question, not obvious to me either: but I've found the answer.

The commit was of course Nick's d992895ba2b2 ("[PATCH] Lazy page table
copies in fork()") in 2.6.14; but it doesn't explain why VM_HUGETLB is
there in the test, and goes on to be copied.

I haven't re-read through the whole mail thread which led to that
commit, but I think you'll find the crucial observation comes from
Andi in https://lore.kernel.org/lkml/200508251756.07849.ak@suse.de/#t

"Actually I disabled it for hugetlbfs (... !is_huge...vma). The reason 
is that lazy faulting for huge pages is still not in mainline."

and indeed, look at the 2.6.13 or 2.6.14 mm/hugetlb.c and you find
/*
 * We cannot handle pagefaults against hugetlb pages at all.  They cause
 * handle_mm_fault() to try to instantiate regular-sized pages in the
 * hugegpage VMA.  do_page_fault() is supposed to trap this, so BUG is we get
 * this far.
 */
static struct page *hugetlb_nopage(struct vm_area_struct *vma,
				unsigned long address, int *unused)
{
	BUG();
	return NULL;
}

Oh, and that pretty much still exists to this day, to cover that path
to a fault; but 2.6.16 implemented hugetlb_no_page(), which is what
then actually got used to satisfy a hugetlb fault.

So the reason for fork copying VM_HUGETLB appears to have gone away
in 2.6.16.

(I haven't a clue on private hugetlb mappings and reservations and
whether anon_vma means the same on hugetlb, but you know all that.)

Hugh
