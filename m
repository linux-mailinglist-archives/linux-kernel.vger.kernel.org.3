Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF0551A007
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 14:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350043AbiEDM4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 08:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237921AbiEDM4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 08:56:11 -0400
X-Greylist: delayed 901 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 04 May 2022 05:52:35 PDT
Received: from m12-18.163.com (m12-18.163.com [220.181.12.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 25F452AE12
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 05:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=0j/hv
        WPupqrJGaOCk9faAVdYLcHHclCHbuBk/wL09eE=; b=XKXx2GJzfal9rxPRPgbfQ
        1/robgERR1lNwK3ndSt6c+kbjEqn6m8tyRqe8yKVCAUPSu4wQ6drHUVyos7whsxy
        3AFuhqCosXFTwzcqmjn1GnW0km6lUAiKXIe+nUNDrOcpD0reS/lfvJSmxaaMWmg7
        kwyM6ZWcBsB0ThHHG8xkHs=
Received: from localhost.localdomain (unknown [120.204.77.149])
        by smtp14 (Coremail) with SMTP id EsCowABnJ_tKc3JikTI+Aw--.4038S4;
        Wed, 04 May 2022 20:37:05 +0800 (CST)
From:   lizhe <sensor1010@163.com>
To:     bhe@redhat.com, vgoyal@redhat.com, dyoung@redhat.com,
        prudo@redhat.com
Cc:     kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        lizhe <sensor1010@163.com>
Subject: [PATCH] kernel/crash_core.c : Remove redundant checks for ck_cmdline is NULL
Date:   Wed,  4 May 2022 05:36:23 -0700
Message-Id: <20220504123623.36852-1-sensor1010@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EsCowABnJ_tKc3JikTI+Aw--.4038S4
X-Coremail-Antispam: 1Uf129KBjvdXoW5Kr1rCw4xCrWxArWUXFW7CFg_yoWxXrX_W3
        y7Krn2qr15Aw1j9r18ZayfWrWUKa10va9a9a43trW2va47trn5G343JFn0yrnxC397Cr17
        Gws7Jrnrt3yakjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_sqWUUUUUU==
X-Originating-IP: [120.204.77.149]
X-CM-SenderInfo: 5vhq20jurqiii6rwjhhfrp/xtbBohH2q1aEEK-VzAAAsa
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When ck_cmdline is NULL. The last three lines of
this function(get_last_crashkernel()) are equivalent to :
	if (!NULL)
		return NULL;

	return NULL;
This is obviously a redundant check

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

