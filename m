Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70DEE4F1BA4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 23:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380733AbiDDVV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379591AbiDDRnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 13:43:25 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1158931DE7
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 10:41:29 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id n6-20020a17090a670600b001caa71a9c4aso2632421pjj.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 10:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gRG4DzaFxaS3i3D5Dn6lXKx0bh0DkudE7AH+todWZpo=;
        b=cULjnfUnYWUX1Kg8zxZdjfzMD7GQL25bJU0W7pJg5yaFBuUqoHyNwMXZrfQNYHw34E
         gAyJ8Jjc7T6oZcOQxl6EKSBqurXC8Lbcjz6DXcDiYHAdqiU9X/W4p/FlLgIeDnChPz1+
         K20FIwaCbqf88OMjvi2m2hfEfUeVijLQcS1u7vuVzxZ7Ydo9gQiSSF++k/Ok2yEbMGKB
         /hFAwGaCE3pHDw4nSdIwKbqwSRIQ0GrNqdvEf86f7wi3kb5MIsxGw42+92GBllJGo6Di
         wRWqcSXeUxZrUlr7IzQXEdKQG975PgJqSVDZXWIXsvACbOE27ihyAZco2A1Xl84JlR1+
         lWoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=gRG4DzaFxaS3i3D5Dn6lXKx0bh0DkudE7AH+todWZpo=;
        b=aRckqpOCd2MKg+pZrRSDDT7ZmU3AeO775LsYm2BY4/DYI7EZVXXwJFt8eDXQUNaA7L
         uOKB1i5Z+fogpcMAhALVSrhfeiF4u7Rw1ueBOp3yEsQb2yNVVgJnIWLSg0B9wmSQSiCt
         fMqGZ+APDWOame/7xDb0/BrepgHkX/0/4REx/PwvvYBnYb9ES8tcLbSJTT7EJQW7ePow
         NF+so0K0l3hWapxD6zY5IUgwSqlZUS5FRMsf4CMiTSVv+LNUR38yY7cdtY5chd/Nm/h/
         vrSeQKsXw/a208D7ess82fgKfOiLoRoXLCqIqhwR1Jl3Llr3Rh3Aj2KwEGqJurRsyMp5
         ApsQ==
X-Gm-Message-State: AOAM5328eUEffoPs1G+3lgBFr8cUvs+V7pQZb04A5R357h1Lx0BrpMhe
        er4OB2Kvtzcj6lsuCnvp5pbbsP8L+dk=
X-Google-Smtp-Source: ABdhPJyMZI05fy3SbjyPwUvOf+KODslEq3a0Y3XuRzUGsI83V2UmKZwOthdU6F2UIUaGckP+kXcj2w==
X-Received: by 2002:a17:903:230a:b0:156:9c66:5cd2 with SMTP id d10-20020a170903230a00b001569c665cd2mr742397plh.57.1649094088348;
        Mon, 04 Apr 2022 10:41:28 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:f271:5160:86de:f889])
        by smtp.gmail.com with ESMTPSA id a38-20020a056a001d2600b004fae885424dsm13324657pfx.72.2022.04.04.10.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 10:41:27 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Mon, 4 Apr 2022 10:41:25 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Jirka Hladky <jhladky@redhat.com>, tj@kernel.org,
        gregkh@linuxfoundation.org
Cc:     tj@kernel.org, linux-kernel <linux-kernel@vger.kernel.org>,
        regressions@lists.linux.dev,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Justin Forbes <jforbes@fedoraproject.org>
Subject: Re: PANIC: "Oops: 0000 [#1] PREEMPT SMP PTI" starting from 5.17 on
 dual socket Intel Xeon Gold servers
Message-ID: <YkstxbC3OfzYnSRw@google.com>
References: <CAE4VaGDZr_4wzRn2___eDYRtmdPaGGJdzu_LCSkJYuY9BEO3cw@mail.gmail.com>
 <536eca11-b4b9-c1a8-6e6b-fcd0c339a3ec@leemhuis.info>
 <CAE4VaGBZk2NL6Tn2fGxmGMR-n8KFNqgPOktY_sQ1vjViLDNhhg@mail.gmail.com>
 <CAE4VaGB4=aCd8iDb4EduR+-5QTSgVWd5sxrnBA4e3g9dPrnuBg@mail.gmail.com>
 <YkTxox8ZQIDtojfU@google.com>
 <CAFxkdAq6r2WnwML-pPfdZiajaYZCEcUU3GrXW=+wsA7CxGnJdQ@mail.gmail.com>
 <CAE4VaGBchOMWeHQ8GKiGFv_aCaNGLEvSdLWXZTpE+qC=0bgM3A@mail.gmail.com>
 <YkY6W1NS+1RTw0VB@google.com>
 <CAE4VaGDAMZqjwumyvbityzEiK30=5a5vuDMjaS+UHM39R-oPRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE4VaGDAMZqjwumyvbityzEiK30=5a5vuDMjaS+UHM39R-oPRw@mail.gmail.com>
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

On Fri, Apr 01, 2022 at 02:04:03PM +0200, Jirka Hladky wrote:
> > Could you decode exact source code line from the oops?
> 
> Yes - please see below [1].

Thanks.

> 
> > I think it's fine to attach in the reply because kernel test bot
> 
> OK. The reproducer is attached. Please unpack it and follow the
> instructions in the README file. [2]

