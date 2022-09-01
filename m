Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 196435AA055
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 21:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234765AbiIAToT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 15:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234695AbiIAToP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 15:44:15 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E578696CE
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 12:44:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 98029223F5;
        Thu,  1 Sep 2022 19:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662061450; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=3rgpNwOhkFzND6nXCguYHiOum8GrZt8wm1cXfoBldJ8=;
        b=jtQPXjxF+G2s+Eb78kD1gtUPD738zRvrYJFGmwp2Wj9oNpRzq0LUh6gACFCYVq5OsYvq3e
        FZNXa5ADfyceBSPhN/4GJqYNvxH8G5VlEwSoc4pHQsPa2KlP+mfU13AmivmJyIwxh1pYAe
        1T+cAaW06IfaUIZBpnqMLjpAprSGLCg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662061450;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=3rgpNwOhkFzND6nXCguYHiOum8GrZt8wm1cXfoBldJ8=;
        b=JP0Yj+0bK5i6uliRoPlkHphgNpGdipOYxOYks3F723a8MrFFbbn8/ilyJ63trMDlHbuKUy
        vBBPTzOFL6sUT0DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 129FD13A89;
        Thu,  1 Sep 2022 19:44:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RF4uAYoLEWMrYgAAMHmgww
        (envelope-from <pvorel@suse.cz>); Thu, 01 Sep 2022 19:44:10 +0000
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-kernel@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH v3 1/1] kernel/utsname_sysctl.c: Print kernel arch
Date:   Thu,  1 Sep 2022 21:44:03 +0200
Message-Id: <20220901194403.3819-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
Changes v2->v3:
* fix title in the subject

@Andrew @Eric: FYI previously the sysfs file was in
/sys/devices/system/cpu/, that's why I sent previous versions to Greg.

 Documentation/admin-guide/sysctl/kernel.rst | 5 +++++
 kernel/utsname_sysctl.c                     | 7 +++++++
 2 files changed, 12 insertions(+)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index ee6572b1edad..bbaa85194695 100644
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
2.35.3

