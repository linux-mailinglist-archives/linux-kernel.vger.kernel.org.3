Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C53FD467771
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 13:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380829AbhLCMgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 07:36:02 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:59363 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232849AbhLCMgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 07:36:01 -0500
Received: from fsav313.sakura.ne.jp (fsav313.sakura.ne.jp [153.120.85.144])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 1B3CWL5T024359;
        Fri, 3 Dec 2021 21:32:21 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav313.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp);
 Fri, 03 Dec 2021 21:32:21 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 1B3CWK8G024353
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 3 Dec 2021 21:32:21 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-ID: <5d055fbd-e94a-fe54-d3e0-982dc455ed1a@i-love.sakura.ne.jp>
Date:   Fri, 3 Dec 2021 21:32:21 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] tty: vt: make do_con_write() no-op if IRQ is disabled
Content-Language: en-US
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Hurley <peter@hurleysoftware.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20211116144937.19035-1-fmdefrancesco@gmail.com>
 <86452127-70e8-c0cf-de18-6f98e77849a6@i-love.sakura.ne.jp>
 <CAHk-=wiXNJ86W=gwAHH1qd+cE9dmfk_dEKFmNa89XH19NhPNkg@mail.gmail.com>
 <3017492.JFOoIcAZ2s@localhost.localdomain>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
In-Reply-To: <3017492.JFOoIcAZ2s@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/12/03 20:00, Fabio M. De Francesco wrote:
> On Thursday, December 2, 2021 7:35:16 PM CET Linus Torvalds wrote:
>> On Thu, Dec 2, 2021 at 7:41 AM Tetsuo Handa
>> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>>
>>>> Looking at the backtrace, I see
>>>>
>>>>    n_hdlc_send_frames+0x24b/0x490 drivers/tty/n_hdlc.c:290
>>>>    tty_wakeup+0xe1/0x120 drivers/tty/tty_io.c:534
>>>>    __start_tty drivers/tty/tty_io.c:806 [inline]
>>>>    __start_tty+0xfb/0x130 drivers/tty/tty_io.c:799
>>>>
>>>> and apparently it's that hdlc line discipline (and
>>>> n_hdlc_send_frames() in particular) that is the problem here.
>>>>
>>>> I think that's where the fix should be.
>>>
>>> Do you mean that we should change the behavior of n_hdlc_send_frames()
>>> rather than trying to make __start_tty() schedulable again?
>>
>> I wouldn't change n_hdlc_send_frames() itself. It does what it says it does.
>>
>> But n_hdlc_tty_wakeup() probably shouldn't call it directly. Other tty
>> line disciplines don't do that kind of thing - although I only looked
>> at a couple. They all seem to just set bits and prepare things. Like a
>> wakeup function should do.
>>
>> So I think n_hdlc_tty_wakeup() should perhaps only do a
>> "schedule_work()" or similar to get that n_hdlc_send_frames() started,
>> rather than doing it itself.
>>
>> Example: net/nfc/nci/uart.c. It does that
>>
>>         schedule_work(&nu->write_work);
>>
>> instead of actually trying to do a write from a wakeup routine
>> (similar examples in ppp - "tasklet_schedule(&ap->tsk)" etc).
>>
>> I mean, it's called "wakeup", not "write". So I think the fundamental
>> confusion here is in hdlc, not the tty layer.
>>
>>               Linus
>>

OK.

> This is what I understand from the above argument: do a schedule_work() to get 
> that n_hdlc_send_frames() started; in this way, n_hdlc_tty_wakeup() can
> return to the caller and n_hdlc_send_frames() is executed asynchronously 
> (i.e., no longer in an atomic context). 

Yes. If we copy how net/nfc/nci/uart.c does, the fix would look like:

--------------------
 drivers/tty/n_hdlc.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/n_hdlc.c b/drivers/tty/n_hdlc.c
index 7e0884ecc74f..a71fcac60925 100644
--- a/drivers/tty/n_hdlc.c
+++ b/drivers/tty/n_hdlc.c
@@ -140,6 +140,8 @@ struct n_hdlc {
 	struct n_hdlc_buf_list	rx_buf_list;
 	struct n_hdlc_buf_list	tx_free_buf_list;
 	struct n_hdlc_buf_list	rx_free_buf_list;
+	struct work_struct	write_work;
+	struct tty_struct	*tty_for_write_work;
 };
 
 /*
@@ -210,6 +212,8 @@ static void n_hdlc_tty_close(struct tty_struct *tty)
 	wake_up_interruptible(&tty->read_wait);
 	wake_up_interruptible(&tty->write_wait);
 
+	cancel_work_sync(&n_hdlc->write_work);
+
 	n_hdlc_free_buf_list(&n_hdlc->rx_free_buf_list);
 	n_hdlc_free_buf_list(&n_hdlc->tx_free_buf_list);
 	n_hdlc_free_buf_list(&n_hdlc->rx_buf_list);
@@ -334,6 +338,20 @@ static void n_hdlc_send_frames(struct n_hdlc *n_hdlc, struct tty_struct *tty)
 		goto check_again;
 }	/* end of n_hdlc_send_frames() */
 
