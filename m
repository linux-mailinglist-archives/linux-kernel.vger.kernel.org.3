Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59FB45ABFDB
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 18:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbiICQm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 12:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiICQm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 12:42:57 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE0BA58DCA
        for <linux-kernel@vger.kernel.org>; Sat,  3 Sep 2022 09:42:55 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id c9so7264540ybf.5
        for <linux-kernel@vger.kernel.org>; Sat, 03 Sep 2022 09:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=MSlpVQM6LPBbdPdYsvwpuDS2GznLXHNkiHs1OXe0l/E=;
        b=dgVVPwawmNQY+PcfCST6C1ozjH/moAM3P6JfJ/jE+ALX0LudC/lNAeRkNsr2LO8CFO
         DBt+z1dIDeLtRE/RDA7tcnKvBVRBUdzGO/tR7jDlPmF6sgWzNQyuJzbKelfbfRZi77bT
         mZ5E8L1UOwHO63q8zTa2fnjVDGjttQP5vNHlVfu6W8IP3ujb6RUJYhBs5wlhO4vOI3dN
         dPD1bETDc9TYJWXFemlKftkTU+5AN3Bum/kCpuMTDU7rpyMsWN5jOybqE8vd72jAL52r
         6GPy13kOx8ZRdI537AbEla6QMmWGSKAosS687pUj+3i6+NUMbV0qh2PnL6GD/BQ1TnIY
         qTvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=MSlpVQM6LPBbdPdYsvwpuDS2GznLXHNkiHs1OXe0l/E=;
        b=oUo3fJltl4SEkaw35lTxJrCYqhtiexoRfqkgwTx5bnufAMrVJa5zHKoJY9mtEPO33K
         wCCcP2zs3P4nszOQgsPx99oUBE5i2KmI4mDYQIkhdx/Nfgu1KR8qmZoZuPT8wjjbX5+N
         uCSIuhrcFYhMqEJ4DPfD9wjqyGLAPZkE9rnsN8vlvsAX/P7wOCwa6hhXRhaCoaF1oz9R
         hIz65HVtBeE6+c/r+MTX+pkzMLtBHULcs74+TNP2wXgc7e0MP19zY0tjcDFUlvJvZMYE
         tAINZ92ifJQaiFLeIL513HZvTfSYK78hEIhtxq0WC6vLUDmEwCXX5cSDzqqo3jDN+Y8r
         9Ymw==
X-Gm-Message-State: ACgBeo1/ayE/OMRwdKkbwrhGQ4v5K0qhgFAgveAaygTvMgbcKWO7+OBo
        oJtc9YWssTYWC8mC9mzKADxpyjqdwakrLgf/nDccbg==
X-Google-Smtp-Source: AA6agR6ah/QjgtNirwQaFdAVShtS797fncfIZTBqVfrd8xWghWo0iF9beuaHqowoqp8R3YGFBT+ALgMpA2CH8vPcicU=
X-Received: by 2002:a25:84cd:0:b0:67a:699e:4e84 with SMTP id
 x13-20020a2584cd000000b0067a699e4e84mr26241370ybm.407.1662223374901; Sat, 03
 Sep 2022 09:42:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220831133758.3741187-1-leitao@debian.org>
In-Reply-To: <20220831133758.3741187-1-leitao@debian.org>
From:   Eric Dumazet <edumazet@google.com>
Date:   Sat, 3 Sep 2022 09:42:43 -0700
Message-ID: <CANn89iLe9spogp7eaXPziA0L-FqJ0w=6VxdWDL6NKGobTyuQRw@mail.gmail.com>
Subject: Re: [PATCH RESEND net-next] tcp: socket-specific version of WARN_ON_ONCE()
To:     Breno Leitao <leitao@debian.org>
Cc:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        netdev <netdev@vger.kernel.org>, leit@fb.com,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Paolo Abeni <pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
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

On Wed, Aug 31, 2022 at 6:38 AM Breno Leitao <leitao@debian.org> wrote:
>
> There are cases where we need information about the socket during a
> warning, so, it could help us to find bugs that happens that do not have
> a easily repro.
>
> BPF congestion control algorithms can change socket state in unexpected
> ways, leading to WARNings. Additional information about the socket state
> is useful to identify the culprit.

