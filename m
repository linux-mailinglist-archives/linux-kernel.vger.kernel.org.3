Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4679054D8D1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 05:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349705AbiFPDPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 23:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348016AbiFPDPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 23:15:03 -0400
Received: from mail-m963.mail.126.com (mail-m963.mail.126.com [123.126.96.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A77E4340CC
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 20:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=/sM5M
        +gbgYIiAZs5Y2MZIAgmpYmz8zwF7R3/CtM0M+0=; b=fcuoXRF/VGUlhKaXi1eiI
        L2e4bJP/gN9OIIRcgqIqqbLlq9zxlIGqnzvZ/YwvUQctmcRPh2d0aU1ualKxZVwg
        GxxNIV9s0BSciDzmDDDKNVtG/hNhfxknpBH49ref3fC7iD6jGIz46iRb5gkFxi9X
        JiJd0+lhC68k4ZUWzAxZzs=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp8 (Coremail) with SMTP id NORpCgB31Jjwn6pi+aPiFg--.24971S2;
        Thu, 16 Jun 2022 11:13:53 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     linux@armlinux.org.uk
Cc:     windhl@126.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm: mm: (cache-tauros2) Add missing of_node_put()
Date:   Thu, 16 Jun 2022 11:13:51 +0800
Message-Id: <20220616031351.3974560-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NORpCgB31Jjwn6pi+aPiFg--.24971S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF4UXry8JryrKry3tF1UWrg_yoWfuwbEga
        4Iq3W2krnYgan2vw1DCF45Gr4UZrn093Z5Zr13XrnxAryfAFyUJrs7ta1Sv348urZagFZ3
        JrWDJ340yF12kjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_k9NDUUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi3BEiF1pEDurv5QAAsI
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

Signed-off-by: Liang He <windhl@126.com>
---
 changelog:

 v2: (1) use real name for Sob (2) use proper subject title
 v1: fix missing of_node_put

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

