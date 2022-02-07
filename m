Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9BA4AC01E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 14:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388848AbiBGNue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 08:50:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358816AbiBGN1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 08:27:33 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816C6C043181;
        Mon,  7 Feb 2022 05:27:32 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id og43so18061000ejc.0;
        Mon, 07 Feb 2022 05:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uodRgi0lSvjfu6z/loPgCdPJcwfTd50pHHEutx7a7FU=;
        b=GOkuyBYFBgK7TrBFV7AaPdglSjAc9h7eSRY4Vn43CJi87x2sGC2JrvOL79WmgPPF/a
         8HQLM/ySYk9O1Y7qZdIa60UODXU0Smf1aUvLNN0PPcEWAvmZxk/x5FPmFeJzSaNPIvGi
         VjNVSR6bx3GwOlp3M3yFXx9pIdrE6g/XqeIe0bOSubz3pxs9FfFxNmR+v9GOmlO7vHTD
         wa4EzWuoIb9nmdNlbv5BPvJiGwK2NqqvMlalkuUDKBVjvPNsi8jc0PCs4BuZ10WcXDJ+
         50ZKZ/Om8/K7NkCv7WC9SdOCzoZERiYveT9d5FCIyKn4PA5EvLJadw9MgvhBZ1QLrcjD
         uIqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=uodRgi0lSvjfu6z/loPgCdPJcwfTd50pHHEutx7a7FU=;
        b=EQuKtLF1kLxJi3O3Ff0kG1sHawHTcPQ6KQ2Lh8qvO37yJkAR3MhQvJEVqg7tA0kmxj
         TPf8MpXQ14OLXPm41+6rqIsPTY4tvcoF+9c/mHtEY5VPbZmsyYaDPwazAVOQmEhiemIW
         G4baEfh/j6WVYFGOkW5JoxDQnnzMPKhQfe0BAuXRWuXwQuRDTGNgSNl5dJi8YzzcwTd2
         Pro3wY0WR6SxGpA/QBUgvtqb6W/g4vCq7AszfwMHcbllrPCBHfdFHzevDg2+KK7ehlhG
         aMCH3/lIJn2iyCt6VNmPSAP69snAp82KPtRWsR046K0njX8LxohXFi7JyVfNSeeg6CpY
         30Jw==
X-Gm-Message-State: AOAM530OvPAznji+EVAzwXabJ1VV4EExIojzD8ygEg7GVZIEs9ToGPw6
        ySEMLdu4GEXeYHmGfUc/kKc=
X-Google-Smtp-Source: ABdhPJwO2cWoWb2zHzBal8Bo+vfe+9ev1QdE8F6uXO4YWA/GdnWjQziOhW/5NX3D8Y0V8NGNxSArvA==
X-Received: by 2002:a17:906:f156:: with SMTP id gw22mr7510658ejb.321.1644240450800;
        Mon, 07 Feb 2022 05:27:30 -0800 (PST)
Received: from dumbo (tor-exit-13.zbau.f3netze.de. [2a0b:f4c0:16c:13::1])
        by smtp.gmail.com with ESMTPSA id a18sm5215946edu.31.2022.02.07.05.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 05:27:30 -0800 (PST)
Sender: Domenico Andreoli <domenico.andreoli.it@gmail.com>
Received: from cavok by dumbo with local (Exim 4.94.2)
        (envelope-from <cavok@dumbo>)
        id 1nH43E-0002H6-41; Mon, 07 Feb 2022 14:27:28 +0100
Date:   Mon, 7 Feb 2022 14:27:28 +0100
From:   Domenico Andreoli <domenico.andreoli@linux.com>
To:     airlied@linux.ie, akpm@linux-foundation.org, amir73il@gmail.com,
        andriy.shevchenko@linux.intel.com, arnd@arndb.de, bcrl@kvack.org,
        benh@kernel.crashing.org, clemens@ladisch.de, crope@iki.fi,
        dgilbert@interlog.com, ebiederm@xmission.com,
        gregkh@linuxfoundation.org, jack@suse.cz, jani.nikula@intel.com,
        jani.nikula@linux.intel.com, jejb@linux.ibm.com,
        jlbec@evilplan.org, john.ogness@linutronix.de,
        joonas.lahtinen@linux.intel.com, joseph.qi@linux.alibaba.com,
        julia.lawall@inria.fr, keescook@chromium.org, kernel@tuxforce.de,
        linux-mm@kvack.org, mark@fasheh.com, martin.petersen@oracle.com,
        mcgrof@kernel.org, mm-commits@vger.kernel.org,
        nixiaoming@huawei.com, penguin-kernel@i-love.sakura.ne.jp,
        peterz@infradead.org, phil@philpotter.co.uk, pjt@google.com,
        pmladek@suse.com, rafael@kernel.org, rodrigo.vivi@intel.com,
        rostedt@goodmis.org, senozhatsky@chromium.org, sre@kernel.org,
        steve@sk2.org, surenb@google.com, torvalds@linux-foundation.org,
        tytso@mit.edu, viro@zeniv.linux.org.uk, wangqing@vivo.com,
        yzaikin@google.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] Fix regression due to "fs: move binfmt_misc sysctl to its
 own file"
