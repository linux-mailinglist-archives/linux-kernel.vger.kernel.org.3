Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0B75003DC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 03:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239546AbiDNB4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 21:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239305AbiDNB4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 21:56:34 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF36222AD;
        Wed, 13 Apr 2022 18:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649901252; x=1681437252;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ue8ojU1OGz7ohSofSTg5I/S9UOIB+twveGfs8YIbCw0=;
  b=Hs8qNEZbYNR/VSC0EMUQPD5Qo90oBIT/qAuXfiQSYfoU6EFoVj9LkEdr
   AiPvwhGrEbIJDDESZZV1UvKXGCC5zRKtPOt6frbjxGmkjqu1gfx3wbb2D
   AC/vwFoYpOZkW+G6D+L3NUtG6yDU9+Xl7favyS6M7jAJwFT8eNDO5fhyQ
   NX6kPHIdjrBEZtqm1Z5DWqObyBgPHlTvYXGL4nnnVcXnWp4nNUZo6NAKy
   25iIqnwbcikMaBMq3DKHiqlutah9zQp+zuiI3q4b9EFI9GGHpESu/uLPy
   w717BLXxDSm5674ldh3WuBNq/GV87b2jppNEk3Jv3f+FZZzrCX4tLQz3a
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="243408537"
X-IronPort-AV: E=Sophos;i="5.90,258,1643702400"; 
   d="scan'208";a="243408537"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 18:54:11 -0700
X-IronPort-AV: E=Sophos;i="5.90,258,1643702400"; 
   d="scan'208";a="725156508"
Received: from sdoyen-mobl1.amr.corp.intel.com (HELO localhost) ([10.213.179.195])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 18:54:11 -0700
Date:   Wed, 13 Apr 2022 18:54:10 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Alison Schofield <alison.schofield@intel.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        Martiros Shakhzadyan <vrzh@vrzh.net>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Subject: Re: [PATCH] staging: media: atomisp: Use kmap_local_page() in
 hmm_store()
Message-ID: <Yld+wpMe1C51bKU3@iweiny-desk3>
References: <20220413225531.9425-1-fmdefrancesco@gmail.com>
 <20220414004454.GA1243697@alison-desk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414004454.GA1243697@alison-desk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 05:44:54PM -0700, Alison Schofield wrote:
> On Thu, Apr 14, 2022 at 12:55:31AM +0200, Fabio M. De Francesco wrote:
> > The use of kmap() is being deprecated in favor of kmap_local_page()
> > where it is feasible. The same is true for kmap_atomic().
> > 
> > In file pci/hmm/hmm.c, function hmm_store() test if we are in atomic
> > context and, if so, it calls kmap_atomic(), if not, it calls kmap().
> > 
> > First of all, in_atomic() shouldn't be used in drivers. This macro
> > cannot always detect atomic context; in particular, it cannot know
> > about held spinlocks in non-preemptible kernels.
> > 
> > Notwithstanding what it is said above, this code doesn't need to care
> > whether or not it is executing in atomic context. It can simply use
> > kmap_local_page() / kunmap_local() that can instead do the mapping /
> > unmapping regardless of the context.
> > 
> > With kmap_local_page(), the mapping is per thread, CPU local and not
> > globally visible. Therefore, hmm_store()() is a function where the use
> > of kmap_local_page() in place of both kmap() and kmap_atomic() is
> > correctly suited.
> > 
> > Convert the calls of kmap() / kunmap() and kmap_atomic() /
> > kunmap_atomic() to kmap_local_page() / kunmap_local() and drop the
> > unnecessary tests which test if the code is in atomic context.
> > 
> 
> Not specifically about this patch, but more generally about all
> such conversions - is there a 'proof' that shows this just works

Just code inspection.  Most of them that I have done have been compile tested
only.  Part of the key is that des is a local variable and is not aliased by
anything outside this function.

> or do we need to test each one. If the latter, then how?

Generally there is no test if we don't have the hardware.  Some of the more
difficult conversions will probably need to have some testing done but that
will need to be discussed with the subsystem maintainers at the time.

Ira

> 
> 
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > ---
> >  drivers/staging/media/atomisp/pci/hmm/hmm.c | 14 ++------------
> >  1 file changed, 2 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/staging/media/atomisp/pci/hmm/hmm.c b/drivers/staging/media/atomisp/pci/hmm/hmm.c
> > index 46ac082cd3f1..54188197c3dc 100644
> > --- a/drivers/staging/media/atomisp/pci/hmm/hmm.c
> > +++ b/drivers/staging/media/atomisp/pci/hmm/hmm.c
> > @@ -482,10 +482,7 @@ int hmm_store(ia_css_ptr virt, const void *data, unsigned int bytes)
> >  		idx = (virt - bo->start) >> PAGE_SHIFT;
> >  		offset = (virt - bo->start) - (idx << PAGE_SHIFT);
> >  
> > -		if (in_atomic())
> > -			des = (char *)kmap_atomic(bo->page_obj[idx].page);
> > -		else
> > -			des = (char *)kmap(bo->page_obj[idx].page);
> > +		des = (char *)kmap_local_page(bo->page_obj[idx].page);
> >  
> >  		if (!des) {
> >  			dev_err(atomisp_dev,
> > @@ -512,14 +509,7 @@ int hmm_store(ia_css_ptr virt, const void *data, unsigned int bytes)
> >  
> >  		clflush_cache_range(des, len);
> >  
> > -		if (in_atomic())
> > -			/*
> > -			 * Note: kunmap_atomic requires return addr from
> > -			 * kmap_atomic, not the page. See linux/highmem.h
> > -			 */
> > -			kunmap_atomic(des - offset);
> > -		else
> > -			kunmap(bo->page_obj[idx].page);
> > +		kunmap_local(des);
> >  	}
> >  
> >  	return 0;
> > -- 
> > 2.34.1
> > 
> > 
