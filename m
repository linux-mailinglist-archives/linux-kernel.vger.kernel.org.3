Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75C90587BEC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 14:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236674AbiHBMEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 08:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbiHBMES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 08:04:18 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878624AD7A;
        Tue,  2 Aug 2022 05:04:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 279431F936;
        Tue,  2 Aug 2022 12:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1659441855; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yNCOVJvTvXYjkbinC2wpPiVJJz4uAY9LW/GyhexozMg=;
        b=Y/f4ThdH9BA3tZ6Mfyjhq2ZRwzYGOqQn6/SVYc6F8K9jwumW860ltxLGH9ZEdggr4RJgG8
        qz88X9PpFtY85Nurju+9YH5zwoG6AKodu7DB1m8/wPvzc14p5eSmoX1H0n3UipW33jaIgb
        Rk2hmRcA9zN84E8AM/lNtlb70xzFAWI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F2D7E13A8E;
        Tue,  2 Aug 2022 12:04:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +04/O74S6WKhNQAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 02 Aug 2022 12:04:14 +0000
Date:   Tue, 2 Aug 2022 14:04:14 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Zach O'Keefe <zokeefe@google.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Axel Rasmussen <axelrasmussen@google.com>,
        James Houghton <jthoughton@google.com>,
        Hugh Dickins <hughd@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Peter Xu <peterx@redhat.com>,
        Rongwei Wang <rongwei.wang@linux.alibaba.com>,
        SeongJae Park <sj@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Chris Kennelly <ckennelly@google.com>,
        Chris Zankel <chris@zankel.net>, Helge Deller <deller@gmx.de>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Jens Axboe <axboe@kernel.dk>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matt Turner <mattst88@gmail.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Minchan Kim <minchan@kernel.org>,
        Patrick Xia <patrickx@google.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: [PATCH mm-unstable] mm/madvise: remove CAP_SYS_ADMIN requirement
 for process_madvise(MADV_COLLAPSE)
Message-ID: <YukSvpPRuus2bHOu@dhcp22.suse.cz>
References: <20220801210946.3069083-1-zokeefe@google.com>
 <YujpzGKImMQsn8SM@dhcp22.suse.cz>
 <CAAa6QmS=VbsdvHgvFQCceV+pYHwSSj1pjhX3_voz12T4rJ-EBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAa6QmS=VbsdvHgvFQCceV+pYHwSSj1pjhX3_voz12T4rJ-EBQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 02-08-22 02:48:33, Zach O'Keefe wrote:
[...]
> "mm/madvise: add MADV_COLLAPSE to process_madvise()" in the v7 series
> ended with me mentioning a couple options, but ultimately I didn't
> present a solution, and no consensus was reached[1]. After taking a
> closer look, this is my proposal for what I believe to be the best
> path forward. It should be squashed into the original patch. What do you think?

If it is agreed that the CAP_SYS_ADMIN is too strict of a requirement
then yes, this should be squashed into the original patch. There is no
real reason to create a potential bisection headache by changing the
permission model in a later patch.

From my POV, I would agree that CAP_SYS_ADMIN is just too strict of a
requirement.

I didn't really have time to follow recent discussions but I would argue
that the operation is not really destructive or seriously harmful. All
applications can already have their memory (almost) equally THP
collapsed by khupaged with the proposed process_madvise semantic.

NOHUGEMEM and prctl opt out from THP are both honored AFAIU and the only
difference is the global THP killswitch behavior which I do not think
warrants the strongest CAP_SYS_ADMIN capability (especially because it
doesn't really control all kinds of THPs).

If there is a userspace agent collapsing memory and causing problems
then it can be easily fixed in the userspace. And I find that easier
to do than putting the bar so high that userspace agents would be
unfeasible because of CAP_SYS_ADMIN (which is nono in many cases as it
would allow essentially full control of other stuff). So from practical
POV, risking an extended RSS is really a negligible risk to lose a
potentially useful feature for all others.

Just my 2c

> Thanks again,
> Zach
> 
> [1] https://lore.kernel.org/linux-mm/Ys4aTRqWIbjNs1mI@google.com/

-- 
Michal Hocko
SUSE Labs
