Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 822BE47A52D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 07:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237628AbhLTGx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 01:53:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234245AbhLTGx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 01:53:57 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F73C061574
        for <linux-kernel@vger.kernel.org>; Sun, 19 Dec 2021 22:53:57 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id 35-20020a9d08a6000000b00579cd5e605eso11506748otf.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Dec 2021 22:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1mCjlLyB/hr7kOH2wdl8Y3S5J5sgaMUYSj4diCluHMU=;
        b=QCiUOGRFKDvoAPrOxdicBzRpKxywBtYA3FQVyizYrOJkRSVA8w8pRkXf9iNvfomRK0
         acRbCx+cWJNMbZgeNL0Pom3e8omIogIKSyvXhQdIxd0+aHLfKECNJwRNmH87OgNDODBa
         39eF6wXCU3QgVQtz+ycyjZ4MGZKUmVhRhUsArkqVOVBsrqLwP2uc2pLQ2gyJZ8PFgUb2
         sjp1PHpOzZybjTMxADWbZ5tQg3/BpJc9pNTBc6QzpNYTC1Bsq2+W0G/F9mhz4mcbAKpR
         TbnEMxrIHpm10T1awgd5ZpC3MdnixLz1ZN5ORE8PHTawS/dlfXGc1uL9/Tcyj+Mx6qX2
         RgXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1mCjlLyB/hr7kOH2wdl8Y3S5J5sgaMUYSj4diCluHMU=;
        b=ocREK7Ryylkz29GhAZRA/euJrKVXTnMq3X9GJ0NAriozBs9x72xeBIxZxlNTqpedIR
         +Bss1XroZ2+Scy+ustmfqhrBCW9msz60yV5UA7H5MM4LyIF8wAusHpci9CI2r6b0cM5J
         7uwvOqgn31C47z+dZlCdbIvYVY7G/STTvQyjrOaRIFX8sM60tyapF+iEcBjJ+obTt+Ut
         4ENGEH/hw7mp2AhNW2qpuk/w7utGxDucUNDzBGJCbiAjLeV8QCJIazH+TBITTlQ6kTaN
         RY29jM4BY6FeXGTZVy8zz6DnAdut02LVYkhQMxPuWGU+a7vAJ/dNyYfVQBBdayutylhx
         SiWA==
X-Gm-Message-State: AOAM533tJesJtJoBw9eDGgHteQRzvy9EnoMzb/F9v0CkTYx3Ytq2WPyW
        LmKu4LKkGMNR4GWpPbLoFocx5aQq9SgjraBlvyr5mQ==
X-Google-Smtp-Source: ABdhPJwXQ439oJ+c9KcQ4qYRzZ3F1IaIYlQnSzexr/F3/DP6FANIf6NjLWY5QeEfUHIfws3WidVmc5gaEE42wwbiLOo=
X-Received: by 2002:a05:6830:2425:: with SMTP id k5mr10268366ots.319.1639983236347;
 Sun, 19 Dec 2021 22:53:56 -0800 (PST)
MIME-Version: 1.0
References: <0000000000000a337b05bb76ff8b@google.com> <000000000000ba831905d367af3e@google.com>
In-Reply-To: <000000000000ba831905d367af3e@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 20 Dec 2021 07:53:45 +0100
Message-ID: <CACT4Y+aPM1nYBMi7QWswWCzPb1a9tb1BA3cznXuDo=sFB2hPsg@mail.gmail.com>
Subject: Re: [syzbot] INFO: task hung in disconnect_work
To:     syzbot <syzbot+060f9ce2b428f88a288f@syzkaller.appspotmail.com>
Cc:     davem@davemloft.net, johannes.berg@intel.com,
        johannes@sipsolutions.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, phind.uet@gmail.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Dec 2021 at 09:46, syzbot
<syzbot+060f9ce2b428f88a288f@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit 563fbefed46ae4c1f70cffb8eb54c02df480b2c2
> Author: Nguyen Dinh Phi <phind.uet@gmail.com>
> Date:   Wed Oct 27 17:37:22 2021 +0000
>
>     cfg80211: call cfg80211_stop_ap when switch from P2P_GO type
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13ad179db00000
> start commit:   f40ddce88593 Linux 5.11
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=51ab7ccaffffc30c
> dashboard link: https://syzkaller.appspot.com/bug?extid=060f9ce2b428f88a288f
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1217953cd00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13baa822d00000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: cfg80211: call cfg80211_stop_ap when switch from P2P_GO type
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

Looks reasonable:

#syz fix: cfg80211: call cfg80211_stop_ap when switch from P2P_GO type
