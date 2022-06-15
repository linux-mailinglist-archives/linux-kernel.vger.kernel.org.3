Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC16154CB95
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 16:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbiFOOm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 10:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348322AbiFOOmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 10:42:23 -0400
X-Greylist: delayed 1831 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 15 Jun 2022 07:42:17 PDT
Received: from mail-m963.mail.126.com (mail-m963.mail.126.com [123.126.96.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0E8AD3EF2C;
        Wed, 15 Jun 2022 07:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=N3/Mt
        kLzXrLRD+UKVMKP7QbmD7HARa8p9A8cQM7O1rk=; b=KytgcgfcwQxB1VKVIWE3A
        83u2c2boVT7iSyFC6gR81619FEAfaEReROb5zWnFLAvRlZOoLY42QhEUlLi1knP5
        jawTuBkryMBvOHNRmhnUVaulu7mJr5pd1L3ryr3AYWyXeL1ppZcR1adj+8obogtw
        aw4CDuDaTE4YU/6vlF4bfM=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp8 (Coremail) with SMTP id NORpCgBnO1CM6KliFz2oFg--.54359S2;
        Wed, 15 Jun 2022 22:11:25 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     miodrag.dinic@mips.com, paulburton@kernel.org,
        tsbogend@alpha.franken.de
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        windhl@126.com
Subject: [PATCH] arch: mips: generic: Add missing of_node_put() in board-ranchu.c
Date:   Wed, 15 Jun 2022 22:11:23 +0800
Message-Id: <20220615141123.3968401-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NORpCgBnO1CM6KliFz2oFg--.54359S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF1kKw4UWFy7Ar1UZw43Wrg_yoW3XwbEga
        n7Z3ykWr1rXr4q9ay3ua13CwnIkwn3WrZ5Jr92q3WjyrWF9F47Wan7KrnrAw4IqrsIkrW5
        GaykJrW8ArsF9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRtRRRJUUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbiuA0hF2JVj4CirAAAs1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In ranchu_measure_hpt_freq(), of_find_compatible_node() will return
a node pointer with refcount incremented. We should use of_put_node()
when it is not used anymore.

Signed-off-by: Liang He <windhl@126.com>
---
 arch/mips/generic/board-ranchu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/generic/board-ranchu.c b/arch/mips/generic/board-ranchu.c
index a89aaad59cb1..930c45041882 100644
--- a/arch/mips/generic/board-ranchu.c
+++ b/arch/mips/generic/board-ranchu.c
@@ -44,6 +44,7 @@ static __init unsigned int ranchu_measure_hpt_freq(void)
 		      __func__);
 
 	rtc_base = of_iomap(np, 0);
+	of_node_put(np);
 	if (!rtc_base)
 		panic("%s(): Failed to ioremap Goldfish RTC base!", __func__);
 
-- 
2.25.1

