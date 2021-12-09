Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D96346E99F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 15:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238365AbhLIOMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 09:12:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbhLIOML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 09:12:11 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A02C061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 06:08:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B769CCE2602
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 14:08:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D26FC341C8;
        Thu,  9 Dec 2021 14:08:29 +0000 (UTC)
Date:   Thu, 9 Dec 2021 15:08:26 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     Tejun Heo <tj@kernel.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
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
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH] exit: Retain nsproxy for exit_task_work() work entries
Message-ID: <20211209140826.kc2xvvwxrdrwmrtj@wittgenstein>
References: <20211208180501.11969-1-mkoutny@suse.com>
 <87sfv3540t.fsf@email.froward.int.ebiederm.org>
 <YbECHjMLPEHO0vqA@slm.duckdns.org>
 <CAHk-=wjcWEYSEVKvowUA0yEeDM279Zg-ptM_SsCMxmRSPJHjAw@mail.gmail.com>
 <YbEMPal0sKkk0+Tl@slm.duckdns.org>
 <YbE6yvMav5Xtp5HO@slm.duckdns.org>
 <20211209134419.GA17186@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211209134419.GA17186@blackbody.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021 at 02:44:19PM +0100, Michal Koutný wrote:
> On Wed, Dec 08, 2021 at 01:07:54PM -1000, Tejun Heo <tj@kernel.org> wrote:
> 
> > +	saved_cred = override_creds(of->file->f_cred);
> >  	ret = cgroup_attach_permissions(src_cgrp, dst_cgrp,
> > -					of->file->f_path.dentry->d_sb, threadgroup);
> > +					of->file->f_path.dentry->d_sb,
> > +					threadgroup, ctx->ns);
> > +	revert_creds(saved_cred);
> 
> I wonder now whether such a wrap shouldn't also be around cgroup_kill()
> too (+ replacement of send_sig() with group_send_sig_info() [1])?

send_sig() isn't used that was changed in response to a review. I'm
confused. 

> 
> This shouldn't break the use case of passing cgroup kill fd to a less
> privileged task for (auto)destruction purposes but on the other hand it
> would prevent subverting the fd to a more privileged confused task to
> kill otherwise disallowed processes.

Kill and freeze only do time permission checking at open. Why would you
introduce another write time check?
