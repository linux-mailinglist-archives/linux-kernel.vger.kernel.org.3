Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6015B4FCC46
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 04:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243546AbiDLCSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 22:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbiDLCSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 22:18:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8092A24A;
        Mon, 11 Apr 2022 19:16:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D1996168C;
        Tue, 12 Apr 2022 02:16:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E5F1C385A4;
        Tue, 12 Apr 2022 02:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1649729762;
        bh=tni5PvWyZxUvzvzTtCOxpTSc4Z5BiuG+j4AAUMjSjLw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ypvt4LtLI/wxKQQOhAHailuFJouqrOwDHQdOxKPFUl0+7Q9WuFLM3+RQ0vokvusr7
         G1Nozi6lKTTm+nfFda9SoF2eedu2cD736RrVrFD96DVmyx49cXTpjMjJWqoYggHVPg
         NTal9bWOGMDNrGM/13809C+0fKJ4TqG1VRF/+dA4=
Date:   Mon, 11 Apr 2022 19:15:59 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Stephen Rothwell <sfr@rothwell.id.au>, linux-mm@kvack.org,
        Andi Kleen <ak@linux.intel.com>,
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
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, page-reclaim@google.com,
        x86@kernel.org
Subject: Re: [PATCH v10 00/14] Multi-Gen LRU Framework
Message-Id: <20220411191559.a844c7140faeba2e68d842b7@linux-foundation.org>
In-Reply-To: <20220407031525.2368067-1-yuzhao@google.com>
References: <20220407031525.2368067-1-yuzhao@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


It's pretty clear from the results and from the test coverage to date
that Linux wants this.

I do think additional review is needed.  For the usual code quality
reasons, but also to help others get up to speed with the proposed
changes and to ensure that we have something which is well maintainable
going forward.

The code at present is unnecessarily difficult to review and that
review will be less effective than it might be, because of its lack of
commentary.

I'll merge the v10 series into -mm and -next for additional runtime
exposure, but I'll be asking for a broad update.

The data structures appear to be adequately documented (this is rare)
but the code itself is lacking.  Please go through each and every new
function and ask "is this function so self-evident that it can be
presented to a newcomer with no explanatory comments at all".

If "yes" then check again.  If still "yes" then fine.  If "no" then
let's craft comments which tell the reader things which are not evident
from the code itself.  Things which are helpful to that reader.  Design
concepts, side-effects, preconditions, unobvious traps, etc.

Please ensure that the current group of mglru developers review these
comment additions as closely as they review code changes.

Alas, it's late in the process to be adding these things.  But it can
be made better.

I'll make some high-level comments on the patches themselves now, but I
see little point in attempting detailed review when a better-explained
version is hopefully forthcoming.


A few gratuitous notebook entries:

- lru_gen_struct.timestamps works in jiffies?  Why?  jiffies can vary
  based on platform and config - why add inter-platform and
  inter-Kconfig variability like this?  Time is measured in seconds!

  And the amount of work which can be performed in one second varies
  by, guess, 100x on machines which we care about.  This also has
  potential to introduce tremendous inter-platform variability in the
  behaviour of this feature.

- did lru_gen_use_mm() really need to test nodes_full()?  Is that
  likely enough to be a net benefit?

- seq_is_valid() sounds like it belongs to the seq_file() subsystem

- does get_nr_evictable() need to return and use signed types (long)?
  It sums the contents of lru_gen_struct.nr_pages[][][], which is
  ulong, so I think "no".
