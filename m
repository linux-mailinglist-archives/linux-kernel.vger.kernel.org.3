Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB61A5A2002
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 06:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244327AbiHZErW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 00:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiHZErT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 00:47:19 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0FACE31B
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 21:47:19 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id n65-20020a17090a5ac700b001fbb4fad865so473205pji.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 21:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=rR0iigeJsPMEDluYstWDFc3cN935FUMoEwAJsGT7cjM=;
        b=XZBlcnDfJ8AvdIyOUIrFtaQt93ozzW139bgeTsaWUwJywzTFv9qxwL61a8AxVP5YrH
         jfw1npcuExfWaqEWVSy47GSq/5rwJu5iitEZLBBSRX9wQC8plHCLRtAs0txc4eCaZLVL
         BODYGiQJo5n9tlx26pw5a93UkTFSg91AyB1FidN3ZQB3cWCwHqkbrNT2ksIwN0M/RyqM
         utcOeGmC21ozlXelIPtq45YtGGYuwHsci2res+xyLvX2DWvfHt3MP21KMCXr3w3IQOkv
         YikzjdmNg8Nd8/RXg6TPc5u9LJ/Msf/seW/NKsGxh9rIs1R6l5mrfAdt8T0KGQwlOSvZ
         xWAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=rR0iigeJsPMEDluYstWDFc3cN935FUMoEwAJsGT7cjM=;
        b=ln97YRBnkxoHz6JG8jK67MLjBsTYq+h8rSbRgIzgRnUIF86c+iePARZCS6JR50CsHc
         G8p902NKxWYht/bZmq7ITqD2sJU7jaq4eFv5jPkMhlFw3yjUye3OL520MPe0nlzIxK24
         6ETekpZThlP/pldNxBUlE2MS1v68uYtDwNjGTeldZnizDVSQQiKBr13iDinvamNR3lZ4
         TOcWnIiWZGmXS2+sV9NleAshWK7Y86zzeoBsGnt65l/V+zcr8X26hy0tttJ8PjLZyDGD
         oM9PD32QPGK78oWSkHgBb8WzKCKqATMjGZ4p4bFEebdxnI+r77TyL5o+OBVSnISVD3Yr
         PY2g==
X-Gm-Message-State: ACgBeo1drxlQw4Yr5McOZSWBFMwb2aRvSmz++TVAyFuArFEe2djvCG5p
        6B7rge/5/yTw8NYAMW4v/2slbSIaPmutfBfSuXA=
X-Google-Smtp-Source: AA6agR6xhNBK+bE28RqK9MkyCIAA8jMxtHtdpYb7aIg+m2HMt5unSQcuZrzqc4Q7cllHqRco4RJvOYd1mwS+cygJ5zM=
X-Received: by 2002:a17:90b:35c1:b0:1fd:6992:f82a with SMTP id
 nb1-20020a17090b35c100b001fd6992f82amr342989pjb.188.1661489238797; Thu, 25
 Aug 2022 21:47:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220825053738.476903-1-imagedong@tencent.com> <CANn89iJTW6DDrzfzya8-B14SkhCURopnHqQV9JqvOqSCXnQy2g@mail.gmail.com>
In-Reply-To: <CANn89iJTW6DDrzfzya8-B14SkhCURopnHqQV9JqvOqSCXnQy2g@mail.gmail.com>
From:   Menglong Dong <menglong8.dong@gmail.com>
Date:   Fri, 26 Aug 2022 12:47:07 +0800
Message-ID: <CADxym3bw8H7E6i1CuV=AU6X+AnzWgx0YOwzcJVBjbTALpt2iFA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: skb: fix kfree_skb event output error in perf
To:     Eric Dumazet <edumazet@google.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        David Miller <davem@davemloft.net>,
        Menglong Dong <imagedong@tencent.com>,
        David Ahern <dsahern@kernel.org>,
        Hao Peng <flyingpeng@tencent.com>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>
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

