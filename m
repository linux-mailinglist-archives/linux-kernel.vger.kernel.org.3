Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31DD7557CA1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 15:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbiFWNMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 09:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbiFWNMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 09:12:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1CC31535
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 06:12:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE9BC61CFA
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 13:12:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A79B6C341C4;
        Thu, 23 Jun 2022 13:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655989924;
        bh=sWU7+dd307nQGUnzb6uKj2OthuxZU5W3/b2rzE5N0ug=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BChn9z2TUPL4JLdXi+NDA7/fD21l8o5jU7WMuDLBUisqEBdb7rRifLGmEVQWsOC/9
         cG6M0E/JD0nyATUorGurHsVjy57BrxB547Echya1QmmmP8kCVMR/vgcBbftAuQSrse
         Dh7C7jBGdefOjq4V15ZABrrf28HeLdfCg9RzwXd2bZBIhF/6grhGgm+poZd6W6filO
         rziSqd5V3OUNbBqi+27+hEudbaLemWIqD/pcdqFe4vBzMtxqlsWx41Oh05BqCb92pR
         iXtXunPyi5oZx64+GWCAbbDRVEtCm7fngA5VUZeYC3IHiMhs2dP6nMb3NJeKAQquzt
         9pVvHVe3vSUfw==
Date:   Thu, 23 Jun 2022 08:11:58 -0500
From:   Mike Rapoport <rppt@kernel.org>
To:     Rebecca Mckeever <remckee0@gmail.com>
Cc:     "Huang, Shaoqin" <shaoqin.huang@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v3 2/4] memblock tests: add verbose output to memblock
 tests
Message-ID: <YrRmnu67AMvvqOKs@kernel.org>
References: <cover.1655889641.git.remckee0@gmail.com>
 <004e021cc3cb7be8749361b3b1cb324459b9cb9f.1655889641.git.remckee0@gmail.com>
 <b7e6565b-d9f7-a5cc-8e66-087ea7b270d1@intel.com>
 <YrO3uyXee9DcMTzz@bertie>
 <d53b547a-1450-82de-a3c5-4bb09f2a728d@intel.com>
 <YrPmhzZDd9YFyEUa@kernel.org>
 <YrPyfqENPHfUCaq4@bertie>
 <YrP0YVMKo19Wrv44@kernel.org>
 <YrQc6kl2q4VyuW6E@bertie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrQc6kl2q4VyuW6E@bertie>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 02:57:30AM -0500, Rebecca Mckeever wrote:
> On Thu, Jun 23, 2022 at 12:04:33AM -0500, Mike Rapoport wrote:
> > On Wed, Jun 22, 2022 at 11:56:30PM -0500, Rebecca Mckeever wrote:
> > > On Wed, Jun 22, 2022 at 11:05:27PM -0500, Mike Rapoport wrote:
> > > > On Thu, Jun 23, 2022 at 09:29:05AM +0800, Huang, Shaoqin wrote:
> > > > > 
> > > > > 
> > > > > On 6/23/2022 8:45 AM, Rebecca Mckeever wrote:
> > > > > > On Wed, Jun 22, 2022 at 06:32:04PM +0800, Huang, Shaoqin wrote:
> > > > > > > Just test it and everything works fine. And I think there are some thing can
> > > > > > > improve:
> > > > > > > 
> > > > > > >      The prefix_push() and prefix_pop() are used in so many functions and
> > > > > > > almost of them just put the prefix_push(__func__) begin in the head and the
> > > > > > > prefix_pop() in the end.
> > > > > > >      May be you can define some macro that when you output something and
> > > > > > > automatically push the __func__ as prefix. And when leave the function,
> > > > > > > automatically pop it. And only in some special place, you call it manually.
> > > > > > > 
> > > > > > Thank you for your review. I'm not sure how you would automatically push
> > > > > > __func__ since you have to be inside the function to access that
> > > > > > variable. Let me know if you have any suggestions. I am thinking about
> > > > > > adding another function in common.c that just calls test_pass() followed
> > > > > > by prefix_pop() since those are called together so often.
> > > > > 
> > > > > Just like:
> > > > > #define test_pass_macro()               \
> > > > >          do {                            \
> > > > >                  prefix_push(__func__);  \
> > > > >                  test_pass();            \
> > > > >                  prefix_pop();           \
> > > > >          } while (0)
> > > > 
> > > > This will not print the name of the failing test, e.g. instead of 
> > > > 
> > > > not ok 28 : memblock_alloc: alloc_bottom_up_disjoint_check: failed
> > > > 
> > > > with Rebecca's implementation it'll print
> > > > 
> > > > not ok 28 : memblock_alloc: failed
> > > > 
> > > Oh yeah, prefix_push() needs to be called before the asserts.
> > > 
> > > > How about
> > > > 
> > > > #define PREFIX_PUSH() 	prefix_push(__func__)?
> > > >  
> > > Good idea. What about 
> > > 
> > > #define TEST_PASS() do { \
> > > 	test_pass(); \
> > > 	prefix_pop(); \
> > > } while (0)
> > > 
> > > ? Or would it be better to make a function?
> > 
> > static inline function would be better.
> > 
> Would there be any advantage to defining a different version for each
> side of #ifdef VERBOSE? 

No, a single version will do. For !VERBOSE builds it will be optimized out
anyway.
 
> 
> Thanks,
> Rebecca

-- 
Sincerely yours,
Mike.
