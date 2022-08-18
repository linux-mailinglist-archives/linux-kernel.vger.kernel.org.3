Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B12EA59855C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 16:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245690AbiHROJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 10:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245660AbiHROI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 10:08:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8BB6CEE;
        Thu, 18 Aug 2022 07:08:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 66EB561730;
        Thu, 18 Aug 2022 14:08:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41F9FC433D7;
        Thu, 18 Aug 2022 14:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660831736;
        bh=JOv+kGKRH7+GQLqkWsL2c02sYxMRgChMQnRCvridvds=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pshGGoItzGo46mGHIj3uEyX0sSR7CqeQocF8jX0f+X67fxMuAodQMfs1y/RknTJBO
         9alWd6UR1ii4y2FBCimzswXhpvxDGU9oBwm8iLlu3bVY0lBjYkqrVbCz3NG8c6nDRz
         P0kPGw92VHqnh037q12OKPyiUchvjc10hWvFkWeg=
Date:   Thu, 18 Aug 2022 16:08:53 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, Bin Liu <b-liu@ti.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/11] musb: fix USB_MUSB_TUSB6010 dependency
Message-ID: <Yv5H9XZf6HJwJNui@kroah.com>
References: <20220818135522.3143514-1-arnd@kernel.org>
 <20220818135737.3143895-1-arnd@kernel.org>
 <20220818135737.3143895-10-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220818135737.3143895-10-arnd@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2022 at 03:57:20PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Turning on NOP_USB_XCEIV as builtin broke the TUSB6010 driver because
> of an older issue with the depencency.
> 
> It is not necessary to forbid NOP_USB_XCEIV=y in combination with
> USB_MUSB_HDRC=m, but only the reverse, which causes the link failure
> from the original Kconfig change.
> 
> Use the correct dependency to still allow NOP_USB_XCEIV=n or
> NOP_USB_XCEIV=y but forbid NOP_USB_XCEIV=m when USB_MUSB_HDRC=m
> to fix the multi_v7_defconfig for tusb.
> 
> Fixes: ab37a7a890c1 ("ARM: multi_v7_defconfig: Make NOP_USB_XCEIV driver built-in")
> Fixes: c0442479652b ("usb: musb: Fix randconfig build issues for Kconfig options")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/usb/musb/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Want me to take this through my tree now?  If so, I can, otherwise
here's a:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

for your tree.

thanks,

greg k-h
