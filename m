Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6589C54D74F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 03:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349436AbiFPBro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 21:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344998AbiFPBrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 21:47:19 -0400
Received: from m15113.mail.126.com (m15113.mail.126.com [220.181.15.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2E663579AA;
        Wed, 15 Jun 2022 18:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=1icBp
        5p0Rg4t5QP7pXu7euYCDr/0Q6K0TcaAKQpB4i0=; b=XdUB94F7618pZ2LNG/vIR
        Fv3OMtc6WYp3RG4SI6KEj/0c0TxLeLVrJeaJaWrCY3l/5CT1gShqxGSXYP09QsH9
        1aX1SvQrwuU1H7DuWjbFUBLZnkDLLnQIaQhk+3o4VB2lR5hUR8x043tWMpB++Tlw
        3Iw6BEp/qy6XP5gVYL32O8=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp3 (Coremail) with SMTP id DcmowADHYJJ9i6pi+1CxDQ--.61740S2;
        Thu, 16 Jun 2022 09:46:46 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        p.zabel@pengutronix.de, digetx@gmail.com, ndesaulniers@google.com,
        ulf.hansson@linaro.org, skamble@nvidia.com, nathan@kernel.org,
        kkartik@nvidia.com
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        windhl@126.com
Subject: [PATCH v2] soc: tegra: fuse: Add missing of_node_put in tegra_init_fuse
Date:   Thu, 16 Jun 2022 09:46:36 +0800
Message-Id: <20220616014636.3972830-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DcmowADHYJJ9i6pi+1CxDQ--.61740S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKFW3GryrZw1rAw4fKFy3Jwb_yoW3KFc_Xa
        1xWFZ7XF1UWanYva40qrWfZFy2yF4Iqrnaqr4Iv3W2k3W7Zr17GFsIvr17Ca4a9wsrCFW5
        GryDZFyayr13AjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRt73kDUUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/xtbBGgAiF1-HZTo2ggAAsc
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In this function, of_find_matching_node() will return a node
pointer with refcount incremented. We should use of_node_put
when the pointer *np* is not used anymore.

Signed-off-by: Liang He <windhl@126.com>
---
 changelog:

 v2: use real name for Sob
 v1: fix the bug


 drivers/soc/tegra/fuse/fuse-tegra.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/tegra/fuse/fuse-tegra.c b/drivers/soc/tegra/fuse/fuse-tegra.c
index b0a8405dbdb1..6542267a224d 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra.c
@@ -568,6 +568,7 @@ static int __init tegra_init_fuse(void)
 	np = of_find_matching_node(NULL, car_match);
 	if (np) {
 		void __iomem *base = of_iomap(np, 0);
+		of_node_put(np);
 		if (base) {
 			tegra_enable_fuse_clk(base);
 			iounmap(base);
-- 
2.25.1

