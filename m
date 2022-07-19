Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB70579833
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 13:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235923AbiGSLLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 07:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232908AbiGSLLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 07:11:12 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5022FFC8;
        Tue, 19 Jul 2022 04:11:11 -0700 (PDT)
Received: from localhost.localdomain (unknown [83.149.199.65])
        by mail.ispras.ru (Postfix) with ESMTPS id B435F40D4004;
        Tue, 19 Jul 2022 11:11:09 +0000 (UTC)
From:   Andrey Strachuk <strochuk@ispras.ru>
To:     Sathya Prakash <sathya.prakash@broadcom.com>
Cc:     Andrey Strachuk <strochuk@ispras.ru>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Chaitra P B <chaitra.basappa@broadcom.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
Subject: [PATCH] scsi: mpt3sas: remove useless comparisons in _base_get_chain_buffer_dma_to_chain_buffer(), _base_release_memory_pools()
Date:   Tue, 19 Jul 2022 14:11:04 +0300
Message-Id: <20220719111104.7554-1-strochuk@ispras.ru>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Local variable 'ct' is initialized by an address
of field of MPT3SAS_ADAPTER structure, so it does
not make sense to compare 'ct' with NULL.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Andrey Strachuk <strochuk@ispras.ru>
Fixes: 93204b782a88 ("scsi: mpt3sas: Lockless access for chain buffers.")
---
 drivers/scsi/mpt3sas/mpt3sas_base.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 9a1ae52bb621..dead0f7d4d9e 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -396,7 +396,7 @@ _base_get_chain_buffer_dma_to_chain_buffer(struct MPT3SAS_ADAPTER *ioc,
 	for (index = 0; index < ioc->scsiio_depth; index++) {
 		for (j = 0; j < ioc->chains_needed_per_io; j++) {
 			ct = &ioc->chain_lookup[index].chains_per_smid[j];
-			if (ct && ct->chain_buffer_dma == chain_buffer_dma)
+			if (ct->chain_buffer_dma == chain_buffer_dma)
 				return ct->chain_buffer;
 		}
 	}
@@ -5699,7 +5699,7 @@ _base_release_memory_pools(struct MPT3SAS_ADAPTER *ioc)
 			for (j = ioc->chains_per_prp_buffer;
 			    j < ioc->chains_needed_per_io; j++) {
 				ct = &ioc->chain_lookup[i].chains_per_smid[j];
-				if (ct && ct->chain_buffer)
+				if (ct->chain_buffer)
 					dma_pool_free(ioc->chain_dma_pool,
 						ct->chain_buffer,
 						ct->chain_buffer_dma);
-- 
2.25.1

