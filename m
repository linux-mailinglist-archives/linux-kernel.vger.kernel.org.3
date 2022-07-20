Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB2957BE16
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 20:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbiGTSt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 14:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiGTSty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 14:49:54 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C725C735BF
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 11:49:52 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id l3so12205501qkl.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 11:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ewHdJY+0XilkP+ABNbGfVEqdZY0AHgVgsfEbax1I1nI=;
        b=F9x0Fxkpa/jLnmDbMPmLXofXV5EW8/x22/stbIqW17hDUGzcswbmPx8laZD4o0MXEe
         QgFAOVkYEm8Sy0tRQuY4GSDH38giuxoBxr0sfhk0FmCorNZEcYMG3CTwu15AmTtozpou
         iNB0wrjDTkzANtZedl75sd8B6sUswAHZw7B/lmwpp0YxEHObCkPB2/tFcqtLkldT1UzG
         vTvW7/C8LqJs5441VJ/2VGsceX+3SKG63JX62X9nMZUVW/aw/87DHTNY1SgAMtqE9pYQ
         NFcOdWo1b95yqvZlWWswFqEiGZJsVvU9qqRgPfkRyYeTK4a0S28tbSYqlMzVLXL+vhZP
         FlCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ewHdJY+0XilkP+ABNbGfVEqdZY0AHgVgsfEbax1I1nI=;
        b=CC5hl0eDVOP2hMw5KDaSDYeYxMYC3h5oC31HyCB1jAuSOgKk4jIIcnnwusi1E6NN5E
         1bJuQo/bXk4BOyXTd5OkitXIaYJG0hx0iUhIQ4TpcbamU98t80sxj2WS8Gll6+voLU58
         9fLPpkPYMj99rKF85jSd10xlaPNLUx5lvY3LkMd9vVnw1ZpJx3NciQMQjh2gCaAaHbl8
         4ca7OhQ3kyfMa5R13+eA3dZtVqTcrCBf4zjRSVbT2EngCi3yR3T1LQo5nmSuw2AoYSZM
         bcNYQgz7nOaSpVg8KqKyV0Wq7mcMnR6RVYnjCmKmMPD4BwDUU3GbOLddZGaHF1gtQex+
         Adww==
X-Gm-Message-State: AJIora95XELtoEqEUSCMpAx9+Ra/wDh2ETD1jrQwM4I+FoJcCuCxMV9a
        sv4DM5oefpAFcV4WkqiTAGzLj/jydH5Aq6rJiK/7XcJivW0=
X-Google-Smtp-Source: AGRyM1sJAKstCia+5xzTTrzCiqL753GXKAp1MaPU/9DdiH52XAzDxkdYq/1j2JA9xT1YYJgwQ1P54EWO8iavi97H6Xk=
X-Received: by 2002:a05:620a:410c:b0:6b2:82d8:dcae with SMTP id
 j12-20020a05620a410c00b006b282d8dcaemr25452157qko.259.1658342991816; Wed, 20
 Jul 2022 11:49:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220720072404.16708-1-hlm3280@163.com>
In-Reply-To: <20220720072404.16708-1-hlm3280@163.com>
From:   Neal Cardwell <ncardwell@google.com>
Date:   Wed, 20 Jul 2022 14:49:35 -0400
Message-ID: <CADVnQynXC=sEiYOcbSJBv2SML8gzooK_xitXt5uOqybTxj-VtQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2] tcp: fix condition for increasing pingpong count
To:     LemmyHuang <hlm3280@163.com>
Cc:     edumazet@google.com, davem@davemloft.net, dsahern@kernel.org,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Wei Wang <weiwan@google.com>,
        Yuchung Cheng <ycheng@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2022 at 3:25 AM LemmyHuang <hlm3280@163.com> wrote:
>
> When CONFIG_HZ defaults to 1000Hz and the network transmission time is
> less than 1ms, lsndtime and lrcvtime are likely to be equal, which will
> lead to hundreds of interactions before entering pingpong mode.
>
> Fixes: 4a41f453bedf ("tcp: change pingpong threshold to 3")
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: LemmyHuang <hlm3280@163.com>
> ---
> v2:
>   * Use !after() wrapping the values. (Jakub Kicinski)
>
> v1: https://lore.kernel.org/netdev/20220719130136.11907-1-hlm3280@163.com/
> ---
>  net/ipv4/tcp_output.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index 858a15cc2..c1c95dc40 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -172,7 +172,7 @@ static void tcp_event_data_sent(struct tcp_sock *tp,
>          * and it is a reply for ato after last received packet,
>          * increase pingpong count.
>          */
> -       if (before(tp->lsndtime, icsk->icsk_ack.lrcvtime) &&
> +       if (!after(tp->lsndtime, icsk->icsk_ack.lrcvtime) &&
>             (u32)(now - icsk->icsk_ack.lrcvtime) < icsk->icsk_ack.ato)
>                 inet_csk_inc_pingpong_cnt(sk);
>
> --

Thanks for pointing out this problem!

AFAICT this patch would result in incorrect behavior.

With this patch, we could have cases where tp->lsndtime ==
icsk->icsk_ack.lrcvtime and (u32)(now - icsk->icsk_ack.lrcvtime) <
icsk->icsk_ack.ato and yet we do not really have a ping-pong exchange.

For example, with this patch we could have:

T1: jiffies=J1; host B receives RPC request from host A
T2: jiffies=J1; host B sends first RPC response data packet to host A;
      -> calls inet_csk_inc_pingpong_cnt()
T3: jiffies=J1; host B sends second RPC response data packet to host A;
      -> calls inet_csk_inc_pingpong_cnt()

In this scenario there is only one ping-pong exchange but the code
calls inet_csk_inc_pingpong_cnt() twice.

So I'm hoping we can come up with a better fix.

A simpler approach might be to simplify the model and go back to
having a single ping-pong interaction cause delayed ACKs to be enabled
on a connection endpoint. Our team has been seeing good results for a
while with the simpler approach. What do folks think?


neal
