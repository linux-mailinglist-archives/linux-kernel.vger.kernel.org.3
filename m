Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0348D51FB76
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 13:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233181AbiEILrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 07:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232654AbiEILqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 07:46:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E4D14FCB7;
        Mon,  9 May 2022 04:42:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 327ED611CA;
        Mon,  9 May 2022 11:42:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACE7CC385AB;
        Mon,  9 May 2022 11:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652096573;
        bh=ZHVW1u+tmMm1OePaD1hQg53R3eo5Soz0csO+AKlva6Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NQ5sYu1MW3dElVyiqPBxMNJ4DwA1qxHZHk2yMsA++2XBpl3RA+Iwbx5dZpMaFHpMq
         LlVJRBsNzTlexkRIkx8mXgZOEka3ruacf2oJ6PT3KgJIAblP9Imh4d3Uvos3MYzggS
         gOjdO04cN3o/FyeZmMegvidclnNqKIhmkKHSxB8NzCqUxMYPDe8SdY3O/8NynAD0Qh
         joC9nF0wyGfOn8eDuB3LXwBACcrjRTwSw9l1cLhrzXLjHwydrKTexZYhITLcDvjy1r
         xv6/0W+SeAB/JHuZWyGDOtQL+NmETf1x9rIlpUSGFamCBUGBG1jo7FY336PLXOoMOo
         iFVyt8jISCwUQ==
Date:   Mon, 9 May 2022 14:42:43 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Faiyaz Mohammed <quic_faiyazm@quicinc.com>
Cc:     quic_vjitta@quicinc.com, karahmed@amazon.de, qperret@google.com,
        robh@kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        frowand.list@gmail.com, devicetree@vger.kernel.org
Subject: Re: [PATCH] mm: memblock: avoid to create memmap for memblock nomap
 regions
Message-ID: <Ynj+M9cRm6zdCMMi@kernel.org>
References: <1649704172-13181-1-git-send-email-quic_faiyazm@quicinc.com>
 <YlW2TO0O8qDHpkGW@kernel.org>
 <7b18bea8-b996-601d-f490-cb8aadfffa1b@quicinc.com>
 <YnQBKPWtPa87y4NA@kernel.org>
 <42f28e7b-c001-7d01-1eb6-fe963491898e@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42f28e7b-c001-7d01-1eb6-fe963491898e@quicinc.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 04:37:30PM +0530, Faiyaz Mohammed wrote:
> 
> On 5/5/2022 10:24 PM, Mike Rapoport wrote:
> > On Thu, May 05, 2022 at 08:46:15PM +0530, Faiyaz Mohammed wrote:
> >> On 4/12/2022 10:56 PM, Mike Rapoport wrote:
> >>> On Tue, Apr 12, 2022 at 12:39:32AM +0530, Faiyaz Mohammed wrote:
> >>>> This 'commit 86588296acbf ("fdt: Properly handle "no-map" field in the
> >>>> memory region")' is keeping the no-map regions in memblock.memory with
> >>>> MEMBLOCK_NOMAP flag set to use no-map memory for EFI using memblock api's,
> >>>> but during the initialization sparse_init mark all memblock.memory as
> >>>> present using for_each_mem_pfn_range, which is creating the memmap for
> >>>> no-map memblock regions. To avoid it skiping the memblock.memory regions
> >>>> set with MEMBLOCK_NOMAP set and with this change we will be able to save
> >>>> ~11MB memory for ~612MB carve out.
> >>> The MEMBLOCK_NOMAP is very fragile and caused a lot of issues already. I
> >>> really don't like the idea if adding more implicit assumptions about how
> >>> NOMAP memory may or may not be used in a generic iterator function.
> >> Sorry for delayed response.
> >> Yes, it is possible that implicit assumption can create
> >> misunderstanding. How about adding command line option and control the
> >> no-map region in fdt.c driver, to decide whether to keep "no-map" region
> >> with NOMAP flag or remove?. Something like below
> > I really don't like memblock_remove() for such cases.
> > Pretending there is a hole when there is an actual DRAM makes things really
> > hairy when it comes to memory map and page allocator initialization.
> > You wouldn't want to trade system stability and random memory corruptions
> > for 11M of "saved" memory.
>
> Creating memory map for holes memory is adding 11MB overhead which is
> huge on low memory target and same time 11MB memory saving is good enough
> on low memory target.
> 
> Or we can have separate list of NOMAP like reserved?.
> 
> Any other suggestion to address this issue?.

Make your firmware to report the memory that Linux cannot use as a hole,
i.e. _not_ report it as memory.
 
> Thanks and regards,
> Mohammed Faiyaz

-- 
Sincerely yours,
Mike.
