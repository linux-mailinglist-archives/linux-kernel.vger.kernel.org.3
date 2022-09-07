Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C92805B0127
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 12:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbiIGKBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 06:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbiIGKAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 06:00:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14253F319
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 03:00:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F76B61835
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 10:00:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67DF0C433B5;
        Wed,  7 Sep 2022 10:00:24 +0000 (UTC)
Date:   Wed, 7 Sep 2022 11:00:20 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com
Subject: Re: [Resend RFC PATCH] mm: introduce __GFP_TRACKLEAK to track
 in-kernel allocation
Message-ID: <YxhrtC/Z6H5MqUgq@arm.com>
References: <1662116347-17649-1-git-send-email-zhaoyang.huang@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1662116347-17649-1-git-send-email-zhaoyang.huang@unisoc.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 06:59:07PM +0800, zhaoyang.huang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> Kthread and drivers could fetch memory via alloc_pages directly which make them
> hard to debug when leaking. Solve this by introducing __GFP_TRACELEAK and reuse
> kmemleak mechanism which unified most of kernel cosuming pages into kmemleak.

This may be helpful for debugging individual drivers but they could as
well call kmemleak_alloc/free() directly and not bother with new GFP and
page flags.

I wonder whether we could go the other way around. Add a
__GFP_NOLEAKTRACE (we have SLAB_NOLEAKTRACE for example) and pass it in
the places where we don't want pages to be scanned/tracked: page cache
pages (too many and they don't store pointers to other kernel objects),
sl*b, CMA etc. allocations (basically in all places where you have
kmemleak_alloc() calls, otherwise the pointers overlap and confuse
kmemleak).

-- 
Catalin
