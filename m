Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF4F64F49D0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1450946AbiDEW3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 18:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457298AbiDEQDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:03:04 -0400
Received: from m12-12.163.com (m12-12.163.com [220.181.12.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 569CC2408C
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 08:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=9Zptn
        J9HIkGLxORVjLEavHV+h6BLMZSlJ7O+XMPB3t8=; b=X6drxuX2boPSFAhIJ5UNM
        Soerm0MLgm/omF7hN5zkwwebGTrhXgI3EOsDa/DuLd2K25twH+dofSxFzNrzOB4W
        Gx1YADMRCXJdbYqgE62AHwvlgD8vseqt5EWYdoynkeLJDhNmZdidl2aytgihBpQo
        /qoY9srWSMq5jGMwKciuGo=
Received: from localhost (unknown [113.116.48.218])
        by smtp8 (Coremail) with SMTP id DMCowAAnVX4BYkxikcMtAg--.50405S2;
        Tue, 05 Apr 2022 23:36:34 +0800 (CST)
From:   wujunwen <wudaemon@163.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org, wujunwen <wudaemon@163.com>
Subject: [PATCH v1] tty/sysrq: change the definition of sysrq_key_table's element to make it more readable
Date:   Tue,  5 Apr 2022 15:36:25 +0000
Message-Id: <20220405153625.55689-1-wudaemon@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DMCowAAnVX4BYkxikcMtAg--.50405S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uFykurWfZw47CFyDuF15Arb_yoW8Ary5pa
        yxCryqyF15uF4jqw4xCa1jqF4ayr93Ga4a9r15Ga4S93s8Gr18JFWjyaySyryrJrW8GF1j
        gr40vF15X3W8J37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zNXd1wUUUUU=
X-Originating-IP: [113.116.48.218]
X-CM-SenderInfo: 5zxgtvxprqqiywtou0bp/1tbiLALZbVspdVcn3gAAsz
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

the definition of sysrq_key_table's elements, like sysrq_thaw_op and 
sysrq_showallcpus_op are massive, so we should make it consistent.

Signed-off-by: wujunwen <wudaemon@163.com>
---
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

