Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A5451D055
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 06:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388941AbiEFEhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 00:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiEFEhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 00:37:17 -0400
Received: from m12-12.163.com (m12-12.163.com [220.181.12.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4FF6E140A3
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 21:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=I+BA0
        Fo8Tt53eRixUoHaMVecXiumQenJeYSFmr5u8eA=; b=Mklypg5opnwq+m/LU57xw
        +TbxEInMknU4ILfDjepQ335DCIMGdeX94TJukpEqtF9X64Rqt/qP6RnNnFjT1nqo
        J+0LNttfLEm4J79hvRnaclJzTZcVLPk3xi4xyKKByJYB6ROZAqp+9FMJMhPmuffL
        4IXA/2o7/s8ocdaL1hCEPs=
Received: from localhost.localdomain (unknown [120.204.77.149])
        by smtp8 (Coremail) with SMTP id DMCowAB3zhrcpHRi95dhBA--.20067S4;
        Fri, 06 May 2022 12:33:08 +0800 (CST)
From:   lizhe <sensor1010@163.com>
To:     bhe@redhat.com, vgoyal@redhat.com, dyoung@redhat.com,
        prudo@redhat.com
Cc:     kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        lizhe <sensor1010@163.com>
Subject: [PATCH v4] kernel/crash_core.c : remove redundant check of ck_cmdline
Date:   Thu,  5 May 2022 21:32:26 -0700
Message-Id: <20220506043226.125611-1-sensor1010@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DMCowAB3zhrcpHRi95dhBA--.20067S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gw1kJry8Jr1fZr1xGw18AFb_yoWxCFg_Ww
        48Krn2qFyUAw1j9r1xZayfWrWYkr40va9a9a43trWava4DJr1rG34rtrn0yrnrA3s7Ar17
        Crs3J3ZrtrWYgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_sqWUUUUUU==
X-Originating-IP: [120.204.77.149]
X-CM-SenderInfo: 5vhq20jurqiii6rwjhhfrp/xS2BdAT4q1gi2I-xYAAAsf
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the end of get_last_crashkernel(), the judgement of ck_cmdline is
obviously unnecessary and causes redundance, let's clean it up.

Signed-off-by: lizhe <sensor1010@163.com>
Acked-by: Baoquan He <bhe@redhat.com>
Acked-by: Philipp Rudo <prudo@redhat.com>
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

