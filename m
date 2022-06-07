Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAE9054045A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 19:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243723AbiFGRGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 13:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237338AbiFGRGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 13:06:41 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE3C54037
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 10:06:39 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id y16so14685296ili.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 10:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QocnDs5w4TazSvMjzZtEO2lYhuTH55BPpRIi6NIvCgU=;
        b=dRIKodz4tDRakIwL0rM81s0k+Y6sZzcFymClpndB8u/CNXlwMmEmdV6eO7OFiQEORL
         RK+hl2KV8qmY2zotWqT9OqXbxCSCqmtKPR2fKLk/Mb0c+F8ZI2wckPqNLd2ds4vZP1jG
         C/vot/RN14YqPvaWRF8f28nNs5npMlddiM4VpnBfok8fA8fMw/xmkGhAh8qIwpbGG7zA
         etgWLnPu1MN2lSSOGQzLJHcc+BFtSeWfbom4aOkEuu1b+IVR71PRroP+Quo3BaXb/zMK
         WLh8pUvlVbF3b6e3ZlxSjOR9QVU+ORoPadn3wP2qQZvV2aTu6gfnZelrf7gUwLUfRxot
         fCVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QocnDs5w4TazSvMjzZtEO2lYhuTH55BPpRIi6NIvCgU=;
        b=K/cf37krr3Ubbcjy/CGqy49yFM90Uqod/jZpl6LvXuQDV0fW5eeoI/uS710Ipt3njF
         57z7rgDh+/nB2tBEkqaD3WIvyTDP+p7c0dS3pAWtXsa2c+BGb0e0FTnWYb5Ijj+pJzLC
         qpy1eOwlnsmt9OEPl/vcBH/6mOj+IVqQGo72MYTU70h/d+gf7iiBiq/4MpX6mGoesdX+
         oW4c1qG1w4mGDMqUcrzWJ1Yznd2Kb07DmdD2EunbX/NI/5U4Fkyb/vqAYNMJejDuDueh
         Z6SlxwFAPS3ugNEKnVyqNy/hY6yNMw7LS4Xr1hTyS0YdmPIRPNdkN0JLf4a8bzOs5jDg
         GF6w==
X-Gm-Message-State: AOAM533LT8jlr9QqJRiiA1cFJyrznAg0E3O5frjs3/R6Pl7waNOc/jnw
        HSJ+BhbV7itSnSoT9b62TUNr0nHlIOScY4poxpyfFA==
X-Google-Smtp-Source: ABdhPJz9Lg7BSVbItguQd767ICKznx7IEdGBPR3e7oFdkDrucWpyWhc4A+HS6IV9zKDoTqLI78OYvApBCnJGhZImJL0=
X-Received: by 2002:a05:6e02:1e0b:b0:2d1:b5e8:38a0 with SMTP id
 g11-20020a056e021e0b00b002d1b5e838a0mr17440930ila.296.1654621598804; Tue, 07
 Jun 2022 10:06:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220607142337.78458-1-duoming@zju.edu.cn>
In-Reply-To: <20220607142337.78458-1-duoming@zju.edu.cn>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 7 Jun 2022 10:06:27 -0700
Message-ID: <CANn89iJoOvG=KrouTpe+bgAVf=mYtxE1D3m542UF96XwxKEVsQ@mail.gmail.com>
Subject: Re: [PATCH v2] net: ax25: Fix deadlock caused by skb_recv_datagram in ax25_recvmsg
To:     Duoming Zhou <duoming@zju.edu.cn>
Cc:     LKML <linux-kernel@vger.kernel.org>, jreuter@yaina.de,
        Ralf Baechle <ralf@linux-mips.org>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        netdev <netdev@vger.kernel.org>, linux-hams@vger.kernel.org,
        thomas@osterried.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 7, 2022 at 7:24 AM Duoming Zhou <duoming@zju.edu.cn> wrote:
>
> The skb_recv_datagram() in ax25_recvmsg() will hold lock_sock
> and block until it receives a packet from the remote. If the client
> doesn`t connect to server and calls read() directly, it will not
> receive any packets forever. As a result, the deadlock will happen.
>
> The fail log caused by deadlock is shown below:
>
> [  369.606973] INFO: task ax25_deadlock:157 blocked for more than 245 seconds.
> [  369.608919] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  369.613058] Call Trace:
> [  369.613315]  <TASK>
> [  369.614072]  __schedule+0x2f9/0xb20
> [  369.615029]  schedule+0x49/0xb0
> [  369.615734]  __lock_sock+0x92/0x100
> [  369.616763]  ? destroy_sched_domains_rcu+0x20/0x20
> [  369.617941]  lock_sock_nested+0x6e/0x70
> [  369.618809]  ax25_bind+0xaa/0x210
> [  369.619736]  __sys_bind+0xca/0xf0
> [  369.620039]  ? do_futex+0xae/0x1b0
> [  369.620387]  ? __x64_sys_futex+0x7c/0x1c0
> [  369.620601]  ? fpregs_assert_state_consistent+0x19/0x40
> [  369.620613]  __x64_sys_bind+0x11/0x20
> [  369.621791]  do_syscall_64+0x3b/0x90
> [  369.622423]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> [  369.623319] RIP: 0033:0x7f43c8aa8af7
> [  369.624301] RSP: 002b:00007f43c8197ef8 EFLAGS: 00000246 ORIG_RAX: 0000000000000031
> [  369.625756] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f43c8aa8af7
> [  369.626724] RDX: 0000000000000010 RSI: 000055768e2021d0 RDI: 0000000000000005
> [  369.628569] RBP: 00007f43c8197f00 R08: 0000000000000011 R09: 00007f43c8198700
> [  369.630208] R10: 0000000000000000 R11: 0000000000000246 R12: 00007fff845e6afe
> [  369.632240] R13: 00007fff845e6aff R14: 00007f43c8197fc0 R15: 00007f43c8198700
>
> This patch moves the skb_recv_datagram() before lock_sock() in order
> that other functions that need lock_sock could be executed.
>
> Suggested-by: Thomas Osterried <thomas@osterried.de>
> Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
> Reported-by: Thomas Habets <thomas@@habets.se>
> ---
> Changes in v2:
>   - Make commit messages clearer.
>
>  net/ax25/af_ax25.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/net/ax25/af_ax25.c b/net/ax25/af_ax25.c
> index 95393bb2760..02cd6087512 100644
> --- a/net/ax25/af_ax25.c
> +++ b/net/ax25/af_ax25.c
> @@ -1665,6 +1665,11 @@ static int ax25_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
>         int copied;
>         int err = 0;
>
> +       /* Now we can treat all alike */
> +       skb = skb_recv_datagram(sk, flags, &err);
> +       if (!skb)
> +               goto done;
> +

So at this point we have skb=something. This means that the following
branch will leak it.

if (sk->sk_type == SOCK_SEQPACKET && sk->sk_state != TCP_ESTABLISHED) {
    err =  -ENOTCONN;
    goto out;    // skb will be leaked
}


>         /*
>          *      This works for seqpacket too. The receiver has ordered the
> @@ -1675,11 +1680,6 @@ static int ax25_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
>                 goto out;
>         }
>
> -       /* Now we can treat all alike */
> -       skb = skb_recv_datagram(sk, flags, &err);
> -       if (skb == NULL)
> -               goto out;
> -
>         if (!sk_to_ax25(sk)->pidincl)
>                 skb_pull(skb, 1);               /* Remove PID */
>
> @@ -1725,6 +1725,7 @@ static int ax25_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
>  out:
>         release_sock(sk);
>
> +done:
>         return err;
>  }
>
> --
> 2.17.1
>
