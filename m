Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE8C534299
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 19:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343626AbiEYR6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 13:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235613AbiEYR6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 13:58:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA53A13D35
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 10:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1xWCZXrCC3SsN1KQJaC2N7l7n1E1rs7j0k9r7unv6E8=; b=S36lzpqTN9jl/FT8S8Qg2vnXii
        oU2B7rpvWI1T5ZkKh38ekJGvG7sNJhnmV3eS3mHuHvYUFe6eCfo+dBqM6DazuwIr7P3/TQZ3N6w1F
        HHFK7ANdz8wgKEHzsxPt6rsL5W7tALbwgaLzPOuK4R+Vgs4wcHczr/QBSEqQr4GoJwtBiWj9uBMNB
        SnW11xlTF+zx/N6ICcZfBrrtS26stnos9BdKuAtgShOfMz1brI0BYEpRJ/om6WRZ3Zr9UYWOu3iua
        AqQW2/DVdYAMonWDT/nvXcTj+N90CP3ZDatxp4JhidISEZ589i3sZIbD90srI+a8Yw8XeCx7h2zKN
        h00uxvbA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ntvGd-000Zaw-W2; Wed, 25 May 2022 17:57:56 +0000
Date:   Wed, 25 May 2022 18:57:55 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     syzbot <syzbot+5b96d55e5b54924c77ad@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] KASAN: use-after-free Read in do_sync_mmap_readahead
Message-ID: <Yo5uI9w7lll5B93r@casper.infradead.org>
References: <0000000000008cfbca05dfd6db81@google.com>
 <20220525095842.f97b64de9cbcc0e15d1257a6@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220525095842.f97b64de9cbcc0e15d1257a6@linux-foundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 09:58:42AM -0700, Andrew Morton wrote:
> On Wed, 25 May 2022 07:26:22 -0700 syzbot <syzbot+5b96d55e5b54924c77ad@syzkaller.appspotmail.com> wrote:
> > BUG: KASAN: use-after-free in do_sync_mmap_readahead+0x465/0x9f0 mm/filemap.c:3006
> > Read of size 8 at addr ffff88801fedb050 by task syz-executor.5/1755
> 
> A race?
> 
> #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> 	/* Use the readahead code, even if readahead is disabled */
> 	if (vmf->vma->vm_flags & VM_HUGEPAGE) {
> 		fpin = maybe_unlock_mmap_for_io(vmf, fpin);
> 		ractl._index &= ~((unsigned long)HPAGE_PMD_NR - 1);
> 		ra->size = HPAGE_PMD_NR;
> 		/*
> 		 * Fetch two PMD folios, so we get the chance to actually
> 		 * readahead, unless we've been told not to.
> 		 */
> -->		if (!(vmf->vma->vm_flags & VM_RAND_READ))
> 			ra->size *= 2;
> 		ra->async_size = HPAGE_PMD_NR;
> 		page_cache_ra_order(&ractl, ra, HPAGE_PMD_ORDER);
> 		return fpin;
> 	}
> #endif
> 
> Reading from vmf->vma->vm_flags was OK, then it suddenly wasn't.

Ohh, that makes sense.  We unlocked the mmap_sem, so the file is
pinned, but the VMA isn't.  I'll whip up a patch.

