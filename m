Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 012F550FB1C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 12:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349259AbiDZKh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 06:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349245AbiDZKgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 06:36:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D9263F1;
        Tue, 26 Apr 2022 03:20:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CE604B81CB3;
        Tue, 26 Apr 2022 10:20:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 089CFC385A4;
        Tue, 26 Apr 2022 10:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650968410;
        bh=e6N7DAl60u2IYLrV1XyeMLr4YJA3vLY7R2dH8ade/hA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IY8D9Xtrx2JuVQo1N8L1aP6atsEBMBwZTgZg5QkHK8+tcSE9/K7XYiRkSkQFQivH5
         614QbEYWOjv5h620OOIpkSYhTpQsUn9y0b//hU1iXjKmomrEt53V4NS1kdm8e4arU+
         NjJbtDzPrp6i5+g7BaR48Gmvk435wsqjYpq6WpJc=
Date:   Tue, 26 Apr 2022 12:20:07 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daehwan Jung <dh10.jung@samsung.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Howard Yen <howardyen@google.com>,
        Jack Pham <jackp@codeaurora.org>,
        Puma Hsu <pumahsu@google.com>,
        "J . Avila" <elavila@google.com>, sc.suh@samsung.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH v4 3/5] usb: host: xhci-plat: support override of hc
 driver
Message-ID: <YmfHV3V/wf9Dsn6l@kroah.com>
References: <1650964728-175347-1-git-send-email-dh10.jung@samsung.com>
 <CGME20220426092022epcas2p2da47c0c20feba6c96037e125289475f9@epcas2p2.samsung.com>
 <1650964728-175347-4-git-send-email-dh10.jung@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1650964728-175347-4-git-send-email-dh10.jung@samsung.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 06:18:46PM +0900, Daehwan Jung wrote:
> It helps xhci-plat driver increase usability. Vendors could use functions
> in xhci-plat mostly and use some overrides to do what they wants without
> modifying xhci-plat driver.
> 
> Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
> ---
>  drivers/usb/host/xhci-plat.c | 6 ++++++
>  drivers/usb/host/xhci-plat.h | 1 +
>  2 files changed, 7 insertions(+)
> 
> diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> index a5881ff945a6..6efa3169bf69 100644
> --- a/drivers/usb/host/xhci-plat.c
> +++ b/drivers/usb/host/xhci-plat.c
> @@ -173,6 +173,12 @@ static const struct of_device_id usb_xhci_of_match[] = {
>  MODULE_DEVICE_TABLE(of, usb_xhci_of_match);
>  #endif
>  
> +void xhci_plat_override_driver(const struct xhci_driver_overrides *xhci_vendor_overrides)
> +{
> +	xhci_init_driver(&xhci_plat_hc_driver, xhci_vendor_overrides);
> +}
> +EXPORT_SYMBOL(xhci_plat_override_driver);

EXPORT_SYMBOL_GPL() please.

thanks,

greg k-h
