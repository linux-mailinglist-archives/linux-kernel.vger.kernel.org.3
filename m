Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 554065A605E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 12:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbiH3KMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 06:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiH3KLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 06:11:50 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E8ABFAB1AE
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 03:07:30 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EE5E8152B;
        Tue, 30 Aug 2022 03:07:35 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8B7FA3F766;
        Tue, 30 Aug 2022 03:07:28 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Achin Gupta <achin.gupta@arm.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Valentin Laurent <valentin.laurent@trustonic.com>,
        Lukas Hanel <lukas.hanel@trustonic.com>,
        Coboy Chen <coboy.chen@mediatek.com>
Subject: [PATCH 2/9] tee: optee: Use ffa_dev->ops directly
Date:   Tue, 30 Aug 2022 11:06:53 +0100
Message-Id: <20220830100700.344594-3-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220830100700.344594-1-sudeep.holla@arm.com>
References: <20220830100700.344594-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the ffa_device structure holds the pointer to ffa_dev_ops,
there is no need to obtain the same through ffa_dev_ops_get().

Just use the ffa_dev->ops directly.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/tee/optee/ffa_abi.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
index 7ab31740cff8..4c3b5d0008dd 100644
--- a/drivers/tee/optee/ffa_abi.c
+++ b/drivers/tee/optee/ffa_abi.c
@@ -793,11 +793,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
 	u32 sec_caps;
 	int rc;
 
-	ffa_ops = ffa_dev_ops_get(ffa_dev);
-	if (!ffa_ops) {
-		pr_warn("failed \"method\" init: ffa\n");
-		return -ENOENT;
-	}
+	ffa_ops = ffa_dev->ops;
 
 	if (!optee_ffa_api_is_compatbile(ffa_dev, ffa_ops))
 		return -EINVAL;
-- 
2.37.2

