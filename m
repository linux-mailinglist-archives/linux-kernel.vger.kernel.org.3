Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1F04EFC2F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 23:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352789AbiDAVf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 17:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235549AbiDAVf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 17:35:56 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE942632A
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 14:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648848845; x=1680384845;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gQWF+3nXXQTVuvvNU3qL73QaPoVzfmUyNSXaNlhBWWg=;
  b=J/Xl9068GygZmUU/Mv8TLpSKOVgGPTkY9VJ4mrAU0gkrCl9fZAnoJIJ8
   FhCy486YYGqtYF9klb+fp/rDnF7vLGxXwA3/4S1vtjUTWTL1rs/dWyZz9
   Lh66k9yhA6jbNWelOE4YP4R/P4b/lg3fCx7u2kUb0X6h9tMKeQLLNN6WO
   2+kpitB/fdiDqsCMDoXVh6bPxCWYvIENca7lDDUPCATD6g/g3E1cY+CWG
   ifxHu9kQnghxie1+DPYN//lhVMf28bAoI9vGivMENIfiBbwyiX1RjjJoE
   S/YfYZsVfbuBi/uDWmI8pANU0c3GXX5i2Rqe0ElpFMObnSqV6iSyObCXo
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10304"; a="346673491"
X-IronPort-AV: E=Sophos;i="5.90,228,1643702400"; 
   d="scan'208";a="346673491"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 14:34:05 -0700
X-IronPort-AV: E=Sophos;i="5.90,228,1643702400"; 
   d="scan'208";a="656042806"
Received: from kmislam-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.112.89])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 14:34:05 -0700
Date:   Fri, 1 Apr 2022 14:34:04 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: Re: [PATCH] staging: rtl8723bs: simplify control flow
Message-ID: <YkdvzIyz/WGlm2uy@iweiny-desk3>
References: <20220401114635.GA567659@euclid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220401114635.GA567659@euclid>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 01, 2022 at 07:46:35AM -0400, Sevinj Aghayeva wrote:
> The function iterates an index from 0 to NUM_PMKID_CACHE and returns
> the first index for which the condition is true. If no such index is
> found, the function returns -1. Current code has a complex control
> flow that obfuscates this simple task. Replace it with a loop.
> 
> Also, given the shortened function body, replace the long variable
> name psecuritypriv with a short variable name p.
> 
> Reported by checkpatch:
> 
> WARNING: else is not generally useful after a break or return
> 
> Signed-off-by: Sevinj Aghayeva <sevinj.aghayeva@gmail.com>

Wow!  Nice find!  This is a huge clean up.  Extra kudos recognizing that it is
not just the else statement which is broken here!

The only issue for the patch is that I don't see any maintainer emailed?
However, I don't see a maintainer listed in the MAINTAINERS file so ...

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  drivers/staging/rtl8723bs/core/rtw_mlme.c | 28 ++++++-----------------
>  1 file changed, 7 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
> index d5bb3a5bd2fb..3eacf8f9d236 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
> @@ -2036,28 +2036,14 @@ int rtw_restruct_wmm_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, uint in_
>  
>  static int SecIsInPMKIDList(struct adapter *Adapter, u8 *bssid)
>  {
> -	struct security_priv *psecuritypriv = &Adapter->securitypriv;
> -	int i = 0;
> -
> -	do {
> -		if ((psecuritypriv->PMKIDList[i].bUsed) &&
> -				(!memcmp(psecuritypriv->PMKIDList[i].Bssid, bssid, ETH_ALEN))) {
> -			break;
> -		} else {
> -			i++;
> -			/* continue; */
> -		}
> -
> -	} while (i < NUM_PMKID_CACHE);
> -
> -	if (i == NUM_PMKID_CACHE) {
> -		i = -1;/*  Could not find. */
> -	} else {
> -		/*  There is one Pre-Authentication Key for the specific BSSID. */
> -	}
> -
> -	return i;
> +	struct security_priv *p = &Adapter->securitypriv;
> +	int i;
>  
> +	for (i = 0; i < NUM_PMKID_CACHE; i++)
> +		if ((p->PMKIDList[i].bUsed) &&
> +				(!memcmp(p->PMKIDList[i].Bssid, bssid, ETH_ALEN)))
> +			return i;
> +	return -1;
>  }
>  
>  /*  */
> -- 
> 2.25.1
> 
