Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C46AF53DF9B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 04:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349040AbiFFCJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 22:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240339AbiFFCJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 22:09:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3712C121
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 19:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=4BYz+QAVVmrOzsJcEMx42CDop/axWeg3fqIEzS4Xzaw=; b=L8BqkKNDzQSNN3nv0/pPC0lx1S
        3ktEPK2oDCypYLJCuvRY9kkp6vRk5vaC7m3594HFwYUbZnM4LGs0jPuRb2k+cxoNiXkSn6hVTUP8F
        so1yE85zwem4yjEL7ErXly8gmdVkNq7Nz3gnyXe/yVF6IYw9gpUoQ0u1lcBdfthkErzHe9qwFhpr5
        fLxWWIz3blby47GKgaz1CUfmr6lAdTenjv839yhCt2Bfi6Pwtqu7l7IT2cvwV7EPZt/ZInNAJBZtJ
        htYLeQKGsEGABcPheb0RcbNEZKRKDOZyEmRgj3J5u2wRVIjiBCo9wWzCBE2geUzj8bPkPNYGxYarz
        FrZ40P4w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ny2At-00AErk-0z; Mon, 06 Jun 2022 02:08:59 +0000
Date:   Mon, 6 Jun 2022 03:08:58 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Chen Wandun <chenwandun@huawei.com>
Cc:     hughd@google.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, david@redhat.com,
        wangkefeng.wang@huawei.com
Subject: Re: [PATCH v2 1/3] mm/shmem: check return value of
 shmem_init_inodecache
Message-ID: <Yp1hujqmnbUmVKSc@casper.infradead.org>
References: <20220605035557.3957759-1-chenwandun@huawei.com>
 <20220605035557.3957759-2-chenwandun@huawei.com>
 <YpyYSFjTQQQ/p4bM@casper.infradead.org>
 <aaebf2a5-026b-54f8-3fad-8e9611732e5e@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aaebf2a5-026b-54f8-3fad-8e9611732e5e@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 06, 2022 at 09:34:13AM +0800, Chen Wandun wrote:
> On 2022/6/5 19:49, Matthew Wilcox wrote:
> > On Sun, Jun 05, 2022 at 11:55:55AM +0800, Chen Wandun wrote:
> > > It will result in null pointer access if shmem_init_inodecache fail,
> > > so check return value of shmem_init_inodecache
> > You ignored my suggestion from v1.  Here, let me write it out for you.
> Hi Matthew,
> I didn't ignore your suggestion,  some explanation is needed, sorry for
> that.
> 
> In V1, Kefeng point:
> "kmem_cache_create return a pointer to the cache on success, NULL on
> failure,
> so error = -ENOMEM; is right :)"
> 
> so, I look some similar code such as init_inodecache in kinds of file
> system,  they all
> return -ENOMEM on failure, so is it OK to return -ENOMEM on failure :)
> 
> Besides,  kmem_cache_create return NULL on failure, maybe returning error
> code
> on failure is more proper, but it is another job.

I literally wrote out what I think you should do instead.  Stop arguing.

> > +static int shmem_init_inodecache(void)
> >   {
> >    	shmem_inode_cachep = kmem_cache_create("shmem_inode_cache",
> >    				sizeof(struct shmem_inode_info),
> >    				0, SLAB_PANIC|SLAB_ACCOUNT, shmem_init_inode);
> > +	if (!shmem_inode_cachep)
> > +		return -ENOMEM;
> > +	return 0;
> >   }
> > 
> > ...
> > 
> > +	error = shmem_init_inodecache();
> > +	if (error)
> > +		goto out2;
> > 
> > 
> > .
> 
