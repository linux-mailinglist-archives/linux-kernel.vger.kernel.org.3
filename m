Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 092B554F00F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 06:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379971AbiFQEVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 00:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379966AbiFQEVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 00:21:42 -0400
Received: from mail-m963.mail.126.com (mail-m963.mail.126.com [123.126.96.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 17690666A4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 21:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=ENvGQ
        PwIvf1KPG42t7qvZiJODByyrvbH42c33b2b8TU=; b=kTU2lWOAAwxs67X1r/NHj
        TqT3s4m+mBoWxZTK7sPw7137FzgDrueWkFEuYdYW4uGl/eCeHjmgaR54l0lxQYVs
        ZnPPl4at5zHOB5OGLWbvKm1yfjbACta6QImmZRs0kj4z+Ux5mO+nyelnAvZT05oc
        N5kQXCWwGFCojsVeff4K/g=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp8 (Coremail) with SMTP id NORpCgDndoMYAaxioZlTFw--.27823S2;
        Fri, 17 Jun 2022 12:20:41 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org
Cc:     windhl@126.com, nick.child@ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: powernv: Fix refcount leak bug in opal-powercap
Date:   Fri, 17 Jun 2022 12:20:38 +0800
Message-Id: <20220617042038.4003704-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NORpCgDndoMYAaxioZlTFw--.27823S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uFyfGw1fZr13Ww13Gw18Grg_yoW8Jw48pr
        9093yxXa18CrWIyayIyaykuF4UtFn5Cr4UG34UCry7AwsxZwnayr4jyry3JFn7AF45Jw1F
        vr4ag3s8tFnxuaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziW8BUUUUUU=
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/xtbBGhEjF1-HZUM9IgAAse
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In opal_powercap_init(), of_find_compatible_node() will return
a node pointer with refcount incremented. We should use of_node_put()
in fail path or when it is not used anymore.

Besides, for_each_child_of_node() will automatically *inc* and *dec*
refcount during iteration. However, we should add the of_node_put()
if there is a break.

Signed-off-by: Liang He <windhl@126.com>
---
 arch/powerpc/platforms/powernv/opal-powercap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/opal-powercap.c b/arch/powerpc/platforms/powernv/opal-powercap.c
index 64506b46e77b..b102477d3f95 100644
--- a/arch/powerpc/platforms/powernv/opal-powercap.c
+++ b/arch/powerpc/platforms/powernv/opal-powercap.c
@@ -153,7 +153,7 @@ void __init opal_powercap_init(void)
 	pcaps = kcalloc(of_get_child_count(powercap), sizeof(*pcaps),
 			GFP_KERNEL);
 	if (!pcaps)
-		return;
+		goto out_powercap;
 
 	powercap_kobj = kobject_create_and_add("powercap", opal_kobj);
 	if (!powercap_kobj) {
@@ -236,6 +236,9 @@ void __init opal_powercap_init(void)
 		kfree(pcaps[i].pg.name);
 	}
 	kobject_put(powercap_kobj);
+	of_node_put(node);
 out_pcaps:
 	kfree(pcaps);
+out_powercap:
+	of_node_put(powercap);
 }
-- 
2.25.1

