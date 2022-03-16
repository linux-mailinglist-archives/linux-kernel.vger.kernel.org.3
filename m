Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE3D4DABFE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 08:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354295AbiCPHqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 03:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354280AbiCPHqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 03:46:54 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD2360CC1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 00:45:40 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id u30-20020a4a6c5e000000b00320d8dc2438so1713315oof.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 00:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T87zTH0DkphGLesbWlrfLY37BYRGj5Dcsh6fZ7Tb2Io=;
        b=r1XEXiASBQDYZ5V4TV73TqXbRPkoxgosJdV49eyGOPLU/Y8tV87HdLL086XkKTPyfH
         MQFEjm1sPu217Jk6SkldXFKawlY+jNY7UCsWGUqkyeWmlP/qecm+wo74TK5aFSoha033
         nICfZT38j16WTKmtm7Bn7uryf7ZzPLxV0ECLZyJOs3fP6oB6mH6Zf5AdGdrTGttuoMUP
         2AY6haAAiY4SQTKEonDAlVrpH4NlpowXYIv/6DJYg9h13ril1KbWhfL+0NqaQD0xAlTE
         Tl65DdltW7v38+WjqbO+OnC0giEL1gO7f1YFUmLZCD8Pjp68bGn6s7naqY0Fmwmg9zrx
         NtCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T87zTH0DkphGLesbWlrfLY37BYRGj5Dcsh6fZ7Tb2Io=;
        b=ZOqvRPcETw+r++9WYldsaAF8/fHDLjjYQluy90xAYhtdi0NFewtp5U/X9Q427qvJET
         uXMu3aZIyqSH0MQSNGFlT4hLMm+/b6/6oZkkAD+dGTXi4fz/ycjjudWA4PVbV3VTA+dw
         7BpLQBNwuuGEHNNS0CRk3O01/MYUh0Ob2ph5YDdU39WSGT2eNond6cmo1V9wnOm8VRxA
         CMBlqaA3DtR1wL+ln3sW12MXKtf8n0jy0jALlfR6uRKmYPEeNBzpkqd16eaawXVEfmjX
         izhPGboQFX/2zQyjQDe2wxMSM2pwoknjhAn/d/FvBjPaSVCsGgpBjdMCP+Drgdn9pou0
         FR4A==
X-Gm-Message-State: AOAM532OKJHFDs2Uc1mQ+SoLSEN2wPUiSuhG1m0vWX2mJd/Rn2rFivT5
        LMd8/Yys6d1/DU1CwBQr6vNJ+9A0NAvPw3EtcUhIwQ==
X-Google-Smtp-Source: ABdhPJwzCR0t8OhcbK4m9h7T96CulLhfg0yY9yNAWIVbNLOCUnRCPgn7zHvpS8UjmFaaH1ztlBIszs4pNFw+zeng5vg=
X-Received: by 2002:a05:6870:9619:b0:d9:a25e:ed55 with SMTP id
 d25-20020a056870961900b000d9a25eed55mr2840688oaq.163.1647416739279; Wed, 16
 Mar 2022 00:45:39 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000009e7a1905b8295829@google.com> <00000000000003887a05da3e872c@google.com>
 <CAHk-=wj4HBk7o8_dbpk=YiTOFxvE9LTiH8Gk=1kgVxOq1jaH7g@mail.gmail.com>
In-Reply-To: <CAHk-=wj4HBk7o8_dbpk=YiTOFxvE9LTiH8Gk=1kgVxOq1jaH7g@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 16 Mar 2022 08:45:28 +0100
Message-ID: <CACT4Y+atgbwmYmiYqhFQT9_oHw5cD5oyp5bNyCJNz34wSaMgmg@mail.gmail.com>
Subject: Re: [syzbot] KASAN: out-of-bounds Read in ath9k_hif_usb_rx_cb (3)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     syzbot <syzbot+3f1ca6a6fec34d601788@syzkaller.appspotmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        ath9k-devel@qca.qualcomm.com, chouhan.shreyansh630@gmail.com,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:USB GADGET/PERIPHERAL SUBSYSTEM" 
        <linux-usb@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Zekun Shen <bruceshenzk@gmail.com>
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

On Tue, 15 Mar 2022 at 18:08, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, Mar 15, 2022 at 2:36 AM syzbot
> <syzbot+3f1ca6a6fec34d601788@syzkaller.appspotmail.com> wrote:
> >
> > syzbot suspects this issue was fixed by commit
> > 09688c0166e7 ("Linux 5.17-rc8")
>
> No, I'm afraid that means that the bisection is broken:
>
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=140283ad700000
>
> and yeah, looking at that log it looks like every single run has
>
>   testing commit [...]
>   run #0: crashed: KASAN: use-after-free Read in ath9k_hif_usb_rx_cb
>   ...
>   # git bisect good [...]
>
> and you never saw a "bad" commit that didn't have the issue, so the
> top-of-tree gets marked "good" (and I suspect you intentionally mark
> the broken case "good" in order to find where it got fixed, so you're
> using "git bisect" in a reverse way).
>
> I didn't look closer, but it does seem to not reproduce very reliably,
> maybe that is what confused the bot originally.

Hi Linus,

Thanks for taking a look. Yes, it's a "reverse" bisection that tries
to find the fix.
And your conclusion re flakiness looks right, there were few runs with
only 1/20 crashes.
But the bug looks to be fixed by something anyway. git log on the file
pretty clearly points to:

#syz fix: ath9k: Fix out-of-bound memcpy in ath9k_hif_usb_rx_stream
