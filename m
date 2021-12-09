Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 761D946EAA4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 16:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234314AbhLIPKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 10:10:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232856AbhLIPKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 10:10:40 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6D2C061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 07:07:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 55BB8CE2644
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 15:07:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55438C004DD;
        Thu,  9 Dec 2021 15:06:58 +0000 (UTC)
Date:   Thu, 9 Dec 2021 16:06:55 +0100
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
Message-ID: <20211209150655.zqm77gmteu436xvb@wittgenstein>
References: <20211208180501.11969-1-mkoutny@suse.com>
 <87sfv3540t.fsf@email.froward.int.ebiederm.org>
 <YbECHjMLPEHO0vqA@slm.duckdns.org>
 <CAHk-=wjcWEYSEVKvowUA0yEeDM279Zg-ptM_SsCMxmRSPJHjAw@mail.gmail.com>
 <YbEMPal0sKkk0+Tl@slm.duckdns.org>
 <YbE6yvMav5Xtp5HO@slm.duckdns.org>
 <20211209134419.GA17186@blackbody.suse.cz>
 <20211209140826.kc2xvvwxrdrwmrtj@wittgenstein>
 <20211209144700.GC63648@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211209144700.GC63648@blackbody.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021 at 03:47:00PM +0100, Michal Koutný wrote:
> On Thu, Dec 09, 2021 at 03:08:26PM +0100, Christian Brauner <christian.brauner@ubuntu.com> wrote:
> > send_sig() isn't used that was changed in response to a review. I'm
> > confused. 
> 
> Sorry for ambiguity, I meant this instance [1].

Sure, seems good.

> 
> > Kill and freeze only do time permission checking at open. Why would you
> > introduce another write time check?
>  
> Let's have a cgroup G with tasks t1,...,tn (run by user u) and some
> monitoring tasks m1,...,mk belonging to a different user v != u.
> 
> Currently u can kill also the tasks of v -- I'm not sure if that's
> intentional. My argument would apply if it wasn't -- it'd be suscebtible

That was discussed and is intentional and is supposed to mirror the
behavior of cgroup.freeze. Delegated killing was supposed to work and
was one use-case.
