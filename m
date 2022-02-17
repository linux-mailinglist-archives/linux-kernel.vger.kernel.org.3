Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83B494BA297
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 15:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241742AbiBQOJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 09:09:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241732AbiBQOJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 09:09:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4897F2B102D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 06:09:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6261D61D04
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 14:09:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 362B9C340E8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 14:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645106955;
        bh=F3zzR2VwUMb39qTVly5v/g0fckTQOAsmJvzdwbrAcck=;
        h=From:To:Subject:Date:From;
        b=krGdQKFcChXTQzgoe2OZGA7w6QPsb1uhgP0rmo/YwdI5pVz1PccH2juDZk9FOo2np
         YrUL/XVJue0oHAH+UGZpXSwjCkBDGBm8fuKJgn9X3JyEfgiCc7Iq9tAwzMGTXkodtw
         QcvaHRXC+FbfwjN5lKPi4yyVD5YK3iux7y976WBhi9SSxOGAOTvWGIonpyz1SWdlxx
         6+v/6NFzUmkGxSSj+3Jn6TClQsd00AgYIaquceNrmqs/E1LKcsEsf6ozOjKXZi3Crh
         VLyKbSWIjDg4L90EjIIhPBoHG/tdXDHlnmbPJzLkKNUtGC8wI+Qd71SnrWIuK6OpPg
         RWfwPXfLA81VQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] habanalabs/gaudi: handle axi errors from NIC engines
Date:   Thu, 17 Feb 2022 16:09:11 +0200
Message-Id: <20220217140912.156824-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various AXI errors can occur in the NIC engines and are reported to
the driver by the f/w. Add code to print the errors and ack them to
the f/w.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 48 +++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index a60c0e23d23c..95201d995743 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -7665,6 +7665,48 @@ static void gaudi_print_fw_alive_info(struct hl_device *hdev,
 		fw_alive->thread_id, fw_alive->uptime_seconds);
 }
 
+static void gaudi_print_nic_axi_irq_info(struct hl_device *hdev, u16 event_type,
+						void *data)
+{
+	char desc[64] = "", *type;
+	struct eq_nic_sei_event *eq_nic_sei = data;
+	u16 nic_id = event_type - GAUDI_EVENT_NIC_SEI_0;
+
+	switch (eq_nic_sei->axi_error_cause) {
+	case RXB:
+		type = "RXB";
+		break;
+	case RXE:
+		type = "RXE";
+		break;
+	case TXS:
+		type = "TXS";
+		break;
+	case TXE:
+		type = "TXE";
+		break;
+	case QPC_RESP:
+		type = "QPC_RESP";
+		break;
+	case NON_AXI_ERR:
+		type = "NON_AXI_ERR";
+		break;
+	case TMR:
+		type = "TMR";
+		break;
+	default:
+		dev_err(hdev->dev, "unknown NIC AXI cause %d\n",
+			eq_nic_sei->axi_error_cause);
+		type = "N/A";
+		break;
+	}
+
+	snprintf(desc, sizeof(desc), "NIC%d_%s%d", nic_id, type,
+			eq_nic_sei->id);
+	dev_err_ratelimited(hdev->dev, "Received H/W interrupt %d [\"%s\"]\n",
+		event_type, desc);
+}
+
 static int gaudi_non_hard_reset_late_init(struct hl_device *hdev)
 {
 	/* GAUDI doesn't support any reset except hard-reset */
@@ -7898,6 +7940,7 @@ static void gaudi_handle_eqe(struct hl_device *hdev,
 				struct hl_eq_entry *eq_entry)
 {
 	struct gaudi_device *gaudi = hdev->asic_specific;
+	u64 data = le64_to_cpu(eq_entry->data[0]);
 	u32 ctl = le32_to_cpu(eq_entry->hdr.ctl);
 	u32 fw_fatal_err_flag = 0;
 	u16 event_type = ((ctl & EQ_CTL_EVENT_TYPE_MASK)
@@ -8095,6 +8138,11 @@ static void gaudi_handle_eqe(struct hl_device *hdev,
 		hl_fw_unmask_irq(hdev, event_type);
 		break;
 
+	case GAUDI_EVENT_NIC_SEI_0 ... GAUDI_EVENT_NIC_SEI_4:
+		gaudi_print_nic_axi_irq_info(hdev, event_type, &data);
+		hl_fw_unmask_irq(hdev, event_type);
+		break;
+
 	case GAUDI_EVENT_DMA_IF_SEI_0 ... GAUDI_EVENT_DMA_IF_SEI_3:
 		gaudi_print_irq_info(hdev, event_type, false);
 		gaudi_print_sm_sei_info(hdev, event_type,
-- 
2.25.1

