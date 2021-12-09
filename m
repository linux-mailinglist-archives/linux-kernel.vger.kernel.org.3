Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B30046EA42
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 15:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238865AbhLIOuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 09:50:37 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:50460 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233886AbhLIOug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 09:50:36 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4349A210FD;
        Thu,  9 Dec 2021 14:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1639061222; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9bhsG0HdJu2F8HCyo58ar0T6wAwNDGjuDQlcjKNYeK8=;
        b=kKE9eipUJttdFD5Ll9pZ2/nYefSO2oppTJgxo1bD8IewH1dXrxl8Z1cGfxXN+nhml67ZYo
        jRAepBokF5Z1/sdLKPS97ccGcEKz+UK7WPdaTTCpqSxdrxrOVTcYt9EBJYpo5LDfrBrXkF
        0jkY3f0K0ywVm/+eyWPkLszTEkWUTG4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C09A113B2D;
        Thu,  9 Dec 2021 14:47:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dp/1LeUWsmGpLwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Thu, 09 Dec 2021 14:47:01 +0000
Date:   Thu, 9 Dec 2021 15:47:00 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
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
Message-ID: <20211209144700.GC63648@blackbody.suse.cz>
References: <20211208180501.11969-1-mkoutny@suse.com>
 <87sfv3540t.fsf@email.froward.int.ebiederm.org>
 <YbECHjMLPEHO0vqA@slm.duckdns.org>
 <CAHk-=wjcWEYSEVKvowUA0yEeDM279Zg-ptM_SsCMxmRSPJHjAw@mail.gmail.com>
 <YbEMPal0sKkk0+Tl@slm.duckdns.org>
 <YbE6yvMav5Xtp5HO@slm.duckdns.org>
 <20211209134419.GA17186@blackbody.suse.cz>
 <20211209140826.kc2xvvwxrdrwmrtj@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209140826.kc2xvvwxrdrwmrtj@wittgenstein>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021 at 03:08:26PM +0100, Christian Brauner <christian.brauner@ubuntu.com> wrote:
> send_sig() isn't used that was changed in response to a review. I'm
> confused. 

Sorry for ambiguity, I meant this instance [1].

> Kill and freeze only do time permission checking at open. Why would you
> introduce another write time check?
 
Let's have a cgroup G with tasks t1,...,tn (run by user u) and some
monitoring tasks m1,...,mk belonging to a different user v != u.

Currently u can kill also the tasks of v -- I'm not sure if that's
intentional. My argument would apply if it wasn't -- it'd be suscebtible
to similar abuse, i.e. passing the opened fd to a more privileged
process to kill also v's tasks. (But if the intention is to be able to
kill anyone in the cgroup, then it likely doesn't matter.)


Michal

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/cgroup/cgroup.c?h=v5.16-rc4#n3762
