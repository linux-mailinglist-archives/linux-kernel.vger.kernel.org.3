Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5E65951EE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 07:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbiHPFX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 01:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbiHPFXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 01:23:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342EBC13;
        Mon, 15 Aug 2022 14:51:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C61F0B811C1;
        Mon, 15 Aug 2022 21:51:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18BC8C433C1;
        Mon, 15 Aug 2022 21:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660600302;
        bh=ort1VpN7VBYM3KDJV+dEWBj27en+cZk8wTHPLkd0HQ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V6MMkkaJ4eu1Xty7dVN4Dk3/poYM21tH0ERMKZ1HEZ3rCVFQ34+mKM/z5TNNjqVNP
         SM3BvLgiKvUSI/D0tqaXAbvFnLbQRXsW92v02sJP4BYFkAVkeSCr4cyGQrhkGDed4k
         Aea+grLX2CwBcgAM76z9JUgJUbiEbk91+5BSqUoYevGqeOMUTJo+2pKtcko+/Qcl9p
         leqrt7ct/k3/zjATZ3JeqTXHqpLVvcd4GngjNDMDPpl7YdyBTsZsOBvH2CCFHDai5n
         WgxpqBJ8mq8tHgXhyZU2n0zj7TxZMyRo2PKWp3zYgzKUYwOM+wfsYlqWe5GAHy2Rv2
         5icoHVkKXRNQQ==
Date:   Mon, 15 Aug 2022 16:51:36 -0500
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
Subject: [PATCH v3 5/6] scsi: megaraid_sas: Use struct_size() in code related
 to struct MR_FW_RAID_MAP
Message-ID: <1211398fb8f7ab332a93f4f8f1a63e8168dbd002.1660592640.git.gustavoars@kernel.org>
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

Prefer struct_size() over open-coded versions of idiom:

	sizeof(struct-with-flex-array) + sizeof(type-of-flex-array) * count

where count is the max number of items the flexible array is supposed to
have.

Link: https://github.com/KSPP/linux/issues/160
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v3:
 - This patch is new in the series.

 drivers/scsi/megaraid/megaraid_sas_base.c | 6 +++---
 drivers/scsi/megaraid/megaraid_sas_fp.c   | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 2dabe0b4823e..09eef1bef430 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -5157,9 +5157,9 @@ static void megasas_update_ext_vd_details(struct megasas_instance *instance)
 		fusion->current_map_sz = ventura_map_sz;
 		fusion->max_map_sz = ventura_map_sz;
 	} else {
-		fusion->old_map_sz =  sizeof(struct MR_FW_RAID_MAP) +
-					(sizeof(struct MR_LD_SPAN_MAP) *
-					instance->fw_supported_vd_count);
+		fusion->old_map_sz =
+			struct_size((struct MR_FW_RAID_MAP *)0, ldSpanMap,
+				    instance->fw_supported_vd_count);
 		fusion->new_map_sz =  sizeof(struct MR_FW_RAID_MAP_EXT);
 
 		fusion->max_map_sz =
diff --git a/drivers/scsi/megaraid/megaraid_sas_fp.c b/drivers/scsi/megaraid/megaraid_sas_fp.c
index b2ec7a3f7650..da1cad1ee123 100644
--- a/drivers/scsi/megaraid/megaraid_sas_fp.c
+++ b/drivers/scsi/megaraid/megaraid_sas_fp.c
@@ -326,9 +326,9 @@ u8 MR_ValidateMapInfo(struct megasas_instance *instance, u64 map_id)
 	else if (instance->supportmax256vd)
 		expected_size = sizeof(struct MR_FW_RAID_MAP_EXT);
 	else
-		expected_size =
-			(sizeof(struct MR_FW_RAID_MAP) +
-			(sizeof(struct MR_LD_SPAN_MAP) * le16_to_cpu(pDrvRaidMap->ldCount)));
+		expected_size = struct_size((struct MR_FW_RAID_MAP *)0,
+					    ldSpanMap,
+					    le16_to_cpu(pDrvRaidMap->ldCount));
 
 	if (le32_to_cpu(pDrvRaidMap->totalSize) != expected_size) {
 		dev_dbg(&instance->pdev->dev, "megasas: map info structure size 0x%x",
-- 
2.34.1

