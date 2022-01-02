Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F01484828F1
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 03:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbiABCn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jan 2022 21:43:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiABCny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jan 2022 21:43:54 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E4DFC061574;
        Sat,  1 Jan 2022 18:43:54 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id t26so62977885wrb.4;
        Sat, 01 Jan 2022 18:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :content-language:content-transfer-encoding;
        bh=WPR1G1FyE4wP1j6iKLhKP0CqfhOh7512yq7d8Tc3Pk8=;
        b=Muuu3+Taxe6/iPVwro3NuwXrETIA1Vufehq/XV5017C1GmiHVaGEN7wud5/RHV3h8a
         VLFKyl1tUqXtXMQVTTVFPpiQJXoWPoEj+ExQ91P3QxSP9C2UJtjM1nF+TF+imNBosVaR
         Cp/gClDBMBJAyXPRQMXJ8Ymf4w2YRA33w1CMBTeG0/WSeYFqrf1C5O1vLFGzz93VSB7G
         GIdoikQmZwswP6sXdumLElemflElb8+7z4PChnMFayAONWCNIKRlKWYw9Wk6pQ1nafF3
         gDrXOfZYaQfvEkhvLU5wY0hSK8vI+vOPU08kAo+zs+VzgJTTVx12RGvno2MpyKwO5Nm+
         38DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:content-language:content-transfer-encoding;
        bh=WPR1G1FyE4wP1j6iKLhKP0CqfhOh7512yq7d8Tc3Pk8=;
        b=vxht6T5hxtRDYYJneJH+SzZt0lEgarqJ5XuHRZUuGsfhphcMxbTeIO8XTdKlb4RxeP
         vQnZBR1n6JjTaMjwcEzcuw/r49sKNX4V1Hfq/DtFQa+f16JcqsYNBaufSkbEXBamXMWw
         pKwHZOAOL0uNBsM1RNmROcEo1BsOSXczP0b5X/1TFMJwSUH/nbYGYWzYbyxb1TSwYvCj
         SriQ9sQYFi1tCePE74mS/wXNcidZ0JypmgkrE56hZn1wftEnh7A6QoWc1+hYd19a3fGF
         7jLM/EQ0QGEIrKUVOGHjy6IO74KZlZibT9v6Wyd0T7jlGA4yzeZXNzx/UGnv7KCkmdHZ
         IMiQ==
X-Gm-Message-State: AOAM530ShYsBwXkD4gYDzr6Zahe+sTtGJxS4GkOIVIgpb+vfkUiDDjbI
        czOJbH5N4sdjKbt17xZH2Y0=
X-Google-Smtp-Source: ABdhPJxFAnc7z6sUdVv+gAhZSZLb8Zv9dO8X3DxxTHXLkxNL65+MO+P5kEE9qt0kPPliKO6ziiH/5w==
X-Received: by 2002:adf:b60e:: with SMTP id f14mr10519549wre.11.1641091433051;
        Sat, 01 Jan 2022 18:43:53 -0800 (PST)
Received: from 168.52.45.77 (201.ip-51-68-45.eu. [51.68.45.201])
        by smtp.gmail.com with ESMTPSA id o8sm36006870wry.20.2022.01.01.18.43.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Jan 2022 18:43:52 -0800 (PST)
Message-ID: <6a3f5e8b-fbc1-bad8-aef0-3e2cf9be364e@gmail.com>
Date:   Sun, 2 Jan 2022 03:43:00 +0100
MIME-Version: 1.0
User-Agent: nano 6.4
From:   Ismael Ferreras Morezuelas <swyterzone@gmail.com>
Subject: [PATCH] Bluetooth: btusb: Add a new quirk to skip HCI_FLT_CLEAR_ALL
 on fake CSR controllers
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>, swyterzone@gmail.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Another subset of the more recent batch of Chinese clones aren't
specs-compliant and seem to lock up whenever they receive a
HCI_OP_SET_EVENT_FLT with flt_type set to zero/HCI_FLT_CLEAR_ALL,
which on Linux happens right at BR/EDR setup.

So, while all the previous efforts to wrangle the herd of fake CSRs
seem to be paying off (and these also get detected as such) we
still need to take care of this quirk; testers seem to agree
that these dongles tend to work well enough afterwards.

From some cursory USB packet capture on Windows it seems like
that driver doesn't appear to use this clear-all functionality at all.

This patch was tested on some really popular AliExpress-style
dongles, in my case marked as "V5.0". Chip markings: UG8413,
the backside of the PCB says "USB Dangel" (sic).

