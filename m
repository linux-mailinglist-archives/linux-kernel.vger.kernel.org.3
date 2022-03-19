Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 945024DE64F
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 06:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242208AbiCSFjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 01:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbiCSFjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 01:39:10 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A62A2E8CCC;
        Fri, 18 Mar 2022 22:37:50 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id kx13-20020a17090b228d00b001c6715c9847so7647074pjb.1;
        Fri, 18 Mar 2022 22:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=Omp7vR9UcPrhGXZZpNbngBh0wCNzl1wDtEI82prc/lc=;
        b=bmoGxWaTYLUaMlvx9G+VUSqVIpABDwNeQ6kj69pe7fDdPWNC1730AzbZ6sdkLWxsj7
         3h19relKK8LCaFodHpJok4FaIVBShCEi5Vb9m16cx2f1XDHy2CIH+omY0gpDv9eW8dGY
         ifxt5y+r/s2NvLvmGm170cjMXuYgIyBUqWhCc42r8EMHKHk/hr19mSl/sm8bfsrv1PkC
         oJNdw35AUuMTB89eiNFzhqIC99Itsorj2mL4zDSl+os7nS1LbYwEpUF9kEonMDCzcpqG
         NqXqH4uslvUCu+uae1f4NhFRavZSbCVE2Mb9k/LeuAKMZbsQ26pBwDYnIgdAVNNPN+UE
         +XIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Omp7vR9UcPrhGXZZpNbngBh0wCNzl1wDtEI82prc/lc=;
        b=d17LHz3INK7RrPHRRoRcl0OrWgj0/oFwYjou0c2FjZnvZh9tGLn30qAHq3GczD8wE/
         Y9T3EBnilunOgCi1R/7SyOn1etiy/zFu9OQnI25NJPMVpq4Rd59XHBTzxpfV983PGiZv
         ZmPIFKWRClZcCQ3fqrEOhLloIqJ92fTswpX2lVG56iN0Vnk0VWI0MYJb7imdLlGnLuha
         vWCIjwfxHJc+Fb8Sjp+2t1KkpDGR/V73nL287HtW1HsUv9i5ncdvZGQxkfDalJfGMHl/
         d9mX2q3CegNzmbnHg9fwJ+ha23pgNWG+NbdqRzRN7ABbepKo718TwSVVbXm+KN/jyvg/
         fGsw==
X-Gm-Message-State: AOAM532xf4NfSqY5mbucH7v6RZCwE3ilVkrZPlONVPpp2qzF8Rpquc5d
        HqPzcRm4MrobvuvFX6EmFeAwo1rZ0W2j8g==
X-Google-Smtp-Source: ABdhPJzWPl4fvH7MhTUKr8+OP7pIxF32LhVhaVTDL+8BTSSKSXDiGaWfO+6tvSc2yzEIgXeaOSnLtg==
X-Received: by 2002:a17:902:c215:b0:153:8d90:a108 with SMTP id 21-20020a170902c21500b001538d90a108mr3025086pll.172.1647668269923;
        Fri, 18 Mar 2022 22:37:49 -0700 (PDT)
Received: from ubuntu.huawei.com ([119.3.119.18])
        by smtp.googlemail.com with ESMTPSA id b21-20020a17090a551500b001b90ef40301sm10417101pji.22.2022.03.18.22.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 22:37:49 -0700 (PDT)
From:   Xiaomeng Tong <xiam0nd.tong@gmail.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     skashyap@marvell.com, jhasan@marvell.com,
        GR-QLogic-Storage-Upstream@marvell.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Xiaomeng Tong <xiam0nd.tong@gmail.com>
Subject: [PATCH] qedf: remove an unneeded NULL check on list iterator
Date:   Sat, 19 Mar 2022 13:37:42 +0800
Message-Id: <20220319053742.27443-1-xiam0nd.tong@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The list iterator 'fcport' is always non-NULL so it doesn't need to be
checked. Thus just remove the unnecessary NULL check. Also remove the
unnecessary initializer because the list iterator is always initialized.
And adjust the position of blank lines.

Signed-off-by: Xiaomeng Tong <xiam0nd.tong@gmail.com>
---
 drivers/scsi/qedf/qedf_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/qedf/qedf_main.c b/drivers/scsi/qedf/qedf_main.c
index 6ad28bc8e948..1bfa30983b92 100644
--- a/drivers/scsi/qedf/qedf_main.c
+++ b/drivers/scsi/qedf/qedf_main.c
@@ -873,7 +873,7 @@ static int qedf_eh_device_reset(struct scsi_cmnd *sc_cmd)
 
 bool qedf_wait_for_upload(struct qedf_ctx *qedf)
 {
-	struct qedf_rport *fcport = NULL;
+	struct qedf_rport *fcport;
 	int wait_cnt = 120;
 
 	while (wait_cnt--) {
@@ -888,7 +888,7 @@ bool qedf_wait_for_upload(struct qedf_ctx *qedf)
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(fcport, &qedf->fcports, peers) {
-		if (fcport && test_bit(QEDF_RPORT_SESSION_READY,
+		if (test_bit(QEDF_RPORT_SESSION_READY,
 				       &fcport->flags)) {
 			if (fcport->rdata)
 				QEDF_ERR(&qedf->dbg_ctx,
@@ -899,9 +899,9 @@ bool qedf_wait_for_upload(struct qedf_ctx *qedf)
 					 "Waiting for fcport %p.\n", fcport);
 			}
 	}
+
 	rcu_read_unlock();
 	return false;
-
 }
 
 /* Performs soft reset of qedf_ctx by simulating a link down/up */
-- 
2.17.1

