Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79EA159F030
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 02:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbiHXAZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 20:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiHXAZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 20:25:02 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E68D25FB
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 17:25:00 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-11c5505dba2so18778617fac.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 17:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=LJAfA7GotYMc2sBImpvtvpZqft2fC+cWg+7aSAi+MUI=;
        b=J8Z/QwaoEtvIKAD3GGv0vJiORTtrZK6BWnFjNAbedgZFY47B1xacZGex+76dIqSRpw
         o8hIeegzWId5M5Rrs8YN3/UNLLbZOaABDosP3QkOXhvYQApsNgpuG+D0b6sv2WQJJ01U
         iOvKqbWOIx9TBvcUVyg3pOxQYDy3W2ygUmMGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=LJAfA7GotYMc2sBImpvtvpZqft2fC+cWg+7aSAi+MUI=;
        b=Vb17G+XYwFc10AvD+CeLaH2ns6/ZYURWHgL4OQhlkGWkhecklYZfkkxyZwNKvsPjAU
         tA+n3lVZyR+gsekDNC/mjafglTkc0ZK5KOKOBNAl9GsyrCudWKaIXeTTC1Z1+J8GXr4m
         /I5diH24aR7A5dCwr+TUp3UdwMRe1z1p7qqbLIE/rRsM8b3zSsV82va/Kve7B2NVxlG6
         kNZerd8fy4/HH0rD4eZOzdg72ILoSdea9LHkII0d3zr4eben4xxYwZY6mgOdXEe44Ts/
         PcFNn4QLTd2Yzp9An8QmC3XCmA01hAwCXp21sE6kwnZxhwpIdGEDLNbEvDgtFmdGHOX3
         2nxg==
X-Gm-Message-State: ACgBeo31aLvI316uHPaY5qmuK7nYC9xdlmPtFxkH1rYEqPmUHBCe7mJO
        hRwwLBIBzyjNsVWbjqM4IEBVLg==
X-Google-Smtp-Source: AA6agR5xRrsm0J1Ep+Om0FKDcYfwDXf/B6TbGlwLEb8cEHiHs/ivqpi9BYzu6oK91U++QCzMGiC8MQ==
X-Received: by 2002:a05:6870:8912:b0:11b:a59c:f533 with SMTP id i18-20020a056870891200b0011ba59cf533mr2525842oao.220.1661300699430;
        Tue, 23 Aug 2022 17:24:59 -0700 (PDT)
Received: from shuah-tx13.internal ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id v23-20020a0568301bd700b0063711a0010bsm4154466ota.76.2022.08.23.17.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 17:24:58 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     valentina.manea.m@gmail.com, shuah@kernel.org,
        gregkh@linuxfoundation.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, mailhol.vincent@wanadoo.fr,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hongren Zenithal Zheng <i@zenithal.me>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH v2] usbip: add USBIP_URB_* URB transfer flags
Date:   Tue, 23 Aug 2022 18:24:56 -0600
Message-Id: <20220824002456.94605-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

USBIP driver packs URB transfer flags in network packets that are
exchanged between Server (usbip_host) and Client (vhci_hcd).

URB_* flags are internal to kernel and could change. Where as USBIP
URB flags exchanged in network packets are USBIP user API must not
change.

Add USBIP_URB* flags to make this an explicit API and change the
client and server to map them. Details as follows:

Client tx path (USBIP_CMD_SUBMIT):
- Maps URB_* to USBIP_URB_* when it sends USBIP_CMD_SUBMIT packet.

Server rx path (USBIP_CMD_SUBMIT):
- Maps USBIP_URB_* to URB_* when it receives USBIP_CMD_SUBMIT packet.

Flags aren't included in USBIP_CMD_UNLINK and USBIP_RET_SUBMIT packets
and no special handling is needed for them in the following cases:

- Server rx path (USBIP_CMD_UNLINK)
- Client rx path & Server tx path (USBIP_RET_SUBMIT)

Update protocol documentation to reflect the change.

Suggested-by: Hongren Zenithal Zheng <i@zenithal.me>
Suggested-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---

Changes since v1: addressed review comments

 Documentation/usb/usbip_protocol.rst | 13 ++--
 drivers/usb/usbip/stub_rx.c          |  4 +-
 drivers/usb/usbip/usbip_common.c     | 91 +++++++++++++++++++++++++++-
 include/uapi/linux/usbip.h           | 26 ++++++++
 4 files changed, 122 insertions(+), 12 deletions(-)

diff --git a/Documentation/usb/usbip_protocol.rst b/Documentation/usb/usbip_protocol.rst
index 0b8541fda4d8..adc158967cc6 100644
--- a/Documentation/usb/usbip_protocol.rst
+++ b/Documentation/usb/usbip_protocol.rst
@@ -340,13 +340,12 @@ USBIP_CMD_SUBMIT:
 | 0         | 20     | usbip_header_basic, 'command' shall be 0x00000001 |
 +-----------+--------+---------------------------------------------------+
 | 0x14      | 4      | transfer_flags: possible values depend on the     |
