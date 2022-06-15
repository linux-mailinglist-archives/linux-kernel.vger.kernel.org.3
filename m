Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A1C54CC00
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 16:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235778AbiFOO6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 10:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbiFOO6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 10:58:34 -0400
Received: from m15112.mail.126.com (m15112.mail.126.com [220.181.15.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 93C7E35841
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 07:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=0jHX1
        o4T3dntA4QQGKBVqsC0i9BdSq13vyJ3pRtuELc=; b=jo77HEeM5iwfk8mkwfhif
        aiqq26y6WzJjk4uwj2CPx9ecJiJqBaj0jvzwd1LhTbBogRGsimK2Fo7DMT8EvghO
        rV1N98RNCAdtiv5AChaUgilxPwZHGATPj/SE3O1NUbDMdV4tJzh/PaN3OEqEgRqN
        Y0Uycx8sLVmWlTpLM5+iIA=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp2 (Coremail) with SMTP id DMmowAD3IQVo86liwUE+DQ--.47882S2;
        Wed, 15 Jun 2022 22:57:44 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     linux@armlinux.org.uk, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        windhl@126.com
Subject: [PATCH] arm: mach-imx: Add missing of_node_put() in cpu-imx5.c
Date:   Wed, 15 Jun 2022 22:57:43 +0800
Message-Id: <20220615145743.3969705-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DMmowAD3IQVo86liwUE+DQ--.47882S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruF4rJryfZr43Cw45XryxXwb_yoWxKrX_t3
        WfW3srJFWrJF4FvryUua1rWF4Fqws3Wr1rXFyIya1Yk3yqvrnxCrnFv3WIqry7Zr1agFW5
        WF9rCr4Ykw1YkjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRMpnQ3UUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/xtbBGgMhF1-HZTdFJwACsF
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In imx5_read_srev_reg(), of_find_compatible_node() will return a
node pointer with refcount incremented. We should use of_node_put()
when it is not used anymore.

Signed-off-by: Liang He <windhl@126.com>
---
 arch/arm/mach-imx/cpu-imx5.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-imx/cpu-imx5.c b/arch/arm/mach-imx/cpu-imx5.c
index ad56263778f9..103bf5be9b1b 100644
--- a/arch/arm/mach-imx/cpu-imx5.c
+++ b/arch/arm/mach-imx/cpu-imx5.c
@@ -30,6 +30,8 @@ static u32 imx5_read_srev_reg(const char *compat)
 	iim_base = of_iomap(np, 0);
 	WARN_ON(!iim_base);
 
+	of_node_put(np);
+
 	srev = readl(iim_base + IIM_SREV) & 0xff;
 
 	iounmap(iim_base);
-- 
2.25.1

