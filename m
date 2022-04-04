Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 913444F1ED1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237659AbiDDVz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378955AbiDDQIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 12:08:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C6313F42
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 09:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DEQK48DTwuMTMNUTpLWwhw+3ZXcCifB/CeMmKRj1wOY=; b=DAFAD08Dvu2jDB3R/moESGFvEY
        Qm/1sjjfXx8+Dbu/JriCkI2v/nHfqxIR3/zQ14SmSywHcDSXwXuiktZlD/CIbcT1jyYBGUljAV77+
        1pzvYO/rOvLU9dQDRxCnzq1P++ZpREsTjxFXOHzz+quDx4Mc6MIBYZ9dTflIdAstJXUEhkTf84IP0
        pJ6RhSlHpWUcsMzoqBMnr+bRMJhxECh9GBRoKgxe/9JtY7xjjaVHq40lvRP4zCpUJHRehexqvCtbx
        3peHdoR4IikvuNN7WwxM+FUwcHx3YizY9zb166RCLkGfzLZvjtHoJKWLaQ+g0dG+vW1CX9h8xFine
        5qQ7q7Lg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nbPDh-005sCJ-7u; Mon, 04 Apr 2022 16:06:21 +0000
Date:   Mon, 4 Apr 2022 17:06:21 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Zi Yan <ziy@nvidia.com>
Cc:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>
Subject: Re: v5.18-rc1: migratepages triggers
 VM_BUG_ON_FOLIO(folio_nr_pages(old) != nr_pages)
Message-ID: <YksXfckGevTN1QD+@casper.infradead.org>
References: <20220404132908.GA785673@u2004>
 <F3E3F1AE-B421-4463-B032-3F58DF89A5E2@nvidia.com>
 <YksAub9UccPZa9DI@casper.infradead.org>
 <C4792D17-A7F6-4803-B8FC-B8682F50E044@nvidia.com>
 <20220404151805.GA800317@u2004>
 <857E3E12-5C2D-4990-A667-79E1FC000291@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <857E3E12-5C2D-4990-A667-79E1FC000291@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2022 at 11:44:39AM -0400, Zi Yan wrote:
> I am wondering if my change is the right fix or not. folios with order>0
> are still available when CONFIG_TRANSPARENT_HUGEPAGE is not set, right?

That's the eventual plan, but it's not possible today.  We need to
be able to split large folios (eg in truncation) and that functionality
is still under CONFIG_TRANSPARENT_HUGEPAGE in mm/huge_memory.c.  So
large folios depend on CONFIG_TRANSPARENT_HUGEPAGE instead of having a
clean separation between functionality-to-support-PMD-mapping and
functionality-to-support-order>0.

So I preferred your earlier patch because it's more obvious.  I mean,
we could pull in the two or three patches from my tree that convert
these functions and their callers to folios ... we're only at rc1.
I can post them and see what others think.
