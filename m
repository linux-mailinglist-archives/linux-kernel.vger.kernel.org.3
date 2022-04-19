Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0123506FD4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 16:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347320AbiDSON7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 10:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347044AbiDSONr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 10:13:47 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DBF33A13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 07:11:04 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id k23so33195614ejd.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 07:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nHXLQ0I+EJ1nxdIp9Tmk0m+ev0eSmIouo4s+rE6MXwE=;
        b=ocxSMgn30cU8rKV3BHbxvPf0SNWubjrp6VwIcf3Bk5no/H9Iz/tb9NhTtPsnozwQ65
         Nj9Ew5y1rKb5PUekhWNWn3PSTD58c47CZeB8JiNSj2nGJK2prDpsVvIM0QRzKI+Y2r/N
         2znXf0VG/KhbfywiY3ZHAv+qWuyMPqZ2jxD11WFupmfj63AV76KklQmSqo4CrL/DZy1R
         45olGSUHmHXXkDP1VSZhVJ5EjbPErIgcA7f0YxOUPhD8ih+hvVI9tdOTRgYLCPzQ49Wm
         wtmzBvbSOH08nLiCsv+3l8akCSEcG76tk/kDELUABY+HeJMJLaBWJa8CSUQJPK9fd4JL
         SBeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nHXLQ0I+EJ1nxdIp9Tmk0m+ev0eSmIouo4s+rE6MXwE=;
        b=NcW78L54SAfWbt4eAzOCwv7QqCPCk/KpLrcwiUE+SUkTAyOdPpwZnMLq51fepuvntb
         C7UukFe7gxQ/5rDXy1cTfXBGZDumuUxN8HtqyEr/dgdZ/uKYLOuoedgnM2YUYhJ68elN
         JNXf7rgcVeO2AAgdE8ShaYdd0z2x70htys48Mlxwd4DXq7nG5E2kR4uQJWvFmUlRetrF
         g5fwUw04v4yzcMwSjJlbVLfcZmEOiX/npbBhyg6IzLD4dW1W0llqcQ4dp+XswzqC/41k
         ZH8I6NLhfl0LpJHjr5MHjc6Xvi+hRLUFChtrHpqQQ8HmH6oTQ+RJ6/8YbTzMP7C6TRVE
         Xp5w==
X-Gm-Message-State: AOAM531fzKzCA1sdZKRF5Q4+oLZizt0vXLKYgGQpOfv22CZH85d5fzRJ
        BKcqsRF78PoDeakqsRWHiw4jk6kMBo1YT5UaSO649Kyov14=
X-Google-Smtp-Source: ABdhPJwppgOkIdU97hzg/rxYr4P3MpEhoZFUqXfqnPDeNyUCrwC6Ve9vihYcq+iiSvSig+bSaCaOljqnrMj/vUEFx2E=
X-Received: by 2002:a17:906:68c2:b0:6b4:9f26:c099 with SMTP id
 y2-20020a17090668c200b006b49f26c099mr14064258ejr.41.1650377462879; Tue, 19
 Apr 2022 07:11:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220331070115.29421-1-bjorn.ardo@axis.com> <CABb+yY1zrHYLBjY_EoC7bkTsWcKOhzCjp-5vgvqP0HEAJicdXQ@mail.gmail.com>
 <c4aa28b2-5550-ed39-3869-556b451ff54b@axis.com>
