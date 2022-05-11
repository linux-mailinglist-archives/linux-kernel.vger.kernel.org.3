Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D404B52412F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 01:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349463AbiEKXpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 19:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349452AbiEKXpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 19:45:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1FC36211F
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 16:45:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 81066B82642
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 23:45:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 266A4C340EE;
        Wed, 11 May 2022 23:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652312735;
        bh=b6mgKJpVJA/b7+VDSLPzDbu9hDNiACAHNnivpAnLRXQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=NQu3DKyBmK8FcoCK67b8nygpYZHdzwkv8l49/7YNJqI22QYKFW0YKFLz6fh2Gdq/6
         lK3q+K1EwN5AW1fTyV+603TNksBJI5aOD4KVFaI5dfkrZIVyt5NT01tyNhaaZIe0sW
         yiUchbbd2TNRSP5ZG0vEMhwj3svStRjxS3MS7uyzG1dPbyw7z6aHBOZs04GGEZZpry
         Bvh0r3gnZQ32rAUsXBn4hPVPmdeJoFAcXJ4acEkAICBfqU7TTaSFjzirHp2GuFq1lh
         wFytBIQfJim9nuY9bq/wx1UNNDgNzDRR/WL+LAjvbCirBnA9VLdpmKCHkythUmn7dD
         OJKYM0sxY6jMg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id BAFD55C05FC; Wed, 11 May 2022 16:45:34 -0700 (PDT)
Date:   Wed, 11 May 2022 16:45:34 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Dias <joaodias@google.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v4] mm: fix is_pinnable_page against on cma page
Message-ID: <20220511234534.GG1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <Ynr10y6pkH6WwbQo@google.com>
 <bb6e76f1-2cbc-893d-c8ab-3ecd3fcae2a5@nvidia.com>
 <Ynr+wTCQpyh8+vOD@google.com>
 <2ffa7670-04ea-bb28-28f8-93a9b9eea7e8@nvidia.com>
 <YnwupNzDNv7IbjRQ@google.com>
 <54b5d177-f2f4-cef2-3a68-cd3b0b276f86@nvidia.com>
 <Ynw6mauQuNhrOAHy@google.com>
 <f7bcda22-8ffe-67be-36bc-fcde58d8884a@nvidia.com>
 <YnxCCPZUfgQNXSg6@google.com>
 <8f083802-7ab0-15ec-b37d-bc9471eea0b1@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f083802-7ab0-15ec-b37d-bc9471eea0b1@nvidia.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 04:13:10PM -0700, John Hubbard wrote:
> On 5/11/22 16:08, Minchan Kim wrote:
> > > OK, so the code checks the wrong item each time. But the code really
> > > only needs to know "is either _CMA or _ISOLATE set?". And so you
> > 
> > Yes.
> > 
> > > can just sidestep the entire question by writing it like this:
> > > 
> > > int mt = get_pageblock_migratetype(page);
> > > 
> > > if (mt & (MIGRATE_ISOLATE | MIGRATE_CMA))
> > > 	return false;
> > 
> > I am confused. Isn't it same question?
> > 
> >                                                      set_pageblock_migratetype(MIGRATE_ISOLATE)
> > if (get_pageblock_migrate(page) & MIGRATE_CMA)
> > 
> >                                                      set_pageblock_migratetype(MIGRATE_CMA)
> > 
> > if (get_pageblock_migrate(page) & MIGRATE_ISOLATE)
> 
> Well no, because the "&" operation is a single operation on the CPU, and
> isn't going to get split up like that.

Chiming in a bit late...

The usual way that this sort of thing causes trouble is if there is a
single store instruction that changes the value from MIGRATE_ISOLATE
to MIGRATE_CMA, and if the compiler decides to fetch twice, AND twice,
and then combine the results.  This could give a zero outcome where the
underlying variable never had the value zero.

Is this sort of thing low probability?

Definitely.

Isn't this sort of thing prohibited?

Definitely not.

So what you have will likely work for at least a while longer, but it
is not guaranteed and it forces you to think a lot harder about what
the current implementations of the compiler can and cannot do to you.

The following LWN article goes through some of the possible optimizations
(vandalisms?) in this area: https://lwn.net/Articles/793253/

In the end, it is your code, so you get to decide how much you would
like to keep track of what compilers get up to over time.  ;-)

							Thanx, Paul
