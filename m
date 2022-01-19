Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 804964937A4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 10:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353130AbiASJot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 04:44:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353118AbiASJos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 04:44:48 -0500
Received: from mx.msync.work (mx.msync.work [IPv6:2a01:4f9:2b:2dc2::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E69EC061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 01:44:48 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2581F268DE1;
        Wed, 19 Jan 2022 09:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
        t=1642585484; h=from:subject:date:message-id:to:cc:mime-version:content-type:
         content-transfer-encoding:content-language:in-reply-to:references:
         disposition-notification-to; bh=9/eVGmOIV/oivfsHMmjhRHKvLdXI2EOqqyAI5/Fn9o8=;
        b=Ma6JDhP7gn5zvQiHkgLJUOJw3XqcXv8cjotmm0ATM8DOmkZPLcIkjv5Wc0RERim0ue3kri
        mOI/wwf7TWkYWFD8y64V6g1McUhCvU1IPkgusm20Q30DqWviW0XIiiA8mHp4MAq0rFEObK
        MHF17rXoJ0/SorZFzC/ObJJZHyUshRtD1rcAQfzHGxGj4+hen3WW1LYLCEWNDd9aTZLDnR
        pa7s1IDjJHpa4X+QANH35pGxZHar/7WHdmbZ0bOBIRWxvdqVGW2bMxqXmF0f6Uk9o+r+ED
        g8cpYkOmPAJlHtswMEBJ7HdnO/CJppQ9O8Rv0CeLkQ8TCYX1U5oQd4zruqaEGg==
Subject: Re: [PATCH v3 1/2] Bluetooth: btrtl: Add support for RTL8822C hci_ver
 0x08
To:     Rudi Heitbaum <rudi@heitbaum.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211027091416.1577668-1-adeep@lexina.in>
 <20211027091416.1577668-2-adeep@lexina.in> <20220119090140.GA24@4f18b3450899>
From:   Vyacheslav <adeep@lexina.in>
Message-ID: <6c73a271-01a3-6616-35ae-6db3f86538a3@lexina.in>
Date:   Wed, 19 Jan 2022 12:44:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20220119090140.GA24@4f18b3450899>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
Thanks for reply

19.01.2022 12:01, Rudi Heitbaum wrote:
 > On Wed, Oct 27, 2021 at 12:14:15PM +0300, Vyacheslav Bocharov wrote:
 >> Add detection of RTL8822CS controller with hci_ver = 0x08
 >>
 >> Signed-off-by: Vyacheslav Bocharov <adeep@lexina.in>
 >> ---
 >>   drivers/bluetooth/btrtl.c | 7 +++++++
 >>   1 file changed, 7 insertions(+)
 >>
 >> diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
 >> index c2bdd1e6060e..38d547cc6fcd 100644
 >> --- a/drivers/bluetooth/btrtl.c
 >> +++ b/drivers/bluetooth/btrtl.c
 >> @@ -156,6 +156,13 @@ static const struct id_table ic_id_table[] = {
 >>   	  .fw_name  = "rtl_bt/rtl8822cs_fw.bin",
 >>   	  .cfg_name = "rtl_bt/rtl8822cs_config" },
 >>
 >> +	/* 8822C with UART interface */
 >> +	{ IC_INFO(RTL_ROM_LMP_8822B, 0xc, 0x8, HCI_UART),
 >> +	  .config_needed = true,
 >> +	  .has_rom_version = true,
 >> +	  .fw_name  = "rtl_bt/rtl8822cs_fw.bin",
 >> +	  .cfg_name = "rtl_bt/rtl8822cs_config" },
 >> +
 >>   	/* 8822C with USB interface */
 >>   	{ IC_INFO(RTL_ROM_LMP_8822B, 0xc, 0xa, HCI_USB),
 >>   	  .config_needed = false,
 >
 > Hi Vyacheslav,
 >
 > Could I make a suggestion rebasing this patch against 5.16 and putting
 > the UART hci ver 0008 berore 000aI recently submitted a v4 patch with 
the .has_msft_ext added based on bluetooth-next, but without the correct 
order.
https://patchwork.kernel.org/project/bluetooth/list/?series=606500
Maybe the order of the lines is not so important?)

 >
 > this has been tested on Tanix TX6.also tested on JetHome JetHub H1 
and applied to Armbian patchset 
(https://github.com/armbian/build/pull/3201).

Also need to update the firmware in linux-firmware, the correct binaries 
are in armbian-firmware.

 >
 > Before:
 >
 > [   11.512883] Bluetooth: hci0: RTL: examining hci_ver=08 
hci_rev=000c lmp_ver=08 lmp_subver=8822
 > [   11.512940] Bluetooth: hci0: RTL: unknown IC info, lmp subver 
8822, hci rev 000c, hci ver 0008
 > [   11.512957] Bluetooth: hci0: RTL: no config loaded
 >
 > After:
 >
 > [   12.642167] Bluetooth: hci0: RTL: examining hci_ver=08 
hci_rev=000c lmp_ver=08 lmp_subver=8822
 > [   12.671911] Bluetooth: hci0: RTL: rom_version status=0 version=3
 > [   12.671961] Bluetooth: hci0: RTL: loading rtl_bt/rtl8822cs_fw.bin
 > [   12.706248] Bluetooth: hci0: RTL: loading rtl_bt/rtl8822cs_config.bin
 > [   12.730251] Bluetooth: hci0: RTL: cfg_sz 33, total sz 40737
 > [   13.318832] Bluetooth: hci0: RTL: fw version 0x05a91a4a
 >
 > Tested-by: Rudi Heitbaum <rudi@heitbaum.com>
 >
 > ---
 >   drivers/bluetooth/btrtl.c | 10 +++++++++-
 >   1 file changed, 9 insertions(+), 1 deletion(-)
 >
 > diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
 > --- a/drivers/bluetooth/btrtl.c	2022-01-09 22:55:34.000000000 +0000
 > +++ b/drivers/bluetooth/btrtl.c	2022-01-15 07:12:21.102080089 +0000
 > @@ -148,7 +148,15 @@
 >   	  .fw_name  = "rtl_bt/rtl8761bu_fw.bin",
 >   	  .cfg_name = "rtl_bt/rtl8761bu_config" },
 >
 > + 	/* 8822C (hci ver 0008) with UART interface */
 > +	{ IC_INFO(RTL_ROM_LMP_8822B, 0xc, 0x8, HCI_UART),
 > +	  .config_needed = true,
 > +	  .has_rom_version = true,
 > +	  .has_msft_ext = true,
 > +	  .fw_name  = "rtl_bt/rtl8822cs_fw.bin",
 > +	  .cfg_name = "rtl_bt/rtl8822cs_config" },
 > +
 > -	/* 8822C with UART interface */
 > +	/* 8822C (hci ver 000a) with UART interface */
 >   	{ IC_INFO(RTL_ROM_LMP_8822B, 0xc, 0xa, HCI_UART),
 >   	  .config_needed = true,
 >   	  .has_rom_version = true,
 > --
 > 2.25.1
 >
--
Vyacheslav