Here is the `hciconfig -a` output; for completeness:

hci0:	Type: Primary  Bus: USB
	BD Address: 00:1A:7D:DA:7X:XX  ACL MTU: 679:8  SCO MTU: 48:16
	UP RUNNING PSCAN ISCAN 
	Features: 0xbf 0x3e 0x4d 0xfa 0xdb 0x3d 0x7b 0xc7
	Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
	Link policy: RSWITCH SNIFF 
	Link mode: PERIPHERAL ACCEPT 
	Name: 'CSR8510 A10.'
	Class: 0x7c0104
	Service Classes: Rendering, Capturing, Object Transfer, Audio, Telephony
	Device Class: Computer, Desktop workstation
	HCI Version: 4.0 (0x6)  Revision: 0x3120
	LMP Version: 4.0 (0x6)  Subversion: 0x22bb
	Manufacturer: Cambridge Silicon Radio (10)


As well as the `lsusb -vv -d 0a12:0001`:

ID 0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth Dongle (HCI mode)
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass          224 Wireless
  bDeviceSubClass         1 Radio Frequency
  bDeviceProtocol         1 Bluetooth
  bMaxPacketSize0        64
  idVendor           0x0a12 Cambridge Silicon Radio, Ltd
  idProduct          0x0001 Bluetooth Dongle (HCI mode)
  bcdDevice           88.91
  iManufacturer           0 
  iProduct                2 BT DONGLE10
  iSerial                 0 
  bNumConfigurations      1

Also, changed the benign dmesg print that shows up whenever the
generic force-suspend fails from bt_dev_err to bt_dev_warn;
it's okay and done on a best-effort basis, not a problem
if that does not work.

Also, swapped the HCI subver and LMP subver numbers for the Barrot
in the comment, which I copied wrong the last time around.

Fixes: 81cac64ba258a ("Bluetooth: Deal with USB devices that are faking CSR vendor")
Fixes: cde1a8a992875 ("Bluetooth: btusb: Fix and detect most of the Chinese Bluetooth controllers")
Fixes: d74e0ae7e0303 ("Bluetooth: btusb: Fix detection of some fake CSR controllers with a bcdDevice val of 0x0134")
Fixes: 0671c0662383e ("Bluetooth: btusb: Add workaround for remote-wakeup issues with Barrot 8041a02 fake CSR controllers")
Fixes: f4292e2faf522 ("Bluetooth: btusb: Make the CSR clone chip force-suspend workaround more generic")

https://bugzilla.kernel.org/show_bug.cgi?id=60824
https://gist.github.com/nevack/6b36b82d715dc025163d9e9124840a07

Cc: stable@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>
Tested-by: Gonzalo Tornaría <tornaria@cmat.edu.uy>
Tested-by: Mateus Lemos <lemonsmateus@gmail.com>
Tested-by: Ismael Ferreras Morezuelas <swyterzone@gmail.com>
Signed-off-by: Ismael Ferreras Morezuelas <swyterzone@gmail.com>

---

 drivers/bluetooth/btusb.c   | 11 ++++++-----
 include/net/bluetooth/hci.h |  6 ++++++
 net/bluetooth/hci_core.c    | 11 ++++++++---
 net/bluetooth/hci_request.c |  8 ++++++--
 4 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 75c83768c..42c909c24 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1932,6 +1932,7 @@ static int btusb_setup_csr(struct hci_dev *hdev)
 		 */
 		set_bit(HCI_QUIRK_BROKEN_STORED_LINK_KEY, &hdev->quirks);
 		set_bit(HCI_QUIRK_BROKEN_ERR_DATA_REPORTING, &hdev->quirks);
