Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF2350E49B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 17:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237837AbiDYPnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 11:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232883AbiDYPnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 11:43:51 -0400
Received: from m12-12.163.com (m12-12.163.com [220.181.12.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 820A52CCA0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 08:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=rlTcn
        UtCD9kwC8NAxm705JWV4lU/pY88fG0RnTfd8/E=; b=kYvhE8m49CWD197s7d1UO
        LX/ASfKJI4CEMxg/+peYv3GXSG+a6AhIQsXM0ntqbJRvzPOt+H0kBUfcNFJ+ETrp
        jyJX4+3gBxs851ZGn57g81KdiG6r7dhB7VW7gJOLy8gnSFBfeFs0xEsoBIpLv9Ww
        065z5mnJmzHyKuJIfRiCEg=
Received: from localhost.localdomain (unknown [120.204.77.149])
        by smtp8 (Coremail) with SMTP id DMCowAAn6uuXwGZiZEwODA--.43529S4;
        Mon, 25 Apr 2022 23:40:03 +0800 (CST)
From:   lizhe <sensor1010@163.com>
To:     bhe@redhat.com, vgoyal@redhat.com, dyoung@redhat.com,
        prudo@redhat.com, sensor1010@163.com
Cc:     kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] kernel/crash_core.c : Remove redundant checks for ck_cmdline is NULL
Date:   Mon, 25 Apr 2022 08:38:57 -0700
Message-Id: <20220425153857.21922-1-sensor1010@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DMCowAAn6uuXwGZiZEwODA--.43529S4
X-Coremail-Antispam: 1Uf129KBjvdXoW5Kry7uryDtry3Cw1kCFy5twb_yoWxXrc_Xw
        47KF1vqryrAw1j9r4UAayrWrWUKw4jvFZa9a43trW2va47tryrG343JFn0yrn8C397Ary7
        CFnrGrsFyrWrKjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRM5l8UUUUUU==
X-Originating-IP: [120.204.77.149]
X-CM-SenderInfo: 5vhq20jurqiii6rwjhhfrp/xS2BdBPtq1gi15X2AgAAst
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 When ck_cmdline is NULL, the only caller of get_last_crashkernel()
 has already done non-NULL check(see __parse_crashkernel()),
 so it doesn't make any sense to make a check here

Signed-off-by: lizhe <sensor1010@163.com>
---
 kernel/crash_core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 256cf6db573c..c232f01a2c54 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -222,9 +222,6 @@ static __init char *get_last_crashkernel(char *cmdline,
 		p = strstr(p+1, name);
 	}
 
-	if (!ck_cmdline)
-		return NULL;
-
 	return ck_cmdline;
 }
 
-- 
2.25.1

