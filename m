Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 953F6486B38
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 21:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243849AbiAFUcL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 6 Jan 2022 15:32:11 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:38311 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243793AbiAFUcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 15:32:10 -0500
Received: from smtpclient.apple (p4fefca45.dip0.t-ipconnect.de [79.239.202.69])
        by mail.holtmann.org (Postfix) with ESMTPSA id 9FEFCCECDD;
        Thu,  6 Jan 2022 21:32:08 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH] Bluetooth: btusb: Add a new quirk to skip
 HCI_FLT_CLEAR_ALL on fake CSR controllers
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <6a3f5e8b-fbc1-bad8-aef0-3e2cf9be364e@gmail.com>
Date:   Thu, 6 Jan 2022 21:32:08 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <3BCA0ABD-6BFC-4487-A5DE-3AF043A6ADE0@holtmann.org>
References: <6a3f5e8b-fbc1-bad8-aef0-3e2cf9be364e@gmail.com>
To:     Ismael Ferreras Morezuelas <swyterzone@gmail.com>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ismael,

> Another subset of the more recent batch of Chinese clones aren't
> specs-compliant and seem to lock up whenever they receive a
> HCI_OP_SET_EVENT_FLT with flt_type set to zero/HCI_FLT_CLEAR_ALL,
> which on Linux happens right at BR/EDR setup.
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
> https://bugzilla.kernel.org/show_bug.cgi?id=60824
> https://gist.github.com/nevack/6b36b82d715dc025163d9e9124840a07
> 
> Cc: stable@vger.kernel.org
> Cc: Hans de Goede <hdegoede@redhat.com>
> Tested-by: Gonzalo Tornaría <tornaria@cmat.edu.uy>
> Tested-by: Mateus Lemos <lemonsmateus@gmail.com>
> Tested-by: Ismael Ferreras Morezuelas <swyterzone@gmail.com>
> Signed-off-by: Ismael Ferreras Morezuelas <swyterzone@gmail.com>
> 
> ---
> 
> drivers/bluetooth/btusb.c   | 11 ++++++-----
> include/net/bluetooth/hci.h |  6 ++++++
> net/bluetooth/hci_core.c    | 11 ++++++++---
> net/bluetooth/hci_request.c |  8 ++++++--
> 4 files changed, 26 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 75c83768c..42c909c24 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -1932,6 +1932,7 @@ static int btusb_setup_csr(struct hci_dev *hdev)
> 		 */
> 		set_bit(HCI_QUIRK_BROKEN_STORED_LINK_KEY, &hdev->quirks);
> 		set_bit(HCI_QUIRK_BROKEN_ERR_DATA_REPORTING, &hdev->quirks);
> +		set_bit(HCI_QUIRK_BROKEN_FILTER_CLEAR_ALL, &hdev->quirks);
> 
> 		/* Clear the reset quirk since this is not an actual
> 		 * early Bluetooth 1.1 device from CSR.
> @@ -1942,16 +1943,16 @@ static int btusb_setup_csr(struct hci_dev *hdev)
> 		/*
> 		 * Special workaround for these BT 4.0 chip clones, and potentially more:
> 		 *
> -		 * - 0x0134: a Barrot 8041a02                 (HCI rev: 0x1012 sub: 0x0810)
> +		 * - 0x0134: a Barrot 8041a02                 (HCI rev: 0x0810 sub: 0x1012)

Don’t get this change.

> 		 * - 0x7558: IC markings FR3191AHAL 749H15143 (HCI rev/sub-version: 0x0709)
> 		 *
> 		 * These controllers are really messed-up.
> 		 *
> 		 * 1. Their bulk RX endpoint will never report any data unless
> -		 * the device was suspended at least once (yes, really).
> +		 *    the device was suspended at least once (yes, really).
> 		 * 2. They will not wakeup when autosuspended and receiving data
> -		 * on their bulk RX endpoint from e.g. a keyboard or mouse
> -		 * (IOW remote-wakeup support is broken for the bulk endpoint).
> +		 *    on their bulk RX endpoint from e.g. a keyboard or mouse
> +		 *    (IOW remote-wakeup support is broken for the bulk endpoint).

Fix the style issues separately.

> 		 *
> 		 * To fix 1. enable runtime-suspend, force-suspend the
> 		 * HCI and then wake-it up by disabling runtime-suspend.
> @@ -1971,7 +1972,7 @@ static int btusb_setup_csr(struct hci_dev *hdev)
> 		if (ret >= 0)
> 			msleep(200);
> 		else
> -			bt_dev_err(hdev, "CSR: Failed to suspend the device for our Barrot 8041a02 receive-issue workaround");
> +			bt_dev_warn(hdev, "CSR: Couldn't suspend the device for our Barrot 8041a02 receive-issue workaround");

Why change this?

> 
> 		pm_runtime_forbid(&data->udev->dev);
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 63065bc01..4e5d5979d 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -246,6 +246,12 @@ enum {
> 	 * HCI after resume.
> 	 */
> 	HCI_QUIRK_NO_SUSPEND_NOTIFIER,
> +
> +	/* When this quirk is set, HCI_OP_SET_EVENT_FLT requests with
> +	 * HCI_FLT_CLEAR_ALL are ignored. A subset of the CSR controller
> +	 * clones struggle with this and instantly lock up.
> +	 */
> +	HCI_QUIRK_BROKEN_FILTER_CLEAR_ALL,
> };
> 
> /* HCI device flags */
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 8d33aa648..7af649afc 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -150,6 +150,7 @@ static void bredr_setup(struct hci_request *req)
> {
> 	__le16 param;
> 	__u8 flt_type;
> +	struct hci_dev *hdev = req->hdev;

This should always go first in a function.

> 
> 	/* Read Buffer Size (ACL mtu, max pkt, etc.) */
> 	hci_req_add(req, HCI_OP_READ_BUFFER_SIZE, 0, NULL);
> @@ -169,9 +170,13 @@ static void bredr_setup(struct hci_request *req)
> 	/* Read Current IAC LAP */
> 	hci_req_add(req, HCI_OP_READ_CURRENT_IAC_LAP, 0, NULL);
> 
> -	/* Clear Event Filters */
> -	flt_type = HCI_FLT_CLEAR_ALL;
> -	hci_req_add(req, HCI_OP_SET_EVENT_FLT, 1, &flt_type);
> +	/* Clear Event Filters; some fake CSR controllers lock up after setting
> +	 * this type of filter, so avoid sending the request altogether.
> +	 */
> +	if (!test_bit(HCI_QUIRK_BROKEN_FILTER_CLEAR_ALL, &hdev->quirks)) {
> +		flt_type = HCI_FLT_CLEAR_ALL;
> +		hci_req_add(req, HCI_OP_SET_EVENT_FLT, 1, &flt_type);
> +	}
> 
> 	/* Connection accept timeout ~20 secs */
> 	param = cpu_to_le16(0x7d00);
> diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
> index 92611bfc0..cfcf64c0c 100644
> --- a/net/bluetooth/hci_request.c
> +++ b/net/bluetooth/hci_request.c
> @@ -980,11 +980,15 @@ void hci_req_add_le_passive_scan(struct hci_request *req)
> static void hci_req_clear_event_filter(struct hci_request *req)
> {
> 	struct hci_cp_set_event_filter f;
> +	struct hci_dev *hdev = req->hdev;
> +
> +	if (!hci_dev_test_flag(hdev, HCI_BREDR_ENABLED))
> +		return;
> 
> -	if (!hci_dev_test_flag(req->hdev, HCI_BREDR_ENABLED))
> +	if (test_bit(HCI_QUIRK_BROKEN_FILTER_CLEAR_ALL, &hdev->quirks))
> 		return;
> 
> -	if (hci_dev_test_flag(req->hdev, HCI_EVENT_FILTER_CONFIGURED)) {
> +	if (hci_dev_test_flag(hdev, HCI_EVENT_FILTER_CONFIGURED)) {
> 		memset(&f, 0, sizeof(f));
> 		f.flt_type = HCI_FLT_CLEAR_ALL;
> 		hci_req_add(req, HCI_OP_SET_EVENT_FLT, 1, &f);

This is not enough. If you do not have clear event filter, we need to disable suspend/resume support. These device can for obvious reason not sleep accordingly.

Regards

Marcel

