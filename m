Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF294B3DAE
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 22:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238377AbiBMVLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 16:11:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238366AbiBMVLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 16:11:00 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B7653736;
        Sun, 13 Feb 2022 13:10:53 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id y6so40658328ybc.5;
        Sun, 13 Feb 2022 13:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KnKCC7oMagFCvCCjM7qG97XmzNcP6hM32qMyVum/dto=;
        b=MBIsTxnulA1MrNZ+IsfyQOaRrtwl2q4GUdFP2YSW/j/CQ7Uo5Oyds++JXr0KB6K9x+
         VvreKfnZ4OI7eVME/n17ninBX9E56yUSQQ2R5qj1lIXf8yPQQYP0ERc5X1WpaRPHcP6q
         QBrvTrlTGLyZ33s8yg3ouAySmVx67aNQvEXNDL9nOKXi0E+hnuwldGSabx914lYBnHX/
         z3iO9qpTjoXA7zxlL3mje/Z58DspXjcEz6W1Er/cCM6QtpZm7+Fqnit3iBgWOcMGkzpT
         3G/s1CZFbveKF+K2Tz9XNltXXoekdReLddn9QZCT9+yQ8vWU3HTdGuaU+22FP9LRB0Wd
         ZMIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KnKCC7oMagFCvCCjM7qG97XmzNcP6hM32qMyVum/dto=;
        b=kL8AVBJqWXh3lXFDbx9yqD6X9xDvT1XimpC2m/NKAM2qNi07YZFWCwHpm2qo/kL/0E
         R86nAwjUqFirs7Mbn00PuTfyAvZMNTaXb4Tmqr4le9YkcER7kF/AXGIh6FeOe/aT1G7e
         ZTArl7nbQUT73ayfORRJdqKAwF2crtlF7njI146ESkaBudGZP/BXPKgCWOiT5EEKLcBC
         WOtU0bh8VHkF0f7LV8BKIajZx/3y35AshHlaLmjOlmmFiTKNuOT030OoysIxV5s8MWQh
         Qf8TAfsOHVAZJjvDzEE/shc3pWafxDGz4ytJQt/eZwHVnRrZ1aZRJkOsBV/FqJKztCNI
         ZTBA==
X-Gm-Message-State: AOAM531bBJsuxNhaiHvBMOqAa91tMKYM66wfOLgdrO237RTk6kvI8Z1u
        Lrf/IUL/qVyXcu6CeFtz/E9dQ97BNY/20A0V9Xk=
X-Google-Smtp-Source: ABdhPJxsBiwJdcvDK4XS9bg3KFwCrZ2nWejzoPKdiLINBF5sJzAhBkiYNgJAgG2bJBMKOIu1ap5H/J3qK03vAQhcyqc=
X-Received: by 2002:a05:6902:124f:: with SMTP id t15mr11084809ybu.640.1644786652734;
 Sun, 13 Feb 2022 13:10:52 -0800 (PST)
MIME-Version: 1.0
References: <20220121221021.60533b009c357d660791476e@linux-foundation.org>
 <20220122061228.nmuo75sDn%akpm@linux-foundation.org> <YgEeQNdgBuHRyEWl@dumbo>
 <YgGTSR628xhRvCjB@bombadil.infradead.org> <CAA5qM4BGmrkwatyO_h3F=ErDZ9t5swuttbt6NkQU-1KDGDiD4g@mail.gmail.com>
 <YgKmaggsipzzCGCg@bombadil.infradead.org> <YgNyAC8VMeuOD/uQ@dumbo> <YgklDvNecca1/8in@shredder>
In-Reply-To: <YgklDvNecca1/8in@shredder>
From:   Tong Zhang <ztong0001@gmail.com>
Date:   Sun, 13 Feb 2022 13:10:42 -0800
Message-ID: <CAA5qM4AP=pOi1dFFgELJ97nSwTBqrruseGmTF-qab=xj2==_Xg@mail.gmail.com>
Subject: Re: [PATCH v2] Fix regression due to "fs: move binfmt_misc sysctl to
 its own file"
