Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5764E552C40
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 09:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347805AbiFUHl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 03:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347919AbiFUHlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 03:41:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A852E140AE;
        Tue, 21 Jun 2022 00:41:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 478676144D;
        Tue, 21 Jun 2022 07:41:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A953DC3411D;
        Tue, 21 Jun 2022 07:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655797302;
        bh=xHrJEBMzMAaB/yf3L0nRdLkzzYcCFC+/oWPA8LkrBrc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MPg6lskTYBxqWfZR+Rmf32dlWTI6IXzpNKe8pqs0dZeQas50a3nfc+PA2FwPGQNtx
         zX86Uk3+S29hLX0MwN6gQnM8MgLaDFiQsJefNd7b+LWJFJZw9TK1Ou6hUpKNOqEaH6
         Tf7gzvq9oNlnWO5wkbTm20qpxtGUcD69IZiyMLhuEdNEi+BKVV3O3aq62QoCxe6zYM
         g2iOfdvlR/cY9uHNtyjfCNuYB5o7Zm53KLektfBbnY1qrmiXtB466FTXBZ2Dg976K6
         2uFHEpKn/KeVQZv+3oLegTZlsYSOn5w/2/+iLK1BGgJX+0Uw7f0nO93Mf4nM7fNB0a
         G0rPTfai6hTTA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1o3YVz-0005ab-SL; Tue, 21 Jun 2022 09:41:36 +0200
Date:   Tue, 21 Jun 2022 09:41:35 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Yonglin Tan <yonglin.tan@outlook.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] USB: serial: option: add Quectel EM05-G modem
Message-ID: <YrF2LxpeUR5Sk1tR@hovoldconsulting.com>
References: <MEYP282MB237401279FB031848505EFB2FDB39@MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MEYP282MB237401279FB031848505EFB2FDB39@MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 10:31:52AM +0800, Yonglin Tan wrote:
> The EM05-G modem has 2 USB configurations that are configurable via the AT
> command AT+QCFG="usbnet",[ 0 | 2 ] which make the modem enumerate with
> the following interfaces, respectively:
> 
> "RMNET"	: AT + DIAG + NMEA + Modem + QMI
> "MBIM"	: MBIM + AT + DIAG + NMEA + Modem
> 
> The detailed description of the USB configuration for each mode as follows:
> 
> RMNET Mode
> --------------
> T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#= 21 Spd=480  MxCh= 0
> D:  Ver= 2.00 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=2c7c ProdID=030a Rev= 3.18
> S:  Manufacturer=Quectel
> S:  Product=Quectel EM05-G
> C:* #Ifs= 5 Cfg#= 1 Atr=a0 MxPwr=500mA
> I:* If#= 3 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
> E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=83(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=85(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> E:  Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 5 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=87(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> E:  Ad=86(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 6 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
> E:  Ad=89(I) Atr=03(Int.) MxPS=   8 Ivl=32ms
> E:  Ad=88(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> 
> MBIM Mode
> --------------
> T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#= 16 Spd=480  MxCh= 0
> D:  Ver= 2.00 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=2c7c ProdID=030a Rev= 3.18
> S:  Manufacturer=Quectel
> S:  Product=Quectel EM05-G
> C:* #Ifs= 6 Cfg#= 1 Atr=a0 MxPwr=500mA
> A:  FirstIf#= 0 IfCount= 2 Cls=02(comm.) Sub=0e Prot=00
> I:* If#= 3 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
> E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=83(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=85(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> E:  Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 5 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=87(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> E:  Ad=86(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 0 Alt= 0 #EPs= 1 Cls=02(comm.) Sub=0e Prot=00 Driver=cdc_mbim
> E:  Ad=89(I) Atr=03(Int.) MxPS=  64 Ivl=32ms
> I:  If#= 1 Alt= 0 #EPs= 0 Cls=0a(data ) Sub=00 Prot=02 Driver=cdc_mbim
> I:* If#= 1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=02 Driver=cdc_mbim
> E:  Ad=88(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> 
> Signed-off-by: Yonglin Tan <yonglin.tan@outlook.com>
> ---
> V2:
>  1. Add the description of the usb interface configurations.
>  2. Add QMI Interface description.

Thanks for the update.

It looks like you missed my comment about moving the entry to where the
other Quectel entries with numerical PIDs are (sorted by PID) and moving
the comment to the first line of the entry.

> 
>  drivers/usb/serial/option.c | 2 ++
>  1 file changed, 2 insertions(+)
>  mode change 100644 => 100755 drivers/usb/serial/option.c

You also should not change the execute permission bits on this file.

> diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
> old mode 100644
> new mode 100755
> index ed1e50d..05fc322
> --- a/drivers/usb/serial/option.c
> +++ b/drivers/usb/serial/option.c
> @@ -1147,6 +1147,8 @@ static const struct usb_device_id option_ids[] = {
>  	  .driver_info = ZLP },
>  	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EC200S_CN, 0xff, 0, 0) },
>  	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EC200T, 0xff, 0, 0) },
> +	{ USB_DEVICE_INTERFACE_CLASS(QUECTEL_VENDOR_ID, 0x030a, 0xff),
> +	  .driver_info = RSVD(6) | ZLP }, /* EM05-G */
>  
>  	{ USB_DEVICE(CMOTECH_VENDOR_ID, CMOTECH_PRODUCT_6001) },
>  	{ USB_DEVICE(CMOTECH_VENDOR_ID, CMOTECH_PRODUCT_CMU_300) },

Could you fix that up in a v3?

Johan
