Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D34E46E905
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 14:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237874AbhLINWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 08:22:20 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:62958 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238013AbhLINWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 08:22:14 -0500
Received: from fsav412.sakura.ne.jp (fsav412.sakura.ne.jp [133.242.250.111])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 1B9DIbJ4030368;
        Thu, 9 Dec 2021 22:18:37 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav412.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav412.sakura.ne.jp);
 Thu, 09 Dec 2021 22:18:37 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav412.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 1B9DIbEe030339
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 9 Dec 2021 22:18:37 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-ID: <c9c18419-ff32-6c87-195a-923ebb28c466@i-love.sakura.ne.jp>
Date:   Thu, 9 Dec 2021 22:18:36 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] tty: n_hdlc: make n_hdlc_tty_wakeup() asynchronous
Content-Language: en-US
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
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
In-Reply-To: <CAHk-=winHP_cXTJvJzeudgq-xCnWQPmVp0_O6wT9nFsFNQYrkQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/12/07 3:07, Linus Torvalds wrote:
> On Mon, Dec 6, 2021 at 3:45 AM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>
>> Linus suspected that "struct tty_ldisc"->ops->write_wakeup() must not
>> sleep, and Jiri confirmed it from include/linux/tty_ldisc.h. Thus, defer
>> n_hdlc_send_frames() from n_hdlc_tty_wakeup() to a WQ context like
>> net/nfc/nci/uart.c does.
> 
> Thanks, this looks good to me.
> 
> That said, I think there's pretty much the *exact* same pattern in
> 
>     drivers/net/caif/caif_serial.c:
>         write_wakeup() causes "handle_tx()", which then calls tty->ops->write().
> 
>     drivers/net/hamradio/mkiss.c
>         mkiss_write_wakeup() -> tty->ops->write()
> 
>     drivers/tty/n_gsm.c:
>         gsmld_write_wakeup -> gsm_data_kick() -> gsmld_output ->
> gsm->tty->ops->write()
> 
> so this does seem to be a common bug pattern for code that has never
> really seen a lot of testing.

Indeed.

> 
> The core tty stuff seems to get it right, but maybe I missed something
> in my quick "grep and look for patterns".

handle_tx() in caif_serial.c has a line

  /* skb_peek is safe because handle_tx is called after skb_queue_tail */

and I think that this comment is true only when handle_tx() is called from
"struct net_device_ops"->ndo_start_xmit (== caif_xmit()). If handle_tx() is
called from "struct tty_ldisc_ops"->write_wakeup (== ldisc_tx_wakeup()),
handle_tx() might be called before skb_queue_tail() is called?

> 
> So I think this patch is good, but I do wonder if perhaps we should
> move the "work_struct" into the tty layer itself, and do the whole
> "schedule_work()" at that level.

I don't know about net_device_ops, but from synchronization point of view,

  ser = tty->disc_data;
  BUG_ON(ser == NULL);
  WARN_ON(ser->tty != tty);

in ldisc_tx_wakeup() makes me feel uneasy, and I can't expect that ldisc_tx_wakeup()
will do safe synchronization by moving the "work_struct" into the tty layer itself.
That is, I think we somehow need to fix caif_serial.c after all.

> 
> Some code never wants it (most notably the regular n_tty one), but at
> least n_tty doesn't really care, I suspect. n_tty is using
> write_wakeup() literally just for fasync handling, so I suspect it's
> not exactly going to be performance-critical.
> 
> Of course, maybe the fix is to just fix caif_serial/mkiss and n_gsm.
> Or mark them broken - does anybody use them?

I think that fixing individual driver sounds safer choice.

