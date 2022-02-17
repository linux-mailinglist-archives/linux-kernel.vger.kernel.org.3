Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1240D4BAC4F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 23:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343795AbiBQWHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 17:07:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241942AbiBQWHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 17:07:35 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5AA826ADC
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 14:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=71dJCo10NUXZXmR3nVHfWDppBo5ie33ICNTgT4LLJRc=; b=fffwrp84nx5JPD7Hdc2Nd7wHQO
        H+PqZ6yrYs/kStDxFHQuOlCHnHlNcD5O4D+EbkZ3b6YgMMSS/iE4Ea1zbIkqNbMdSKi1SubDfDkGG
        ek6DyFOgFRY5WPCPxWmJ404zsNpmYYZqGmnQtuYfiJrDhAyZT9uXvBUZdpJPO1l86pXC/hBMorkRs
        3EMppTY1h6mUK4qgHHcytmKtEDwgYJpCShWOUOyNX/4ZeEKjAQ+1yoLjMFgp1xFRNyZYPaY7jxsIg
        jyZnvAT6ODLWtqHMYSHGTgt23xWLoApNqC44rjwHx7RE6RcgNR1JmGY42TR9UwhYGgAnnVfU2y8VQ
        LQofCunw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nKovb-00FzEM-On; Thu, 17 Feb 2022 22:07:08 +0000
Date:   Thu, 17 Feb 2022 22:07:07 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel test robot <lkp@intel.com>, Christoph Hellwig <hch@lst.de>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [hnaz-mm:master 237/343]
 arch/powerpc/mm/book3s64/pgtable.c:540:15: warning: no previous prototype
 for 'memremap_compat_align'
Message-ID: <Yg7HC3r1mdvsHs4s@casper.infradead.org>
References: <202202172347.lJ6oYVOE-lkp@intel.com>
 <20220217125553.88a9ce7723ea8fd39c76a199@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217125553.88a9ce7723ea8fd39c76a199@linux-foundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022 at 12:55:53PM -0800, Andrew Morton wrote:
> On Fri, 18 Feb 2022 03:46:17 +0800 kernel test robot <lkp@intel.com> wrote:
> > >> arch/powerpc/mm/book3s64/pgtable.c:540:15: warning: no previous prototype for 'memremap_compat_align' [-Wmissing-prototypes]
> >      540 | unsigned long memremap_compat_align(void)
> >          |               ^~~~~~~~~~~~~~~~~~~~~
> 
> Thanks, I did this.

I guess this is now my responsibility?  Folded that fix in and pushed
out 8cbcadaf5aef to infradead/for-next

> --- a/arch/powerpc/mm/book3s64/pgtable.c~mm-dont-include-linux-memremaph-in-linux-mmh-fix-2-fix
> +++ a/arch/powerpc/mm/book3s64/pgtable.c
> @@ -6,6 +6,7 @@
>  #include <linux/sched.h>
>  #include <linux/mm_types.h>
>  #include <linux/memblock.h>
> +#include <linux/memremap.h>
>  #include <linux/debugfs.h>
>  #include <misc/cxl-base.h>
>  
> _
> 
> 
> 
