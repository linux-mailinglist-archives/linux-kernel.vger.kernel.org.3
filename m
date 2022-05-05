Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1117951CC03
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 00:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386268AbiEEWWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 18:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234582AbiEEWWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 18:22:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D16B54F92;
        Thu,  5 May 2022 15:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PQpJvze83NSWDlr7OIcAOygWYw70l9ciiAR1MAheopE=; b=RdLiYrz1lcimvJ5EFlm2OpYW07
        EBuVe7UI0ihIr0jNzNnAO/qKnT2X2XlxhDe1tll2ffGg+MIGaGlzfcJUhfERzY35hCUMKJqcZeBzw
        o0M+1uYWgIZciVhpqKBXo6Bhz1dExuY2z9u6Uhn7sxhmjuDN5LFPKRZc/2DGUDbxxciyhnXd1cydP
        hPrW8NcDwOoXsVTKpZKlUouBbvWVOioZla+nT2quMlttCur4XM4d9OzBSd3T7E5NYW0X0iyJjvVbo
        Sq0dIQorel0ndZs2+VLr8VJA8eSeFAQW31MwZ9soKTiJ3GcqgFFDHiNZEGpV0zskqqa/tSM/3Q0eo
        bFXrWZ4w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nmjo4-000NRV-NJ; Thu, 05 May 2022 22:18:44 +0000
Date:   Thu, 5 May 2022 23:18:44 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the mm tree
Message-ID: <YnRNRDqGgTqaAs/d@casper.infradead.org>
References: <20220506073537.6da48a27@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220506073537.6da48a27@canb.auug.org.au>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 06, 2022 at 07:35:37AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the mm tree, today's linux-next build (i386 allmodconfig
> clang14) produced this warning:
> 
> mm/shmem.c:1704:7: error: variable 'folio' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
> 
> Introduced by commit
> 
>   2b58b3f33ba2 ("mm/shmem: convert shmem_swapin_page() to shmem_swapin_folio()")
> 
> 'folio' is used in the error path.

I sent a repacement series here:

https://lore.kernel.org/linux-mm/20220504182857.4013401-1-willy@infradead.org/T/#t

I presume Andrew has not had a chance to integrate it yet.  LSF/MM was
exhausting!
