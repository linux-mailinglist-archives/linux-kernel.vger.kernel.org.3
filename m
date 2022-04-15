Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91CF35031A1
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 01:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354902AbiDOVe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 17:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbiDOVez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 17:34:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B7FAAC8B;
        Fri, 15 Apr 2022 14:32:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9AB7062185;
        Fri, 15 Apr 2022 21:32:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ADA9C385A4;
        Fri, 15 Apr 2022 21:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1650058343;
        bh=3UWUcyacMiJlx7p1411HKtWv5JjN8giHOd5i3EG0zSU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JrZnPatO9LRi5eqCzk79CipiGJo5Y/fO7qwH9Qd+NPfbU1e/C3vo7TPs8SeoPNNBn
         QBs9tMWzjWV+goiaCOE99AzqZXatzAUIhtMAy03dOsjf4od9MMdhDi8q6b4cPyAcf4
         KHcD5FHBDK5ACrThpIUEFXS/39sgtHveD+V3oKUk=
Date:   Fri, 15 Apr 2022 14:32:20 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Justin Forbes <jforbes@fedoraproject.org>,
        Stephen Rothwell <sfr@rothwell.id.au>,
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
Message-Id: <20220415143220.cc37b0b0a368ed2bf2a821f8@linux-foundation.org>
In-Reply-To: <CAOUHufYsjwMGMFCfYoh79rFZqwqS1jDihcBS9sHd-gBxEAD3Ug@mail.gmail.com>
References: <20220407031525.2368067-1-yuzhao@google.com>
        <20220407031525.2368067-9-yuzhao@google.com>
        <20220411191621.0378467ad99ebc822d5ad005@linux-foundation.org>
        <CAOUHufYeC=Kuu59BPL_48sM67CqACxH2wWy-SYGXpadgMDmY3w@mail.gmail.com>
        <20220414185654.e7150bcbe859e0dd4b9c61af@linux-foundation.org>
        <CAOUHufYy6yQS9ARN9C5+ODkopR+ez4TH3hZNZo4HtNHBExS1mA@mail.gmail.com>
        <20220415121521.764a88dda55ae8c676ad26b0@linux-foundation.org>
        <CAOUHufYsjwMGMFCfYoh79rFZqwqS1jDihcBS9sHd-gBxEAD3Ug@mail.gmail.com>
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

On Fri, 15 Apr 2022 14:11:32 -0600 Yu Zhao <yuzhao@google.com> wrote:

> >
> > I grabbed
> > https://kojipkgs.fedoraproject.org//packages/kernel/5.18.0/0.rc2.23.fc37/src/kernel-5.18.0-0.rc2.23.fc37.src.rpm
> > and
> 
> Yes, Fedora/RHEL is one concrete example of the model I mentioned
> above (experimental/stable). I added Justin, the Fedora kernel
> maintainer, and he can further clarify.
> 
> If we don't want more VM_BUG_ONs, I'll remove them. But (let me
> reiterate) it seems to me that just defeats the purpose of having
> CONFIG_DEBUG_VM.
> 

Well, I feel your pain.  It was never expected that VM_BUG_ON() would
get subverted in this fashion.

We could create a new MM-developer-only assertion.  Might even call it
MM_BUG_ON().  With compile-time enablement but perhaps not a runtime
switch.

With nice simple semantics, please.  Like "it returns void" and "if you
pass an expression with side-effects then you lose".  And "if you send
a patch which produces warnings when CONFIG_MM_BUG_ON=n then you get to
switch to windows95 for a month".

Let's leave the mglru assertions in place for now and let's think about
creating something more suitable, with a view to switching mglru over
to that at a later time.



But really, none of this addresses the core problem: *_BUG_ON() often
kills the kernel.  So guess what we just did?  We killed the user's
kernel at the exact time when we least wished to do so: when they have
a bug to report to us.  So the thing is self-defeating.

It's much much better to WARN and to attempt to continue.  This makes
it much more likely that we'll get to hear about the kernel flaw.
