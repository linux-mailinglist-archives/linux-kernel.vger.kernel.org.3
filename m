Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BFA0562CE1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 09:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235021AbiGAHnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 03:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiGAHns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 03:43:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C0C3819F
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 00:43:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8ED3C6248A
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 07:43:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94D31C3411E;
        Fri,  1 Jul 2022 07:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656661426;
        bh=j1zfRpbg0oFIgURXv8PfcZsUSKmxpvfxMhIDYC8VNuA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XMsGz5BOZFfWMctR4HJcbwlow8eP2jmlwcmrEB5iuhDakoqZ7l9K3VZgxLLJ/ecSI
         7hSCgf1U4wRZ0J7vT2D2VG1q5NhwPNitb9D2PpFn3fUJ93HaIpHJXRNj8RuPA0pkLS
         XhCHUd4oopdTbBB4SvHeYS8LRxlG7cHv3dSf9FA0=
Date:   Fri, 1 Jul 2022 09:43:43 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Felix Schlepper <f3sch.git@outlook.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        wjsota@gmail.com
Subject: Re: [PATCH v2 1/6] Staging: rtl8192e: Refactored rtllib_modes
Message-ID: <Yr6lr51bOEh9QkXN@kroah.com>
References: <cover.1656587827.git.f3sch.git@outlook.com>
 <82c9da336bf9bb7dbf5378efc9be20ea268eeb3c.1656587827.git.f3sch.git@outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82c9da336bf9bb7dbf5378efc9be20ea268eeb3c.1656587827.git.f3sch.git@outlook.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 01:30:14PM +0200, Felix Schlepper wrote:
> The initial reason for looking at this code was an
> issue raised by checkpatch.pl:
> 
>      $ ./scripts/checkpatch.pl --terse -f drivers/staging/rtl8192e/rtllib_wx.c
>      CHECK: Please use a blank line after function/struct/union/enum
>      declarations
> 
> The additional blank line above the struct/before the headers is
> just cleaner.
> 
> However, as it turns out since there is no str formatting required
> One can replace the error prone str + size struct with a char array.
> The rest of this patch fixes the usecases.
> 
> Signed-off-by: Felix Schlepper <f3sch.git@outlook.com>
> ---
>  drivers/staging/rtl8192e/rtllib_wx.c | 21 +++++----------------
>  1 file changed, 5 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtllib_wx.c b/drivers/staging/rtl8192e/rtllib_wx.c
> index cf9a240924f2..1e420230d029 100644
> --- a/drivers/staging/rtl8192e/rtllib_wx.c
> +++ b/drivers/staging/rtl8192e/rtllib_wx.c
> @@ -17,18 +17,8 @@
>  #include <linux/module.h>
>  #include <linux/etherdevice.h>
>  #include "rtllib.h"
> -struct modes_unit {
> -	char *mode_string;
> -	int mode_size;
> -};
> -static struct modes_unit rtllib_modes[] = {
> -	{"a", 1},
> -	{"b", 1},
> -	{"g", 1},
> -	{"?", 1},
> -	{"N-24G", 5},
> -	{"N-5G", 4},
> -};
> +
> +static const char *rtllib_modes[] = { "a", "b", "g", "?", "N-24G", "N-5G" };
>  
>  #define MAX_CUSTOM_LEN 64
>  static inline char *rtl819x_translate_scan(struct rtllib_device *ieee,
> @@ -72,10 +62,9 @@ static inline char *rtl819x_translate_scan(struct rtllib_device *ieee,
>  	/* Add the protocol name */
>  	iwe.cmd = SIOCGIWNAME;
>  	for (i = 0; i < ARRAY_SIZE(rtllib_modes); i++) {
> -		if (network->mode&(1<<i)) {
> -			sprintf(pname, rtllib_modes[i].mode_string,
> -				rtllib_modes[i].mode_size);
> -			pname += rtllib_modes[i].mode_size;
> +		if(network->mode & BIT(i)){
> +			strcpy(pname, rtllib_modes[i]);
> +			pname += strlen(rtllib_modes[i]);
>  		}
>  	}
>  	*pname = '\0';
> -- 
> 2.36.1
> 
> 

Always run checkpatch on your changes so you do not get grumpy
maintainers asking you why you did not run checkpatch on your changes...

thanks,

greg k-h
