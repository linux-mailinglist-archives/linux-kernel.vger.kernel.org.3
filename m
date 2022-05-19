Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62BBF52DE68
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 22:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240856AbiESU3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 16:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiESU3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 16:29:44 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0631138BC4
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 13:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652992183; x=1684528183;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8pPufjjs2s4Gh/7ZkLu3dny81z2tHmiW7CEYnDe9MaA=;
  b=fhqZOyZdcRk0/b4VdywkVGqnJm9g0Fr+ZIzP9iR8tPeBEyvgJ4Yl6/Qg
   +wV+mS5fTjQ+j0B7ykm1387X8+4WkK60c3g0IJVzHhMpBmgjiyopPjVXb
   8SyAzhJCBJA5eSqnwxPUpIeocLhQ08tUKS5gNGqbpalLrYifp6gm+sbHo
   /ib3UYKRpxyU2YwdzZv+FtJR7pOoHrpHO3B0y3TgsWRl+qZQZZYbbLso4
   6NS2O4PfhC61xFAt85m0bJdaBlKBlhnpJDQF2FNhpQepRMJtQXNlRrpob
   KJH2LFlwWm5rqTMFUTFEoLurgGBBf67pRa0bNkGn8dyc852RlZN9pICPY
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="269956545"
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="269956545"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 13:29:43 -0700
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="570410118"
Received: from ofeliacx-mobl.amr.corp.intel.com (HELO localhost) ([10.212.85.70])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 13:29:42 -0700
Date:   Thu, 19 May 2022 13:29:41 -0700
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
Message-ID: <YoaotWPR0H5Mykff@iweiny-desk3>
References: <20220419170649.1022246-1-ira.weiny@intel.com>
 <20220419170649.1022246-34-ira.weiny@intel.com>
 <Ymq3yrQ3rmgnbX1o@infradead.org>
 <Ynxh/5jewIuGwb5d@iweiny-desk3>
 <YoQl3yLa4iDCjicO@iweiny-desk3>
 <YoShWMGVj9ZJbWqT@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoShWMGVj9ZJbWqT@infradead.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 12:33:44AM -0700, Christoph Hellwig wrote:
> On Tue, May 17, 2022 at 03:46:55PM -0700, Ira Weiny wrote:
> > Ok there is a trade off here which I'm not sure is a good idea.
> > 
> > In order to make kmap faster I carefully placed the devmap_protected() call
> > completely inline.[1]  This specifically checks the PGMAP_PROTECTION flag in
> > dev_pagemap.[1]
> > 
> > I see only 2 ways of not including memremap.h in highmem-internal.h.
> > 
> > 1) Make this check a function call and place it in memremap.c
> > 2) Move struct dev_pagemap (and it's dependencies) to another header.
> > 
> > Number 2 negates any positive effect of splitting the header file.
> > 
> > Number 1 is going to force some overhead on all ZONE_DEVICE pages if PMEM is in
> > the system.
> > 
> > Do you think the extra run time overhead is a reasonable trade off to
> > eliminating the header?
> 
> Well, given how big these devmap helpes are it seems like they should be
> out of line anyway due to the code size impact.  It would be great to
> compare the code size for the cases of:

Fair enough.  I did a few experiments with all yes config modified only to
remove LOCKDEP because those numbers were a bit skewed IMO.

> 
>  1) baseline kernel

Text		Data		bss
293450036	337712849	19907196

>  2) devmap protection inline

This is V10

Text		Data		bss
293461422	337759561	19882620

From Baseline:
 + 11386	+ 46712
   0.0038%	0.014%

2.5) devmap partly inline (This cleans up the headers by adding a new header
  for devmap protection and not using memremap.h in highmem-internal.h)

Text		Data		bss
293460722	337759593	19882620

From Baseline:
 + 10686	+ 46744
  0.0036%	0.014%

>  3) devmap protection out of line
 
Text		Data		bss
293458303	337734401	19890812

From Baseline:
 + 8267		+ 21552
  0.0028%	0.0064%

From these numbers it seems reasonable to have some of devmap_protected() out
of line to clean up the header dependencies.

Thanks,
Ira
