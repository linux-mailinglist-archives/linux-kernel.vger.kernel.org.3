Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12BE651728F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 17:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385787AbiEBPeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 11:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385846AbiEBPeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 11:34:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB130109E;
        Mon,  2 May 2022 08:30:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF55F610A3;
        Mon,  2 May 2022 15:30:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DA16C385A4;
        Mon,  2 May 2022 15:30:29 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="eyCIu4wo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1651505427;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qWDIwzU5x3UuWsZp+HhTp4LQrtqpnPHHxwXe77v7dMY=;
        b=eyCIu4woGQwRluJ81yt4j3UmCFhltI8z4Rf7zFiHwOthQkVAb3o+whdo8HpoQojM3YOjYH
        Vs/QB/Zjo6AImQ+X0lg6B0v+9DHeyEjGWb4icLkEzfIZB02hQw03kYy3CWuLdCVsrxtsAV
        VJwJJgDNho6/kl7x/hwD9KxeFHkexow=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 7f1160cf (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 2 May 2022 15:30:27 +0000 (UTC)
Date:   Mon, 2 May 2022 17:30:24 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     mzxreary@0pointer.de, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH 1/2] sysctl: read() must consume poll events, not poll()
Message-ID: <Ym/5EEYHbk56hV1H@zx2c4.com>
References: <20220502140602.130373-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220502140602.130373-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Lennart, since systemd is the only userspace I know of currently making
use of this.

On Mon, May 02, 2022 at 04:06:01PM +0200, Jason A. Donenfeld wrote:
> Events that poll() responds to are supposed to be consumed when the file
> is read(), not by the poll() itself. By putting it on the poll() itself,
> it makes it impossible to poll() on a epoll file descriptor, since the
> event gets consumed too early. Jann wrote a PoC, available in the link
> below.
> 
> Reported-by: Jann Horn <jannh@google.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: linux-fsdevel@vger.kernel.org
> Link: https://lore.kernel.org/lkml/CAG48ez1F0P7Wnp=PGhiUej=u=8CSF6gpD9J=Oxxg0buFRqV1tA@mail.gmail.com/
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  fs/proc/proc_sysctl.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> index 7d9cfc730bd4..1aa145794207 100644
> --- a/fs/proc/proc_sysctl.c
> +++ b/fs/proc/proc_sysctl.c
> @@ -622,6 +622,14 @@ static ssize_t proc_sys_call_handler(struct kiocb *iocb, struct iov_iter *iter,
>  
>  static ssize_t proc_sys_read(struct kiocb *iocb, struct iov_iter *iter)
>  {
> +	struct inode *inode = file_inode(iocb->ki_filp);
> +	struct ctl_table_header *head = grab_header(inode);
> +	struct ctl_table *table = PROC_I(inode)->sysctl_entry;
> +
> +	if (!IS_ERR(head) && table->poll)
> +		iocb->ki_filp->private_data = proc_sys_poll_event(table->poll);
> +	sysctl_head_finish(head);
> +
>  	return proc_sys_call_handler(iocb, iter, 0);
>  }
>  
> @@ -668,10 +676,8 @@ static __poll_t proc_sys_poll(struct file *filp, poll_table *wait)
>  	event = (unsigned long)filp->private_data;
>  	poll_wait(filp, &table->poll->wait, wait);
>  
> -	if (event != atomic_read(&table->poll->event)) {
> -		filp->private_data = proc_sys_poll_event(table->poll);
> +	if (event != atomic_read(&table->poll->event))
>  		ret = EPOLLIN | EPOLLRDNORM | EPOLLERR | EPOLLPRI;
> -	}
>  
>  out:
>  	sysctl_head_finish(head);
> -- 
> 2.35.1

Just wanted to double check with you that this change wouldn't break how
you're using it in systemd for /proc/sys/kernel/hostname:

https://github.com/systemd/systemd/blob/39cd62c30c2e6bb5ec13ebc1ecf0d37ed015b1b8/src/journal/journald-server.c#L1832
https://github.com/systemd/systemd/blob/39cd62c30c2e6bb5ec13ebc1ecf0d37ed015b1b8/src/resolve/resolved-manager.c#L465

I couldn't find anybody else actually polling on it. Interestingly, it
looks like sd_event_add_io uses epoll() inside, but you're not hitting
the bug that Jann pointed out (because I suppose you're not poll()ing on
an epoll fd).

Jason
