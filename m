Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B1E58A5F5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 08:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235794AbiHEGjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 02:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235406AbiHEGjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 02:39:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7C972ED2
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 23:39:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 392DA61313
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 06:39:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40CEAC43470;
        Fri,  5 Aug 2022 06:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659681583;
        bh=I+kcE97Ve6/ReO0B8c5180Bc7abr6kASH5KpHGYE8A8=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=1hq61QxoWIElS+9Pl/b8sRq11hctbk7P2Ebd6DPZ8el95aG0HUuqJyMoMmRaaojzi
         qUl3aMHwnnVYaiY3rRlYHbbJnNqN1IyFzjyFLT4oLR5B0dAhYUtZ7oLFFjimQfWD1J
         cuRWQ6a8gZuYy0u8l2jUu2sT0fqhvZWD3eudoyws=
Date:   Fri, 5 Aug 2022 08:39:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Grzegorz Szymaszek <gszymaszek@short.pl>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH 3/3] staging: r8188eu: make driver metadata macro names
 more consistent
Message-ID: <Yuy7Lc/TJMinuupA@kroah.com>
References: <6c83e05e5dbccff5630ccfed9e40bf84c889b647.1659565180.git.gszymaszek@short.pl>
 <7cc838a1e7f64c9aa88deffdb7986fbe55753be8.1659565180.git.gszymaszek@short.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7cc838a1e7f64c9aa88deffdb7986fbe55753be8.1659565180.git.gszymaszek@short.pl>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 04, 2022 at 12:29:10AM +0200, Grzegorz Szymaszek wrote:
> Rename DRIVERVERSION to DRV_VERSION so that it looks more alike the
> other macros, DRV_NAME and FW_*, and matches the most popular (as it
> seems from a quick review) conventions in other drivers.
> 
> Signed-off-by: Grzegorz Szymaszek <gszymaszek@short.pl>
> ---
>  drivers/staging/r8188eu/include/drv_types.h | 5 ++---
>  drivers/staging/r8188eu/os_dep/os_intfs.c   | 2 +-
>  2 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/include/drv_types.h b/drivers/staging/r8188eu/include/drv_types.h
> index f51b83515953..3328c66d1ef1 100644
> --- a/drivers/staging/r8188eu/include/drv_types.h
> +++ b/drivers/staging/r8188eu/include/drv_types.h
> @@ -10,8 +10,6 @@
>  #ifndef __DRV_TYPES_H__
>  #define __DRV_TYPES_H__
>  
> -#define DRV_NAME "r8188eu"

This should just be KBUILD_MODNAME, no need to create yet-another-macro
for this one.

> -
>  #include "osdep_service.h"
>  #include "wlan_bssdef.h"
>  #include "rtw_ht.h"
> @@ -36,7 +34,8 @@
>  #include "rtl8188e_hal.h"
>  #include "rtw_fw.h"
>  
> -#define DRIVERVERSION	"v4.1.4_6773.20130222"
> +#define DRV_NAME	"r8188eu"

Again, KBUILD_MODNAME

> +#define DRV_VERSION	"v4.1.4_6773.20130222"

As the driver is now in the kernel, this "version" string can just go
away.  Can you redo this patch to do the DRV_NAME thing first, and then
drop the DRV_VERSION field after that?

thanks,

greg k-h
