Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1514552E1C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 11:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347355AbiFUJVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 05:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345332AbiFUJVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 05:21:22 -0400
Received: from outbound-smtp20.blacknight.com (outbound-smtp20.blacknight.com [46.22.139.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A401AF1A
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 02:21:20 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp20.blacknight.com (Postfix) with ESMTPS id A81641C4684
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 10:21:18 +0100 (IST)
Received: (qmail 19133 invoked from network); 21 Jun 2022 09:21:18 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 21 Jun 2022 09:21:18 -0000
Date:   Tue, 21 Jun 2022 10:21:16 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Yu Zhao <yuzhao@google.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH 7/7] mm/page_alloc: Replace local_lock with normal
 spinlock
Message-ID: <20220621092116.GC15453@techsingularity.net>
References: <20220613125622.18628-1-mgorman@techsingularity.net>
 <20220613125622.18628-8-mgorman@techsingularity.net>
 <CGME20220615224855eucas1p1ea6d90c23ec9423dfe04b267f6dddd2a@eucas1p1.samsung.com>
 <e1c73640-3f29-bf57-b98d-84b1800cf4e3@samsung.com>
 <20220615160446.be1f75fd256d67e57b27a9fc@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20220615160446.be1f75fd256d67e57b27a9fc@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 04:04:46PM -0700, Andrew Morton wrote:
> On Thu, 16 Jun 2022 00:48:55 +0200 Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> 
> > In the logs I see lots of errors like:
> > 
> > BUG: sleeping function called from invalid context at 
> > ./include/linux/sched/mm.h:274
> > 
> > BUG: scheduling while atomic: systemd-udevd/288/0x00000002
> > 
> > BUG: sleeping function called from invalid context at mm/filemap.c:2647
> > 
> > however there are also a fatal ones like:
> > 
> > Unable to handle kernel paging request at virtual address 00000000017a87b4
> > 
> > 
> > The issues seems to be a bit random. Looks like memory trashing. 
> > Reverting $subject on top of current linux-next fixes all those issues.
> > 
> > 
> 
> This?
> 
> --- a/mm/page_alloc.c~mm-page_alloc-replace-local_lock-with-normal-spinlock-fix
> +++ a/mm/page_alloc.c
> @@ -183,8 +183,10 @@ static DEFINE_MUTEX(pcp_batch_high_lock)
>  	type *_ret;							\
>  	pcpu_task_pin();						\
>  	_ret = this_cpu_ptr(ptr);					\
> -	if (!spin_trylock_irqsave(&_ret->member, flags))		\
> +	if (!spin_trylock_irqsave(&_ret->member, flags)) {		\
> +		pcpu_task_unpin();					\
>  		_ret = NULL;						\
> +	}								\
>  	_ret;								\
>  })
>  

This is the correct fix. I *had* a fix for this but in a patch that was
not posted that drops irqsave :(

-- 
Mel Gorman
SUSE Labs
