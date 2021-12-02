Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5279B4666E2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 16:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbhLBPog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 10:44:36 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:53780 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236763AbhLBPod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 10:44:33 -0500
Received: from fsav116.sakura.ne.jp (fsav116.sakura.ne.jp [27.133.134.243])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 1B2Fehdv081167;
        Fri, 3 Dec 2021 00:40:43 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav116.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp);
 Fri, 03 Dec 2021 00:40:43 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 1B2FegMg081151
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 3 Dec 2021 00:40:43 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-ID: <86452127-70e8-c0cf-de18-6f98e77849a6@i-love.sakura.ne.jp>
Date:   Fri, 3 Dec 2021 00:40:42 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] tty: vt: make do_con_write() no-op if IRQ is disabled
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Hurley <peter@hurleysoftware.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20211116144937.19035-1-fmdefrancesco@gmail.com>
 <1825634.Qa45DEmgBM@localhost.localdomain>
 <44d83e9c-d8c9-38bf-501c-019b8c2f7b5e@i-love.sakura.ne.jp>
 <1701119.OD4kndUEs1@localhost.localdomain>
 <1d05e95c-556a-a34c-99fd-8c542311e2dd@i-love.sakura.ne.jp>
 <3add7ade-9c9b-2839-5a0c-0a38c4be0e34@i-love.sakura.ne.jp>
 <CAHk-=wjVL_CLm-+=7qf2obF6f8D+ujysmqp5dKdAb7UEyo1cZg@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
In-Reply-To: <CAHk-=wjVL_CLm-+=7qf2obF6f8D+ujysmqp5dKdAb7UEyo1cZg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/12/02 4:05, Linus Torvalds wrote:
> On Wed, Dec 1, 2021 at 5:41 AM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>
>> What do you think? Can we apply this?
> 
> I think this patch is only papering over the problem, and the issue goes deeper.

I know. After this "stop bleeding" patch, I am planning to propose a patch for
fixing a regression introduced by commit f9e053dcfc02b0ad ("tty: Serialize
tty flow control changes with flow_lock"), something like shown below.

 drivers/tty/tty.h       |  2 --
 drivers/tty/tty_io.c    | 41 ++++++++++++++++++++---------------------
 drivers/tty/tty_ioctl.c | 15 +++++++++------
 3 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/drivers/tty/tty.h b/drivers/tty/tty.h
index b710c5ef89ab..b19460dca58b 100644
--- a/drivers/tty/tty.h
+++ b/drivers/tty/tty.h
@@ -60,8 +60,6 @@ void tty_ldisc_unlock(struct tty_struct *tty);
 
 int __tty_check_change(struct tty_struct *tty, int sig);
 int tty_check_change(struct tty_struct *tty);
-void __stop_tty(struct tty_struct *tty);
-void __start_tty(struct tty_struct *tty);
 void tty_vhangup_session(struct tty_struct *tty);
 void tty_open_proc_set_tty(struct file *filp, struct tty_struct *tty);
 int tty_signal_session_leader(struct tty_struct *tty, int exit_session);
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 6616d4a0d41d..84f4296eefed 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -761,15 +761,6 @@ int tty_hung_up_p(struct file *filp)
 }
 EXPORT_SYMBOL(tty_hung_up_p);
 
-void __stop_tty(struct tty_struct *tty)
-{
-	if (tty->flow.stopped)
-		return;
-	tty->flow.stopped = true;
-	if (tty->ops->stop)
-		tty->ops->stop(tty);
-}
-
 /**
  *	stop_tty	-	propagate flow control
  *	@tty: tty to stop
@@ -791,21 +782,15 @@ void stop_tty(struct tty_struct *tty)
 	unsigned long flags;
 
 	spin_lock_irqsave(&tty->flow.lock, flags);
-	__stop_tty(tty);
+	if (!tty->flow.stopped) {
+		tty->flow.stopped = true;
+		if (tty->ops->stop)
+			tty->ops->stop(tty);
+	}
 	spin_unlock_irqrestore(&tty->flow.lock, flags);
 }
 EXPORT_SYMBOL(stop_tty);
 
-void __start_tty(struct tty_struct *tty)
-{
-	if (!tty->flow.stopped || tty->flow.tco_stopped)
-		return;
-	tty->flow.stopped = false;
-	if (tty->ops->start)
-		tty->ops->start(tty);
-	tty_wakeup(tty);
-}
-
 /**
  *	start_tty	-	propagate flow control
  *	@tty: tty to start
@@ -821,8 +806,22 @@ void start_tty(struct tty_struct *tty)
 {
 	unsigned long flags;
 
+	/*
+	 * do_con_write() from tty_wakeup() needs to sleep. But I'm not sure
+	 * whether all callers are allowed to sleep, for stop_tty() says that
+	 * callers might not be allowed to sleep...
+	 */
+	might_sleep();
+
 	spin_lock_irqsave(&tty->flow.lock, flags);
