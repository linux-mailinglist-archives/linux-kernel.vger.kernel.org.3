Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 704AF534C1B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 10:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346807AbiEZI6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 04:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346797AbiEZI6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 04:58:03 -0400
Received: from mail-m974.mail.163.com (mail-m974.mail.163.com [123.126.97.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 54FB1C5DA3;
        Thu, 26 May 2022 01:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=m9eS1
        TxSHRFd/u36PSumGJaKjxQmnHrPcXPPPIMXmEY=; b=LLsQ2rxbS9QTNaaEI7mhw
        /X+3pCYNIIZuQ+dvwDqHcNhJn5awVvArwcF0zFQDOTitz4GQDoSc6NwyliMUm/vX
        jFy0RZN2qwcj8MioFvGfaewqU6zYK3ROLFaFGEwjONtXrPTlyaDnJR6bvf1lxzfI
        ur8s+Lfat000VTOxzlJaOU=
Received: from localhost.localdomain (unknown [123.112.69.106])
        by smtp4 (Coremail) with SMTP id HNxpCgDnHeP4QI9igxV5EQ--.19625S4;
        Thu, 26 May 2022 16:57:31 +0800 (CST)
From:   Jianglei Nie <niejianglei2021@163.com>
To:     ketan.mukadam@broadcom.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jianglei Nie <niejianglei2021@163.com>
Subject: [PATCH] scsi: be2iscsi: fix potential memory leak in beiscsi_process_mcc_compl()
Date:   Thu, 26 May 2022 16:57:21 +0800
Message-Id: <20220526085721.481202-1-niejianglei2021@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: HNxpCgDnHeP4QI9igxV5EQ--.19625S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7GrykCrW8CFWfJF17Jw43Jrb_yoW3Wwb_ur
        43tr17K39xGFsayr1Fgan8AFZI9FW8Xwn7urWaq34SvFWUurnxXFyDtrn7W3y8Aw4xXFn8
        Jw4Dur1Yyws3XjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRidWrtUUUUU==
X-Originating-IP: [123.112.69.106]
X-CM-SenderInfo: xqlhyxxdqjzvrlsqjii6rwjhhfrp/1tbiPhsNjFxBsWACbgAAsE
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should call free_mcc_wrb() before the function returns.This patch
adds the missing free_mcc_wrb() before the funciton returns.

Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
---
 drivers/scsi/be2iscsi/be_cmds.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/be2iscsi/be_cmds.c b/drivers/scsi/be2iscsi/be_cmds.c
index 69b1a80e3687..d07107a0bf41 100644
--- a/drivers/scsi/be2iscsi/be_cmds.c
+++ b/drivers/scsi/be2iscsi/be_cmds.c
@@ -498,6 +498,7 @@ int beiscsi_process_mcc_compl(struct be_ctrl_info *ctrl,
 		beiscsi_log(phba, KERN_ERR, BEISCSI_LOG_MBOX |
 			    BEISCSI_LOG_INIT | BEISCSI_LOG_CONFIG,
 			    "BC_%d : MBX cmd completed but not posted\n");
+		free_mcc_wrb(ctrl, tag);
 		return 0;
 	}
 
-- 
2.25.1

