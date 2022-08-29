Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 297145A4E49
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 15:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbiH2Ng6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 09:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbiH2Ngp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 09:36:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2946557E;
        Mon, 29 Aug 2022 06:36:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F4A260B9A;
        Mon, 29 Aug 2022 13:36:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C4BEC433C1;
        Mon, 29 Aug 2022 13:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661780203;
        bh=Y7V8r6sKAbYpz0MLRTWg2oGd3TE6f80EOgHwCR0HEnM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nURGRNq5QN8Oiqy5mUVr39TkEHoDgFPF9jYMYgHPBQAuMH+aVMe2lbtCbvUmhU5AX
         ZU9xzlqhdyDOWLCWURlcNADzBi+NzvF6exfJaiOM/yBMntt4MOVRmljFQqtwkWLzJn
         HchaxVr0n920bh+6nbbjZFLkxDtFGF3pcGWPa8Mvqrm0/opaKaBJFUWqWyIL/osyoj
         6OnWUAwVCfRotSbap0elSzuKPjYW9/k0eXFNzJUDK7KiqfDQXrm0OaRAdvCPsb0Ng4
         dbvxmc3Bz0aEptVqb0+0J+EvBWkPiYSVcjp3TAo5mJMUHzdaWgMTFtPjfsBLhERh7M
         t2VWBVcBP0cKA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oSewc-0004gQ-Uh; Mon, 29 Aug 2022 15:36:51 +0200
Date:   Mon, 29 Aug 2022 15:36:50 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Slark Xiao <slark_xiao@163.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH] USB: serial: option: add support for Cinterion
 MV32-WA/WB RmNet mode
Message-ID: <YwzA8kOf6AFECDuQ@hovoldconsulting.com>
References: <20220810033050.3117-1-slark_xiao@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220810033050.3117-1-slark_xiao@163.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2022 at 11:30:50AM +0800, Slark Xiao wrote:
> We added PIDs for MV32-WA/WB MBIM mode before, now we need to add
> support for RmNet mode.

> Signed-off-by: Slark Xiao <slark_xiao@163.com>
> ---
>  drivers/usb/serial/option.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
> index de59fa919540..63af8b48831a 100644
> --- a/drivers/usb/serial/option.c
> +++ b/drivers/usb/serial/option.c
> @@ -438,6 +438,8 @@ static void option_instat_callback(struct urb *urb);
>  #define CINTERION_PRODUCT_MV31_2_RMNET		0x00b9
>  #define CINTERION_PRODUCT_MV32_WA		0x00f1
>  #define CINTERION_PRODUCT_MV32_WB		0x00f2
> +#define CINTERION_PRODUCT_MV32_WA_RMNET		0x00f3
> +#define CINTERION_PRODUCT_MV32_WB_RMNET		0x00f4
>  
>  /* Olivetti products */
>  #define OLIVETTI_VENDOR_ID			0x0b3c
> @@ -1995,6 +1997,10 @@ static const struct usb_device_id option_ids[] = {
>  	  .driver_info = RSVD(3)},
>  	{ USB_DEVICE_INTERFACE_CLASS(CINTERION_VENDOR_ID, CINTERION_PRODUCT_MV32_WB, 0xff),
>  	  .driver_info = RSVD(3)},
> +	{ USB_DEVICE_INTERFACE_CLASS(CINTERION_VENDOR_ID, CINTERION_PRODUCT_MV32_WA_RMNET, 0xff),
> +	  .driver_info = RSVD(0)},

I moved this entry above CINTERION_PRODUCT_MV32_WB to the keep the
entries sorted.

> +	{ USB_DEVICE_INTERFACE_CLASS(CINTERION_VENDOR_ID, CINTERION_PRODUCT_MV32_WB_RMNET, 0xff),
> +	  .driver_info = RSVD(0)},
>  	{ USB_DEVICE(OLIVETTI_VENDOR_ID, OLIVETTI_PRODUCT_OLICARD100),
>  	  .driver_info = RSVD(4) },
>  	{ USB_DEVICE(OLIVETTI_VENDOR_ID, OLIVETTI_PRODUCT_OLICARD120),

Now applied, thanks.

Johan
