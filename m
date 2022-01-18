Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B01EA49258B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 13:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241556AbiARMQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 07:16:17 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:57381 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231645AbiARMQQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 07:16:16 -0500
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 0AC9961EA1BE8;
        Tue, 18 Jan 2022 13:16:14 +0100 (CET)
Message-ID: <172a1b38-bc36-059b-4d90-f3afee1b8483@molgen.mpg.de>
Date:   Tue, 18 Jan 2022 13:16:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] Bluetooth: btusb: Add a new quirk to skip
 HCI_FLT_CLEAR_ALL on fake CSR controllers
Content-Language: en-US
To:     Ismael Ferreras Morezuelas <swyterzone@gmail.com>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Marcel Holtmann <marcel@holtmann.org>
References: <4957ed07-36b8-58a0-2307-d2e6e2940527@gmail.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <4957ed07-36b8-58a0-2307-d2e6e2940527@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Ismael,


Thank you for working on fixing these controllers. Just a nit, to make 
the commit message summary a little shorter, you can just write:

Add quirk to skip HCI_FLT_CLEAR_ALL on fake CSR controllers


Am 18.01.22 um 08:14 schrieb Ismael Ferreras Morezuelas:
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
> As well as the `lsusb -vv -d 0a12:0001`:
> 
> ID 0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth Dongle (HCI mode)
> Device Descriptor:
>    bLength                18
>    bDescriptorType         1
>    bcdUSB               2.00
>    bDeviceClass          224 Wireless
>    bDeviceSubClass         1 Radio Frequency
>    bDeviceProtocol         1 Bluetooth
>    bMaxPacketSize0        64
>    idVendor           0x0a12 Cambridge Silicon Radio, Ltd
>    idProduct          0x0001 Bluetooth Dongle (HCI mode)
>    bcdDevice           88.91
>    iManufacturer           0
>    iProduct                2 BT DONGLE10
>    iSerial                 0
>    bNumConfigurations      1
> 
> Also, changed the benign dmesg print that shows up whenever the
> generic force-suspend fails from bt_dev_err to bt_dev_warn;
> it's okay and done on a best-effort basis, not a problem
> if that does not work.

If there are more iterations, you might want to split that one into a 
separate commit.

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

The tags Link and BugLink exist (in `scripts/checkpatch.pl`), and you 
might want to use these tags.

The bug report is from 2013 and talks about a regression upgrading from 
Linux 3.9 to 3.11. Was the bug report repurposed, or is the original 
issue also fixed by your change?

