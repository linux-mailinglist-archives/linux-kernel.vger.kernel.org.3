Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83EEC558371
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 19:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233936AbiFWR3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 13:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234011AbiFWR1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 13:27:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04DF7506D6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 10:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UenEwcIN0CvVMMXweP0TWmC7AzLiwOHffKvm7rzsvxY=; b=F60jZ0DijvM0NLeHfLyAZLtO8B
        cbCSSryf/ZJyUOWsnEtUCDNiwnf8r9kSJNUJoyCOh8/JSjMgZzxWLo2l8nGB+M4V1I64oCbTL8pnG
        YD/LZs6YKE1Yq40e61dXoVn75QKBz2bsGHtBJwGqalXEPQiKoj5XIahiSxsGOtj/k+nMhmgwTgWW8
        7XwYtcrrkIvSvlYu8Los43W1fSgc4MBXDNne0L/6KVVUHONYps1CLTuGkbV4Wx+68AKR3hm6oXagi
        2hq7ITECWkzRHY60cGknvOTokRIsGqq0J+1DfEUZQyyIppBLROpiJW5iXocE8Cjnn9GKnJfD8B5kj
        0+LhjxVw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o4QER-0081dP-VH; Thu, 23 Jun 2022 17:03:03 +0000
Date:   Thu, 23 Jun 2022 18:03:03 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Liam Howlett <liam.howlett@oracle.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "damon @ lists . linux . dev" <damon@lists.linux.dev>,
        SeongJae Park <sj@kernel.org>
Subject: Re: [PATCH v10 09/69] mm: add VMA iterator
Message-ID: <YrScxyQ5RRYYZFrj@casper.infradead.org>
References: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
 <20220621204632.3370049-10-Liam.Howlett@oracle.com>
 <20192b57-30de-1426-6694-238e018104eb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20192b57-30de-1426-6694-238e018104eb@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 11:10:09PM +0200, David Hildenbrand wrote:
> > +#define VMA_ITERATOR(name, mm, addr) 					\
> > +	struct vma_iterator name = {					\
> > +		.mas = {						\
> > +			.tree = &mm->mm_mt,				\
> > +			.index = addr,					\
> > +			.node = MAS_START,				\
> > +		},							\
> > +	}
> > +
> 
> No __* and () macro magic?
> 
> I'd have expected at least
> 
> tree = &(__mm)->mm_mt,
> .index = (__addr),
> 
> ;)

Fair, fair.  Just testing that change now.  I always forget to do those
things until they bite me.

> Reviewed-by: David Hildenbrand <david@redhat.com>

Appreciate the review!

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index acbd8d03e01e..8bcbffefdc02 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -686,11 +686,11 @@ struct vma_iterator {
 	struct ma_state mas;
 };
 
-#define VMA_ITERATOR(name, mm, addr) 					\
+#define VMA_ITERATOR(name, _mm, _addr)	 				\
 	struct vma_iterator name = {					\
 		.mas = {						\
-			.tree = &mm->mm_mt,				\
-			.index = addr,					\
+			.tree = &(_mm)->mm_mt,				\
+			.index = (_addr),				\
 			.node = MAS_START,				\
 		},							\
 	}
