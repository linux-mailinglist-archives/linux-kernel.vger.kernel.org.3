Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8AF4CE353
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 07:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbiCEGxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 01:53:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiCEGxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 01:53:20 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62A726F674;
        Fri,  4 Mar 2022 22:52:27 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id j26so5265454wrb.1;
        Fri, 04 Mar 2022 22:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject
         :content-language:to:cc:content-transfer-encoding;
        bh=rsNxYzOZnmd9ZUO9DBtWU4+Ik1+0a6QdsxbvmAjgvRE=;
        b=Qb87/QTpOKVSw8fW2p2b1uvh+QvEbcWPL22tj7T7bLei8no1P+3sK4ghT+hwnDkH79
         7jZWYU8X/pma4BkMyyawoFIRpHU0gfy7LtKT2DauhSFsMUcPoFFW0DeyaAZU0mgTomdo
         k3t57kOgNAXCzaL3UNvbXVXdJQAocuXL5/FpxASMJWgSev4j4n8Lv9NdWzFEi8qCu5jn
         K/KMT0cxWoYEBKk9LrPgkr/ZkU3TRVEy3lV2sVgMwF0f+YpMj+J4jGN8dN3W43aGxNQF
         PdqAl1MPocxIZ9bwQRT2GTYsoJW4M8/aHL1/S8OD64x1IhWv+PYToK9x19yDsuJhaaBd
         c1VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:content-language:to:cc:content-transfer-encoding;
        bh=rsNxYzOZnmd9ZUO9DBtWU4+Ik1+0a6QdsxbvmAjgvRE=;
        b=TvAw23Q0wzSgm3rtgBpHqP3gcyjAiumItKI0yuEMSXFeYBe1tGg5xOiBiB8MhGacBS
         hrx3yZmwBP23xGRd7ZaFYQGiNTkJfeWJxV5wRvgCGkZI8ZaqaW2nGcb4BG3hvgKBOC7r
         XV+9PqeeUrTkBfJbdeBGN/VoAErJKk8YAzK1jtqGxDjfXi6WgIjEhLpVTpsH4+opMJ8a
         uPAQdBj+MeKF1wa0aQyCSqiIcR6s1bqPb+utLPtPs4WrPQrnThzRTWEK5+aFJhrVt+n6
         3EI5XnK0PkGrDvzgBL5U66GowkiAwe7RInfIQQ+iyoB0BzWIpGX6Fu/VHo9O3XDdzgzR
         a68A==
X-Gm-Message-State: AOAM53093rIpM/AlmOnHvcdw4G4nSXHzgIC6htWY8M274j1Wea7KlY2p
        qGifapGH+qKmZJ+yQk8KE50UtCK7HvhNKW0G
X-Google-Smtp-Source: ABdhPJxpxdLB8pid78QiZWpCYMtY8pCUK/04vUyPgWs9OYhwtY9Ylv/MP9hkk00PEHtC55i1iG9h3w==
X-Received: by 2002:adf:ff92:0:b0:1f1:1754:b3c2 with SMTP id j18-20020adfff92000000b001f11754b3c2mr1482338wrr.655.1646463145900;
        Fri, 04 Mar 2022 22:52:25 -0800 (PST)
Received: from 168.52.45.77 (201.ip-51-68-45.eu. [51.68.45.201])
        by smtp.gmail.com with ESMTPSA id o16-20020a05600c511000b0038141b4a4edsm15471277wms.38.2022.03.04.22.52.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Mar 2022 22:52:25 -0800 (PST)
Message-ID: <3b6c7c18-dc48-b924-bd09-3638a5c741a4@gmail.com>
Date:   Sat, 5 Mar 2022 07:52:23 +0100
MIME-Version: 1.0
User-Agent: nano 6.4
From:   Ismael Ferreras Morezuelas <swyterzone@gmail.com>
Subject: [PATCH v3] Bluetooth: btusb: Add quirk to skip HCI_FLT_CLEAR_ALL on
 fake CSR controllers
Content-Language: en-US
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        BlueZ <linux-bluetooth@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_HELO_IP_MISMATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Another subset of the more recent batch of Chinese clones aren't
specs-compliant and seem to lock up whenever they receive a
HCI_OP_SET_EVENT_FLT with flt_type set to zero/HCI_FLT_CLEAR_ALL,
which on Linux (until the recent HCI state-machine refactor) happened
right at BR/EDR setup. As there are other less-straightforward ways
of reaching those operations, this patch is still relevant.

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

Link: https://bugzilla.kernel.org/show_bug.cgi?id=60824
Link: https://gist.github.com/nevack/6b36b82d715dc025163d9e9124840a07

Cc: stable@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>
Tested-by: Gonzalo Tornaría <tornaria@cmat.edu.uy>
Tested-by: Mateus Lemos <lemonsmateus@gmail.com>
Tested-by: Ismael Ferreras Morezuelas <swyterzone@gmail.com>
Signed-off-by: Ismael Ferreras Morezuelas <swyterzone@gmail.com>
---

Changes for v3:
  * Simplified and updated the hci_sync.c code after the state-machine
    changes; the hci_core.c and hci_request.c parts no longer exist.

    As requested by Marcel.

    Funnily enough, the HCI code does not unconditionally send a
    clear-all anymore on bring-up, so I have received reports of
    the bug being "fixed" without patching. But there might be
    more ways of hitting these codepaths in the future as the
    kernel develops.

    So yeah, the controller limitation is still there, but
    doesn't get exercised because we don't do it like that.

  * Shortened the patch subject, as suggested by Paul Menzel.

