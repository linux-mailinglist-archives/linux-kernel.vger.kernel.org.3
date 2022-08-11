Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5F1258F8F2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 10:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234119AbiHKIV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 04:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232987AbiHKIV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 04:21:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEEDA4B0D2;
        Thu, 11 Aug 2022 01:21:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8DEF7B81EAD;
        Thu, 11 Aug 2022 08:21:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7DE0C433D6;
        Thu, 11 Aug 2022 08:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660206083;
        bh=YdAqCSEiuaimqjtzakAUs0wmafOpgYzAjMzlOl9rbug=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0ly7D1f2c/aXgEW+njjbL8ouCrq3ETCt+6iB510jhlHXO04ATG306ObAwjaT96XCh
         tJHB5MtMaDBUewX/czZL88LPwmiqLgt/ZAGHMvncJcBTUlQb+s12zzcI6wRJUpLldj
         lSVz5VRIdffJP8dFlekfl2dkbJwC9WdFGTk68KKc=
Date:   Thu, 11 Aug 2022 10:21:20 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zhou jie <zhoujie@nfschina.com>
Cc:     johan@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@nfschina.com
Subject: Re: [PATCH] usb/serial:Modify the return value to void
Message-ID: <YvS8AK9apa7tnYOz@kroah.com>
References: <20220811070358.5472-1-zhoujie@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220811070358.5472-1-zhoujie@nfschina.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2022 at 03:03:58PM +0800, Zhou jie wrote:
> Modify the return value to void,The return value is not used elsewhere.
> 
> Signed-off-by: Zhou jie <zhoujie@nfschina.com>
> ---
>  drivers/usb/serial/mos7720.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/serial/mos7720.c b/drivers/usb/serial/mos7720.c
> index 1e12b5f30dcc..ddb3a2d0f819 100644
> --- a/drivers/usb/serial/mos7720.c
> +++ b/drivers/usb/serial/mos7720.c
> @@ -239,13 +239,12 @@ static int read_mos_reg(struct usb_serial *serial, unsigned int serial_portnum,
>  
>  #ifdef CONFIG_USB_SERIAL_MOS7715_PARPORT
>  
> -static inline int mos7715_change_mode(struct mos7715_parport *mos_parport,
> +static inline void mos7715_change_mode(struct mos7715_parport *mos_parport,
>  				      enum mos7715_pp_modes mode)
>  {
>  	mos_parport->shadowECR = mode;
>  	write_mos_reg(mos_parport->serial, dummy, MOS7720_ECR,
>  		      mos_parport->shadowECR);
> -	return 0;

Why not check the return value of write_mos_reg() and properly handle
the error that can give you instead of ignoring it?

thanks,

greg k-h
