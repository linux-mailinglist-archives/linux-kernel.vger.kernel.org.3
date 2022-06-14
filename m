Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1DEC54B252
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 15:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236098AbiFNNd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 09:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245704AbiFNNc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 09:32:26 -0400
Received: from hust.edu.cn (mail.hust.edu.cn [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489962F1;
        Tue, 14 Jun 2022 06:32:24 -0700 (PDT)
Received: from localhost.localdomain ([172.16.0.254])
        (user=dzm91@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 25EDUYte030219-25EDUYth030219
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 14 Jun 2022 21:30:38 +0800
From:   Dongliang Mu <dzm91@hust.edu.cn>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Eddie James <eajames@linux.ibm.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dongliang Mu <mudongliangabcd@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Pekka Enberg <penberg@kernel.org>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] hwmon: (occ) remove NULL check before kvfree
Date:   Tue, 14 Jun 2022 21:30:22 +0800
Message-Id: <20220614133025.146745-1-dzm91@hust.edu.cn>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: dzm91@hust.edu.cn
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dongliang Mu <mudongliangabcd@gmail.com>

kvfree can handle NULL pointer as its argument.
According to coccinelle isnullfree check, remove NULL check
before kvfree operation.

Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
---
v1->v2: modify the commit title and signature
 drivers/hwmon/occ/p9_sbe.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/occ/p9_sbe.c b/drivers/hwmon/occ/p9_sbe.c
index 42fc7b97bb34..01405ae2f9bd 100644
--- a/drivers/hwmon/occ/p9_sbe.c
+++ b/drivers/hwmon/occ/p9_sbe.c
@@ -55,8 +55,7 @@ static bool p9_sbe_occ_save_ffdc(struct p9_sbe_occ *ctx, const void *resp,
 	mutex_lock(&ctx->sbe_error_lock);
 	if (!ctx->sbe_error) {
 		if (resp_len > ctx->ffdc_size) {
-			if (ctx->ffdc)
-				kvfree(ctx->ffdc);
+			kvfree(ctx->ffdc);
 			ctx->ffdc = kvmalloc(resp_len, GFP_KERNEL);
 			if (!ctx->ffdc) {
 				ctx->ffdc_len = 0;
@@ -171,8 +170,7 @@ static int p9_sbe_occ_remove(struct platform_device *pdev)
 	ctx->sbe = NULL;
 	occ_shutdown(occ);
 
-	if (ctx->ffdc)
-		kvfree(ctx->ffdc);
+	kvfree(ctx->ffdc);
 
 	return 0;
 }
-- 
2.35.1

