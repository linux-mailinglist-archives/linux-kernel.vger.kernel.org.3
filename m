Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7D284E9B6F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 17:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239278AbiC1PqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 11:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239097AbiC1PqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 11:46:10 -0400
Received: from mail.baikalelectronics.ru (mail.baikalelectronics.com [87.245.175.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 855B84B1E3;
        Mon, 28 Mar 2022 08:44:19 -0700 (PDT)
Received: from mail.baikalelectronics.ru (unknown [192.168.51.25])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 5B6651E28D6;
        Thu, 24 Mar 2022 03:16:39 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.ru 5B6651E28D6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1648080999;
        bh=Yt4t9pz9qqT6PdT2sz7/qmCcR/vnmr7AJW58bmYgtH8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=qQUp8HeV/ugnWRRULFLZwz07LyntimKlBHmhnCOMJ2kW4qliPOgIeX2dDz0qvoAk8
         TFLM7X7nZd42g+g48E8JtS3FC9FQDjnRPgmjKYLQuYzh0v8Sr0AyEXzI+9FOibPtAw
         QQ7Dcz9YpTItY0EAS5sphXMEB+flAiEQ9YvDx98s=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 24 Mar 2022 03:16:39 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, <linux-ide@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH 11/21] ata: libahci: Extend port-cmd flags set with port capabilities
Date:   Thu, 24 Mar 2022 03:16:18 +0300
Message-ID: <20220324001628.13028-12-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220324001628.13028-1-Sergey.Semin@baikalelectronics.ru>
References: <20220324001628.13028-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently not all of the Port-specific capabilities listed in the
PORT_CMD-enumeration. Let's extend that set with the Cold Presence
Detection and Mechanical Presence Switch attached to the Port flags [1] so
to closeup the set of the platform-specific port-capabilities flags.  Note
these flags are supposed to be set by the platform firmware if there is
one. Alternatively as we are about to do they can be set by means of the
OF properties.

While at it replace PORT_IRQ_DEV_ILCK with PORT_IRQ_DEV_MPS and fix the
comment there. In accordance with [2] that IRQ flag is supposed to
indicate the state of the signal coming from the Mechanical Presence
Switch.

[1] Serial ATA AHCI 1.3.1 Specification, p.27
[2] Serial ATA AHCI 1.3.1 Specification, p.7

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/ata/ahci.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 0b1d5c24cb8c..04690b4168a3 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -138,7 +138,7 @@ enum {
 	PORT_IRQ_BAD_PMP	= (1 << 23), /* incorrect port multiplier */
 
 	PORT_IRQ_PHYRDY		= (1 << 22), /* PhyRdy changed */
-	PORT_IRQ_DEV_ILCK	= (1 << 7), /* device interlock */
+	PORT_IRQ_DMPS		= (1 << 7), /* mechanical presence status */
 	PORT_IRQ_CONNECT	= (1 << 6), /* port connect change status */
 	PORT_IRQ_SG_DONE	= (1 << 5), /* descriptor processed */
 	PORT_IRQ_UNK_FIS	= (1 << 4), /* unknown FIS rx'd */
@@ -166,6 +166,8 @@ enum {
 	PORT_CMD_ATAPI		= (1 << 24), /* Device is ATAPI */
 	PORT_CMD_FBSCP		= (1 << 22), /* FBS Capable Port */
 	PORT_CMD_ESP		= (1 << 21), /* External Sata Port */
+	PORT_CMD_CPD		= (1 << 20), /* Cold Presence Detection */
+	PORT_CMD_MPSP		= (1 << 19), /* Mechanical Presence Switch */
 	PORT_CMD_HPCP		= (1 << 18), /* HotPlug Capable Port */
 	PORT_CMD_PMP		= (1 << 17), /* PMP attached */
 	PORT_CMD_LIST_ON	= (1 << 15), /* cmd list DMA engine running */
@@ -181,6 +183,9 @@ enum {
 	PORT_CMD_ICC_PARTIAL	= (0x2 << 28), /* Put i/f in partial state */
 	PORT_CMD_ICC_SLUMBER	= (0x6 << 28), /* Put i/f in slumber state */
 
+	PORT_CMD_CAP		= PORT_CMD_HPCP | PORT_CMD_MPSP |
+				  PORT_CMD_CPD | PORT_CMD_ESP | PORT_CMD_FBSCP,
+
 	/* PORT_FBS bits */
 	PORT_FBS_DWE_OFFSET	= 16, /* FBS device with error offset */
 	PORT_FBS_ADO_OFFSET	= 12, /* FBS active dev optimization offset */
-- 
2.35.1

