Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB36F5A7342
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 03:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbiHaBSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 21:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiHaBSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 21:18:33 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3428FAC248
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 18:18:32 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id z25so17895441lfr.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 18:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=YdigL9mdfE/0hNS5gRz7RikDbrA/FSPnOXRX8Mw8fQo=;
        b=h9jRoiN4Z7DMAgNwBStObbVmRqZzodsYOdu4El9wyBAcjq7ZcUcqcvor7F2ZJ6J1xG
         kV6Ko3b2AE/t7suQuzy8Jx/1KUT8tLjl6ozSbHl7SnXnESVFrRkryFiJa7CGXK5TESV4
         T6AD3UeKGi2VUKhbs7imHCHIUgnD5rhV/Op9pGbfC/Tmuua547PmmZW+YDL5L0tmhtfe
         f67TELVbK7MWXgMR5lcH9F6hgB4Mc87l0KpjfwwurtyO90NBvp46XHZLbJNCJannpIVT
         iUdxR4+iAkORS8eYebiFuJxKiVN5iRZX9FB8FMt9QTmevJQ0torYb+M7HrvCsuzRHTke
         FfTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=YdigL9mdfE/0hNS5gRz7RikDbrA/FSPnOXRX8Mw8fQo=;
        b=rVNbC7MaSuUgm0QjhamNYeDsEePCYaBktn4zxj3iamSxWXSndxYRVwSHRHkBFXshFw
         1cOUu8Lf0P/kFMW/SP2IE1WTCsIf+/PNda4ejUjhaqL4isj2FWMiFe44kgt7sDOPkwnM
         tFpfnfiLv/PnR3CHwS+bQJf8JlRnG7kUjop+P88Q1zZrcjLRNxLHGMZNIBP3kSx4hpuM
         Sf62Cl9d7EApuMv7F2tuPHxWvPU8LRV2NcWlWgEqwXLgLABujer8xEnmwIXcbpgNTP1d
         sXxVAzmt7cpwMCet3azDHfQtTn/B1y8+Xio3BqHaftm1bjnV8HLAvrhPCfSBFkahUgg+
         6CvA==
X-Gm-Message-State: ACgBeo0DdW5M3K8B+r90n02Ro+swiKi0sO4ldmqcZEEPSjUIbgLVZrWD
        Pr8+JVCklQyjGWg8dJTSw2mrmFcmS8hwiNGed40=
X-Google-Smtp-Source: AA6agR6TDH/k8jKRG/W42SD7AuvkaHpSGOxENbANejrv34fgKlkUKpJUDImBnURU/DFc+bEONHVvZWctpz7YP7x5QYA=
X-Received: by 2002:ac2:4c4c:0:b0:492:bc29:e328 with SMTP id
 o12-20020ac24c4c000000b00492bc29e328mr8065768lfk.386.1661908710335; Tue, 30
 Aug 2022 18:18:30 -0700 (PDT)
MIME-Version: 1.0
References: <ed418e43ad28b8688cfea2b7c90fce1c@ispras.ru>
In-Reply-To: <ed418e43ad28b8688cfea2b7c90fce1c@ispras.ru>
From:   Andrei Vagin <avagin@gmail.com>
Date:   Tue, 30 Aug 2022 18:18:18 -0700
Message-ID: <CANaxB-xqpZcVObpGCBsBXNVN7a2CZ7=_CaPZp4mG50Bi0oVDmA@mail.gmail.com>
Subject: Re: Potentially undesirable interactions between vfork() and time namespaces
To:     Alexey Izbyshev <izbyshev@ispras.ru>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        Florian Weimer <fweimer@redhat.com>, linux-mm@kvack.org,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 12:49 PM Alexey Izbyshev <izbyshev@ispras.ru> wrote:
>
> Hi,
>
> I've looked at Andrei's patch[1] that permitted vfork() after
> unshare(CLONE_NEWTIME) and noticed a couple of odd things that I'd like
> to point out.
>
>         /*
>          * If the new process will be in a different time namespace
>          * do not allow it to share VM or a thread group with the forking
> task.
> +        *
> +        * On vfork, the child process enters the target time namespace only
> +        * after exec.
>          */
> -       if (clone_flags & (CLONE_THREAD | CLONE_VM)) {
> +       if ((clone_flags & (CLONE_VM | CLONE_VFORK)) == CLONE_VM) {
>                 if (nsp->time_ns != nsp->time_ns_for_children)
>                         return ERR_PTR(-EINVAL);
>         }
>
> This change permits not only a normal vfork(), but also
> clone(CLONE_VM|CLONE_VFORK|CLONE_SIGHAND|CLONE_THREAD). I'm not sure
> whether it can cause real harm, but it's pretty inconsistent to forbid
> creation of normal threads after unshare(CLONE_NEWTIME), but permit such
> weird ones, so maybe the check should be strengthened.

Good catch. I was not aware that CLONE_VFORK is allowed to be used with
CLONE_THREAD. I will send a fix.  Thanks.

>
> Also, if such a thread execs, no time namespace switch will happen
> because it's vfork_done field will be cleared when its creator (a
> sibling thread) is killed by de_thread().
>
> +       vfork = !!tsk->vfork_done;
>          old_mm = current->mm;
>          exec_mm_release(tsk, old_mm);
>          if (old_mm)
> @@ -1030,6 +1033,10 @@ static int exec_mmap(struct mm_struct *mm)
>          tsk->mm->vmacache_seqnum = 0;
>          vmacache_flush(tsk);
>          task_unlock(tsk);
> +
> +       if (vfork)
> +               timens_on_fork(tsk->nsproxy, tsk);
> +
>
> Similarly, even after a normal vfork(), time namespace switch could be
> silently skipped if the parent dies before "tsk->vfork_done" is read.
> Again, I don't know whether anybody cares, but this behavior seems
> non-obvious and probably unintended to me.

This is the more interesting case. I will try to find out how we can
handle it properly.

Thanks,
Andrei
