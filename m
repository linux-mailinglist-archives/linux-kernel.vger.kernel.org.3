Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB79539EAF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 09:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350382AbiFAHq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 03:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350369AbiFAHqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 03:46:15 -0400
Received: from mail.meizu.com (edge05.meizu.com [157.122.146.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E30A205F
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 00:46:08 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail12.meizu.com
 (172.16.1.108) with Microsoft SMTP Server (TLS) id 14.3.487.0; Wed, 1 Jun
 2022 15:46:08 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Wed, 1 Jun
 2022 15:46:06 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>
CC:     Haowen Bai <baihaowen@meizu.com>, <linux-um@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] um: remove unused variable
Date:   Wed, 1 Jun 2022 15:46:05 +0800
Message-ID: <1654069565-6968-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-126.meizu.com (172.16.1.126) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable dead is initialized but never used otherwise.

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
 arch/um/os-Linux/umid.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/um/os-Linux/umid.c b/arch/um/os-Linux/umid.c
index a3dd61521d24..7a1abb829930 100644
--- a/arch/um/os-Linux/umid.c
+++ b/arch/um/os-Linux/umid.c
@@ -136,7 +136,7 @@ static int remove_files_and_dir(char *dir)
 static inline int is_umdir_used(char *dir)
 {
 	char pid[sizeof("nnnnnnnnn")], *end, *file;
-	int dead, fd, p, n, err;
+	int fd, p, n, err;
 	size_t filelen = strlen(dir) + sizeof("/pid") + 1;
 
 	file = malloc(filelen);
@@ -145,7 +145,6 @@ static inline int is_umdir_used(char *dir)
 
 	snprintf(file, filelen, "%s/pid", dir);
 
-	dead = 0;
 	fd = open(file, O_RDONLY);
 	if (fd < 0) {
 		fd = -errno;
-- 
2.7.4

