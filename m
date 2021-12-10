Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42C2C4702FA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 15:38:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242293AbhLJOli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 09:41:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31297 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242268AbhLJOlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 09:41:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639147080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7XKxiU3MgedSihivIPXfbGZmn05XT0xvG+ufQk1N+WQ=;
        b=O2v3khXqlqGhprArHCm+j3cE7iMVHDmEY6q8e601cym6gAbQKZDz7LQLmQ5298kCXSTw2i
        dAxA2xCiwtZizXNbbLJ/zjGAIVLm8/Zv8aoHI96uZvISMZL4k4HR7+tl+ZfBWGeze4n7EU
        p1DJ4rH0LwkcGByCCryOKcKmnYLQ0zI=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-28-CfIpzXDQMPWnJFqH8jz-YQ-1; Fri, 10 Dec 2021 09:37:59 -0500
X-MC-Unique: CfIpzXDQMPWnJFqH8jz-YQ-1
Received: by mail-qk1-f200.google.com with SMTP id bj32-20020a05620a192000b0046dcca212b6so10436250qkb.6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 06:37:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=7XKxiU3MgedSihivIPXfbGZmn05XT0xvG+ufQk1N+WQ=;
        b=oo395zfrzilijeiUG2iAeBSvzUBFOW4orQ7A555evvbX/DMmIgbcQ5+SJ2BKAofyTf
         MrAQa13LPLccr9aguKPgKuoUOBvPj5rmZYw6Z3hRe5UQNtLhq19pOkD2Giz0DcFX4Qnr
         Azc66pnMeWglduSnsOYRW7y+MyyOjP8kacv0TACaGrp5DVZBoCE+tYogOhNUaSaV0ebp
         4vwUh1TcFqrsWpg5Dx1s3hDBjWNCrLmmXG054WX24gnKTVp83cQOsW2VsPgQCMf3E7sh
         8CYRokUWyadn9poqUuRgrSyFPrJjd67KV6GTc4aosiIzAKMbaMmgilVeBonFWYfF4z6R
         us8A==
X-Gm-Message-State: AOAM531Grz+qy1LVK3G+9jNdsQWwtej60D1zDImP3xkhZ3MokT50R7Gk
        b0WHXgG4jmr06wuXp1tjsLDVKImCMSnhZ1f2TRc0FmIcE8NmD7XIrkWtxtsARBQN/pxEb8huV5Z
        N57htq2wgKamC341ozshXFxWs
X-Received: by 2002:a05:622a:48e:: with SMTP id p14mr26872971qtx.553.1639147078956;
        Fri, 10 Dec 2021 06:37:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzmHHLdtzJvWqOcnVU8AcC3NlrCPmChU0xnKTY5iq+BqjhLk/HYFTvIUg/aaHe9l0TjIZv9Bg==
X-Received: by 2002:a05:622a:48e:: with SMTP id p14mr26872944qtx.553.1639147078722;
        Fri, 10 Dec 2021 06:37:58 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-237-50.dyn.eolo.it. [146.241.237.50])
        by smtp.gmail.com with ESMTPSA id l17sm1224892qkj.85.2021.12.10.06.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 06:37:58 -0800 (PST)
Message-ID: <d94b3f8903fe743583cbee16ac60528bd77b1be6.camel@redhat.com>
Subject: Re: [syzbot] general protection fault in inet_csk_accept
From:   Paolo Abeni <pabeni@redhat.com>
To:     Eric Dumazet <edumazet@google.com>,
        syzbot <syzbot+e4d843bb96a9431e6331@syzkaller.appspotmail.com>,
        Florian Westphal <fw@strlen.de>
Cc:     davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org
Date:   Fri, 10 Dec 2021 15:37:54 +0100
In-Reply-To: <CANn89iKJY21Y3MZMXBpVqNm6BhudgfE+c-v7EU8gMUcbEFVs+A@mail.gmail.com>
References: <0000000000004c679505d2c8c1d4@google.com>
         <CANn89iKJY21Y3MZMXBpVqNm6BhudgfE+c-v7EU8gMUcbEFVs+A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.1 (3.42.1-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-12-10 at 03:13 -0800, Eric Dumazet wrote:
> On Fri, Dec 10, 2021 at 3:09 AM syzbot
> <syzbot+e4d843bb96a9431e6331@syzkaller.appspotmail.com> wrote:
> > 
> > Hello,
> > 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    2a987e65025e Merge tag 'perf-tools-fixes-for-v5.16-2021-12..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=166f73adb00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=221ffc09e39ebbd1
> > dashboard link: https://syzkaller.appspot.com/bug?extid=e4d843bb96a9431e6331
> > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16280ae5b00000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1000fdc5b00000
> > 
> > The issue was bisected to:
> > 
> 
> Note to MPTCP maintainers, I think this issue is MPTCP one, 

Indeed it is, thanks for the head-up!

> and the bisection result shown here seems not relevant.

yep.

> The C repro is however correct, I trigger an immediate crash.

The repro is not triggering here - but I'm using a different kconfig.
Still the repro itself gives a good hint on the root cause. I'm testing
a patch with syzbot.

Thanks!

Paolo


