Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83EC152AE44
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 00:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbiEQWq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 18:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbiEQWq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 18:46:57 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69563FD96
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 15:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652827616; x=1684363616;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UPbb30qoGysGCMXmrylZxu9LDvbk/g1BrvZvUwm92gE=;
  b=kywTdcAsYEveIIeAjSNy2luiwIos45EkgsczZ6+Z0PEk4lB3eIKZ6cYa
   gDywFYzrIrvO1/GZiqHYrEMbAxf7UuBv6ocptJu3qpzQ8yVhSI7WGbWZi
   ASMou6C2LnFhrMjXd1hfBtDterpnU/xX9QVmnPIf5c5kbmeDfgvWXbEV1
   TxLd4i0RjTYILkoBRi7R3LqfW/xI6lMpJfoKqGyGjg6lDx108aD8P8Ylr
   PZgilogDoVlv2+XFk1uQCNgJi9UlAEBpTzsBW6Nibd7ZOlQfGLgTuf3ba
   qXMcyw/zc4eXqYKzrk1wUHmYWT4e7hAP0tF4AOXV2NgTcHzVj6OouNlhD
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="271309955"
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="271309955"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 15:46:56 -0700
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="597388075"
Received: from hrong1-mobl.amr.corp.intel.com (HELO localhost) ([10.212.21.169])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 15:46:55 -0700
Date:   Tue, 17 May 2022 15:46:55 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V10 33/44] kmap: Make kmap work for devmap protected pages
Message-ID: <YoQl3yLa4iDCjicO@iweiny-desk3>
References: <20220419170649.1022246-1-ira.weiny@intel.com>
 <20220419170649.1022246-34-ira.weiny@intel.com>
 <Ymq3yrQ3rmgnbX1o@infradead.org>
 <Ynxh/5jewIuGwb5d@iweiny-desk3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ynxh/5jewIuGwb5d@iweiny-desk3>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 06:25:19PM -0700, Ira wrote:
> On Thu, Apr 28, 2022 at 08:50:34AM -0700, Christoph Hellwig wrote:
> > On Tue, Apr 19, 2022 at 10:06:38AM -0700, ira.weiny@intel.com wrote:
> > > index a77be5630209..32ed07c2994b 100644
> > > --- a/include/linux/highmem-internal.h
> > > +++ b/include/linux/highmem-internal.h
> > > @@ -151,6 +151,8 @@ static inline void totalhigh_pages_add(long count)
> > >  
> > >  #else /* CONFIG_HIGHMEM */
> > >  
> > > +#include <linux/memremap.h>
> > 
> > Uuuh, I'd really prefer to avoid having to pull in memremap.h into
> > basically the whole kernel build.
> > 
> 
> Fair enough.  What should I call a header to store the new pgmap_set_*() calls?
> 
> devmap_prot.h
> 
> ?
> 
> Or I could just add the calls into highmem-internal.h.  That might be more
> appropriate given the new direction of that interface.
> 
> I think I'm leaning toward that vs adding another header.

Ok there is a trade off here which I'm not sure is a good idea.

In order to make kmap faster I carefully placed the devmap_protected() call
completely inline.[1]  This specifically checks the PGMAP_PROTECTION flag in
dev_pagemap.[1]

I see only 2 ways of not including memremap.h in highmem-internal.h.

1) Make this check a function call and place it in memremap.c
2) Move struct dev_pagemap (and it's dependencies) to another header.

Number 2 negates any positive effect of splitting the header file.

Number 1 is going to force some overhead on all ZONE_DEVICE pages if PMEM is in
the system.

Do you think the extra run time overhead is a reasonable trade off to
eliminating the header?

Ira

[1] https://lore.kernel.org/lkml/20220419170649.1022246-29-ira.weiny@intel.com/
