Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECC554F708
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 13:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382104AbiFQLxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 07:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380377AbiFQLxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 07:53:47 -0400
Received: from mail-m963.mail.126.com (mail-m963.mail.126.com [123.126.96.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EF8536CF7C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 04:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=rYOyY
        8DCsrHlOTPqBZ/Z7HjC8dHssOZBwD/a1jjkMX0=; b=IDD1a/8GaXEM26CIajegU
        TAEudN2qGApkpsqqMcMvE2Btt/We6LpMmo+TGG74zxHAHmWCKhP+egY5pJ6EjrFV
        PVcjaILGA6xwAZav33WgGi8ToEnhiZ5fAOdrqA+Wx8KeCBb1l1YgFFvWGP9HhtJx
        eQaB66dMyjZL+kCvPWbS9U=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp8 (Coremail) with SMTP id NORpCgBHlnI0a6xiFfhuFw--.25233S2;
        Fri, 17 Jun 2022 19:53:24 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     chris@zankel.net, jcmvbkbc@gmail.com, linux@roeck-us.net
Cc:     windhl@126.com, linux-xtensa@linux-xtensa.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] xtfpga: Fix refcount leak bug in setup
Date:   Fri, 17 Jun 2022 19:53:23 +0800
Message-Id: <20220617115323.4046905-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NORpCgBHlnI0a6xiFfhuFw--.25233S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF4UXry8JryrKry3tw47Jwb_yoW3ArgEqw
        1SgayUGryrtF4DK39rZr4fWw1jqa93Wrn0grnava1xJw4YqF15Gr1qyFZa9ay7uFZYyrWa
        va98J3yYkF93ujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUU3fH5UUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi2hQjF1uwMOTRDgAAsa
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In machine_setup(), of_find_compatible_node() will return a node
pointer with refcount incremented. We should use of_node_put() when
it is not used anymore.

Signed-off-by: Liang He <windhl@126.com>
---
 arch/xtensa/platforms/xtfpga/setup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/xtensa/platforms/xtfpga/setup.c b/arch/xtensa/platforms/xtfpga/setup.c
index 538e6748e85a..c79c1d09ea86 100644
--- a/arch/xtensa/platforms/xtfpga/setup.c
+++ b/arch/xtensa/platforms/xtfpga/setup.c
@@ -133,6 +133,7 @@ static int __init machine_setup(void)
 
 	if ((eth = of_find_compatible_node(eth, NULL, "opencores,ethoc")))
 		update_local_mac(eth);
+	of_node_put(eth);
 	return 0;
 }
 arch_initcall(machine_setup);
-- 
2.25.1

