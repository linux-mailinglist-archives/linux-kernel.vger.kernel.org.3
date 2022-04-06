Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A50B4F53BF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 06:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446873AbiDFDfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 23:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2359565AbiDFDPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 23:15:54 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 71731DD960
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 17:01:58 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-43-123.pa.nsw.optusnet.com.au [49.180.43.123])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 555F010E56E5;
        Wed,  6 Apr 2022 10:01:32 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nbt74-00EFQJ-N4; Wed, 06 Apr 2022 10:01:30 +1000
Date:   Wed, 6 Apr 2022 10:01:30 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Yang Shi <shy828301@gmail.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hillf Danton <hdanton@sina.com>, MM <linux-mm@kvack.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Yu Zhao <yuzhao@google.com>,
        David Hildenbrand <david@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] mm/vmscan: add periodic slab shrinker
Message-ID: <20220406000130.GZ1609613@dread.disaster.area>
References: <20220402072103.5140-1-hdanton@sina.com>
 <20220403005618.5263-1-hdanton@sina.com>
 <20220404010948.GV1609613@dread.disaster.area>
 <YktCKVbChtC+YjOk@carbon.dhcp.thefacebook.com>
 <20220405051710.GW1609613@dread.disaster.area>
 <Ykxv1j9dxlz1BS5N@carbon.dhcp.thefacebook.com>
 <CAHbLzko=bjLhhJXjcs0Uh-g3x9vV1gQZjEU2JqxVehqSb1UGkQ@mail.gmail.com>
 <Ykyy8RfJgWDOGylv@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ykyy8RfJgWDOGylv@casper.infradead.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=deDjYVbe c=1 sm=1 tr=0 ts=624cd85d
        a=MV6E7+DvwtTitA3W+3A2Lw==:117 a=MV6E7+DvwtTitA3W+3A2Lw==:17
        a=kj9zAlcOel0A:10 a=z0gMJWrwH1QA:10 a=7-415B0cAAAA:8
        a=GuXcQiCdMdAWui93_OgA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 10:21:53PM +0100, Matthew Wilcox wrote:
> On Tue, Apr 05, 2022 at 01:58:59PM -0700, Yang Shi wrote:
> > Yeah, I agree it actually doesn't make too much sense to return the
> > number of reclaimed objects. Other part of vmscan returns the number
> > of base pages, the sizes of slab objects are varied, it may be much
> > smaller than a page, for example, dentry may be 192 bytes.
> 
> From the point of view of vmscan, it only cares about the number of pages
> freed because it's trying to free pages.  But from the point of view of
> trying to keep the number of non-useful objects in check, the number of
> objects freed is more important, and it doesn't matter whether we ended
> up freeing any pages because we made memory available for this slab cache.

Yes and no. If the memory pressure is being placed on this cache,
then freeing any number of objects is a win-win situation - reclaim
makes progress and new allocations don't need to wait for reclaim.

However, if there is no pressure on this slab cache, then freeing
objects but no actual memory pages is largely wasted reclaim effort.
Freeing those objects does nothing to alleviate the memory shortage,
and the memory freed is not going to be consumed any time soon so
all we've done is fragment the slab cache and require the subsystem
to spend more resources re-populating it. That's a lose-lose.

We want to select the shrinkers that will result in the former
occurring, not the latter.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
