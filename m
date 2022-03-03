Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5E324CBAFD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 11:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbiCCKHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 05:07:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiCCKHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 05:07:10 -0500
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC9B1795DE;
        Thu,  3 Mar 2022 02:06:24 -0800 (PST)
Received: from handsomejack.molgen.mpg.de (handsomejack.molgen.mpg.de [141.14.17.248])
        by mx.molgen.mpg.de (Postfix) with ESMTP id 1F11261EA192A;
        Thu,  3 Mar 2022 11:06:23 +0100 (CET)
From:   Paul Menzel <pmenzel@molgen.mpg.de>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] [RFC] ata: ahci: Skip debounce delay for AMD FCH SATA Controller
Date:   Thu,  3 Mar 2022 11:04:53 +0100
Message-Id: <20220303100453.30018-2-pmenzel@molgen.mpg.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220303100453.30018-1-pmenzel@molgen.mpg.de>
References: <20220303100453.30018-1-pmenzel@molgen.mpg.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,
        PP_MIME_FAKE_ASCII_TEXT,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD devices with the FCH SATA Controller 0x1022:0x7901 do not need the
default debounce delay of 200 ms.

    07:00.2 SATA controller [0106]: Advanced Micro Devices, Inc. [AMD] FCH SATA Controller [AHCI mode] [1022:7901] (rev 51)

So skip it, by mapping it to the board with no debounce delay.

Tested on the MSI MS-7A37/B350M MORTAR (MS-7A37).

To-do: Add test details and results.

Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
---
I am travelling so could not test this exact patch just yet, but I ran
something similar for several weeks already. It’d be great, if the
desktop and AMD folks could also give this a try.

 drivers/ata/ahci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 0fc09b86a559..44b79fe43d13 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -456,7 +456,7 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(AMD, 0x7800), board_ahci }, /* AMD Hudson-2 */
 	{ PCI_VDEVICE(AMD, 0x7801), board_ahci_no_debounce_delay }, /* AMD Hudson-2 (AHCI mode) */
 	{ PCI_VDEVICE(AMD, 0x7900), board_ahci }, /* AMD CZ */
-	{ PCI_VDEVICE(AMD, 0x7901), board_ahci_low_power }, /* AMD Green Sardine */
+	{ PCI_VDEVICE(AMD, 0x7901), board_ahci_low_power_no_debounce_delay }, /* AMD Green Sardine */
 	/* AMD is using RAID class only for ahci controllers */
 	{ PCI_VENDOR_ID_AMD, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
 	  PCI_CLASS_STORAGE_RAID << 8, 0xffffff, board_ahci },
-- 
2.30.2

