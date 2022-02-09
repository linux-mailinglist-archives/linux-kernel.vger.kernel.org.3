Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4753A4AEB72
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 08:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239451AbiBIHtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 02:49:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbiBIHtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 02:49:21 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B92C05CB82;
        Tue,  8 Feb 2022 23:49:24 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id s7so3391123edd.3;
        Tue, 08 Feb 2022 23:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LUzGldKtZC3jOl6Fq1nfXnQKprYL3pMs6oURDAZ0EmE=;
        b=KOvrX9K5oGQAb0XaO6VlNj0WKjC9bavJrqO6YBN2wMeYSLTNMMq4OUNbxxQtCKhHDd
         iu25luITlcqZYE2ZMl8jsIxUQcGUjf1t8MvTEu7cO0V8NYRhxcGzsEpD1e6wWB6KCcEH
         0rpvH33A61Wk0zcJSRuAlliDXLG6zwTrSJx00FL4JwfzkkJ/qHVrYtTj2wAsdgoV7TMB
         hwCCfDzPd1GoWbg0oaynvhMWtw4g/aAxwnqQBwBsnpb/TEI5Xq9aU0rd7fKr1uiirDCK
         jCmdSG28ZM5umxg0NiSDA5adQqe+DSKSQyEyk5V5cf7WFwgJa3VnWxM/pbluedefgbiC
         W5bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=LUzGldKtZC3jOl6Fq1nfXnQKprYL3pMs6oURDAZ0EmE=;
        b=J0bGm3fy/VYmJmJkGCQkJw7L0RWdN1ILbL+ckl8ITbxNQzHYD7V026yhSyuE2pMyhx
         YaJE+lXoiWgCGE80rohhOVnYlD5yqJ9htRJsOhqzk3S147IsU6Gubps6fMprY4w9C1X3
         kAOuuHy3NEifsdK9xj/N/COA7JIBez/Yn/BIVSUn0A46EkoNfDjOTwJ80l2HqGUCwmTF
         dUr5poTBICneOCtVIyTqpnh5RLDQpBZpw2pQ7Bc+no8VzsfkAak/oQPyGNqP/D3pMgIX
         bsRol9mMN1afjFYSxEF22C+MTKyLmQPQTjQHWcoA3zTvtmWZRpTui1W6k8Tz4zFJIerD
         gbdA==
X-Gm-Message-State: AOAM533ZhWdb+M6NmHMLjgi2v70qkkr91M45GcqAfNcAt95eRdtTxXZ8
        XkOaCrVb23w59BLzw73LAx4=
X-Google-Smtp-Source: ABdhPJy7j/jOKxsaAV2/AtzcWda7tM3HPoh6bV/FquZcserdfo9YfUiMeSpCU161wWXwVjfQXLLUEA==
X-Received: by 2002:a05:6402:51cd:: with SMTP id r13mr1079014edd.381.1644392962839;
        Tue, 08 Feb 2022 23:49:22 -0800 (PST)
Received: from dumbo ([185.220.101.84])
        by smtp.gmail.com with ESMTPSA id l1sm5690964ejb.81.2022.02.08.23.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 23:49:22 -0800 (PST)
Sender: Domenico Andreoli <domenico.andreoli.it@gmail.com>
Received: from cavok by dumbo with local (Exim 4.94.2)
        (envelope-from <cavok@dumbo>)
        id 1nHhj6-0002av-MX; Wed, 09 Feb 2022 08:49:20 +0100
Date:   Wed, 9 Feb 2022 08:49:20 +0100
From:   Domenico Andreoli <domenico.andreoli@linux.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Tong Zhang <ztong0001@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        David Airlie <airlied@linux.ie>,
        Andrew Morton <akpm@linux-foundation.org>, amir73il@gmail.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, bcrl@kvack.org,
        benh@kernel.crashing.org, clemens@ladisch.de, crope@iki.fi,
        dgilbert@interlog.com, Greg KH <gregkh@linuxfoundation.org>,
        jack@suse.cz, jani.nikula@intel.com, jani.nikula@linux.intel.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>, jlbec@evilplan.org,
        john.ogness@linutronix.de, joonas.lahtinen@linux.intel.com,
        Joseph Qi <joseph.qi@linux.alibaba.com>, julia.lawall@inria.fr,
        Kees Cook <keescook@chromium.org>, kernel@tuxforce.de,
        Linux Memory Management List <linux-mm@kvack.org>,
        mark@fasheh.com, "Martin K. Petersen" <martin.petersen@oracle.com>,
        mm-commits@vger.kernel.org, nixiaoming@huawei.com,
        penguin-kernel@i-love.sakura.ne.jp, peterz@infradead.org,
        phil@philpotter.co.uk, pjt@google.com, pmladek@suse.com,
        rafael@kernel.org, rodrigo.vivi@intel.com, rostedt@goodmis.org,
        senozhatsky@chromium.org, sre@kernel.org, steve@sk2.org,
        surenb@google.com, torvalds@linux-foundation.org, tytso@mit.edu,
        Al Viro <viro@zeniv.linux.org.uk>, wangqing@vivo.com,
        Iurii Zaikin <yzaikin@google.com>,
        open list <linux-kernel@vger.kernel.org>,
        regressions@lists.linux.dev
Subject: [PATCH v2] Fix regression due to "fs: move binfmt_misc sysctl to its
 own file"
Message-ID: <YgNyAC8VMeuOD/uQ@dumbo>
References: <20220121221021.60533b009c357d660791476e@linux-foundation.org>
 <20220122061228.nmuo75sDn%akpm@linux-foundation.org>
 <YgEeQNdgBuHRyEWl@dumbo>
 <YgGTSR628xhRvCjB@bombadil.infradead.org>
 <CAA5qM4BGmrkwatyO_h3F=ErDZ9t5swuttbt6NkQU-1KDGDiD4g@mail.gmail.com>
 <YgKmaggsipzzCGCg@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgKmaggsipzzCGCg@bombadil.infradead.org>
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_BL_SPAMCOP_NET,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 3ba442d5331f did not go unnoticed, binfmt-support stopped to
work on my Debian system since v5.17-rc2 (did not check with -rc1).

The existance of the /proc/sys/fs/binfmt_misc is a precondition for
attempting to mount the binfmt_misc fs, which in turn triggers the
autoload of the binfmt_misc module. Without it, no module is loaded
and no binfmt is available at boot.

Building as built-in or manually loading the module and mounting the fs
works fine, it's therefore only a matter of interaction with user-space.
I could try to improve the Debian systemd configuration but I can't
say anything about the other distributions.

This patch restores a working system right after boot.

v2:
- move creation of fs/binfmt_misc to fs/file_table.c
- use IS_ENABLED() to conditionally create it

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
 fs/file_table.c  |    2 ++
 2 files changed, 3 insertions(+), 5 deletions(-)

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
Index: b/fs/file_table.c
===================================================================
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -119,6 +119,8 @@ static struct ctl_table fs_stat_sysctls[
 static int __init init_fs_stat_sysctls(void)
 {
 	register_sysctl_init("fs", fs_stat_sysctls);
+	if (IS_ENABLED(CONFIG_BINFMT_MISC))
+		register_sysctl_mount_point("fs/binfmt_misc");
 	return 0;
 }
 fs_initcall(init_fs_stat_sysctls);
