Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 628EB5501BE
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 03:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382752AbiFRBsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 21:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383496AbiFRBsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 21:48:24 -0400
Received: from m15112.mail.126.com (m15112.mail.126.com [220.181.15.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5920560A85
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 18:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=EjjGP
        vuthmf5Z8jDqlrttQfgUbB5nVt8z60LWABfKwI=; b=bD7Xe2LRBrupq2bCnTEke
        H1XOZLfVavb55KglvUsMqxl7ikYqccbgIWYeJK7Z4uMQFYhzoblIvSgkLfrk17D+
        GJVbNeI0hH/vAkeA5AG2DA24sIrMIvF+VntLIJ5NaQKc9B3FwcjobBGAMpFtS8JT
        GQOtZtltIHSvepaMshxAIQ=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp2 (Coremail) with SMTP id DMmowACXBAHDLq1ifz5mDg--.23118S2;
        Sat, 18 Jun 2022 09:47:48 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     tony@atomide.com, linux@armlinux.org.uk
Cc:     windhl@126.com, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm/mach-omap2: Fix refcount leak bug in omap_hwmod.c
Date:   Sat, 18 Jun 2022 09:47:47 +0800
Message-Id: <20220618014747.4055279-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DMmowACXBAHDLq1ifz5mDg--.23118S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KrW7Cr1ktr4rXr1xGF1xZrb_yoW8GrW5p3
        92k395tr1UWws7J3yktFyqqrW29w1DCrWqyr9xCw1Ika1DCr4rZr4rtF90k345JFWru3WF
        yF4Fyw17W3Z8u3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0z__MakUUUUU=
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbizgUkF18RPUQLLQAAsp
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In _init(), of_find_node_by_name() will return a node pointer with
refcount incremented. We should use of_node_put() in fail path or
when it is not used anymore.

NOTE: As the ref will be passed from 'bus' to 'np' by the xx_lookup(),
in normal exit path, we should call of_node_put() at the end use of 'np',
not the end use of 'bus'.

Signed-off-by: Liang He <windhl@126.com>
---
 arch/arm/mach-omap2/omap_hwmod.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 31d1a21f6041..007e73cc0471 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2365,6 +2365,7 @@ static int __init _init(struct omap_hwmod *oh, void *data)
 
 	r = _init_mpu_rt_base(oh, NULL, index, np);
 	if (r < 0) {
+		of_node_put(bus);
 		WARN(1, "omap_hwmod: %s: doesn't have mpu register target base\n",
 		     oh->name);
 		return 0;
@@ -2372,6 +2373,7 @@ static int __init _init(struct omap_hwmod *oh, void *data)
 
 	r = _init_clocks(oh, np);
 	if (r < 0) {
+		of_node_put(bus);
 		WARN(1, "omap_hwmod: %s: couldn't init clocks\n", oh->name);
 		return -EINVAL;
 	}
@@ -2385,6 +2387,8 @@ static int __init _init(struct omap_hwmod *oh, void *data)
 			parse_module_flags(oh, child);
 	}
 
+	of_node_put(bus);
+
 	oh->_state = _HWMOD_STATE_INITIALIZED;
 
 	return 0;
-- 
2.25.1

