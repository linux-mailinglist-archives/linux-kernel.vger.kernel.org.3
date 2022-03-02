Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E43A4C9AD6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 03:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238990AbiCBCBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 21:01:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234572AbiCBCBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 21:01:48 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0DDA4187
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 18:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646186466; x=1677722466;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WmHw/W/dnNXd3R0+s6MvYFXtvADdx9u5b1nH/YJhrAQ=;
  b=h9LJOD15Ro65S+7LD3+5XVVHsGUwcaRdAhUPAQ8cCX0pc/o85Dw1h4ni
   MVdTUYGkcTOsIyiG+LuJs5NoxoJUorNcpB9PUwd5pquMUNbymCbWm8QyG
   eQHnMzpoZhOVIPnDSNA3AucXC2TnUDC/Bw9eCLkhpltznPdEZmfskccWv
   l83Pmk/IsPF/Data7ovfbpvtrk1knkT2yY/0jTEAVA6ZD4zfQJOzZhvHx
   rErv0q3RrRXBG5b0lQldgXRFLc8B2hUZZceTZZwmFolTowVZbdTv4EF46
   Z9YnSziTLfehkjFXw1RHjkz2tX/jngX6h5Q9NlLMQk2eG1mtOpWFASXim
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="253212847"
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="253212847"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 18:01:05 -0800
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="609044577"
Received: from bklinvil-mobl.amr.corp.intel.com (HELO localhost) ([10.212.48.220])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 18:01:05 -0800
Date:   Tue, 1 Mar 2022 18:01:04 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "hpa@zytor.com" <hpa@zytor.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V8 40/44] memremap_pages: Add
 pgmap_protection_flag_invalid()
Message-ID: <Yh7P4Pzvv5d60Skm@iweiny-desk3>
References: <20220127175505.851391-1-ira.weiny@intel.com>
 <20220127175505.851391-41-ira.weiny@intel.com>
 <73ee87100ef10af35c99e6b407eac6362c4540da.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73ee87100ef10af35c99e6b407eac6362c4540da.camel@intel.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 05:37:17PM -0800, Edgecombe, Rick P wrote:
> On Thu, 2022-01-27 at 09:55 -0800, ira.weiny@intel.com wrote:
> > +/*
> > + * pgmap_protection_flag_invalid - Check and flag an invalid use of
> > a pgmap
> > + *                                 protected page
> > + *
> > + * There are code paths which are known to not be compatible with
> > pgmap
> > + * protections.
> 
> This could get hopefully get stale. Maybe the comment should just
> describe what the function does and leave this reasoning to the commit
> log?

Thanks for the review but based on the thread with Dan this patch is dropped.

Thanks,
Ira

> 
> > pgmap_protection_flag_invalid() is provided as a 'relief
> > + * valve' to be used in those functions which are known to be
> > incompatible.
> > + *
> > + * Thus an invalid use case can be flaged with more precise data
> > rather than
> > + * just flagging a fault.  Like the fault handler code this abandons
> 
> In the commit log you called this "the invalid access on fault" and it
> seemed a little clearer to me then "just flagging a fault".
> 
> > the use of
> > + * the PKS key and optionally allows the calling code path to
> > continue based on
> > + * the configuration of the memremap.pks_fault_mode command line
> > + * (and/or sysfs) option.
> 
> It lets the calling code continue regardless right? It just warns if
> !PKS_MODE_STRICT. Why not warn in the case of PKS_MODE_STRICT too?
> 
> Seems surprising that the stricter setting would have less checks.
> 
> > + */
> > +static inline void pgmap_protection_flag_invalid(struct page *page)
> > +{
> > +       if (!pgmap_check_pgmap_prot(page))
> > +               return;
> > +       __pgmap_protection_flag_invalid(page->pgmap);
> > +}
