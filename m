Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF94524193
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 02:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349711AbiELAf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 20:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349693AbiELAfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 20:35:48 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14537634B
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 17:35:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 61AC6CE27A9
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 00:35:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2014C340EE;
        Thu, 12 May 2022 00:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652315743;
        bh=uxmwQjcc5w9P8/ZBtZYbLtOFtxd71WhJTlltZhYOd+o=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Mnk3xql1gcp07bHdLvrpCMUuhXH1uzi5OBQb+Ul+Gju38PpV9Y9QfvVmg8X53hmkf
         xZK1XipMLOOxaPj2zRKkLwVa3rWxEttVmx/Z1L3f7ggdRZKtjKTHf0NvTpBNIPbTA8
         /+MuO0uL63+Xi1RTZ6x27WSsI+MAv+VE+PByM/myRwRmMI+PHF/TBqCdf5APdGgjeu
         NRrR5Evrc11ZO5ciIRFFNsALEGtWhTN30wVyUwQ/ltdKtE1XNM1foL8JoOa/GI9nsS
         CVyXwHeMxvoRDJy10+1dAaNCbrUQyYu5/nDVQQ7Df58Sl2wIN07XLne07HLmWohXmc
         B4pH4yEejGq7Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 356825C05FC; Wed, 11 May 2022 17:35:43 -0700 (PDT)
Date:   Wed, 11 May 2022 17:35:43 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Dias <joaodias@google.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v4] mm: fix is_pinnable_page against on cma page
Message-ID: <20220512003543.GA2043693@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <54b5d177-f2f4-cef2-3a68-cd3b0b276f86@nvidia.com>
 <Ynw6mauQuNhrOAHy@google.com>
 <f7bcda22-8ffe-67be-36bc-fcde58d8884a@nvidia.com>
 <YnxCCPZUfgQNXSg6@google.com>
 <8f083802-7ab0-15ec-b37d-bc9471eea0b1@nvidia.com>
 <20220511234534.GG1790663@paulmck-ThinkPad-P17-Gen-1>
 <ea64b36c-ecc1-74db-dd2e-909e7e507ef8@nvidia.com>
 <0d90390c-3624-4f93-f8bd-fb29e92237d3@nvidia.com>
 <20220512002207.GJ1790663@paulmck-ThinkPad-P17-Gen-1>
 <YnxUTxnCJ6EsmjEi@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YnxUTxnCJ6EsmjEi@google.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 05:26:55PM -0700, Minchan Kim wrote:
> On Wed, May 11, 2022 at 05:22:07PM -0700, Paul E. McKenney wrote:
> > On Wed, May 11, 2022 at 05:12:32PM -0700, John Hubbard wrote:
> > > On 5/11/22 16:57, John Hubbard wrote:
> > > > On 5/11/22 16:45, Paul E. McKenney wrote:
> > > > > > 
> > > > > > Well no, because the "&" operation is a single operation on the CPU, and
> > > > > > isn't going to get split up like that.
> > > > > 
> > > > > Chiming in a bit late...
> > > > 
> > > > Much appreciated!
> > > > 
> > > > > 
> > > > > The usual way that this sort of thing causes trouble is if there is a
> > > > > single store instruction that changes the value from MIGRATE_ISOLATE
> > > > > to MIGRATE_CMA, and if the compiler decides to fetch twice, AND twice,
> > > > 
> > > > Doing an AND twice for "x & constant" this definitely blows my mind. Is
> > > > nothing sacred? :)
> > > > 
> > > > > and then combine the results.  This could give a zero outcome where the
> > > > > underlying variable never had the value zero.
> > > > > 
> > > > > Is this sort of thing low probability?
> > > > > 
> > > > > Definitely.
> > > > > 
> > > > > Isn't this sort of thing prohibited?
> > > > > 
> > > > > Definitely not.
> > > > > 
> > > > > So what you have will likely work for at least a while longer, but it
> > > > > is not guaranteed and it forces you to think a lot harder about what
> > > > > the current implementations of the compiler can and cannot do to you.
> > > > > 
> > > > > The following LWN article goes through some of the possible optimizations
> > > > > (vandalisms?) in this area: https://lwn.net/Articles/793253/
> > > > > 
> > > > 
> > > > hmm, I don't think we hit any of those  cases, do we? Because here, the
> > > > "write" side is via a non-inline function that I just don't believe the
> > > > compiler is allowed to call twice. Or is it?
> > > > 
> > > > Minchan's earlier summary:
> > > > 
> > > > CPU 0                         CPU1
> > > > 
> > > > 
> > > >                                set_pageblock_migratetype(MIGRATE_ISOLATE)
> > > > 
> > > > if (get_pageblock_migrate(page) & MIGRATE_CMA)
> > > > 
> > > >                                set_pageblock_migratetype(MIGRATE_CMA)
> > > > 
> > > > if (get_pageblock_migrate(page) & MIGRATE_ISOLATE)
> > > > 
> > > > ...where set_pageblock_migratetype() is not inline.
> > > > 
> > > > thanks,
> > > 
> > > Let me try to say this more clearly: I don't think that the following
> > > __READ_ONCE() statement can actually help anything, given that
> > > get_pageblock_migratetype() is non-inlined:
> > > 
> > > +	int __mt = get_pageblock_migratetype(page);
> > > +	int mt = __READ_ONCE(__mt);
> > > +
> > > +	if (mt & (MIGRATE_CMA | MIGRATE_ISOLATE))
> > > +		return false;
> > > 
> > > 
> > > Am I missing anything here?
> > 
> > In the absence of future aggression from link-time optimizations (LTO),
> > you are missing nothing.
> 
> A thing I want to note is Android kernel uses LTO full mode.

I doubt that current LTO can do this sort of optimized inlining, at least,
not yet.

							Thanx, Paul
