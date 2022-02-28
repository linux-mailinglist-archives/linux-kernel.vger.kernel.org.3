Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19E4A4C7CDE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 23:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbiB1WGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 17:06:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbiB1WGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 17:06:46 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0D1C5592;
        Mon, 28 Feb 2022 14:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=qQiyG07geDHC1MAj6L9Yr/5MiWZ9dN3JGu6iSFcM2JY=; b=1sjzhJ9VvdSuLFyV73mmBZV4EU
        jYMSkfAgGtxrb0Vsa6i5XoZvlR6hgYJHW22sOTIL/mOLMaCsEKJqGzGwH4qoxp8g5LqIrFvM2EQVf
        w8w+6b6xTxUvujV/2i7onrvr52QCODaDXnz1zCQ+oqWTdRdgJFKkuZiiypq7e+kgINboeWJOBdyVC
        /Ssr0S8cnYyPUIve5WCnOn+NUXUeTbS1OtT6WP1HWvfX9JxvoMDaaKGrhEcpkGkH7KMHHbgROZbrA
        WKP+NjBQu/j8pd7oM6H0NA0TTl0ecIlTnodI8WJJvkllsUV+iQj5RMGStTU5bIA6RBul2mAz4m/9Y
        U3gmB7xA==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nOo9J-00EG7H-Ds; Mon, 28 Feb 2022 22:05:45 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Igor Zhbanov <i.zhbanov@omprussia.ru>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        linux-pm@vger.kernel.org
Subject: [PATCH] PM/sleep: fix return value of __setup handler
Date:   Mon, 28 Feb 2022 14:05:44 -0800
Message-Id: <20220228220544.22877-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an invalid option is given for "test_suspend=<option>", the entire
string is added to init's environment, so return 1 instead of 0 from
the __setup handler.

  Unknown kernel command line parameters "BOOT_IMAGE=/boot/bzImage-517rc5
    test_suspend=invalid"

and

 Run /sbin/init as init process
   with arguments:
     /sbin/init
   with environment:
     HOME=/
     TERM=linux
     BOOT_IMAGE=/boot/bzImage-517rc5
     test_suspend=invalid

Fixes: 2ce986892faf ("PM / sleep: Enhance test_suspend option with repeat capability")
Fixes: 27ddcc6596e5 ("PM / sleep: Add state field to pm_states[] entries")
Fixes: a9d7052363a6 ("PM: Separate suspend to RAM functionality from core")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: Igor Zhbanov <i.zhbanov@omprussia.ru>
Link: lore.kernel.org/r/64644a2f-4a20-bab3-1e15-3b2cdd0defe3@omprussia.ru
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <len.brown@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@vger.kernel.org
---
Would someone like warning messages added in case of bad option strings?

 kernel/power/suspend_test.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- linux-next-20220228.orig/kernel/power/suspend_test.c
+++ linux-next-20220228/kernel/power/suspend_test.c
@@ -157,22 +157,22 @@ static int __init setup_test_suspend(cha
 	value++;
 	suspend_type = strsep(&value, ",");
 	if (!suspend_type)
-		return 0;
+		return 1;
 
 	repeat = strsep(&value, ",");
 	if (repeat) {
 		if (kstrtou32(repeat, 0, &test_repeat_count_max))
-			return 0;
+			return 1;
 	}
 
 	for (i = PM_SUSPEND_MIN; i < PM_SUSPEND_MAX; i++)
 		if (!strcmp(pm_labels[i], suspend_type)) {
 			test_state_label = pm_labels[i];
-			return 0;
+			return 1;
 		}
 
 	printk(warn_bad_state, suspend_type);
-	return 0;
+	return 1;
 }
 __setup("test_suspend", setup_test_suspend);
 
