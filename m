Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 842E448BA68
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 23:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345404AbiAKWE2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 11 Jan 2022 17:04:28 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:45194 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245547AbiAKWE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 17:04:27 -0500
Received: from smtpclient.apple (p4fefca45.dip0.t-ipconnect.de [79.239.202.69])
        by mail.holtmann.org (Postfix) with ESMTPSA id 26819CECD0;
        Tue, 11 Jan 2022 23:04:25 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [BUG] Slow bluetooth speed on Apple MacBook Pro 16,1
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20211228055353.1b4c09e9@localhost>
Date:   Tue, 11 Jan 2022 23:04:24 +0100
Cc:     Aditya Garg <gargaditya08@live.com>,
        Johan Hedberg <johan.hedberg@intel.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "admin@kodeit.net" <admin@kodeit.net>
Content-Transfer-Encoding: 8BIT
Message-Id: <512C8B97-C830-4561-BA66-9581F84D7BB3@holtmann.org>
References: <3352A23E-EA42-4366-BBAA-459CEAE6F51B@live.com>
 <20211228055353.1b4c09e9@localhost>
To:     Orlando Chamberlain <redecorating@protonmail.com>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Orlando,

>> The file transfer speed on MacBook Pro 16,1 from an Android device to
>> Mac is too slow even if I transfer a file of a few Kbs. In case of a
>> transfer from Mac to my Android device, it simply fails.
>> 
>> Some logs that might be helpful :-
>> 
>> -- Logs begin at Fri 2021-11-26 21:34:04 IST, end at Tue 2021-12-28 08:38:16 IST. --
>> Dec 28 08:28:29 MacBook kernel: Bluetooth: Core ver 2.22
>> Dec 28 08:28:29 MacBook kernel: NET: Registered PF_BLUETOOTH protocol family
>> Dec 28 08:28:29 MacBook kernel: Bluetooth: HCI device and connection manager initialized
>> Dec 28 08:28:29 MacBook kernel: Bluetooth: HCI socket layer initialized
>> Dec 28 08:28:29 MacBook kernel: Bluetooth: L2CAP socket layer initialized
>> Dec 28 08:28:29 MacBook kernel: Bluetooth: SCO socket layer initialized
>> Dec 28 08:28:29 MacBook kernel: Bluetooth: HCI UART driver ver 2.3
>> Dec 28 08:28:29 MacBook kernel: Bluetooth: HCI UART protocol H4 registered
>> Dec 28 08:28:29 MacBook kernel: Bluetooth: HCI UART protocol BCSP registered
>> Dec 28 08:28:29 MacBook kernel: Bluetooth: HCI UART protocol LL registered
>> Dec 28 08:28:29 MacBook kernel: Bluetooth: HCI UART protocol ATH3K registered
>> Dec 28 08:28:29 MacBook kernel: Bluetooth: HCI UART protocol Three-wire (H5) registered
>> Dec 28 08:28:29 MacBook kernel: Bluetooth: HCI UART protocol Intel registered
>> Dec 28 08:28:29 MacBook kernel: Bluetooth: HCI UART protocol Broadcom registered
>> Dec 28 08:28:29 MacBook kernel: Bluetooth: HCI UART protocol QCA registered
>> Dec 28 08:28:29 MacBook kernel: Bluetooth: HCI UART protocol AG6XX registered
>> Dec 28 08:28:29 MacBook kernel: Bluetooth: HCI UART protocol Marvell registered
>> Dec 28 08:28:29 MacBook kernel: Bluetooth: hci0: BCM: failed to write update baudrate (-16)
>> Dec 28 08:28:29 MacBook kernel: Bluetooth: hci0: Failed to set baudrate
> 
> When it fails to set baud rate, btmon has the following:
> 
> < HCI Command: Broadcom Update UART Baud Rate (0x3f|0x0018) plen 6 
>        Encoded baud rate: Not used (0x0000)
>        Explicit baud rate: 3000000 Mbps
>> HCI Event: Command Complete (0x0e) plen 4                        
>      Broadcom Update UART Baud Rate (0x3f|0x0018) ncmd 1
>        Status: Command Disallowed (0x0c)
> 
> Not sure if this means the command is unsupported by this chip, or if an "Encoded
> baud rate" needs to be specified.

I think that I remember that the to be used baud rate is inside ACPI and that the Broadcom chip inside the MacBooks don’t support baud rate change and just start out at the appropriate rate in the first place. Then again, I don’t have a MacBook running Linux and thus can verify this.

Actually I would start by dumping the ACPI tables and see if the resources for the UART are listed correctly.

Regards

Marcel

