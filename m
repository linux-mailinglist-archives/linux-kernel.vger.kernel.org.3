Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 149D5502F29
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 21:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243825AbiDOTSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 15:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238645AbiDOTRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 15:17:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E5F49C80;
        Fri, 15 Apr 2022 12:15:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3015661DEE;
        Fri, 15 Apr 2022 19:15:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2534C385A5;
        Fri, 15 Apr 2022 19:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1650050123;
        bh=s9C8faIK00xt2+0wVedQjvZhl8ZJTVhHLnw3heyEu+M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=n9y0C56ItXZ6xpNq/g2dEU0MMwPVCIqzYqUviq3BiqGuyOlvqC3EoUKF/0oInwbVf
         SFi471arNEwMtWyXZuITw10ESGMeic7mS4iX63OYEkT4VdPVoTl5TdPvK0MZ7lPXaa
         1M7XBEfatPouaHlItxQ21PVYu5o5PQvtdvC80rBg=
Date:   Fri, 15 Apr 2022 12:15:21 -0700
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
Message-Id: <20220415121521.764a88dda55ae8c676ad26b0@linux-foundation.org>
In-Reply-To: <CAOUHufYy6yQS9ARN9C5+ODkopR+ez4TH3hZNZo4HtNHBExS1mA@mail.gmail.com>
References: <20220407031525.2368067-1-yuzhao@google.com>
        <20220407031525.2368067-9-yuzhao@google.com>
        <20220411191621.0378467ad99ebc822d5ad005@linux-foundation.org>
        <CAOUHufYeC=Kuu59BPL_48sM67CqACxH2wWy-SYGXpadgMDmY3w@mail.gmail.com>
        <20220414185654.e7150bcbe859e0dd4b9c61af@linux-foundation.org>
        <CAOUHufYy6yQS9ARN9C5+ODkopR+ez4TH3hZNZo4HtNHBExS1mA@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Apr 2022 00:25:45 -0600 Yu Zhao <yuzhao@google.com> wrote:

> On Thu, Apr 14, 2022 at 7:57 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Thu, 14 Apr 2022 19:14:54 -0600 Yu Zhao <yuzhao@google.com> wrote:
> >
> > > On Mon, Apr 11, 2022 at 8:16 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> > > >
> > > > On Wed,  6 Apr 2022 21:15:20 -0600 Yu Zhao <yuzhao@google.com> wrote:
> > > >
> > > > > +static void update_batch_size(struct lru_gen_mm_walk *walk, struct folio *folio,
> > > > > +                           int old_gen, int new_gen)
> > > > > +{
> > > > > +     int type = folio_is_file_lru(folio);
> > > > > +     int zone = folio_zonenum(folio);
> > > > > +     int delta = folio_nr_pages(folio);
> > > > > +
> > > > > +     VM_BUG_ON(old_gen >= MAX_NR_GENS);
> > > > > +     VM_BUG_ON(new_gen >= MAX_NR_GENS);
> > > >
> > > > General rule: don't add new BUG_ONs, because they crash the kenrel.
> > > > It's better to use WARN_ON or WARN_ON_ONCE then try to figure out a way
> > > > to keep the kernel limping along.  At least so the poor user can gather logs.
> > >
> > > These are VM_BUG_ONs, which are BUILD_BUG_ONs except for (mostly MM) developers.
> >
> > I'm told that many production builds enable runtime VM_BUG_ONning.
> 
> Nobody wants to debug VM in production. Some distros that offer both
> the latest/LTS kernels do enable CONFIG_DEBUG_VM in the former so the
> latter can have better test coverage when it becomes available. Do
> people use the former in production? Absolutely, otherwise we won't
> have enough test coverage. Are we supposed to avoid CONFIG_DEBUG_VM? I
> don't think so, because it defeats the purpose of those distros
> enabling it in the first place.
> 
> The bottomline is that none of RHEL 8.5, SLES 15, Debian 11 enables
> CONFIG_DEBUG_VM.

I grabbed
https://kojipkgs.fedoraproject.org//packages/kernel/5.18.0/0.rc2.23.fc37/src/kernel-5.18.0-0.rc2.23.fc37.src.rpm
and 

hp2:/home/akpm/yy> grep "DEBUG_VM[= ]" *.config 
kernel-aarch64-debug-fedora.config:CONFIG_DEBUG_VM=y
kernel-aarch64-debug-rhel.config:# CONFIG_DEBUG_VM is not set
kernel-aarch64-fedora.config:CONFIG_DEBUG_VM=y
kernel-aarch64-rhel.config:# CONFIG_DEBUG_VM is not set
kernel-armv7hl-debug-fedora.config:CONFIG_DEBUG_VM=y
kernel-armv7hl-fedora.config:CONFIG_DEBUG_VM=y
kernel-armv7hl-lpae-debug-fedora.config:CONFIG_DEBUG_VM=y
kernel-armv7hl-lpae-fedora.config:CONFIG_DEBUG_VM=y
kernel-ppc64le-debug-fedora.config:CONFIG_DEBUG_VM=y
kernel-ppc64le-debug-rhel.config:CONFIG_DEBUG_VM=y
kernel-ppc64le-fedora.config:CONFIG_DEBUG_VM=y
kernel-ppc64le-rhel.config:# CONFIG_DEBUG_VM is not set
kernel-s390x-debug-fedora.config:CONFIG_DEBUG_VM=y
kernel-s390x-debug-rhel.config:CONFIG_DEBUG_VM=y
kernel-s390x-fedora.config:CONFIG_DEBUG_VM=y
kernel-s390x-rhel.config:# CONFIG_DEBUG_VM is not set
kernel-s390x-zfcpdump-rhel.config:# CONFIG_DEBUG_VM is not set
kernel-x86_64-debug-fedora.config:CONFIG_DEBUG_VM=y
kernel-x86_64-debug-rhel.config:CONFIG_DEBUG_VM=y
kernel-x86_64-fedora.config:CONFIG_DEBUG_VM=y
kernel-x86_64-rhel.config:# CONFIG_DEBUG_VM is not set

