Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBF9F5501C9
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 03:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383679AbiFRB6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 21:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383656AbiFRB5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 21:57:53 -0400
Received: from mail-m964.mail.126.com (mail-m964.mail.126.com [123.126.96.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AC79413D14
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 18:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=kk5pK
        Hd/2mIBIK8MdK5R9s8Uq/oarlTlmc5aNu1O+CA=; b=VwIAfyMA2jVL4JYqokrTX
        luiPKA19cIyiVJNT0wgny1XLq0tEAWpM+x0hV9kanQyE9m1fN3/wBRUWofI8+vVS
        omTpXwwt9ntk/vRtz7AZGQKAdXAsNYQ7aRCEd8wp5Wg15YZQ/RBYIEt+lg5H65tu
        pPzuGLwdWBBQidD4vn61Sc=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp9 (Coremail) with SMTP id NeRpCgB3jMHWMK1iA1L9Ew--.45551S2;
        Sat, 18 Jun 2022 09:56:39 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        npiggin@gmail.com, clg@kaod.org, haren@linux.ibm.com,
        christophe.leroy@csgroup.eu
Cc:     windhl@126.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: powernv: opal-core: Fix refcount leak bug
Date:   Sat, 18 Jun 2022 09:56:37 +0800
Message-Id: <20220618015637.4055531-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NeRpCgB3jMHWMK1iA1L9Ew--.45551S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrury7Gry3ZryrXryUWr4rZrb_yoW3urb_Kw
        1xJa47Jrs5Gr4vva4Duw4fWr1qv3s3Grs8Gr1Iq3ZrtFy3ta9xGw47JrWUW3WDurZFyrZ8
        GFZ3trsrCa4SvjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUj2jgDUUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi7QUkF1pEAONKeAABsV
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In create_opalcore(), of_find_node_by_name() will return a node
pointer with refcount incremented. We should use of_node_put()
when it is not used anymore.

Signed-off-by: Liang He <windhl@126.com>
---
 arch/powerpc/platforms/powernv/opal-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/opal-core.c b/arch/powerpc/platforms/powernv/opal-core.c
index adcb1a1a2bfe..bb7657115f1d 100644
--- a/arch/powerpc/platforms/powernv/opal-core.c
+++ b/arch/powerpc/platforms/powernv/opal-core.c
@@ -348,6 +348,8 @@ static int __init create_opalcore(void)
 	if (!dn || ret)
 		pr_warn("WARNING: Failed to read OPAL base & entry values\n");
 
+	of_node_put(dn);
+
 	/* Use count to keep track of the program headers */
 	count = 0;
 
-- 
2.25.1

