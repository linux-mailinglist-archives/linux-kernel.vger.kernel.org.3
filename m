Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D59555C2F2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232692AbiF0HMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 03:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232688AbiF0HMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 03:12:12 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA655F85
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 00:12:11 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id s10so9841136ljh.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 00:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NJs+HTqgWi+OhM79ulnjzPkQM3clLA8Pp7b2ooLPT2s=;
        b=s7/qKBgZTW6YrxSaLJsLvO8v+LSLyNHX0IMAvtFPiCznHhfES2/Fualau1NIfv3Gwk
         yg33uRzL8oKBp3qX2Jmtojum6lt1jUngLxn0C5b+2XvK5YLlJVI8fg1IRBMaKVAlccdd
         EiyV4nvrQ1OJp+mapY+3VfpSmyBEhHVicRBEoXaEgyKngtHaFekhpvlaJGXwN9R82dOH
         +lEmgZPCc/48BwzJ1d5+tq7haxR6oFHq688+ClKE4Pcql1UyXPTqUftViBoNyccUEvZd
         IYnW+ecUOyutzYjOk6icvH41Jy/UXN9esR+kirmlsrNeoBHaxq+UDXJsRTHatTjk1zRF
         /rdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NJs+HTqgWi+OhM79ulnjzPkQM3clLA8Pp7b2ooLPT2s=;
        b=lgCZ1wXM6+TvpTXeX3iMBl5vSoR8ogXGPZVyXu2D6ITJbrWB7yjTgdCTwvzDWDdn/X
         XDBQFHwbBE2YzEE7pEbOJpQ3tMaYcv3kFzkTMJD1Mb2nZ0vahDetXUXBDYd28yn15A5K
         7bB1TCZNcS+oZCSO6ynYQTM9NjSK3VHDS3lWoVFM9A8LPEvfBAbgZbgaT18n82AeUlNX
         Q8rGWzDhTIpdYGHBbM7x+3Aunw/n5c3rEtGdfxPdFdTWb3MCVgKLni9yatMBd1IULz2l
         YrsoBf6QHt1zfAgemkqIc0WK4OdbX70eeV+qoWON/E7LFhtERZ20FmJczNoTDRtoZCPx
         s6vg==
X-Gm-Message-State: AJIora/Ja5cqInx1sr45+X8ITDL7unHWXjOHSrDTmCqDEunosTlFoG4D
        gmnYgCNt/cADhO8W8TLPMHcFdEMSKblqozPLS36QUg==
X-Google-Smtp-Source: AGRyM1u7LlVNL2G1pH3xmJmM8J//qR7X2sUY3vZ5Rh7tFdkhMCV55a+DGWMS+8Ixka1dMz7AWolNgKUdv45Us5ijnBw=
X-Received: by 2002:a2e:bd0e:0:b0:25a:88b3:9af6 with SMTP id
 n14-20020a2ebd0e000000b0025a88b39af6mr6083392ljq.363.1656313929760; Mon, 27
 Jun 2022 00:12:09 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000dab76c05d0bc284c@google.com> <00000000000095e3d105e2553f0a@google.com>
In-Reply-To: <00000000000095e3d105e2553f0a@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 27 Jun 2022 09:11:58 +0200
Message-ID: <CACT4Y+Yf4ckOJjGkkFh_HYEKDjQo34wN=q18ADbP3=vhd5eQJQ@mail.gmail.com>
Subject: Re: [syzbot] possible deadlock in console_unlock (2)
To:     syzbot <syzbot+0b7c8bfd17c00d016fb4@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, elver@google.com, glider@google.com,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        john.ogness@linutronix.de, linux-kernel@vger.kernel.org,
        npiggin@gmail.com, pmladek@suse.com, rdunlap@infradead.org,
        rostedt@goodmis.org, senozhatsky@chromium.org, swboyd@chromium.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-15.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Jun 2022 at 10:04, syzbot
<syzbot+0b7c8bfd17c00d016fb4@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit faebd693c59387b7b765fab64b543855e15a91b4
> Author: John Ogness <john.ogness@linutronix.de>
> Date:   Thu Apr 21 21:22:36 2022 +0000
>
>     printk: rename cpulock functions
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17ed359bf00000
> start commit:   aa051d36ce4a Merge tag 'for-linus-2022052401' of git://git..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=6c31e1555a4c59f3
> dashboard link: https://syzkaller.appspot.com/bug?extid=0b7c8bfd17c00d016fb4
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16a5aad6f00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16d697c3f00000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: printk: rename cpulock functions
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection


I guess this is also:

#syz fix: printk: add kthread console printers

as "possible deadlock in console_lock_spinning_enable":
https://syzkaller.appspot.com/bug?id=7f31f600c4a83b33f7a5b71a364f971dcd177db4

But interestingly syzbot consistently points at the "rename cpulock
functions" commit...
