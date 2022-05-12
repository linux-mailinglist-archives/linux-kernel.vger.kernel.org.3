Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D878452563F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 22:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352593AbiELUJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 16:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354491AbiELUJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 16:09:37 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2EB2670AA
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 13:09:36 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-2f7ca2ce255so69283987b3.7
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 13:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+RvotmzlXXJLUjxfnHqDPaXa716Ci6O256j8ra0+f68=;
        b=g0GsQlOvnxr8GQ9ath+D+MdVdAHaXyLhTt/CfZs6l7Ar6F5uYBhvWa/XylZxrFWxcQ
         1zhc0mGLTwT/0Gn4apeojjEtse3mcuj2qV12KNPqhgeW8H4kvbEaeAEmZYV+3CBBvbbD
         0a0AxJRm/bKaYOrnj19ALFto28G04rrbhQHNnrDGJJAAHE4ublazO9V9zqlX6PYJqXBk
         V5sixDdKEnFlkmi5J3oOHMhQauKmGdn5wIgz2y4L1g1cH7P0rdoOKpiN0dH2W5UDJx5K
         PVnQKhYAKKkZDtE9JtOKWryEJqgiXLqnChGzmoY4VI1E5YBSF4P5bNDO3EZ8kLu2sv0o
         iWWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+RvotmzlXXJLUjxfnHqDPaXa716Ci6O256j8ra0+f68=;
        b=1WkyPluMUv/BM/9mpM+euNzxEgbWh8NkYHlNORWPxJ1U40FnqTzsu6Tt6vCijSPZk2
         9TIRl8wORXSltHn4NH9+dydf8UlkT8ocTwFEWoco5BVlLGENQ3vQtPRroOY8Q1jd/MDE
         QBNYRpXpFSyxHZo3FEKRNHSmhohk+Xc7QsXgohU8ojRrF04PAlt6uW+l1sNcemJPSqpY
         N7qKcUirMsX3evOJY/HV4grZ69YHR15yDkXXyYNFV7Nqrz+tl4DLcFFA7HWsyb+UDS3G
         eaK9wgm7PCsOyyUkFxAp5OU7kfkXWzRvYgdtYvx2UC6PH7/tQHFkh06xTdcvQhbpbjHO
         GOAg==
X-Gm-Message-State: AOAM53084XWdhdLxk2BGbvF87I7XpSTVX07Lk8Hps9ovRRwXMvY7hpAP
        2qwwD8EnGP4Ssb0CZk48gTEorUfVNHp6Ru3ZAEn5zE3aN8VH7A==
X-Google-Smtp-Source: ABdhPJzHB6TV7hqi8N1J/X4kzAG33AMHh2DD3/6XgC/AEnve02kflDN19GN7MbWeOj6f4a1Ls/b+/1usqV+zqa2J4CM=
X-Received: by 2002:a81:5603:0:b0:2f8:3187:f37a with SMTP id
 k3-20020a815603000000b002f83187f37amr1872082ywb.255.1652386175023; Thu, 12
 May 2022 13:09:35 -0700 (PDT)
MIME-Version: 1.0
References: <93323bba-476e-f821-045c-9fe942143da9@gmail.com> <CANn89iKjt1wpGk1dqqnYYx3r9UzEc3rwNtvBQ1O2dVToY_7rBQ@mail.gmail.com>
In-Reply-To: <CANn89iKjt1wpGk1dqqnYYx3r9UzEc3rwNtvBQ1O2dVToY_7rBQ@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 12 May 2022 13:09:23 -0700
Message-ID: <CANn89i+aLWGcBe=n2iRR4chvkpfBO_V7c1P9mqA3fBS59CzjUg@mail.gmail.com>
Subject: Re: BUG: TCP timewait sockets survive across namespace creation in net-next
To:     Leonard Crestez <cdleonard@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>,
        netdev <netdev@vger.kernel.org>,
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

On Thu, May 12, 2022 at 11:13 AM Eric Dumazet <edumazet@google.com> wrote:
>
> On Thu, May 12, 2022 at 11:01 AM Leonard Crestez <cdleonard@gmail.com> wrote:
> >
> > Hello,
> >
> > It appears that in recent net-next versions it is possible for sockets
> > in the timewait state to survive across namespace add/del. Timewait
> > sockets are inserted into a global hash and only the sock_net value is
> > compared when they are enumerated from interfaces like /proc/net/tcp and
> > inet_diag. Old TW sockets are not cleared after namespace delete and
> > namespaces are allocated from a slab and thus their pointers get reused
> > a lot, when that happens timewait sockets from an old namespace will
> > show up in the new one.
> >
> > This can be reproduced by establishing a TCP connection over a veth pair
> > between two namespaces, closing and then recreating those namespaces.
> > Old timewait sockets will be visible and it happens quite reliably,
> > often on the first iteration. I can try to provide a script for this.
> >
> > I can't point to specific bugs outside of tests that explicitly
> > enumerate timewait sockets but letting sk_net be a dangling pointer
> > seems very dangerous. It also violates the idea of network namespaces
> > being independent and isolated.
> >
> > This does not happen in 5.17, I bisected this behavior to commit
> > 0dad4087a86a ("tcp/dccp: get rid of inet_twsk_purge()")
> >
>
> Thanks for the report.
>
> I guess we will need to store the (struct net)->net_cookie to
> disambiguate the case
> where a new 'struct net' is reusing the same storage than an old one.

Oh well, too many changes would be needed.
I will send a revert, thanks.
