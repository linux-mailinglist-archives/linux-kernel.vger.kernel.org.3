Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF2954C4C6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 11:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348181AbiFOJgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 05:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbiFOJgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 05:36:45 -0400
Received: from mail-m963.mail.126.com (mail-m963.mail.126.com [123.126.96.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F350F344C9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 02:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=CUmGd
        INgk1+n0K54dy4qu6cl1KlOEQmgr2vCPmeguoU=; b=gqGeP1f+cb/gMViYHs/8R
        DNLaw23Z9akbAXpfyAAf56FGdCDAk1AdwwoYoK0F+laIYWdub0Ol6Za5Hk7blQyE
        Ifq0bC42hQuozyvx0rh4nA0IFuI1fczxG42fJCA2u3NunX40DlFfQmet8th2JRq8
        ZkJ+fM9FXMRqFxyFbxbEQA=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp8 (Coremail) with SMTP id NORpCgCXLosSqKliPEuUFg--.44350S2;
        Wed, 15 Jun 2022 17:36:19 +0800 (CST)
From:   heliang <windhl@126.com>
To:     nm@ti.com, ssantosh@kernel.org, linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        windhl@126.com
Subject: [PATCH] arch: arm: mach-keystone: Add missing of_node_put() in pm_domain.c
Date:   Wed, 15 Jun 2022 17:36:17 +0800
Message-Id: <20220615093617.3962482-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NORpCgCXLosSqKliPEuUFg--.44350S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JFyUCr15GrW3ZryDJw4DCFg_yoW3GFb_J3
        4xXa1fWF1xJF1kWrW8Aw43Wr9rXw1UGrsFq34a9w4agF48Jw17ZFZrtrnavrW8WrWIkrW3
        JayDAr1aywn29jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_5l1JUUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbiuBMhF2JVj34a4gAAsj
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In keystone_pm_runtime_init(), of_find_matching_node() will return a
node pointer with refcount incremented. We should use of_node_put()
when it is not used anymore.

Signed-off-by: heliang <windhl@126.com>
---
 arch/arm/mach-keystone/pm_domain.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-keystone/pm_domain.c b/arch/arm/mach-keystone/pm_domain.c
index 5eea01cbecf0..50a08721a8d8 100644
--- a/arch/arm/mach-keystone/pm_domain.c
+++ b/arch/arm/mach-keystone/pm_domain.c
@@ -44,6 +44,8 @@ int __init keystone_pm_runtime_init(void)
 	if (!np)
 		return 0;
 
+	of_node_put(np);
+
 	pm_clk_add_notifier(&platform_bus_type, &platform_domain_notifier);
 
 	return 0;
-- 
2.25.1