In-Reply-To: <c4aa28b2-5550-ed39-3869-556b451ff54b@axis.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Tue, 19 Apr 2022 09:10:51 -0500
Message-ID: <CABb+yY1BNsdMq7CNOBDk3sn7uvpL4=-fT7eOcbuL-+Yjz+iqHw@mail.gmail.com>
Subject: Re: [PATCH] mailbox: forward the hrtimer if not queued and under a lock
To:     Bjorn Ardo <bjorn.ardo@axis.com>
Cc:     kernel <kernel@axis.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 7:15 AM Bjorn Ardo <bjorn.ardo@axis.com> wrote:
>
> Hi,
>
>
> I can confirm that this is an actual issue found on our system, not just
> a theoretical case.
>
>
> If I add the following trace-code to the original code:
>
>
> diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
> index 3e7d4b20ab34..8e9e82e5f4b1 100644
> --- a/drivers/mailbox/mailbox.c
> +++ b/drivers/mailbox/mailbox.c
> @@ -57,6 +57,7 @@ static void msg_submit(struct mbox_chan *chan)
>          void *data;
>          int err = -EBUSY;
>
> +       trace_printk("Entering msg_submit\n");
>          spin_lock_irqsave(&chan->lock, flags);
>
>          if (!chan->msg_count || chan->active_req)
> @@ -85,9 +86,14 @@ static void msg_submit(struct mbox_chan *chan)
>          /* kick start the timer immediately to avoid delays */
>          if (!err && (chan->txdone_method & TXDONE_BY_POLL)) {
>                  /* but only if not already active */
> -               if (!hrtimer_active(&chan->mbox->poll_hrt))
> +               if (!hrtimer_active(&chan->mbox->poll_hrt)) {
> +                       trace_printk("Starting the hr timer from
> submit\n");
> hrtimer_start(&chan->mbox->poll_hrt, 0, HRTIMER_MODE_REL);
> +               } else {
> +                       trace_printk("Not starting the hr timer from
> submit since it is active\n");
> +               }
>          }
> +       trace_printk("Leaving msg_submit\n");
>   }
>
>   static void tx_tick(struct mbox_chan *chan, int r)
> @@ -121,6 +127,7 @@ static enum hrtimer_restart txdone_hrtimer(struct
> hrtimer *hrtimer)
>          bool txdone, resched = false;
>          int i;
>
> +       trace_printk("Entering txdone_hrtimer\n");
>          for (i = 0; i < mbox->num_chans; i++) {
>                  struct mbox_chan *chan = &mbox->chans[i];
>
> @@ -134,8 +141,10 @@ static enum hrtimer_restart txdone_hrtimer(struct
> hrtimer *hrtimer)
>
>          if (resched) {
>                  hrtimer_forward_now(hrtimer,
> ms_to_ktime(mbox->txpoll_period));
> +               trace_printk("Leaving txdone_hrtimer with restart\n");
>                  return HRTIMER_RESTART;
>          }
> +       trace_printk("Leaving txdone_hrtimer without restart\n");
>          return HRTIMER_NORESTART;
>   }
>
> Then I get the following trace output (I have cropped a small portion
> around where the error appears):
>
>
>         vhost-475-480     [000] d..1.   217.440325: msg_submit: Entering
> msg_submit
>         vhost-475-480     [000] d..1.   217.440332: msg_submit: Starting
> the hr timer from submit
>         vhost-475-480     [000] d..1.   217.440336: msg_submit: Leaving
> msg_submit
>         vhost-475-480     [000] d.h1.   217.440342: txdone_hrtimer:
> Entering txdone_hrtimer
>         vhost-475-480     [000] d.h1.   217.440349: txdone_hrtimer:
> Leaving txdone_hrtimer without restart
>         vhost-475-480     [000] d..1.   217.440597: msg_submit: Entering
> msg_submit
>         vhost-475-480     [000] d..1.   217.440599: msg_submit: Starting
> the hr timer from submit
>         vhost-475-480     [000] d..1.   217.440602: msg_submit: Leaving
> msg_submit
>            <idle>-0       [001] ..s1.   217.440604: msg_submit: Entering
> msg_submit
>         vhost-475-480     [000] d.h1.   217.440606: txdone_hrtimer:
> Entering txdone_hrtimer
>         vhost-475-480     [000] d.h1.   217.440608: txdone_hrtimer:
> Leaving txdone_hrtimer without restart
>            <idle>-0       [001] ..s1.   217.440609: msg_submit: Not
> starting the hr timer from submit since it is active
>            <idle>-0       [001] ..s1.   217.440610: msg_submit: Leaving
> msg_submit
>
>
> If I break down the log above we first have one case that works as
> intended. That is a message being written and a timer started and the
> message have been read when the timer hits:
>
>         vhost-475-480     [000] d..1.   217.440325: msg_submit: Entering
> msg_submit
>         vhost-475-480     [000] d..1.   217.440332: msg_submit: Starting
> the hr timer from submit
>         vhost-475-480     [000] d..1.   217.440336: msg_submit: Leaving
> msg_submit
>         vhost-475-480     [000] d.h1.   217.440342: txdone_hrtimer:
> Entering txdone_hrtimer
>         vhost-475-480     [000] d.h1.   217.440349: txdone_hrtimer:
> Leaving txdone_hrtimer without restart
>
>
> After this we write a new message and a new timer is started:
>
>         vhost-475-480     [000] d..1.   217.440597: msg_submit: Entering
> msg_submit
>         vhost-475-480     [000] d..1.   217.440599: msg_submit: Starting
> the hr timer from submit
>         vhost-475-480     [000] d..1.   217.440602: msg_submit: Leaving
> msg_submit
>
>
> However here comes the race. Now a new message is being written at the
> same time as the hr-timer is handling the first reply (on different CPU's):
>
>            <idle>-0       [001] ..s1.   217.440604: msg_submit: Entering
> msg_submit
>         vhost-475-480     [000] d.h1.   217.440606: txdone_hrtimer:
> Entering txdone_hrtimer
>
I don't have access to your client driver, but if it submits another
message from rx_callback() that is the problem.

Please have a look at how other platforms do, for example
imx_dsp_rproc_rx_tx_callback()

/**
 * mbox_chan_received_data - A way for controller driver to push data
 *              received from remote to the upper layer.
 * @chan: Pointer to the mailbox channel on which RX happened.
 * @mssg: Client specific message typecasted as void *
 *
 * After startup and before shutdown any data received on the chan
 * is passed on to the API via atomic mbox_chan_received_data().
 * The controller should ACK the RX only after this call returns.
 */
void mbox_chan_received_data(struct mbox_chan *chan, void *mssg)

If not this, please share your client code as well.

thanks.
