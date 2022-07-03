Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1B155643BC
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 05:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbiGCDlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 23:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiGCDlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 23:41:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290A76545
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 20:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yUcXbxB06hdRD0R+rVE1I7cbEXp854NTpON98IkjV5M=; b=hae7218pokCBDtYmMXlJ2Nu9su
        E8Erlh/UHAOael315DED6pcBJwmbU22YI3PtudAZ8Rs04oQWOWcfAzzuiDnmaL7rLsMSG9gHp49qh
        y8wcbL1q/dVGANQlr0shMXgguZ5D7oG1YBIhlLUzquksCsaK5inYItqdR2ckqGuTPUC0eDgJwWJ3o
        2OXnTAwBM7vuSb40hOTRGQ1moOCFtMGws5QLIV+WHbhPKO7CPfPBpjprUJyyc3VOLi7ixvgtIkETA
        YEYbLzZ6qIZ6ofgd7Wuk8220p4cw3mlzjMSKMRSjJQcmBvKdLFvFfM4Kn5EZB4Ab0n5meRLFNcd4x
        3B8n0zCA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o7qTa-00GDPg-Ot; Sun, 03 Jul 2022 03:40:50 +0000
Date:   Sun, 3 Jul 2022 04:40:50 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     Mike Rapoport <rppt@linux.ibm.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v3 2/3] mm: Add PUD level pagetable account
Message-ID: <YsEPwvgUd0sIjso/@casper.infradead.org>
References: <cover.1656586863.git.baolin.wang@linux.alibaba.com>
 <6a6a768634b9ce8537154264e35e6a66a79b6ca8.1656586863.git.baolin.wang@linux.alibaba.com>
 <Yr2wlqQkpsffTvd/@linux.ibm.com>
 <1234a28a-dca0-5836-9066-4ab2d4fbcc95@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1234a28a-dca0-5836-9066-4ab2d4fbcc95@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 01, 2022 at 04:04:21PM +0800, Baolin Wang wrote:
> > Using pgtable_pud_page_ctor() and pgtable_pud_page_dtor() would be
> > consistent with what we currently have for PTEs and PMDs.
> > 
> > This applies to all the additions of pgtable_page_dec() and
> > pgtable_page_inc().
> 
> OK. I can add pgtable_pud_page_ctor() and pgtable_pud_page_dtor() helpers to
> keep consistent, which are just wrappers of pgtable_page_inc() and
> pgtable_page_dec().

I think you misunderstand Mike.

Don't add pgtable_page_inc() and pgtable_page_dec().  Just add
pgtable_pud_page_ctor() and pgtable_pud_page_dtor().  At least, that
was what I said last time yo uposted these patches.
