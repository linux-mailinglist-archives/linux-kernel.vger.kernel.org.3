Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E26F4FCEAC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 07:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347680AbiDLFRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 01:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343571AbiDLFRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 01:17:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50E520F74;
        Mon, 11 Apr 2022 22:14:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E727DB81A8D;
        Tue, 12 Apr 2022 05:14:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E562C385A1;
        Tue, 12 Apr 2022 05:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649740489;
        bh=D+3CPjCaMIxKlAlEp2U4syRYUqxjLf02CVuKt4j2BvY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W/5cjVy2JefiT9QoPvgQPOL4Z1jUUPJ8Awz118Vy91Is6PUOCzOBOYGdQ7FxErjkK
         PYeqDK9k3/vsw5yTmqJJkXy72wHT6uZyeoMZ+UUdEhoOMlq7vV88JdJTl8AS6KBMq1
         AMlC2x9jtvS8xsHbPUtQxA1mjM04cBYfw4O+I4d0=
Date:   Tue, 12 Apr 2022 07:14:47 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Surong Pang <surong.pang@gmail.com>
Cc:     mathias.nyman@intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V1 1/1] usb/host: To get "usb3-slow-suspend" property,
 then to set xhci quirks
Message-ID: <YlUKx5lxWShSfycp@kroah.com>
References: <20220412025952.21062-1-surong.pang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412025952.21062-1-surong.pang@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 10:59:52AM +0800, Surong Pang wrote:
> From: Surong Pang <surong.pang@unisoc.com>
> 
> To set xhci->quirks value according to "usb3-slow-suspend" property
> 
> Signed-off-by: Surong Pang <surong.pang@unisoc.com>
> ---
>  drivers/usb/host/xhci-plat.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> index 649ffd861b44..6bc456bc6468 100644
> --- a/drivers/usb/host/xhci-plat.c
> +++ b/drivers/usb/host/xhci-plat.c
> @@ -302,6 +302,9 @@ static int xhci_plat_probe(struct platform_device *pdev)
>  		if (device_property_read_bool(tmpdev, "usb3-lpm-capable"))
>  			xhci->quirks |= XHCI_LPM_SUPPORT;
>  
> +		if (device_property_read_bool(tmpdev, "usb3-slow-suspend"))
> +			xhci->quirks |= XHCI_SLOW_SUSPEND;

Where is that property documented?

