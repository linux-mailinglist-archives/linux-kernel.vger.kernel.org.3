Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 525B2508319
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 10:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376612AbiDTIF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 04:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376543AbiDTIFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 04:05:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AD41D3C4B0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 01:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650441755;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sZZR3zwNKQKDEnJylIibAFIQ2Qi+eLRKOEhLM32uxeU=;
        b=bDtd6oUhrLNedJKVARYjv+0DMiNaGOJEhRmIqkUNqKAlq0AVfU/dmX/kzXA1ccyNqIc0tP
        JhR8UBNpBaMbe479hmNBP1YhxPvwf57kdCD78B+DXU6BpgbgC88zB+WXUgg6/6FHspX7ln
        2b9fJCi3Y+8vmpF8KwxwUPOe2Bx3vJg=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-471-i-ZQ1OCYPuKnDEKyP2_y8w-1; Wed, 20 Apr 2022 04:02:34 -0400
X-MC-Unique: i-ZQ1OCYPuKnDEKyP2_y8w-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-2ef53391dbaso9179287b3.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 01:02:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sZZR3zwNKQKDEnJylIibAFIQ2Qi+eLRKOEhLM32uxeU=;
        b=QY5PrrqB/9fOlq8O/F2FyoPEPOIMUJWQVhqOwm7XdcM0vwEnAJYJ3YCNeGY0TDHlqz
         4NodvHr5R/TsVXsYYoWAR15IKDTuTNcPVwgqqrLChDeWr/s37jAEqo8JSe3zsJDZ2uUy
         6vluEjmFH+PA+rJZqnG4y7l7xtnTwHeySo7t45pUPc2zlQgz9+Ck6C0og+P6Ry5jDQIW
         Wjfo2fR+wS64s8HdEbPLXcTlmmI1yrUFgX2eaAvoHIXGMOLcLRc5LYL+78+4pk2OSLLh
         ulsFxad1rvPTQPPUUQdC+M+XNEkuKAXBVGa1eKthF/SvAyKgnJ3tFMQTnjg4dxOcDJ9c
         5xLg==
X-Gm-Message-State: AOAM531h1FadAlXCQwFWxcZTzdAGaByhruAdaQIuu2gKHG0uEG/y/HnE
        sOu1sm/5lEci+x9s0xszNUCvxVfJsalRiD81vwzntCLD+8IPWM0i8esDFTnco8x5qg89aoSmGg5
        yPY3ISdw91VXPCbtuyE3nZEzD6tAsp0rvxgTE2kFl
X-Received: by 2002:a25:7c05:0:b0:644:dec5:6d6e with SMTP id x5-20020a257c05000000b00644dec56d6emr15237451ybc.598.1650441752133;
        Wed, 20 Apr 2022 01:02:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzKvWp/Gtz+Z/v13ug97g5sDZA82DQrAGOOsGB643evErgBkO2frODmnrorSZdExprtDOMi7dXLleEAE0MAGPw=
X-Received: by 2002:a25:7c05:0:b0:644:dec5:6d6e with SMTP id
 x5-20020a257c05000000b00644dec56d6emr15237426ybc.598.1650441751900; Wed, 20
 Apr 2022 01:02:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAE4VaGDZr_4wzRn2___eDYRtmdPaGGJdzu_LCSkJYuY9BEO3cw@mail.gmail.com>
 <536eca11-b4b9-c1a8-6e6b-fcd0c339a3ec@leemhuis.info> <CAE4VaGBZk2NL6Tn2fGxmGMR-n8KFNqgPOktY_sQ1vjViLDNhhg@mail.gmail.com>
 <CAE4VaGB4=aCd8iDb4EduR+-5QTSgVWd5sxrnBA4e3g9dPrnuBg@mail.gmail.com>
 <YkTxox8ZQIDtojfU@google.com> <CAFxkdAq6r2WnwML-pPfdZiajaYZCEcUU3GrXW=+wsA7CxGnJdQ@mail.gmail.com>
 <CAE4VaGBchOMWeHQ8GKiGFv_aCaNGLEvSdLWXZTpE+qC=0bgM3A@mail.gmail.com>
 <YkY6W1NS+1RTw0VB@google.com> <CAE4VaGDAMZqjwumyvbityzEiK30=5a5vuDMjaS+UHM39R-oPRw@mail.gmail.com>
 <YkstxbC3OfzYnSRw@google.com>
In-Reply-To: <YkstxbC3OfzYnSRw@google.com>
From:   Jirka Hladky <jhladky@redhat.com>
Date:   Wed, 20 Apr 2022 10:02:20 +0200
Message-ID: <CAE4VaGAQZcQzN8D+iwcBnP5vY=Ctmbh+oTikvONHir6JjTgpsw@mail.gmail.com>
Subject: Re: PANIC: "Oops: 0000 [#1] PREEMPT SMP PTI" starting from 5.17 on
 dual socket Intel Xeon Gold servers
To:     Minchan Kim <minchan@kernel.org>
Cc:     tj@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        regressions@lists.linux.dev,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Justin Forbes <jforbes@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Minchan,

have you heard back from the kernfs maintainers?

Thank you!
Jirka


