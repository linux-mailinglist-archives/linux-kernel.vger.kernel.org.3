Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656FF510E3C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 03:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356772AbiD0BiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 21:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356760AbiD0BiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 21:38:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239751749E6;
        Tue, 26 Apr 2022 18:34:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7BA74B82472;
        Wed, 27 Apr 2022 01:34:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3176C385AC;
        Wed, 27 Apr 2022 01:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1651023291;
        bh=dSVYLEetv78FW+gtzyAvwAnMSrgvka4Nww/5vTmvfkY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BtCnxzGfo/fzgOWgJ2FBU1pxuFtz6fkh8N9dLoVanvGlrrQzg1mY0o6uIqwxS2ufl
         xW5vdTBDw2gaeBAQ26Kho+99RwdWCFM4Qzl5BxZp1oYgpZB+JRWh8bOakHDRvv6aBK
         d34Ih7NOoILog3q+VC9/CsZ/iXaJPUfzPplEs04s=
Date:   Tue, 26 Apr 2022 18:34:48 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Stephen Rothwell <sfr@rothwell.id.au>,
        Linux-MM <linux-mm@kvack.org>, Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Barry Song <21cnbao@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Page Reclaim v2 <page-reclaim@google.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Brian Geffon <bgeffon@google.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        Donald Carr <d@chaos-reins.com>,
        Holger =?ISO-8859-1?Q?Hoffst=E4tte?= 
        <holger@applied-asynchrony.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>,
        Vaibhav Jain <vaibhav@linux.ibm.com>
Subject: Re: [PATCH v10 05/14] mm: multi-gen LRU: groundwork
Message-Id: <20220426183448.3538d53eb9aafb48d1bfdb2b@linux-foundation.org>
In-Reply-To: <CAOUHufbMA7VutATpDYZ15JT_WuP9MGL_Vp6q5KFk72OjzRV+qQ@mail.gmail.com>
References: <20220407031525.2368067-1-yuzhao@google.com>
        <20220407031525.2368067-6-yuzhao@google.com>
        <20220411191615.a34959bdcc25ef3f9c16a7ce@linux-foundation.org>
        <CAOUHufaeNzDJnDqatHe0MwsN-D6M_tw6JX2UBJFc+JpZNP86hQ@mail.gmail.com>
        <20220426164241.99e6a283c371ed75fa5c12a0@linux-foundation.org>
        <CAOUHufbMA7VutATpDYZ15JT_WuP9MGL_Vp6q5KFk72OjzRV+qQ@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Apr 2022 19:18:21 -0600 Yu Zhao <yuzhao@google.com> wrote:

> > For example, lru_gen_add_folio() is huge and has 4(?) call sites.  This
> > may well produce slower code due to the icache footprint.
> >
> > Experiment: moving lru_gen_del_folio() into mm/vmscan.c shrinks that
> > file's .text from 80612 bytes to 78956.
> >
> > I tend to think that out-of-line regular old C functions should be the
> > default and that the code should be inlined only when a clear benefit
> > is demonstrable, or has at least been seriously thought about.
> 
> I can move those functions to vmscan.c if you think it would improve
> performance. I don't have a strong opinion here -- I was able to
> measure the bloat but not the performance impact.

This seems to be more an act of faith than anything else.  Unlikely
that any difference will be measurable.

If there is a difference, the inlined version should win on
microbenchmarks because all four copies of the function will be in
cache.  But a more realistic, broader test might suffer a slowdown due
to having to move the larger text in more frequently.  And inter-build
alignment changes seem to make a larger difference than anything else,
thus confounding measurement attempts.
