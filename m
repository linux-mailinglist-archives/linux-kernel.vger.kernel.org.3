Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBCC358B04C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 21:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241299AbiHETWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 15:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbiHETWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 15:22:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7321C65641;
        Fri,  5 Aug 2022 12:22:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DAE2CB829F7;
        Fri,  5 Aug 2022 19:22:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92430C433D6;
        Fri,  5 Aug 2022 19:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659727353;
        bh=6NiXLQm8OcoUZ8csmIKR/ARQpbG7nd98ZNzdAF0IdKc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hvRVdYrVCaYzMJdZQi7TucyGzVAt9jUJykVgus5XNs0aRvS2Sq6n8kzeLrPkZN4kc
         zdWykUkoZx6Ip1nCKjA2b4MOdGOhEJQWTPodJAjkIC2NggA5fpwOmIl6qy3v3dpD1A
         A9T2HAT+cOpXP/WF41x+4N1+jCVUmsDQRUFoqWAKWHe/lvqU4Gnyx4IiXVxM9Kdwug
         USFZWyRY8CHwk8jliYVI4v/jSKe+L0K7pgIf6Dmd840A4gVBzlSg9OIY335+yakyCK
         DvyCnxnD2WLw76hyAj9Mq9DPw3hn9lnriUY673qvzbWUCjASH/L12YrXB0+93ECG2i
         z9p6fx5K0hv8A==
Date:   Fri, 5 Aug 2022 21:22:25 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Vijayanand Jitta <quic_vjitta@quicinc.com>
Cc:     Faiyaz Mohammed <quic_faiyazm@quicinc.com>, karahmed@amazon.de,
        qperret@google.com, robh@kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, frowand.list@gmail.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] mm: memblock: avoid to create memmap for memblock nomap
 regions
Message-ID: <Yu1t8TpXT1f372v/@kernel.org>
References: <1649704172-13181-1-git-send-email-quic_faiyazm@quicinc.com>
 <YlW2TO0O8qDHpkGW@kernel.org>
 <7b18bea8-b996-601d-f490-cb8aadfffa1b@quicinc.com>
 <YnQBKPWtPa87y4NA@kernel.org>
 <42f28e7b-c001-7d01-1eb6-fe963491898e@quicinc.com>
 <Ynj+M9cRm6zdCMMi@kernel.org>
 <22aca197-8d18-2c9e-b3c4-f6fdc893ceb1@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22aca197-8d18-2c9e-b3c4-f6fdc893ceb1@quicinc.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vijay,

On Wed, Aug 03, 2022 at 04:27:33PM +0530, Vijayanand Jitta wrote:
> 
> On 5/9/2022 5:12 PM, Mike Rapoport wrote:
> > On Mon, May 09, 2022 at 04:37:30PM +0530, Faiyaz Mohammed wrote:
> >>
> >> On 5/5/2022 10:24 PM, Mike Rapoport wrote:
> >>> On Thu, May 05, 2022 at 08:46:15PM +0530, Faiyaz Mohammed wrote:
> >>>> On 4/12/2022 10:56 PM, Mike Rapoport wrote:
> >>>>> On Tue, Apr 12, 2022 at 12:39:32AM +0530, Faiyaz Mohammed wrote:
> >>>>>> This 'commit 86588296acbf ("fdt: Properly handle "no-map" field in the
> >>>>>> memory region")' is keeping the no-map regions in memblock.memory with
> >>>>>> MEMBLOCK_NOMAP flag set to use no-map memory for EFI using memblock api's,
> >>>>>> but during the initialization sparse_init mark all memblock.memory as
> >>>>>> present using for_each_mem_pfn_range, which is creating the memmap for
> >>>>>> no-map memblock regions. To avoid it skiping the memblock.memory regions
> >>>>>> set with MEMBLOCK_NOMAP set and with this change we will be able to save
> >>>>>> ~11MB memory for ~612MB carve out.
> >>>>> The MEMBLOCK_NOMAP is very fragile and caused a lot of issues already. I
> >>>>> really don't like the idea if adding more implicit assumptions about how
> >>>>> NOMAP memory may or may not be used in a generic iterator function.
> >>>> Sorry for delayed response.
> >>>> Yes, it is possible that implicit assumption can create
> >>>> misunderstanding. How about adding command line option and control the
> >>>> no-map region in fdt.c driver, to decide whether to keep "no-map" region
> >>>> with NOMAP flag or remove?. Something like below
> >>> I really don't like memblock_remove() for such cases.
> >>> Pretending there is a hole when there is an actual DRAM makes things really
> >>> hairy when it comes to memory map and page allocator initialization.
> >>> You wouldn't want to trade system stability and random memory corruptions
> >>> for 11M of "saved" memory.
> >>
> >> Creating memory map for holes memory is adding 11MB overhead which is
> >> huge on low memory target and same time 11MB memory saving is good enough
> >> on low memory target.
> >>
> >> Or we can have separate list of NOMAP like reserved?.
> >>
> >> Any other suggestion to address this issue?.
> > 
> > Make your firmware to report the memory that Linux cannot use as a hole,
> > i.e. _not_ report it as memory.
> >  
> 
> Thanks, Mike for the comments.
> 
> Few concerns with this approach.
> 
> 1) One concern is, even if firmware doesn't report these regions as
> memory, we would need addresses for these to be part of device tree so
> that the clients would be able to get these addresses. Otherwise there
> is no way for client to know these addresses.
> 
> 2) This would also add a dependency on firmware to be able to pass these
> regions not as memory, though we know that these regions would be used
> by the clients. Isn't it better to have such control within the kernel ?

If it is memory that is used by the kernel it should be reported as memory
and have the memory map. 
If this is a hole in the memory layout from the kernel perspective, then
kernel should not bother with this memory.

And I'm not buying "low memory target" argument if you have enough memory
to carve out ~600M for some mysterious clients.
 
> Let me know your comments on these.
> 
> Thanks,
> Vijay

-- 
Sincerely yours,
Mike.
