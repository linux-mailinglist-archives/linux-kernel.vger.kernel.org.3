Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB8114CC47B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 18:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235516AbiCCSAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 13:00:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiCCSA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 13:00:28 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25042188857
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 09:59:41 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-2dbfe58670cso65110297b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 09:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s/unpQwJaLgNQM+s14R4jLgua2pI9jnWiTGhNAHeWE8=;
        b=KZTmAfZOwOAA5fibVibhztrJkY1z/DbGoLaKhYH4Z8sni7aOKQJiHnzOmlXPjylBDf
         Yhn0Eyg7IwFCaXwaf0YpMFeFAOaHfbQzjpXJ1sXC1aIQ7ZJZXvK6M7ZWVPv9XITdKP01
         HvE6DXiMmq5E0QVrhG7sIwBHO/QCyiwsK9C3xuk4hjmEbws0NksB09ExgSkBtjhNDP12
         bHIoXZ1XEkm5RXaDLQyQrQHcf4bBRVU1KJb1zmBwDPEaSgsh5nvh4vFE36ByqmE7iTke
         Bxv5/0DAWGpiVorNyF1HPehxNMXLvlz4FBXGS/P9RUqnZtR193Q7ZwkkO49g5WBS+Pgm
         tgpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s/unpQwJaLgNQM+s14R4jLgua2pI9jnWiTGhNAHeWE8=;
        b=DfqDpEbZU2xiU8AaRBz0Y0ip/VWp4SUhkEEZHIRyZ9DadxPOSMlOuqXPX4QXzuZg5b
         7JRVZOreVAKbsMZfn8MMd+vfIX0FI8TyZC2n6oUNxynWrj3DVFZ2IehtSM1UFSXbWGsd
         5B6NpmjjG+na8qauCpQWE15LKI35ftKhc0IhyNKa1YFtqEx7vGfvDV+D4Hk+oqpGPDQf
         VVAjHe5zeroetwzoaEyRbeW6elEb8DZ4PTjeh1hjQdZYkbPWgB1moyrxG0vWRUnL7Gu3
         b195IyRTyxHxMoKUvgLpegRUXQj6Bd2a1h+KdHKk85K9b1HlKduGVnWCJfmh7y60sp+s
         SsTg==
X-Gm-Message-State: AOAM531ftKKcNB8gkk++Q0tXh0NrdpFqhphQ9e4qf57vEZt73BphxXtO
        xEBU2/SnWHH00vNFX6TA8q7cKfkhS4zxyA8kObIR+LW8ttg=
X-Google-Smtp-Source: ABdhPJydkatxDGptyUeCctpZsFzraCCnCd/C4OBwZKkf+qNr4hWomtdjZM9czL3azC8+lIfLReG7ylyR5Yroi1HIGpI=
X-Received: by 2002:a81:500b:0:b0:2dc:27ff:1240 with SMTP id
 e11-20020a81500b000000b002dc27ff1240mr7006301ywb.55.1646330379848; Thu, 03
 Mar 2022 09:59:39 -0800 (PST)
MIME-Version: 1.0
References: <20220303174707.40431-1-imagedong@tencent.com> <20220303174707.40431-5-imagedong@tencent.com>
In-Reply-To: <20220303174707.40431-5-imagedong@tencent.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 3 Mar 2022 09:59:28 -0800
Message-ID: <CANn89iLcp96x15SkmPN7d7WyHRXecbswYNhghB3U2+JQxOvvjQ@mail.gmail.com>
Subject: Re: [PATCH net-next 4/7] net: dev: use kfree_skb_reason() for enqueue_to_backlog()
To:     Menglong Dong <menglong8.dong@gmail.com>
Cc:     David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        David Miller <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Menglong Dong <imagedong@tencent.com>,
        Talal Ahmad <talalahmad@google.com>,
        Kees Cook <keescook@chromium.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Alexander Lobakin <alobakin@pm.me>, flyingpeng@tencent.com,
        mengensun@tencent.com, Antoine Tenart <atenart@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemb@google.com>,
        Vasily Averin <vvs@virtuozzo.com>,
        Cong Wang <cong.wang@bytedance.com>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 3, 2022 at 9:48 AM <menglong8.dong@gmail.com> wrote:
