Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 636074ECEF6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 23:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351326AbiC3Vqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 17:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348397AbiC3Vqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 17:46:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9846592
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 14:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FsXi28gMtdis5Jj9MbJiJRd8qiKWr77s/dYvW4iZVqk=; b=q35vE6HTTuQyDeuJqYmhWGFFwg
        Phr1RusYnMeu0U+3q9/lKXn6Rae9tnFweCN8ukLPPeBZNLB8y2ueWKJdzkf2jnbxwoWmWS1yxLaun
        BhIYgMyqbTzimrYjQlwERtWN3rjkD8a14giTqDBsM5kcDZT3++w03cBQR+rK3a1/58HsyLohMPZh6
        eeLv7S5od/pXrK2dG3ppEaxtLrirSAmW2jq03JyVZP3vzt8KI+k3AWqd9A/QzING4Rq9pvtJZTGCg
        duM7Wmy+uGcrwa35k/DOBFddN20jCmK33+giroIxzUnhd+o9YDrCQZI5fNGN+9pOsJX2gjc/Krmj+
        GANjxN6Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZg7W-001bGh-4j; Wed, 30 Mar 2022 21:44:50 +0000
Date:   Wed, 30 Mar 2022 22:44:50 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: WARNING: mm/workingset.c:567 shadow_lru_isolate
Message-ID: <YkTPUmMitEDHfjeH@casper.infradead.org>
References: <55db706b-9bce-b820-7d88-6392374cd4fc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55db706b-9bce-b820-7d88-6392374cd4fc@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2022 at 09:24:00PM -0700, Hugh Dickins wrote:
> I'm not familiar with workingset.c, I'll make no guesses, over to you!

I haven't been able to reproduce it, but I applied Feynman's Problem
Solving Algorithm, and I think this will do the trick:

diff --git a/lib/xarray.c b/lib/xarray.c
index b95e92598b9c..d3b168f619b1 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -1079,6 +1079,7 @@ void xas_split(struct xa_state *xas, void *entry, unsigned int order)
 					xa_mk_node(child));
 			if (xa_is_value(curr))
 				values--;
+			xas_update(xas, child);
 		} else {
 			unsigned int canon = offset - xas->xa_sibs;
 
@@ -1093,6 +1094,7 @@ void xas_split(struct xa_state *xas, void *entry, unsigned int order)
 	} while (offset-- > xas->xa_offset);
 
 	node->nr_values += values;
+	xas_update(xas, node);
 }
 EXPORT_SYMBOL_GPL(xas_split);
 #endif

(the key insight is that the update function should have removed the
node from the list; the WARN_ON really means "this node should not be on
the list", so there's somewhere that we're forgetting to call
xas_update(), or somewhere that we're forgetting to call
mapping_set_update().  I didn't find any of the latter, but I did find
one of the former)
