Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5DDB53EDE1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 20:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbiFFS2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 14:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbiFFS2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 14:28:45 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F04E1AF6EB
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 11:28:44 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id fu3so29099827ejc.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 11:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qXYqp07Gt1ZtS5TmqPmPcYjNyQa7EHn+PPqLupxduxE=;
        b=e5deP955cqquSyg6oIIx3CAf8kgiTaqIY9bcnFfEj7ZLflDPPAW86Emcn95M8HZaCC
         42qc7J70nZug2SNdJKjJgyCMPhAPg0LD/D4YMTCvWKzcs83etYmdBaLlq/Isztw3LXqz
         giP1rEm6h5Y0md23q+Lg6Uqv0VYv58smLzap0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qXYqp07Gt1ZtS5TmqPmPcYjNyQa7EHn+PPqLupxduxE=;
        b=vAoS3DiEJ8FDrEdY0yfVmsD6LOnxQdjNmrzHkvJxKpwWw9ZKv7VHQgEN1Fuh+xopX5
         3YZLiFTeDVLA7Qnmjk/grXZkndpZCH39oCFDjW0HFL9nyExKvSTfFjAnJ7s3zk7Ea7ij
         5xkXAjnmk5ggGc51s562F9r52qj1bo/gQ3DEaMRmpievOFdBw6U0TyTBRmUD1SanPpgV
         /gy0zeuZZRuwKApKLl+NpV+3uORhfnEg9s9pilsVXzbwjlOwbv3zbgOvJGUY3aAG4P2R
         tmcemwnhFJJp5eGuYBtqz0tAzi0EXjLiskHOwNQn+AcprHp/eJumLtlkWIp5qGx2DENP
         mSJw==
X-Gm-Message-State: AOAM5331y3ece+Hn/LBLNUuOXtWBojAQUTNxi5BinWj9nD+BUSmDkzRb
        vx+eDuL2X2fifR5vr9TckvvXn8XH1GbRspgakjc=
X-Google-Smtp-Source: ABdhPJzLxtMmic+oGS48hsazu5/UMXCzNEJZNQ0GIYqpXz1sshLG5cwM4c1ar7QKLegG5qCf8MU+mg==
X-Received: by 2002:a17:907:96a0:b0:6fe:c2c7:5c66 with SMTP id hd32-20020a17090796a000b006fec2c75c66mr22855675ejc.756.1654540122687;
        Mon, 06 Jun 2022 11:28:42 -0700 (PDT)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id q24-20020aa7d458000000b0042aad9edc9bsm9142120edr.71.2022.06.06.11.28.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jun 2022 11:28:41 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id d14so11968638wra.10
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 11:28:40 -0700 (PDT)
X-Received: by 2002:a05:6000:1b0f:b0:210:313a:ef2a with SMTP id
 f15-20020a0560001b0f00b00210313aef2amr22896573wrz.281.1654540120455; Mon, 06
 Jun 2022 11:28:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whmtHMzjaVUF9bS+7vE_rrRctcCTvsAeB8fuLYcyYLN-g@mail.gmail.com>
 <226cee6a-6ca1-b603-db08-8500cd8f77b7@gnuweeb.org> <CAHk-=whayT+o58FrPCXVVJ3Bn-3SeoDkMA77TOd9jg4yMGNExw@mail.gmail.com>
 <87r1414y5v.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87r1414y5v.fsf@email.froward.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 6 Jun 2022 11:28:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wijAnOcC2qQEAvFtRD_xpPbG+aSUXkfM-nFTHuMmPbZGA@mail.gmail.com>
Message-ID: <CAHk-=wijAnOcC2qQEAvFtRD_xpPbG+aSUXkfM-nFTHuMmPbZGA@mail.gmail.com>
Subject: Re: Linux 5.18-rc4
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        "<linux-fsdevel@vger.kernel.org>" <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, gwml@vger.gnuweeb.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 6, 2022 at 8:19 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
> Has anyone looked into this lock ordering issues?

The deadlock is

> >> [78140.503821]        CPU0                    CPU1
> >> [78140.503823]        ----                    ----
> >> [78140.503824]   lock(&newf->file_lock);
> >> [78140.503826]                                lock(&p->alloc_lock);
> >> [78140.503828]                                lock(&newf->file_lock);
> >> [78140.503830]   lock(&ctx->lock);

and the alloc_lock -> file_lock on CPU1 is trivial - it's seq_show()
in fs/proc/fd.c:

        task_lock(task);
        files = task->files;
        if (files) {
                unsigned int fd = proc_fd(m->private);

                spin_lock(&files->file_lock);

and that looks all normal.

But the other chains look painful.

I do see the IPC code doing ugly things, in particular I detest this code:

        task_lock(current);
        list_add(&shp->shm_clist, &current->sysvshm.shm_clist);
        task_unlock(current);

where it is using the task lock to protect the shm_clist list. Nasty.

And it's doing that inside the shm_ids.rwsem lock _and_ inside the
shp->shm_perm.lock.

So the IPC code has newseg() doing

   shmget ->
    ipcget():
     down_write(ids->rwsem) ->
       newseg():
         ipc_addid gets perm->lock
         task_lock(current)

so you have

  ids->rwsem -> perm->lock -> alloc_lock

there.

So now we have that

   ids->rwsem -> ipcperm->lock -> alloc_lock -> file_lock

when you put those sequences together.

But I didn't figure out what the security subsystem angle is and how
that then apparently mixes things up with execve.

Yes, newseg() is doing that

        error = security_shm_alloc(&shp->shm_perm);

while holding rwsem, but I can't see how that matters. From the
lockdep output, rwsem doesn't actually seem to be part of the whole
sequence.

It *looks* like we have

   apparmour ctx->lock -->
      radix_tree_preloads.lock -->
         ipcperm->lock

and apparently that's called under the file_lock somewhere, completing
the circle.

I guess the execve component is that

  begin_new_exec ->
    security_bprm_committing_creds ->
      apparmor_bprm_committing_creds ->
        aa_inherit_files ->
          iterate_fd ->   *takes file_lock*
            match_file ->
              aa_file_perm ->
                update_file_ctx *takes ctx->lock*

so that's how you get file_lock -> ctx->lock.

So you have:

 SHMGET:
    ipcperm->lock -> alloc_lock
 /proc:
    alloc_lock -> file_lock
 apparmor_bprm_committing_creds:
    file_lock -> ctx->lock

and then all you need is ctx->lock -> ipcperm->lock but I didn't find that part.

I suspect that part is that both Apparmor and IPC use the idr local lock.

               Linus