>
> From: Menglong Dong <imagedong@tencent.com>
>
> Replace kfree_skb() used in enqueue_to_backlog() with
> kfree_skb_reason(). The skb rop reason SKB_DROP_REASON_CPU_BACKLOG is
> introduced for the case of failing to enqueue the skb to the per CPU
> backlog queue. The further reason can be backlog queue full or RPS
> flow limition, and I think we meedn't to make further distinctions.
>
> Signed-off-by: Menglong Dong <imagedong@tencent.com>
> ---
>  include/linux/skbuff.h     | 6 ++++++
>  include/trace/events/skb.h | 1 +
>  net/core/dev.c             | 6 +++++-
>  3 files changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 62f9d15ec6ec..d2cf87ff84c2 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -402,6 +402,12 @@ enum skb_drop_reason {
>                                          * outputting (failed to enqueue to
>                                          * current qdisc)
>                                          */
> +       SKB_DROP_REASON_CPU_BACKLOG,    /* failed to enqueue the skb to
> +                                        * the per CPU backlog queue. This
> +                                        * can be caused by backlog queue
> +                                        * full (see netdev_max_backlog in
> +                                        * net.rst) or RPS flow limit
> +                                        */
>         SKB_DROP_REASON_MAX,
>  };
>
> diff --git a/include/trace/events/skb.h b/include/trace/events/skb.h
> index 80fe15d175e3..29c360b5e114 100644
> --- a/include/trace/events/skb.h
> +++ b/include/trace/events/skb.h
> @@ -47,6 +47,7 @@
>         EM(SKB_DROP_REASON_NEIGH_DEAD, NEIGH_DEAD)              \
>         EM(SKB_DROP_REASON_QDISC_EGRESS, QDISC_EGRESS)          \
>         EM(SKB_DROP_REASON_QDISC_DROP, QDISC_DROP)              \
> +       EM(SKB_DROP_REASON_CPU_BACKLOG, CPU_BACKLOG)            \
>         EMe(SKB_DROP_REASON_MAX, MAX)
>
>  #undef EM
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 3280ba2502cd..373fa7a33ffa 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -4541,10 +4541,12 @@ static bool skb_flow_limit(struct sk_buff *skb, unsigned int qlen)
>  static int enqueue_to_backlog(struct sk_buff *skb, int cpu,
>                               unsigned int *qtail)
>  {
> +       enum skb_drop_reason reason;
>         struct softnet_data *sd;
>         unsigned long flags;
>         unsigned int qlen;
>
> +       reason = SKB_DROP_REASON_NOT_SPECIFIED;
>         sd = &per_cpu(softnet_data, cpu);
>
>         rps_lock_irqsave(sd, &flags);
> @@ -4566,6 +4568,8 @@ static int enqueue_to_backlog(struct sk_buff *skb, int cpu,
>                 if (!__test_and_set_bit(NAPI_STATE_SCHED, &sd->backlog.state))
>                         napi_schedule_rps(sd);
>                 goto enqueue;
> +       } else {

No need for an else {} after a goto  xxx;


> +               reason = SKB_DROP_REASON_CPU_BACKLOG;
>         }
>
>  drop:
> @@ -4573,7 +4577,7 @@ static int enqueue_to_backlog(struct sk_buff *skb, int cpu,
>         rps_unlock_irq_restore(sd, &flags);
>
>         atomic_long_inc(&skb->dev->rx_dropped);
> -       kfree_skb(skb);
> +       kfree_skb_reason(skb, reason);
>         return NET_RX_DROP;
>  }
>
> --
> 2.35.1
>
