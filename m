Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90D855061CF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 03:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343656AbiDSBsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 21:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238998AbiDSBsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 21:48:20 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E9227157;
        Mon, 18 Apr 2022 18:45:40 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id s4so12546382qkh.0;
        Mon, 18 Apr 2022 18:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GWJivJNTrI/QBY9yQIfFHcMB0AyV4j3D2XJyf0B7ai4=;
        b=mdv1a5b5PbDlnJ2HcqHIOXJzFRMhQpMz5W+Dk498yUlyXwZ7v1tmTm1y2oWewJIw0y
         TXkO/RPd+SQHpMGp1XkNqN68WSU0govwAIyUTWfP9pIbEDqtHnrzG6Abagpe3hJX8sWa
         YGoiGUW5gUrqRAVa1yyuhygzzeu8LIY2ibDuZYV2/wmnrwOFFufWfefhaxbb1E/6Abt7
         H3yzKlyeHUzVGh/j81234/NjIk5XEK6Y8a9J95Xiy83djKjdW6v9tDe16VjoDUALTfZQ
         Xh8BCfat9JzApWXIN2L+kqW5jg6XsZ7Nz/POT1caezi4aQW8mebC2Ks1bkW434+4c6Xs
         F8XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GWJivJNTrI/QBY9yQIfFHcMB0AyV4j3D2XJyf0B7ai4=;
        b=LrX0hPxkSu5lgvyD88qtebSbRsJH8p8lFmY5LbD0vFx7ukMo07uQ1f3kdDXg20MqN5
         0JkEvsRkKuLj/GiOGeQZsxlHyi73bmcaH8oUB+S+acBk6Od6BIezhGgMvEAlNejWXEAy
         gofWWzrptu/JFiqGIjCPCKjMMVDnu29viW12Q1uqNM9ImnSfAILCXNPdKrZZUwUT4m5N
         xAbnIm6Ug8dK73q0N2Yzg4Mjnw0aUosjb0XmlspjNcri0wzwZefwwqjpJCF6xKxlQKAk
         dhTkmXIb9H7cs8vMJdygGQZbTKoCH1aMKAhXifiQhdb6+cr4L/VV615SRazdRSuUCZvo
         MhYA==
X-Gm-Message-State: AOAM530VzwsYEmKISICUhfR8NMHURwyHIhyfa2mMOC2EBOMJ6/KDje1q
        XJmUruD65RD6+Y6B9BNYXXfuYH+agic=
X-Google-Smtp-Source: ABdhPJxq3Tg8XW4ePGb4pBEvqZw3CEYQLcz1DA4JnyDIuKKCbLriJjkm2vByc4XsEzVsNdZVPcYTdQ==
X-Received: by 2002:a05:620a:1a0c:b0:69e:c6ee:f8da with SMTP id bk12-20020a05620a1a0c00b0069ec6eef8damr209783qkb.340.1650332739331;
        Mon, 18 Apr 2022 18:45:39 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id f11-20020a05622a1a0b00b002f1f3b66bd4sm5252453qtb.94.2022.04.18.18.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 18:45:38 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: lv.ruyi@zte.com.cn
To:     james.smart@broadcom.com, dick.kennedy@broadcom.com
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lv Ruyi <lv.ruyi@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] scsi: lpfc: fix error check return value of debugfs_create_file()
Date:   Tue, 19 Apr 2022 01:45:26 +0000
Message-Id: <20220419014526.2561899-1-lv.ruyi@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lv Ruyi <lv.ruyi@zte.com.cn>

If an error occurs, debugfs_create_file() will return ERR_PTR(-ERROR),
so use IS_ERR() to check it.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
---
 drivers/scsi/lpfc/lpfc_debugfs.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_debugfs.c b/drivers/scsi/lpfc/lpfc_debugfs.c
