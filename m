Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97A8F51741B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 18:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386298AbiEBQWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 12:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345155AbiEBQWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 12:22:10 -0400
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3288E0BE;
        Mon,  2 May 2022 09:18:40 -0700 (PDT)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.94.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1nlYkw-00088a-Sx; Mon, 02 May 2022 18:18:39 +0200
Date:   Mon, 2 May 2022 17:18:33 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     linux-block@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Tom Rini <trini@konsulko.com>, Jens Axboe <axboe@kernel.dk>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 3/5] partitions/efi: add support for uImage.FIT sub-partitions
Message-ID: <YnAEWcSCxO+1TXrn@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,PDS_OTHER_BAD_TLD,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new GUID allowing to parse uImage.FIT stored in a GPT partition
and map filesystem sub-image as sub-partitions.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 block/partitions/efi.c | 6 ++++++
 block/partitions/efi.h | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/block/partitions/efi.c b/block/partitions/efi.c
index 5e9be13a56a82a..b8a88601ff5780 100644
--- a/block/partitions/efi.c
+++ b/block/partitions/efi.c
@@ -716,6 +716,7 @@ int efi_partition(struct parsed_partitions *state)
 	gpt_entry *ptes = NULL;
 	u32 i;
 	unsigned ssz = queue_logical_block_size(state->disk->queue) / 512;
+	u32 extra_slot = 64;
 
 	if (!find_valid_gpt(state, &gpt, &ptes) || !gpt || !ptes) {
 		kfree(gpt);
@@ -749,6 +750,11 @@ int efi_partition(struct parsed_partitions *state)
 				ARRAY_SIZE(ptes[i].partition_name));
 		utf16_le_to_7bit(ptes[i].partition_name, label_max, info->volname);
 		state->parts[i + 1].has_info = true;
+		/* If this is a U-Boot FIT volume it may have subpartitions */
+		if (IS_ENABLED(CONFIG_FIT_PARTITION) &&
+		    !efi_guidcmp(ptes[i].partition_type_guid, PARTITION_LINUX_FIT_GUID))
+			(void) parse_fit_partitions(state, start * ssz, size * ssz,
+						    &extra_slot, 127, 1);
 	}
 	kfree(ptes);
 	kfree(gpt);
diff --git a/block/partitions/efi.h b/block/partitions/efi.h
index 84b9f36b9e4797..06c11f6ae3989c 100644
--- a/block/partitions/efi.h
+++ b/block/partitions/efi.h
@@ -51,6 +51,9 @@
 #define PARTITION_LINUX_LVM_GUID \
     EFI_GUID( 0xe6d6d379, 0xf507, 0x44c2, \
               0xa2, 0x3c, 0x23, 0x8f, 0x2a, 0x3d, 0xf9, 0x28)
+#define PARTITION_LINUX_FIT_GUID \
+    EFI_GUID( 0xcae9be83, 0xb15f, 0x49cc, \
+              0x86, 0x3f, 0x08, 0x1b, 0x74, 0x4a, 0x2d, 0x93)
 
 typedef struct _gpt_header {
 	__le64 signature;
-- 
2.36.0

