Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A86A854F729
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 14:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381557AbiFQMEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 08:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235267AbiFQMEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 08:04:13 -0400
Received: from m15111.mail.126.com (m15111.mail.126.com [220.181.15.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 48D106B67D;
        Fri, 17 Jun 2022 05:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=xLXQP
        CRRnzk1om6x2Cgzr7SkTW8h2l/BHdHFS74lVOw=; b=M9H/4qlii7VzTzoFKuPY3
        L0vClOxWiSZhi9kWmTwDd2G02XrCKBziXN8KdBHqEONTjMRH/N9Y8AamXawG/sfF
        0xWC3VWYpQ+tJcikfbkbbX3RdJDMraDS+YyF90xVvbey5NIrx4IS1rCr2cv1eCja
        KJG69zfDD02QCTg7r2tAIw=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp1 (Coremail) with SMTP id C8mowAA3BTbobKxiBx8hEw--.31268S2;
        Fri, 17 Jun 2022 20:00:42 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     ysato@users.sourceforge.jp, dalias@libc.org
Cc:     windhl@126.com, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sh: sh2: Fix refcount leak bug in smp-j2
Date:   Fri, 17 Jun 2022 20:00:40 +0800
Message-Id: <20220617120040.4047182-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C8mowAA3BTbobKxiBx8hEw--.31268S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF1kKw4UAr4fKF1DXry7Jrb_yoWfurcEqF
        nxWr47Cr4rGwn0qrZrua1rCr4Dtws8KFZ5Ca4rA34YyFW3Zr15Cr95C398JFZxuFWxurW7
        GrWku3Wv9r429jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRt1v3PUUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/xtbBGhMjF1-HZUYJxgAAsJ
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In j2_prepare_cpus(), of_find_compatible_node() will return a
node pointer with refcount incremented. We should use of_node_put()
in fail path or when it is not used anymore.

Signed-off-by: Liang He <windhl@126.com>
---
 arch/sh/kernel/cpu/sh2/smp-j2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/sh/kernel/cpu/sh2/smp-j2.c b/arch/sh/kernel/cpu/sh2/smp-j2.c
index d0d5d81455ae..995fb5da6ff3 100644
--- a/arch/sh/kernel/cpu/sh2/smp-j2.c
+++ b/arch/sh/kernel/cpu/sh2/smp-j2.c
@@ -51,6 +51,7 @@ static void j2_prepare_cpus(unsigned int max_cpus)
 
 	j2_ipi_irq = irq_of_parse_and_map(np, 0);
 	j2_ipi_trigger = of_iomap(np, 0);
+	of_node_put(np);
 	if (!j2_ipi_irq || !j2_ipi_trigger)
 		goto out;
 
@@ -59,6 +60,7 @@ static void j2_prepare_cpus(unsigned int max_cpus)
 		goto out;
 
 	sh2_cpuid_addr = of_iomap(np, 0);
+	of_node_put(np);
 	if (!sh2_cpuid_addr)
 		goto out;
 
-- 
2.25.1

