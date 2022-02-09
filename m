Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4D94AEB8E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 08:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239941AbiBIHzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 02:55:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233423AbiBIHzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 02:55:12 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC28C05CB84;
        Tue,  8 Feb 2022 23:55:16 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id v186so3685685ybg.1;
        Tue, 08 Feb 2022 23:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eV794YHbVHS12HmSAomi+0BDrCTJ09pCtyoRkv+rxS4=;
        b=IaqQH2L1wqV8U/xN3pp1SpF/OBUrJpDXSlrwH7ehrNLbySHv9Wu27FnQCLrzuLW/9H
         0aEUMxpKbcOuYT3UfYeXlElDk4AtxnL1fiDwxlR9fidIi+pymWn+be3W4iP+LrhR1HIZ
         t3k30fqsdNDFaaxi8YXi/rO7TvALjKbenZuYkWpXm1YywZngNy7K1Hma2dRZV8dzNooF
         VVo+ma88TWMFfxjPhMjY4hJ5xBAc0GFFL6u5Rhn0e5HBKHTWYwQagu8p1JQ8+QopwgIM
         lyYnjdMQIW2Jyo/BUaUtMNebOs0Rb8aHZrdgvCb+UB1WLg2FOSn+lytIsJNPg367umDb
         IgRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eV794YHbVHS12HmSAomi+0BDrCTJ09pCtyoRkv+rxS4=;
        b=m7Ho9O37bRCUp22bbuaf2X3E4fK28GO5wOzsoy5tQLRvJ0rh4Da+Uyme+HwYmg5U7m
         tDJ+JmpNu78dUIiITnuLxhItMdVq7q3gqHThxdf2GkcaNinN2n5TYxSIo2P0WyewhEEE
         uKVhcLeD5g7qHVSyc8zcdFO1mdR5mbhz+erCWsF427ztYEISwMMkcLxwLZ9MoCVoJBa7
         xxrgNr7cAcIma6ipin+BSmbwhyU70LGQAMSYOVAG4Wi+YY6DUvKLpVQLWkPFW8sBfcqF
         9HcwMBEzwdmVUe//33KAcRrCJVRnfvM4BsD10ypA65ouMTSHPpWffhRC2FcLD0vT6A1+
         6bJg==
X-Gm-Message-State: AOAM531b2Cksk1IFpB3i6FJqiR3w4iZjcJpxu95zIP0sqV119XCPAo/n
        ETDDO+VvWvJRKe1MEFqIMV9UjRR3+PLFj24Xshg=
X-Google-Smtp-Source: ABdhPJyYT4RXELVDsNxwkCYFgUOkQSg0SKPK6EQFP3US4fA/3rH2ApxDKrTuSpdjytjxSGybeJS7lxyFXdGT7d71NZg=
X-Received: by 2002:a05:6902:4c2:: with SMTP id v2mr1053884ybs.429.1644393315563;
 Tue, 08 Feb 2022 23:55:15 -0800 (PST)
MIME-Version: 1.0
References: <20220121221021.60533b009c357d660791476e@linux-foundation.org>
 <20220122061228.nmuo75sDn%akpm@linux-foundation.org> <YgEeQNdgBuHRyEWl@dumbo>
 <YgGTSR628xhRvCjB@bombadil.infradead.org> <CAA5qM4BGmrkwatyO_h3F=ErDZ9t5swuttbt6NkQU-1KDGDiD4g@mail.gmail.com>
 <YgKmaggsipzzCGCg@bombadil.infradead.org> <YgNyAC8VMeuOD/uQ@dumbo>
In-Reply-To: <YgNyAC8VMeuOD/uQ@dumbo>
From:   Tong Zhang <ztong0001@gmail.com>
Date:   Tue, 8 Feb 2022 23:55:04 -0800
Message-ID: <CAA5qM4AkaYLxesaiy_X+ceEx0R9cXHdiLJE38v08bCjKXhxcMA@mail.gmail.com>
Subject: Re: [PATCH v2] Fix regression due to "fs: move binfmt_misc sysctl to
 its own file"
To:     Domenico Andreoli <domenico.andreoli@linux.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
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
        Mark Fasheh <mark@fasheh.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        mm-commits@vger.kernel.org, nixiaoming@huawei.com,
        penguin-kernel@i-love.sakura.ne.jp, peterz@infradead.org,
        Phillip Potter <phil@philpotter.co.uk>,
        Paul Turner <pjt@google.com>, pmladek@suse.com,
        rafael@kernel.org, rodrigo.vivi@intel.com, rostedt@goodmis.org,
        senozhatsky@chromium.org, sre@kernel.org, steve@sk2.org,
        Suren Baghdasaryan <surenb@google.com>,
        torvalds@linux-foundation.org, tytso@mit.edu,
        Al Viro <viro@zeniv.linux.org.uk>, wangqing@vivo.com,
        Iurii Zaikin <yzaikin@google.com>,
        open list <linux-kernel@vger.kernel.org>,
        regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 8, 2022 at 11:49 PM Domenico Andreoli
