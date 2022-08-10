Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E02FF58E597
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 05:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbiHJDmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 23:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiHJDlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 23:41:20 -0400
Received: from mail-m963.mail.126.com (mail-m963.mail.126.com [123.126.96.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A40F067CB4
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 20:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=qV7ak
        zLaGXu9fGQiOMj/yV6cyOJkqSiwyUBHI4SCrYU=; b=LSkXS3jfJZxSjzP5o387Q
        ll5Ep25eEkPk/dJSrAFvzOGRu6he/h2J0oc4jR0k9oxXNz9FYKP1lEceCkEyN0IL
        PldISBztuwmpl78QIdUnYpDbVN6guWHy4l7nTilbfoY36QP9NbGMmZfO3Y0TmwqW
        7BwJYMc5FwH964JUZtyI+A=
Received: from localhost.localdomain (unknown [116.128.244.169])
        by smtp8 (Coremail) with SMTP id NORpCgAXx5N2KPNiByMLKA--.41747S2;
        Wed, 10 Aug 2022 11:39:34 +0800 (CST)
From:   Bing Huang <huangbing775@126.com>
To:     mingo@redhat.com
Cc:     peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, Bing Huang <huangbing@kylinos.cn>
Subject: [PATCH] sched/topology: Add __init for init_defrootdomain
Date:   Wed, 10 Aug 2022 11:39:32 +0800
Message-Id: <20220810033932.171690-1-huangbing775@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NORpCgAXx5N2KPNiByMLKA--.41747S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cr48ury3Kw4fJw1xKr43GFg_yoW8JFyrpF
        yq9rW5G3y8GrWqq348C3ykurW3W3sxKw4Skan8tws8Jr1rGwn0gFn0vF43CryY9r45Gr4a
        yF4qq342y3WUtFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U0tC7UUUUU=
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: xkxd0w5elqwlixv6ij2wof0z/1tbimQRZr19E8NvDKAABsx
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bing Huang <huangbing@kylinos.cn>

init_defrootdomain is only used in initialization

Signed-off-by: Bing Huang <huangbing@kylinos.cn>
---
 kernel/sched/sched.h    | 2 +-
 kernel/sched/topology.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b0bf2287dd9d..cd761f1fc60c 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -883,7 +883,7 @@ struct root_domain {
 	struct perf_domain __rcu *pd;
 };
 
-extern void init_defrootdomain(void);
+extern void __init init_defrootdomain(void);
 extern int sched_init_domains(const struct cpumask *cpu_map);
 extern void rq_attach_root(struct rq *rq, struct root_domain *rd);
 extern void sched_get_rd(struct root_domain *rd);
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 8739c2a5a54e..dea9fa39e7c0 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -578,7 +578,7 @@ static int init_rootdomain(struct root_domain *rd)
  */
 struct root_domain def_root_domain;
 
-void init_defrootdomain(void)
+void __init init_defrootdomain(void)
 {
 	init_rootdomain(&def_root_domain);
 
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus

