Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1AD543D1B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 21:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235675AbiFHTuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 15:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235672AbiFHTuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 15:50:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E5B19C3BB
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 12:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vB8qr31hPZDrulIC0wNXe3jXMBDgmtAVqOgZUjr6cR0=; b=PoG3IJOzPir+bn8LsRR9955dqy
        TqBU58ZGvNU8VWRcRDbbb9hPsgfkAW9AO3794kwVAXodLPU9LxjyVGNMXyG35L/z0emBObP1XGz4n
        CeXLMWRcxZSRFDLDb9+J+2m8qVz1WvZoH5vqrSIowZTpmC8p/sRtpp4Qoc68GjvC+iqDpDWP603na
        EB0XlwqfSW3nvFhzFLQzPwCQO71cA9s+AdbQdCzD3dg1yqpZmPXMvuLLkrfMKquv2WRyqZK+k8evC
        Mo64qgsHSGMqpKcpCkdOH7tITcHG2NsUgKkF5Y02vO7nGN9uIc0wwZmPzU5fw0LtK5X7Z+Eui/OT5
        4g3Zhp/w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nz1gj-00CvKE-PH; Wed, 08 Jun 2022 19:49:57 +0000
Date:   Wed, 8 Jun 2022 20:49:57 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ankur Arora <ankur.a.arora@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>,
        Jason Gunthorpe <jgg@nvidia.com>, jon.grimm@amd.com,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Joao Martins <joao.m.martins@oracle.com>
Subject: Re: [PATCH v3 00/21] huge page clearing optimizations
Message-ID: <YqD9ZRNtU1F6zBn/@casper.infradead.org>
References: <20220606202109.1306034-1-ankur.a.arora@oracle.com>
 <CAHk-=wh89D_69JZtB0MNKbrTM4dPJisK6E0yFKH-hA++F13mzw@mail.gmail.com>
 <87k09s1pgo.fsf@oracle.com>
 <CAHk-=wj9En-BC4t7J9xFZOws5ShwaR9yor7FxHZr8CTVyEP_+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj9En-BC4t7J9xFZOws5ShwaR9yor7FxHZr8CTVyEP_+Q@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2022 at 10:56:01AM -0700, Linus Torvalds wrote:
> I worry a bit about the insanity of the "gigantic" pages, and the
> mem_map_next() games it plays, but that code is from 2008 and I really
> doubt it makes any sense to keep around at least for x86. The source
> of that abomination is powerpc, and I do not think that whole issue
> with MAX_ORDER_NR_PAGES makes any difference on x86, at least.

Oh, argh, I meant to delete mem_map_next(), and forgot.

If you need to use struct page (a later message hints you don't), just
use nth_page() directly.  I optimised it so it's not painful except on
SPARSEMEM && !SPARSEMEM_VMEMMAP back in December in commit 659508f9c936.
And nobody cares about performance on SPARSEMEM && !SPARSEMEM_VMEMMAP
systems.
