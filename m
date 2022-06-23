Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A84855725C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 06:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbiFWEst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 00:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343761AbiFWEFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 00:05:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455E53EF03
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 21:05:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D984D60F92
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 04:05:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0821C3411B;
        Thu, 23 Jun 2022 04:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655957130;
        bh=2UyGTSqVR/Y2YvttRxXwD6RrqgslHhqELmKAKfDMlSs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZgX2RmY9WHipioZJhoQAQbDPSCYa+2lXYl1fAkh1Pc89RoWxPDo3rMsB3lq17mOfW
         hQ6THnUgteTa1Bpe+zkx2RhqOj5EO2E329dtLyFpyHGy574HlzALKELPd78Ka+rtHa
         Q95fIbeQwzEA/Se3sBN3B2LZVLmtwkRVlkIFdPbTl+6MUlH02XBoJfZ5/CdOfovy2Z
         MpMjWhpK+He0NIEaWlKIRSFGm+/dwTdd2FAEXbl07OLkznvhofl8K1Kru8MZXthVT9
         2/4KptYo7NFPW86Thf5PHzPbaXpaZ4II+ul/KuBPtgWMQZCjhoIvkc1GUZZVYbd3Rz
         5bhFgUuR3IrEA==
Date:   Wed, 22 Jun 2022 23:05:27 -0500
From:   Mike Rapoport <rppt@kernel.org>
To:     "Huang, Shaoqin" <shaoqin.huang@intel.com>
Cc:     Rebecca Mckeever <remckee0@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v3 2/4] memblock tests: add verbose output to memblock
 tests
Message-ID: <YrPmhzZDd9YFyEUa@kernel.org>
References: <cover.1655889641.git.remckee0@gmail.com>
 <004e021cc3cb7be8749361b3b1cb324459b9cb9f.1655889641.git.remckee0@gmail.com>
 <b7e6565b-d9f7-a5cc-8e66-087ea7b270d1@intel.com>
 <YrO3uyXee9DcMTzz@bertie>
 <d53b547a-1450-82de-a3c5-4bb09f2a728d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d53b547a-1450-82de-a3c5-4bb09f2a728d@intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 09:29:05AM +0800, Huang, Shaoqin wrote:
> 
> 
> On 6/23/2022 8:45 AM, Rebecca Mckeever wrote:
> > On Wed, Jun 22, 2022 at 06:32:04PM +0800, Huang, Shaoqin wrote:
> > > Just test it and everything works fine. And I think there are some thing can
> > > improve:
> > > 
> > >      The prefix_push() and prefix_pop() are used in so many functions and
> > > almost of them just put the prefix_push(__func__) begin in the head and the
> > > prefix_pop() in the end.
> > >      May be you can define some macro that when you output something and
> > > automatically push the __func__ as prefix. And when leave the function,
> > > automatically pop it. And only in some special place, you call it manually.
> > > 
> > Thank you for your review. I'm not sure how you would automatically push
> > __func__ since you have to be inside the function to access that
> > variable. Let me know if you have any suggestions. I am thinking about
> > adding another function in common.c that just calls test_pass() followed
> > by prefix_pop() since those are called together so often.
> 
> Just like:
> #define test_pass_macro()               \
>          do {                            \
>                  prefix_push(__func__);  \
>                  test_pass();            \
>                  prefix_pop();           \
>          } while (0)

This will not print the name of the failing test, e.g. instead of 

not ok 28 : memblock_alloc: alloc_bottom_up_disjoint_check: failed

with Rebecca's implementation it'll print

not ok 28 : memblock_alloc: failed

How about

#define PREFIX_PUSH() 	prefix_push(__func__)?
 
> This macro will automatically push the __fun__ as prefix when you call
> test_pass_macro(). And then pop it after test_pass() output.
> 
> And use this macro() to hidden most of the paired prefix_* functions.
> 
> And I think that's the simplist way. May be someone has a better solution.
> 

-- 
Sincerely yours,
Mike.
