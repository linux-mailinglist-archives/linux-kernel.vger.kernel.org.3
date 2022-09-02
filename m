Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B24295AB128
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 15:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238683AbiIBNFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 09:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238807AbiIBND5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 09:03:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54ADD110DB9
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 05:42:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5AA72620FE
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 12:40:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11F9CC433D6;
        Fri,  2 Sep 2022 12:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662122435;
        bh=ctIlZ1dKIFN9a2uUzSrDB28SEGv6Sp4lWkDy3XCto0w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AbDGYx1cptX/p+QnlbRkFjpPXXiTtLWw9RBdJTbnUq0hWb7QTFTywE62cFjT7uSmq
         LOeVmMKXNE0jW4jVL4yxLlUTewwjkFN/Vb+HoOmA8BYNyCZUjNBnUdO4zfxUo1gB2E
         rSDv2gpNPw/7QeUj0BJao+YTfYQzb1r+/LziEM8Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Major Chen <major.chen@samsung.com>,
        stable <stable@kernel.org>, Kuyo Chang <kuyo.chang@mediatek.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH 2/2] sched/debug: fix dentry leak in update_sched_domain_debugfs
Date:   Fri,  2 Sep 2022 14:31:07 +0200
Message-Id: <20220902123107.109274-2-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220902123107.109274-1-gregkh@linuxfoundation.org>
References: <20220902123107.109274-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1566; i=gregkh@linuxfoundation.org; h=from:subject; bh=ctIlZ1dKIFN9a2uUzSrDB28SEGv6Sp4lWkDy3XCto0w=; b=owGbwMvMwCRo6H6F97bub03G02pJDMmC37v3ZIT9uCl0cz3v37W3pOTZOqJfaDlZTWEwYlKTfr3Y vVSxI5aFQZCJQVZMkeXLNp6j+ysOKXoZ2p6GmcPKBDKEgYtTACaicIhhfs3vuZsdNp57vv4730HrpG tK2c7Z+Qzzq8sL7i7UvbymaMWM+YdOzmI/PY/rPgA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kuyo reports that the pattern of using debugfs_remove(debugfs_lookup())
leaks a dentry and with a hotplug stress test, the machine eventually
runs out of memory.

Fix this up by using the newly created debugfs_lookup_and_remove() call
instead which properly handles the dentry reference counting logic.

Cc: Major Chen <major.chen@samsung.com>
Cc: stable <stable@kernel.org>
Reported-by: Kuyo Chang <kuyo.chang@mediatek.com>
Tested-by: Kuyo Chang <kuyo.chang@mediatek.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/sched/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index bb3d63bdf4ae..667876da8382 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -416,7 +416,7 @@ void update_sched_domain_debugfs(void)
 		char buf[32];
 
 		snprintf(buf, sizeof(buf), "cpu%d", cpu);
-		debugfs_remove(debugfs_lookup(buf, sd_dentry));
+		debugfs_lookup_and_remove(buf, sd_dentry);
 		d_cpu = debugfs_create_dir(buf, sd_dentry);
 
 		i = 0;
-- 
2.37.3