On Mon, Apr 4, 2022 at 7:41 PM Minchan Kim <minchan@kernel.org> wrote:
>
> On Fri, Apr 01, 2022 at 02:04:03PM +0200, Jirka Hladky wrote:
> > > Could you decode exact source code line from the oops?
> >
> > Yes - please see below [1].
>
> Thanks.
>
> >
> > > I think it's fine to attach in the reply because kernel test bot
> >
> > OK. The reproducer is attached. Please unpack it and follow the
> > instructions in the README file. [2]
>
> Unfortunately, I failed to run the script in my machine.
>
> >
> > Thanks a lot for looking into it!
> > Jirka
> >
> > [1]
> > =============================================
> > Source code line numbers for the Oops message
> > =============================================
> >
> > 1) RIP: 0010:kernfs_remove+0x8/0x50:
> > (gdb) l *kernfs_remove+0x8
> > 0xffffffff81418588 is in kernfs_remove (fs/kernfs/kernfs-internal.h:48).
> > 43       * Return the kernfs_root @kn belongs to.
> > 44       */
> > 45      static inline struct kernfs_root *kernfs_root(struct kernfs_node *kn)
> > 46      {
> > 47              /* if parent exists, it's always a dir; otherwise, @sd
> > is a dir */
> > 48              if (kn->parent)
> > 49                      kn = kn->parent;
> > 50              return kn->dir.root;
> > 51      }
> >
> > And here are source code lines from the 5 first functions in call trace:
> > [ 8563.366280] Call Trace:
> > [ 8563.366280]  <TASK>
> > [ 8563.366280]  rdt_kill_sb+0x29d/0x350
> > [ 8563.366280]  deactivate_locked_super+0x36/0xa0
> > [ 8563.366280]  cleanup_mnt+0x131/0x190
> > [ 8563.366280]  task_work_run+0x5c/0x90
> > [ 8563.366280]  exit_to_user_mode_prepare+0x229/0x230
> > [ 8563.366280]  syscall_exit_to_user_mode+0x18/0x40
> > [ 8563.366280]  do_syscall_64+0x48/0x90
> > [ 8563.366280]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> >
> > 2)(gdb) l *rdt_kill_sb+0x29d
> > 0xffffffff810506bd is in rdt_kill_sb
> > (arch/x86/kernel/cpu/resctrl/rdtgroup.c:2442).
> > 2437            /* Notify online CPUs to update per cpu storage and
> > PQR_ASSOC MSR */
> > 2438            update_closid_rmid(cpu_online_mask, &rdtgroup_default);
> > 2439
> > 2440            kernfs_remove(kn_info);
> > 2441            kernfs_remove(kn_mongrp);
> > 2442            kernfs_remove(kn_mondata);
> > 2443    }
> >
> > 3)(gdb) l *deactivate_locked_super+0x36
> > 0xffffffff813650f6 is in deactivate_locked_super (fs/super.c:342).
> > 337                     /*
> > 338                      * Since list_lru_destroy() may sleep, we
> > cannot call it from
> > 339                      * put_super(), where we hold the sb_lock.
> > Therefore we destroy
> > 340                      * the lru lists right now.
> > 341                      */
> > 342                     list_lru_destroy(&s->s_dentry_lru);
> > 343                     list_lru_destroy(&s->s_inode_lru);
> > 344
> > 345                     put_filesystem(fs);
> > 346                     put_super(s);
> >
> > 4) (gdb) l *cleanup_mnt+0x131
> > 0xffffffff813890a1 is in cleanup_mnt (fs/namespace.c:137).
> > 132             return 0;
> > 133     }
> > 134
> > 135     static void mnt_free_id(struct mount *mnt)
> > 136     {
> > 137             ida_free(&mnt_id_ida, mnt->mnt_id);
> > 138     }
> >
> > 5) (gdb) l *task_work_run+0x5c
> > 0xffffffff8110620c is in task_work_run (./include/linux/sched.h:2017).
> > 2012
> > 2013    DECLARE_STATIC_CALL(cond_resched, __cond_resched);
> > 2014
> > 2015    static __always_inline int _cond_resched(void)
> > 2016    {
> > 2017            return static_call_mod(cond_resched)();
> > 2018    }
> >
> > 6) (gdb) l *exit_to_user_mode_prepare+0x229
> > 0xffffffff81176d19 is in exit_to_user_mode_prepare
> > (./include/linux/tracehook.h:189).
> > 184              * This barrier pairs with
> > task_work_add()->set_notify_resume() after
> > 185              * hlist_add_head(task->task_works);
> > 186              */
> > 187             smp_mb__after_atomic();
> > 188             if (unlikely(current->task_works))
> > 189                     task_work_run();
> > 190
> > 191     #ifdef CONFIG_KEYS_REQUEST_CACHE
> > 192             if (unlikely(current->cached_requested_key)) {
> > 193                     key_put(current->cached_requested_key);
> >
> > [2]
> > =============================================
> > Reproducer - README
> > =============================================
> >
> > 1) HW
> > This issue seems to be platform specific. I was not able to reproduce
> > it on AMD Zen and also not on Intel Ice Lake platform.
> > I see the issue on dual socket Intel Skylake systems. Reproduced on a
> > Supermicro Super Server/X11DDW-L with 2x Xeon Gold 6126 CPU.
>
> Based on your report, kernel was crashed due to kn_mondata was NULL
>
>   rdt_kill_sb
>     rmdir_all_sub
>       ..
>       kernfs_remove(kn_mondata);
>         struct kernfs_root *root = kernfs_root(kn); <-- crashed
>
>
> Before the my patch[1], it worked like this.
>
>   rdt_kill_sb
>     rmdir_all_sub
>       ..
>       kernfs_remove(kn_mondata);
>         down_write(&kernfs_rwsem);
>           if (!kn)
>             return;
>         up_write(&kernfs_rwsem);
>
> IOW, before, kernfs_remove worked with NULL argument via just bailing
> but with the my patch[1], it doesn't work any longer.
>
> It makes me have questions for kernfs maintainers:
>
> Should kernfs_remove API support NULL parameter? If so, can we support
> it atomically without old global kernfs_rwsem?
>
> [1] 393c3714081a, kernfs: switch global kernfs_rwsem lock to per-fs lock
>


-- 
-Jirka

