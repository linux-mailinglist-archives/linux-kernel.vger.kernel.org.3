Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF99B46A559
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 20:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348242AbhLFTK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 14:10:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238807AbhLFTKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 14:10:25 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A511C061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 11:06:56 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id az34-20020a05600c602200b0033bf8662572so594664wmb.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 11:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xpzuJhxQB216KEfHHMCrEm4w3UWNMvbzaotwbEGxZeQ=;
        b=QbSM6wtJuM71CoMnZHyZtZmgHaqLfsYffOCABlSiMl3pB0kO8CA9S+nq/z6YY/rPa8
         AMmAfEfaYGfavzFMeiKYmLUE3qBPsa2XvvIjehoQexl2zr78o7m7YDMcG5kO8HXkeLmj
         H8JsfFB9tQQvSUfq1TioUsy/ab+4IG8fhAmRzbP7R6L+TQgwIq41iGs4Z+9EDa/+JuRk
         xXZLDHO4gjJbIZjYNcfF5RgEUBgI+ge6zpn3o6e7eld6MVDmjEzFn+X4CY6kAkJnONzM
         m2zjd7PlVrcHDL0c3OMkyL9gxKxrqpmNzvVlL9g8hBj7lQsfOfFlw3hLTZ2vzLsL2waz
         ttNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xpzuJhxQB216KEfHHMCrEm4w3UWNMvbzaotwbEGxZeQ=;
        b=pDGtuMCJuRxJN8sRMXyoTAspfWVam2P2Mcb66pnZeUonKi35YLI68OdpnE42XwwkEV
         9u2iWW3HObeY457P8JtFztV1ET0Wh2WtkL7NkfgVQw3d1Izin/OabyF5cUbCqsq1wYgV
         V0D9Azw4DqcCyoZ0dhosRn+9CSpBk2hqtSfiRLP7DPb488tDEPk9C1qKmBf76DNVLqq8
         ZtEka3s4RRbsm01fAN+rby2B7Bsj1VpdGEPM4jDWmpiixHEuppVYiekSGjjZ7vktnSrC
         ZoRm2X/EDg+wrqv5QdmaV71p0czITJ3FqoChd0K2utqQ3rUv7yF2gt1Cjd6O8jFH+BmV
         8GxQ==
X-Gm-Message-State: AOAM5300Fu7yL0PUOegGzy8MtPi62P7XgTThoInx+ygKRR4LomO/Wg/x
        wPENJWgTSn9acIGrUuBxPUE=
X-Google-Smtp-Source: ABdhPJz2PidfmGGsJuhnDaiqvVlHFu1dtS1C/yno1rkwj5tBNghcOZ7yCadshciGwCtNxy51MSjTmw==
X-Received: by 2002:a1c:7e41:: with SMTP id z62mr585748wmc.62.1638817614718;
        Mon, 06 Dec 2021 11:06:54 -0800 (PST)
Received: from localhost.localdomain (host-95-239-199-20.retail.telecomitalia.it. [95.239.199.20])
        by smtp.gmail.com with ESMTPSA id p5sm12223119wrd.13.2021.12.06.11.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 11:06:54 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     syzbot+5f47a8cea6a12b77a876@syzkaller.appspotmail.com,
        Marco Elver <elver@google.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        David Sterba <dsterba@suse.com>,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        nick black <dankamongmen@gmail.com>,
        Igor Matheus Andrade Torrente <igormtorrente@gmail.com>
Subject: Re: [PATCH] tty: n_hdlc: make n_hdlc_tty_wakeup() asynchronous
Date:   Mon, 06 Dec 2021 20:06:06 +0100
Message-ID: <3981949.J2oczr2A6u@localhost.localdomain>
In-Reply-To: <e2f074e2-b19e-da5b-9db9-c0b4142de618@i-love.sakura.ne.jp>
References: <20211116144937.19035-1-fmdefrancesco@gmail.com> <e2f074e2-b19e-da5b-9db9-c0b4142de618@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, December 6, 2021 12:44:38 PM CET Tetsuo Handa wrote:
> syzbot is reporting that an unprivileged user who logged in from tty
> console can crash the system using a reproducer shown below [1], for
> n_hdlc_tty_wakeup() is synchronously calling n_hdlc_send_frames().
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
> Linus suspected that "struct tty_ldisc"->ops->write_wakeup() must not
> sleep, and Jiri confirmed it from include/linux/tty_ldisc.h. Thus, defer
> n_hdlc_send_frames() from n_hdlc_tty_wakeup() to a WQ context like
> net/nfc/nci/uart.c does.
> 
> Link: https://syzkaller.appspot.com/bug?extid=5f47a8cea6a12b77a876 [1]
> Reported-by: syzbot <syzbot+5f47a8cea6a12b77a876@syzkaller.appspotmail.com>
> Analyzed-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Confirmed-by: Jiri Slaby <jirislaby@kernel.org>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
>  drivers/tty/n_hdlc.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)

