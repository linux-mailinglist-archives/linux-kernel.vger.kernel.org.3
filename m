Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0ED350A896
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 20:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391643AbiDUTAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 15:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391632AbiDUTAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 15:00:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A611171
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 11:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=7GHKFnbj3QVvMVmD5+xSq/YafPBrluK6Cd8roIkA8zs=; b=Dz2MqSeh7ovHxEfejHz4J5gTG7
        /6fJtO9omLvMzbPglH+V8GwzBX1v+4Xa/QD/6EYVT3wHY+IYiD6vBoxyri1vRbcbeyiP6emn/FMMa
        j/DYcrfPckvApvmMytsQLWAqIxnbNXUe7fdQeaXr42bscxgdJ98q1i7z0znWm+av7140+egbpceNB
        a68kXQaJlSMmkrH5D+CDFgEdEfBcK8R8lItGhBDvLij83ugWBNbMAW2zlUK+9sz748sm/8SLeNVRL
        YyPHcuHQ0bUogr9k4kiOoDU+yYjvX5KZS3BghqDaz3h8LpDLoFUAs34PaaCn7n6QxslcL0FdqZoOd
        io03t7WQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nhbzB-00EifQ-LQ; Thu, 21 Apr 2022 18:57:01 +0000
Date:   Thu, 21 Apr 2022 11:57:01 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mingo@redhat.com, YueHaibing <yuehaibing@huawei.com>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        mcgrof@kernel.org
Subject: [PATCH] ftrace: fix building with SYSCTL=y but DYNAMIC_FTRACE=n
Message-ID: <YmGo/TcNVzOK4Bjn@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ok so hopefully this is the last of it. 0day picked up a build
failure [0] when SYSCTL=y but DYNAMIC_FTRACE=n. This can be fixed
by just declaring an empty routine for the calls moved just
recently.

[0] https://lkml.kernel.org/r/202204161203.6dSlgKJX-lkp@intel.com

Reported-by: kernel test robot <lkp@intel.com>
Fixes: f8b7d2b4c192 ("ftrace: fix building with SYSCTL=n but DYNAMIC_FTRACE=y")
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 kernel/trace/ftrace.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index d9424fd9a183..1f89039f0feb 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -7873,6 +7873,8 @@ int unregister_ftrace_function(struct ftrace_ops *ops)
 EXPORT_SYMBOL_GPL(unregister_ftrace_function);
 
 #ifdef CONFIG_SYSCTL
+
+#ifdef CONFIG_DYNAMIC_FTRACE
 static void ftrace_startup_sysctl(void)
 {
 	int command;
@@ -7906,6 +7908,10 @@ static void ftrace_shutdown_sysctl(void)
 		ftrace_run_update_code(command);
 	}
 }
+#else
+# define ftrace_startup_sysctl()       do { } while (0)
+# define ftrace_shutdown_sysctl()      do { } while (0)
+#endif /* CONFIG_DYNAMIC_FTRACE */
 
 static bool is_permanent_ops_registered(void)
 {
-- 
2.35.1

