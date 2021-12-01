Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A65E464EF1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 14:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349610AbhLANoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 08:44:23 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:64123 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349605AbhLANoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 08:44:22 -0500
Received: from fsav115.sakura.ne.jp (fsav115.sakura.ne.jp [27.133.134.242])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 1B1Deeou049719;
        Wed, 1 Dec 2021 22:40:40 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav115.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav115.sakura.ne.jp);
 Wed, 01 Dec 2021 22:40:40 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav115.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 1B1Ded1i049715
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 1 Dec 2021 22:40:40 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-ID: <3add7ade-9c9b-2839-5a0c-0a38c4be0e34@i-love.sakura.ne.jp>
Date:   Wed, 1 Dec 2021 22:40:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] tty: vt: make do_con_write() no-op if IRQ is disabled
Content-Language: en-US
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Hurley <peter@hurleysoftware.com>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20211116144937.19035-1-fmdefrancesco@gmail.com>
 <1825634.Qa45DEmgBM@localhost.localdomain>
 <44d83e9c-d8c9-38bf-501c-019b8c2f7b5e@i-love.sakura.ne.jp>
 <1701119.OD4kndUEs1@localhost.localdomain>
 <1d05e95c-556a-a34c-99fd-8c542311e2dd@i-love.sakura.ne.jp>
In-Reply-To: <1d05e95c-556a-a34c-99fd-8c542311e2dd@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

What do you think? Can we apply this?

On 2021/11/19 23:55, Tetsuo Handa wrote:
> syzbot is reporting that an unprivileged user who logged in from tty
> console can crash the system using a reproducer shown below [1], for
> commit f9e053dcfc02b0ad ("tty: Serialize tty flow control changes with
> flow_lock") changed __start_tty() from schedulable context to atomic
> context without realizing that drivers/tty/n_hdlc.c is calling
> do_con_write() (which waits for console semaphore) from __start_tty().
> 
> ----------
>   #include <sys/ioctl.h>
>   #include <unistd.h>
> 
>   int main(int argc, char *argv[])
>   {
>     const int disc = 0xd;
> 
>     ioctl(1, TIOCSETD, &disc);
>     while (1) {
>       ioctl(1, TCXONC, 0);
>       write(1, "", 1);
>       ioctl(1, TCXONC, 1); /* Kernel panic - not syncing: scheduling while atomic */
>     }
>   }
> ----------
> 
> While we would need to bring __start_tty() back to schedulable context
> in order to be able to call do_con_write() from ioctl(TCXONC, TCOON),
> changes required might be complicated; an oversight will result in a
> new sleep from atomic context bug or a new race window bug. Therefore,
> firstly let's fix crash problem by protecting do_con_write() side.
> 
> Link: https://syzkaller.appspot.com/bug?extid=5f47a8cea6a12b77a876 [1]
> Reported-by: syzbot <syzbot+5f47a8cea6a12b77a876@syzkaller.appspotmail.com>
> Analyzed-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Fixes: f9e053dcfc02b0ad ("tty: Serialize tty flow control changes with flow_lock")
> ---
>  drivers/tty/vt/vt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index 7359c3e80d63..efa16f51c978 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -2902,7 +2902,7 @@ static int do_con_write(struct tty_struct *tty, const unsigned char *buf, int co
>  	struct vt_notifier_param param;
>  	bool rescan;
>  
> -	if (in_interrupt())
> +	if (in_interrupt() || irqs_disabled())
>  		return count;
>  
>  	console_lock();
> @@ -3358,7 +3358,7 @@ static void con_flush_chars(struct tty_struct *tty)
>  {
>  	struct vc_data *vc;
>  
> -	if (in_interrupt())	/* from flush_to_ldisc */
> +	if (in_interrupt() || irqs_disabled())	/* from flush_to_ldisc */
>  		return;
>  
>  	/* if we race with con_close(), vt may be null */
> 

