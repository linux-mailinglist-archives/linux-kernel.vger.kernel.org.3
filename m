Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F6E4E9C03
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 18:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239098AbiC1QO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 12:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241597AbiC1QOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 12:14:23 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0252562A21
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 09:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648483962; x=1680019962;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1K00Uy2bjZkVdoEOhcJO6s0f7diS2FE9HUV9VPPi8yw=;
  b=TZl93Yn4/jB/6jAmw+awVAIe3zA9FqmIHYS8WzRgwpdkdSk1vtKH5tuN
   tPQS7ya64oScLop8FicBnVgfeBj7lkvW2y0TOW8/7sBuZeD1eDfcmCqiO
   8ISRij/bFIZNUq5kHoJ6iCBtQkxbbsR6jyofZVhVvXH+n2YOtqg4h1Q/H
   C5CrShAi6LiDp2gZG3FaRVqxvr4DcAGjk1FtK3Y6MZzkBk2t+A+hgKdTm
   aFmaFHXMMPUoVHArym+BFmIx/oUGUfleiW6GhNVkMuRXTkyepgZCONPgB
   /RRJWrkGB6zdNmNWz7BiOOWG7d+sIfow5ozSNNdjyR8ANcooCijJaF9KT
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="241195781"
X-IronPort-AV: E=Sophos;i="5.90,217,1643702400"; 
   d="scan'208";a="241195781"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 09:11:58 -0700
X-IronPort-AV: E=Sophos;i="5.90,217,1643702400"; 
   d="scan'208";a="521075979"
Received: from allenzho-mobl.amr.corp.intel.com (HELO localhost) ([10.212.109.43])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 09:11:57 -0700
Date:   Mon, 28 Mar 2022 09:11:56 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benjamin Philip <benjamin.philip495@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Charlie Sands <sandsch@northvilleschools.net>,
        Mitali Borkar <mitaliborkar810@gmail.com>,
        Colin Ian King <colin.king@intel.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        iweiny@gmail.com, ira.weiny@intel.com
Subject: Re: [PATCH] staging: rts5208: Convert kmap() to kmap_local_page()
Message-ID: <YkHeTCGdnGPjW0/9@iweiny-desk3>
References: <20220328112440.17756-1-fmdefrancesco@gmail.com>
 <YkHXQRmExRFioEBN@iweiny-desk3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkHXQRmExRFioEBN@iweiny-desk3>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2022 at 08:41:53AM -0700, Ira Weiny wrote:
> On Mon, Mar 28, 2022 at 01:24:40PM +0200, Fabio M. De Francesco wrote:
> > The use of kmap() is being deprecated and kmap_local_page() is faster.
> > Use kmap_local_page() in place of kmap().
> 
> Thanks for the patch!  I have just a couple of comments.
> 
> kmap_local_page() is not necessarily faster than kmap() but it is more correct
> in this case.  You should mention why.
> 
> Also to help with kmap_local_page() there are a number of helpers implemented
> in highmem.h for things like memcpy, memmove, etc.
> 
> Check out memcpy_page() for this use case.
> 
> Thank you!
> Ira
> 

Also I believe this is work toward the Outreachy program.  If so be sure to
follow the guidelines on this page:

https://kernelnewbies.org/Outreachyfirstpatch

In particular, it does not look like you cc'ed the Outreachy list.

Thanks!
Ira

> > 
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > ---
> >  drivers/staging/rts5208/rtsx_transport.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/staging/rts5208/rtsx_transport.c b/drivers/staging/rts5208/rtsx_transport.c
> > index 805dc18fac0a..de690d7ee5e3 100644
> > --- a/drivers/staging/rts5208/rtsx_transport.c
> > +++ b/drivers/staging/rts5208/rtsx_transport.c
> > @@ -92,13 +92,13 @@ unsigned int rtsx_stor_access_xfer_buf(unsigned char *buffer,
> >  			while (sglen > 0) {
> >  				unsigned int plen = min(sglen, (unsigned int)
> >  						PAGE_SIZE - poff);
> > -				unsigned char *ptr = kmap(page);
> > +				unsigned char *ptr = kmap_local_page(page);
> >  
> >  				if (dir == TO_XFER_BUF)
> >  					memcpy(ptr + poff, buffer + cnt, plen);
> >  				else
> >  					memcpy(buffer + cnt, ptr + poff, plen);
> > -				kunmap(page);
> > +				kunmap_local(ptr);
> >  
> >  				/* Start at the beginning of the next page */
> >  				poff = 0;
> > -- 
> > 2.34.1
> > 
