Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35298534839
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 03:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241663AbiEZBjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 21:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiEZBjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 21:39:13 -0400
Received: from mail-m974.mail.163.com (mail-m974.mail.163.com [123.126.97.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 62C049D4FD;
        Wed, 25 May 2022 18:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=b2P3Q
        H6vt+McJy25fKhf43Jb4cDyVE2JY2bcEA7mzQo=; b=WDptdQL78j+RaS/nAHlYX
        1Ce4aKhc4cNCcl5AxJK1AkEFLoy6YFb8SUGN9FUqFWukOvX2K+qSVayAHKuGitqX
        DHE9c9TyX+fYi6o1XcqZGm/kb/MR8YwojTjisk5yHeYHPRJXQBRWwEVwVe8SGfIG
        Xq94AeLZ77Q7yb0HmOMjoM=
Received: from localhost.localdomain (unknown [123.112.69.106])
        by smtp4 (Coremail) with SMTP id HNxpCgD3__Mh2o5ig+JFEQ--.3894S4;
        Thu, 26 May 2022 09:38:46 +0800 (CST)
From:   Jianglei Nie <niejianglei2021@163.com>
To:     bootc@bootc.net, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux1394-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        Jianglei Nie <niejianglei2021@163.com>
Subject: [PATCH] scsi: target: sbp: Fix memory leak in sbp_management_request_logout()
Date:   Thu, 26 May 2022 09:38:39 +0800
Message-Id: <20220526013839.471987-1-niejianglei2021@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: HNxpCgD3__Mh2o5ig+JFEQ--.3894S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7GFykCw47GF4DtF18KrWUXFb_yoWfWrgEkw
        srW34xurn5Ww4kKF4jkw15CrWavF4kZF1ayF4ktFWakrW7Wr1xXr1q9F93A3srCr48JrnY
        kFsIvr1Uu3y5ujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRibAwPUUUUU==
X-Originating-IP: [123.112.69.106]
X-CM-SenderInfo: xqlhyxxdqjzvrlsqjii6rwjhhfrp/1tbiMgQMjFWBzm5eRwABsa
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When req->node_addr != login->sess->node_id, sbp_management_request
_logout() returns without releasing the login, which may lead to a
potential memory leak.

We can fix it by calling sbp_login_release() before the function returns.

Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
---
 drivers/target/sbp/sbp_target.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/target/sbp/sbp_target.c b/drivers/target/sbp/sbp_target.c
index 504670994fb4..76f3ec58a24b 100644
--- a/drivers/target/sbp/sbp_target.c
+++ b/drivers/target/sbp/sbp_target.c
@@ -575,6 +575,7 @@ static void sbp_management_request_logout(
 		req->status.status = cpu_to_be32(
 			STATUS_BLOCK_RESP(STATUS_RESP_REQUEST_COMPLETE) |
 			STATUS_BLOCK_SBP_STATUS(SBP_STATUS_ACCESS_DENIED));
+		sbp_login_release(login, true);
 		return;
 	}
 
-- 
2.25.1

