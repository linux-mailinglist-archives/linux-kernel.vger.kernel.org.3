Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7327252B97A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 14:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236144AbiERMCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 08:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236173AbiERMCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 08:02:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90509506F7;
        Wed, 18 May 2022 05:02:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 00E8EB81F42;
        Wed, 18 May 2022 12:02:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF457C385AA;
        Wed, 18 May 2022 12:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652875326;
        bh=MUbcHyQvv4dKox4JvbJ9+1DW+Nh6qIMepCc4FfqqfAw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PEmdBxk/e5GBr4sSDUcpugXeOGnfB/84yii14TZBHW9oPMQAt9sXZ5fja/mOxEU7J
         9wK3zFQwnrerUloQExGoKxMH3Dtk5c13Bn2ReaAK8AHXggDElnQzDXz9c9Nq3WbMR/
         216tmL2URNKSrLroymJr41qTZIvuBDTSK+Uvk8fnY1IZbB24uKxkjQ7zexNrdBJgHi
         eTtz52uKRkdofCpID3CBkPy8eODDmQeG6FveGvnCqYrWyUjfKf+iVOMcnF7daxzgkr
         sC0ZluZnCZlmhg7pDpQC4lExVQUkOYQ/r8LXVA/YwfnhLPGFRkaRIJur4RFh2Flcdp
         UTBoPICZK7BmA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nrINT-0003lM-Kr; Wed, 18 May 2022 14:02:07 +0200
Date:   Wed, 18 May 2022 14:02:07 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Carl =?utf-8?B?WWluKOaut+W8oOaIkCk=?= <carl.yin@quectel.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rspmn@arcor.de" <rspmn@arcor.de>
Subject: Re: [PATCH v2] USB: serial: option: add Quectel BG95 modem
Message-ID: <YoTgP34e2TPr2+Go@hovoldconsulting.com>
References: <TYZPR06MB42705166FACD6C4CD4AF9C0E86D19@TYZPR06MB4270.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYZPR06MB42705166FACD6C4CD4AF9C0E86D19@TYZPR06MB4270.apcprd06.prod.outlook.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 01:04:10AM +0000, Carl Yin(殷张成) wrote:
> The BG95 modem has 3 USB configurations that are configurable via the AT
> command AT+QCFGEXT="usbnet",["ecm"|"modem"|"rmnet"] which make the modem
> enumerate with the following interfaces, respectively:
> 
> "modem": Diag + GNSS + Modem + Modem
> "ecm"  : Diag + GNSS + Modem + ECM
> "rmnet": Diag + GNSS + Modem + QMI
> 
> A detailed description of the USB configuration for each mode follows:

Thanks for updating the commit message and including rmnet.

> Signed-off-by: Carl Yin <carl.yin@quectel.com>
> ---
> 
> v2:
> add at+qcfgext="usbnet","rmnet" and RSVD(3)
> ---
>  drivers/usb/serial/option.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
> index 152ad8826..21fb8da43 100644
> --- a/drivers/usb/serial/option.c
> +++ b/drivers/usb/serial/option.c
> @@ -256,6 +256,7 @@ static void option_instat_callback(struct urb *urb);
>  #define QUECTEL_PRODUCT_RM500Q			0x0800
>  #define QUECTEL_PRODUCT_EC200S_CN		0x6002
>  #define QUECTEL_PRODUCT_EC200T			0x6026
> +#define QUECTEL_PRODUCT_BG95			0x0700

But you seemed to have miss my other comments. These defines should
remain sorted numerically by PID.

>  #define CMOTECH_VENDOR_ID			0x16d8
>  #define CMOTECH_PRODUCT_6001			0x6001
> @@ -1143,6 +1144,10 @@ static const struct usb_device_id option_ids[] = {
>  	  .driver_info = ZLP },
>  	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EC200S_CN, 0xff, 0, 0) },
>  	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EC200T, 0xff, 0, 0) },
> +	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_BG95, 0xff, 0xff, 0xff),
> +	  .driver_info = RSVD(3) | ZLP },
> +	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_BG95, 0xff, 0xfe, 0xff),
> +	  .driver_info = ZLP },

And here it looks like you should be able to just have a single entry
using USB_DEVICE_INTERFACE_CLASS().

>  	{ USB_DEVICE(CMOTECH_VENDOR_ID, CMOTECH_PRODUCT_6001) },
>  	{ USB_DEVICE(CMOTECH_VENDOR_ID, CMOTECH_PRODUCT_CMU_300) },

Johan
