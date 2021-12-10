Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10037470E70
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 00:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235428AbhLJXQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 18:16:15 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:49222 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbhLJXQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 18:16:14 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 67270210F0;
        Fri, 10 Dec 2021 23:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1639177957; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=72ZRy4h37708fZaVtLhDzJxM0TFUqcnItvWjLzwhvYA=;
        b=l5GDaYhLE/BUJYsukbNbMI/sALGTVP6ekwpUQjKob9N7w9/oJmXfig4ul/ZXz/xhElZhSk
        CEBCH2N05JUgFHYZlXyFI+BWtWzNVcjDcXp0usve/+MBb6DYyVSztaYxkloHyyxpwWIXKq
        jbm0wwppf1hTq09xxeUfLaBaFPDxUek=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 06BCB13B9E;
        Fri, 10 Dec 2021 23:12:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9ZGIOuTes2EaBgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Fri, 10 Dec 2021 23:12:36 +0000
Date:   Sat, 11 Dec 2021 00:12:35 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jim Newsome <jnewsome@torproject.org>,
        Alexey Gladkov <legion@kernel.org>, Tejun Heo <tj@kernel.org>,
        security@kernel.org, Andy Lutomirski <luto@amacapital.net>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH] exit: Retain nsproxy for exit_task_work() work entries
Message-ID: <YbPe4+K+RlDgccIh@blackbook>
References: <20211208180501.11969-1-mkoutny@suse.com>
 <87sfv3540t.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sfv3540t.fsf@email.froward.int.ebiederm.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2021 at 12:45:54PM -0600, "Eric W. Biederman" <ebiederm@xmission.com> wrote:
> TL;DR the cgroup file system is checking permissions at write time.

Thank you for bringing that up (handled in a separate thread now).

> I think I follow your reasoning and I think it will even fix the issue
> but no.

FTR, part of Tejun's series [1] ensures that cgroup_ns is accessed
directly without nsproxy and a reference to it is kept while the file
is opened. I.e. that'd properly fix this particular crash reported by
syzbot.

> Please don't apply this patch.
> 
> exit_task_work running after exit_task_namespaces is the messenger
> that just told us about something ugly.

In (my) theory some other task_work callbacks could (transitively) rely
on the current->nsproxy which could still be cleared by
exit_task_namespaces().
Is there another reason why to have exit_task_namespaces() before
exit_task_work()?

Thanks,
Michal

[1] https://lore.kernel.org/r/20211209214707.805617-4-tj@kernel.org/

