Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4755B29C8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 01:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiIHXAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 19:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiIHXAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 19:00:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD8548049B;
        Thu,  8 Sep 2022 16:00:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 601C0B822BB;
        Thu,  8 Sep 2022 23:00:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A8FFC433C1;
        Thu,  8 Sep 2022 23:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1662678037;
        bh=vYPZUFtvIrLJhPcquNWaDGwB5oL31gsB6D0AD6z9rJQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sy3HzR1ZkaJfKRDdCP4OLoYBeWeh4eIRqMfLL7ZBQlhaiwqz1aisqc8MUwmVw8DxR
         shM+GGV54BycgoCQzb+SizuHv28toymYLlQYIb8FzilE2pg+7agKdzitEEC0D5aV8N
         6DldiyP1gzdaUtdYgodAlyCd6GiJ4gWthhB1nPlU=
Date:   Thu, 8 Sep 2022 16:00:35 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>, <x86@kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-cxl@vger.kernel.org>,
        <peterz@infradead.org>, <bp@alien8.de>, <dave.jiang@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <a.manzanares@samsung.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] memregion: Add arch_flush_memregion() interface
Message-Id: <20220908160035.f030e3e533a996eadc04dbd5@linux-foundation.org>
In-Reply-To: <631a7206afc2_166f29413@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220829212918.4039240-1-dave@stgolabs.net>
        <20220907153016.f7cd4f42a337fedae8319f28@linux-foundation.org>
        <631940536d040_2736529437@dwillia2-xfh.jf.intel.com.notmuch>
        <20220908141319.00000f01@huawei.com>
        <631a7206afc2_166f29413@dwillia2-xfh.jf.intel.com.notmuch>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Sep 2022 15:51:50 -0700 Dan Williams <dan.j.williams@intel.com> wrote:

> Jonathan Cameron wrote:
> > On Wed, 7 Sep 2022 18:07:31 -0700
> > Dan Williams <dan.j.williams@intel.com> wrote:
> > 
> > > Andrew Morton wrote:
> > > > I really dislike the term "flush".  Sometimes it means writeback,
> > > > sometimes it means invalidate.  Perhaps at other times it means
> > > > both.
> > > > 
> > > > Can we please be very clear in comments and changelogs about exactly
> > > > what this "flush" does.   With bonus points for being more specific in the 
> > > > function naming?
> > > >   
> > > 
> > > That's a good point, "flush" has been cargo-culted along in Linux's
> > > cache management APIs to mean write-back-and-invalidate. In this case I
> > > think this API is purely about invalidate. It just so happens that x86
> > > has not historically had a global invalidate instruction readily
> > > available which leads to the overuse of wbinvd.
> > > 
> > > It would be nice to make clear that this API is purely about
> > > invalidating any data cached for a physical address impacted by address
> > > space management event (secure erase / new region provision). Write-back
> > > is an unnecessary side-effect.
> > > 
> > > So how about:
> > > 
> > > s/arch_flush_memregion/cpu_cache_invalidate_memregion/?
> > 
> > Want to indicate it 'might' write back perhaps?
> > So could be invalidate or clean and invalidate (using arm ARM terms just to add
> > to the confusion ;)
> > 
> > Feels like there will be potential race conditions where that matters as we might
> > force stale data to be written back.
> > 
> > Perhaps a comment is enough for that. Anyone have the "famous last words" feeling?
> 
> Is "invalidate" not clear that write-back is optional? Maybe not.

Yes, I'd say that "invalidate" means "dirty stuff may of may not have
been written back".  Ditto for invalidate_inode_pages2().

> Also, I realized that we tried to include the address range to allow for
> the possibility of flushing by virtual address range, but that
> overcomplicates the use. I.e. if someone issue secure erase and the
> region association is not established does that mean that mean that the
> cache invalidation is not needed? It could be the case that someone
> disables a device, does the secure erase, and then reattaches to the
> same region. The cache invalidation is needed, but at the time of the
> secure erase the HPA was unknown.
> 
> All this to say that I feel the bikeshedding will need to continue until
> morale improves.
> 
> I notice that the DMA API uses 'sync' to indicate, "make this memory
> consistent/coherent for the CPU or the device", so how about an API like
> 
>     memregion_sync_for_cpu(int res_desc)
> 
> ...where the @res_desc would be IORES_DESC_CXL for all CXL and
> IORES_DESC_PERSISTENT_MEMORY for the current nvdimm use case.

"sync" is another of my pet peeves ;) In filesystem land, at least. 
Does it mean "start writeback and return" or does it mean "start
writeback, wait for its completion then return".  

