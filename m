Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1117D4E9B46
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 17:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238392AbiC1Pnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 11:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238328AbiC1Pne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 11:43:34 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E435F27A
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 08:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648482114; x=1680018114;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DBwya0O6Iv5ilAIp5YfXagobpebtXBW/mU7QsBrQeDY=;
  b=kvgkl8Ha9vkUOnq849820oSGbzG3czu+WKlRY6VsSuBZ4T9aXx2tNSU3
   3OcnSVrf9Hj8RwxwhSy4IogYgb4ONcc5W9cSL9GKXG0/Kee+NKPfi+DdB
   krD5uEuA0kZYLadfBzsw8Xk2j8aN4eekvhVOj7blyN2BLFSV3EzCU6ju9
   hd1J1Y/yUVB/xWLIiFTQjpkT12Xf5zqFMADgDzUEgJ1RS1S719v53MPkG
   OkPJl4RRmaU/7/odaZuAOeu9TPBvjoFyaGz62uR1/Y/nKbTh0lqgSxkUd
   jPkGsPJ7ypBh5+E4+1RqaMsLmPbeShqbVtppdavWyfMbvK3HfLrtCMear
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="283922269"
X-IronPort-AV: E=Sophos;i="5.90,217,1643702400"; 
   d="scan'208";a="283922269"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 08:41:53 -0700
X-IronPort-AV: E=Sophos;i="5.90,217,1643702400"; 
   d="scan'208";a="831474393"
Received: from allenzho-mobl.amr.corp.intel.com (HELO localhost) ([10.212.109.43])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 08:41:53 -0700
Date:   Mon, 28 Mar 2022 08:41:53 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benjamin Philip <benjamin.philip495@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Charlie Sands <sandsch@northvilleschools.net>,
        Mitali Borkar <mitaliborkar810@gmail.com>,
        Colin Ian King <colin.king@intel.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rts5208: Convert kmap() to kmap_local_page()
Message-ID: <YkHXQRmExRFioEBN@iweiny-desk3>
References: <20220328112440.17756-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220328112440.17756-1-fmdefrancesco@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2022 at 01:24:40PM +0200, Fabio M. De Francesco wrote:
> The use of kmap() is being deprecated and kmap_local_page() is faster.
> Use kmap_local_page() in place of kmap().

Thanks for the patch!  I have just a couple of comments.

kmap_local_page() is not necessarily faster than kmap() but it is more correct
in this case.  You should mention why.

Also to help with kmap_local_page() there are a number of helpers implemented
in highmem.h for things like memcpy, memmove, etc.

Check out memcpy_page() for this use case.

Thank you!
Ira

> 
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>  drivers/staging/rts5208/rtsx_transport.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rts5208/rtsx_transport.c b/drivers/staging/rts5208/rtsx_transport.c
> index 805dc18fac0a..de690d7ee5e3 100644
> --- a/drivers/staging/rts5208/rtsx_transport.c
> +++ b/drivers/staging/rts5208/rtsx_transport.c
> @@ -92,13 +92,13 @@ unsigned int rtsx_stor_access_xfer_buf(unsigned char *buffer,
>  			while (sglen > 0) {
>  				unsigned int plen = min(sglen, (unsigned int)
>  						PAGE_SIZE - poff);
> -				unsigned char *ptr = kmap(page);
> +				unsigned char *ptr = kmap_local_page(page);
>  
>  				if (dir == TO_XFER_BUF)
>  					memcpy(ptr + poff, buffer + cnt, plen);
>  				else
>  					memcpy(buffer + cnt, ptr + poff, plen);
> -				kunmap(page);
> +				kunmap_local(ptr);
>  
>  				/* Start at the beginning of the next page */
>  				poff = 0;
> -- 
> 2.34.1
> 
