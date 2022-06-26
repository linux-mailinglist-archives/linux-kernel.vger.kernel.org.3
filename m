Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65F6B55B036
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 10:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233983AbiFZIVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 04:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232734AbiFZIVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 04:21:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B417E12AB3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 01:21:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4AF63B80D13
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 08:21:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CB3BC341C7;
        Sun, 26 Jun 2022 08:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656231659;
        bh=j4UfyQrlOyGm/1PgSuQ/6EcYNsoqlK+aVO223Z4irGE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jYKkmQF/icVatvfbN8EFX8RpGRiEINdNegABCSyzAUB/0UH5j9s000U5c8d+cJHvC
         2Q7m3AZi3Ckh+LmZPRwkXSeOF7OZBvMY6UJZ9HvTXmFubhnVXOHYhbwYK5NibZHW9d
         RDIFUjOy0OyfJW1LqGwWHoP327ey6ubJV58xOBYw=
Date:   Sun, 26 Jun 2022 10:20:54 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     SebinSebastian <mailmesebin00@gmail.com>
Cc:     skhan@linuxfoundation.org,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Martin Kaiser <martin@kaiser.cx>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: Remove null checking before freeing
 functions
Message-ID: <YrgW5vB0Nxs/hqwC@kroah.com>
References: <20220626074417.661312-1-mailmesebin00@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220626074417.661312-1-mailmesebin00@gmail.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 26, 2022 at 01:14:11PM +0530, SebinSebastian wrote:
> Fix the following coccicheck warning:
> drivers/staging/r8188eu/os_dep/usb_intf.c:376:2-7: WARNING: NULL check before some freeing functions is not needed.
> 
> Signed-off-by: Sebin Sebastian <mailmesebin00@gmail.com>
> ---
>  drivers/staging/r8188eu/os_dep/usb_intf.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
> index 68869c5daeff..f5f1119b5444 100644
> --- a/drivers/staging/r8188eu/os_dep/usb_intf.c
> +++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
> @@ -372,8 +372,8 @@ static struct adapter *rtw_usb_if1_init(struct dvobj_priv *dvobj,
>  free_adapter:
>  	if (pnetdev)
>  		rtw_free_netdev(pnetdev);
> -	else if (padapter)
> -		vfree(padapter);
> +	
> +	vfree(padapter);

You introduced another coding style issue, and you changed the logic to
be different here.  Are you sure you want this change to be accepted?

thanks,

greg k-h
