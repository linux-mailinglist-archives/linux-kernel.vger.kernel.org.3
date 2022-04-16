Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 322325033D6
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 07:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbiDPEXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 00:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbiDPEXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 00:23:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F840F894C;
        Fri, 15 Apr 2022 21:20:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4BC24B80ED4;
        Sat, 16 Apr 2022 04:20:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 500FEC385A3;
        Sat, 16 Apr 2022 04:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1650082827;
        bh=ndP7DnH+0uV9LgZ6UnXjtKlMPqFkQCYtGcMxI22lfkw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DngN/TqwEnTZN+jzz+HXCnHt18Ew6TbspwXKOFu6q4lTgpjzVgON0emfN4IrDsh3d
         VV0zjcuL0bs+J2ek9nDUp+l5YV4oSmn4vzoRaiBspjThPY8emzLVS0i0xxTT7yBFk1
         Nsff9JX38lKG68EEayIJVXCzA/uZFf0ZXppn/4Xg=
Date:   Fri, 15 Apr 2022 21:20:24 -0700
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
Subject: Re: [PATCH v10 12/14] mm: multi-gen LRU: debugfs interface
Message-Id: <20220415212024.c682ac000e3e91572d8d6d2b@linux-foundation.org>
In-Reply-To: <CAOUHufYhhCPFqoRbtn+=OFxZxNWS9yxW9Re_s-2TYGqCEaMXVw@mail.gmail.com>
References: <20220407031525.2368067-1-yuzhao@google.com>
        <20220407031525.2368067-13-yuzhao@google.com>
        <20220411191634.674554d3de2ba37b3db40ca2@linux-foundation.org>
        <CAOUHufYhhCPFqoRbtn+=OFxZxNWS9yxW9Re_s-2TYGqCEaMXVw@mail.gmail.com>
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

On Fri, 15 Apr 2022 18:03:16 -0600 Yu Zhao <yuzhao@google.com> wrote:

> > Presumably sysfs is the place.  Fully documented and with usage
> > examples in the changelog so we can carefully review the proposed
> > extensions to Linux's ABI.  Extensions which must be maintained
> > unchanged for all time.
> 
> Eventually, yes. There still is a long way to go. Rest assured, this
> is something Google will keep investing resources on.

So.  The plan is to put these interfaces in debugfs for now, with a
view to migrating stabilized interfaces into sysfs (or procfs or
whatever) once end-user requirements and use cases are better
understood?

If so, that sounds totally great to me.  But it should have been in
the darn changelog!  This is the sort of thing which we care about most
keenly.

It would be helpful for reviewers to understand the proposed timeline
for this process, because the entire feature isn't really real until
this is completed, is it?  I do think we should get this nailed down
relatively rapidly, otherwise people will be reluctant to invest much
into a moving target.

And I must say, I see dissonance between the overall maturity of the
feature as described in these emails versus the immaturity of these
userspace control interfaces.  What's happening there?