This looks to be the correct solution, at least for fixing the SAC bug that 
Syzbot reported.

I say "at least" only because (for the moment) we have lost the synchronization 
that the spinlocks in n_hdlc_tty_ioctl() were meant to assure. 

As we have discussed, now n_hdlc_tty_wakeup() returns immediately after 
calling schedule_work(). Therefore, n_hdlc_tty_ioctl() releases the spinlock 
without it being notified whether or not n_hdlc_send_frames() has had the 
chance to run and complete.[1][2][3]

Only a minor note: since the purpose of the new "write_work"  is to start tty, 
I'd have chosen different name, like "start_work" or "start_write_work" and I'd 
have used "n_hdlc_tty_start_work()" instead of "n_hdlc_tty_write_work()" for the 
callback.

Since I have analyzed and discussed this bug with you and others, I assume that 
I got the necessary knowledge of this subject that allows me to review this patch.

Therefore, despite the due reservations about the loss of alternation and 
synchronization between __stop_tty () and __start_tty (), this work is useful for 
fixing the reported bug, so I'd like to give my tag...

Reviewed-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

Thanks for your patch,

Fabio M. De Francesco

[1] https://lore.kernel.org/lkml/3017492.JFOoIcAZ2s@localhost.localdomain/
[2] https://lore.kernel.org/lkml/5d055fbd-e94a-fe54-d3e0-982dc455ed1a@i-love.sakura.ne.jp/
[3] https://lore.kernel.org/lkml/2064700.cDd5PexU1D@localhost.localdomain/

> 
> diff --git a/drivers/tty/n_hdlc.c b/drivers/tty/n_hdlc.c
> index 7e0884ecc74f..23ba1fc99df8 100644
> --- a/drivers/tty/n_hdlc.c
> +++ b/drivers/tty/n_hdlc.c
> @@ -140,6 +140,8 @@ struct n_hdlc {
>  	struct n_hdlc_buf_list	rx_buf_list;
>  	struct n_hdlc_buf_list	tx_free_buf_list;
>  	struct n_hdlc_buf_list	rx_free_buf_list;
> +	struct work_struct	write_work;
> +	struct tty_struct	*tty_for_write_work;
>  };
>  
>  /*
> @@ -154,6 +156,7 @@ static struct n_hdlc_buf *n_hdlc_buf_get(struct n_hdlc_buf_list *list);
>  /* Local functions */
>  
>  static struct n_hdlc *n_hdlc_alloc(void);
> +static void n_hdlc_tty_write_work(struct work_struct *work);
>  
>  /* max frame size for memory allocations */
>  static int maxframe = 4096;
> @@ -210,6 +213,8 @@ static void n_hdlc_tty_close(struct tty_struct *tty)
>  	wake_up_interruptible(&tty->read_wait);
>  	wake_up_interruptible(&tty->write_wait);
>  
> +	cancel_work_sync(&n_hdlc->write_work);
> +
>  	n_hdlc_free_buf_list(&n_hdlc->rx_free_buf_list);
>  	n_hdlc_free_buf_list(&n_hdlc->tx_free_buf_list);
>  	n_hdlc_free_buf_list(&n_hdlc->rx_buf_list);
> @@ -241,6 +246,8 @@ static int n_hdlc_tty_open(struct tty_struct *tty)
>  		return -ENFILE;
>  	}
>  
> +	INIT_WORK(&n_hdlc->write_work, n_hdlc_tty_write_work);
> +	n_hdlc->tty_for_write_work = tty;
>  	tty->disc_data = n_hdlc;
>  	tty->receive_room = 65536;
>  
> @@ -334,6 +341,20 @@ static void n_hdlc_send_frames(struct n_hdlc *n_hdlc, struct tty_struct *tty)
>  		goto check_again;
>  }	/* end of n_hdlc_send_frames() */
>  
> +/**
> + * n_hdlc_tty_write_work - Asynchronous callback for transmit wakeup
> + * @work: pointer to work_struct
> + *
> + * Called when low level device driver can accept more send data.
> + */
> +static void n_hdlc_tty_write_work(struct work_struct *work)
> +{
> +	struct n_hdlc *n_hdlc = container_of(work, struct n_hdlc, write_work);
> +	struct tty_struct *tty = n_hdlc->tty_for_write_work;
> +
> +	n_hdlc_send_frames(n_hdlc, tty);
> +}	/* end of n_hdlc_tty_write_work() */
> +
>  /**
>   * n_hdlc_tty_wakeup - Callback for transmit wakeup
>   * @tty: pointer to associated tty instance data
> @@ -344,7 +365,7 @@ static void n_hdlc_tty_wakeup(struct tty_struct *tty)
>  {
>  	struct n_hdlc *n_hdlc = tty->disc_data;
>  
> -	n_hdlc_send_frames(n_hdlc, tty);
> +	schedule_work(&n_hdlc->write_work);
>  }	/* end of n_hdlc_tty_wakeup() */
>  
>  /**
> -- 
> 2.18.4
> 
> 
> 




