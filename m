Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E4B4C85E7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 09:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233188AbiCAIFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 03:05:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232982AbiCAIFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 03:05:34 -0500
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F2880917;
        Tue,  1 Mar 2022 00:04:53 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R361e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0V5vuZaA_1646121890;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V5vuZaA_1646121890)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 01 Mar 2022 16:04:50 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     jejb@linux.ibm.com
Cc:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] scsi: Remove ignoring unreachable code warning
Date:   Tue,  1 Mar 2022 16:04:48 +0800
Message-Id: <20220301080448.112813-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The smatch tool reported the following warning:
drivers/scsi/scsi_error.c:1988 scsi_decide_disposition() warn: ignoring
unreachable code.

Remove the "default:return FAILED;" instead of "return FAILED;" reported
by smatch, because compilers can provide more useful diagnostics about
switch/case statements that do not have a default statement, especially
if the "switch" applies to a value with enumeration type.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/scsi/scsi_error.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index 9c237b223e63..ee752b4512f8 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -1982,8 +1982,6 @@ enum scsi_disposition scsi_decide_disposition(struct scsi_cmnd *scmd)
 			    "reservation conflict\n");
 		set_host_byte(scmd, DID_NEXUS_FAILURE);
 		return SUCCESS; /* causes immediate i/o error */
-	default:
-		return FAILED;
 	}
 	return FAILED;
 
-- 
2.20.1.7.g153144c

