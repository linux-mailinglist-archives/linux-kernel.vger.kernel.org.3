Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDE2950203F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 03:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348539AbiDOB72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 21:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345417AbiDOB71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 21:59:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE02B0D27;
        Thu, 14 Apr 2022 18:57:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EA5B5B82BE8;
        Fri, 15 Apr 2022 01:56:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EED4CC385A5;
        Fri, 15 Apr 2022 01:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1649987817;
        bh=ysnJvJIjZnyxWKZuaQD4LsgYeCMzMSJq6bj2UggluuM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KScx2dLZArE6eYk81pk/lFBIfXKqb0xej5bLwVJZ2U1ypZzz63FJtTcE1PViKwtlI
         bn5liD8s3f5BQWa/2LQSwPj5cwH8Izf7z+YmG+S0KhA13IPHRld2oDbVjovhfIbvD9
         YL8p0jxgE4cK1JbgeRGlbwvxLsGMbTvCXG9UNhz8=
Date:   Thu, 14 Apr 2022 18:56:54 -0700
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
Subject: Re: [PATCH v10 08/14] mm: multi-gen LRU: support page table walks
Message-Id: <20220414185654.e7150bcbe859e0dd4b9c61af@linux-foundation.org>
In-Reply-To: <CAOUHufYeC=Kuu59BPL_48sM67CqACxH2wWy-SYGXpadgMDmY3w@mail.gmail.com>
References: <20220407031525.2368067-1-yuzhao@google.com>
        <20220407031525.2368067-9-yuzhao@google.com>
        <20220411191621.0378467ad99ebc822d5ad005@linux-foundation.org>
        <CAOUHufYeC=Kuu59BPL_48sM67CqACxH2wWy-SYGXpadgMDmY3w@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Apr 2022 19:14:54 -0600 Yu Zhao <yuzhao@google.com> wrote:

> On Mon, Apr 11, 2022 at 8:16 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Wed,  6 Apr 2022 21:15:20 -0600 Yu Zhao <yuzhao@google.com> wrote:
> >
> > > +static void update_batch_size(struct lru_gen_mm_walk *walk, struct folio *folio,
> > > +                           int old_gen, int new_gen)
> > > +{
> > > +     int type = folio_is_file_lru(folio);
> > > +     int zone = folio_zonenum(folio);
> > > +     int delta = folio_nr_pages(folio);
> > > +
> > > +     VM_BUG_ON(old_gen >= MAX_NR_GENS);
> > > +     VM_BUG_ON(new_gen >= MAX_NR_GENS);
> >
> > General rule: don't add new BUG_ONs, because they crash the kenrel.
> > It's better to use WARN_ON or WARN_ON_ONCE then try to figure out a way
> > to keep the kernel limping along.  At least so the poor user can gather logs.
> 
> These are VM_BUG_ONs, which are BUILD_BUG_ONs except for (mostly MM) developers.

I'm told that many production builds enable runtime VM_BUG_ONning.
