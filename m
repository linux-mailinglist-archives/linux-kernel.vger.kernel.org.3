Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE49500686
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 09:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240210AbiDNHGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 03:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbiDNHGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 03:06:06 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA5028997;
        Thu, 14 Apr 2022 00:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=te3lUagj3c47Lhqa09adCixkLUiFDVwxje5+ZhtzTcc=;
  b=ZASy1r346Mf9/Cf0kmRziXpUVf6qit22lb/QCPcpntA5YPeNpys/9yss
   +r3cSRWU5lrgL2Gzhdvntutg1//7VyFGSOf/3xmlMhXo95ptouQ9cF73G
   PzgxDkvWRuTg/88ntufeuK3/eu3DrboKB1TcJDD/tza/Jq8Wbx3Zf/kX8
   Y=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.90,259,1643670000"; 
   d="scan'208";a="31625224"
Received: from 203.107.68.85.rev.sfr.net (HELO hadrien) ([85.68.107.203])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 09:03:41 +0200
Date:   Thu, 14 Apr 2022 09:03:40 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Ira Weiny <ira.weiny@intel.com>
cc:     Alison Schofield <alison.schofield@intel.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
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
In-Reply-To: <Yld+wpMe1C51bKU3@iweiny-desk3>
Message-ID: <alpine.DEB.2.22.394.2204140902030.3023@hadrien>
References: <20220413225531.9425-1-fmdefrancesco@gmail.com> <20220414004454.GA1243697@alison-desk> <Yld+wpMe1C51bKU3@iweiny-desk3>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 13 Apr 2022, Ira Weiny wrote:

> On Wed, Apr 13, 2022 at 05:44:54PM -0700, Alison Schofield wrote:
> > On Thu, Apr 14, 2022 at 12:55:31AM +0200, Fabio M. De Francesco wrote:
> > > The use of kmap() is being deprecated in favor of kmap_local_page()
> > > where it is feasible. The same is true for kmap_atomic().
> > >
> > > In file pci/hmm/hmm.c, function hmm_store() test if we are in atomic
> > > context and, if so, it calls kmap_atomic(), if not, it calls kmap().
> > >
> > > First of all, in_atomic() shouldn't be used in drivers. This macro
> > > cannot always detect atomic context; in particular, it cannot know
> > > about held spinlocks in non-preemptible kernels.
> > >
> > > Notwithstanding what it is said above, this code doesn't need to care
> > > whether or not it is executing in atomic context. It can simply use
> > > kmap_local_page() / kunmap_local() that can instead do the mapping /
> > > unmapping regardless of the context.
> > >
> > > With kmap_local_page(), the mapping is per thread, CPU local and not
> > > globally visible. Therefore, hmm_store()() is a function where the use
> > > of kmap_local_page() in place of both kmap() and kmap_atomic() is
> > > correctly suited.
> > >
> > > Convert the calls of kmap() / kunmap() and kmap_atomic() /
> > > kunmap_atomic() to kmap_local_page() / kunmap_local() and drop the
> > > unnecessary tests which test if the code is in atomic context.
> > >
> >
> > Not specifically about this patch, but more generally about all
> > such conversions - is there a 'proof' that shows this just works
>
> Just code inspection.  Most of them that I have done have been compile tested
> only.  Part of the key is that des is a local variable and is not aliased by
> anything outside this function.

Typically, the concern about being in atomic context has to do with
whether GFP_KERNEL or GFP_ATOMIC should be used, ie whether allocation can
sleep.  It doesn't have to do with whether some data can be shared.  Is
that the concern here?

julia

>
> > or do we need to test each one. If the latter, then how?
>
> Generally there is no test if we don't have the hardware.  Some of the more
> difficult conversions will probably need to have some testing done but that
> will need to be discussed with the subsystem maintainers at the time.
>
> Ira
>
> >
> >
> > > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > > ---
> > >  drivers/staging/media/atomisp/pci/hmm/hmm.c | 14 ++------------
> > >  1 file changed, 2 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/drivers/staging/media/atomisp/pci/hmm/hmm.c b/drivers/staging/media/atomisp/pci/hmm/hmm.c
> > > index 46ac082cd3f1..54188197c3dc 100644
> > > --- a/drivers/staging/media/atomisp/pci/hmm/hmm.c
> > > +++ b/drivers/staging/media/atomisp/pci/hmm/hmm.c
> > > @@ -482,10 +482,7 @@ int hmm_store(ia_css_ptr virt, const void *data, unsigned int bytes)
> > >  		idx = (virt - bo->start) >> PAGE_SHIFT;
> > >  		offset = (virt - bo->start) - (idx << PAGE_SHIFT);
> > >
> > > -		if (in_atomic())
> > > -			des = (char *)kmap_atomic(bo->page_obj[idx].page);
> > > -		else
> > > -			des = (char *)kmap(bo->page_obj[idx].page);
> > > +		des = (char *)kmap_local_page(bo->page_obj[idx].page);
> > >
> > >  		if (!des) {
> > >  			dev_err(atomisp_dev,
> > > @@ -512,14 +509,7 @@ int hmm_store(ia_css_ptr virt, const void *data, unsigned int bytes)
> > >
> > >  		clflush_cache_range(des, len);
> > >
> > > -		if (in_atomic())
> > > -			/*
> > > -			 * Note: kunmap_atomic requires return addr from
> > > -			 * kmap_atomic, not the page. See linux/highmem.h
> > > -			 */
> > > -			kunmap_atomic(des - offset);
> > > -		else
> > > -			kunmap(bo->page_obj[idx].page);
> > > +		kunmap_local(des);
> > >  	}
> > >
> > >  	return 0;
> > > --
> > > 2.34.1
> > >
> > >
>
>