On Thu, Aug 25, 2022 at 11:32 PM Eric Dumazet <edumazet@google.com> wrote:
>
> On Wed, Aug 24, 2022 at 10:37 PM <menglong8.dong@gmail.com> wrote:
> >
> > From: Menglong Dong <imagedong@tencent.com>
> >
> > As Eric reported, the 'reason' field is not presented when trace the
> > kfree_skb event by perf:
> >
> > $ perf record -e skb:kfree_skb -a sleep 10
> > $ perf script
> >   ip_defrag 14605 [021]   221.614303:   skb:kfree_skb:
> >   skbaddr=0xffff9d2851242700 protocol=34525 location=0xffffffffa39346b1
> >   reason:
> >
> > The cause seems to be passing kernel address directly to TP_printk(),
> > which is not right.
>
> Why ?
>

I think it is because of how perf passes data to the user space. From
what 'perf_output_sample()' do, we can know that perf passes the data
of entry (with other data) to the user, and the user generates the output
string from the format string (which can be obtained from
/sys/kernel/debug/tracing/event/skb/kfree_skb/format) and the entry data.

Therefore, perf can't get the string of drop reasons from the entry, only
the enum.

> It seems this adds an expensive copy of a string that should reside in
> rodata section of vmlinux, thus can not disappear...
> (Also the ring buffer entry will have a dynamic size ?)
>

It indeed will add additional cost, but it seems unavoidable. In the old
version, __print_symbolic() is used, which will loop all the drop reason
from a array and find corresponding string:

    TP_printk("skbaddr=%p protocol=%u location=%p reason: %s",
          __entry->skbaddr, __entry->protocol, __entry->location,
          __print_symbolic(__entry->reason,
                   TRACE_SKB_DROP_REASON))

And I think the cost of coping strings may be less than this loop? as the
drop reasons are getting more and more.

> trace_safe_str() is using is_kernel_rodata() which should return true
> for drop_reasons[X] ?
>
> $ grep drop_reasons net/core/dropreason_str.c
> const char * const drop_reasons[] = {
> ...
>
>
>
> >
> > Therefore, fix this by adding a '__string' field to the TP_STRUCT of
> > kfree_skb, which is 'reason_str', and passing it to TP_printk().
> >
> > (Not sure if we should still keep the 'reason' field in
> > TP_STRUCT__entry)
>
> Maybe for event/trace filtering purposes ?
>
> >
> > Reported-by: Eric Dumazet <edumazet@google.com>
> > Signed-off-by: Menglong Dong <imagedong@tencent.com>
> > ---
> >  include/trace/events/skb.h | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/trace/events/skb.h b/include/trace/events/skb.h
> > index 45264e4bb254..7235554141c3 100644
> > --- a/include/trace/events/skb.h
> > +++ b/include/trace/events/skb.h
> > @@ -24,6 +24,7 @@ TRACE_EVENT(kfree_skb,
> >                 __field(void *,         location)
> >                 __field(unsigned short, protocol)
> >                 __field(enum skb_drop_reason,   reason)
> > +               __string(reason_str, drop_reasons[reason])
> >         ),
> >
> >         TP_fast_assign(
> > @@ -31,11 +32,12 @@ TRACE_EVENT(kfree_skb,
> >                 __entry->location = location;
> >                 __entry->protocol = ntohs(skb->protocol);
> >                 __entry->reason = reason;
> > +               __assign_str(reason_str, drop_reasons[reason]);
> >         ),
> >
> >         TP_printk("skbaddr=%p protocol=%u location=%p reason: %s",
> >                   __entry->skbaddr, __entry->protocol, __entry->location,
> > -                 drop_reasons[__entry->reason])
> > +                 __get_str(reason_str))
> >  );
> >
> >  TRACE_EVENT(consume_skb,
> > --
> > 2.37.2
> >
