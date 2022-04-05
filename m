Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDAFF4F48D2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387183AbiDEVu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 17:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446335AbiDEPo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:44:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B584F1E8B
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 07:14:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1712D60AF7
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 14:14:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 212A4C385A0;
        Tue,  5 Apr 2022 14:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649168059;
        bh=iZiKzlaCdiL7IWBslwNKbqVzttLxVImUfOeQx9NnVUM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nWdxN7YrHrzMCDGsHyy5S7maXW02cB88esApZehmKD+BXdSwk65Vf4qZgFfIQ4P2W
         GQ4f+kRiSv7gW3qCDgVBPXZX5ucvJfKwAEo1y1TavKiF7jqM0h6LEzIu2aI4HJGFaK
         wHjRjFBgVEHdorkBq7gpQXQFgQGOWabfpzM/3aRU=
Date:   Tue, 5 Apr 2022 16:14:17 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Vihas Makwana <makvihas@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] staging: r8188eu: simplify
 rtw_inc_and_chk_continual_urb_error
Message-ID: <YkxOueWoitw83chA@kroah.com>
References: <20220405124239.3372-1-makvihas@gmail.com>
 <20220405124239.3372-4-makvihas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405124239.3372-4-makvihas@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 06:12:40PM +0530, Vihas Makwana wrote:
> The if check and variable "value" is redundant. Drop it and simplify
> the funciton.
> 
> Signed-off-by: Vihas Makwana <makvihas@gmail.com>
> ---
>  drivers/staging/r8188eu/include/usb_ops.h | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/include/usb_ops.h b/drivers/staging/r8188eu/include/usb_ops.h
> index ddc46cb44..c5982704c 100644
> --- a/drivers/staging/r8188eu/include/usb_ops.h
> +++ b/drivers/staging/r8188eu/include/usb_ops.h
> @@ -27,12 +27,7 @@
>   */
>  static inline bool rtw_inc_and_chk_continual_urb_error(struct dvobj_priv *dvobj)
>  {
> -	int value = atomic_inc_return(&dvobj->continual_urb_error);
> -
> -	if (value > MAX_CONTINUAL_URB_ERR)
> -		return true;
> -
> -	return false;
> +	return atomic_inc_return(&dvobj->continual_urb_error) > MAX_CONTINUAL_URB_ERR;
>  }

Let's leave this as-is because it's a mess and should be fixed up
anyway.  No need to count urb errors as atomic values, this is crazy.

thanks,

greg k-h
