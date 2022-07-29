Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2740585030
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 14:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235357AbiG2Mvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 08:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbiG2Mvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 08:51:49 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F0683ED75
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 05:51:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9D19334798;
        Fri, 29 Jul 2022 12:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1659099106; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=hV0qYTC7OoJpAF9QtQK9rYxys2g6YEbLjVJJxSg9gbU=;
        b=IsWp5mXCuaKwjUMBnUYkMEXBfugN1i6T20EH2hprYvy+Tdb9oxmeUD/ttpPVbeLfVU56A7
        FZ1D5KGxcZbvwffE2Q/dg68sa4YSIGVs/mmXXbS75PSST3qgybQucSHNIFwQFQ/0hCz8of
        qa1YedXBFnXmWLXTZSB3XJjJEmdwhj4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1659099106;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=hV0qYTC7OoJpAF9QtQK9rYxys2g6YEbLjVJJxSg9gbU=;
        b=bZ+McRZGRuYPgzjH834gFMp1Mg6Q+dT5zy7WDiEQzMRmwanxhawXI8G/qn+rlJCjxuawWx
        EcwZDwsj4ew6DcAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BBDB013A8E;
        Fri, 29 Jul 2022 12:51:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dT3LK+HX42IPPQAAMHmgww
        (envelope-from <pvorel@suse.cz>); Fri, 29 Jul 2022 12:51:45 +0000
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-kernel@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH v2 1/1] drivers/base/cpu: Print kernel arch
Date:   Fri, 29 Jul 2022 14:51:41 +0200
Message-Id: <20220729125141.12786-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Print the machine hardware name (UTS_MACHINE) in /proc/sys/kernel/arch.

This helps people who debug kernel with initramfs with minimal
environment (i.e. without coreutils or even busybox) or allow to open
sysfs file instead of run 'uname -m' in high level languages.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 Documentation/admin-guide/sysctl/kernel.rst | 5 +++++
 kernel/utsname_sysctl.c                     | 7 +++++++
 2 files changed, 12 insertions(+)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index ddccd1077462..70a0acf07101 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -65,6 +65,11 @@ combining the following values:
 4 s3_beep
 = =======
 
+arch
+====
+
+The machine hardware name, the same output as ``uname -m``
+(e.g. ``x86_64`` or ``aarch64``).
 
 auto_msgmni
 ===========
diff --git a/kernel/utsname_sysctl.c b/kernel/utsname_sysctl.c
index 4ca61d49885b..7ffdd2cd5ff9 100644
--- a/kernel/utsname_sysctl.c
+++ b/kernel/utsname_sysctl.c
@@ -73,6 +73,13 @@ static DEFINE_CTL_TABLE_POLL(hostname_poll);
 static DEFINE_CTL_TABLE_POLL(domainname_poll);
 
 static struct ctl_table uts_kern_table[] = {
+	{
+		.procname	= "arch",
+		.data		= init_uts_ns.name.machine,
+		.maxlen		= sizeof(init_uts_ns.name.machine),
+		.mode		= 0444,
+		.proc_handler	= proc_do_uts_string,
+	},
 	{
 		.procname	= "ostype",
 		.data		= init_uts_ns.name.sysname,
-- 
2.37.1

