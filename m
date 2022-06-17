Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 676F254EFFE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 06:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379840AbiFQEMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 00:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbiFQEME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 00:12:04 -0400
Received: from m15111.mail.126.com (m15111.mail.126.com [220.181.15.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D1AB165433;
        Thu, 16 Jun 2022 21:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=n2N7s
        6BnjSWl2Opp1oE4L1xAtlp8vuylpNqGoBcOilc=; b=cwh1xEDNzptnVZqr3Wf0v
        2/F6+2/sqWVnlv1bf5KWR0HidTRw7c9mC5YkPBXJdTn8DBu3xpIQuYeKusbvpmYW
        LTHiQ0SmpBd7jtGAHxsIUF4UOurVqwTlvYqajjgjUoI+dkyP0xnimlK9jQ6HOEVL
        gBSDZC3weZT2mEsCLvBPBw=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp1 (Coremail) with SMTP id C8mowACHY9xx96tiYuLiEg--.19761S2;
        Fri, 17 Jun 2022 11:39:39 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     john@phrozen.org, tsbogend@alpha.franken.de
Cc:     windhl@126.com, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mips: ralink: Fix refcount leak in of.c
Date:   Fri, 17 Jun 2022 11:39:29 +0800
Message-Id: <20220617033929.4002832-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C8mowACHY9xx96tiYuLiEg--.19761S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF4UXry8JryrKry3uw13CFg_yoWxKFXEq3
        WIgws7ur43Awn5WayDCa13Was8Z3s3Wrn3Gw1xtFWIyr90vF1DKrWSqr1DXry8W39rtFW8
        A3srAa1Y9w4a9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRKFApDUUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi7R0jF1pEANzNhwAAsM
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In plat_of_remap_node(), plat_of_remap_node() will return a node
pointer with refcount incremented. We should use of_node_put()
when it is not used anymore.

Signed-off-by: Liang He <windhl@126.com>
---
 arch/mips/ralink/of.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/ralink/of.c b/arch/mips/ralink/of.c
index 587c7b998769..ea8072acf8d9 100644
--- a/arch/mips/ralink/of.c
+++ b/arch/mips/ralink/of.c
@@ -40,6 +40,8 @@ __iomem void *plat_of_remap_node(const char *node)
 	if (of_address_to_resource(np, 0, &res))
 		panic("Failed to get resource for %s", node);
 
+	of_node_put(np);
+
 	if (!request_mem_region(res.start,
 				resource_size(&res),
 				res.name))
-- 
2.25.1

