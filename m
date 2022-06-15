Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D83A54C358
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 10:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244082AbiFOISm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 04:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243896AbiFOISe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 04:18:34 -0400
Received: from m15113.mail.126.com (m15113.mail.126.com [220.181.15.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A494E275DB
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 01:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=WAvjG
        aW8eeZFyULt3oiXcMYMmRC4xcP9KkvwRhP2h50=; b=anpYU+dPQOLolCsmnwm4C
        9IioO/uKySaYT+0jgB17zQdo6Zb9y6cUwtOSvBfFkoYyFbV916i7AK+sciYrIeSa
        RrhBqrZV8MFgjZ6HJE1HlPJyTDzD6idN9VYW4ilKd8RVBOfvOV15D1KmZtrDiRff
        gp06+u3v5xQd/XyktQEklI=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp3 (Coremail) with SMTP id DcmowAAHppfDlalidF98DQ--.36961S2;
        Wed, 15 Jun 2022 16:18:11 +0800 (CST)
From:   heliang <windhl@126.com>
To:     linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        windhl@126.com
Subject: [PATCH] arm: mm: Add missing of_node_put() in cache-tauros2.c
Date:   Wed, 15 Jun 2022 16:18:11 +0800
Message-Id: <20220615081811.3960357-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DcmowAAHppfDlalidF98DQ--.36961S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF4UXry8JryrtFy8ZF4xJFb_yoW3KFXEgF
        yIvw1UCrsYgan2vr1DCF45Gr4UZwnY93Z5Xr13XrnxAr1fXFyUJrs3tanav348urZYgFZ3
        JrWDJ340yF1agjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_k9NDUUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi2gQhF1uwMNPbEAAAsr
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In tauros2_init, we use of_find_matching_node() to get a node
pointer with refcount incremented. We should use of_node_put() when
it is not used anymore.

Signed-off-by: heliang <windhl@126.com>
---
 arch/arm/mm/cache-tauros2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mm/cache-tauros2.c b/arch/arm/mm/cache-tauros2.c
index 88255bea65e4..05eab6e44cfc 100644
--- a/arch/arm/mm/cache-tauros2.c
+++ b/arch/arm/mm/cache-tauros2.c
@@ -294,6 +294,7 @@ void __init tauros2_init(unsigned int features)
 		pr_info("Not found marvell,tauros2-cache, disable it\n");
 	} else {
 		ret = of_property_read_u32(node, "marvell,tauros2-cache-features", &f);
+		of_node_put(node);
 		if (ret) {
 			pr_info("Not found marvell,tauros-cache-features property, "
 				"disable extra features\n");
-- 
2.25.1