> https://gist.github.com/nevack/6b36b82d715dc025163d9e9124840a07
> 
> Cc: stable@vger.kernel.org
> Cc: Hans de Goede <hdegoede@redhat.com>
> Tested-by: Gonzalo Tornaría <tornaria@cmat.edu.uy>
> Tested-by: Mateus Lemos <lemonsmateus@gmail.com>
> Tested-by: Ismael Ferreras Morezuelas <swyterzone@gmail.com>
> Signed-off-by: Ismael Ferreras Morezuelas <swyterzone@gmail.com>
> ---
> 
> Changes for v2:
>    * Added HCI_QUIRK_NO_SUSPEND_NOTIFIER to btusb_setup_csr().
>      In theory we already disable runtime suspend in btusb, button
>      better safe than sorry. Doesn't hurt to explicitly avoid the
>      hci_suspend_dev() codepath, it also works as example.
>    * Improved the quirk description in hci.h, as suggested by Hans
>      de Goede. Explain the need to disable runtime suspend.
>    * Also check for the quirk in hci_req_set_event_filter();
>      mirror its hci_req_clear_event_filter() counterpart.
>    * The struct hci_dev *hdev variables always go first.
>    * Removed some misc formatting changes.
> 
> The dongles still seem all peachy after the v2 changes. :)
> 
>   drivers/bluetooth/btusb.c   |  6 ++++--
>   include/net/bluetooth/hci.h | 10 ++++++++++
>   net/bluetooth/hci_core.c    | 11 ++++++++---
>   net/bluetooth/hci_request.c | 13 ++++++++++---
>   4 files changed, 32 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 75c83768c..c3bfb9bbe 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -1932,6 +1932,8 @@ static int btusb_setup_csr(struct hci_dev *hdev)
>   		 */
>   		set_bit(HCI_QUIRK_BROKEN_STORED_LINK_KEY, &hdev->quirks);
>   		set_bit(HCI_QUIRK_BROKEN_ERR_DATA_REPORTING, &hdev->quirks);
> +		set_bit(HCI_QUIRK_BROKEN_FILTER_CLEAR_ALL, &hdev->quirks);
> +		set_bit(HCI_QUIRK_NO_SUSPEND_NOTIFIER, &hdev->quirks);
>   
>   		/* Clear the reset quirk since this is not an actual
>   		 * early Bluetooth 1.1 device from CSR.
> @@ -1942,7 +1944,7 @@ static int btusb_setup_csr(struct hci_dev *hdev)
>   		/*
>   		 * Special workaround for these BT 4.0 chip clones, and potentially more:
>   		 *
> -		 * - 0x0134: a Barrot 8041a02                 (HCI rev: 0x1012 sub: 0x0810)
> +		 * - 0x0134: a Barrot 8041a02                 (HCI rev: 0x0810 sub: 0x1012)
>   		 * - 0x7558: IC markings FR3191AHAL 749H15143 (HCI rev/sub-version: 0x0709)
>   		 *
>   		 * These controllers are really messed-up.
> @@ -1971,7 +1973,7 @@ static int btusb_setup_csr(struct hci_dev *hdev)
>   		if (ret >= 0)
>   			msleep(200);
>   		else
> -			bt_dev_err(hdev, "CSR: Failed to suspend the device for our Barrot 8041a02 receive-issue workaround");
> +			bt_dev_warn(hdev, "CSR: Couldn't suspend the device for our Barrot 8041a02 receive-issue workaround");
>   
>   		pm_runtime_forbid(&data->udev->dev);
>   
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 63065bc01..a17b8453a 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -246,6 +246,16 @@ enum {
>   	 * HCI after resume.
>   	 */
>   	HCI_QUIRK_NO_SUSPEND_NOTIFIER,
> +
> +	/* When this quirk is set, HCI_OP_SET_EVENT_FLT requests with
> +	 * HCI_FLT_CLEAR_ALL are ignored and event filtering is
> +	 * completely avoided. A subset of the CSR controller
> +	 * clones struggle with this and instantly lock up.
> +	 *
> +	 * Note that devices using this must (separately) disable
> +	 * runtime suspend, because event filtering takes place there.
> +	 */
> +	HCI_QUIRK_BROKEN_FILTER_CLEAR_ALL,
>   };
>   
>   /* HCI device flags */
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 8d33aa648..51d53c476 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -148,6 +148,7 @@ static int hci_init1_req(struct hci_request *req, unsigned long opt)
>   
>   static void bredr_setup(struct hci_request *req)
>   {
> +	struct hci_dev *hdev = req->hdev;
>   	__le16 param;
>   	__u8 flt_type;
>   
> @@ -169,9 +170,13 @@ static void bredr_setup(struct hci_request *req)
>   	/* Read Current IAC LAP */
>   	hci_req_add(req, HCI_OP_READ_CURRENT_IAC_LAP, 0, NULL);
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
>   	/* Connection accept timeout ~20 secs */
>   	param = cpu_to_le16(0x7d00);
> diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
> index 92611bfc0..c417325fe 100644
> --- a/net/bluetooth/hci_request.c
> +++ b/net/bluetooth/hci_request.c
> @@ -979,12 +979,16 @@ void hci_req_add_le_passive_scan(struct hci_request *req)
>   
>   static void hci_req_clear_event_filter(struct hci_request *req)
>   {
> +	struct hci_dev *hdev = req->hdev;
>   	struct hci_cp_set_event_filter f;
>   
> -	if (!hci_dev_test_flag(req->hdev, HCI_BREDR_ENABLED))
> +	if (!hci_dev_test_flag(hdev, HCI_BREDR_ENABLED))
> +		return;
> +
> +	if (test_bit(HCI_QUIRK_BROKEN_FILTER_CLEAR_ALL, &hdev->quirks))
>   		return;
>   
> -	if (hci_dev_test_flag(req->hdev, HCI_EVENT_FILTER_CONFIGURED)) {
> +	if (hci_dev_test_flag(hdev, HCI_EVENT_FILTER_CONFIGURED)) {
>   		memset(&f, 0, sizeof(f));
>   		f.flt_type = HCI_FLT_CLEAR_ALL;
>   		hci_req_add(req, HCI_OP_SET_EVENT_FLT, 1, &f);
> @@ -993,15 +997,18 @@ static void hci_req_clear_event_filter(struct hci_request *req)
>   
>   static void hci_req_set_event_filter(struct hci_request *req)
>   {
> +	struct hci_dev *hdev = req->hdev;
>   	struct bdaddr_list_with_flags *b;
>   	struct hci_cp_set_event_filter f;
> -	struct hci_dev *hdev = req->hdev;
>   	u8 scan = SCAN_DISABLED;
>   	bool scanning = test_bit(HCI_PSCAN, &hdev->flags);
>   
>   	if (!hci_dev_test_flag(hdev, HCI_BREDR_ENABLED))
>   		return;
>   
> +	if (test_bit(HCI_QUIRK_BROKEN_FILTER_CLEAR_ALL, &hdev->quirks))
> +		return;
> +
>   	/* Always clear event filter when starting */
>   	hci_req_clear_event_filter(req);
>   

Acked-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
