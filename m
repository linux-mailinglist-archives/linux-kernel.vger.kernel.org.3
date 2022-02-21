Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 594AA4BE366
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348599AbiBUJQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 04:16:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347909AbiBUJJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 04:09:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1F71C91D;
        Mon, 21 Feb 2022 01:02:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 08678B80EAC;
        Mon, 21 Feb 2022 09:02:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB9A2C340F3;
        Mon, 21 Feb 2022 09:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645434129;
        bh=No5SvW/qQe4jwmC+qej3w+cHlrTRKUCXpvJgRwrsQTA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qkT/vEFaMAHuGvom2URQqyWYR3h8IN25ik8YNrTiDzN/SzFCh5Fb90ZWTwjlAs9AX
         0WKpABuOCRZAXOvbmHnDBJ/BWW1qEle4/7RNNIewIF9ejzoFRzeMaicj9ZnnKVJ3N5
         HbmXY3PRfkSD77So4qD4WTHvCkX2OkESls+EhaOFDuEp7Wsb4a2s0y/iIVDp4+RZa9
         bpQdNuSb7eVGaYMaauThSvXvbw3G9cZ9+4eCR2sni+NjNh8EVMexku/MR4EAquO8Eu
         7y4ZpI9Ynz1ENzk7zitF8gSTjCe6dHR9IgZViRuVu8P/XW6bTYudamo35rrc/Y6jH3
         AzCW2Q7wHj2Cw==
Date:   Mon, 21 Feb 2022 11:01:53 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Barry Song <21cnbao@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Larabel <Michael@michaellarabel.com>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        page-reclaim@google.com, x86@kernel.org,
        Brian Geffon <bgeffon@google.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        Donald Carr <d@chaos-reins.com>,
        Holger =?iso-8859-1?Q?Hoffst=E4tte?= 
        <holger@applied-asynchrony.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>
Subject: Re: [PATCH v7 12/12] mm: multigenerational LRU: documentation
Message-ID: <YhNVAUM7H7PF7j7j@kernel.org>
References: <20220208081902.3550911-1-yuzhao@google.com>
 <20220208081902.3550911-13-yuzhao@google.com>
 <Ygou6Gq79XY3mFK7@kernel.org>
 <Ygxt4iR9ZMYEbV78@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ygxt4iR9ZMYEbV78@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 08:22:10PM -0700, Yu Zhao wrote:
> On Mon, Feb 14, 2022 at 12:28:56PM +0200, Mike Rapoport wrote:
> 
> > > +====== ========
> > > +Values Features
> > > +====== ========
> > > +0x0001 the multigenerational LRU
> > 
> > The multigenerational LRU what?
> 
> Itself? This depends on the POV, and I'm trying to determine what would
> be the natural way to present it.
> 
> MGLRU itself could be seen as an add-on atop the existing page reclaim
> or an alternative in parallel. The latter would be similar to sl[aou]b,
> and that's how I personally see it.
> 
> But here I presented it more like the former because I feel this way is
> more natural to users because they are like switches on a single panel.

Than I think it should be described as "enable multigenerational LRU" or
something like this.
 
> > What will happen if I write 0x2 to this file?
> 
> Just like turning on a branch breaker while leaving the main breaker
> off in a circuit breaker box. This is how I see it, and I'm totally
> fine with changing it to whatever you'd recommend.

That was my guess that when bit 0 is clear the rest do not matter :)
What's important, IMO, is that it is stated explicitly in the description.
 
> > Please consider splitting "enable" and "features" attributes.
> 
> How about s/Features/Components/?

I meant to use two attributes:

/sys/kernel/mm/lru_gen/enable for the main breaker, and
/sys/kernel/mm/lru_gen/features (or components) for the branch breakers
 
> > > +0x0002 clear the accessed bit in leaf page table entries **in large
> > > +       batches**, when MMU sets it (e.g., on x86)
> > 
> > Is extra markup really needed here...
> > 
> > > +0x0004 clear the accessed bit in non-leaf page table entries **as
> > > +       well**, when MMU sets it (e.g., on x86)
> > 
> > ... and here?
> 
> Will do.
> 
> > As for the descriptions, what is the user-visible effect of these features?
> > How different modes of clearing the access bit are reflected in, say, GUI
> > responsiveness, database TPS, or probability of OOM?
> 
> These remain to be seen :) I just added these switches in v7, per Mel's
> request from the meeting we had. These were never tested in the field.

I see :)

It would be nice to have a description or/and examples of user-visible
effects when there will be some insight on what these features do.

> > > +:Debugfs interface: ``/sys/kernel/debug/lru_gen`` has the following
> > 
> > Is debugfs interface relevant only for datacenters? 
> 
> For the moment, yes.

And what will happen if somebody uses these interfaces outside
datacenters? As soon as there is a sysfs intefrace, somebody will surely
play with it.

I think the job schedulers might be the most important user of that
interface, but the documentation should not presume it is the only user.
 
> > > + job scheduler writes to this file at a certain time interval to
> > > + create new generations, and it ranks available servers based on the
> > > + sizes of their cold memory defined by this time interval. For
> > > + proactive reclaim, a job scheduler writes to this file before it
> > > + tries to land a new job, and if it fails to materialize the cold
> > > + memory without impacting the existing jobs, it retries on the next
> > > + server according to the ranking result.
> > 
> > Is this knob only relevant for a job scheduler? Or it can be used in other
> > use-cases as well?
> 
> There are other concrete use cases but I'm not ready to discuss them
> yet.
 
Here as well, as soon as there is an interface it's not necessarily "job
scheduler" that will "write to this file", anybody can write to that file.
Please adjust the documentation to be more neutral regarding the use-cases.

-- 
Sincerely yours,
Mike.
