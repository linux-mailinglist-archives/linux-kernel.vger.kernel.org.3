Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF035A15DE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 17:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242882AbiHYPc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 11:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242695AbiHYPcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 11:32:13 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65F25F9AB
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 08:32:09 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-32a09b909f6so551322777b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 08:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Ny1qGT8XIeO02r3/Kq1g4p9XYUL5D+ylo1nT+XyTdic=;
        b=BJ3r3pI6Oxx8+nf/xTb5DqmOUNbwQpBE7hp8FR9U2g38Hxfi078R4mmb5zZOJZr4u4
         aGC8dz04cbi1V21kZ0ro7IFa9/nRYMFUfyR1cAlzdsKIrdaFXAiVS8kmOtaZMwwvEJyq
         ssoIWWY0IwIijDp+NTHbjfI/2lPk19fk4qItDsaRB3E0h6ay+os2Ryqdh3cj4rWWDBns
         dkVyQcdGhXdaKlfRBnNG5SwffFwLCUPylb/cQQZ/Cbg3XPIc3m+Kmrx+1YicX0H1lopb
         aU6DimXqMQwt8tGcI3x/iXiSBfccyP+QNjNCfTfYpBLzX5OU1w+utKXrPW8HlRYiXjRw
         6O6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Ny1qGT8XIeO02r3/Kq1g4p9XYUL5D+ylo1nT+XyTdic=;
        b=n+ZbiGIuUTmFHrW9cdDzonpfGGMsQCJfG/eaF+goSB3TnLSxwCJ+Rg8tyWEyvPnb5k
         jMrzl1BCO7q+mB3acJY9AFWVUQdpKM8tPWzhunMSurSid4aX3enkZDXSs7GmqKlhuK8a
         ct5mP3tPvzDCumvIw9O00y/nKba/HS9Htf2UIfJl1xgOUWTo4TCstBd6LoaJU4X+3coV
         zjVSdu5Kk0XEXRToE2CQUSYDl4jQ4tiklCxXAEELEqocEoJyCdgNXiD1CiJJgDUB3rUs
         006szahvdGfE5M8EDFfSHh7F+zGwLLpY4O6M0K8Nkq/tbtA49my9eZchHcQEd+FLWk9a
         PTqQ==
X-Gm-Message-State: ACgBeo1g3RN6MyEsoBy1jQdvWRt6aLU3VUShKgtMeWwSoFzj5bd6Ky1U
        GtT8LwjjEybV0dOJ23o1ToLsv9rlLToNCQQd/mMPmTPstDjMXA==
X-Google-Smtp-Source: AA6agR6F9WmdxXtAt8lmqredia9KoUE7HjK1AotSbfIFZpY84rtFGgELIk4Hnt9wbI7qGHHyg73B6fH6USq5CoK8ZGs=
X-Received: by 2002:a81:4f17:0:b0:33d:b163:4711 with SMTP id
 d23-20020a814f17000000b0033db1634711mr4402501ywb.278.1661441528422; Thu, 25
 Aug 2022 08:32:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220825053738.476903-1-imagedong@tencent.com>
In-Reply-To: <20220825053738.476903-1-imagedong@tencent.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 25 Aug 2022 08:31:56 -0700
Message-ID: <CANn89iJTW6DDrzfzya8-B14SkhCURopnHqQV9JqvOqSCXnQy2g@mail.gmail.com>
Subject: Re: [PATCH net-next] net: skb: fix kfree_skb event output error in perf
To:     Menglong Dong <menglong8.dong@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        David Miller <davem@davemloft.net>,
        Menglong Dong <imagedong@tencent.com>,
        David Ahern <dsahern@kernel.org>,
        Hao Peng <flyingpeng@tencent.com>,
        Dongli Zhang <dongli.zhang@oracle.com>,
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

On Wed, Aug 24, 2022 at 10:37 PM <menglong8.dong@gmail.com> wrote:
>
> From: Menglong Dong <imagedong@tencent.com>
>
> As Eric reported, the 'reason' field is not presented when trace the
> kfree_skb event by perf:
>
> $ perf record -e skb:kfree_skb -a sleep 10
> $ perf script
>   ip_defrag 14605 [021]   221.614303:   skb:kfree_skb:
>   skbaddr=0xffff9d2851242700 protocol=34525 location=0xffffffffa39346b1
>   reason:
>
> The cause seems to be passing kernel address directly to TP_printk(),
> which is not right.

Why ?

It seems this adds an expensive copy of a string that should reside in
rodata section of vmlinux, thus can not disappear...
(Also the ring buffer entry will have a dynamic size ?)

trace_safe_str() is using is_kernel_rodata() which should return true
for drop_reasons[X] ?

$ grep drop_reasons net/core/dropreason_str.c
const char * const drop_reasons[] = {
...



>
> Therefore, fix this by adding a '__string' field to the TP_STRUCT of
> kfree_skb, which is 'reason_str', and passing it to TP_printk().
>
> (Not sure if we should still keep the 'reason' field in
> TP_STRUCT__entry)

Maybe for event/trace filtering purposes ?

>
> Reported-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Menglong Dong <imagedong@tencent.com>
> ---
>  include/trace/events/skb.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/include/trace/events/skb.h b/include/trace/events/skb.h
> index 45264e4bb254..7235554141c3 100644
> --- a/include/trace/events/skb.h
> +++ b/include/trace/events/skb.h
> @@ -24,6 +24,7 @@ TRACE_EVENT(kfree_skb,
>                 __field(void *,         location)
>                 __field(unsigned short, protocol)
>                 __field(enum skb_drop_reason,   reason)
> +               __string(reason_str, drop_reasons[reason])
>         ),
>
>         TP_fast_assign(
> @@ -31,11 +32,12 @@ TRACE_EVENT(kfree_skb,
>                 __entry->location = location;
>                 __entry->protocol = ntohs(skb->protocol);
>                 __entry->reason = reason;
> +               __assign_str(reason_str, drop_reasons[reason]);
>         ),
>
>         TP_printk("skbaddr=%p protocol=%u location=%p reason: %s",
>                   __entry->skbaddr, __entry->protocol, __entry->location,
> -                 drop_reasons[__entry->reason])
> +                 __get_str(reason_str))
>  );
>
>  TRACE_EVENT(consume_skb,
> --
> 2.37.2
>
