Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A904D0491
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 17:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244329AbiCGQwo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 7 Mar 2022 11:52:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241267AbiCGQwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 11:52:41 -0500
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 692206AA68;
        Mon,  7 Mar 2022 08:51:47 -0800 (PST)
Received: from smtpclient.apple (p5b3d2910.dip0.t-ipconnect.de [91.61.41.16])
        by mail.holtmann.org (Postfix) with ESMTPSA id 8B1ADCED1A;
        Mon,  7 Mar 2022 17:51:46 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.60.0.1.1\))
Subject: Re: [PATCH v3] Bluetooth: btusb: Add quirk to skip HCI_FLT_CLEAR_ALL
 on fake CSR controllers
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <3b6c7c18-dc48-b924-bd09-3638a5c741a4@gmail.com>
Date:   Mon, 7 Mar 2022 17:51:46 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        BlueZ <linux-bluetooth@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>
Content-Transfer-Encoding: 8BIT
Message-Id: <565ADA56-1DEC-4DF3-9481-A3D535692BB3@holtmann.org>
References: <3b6c7c18-dc48-b924-bd09-3638a5c741a4@gmail.com>
To:     Ismael Ferreras Morezuelas <swyterzone@gmail.com>
X-Mailer: Apple Mail (2.3693.60.0.1.1)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ismael,

> Another subset of the more recent batch of Chinese clones aren't
> specs-compliant and seem to lock up whenever they receive a
> HCI_OP_SET_EVENT_FLT with flt_type set to zero/HCI_FLT_CLEAR_ALL,
> which on Linux (until the recent HCI state-machine refactor) happened
> right at BR/EDR setup. As there are other less-straightforward ways
> of reaching those operations, this patch is still relevant.
> 
> So, while all the previous efforts to wrangle the herd of fake CSRs
> seem to be paying off (and these also get detected as such) we
> still need to take care of this quirk; testers seem to agree
> that these dongles tend to work well enough afterwards.
> 
> From some cursory USB packet capture on Windows it seems like
> that driver doesn't appear to use this clear-all functionality at all.
> 
> This patch was tested on some really popular AliExpress-style
> dongles, in my case marked as "V5.0". Chip markings: UG8413,
> the backside of the PCB says "USB Dangel" (sic).
> 
> Here is the `hciconfig -a` output; for completeness:
> 
> hci0:	Type: Primary  Bus: USB
> 	BD Address: 00:1A:7D:DA:7X:XX  ACL MTU: 679:8  SCO MTU: 48:16
> 	UP RUNNING PSCAN ISCAN
> 	Features: 0xbf 0x3e 0x4d 0xfa 0xdb 0x3d 0x7b 0xc7
> 	Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
> 	Link policy: RSWITCH SNIFF
> 	Link mode: PERIPHERAL ACCEPT
> 	Name: 'CSR8510 A10.'
> 	Class: 0x7c0104
> 	Service Classes: Rendering, Capturing, Object Transfer, Audio, Telephony
> 	Device Class: Computer, Desktop workstation
> 	HCI Version: 4.0 (0x6)  Revision: 0x3120
> 	LMP Version: 4.0 (0x6)  Subversion: 0x22bb
> 	Manufacturer: Cambridge Silicon Radio (10)
> 
> As well as the `lsusb -vv -d 0a12:0001`:
> 
> ID 0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth Dongle (HCI mode)
> Device Descriptor:
>  bLength                18
>  bDescriptorType         1
>  bcdUSB               2.00
>  bDeviceClass          224 Wireless
>  bDeviceSubClass         1 Radio Frequency
>  bDeviceProtocol         1 Bluetooth
>  bMaxPacketSize0        64
>  idVendor           0x0a12 Cambridge Silicon Radio, Ltd
>  idProduct          0x0001 Bluetooth Dongle (HCI mode)
>  bcdDevice           88.91
>  iManufacturer           0
>  iProduct                2 BT DONGLE10
>  iSerial                 0
>  bNumConfigurations      1
> 
> Also, changed the benign dmesg print that shows up whenever the
> generic force-suspend fails from bt_dev_err to bt_dev_warn;
> it's okay and done on a best-effort basis, not a problem
> if that does not work.
> 
> Also, swapped the HCI subver and LMP subver numbers for the Barrot
> in the comment, which I copied wrong the last time around.
> 
> Fixes: 81cac64ba258a ("Bluetooth: Deal with USB devices that are faking CSR vendor")
> Fixes: cde1a8a992875 ("Bluetooth: btusb: Fix and detect most of the Chinese Bluetooth controllers")
> Fixes: d74e0ae7e0303 ("Bluetooth: btusb: Fix detection of some fake CSR controllers with a bcdDevice val of 0x0134")
> Fixes: 0671c0662383e ("Bluetooth: btusb: Add workaround for remote-wakeup issues with Barrot 8041a02 fake CSR controllers")
> Fixes: f4292e2faf522 ("Bluetooth: btusb: Make the CSR clone chip force-suspend workaround more generic")
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=60824
> Link: https://gist.github.com/nevack/6b36b82d715dc025163d9e9124840a07
> 
> Cc: stable@vger.kernel.org
> Cc: Hans de Goede <hdegoede@redhat.com>
> Tested-by: Gonzalo Tornaría <tornaria@cmat.edu.uy>
> Tested-by: Mateus Lemos <lemonsmateus@gmail.com>
> Tested-by: Ismael Ferreras Morezuelas <swyterzone@gmail.com>
> Signed-off-by: Ismael Ferreras Morezuelas <swyterzone@gmail.com>
> ---
> 
> Changes for v3:
>  * Simplified and updated the hci_sync.c code after the state-machine
>    changes; the hci_core.c and hci_request.c parts no longer exist.
> 
>    As requested by Marcel.
> 
>    Funnily enough, the HCI code does not unconditionally send a
>    clear-all anymore on bring-up, so I have received reports of
>    the bug being "fixed" without patching. But there might be
>    more ways of hitting these codepaths in the future as the
>    kernel develops.
> 
>    So yeah, the controller limitation is still there, but
>    doesn't get exercised because we don't do it like that.
> 
>  * Shortened the patch subject, as suggested by Paul Menzel.
> 
> Changes for v2:
>  * Added HCI_QUIRK_NO_SUSPEND_NOTIFIER to btusb_setup_csr().
>    In theory we already disable runtime suspend in btusb, button
>    better safe than sorry. Doesn't hurt to explicitly avoid the
>    hci_suspend_dev() codepath, it also works as example.
>  * Improved the quirk description in hci.h, as suggested by Hans
>    de Goede. Explain the need to disable runtime suspend.
>  * Also check for the quirk in hci_req_set_event_filter();
>    mirror its hci_req_clear_event_filter() counterpart.
>  * The struct hci_dev *hdev variables always go first.
>  * Removed some misc formatting changes.
> 
> drivers/bluetooth/btusb.c   |  6 ++++--
> include/net/bluetooth/hci.h | 10 ++++++++++
> net/bluetooth/hci_sync.c    | 16 ++++++++++++++++
> 3 files changed, 30 insertions(+), 2 deletions(-)

I seem to repeating myself. Change to the core layer and changes to the driver have to be separated.

Regards

Marcel