+		set_bit(HCI_QUIRK_BROKEN_FILTER_CLEAR_ALL, &hdev->quirks);
 
 		/* Clear the reset quirk since this is not an actual
 		 * early Bluetooth 1.1 device from CSR.
@@ -1942,16 +1943,16 @@ static int btusb_setup_csr(struct hci_dev *hdev)
 		/*
 		 * Special workaround for these BT 4.0 chip clones, and potentially more:
 		 *
-		 * - 0x0134: a Barrot 8041a02                 (HCI rev: 0x1012 sub: 0x0810)
+		 * - 0x0134: a Barrot 8041a02                 (HCI rev: 0x0810 sub: 0x1012)
 		 * - 0x7558: IC markings FR3191AHAL 749H15143 (HCI rev/sub-version: 0x0709)
 		 *
 		 * These controllers are really messed-up.
 		 *
 		 * 1. Their bulk RX endpoint will never report any data unless
-		 * the device was suspended at least once (yes, really).
+		 *    the device was suspended at least once (yes, really).
 		 * 2. They will not wakeup when autosuspended and receiving data
-		 * on their bulk RX endpoint from e.g. a keyboard or mouse
-		 * (IOW remote-wakeup support is broken for the bulk endpoint).
+		 *    on their bulk RX endpoint from e.g. a keyboard or mouse
+		 *    (IOW remote-wakeup support is broken for the bulk endpoint).
 		 *
 		 * To fix 1. enable runtime-suspend, force-suspend the
 		 * HCI and then wake-it up by disabling runtime-suspend.
@@ -1971,7 +1972,7 @@ static int btusb_setup_csr(struct hci_dev *hdev)
 		if (ret >= 0)
 			msleep(200);
 		else
-			bt_dev_err(hdev, "CSR: Failed to suspend the device for our Barrot 8041a02 receive-issue workaround");
+			bt_dev_warn(hdev, "CSR: Couldn't suspend the device for our Barrot 8041a02 receive-issue workaround");
 
 		pm_runtime_forbid(&data->udev->dev);
 
diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 63065bc01..4e5d5979d 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -246,6 +246,12 @@ enum {
 	 * HCI after resume.
 	 */
 	HCI_QUIRK_NO_SUSPEND_NOTIFIER,
+
+	/* When this quirk is set, HCI_OP_SET_EVENT_FLT requests with
+	 * HCI_FLT_CLEAR_ALL are ignored. A subset of the CSR controller
+	 * clones struggle with this and instantly lock up.
+	 */
+	HCI_QUIRK_BROKEN_FILTER_CLEAR_ALL,
 };
 
 /* HCI device flags */
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 8d33aa648..7af649afc 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -150,6 +150,7 @@ static void bredr_setup(struct hci_request *req)
 {
 	__le16 param;
 	__u8 flt_type;
+	struct hci_dev *hdev = req->hdev;
 
 	/* Read Buffer Size (ACL mtu, max pkt, etc.) */
 	hci_req_add(req, HCI_OP_READ_BUFFER_SIZE, 0, NULL);
@@ -169,9 +170,13 @@ static void bredr_setup(struct hci_request *req)
 	/* Read Current IAC LAP */
 	hci_req_add(req, HCI_OP_READ_CURRENT_IAC_LAP, 0, NULL);
 
-	/* Clear Event Filters */
-	flt_type = HCI_FLT_CLEAR_ALL;
-	hci_req_add(req, HCI_OP_SET_EVENT_FLT, 1, &flt_type);
+	/* Clear Event Filters; some fake CSR controllers lock up after setting
+	 * this type of filter, so avoid sending the request altogether.
+	 */
+	if (!test_bit(HCI_QUIRK_BROKEN_FILTER_CLEAR_ALL, &hdev->quirks)) {
+		flt_type = HCI_FLT_CLEAR_ALL;
+		hci_req_add(req, HCI_OP_SET_EVENT_FLT, 1, &flt_type);
+	}
 
 	/* Connection accept timeout ~20 secs */
 	param = cpu_to_le16(0x7d00);
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 92611bfc0..cfcf64c0c 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -980,11 +980,15 @@ void hci_req_add_le_passive_scan(struct hci_request *req)
 static void hci_req_clear_event_filter(struct hci_request *req)
 {
 	struct hci_cp_set_event_filter f;
+	struct hci_dev *hdev = req->hdev;
+
+	if (!hci_dev_test_flag(hdev, HCI_BREDR_ENABLED))
+		return;
 
-	if (!hci_dev_test_flag(req->hdev, HCI_BREDR_ENABLED))
+	if (test_bit(HCI_QUIRK_BROKEN_FILTER_CLEAR_ALL, &hdev->quirks))
 		return;
 
-	if (hci_dev_test_flag(req->hdev, HCI_EVENT_FILTER_CONFIGURED)) {
+	if (hci_dev_test_flag(hdev, HCI_EVENT_FILTER_CONFIGURED)) {
 		memset(&f, 0, sizeof(f));
 		f.flt_type = HCI_FLT_CLEAR_ALL;
 		hci_req_add(req, HCI_OP_SET_EVENT_FLT, 1, &f);
-- 
2.34.1

