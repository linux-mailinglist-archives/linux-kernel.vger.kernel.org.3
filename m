Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1750E587AE6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 12:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236136AbiHBKnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 06:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232695AbiHBKnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 06:43:32 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 369EF22539
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 03:43:32 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id h7-20020a92c267000000b002dd80cf0989so8274583ild.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 03:43:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=yVlgNZB/I47whXL8t7L3xLdkxatXwDbux5hHs6L8d7A=;
        b=Ef5g5QJr8wF6haeA6fmE3rjQUkHq14FrykR3tYJgCZ4QWSZSaZkD+kdYs3BtEZ/RSz
         V+ofdOjSqOrltoPTqy+QMBPgpBxuWbamyMOS1rijhLzmSU3/ICH5vyfv2zvJi8gSX18N
         uu4B81f80o6OIBOEO1Hx6sbvyxPgQI5P4YwBCIA16tlCaAegbecCkgwlNk+eC1L+4Tve
         1Vz8kpZGNksSqpJdIWis/Hpjf5bDjSo4LdZd5RgEsnAQo4JFi8viSuMGiGGuqAdB3GLJ
         vLT6EW/pwxz+ON6SzpxzkrRWlulaWfew0X4QJ5GbAGulbvpnuXs4MgVKNqDD+T71B8f5
         Y3GQ==
X-Gm-Message-State: ACgBeo1w3us4AyhpPeIOBybliPDGE8gp6xm/e6UqLSM46o0BnWmp5fHm
        FrMIyQySnMyj5UbHB4OZzP7oVrq+bfO2iXYxu17MiQc1k5Lw
X-Google-Smtp-Source: AA6agR49guNSo2nSzDN/SGEJ81vI0fTNZY4iWEpP4R1Zms6eo/YxNQADqWTM2B7dX5hoHOxaDK9bGhD8lSMbxtm77CMwsyuoP2zp
MIME-Version: 1.0
X-Received: by 2002:a92:d2d2:0:b0:2de:a91b:3ac6 with SMTP id
 w18-20020a92d2d2000000b002dea91b3ac6mr3525545ilg.194.1659437011617; Tue, 02
 Aug 2022 03:43:31 -0700 (PDT)
Date:   Tue, 02 Aug 2022 03:43:31 -0700
In-Reply-To: <20220802104319.1450-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009ad11905e53fc99f@google.com>
Subject: Re: [syzbot] INFO: rcu detected stall in gc_worker (2)
From:   syzbot <syzbot+70c4a3a8fe7f7e1af947@syzkaller.appspotmail.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, 09 Dec 2021 00:56:26 -0800
>> syzbot found the following issue on:
>> 
>> HEAD commit:    2a987e65025e Merge tag 'perf-tools-fixes-for-v5.16-2021-12..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=114fe575b00000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=7d5e878e3399b6cc
>> dashboard link: https://syzkaller.appspot.com/bug?extid=70c4a3a8fe7f7e1af947
>> compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.2
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=128048b9b00000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10ceddadb00000
>
> Print the hrtimer hog.
>
> #syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master

This bug is already marked as invalid. No point in testing.

>
> diff -pur a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
> --- a/kernel/time/hrtimer.c	2022-08-02 18:24:33.200242000 +0800
> +++ b/kernel/time/hrtimer.c	2022-08-02 18:40:52.895892600 +0800
> @@ -1647,6 +1647,7 @@ static void __run_hrtimer(struct hrtimer
>  	enum hrtimer_restart (*fn)(struct hrtimer *);
>  	bool expires_in_hardirq;
>  	int restart;
> +	unsigned long ts;
>  
>  	lockdep_assert_held(&cpu_base->lock);
>  
> @@ -1682,8 +1683,13 @@ static void __run_hrtimer(struct hrtimer
>  	trace_hrtimer_expire_entry(timer, now);
>  	expires_in_hardirq = lockdep_hrtimer_enter(timer);
>  
> +	ts = jiffies + 500;
> +
>  	restart = fn(timer);
>  
> +	WARN_ONCE(time_after(jiffies, ts),
> +		"CPU%u hrtimer %ps took more than 500 ticks\n", cpu_base->cpu, fn);
> +
>  	lockdep_hrtimer_exit(expires_in_hardirq);
>  	trace_hrtimer_expire_exit(timer);
>  	raw_spin_lock_irq(&cpu_base->lock);
> --
