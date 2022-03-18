Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDCC4DD658
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 09:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233895AbiCRImU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 04:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233893AbiCRImI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 04:42:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C4817869D
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 01:40:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6A5CEB82196
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 08:40:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AF8BC340EC;
        Fri, 18 Mar 2022 08:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647592846;
        bh=xJBQDlqFBXax04cp7hOQvnVKZ6NiGsFEY3WOnqxW2E8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=LMs11+rR98X2oRKX9OnwUUF04p026YBDauZ9lqxwN8foHG+6lAUQ6tDRZsgmPz7k4
         cpyU5sMzVa9l1X18tSDdebc9SlXxMuXIcXCZ2CtEIWDqsnOBCKBVVO7AZVDGfysV6N
         GMI8i2UbUwih6X5PAgfyGKkOr5DVcR+98V+5yhUylH4Jz3RrGo1QhTyYtJsqQj4whP
         ngPJ5uZ5nY1ZMYVlBEqHsilJnez+FhdZ1efBXWyAVfEvNgPur04HpIpRt3l1ZWKka8
         ALLYPIT2g+cB9xO4BQwoG67SHeT7dye5I8kv5FeRn5JL4bwaR8Q9MkUhikG79DHXsT
         8E82IY7A9ixNg==
From:   sj@kernel.org
To:     David Hildenbrand <david@redhat.com>
Cc:     xhao@linux.alibaba.com, sj@kernel.org,
        rongwei.wang@linux.alibaba.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Baolin Wang <baolin.wang@linux.alibaba.com>
Subject: Re: [RFC PATCH V1 0/3] mm/damon: Add CMA minotor support
Date:   Fri, 18 Mar 2022 08:40:41 +0000
Message-Id: <20220318084041.25949-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
In-Reply-To: <5c46548a-04b9-607e-f43a-63545131d336@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Mar 2022 09:29:20 +0100 David Hildenbrand <david@redhat.com> wrote:

> On 18.03.22 06:13, xhao@linux.alibaba.com wrote:
> > 
> > On 3/18/22 12:42 AM, David Hildenbrand wrote:
> >> On 17.03.22 08:03, Xin Hao wrote:
> >>> Hi David,
> >>>
> >>> On 3/16/22 11:09 PM, David Hildenbrand wrote:
> >>>> On 15.03.22 17:37, Xin Hao wrote:
> >>>>
> >>>> s/minotor/monitor/
> >>> Thanks,  i will fix it.
> >>>>> The purpose of these patches is to add CMA memory monitoring function.
> >>>>> In some memory tight scenarios, it will be a good choice to release more
> >>>>> memory by monitoring the CMA memory.
> >>>> I'm sorry, but it's hard to figure out what the target use case should
> >>>> be. Who will release CMA memory and how? Who will monitor that? What are
> >>>> the "some memory tight scenarios"? What's the overall design goal?
> >>> I may not be describing exactly what  i mean，My intention is to find out
> >>> how much of the reserved CMA space is actually used and which is unused,
> >>> For those that are not used, I understand that they can be released by
> >>> cma_release(). Of course, This is just a little personal thought that I
> >>> think is helpful for saving memory.
> >> Hm, not quite. We can place movable allocations on cma areas, to be
> >> migrated away once required for allocations via CMA. So just looking at
> >> the pages allocated within a CMA area doesn't really tell you what's
> >> actually going on.
> > 
> > I don't think so,  the damon not looking at the pages allocate, It is 
> > constantly monitoring who is using CMA area pages through tracking page 
> > access bit
> > 
> > in the kernel via the kdamond.x thread, So through damon, it can tell us 
> > about  the hot and cold distribution of CMA memory.
> 
> I'm not sure I follow. With random movable pages being placed on the CMA
> area, the mentioned use case of "cma_release()" to release pages doesn't
> make sense to me.
> 
> I assume I'm missing the big picture -- and that should be properly
> documented in the patch description. We don't add stuff just because it
> could be used somehow, there should be a clear motivation how it can
> actually be used.

Same opinion from my side.  The purpose and usage of this patch is unclear to
me.  Could you please clarify more, Xin?


Thanks,
SJ

> 
> -- 
> Thanks,
> 
> David / dhildenb