Well, this suggests we need to fix BPF side ?

Not sure how this can happen, because TCP_BPF_IW has

if (val <= 0 || tp->data_segs_out > tp->syn_data)
     ret = -EINVAL;
else
    tcp_snd_cwnd_set(tp, val);

It seems you already found the issue in an eBPF CC, can you share the details ?


>
> This diff creates a TCP socket-specific version of WARN_ON_ONCE(), and
> attaches it to tcp_snd_cwnd_set().

Well, I feel this will need constant additions... the state of a
custom BPF CC is opaque to core TCP stack anyway ?

>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  include/net/tcp.h       |  3 ++-
>  include/net/tcp_debug.h | 10 ++++++++++
>  net/ipv4/tcp.c          | 30 ++++++++++++++++++++++++++++++
>  3 files changed, 42 insertions(+), 1 deletion(-)
>  create mode 100644 include/net/tcp_debug.h
>
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index d10962b9f0d0..73c3970d8839 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -40,6 +40,7 @@
>  #include <net/inet_ecn.h>
>  #include <net/dst.h>
>  #include <net/mptcp.h>
> +#include <net/tcp_debug.h>
>
>  #include <linux/seq_file.h>
>  #include <linux/memcontrol.h>
> @@ -1222,7 +1223,7 @@ static inline u32 tcp_snd_cwnd(const struct tcp_sock *tp)
>
>  static inline void tcp_snd_cwnd_set(struct tcp_sock *tp, u32 val)
>  {
> -       WARN_ON_ONCE((int)val <= 0);
> +       TCP_SOCK_WARN_ON_ONCE(tp, (int)val <= 0);
>         tp->snd_cwnd = val;
>  }
>
> diff --git a/include/net/tcp_debug.h b/include/net/tcp_debug.h
> new file mode 100644
> index 000000000000..50e96d87d335
> --- /dev/null
> +++ b/include/net/tcp_debug.h
> @@ -0,0 +1,10 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_TCP_DEBUG_H
> +#define _LINUX_TCP_DEBUG_H
> +
> +void tcp_sock_warn(const struct tcp_sock *tp);
> +
> +#define TCP_SOCK_WARN_ON_ONCE(tcp_sock, condition) \
> +               DO_ONCE_LITE_IF(condition, tcp_sock_warn, tcp_sock)
> +
> +#endif  /* _LINUX_TCP_DEBUG_H */
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index bbe218753662..71771fee72f7 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -4684,6 +4684,36 @@ int tcp_abort(struct sock *sk, int err)
>  }
>  EXPORT_SYMBOL_GPL(tcp_abort);
>
> +void tcp_sock_warn(const struct tcp_sock *tp)
> +{
> +       const struct sock *sk = (const struct sock *)tp;
> +       struct inet_sock *inet = inet_sk(sk);
> +       struct inet_connection_sock *icsk = inet_csk(sk);
> +
> +       WARN_ON(1);
> +
> +       if (!tp)
> +               return;
> +
> +       pr_warn("Socket Info: family=%u state=%d sport=%u dport=%u ccname=%s cwnd=%u",
> +               sk->sk_family, sk->sk_state, ntohs(inet->inet_sport),
> +               ntohs(inet->inet_dport), icsk->icsk_ca_ops->name, tcp_snd_cwnd(tp));
> +
> +       switch (sk->sk_family) {
> +       case AF_INET:
> +               pr_warn("saddr=%pI4 daddr=%pI4", &inet->inet_saddr,
> +                       &inet->inet_daddr);
> +               break;
> +#if IS_ENABLED(CONFIG_IPV6)
> +       case AF_INET6:
> +               pr_warn("saddr=%pI6 daddr=%pI6", &sk->sk_v6_rcv_saddr,
> +                       &sk->sk_v6_daddr);
> +               break;
> +#endif
> +       }
> +}
> +EXPORT_SYMBOL_GPL(tcp_sock_warn);
> +
>  extern struct tcp_congestion_ops tcp_reno;
>
>  static __initdata unsigned long thash_entries;
> --
> 2.30.2
>
