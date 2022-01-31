Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 364A74A3FEB
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 11:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357925AbiAaKQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 05:16:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbiAaKQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 05:16:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05757C061714;
        Mon, 31 Jan 2022 02:16:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C2D6FB82A3F;
        Mon, 31 Jan 2022 10:16:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91726C340E8;
        Mon, 31 Jan 2022 10:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643624199;
        bh=/VMRr+Uvx+0OjZaOltpAAKFoeL3f/6ono7RTW4UxRpM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VZL48Y8FgYXfXaoVfrXgjU3ltIT0qdKwwfcjYJzyNo1WVOf0YiKAWAnM4qsknH0DR
         ujPWcp9zMbcAPXIc++dE2C+MY0fG+AVxuRSqgeB3PhH3Y42v7nqhR3GP6WWWlLl5Qc
         xLoSHL287QR4f2FtXpEqNHQN1lbQ2vrp1Se8grUOBs5Me5hCcEfKgj+d+MIM5rBF/J
         clJGSTTUuNwMfHuot6UWk3nVmnb/e8ndHtCF/VPulTTblJU6Dxd+CCXfdF4hK1Q85b
         cUxsyox/GROVSSK821ioin9J/753iIjxFm+3Wnp4XOLgmuUVeYSh8S3CF+irOf7/Td
         v1l8Ne9Za8+tQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nETjU-0002Ak-3m; Mon, 31 Jan 2022 11:16:24 +0100
Date:   Mon, 31 Jan 2022 11:16:24 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Peter Robinson <pbrobinson@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] gnss: usb: add support for U-Blox NEO-M9N
Message-ID: <Yfe2+KM3c3Vo7y9L@hovoldconsulting.com>
References: <20211227012357.788966-1-pbrobinson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211227012357.788966-1-pbrobinson@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

and sorry about the late reply.

On Mon, Dec 27, 2021 at 01:23:57AM +0000, Peter Robinson wrote:
> Add support for the USB interface of the SparkFun NEO-M9N
> GPS Breakout receiver.
> 
> Bus 001 Device 005: ID 1546:01a9 U-Blox AG u-blox GNSS receiver
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               1.10
>   bDeviceClass            2 Communications
>   bDeviceSubClass         0
>   bDeviceProtocol         0
>   bMaxPacketSize0        64
>   idVendor           0x1546 U-Blox AG
>   idProduct          0x01a9
>   bcdDevice            4.04
>   iManufacturer           1 u-blox AG - www.u-blox.com
>   iProduct                2 u-blox GNSS receiver
>   iSerial                 0
>   bNumConfigurations      1
>   Configuration Descriptor:
>     bLength                 9
>     bDescriptorType         2
>     wTotalLength       0x003e
>     bNumInterfaces          2
>     bConfigurationValue     1
>     iConfiguration          0
>     bmAttributes         0xc0
>       Self Powered
>     MaxPower                0mA
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        0
>       bAlternateSetting       0
>       bNumEndpoints           1
>       bInterfaceClass         2 Communications
>       bInterfaceSubClass      2 Abstract (modem)
>       bInterfaceProtocol      1 AT-commands (v.25ter)
>       iInterface              0
>       CDC Header:
>         bcdCDC               1.10
>       CDC ACM:
>         bmCapabilities       0x02
>           line coding and serial state
>       CDC Call Management:
>         bmCapabilities       0x03
>           call management
>           use DataInterface
>         bDataInterface          1
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x83  EP 3 IN
>         bmAttributes            3
>           Transfer Type            Interrupt
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0040  1x 64 bytes
>         bInterval             255
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        1
>       bAlternateSetting       0
>       bNumEndpoints           2
>       bInterfaceClass        10 CDC Data
>       bInterfaceSubClass      0
>       bInterfaceProtocol    255 Vendor specific
>       iInterface              0
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x01  EP 1 OUT
>         bmAttributes            2
>           Transfer Type            Bulk
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0040  1x 64 bytes
>         bInterval               0
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x82  EP 2 IN
>         bmAttributes            2
>           Transfer Type            Bulk
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0040  1x 64 bytes
>         bInterval               0
> Device Status:     0x0001
>   Self Powered
> 
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
> Cc: Johan Hovold <johan@kernel.org>
> ---
> Hi Johan,
> 
> I've tested your GNSS USB series with a pair of U-Blox devices, adding
> the above USB ID. Only one included here for feedback to guage your thoughts.
> By defauly The U-Blox devices enumerate with the CDC ACM driver and output
> NMEA data via /dev/ttyACM0. With this patch and cdc_acm blocked I get
> /dev/gnss0 and can cat it to get NMEA data. Is your expectation to move
> these sort of devices over to the usb gnss driver too?

Thanks for testing.

I also used u-blox receiver when developing the USB support, but
enabling support for these devices properly would require adding a few
more missing bits, including blacklisting the corresponding ids in
cdc-acm.

I think I'll look into doing this, but I'm currently quite short on
time.

I'll keep you posted.

Johan
