Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE5354F749
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 14:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381793AbiFQMN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 08:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236185AbiFQMN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 08:13:57 -0400
Received: from mail-m965.mail.126.com (mail-m965.mail.126.com [123.126.96.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CBCB82E3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 05:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=iCT51
        JsNBzrOmEI1i8aQe7I2G6/ZSLAG5PnFqv0MdfQ=; b=Oaog0QlBGrNuNdDPF1nsN
        IPguoy6FaYFRIcs3RBai1PhVuI+xl/wx6gWde0R7Gave980ehxmW0AJyM8q9u6nw
        EyUdBRemrz0hDrWKMHrAgIbhxRINFR7YSQO9Wah4DE27zHMQ91Hh8wqZ+IKoqmNV
        vdBpjAYnF61aWLLep2xNrc=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp10 (Coremail) with SMTP id NuRpCgA3fnK0b6xiba97Ew--.20431S2;
        Fri, 17 Jun 2022 20:12:37 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     linux@armlinux.org.uk, s.hauer@pengutronix.de,
        kernel@pengutronix.de, p.zabel@pengutronix.de, saravanak@google.com
Cc:     windhl@126.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm: mach-imx: Fix refcount leak bug in src
Date:   Fri, 17 Jun 2022 20:12:35 +0800
Message-Id: <20220617121235.4047670-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NuRpCgA3fnK0b6xiba97Ew--.20431S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruFyfGr18WFyxAryfuF4DJwb_yoW3GFXEqw
        nag3srJrWrWa10vw4Duw4fKr13uw4rWrs3Jr9Fvw17KFWYvr1UCFs2vFyxtryUWrWIkrW3
        GFWkCFyakw1akjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjb_-JUUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi7RUjF1pEAN-lYwAAsL
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In imx7_src_init(), of_find_compatible_node() will return a node
pointer with refcount incremented. We should use of_node_put() when
it is not used anymore.

Signed-off-by: Liang He <windhl@126.com>
---
 arch/arm/mach-imx/src.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-imx/src.c b/arch/arm/mach-imx/src.c
index 59a8e8cc4469..fff2776f9180 100644
--- a/arch/arm/mach-imx/src.c
+++ b/arch/arm/mach-imx/src.c
@@ -195,6 +195,7 @@ void __init imx7_src_init(void)
 		return;
 
 	src_base = of_iomap(np, 0);
+	of_node_put(np);
 	if (!src_base)
 		return;
 
@@ -203,6 +204,7 @@ void __init imx7_src_init(void)
 		return;
 
 	gpc_base = of_iomap(np, 0);
+	of_node_put(np);
 	if (!gpc_base)
 		return;
 }
-- 
2.25.1

