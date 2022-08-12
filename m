Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26841591698
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 23:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbiHLVEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 17:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232561AbiHLVEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 17:04:43 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E1AB440A
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 14:04:42 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id x7-20020a056e021ca700b002ded2e6331aso1307141ill.20
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 14:04:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=CqAP7/erwabYfZcEqDajpmAewsF59PsJ5bWHrsgdEGI=;
        b=YVoX64YIdx6m49/paBpjW5N91oh/cyt879Hl4hzufIuM/2cMuD9Ys/3EtHtiNLDhxc
         FAlOS5d9RuHdjbzQ5Ql/LcmAk+Mnd+c/t2vz0Y1j4Kagcal02rKfURPTSHDxrPrhXAyA
         yaCnnTROeckeopPYkNtQJYu3jE8ZwN1yJ9n+h+rnUo0uUBjXzQ8afxlmERNJ/zlVUQ76
         LW6AQvXmwE7lVrra1Aq/mRYu/Zuv2p9xADwg0lJ3WCytfJTS6IEQ81FOTEmMgLOmaQvU
         i0e+UeuE7bJBLPIQA9JmlCjk0g/iDxGosIBITQu6Ca5Uwk28wVmV+/DTb8Y1ULKhisR7
         78ZA==
X-Gm-Message-State: ACgBeo2EfGhnH51Xuumx2W4UjDJgfW+GgRzlmylL7YbND8wfeikJoKT7
        dVKuNWy6ZS0pxPI6ZZ5Q0E3ZsARgfMMZyJuaTlAPVuaQ0jJR
X-Google-Smtp-Source: AA6agR41mVj/xh13nLXVSDnRQYc6cKY6oZWjSheQQKcb41XlCnsB5BUVCRbV9DspI9xzhbrPfISPofF6+HlqRCpSmqjyrUoK1J2R
MIME-Version: 1.0
X-Received: by 2002:a05:6638:270e:b0:343:6da4:6738 with SMTP id
 m14-20020a056638270e00b003436da46738mr1318672jav.263.1660338281929; Fri, 12
 Aug 2022 14:04:41 -0700 (PDT)
Date:   Fri, 12 Aug 2022 14:04:41 -0700
In-Reply-To: <20220812140439.6bb2bb17@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000080646c05e611a198@google.com>
Subject: Re: [syzbot] memory leak in netlink_policy_dump_add_policy
From:   syzbot <syzbot+dc54d9ba8153b216cae0@syzkaller.appspotmail.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, 12 Aug 2022 10:04:26 -0700 syzbot wrote:
>> Hello,
>> 
>> syzbot found the following issue on:
>> 
>> HEAD commit:    4e23eeebb2e5 Merge tag 'bitmap-6.0-rc1' of https://github...
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=165f4f6a080000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=3a433c7a2539f51c
>> dashboard link: https://syzkaller.appspot.com/bug?extid=dc54d9ba8153b216cae0
>> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1443be71080000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11e5918e080000
>> 
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+dc54d9ba8153b216cae0@syzkaller.appspotmail.com
>
> Let's see if attaching a patch works...
>
> #syz test

want 2 args (repo, branch), got 1