Message-ID: <YgEeQNdgBuHRyEWl@dumbo>
References: <20220121221021.60533b009c357d660791476e@linux-foundation.org>
 <20220122061228.nmuo75sDn%akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220122061228.nmuo75sDn%akpm@linux-foundation.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 3ba442d5331f did not go unnoticed, binfmt-support stopped to
work on my Debian system since v5.17-rc2 (did not check with -rc1).

The existance of /proc/sys/fs/binfmt_misc is a precondition for
attempting to mount the binfmt_misc fs, which in turn triggers the
autoload of the binfmt_misc module. Without it, no module is loaded
and no binfmt is available at boot.

Building as built-in or manually loading the module and mounting the fs
works fine, it's therefore only a matter of interaction with user-space.

I could try to improve the Debian systemd configuration but I can't
say anything about the other distributions.

In the meanwhile this patch restores a working system right after boot.

Fixes: 3ba442d5331f ("fs: move binfmt_misc sysctl to its own file")
Signed-off-by: Domenico Andreoli <domenico.andreoli@linux.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Antti Palosaari <crope@iki.fi>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Benjamin LaHaise <bcrl@kvack.org>
Cc: Clemens Ladisch <clemens@ladisch.de>
Cc: David Airlie <airlied@linux.ie>
Cc: Douglas Gilbert <dgilbert@interlog.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Iurii Zaikin <yzaikin@google.com>
Cc: James E.J. Bottomley <jejb@linux.ibm.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: John Ogness <john.ogness@linutronix.de>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Julia Lawall <julia.lawall@inria.fr>
Cc: Kees Cook <keescook@chromium.org>
Cc: Lukas Middendorf <kernel@tuxforce.de>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Mark Fasheh <mark@fasheh.com>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Paul Turner <pjt@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Phillip Potter <phil@philpotter.co.uk>
Cc: Qing Wang <wangqing@vivo.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Stephen Kitt <steve@sk2.org>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: "Theodore Ts'o" <tytso@mit.edu>
Cc: Xiaoming Ni <nixiaoming@huawei.com>

---
 fs/binfmt_misc.c |    6 +-----
 kernel/sysctl.c  |   13 +++++++++++++
 2 files changed, 14 insertions(+), 5 deletions(-)

Index: b/fs/binfmt_misc.c
===================================================================
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -817,20 +817,16 @@ static struct file_system_type bm_fs_typ
 };
 MODULE_ALIAS_FS("binfmt_misc");
 
-static struct ctl_table_header *binfmt_misc_header;
-
 static int __init init_misc_binfmt(void)
 {
 	int err = register_filesystem(&bm_fs_type);
 	if (!err)
 		insert_binfmt(&misc_format);
-	binfmt_misc_header = register_sysctl_mount_point("fs/binfmt_misc");
-	return 0;
+	return err;
 }
 
 static void __exit exit_misc_binfmt(void)
 {
-	unregister_sysctl_table(binfmt_misc_header);
 	unregister_binfmt(&misc_format);
 	unregister_filesystem(&bm_fs_type);
 }
Index: b/kernel/sysctl.c
===================================================================
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2806,6 +2806,17 @@ static struct ctl_table vm_table[] = {
 	{ }
 };
 
+static struct ctl_table fs_table[] = {
+#if defined(CONFIG_BINFMT_MISC) || defined(CONFIG_BINFMT_MISC_MODULE)
+	{
+		.procname	= "binfmt_misc",
+		.mode		= 0555,
+		.child		= sysctl_mount_point,
+	},
+#endif
+	{ }
+};
+
 static struct ctl_table debug_table[] = {
 #ifdef CONFIG_SYSCTL_EXCEPTION_TRACE
 	{
@@ -2825,6 +2836,7 @@ static struct ctl_table dev_table[] = {
 
 DECLARE_SYSCTL_BASE(kernel, kern_table);
 DECLARE_SYSCTL_BASE(vm, vm_table);
+DECLARE_SYSCTL_BASE(fs, fs_table);
 DECLARE_SYSCTL_BASE(debug, debug_table);
 DECLARE_SYSCTL_BASE(dev, dev_table);
 
@@ -2832,6 +2844,7 @@ int __init sysctl_init_bases(void)
 {
 	register_sysctl_base(kernel);
 	register_sysctl_base(vm);
+	register_sysctl_base(fs);
 	register_sysctl_base(debug);
 	register_sysctl_base(dev);
 