Unfortunately, I failed to run the script in my machine.

> 
> Thanks a lot for looking into it!
> Jirka
> 
> [1]
> =============================================
> Source code line numbers for the Oops message
> =============================================
> 
> 1) RIP: 0010:kernfs_remove+0x8/0x50:
> (gdb) l *kernfs_remove+0x8
> 0xffffffff81418588 is in kernfs_remove (fs/kernfs/kernfs-internal.h:48).
> 43       * Return the kernfs_root @kn belongs to.
> 44       */
> 45      static inline struct kernfs_root *kernfs_root(struct kernfs_node *kn)
> 46      {
> 47              /* if parent exists, it's always a dir; otherwise, @sd
> is a dir */
> 48              if (kn->parent)
> 49                      kn = kn->parent;
> 50              return kn->dir.root;
> 51      }
> 
> And here are source code lines from the 5 first functions in call trace:
> [ 8563.366280] Call Trace:
> [ 8563.366280]  <TASK>
> [ 8563.366280]  rdt_kill_sb+0x29d/0x350
> [ 8563.366280]  deactivate_locked_super+0x36/0xa0
> [ 8563.366280]  cleanup_mnt+0x131/0x190
> [ 8563.366280]  task_work_run+0x5c/0x90
> [ 8563.366280]  exit_to_user_mode_prepare+0x229/0x230
> [ 8563.366280]  syscall_exit_to_user_mode+0x18/0x40
> [ 8563.366280]  do_syscall_64+0x48/0x90
> [ 8563.366280]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> 2)(gdb) l *rdt_kill_sb+0x29d
> 0xffffffff810506bd is in rdt_kill_sb
> (arch/x86/kernel/cpu/resctrl/rdtgroup.c:2442).
> 2437            /* Notify online CPUs to update per cpu storage and
> PQR_ASSOC MSR */
> 2438            update_closid_rmid(cpu_online_mask, &rdtgroup_default);
> 2439
> 2440            kernfs_remove(kn_info);
> 2441            kernfs_remove(kn_mongrp);
> 2442            kernfs_remove(kn_mondata);
> 2443    }
> 
> 3)(gdb) l *deactivate_locked_super+0x36
> 0xffffffff813650f6 is in deactivate_locked_super (fs/super.c:342).
> 337                     /*
> 338                      * Since list_lru_destroy() may sleep, we
> cannot call it from
> 339                      * put_super(), where we hold the sb_lock.
> Therefore we destroy
> 340                      * the lru lists right now.
> 341                      */
> 342                     list_lru_destroy(&s->s_dentry_lru);
> 343                     list_lru_destroy(&s->s_inode_lru);
> 344
> 345                     put_filesystem(fs);
> 346                     put_super(s);
> 
> 4) (gdb) l *cleanup_mnt+0x131
> 0xffffffff813890a1 is in cleanup_mnt (fs/namespace.c:137).
> 132             return 0;
> 133     }
> 134
> 135     static void mnt_free_id(struct mount *mnt)
> 136     {
> 137             ida_free(&mnt_id_ida, mnt->mnt_id);
> 138     }
> 
> 5) (gdb) l *task_work_run+0x5c
> 0xffffffff8110620c is in task_work_run (./include/linux/sched.h:2017).
> 2012
> 2013    DECLARE_STATIC_CALL(cond_resched, __cond_resched);
> 2014
> 2015    static __always_inline int _cond_resched(void)
> 2016    {
> 2017            return static_call_mod(cond_resched)();
> 2018    }
> 
> 6) (gdb) l *exit_to_user_mode_prepare+0x229
> 0xffffffff81176d19 is in exit_to_user_mode_prepare
> (./include/linux/tracehook.h:189).
> 184              * This barrier pairs with
> task_work_add()->set_notify_resume() after
> 185              * hlist_add_head(task->task_works);
> 186              */
> 187             smp_mb__after_atomic();
> 188             if (unlikely(current->task_works))
> 189                     task_work_run();
> 190
> 191     #ifdef CONFIG_KEYS_REQUEST_CACHE
> 192             if (unlikely(current->cached_requested_key)) {
> 193                     key_put(current->cached_requested_key);
> 
> [2]
> =============================================
> Reproducer - README
> =============================================
> 
> 1) HW
> This issue seems to be platform specific. I was not able to reproduce
> it on AMD Zen and also not on Intel Ice Lake platform.
> I see the issue on dual socket Intel Skylake systems. Reproduced on a
> Supermicro Super Server/X11DDW-L with 2x Xeon Gold 6126 CPU.

Based on your report, kernel was crashed due to kn_mondata was NULL

  rdt_kill_sb
    rmdir_all_sub
      ..
      kernfs_remove(kn_mondata);
        struct kernfs_root *root = kernfs_root(kn); <-- crashed


Before the my patch[1], it worked like this.

  rdt_kill_sb
    rmdir_all_sub
      ..
      kernfs_remove(kn_mondata);
        down_write(&kernfs_rwsem);
          if (!kn)
            return;
        up_write(&kernfs_rwsem);

IOW, before, kernfs_remove worked with NULL argument via just bailing
but with the my patch[1], it doesn't work any longer.

It makes me have questions for kernfs maintainers:

Should kernfs_remove API support NULL parameter? If so, can we support
it atomically without old global kernfs_rwsem?

[1] 393c3714081a, kernfs: switch global kernfs_rwsem lock to per-fs lock
