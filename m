Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B014F59CA9D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 23:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbiHVVQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 17:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237529AbiHVVQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 17:16:06 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43263DBFF
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 14:16:05 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id d71so10492992pgc.13
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 14:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=mJuMD1J9mSg4Tayie7CRPcj4C11xZ/X63/iRaU5vs3Q=;
        b=YeRqoo8PKi8RuARmyWaGgbYSk+XR5yiQlSiyPEfOBhgzEtPL4d/TaThygxnommbpPX
         ENUTKGJXlTP+A6jaJOtwm0m9gkcHHlLaWXPj1/RUdr3yuqeUlLIw8G/yD0PEcmpm++xc
         SBj0wg2iBKNpKvXoP9Qx9dUNxqcj90NzrZ+Wk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=mJuMD1J9mSg4Tayie7CRPcj4C11xZ/X63/iRaU5vs3Q=;
        b=n2NYW91GY5VSSPRiRuUV9/cw0aipvlKV2MdidcJfCXrXHU+VnIPbNe2LVF+SUwaZ3N
         ojmRzvzea08a2Y+lf8RpGC//VesHetrL3o6xaEjQl/OB3ZarcLJNKeQqxBpwngYgIBG6
         vFX8MrxtToLHrg84fw70hdZbKnlbFFZMvslJT1qZTo9y+IeEjgGrE66JRqZ4FOj+TiR4
         JhAM1Tp8UyMeIXljjfiGeAHUTfB1WB0stRNK+niE/y+GNMomggkwtLWFtFBCB1kAXG0G
         2wvIIleoMUmav0tqnvE7U1kSMwEI6wfLdx8zP/7veSWtA+IIVZimLXLwIBlOhFc4r6Nb
         MMCg==
X-Gm-Message-State: ACgBeo1zL4EqbKhSKUlPFOzaqwR05PHF7P4IllMEKuW2ysE67QxDUn2G
        s8mxlnydfpMpc9odXr+7EIaQvg==
X-Google-Smtp-Source: AA6agR51qY2bxCc+G2gFUL2GfYxh4pc1uoVYSjbNCUyKN6T7j3f/lQ2CVvkdUmIDgTgH5lcIXfHzZw==
X-Received: by 2002:a05:6a00:2395:b0:52f:723c:363 with SMTP id f21-20020a056a00239500b0052f723c0363mr22183639pfc.21.1661202965336;
        Mon, 22 Aug 2022 14:16:05 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n10-20020a6546ca000000b0042a4612c07esm5893432pgr.39.2022.08.22.14.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 14:16:04 -0700 (PDT)
Date:   Mon, 22 Aug 2022 14:16:03 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Kuniyuki Iwashima <kuniyu@amazon.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        Christian Brauner <brauner@kernel.org>,
        Kuniyuki Iwashima <kuni1840@gmail.com>,
        linux-kernel@vger.kernel.org,
        syzbot+ab17848fe269b573eb71@syzkaller.appspotmail.com,
        Ayushman Dutta <ayudutta@amazon.com>
Subject: Re: [PATCH v1] seccomp: Release filter when copy_process() fails.
Message-ID: <202208221414.A0E13E7@keescook>
References: <20220822204436.26631-1-kuniyu@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220822204436.26631-1-kuniyu@amazon.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2022 at 01:44:36PM -0700, Kuniyuki Iwashima wrote:
> Our syzbot instance reported memory leaks in do_seccomp() [0], similar
> to the report [1].  It shows that we miss freeing struct seccomp_filter
> and some objects included in it.
> 
> We can reproduce the issue with the program below [2] which calls one
> seccomp() and two clone() syscalls.
> 
> The first clone()d child exits earlier than its parent and sends a
> signal to kill it during the second clone(), more precisely before the
> fatal_signal_pending() test in copy_process().  When the parent receives
> the signal, it has to destroy the embryonic process and return -EINTR to
> user space.  In the failure path, we have to call seccomp_filter_release()
> to decrement the filter's ref count.
> 
> Initially, we called it in free_task() called from the failure path, but
> the commit 3a15fb6ed92c ("seccomp: release filter after task is fully
> dead") moved it to release_task() to notify user space as early as possible
> that the filter is no longer used.
> 
> To keep the change, let's call seccomp_filter_release() in copy_process()
> and add a WARN_ON_ONCE() in free_task() for future debugging.

Thanks for tracking this down! I think I'd prefer to avoid changing the
semantics around the existing seccomp refcount lifetime, so what about
just moving copy_seccomp() below the last possible error path?


diff --git a/kernel/fork.c b/kernel/fork.c
index 90c85b17bf69..e7f4e7f1e01e 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2409,12 +2409,6 @@ static __latent_entropy struct task_struct *copy_process(
 
 	spin_lock(&current->sighand->siglock);
 
-	/*
-	 * Copy seccomp details explicitly here, in case they were changed
-	 * before holding sighand lock.
-	 */
-	copy_seccomp(p);
-
 	rv_task_fork(p);
 
 	rseq_fork(p, clone_flags);
@@ -2431,6 +2425,14 @@ static __latent_entropy struct task_struct *copy_process(
 		goto bad_fork_cancel_cgroup;
 	}
 
+	/* No more failures paths after this point. */
+
+	/*
+	 * Copy seccomp details explicitly here, in case they were changed
+	 * before holding sighand lock.
+	 */
+	copy_seccomp(p);
+
 	init_task_pid_links(p);
 	if (likely(p->pid)) {
 		ptrace_init_task(p, (clone_flags & CLONE_PTRACE) || trace);


Totally untested, but I think it would fix this?

-Kees

-- 
Kees Cook
