Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D582254CCEC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 17:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243040AbiFOP3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 11:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356588AbiFOP3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 11:29:07 -0400
Received: from m15114.mail.126.com (m15114.mail.126.com [220.181.15.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A1E63F51
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 08:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=v8A8X
        gGGq6V2cX2rv6Le2xycbYkR9zdD7411m4UCQbo=; b=LlNUhji5VXOVeko8CN6xZ
        hHA7Gb6OAk15zLjs9Tk88L4bWYgu22g3lyqpX7B8Ys8o60E7Prz+2NHU4XA+05wx
        Uk9qUXEckG4SRjuQhtn4zP85xYxVrcDoZDHanHPULi8E9YoZ4SKhLrvqRKHS1p9F
        JJRCYeTOKj2+uWjaNdE8rE=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp7 (Coremail) with SMTP id DsmowAB3RvKx+qli0150DQ--.48390S2;
        Wed, 15 Jun 2022 23:28:49 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     tsbogend@alpha.franken.de, yangtiezhu@loongson.cn
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        windhl@126.com
Subject: [PATCH] mips: pic32: pic32mzda: Add missing of_node_put() in init.c
Date:   Wed, 15 Jun 2022 23:28:49 +0800
Message-Id: <20220615152849.3970438-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DsmowAB3RvKx+qli0150DQ--.48390S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtrWrZFWUCF4fWw1ruF4kWFg_yoWfGFc_Wr
        n7XrW8Wr4rJFn8uay7Z3W3G3s5Zw45WFnY9rs3Aryayw1rArZxGF4qq34qyw17uFWYyrW5
        AFZ8u345uw4avjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRKnmRDUUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/xtbBGgIhF1-HZTd1UwAAsC
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In pic32_of_prepare_platform_data(), of_find_compatible_node() will
return a node pointer with refcount incremented. We should use
of_node_put() when it is not used anymore.

Signed-off-by: Liang He <windhl@126.com>
---
 arch/mips/pic32/pic32mzda/init.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/mips/pic32/pic32mzda/init.c b/arch/mips/pic32/pic32mzda/init.c
index 129915616763..2b134d5d54e1 100644
--- a/arch/mips/pic32/pic32mzda/init.c
+++ b/arch/mips/pic32/pic32mzda/init.c
@@ -99,9 +99,13 @@ static int __init pic32_of_prepare_platform_data(struct of_dev_auxdata *lookup)
 		if (np) {
 			lookup->name = (char *)np->name;
 			if (lookup->phys_addr)
+			{
+				of_node_put(np);
 				continue;
+			}
 			if (!of_address_to_resource(np, 0, &res))
 				lookup->phys_addr = res.start;
+			of_node_put(np);
 		}
 	}
 
-- 
2.25.1

