Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A73AC54CB8B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 16:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345234AbiFOOjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 10:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345057AbiFOOjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 10:39:45 -0400
Received: from m15111.mail.126.com (m15111.mail.126.com [220.181.15.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 55D7BB7EC
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 07:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=hq6nR
        WglAhr8vPBtxEwx7KGRHjG1FojbJfx83gxT5cs=; b=cOcgvf8FsunlcPHnMZEVf
        B6oZq7JtwSMRZgNmRtwc1RMzQZHIcPozdoHgVF3S5iLozU9zbrIGK25BcB84/H1I
        wQQjGRIRexqv/K+I1WwijbMmeIPdigbqZjJGKVxJWsVMa/Trtq2+VAGiTrKIXqWF
        Y/dzmVdJ+Chm9Ut20SrCKY=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp1 (Coremail) with SMTP id C8mowADHzCiP7qlinPC3EQ--.44190S2;
        Wed, 15 Jun 2022 22:37:03 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     agust@denx.de, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, ulia.Lawall@inria.fr, nick.child@ibm.com
Cc:     joel@jms.id.au, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, windhl@126.com
Subject: [PATCH] arch: powerpc: platforms: 512x: Add missing of_node_put()
Date:   Wed, 15 Jun 2022 22:37:03 +0800
Message-Id: <20220615143703.3968898-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C8mowADHzCiP7qlinPC3EQ--.44190S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKF4xWFy7Kr4rZF4ftw17GFg_yoWfCrXEya
        yIqa1jkrWkJrsayr1DZr1Y9ryak3sxCa98X340q3WxJw15Xw43JrnFqrsFv3WUWFW2k39x
        JFWDGw1aya4akjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xREPl1tUUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi7RAhF1pEAND77wAAsR
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In mpc5121_clk_init(), of_find_compatible_node() will return a
node pointer with refcount incremented. We should use of_node_put()
when it is not used anymore.

Signed-off-by: Liang He <windhl@126.com>
---
 arch/powerpc/platforms/512x/clock-commonclk.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/platforms/512x/clock-commonclk.c b/arch/powerpc/platforms/512x/clock-commonclk.c
index 0652c7e69225..ca475462e95b 100644
--- a/arch/powerpc/platforms/512x/clock-commonclk.c
+++ b/arch/powerpc/platforms/512x/clock-commonclk.c
@@ -1208,6 +1208,8 @@ int __init mpc5121_clk_init(void)
 	/* register as an OF clock provider */
 	mpc5121_clk_register_of_provider(clk_np);
 
+	of_node_put(clk_np);
+
 	/*
 	 * unbreak not yet adjusted peripheral drivers during migration
 	 * towards fully operational common clock support, and allow
-- 
2.25.1

