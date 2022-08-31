Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB645A7B15
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 12:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbiHaKLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 06:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbiHaKLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 06:11:35 -0400
X-Greylist: delayed 1854 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 31 Aug 2022 03:11:26 PDT
Received: from mail-m964.mail.126.com (mail-m964.mail.126.com [123.126.96.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 09B41AEDB7
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 03:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=qV7ak
        zLaGXu9fGQiOMj/yV6cyOJkqSiwyUBHI4SCrYU=; b=LCSWjsF//RrnWuIz0RXeM
        OnrYonwQWxDeOwZeNa+eJn1aPYToLOAd2fMKzsjujzJz8ttzRD3ZvUmUqDOcf27d
        tAyrw5EFXgYd+JwS4XYdCseVyxANzevah7Go9seTtV4HM1pWCBkpFVTDRCqQafE/
        VPzh3vXW8IVOf9q0cJy/9U=
Received: from localhost.localdomain (unknown [116.128.244.169])
        by smtp9 (Coremail) with SMTP id NeRpCgB3lxNPLA9jA+xpAg--.24384S2;
        Wed, 31 Aug 2022 17:39:28 +0800 (CST)
From:   Bing Huang <huangbing775@126.com>
To:     rostedt@goodmis.org, dietmar.eggemann@arm.com
Cc:     brauner@kernel.org, bristot@redhat.com, bsegall@google.com,
        juri.lelli@redhat.com, linux-kernel@vger.kernel.org,
        mgorman@suse.de, mingo@redhat.com, peterz@infradead.org,
        vincent.guittot@linaro.org
Subject: [PATCH RESEND] sched/topology: Add __init for init_defrootdomain
Date:   Wed, 31 Aug 2022 17:39:27 +0800
Message-Id: <20220831093927.5904-1-huangbing775@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NeRpCgB3lxNPLA9jA+xpAg--.24384S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cr48ury3Kw4fJw1xKr43GFg_yoW8JFyrpF
        yq9rW5G3y8GrWqq348C3ykurW3W3sxKw4Skan8tws8Jr1rGwn0gFn0vF43CryY9r45Gr4a
        yF4qq342y3WUtFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Undb8UUUUU=
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: xkxd0w5elqwlixv6ij2wof0z/1tbijBBur1pEJLYbywAAsB
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

