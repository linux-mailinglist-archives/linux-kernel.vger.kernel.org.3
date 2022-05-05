Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6FFC51BE4B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 13:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355785AbiEELo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 07:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbiEELoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 07:44:24 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C654F53703;
        Thu,  5 May 2022 04:40:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 014A4CE2CCE;
        Thu,  5 May 2022 11:40:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 412D7C385A8;
        Thu,  5 May 2022 11:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651750841;
        bh=rpuB5GOvWUXRGPN9vUlcxJ/CK+93A8tlxUyxum1xGFI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qnIWMoRbdJmBVtipdoRnWO9HVlNgBw/xHn83G0RyvP79MU6rFD9a/PdIM1zk03w3j
         MdEN8iFhzBXpdpTEj3D9bPbWSv93ltBeH/rknhkXckShLzPDUdw4Vc8/imR+vqlx9N
         wqcTlEjeJxGTvCMpm0YvK2lzrcSO5muq/G6vPPFVYWn172yMlsMzfqhI7LoSbRixwj
         Liz++IG68UG7fX7HMw2GVLIffIcaaMDoY5mabGV1gUgIWTKt34CUwLziUeCgjGsMKL
         0B2j9Av5FwK+2olMp7+xiXMPjEb8gqImAi4EEACDqOXHso3ygyXG8NYn/owbLIwkoU
         RnpDAnADlC97w==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nmZqb-0002xd-RK; Thu, 05 May 2022 13:40:41 +0200
Date:   Thu, 5 May 2022 13:40:41 +0200
From:   Johan Hovold <johan@kernel.org>
To:     sven@svenschwermer.de
Cc:     linux-usb@vger.kernel.org,
        Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] usb: serial: option: Add Fibocom L610 modem
Message-ID: <YnO3uY3XfIhK30td@hovoldconsulting.com>
References: <20220425143450.44886-1-sven@svenschwermer.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220425143450.44886-1-sven@svenschwermer.de>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 04:34:49PM +0200, sven@svenschwermer.de wrote:
> From: Sven Schwermer <sven.schwermer@disruptive-technologies.com>
> 
> The L610 modem has 3 USB configurations that are configurable via the AT
> command AT+GTUSBMODE={31,32,33} which make the modem enumerate with the
> following interfaces, respectively:
> 
> 31: Modem + NV + MOS + Diag + LOG + AT + AT
> 32: ECM + Modem + NV + MOS + Diag + LOG + AT + AT
> 33: RNDIS + Modem + NV + MOS + Diag + LOG + AT + AT
> 
> A detailed description of the USB configuration for each mode follows:

[...]

> Signed-off-by: Sven Schwermer <sven.schwermer@disruptive-technologies.com>
> ---
> V2 -> V3: Add this changelog
> V1 -> V2: Use USB_DEVICE_INTERFACE_CLASS, add comments

Perfect, thanks for the update!

>  drivers/usb/serial/option.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
> index e7755d9cfc61..e0af45e3a6f7 100644
> --- a/drivers/usb/serial/option.c
> +++ b/drivers/usb/serial/option.c
> @@ -2111,6 +2111,8 @@ static const struct usb_device_id option_ids[] = {
>  	  .driver_info = RSVD(3) },
>  	{ USB_DEVICE(0x1508, 0x1001),						/* Fibocom NL668 (IOT version) */
>  	  .driver_info = RSVD(4) | RSVD(5) | RSVD(6) },
> +	{ USB_DEVICE(0x1782, 0x4d10) },						/* Fibocom L610 (AT mode) */
> +	{ USB_DEVICE_INTERFACE_CLASS(0x1782, 0x4d11, 0xff) },			/* Fibocom L610 (ECM/RNDIS mode) */
>  	{ USB_DEVICE(0x2cb7, 0x0104),						/* Fibocom NL678 series */
>  	  .driver_info = RSVD(4) | RSVD(5) },
>  	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x0105, 0xff),			/* Fibocom NL678 series */

Both patches now applied.

Johan
