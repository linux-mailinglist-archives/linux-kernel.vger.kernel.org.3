Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8701158AB21
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 14:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240826AbiHEM4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 08:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240797AbiHEMz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 08:55:59 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46D622B2C;
        Fri,  5 Aug 2022 05:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1659704158; x=1691240158;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=00HIFvltqoK2q6RN6iEVaq/z31zM0MweFlDQWbq1aXU=;
  b=RraV3IGMPEPO0sAR7YsDZoKVqoWmR4QV2iEaHdBgTNKAQEzDYLAL62O7
   BiBbB7AMWyqX/Zk7jk3ZAo74HIzorcuezUd7I79+QNWV3ktGOX00yaekG
   BIUb6FVXw+7gWIej7dC69Np8Bkb2fB/x7gC5vR1Xnh33zbShVUdIj/eBs
   3KhovI6mKLXFONzuo4nTVGiQIs398TgwEdV0OM7QWmFpCflvposJpzm1G
   yJOtMDxFcblrN2D4EtfmzjanWfu+T/6FIIh+QtkfhhTIz2SmVt+7NQdMU
   OYk/msjDJZ8EcgxJp2FRsiGZmECyIZ8z+shSp1YD4ib159SDTNibbgsUE
   A==;
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="175226525"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Aug 2022 05:55:58 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 5 Aug 2022 05:55:57 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Fri, 5 Aug 2022 05:55:56 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
Subject: [PATCH 3/3] mailbox: mpfs: account for mbox offsets while sending
Date:   Fri, 5 Aug 2022 13:56:19 +0100
Message-ID: <20220805125618.733628-4-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220805125618.733628-1-conor.dooley@microchip.com>
References: <20220805125618.733628-1-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mailbox offset is not only used for receiving messages, but it is
also used by messages sent to the system controller by Linux that have a
payload, such as the "digital signature service". It is also overloaded
by certain other services (reprogramming of the FPGA fabric, see Link:)
to have a meaning other than the offset the system controller should
read from.
When the driver was written, no such services of the latter type were
in use & those of the former used an offset of zero so this has gone
un-noticed.

Link: https://www.microsemi.com/document-portal/doc_download/1245815-polarfire-fpga-and-polarfire-soc-fpga-system-services-user-guide # Section 5.2
Fixes: 83d7b1560810 ("mbox: add polarfire soc system controller mailbox")
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/mailbox/mailbox-mpfs.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/mailbox/mailbox-mpfs.c b/drivers/mailbox/mailbox-mpfs.c
index e432a8f0d148..cfacb3f320a6 100644
--- a/drivers/mailbox/mailbox-mpfs.c
+++ b/drivers/mailbox/mailbox-mpfs.c
@@ -100,21 +100,20 @@ static int mpfs_mbox_send_data(struct mbox_chan *chan, void *data)
 
 		for (index = 0; index < (msg->cmd_data_size / 4); index++)
 			writel_relaxed(word_buf[index],
-				       mbox->mbox_base + index * 0x4);
+				       mbox->mbox_base + msg->mbox_offset + index * 0x4);
 		if (extra_bits) {
 			u8 i;
 			u8 byte_off = ALIGN_DOWN(msg->cmd_data_size, 4);
 			u8 *byte_buf = msg->cmd_data + byte_off;
 
-			val = readl_relaxed(mbox->mbox_base + index * 0x4);
+			val = readl_relaxed(mbox->mbox_base + msg->mbox_offset + index * 0x4);
 
 			for (i = 0u; i < extra_bits; i++) {
 				val &= ~(0xffu << (i * 8u));
 				val |= (byte_buf[i] << (i * 8u));
 			}
 
-			writel_relaxed(val,
-				       mbox->mbox_base + index * 0x4);
+			writel_relaxed(val, mbox->mbox_base + msg->mbox_offset + index * 0x4);
 		}
 	}
 
-- 
2.36.1

