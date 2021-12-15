Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC18F475832
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 12:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242214AbhLOLwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 06:52:46 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:62438 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236958AbhLOLwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 06:52:45 -0500
Received: from fsav312.sakura.ne.jp (fsav312.sakura.ne.jp [153.120.85.143])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 1BFBqh06074482;
        Wed, 15 Dec 2021 20:52:43 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav312.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav312.sakura.ne.jp);
 Wed, 15 Dec 2021 20:52:43 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav312.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 1BFBqhuR074407
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 15 Dec 2021 20:52:43 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-ID: <40de8b7e-a3be-4486-4e33-1b1d1da452f8@i-love.sakura.ne.jp>
Date:   Wed, 15 Dec 2021 20:52:40 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: [PATCH (resend)] tty: n_hdlc: make n_hdlc_tty_wakeup() asynchronous
Content-Language: en-US
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzbot+5f47a8cea6a12b77a876@syzkaller.appspotmail.com,
        Marco Elver <elver@google.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        David Sterba <dsterba@suse.com>,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        nick black <dankamongmen@gmail.com>,
        Igor Matheus Andrade Torrente <igormtorrente@gmail.com>
References: <20211116144937.19035-1-fmdefrancesco@gmail.com>
 <e2f074e2-b19e-da5b-9db9-c0b4142de618@i-love.sakura.ne.jp>
 <CAHk-=winHP_cXTJvJzeudgq-xCnWQPmVp0_O6wT9nFsFNQYrkQ@mail.gmail.com>
 <c9c18419-ff32-6c87-195a-923ebb28c466@i-love.sakura.ne.jp>
In-Reply-To: <c9c18419-ff32-6c87-195a-923ebb28c466@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot is reporting that an unprivileged user who logged in from tty
console can crash the system using a reproducer shown below [1], for
n_hdlc_tty_wakeup() is synchronously calling n_hdlc_send_frames().

----------
  #include <sys/ioctl.h>
  #include <unistd.h>

  int main(int argc, char *argv[])
  {
    const int disc = 0xd;

    ioctl(1, TIOCSETD, &disc);
    while (1) {
      ioctl(1, TCXONC, 0);
      write(1, "", 1);
      ioctl(1, TCXONC, 1); /* Kernel panic - not syncing: scheduling while atomic */
    }
  }
----------

Linus suspected that "struct tty_ldisc"->ops->write_wakeup() must not
sleep, and Jiri confirmed it from include/linux/tty_ldisc.h. Thus, defer
n_hdlc_send_frames() from n_hdlc_tty_wakeup() to a WQ context like
net/nfc/nci/uart.c does.

Link: https://syzkaller.appspot.com/bug?extid=5f47a8cea6a12b77a876 [1]
Reported-by: syzbot <syzbot+5f47a8cea6a12b77a876@syzkaller.appspotmail.com>
Analyzed-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Confirmed-by: Jiri Slaby <jirislaby@kernel.org>
Reviewed-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 drivers/tty/n_hdlc.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/n_hdlc.c b/drivers/tty/n_hdlc.c
index 7e0884ecc74f..23ba1fc99df8 100644
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
@@ -154,6 +156,7 @@ static struct n_hdlc_buf *n_hdlc_buf_get(struct n_hdlc_buf_list *list);
 /* Local functions */
 
 static struct n_hdlc *n_hdlc_alloc(void);
+static void n_hdlc_tty_write_work(struct work_struct *work);
 
 /* max frame size for memory allocations */
 static int maxframe = 4096;
@@ -210,6 +213,8 @@ static void n_hdlc_tty_close(struct tty_struct *tty)
 	wake_up_interruptible(&tty->read_wait);
 	wake_up_interruptible(&tty->write_wait);
 
+	cancel_work_sync(&n_hdlc->write_work);
+
 	n_hdlc_free_buf_list(&n_hdlc->rx_free_buf_list);
 	n_hdlc_free_buf_list(&n_hdlc->tx_free_buf_list);
 	n_hdlc_free_buf_list(&n_hdlc->rx_buf_list);
@@ -241,6 +246,8 @@ static int n_hdlc_tty_open(struct tty_struct *tty)
 		return -ENFILE;
 	}
 
+	INIT_WORK(&n_hdlc->write_work, n_hdlc_tty_write_work);
+	n_hdlc->tty_for_write_work = tty;
 	tty->disc_data = n_hdlc;
 	tty->receive_room = 65536;
 
@@ -334,6 +341,20 @@ static void n_hdlc_send_frames(struct n_hdlc *n_hdlc, struct tty_struct *tty)
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
@@ -344,7 +365,7 @@ static void n_hdlc_tty_wakeup(struct tty_struct *tty)
 {
 	struct n_hdlc *n_hdlc = tty->disc_data;
 
-	n_hdlc_send_frames(n_hdlc, tty);
+	schedule_work(&n_hdlc->write_work);
 }	/* end of n_hdlc_tty_wakeup() */
 
 /**
-- 
2.18.4



