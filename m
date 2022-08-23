Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7DC259EBC0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 21:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbiHWTBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 15:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234695AbiHWTA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 15:00:57 -0400
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB3C118CB6;
        Tue, 23 Aug 2022 10:32:15 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-32a09b909f6so398442797b3.0;
        Tue, 23 Aug 2022 10:32:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=kdvm0vZFz59kvC4HTbp02OnCMuyH+djj08TK3gUuuqo=;
        b=4ToG5WYBL4S/XiBchLlr6Z1DrIkqWemli/NNZ84Ffy4yXUB5tSINXSyJRyMkGYKZXr
         1HLyUWYuVztS9BLS0DPvC7OX+s0R/g5VkodsEnt6N7/cKuFyKmV2AV0y4ufPzQZ5bNH/
         BEA4dGLbo240Zfk87daUDIyNkgDJWpPt1HF5JvfkhB5bsZB2GGNpwvuEBWwSYHUkFSM/
         F5/80Cu7aBMcpaj0SjFLvhB0xepbLaCfMVDUHV+qi9GMc3KhthKLuRhRVFfpVkh3qeWK
         vCAs7DTNlvCKW6KAsEECIlxVSPdh2LFS+CsOpLaeJy8/Qi5ZTDmumUsLXfiV1NtZ+EnQ
         QWjg==
X-Gm-Message-State: ACgBeo3MUb+46Y1tF89EQEUdzjl8fIqcA67y/4O36vyvDlhdpSvDwd/v
        wkUm45AZmC0cNcIdcHw/fPsn+o4JT3azqe34Uy8=
X-Google-Smtp-Source: AA6agR7OENJPJYLFu0aaVp/glS2lRJEGr2vVS/qGv5j8Oug+Azd8zapVYzCyRUPQU+b4OWAYc9m4QEpwkO5uPvSGplA=
X-Received: by 2002:a0d:e701:0:b0:336:90d7:c67a with SMTP id
 q1-20020a0de701000000b0033690d7c67amr26650389ywe.7.1661275747371; Tue, 23 Aug
 2022 10:29:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220822111816.760285417@infradead.org> <20220822114648.791019324@infradead.org>
In-Reply-To: <20220822114648.791019324@infradead.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 23 Aug 2022 19:28:56 +0200
Message-ID: <CAJZ5v0iYmfPw+arADFkGtwNWp8wjy-TnukUchg9=i15Nb-9jLg@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] freezer,umh: Clean up freezer/initrd interaction
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Eric Biederman <ebiederm@xmission.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2022 at 1:48 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> handle_initrd() marks itself as PF_FREEZER_SKIP in order to ensure
> that the UMH, which is going to freeze the system, doesn't
> indefinitely wait for it's caller.
>
> Rework things by adding UMH_FREEZABLE to indicate the completion is
> freezable.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  include/linux/umh.h     |    9 +++++----
>  init/do_mounts_initrd.c |   10 +---------
>  kernel/umh.c            |    8 ++++++++
>  3 files changed, 14 insertions(+), 13 deletions(-)
>
> --- a/include/linux/umh.h
> +++ b/include/linux/umh.h
> @@ -11,10 +11,11 @@
>  struct cred;
>  struct file;
>
> -#define UMH_NO_WAIT    0       /* don't wait at all */
> -#define UMH_WAIT_EXEC  1       /* wait for the exec, but not the process */
> -#define UMH_WAIT_PROC  2       /* wait for the process to complete */
> -#define UMH_KILLABLE   4       /* wait for EXEC/PROC killable */
> +#define UMH_NO_WAIT    0x00    /* don't wait at all */
> +#define UMH_WAIT_EXEC  0x01    /* wait for the exec, but not the process */
> +#define UMH_WAIT_PROC  0x02    /* wait for the process to complete */
> +#define UMH_KILLABLE   0x04    /* wait for EXEC/PROC killable */
> +#define UMH_FREEZABLE  0x08    /* wait for EXEC/PROC freezable */
>
>  struct subprocess_info {
>         struct work_struct work;
> --- a/init/do_mounts_initrd.c
> +++ b/init/do_mounts_initrd.c
> @@ -79,19 +79,11 @@ static void __init handle_initrd(void)
>         init_mkdir("/old", 0700);
>         init_chdir("/old");
>
> -       /*
> -        * In case that a resume from disk is carried out by linuxrc or one of
> -        * its children, we need to tell the freezer not to wait for us.
> -        */
> -       current->flags |= PF_FREEZER_SKIP;
> -
>         info = call_usermodehelper_setup("/linuxrc", argv, envp_init,
>                                          GFP_KERNEL, init_linuxrc, NULL, NULL);
>         if (!info)
>                 return;
> -       call_usermodehelper_exec(info, UMH_WAIT_PROC);
> -
> -       current->flags &= ~PF_FREEZER_SKIP;
> +       call_usermodehelper_exec(info, UMH_WAIT_PROC|UMH_FREEZABLE);
>
>         /* move initrd to rootfs' /old */
>         init_mount("..", ".", NULL, MS_MOVE, NULL);
> --- a/kernel/umh.c
> +++ b/kernel/umh.c
> @@ -28,6 +28,7 @@
>  #include <linux/async.h>
>  #include <linux/uaccess.h>
>  #include <linux/initrd.h>
> +#include <linux/freezer.h>
>
>  #include <trace/events/module.h>
>
> @@ -436,6 +437,9 @@ int call_usermodehelper_exec(struct subp
>         if (wait == UMH_NO_WAIT)        /* task has freed sub_info */
>                 goto unlock;
>
> +       if (wait & UMH_FREEZABLE)
> +               freezer_do_not_count();
> +
>         if (wait & UMH_KILLABLE) {
>                 retval = wait_for_completion_killable(&done);
>                 if (!retval)
> @@ -448,6 +452,10 @@ int call_usermodehelper_exec(struct subp
>         }
>
>         wait_for_completion(&done);
> +
> +       if (wait & UMH_FREEZABLE)
> +               freezer_count();
> +
>  wait_done:
>         retval = sub_info->retval;
>  out:
>
>