+/**
+ * n_hdlc_tty_write_work - Asynchronous callback for transmit wakeup
+ * @work: pointer to work_struct
+ *
+ * Called when low level device driver can accept more send data.
+ */
+static void n_hdlc_tty_write_work(struct work_struct *work)
+{
+	struct n_hdlc *n_hdlc = container_of(work, struct n_hdlc, write_work);
+	struct tty_struct *tty = n_hdlc->tty_for_write_work;
+
+	n_hdlc_send_frames(n_hdlc, tty);
+}	/* end of n_hdlc_tty_write_work() */
+
 /**
  * n_hdlc_tty_wakeup - Callback for transmit wakeup
  * @tty: pointer to associated tty instance data
@@ -344,7 +362,8 @@ static void n_hdlc_tty_wakeup(struct tty_struct *tty)
 {
 	struct n_hdlc *n_hdlc = tty->disc_data;
 
-	n_hdlc_send_frames(n_hdlc, tty);
+	n_hdlc->tty_for_write_work = tty;
+	schedule_work(&n_hdlc->write_work);
 }	/* end of n_hdlc_tty_wakeup() */
 
 /**
@@ -706,6 +725,7 @@ static struct n_hdlc *n_hdlc_alloc(void)
 	if (!n_hdlc)
 		return NULL;
 
+	INIT_WORK(&n_hdlc->write_work, n_hdlc_tty_write_work);
 	spin_lock_init(&n_hdlc->rx_free_buf_list.spinlock);
 	spin_lock_init(&n_hdlc->tx_free_buf_list.spinlock);
 	spin_lock_init(&n_hdlc->rx_buf_list.spinlock);
--------------------

> 
> I hope that I'm not missing something. If the above summary is correct, 
> please forgive a newbie for the following questions... 
> 
> Commit f9e053dcfc02 ("tty: Serialize tty flow control changes with flow_lock") 
> has introduced spinlocks to serialize flow control changes and avoid the 
> concurrent executions of __start_tty() and __stop_tty().
> 
> This is an excerpt from the above-mentioned commit:
> 
> ->
>     Introduce tty->flow_lock spinlock to serialize tty flow control changes.
>     Split out unlocked __start_tty()/__stop_tty() flavors for use by
>     ioctl(TCXONC) in follow-on patch.
> <-
> 
> This is the reason why we are dealing with this bug. Currently we have __start_tty() 
> called with an acquired spinlock and IRQs disabled and the calls chain leads to 
> console_lock() while in atomic context.

If we hit a race window described in that commit

    CPU 0                          | CPU 1
    stop_tty()                     |
      lock ctrl_lock               |
      tty->stopped = 1             |
      unlock ctrl_lock             |
                                   | start_tty()
                                   |   lock ctrl_lock
                                   |   tty->stopped = 0
                                   |   unlock ctrl_lock
                                   |   driver->start()
      driver->stop()               |

    In this case, the flow control state now indicates the tty has
    been started, but the actual hardware state has actually been stopped.

, the tty->stopped flag remains 0 despite driver->stop() is called after
driver->start() finished. tty->stopped (the flow control state) says "not stopped"
but the actual hardware state is "stopped".

> 
> In summation, my questions are... 
> 
> 1) Why do we still need to protect __start_tty() and __stop_tty() with spin_lock_irq() 
> if the solution to the bug is to execute n_hdlc_send_frames() asynchronously?

Without serialization, tty->stopped flag and the actual hardware state can mismatch.

> 
> 2) If it is true that we need to avoid concurrent executions of __start_tty() and 
> __stop_tty(), can we just use a Mutex in the IOCTL's helper?

Yes if all __start_tty() and __stop_tty() callers were schedulable context.
But stop_tty() says that stop_tty() might be called from atomic context.
Thus, we can't use a mutex for protecting tty->stopped flag.

> 
> Thanks,
> 
> Fabio M. De Francesco

By the way, even with above patch, I think

    CPU 0                  | CPU 1                  |  CPU 2
    stop_tty()             |                        |
      lock flow.lock       |                        |
      tty->stopped = 1     |                        |
      driver->stop()       |                        |
      unlock flow.lock     |                        |
                           | start_tty()            |
                           |   lock flow.lock       |
                           |   tty->stopped = 0     |
                           |   driver->start() => Schedules n_hdlc_send_frames()
                           |   unlock flow.lock     |
    stop_tty()             |                        |
      lock flow.lock       |                        |
      tty->stopped = 1     |                        |
      driver->stop()       |                        |
      unlock flow.lock     |                        |
                           |                        | Starts n_hdlc_send_frames()

(that is, the n_hdlc is writing to consoles despite tty->stopped is 1) can happen
until n_hdlc_send_frames() completes.

Then, even scheduling next n_hdlc_send_frames() while previous n_hdlc_send_frames() is
possible? In the worst case, multiple CPUs can run n_hdlc_send_frames() concurrently?

    CPU 0                  | CPU 1                  |  CPU 2                 | CPU 3
    stop_tty()             |                        |                        |
      lock flow.lock       |                        |                        |
      tty->stopped = 1     |                        |                        |
      driver->stop()       |                        |                        |
      unlock flow.lock     |                        |                        |
                           | start_tty()            |                        |
                           |   lock flow.lock       |                        |
                           |   tty->stopped = 0     |                        |
                           |   driver->start() => Schedules n_hdlc_send_frames()
                           |   unlock flow.lock     |                        |
                           |                        | Starts n_hdlc_send_frames()
    stop_tty()             |                        |                        |
      lock flow.lock       |                        |                        |
      tty->stopped = 1     |                        |                        |
      driver->stop()       |                        |                        |
      unlock flow.lock     |                        |                        |
                           | start_tty()            |                        |
                           |   lock flow.lock       |                        |
                           |   tty->stopped = 0     |                        |
                           |   driver->start() => Schedules n_hdlc_send_frames()
                           |   unlock flow.lock     |                        |
                           |                        |                        | Starts n_hdlc_send_frames()

Ah, OK. n_hdlc->tbusy is there for serialization.