-|           |        | URB transfer_flags (refer to URB doc in           |
-|           |        | Documentation/driver-api/usb/URB.rst)             |
-|           |        | but with URB_NO_TRANSFER_DMA_MAP masked. Refer to |
-|           |        | function usbip_pack_cmd_submit and function       |
-|           |        | tweak_transfer_flags in drivers/usb/usbip/        |
-|           |        | usbip_common.c. The following fields may also ref |
-|           |        | to function usbip_pack_cmd_submit and URB doc     |
+|           |        | USBIP_URB transfer_flags.                         |
+|           |        | Refer to include/uapi/linux/usbip.h and           |
+|           |        | Documentation/driver-api/usb/URB.rst.             |
+|           |        | Refer to usbip_pack_cmd_submit() and              |
+|           |        | tweak_transfer_flags() in drivers/usb/usbip/      |
+|           |        | usbip_common.c.                                   |
 +-----------+--------+---------------------------------------------------+
 | 0x18      | 4      | transfer_buffer_length:                           |
 |           |        | use URB transfer_buffer_length                    |
diff --git a/drivers/usb/usbip/stub_rx.c b/drivers/usb/usbip/stub_rx.c
index 5dd41e8215e0..fc01b31bbb87 100644
--- a/drivers/usb/usbip/stub_rx.c
+++ b/drivers/usb/usbip/stub_rx.c
@@ -464,7 +464,7 @@ static void stub_recv_cmd_submit(struct stub_device *sdev,
 	int nents;
 	int num_urbs = 1;
 	int pipe = get_pipe(sdev, pdu);
-	int use_sg = pdu->u.cmd_submit.transfer_flags & URB_DMA_MAP_SG;
+	int use_sg = pdu->u.cmd_submit.transfer_flags & USBIP_URB_DMA_MAP_SG;
 	int support_sg = 1;
 	int np = 0;
 	int ret, i;
@@ -514,7 +514,7 @@ static void stub_recv_cmd_submit(struct stub_device *sdev,
 				num_urbs = nents;
 				priv->completed_urbs = 0;
 				pdu->u.cmd_submit.transfer_flags &=
-								~URB_DMA_MAP_SG;
+								~USBIP_URB_DMA_MAP_SG;
 			}
 		} else {
 			buffer = kzalloc(buf_len, GFP_KERNEL);
diff --git a/drivers/usb/usbip/usbip_common.c b/drivers/usb/usbip/usbip_common.c
index 2ab99244bc31..053a2bca4c47 100644
--- a/drivers/usb/usbip/usbip_common.c
+++ b/drivers/usb/usbip/usbip_common.c
@@ -344,6 +344,91 @@ static unsigned int tweak_transfer_flags(unsigned int flags)
 	return flags;
 }
 