-	__start_tty(tty);
+	if (tty->flow.stopped && !tty->flow.tco_stopped) {
+		spin_unlock_irqrestore(&tty->flow.lock, flags);
+		if (tty->ops->start)
+			tty->ops->start(tty);
+		tty_wakeup(tty);
+		spin_lock_irqsave(&tty->flow.lock, flags);
+		tty->flow.stopped = false;
+	}
 	spin_unlock_irqrestore(&tty->flow.lock, flags);
 }
 EXPORT_SYMBOL(start_tty);
diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
index 63181925ec1a..84c0742efd34 100644
--- a/drivers/tty/tty_ioctl.c
+++ b/drivers/tty/tty_ioctl.c
@@ -857,6 +857,7 @@ EXPORT_SYMBOL_GPL(tty_perform_flush);
 int n_tty_ioctl_helper(struct tty_struct *tty, unsigned int cmd,
 		unsigned long arg)
 {
+	static DEFINE_MUTEX(tty_tco_mutex);
 	int retval;
 
 	switch (cmd) {
@@ -866,20 +867,22 @@ int n_tty_ioctl_helper(struct tty_struct *tty, unsigned int cmd,
 			return retval;
 		switch (arg) {
 		case TCOOFF:
-			spin_lock_irq(&tty->flow.lock);
+			if (mutex_lock_killable(&tty_tco_mutex))
+				return -EINTR;
 			if (!tty->flow.tco_stopped) {
 				tty->flow.tco_stopped = true;
-				__stop_tty(tty);
+				stop_tty(tty);
 			}
-			spin_unlock_irq(&tty->flow.lock);
+			mutex_unlock(&tty_tco_mutex);
 			break;
 		case TCOON:
-			spin_lock_irq(&tty->flow.lock);
+			if (mutex_lock_killable(&tty_tco_mutex))
+				return -EINTR;
 			if (tty->flow.tco_stopped) {
 				tty->flow.tco_stopped = false;
-				__start_tty(tty);
+				start_tty(tty);
 			}
-			spin_unlock_irq(&tty->flow.lock);
+			mutex_unlock(&tty_tco_mutex);
 			break;
 		case TCIOFF:
 			if (STOP_CHAR(tty) != __DISABLED_CHAR)

I think that since tty->flow.tco_stopped is updated by only ioctl(TCXONC)
which is schedulable context, we can serialize using a mutex. Then, as
long as start_tty() can be called from schedulable context, we can allow
do_con_write() to work.

> 
> It may be that "papering over the issue" successfully hides it
> completely, but it's still a horribly bad approach.
> 
>>> -     if (in_interrupt())
>>> +     if (in_interrupt() || irqs_disabled())
>>>               return count;
> 
> This kind of stuff is broken. Pretty much always.
> 
> And in this case, it's still broken, because things like "called under
> a non-irq spinlock" would still not show up.

As far as I'm aware, the commit did not introduce "called under a non-irq
spinlock" case.

> 
> And no, I do *not* mean that the code should try to figure that out. I
> mean that the problem goes further up, and that the fact that we get
> to do_con_write() in the first place when we're in an invalid context
> is wrong, wrong, wrong.
> 
> How the heck do we get here from just an ioctl?

Just an ioctl, but the commit made it to get inside spin_lock_irqsave()
section when tty_wakeup() is called.

> 
> Looking at the backtrace, I see
> 
>    n_hdlc_send_frames+0x24b/0x490 drivers/tty/n_hdlc.c:290
>    tty_wakeup+0xe1/0x120 drivers/tty/tty_io.c:534
>    __start_tty drivers/tty/tty_io.c:806 [inline]
>    __start_tty+0xfb/0x130 drivers/tty/tty_io.c:799
> 
> and apparently it's that hdlc line discipline (and
> n_hdlc_send_frames() in particular) that is the problem here.
> 
> I think that's where the fix should be.

Do you mean that we should change the behavior of n_hdlc_send_frames()
rather than trying to make __start_tty() schedulable again?

Then, n_hdlc_send_frames() saying "this function is called after adding
a frame to the send buffer list and by the tty wakeup callback." but
expecting tty->ops->write (which is do_con_write() which needs to sleep)
not to sleep is wrong?

Then, what we can do with n_hdlc_send_frames() ?
Make n_hdlc_send_frames() no-op when called from atomic context?

