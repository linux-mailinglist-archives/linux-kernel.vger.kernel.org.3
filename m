Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB1614AA53E
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 02:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378332AbiBEBIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 20:08:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233537AbiBEBIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 20:08:46 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52BFC06109E
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 17:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YyDuTwMPZeeNrVuBfd+snTAaZxE4INWW/n9pC9E994c=; b=GMgxSDjm9L7J6f0S6jNHVb1hS2
        a8TrW/q3Jl/zQSPQ5MSA8FaVnILkkXgOXKGSxFowHtMHbqb7FvX/kyCeWPz+xtxdsSdRdqN1ePCTS
        z2nOHWoFZlQesNRjGaomDItIhrsHF6cFWL6iX19GD9pbwKn/4+WLl3pHSdfZnOEN7eFEdx/eMcBwU
        BRtJj1TeaPV4IcRDVfmNyxHn0/tPrIW6AFvMZmOMwPNe3ciZbUfNpJQvPvMQq6bW/1vZQTzpZEeOt
        7q31rKFMqIziohvmX8hisXZy8Y/JlL/9xWTcBTeuDlwPz7RR+j4llN2bWQlU5hElnxwJ84DPEaE0l
        1gyOZevg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nG9Yz-0087Iu-DZ; Sat, 05 Feb 2022 01:08:29 +0000
Date:   Sat, 5 Feb 2022 01:08:29 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-mm@kvack.org
Subject: Re: [willy-pagecache:for-next 13/75] include/linux/mm.h:1570:29:
 error: conflicting types for 'page_to_section'; have 'long unsigned
 int(const struct page *)'
Message-ID: <Yf3ODW2NVakDhP55@casper.infradead.org>
References: <202202050617.Ew48ldTc-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202202050617.Ew48ldTc-lkp@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 05, 2022 at 06:54:20AM +0800, kernel test robot wrote:
> commit: 8788d4b404865697ebe822cff65a1380728ba251 [13/75] mm: Add folio_pincount_ptr()
>    include/linux/mm.h: In function 'folio_pincount_ptr':
>    include/asm-generic/memory_model.h:35:21: error: implicit declaration of function 'page_to_section'; did you mean 'present_section'? [-Werror=implicit-function-declaration]

Grr.  I can't use folio_page() until after page_to_section().  So I've
moved a lot of code around in patches 13 and 14.  New version pushed to
infradead.
