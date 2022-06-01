Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74FE753AAD2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 18:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356039AbiFAQN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 12:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355340AbiFAQNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 12:13:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2042E41639
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 09:13:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ABB16B81B58
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 16:13:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B9F0C385A5;
        Wed,  1 Jun 2022 16:13:45 +0000 (UTC)
Date:   Wed, 1 Jun 2022 17:13:42 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Patrick Wang <patrick.wang.shcn@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yee.lee@mediatek.com
Subject: Re: [PATCH] mm: kmemleak: check boundary of objects allocated with
 physical address when scan
Message-ID: <YpeQNkk31d7JL9g6@arm.com>
References: <20220531150823.1004101-1-patrick.wang.shcn@gmail.com>
 <YpZCWbfNE32EzCnz@arm.com>
 <99faf6b0-30bf-f87c-2620-1eafb4eac1ac@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99faf6b0-30bf-f87c-2620-1eafb4eac1ac@gmail.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2022 at 06:24:34PM +0800, Patrick Wang wrote:
> On 2022/6/1 00:29, Catalin Marinas wrote:
> > On Tue, May 31, 2022 at 11:08:23PM +0800, Patrick Wang wrote:
> > > +	if (kmemleak_enabled && (unsigned long)__va(phys) >= PAGE_OFFSET &&
> > > +	    !IS_ERR(__va(phys)))
> > > +		/* create object with OBJECT_PHYS flag */
> > > +		create_object((unsigned long)__va(phys), size, min_count,
> > > +			      gfp, true);
> > 
> > Do we still need to check for __va(phys) >= PAGE_OFFSET? Also I don't
> > think IS_ERR(__va(phys)) makes sense, we can't store an error in a
> > physical address. The kmemleak_alloc_phys() function is only called on
> > successful allocation, so shouldn't bother with error codes.
> 
> In this commit:
> 972fa3a7c17c(mm: kmemleak: alloc gray object for reserved
> region with direct map)
> 
> The kmemleak_alloc_phys() function is called directly by passing
> physical address from devicetree. So I'm concerned that could
> __va() => __pa() convert always get the phys back? I thought
> check for __va(phys) might help, but it probably dosen't work
> and using IS_ERR is indeed inappropriate.
> 
> We might have to store phys in object and convert it via __va()
> for normal use like:
> 
> #define object_pointer(obj)	\
> 	(obj->flags & OBJECT_PHYS ? (unsigned long)__va((void *)obj->pointer)	\
> 				: obj->pointer)

In the commit you mentioned, the kmemleak callback is skipped if the
memory is marked no-map.

But you have a point with the va->pa conversion. On 32-bit
architectures, the __va() is no longer valid if the pfn is above
max_low_pfn. So whatever we add to the rbtree may be entirely bogus,
and we can't guarantee that the va->pa conversion back is correct.

Storing the phys address in object->pointer only solves the conversion
but it doesn't solve the rbtree problem (VA and PA values may overlap,
we can't just store the physical address either). And we use the rbtree
for searching objects on freeing as well.

Given that all the kmemleak_alloc_phys() calls always pass min_count=0
(we should probably get rid of the extra arguments), we don't expect
them to leak, so there's no point in adding them to the rbtree. We can
instead add a new object_phys_tree_root to store these objects by the
physical address for when we need to search (kmemleak_free_part_phys()).
This would probably look simpler than recording the callbacks and
replaying them.

Wherever we use object_tree_root we should check for OBJECT_PHYS and use
object_phys_tree_root instead. There aren't many places.

-- 
Catalin