To:     Ido Schimmel <idosch@idosch.org>
Cc:     Domenico Andreoli <domenico.andreoli@linux.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        David Airlie <airlied@linux.ie>,
        Andrew Morton <akpm@linux-foundation.org>, amir73il@gmail.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, bcrl@kvack.org,
        benh@kernel.crashing.org, clemens@ladisch.de, crope@iki.fi,
        dgilbert@interlog.com, Greg KH <gregkh@linuxfoundation.org>,
        jack@suse.cz, jani.nikula@intel.com,
        Jani Nikula <jani.nikula@linux.intel.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>, jlbec@evilplan.org,
        john.ogness@linutronix.de,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>, julia.lawall@inria.fr,
        Kees Cook <keescook@chromium.org>, kernel@tuxforce.de,
        Linux Memory Management List <linux-mm@kvack.org>,
        Mark Fasheh <mark@fasheh.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        mm-commits@vger.kernel.org, nixiaoming@huawei.com,
        penguin-kernel@i-love.sakura.ne.jp, peterz@infradead.org,
        Phillip Potter <phil@philpotter.co.uk>,
        Paul Turner <pjt@google.com>, pmladek@suse.com,
        rafael@kernel.org, Rodrigo Vivi <rodrigo.vivi@intel.com>,
        rostedt@goodmis.org, senozhatsky@chromium.org, sre@kernel.org,
        steve@sk2.org, Suren Baghdasaryan <surenb@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>, tytso@mit.edu,
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

On Sun, Feb 13, 2022 at 7:34 AM Ido Schimmel <idosch@idosch.org> wrote:
>
> On Wed, Feb 09, 2022 at 08:49:20AM +0100, Domenico Andreoli wrote:
> >  fs/binfmt_misc.c |    6 +-----
> >  fs/file_table.c  |    2 ++
> >  2 files changed, 3 insertions(+), 5 deletions(-)
> >
> > Index: b/fs/binfmt_misc.c
> > ===================================================================
> > --- a/fs/binfmt_misc.c
> > +++ b/fs/binfmt_misc.c
> > @@ -817,20 +817,16 @@ static struct file_system_type bm_fs_typ
> >  };
> >  MODULE_ALIAS_FS("binfmt_misc");
> >
> > -static struct ctl_table_header *binfmt_misc_header;
> > -
> >  static int __init init_misc_binfmt(void)
> >  {
> >       int err = register_filesystem(&bm_fs_type);
> >       if (!err)
> >               insert_binfmt(&misc_format);
> > -     binfmt_misc_header = register_sysctl_mount_point("fs/binfmt_misc");
> > -     return 0;
> > +     return err;
> >  }
> >
> >  static void __exit exit_misc_binfmt(void)
> >  {
> > -     unregister_sysctl_table(binfmt_misc_header);
> >       unregister_binfmt(&misc_format);
> >       unregister_filesystem(&bm_fs_type);
> >  }
> > Index: b/fs/file_table.c
> > ===================================================================
> > --- a/fs/file_table.c
> > +++ b/fs/file_table.c
> > @@ -119,6 +119,8 @@ static struct ctl_table fs_stat_sysctls[
> >  static int __init init_fs_stat_sysctls(void)
> >  {
> >       register_sysctl_init("fs", fs_stat_sysctls);
> > +     if (IS_ENABLED(CONFIG_BINFMT_MISC))
> > +             register_sysctl_mount_point("fs/binfmt_misc");
>
> Hi,
>
> kmemleak complains about this:
>
> # cat /sys/kernel/debug/kmemleak
> unreferenced object 0xffff8881045fea88 (size 96):
>   comm "swapper/0", pid 1, jiffies 4294669355 (age 167.804s)
>   hex dump (first 32 bytes):
>     e0 c8 07 88 ff ff ff ff 00 00 00 00 01 00 00 00  ................
>     01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<ffffffff81d11637>] __register_sysctl_table+0x117/0x1150
>     [<ffffffff86c3600f>] init_fs_stat_sysctls+0x30/0x33
>     [<ffffffff81002558>] do_one_initcall+0x108/0x690
>     [<ffffffff86bca8bd>] kernel_init_freeable+0x45a/0x4de
>     [<ffffffff83e0757f>] kernel_init+0x1f/0x220
>     [<ffffffff810048cf>] ret_from_fork+0x1f/0x30
>
> >       return 0;
> >  }
> >  fs_initcall(init_fs_stat_sysctls);
> >

Hi Ido,
Thanks for the report. This is a known issue. The fix is proposed here.
https://lore.kernel.org/all/YgRbEG21AUrLSFKX@bombadil.infradead.org/

Thanks,
- Tong