Changes for v2:
  * Added HCI_QUIRK_NO_SUSPEND_NOTIFIER to btusb_setup_csr().
    In theory we already disable runtime suspend in btusb, button
    better safe than sorry. Doesn't hurt to explicitly avoid the
    hci_suspend_dev() codepath, it also works as example.
  * Improved the quirk description in hci.h, as suggested by Hans
    de Goede. Explain the need to disable runtime suspend.
  * Also check for the quirk in hci_req_set_event_filter();
    mirror its hci_req_clear_event_filter() counterpart.
  * The struct hci_dev *hdev variables always go first.
  * Removed some misc formatting changes.

 drivers/bluetooth/btusb.c   |  6 ++++--
 include/net/bluetooth/hci.h | 10 ++++++++++
 net/bluetooth/hci_sync.c    | 16 ++++++++++++++++
 3 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 1bb00b7547fb..73a4c9dd77c2 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2057,6 +2057,8 @@ static int btusb_setup_csr(struct hci_dev *hdev)
 		 */
 		set_bit(HCI_QUIRK_BROKEN_STORED_LINK_KEY, &hdev->quirks);
 		set_bit(HCI_QUIRK_BROKEN_ERR_DATA_REPORTING, &hdev->quirks);
+		set_bit(HCI_QUIRK_BROKEN_FILTER_CLEAR_ALL, &hdev->quirks);
+		set_bit(HCI_QUIRK_NO_SUSPEND_NOTIFIER, &hdev->quirks);
 
 		/* Clear the reset quirk since this is not an actual
 		 * early Bluetooth 1.1 device from CSR.
@@ -2067,7 +2069,7 @@ static int btusb_setup_csr(struct hci_dev *hdev)
 		/*
 		 * Special workaround for these BT 4.0 chip clones, and potentially more:
 		 *
-		 * - 0x0134: a Barrot 8041a02                 (HCI rev: 0x1012 sub: 0x0810)
+		 * - 0x0134: a Barrot 8041a02                 (HCI rev: 0x0810 sub: 0x1012)
 		 * - 0x7558: IC markings FR3191AHAL 749H15143 (HCI rev/sub-version: 0x0709)
 		 *
 		 * These controllers are really messed-up.
@@ -2096,7 +2098,7 @@ static int btusb_setup_csr(struct hci_dev *hdev)
 		if (ret >= 0)
 			msleep(200);
 		else
-			bt_dev_err(hdev, "CSR: Failed to suspend the device for our Barrot 8041a02 receive-issue workaround");
+			bt_dev_warn(hdev, "CSR: Couldn't suspend the device for our Barrot 8041a02 receive-issue workaround");
 
 		pm_runtime_forbid(&data->udev->dev);
 
diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 35c073d44ec5..5cb095b09a94 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -255,6 +255,16 @@ enum {
 	 * during the hdev->setup vendor callback.
 	 */
 	HCI_QUIRK_BROKEN_READ_TRANSMIT_POWER,
+
+	/* When this quirk is set, HCI_OP_SET_EVENT_FLT requests with
+	 * HCI_FLT_CLEAR_ALL are ignored and event filtering is
+	 * completely avoided. A subset of the CSR controller
+	 * clones struggle with this and instantly lock up.
+	 *
+	 * Note that devices using this must (separately) disable
+	 * runtime suspend, because event filtering takes place there.
+	 */
+	HCI_QUIRK_BROKEN_FILTER_CLEAR_ALL,
 };
 
 /* HCI device flags */
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index e31d1150dc71..c3bdaf2de511 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -2812,6 +2812,9 @@ static int hci_set_event_filter_sync(struct hci_dev *hdev, u8 flt_type,
 	if (!hci_dev_test_flag(hdev, HCI_BREDR_ENABLED))
 		return 0;
 
+	if (test_bit(HCI_QUIRK_BROKEN_FILTER_CLEAR_ALL, &hdev->quirks))
+		return 0;
+
 	memset(&cp, 0, sizeof(cp));
 	cp.flt_type = flt_type;
 
@@ -2832,6 +2835,13 @@ static int hci_clear_event_filter_sync(struct hci_dev *hdev)
 	if (!hci_dev_test_flag(hdev, HCI_EVENT_FILTER_CONFIGURED))
 		return 0;
 
+	/* In theory the state machine should not reach here unless
+	 * a hci_set_event_filter_sync() call succeeds, but we do
+	 * the check both for parity and as a future reminder.
+	 */
+	if (test_bit(HCI_QUIRK_BROKEN_FILTER_CLEAR_ALL, &hdev->quirks))
+		return 0;
+
 	return hci_set_event_filter_sync(hdev, HCI_FLT_CLEAR_ALL, 0x00,
 					 BDADDR_ANY, 0x00);
 }
@@ -4831,6 +4841,12 @@ static int hci_update_event_filter_sync(struct hci_dev *hdev)
 	if (!hci_dev_test_flag(hdev, HCI_BREDR_ENABLED))
 		return 0;
 
+	/* Some fake CSR controllers lock up after setting this type of
+	 * filter, so avoid sending the request altogether.
+	 */
+	if (test_bit(HCI_QUIRK_BROKEN_FILTER_CLEAR_ALL, &hdev->quirks))
+		return 0;
+
 	/* Always clear event filter when starting */
 	hci_clear_event_filter_sync(hdev);
 
-- 
2.35.1

