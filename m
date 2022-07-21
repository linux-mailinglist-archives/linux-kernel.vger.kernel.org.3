Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 269BB57D327
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 20:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbiGUSSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 14:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232227AbiGUSS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 14:18:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520EB8C744;
        Thu, 21 Jul 2022 11:18:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0DCF0B82622;
        Thu, 21 Jul 2022 18:18:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 353DAC341C0;
        Thu, 21 Jul 2022 18:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658427504;
        bh=4R5kkjr1Ao+cpSMsUTzhvSDxb9fffbAoI3OH61cMTNo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZvtmTNpw04q4Jwe6d8fYjDUtvcxv1DvG7FMRW4AnbhUrbbPcJbmT3eGtOZeSUMXpe
         P93k7d9ET0Rd+1z+lyCcw0yzzLmWAhSPNUd+cMcuHUhy/x6RN/UQyMNZzWGE4R4HK+
         D8G3ChkpNOM/VXCklWj3N7toxn+cn/FjcHanjcjM=
Date:   Thu, 21 Jul 2022 20:18:01 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yan Xinyu <sdlyyxy@bupt.edu.cn>
Cc:     johan@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] USB: serial: usb_wwan: replace DTR/RTS magic numbers
 with macros
Message-ID: <YtmYWbRtbNvph6lF@kroah.com>
References: <20220721155257.631793-1-sdlyyxy@bupt.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721155257.631793-1-sdlyyxy@bupt.edu.cn>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 11:52:57PM +0800, Yan Xinyu wrote:
> The usb_wwan_send_setup function generates DTR/RTS signals in compliance
> with CDC ACM standard. This patch changes magic numbers in this function
> to equivalent macros.
> 
> Signed-off-by: Yan Xinyu <sdlyyxy@bupt.edu.cn>
> ---
> v1->v2:
>  * Fix Signed-off-by name.
> ---
>  drivers/usb/serial/usb_wwan.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/serial/usb_wwan.c b/drivers/usb/serial/usb_wwan.c
> index dab38b63eaf7..a6bd6144702d 100644
> --- a/drivers/usb/serial/usb_wwan.c
> +++ b/drivers/usb/serial/usb_wwan.c
> @@ -29,10 +29,14 @@
>  #include <linux/bitops.h>
>  #include <linux/uaccess.h>
>  #include <linux/usb.h>
> +#include <linux/usb/cdc.h>
>  #include <linux/usb/serial.h>
>  #include <linux/serial.h>
>  #include "usb-wwan.h"
>  
> +#define ACM_CTRL_DTR 0x01
> +#define ACM_CTRL_RTS 0x02

Why are these not in the cdc.h file already?

thanks,

greg k-h
