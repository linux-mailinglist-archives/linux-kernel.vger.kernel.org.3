Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C36045A438E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 09:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiH2HKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 03:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbiH2HKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 03:10:09 -0400
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18ACD205DE
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 00:10:06 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id b16so8934519edd.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 00:10:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Hq5rVp43c61MSLWG2VllTkt+j0B7E8YXjleuqUGPUyg=;
        b=lQ1Pufv0inkvX0bML8FvN4MYGlRVvYpLMVDNGg+onYisLd3WXHXY62eHvE0jYie270
         fof3zX/8In1d3PUjyEzcItvUUG0iaEXKv8tkr60f22XYcRS74sQ0HwGwFrEZTigDqH7j
         nsPTPZMrkPdp17CfEUAmlYvFI0jVSZ5R4I6O1tydQ0dzvW5EczuUmjJTsiQHfy+7NUbB
         ibvq5NoFSk7zV0lC2L3f0wpGLyJO6sjKcpaAGzJ13M2u5eFHefpzsSwDm+PLgPIYpJLR
         9jlReleS+/1ILz7QCsygwvv/FxqDdRPXd79UCcRTCjAb3QkYYIn4aObiXqGz/4n19CVQ
         0wiA==
X-Gm-Message-State: ACgBeo0sMMWw3WFB9Fpe1IIuYHUmzg8ZlGp8s9WV5/qxCCVkT+gzKSjo
        JY30T9sFMSf8LQyfg7nhWr8=
X-Google-Smtp-Source: AA6agR7XoO7MREK6M2BBf+ACKXMdcVljSiT+H+a8QDc+cmHDYeINbnQKLko+LLGA+J5x1l4B013z/g==
X-Received: by 2002:a05:6402:2884:b0:447:9f63:f969 with SMTP id eg4-20020a056402288400b004479f63f969mr15231591edb.407.1661757004909;
        Mon, 29 Aug 2022 00:10:04 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id ku13-20020a170907788d00b00728f6d4d0d7sm4109174ejc.67.2022.08.29.00.10.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 00:10:04 -0700 (PDT)
Message-ID: <89830d6e-fe70-eb68-84fe-1b60657ac3d8@kernel.org>
Date:   Mon, 29 Aug 2022 09:10:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] tty: n_gsm: initialize more members at gsm_alloc_mux()
Content-Language: en-US
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Daniel Starke <daniel.starke@siemens.com>
Cc:     syzbot <syzbot+cf155def4e717db68a12@syzkaller.appspotmail.com>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <0000000000008be58e05e5b5d971@google.com>
 <000000000000434f7a05e5bab1ce@google.com>
 <2110618e-57f0-c1ce-b2ad-b6cacef3f60e@I-love.SAKURA.ne.jp>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <2110618e-57f0-c1ce-b2ad-b6cacef3f60e@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27. 08. 22, 15:47, Tetsuo Handa wrote:
> syzbot is reporting use of uninitialized spinlock at gsmld_write() [1], for
> commit 32dd59f96924f45e ("tty: n_gsm: fix race condition in gsmld_write()")
> allows accessing gsm->tx_lock before gsm_activate_mux() initializes it.
> 
> Since object initialization should be done right after allocation in order
> to avoid accessing uninitialized memory, move initialization of
> timer/work/waitqueue/spinlock from gsmld_open()/gsm_activate_mux() to
> gsm_alloc_mux().

LGTM, I wonder why this was not like this forever.

Acked-by: Jiri Slaby <jirislaby@kernel.org>

> Link: https://syzkaller.appspot.com/bug?extid=cf155def4e717db68a12 [1]
> Reported-by: syzbot <syzbot+cf155def4e717db68a12@syzkaller.appspotmail.com>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Tested-by: syzbot <syzbot+cf155def4e717db68a12@syzkaller.appspotmail.com>
> Fixes: 32dd59f96924f45e ("tty: n_gsm: fix race condition in gsmld_write()")
> ---
>   drivers/tty/n_gsm.c | 17 ++++++-----------
>   1 file changed, 6 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> index caa5c14ed57f..70cd90474679 100644
> --- a/drivers/tty/n_gsm.c
> +++ b/drivers/tty/n_gsm.c
> @@ -2501,13 +2501,6 @@ static int gsm_activate_mux(struct gsm_mux *gsm)
>   	if (dlci == NULL)
>   		return -ENOMEM;
>   
> -	timer_setup(&gsm->kick_timer, gsm_kick_timer, 0);
> -	timer_setup(&gsm->t2_timer, gsm_control_retransmit, 0);
> -	INIT_WORK(&gsm->tx_work, gsmld_write_task);
> -	init_waitqueue_head(&gsm->event);
> -	spin_lock_init(&gsm->control_lock);
> -	spin_lock_init(&gsm->tx_lock);
> -
>   	if (gsm->encoding == 0)
>   		gsm->receive = gsm0_receive;
>   	else
> @@ -2612,6 +2605,12 @@ static struct gsm_mux *gsm_alloc_mux(void)
>   	kref_init(&gsm->ref);
>   	INIT_LIST_HEAD(&gsm->tx_ctrl_list);
>   	INIT_LIST_HEAD(&gsm->tx_data_list);
> +	timer_setup(&gsm->kick_timer, gsm_kick_timer, 0);
> +	timer_setup(&gsm->t2_timer, gsm_control_retransmit, 0);
> +	INIT_WORK(&gsm->tx_work, gsmld_write_task);
> +	init_waitqueue_head(&gsm->event);
> +	spin_lock_init(&gsm->control_lock);
> +	spin_lock_init(&gsm->tx_lock);
>   
>   	gsm->t1 = T1;
>   	gsm->t2 = T2;
> @@ -2946,10 +2945,6 @@ static int gsmld_open(struct tty_struct *tty)
>   
>   	gsmld_attach_gsm(tty, gsm);
>   
> -	timer_setup(&gsm->kick_timer, gsm_kick_timer, 0);
> -	timer_setup(&gsm->t2_timer, gsm_control_retransmit, 0);
> -	INIT_WORK(&gsm->tx_work, gsmld_write_task);
> -
>   	return 0;
>   }
>   

-- 
js
suse labs

