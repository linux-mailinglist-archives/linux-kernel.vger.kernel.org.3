Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75DB64BE15E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348417AbiBUJ1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 04:27:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348809AbiBUJUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 04:20:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2001340FD;
        Mon, 21 Feb 2022 01:07:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 55AF0611D0;
        Mon, 21 Feb 2022 09:07:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6806C340F1;
        Mon, 21 Feb 2022 09:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645434458;
        bh=ZzDL3b2R2zK8e9c5lboDQVpGxcxRvRsX/D5OltykcNQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YBNmfx/8bxtTm/uF3GwG7r1Z0cSJ7PiXf9cabrefPXoRxEKlej9SA4EEKYvsUlKfE
         S2mrqtenCZ3OlgFd+Nl/M9eeiCogh3+tNCE+Wad38jzmXWDDqX6tLDjxKPYSE5YhKn
         +/8hpSw2RhIgoeigTD+pF1XoFFeNdWPZNhUpGrpqUoA6criwArcm66h9VfqmzZK6It
         Pw+WsdIlnCNqDQYOr7zF5sCVOR49sdkZJ1OJLjwQAZP1X9WiUS51qtX/v+X7aJmkvU
         ByzT+f1fIuHXLv7DSwcrRJLMAVT0ZVKdx8k2IBANoeqSO/+nupsgH41lCbj61Ikqol
         bRHuL9SNGky0g==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nM4fP-0004xn-Rs; Mon, 21 Feb 2022 10:07:35 +0100
Date:   Mon, 21 Feb 2022 10:07:35 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Slark Xiao <slark_xiao@163.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] USB: serial: option: add support for DW5829e
Message-ID: <YhNWV5lXm0d7lyfL@hovoldconsulting.com>
References: <20220209031535.9668-1-slark_xiao@163.com>
 <YgPPNVzyg7Gypzv9@hovoldconsulting.com>
 <62feaf3.248f.17ee1ac3017.Coremail.slark_xiao@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62feaf3.248f.17ee1ac3017.Coremail.slark_xiao@163.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 11:27:45AM +0800, Slark Xiao wrote:
> At 2022-02-09 22:27:01, "Johan Hovold" <johan@kernel.org> wrote:
> >On Wed, Feb 09, 2022 at 11:15:35AM +0800, Slark Xiao wrote:

> >> DW5829e RMNET mode:
> >> T:  Bus=04 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  5 Spd=5000 MxCh= 0
> >> D:  Ver= 3.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS= 9 #Cfgs=  1
> >> P:  Vendor=413c ProdID=81e6 Rev=03.18
> >> S:  Manufacturer=Dell Inc.
> >> S:  Product=DW5829e Snapdragon X20 LTE
> >> S:  SerialNumber=0123456789ABCDEF
> >> C:  #Ifs= 6 Cfg#= 1 Atr=a0 MxPwr=896mA
> >> I:  If#=0x0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=qmi_wwan
> >> I:  If#=0x1 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=00 Prot=00 Driver=usbhid
> >> I:  If#=0x2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> >> I:  If#=0x3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> >> I:  If#=0x4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> >> I:  If#=0x5 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option

> >> DW5829e-eSIM RMNET mode:
> >> T:  Bus=04 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  7 Spd=5000 MxCh= 0
> >> D:  Ver= 3.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS= 9 #Cfgs=  1
> >> P:  Vendor=413c ProdID=81e4 Rev=03.18
> >> S:  Manufacturer=Dell Inc.
> >> S:  Product=DW5829e-eSIM Snapdragon X20 LTE
> >> S:  SerialNumber=0123456789ABCDEF
> >> C:  #Ifs= 6 Cfg#= 1 Atr=a0 MxPwr=896mA
> >> I:  If#=0x0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=qmi_wwan
> >> I:  If#=0x1 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=00 Prot=00 Driver=usbhid
> >> I:  If#=0x2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> >> I:  If#=0x3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> >> I:  If#=0x4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> >> I:  If#=0x5 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option

> >>  #define KYOCERA_VENDOR_ID			0x0c88
> >>  #define KYOCERA_PRODUCT_KPC650			0x17da
> >> @@ -1063,6 +1065,10 @@ static const struct usb_device_id option_ids[] = {
> >>  	  .driver_info = RSVD(0) | RSVD(1) | RSVD(6) },
> >>  	{ USB_DEVICE(DELL_VENDOR_ID, DELL_PRODUCT_5821E_ESIM),
> >>  	  .driver_info = RSVD(0) | RSVD(1) | RSVD(6) },
> >> +	{ USB_DEVICE_INTERFACE_CLASS(DELL_VENDOR_ID, DELL_PRODUCT_5829E, 0xff),
> >> +	  .driver_info = RSVD(6) },
> >> +	{ USB_DEVICE_INTERFACE_CLASS(DELL_VENDOR_ID, DELL_PRODUCT_5829E_ESIM, 0xff),
> >> +	  .driver_info = RSVD(6) },
> >
> >It looks like these entries will cause the driver to bind also to the
> >QMI port however.
> >

> Actually not,  currently RMNET port would load the qmi_wwan driver
> successfully even the class of QMI is also 0xff.

That's not guaranteed so RMNET mode could break depending on probe
order with the above entries.

> Do you mean I should add RSVD(0) to reduce confusion?

You need to reserve it for correctness (or restructure the entries in
some other way to achieve the same result).
 
> >>  	{ USB_DEVICE(ANYDATA_VENDOR_ID, ANYDATA_PRODUCT_ADU_E100A) },	/* ADU-E100, ADU-310 */
> >>  	{ USB_DEVICE(ANYDATA_VENDOR_ID, ANYDATA_PRODUCT_ADU_500A) },
> >>  	{ USB_DEVICE(ANYDATA_VENDOR_ID, ANYDATA_PRODUCT_ADU_620UW) },

Johan
