Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6CFB57F5FA
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 18:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232888AbiGXQSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 12:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiGXQSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 12:18:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9118DFA9
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 09:18:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9E378B80C8C
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 16:18:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07FD3C3411E;
        Sun, 24 Jul 2022 16:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658679483;
        bh=cg7AgZYQWQqXNzFU4SmDbA8nxQ3ZVK2B6/Q1SO0ceJU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VyYkEmE2uL6e0+fCRPODF1gWXCEmxGzOA95keUgu3c1whUYqII5Bjdvpyfaa5dn/q
         puyd+HXh6zCzqkgZE26jmXjQo0QRebfgUr+XyjTGB6e7RxxlUT6RhnVoLzMTwWm8C1
         91AjsrKWg2pU/DcFmp3eYdUZ6a0xKAsap5MlN4O0=
Date:   Sun, 24 Jul 2022 18:18:00 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: handle errors from
 ReadAdapterInfo8188EU
Message-ID: <Yt1wuJKzzUTpxMY3@kroah.com>
References: <20220724161405.146488-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220724161405.146488-1-martin@kaiser.cx>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 24, 2022 at 06:14:05PM +0200, Martin Kaiser wrote:
> Update ReadAdapterInfo8188EU to return 0 for success or a negative
> error code. Don't use the infamous _SUCCESS and _FAIL defines.
> 
> Handle returned errors in rtw_usb_if1_init, this will eventually fail the
> probing of the r8188eu driver.
> 
> Suggested-by: Pavel Skripkin <paskripkin@gmail.com>
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>  drivers/staging/r8188eu/hal/usb_halinit.c  | 7 ++++---
>  drivers/staging/r8188eu/include/hal_intf.h | 2 +-
>  drivers/staging/r8188eu/os_dep/usb_intf.c  | 3 ++-
>  3 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
> index 421fe7c40390..08d4b5dfd430 100644
> --- a/drivers/staging/r8188eu/hal/usb_halinit.c
> +++ b/drivers/staging/r8188eu/hal/usb_halinit.c
> @@ -922,7 +922,7 @@ static void Hal_EfuseParseMACAddr_8188EU(struct adapter *adapt, u8 *hwinfo, bool
>  	}
>  }
>  
> -void ReadAdapterInfo8188EU(struct adapter *Adapter)
> +int ReadAdapterInfo8188EU(struct adapter *Adapter)
>  {
>  	struct eeprom_priv *eeprom = &Adapter->eeprompriv;
>  	struct led_priv *ledpriv = &Adapter->ledpriv;
> @@ -933,13 +933,13 @@ void ReadAdapterInfo8188EU(struct adapter *Adapter)
>  	/* check system boot selection */
>  	res = rtw_read8(Adapter, REG_9346CR, &eeValue);
>  	if (res)
> -		return;
> +		return -1;

This is not a valid error code, please use a real -ESOMETHING instead.

thanks,

greg k-h
