Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6164DB1E1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 14:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348443AbiCPNxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 09:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233718AbiCPNxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 09:53:16 -0400
Received: from hust.edu.cn (mail.hust.edu.cn [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7CE460CD1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 06:52:00 -0700 (PDT)
Received: from localhost.localdomain ([172.16.0.254])
        (user=dzm91@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 22GDomGD003471-22GDomGG003471
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Wed, 16 Mar 2022 21:50:52 +0800
From:   Dongliang Mu <dzm91@hust.edu.cn>
To:     Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>
Cc:     Dongliang Mu <mudongliangabcd@gmail.com>,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tee: optee: add missing mutext_destroy in optee_ffa_probe
Date:   Wed, 16 Mar 2022 21:50:47 +0800
Message-Id: <20220316135047.188122-1-dzm91@hust.edu.cn>
X-Mailer: git-send-email 2.25.1
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

The error handling code of optee_ffa_probe misses the mutex_destroy of
ffa.mutex when mutext_init succeeds.

Fix this by adding mutex_destory of ffa.mutex at the error handling part

Fixes: aceeafefff73 ("optee: use driver internal tee_context for some rpc")
Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
---
 drivers/tee/optee/ffa_abi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
index f744ab15bf2c..30a6119a2b16 100644
--- a/drivers/tee/optee/ffa_abi.c
+++ b/drivers/tee/optee/ffa_abi.c
@@ -894,6 +894,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
 	rhashtable_free_and_destroy(&optee->ffa.global_ids, rh_free_fn, NULL);
 	optee_supp_uninit(&optee->supp);
 	mutex_destroy(&optee->call_queue.mutex);
+	mutex_destroy(&optee->ffa.mutex);
 err_unreg_supp_teedev:
 	tee_device_unregister(optee->supp_teedev);
 err_unreg_teedev:
-- 
2.25.1

