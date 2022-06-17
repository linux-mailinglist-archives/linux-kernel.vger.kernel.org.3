Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4282E54F7BA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 14:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382388AbiFQMlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 08:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245358AbiFQMld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 08:41:33 -0400
Received: from mail-m964.mail.126.com (mail-m964.mail.126.com [123.126.96.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4805F65D39
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 05:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=gq1uv
        r1aBLtCddK9PhILvNreXkKlYFH70qW1RYLIJOI=; b=JQrviY/hXr75pi8Y+qUqG
        6V7UMGh+pxGhfK/HcUMeeW/7Dn5R5yxnqUdMvWEp/V0s4Sfh1hTjJTFzY9d3w+eD
        p41heEKzselCbBN6kCy7N9RomOiTmwbx3uj6rKiQEooiDV2wzc91gJXw2AXdxRwR
        Xq3nQWdoH8LJqeV+G6rd/8=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp9 (Coremail) with SMTP id NeRpCgDn9LlPdqxiAcbnEw--.39061S2;
        Fri, 17 Jun 2022 20:40:48 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     mpe@ellerman.id.au, benh@kernel.crashing.org,
        christophe.leroy@csgroup.eu
Cc:     windhl@126.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: maple: Fix refcount leak bug in time.c
Date:   Fri, 17 Jun 2022 20:40:45 +0800
Message-Id: <20220617124045.4048757-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NeRpCgDn9LlPdqxiAcbnEw--.39061S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF1kKw45XFWfWFW8GrWUtwb_yoW3uwcEk3
        Z7Aa1DXr4xGr4vyF4q9w4fGw12ywnrGF4DKr18X3WxJ3y5Xw13G39rZrW2k340v3yUtFWr
        GayDGF9Fy3WS9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRt73vUUUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi3BIjF1pEDvZlvgAAsH
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In maple_get_boot_time(), of_find_compatible_node() will return
a node pointer with refcount incremented. We should use of_node_put()
in fail path or when it is not used anymore.

Signed-off-by: Liang He <windhl@126.com>
---
 arch/powerpc/platforms/maple/time.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/maple/time.c b/arch/powerpc/platforms/maple/time.c
index 823e219ef8ee..91606411d2e0 100644
--- a/arch/powerpc/platforms/maple/time.c
+++ b/arch/powerpc/platforms/maple/time.c
@@ -153,6 +153,7 @@ time64_t __init maple_get_boot_time(void)
 		       maple_rtc_addr);
 	}
  bail:
+	of_node_put(rtcs);
 	if (maple_rtc_addr == 0) {
 		maple_rtc_addr = RTC_PORT(0); /* legacy address */
 		printk(KERN_INFO "Maple: No device node for RTC, assuming "
-- 
2.25.1

