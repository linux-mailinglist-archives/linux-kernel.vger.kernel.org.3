Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D45656B35D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 09:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237405AbiGHHUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 03:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiGHHUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 03:20:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4287B355
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 00:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=8+HqruRpwjEEEgSkE1QZNioLi75oIFsvSf7CNmRI+jQ=; b=KA/TA93wXBcJzNZB5lJSMugjWr
        kcWjW2pBXd8nmM7ADtnT1XWMxDSZca+5/nWS8E48HPWMnaRPYhgxnEIk8kZt1mKHkubXLE9JAPaMY
        Fr5pQUR/rgNCJxEe9ceMEZhwiDnNOKdW1AREDSyekJc+PvrtrqHW53aKH4sebLEba1SSwNwDOylMx
        ULPCkc3GSNUqKNWzutLStCclX+DO9YUTBjHyuTrq7ft7XMOQPs08jxMIsnEuI8MpJRwOuQ8G02nBU
        TyTZCj9OOrffz9rD1DB07eVg0Enq1cruBnqeit2d+pVNscnvDcjXybZmec+hfNlxakEfHwgKJXyD8
        5+cMRnng==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o9iHK-003Igt-0Y; Fri, 08 Jul 2022 07:19:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B3C62300912;
        Fri,  8 Jul 2022 09:19:51 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 47891203BFBC2; Fri,  8 Jul 2022 09:19:51 +0200 (CEST)
Message-ID: <20220708071802.751003711@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 08 Jul 2022 09:18:02 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jann Horn <jannh@google.com>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        peterz@infradead.org, Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guo Ren <guoren@kernel.org>, David Miller <davem@davemloft.net>
Subject: [PATCH 0/4] munmap() vs unmap_mapping_range()
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

These 4 patches implement the suggestion by Linus.

The first patch nukes all architecture implementations of tlb_{start,end}_vma()
by adding two additional MMU_GATHER config knobs.

DaveM, please clarify the sparc64 case, it seems a little odd to have
flush_cache_range() but to explicitly not call it at unmap time. It would be
nice to remove this one special case.

The second patch isn't strictly needed for this series but since I was looking
at all this, I figured C-SKY didn't make a whole lot of sense. Guo, please
have a look.

The third patch cleans up the #ifdeffery and provides a single
tlb_{start,end}_vma() implementation for everyone.

The fourth, and final, patch does the force TLB-flush on VM_PFNMAP thing.

I've had the first three patches exposed to the robots and they've (so far) not
reported build (or other) fail.

