Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5326D550D0A
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 22:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237027AbiFSUnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 16:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237414AbiFSUnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 16:43:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDDB75FA3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 13:43:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6AD8961291
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 20:43:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59C50C34114;
        Sun, 19 Jun 2022 20:43:38 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="mndrBOb3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1655671416;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QqJKD6zg80rBX8SlDSTLLX0THmaiPu1I0aoLaI/MT+0=;
        b=mndrBOb3yGaFbzWLVLWMtuuskGO4+qlGc8Z7ojrxAWw/TeCqqisQ0mFrGWKs8FwQ1TS2y7
        H87ZNHUmbl3DMyQMsZPRxIM4gSecyh6waLaP+mHD3dnsdMN6/4m80Dd9yaIGANX8HeyYa7
        WpQfQIQvDShv8cC00FzL34ZX6YrvGC8=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 21cd46c7 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sun, 19 Jun 2022 20:43:36 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>, Marco Elver <elver@google.com>,
        linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH v2] printk: allow direct console printing to be enabled always
Date:   Sun, 19 Jun 2022 22:43:26 +0200
Message-Id: <20220619204326.556923-1-Jason@zx2c4.com>
In-Reply-To: <Yq+Jjoyn/wj7yzeQ@zx2c4.com>
References: <Yq+Jjoyn/wj7yzeQ@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In 5.19, there are some changes in printk message ordering /
interleaving which leads to confusion. The most obvious (and benign)
example appears on system boot, in which the "Run /init as init process"
message gets intermixed with the messages that init actually writes() to
stdout. For example, here's a snippet from build.wireguard.com:

    [    0.469732] Freeing unused kernel image (initmem) memory: 4576K
    [    0.469738] Write protecting the kernel read-only data: 10240k
    [    0.473823] Freeing unused kernel image (text/rodata gap) memory: 2044K
    [    0.475228] Freeing unused kernel image (rodata/data gap) memory: 1136K
    [    0.475236] Run /init as init process

        WireGuard Test Suite on Linux 5.19.0-rc2+ x86_64

    [+] Mounting filesystems...
    [+] Module self-tests:
     *  allowedips self-tests: pass
     *  nonce counter self-tests: pass
     *  ratelimiter self-tests: pass
    [+] Enabling logging...
    [+] Launching tests...
    [    0.475237]   with arguments:
    [    0.475238]     /init
    [    0.475238]   with environment:
    [    0.475239]     HOME=/
    [    0.475240]     TERM=linux
    [+] ip netns add wg-test-46-0
    [+] ip netns add wg-test-46-1

Before the "with arguments:" and such would print prior to the
"wireguard test suite on linux 5.19" banner. Now it shows after.

I see the same thing with "Freeing unused kernel image (text/rodata gap)
memory" printing interwoven into the console of my initramfs on my
laptop. And so forth.

But the bigger issue for me is that it makes it very confusing to
interpret CI results later on. Prior, I would nice a nice correlation
of:

[+] some userspace command
[    1.2345 ] some kernel log output
[+] some userspace command
[    1.2346 ] some kernel log output
[+] some userspace command
[    1.2347 ] some kernel log output

Now, the kernel log outputs are all over the place and out of order with
the sequence of commands. This makes debugging issues somewhat tricky,
because post hoc ergo propter hoc winds up being a good intuition to
follow when tracking down bugs, and now the post hoc part is muddled.

This is caused by threaded printk. In order to restore this in debugging
sessions and in CI, this commit adds the ability to always use direct
printk, either set by default at compile time, or overridden with a
runtime command line switch.

Cc: John Ogness <john.ogness@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Marco Elver <elver@google.com>
Fixes: 09c5ba0aa2fc ("printk: add kthread console printers")
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  7 +++++++
 init/Kconfig                                    | 12 ++++++++++++
 kernel/printk/printk.c                          | 11 +++++++++++
 3 files changed, 30 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 8090130b544b..96e910a4e12b 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4389,6 +4389,13 @@
 	printk.time=	Show timing data prefixed to each printk message line
 			Format: <bool>  (1/Y/y=enable, 0/N/n=disable)
 
+	printk.direct=	Rather than using kthreads for printk output, always
+			attempt to write to the console immediately. This has
+			performance implications, but will result in a more
+			faithful ordering and interleaving with other
+			processes writing to the console.
+			Format: <bool>  (1/Y/y=enable, 0/N/n=disable)
+
 	processor.max_cstate=	[HW,ACPI]
 			Limit processor to maximum C-state
 			max_cstate=9 overrides any DMI blacklist limit.
diff --git a/init/Kconfig b/init/Kconfig
index c7900e8975f1..47466aa2b0e8 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -798,6 +798,18 @@ config PRINTK_INDEX
 
 	  There is no additional runtime cost to printk with this enabled.
 
+config PRINTK_DIRECT
+	bool "Attempt to flush printk output immediately"
+	depends on PRINTK
+	help
+	  Rather than using kthreads for printk output, always attempt to write
+	  to the console immediately. This has performance implications, but
+	  will result in a more faithful ordering and interleaving with other
+	  processes writing to the console.
+
+	  Say N here unless you really need this. This may also be controlled
+	  at boot time with printk.direct=0/1.
+
 #
 # Architectures with an unreliable sched_clock() should select this:
 #
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index ea3dd55709e7..43f8a0074ed6 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -178,6 +178,14 @@ static int __init control_devkmsg(char *str)
 }
 __setup("printk.devkmsg=", control_devkmsg);
 
+static bool printk_direct = IS_ENABLED(CONFIG_PRINTK_DIRECT);
+
+static int __init control_printk_direct(char *str)
+{
+	return kstrtobool(str, &printk_direct);
+}
+__setup("printk.direct=", control_printk_direct);
+
 char devkmsg_log_str[DEVKMSG_STR_MAX_SIZE] = "ratelimit";
 #if defined(CONFIG_PRINTK) && defined(CONFIG_SYSCTL)
 int devkmsg_sysctl_set_loglvl(struct ctl_table *table, int write,
@@ -3602,6 +3610,9 @@ static int __init printk_activate_kthreads(void)
 {
 	struct console *con;
 
+	if (printk_direct)
+		return 0;
+
 	console_lock();
 	printk_kthreads_available = true;
 	for_each_console(con)
-- 
2.35.1

