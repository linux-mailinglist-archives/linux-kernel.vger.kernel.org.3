Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F68E530830
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 06:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbiEWECs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 00:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234677AbiEWECn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 00:02:43 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9497112602
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 21:02:40 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id gh17so13031821ejc.6
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 21:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LKAJkiWmW+IPGP1bXDKaiFUYpV46xzegx9oR3356eFs=;
        b=gVnl8EntcpMgwE29/c+bjMIurGfrhaKvHuVgNwokXlHj8f0HpRtVO2iTuf2t84JtcC
         4T8IWNKbLcn4nS8C8o54KCWd2cK+9MGM+jMuIbj4JCyR7HUtw+Hfe5LSZl4Mo/IfVzMY
         D4Ai8Dmf6YrLPSwpNE0xjpX1Lrp517SuOajXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LKAJkiWmW+IPGP1bXDKaiFUYpV46xzegx9oR3356eFs=;
        b=mNwGDb0ShfxvsBzRC9zr36BDmXWHP3pobdJdjaKwujFIBhZd6pZ7jwJwzLkYDArEZm
         wF0EAqKYK5jWRygC/4B8adO2NkU3ytwXG4wlNPw5T5uGtpG1nJg0xZBOHDIpm9tZquqE
         cYn7G5P+8PBx+Ke7+RtKQHdA/9rjoWRAdn9f5lUthOOaBMaxr8gtU/pcV14OrUjea9OJ
         D6tTKga0Er+wZG1iLruyB4Y8hc1psbgpMUdQiIaTSvpR36ShQzbJQ7Ssw6GeUIJkiWKe
         nFa5QWUZvTvoKD5d0aYCqMBjDwGPr//MBQHd3fpZgOA+F2qIWGlRKIodbg64bCZ34c4h
         9ppA==
X-Gm-Message-State: AOAM5329TLywhzXf8iwwp5UGvbXl6DrJkd4gXi2oZ6allnD2bo21di6F
        DA/6e03mYahEPjtIaTEZiXlwzfV5Qc6xtS1z
X-Google-Smtp-Source: ABdhPJxYY5hfavYPXPNNoWdX6IWyMCl27vVecMKpze9xNHKH7ydKtvCO+/eo/0vakmAlxPjRis74fQ==
X-Received: by 2002:a17:907:dab:b0:6fe:b379:ad3f with SMTP id go43-20020a1709070dab00b006feb379ad3fmr11282765ejc.223.1653278558975;
        Sun, 22 May 2022 21:02:38 -0700 (PDT)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id o18-20020aa7d3d2000000b0042a96c77e9esm7545871edr.91.2022.05.22.21.02.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 May 2022 21:02:38 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id r23so19492735wrr.2
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 21:02:38 -0700 (PDT)
X-Received: by 2002:a5d:5484:0:b0:20f:bf64:cae1 with SMTP id
 h4-20020a5d5484000000b0020fbf64cae1mr10390593wrv.281.1653278194596; Sun, 22
 May 2022 20:56:34 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000c1925305ac997812@google.com> <000000000000b6b4eb05dfa1b325@google.com>
In-Reply-To: <000000000000b6b4eb05dfa1b325@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 22 May 2022 20:56:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=whH5pmgyzE6+6C==p2VQFUgGiPhSwX=R2zKs+iHZuX7_A@mail.gmail.com>
Message-ID: <CAHk-=whH5pmgyzE6+6C==p2VQFUgGiPhSwX=R2zKs+iHZuX7_A@mail.gmail.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in corrupted (4)
To:     syzbot <syzbot+48135e34de22e3a82c99@syzkaller.appspotmail.com>
Cc:     applications@thinkbigglobal.in, David Miller <davem@davemloft.net>,
        gustavo@padovan.org, Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Ingo Molnar <mingo@redhat.com>, Michal Marek <mmarek@suse.com>,
        Netdev <netdev@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 22, 2022 at 4:01 PM syzbot
<syzbot+48135e34de22e3a82c99@syzkaller.appspotmail.com> wrote:
>
> The issue was bisected to:
>
> commit c470abd4fde40ea6a0846a2beab642a578c0b8cd
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Sun Feb 19 22:34:00 2017 +0000
>
>     Linux 4.10

Heh. That looks very unlikely, so the bisection seems to sadly have
failed at some point.

At least one of the KASAN reports (that "final oops") does look very
much like the bug fixed by commit 1bff51ea59a9 ("Bluetooth: fix
use-after-free error in lock_sock_nested()"), so this may already be
fixed, but who knows...

But that "update Makefile to 4.10" is not the cause...

               Linus
