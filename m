Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE74A4D0823
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 21:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240974AbiCGUGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 15:06:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245266AbiCGUGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 15:06:21 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA503887BC;
        Mon,  7 Mar 2022 12:05:24 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id r13so34467358ejd.5;
        Mon, 07 Mar 2022 12:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7V7albS1mMaULT1gTe4cRzOvRbv1Zju6JegZQZ9PJEw=;
        b=qJsqMqHvx6m67pEZGrGShWddr5xKIysA8ZG0N3Ebdafs48tV/9b8xQkmRKxEgUto8L
         2/i/4CmBS/fP1M3JfrKg3L3BfXngX5cI/VxcURD3xbwoPiSQg1gsXURoHIV3yNODzBYt
         GJmlPyQJ2gqkVjn6ot99sHJSsUIXX/GJ4GdjJL+vwK3dZZjZZ3MExCXNDEkk79ijr9vB
         iwp6+NyvV74xqOU5SR2Ozn60qjqnhP4gffYuyq6OQhO/JItQRImltKHHiQ9xnW5XYfbD
         0ujux6T2hSLCI9KxpOPx/SW30vB5zYJjLolFSBgJJCxQeZavk3oAN86/Kvc24krz/aSU
         nqaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7V7albS1mMaULT1gTe4cRzOvRbv1Zju6JegZQZ9PJEw=;
        b=R44SgyOSdEfOx9bmljorLBDR8WmxhHNP8YUl1czYPgws/GUOO2ifl4+cEy0lmTKiwF
         ln3NntPZsZiP1LOPJq4Z3RMWGUXw0isEpbb8jflDruULG700el0GIpabysObODu4WpaK
         qzFeZgLbc1WhGjvZzbTe3l9r4thN5oLOpP8djI3b1mhpfPWxmkzRBC31Ul3ycSNPAx1a
         zeEqcbeH25eNwFVGVxVqNYGlDMi+uG2xMr3/fMPMjS5EUETTO0IDZ/qsb8Ojh37Fpin4
         cqx6MpOxqiLn+4BktgC49/sdQ8dFlhAdiD8LKnoZuVizBwe1lWVoyaQbv4Zr+SRlSXNj
         51RQ==
X-Gm-Message-State: AOAM533zxk8SzAGhjeq7hlSGHiDbSATnNeNyAUH/10Avz2tzmdokFu7s
        oQVHqKIgL3sBWCkQCUg8np8=
X-Google-Smtp-Source: ABdhPJzcVFXy6p7YZTyKUpR+tx9HbQYpXAexWr+PG+YudVfIUFSbjXtZjKnOe7pOY/aSDWH3rISNcw==
X-Received: by 2002:a17:907:94ca:b0:6da:e637:fa42 with SMTP id dn10-20020a17090794ca00b006dae637fa42mr10237260ejc.347.1646683523342;
        Mon, 07 Mar 2022 12:05:23 -0800 (PST)
Received: from osgiliath.lan (201.ip-51-68-45.eu. [51.68.45.201])
        by smtp.googlemail.com with ESMTPSA id m13-20020a170906234d00b006cf86bb0652sm5055354eja.121.2022.03.07.12.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 12:05:23 -0800 (PST)
From:   Ismael Ferreras Morezuelas <swyterzone@gmail.com>
To:     marcel@holtmann.org
Cc:     johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        hdegoede@redhat.com, pmenzel@molgen.mpg.de, swyterzone@gmail.com
Subject: [PATCH v4 2/2] Bluetooth: btusb: Use quirk to skip HCI_FLT_CLEAR_ALL on fake CSR controllers
Date:   Mon,  7 Mar 2022 21:04:45 +0100
Message-Id: <20220307200445.5554-2-swyterzone@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220307200445.5554-1-swyterzone@gmail.com>
References: <20220307200445.5554-1-swyterzone@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/bluetooth/btusb.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

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
 
-- 
2.35.1

