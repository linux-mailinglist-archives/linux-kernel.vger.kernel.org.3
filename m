Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6EE54C3A9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 10:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346055AbiFOIjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 04:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344209AbiFOIjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 04:39:23 -0400
X-Greylist: delayed 1818 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 15 Jun 2022 01:39:22 PDT
Received: from mail-m965.mail.126.com (mail-m965.mail.126.com [123.126.96.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7002E49FBB
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 01:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=8Ns5g
        EvAuYDLgBXJtS39BSCUULDUrj3lCfWZde535H0=; b=hiLSDZZ4hjxsiAobnepTn
        C85dzbrrR9y7nxXfbvMui9qnhjleTGNyk6M3LO7DxGWDZP/K+JltmgUrC9N57LR4
        HX718EYg1wv9xxfwhSZjMY0KJIDI18mxOn2TOq/Yp62UP4KXBPAzTChiEnU4rf/Z
        j2m40D32QKtqKJInLg2Uik=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp10 (Coremail) with SMTP id NuRpCgDX1UmQk6liKTWxEg--.34720S2;
        Wed, 15 Jun 2022 16:08:49 +0800 (CST)
From:   heliang <windhl@126.com>
To:     linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        windhl@126.com
Subject: [PATCH] arm: mm: Add missing of_node_put()
Date:   Wed, 15 Jun 2022 16:08:46 +0800
Message-Id: <20220615080846.3960101-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NuRpCgDX1UmQk6liKTWxEg--.34720S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruw4DJFyrZr45tFyxZFW7XFb_yoW3AwcEvF
        1Iq3W3JrWrGF1xXF4kuF43CF1DCws8Cr1fXr1fZr17Gr1UZrWUXrZ8trn7tr1qgrWj9rW3
        JrZ5Xr42vw4agjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRuHq73UUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/xtbBGgEhF1-HZTUE4wAAsC
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In feroceon_of_init, we use of_find_matching_node() to get a node
pointer with refcount incremented. We should use of_node_put() when
it is not used anymore.

Signed-off-by: heliang <windhl@126.com>
---
 arch/arm/mm/cache-feroceon-l2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mm/cache-feroceon-l2.c b/arch/arm/mm/cache-feroceon-l2.c
index 5c1b7a7b9af6..a10c4be14087 100644
--- a/arch/arm/mm/cache-feroceon-l2.c
+++ b/arch/arm/mm/cache-feroceon-l2.c
@@ -376,6 +376,7 @@ int __init feroceon_of_init(void)
 	node = of_find_matching_node(NULL, feroceon_ids);
 	if (node && of_device_is_compatible(node, "marvell,kirkwood-cache")) {
 		base = of_iomap(node, 0);
+		of_node_put(node);
 		if (!base)
 			return -ENOMEM;
 
-- 
2.25.1

