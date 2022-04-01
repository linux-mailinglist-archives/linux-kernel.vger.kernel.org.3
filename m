Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD854EFBBF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 22:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352565AbiDAUne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 16:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242759AbiDAUnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 16:43:32 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5147175383
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 13:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648845701; x=1680381701;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Utj1K8zHur0DD48Ld1ZfQvhBSbjz4rhtoEl2dU5x5CY=;
  b=hwSG0NX3axmV/YeTJgMdVUB33mJi7KNdz4JncsBOW5tURSYN8ogzP4OE
   ZzgOxyT3uHvgn1KEDUPWUqMVbi+EvAwEqBCCDzDHJPdw7U3YRGUOaTYw2
   d2jZpKen97ZHsij3IV3gnAxJMh3VgnZYoY+ZMNVfxqc+vy9d45trR0tUm
   eBgt4B2F8zfGCelQ5uGvK5jDeMNGJz0a0VFWxvDfHdvMeLui6dkjDuUS2
   ewX2EpiKWCg81EV98PuwcQhkgAF6CCSzGr6d9FuMUBCTVfqdVoFZzFwAv
   wyIYhB6wQp/+NYr564EA8AoVqLXemYn8PQU+Is5CZj9UUuc8ix+9tARS7
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10304"; a="242371829"
X-IronPort-AV: E=Sophos;i="5.90,228,1643702400"; 
   d="scan'208";a="242371829"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 13:41:41 -0700
X-IronPort-AV: E=Sophos;i="5.90,228,1643702400"; 
   d="scan'208";a="586984045"
Received: from kmislam-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.112.89])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 13:41:40 -0700
Date:   Fri, 1 Apr 2022 13:41:40 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: Re: [PATCH] staging: r8188eu: Remove goto to no-op exit label
Message-ID: <YkdjhGtMwnbJcz+P@iweiny-desk3>
References: <20220401183513.26222-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220401183513.26222-1-fmdefrancesco@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 01, 2022 at 08:35:13PM +0200, Fabio M. De Francesco wrote:
> In function rtw_free_netdev() there are two "goto" jumps to a no-op exit
> label called "RETURN". Remove the label and return in line.

Thanks for the patch!  However, A good commit message lists the why and what of
a change.  I don't see a why for this commit?

FWIW (For what it's worth) I know of a couple of good reasons for this change
but you should get in the habit of putting that in the commit message.  Even
for obvious things like this.

Anyway, I think this patch can stand on it's own with an updated commit
message.  However, see below...

> 
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>  drivers/staging/r8188eu/os_dep/osdep_service.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/os_dep/osdep_service.c b/drivers/staging/r8188eu/os_dep/osdep_service.c
> index 7a6fcc96081a..d680bfba7f5d 100644
> --- a/drivers/staging/r8188eu/os_dep/osdep_service.c
> +++ b/drivers/staging/r8188eu/os_dep/osdep_service.c
> @@ -117,18 +117,15 @@ void rtw_free_netdev(struct net_device *netdev)
>  	struct rtw_netdev_priv_indicator *pnpi;
>  
>  	if (!netdev)
> -		goto RETURN;
> +		return;
>  
>  	pnpi = netdev_priv(netdev);
>  
>  	if (!pnpi->priv)
> -		goto RETURN;
> +		return;

This does not look right.  If netdev is not NULL why does this function skip
free_netdev()?

Fabio could you follow up with Larry and/or Phillip and see why the code does
this?  To me it looks like a potential bug.

Thanks!
Ira

>  
>  	vfree(pnpi->priv);
>  	free_netdev(netdev);
> -
> -RETURN:
> -	return;
>  }
>  
>  int rtw_change_ifname(struct adapter *padapter, const char *ifname)
> -- 
> 2.34.1
> 
