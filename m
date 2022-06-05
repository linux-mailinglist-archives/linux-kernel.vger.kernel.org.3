Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9639E53DE37
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 22:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347265AbiFEUn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 16:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiFEUn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 16:43:56 -0400
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA92266F
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 13:43:53 -0700 (PDT)
Received: (wp-smtpd smtp.wp.pl 12142 invoked from network); 5 Jun 2022 22:43:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1654461829; bh=MCYrEjgzieJDKLfSTVWSDFa0xMQ9SUb7yWBOIBy4GZw=;
          h=From:To:Cc:Subject;
          b=eMjPXfP77QOc2vnNXkCxF/w2ISUbuXJ0uppmHnajDp8T4rRCQktqHX1WDSrQlpqiV
           J705YI+LC15YX6NKC/5Gv5qkNdpRodJ2CsuXzzgg4LIWmk8Gv9kJTV/xp8GtABSTeZ
           qSP71wjemrXWa0VwRyzJzd+MCvflyZbPSqIpFKk4=
Received: from public-gprs207966.centertel.pl (HELO mocarz) (deweloper@wp.pl@[46.134.151.159])
          (envelope-sender <deweloper@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <arnd@arndb.de>; 5 Jun 2022 22:43:49 +0200
Date:   Sun, 5 Jun 2022 22:43:47 +0200
From:   Aleksander Mazur <deweloper@wp.pl>
To:     Arnd Bergmann <arnd@arndb.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Aleksander Mazur <deweloper@wp.pl>, linux-kernel@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH] /proc/modules: honor kptr_restrict even without
 CONFIG_KALLSYMS
Message-ID: <20220605224347.481e2fb4@mocarz>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-WP-MailID: 28a283f460c12e9444f57583fc01d6b6
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 000000A [8YNk]                               
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit e4a8ca3baa55 fixed building without CONFIG_KALLSYMS by providing
dummy kallsyms_show_value(). Unfortunately -- due to hard-coded "false"
being returned -- access to addresses in /proc/modules became permanently
disabled.

My proposal is to change this unconditional "false" to !kptr_restrict.
This re-enables addresses in /proc/modules even without CONFIG_KALLSYSMS
unless restricted by means of sysctl (kernel.kptr_restrict).

Fixes: e4a8ca3baa55 ("/proc/module: fix building without kallsyms")
Signed-off-by: Aleksander Mazur <deweloper@wp.pl>
---
 include/linux/kallsyms.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/kallsyms.h b/include/linux/kallsyms.h
index ad39636e0c3f..cf64f9709f46 100644
--- a/include/linux/kallsyms.h
+++ b/include/linux/kallsyms.h
@@ -160,7 +160,7 @@ static inline int lookup_symbol_attrs(unsigned long addr, unsigned long *size, u
 
 static inline bool kallsyms_show_value(const struct cred *cred)
 {
-	return false;
+	return !kptr_restrict;
 }
 
 static inline int kallsyms_on_each_symbol(int (*fn)(void *, const char *, struct module *,
-- 
2.36.1

