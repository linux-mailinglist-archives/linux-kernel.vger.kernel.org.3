Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3C0A4D3668
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 18:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236543AbiCIRHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 12:07:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237029AbiCIRGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 12:06:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B541B8C93;
        Wed,  9 Mar 2022 08:56:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5E4B7B82221;
        Wed,  9 Mar 2022 16:56:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E769C340EC;
        Wed,  9 Mar 2022 16:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646845003;
        bh=kDMnZH3ho28GeAh47qD13Y8CWbmenm3wAL3cZzVX4RY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WZ/fu/uYkB4AJIYeqd2YGCJHbzXsMT7wtZryD15B5YtuYJZeMWLRRgwpit7N06+vW
         UFi07RAEJ3kC3zLDtLzN51JqEn1mKwerx6wT4FhpgKMpWB8b/6guPjwWdZ0eZh4BqA
         T1SgIlWeTDml1xiN59Jd8Q66goqaKW4tIa7iYP47RkGtbKaLDj23KE6gXjav4z0ONd
         V8+1Hhmz1XXp+lkWrgbw/NGdZeC9kY5esWordEN8f5BNH285j6nkBC3KFnrjB5f1we
         mI6dlmfz3YQXgDEIUBn4B0kxqBWN1knNHs/VhY5NpweCcWb+quwpefXveaeFIUWw4y
         k7OawS80Qrozw==
Date:   Wed, 9 Mar 2022 18:56:32 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-doc@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs/kernel-parameters: update description of mem=
Message-ID: <YijcQAs3neDA/N1w@kernel.org>
References: <20220309122446.1118738-1-rppt@kernel.org>
 <faadb494-2ed9-f894-257d-9a70398a02b6@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <faadb494-2ed9-f894-257d-9a70398a02b6@infradead.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 08:05:05AM -0800, Randy Dunlap wrote:
> Hi Mike,
> 
> On 3/9/22 04:24, Mike Rapoport wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > The existing description of mem= does not cover all the cases and
> > differences between how architectures treat it.
> > 
> > Extend the description to match the code.
> > 
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > ---
> > 
> > This is in a way a followup for the discussion of mem= usage on MIPS:
> > 
> > https://lore.kernel.org/all/1646461289-31992-1-git-send-email-yangtiezhu@loongson.cn
> > 
> >  .../admin-guide/kernel-parameters.txt         | 20 +++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> > 
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index f5a27f067db9..f3597841a031 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -2834,6 +2834,15 @@
> >  			2 when the kernel is not able to see the whole system memory;
> >  			3 memory that lies after 'mem=' boundary is excluded from
> >  			 the hypervisor, then assigned to KVM guests.
> > +			4 to limit the memory available for kdump kernel.
> > +
> > +			[ARC,MICROBLAZE] - the limit applies only to low memory,
> > +			high memory is not affected.
> > +
> > +			[ARM64] - only limits memory covered by the linear
> > +			mapping. The NOMAP regions are not affected.
> > +
> > +			[HEXAGON] - must be use to set the memory size, there is
> 
> Above line seems to be missing something?

Yes :)
 
> Otherwise looks good AFAIK.
> 
> >  
> >  			[X86] Work as limiting max address. Use together
> >  			with memmap= to avoid physical address space collisions.
> > @@ -2844,6 +2853,17 @@
> >  			in above case 3, memory may need be hot added after boot
> >  			if system memory of hypervisor is not sufficient.
> >  
> > +	mem=nn[KMG]@ss[KMG]
> > +			[ARM,MIPS] - override the memory layout reported by
> > +			firmware.
> > +			Define a memory region of size nn[KMG] starting at
> > +			ss[KMG].
> > +			Multiple different regions can be specified with
> > +			multiple mem= parameters on the command line.
> > +
> > +	mem=nn[KMG]	[HEXAGON] Set the memory size.
> > +			Must be specified, otherwise memory size will be 0.
> > +
> >  	mem=nopentium	[BUGS=X86-32] Disable usage of 4MB pages for kernel
> >  			memory.
> >  
> 
> -- 
> ~Randy

-- 
Sincerely yours,
Mike.
