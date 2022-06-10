Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75EC0546647
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 14:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347915AbiFJMH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 08:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240337AbiFJMH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 08:07:58 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7F05C3F892;
        Fri, 10 Jun 2022 05:07:55 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 424E11E80D6E;
        Fri, 10 Jun 2022 20:07:09 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xn3Z_1SjwQcY; Fri, 10 Jun 2022 20:07:06 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: zhounan@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 87C5F1E80D24;
        Fri, 10 Jun 2022 20:07:06 +0800 (CST)
From:   zhoun <zhounan@nfschina.com>
To:     martin.petersen@oracle.com, jejb@linux.ibm.com,
        dick.kennedy@broadcom.com, james.smart@broadcom.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhoun <zhounan@nfschina.com>
Subject: [PATCH] driver:Change the return value to void and add the parameter name to lpfc_hba_down_prep
Date:   Fri, 10 Jun 2022 08:07:49 -0400
Message-Id: <20220610120749.82272-1-zhounan@nfschina.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Optimize unused integer return values, add the parameter name to the 
function lpfc_hba_down_prep header file.

Signed-off-by: zhoun <zhounan@nfschina.com>

 Committer: zhoun <zhounan@nfschina.com>
---
 drivers/scsi/lpfc/lpfc_crtn.h | 2 +-
 drivers/scsi/lpfc/lpfc_init.c | 6 ++----
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_crtn.h b/drivers/scsi/lpfc/lpfc_crtn.h
index b1be0dd0337a..5f7bfbfd7cad 100644
--- a/drivers/scsi/lpfc/lpfc_crtn.h
+++ b/drivers/scsi/lpfc/lpfc_crtn.h
@@ -212,7 +212,7 @@ int lpfc_config_port_prep(struct lpfc_hba *);
 void lpfc_update_vport_wwn(struct lpfc_vport *vport);
 int lpfc_config_port_post(struct lpfc_hba *);
 int lpfc_sli4_refresh_params(struct lpfc_hba *phba);
-int lpfc_hba_down_prep(struct lpfc_hba *);
+void lpfc_hba_down_prep(struct lpfc_hba *phba);
 int lpfc_hba_down_post(struct lpfc_hba *);
 void lpfc_hba_init(struct lpfc_hba *, uint32_t *);
 int lpfc_sli3_post_buffer(struct lpfc_hba *phba, struct lpfc_sli_ring *pring, int cnt);
diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index 93b94c64518d..2439c474eddc 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -872,10 +872,9 @@ lpfc_hba_down_link(struct lpfc_hba *phba, uint32_t flag)
  * bringing down the SLI Layer.
  *
  * Return codes
- *   0 - success.
- *   Any other value - error.
+ *   void.
  **/
-int
+void
 lpfc_hba_down_prep(struct lpfc_hba *phba)
 {
 	struct lpfc_vport **vports;
@@ -897,7 +896,6 @@ lpfc_hba_down_prep(struct lpfc_hba *phba)
 				lpfc_cleanup_discovery_resources(vports[i]);
 		lpfc_destroy_vport_work_array(phba, vports);
 	}
-	return 0;
 }
 
 /**
-- 
2.27.0

