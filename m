Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3224E58201D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 08:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiG0Gat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 02:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiG0Gar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 02:30:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BECB5F4F
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 23:30:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EB263B81F51
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 06:30:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DBAEC433C1;
        Wed, 27 Jul 2022 06:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658903442;
        bh=rp46eH3qqWssaoc9B9oVQqpON0sWe0H9YfC23+ByrC0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d3WnuUsvKefu/oDlgSH2nCeFN4GIEEV7PO5YvijdrF4M0exFCpffiXDVS9qTq9GDk
         0t/HxD1r2AgCpkR7xTJQPJEA5NBo99KYi/hmOxOoTj0bK6dc9VKp4ADH3TMMXszZqG
         Sfza4Gzl6h434Zpno++Rsh3Tg5cG1O6xGcZgLQNc=
Date:   Wed, 27 Jul 2022 08:30:39 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: make dump_chip_info() static
Message-ID: <YuDbjzkSJk3gRNpN@kroah.com>
References: <20220724182520.7794-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220724182520.7794-1-straube.linux@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 24, 2022 at 08:25:20PM +0200, Michael Straube wrote:
> The function dump_chip_info() is only used in rtl8188e_hal_init.c.
> Make it static to reduce the driver object file size by 281 bytes.
> 
> before:
>   text    data     bss     dec     hex filename
> 530606   43897    7072  581575   8dfc7 drivers/staging/r8188eu/r8188eu.o
> 
> after:
>   text    data     bss     dec     hex filename
> 530405   43817    7072  581294   8deae drivers/staging/r8188eu/r8188eu.o
> 
> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> ---
>  drivers/staging/r8188eu/hal/hal_com.c         | 39 -------------------
>  .../staging/r8188eu/hal/rtl8188e_hal_init.c   | 39 +++++++++++++++++++
>  drivers/staging/r8188eu/include/hal_com.h     |  3 --
>  3 files changed, 39 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/hal/hal_com.c b/drivers/staging/r8188eu/hal/hal_com.c
> index e9a32dd84a8e..6a1cdc67335b 100644
> --- a/drivers/staging/r8188eu/hal/hal_com.c
> +++ b/drivers/staging/r8188eu/hal/hal_com.c
> @@ -10,45 +10,6 @@
>  
>  #define _HAL_INIT_C_
>  
> -void dump_chip_info(struct HAL_VERSION	chip_vers)
> -{
> -	uint cnt = 0;
> -	char buf[128];
> -
> -	cnt += sprintf((buf + cnt), "Chip Version Info: CHIP_8188E_");
> -	cnt += sprintf((buf + cnt), "%s_", IS_NORMAL_CHIP(chip_vers) ?
> -		       "Normal_Chip" : "Test_Chip");
> -	cnt += sprintf((buf + cnt), "%s_", IS_CHIP_VENDOR_TSMC(chip_vers) ?
> -		       "TSMC" : "UMC");
> -
> -	switch (chip_vers.CUTVersion) {
> -	case A_CUT_VERSION:
> -		cnt += sprintf((buf + cnt), "A_CUT_");
> -		break;
> -	case B_CUT_VERSION:
> -		cnt += sprintf((buf + cnt), "B_CUT_");
> -		break;
> -	case C_CUT_VERSION:
> -		cnt += sprintf((buf + cnt), "C_CUT_");
> -		break;
> -	case D_CUT_VERSION:
> -		cnt += sprintf((buf + cnt), "D_CUT_");
> -		break;
> -	case E_CUT_VERSION:
> -		cnt += sprintf((buf + cnt), "E_CUT_");
> -		break;
> -	default:
> -		cnt += sprintf((buf + cnt), "UNKNOWN_CUT(%d)_", chip_vers.CUTVersion);
> -		break;
> -	}
> -
> -	cnt += sprintf((buf + cnt), "1T1R_");
> -
> -	cnt += sprintf((buf + cnt), "RomVer(%d)\n", 0);
> -
> -	pr_info("%s", buf);
> -}
> -
>  #define	CHAN_PLAN_HW	0x80
>  
>  u8 /* return the final channel plan decision */
> diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
> index fe477438899e..5b8f1a912bbb 100644
> --- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
> +++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
> @@ -526,6 +526,45 @@ void rtl8188e_ReadEFuse(struct adapter *Adapter, u16 _size_byte, u8 *pbuf)
>  	Hal_EfuseReadEFuse88E(Adapter, 0, _size_byte, pbuf);
>  }
>  
> +static void dump_chip_info(struct HAL_VERSION chip_vers)
> +{
> +	uint cnt = 0;
> +	char buf[128];
> +
> +	cnt += sprintf((buf + cnt), "Chip Version Info: CHIP_8188E_");
> +	cnt += sprintf((buf + cnt), "%s_", IS_NORMAL_CHIP(chip_vers) ?
> +		       "Normal_Chip" : "Test_Chip");
> +	cnt += sprintf((buf + cnt), "%s_", IS_CHIP_VENDOR_TSMC(chip_vers) ?
> +		       "TSMC" : "UMC");
> +
> +	switch (chip_vers.CUTVersion) {
> +	case A_CUT_VERSION:
> +		cnt += sprintf((buf + cnt), "A_CUT_");
> +		break;
> +	case B_CUT_VERSION:
> +		cnt += sprintf((buf + cnt), "B_CUT_");
> +		break;
> +	case C_CUT_VERSION:
> +		cnt += sprintf((buf + cnt), "C_CUT_");
> +		break;
> +	case D_CUT_VERSION:
> +		cnt += sprintf((buf + cnt), "D_CUT_");
> +		break;
> +	case E_CUT_VERSION:
> +		cnt += sprintf((buf + cnt), "E_CUT_");
> +		break;
> +	default:
> +		cnt += sprintf((buf + cnt), "UNKNOWN_CUT(%d)_", chip_vers.CUTVersion);
> +		break;
> +	}
> +
> +	cnt += sprintf((buf + cnt), "1T1R_");
> +
> +	cnt += sprintf((buf + cnt), "RomVer(%d)\n", 0);
> +
> +	pr_info("%s", buf);

Nit, none of this should be sent to the kernel log if all is good.  When
drivers are working properly, they are quiet.  This is spamming the
kernel log for when things are working properly, which just slows
booting down.

Also no driver should be calling pr_*() calls when they have a real
device at hand.

So this should be moved to be a dev_dbg() so that developers can still
enable it when they want to see this information, but it doesn't spam
the log for normal users.  But that's all for a future change, this one
is fine as-is, I'll take it now, thanks.

greg k-h
