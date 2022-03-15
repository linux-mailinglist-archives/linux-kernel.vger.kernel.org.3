Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB3C44DA0A0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 17:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350355AbiCOQ6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 12:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350357AbiCOQ6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 12:58:43 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27E6580D3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 09:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647363451; x=1678899451;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=m7ZKrh8loAyVEg0SDdOAuMAn1KCDmPCSOZk5E8Ai0S4=;
  b=VDVgIRrC70Qsw2P2I+pPIvkTCQW4AaiT/Qj629MUEZDKLrQErkQfK62D
   vmZ9ovp2jP6QFApNp7TtFKbgkVePJNoW7hX6FZoQdcYXFhOAKUHXGYcvj
   oJYII4k9rYABOiKmKCRLu/INlxhsfqO+DJ5C/SAk650iwRm0JfUUM7kfO
   vE56yBoMdeaMvblnBHy3USB5O4q05PiRrKcg5VWf5n3ynwLcOmb1IHS/j
   NPI9vsE5+E3e8nyN+TNXbdQfXqTbLpwQDYZdU/U4RVGMpIUMkLg0JGFKB
   nw8rwAwB6+IAwjVyidXdKnKK6jl11fcurkcmSLWo6rJFZfHD1WyzWlvZw
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="253918414"
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; 
   d="scan'208";a="253918414"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 09:57:31 -0700
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; 
   d="scan'208";a="498091678"
Received: from jpgabald-mobl.amr.corp.intel.com (HELO localhost) ([10.212.75.31])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 09:57:30 -0700
Date:   Tue, 15 Mar 2022 09:57:30 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] x86/pkeys: Standardize on u8 for pkey type
Message-ID: <YjDFesTdo8Zl8iYm@iweiny-desk3>
References: <20220311005742.1060992-1-ira.weiny@intel.com>
 <20220311005742.1060992-6-ira.weiny@intel.com>
 <42e0aa73-04c8-a4c2-2d64-80812634b627@intel.com>
 <YjC2jcn7kJKdHrf3@iweiny-desk3>
 <5b5ae505-84c7-1a46-832a-68bdfd8fd61c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b5ae505-84c7-1a46-832a-68bdfd8fd61c@intel.com>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 09:03:26AM -0700, Dave Hansen wrote:
> On 3/15/22 08:53, Ira Weiny wrote:
> > On Mon, Mar 14, 2022 at 04:49:12PM -0700, Dave Hansen wrote:
> >> On 3/10/22 16:57, ira.weiny@intel.com wrote:
> >>> From: Ira Weiny <ira.weiny@intel.com>
> >>>
> >>> The number of pkeys supported on x86 and powerpc are much smaller than a
> >>> u16 value can hold.  It is desirable to standardize on the type for
> >>> pkeys.  powerpc currently supports the most pkeys at 32.  u8 is plenty
> >>> large for that.
> >>>
> >>> Standardize on the pkey types by changing u16 to u8.
> >>
> >> How widely was this intended to "standardize" things?  Looks like it may
> >> have missed a few spots.
> > 
> > Sorry I think the commit message is misleading you.  The justification of u8 as
> > the proper type is that no arch has a need for more than 255 pkeys.
> > 
> > This specific patch was intended to only change x86.  Per that goal I don't see
> > any other places in x86 which uses u16 after this patch.
> > 
> > $ git grep u16 arch/x86 | grep key
> > arch/x86/events/intel/uncore_discovery.c:	const u16 *type_id = key;
> > arch/x86/include/asm/intel_pconfig.h:	u16 keyid;
> > arch/x86/include/asm/mmu.h:	u16 pkey_allocation_map;
> > arch/x86/include/asm/pkeys.h:	u16 all_pkeys_mask = ((1U << arch_max_pkey()) - 1);
> 
> I was also looking at the generic mm code.

Ah yea that needs to be sorted out too I think.

> 
> >> Also if we're worried about the type needing to changY or with the wrong
> >> type being used, I guess we could just to a pkey_t typedef.
> > 
> > I'm not 'worried' about it.  But I do think it makes the code cleaner and more
> > self documenting.
> 
> Yeah, consistency is good.  Do you mind taking a look at how a pkey_t
> would look, and also seeing how much core mm code should use it?

I don't mind at all.

Ira
