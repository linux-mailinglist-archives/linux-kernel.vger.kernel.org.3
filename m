Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E56A2505BF7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 17:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345870AbiDRPxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 11:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345774AbiDRPx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 11:53:26 -0400
Received: from m12-16.163.com (m12-16.163.com [220.181.12.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5FDA86170
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 08:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=aP0d/
        Hf8MbnjKRwf/U/o9tyKg4RaO+xBC7661/QXVMQ=; b=Fk0JcKcJRVeC6/PoUGOF3
        PY5e2iVyhi9hchKblMKX0QtJyHVMjt/ZfnupXlJQXcAX6ru4/507hu2jJEt+4Kwu
        O8i5KEl1IWvvxeKFEK9IWeklwftVIvsId9+P4Ews4kO36USUsglgSo7MOfoZ/1q5
        05UyrzVxtEIFOGHdY35T3Q=
Received: from localhost (unknown [116.30.192.61])
        by smtp12 (Coremail) with SMTP id EMCowACH_SmvhV1iUzhcAQ--.2679S2;
        Mon, 18 Apr 2022 23:37:20 +0800 (CST)
From:   Junwen Wu <wudaemon@163.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org, Junwen Wu <wudaemon@gmail.com>
Subject: [PATCH v2] tty/sysrq: change the definition of sysrq_key_table's element to make it more readable
Date:   Mon, 18 Apr 2022 15:37:03 +0000
Message-Id: <20220418153703.97705-1-wudaemon@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EMCowACH_SmvhV1iUzhcAQ--.2679S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AFyUury3Kr1xAF45Jr48Crg_yoW8Cryfpa
        yxuryqyFy5ZF40qw1xCF4jgF4ayr93Ga4a9r15Ca4S9wn8Kr18AFWjyaySgryrJrW8GF12
        krW0vr15Xw1UJ37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jH6wZUUUUU=
X-Originating-IP: [116.30.192.61]
X-CM-SenderInfo: 5zxgtvxprqqiywtou0bp/xtbBFBDmbVaEDYMLDwAAsX
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Junwen Wu <wudaemon@gmail.com>

The definition of sysrq_key_table's elements, like sysrq_thaw_op and
sysrq_showallcpus_op are not consistent with sysrq_ftrace_dump_op,
Consistency makes code more readable.

Signed-off-by: Junwen Wu <wudaemon@gmail.com>
---
V1 -> V2: Fix some commit message's error

 drivers/tty/sysrq.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index bbfd004449b5..9485156bf48b 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -274,6 +274,8 @@ static const struct sysrq_key_op sysrq_showallcpus_op = {
 	.action_msg	= "Show backtrace of all active CPUs",
 	.enable_mask	= SYSRQ_ENABLE_DUMP,
 };
+#else
+#define sysrq_showallcpus_op (*(const struct sysrq_key_op *)NULL)
 #endif
 
 static void sysrq_handle_showregs(int key)
@@ -405,6 +407,7 @@ static const struct sysrq_key_op sysrq_moom_op = {
 	.enable_mask	= SYSRQ_ENABLE_SIGNAL,
 };
 
+#ifdef CONFIG_BLOCK
 static void sysrq_handle_thaw(int key)
 {
 	emergency_thaw_all();
@@ -415,6 +418,9 @@ static const struct sysrq_key_op sysrq_thaw_op = {
 	.action_msg	= "Emergency Thaw of all frozen filesystems",
 	.enable_mask	= SYSRQ_ENABLE_SIGNAL,
 };
+#else
+#define sysrq_thaw_op (*(const struct sysrq_key_op *)NULL)
+#endif
 
 static void sysrq_handle_kill(int key)
 {
@@ -468,17 +474,9 @@ static const struct sysrq_key_op *sysrq_key_table[62] = {
 	NULL,				/* g */
 	NULL,				/* h - reserved for help */
 	&sysrq_kill_op,			/* i */
-#ifdef CONFIG_BLOCK
 	&sysrq_thaw_op,			/* j */
-#else
-	NULL,				/* j */
-#endif
 	&sysrq_SAK_op,			/* k */
-#ifdef CONFIG_SMP
 	&sysrq_showallcpus_op,		/* l */
-#else
-	NULL,				/* l */
-#endif
 	&sysrq_showmem_op,		/* m */
 	&sysrq_unrt_op,			/* n */
 	/* o: This will often be registered as 'Off' at init time */
-- 
2.25.1

