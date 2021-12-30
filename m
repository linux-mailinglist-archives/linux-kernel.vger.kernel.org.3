Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60DC5481E63
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 17:58:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241413AbhL3Q62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 11:58:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240224AbhL3Q61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 11:58:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552ADC061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 08:58:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0A68AB81B4F
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 16:58:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CF6BC36AE7;
        Thu, 30 Dec 2021 16:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640883504;
        bh=dqCiUgaTtfnWCNdwr1wo/HF7EDQCebxbT+fLi0Mi3HY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O3Z7vo/UM0plAUHlYM2TwNlAN82ceaYm26vVIBL2QIceye/6DCG//6uiL6SU/7WGx
         kqD7kuwM679rXrh5a4qUdzp6XXUt3NWM0KM6lcUyAM/dFIK2o1aPKYOA5B2PLqoBe3
         L8g6bH/u639atTaMRs7RfDceXkhrNZg88JG3XiFs=
Date:   Thu, 30 Dec 2021 17:58:22 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jan Engelhardt <jengelh@inai.de>
Cc:     linux-kernel@vger.kernel.org, tkjos@android.com
Subject: Re: [PATCH] android: use "menuconfig" menu entry type for
 CONFIG_ANDROID
Message-ID: <Yc3lLpYKXl0MAEoO@kroah.com>
References: <20211230145002.7120-1-jengelh@inai.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211230145002.7120-1-jengelh@inai.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 30, 2021 at 03:50:02PM +0100, Jan Engelhardt wrote:
> Allow disabling the Android driver section from within the Device
> Drivers submenu, without having to descend into the Android drivers
> submenu first.
> 
> Signed-off-by: Jan Engelhardt <jengelh@inai.de>
> ---
>  drivers/android/Kconfig | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/android/Kconfig b/drivers/android/Kconfig
> index 53b22e26266c..dc0a373ab879 100644
> --- a/drivers/android/Kconfig
> +++ b/drivers/android/Kconfig
> @@ -1,7 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
> -menu "Android"
> -
> -config ANDROID
> +menuconfig ANDROID
>  	bool "Android Drivers"
>  	help
>  	  Enable support for various drivers needed on the Android platform
> @@ -55,5 +53,3 @@ config ANDROID_BINDER_IPC_SELFTEST
>  	  alignments.
>  
>  endif # if ANDROID
> -
> -endmenu
> -- 
> 2.34.1
> 

But, when you do this, you loose these lines from the .config file,
resulting in this diff in the file:

--- .config.save	2021-12-30 17:54:49.327896243 +0100
+++ .config	2021-12-30 17:56:21.459819436 +0100
@@ -6477,17 +6477,11 @@
 CONFIG_RAS=y
 # CONFIG_RAS_CEC is not set
 # CONFIG_USB4 is not set
-
-#
-# Android
-#
 CONFIG_ANDROID=y
 CONFIG_ANDROID_BINDER_IPC=y
 CONFIG_ANDROID_BINDERFS=y
 CONFIG_ANDROID_BINDER_DEVICES="binder"
 CONFIG_ANDROID_BINDER_IPC_SELFTEST=y
-# end of Android
-
 # CONFIG_LIBNVDIMM is not set
 CONFIG_DAX=m
 CONFIG_NVMEM=y



Is that really a good idea?  What's the default these days?

Also, to be pedantic, this is a [v2] patch, right?  :)

I'll wait for the other Android driver maintainers to review this before
applying it, if they agree it is ok to do.

thanks,

greg k-h
