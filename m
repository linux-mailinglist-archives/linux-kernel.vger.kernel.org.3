Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA9957C76D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 11:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232784AbiGUJT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 05:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbiGUJT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 05:19:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AFF67859F;
        Thu, 21 Jul 2022 02:19:27 -0700 (PDT)
Date:   Thu, 21 Jul 2022 09:19:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658395165;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=250ltKNADmcWPiak1/OA/CGs4lgikJdLah2EWCcRta8=;
        b=S3W3B2YipDA9k4Ce0pmogWO8+/lBQ45szQRiA2t0D6qxv9BWz4gaRSytHtuecCBnV1DrJj
        pbjQw6HTUWclomTdwFejI+h3cTvs6aAZFwRDC8OaBhmOxZq8yYlPvXOtQsGHYneFhzeU7g
        P8vFUQcBstZjC2bT5QjDfxBvGpFejN7RFfGf3BrgFoOWZ9oDpJ7QqakyiBYpb0cQWhXQ6K
        5zosDncdOJSWU6FCiyxb8Ls7+T76tGuwidVmAhPEaYx1jghm2SYXAzmq0inR3GEx9Ye6F9
        ta7SV+XAKZ7iZ1jFAJoLfv+IFeTpAgvc8BzHZ2E12CKl02qPQtPqMky3uqeMoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658395165;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=250ltKNADmcWPiak1/OA/CGs4lgikJdLah2EWCcRta8=;
        b=Vr0t53hB97lB09Q7yweBzg5f+WDnM+Ayd+Ufa3szrPzagAEU7rB3sqJXFyyQBeeV8wcZ8a
        on8Gbfx+nzv7jTDQ==
From:   "tip-bot2 for Mario Limonciello" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] hwmon: (k10temp): Add support for new family 17h and
 19h models
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        Borislav Petkov <bp@suse.de>,
        Guenter Roeck <linux@roeck-us.net>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220719195256.1516-1-mario.limonciello@amd.com>
References: <20220719195256.1516-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Message-ID: <165839516431.15455.3571079093797833678.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     d906fa730827456711ce29c1f2994a0ccaff49dc
Gitweb:        https://git.kernel.org/tip/d906fa730827456711ce29c1f2994a0ccaff49dc
Author:        Mario Limonciello <mario.limonciello@amd.com>
AuthorDate:    Tue, 19 Jul 2022 14:52:54 -05:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 20 Jul 2022 17:39:11 +02:00

hwmon: (k10temp): Add support for new family 17h and 19h models

Add the support for CCD offsets used on family 17h models A0h-AFh,
and family 19h models 60h-7Fh.

  [ bp: Merge into a single patch. ]

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20220719195256.1516-1-mario.limonciello@amd.com
---
 drivers/hwmon/k10temp.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index 4e239bd..5a9d47a 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -428,6 +428,10 @@ static int k10temp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 			data->ccd_offset = 0x154;
 			k10temp_get_ccd_support(pdev, data, 8);
 			break;
+		case 0xa0 ... 0xaf:
+			data->ccd_offset = 0x300;
+			k10temp_get_ccd_support(pdev, data, 8);
+			break;
 		}
 	} else if (boot_cpu_data.x86 == 0x19) {
 		data->temp_adjust_mask = ZEN_CUR_TEMP_RANGE_SEL_MASK;
@@ -445,6 +449,11 @@ static int k10temp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 			data->ccd_offset = 0x300;
 			k10temp_get_ccd_support(pdev, data, 8);
 			break;
+		case 0x60 ... 0x6f:
+		case 0x70 ... 0x7f:
+			data->ccd_offset = 0x308;
+			k10temp_get_ccd_support(pdev, data, 8);
+			break;
 		case 0x10 ... 0x1f:
 		case 0xa0 ... 0xaf:
 			data->ccd_offset = 0x300;
@@ -489,10 +498,13 @@ static const struct pci_device_id k10temp_id_table[] = {
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_M30H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_M60H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_M70H_DF_F3) },
+	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_MA0H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_M10H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_M40H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_M50H_DF_F3) },
+	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_M60H_DF_F3) },
+	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_M70H_DF_F3) },
 	{ PCI_VDEVICE(HYGON, PCI_DEVICE_ID_AMD_17H_DF_F3) },
 	{}
 };
