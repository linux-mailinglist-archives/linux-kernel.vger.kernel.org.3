Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6015718B4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 13:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbiGLLjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 07:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbiGLLjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 07:39:53 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D55AC077;
        Tue, 12 Jul 2022 04:39:51 -0700 (PDT)
Received: from localhost.localdomain (unknown [83.149.199.65])
        by mail.ispras.ru (Postfix) with ESMTPS id 8B01D40737D7;
        Tue, 12 Jul 2022 11:39:43 +0000 (UTC)
From:   Valentina Goncharenko <goncharenko.vp@ispras.ru>
To:     Anil Gurumurthy <anil.gurumurthy@qlogic.com>
Cc:     Valentina Goncharenko <goncharenko.vp@ispras.ru>,
        Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Krishna Gudipati <kgudipat@brocade.com>,
        James Bottomley <JBottomley@Parallels.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: [PATCH] scsi: bfa: Harden loop checks in bfad_iocmd_ioc_get_info()
Date:   Tue, 12 Jul 2022 14:39:13 +0300
Message-Id: <20220712113913.350385-1-goncharenko.vp@ispras.ru>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Loop conditions 'i < BFA_STRING_32' in bfad_iocmd_ioc_get_info() do
not prevent buffer overflow while writing data to
'iocmd->adapter_hwpath[i]' after the loop because on incorrect data
'i' can be incremented anyway.

The patch hardens the loop conditions to avoid buffer overflow in case
of invalid data, while it does not affect the processing of valid
'adapter_hwpath'.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: e6826c96ced7 ("[SCSI] bfa: Add support to read/update the FRU data.")
Signed-off-by: Valentina Goncharenko <goncharenko.vp@ispras.ru>
---
 drivers/scsi/bfa/bfad_bsg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/bfa/bfad_bsg.c b/drivers/scsi/bfa/bfad_bsg.c
index be8dfbe13e90..73ef29c83262 100644
--- a/drivers/scsi/bfa/bfad_bsg.c
+++ b/drivers/scsi/bfa/bfad_bsg.c
@@ -98,9 +98,9 @@ bfad_iocmd_ioc_get_info(struct bfad_s *bfad, void *cmd)
 
 	/* set adapter hw path */
 	strcpy(iocmd->adapter_hwpath, bfad->pci_name);
-	for (i = 0; iocmd->adapter_hwpath[i] != ':' && i < BFA_STRING_32; i++)
+	for (i = 0; iocmd->adapter_hwpath[i] != ':' && i < BFA_STRING_32 - 2; i++)
 		;
-	for (; iocmd->adapter_hwpath[++i] != ':' && i < BFA_STRING_32; )
+	for (; iocmd->adapter_hwpath[++i] != ':' && i < BFA_STRING_32 - 1; )
 		;
 	iocmd->adapter_hwpath[i] = '\0';
 	iocmd->status = BFA_STATUS_OK;
-- 
2.25.1

