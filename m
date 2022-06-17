Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA8D54FA03
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 17:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383089AbiFQPRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 11:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383075AbiFQPRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 11:17:22 -0400
Received: from m15113.mail.126.com (m15113.mail.126.com [220.181.15.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 64B133D4B6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 08:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=vy1/z
        mDGugMG37ryPH+Tv9++kz/jYiS+PNBOnKejF74=; b=BLYii+CdmmgloV+8qoUs6
        5D5Gkl9KEhdNq39k35e9sspeBUc+UlYSxr5/X/izQ+2caoRxwtj+O/d83Mofx1Q6
        0gcIIFxsOv5nRugHhtamRuw7BUJAtW+FJ6BVr+4LjOv1ZdggYQWzd6w5NVIycomT
        uZTMn5PBwkRbyz5rv0p+9U=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp3 (Coremail) with SMTP id DcmowADHZZf0maxiKDiLDg--.37809S2;
        Fri, 17 Jun 2022 23:12:53 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        christophe.leroy@csgroup.eu, joel@jms.id.au
Cc:     windhl@126.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: sysdev: Fix refcount leak bug in mpic_msgr
Date:   Fri, 17 Jun 2022 23:12:52 +0800
Message-Id: <20220617151252.4051291-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DcmowADHZZf0maxiKDiLDg--.37809S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKr1kKr1UGr1ftF1kWF13CFg_yoWfZrcEk3
        Z2g34kAFWkJr48ZFsxZrWrX3Z5A3WfWrn8Jrn2qa17Aw1aqa17Xw47X395AryqgFsFy3yr
        AFn3Wrnaga40yjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjnYwUUUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbiuBYjF2JVj6in2AAAs1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In mpic_msgr_number_of_blocks() and mpic_msgr_block_number(),
of_find_node_by_name() will return a node pointer with refcount
incremented. We should use of_node_put() when it is not used
anymore.

Signed-off-by: Liang He <windhl@126.com>
---
 arch/powerpc/sysdev/mpic_msgr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/sysdev/mpic_msgr.c b/arch/powerpc/sysdev/mpic_msgr.c
index 698fefaaa6dd..c2a235d9eb09 100644
--- a/arch/powerpc/sysdev/mpic_msgr.c
+++ b/arch/powerpc/sysdev/mpic_msgr.c
@@ -122,6 +122,7 @@ static unsigned int mpic_msgr_number_of_blocks(void)
 			count += 1;
 		}
 	}
+	of_node_put(aliases);
 
 	return count;
 }
@@ -150,6 +151,7 @@ static int mpic_msgr_block_number(struct device_node *node)
 		if (node == of_find_node_by_path(prop->value))
 			break;
 	}
+	of_node_put(aliases);
 
 	return index == number_of_blocks ? -1 : index;
 }
-- 
2.25.1

