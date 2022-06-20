Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A45E551390
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 11:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240217AbiFTJBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 05:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240222AbiFTJA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 05:00:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBEF612D02
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 02:00:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54D1561371
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 09:00:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 610A3C3411B;
        Mon, 20 Jun 2022 09:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655715655;
        bh=nrZstBXNR2UWcyCEz05tmVlLfVYahforx0DuyNS8GvA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dsybss4gXx8dTF3LRfLhUM61mZLH+D1MW4gDhXOsocOLfFx1kRAsFSWF5sdB0tYOH
         4dTvfhz8h1e+lR+dla0tAyRs7DcctjD1p6lZ6osSymrn8hoC21MuQLy3soYkf/FTZ0
         v0XYE6gGfNvdY1XAXXe6Ei68FM3lsMrVxm5M783k=
Date:   Mon, 20 Jun 2022 11:00:53 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kate Hsuan <hpa@redhat.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        "Fabio M . De Francesco" <fmdefrancesco@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] staging: r8188eu: an incorrect return value made the
 function always return fail
Message-ID: <YrA3RffyR9VT0DjN@kroah.com>
References: <20220620085413.948265-1-hpa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220620085413.948265-1-hpa@redhat.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2022 at 04:54:13PM +0800, Kate Hsuan wrote:
> Since _SUCCESS (1) and _FAIL (0) are used to indicate the status of the
> functions. The previous commit 8ae7bf782eacad803f752c83a183393b0a67127b

In the future, please reference commit ids as the documentation asks, as
it's a much nicer way to understand things.  Also this commit id is not
in Linus's tree or any tree that I can see, where did it come from?

> fixed and prevented dereferencing a NULL pointer through checking the
> return pointer. The NULL pointer check work properly but the return
> values (-ENOMEM on fail and 0 on success). This work fixed the return
> values to make sure the caller function will return the correct status.
> 
> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=2097526
> Signed-off-by: Kate Hsuan <hpa@redhat.com>
> ---
>  drivers/staging/r8188eu/core/rtw_xmit.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
> index f4e9f6102539..2f8720db21d9 100644
> --- a/drivers/staging/r8188eu/core/rtw_xmit.c
> +++ b/drivers/staging/r8188eu/core/rtw_xmit.c
> @@ -180,10 +180,8 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
>  	pxmitpriv->free_xmit_extbuf_cnt = num_xmit_extbuf;
>  
>  	res = rtw_alloc_hwxmits(padapter);
> -	if (res) {
> -		res = _FAIL;
> +	if (res == _FAIL)
>  		goto exit;
> -	}
>  
>  	rtw_init_hwxmits(pxmitpriv->hwxmits, pxmitpriv->hwxmit_entry);
>  
> @@ -1510,7 +1508,7 @@ int rtw_alloc_hwxmits(struct adapter *padapter)
>  
>  	pxmitpriv->hwxmits = kzalloc(sizeof(struct hw_xmit) * pxmitpriv->hwxmit_entry, GFP_KERNEL);
>  	if (!pxmitpriv->hwxmits)
> -		return -ENOMEM;
> +		return _FAIL;

No, please let's fix up the callers to properly detect normal kernel
error values and get rid of all of the crazy _FAIL and _SUCCESS values
in this driver.

>  
>  	hwxmits = pxmitpriv->hwxmits;
>  
> @@ -1528,7 +1526,7 @@ int rtw_alloc_hwxmits(struct adapter *padapter)
>  	} else {
>  	}
>  
> -	return 0;
> +	return _SUCCESS;

Same here, fix up the callers if they are checking this incorrectly.

thanks,

greg k-h
