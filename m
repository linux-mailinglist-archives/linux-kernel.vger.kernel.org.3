Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 180DB550227
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 04:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383969AbiFRCub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 22:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383962AbiFRCuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 22:50:23 -0400
Received: from m15112.mail.126.com (m15112.mail.126.com [220.181.15.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 711C06A03F
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 19:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=qkQlh
        JZghESEYg/d4Msy2Ak1gToS/EiqAWzA7FqaO/Q=; b=nwDTrMVgqsrex7ezfztp4
        8dxOoWCiFIGWezETrlf7WgT5PsEY4wILYMgRJLIeFUIyXvAd4JjgmDxB2sWAR7QY
        JofUIKzHXzZvqPj2eXjOKJREpZVf1pmyeWfF68vcld8Mzbqemn5v98jY9cJYak38
        WxBsm+RqBc1OaitjlAZOxo=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp2 (Coremail) with SMTP id DMmowACXBAE6Pa1icrFnDg--.23352S2;
        Sat, 18 Jun 2022 10:49:30 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     christophe.leroy@csgroup.eu, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org
Cc:     windhl@126.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: 8xx: Fix refcount leak bug in tqm8xx_setup
Date:   Sat, 18 Jun 2022 10:49:30 +0800
Message-Id: <20220618024930.4056825-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DMmowACXBAE6Pa1icrFnDg--.23352S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKry8GF4kGr13Kr4fuFW5trb_yoW3WwbEyw
        1IkFs5Cws5GrWktFnrZF43GF90kF15WFWqg3WjqanxZ343X3ZxGrnrXFZrGw47uF42krW3
        Ca4kKr9xu3ZakjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjBOJ7UUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi7RskF1pEAOORoQAAsI
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In init_ioports(), of_find_node_by_name() will return a node pointer
with refcount incremented. We should use of_node_put() when it is not
used anymore.

Signed-off-by: Liang He <windhl@126.com>
---
 arch/powerpc/platforms/8xx/tqm8xx_setup.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/platforms/8xx/tqm8xx_setup.c b/arch/powerpc/platforms/8xx/tqm8xx_setup.c
index 3725d51248df..ffcfd17a5fa3 100644
--- a/arch/powerpc/platforms/8xx/tqm8xx_setup.c
+++ b/arch/powerpc/platforms/8xx/tqm8xx_setup.c
@@ -105,6 +105,9 @@ static void __init init_ioports(void)
 	if (dnode == NULL)
 		return;
 	prop = of_find_property(dnode, "ethernet1", &len);
+
+	of_node_put(dnode);
+
 	if (prop == NULL)
 		return;
 
-- 
2.25.1

