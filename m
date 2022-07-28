Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A24583B03
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 11:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235340AbiG1JMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 05:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233460AbiG1JMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 05:12:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9444D5721A
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 02:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658999553;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9F6VJGBL/RpKKy/PN50EiRiseaduTSEinNeawM21lUI=;
        b=cdNIr6WwHEdeTLD3HIzNG/j7yl6q2M3b4ZaUeTyeWOwyxBYI++YhBjMW+HbMrqFVVLSgix
        qkV2VHJK0hMaEGmhpbly8YILyzy4npjBflR761MjhyV3Pmz4VlIqpsOO6b+cD1GSGv4l21
        0QwwNoqPDfz32NXXA4xh1GKX8d4M9T0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-326-8v4UYBOzOBiG_1VX1k_Hng-1; Thu, 28 Jul 2022 05:12:24 -0400
X-MC-Unique: 8v4UYBOzOBiG_1VX1k_Hng-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 01C2C101A54E;
        Thu, 28 Jul 2022 09:12:24 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.194.81])
        by smtp.corp.redhat.com (Postfix) with SMTP id A4A172026D64;
        Thu, 28 Jul 2022 09:12:22 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 28 Jul 2022 11:12:23 +0200 (CEST)
Date:   Thu, 28 Jul 2022 11:12:20 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Tycho Andersen <tycho@tycho.pizza>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: __fatal_signal_pending() should also check
 PF_EXITING
Message-ID: <20220728091220.GA11207@redhat.com>
References: <Ys2PwTS0qFmGNFqy@netflix>
 <20220713175305.1327649-1-tycho@tycho.pizza>
 <20220720150328.GA30749@mail.hallyn.com>
 <YthsgqAZYnwHZLn+@tycho.pizza>
 <20220721015459.GA4297@mail.hallyn.com>
 <YuFdUj5X4qckC/6g@tycho.pizza>
 <20220727175538.GC18822@redhat.com>
 <YuGBXnqb5rPwAlYk@tycho.pizza>
 <20220727191949.GD18822@redhat.com>
 <YuGUyayVWDB7R89i@tycho.pizza>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YuGUyayVWDB7R89i@tycho.pizza>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/27, Tycho Andersen wrote:
>
> On Wed, Jul 27, 2022 at 09:19:50PM +0200, Oleg Nesterov wrote:
> >
> > Sorry, I still do not follow. Again, I can easily miss something. But how
> > can ANY change in __fatal_signal_pending() ensure that SIGKILL will wakeup
> > a PF_EXITING task which already sleeps in TASK_KILLABLE state? or even set
> > TIF_SIGPENDING as the changelog states?
>
> __fatal_signal_pending() just checks the non-shared set:
>
>     sigismember(&p->pending.signal, SIGKILL)
>
> When init in a pid namespace dies, it calls zap_pid_ns_processes(),
> which does:
>
>     group_send_sig_info(SIGKILL, SEND_SIG_PRIV, task, PIDTYPE_MAX);
>
> that eventually gets to __send_signal_locked() which does:
>
>     pending = (type != PIDTYPE_PID) ? &t->signal->shared_pending : &t->pending;
>
> i.e. it decides to put the signal in the shared set, instead of the individual
> set. If we change __fatal_signal_pending() to look in the shared set too, it
> will exit all the wait code in this case.

This is clear, but it seems you do not understand me. Let me try again
to explain and please correct me if I am wrong.

To simplify, lets suppose we have a single-thread task T which simply
does
	__set_current_state(TASK_KILLABLE);
	schedule();

in the do_exit() paths after exit_signals() which sets PF_EXITING. Btw,
note that it even documents that this thread is not "visible" for the
group-wide signals, see below.

Now, suppose that this task is running and you send SIGKILL. T will
dequeue SIGKILL from T->penging and call do_exit(). However, it won't
remove SIGKILL from T->signal.shared_pending(), and this means that
signal_pending(T) is still true.

Now. If we add a PF_EXITING or sigismember(shared_pending, SIGKILL) check
into __fatal_signal_pending(), then yes, T won't block in schedule(),
schedule()->signal_pending_state() will return true.

But what if T exits on its own? It will block in schedule() forever.
schedule()->signal_pending_state() will not even check __fatal_signal_pending(),
signal_pending() == F.

Now if you send SIGKILL to this task, SIGKILL won't wake it up or even
set TIF_SIGPENDING, complete_signal() will do nothing.

See?

I agree, we should probably cleanup this logic and define how exactly
the exiting task should react to signals (not only fatal signals). But
your patch certainly doesn't look good to me and it is not enough.
May be we can change get_signal() to not remove SIGKILL from t->pending
for the start... not sure, this needs another discussion.


Finally. if fuse_flush() wants __fatal_signal_pending() == T when the
caller exits, perhaps it can do it itself? Something like

	if (current->flags & PF_EXITING) {
		spin_lock_irq(siglock);
		set_thread_flag(TIF_SIGPENDING);
		sigaddset(&current->pending.signal, SIGKILL);
		spin_unlock_irq(siglock);
	}

Sure, this is ugly as hell. But perhaps this can serve as a workaround?

Oleg.