+/*
+ * USBIP driver packs URB transfer flags in PDUs that are exchanged
+ * between Server (usbip_host) and Client (vhci_hcd). URB_* flags
+ * are internal to kernel and could change. Where as USBIP URB flags
+ * exchanged in PDUs are USBIP user API must not change.
+ *
+ * USBIP_URB* flags are exported as explicit API and client and server
+ * do mapping from kernel flags to USBIP_URB*. Details as follows:
+ *
+ * Client tx path (USBIP_CMD_SUBMIT):
+ * - Maps URB_* to USBIP_URB_* when it sends USBIP_CMD_SUBMIT packet.
+ *
+ * Server rx path (USBIP_CMD_SUBMIT):
+ * - Maps USBIP_URB_* to URB_* when it receives USBIP_CMD_SUBMIT packet.
+ *
+ * Flags aren't included in USBIP_CMD_UNLINK and USBIP_RET_SUBMIT packets
+ * and no special handling is needed for them in the following cases:
+ * - Server rx path (USBIP_CMD_UNLINK)
+ * - Client rx path & Server tx path (USBIP_RET_SUBMIT)
+ *
+ * Code paths:
+ * usbip_pack_pdu() is the common routine that handles packing pdu from
+ * urb and unpack pdu to an urb.
+ *
+ * usbip_pack_cmd_submit() and usbip_pack_ret_submit() handle
+ * USBIP_CMD_SUBMIT and USBIP_RET_SUBMIT respectively.
+ *
+ * usbip_map_urb_to_usbip() and usbip_map_usbip_to_urb() are used
+ * by usbip_pack_cmd_submit() and usbip_pack_ret_submit() to map
+ * flags.
+ */
+
+struct urb_to_usbip_flags {
+	u32 urb_flag;
+	u32 usbip_flag;
+};
+
+#define NUM_USBIP_FLAGS	17
+
+static const struct urb_to_usbip_flags flag_map[NUM_USBIP_FLAGS] = {
+	{URB_SHORT_NOT_OK, USBIP_URB_SHORT_NOT_OK},
+	{URB_ISO_ASAP, USBIP_URB_ISO_ASAP},
+	{URB_NO_TRANSFER_DMA_MAP, USBIP_URB_NO_TRANSFER_DMA_MAP},
+	{URB_ZERO_PACKET, USBIP_URB_ZERO_PACKET},
+	{URB_NO_INTERRUPT, USBIP_URB_NO_INTERRUPT},
+	{URB_FREE_BUFFER, USBIP_URB_FREE_BUFFER},
+	{URB_DIR_IN, USBIP_URB_DIR_IN},
+	{URB_DIR_OUT, USBIP_URB_DIR_OUT},
+	{URB_DIR_MASK, USBIP_URB_DIR_MASK},
+	{URB_DMA_MAP_SINGLE, USBIP_URB_DMA_MAP_SINGLE},
+	{URB_DMA_MAP_PAGE, USBIP_URB_DMA_MAP_PAGE},
+	{URB_DMA_MAP_SG, USBIP_URB_DMA_MAP_SG},
+	{URB_MAP_LOCAL, USBIP_URB_MAP_LOCAL},
+	{URB_SETUP_MAP_SINGLE, USBIP_URB_SETUP_MAP_SINGLE},
+	{URB_SETUP_MAP_LOCAL, USBIP_URB_SETUP_MAP_LOCAL},
+	{URB_DMA_SG_COMBINED, USBIP_URB_DMA_SG_COMBINED},
+	{URB_ALIGNED_TEMP_BUFFER, USBIP_URB_ALIGNED_TEMP_BUFFER},
+};
+
+static unsigned int urb_to_usbip(unsigned int flags)
+{
+	unsigned int map_flags = 0;
+	int loop;
+
+	for (loop = 0; loop < NUM_USBIP_FLAGS; loop++) {
+		if (flags & flag_map[loop].urb_flag)
+			map_flags |= flag_map[loop].usbip_flag;
+	}
+
+	return map_flags;
+}
+
+static unsigned int usbip_to_urb(unsigned int flags)
+{
+	unsigned int map_flags = 0;
+	int loop;
+
+	for (loop = 0; loop < NUM_USBIP_FLAGS; loop++) {
+		if (flags & flag_map[loop].usbip_flag)
+			map_flags |= flag_map[loop].urb_flag;
+	}
+
+	return map_flags;
+}
+
 static void usbip_pack_cmd_submit(struct usbip_header *pdu, struct urb *urb,
 				  int pack)
 {
@@ -354,14 +439,14 @@ static void usbip_pack_cmd_submit(struct usbip_header *pdu, struct urb *urb,
 	 * will be discussed when usbip is ported to other operating systems.
 	 */
 	if (pack) {
-		spdu->transfer_flags =
-			tweak_transfer_flags(urb->transfer_flags);
+		/* map after tweaking the urb flags */
+		spdu->transfer_flags = urb_to_usbip(tweak_transfer_flags(urb->transfer_flags));
 		spdu->transfer_buffer_length	= urb->transfer_buffer_length;
 		spdu->start_frame		= urb->start_frame;
 		spdu->number_of_packets		= urb->number_of_packets;
 		spdu->interval			= urb->interval;
 	} else  {
-		urb->transfer_flags         = spdu->transfer_flags;
+		urb->transfer_flags         = usbip_to_urb(spdu->transfer_flags);
 		urb->transfer_buffer_length = spdu->transfer_buffer_length;
 		urb->start_frame            = spdu->start_frame;
 		urb->number_of_packets      = spdu->number_of_packets;
diff --git a/include/uapi/linux/usbip.h b/include/uapi/linux/usbip.h
index fd393d908d8a..e4421ad55b2e 100644
--- a/include/uapi/linux/usbip.h
+++ b/include/uapi/linux/usbip.h
@@ -24,4 +24,30 @@ enum usbip_device_status {
 	VDEV_ST_USED,
 	VDEV_ST_ERROR
 };
+
+/* USB URB Transfer flags:
+ *
+ * USBIP server and client (vchi) pack URBs in TCP packets. The following
+ * are the transfer type defines used in USBIP protocol.
+ */
+
+#define USBIP_URB_SHORT_NOT_OK		0x0001
+#define USBIP_URB_ISO_ASAP		0x0002
+#define USBIP_URB_NO_TRANSFER_DMA_MAP	0x0004
+#define USBIP_URB_ZERO_PACKET		0x0040
+#define USBIP_URB_NO_INTERRUPT		0x0080
+#define USBIP_URB_FREE_BUFFER		0x0100
+#define USBIP_URB_DIR_IN		0x0200
+#define USBIP_URB_DIR_OUT		0
+#define USBIP_URB_DIR_MASK		USBIP_URB_DIR_IN
+
+#define USBIP_URB_DMA_MAP_SINGLE	0x00010000
+#define USBIP_URB_DMA_MAP_PAGE		0x00020000
+#define USBIP_URB_DMA_MAP_SG		0x00040000
+#define USBIP_URB_MAP_LOCAL		0x00080000
+#define USBIP_URB_SETUP_MAP_SINGLE	0x00100000
+#define USBIP_URB_SETUP_MAP_LOCAL	0x00200000
+#define USBIP_URB_DMA_SG_COMBINED	0x00400000
+#define USBIP_URB_ALIGNED_TEMP_BUFFER	0x00800000
+
 #endif /* _UAPI_LINUX_USBIP_H */
-- 
2.34.1

