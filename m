Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9C3258FB8A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 13:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234948AbiHKLnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 07:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234420AbiHKLnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 07:43:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7C2910BB
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 04:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=44LNoOo+GlGFf4oFaGIyYBOTJarrYSp5y1KTEHFz0eM=; b=r89wHmeyVhIM3k79xQ6SZfxx7T
        W2E9mMt2CAxH6CAPSby6Y2Cf601fMCfbvmbKmFo+LmKtNvkRlbuyVwO0nK0Msaci0+msVSyh2Zo32
        1eR+a8HrbgUuCgK/iKwFpMa98AFepQOReEDPXUgxJXe7CmHoIuwNgjVMvVjFrDN/LYUwgKyPOv9aT
        16BVdsKXPWTL2YCYfvK4eP2+ICM63WbPUW7aq+0JI214NR0Yy15WVPGkVQQkh1gSFbf0GN2lrt/Fy
        2IrEA6leBfz+P2NpHZxQ9pJx0HSKTbpn9aSWZh57mi1eEmXJtZNdgNBVR8cCz2iTxttdRd3uJ91CM
        rO88on+w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oM6aZ-000cTj-Hq; Thu, 11 Aug 2022 11:42:59 +0000
Date:   Thu, 11 Aug 2022 12:42:59 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm/shmem: shmem_replace_page() remember NR_SHMEM
Message-ID: <YvTrQ1NRfnOEHGWD@casper.infradead.org>
References: <cec7c09d-5874-e160-ada6-6e10ee48784@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cec7c09d-5874-e160-ada6-6e10ee48784@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2022 at 10:06:33PM -0700, Hugh Dickins wrote:
> Elsewhere, NR_SHMEM is updated at the same time as shmem NR_FILE_PAGES;
> but shmem_replace_page() was forgetting to do that - so NR_SHMEM stats
> could grow too big or too small, in those unusual cases when it's used.
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

> ---
> This is not terribly important, and will clash with one of Matthew's
> 59 for 5.21; I don't mind if this gets delayed, and we just do it again
> on top of his series later, or he fold the equivalent into his series;
> but thought I'd better send it in as another fix to shmem_replace_page()
> while that function is on our minds.

Let's get this into 6.0 since it's a bugfix, and I'll rebase my patches
for 6.1 on top of it.