index 7b24c932e812..c57f80191b34 100644
--- a/drivers/scsi/lpfc/lpfc_debugfs.c
+++ b/drivers/scsi/lpfc/lpfc_debugfs.c
@@ -6105,7 +6105,7 @@ lpfc_debugfs_initialize(struct lpfc_vport *vport)
 					    phba->hba_debugfs_root,
 					    phba,
 					    &lpfc_debugfs_op_multixripools);
-		if (!phba->debug_multixri_pools) {
+		if (IS_ERR(phba->debug_multixri_pools)) {
 			lpfc_printf_vlog(vport, KERN_ERR, LOG_INIT,
 					 "0527 Cannot create debugfs multixripools\n");
 			goto debug_failed;
@@ -6117,7 +6117,7 @@ lpfc_debugfs_initialize(struct lpfc_vport *vport)
 			debugfs_create_file(name, S_IFREG | 0644,
 					    phba->hba_debugfs_root,
 					    phba, &lpfc_cgn_buffer_op);
-		if (!phba->debug_cgn_buffer) {
+		if (IS_ERR(phba->debug_cgn_buffer)) {
 			lpfc_printf_vlog(vport, KERN_ERR, LOG_INIT,
 					 "6527 Cannot create debugfs "
 					 "cgn_buffer\n");
@@ -6130,7 +6130,7 @@ lpfc_debugfs_initialize(struct lpfc_vport *vport)
 			debugfs_create_file(name, S_IFREG | 0644,
 					    phba->hba_debugfs_root,
 					    phba, &lpfc_rx_monitor_op);
-		if (!phba->debug_rx_monitor) {
+		if (IS_ERR(phba->debug_rx_monitor)) {
 			lpfc_printf_vlog(vport, KERN_ERR, LOG_INIT,
 					 "6528 Cannot create debugfs "
 					 "rx_monitor\n");
@@ -6143,7 +6143,7 @@ lpfc_debugfs_initialize(struct lpfc_vport *vport)
 			debugfs_create_file(name, 0644,
 					    phba->hba_debugfs_root,
 					    phba, &lpfc_debugfs_ras_log);
-		if (!phba->debug_ras_log) {
+		if (IS_ERR(phba->debug_ras_log)) {
 			lpfc_printf_vlog(vport, KERN_ERR, LOG_INIT,
 					 "6148 Cannot create debugfs"
 					 " ras_log\n");
@@ -6164,7 +6164,7 @@ lpfc_debugfs_initialize(struct lpfc_vport *vport)
 			debugfs_create_file(name, S_IFREG | 0644,
 					    phba->hba_debugfs_root,
 					    phba, &lpfc_debugfs_op_lockstat);
-		if (!phba->debug_lockstat) {
+		if (IS_ERR(phba->debug_lockstat)) {
 			lpfc_printf_vlog(vport, KERN_ERR, LOG_INIT,
 					 "4610 Can't create debugfs lockstat\n");
 			goto debug_failed;
@@ -6390,7 +6390,7 @@ lpfc_debugfs_initialize(struct lpfc_vport *vport)
 		debugfs_create_file(name, 0644,
 				    vport->vport_debugfs_root,
 				    vport, &lpfc_debugfs_op_scsistat);
-	if (!vport->debug_scsistat) {
+	if (IS_ERR(vport->debug_scsistat)) {
 		lpfc_printf_vlog(vport, KERN_ERR, LOG_INIT,
 				 "4611 Cannot create debugfs scsistat\n");
 		goto debug_failed;
@@ -6401,7 +6401,7 @@ lpfc_debugfs_initialize(struct lpfc_vport *vport)
 		debugfs_create_file(name, 0644,
 				    vport->vport_debugfs_root,
 				    vport, &lpfc_debugfs_op_ioktime);
-	if (!vport->debug_ioktime) {
+	if (IS_ERR(vport->debug_ioktime)) {
 		lpfc_printf_vlog(vport, KERN_ERR, LOG_INIT,
 				 "0815 Cannot create debugfs ioktime\n");
 		goto debug_failed;
-- 
2.25.1


