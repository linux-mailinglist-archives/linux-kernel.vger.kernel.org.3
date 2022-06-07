Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E30254231D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241101AbiFHCHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 22:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1586166AbiFGXuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 19:50:50 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924B64B09A6
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 15:39:13 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id a10so17049525ioe.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 15:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PZjTnNBEFjMERm/zBB1Q5SKIoGAjovs1DRR0WKNL5cQ=;
        b=C0tlUMN7jBA6dqEdpuV1EemFXOL4FZvtkee+TxrlYMNuA4qDyrxgjkxmjPFo1/Y4Xb
         J0ZLjxtF+RAVa02b7ykgDbxzqYXJSxKY0dpqxRPLC3YqnJYc92MGM1pAV1t8jZpNiy9g
         ieUFVjN6Qn7KTyN7UeW3VOKpjffDayidprqpvfbsaRF8AIsUe/JX0UjYHJicstH+7Isp
         1bX+gu6LZS9E9dEdBVbu4u6goqW2uWh8ED8DNlVgDUPQ0jB5cLBazWlvL5gnFOr1xlsv
         DPj7+FKgX3rrT08F3c+onVN63c7duPAls+X7xTgvcfRDL4rELIAccWwjHVEf1DBIsRDI
         meTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PZjTnNBEFjMERm/zBB1Q5SKIoGAjovs1DRR0WKNL5cQ=;
        b=NztEBjEWyTk1iuw2Z5b/vYK0cXMHzuDCgosJlUIkD8LhtoskRpcXku3KWEUQ5md7gi
         Usa2aIqp4S8C2DQAfiG6NGUGZHLX/Xt4pn3Qjj7D6tMIRBk4uc4DBMJN9w4nZeL9l4kn
         ngRqhf8LZEHMMEwEBxE+YMyiUndIcUATaM4gdd5h72RDnN5paF/1Ng0Kd1PDIQQXqxek
         /tQTfAyn46VQZoOFd/qCKwlolXgeCzANhYUWgodoTjeaz2KyD6N3qUQSbyE/gWznI1UV
         yZG/bZ+pqzNppXm5q4zUWFn1ncd5pqjfiiexX6yDZsl4aYGzfaLsFLYtqiy1hXdUn9oJ
         ja3A==
X-Gm-Message-State: AOAM531EJf7Muwgfje0GYoAyo9qqqXb2gKBLSnQLAru1r7YPkIG+19YR
        cvaYW/NsJSHDZMwEboHEd1OgMeu+JgMnkYvMmg9vInCdgY4=
X-Google-Smtp-Source: ABdhPJzzr1lRHONyU3kpmNxcrVHf49STF99H32Yq72ipH19LqeUpU7SoZ1xC0Blsv7ZJepEu+YtMbPjBDM/lhgq6k/k=
X-Received: by 2002:a05:6638:12d5:b0:32e:c4fd:d794 with SMTP id
 v21-20020a05663812d500b0032ec4fdd794mr15750996jas.265.1654641550419; Tue, 07
 Jun 2022 15:39:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220607013844.213446-1-jmaxwell37@gmail.com> <165458990767.3884.13816861537144030058@kwain>
In-Reply-To: <165458990767.3884.13816861537144030058@kwain>
From:   Jonathan Maxwell <jmaxwell37@gmail.com>
Date:   Wed, 8 Jun 2022 08:38:34 +1000
Message-ID: <CAGHK07BPXD-qu-ufSL6dfVkSEzyk9p+_hL7AhmkZhu4eF11kKA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: bpf: fix request_sock leak in filter.c
To:     Antoine Tenart <atenart@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>, cjebpub@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 7, 2022 at 6:18 PM Antoine Tenart <atenart@kernel.org> wrote:
>
> Hi Jon,
>
> This patch is targeted at the networking subsystem, as such (see the
> "NETWORKING [GENERAL]" section in MAINTAINERS), you should send it to
> netdev@vger.kernel.org and to the networking maintainers (David, Jakub,
> Paolo & Eric).
>
> This also fixes an issue and should be targeted at [net] instead of
> [net-next]. Because of this you'll also need a Fixes: tag.
>
> Quoting Jon Maxwell (2022-06-07 03:38:44)
> > A customer reported a request_socket leak in a Calico cloud environment. We
> > found that a BPF program was doing a socket lookup with takes a refcnt on
> > the socket and that it was finding the request_socket but returning the parent
> > LISTEN socket via sk_to_full_sk() without decrementing the child request socket
> > 1st, resulting in request_sock slab object leak. This patch retains the
> > existing behaviour of returning full socks to the caller but it also decrements
> > the child request_socket if one is present before doing so to prevent the leak.
> >
> > Thanks to Curtis Taylor for all the help in diagnosing and testing this. And
> > thanks to Antoine Tenart for the reproducer and patch input.
> >
> > Signed-off-by: Jon Maxwell <jmaxwell37@gmail.com>
> > Tested-by: Curtis Taylor <cjebpub@gmail.com>
> > Co-developed-by: Antoine Tenart <atenart@kernel.org>
>
> You need to put my SoB here when using the above tag. You'll also need
> to put your SoB at the end of all the above tags instead of the top.
>
> > @@ -6514,13 +6514,14 @@ __bpf_sk_lookup(struct sk_buff *skb, struct bpf_sock_tuple *tuple, u32 len,
> >  {
> >         struct sock *sk = __bpf_skc_lookup(skb, tuple, len, caller_net,
> >                                            ifindex, proto, netns_id, flags);
> > +       struct sock *sk1 = sk;
> >
> >         if (sk) {
> >                 sk = sk_to_full_sk(sk);
> > -               if (!sk_fullsock(sk)) {
> > -                       sock_gen_put(sk);
>
> I'd suggest to add a comment here to explain why sock_gen_put is called
> on the original sk.
>
> > +               if (!sk_fullsock(sk1))
> > +                       sock_gen_put(sk1);
> > +               if (!sk_fullsock(sk))
> >                         return NULL;
> > -               }
> >         }
> >
> >         return sk;
> > @@ -6551,13 +6552,14 @@ bpf_sk_lookup(struct sk_buff *skb, struct bpf_sock_tuple *tuple, u32 len,
> >  {
> >         struct sock *sk = bpf_skc_lookup(skb, tuple, len, proto, netns_id,
> >                                          flags);
> > +       struct sock *sk1 = sk;
> >
> >         if (sk) {
> >                 sk = sk_to_full_sk(sk);
> > -               if (!sk_fullsock(sk)) {
> > -                       sock_gen_put(sk);
>
> Ditto.
>
> > +               if (!sk_fullsock(sk1))
> > +                       sock_gen_put(sk1);
> > +               if (!sk_fullsock(sk))
> >                         return NULL;
> > -               }
> >         }
> >
> >         return sk;
>
> Thanks!
> Antoine

Thanks Antoine, ack I'll do that and resubmit.
