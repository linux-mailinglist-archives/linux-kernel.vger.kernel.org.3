Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1897A4ECEA4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 23:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346960AbiC3VNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 17:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238534AbiC3VNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 17:13:05 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 310923A181
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 14:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648674680; x=1680210680;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=keon6mJSiu6oJTFE85youukWofwphPuyQTu9o5aZfkI=;
  b=IHlTFB+2s8niBP3np51PR7rAGkkpRpK42uzFh4VfYV63RhixM+Cmb606
   Y9krwY35KyW1CZfZ+pPqMcLezy6+VtEmnMZllP44u8soDl+Y9wTdwWiOp
   WaaJv2BtalAdkqspSk4Aw+CLe6dahazsGiQbiIAyIyR3VHmPyC8z+zdbm
   Miqw1TVWxdtYE5bCEI6ui4WvSNRxX99yZ2DYhOpDGPFCAQe2kFYh1c4uo
   WU6nyt419UiXkTdKk5hAy+qls70CJbkdvxearTpybqhlN8k5xSuXZaDP+
   OpEXgtXf6N91NAq2FAHCn5a2FqmF95HxBMVO6zFUOcFL7MsEXsPQtwUoN
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="240241104"
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="240241104"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 14:11:19 -0700
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="639869076"
Received: from npeper-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.16.15])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 14:11:19 -0700
Date:   Wed, 30 Mar 2022 14:11:19 -0700
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
Subject: Re: [PATCH v4] staging: rts5208: Convert kmap() to kmap_local_page()
Message-ID: <YkTHG+HSlU9u1FoV@iweiny-desk3>
References: <20220330143331.8306-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220330143331.8306-1-fmdefrancesco@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 04:33:31PM +0200, Fabio M. De Francesco wrote:
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
> Make a minor change to a comment related to scatter-gather.
> 
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

Thanks!

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
> 
> v1 -> v2: Rework the commit message and use the appropriate helpers
> instead of open coding the use of kmap_local_page()/kunmap_local_page().
> (Thanks to Ira Weiny <ira.weiny@intel.com>).
> 
> v2 -> v3: Use memcpy_{to,from}_page() arguments correctly.
> (Thanks to Dan Carpenter <dan.carpenter@oracle.com>).
> 
> v3 -> v4: According to a suggestion by Ira Weiny, change the test
> of a comment related to the use of scatter-gather.
> 
>  drivers/staging/rts5208/rtsx_transport.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/staging/rts5208/rtsx_transport.c b/drivers/staging/rts5208/rtsx_transport.c
> index 805dc18fac0a..d5ad49de4c56 100644
> --- a/drivers/staging/rts5208/rtsx_transport.c
> +++ b/drivers/staging/rts5208/rtsx_transport.c
> @@ -55,9 +55,9 @@ unsigned int rtsx_stor_access_xfer_buf(unsigned char *buffer,
>  		*offset += cnt;
>  
>  	/*
> -	 * Using scatter-gather.  We have to go through the list one entry
> -	 * at a time.  Each s-g entry contains some number of pages, and
> -	 * each page has to be kmap()'ed separately.
> +	 * Using scatter-gather. We have to go through the list one entry
> +	 * at a time. Each s-g entry contains some number of pages which
> +	 * have to be copied one at a time.
>  	 */
>  	} else {
>  		struct scatterlist *sg =
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
>  
>  				/* Start at the beginning of the next page */
>  				poff = 0;
> -- 
> 2.34.1
> 
