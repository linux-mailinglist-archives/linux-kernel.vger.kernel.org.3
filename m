Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF61D544C59
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 14:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243964AbiFIMoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 08:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343969AbiFIMn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 08:43:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CAEB40902;
        Thu,  9 Jun 2022 05:43:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 575B3B82D3F;
        Thu,  9 Jun 2022 12:43:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E689FC3411D;
        Thu,  9 Jun 2022 12:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654778635;
        bh=DNUj55i+tBAtllU92vXeXrrYBcW7ydlaZIiUaPiMcDU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qr/9hCvA9/RXFgWTOOsYBWeT8rpRvItuiBrVVEUrLtqsnsUIJUp6BWMbc8KDK59Kb
         1/bDaRKhaElMuPoHuYR+HtP9JHSNEHukPpfjfeP30UrCuMPNOkdJ8a4QtCFMv6dQzS
         TX/TpsIgOX7mYRvzlX5CkABrBd0m/akNXJAqamLbnTpYBL9BCODvX/CrIzQLh1hsA0
         XGLlE/ysaYDaeZdNKwfvIrqY6NV8vfzpPF7TpomEILCASMJKgWOtwKOuMeBqW6m/Fq
         6Y7mopYnV467KWmnCjys0ZgNgINGqD6ScroZA7L4D6LgW6fEBvecFZnmH9+dv3+rhR
         lg/6pWcWPvOaw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nzHVu-0005Qw-Il; Thu, 09 Jun 2022 14:43:50 +0200
Date:   Thu, 9 Jun 2022 14:43:50 +0200
From:   Johan Hovold <johan@kernel.org>
To:     cgel.zte@gmail.com
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] USB: serial: Remove redundant NULL check before
 release_firmware() call
Message-ID: <YqHrBq1BZ+6DWcGl@hovoldconsulting.com>
References: <20220606014315.290533-1-chi.minghao@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220606014315.290533-1-chi.minghao@zte.com.cn>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 06, 2022 at 01:43:15AM +0000, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> release_firmware() checks for NULL pointers internally so checking
> before calling it is redundant.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>

Cleanups do not deserve a Reported-by tag, and neither do reports that
are never posted to the mailing lists.

> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> ---
>  drivers/usb/serial/mxuport.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/serial/mxuport.c b/drivers/usb/serial/mxuport.c
> index eb45a9b0005c..eb9090ab900f 100644
> --- a/drivers/usb/serial/mxuport.c
> +++ b/drivers/usb/serial/mxuport.c
> @@ -1109,8 +1109,7 @@ static int mxuport_probe(struct usb_serial *serial,
>  	 */
>  	usb_set_serial_data(serial, (void *)id->driver_info);
>  out:
> -	if (fw_p)
> -		release_firmware(fw_p);
> +	release_firmware(fw_p);

I think keeping this check is preferred here as it makes the intent of
code more clear (and you don't have to check the definition of
release_firmware() to make sure it's safe to pass in NULL).

>  	return err;
>  }

Johan
