Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBC6594E1C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 03:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233009AbiHPBt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 21:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233512AbiHPBs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 21:48:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD992036B9;
        Mon, 15 Aug 2022 14:40:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 22186B811FE;
        Mon, 15 Aug 2022 21:40:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBA9DC433D7;
        Mon, 15 Aug 2022 21:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660599644;
        bh=s1ysBUarhjxYEJL4ryDgOKJSJUjnZCoo74clBKJ7yNs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W9PFrRzkfJnI6SrnWoCVG5SqJNhu1B5NEPoyhp8D91e3ogQKqwHXEqkt90ffhnXlf
         qJMqJ+FDHdOWOYTENMc3DRbWLuMOa2ngAdL1NIss/wvQvBG8G6ua1oWpSM+/vq7tj2
         81JiienoY6xTd5A2JSjUpSu4Zn1YPyP94sam4qHJ7H98nGEu0iYXhRfFuN0pAYq/Vd
         42j2Q5hlQ6I0r9jpzaXgaETDQ1riXTBdlNKl/oO2wSa+CXNNcLiPnpe/V4oyVF8HpQ
         1NfBSGb2nz1mGZ7hiVdDiZBB32PIYjax4U3xXdATGhdHbN7FdEc4PWHO4Gwq1ZmhJu
         rMCdU5/i2ZUNA==
Date:   Mon, 15 Aug 2022 16:40:35 -0500
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
Subject: [PATCH v3 1/6] scsi: megaraid_sas: Replace one-element array with
 flexible-array member in MR_FW_RAID_MAP
Message-ID: <4495ce170c8ef088a10f1abe0e7c227368f43242.1660592640.git.gustavoars@kernel.org>
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
flexible-array member in struct MR_DRV_RAID_MAP and refactor the
the rest of the code accordingly.

This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
routines on memcpy().

Link: https://github.com/KSPP/linux/issues/79
Link: https://github.com/KSPP/linux/issues/109
Enhanced-by: Kees Cook <keescook@chromium.org> # Change in struct MR_FW_RAID_MAP_ALL
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v3:
 - Modify MR_FW_RAID_MAP_ALL structures.
 - Revert use of struct_size() helper.

Changes in v2:
 - Update Subject line and changelog text.

 drivers/scsi/megaraid/megaraid_sas_base.c   | 2 +-
 drivers/scsi/megaraid/megaraid_sas_fp.c     | 2 +-
 drivers/scsi/megaraid/megaraid_sas_fusion.h | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index a3e117a4b8e7..c06a346a3eaf 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -5159,7 +5159,7 @@ static void megasas_update_ext_vd_details(struct megasas_instance *instance)
 	} else {
 		fusion->old_map_sz =  sizeof(struct MR_FW_RAID_MAP) +
 					(sizeof(struct MR_LD_SPAN_MAP) *
-					(instance->fw_supported_vd_count - 1));
+					instance->fw_supported_vd_count);
 		fusion->new_map_sz =  sizeof(struct MR_FW_RAID_MAP_EXT);
 
 		fusion->max_map_sz =
diff --git a/drivers/scsi/megaraid/megaraid_sas_fp.c b/drivers/scsi/megaraid/megaraid_sas_fp.c
index 83f69c33b01a..b2ec7a3f7650 100644
--- a/drivers/scsi/megaraid/megaraid_sas_fp.c
+++ b/drivers/scsi/megaraid/megaraid_sas_fp.c
@@ -327,7 +327,7 @@ u8 MR_ValidateMapInfo(struct megasas_instance *instance, u64 map_id)
 		expected_size = sizeof(struct MR_FW_RAID_MAP_EXT);
 	else
 		expected_size =
-			(sizeof(struct MR_FW_RAID_MAP) - sizeof(struct MR_LD_SPAN_MAP) +
+			(sizeof(struct MR_FW_RAID_MAP) +
 			(sizeof(struct MR_LD_SPAN_MAP) * le16_to_cpu(pDrvRaidMap->ldCount)));
 
 	if (le32_to_cpu(pDrvRaidMap->totalSize) != expected_size) {
diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.h b/drivers/scsi/megaraid/megaraid_sas_fusion.h
index ce84f811e5e1..5530c233fccb 100644
--- a/drivers/scsi/megaraid/megaraid_sas_fusion.h
+++ b/drivers/scsi/megaraid/megaraid_sas_fusion.h
@@ -942,7 +942,7 @@ struct MR_FW_RAID_MAP {
 	u8                  reserved2[7];
 	struct MR_ARRAY_INFO       arMapInfo[MAX_RAIDMAP_ARRAYS];
 	struct MR_DEV_HANDLE_INFO  devHndlInfo[MAX_RAIDMAP_PHYSICAL_DEVICES];
-	struct MR_LD_SPAN_MAP      ldSpanMap[1];
+	struct MR_LD_SPAN_MAP      ldSpanMap[];
 };
 
 struct IO_REQUEST_INFO {
@@ -1148,7 +1148,7 @@ typedef struct LOG_BLOCK_SPAN_INFO {
 
 struct MR_FW_RAID_MAP_ALL {
 	struct MR_FW_RAID_MAP raidMap;
-	struct MR_LD_SPAN_MAP ldSpanMap[MAX_LOGICAL_DRIVES - 1];
+	struct MR_LD_SPAN_MAP ldSpanMap[MAX_LOGICAL_DRIVES];
 } __attribute__ ((packed));
 
 struct MR_DRV_RAID_MAP {
-- 
2.34.1

