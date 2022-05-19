Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4037952DCDB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 20:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbiESSb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 14:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244191AbiESSbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 14:31:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DCFADD7
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 11:31:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9A2561AB8
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 18:31:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 056F7C385AA;
        Thu, 19 May 2022 18:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1652985073;
        bh=Ta58ypg7C5RBl1jeQLPbuw2Br2B3B7e2eFsbiZbyb/c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qV2NUoxuWXcRHtsTtE16jglBzLifEm1hc82saNbVjqE8zFxJuONumCqs8vg5m2aaJ
         6klJ4udHdL5wK0gzPhbOh+uRNKv7zUNgmNFoegFBC4rceAwr7DNJvpEhWf4kxGh5+E
         1/uUVWSEhk1Pn8d6qMQu56EOncp3uAhclZc01FzA=
Date:   Thu, 19 May 2022 11:31:12 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Vitaly Wool <vitaly.wool@konsulko.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/9] revert
 "mm/z3fold.c: allow __GFP_HIGHMEM in z3fold_alloc"
Message-Id: <20220519113112.7531614a96dc4852ba61fdbc@linux-foundation.org>
In-Reply-To: <a3179291-fe43-1004-c89c-3bcdad26306e@huawei.com>
References: <20220429064051.61552-1-linmiaohe@huawei.com>
        <20220429064051.61552-6-linmiaohe@huawei.com>
        <CAM4kBBLC4Jo4TAC66XzJBgFZfF5ONgCNT5fPFQjwPJtug+5N8A@mail.gmail.com>
        <a3179291-fe43-1004-c89c-3bcdad26306e@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 May 2022 19:34:01 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:

> On 2022/5/19 15:12, Vitaly Wool wrote:
> > On Fri, Apr 29, 2022 at 8:41 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
> >>
> >> Revert commit f1549cb5ab2b ("mm/z3fold.c: allow __GFP_HIGHMEM in
> >> z3fold_alloc").
> >>
> >> z3fold can't support GFP_HIGHMEM page now. page_address is used
> >> directly at all places. Moreover, z3fold_header is on per cpu
> >> unbuddied list which could be access anytime. So we should rid
> >> the support of GFP_HIGHMEM allocation for z3fold.
> > 
> > Could you please clarify how kmem_cache is affected here?
> 
> With this code changes, kmem_cache should be unaffected. HIGHMEM is still not supported for
> kmem_cache just like before but caller ensures __GFP_HIGHMEM is not passed in now. The issue
> I want to fix here is that if z3fold page is allocated from highmem, page_address can't be
> used directly. Did I answer your question? Or don't I get your point?
> 

Yes, page_address() against a highmem page only works if that page has
been mapped into pagetables with kmap() or kmap_atomic(), and z3fold
doesn't appear to do that.

Given that other zpool_driver implementations do appear to support
highmem pages, I expect that z3fold should be taught likewise.


I didn't look very hard, but this particular patch is a bit worrisome. 
As I understand it, zswap can enable highmem:

	if (zpool_malloc_support_movable(entry->pool->zpool))
		gfp |= __GFP_HIGHMEM | __GFP_MOVABLE;

and z3fold will silently ignore the __GFP_HIGHMEM, which is OK.  But
with this patch, z3fold will now return -EINVAL, so existing setups
will start failing?

