Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3DEE46ED49
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 17:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241240AbhLIQnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 11:43:16 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:39496 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237594AbhLIQnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 11:43:15 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 23176210FF;
        Thu,  9 Dec 2021 16:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1639067981; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p7GhXJY+YdqPvBVPH+smGRiXYS6mmuG3rbYEN3ZJfHQ=;
        b=iEVc7pYRO92tgsMX43J2ZftDpL5U5GRvU+o6i6PNiL8akFbpgzU2QQFHhnV2Lm6n/ittSM
        bfO5PdOo58HeFv1ldNITnofeUFpDz5fKZC1YCZPUZfLxVBwv3mB4BKuXhOf8r2O83FfAfK
        WnhEhdS5qYavCuva+oMxwsmg0MV+dfs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E46C713D18;
        Thu,  9 Dec 2021 16:39:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MjQ0N0wxsmErZQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Thu, 09 Dec 2021 16:39:40 +0000
Date:   Thu, 9 Dec 2021 17:39:38 +0100
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
Message-ID: <20211209163938.GD63648@blackbody.suse.cz>
References: <20211208180501.11969-1-mkoutny@suse.com>
 <87sfv3540t.fsf@email.froward.int.ebiederm.org>
 <YbECHjMLPEHO0vqA@slm.duckdns.org>
 <CAHk-=wjcWEYSEVKvowUA0yEeDM279Zg-ptM_SsCMxmRSPJHjAw@mail.gmail.com>
 <YbEMPal0sKkk0+Tl@slm.duckdns.org>
 <YbE6yvMav5Xtp5HO@slm.duckdns.org>
 <20211209134419.GA17186@blackbody.suse.cz>
 <20211209140826.kc2xvvwxrdrwmrtj@wittgenstein>
 <20211209144700.GC63648@blackbody.suse.cz>
 <20211209150655.zqm77gmteu436xvb@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209150655.zqm77gmteu436xvb@wittgenstein>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021 at 04:06:55PM +0100, Christian Brauner <christian.brauner@ubuntu.com> wrote:
> That was discussed and is intentional and is supposed to mirror the
> behavior of cgroup.freeze. Delegated killing was supposed to work and
> was one use-case.

Thanks for the clarification.

The cgroup_kill() doesn't need the override_creds() treating then
(clearing my previous wondering).


Michal
