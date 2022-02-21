Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3344BE1A2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381583AbiBURQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 12:16:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381581AbiBURQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 12:16:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A9426122
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 09:16:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 640216144F
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 17:16:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49E2DC340E9;
        Mon, 21 Feb 2022 17:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645463784;
        bh=hOo8EVPxASwZeK28tfDq8KEHLaCOknGxUF68Yqnl/sg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1HX/pX2MsbcEs6iGjOcwfoko6GxCKx9gkE8DhyVnQx7swBLTeHG6rBzf9cYvWhVUq
         JBXQ19OlMZuHftENRuUMMgbotQk9eSaLETWRXD+mDhfQBqSVNtac6FTVJRaihDu0tX
         Wwh4SvzmLzNKaQhJShwW+r4lhS2fc8FrKT2AZKwA=
Date:   Mon, 21 Feb 2022 18:16:22 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tong Zhang <ztong0001@gmail.com>
Cc:     Jakub Kicinski <kuba@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        Colin Ian King <colin.i.king@googlemail.com>,
        Saurav Girepunje <saurav.girepunje@gmail.com>,
        Johan Hovold <johan@kernel.org>,
        =?iso-8859-1?Q?Cl=E1udio?= Maia <clrrm@isep.ipp.pt>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8192u: cleanup proc fs entries upon exit
Message-ID: <YhPI5iDRUpzYWDyY@kroah.com>
References: <20220220231554.2510567-1-ztong0001@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220220231554.2510567-1-ztong0001@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 20, 2022 at 03:15:53PM -0800, Tong Zhang wrote:
> proc fs entries need to be removed when module is removed, otherwise
> when we try to insert the module again, kernel will complain
> 
> [  493.068012] proc_dir_entry 'net/ieee80211' already registered
> [  493.271973]  proc_mkdir+0x18/0x20
> [  493.272136]  ieee80211_debug_init+0x28/0xde8 [r8192u_usb]
> [  493.272404]  rtl8192_usb_module_init+0x10/0x161 [r8192u_usb]
> 
> [   13.910616] proc_dir_entry 'net/rtl819xU' already registered
> [   13.918931]  proc_mkdir+0x18/0x20
> [   13.919098]  rtl8192_usb_module_init+0x142/0x16d [r8192u_usb]
> 
> Signed-off-by: Tong Zhang <ztong0001@gmail.com>
> ---
>  drivers/staging/rtl8192u/r8192U_core.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
> index 364e1ca94f70..683afdc667bc 100644
> --- a/drivers/staging/rtl8192u/r8192U_core.c
> +++ b/drivers/staging/rtl8192u/r8192U_core.c
> @@ -4825,6 +4825,11 @@ static int __init rtl8192_usb_module_init(void)
>  static void __exit rtl8192_usb_module_exit(void)
>  {
>  	usb_deregister(&rtl8192_usb_driver);
> +	remove_proc_entry(RTL819XU_MODULE_NAME, init_net.proc_net);
> +
> +#ifdef CONFIG_IEEE80211_DEBUG
> +	ieee80211_debug_exit();
> +#endif

Please do not put #ifdef in .c files.  They should be in a .h file
instead.

thanks,

greg k-h
