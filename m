Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4E8F54CC21
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 17:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345474AbiFOPEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 11:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345743AbiFOPEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 11:04:20 -0400
Received: from m15112.mail.126.com (m15112.mail.126.com [220.181.15.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AC74D3630E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 08:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=20hDp
        fKx7DlRW5HS+oU9NQcbLfsZNblgISuRP1uJhKs=; b=WiSwl0HtnDY+U/011fS5+
        yh82ScEyPi1br2kNFdK153My4IvOuneeoYsht5KtJBwOdFcceNUlpD+9tZUMoqPv
        6NjUjELQNsojOq0Vro9paUj/FEH08V8hTGw7a9su0rykjA2tOOKgbxoUpjBDEzeB
        c7raTxTn2tvFKcnbAzJL00=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp2 (Coremail) with SMTP id DMmowADnOAS+9KliW3g+DQ--.47526S2;
        Wed, 15 Jun 2022 23:03:27 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        robh@kernel.org, frank.rowand@sony.com
Cc:     windhl@126.com, linux-kernel@vger.kernel.org
Subject: [PATCH] arch: x86: kernel: Add missing of_node_put() in devicetree.c
Date:   Wed, 15 Jun 2022 23:03:25 +0800
Message-Id: <20220615150325.3969911-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DMmowADnOAS+9KliW3g+DQ--.47526S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GFWxXw1kXrykAF1xZrWkZwb_yoWxZFb_W3
        WxWr48Crs5X3WSg39xCr4fWr13Zw1fKFZYyr1vqFs7Ar90qF45WFsIq3Wayrn3WFW8tFW5
        ZrnxAFWqkw4jkjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRMmhFDUUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbiuAkhF2JVj4IGogABsY
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In dtb_setup_hpet(), of_find_compatible_node() will return a node
pointer with refcount incremented. We should use of_node_put() when it
is not used anymore.

Signed-off-by: Liang He <windhl@126.com>
---
 arch/x86/kernel/devicetree.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/devicetree.c b/arch/x86/kernel/devicetree.c
index 5cd51f25f446..6a386424ddf7 100644
--- a/arch/x86/kernel/devicetree.c
+++ b/arch/x86/kernel/devicetree.c
@@ -120,6 +120,9 @@ static void __init dtb_setup_hpet(void)
 	if (!dn)
 		return;
 	ret = of_address_to_resource(dn, 0, &r);
+	
+	of_node_put(dn);
+	
 	if (ret) {
 		WARN_ON(1);
 		return;
-- 
2.25.1

