Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4715A4BEB34
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 20:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbiBUSb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 13:31:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbiBUS2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 13:28:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DBD51143
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 10:27:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E83FAB81714
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 18:27:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02DDDC340E9;
        Mon, 21 Feb 2022 18:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645468027;
        bh=dnsspyvKq3Qya8BwiyCkj0fVsSKQr+F44WMkvdDurso=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HDTlNVsHDLD/BDmL9ZQDmVZ+qKW4qJ7Zkqp0pPkJfwFgAwAv82VakuQJ87NIPd3uo
         bIiJkK+ywW/BkvJcTa0qJH8LrJCMmZwgn5tiLoD4KWiU5JePGpfh7xjPsTigdQy5tf
         mcOQtie59yxiH0xwerOFoqJxtt0vSJyiPCGZxYjk=
Date:   Mon, 21 Feb 2022 19:27:04 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, kernel@axis.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] char: ttyprintk: register console
Message-ID: <YhPZeDBlrHjLcgPh@kroah.com>
References: <20220215141750.92808-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220215141750.92808-1-vincent.whitchurch@axis.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 03:17:49PM +0100, Vincent Whitchurch wrote:
> Register a console in the ttyprintk driver so that it can be selected
> for /dev/console with console=ttyprintk on the kernel command line,
> similar to other console drivers.
> 
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
>  drivers/char/Kconfig     |  3 ++-
>  drivers/char/ttyprintk.c | 16 ++++++++++++++++
>  2 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
> index 740811893c57..c553a8a50d03 100644
> --- a/drivers/char/Kconfig
> +++ b/drivers/char/Kconfig
> @@ -18,7 +18,8 @@ config TTY_PRINTK
>  	  The feature is useful to inline user messages with kernel
>  	  messages.
>  	  In order to use this feature, you should output user messages
> -	  to /dev/ttyprintk or redirect console to this TTY.
> +	  to /dev/ttyprintk or redirect console to this TTY, or boot
> +	  the kernel with console=ttyprintk.

Why do you want to use this tty device as a console?  What benifit does
that provide?

thanks,

greg k-h
