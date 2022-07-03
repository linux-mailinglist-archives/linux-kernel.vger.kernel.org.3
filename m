Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28D79564828
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 16:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232688AbiGCOw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 10:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232646AbiGCOwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 10:52:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282EF10DC
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 07:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wUvBQCKrc374bGTpdex4sW2Vzf0pP0Ed5hAguBT3ZdQ=; b=uX4wIiXMSzYxPjzsbR3395x39F
        RDKib5kzdS7y0dl/AgWgPI5fjMBREAcrr9JJoYZayb2iAia73uEhAqWU+9WVLRiNMY5gRM20TSKNB
        s+AiIBx+njGTY1MYVwc2K+IF/6wNjWCS0qv5gZlmUcJ1it+oaw28TEjh13ycIkUbI1KOzGSv4HSfH
        oOlo4hfWN6Yo/9eBUUwgS+wcbKikIcmC64WdEYcaV29HkkJTIZUkswzGRYq1+DLDVAKO33SJ80Dfa
        5rtV0ps3Oi9KAAJ3NPx/x+BeJp22zYfr8q4J5o/HiBuYUXBd5j+timcGdRBxktw1xcIsrWD2xnFTK
        qmPqDpJg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o80xq-00GVRn-EG; Sun, 03 Jul 2022 14:52:46 +0000
Date:   Sun, 3 Jul 2022 15:52:46 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     Mike Rapoport <rppt@linux.ibm.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v3 2/3] mm: Add PUD level pagetable account
Message-ID: <YsGtPnfB4/A8pFhA@casper.infradead.org>
References: <cover.1656586863.git.baolin.wang@linux.alibaba.com>
 <6a6a768634b9ce8537154264e35e6a66a79b6ca8.1656586863.git.baolin.wang@linux.alibaba.com>
 <Yr2wlqQkpsffTvd/@linux.ibm.com>
 <1234a28a-dca0-5836-9066-4ab2d4fbcc95@linux.alibaba.com>
 <YsEPwvgUd0sIjso/@casper.infradead.org>
 <17df0d3c-caaf-ee34-f702-1d4e7674887f@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17df0d3c-caaf-ee34-f702-1d4e7674887f@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 03, 2022 at 10:06:32PM +0800, Baolin Wang wrote:
> So for kernel pte page table allocation, I need another similar helpers like
> below. However they do the samething with
> pgtable_pud_page_ctor/pgtable_pud_page_dtor, so I am not sure this is good
> for adding these duplicate code.

Why do we want to account kernel PTE page tables in NR_PAGETABLE?
I think that's confusing.

