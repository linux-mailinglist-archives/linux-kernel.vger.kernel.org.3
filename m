Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0696B4EE80C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 08:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245285AbiDAGKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 02:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233051AbiDAGKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 02:10:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF60BBC
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 23:08:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 556ABB82273
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 06:08:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 994C0C34110;
        Fri,  1 Apr 2022 06:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1648793300;
        bh=YFueYBxeF3pP1sxELNGDeE/l8m6/Goc5dYe7xrFWBnw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jbq5CGhJMWXhZGN4ZiQVPNjOTjADnwVVNaa/uu1G6zDXt4dL754F984iXJhpVNPv9
         KYcEbfURN6g3tL3//IqVC2AORcgtxNl+oXrPKjiiRSrse8a3N4H4dD+aaP/n+69RCx
         1GPeWxmbHJ56Do9wZ25BaUXA/lGvOoRMe1/YDzO0=
Date:   Fri, 1 Apr 2022 08:08:17 +0200
From:   reg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bruno Moreira-Guedes <codeagain@codeagain.dev>
Cc:     Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: Re: [PATCH] staging: vme: Adjusted VME_USER in Kconfig
Message-ID: <YkaW0ThT8Ah3z0wW@kroah.com>
References: <20220401050045.3686663-1-codeagain@codeagain.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220401050045.3686663-1-codeagain@codeagain.dev>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 01, 2022 at 02:00:45AM -0300, Bruno Moreira-Guedes wrote:
> Currently, the VME_USER driver is in the staging tree Kconfig, unlike
> other VME drivers already moved to the main portions of the kernel tree.
> Its configuration is, however, nested into the VME_BUS config option,
> which might be misleading.
> 
> Since the staging tree "[...] is used to hold stand-alone[1] drivers and
> filesystem that are not ready to be merged into the main portion of the
> Linux kernel tree [...]"[1], IMHO all staging drivers should appear
> nested into the Main Menu -> Device Drivers -> Staging Drivers to make
> sure the user don't pick it without being fully aware of its staging
> status as it could be the case in Menu -> Device Drivers -> VME bridge
> support (the current location).
> 
> With this change menuconfig users will clearly know this is not a driver
> in the main portion of the kernel tree and decide whether to build it or
> not with that clearly in mind.
> 
> This change goes into the same direction of commit 4b4cdf3979c3
> ("STAGING: Move staging drivers back to staging-specific menu")
> 
> [1] https://lkml.org/lkml/2009/3/18/314
> 
> Signed-off-by: Bruno Moreira-Guedes <codeagain@codeagain.dev>
> ---
>  drivers/staging/Kconfig | 2 ++
>  drivers/vme/Kconfig     | 2 --
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
> index 932acb4e8cbc..0545850eb2ff 100644
> --- a/drivers/staging/Kconfig
> +++ b/drivers/staging/Kconfig
> @@ -88,4 +88,6 @@ source "drivers/staging/qlge/Kconfig"
>  
>  source "drivers/staging/wfx/Kconfig"
>  
> +source "drivers/staging/vme/devices/Kconfig"
> +
>  endif # STAGING
> diff --git a/drivers/vme/Kconfig b/drivers/vme/Kconfig
> index 936392ca3c8c..c13dd9d2a604 100644
> --- a/drivers/vme/Kconfig
> +++ b/drivers/vme/Kconfig
> @@ -15,6 +15,4 @@ source "drivers/vme/bridges/Kconfig"
>  
>  source "drivers/vme/boards/Kconfig"
>  
> -source "drivers/staging/vme/devices/Kconfig"
> -
>  endif # VME
> -- 
> 2.35.1
> 
> 

The problem with this change is that you just changed the initialization
order of the drivers if they are built into the kernel.  Are you sure
that you can initialize a vme device driver before the vme bridge and
bus code is run?  I don't know if that will work properly, which is why
the Kconfig entries are in the order they currently are in (we preserved
the link order.)

It's not an obvious thing at all, sorry, but build order defines link
order, which defines the order in which things are initialized in the
kernel.

So I can't take this change unless you are able to prove that it still
works properly on the hardware that these drivers control.  Do you have
this hardware to test this change with?

thanks,

greg k-h
