Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C58055AB760
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 19:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236174AbiIBRVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 13:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235728AbiIBRVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 13:21:01 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8762D4F7B
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 10:21:00 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id x23so2483727pll.7
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 10:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=iQbV94zcvm+miEj7HiKM+Lf+C2RI4FnBWdsgliuH+qI=;
        b=ArtbJSIjssgo6PSuE0VUvEGuZfZVxwOQvS63KtYr4bkZzK+d/nnhmqXO7YT56/R6Rg
         lFfbIL304JlWQ/kZms8CddAoygsd2P8g1kTnvLvZQuCfc82nO0rNuWcmOcO8bXUP6NeO
         sf65kXICgQ7cn4PuGjMwidQf9Rw4ge8c53Cbr7n1S1e8IwzyF8EKF5VGKGLMHihfv5AK
         oshKS0JRNzA4vmLjyfo7HIVjSJndBTOkyswmF5O3Br8v2kTcY8yzo9YeLZ5f8s/yRyVk
         JRinTZA+1UhDb8EaMZJnlYfvbMUOCQuODz1+xS5fFa40QMug19rFxzc78G2u+qB7Bthu
         mKIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=iQbV94zcvm+miEj7HiKM+Lf+C2RI4FnBWdsgliuH+qI=;
        b=VnNOyhKfHDn1qmopViByFCd4Yrhjlal+dgyAyBA3e37Khz4kbqUoKrIJZpUIDnN0n7
         0w4JchIGoGzgPqRyIWphkQRJfv4KwOWjGiG2Pg5b0RmIvDpOjDknzxaWFnuxEDrluhRm
         zE3o39yienc/mW8TDSFBu6W4IrsT63ajpVhjc+E0a91bMnCa4oLesHtG00NwRQ8As8If
         SsAwe3PZC0LNc/bwpaTL01dMDnCgF8Hnb9AEJuN5VpL3awwvZ8KJaT89yxEiJu99W1Ly
         zo905f84BVXfSGkk6VobCARvU4ow4P0XAtMWeRAIV0o7Eb+1agSEjDJ7LCZZRiRi/1qT
         FHWA==
X-Gm-Message-State: ACgBeo3NU+bQts+oOVBzV9z1jWj5G8P7rwm+5FtaoUuFJQETNjuQDYat
        1m1feAdD5y5RumP9uN6kNjc=
X-Google-Smtp-Source: AA6agR5YgYe8v48cg9VcdiYh6UwpYqzgBmOwNuY+6Rv7JAuD2W8ZkgXYvsCV90pF32VMdSMecw//Ng==
X-Received: by 2002:a17:902:bd05:b0:172:ae77:1eea with SMTP id p5-20020a170902bd0500b00172ae771eeamr36296865pls.158.1662139260174;
        Fri, 02 Sep 2022 10:21:00 -0700 (PDT)
Received: from gmail.com ([2601:600:8500:5f14:d627:c51e:516e:a105])
        by smtp.gmail.com with ESMTPSA id z15-20020a170903018f00b00172a670607asm1909648plg.300.2022.09.02.10.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 10:20:59 -0700 (PDT)
Date:   Fri, 2 Sep 2022 10:20:57 -0700
From:   Andrei Vagin <avagin@gmail.com>
To:     Alexey Izbyshev <izbyshev@ispras.ru>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Florian Weimer <fweimer@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: Potentially undesirable interactions between vfork() and time
 namespaces
Message-ID: <YxI7ec9S1CB0sDju@gmail.com>
References: <YxAq2jYvGG8QOypu@gmail.com>
 <87czcfhsme.fsf@email.froward.int.ebiederm.org>
 <YxIr15QTmYb4Uojq@gmail.com>
 <b14a9802e171b3148c62f6193d08fa92@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <b14a9802e171b3148c62f6193d08fa92@ispras.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 07:39:28PM +0300, Alexey Izbyshev wrote:

<snip>

> > > @@ -2043,18 +2043,6 @@ static __latent_entropy struct task_struct
> > > *copy_process(
> > >  			return ERR_PTR(-EINVAL);
> > >  	}
> > > 
> > > -	/*
> > > -	 * If the new process will be in a different time namespace
> > > -	 * do not allow it to share VM or a thread group with the forking
> > > task.
> > > -	 *
> > > -	 * On vfork, the child process enters the target time namespace only
> > > -	 * after exec.
> > > -	 */
> > > -	if ((clone_flags & (CLONE_VM | CLONE_VFORK)) == CLONE_VM) {
> > > -		if (nsp->time_ns != nsp->time_ns_for_children)
> > > -			return ERR_PTR(-EINVAL);
> > > -	}
> > 
> > pls don't remove this part. It was one of the concerns that vfork
> > doesn't work after unshare(CLONE_NEWTIME), but it is one of the standard
> > ways of creating a new process. For example, posix_spawn uses it.
> > 
> What do you mean? On the contrary, removing this restriction of the original
> time namespace implementation allows vfork(), pthread_create() and the like,
> solving the issue with posix_spawn() as well.
>

Sorry, I was not woken up completely and decided that it just reverted
the change that allows vfork. Now, I see that it removes this
restriction completely. So it looks good to me.

Thanks,
Andrei.
