Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAABB46E947
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 14:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238100AbhLINr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 08:47:56 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:40520 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbhLINrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 08:47:55 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4B9D0210FF;
        Thu,  9 Dec 2021 13:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1639057461; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XlCER1c1kdHMx62q6FXnaeJQSaCcAIFyhVUj/SNYyrs=;
        b=MFf3mp5IRdX7z2p0DwdJvqdfCat9XnYZkPCjpOdT3mS3pNg0FFbkdbmzrI0aXfdqRThBNY
        JdRLLHAO2VZxZs1Hebi7GNaZaJ6Rl1LyKEg8n4KMIBVFaA1Gl0OqJ1RQTkWolUbUrCuTvg
        gRInitrrQ18DbNe0qdYiExCIeKWjZTQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1EEFE13343;
        Thu,  9 Dec 2021 13:44:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FXACBzUIsmH5DAAAMHmgww
        (envelope-from <mkoutny@suse.com>); Thu, 09 Dec 2021 13:44:21 +0000
Date:   Thu, 9 Dec 2021 14:44:19 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linuxfoundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jim Newsome <jnewsome@torproject.org>,
        Alexey Gladkov <legion@kernel.org>,
        Security Officers <security@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Jann Horn <jannh@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH] exit: Retain nsproxy for exit_task_work() work entries
Message-ID: <20211209134419.GA17186@blackbody.suse.cz>
References: <20211208180501.11969-1-mkoutny@suse.com>
 <87sfv3540t.fsf@email.froward.int.ebiederm.org>
 <YbECHjMLPEHO0vqA@slm.duckdns.org>
 <CAHk-=wjcWEYSEVKvowUA0yEeDM279Zg-ptM_SsCMxmRSPJHjAw@mail.gmail.com>
 <YbEMPal0sKkk0+Tl@slm.duckdns.org>
 <YbE6yvMav5Xtp5HO@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbE6yvMav5Xtp5HO@slm.duckdns.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2021 at 01:07:54PM -1000, Tejun Heo <tj@kernel.org> wrote:

> +	saved_cred = override_creds(of->file->f_cred);
>  	ret = cgroup_attach_permissions(src_cgrp, dst_cgrp,
> -					of->file->f_path.dentry->d_sb, threadgroup);
> +					of->file->f_path.dentry->d_sb,
> +					threadgroup, ctx->ns);
> +	revert_creds(saved_cred);

I wonder now whether such a wrap shouldn't also be around cgroup_kill()
too (+ replacement of send_sig() with group_send_sig_info() [1])?

This shouldn't break the use case of passing cgroup kill fd to a less
privileged task for (auto)destruction purposes but on the other hand it
would prevent subverting the fd to a more privileged confused task to
kill otherwise disallowed processes.

Thanks,
Michal

[1] https://lore.kernel.org/r/m1v97x6niq.fsf@fess.ebiederm.org/

