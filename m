Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B607C52AEB9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 01:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbiEQXjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 19:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiEQXjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 19:39:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A3452B2D
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 16:39:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 74D64B81D63
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 23:39:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D69F9C385B8;
        Tue, 17 May 2022 23:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1652830753;
        bh=65mgIOZQb4alucF36hrCIzo3EqeozYcFQHGE5BWleDw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nTkTzCQq+k6ZGWtcRrAwxyP+pEayku3g3Cn2dp8puLuk+tazqL2q2aL4bYpFSK+Xc
         /Y1Mj3RyBkGrdCnPdj1naIR9j81C5G38jaWIBfyuzL/bbfirPxyIzyodpq8rRPBXHf
         //e3yx2m8Uke14VNx08u4foLV4M0F78b+XhjxzRM=
Date:   Tue, 17 May 2022 16:39:12 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     NeilBrown <neilb@suse.de>, <willy@infradead.org>, <vbabka@suse.cz>,
        <dhowells@redhat.com>, <apopple@nvidia.com>, <david@redhat.com>,
        <surenb@google.com>, <peterx@redhat.com>,
        <naoya.horiguchi@nec.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 09/15] mm/swap: avoid calling swp_swap_info when try to
 check SWP_STABLE_WRITES
Message-Id: <20220517163912.919475bf7fb5923da1325822@linux-foundation.org>
In-Reply-To: <d674bc33-fcf2-ebc1-b252-1e7232b3bd1c@huawei.com>
References: <20220509131416.17553-1-linmiaohe@huawei.com>
        <20220509131416.17553-10-linmiaohe@huawei.com>
        <165214248406.14782.6536817483979050668@noble.neil.brown.name>
        <d674bc33-fcf2-ebc1-b252-1e7232b3bd1c@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 May 2022 10:21:21 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:

> On 2022/5/10 8:28, NeilBrown wrote:
> > On Mon, 09 May 2022, Miaohe Lin wrote:
> >> Use flags of si directly to check SWP_STABLE_WRITES to avoid possible
> >> READ_ONCE and thus save some cpu cycles.
> >>
> >> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> >> ---
> >>  mm/memory.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/mm/memory.c b/mm/memory.c
> >> index 9c3e7e6ac202..89dd15504f3d 100644
> >> --- a/mm/memory.c
> >> +++ b/mm/memory.c
> >> @@ -3892,7 +3892,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >>  			 */
> >>  			exclusive = true;
> >>  		} else if (exclusive && PageWriteback(page) &&
> >> -			  (swp_swap_info(entry)->flags & SWP_STABLE_WRITES)) {
> >> +			  (si->flags & SWP_STABLE_WRITES)) {
> > 
> > Should this have a data_race() annotation.  Other bit-tests of si->flags
> > do because scan_swap_map_slots can update it asynchronously, but we know
> > that won't matter in practice.
> 
> Yes, you're right. scan_swap_map_slots can update si->flags asynchronously while
> do_swap_page tests SWP_STABLE_WRITES here. We know this is harmless because
> SWP_STABLE_WRITES is only changed at swapon/swapoff.
> 
> Will add data_race() annotation in next version to avoid possible KCSAN data-race complaint.
> 

I did this:

--- a/mm/memory.c~mm-swap-avoid-calling-swp_swap_info-when-try-to-check-swp_stable_writes-fix
+++ a/mm/memory.c
@@ -3889,7 +3889,7 @@ vm_fault_t do_swap_page(struct vm_fault
 			 */
 			exclusive = true;
 		} else if (exclusive && PageWriteback(page) &&
-			  (si->flags & SWP_STABLE_WRITES)) {
+			  data_race(si->flags & SWP_STABLE_WRITES)) {
 			/*
 			 * This is tricky: not all swap backends support
 			 * concurrent page modifications while under writeback.
_

