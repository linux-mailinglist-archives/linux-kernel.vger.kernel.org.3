Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 632004ED383
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 07:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbiCaFyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 01:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbiCaFyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 01:54:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F099393C7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 22:52:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 04BBEB81E0A
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 05:52:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A1ABC340ED;
        Thu, 31 Mar 2022 05:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1648705946;
        bh=7WIb2O/ijIFwfYmhFi5G0UXBjXEKNalAGXR9f+8HLDE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Quq34u06rN6LVE3rAFOT0Arh8ULMBTFH80rwI7D4fV0s1rEYD+3uPGj+nY1VzPosF
         D8Zc4tr8GeIARMdFQvIBEJt/thD8uHzPqixuUcDkU44RxL6rcm9+5TilWkFKCltC4K
         LQ/uTlxfQO7yCsDu0VDVID6UUqN0OQdBD7Bd7164=
Date:   Thu, 31 Mar 2022 07:52:24 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/8] staging: r8188eu: remove HW_VAR_RXDMA_AGG_PG_TH
 from SetHwReg8188EU()
Message-ID: <YkVBmIfVJOj9abe7@kroah.com>
References: <20220329202141.7028-1-straube.linux@gmail.com>
 <20220329202141.7028-6-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220329202141.7028-6-straube.linux@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 10:21:38PM +0200, Michael Straube wrote:
> The HW_VAR_RXDMA_AGG_PG_TH case in SetHwReg8188EU() just sets a
> variable conditionally and then calls rtw_write8(). Set the variable
> in the caller and call rtw_write8() directly. Move the functionality
> into a new static function to make the code cleaner. Remove the
> HW_VAR_RXDMA_AGG_PG_TH case from SetHwReg8188EU(). This is part of the
> ongoing effort to get rid of the unwanted hal layer.
> 
> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> ---
> v2: Moved the code into a function and included patch 6/9 of v1.
> 
>  drivers/staging/r8188eu/core/rtw_mlme.c    | 34 +++++++++++++---------
>  drivers/staging/r8188eu/hal/usb_halinit.c  |  8 -----
>  drivers/staging/r8188eu/include/hal_intf.h |  1 -
>  3 files changed, 21 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
> index f1e1627641cb..086d64542082 100644
> --- a/drivers/staging/r8188eu/core/rtw_mlme.c
> +++ b/drivers/staging/r8188eu/core/rtw_mlme.c
> @@ -1787,10 +1787,29 @@ void rtw_update_registrypriv_dev_network(struct adapter *adapter)
>  
>  }
>  
> +static void rtw_set_threshold(struct adapter *adapter)
> +{
> +	u8 threshold;
> +	struct mlme_priv *mlmepriv = &adapter->mlmepriv;
> +	struct ht_priv *htpriv = &mlmepriv->htpriv;
> +
> +	/*  TH = 1 => means that invalidate usb rx aggregation */
> +	/*  TH = 0 => means that validate usb rx aggregation, use init value. */
> +	if (htpriv->ht_option) {
> +		if (adapter->registrypriv.wifi_spec == 1)
> +			threshold = 1;
> +		else
> +			threshold = USB_RXAGG_PAGE_COUNT;
> +
> +		rtw_write8(adapter, REG_RXDMA_AGG_PG_TH, threshold);
> +	} else {
> +		rtw_write8(adapter, REG_RXDMA_AGG_PG_TH, 1);
> +	}
> +}

For future cleanups, this function can be made a lot smaller :)

thanks,

greg k-h
