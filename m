Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABACC525A1E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 05:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376781AbiEMDbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 23:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376768AbiEMDa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 23:30:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671423EF1B
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 20:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=T1n6CcgxVlaaTJq+CdhKBBc8cwWaDbssBxSXTzNNfzc=; b=Uh0b9OF+M0Iy4RqjTa7JTtdqBX
        gPYpgBZ+O+hVvylStq4jCTOEeZ9/6LK8ZXcj3k9j1W8l30iIa/AvoEIGzsaFFHCeHPRJmrrMJzPvF
        ZQWunK73NroWy7jaO/cLtZxf8JKohHYnYM/uIGxs3yEwKeM3L327h+PJ4HWm/DAKL6/dZDFHMV7V3
        Q2ovOXFAUUxKQNJo7tgGDMVvmv70if+iLO33uni/E7DrwZUeYx8XgUoQpn2mBSYRhP4Mf3BkY8AMY
        FJ3koHZejPnDySmDdc/BENU89RUJP7wV10SMcXjHCkgz/tyC4GaUXBRZBuiiFzePkQIhPFH3Ng8H/
        OF9xsqHg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1npM0y-0070UD-8n; Fri, 13 May 2022 03:30:52 +0000
Date:   Fri, 13 May 2022 04:30:52 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Yang Shi <shy828301@gmail.com>
Cc:     songmuchun@bytedance.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm: pvmw: check possible huge PMD map by
 transhuge_vma_suitable()
Message-ID: <Yn3Q7KIb3FcAPW9j@casper.infradead.org>
References: <20220512174551.81279-1-shy828301@gmail.com>
 <20220512174551.81279-2-shy828301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512174551.81279-2-shy828301@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 10:45:51AM -0700, Yang Shi wrote:
> IIUC PVMW checks if the vma is possibly huge PMD mapped by
> transparent_hugepage_active() and "pvmw->nr_pages >= HPAGE_PMD_NR".
> 
> Actually pvmw->nr_pages is returned by compound_nr() or
> folio_nr_pages(), so the page should be THP as long as "pvmw->nr_pages
> >= HPAGE_PMD_NR".  And it is guaranteed THP is allocated for valid VMA
> in the first place.  But it may be not PMD mapped if the VMA is file
> VMA and it is not properly aligned.  The transhuge_vma_suitable()
> is used to do such check, so replace transparent_hugepage_active() to
> it, which is too heavy and overkilling.
> 
> Fixes: 2aff7a4755be ("mm: Convert page_vma_mapped_walk to work on PFNs")

I think Fixes is a bit much.  There's no bug being fixed here.  This is
just an optimisation.  Is it an important optimisation?  We could put a
bool into page_vma_mapped_walk() so we only have to ask the page whether
it's PMD-mappable once per walk rather than for each VMA.

