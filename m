Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA1C9594E54
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 03:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbiHPB5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 21:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234005AbiHPB4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 21:56:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6301215F25;
        Mon, 15 Aug 2022 14:49:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E9E4FB811FF;
        Mon, 15 Aug 2022 21:49:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65C45C433D6;
        Mon, 15 Aug 2022 21:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660600184;
        bh=iy8yfgUtW5RIairW73K6gX9n22ly4FXl8t5qBi7ddOo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rFt1IIJhqPlHgnpNOeIr+MPhNFfGhte0Zuu8KuNySaxxuMZltDyq7TnXBKkM6Qood
         MCGefbwkTKeOfwL0+2Z8YHP5dzn06G/XmOGS2Kh6/QqIcuFx8PBeewhSLMpZPxq2pq
         QJCKnDFAL/5bsBQUZlrQz9GiP5YfwxUuILPhpLuhQs6EfHcPjhdql23ZWms6KGsOmO
         vHI01dtZmtoeUqaKwdnAtNlricdh5evSZiUMRmuQSuHvB9ZvB8kgKzkYTCLFMJ6dMH
         M0rcFYT4/ukCe/W5wx7Oy7CreXU5NgaEIKQuC2lnNfC+CCpuucWx9rxDn3gduat6Qe
         26fwhOCEuFbMA==
Date:   Mon, 15 Aug 2022 16:49:38 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH v3 4/6] scsi: megaraid_sas: Replace one-element array with
 flexible-array member in MR_PD_CFG_SEQ_NUM_SYNC
Message-ID: <78e9261591db072b67fcf49f0216d7046a67ca6d.1660592640.git.gustavoars@kernel.org>
References: <cover.1660592640.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1660592640.git.gustavoars@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One-element arrays are deprecated, and we are replacing them with
flexible array members, instead. So, replace one-element array with
flexible-array member in struct MR_PD_CFG_SEQ_NUM_SYNC and refactor
the rest of the code accordingly.

This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
routines on memcpy() and help us make progress towards globally
enabling -fstrict-flex-arrays [0].

Link: https://github.com/KSPP/linux/issues/79
Link: https://github.com/KSPP/linux/issues/109
Link: Link: https://reviews.llvm.org/D126864 [0]
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v3:
 - Revert use of struct_size() helper.

Changes in v2:
 - None.

 drivers/scsi/megaraid/megaraid_sas_base.c   | 4 ++--
 drivers/scsi/megaraid/megaraid_sas_fusion.c | 2 +-
 drivers/scsi/megaraid/megaraid_sas_fusion.h | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index c06a346a3eaf..2dabe0b4823e 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -5795,7 +5795,7 @@ megasas_setup_jbod_map(struct megasas_instance *instance)
 	u32 pd_seq_map_sz;
 
 	pd_seq_map_sz = sizeof(struct MR_PD_CFG_SEQ_NUM_SYNC) +
-		(sizeof(struct MR_PD_CFG_SEQ) * (MAX_PHYSICAL_DEVICES - 1));
+		(sizeof(struct MR_PD_CFG_SEQ) * MAX_PHYSICAL_DEVICES);
 
 	instance->use_seqnum_jbod_fp =
 		instance->support_seqnum_jbod_fp;
@@ -8048,7 +8048,7 @@ static void megasas_detach_one(struct pci_dev *pdev)
 		megasas_release_fusion(instance);
 		pd_seq_map_sz = sizeof(struct MR_PD_CFG_SEQ_NUM_SYNC) +
 				(sizeof(struct MR_PD_CFG_SEQ) *
-					(MAX_PHYSICAL_DEVICES - 1));
+					MAX_PHYSICAL_DEVICES);
 		for (i = 0; i < 2 ; i++) {
 			if (fusion->ld_map[i])
 				dma_free_coherent(&instance->pdev->dev,
diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.c b/drivers/scsi/megaraid/megaraid_sas_fusion.c
index e48d4261d0bc..f17ec83f7c98 100644
--- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
+++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
@@ -1310,7 +1310,7 @@ megasas_sync_pd_seq_num(struct megasas_instance *instance, bool pend) {
 
 	pd_sync = (void *)fusion->pd_seq_sync[(instance->pd_seq_map_id & 1)];
 	pd_seq_h = fusion->pd_seq_phys[(instance->pd_seq_map_id & 1)];
-	pd_seq_map_sz = struct_size(pd_sync, seq, MAX_PHYSICAL_DEVICES - 1);
+	pd_seq_map_sz = struct_size(pd_sync, seq, MAX_PHYSICAL_DEVICES);
 
 	cmd = megasas_get_cmd(instance);
 	if (!cmd) {
diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.h b/drivers/scsi/megaraid/megaraid_sas_fusion.h
index df92d4369e04..49e9a9048ee7 100644
--- a/drivers/scsi/megaraid/megaraid_sas_fusion.h
+++ b/drivers/scsi/megaraid/megaraid_sas_fusion.h
@@ -1249,7 +1249,7 @@ struct MR_PD_CFG_SEQ {
 struct MR_PD_CFG_SEQ_NUM_SYNC {
 	__le32 size;
 	__le32 count;
-	struct MR_PD_CFG_SEQ seq[1];
+	struct MR_PD_CFG_SEQ seq[];
 } __packed;
 
 /* stream detection */
-- 
2.34.1

