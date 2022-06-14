Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8524454AD18
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 11:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354927AbiFNJSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 05:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233422AbiFNJSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 05:18:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29D83FBE6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 02:18:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 54CD1B817DC
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 09:18:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A26FC3411E;
        Tue, 14 Jun 2022 09:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655198309;
        bh=YeE9jrUyw9QrNFv2HwkbJWwjrAFDZqNqb/wb75IXkqQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pjW3FSHUhb7Desv7/QvW2HqgBaKTuiptA1StxId9jiUqorlZ2yiuqvuNWqcECzIr7
         IFqOi64Dsgj8QKtLHat8oAh6aTXtE9LIuiFmXAd0AmyHLaO9G16knXDb6TXYaHqfo2
         C+1ar3LKYFtsc6NhGpUsZRQf5RfIkDaQpOoKznUQ=
Date:   Tue, 14 Jun 2022 11:18:26 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dongliang Mu <dzm91@hust.edu.cn>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Martin Kaiser <martin@kaiser.cx>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        mudongliang <mudongliangabcd@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver: r8188eu: remove NULL check before vfree
Message-ID: <YqhSYtfLJ3h/zFEr@kroah.com>
References: <20220614090340.123714-1-dzm91@hust.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614090340.123714-1-dzm91@hust.edu.cn>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 05:03:30PM +0800, Dongliang Mu wrote:
> From: mudongliang <mudongliangabcd@gmail.com>
> 
> vfree can handle NULL pointer as its argument.
> According to coccinelle isnullfree check, remove NULL check
> before vfree operation.
> 
> Signed-off-by: mudongliang <mudongliangabcd@gmail.com>
> ---
>  drivers/staging/r8188eu/os_dep/usb_intf.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
> index 68869c5daeff..bd1c8b4b5c4b 100644
> --- a/drivers/staging/r8188eu/os_dep/usb_intf.c
> +++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
> @@ -372,8 +372,7 @@ static struct adapter *rtw_usb_if1_init(struct dvobj_priv *dvobj,
>  free_adapter:
>  	if (pnetdev)
>  		rtw_free_netdev(pnetdev);
> -	else if (padapter)
> -		vfree(padapter);
> +	vfree(padapter);

You changed the logic of this code here, please be more careful in the
future.

Also, you need to use your real name for the signed-off-by and From:
line.

thanks,

greg k-h
