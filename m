Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 482C95506C3
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 23:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231983AbiFRVGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 17:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbiFRVGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 17:06:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9855FD3
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 14:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kbdgwi7SSpi9xXUsT16pgLifYuuKHQqA5KzhmsBvAWk=; b=hluXhrWXiJl1H5EHpSR6+TV7F0
        SsDXZuTsfWAPeSmYjNuujCoUIAHcNZcs4eB6oN2OAEl3srYeXxhKUxTt11jwca/D74xkGhbZBaKPS
        oYHDosVfb4bovVWocHA10XYy8xw40r5N1v8ICxWrdxYWwu7hoy8DtYJTWvljDQAbyfr9cpdkvBmlS
        iAJLjlJXLuvfhx/cSvtRN7ItCNaXN4keKxpt/91vTJcAOJpzN2IvFGHz5RGxmuOu4ExgzC9qg4fzL
        PnA61K3r2gwjB/s2pGgsfBu0x1fYLs1zp8czyEOjtIzLnrOYwoGokeyIhePLV1nmCXbWsPQG9X+h+
        W0LtkVDw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o2feO-003u7o-Hb; Sat, 18 Jun 2022 21:06:36 +0000
Date:   Sat, 18 Jun 2022 22:06:36 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [akpm-mm:mm-unstable 255/261] include/linux/mm.h:1556:29: error:
 conflicting types for 'page_to_section'; have 'long unsigned int(const
 struct page *)'
Message-ID: <Yq4+XF06TsrQ8LmR@casper.infradead.org>
References: <202206181437.AwvGIkuq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202206181437.AwvGIkuq-lkp@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 18, 2022 at 03:00:58PM +0800, kernel test robot wrote:
> config: parisc64-defconfig (https://download.01.org/0day-ci/archive/20220618/202206181437.AwvGIkuq-lkp@intel.com/config)

Ugh, SPARSEMEM without SPARSEMEM_VMEMMAP.

>    include/linux/mm.h: In function 'destroy_large_folio':
> >> include/asm-generic/memory_model.h:35:21: error: implicit declaration of function 'page_to_section'; did you mean 'present_section'? [-Werror=implicit-function-declaration]
>    include/linux/mm.h:214:38: note: in expansion of macro 'page_to_pfn'
>      214 | #define nth_page(page,n) pfn_to_page(page_to_pfn((page)) + (n))
>          |                                      ^~~~~~~~~~~

Needs some rearranging of the header file to make this work.

I don't think it's the right time to do that, and this patch can just be
dropped for this cycle.  It shouldn't affect the subsequent patches in
the series, AFAICT.
