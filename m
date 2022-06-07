Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6D1053F73B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 09:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237683AbiFGHaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 03:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237692AbiFGHaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 03:30:03 -0400
Received: from mail-m974.mail.163.com (mail-m974.mail.163.com [123.126.97.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7155953B76;
        Tue,  7 Jun 2022 00:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=AeuvP
        075pkaXohWflYA9Hvu9tYjnfSsAjnEerCqcRCs=; b=MPOTprpdboyRMepxjN7mB
        Jgc8l5b4Kq8IcjVZhOimD7UiJzePkbPOMiGI7Qeyg9OaJtvO+C5bYyyh+bMvyPI4
        xsnWicdRW6Boz/oNJfCJztXHQ0llO5Qbhlyg5LhvSNNWfKFPq3FBaFfG+sOq+0N9
        1DLXMX7aC3e0pFQmjUL0Qg=
Received: from localhost.localdomain (unknown [123.112.69.106])
        by smtp4 (Coremail) with SMTP id HNxpCgAn9eZo_p5itp_HGw--.8526S4;
        Tue, 07 Jun 2022 15:29:50 +0800 (CST)
From:   Jianglei Nie <niejianglei2021@163.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jianglei Nie <niejianglei2021@163.com>
Subject: [PATCH] scsi: csiostor: Fix memory leak in csio_wr_eq_destroy()
Date:   Tue,  7 Jun 2022 15:29:42 +0800
Message-Id: <20220607072942.431988-1-niejianglei2021@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: HNxpCgAn9eZo_p5itp_HGw--.8526S4
X-Coremail-Antispam: 1Uf129KBjvdXoWruF4fZryfJr4ftF43CFWDCFg_yoWftwc_CF
        40gw42vFs8tFs7JryIk3y3ArWI9ay8WF4kuF1aqayfZ34Yqw1DKws3XF93X34kWr47AryD
        Ca1DZw1jyr13AjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRibAwPUUUUU==
X-Originating-IP: [123.112.69.106]
X-CM-SenderInfo: xqlhyxxdqjzvrlsqjii6rwjhhfrp/1tbi6w4ZjFXl16F00gAAsQ
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mempool_alloc() allocates an element for mbp from a specific memory pool.
When some error occurs, we should free this memory pool with
mempool_free(). But when cbfn != NULL, the function returns 0 without
freeing the mbp, which will lead to a memory leak.

We can fix it by calling mempool_free() when the cbfn != NULL.

Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
---
 drivers/scsi/csiostor/csio_wr.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/csiostor/csio_wr.c b/drivers/scsi/csiostor/csio_wr.c
index fe0355c964bc..7dcc4fda0483 100644
--- a/drivers/scsi/csiostor/csio_wr.c
+++ b/drivers/scsi/csiostor/csio_wr.c
@@ -728,8 +728,10 @@ csio_wr_eq_destroy(struct csio_hw *hw, void *priv, int eq_idx,
 		return rv;
 	}
 
-	if (cbfn != NULL)
+	if (cbfn != NULL) {
+		mempool_free(mbp, hw->mb_mempool);
 		return 0;
+	}
 
 	return csio_wr_eq_destroy_rsp(hw, mbp, eq_idx);
 }
-- 
2.25.1

