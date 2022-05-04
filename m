Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98CD051C646
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 19:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382755AbiEERn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 13:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382358AbiEERnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 13:43:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22AC5A2C8;
        Thu,  5 May 2022 10:39:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 40FD461DC8;
        Thu,  5 May 2022 17:39:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 926ECC385A4;
        Thu,  5 May 2022 17:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651772384;
        bh=51RmuxsLCb5IZMOE7TRcGZprdeB6vu+ht+bajlN+wb0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ddliANIBdN9v47GuQ4HXO589wVvW3sKVS/E1qO/5XBne5KQ0d3ZHQ+MiL27yhL1Eo
         ZcMKlpKdJGij3JYs2tcGsp1GHwOUlaYmVBxKlaupK6ovRnvxmB6M2iD8UkIR+MnbyG
         i13vPZXKAosK+Qjp8TF5fAfUva0eJeblgAa9IXoA=
Date:   Wed, 4 May 2022 20:24:00 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Frank Wunderlich <linux@fw-web.de>
Cc:     linux-pm@vger.kernel.org,
        Frank Wunderlich <frank-w@public-files.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC v1] opp: add config option for debug
Message-ID: <YnLEwEIOqnLGxFjJ@kroah.com>
References: <20220504174823.156709-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220504174823.156709-1-linux@fw-web.de>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 04, 2022 at 07:48:23PM +0200, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Currently OPP debug is enabled by DEBUG_DRIVER option. This is generic
> driver debug and opp floods serial console. This is annoying if opp is
> not needed so give it an additional config-key.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
>  drivers/base/Kconfig | 1 +
>  drivers/opp/Kconfig  | 7 +++++++
>  drivers/opp/Makefile | 2 +-
>  3 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
> index 6f04b831a5c0..8ae826c95d5f 100644
> --- a/drivers/base/Kconfig
> +++ b/drivers/base/Kconfig
> @@ -130,6 +130,7 @@ config DEV_COREDUMP
>  config DEBUG_DRIVER
>  	bool "Driver Core verbose debug messages"
>  	depends on DEBUG_KERNEL
> +	imply DEBUG_OPP

This should not be needed, otherwise we would have to do that for all
random driver subsystem in the kernel.

>  	help
>  	  Say Y here if you want the Driver core to produce a bunch of
>  	  debug messages to the system log. Select this if you are having a
> diff --git a/drivers/opp/Kconfig b/drivers/opp/Kconfig
> index e8ce47b32735..6a2d2c6c1143 100644
> --- a/drivers/opp/Kconfig
> +++ b/drivers/opp/Kconfig
> @@ -12,3 +12,10 @@ config PM_OPP
>  	  representing individual voltage domains and provides SOC
>  	  implementations a ready to use framework to manage OPPs.
>  	  For more information, read <file:Documentation/power/opp.rst>
> +
> +menu "Operating Performance Points (OPP)"
> +config DEBUG_OPP
> +	bool "Debug Operating Performance Points"
> +	help
> +	  enable opp debugging
> +endmenu
> diff --git a/drivers/opp/Makefile b/drivers/opp/Makefile
> index f65ed5985bb4..2589915eef95 100644
> --- a/drivers/opp/Makefile
> +++ b/drivers/opp/Makefile
> @@ -1,5 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> -ccflags-$(CONFIG_DEBUG_DRIVER)	:= -DDEBUG
> +ccflags-$(CONFIG_DEBUG_OPP)	:= -DDEBUG

This feels wrong, you shouldn't need a -DDEBUG for anything if all is
going correctly.  Why is opp so odd this way?  Just use the normal
dev_dbg() macros and all will be fine, nothing special should be needed
at all.

And don't use a config option for it either, no one will turn it on, it
needs to "just work" for all systems.

thanks,

greg k-h