<domenico.andreoli@linux.com> wrote:
>
> Commit 3ba442d5331f did not go unnoticed, binfmt-support stopped to
> work on my Debian system since v5.17-rc2 (did not check with -rc1).
>
> The existance of the /proc/sys/fs/binfmt_misc is a precondition for
> attempting to mount the binfmt_misc fs, which in turn triggers the
> autoload of the binfmt_misc module. Without it, no module is loaded
> and no binfmt is available at boot.
>
> Building as built-in or manually loading the module and mounting the fs
> works fine, it's therefore only a matter of interaction with user-space.
> I could try to improve the Debian systemd configuration but I can't
> say anything about the other distributions.
>
> This patch restores a working system right after boot.
>
> v2:
> - move creation of fs/binfmt_misc to fs/file_table.c
> - use IS_ENABLED() to conditionally create it
>
> Fixes: 3ba442d5331f ("fs: move binfmt_misc sysctl to its own file")
> Signed-off-by: Domenico Andreoli <domenico.andreoli@linux.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Amir Goldstein <amir73il@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Antti Palosaari <crope@iki.fi>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Benjamin LaHaise <bcrl@kvack.org>
> Cc: Clemens Ladisch <clemens@ladisch.de>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Douglas Gilbert <dgilbert@interlog.com>
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Iurii Zaikin <yzaikin@google.com>
> Cc: James E.J. Bottomley <jejb@linux.ibm.com>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Jani Nikula <jani.nikula@intel.com>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Joel Becker <jlbec@evilplan.org>
> Cc: John Ogness <john.ogness@linutronix.de>
> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Cc: Joseph Qi <joseph.qi@linux.alibaba.com>
> Cc: Julia Lawall <julia.lawall@inria.fr>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Lukas Middendorf <kernel@tuxforce.de>
> Cc: Mark Fasheh <mark@fasheh.com>
> Cc: Martin K. Petersen <martin.petersen@oracle.com>
> Cc: Paul Turner <pjt@google.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: Phillip Potter <phil@philpotter.co.uk>
> Cc: Qing Wang <wangqing@vivo.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
> Cc: Stephen Kitt <steve@sk2.org>
> Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Cc: "Theodore Ts'o" <tytso@mit.edu>
> Cc: Xiaoming Ni <nixiaoming@huawei.com>
>
> ---
>  fs/binfmt_misc.c |    6 +-----
>  fs/file_table.c  |    2 ++
>  2 files changed, 3 insertions(+), 5 deletions(-)
>
> Index: b/fs/binfmt_misc.c
> ===================================================================
> --- a/fs/binfmt_misc.c
> +++ b/fs/binfmt_misc.c
> @@ -817,20 +817,16 @@ static struct file_system_type bm_fs_typ
>  };
>  MODULE_ALIAS_FS("binfmt_misc");
>
> -static struct ctl_table_header *binfmt_misc_header;
> -
>  static int __init init_misc_binfmt(void)
>  {
>         int err = register_filesystem(&bm_fs_type);
>         if (!err)
>                 insert_binfmt(&misc_format);
> -       binfmt_misc_header = register_sysctl_mount_point("fs/binfmt_misc");
> -       return 0;
> +       return err;
>  }
>
>  static void __exit exit_misc_binfmt(void)
>  {
> -       unregister_sysctl_table(binfmt_misc_header);
>         unregister_binfmt(&misc_format);
>         unregister_filesystem(&bm_fs_type);
>  }
> Index: b/fs/file_table.c
> ===================================================================
> --- a/fs/file_table.c
> +++ b/fs/file_table.c
> @@ -119,6 +119,8 @@ static struct ctl_table fs_stat_sysctls[
>  static int __init init_fs_stat_sysctls(void)
>  {
>         register_sysctl_init("fs", fs_stat_sysctls);
> +       if (IS_ENABLED(CONFIG_BINFMT_MISC))
> +               register_sysctl_mount_point("fs/binfmt_misc");
>         return 0;
>  }
>  fs_initcall(init_fs_stat_sysctls);

Looks good
Thanks!

Reviewed-by: Tong Zhang <ztong0001@gmail.com>
