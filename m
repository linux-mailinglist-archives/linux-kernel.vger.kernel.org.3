Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E888533343
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 00:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242039AbiEXWKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 18:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232733AbiEXWKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 18:10:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AEA76D4FE
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 15:10:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5FE7617B2
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 22:10:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 913D0C34100;
        Tue, 24 May 2022 22:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1653430216;
        bh=fZAWkq2j47J0eNsYpu0+vT/cRpk5mud27VEFXwZ+hJ4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RZVj4kPJSLFHvGItWmpoIZ1bUOM1mqTRMc/1848nLMgNSdb4VvuJxfnHjvEPUPoPC
         W/RKDcuyPwQidVRmUiGg4HdvQ0h/URJbP6AOvzk6oIBUyAINyZbVVXx8aGSZ8eJADK
         jHHLBZSuPltGKrc0lfE+PI6Dlml1+1RMtvuFC2JY=
Date:   Tue, 24 May 2022 15:10:14 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     HORIGUCHI =?UTF-8?B?TkFPWUE=?= (=?UTF-8?B?5aCA5Y+jIOebtOS5nw==?=) 
        <naoya.horiguchi@nec.com>, "hughd@google.com" <hughd@google.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "neilb@suse.de" <neilb@suse.de>,
        "apopple@nvidia.com" <apopple@nvidia.com>,
        "david@redhat.com" <david@redhat.com>,
        "surenb@google.com" <surenb@google.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "rcampbell@nvidia.com" <rcampbell@nvidia.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 4/5] mm/shmem: fix infinite loop when swap in shmem
 error at swapoff time
Message-Id: <20220524151014.4d16f01cbd1c04ef74e4db5e@linux-foundation.org>
In-Reply-To: <0f6dc98b-88f4-c0c9-eb7b-5356ad0e08b1@huawei.com>
References: <20220519125030.21486-1-linmiaohe@huawei.com>
        <20220519125030.21486-5-linmiaohe@huawei.com>
        <20220520063433.GA584983@hori.linux.bs1.fc.nec.co.jp>
        <0f6dc98b-88f4-c0c9-eb7b-5356ad0e08b1@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 May 2022 17:34:28 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:

> On 2022/5/20 14:34, HORIGUCHI NAOYA(堀口 直也) wrote:
> > On Thu, May 19, 2022 at 08:50:29PM +0800, Miaohe Lin wrote:
> >> When swap in shmem error at swapoff time, there would be a infinite loop
> >> in the while loop in shmem_unuse_inode(). It's because swapin error is
> >> deliberately ignored now and thus info->swapped will never reach 0. So
> >> we can't escape the loop in shmem_unuse().
> >>
> >> In order to fix the issue, swapin_error entry is stored in the mapping
> >> when swapin error occurs. So the swapcache page can be freed and the
> >> user won't end up with a permanently mounted swap because a sector is
> >> bad. If the page is accessed later, the user process will be killed
> >> so that corrupted data is never consumed. On the other hand, if the
> >> page is never accessed, the user won't even notice it.
> >>
> >> Reported-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> >> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> > 
> > Hi Miaohe,
> > 
> > Thank you for the update.  I might miss something, but I still see the same
> > problem (I checked it on mm-everything-2022-05-19-00-03 + this patchset).
> 
> Hi Naoya,
> I reproduce the issue in the linux-next-next-20220520 version. And I found even if
> I *do not inject the swapin error*, the deadloop still occurs. After investigating the
> code for a long while, I found the root cause:
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index d55dd972023a..6d23ed4d23cb 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1182,7 +1182,7 @@ static int shmem_find_swap_entries(struct address_space *mapping,
>                 if (swp_type(entry) != type)
>                         continue;
> 
> -               indices[ret] = xas.xa_index;
> +               indices[ret++] = xas.xa_index;
>                 if (!folio_batch_add(fbatch, folio))
>                         break;
> 
> The origin code does not increment the ret value when a folio is found. I will send a patch
> to fix this next week. Thanks! :)

So I'm thinking that with Hugh's "mm/shmem: fix shmem folio swapoff
hang", this patchset is now looking OK, so

mm-swapfile-unuse_pte-can-map-random-data-if-swap-read-fails.patch
mm-swapfile-fix-lost-swap-bits-in-unuse_pte.patch
mm-madvise-free-hwpoison-and-swapin-error-entry-in-madvise_free_pte_range.patch
mm-shmem-fix-infinite-loop-when-swap-in-shmem-error-at-swapoff-time.patch
mm-filter-out-swapin-error-entry-in-shmem-mapping.patch
#

are OK for merging into mainline?
