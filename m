Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA7A55D147
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237485AbiF0Oeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 10:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237477AbiF0Oes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 10:34:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AACD11456
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 07:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ntcReyowVjn4HnyNh4i2ofXYzIiLtVLY9clRf2PCq/o=; b=Yn4jQs8DMQdIfl/AuavcP6Vym4
        KV1BRKVd24cbcWTUO0pVYZXCkIQJFb6CQvhYl00v4EU4DiRlxl5EcIOETEYWwp4EnuQOyNGtw2QyN
        yhVrDnnyby8rYPrYJjxz9YZHD8jS1eIeARTuRTrmjpnP1TgZ7il4LmiJO+K/sWbbfGQAjC8tWVi+X
        w7GUKSt20g8FNJAgDNmcLikkEBsR7U4xXMmtb89ZMftQbYy0Iru5bE9GnQAu1toIGFOomhbXcB9Dr
        7/mCmO2644Q+m+ZAr/rjAEMhsjRfnbiAzMyb+DZW1ySzL3QMOefd/9yaWETwzIUHmNSAPfJCLjup9
        SSnjcaMg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o5pov-00BR6K-7e; Mon, 27 Jun 2022 14:34:33 +0000
Date:   Mon, 27 Jun 2022 15:34:33 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Qi Zheng <zhengqi.arch@bytedance.com>, mike.kravetz@oracle.com,
        songmuchun@bytedance.com, akpm@linux-foundation.org,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm: hugetlb: kill set_huge_swap_pte_at()
Message-ID: <Yrm/+UoOtDY7G5bi@casper.infradead.org>
References: <20220626145717.53572-1-zhengqi.arch@bytedance.com>
 <f0cfe169-44fa-5653-d454-149ef286d3bb@arm.com>
 <037fc8c3-9b71-cb83-8882-95d5459a494f@bytedance.com>
 <b46f5390-830d-08fd-0d6d-3fda7d31c36a@arm.com>
 <d68572c8-a12b-1e3a-09d4-7a971ff305d6@bytedance.com>
 <8b4eba5d-545e-c2a4-e4cf-fd5dd6634265@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b4eba5d-545e-c2a4-e4cf-fd5dd6634265@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 01:05:00PM +0530, Anshuman Khandual wrote:
> > For the swap entry of hugetlb, we need to remember that we should
> > call set_huge_swap_pte_at() instead of set_huge_pte_at() every
> 
> Which is intuitive, so what is the problem ?

The problem is that HugeTLB is DIFFERENT from the rest of the VM.
This has a huge cost in programmer time, which is infinitely more
valuable than the cycle shaving you're quibbling over.  We should take
any and every opportunity to make huge pages work the same way as THP
and order-0 pages.
