Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C53D157A34D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 17:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237620AbiGSPhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 11:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237364AbiGSPhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 11:37:20 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34C956BA9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 08:37:19 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 829CC34CC4;
        Tue, 19 Jul 2022 15:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1658245038; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AHDsbNoX4BgfFza6+kahupshGKvdKhml/XU63hfZ/84=;
        b=eqQZHhc2lCrDj0hrb55nBkBm0E15yypGhM4uWaFjAQO9cjLrfMTymRp4WYzLyHuOm7TDPY
        eQgUACNnQWLoWo5mEHl9d1W30ImeplJy1MDdnlKmXye7d0mpImPaiTt83eNIL2TYKqgLBz
        fltS6yrMOKoEmdhMlrvlrs89wMd3a38=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2C4502C141;
        Tue, 19 Jul 2022 15:37:15 +0000 (UTC)
Date:   Tue, 19 Jul 2022 17:37:14 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Charan Teja Kalla <quic_charante@quicinc.com>,
        akpm@linux-foundation.org, pasha.tatashin@soleen.com,
        sjpark@amazon.de, sieberf@amazon.com, shakeelb@google.com,
        dhowells@redhat.com, willy@infradead.org, vbabka@suse.cz,
        minchan@kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH] mm: fix use-after free of page_ext after race with
 memory-offline
Message-ID: <YtbPqrNtlr72+qx9@dhcp22.suse.cz>
References: <1657810063-28938-1-git-send-email-quic_charante@quicinc.com>
 <YtVJBQ/ZOt22o8+B@dhcp22.suse.cz>
 <fca23df7-37b0-f32d-ece3-58317dfad210@quicinc.com>
 <YtV0PSMAGG46Pq0K@dhcp22.suse.cz>
 <6fa6b7aa-731e-891c-3efb-a03d6a700efa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6fa6b7aa-731e-891c-3efb-a03d6a700efa@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 19-07-22 17:19:34, David Hildenbrand wrote:
> On 18.07.22 16:54, Michal Hocko wrote:
> > On Mon 18-07-22 19:28:13, Charan Teja Kalla wrote:
[...]
> >>> 3) Change the design where the page_ext is valid as long as the struct
> >>> page is alive.
> >>
> >> :/ Doesn't spark joy."
> > 
> > I would be wondering why. It should only take to move the callback to
> > happen at hotremove. So it shouldn't be very involved of a change. I can
> > imagine somebody would be relying on releasing resources when offlining
> > memory but is that really the case?
> 
> Various reasons:
> 
> 1) There was a discussion in the past to eventually also use rcu
> protection for handling pdn_to_online_page(). So doing it cleanly here
> is certainly an improvement.

Call me skeptical on that.

> 2) I really dislike having to scatter section online checks all over the
> place in page ext code. Once there is a difference between active vs.
> stale page ext data things get a bit messy and error prone. This is
> already ugly enough in our generic memmap handling code IMHO.

They should represent a free page in any case so even they are stall
they shouldn't be really dangerous, right? 

> 3) Having on-demand allocations, such as KASAN or page ext from the
> memory online notifier is at least currently cleaner, because we don't
> have to handle each and every subsystem that hooks into that during the
> core memory hotadd/remove phase, which primarily only setups the
> vmemmap, direct map and memory block devices.

Cannot this hook into __add_pages which is the real implementation of
the arch independent way to allocate vmemmap. Or at the sparsemem level
because we do not (and very likely won't) support memory hotplug on
any other memory model.

> Personally, I think what we have in this patch is quite nice and clean.
> But I won't object if it can be similarly done in a clean way from
> hot(un)plug code.

Well, if the scheme can be done without synchronize_rcu for each section
which can backfire and if the scheme doesn't add too much complexity to
achieve that then sure I won't object. I just do not get why page_ext
should have a different allocation lifetime expectancy than a real page.
Quite confusing if you ask me.
-- 
Michal Hocko
SUSE Labs
