Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77693585A78
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 14:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234574AbiG3MpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 08:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbiG3MpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 08:45:14 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37CEAFE4;
        Sat, 30 Jul 2022 05:45:13 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id u14-20020a05600c00ce00b003a323062569so3587847wmm.4;
        Sat, 30 Jul 2022 05:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5V7yy3Fmup+pYyriDzMsJyQM+/qWSBJZ45fKEFQtWmQ=;
        b=CWFVOzsiXZ84nOPjSpwH48rFBN9RBU+WsMQEPFg9wdo4V0S/bLEQ5+8jTgtSxWLuAS
         zMSKcZVRubqBoIfbOQadPra6RtmmEcXpQNrtm5MyK++O4Qcqm1F3+DLOtK3+vyEouBa0
         h2ExV3rrYmkJ1Ipd597RXJJxd7xhD9SdcAMS4gjvfpqRUpuWYWyslv0hQfQwV197Jdrn
         lvbwmrM05MqAZ+2A+F5+QCE4/DLbq1W+MnEqwBlCw95OTTK9bwQHPNblv4+o62txMSx9
         jodkyjgZfW8ZzDIOkqfQG736zXO+sSC45xJmtmkCZhTPg8YdcU2aXYL+5+7f8WLMdi4n
         5XIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5V7yy3Fmup+pYyriDzMsJyQM+/qWSBJZ45fKEFQtWmQ=;
        b=udygBWKP16owt7chsvNHgbBYx/G51kaFg0UBoN5VRDEfWH4cZEfqrghGF6oIR2zXt0
         6KD0BeyEVPFni1Tu8HYrKhM/MTeQa3Fw7IrG1jDazWCJScV6+FToHVVW4+o0bc1BlNXL
         bOg5WwNZiY7xJIIzIjTrvs4t4DtdkzekVOoi17IcV01ntsj4LvPTOWT0nO8t+gUt8FI2
         CXoQiwMYmscWtjh80227MHy5kP/Sw/ZDxqB4qthMO7tUIPIhks5fC/u9//x2Mbks6EAZ
         8z/zHBZqV0Fq3xHwrA6Kb7iukreWgKdjlomjzyOfmJvFGOblRwr8/+9DYtsPPD51tv9G
         34RA==
X-Gm-Message-State: AJIora/2MxDWZPZNDfxp3a0irP84op/fJkqdGmRVFBVjzruqBjiHpGbi
        2ON0Z/G0HLQ0nHioOx0qc08=
X-Google-Smtp-Source: AGRyM1vEcF6AuiQcryAUY16yJi+dFX5SAzWfBNH9PhOwhqKHDPEaRqSOqCMSICFZLJVhihtlPFkjdw==
X-Received: by 2002:a05:600c:1c83:b0:3a3:2631:2fec with SMTP id k3-20020a05600c1c8300b003a326312fecmr5291533wms.155.1659185111436;
        Sat, 30 Jul 2022 05:45:11 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id t11-20020a5d690b000000b0021d65e9d449sm6139659wru.73.2022.07.30.05.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jul 2022 05:45:10 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: megaraid_sas: remove redundant variable cmd_type
Date:   Sat, 30 Jul 2022 13:45:09 +0100
Message-Id: <20220730124509.148457-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable cmd_type is assigned a value but it is never read. The
variable and the assignment are redundant and can be removed.

Cleans up clang scan build warning:
drivers/scsi/megaraid/megaraid_sas_fusion.c:3228:10: warning: Although
the value stored to 'cmd_type' is used in the enclosing expression, the
value is never actually read from 'cmd_type' [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/scsi/megaraid/megaraid_sas_fusion.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.c b/drivers/scsi/megaraid/megaraid_sas_fusion.c
index 5b5885d9732b..e48d4261d0bc 100644
--- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
+++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
@@ -3199,7 +3199,6 @@ megasas_build_io_fusion(struct megasas_instance *instance,
 			struct megasas_cmd_fusion *cmd)
 {
 	int sge_count;
-	u8  cmd_type;
 	u16 pd_index = 0;
 	u8 drive_type = 0;
 	struct MPI2_RAID_SCSI_IO_REQUEST *io_request = cmd->io_request;
@@ -3225,7 +3224,7 @@ megasas_build_io_fusion(struct megasas_instance *instance,
 	 */
 	io_request->IoFlags = cpu_to_le16(scp->cmd_len);
 
-	switch (cmd_type = megasas_cmd_type(scp)) {
+	switch (megasas_cmd_type(scp)) {
 	case READ_WRITE_LDIO:
 		megasas_build_ldio_fusion(instance, scp, cmd);
 		break;
-- 
2.35.3

