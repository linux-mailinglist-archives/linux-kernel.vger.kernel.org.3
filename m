Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8670F4EBA3F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 07:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243014AbiC3Fgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 01:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235840AbiC3Fgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 01:36:37 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042C521D7D4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 22:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648618492; x=1680154492;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SAL7/34vJ25bamv8Fr/9MpfHVJ+j2ue84dl6hFHp+n0=;
  b=eIhwpyvNezzWzoH0fkkf56CuiJQE1+5c9BX/F2Y+adZkQ9TX7lRn1x8g
   VcjPj4dxqwHNqqDSH4+0RZye6x81d0ryJmpv4MKr5YU1KamqQng2pNEo8
   RLVWwLLYSqvoLp9TXl+G8GxIA4t6l3k8czNvjoI3hs+0tPZyR3GlH5OV1
   FgrQCwKD/uNxZqDw454GEMFVgyV8bzJU6YIrKL0+XAttx8pg2c30UdDsv
   qV6T+GapvYS3ml+cqGSZDGTAOWPBma/ckixXCzeVLM4bg2S62YER7jfdh
   VXoNj0JwTVDPD0ihbnjyNs1RQnf9tyQObtJuxzGW9KPRJQlyHLC1xJKPe
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="322632004"
X-IronPort-AV: E=Sophos;i="5.90,221,1643702400"; 
   d="scan'208";a="322632004"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 22:34:52 -0700
X-IronPort-AV: E=Sophos;i="5.90,221,1643702400"; 
   d="scan'208";a="503175602"
Received: from micastro-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.81.34])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 22:34:51 -0700
Date:   Tue, 29 Mar 2022 22:34:51 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benjamin Philip <benjamin.philip495@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Colin Ian King <colin.king@intel.com>,
        Samuel =?iso-8859-1?Q?Sj=F6berg?= <info@samuelsjoberg.se>,
        Charlie Sands <sandsch@northvilleschools.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        outreachy@lists.linux.dev
Subject: Re: [PATCHi v3] staging: rts5208: Convert kmap() to kmap_local_page()
Message-ID: <YkPr+4lRbha/LV+9@iweiny-desk3>
References: <20220329162055.28006-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220329162055.28006-1-fmdefrancesco@gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 06:20:55PM +0200, Fabio M. De Francesco wrote:
> The use of kmap() is being deprecated in favor of kmap_local_page()
> where it is feasible.
> 
> With kmap_local_page(), the mapping is per thread, CPU local and not
> globally visible. Therefore rtsx_stor_access_xfer_buf() is a function
> where the use of kmap_local_page() in place of kmap() is correctly
> suited.
> 
> Convert to kmap_local_page() but, instead of open coding it, use the
> helpers memcpy_to_page() and memcpy_from_page().
> 
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
> 
> v1 -> v2: Rework the commit message and use the appropriate helpers
> instead of open coding the use of kmap_local_page()/kunmap_local_page().
> (Thanks to Ira Weiny <ira.weiny@intel.com>).
> 
> v2 -> v3: Use memcpy_{to,from}_page() arguments correctly.
> (Thanks to Dan Carpenter <dan.carpenter@oracle.com>).
> 
>  drivers/staging/rts5208/rtsx_transport.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/rts5208/rtsx_transport.c b/drivers/staging/rts5208/rtsx_transport.c
> index 805dc18fac0a..b702c7caf944 100644
> --- a/drivers/staging/rts5208/rtsx_transport.c
> +++ b/drivers/staging/rts5208/rtsx_transport.c
> @@ -92,13 +92,11 @@ unsigned int rtsx_stor_access_xfer_buf(unsigned char *buffer,
>  			while (sglen > 0) {
>  				unsigned int plen = min(sglen, (unsigned int)
>  						PAGE_SIZE - poff);
> -				unsigned char *ptr = kmap(page);
>  
>  				if (dir == TO_XFER_BUF)
> -					memcpy(ptr + poff, buffer + cnt, plen);
> +					memcpy_to_page(page, poff, buffer + cnt, plen);
>  				else
> -					memcpy(buffer + cnt, ptr + poff, plen);
> -				kunmap(page);
> +					memcpy_from_page(buffer + cnt, page, poff, plen);

This code is great...  But I went and looked at the function and found a
comment which needs to be updated as well.  :-/

 57         /*
 58          * Using scatter-gather.  We have to go through the list one entry
 59          * at a time.  Each s-g entry contains some number of pages, and
 60          * each page has to be kmap()'ed separately.
 61          */

I would update it to say something like:

...  Each s-g entry contains some number of pages which have to be copied one
at a time.

Sorry for not catching that earlier,
Ira

>  
>  				/* Start at the beginning of the next page */
>  				poff = 0;
> -- 
> 2.34.1
> 
