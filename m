Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDD0F4F212B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 06:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiDECWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 22:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiDECWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 22:22:42 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD5932B71A;
        Mon,  4 Apr 2022 18:18:07 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id c2so9729378pga.10;
        Mon, 04 Apr 2022 18:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=Omp7vR9UcPrhGXZZpNbngBh0wCNzl1wDtEI82prc/lc=;
        b=l3j45LxcbX7a8DtGlzz0bIJayPR/GJ2s6RfW8uOP/QIlJMraZy2O+Kmn5S2r8+qBpI
         67JhUesmg5tu0iDmRWfMd26c9vaEiWG1GzVgB8D0GhezBF3OwAblyuvMgITynsUgngyq
         QifFjDEylAmb9Sru2YJqugzY9hg2dcBWk2B4a3+1wGJaiXmRyQsE+k0tBCOh35eszHz9
         qA6bYJdF/HSgZFPq02AyLQ0TCOfUfQdhFjYDMOeZK7P82Zl1wRRLFUzhGV9EUxBUidoa
         6gCBpyKTjl1p2e4zn5VtjiRJfSs8FqrBhknf8TiYIrmx4GjKmhWbg5NlKCTVfF7otx0P
         wS/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Omp7vR9UcPrhGXZZpNbngBh0wCNzl1wDtEI82prc/lc=;
        b=a9MIY33YCFkCwhXsbcMF0yZ9u6wI1OsgC8WIe1FN5HGufZCQxlLBxs9G/V6LYxSPDL
         OmicO/MP3XAQVMOu/T0/sHchqohW0FSVHPFlX0QulXuSqCNKiclMTn24tRyYEE/AypG/
         JtiJuCaIXDdwdnPPdtk+cxIh7dvNQ6J0TkXjlcTsYzi2Dxjmr2dhF2bh5CNe82tq/K12
         Dfk7LvIofBtBDWK+v1tE2RiNejizH091/mfsYOLZaf8EXvhEHy8+OvoWRkd2u7oHAy9O
         sOUAHQP/w954devI796PRO0C2Bj9wXI3zkKCFT3aNU+tbrTeqKmr8P6ZWCBGf9gxkxtO
         u3Tw==
X-Gm-Message-State: AOAM5334jFp9J8Av2gjPwKs7c4YjF/ntewZa+FOUIN8toSNoZPQ0wlG/
        YPfuyuUsqYhDA6W2YnRE9raaEz9cDeEN7Q==
X-Google-Smtp-Source: ABdhPJxi6rRjA8yOmB9/9d3CiWfGIN1cdOyOXy+4QUPxG4RsSOAp+6eYgL3tNrArAjdSKdutIP1ONA==
X-Received: by 2002:a63:1d07:0:b0:398:e6d3:8e22 with SMTP id d7-20020a631d07000000b00398e6d38e22mr692165pgd.8.1649119270145;
        Mon, 04 Apr 2022 17:41:10 -0700 (PDT)
Received: from localhost.localdomain ([183.156.181.188])
        by smtp.gmail.com with ESMTPSA id ay9-20020a056a00300900b004fae1346aa1sm12589179pfb.122.2022.04.04.17.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 17:41:09 -0700 (PDT)
From:   Xiaomeng Tong <xiam0nd.tong@gmail.com>
To:     skashyap@marvell.com, jhasan@marvell.com,
        GR-QLogic-Storage-Upstream@marvell.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiaomeng Tong <xiam0nd.tong@gmail.com>
Subject: [RESEND][PATCH] qedf: remove an unneeded NULL check on list iterator
Date:   Tue,  5 Apr 2022 08:40:55 +0800
Message-Id: <20220405004055.24312-1-xiam0nd.tong@gmail.com>
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

