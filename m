Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 601F35274BD
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 02:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235369AbiEOAWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 20:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235262AbiEOAWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 20:22:10 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A95C6548
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 17:22:09 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id ay38-20020a5d9da6000000b0065adc1f932bso7678596iob.11
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 17:22:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=tVCL+Ix39RObOP8KYLj0judOKhnBQ9s1gFvbw6AFlAA=;
        b=sS1W0d0CNZ9rYgEXh+DNxnkST3rvAAA9cTPflyA1UUtrxHtGuMtNQb8TVKzeImt+Mc
         ADaAN6QGNw7s2ZIn24B0OZqQJiA+vpEsfcOho60GJoMyYHUqTQLs9cBNmV5u5RigP3HJ
         19UQ1DUBUdNCAJIa93pq8ViUw9ayCQ1rqy+t7RKue5eDOnBie68YjWy+MR/VhP5p8jAR
         hjIm9PDzMXISkf5JHQZrN4gwIHpvjhFnlr9Tb7ikr3Fiqh1c43YLUmADjoajqmEwkTux
         iI1PT42YNg86faze7OFG0XGtS4BTImNiAjmAbrqaX6Y9jzU11Up74WDuW0eZeOoJi9ui
         O2wg==
X-Gm-Message-State: AOAM533qnr5DhnzQuEWI4zAZmAa+EkAWhzuNVV1D5uWoF35LaZMJpuT7
        FtTvr5nJCFMPFa6vpM+KsqfBNwPyucbdykuPvRxRxtu12jhH
X-Google-Smtp-Source: ABdhPJwQNKIwgQTArh0y70nb+0X2UIXAyevro151yS7ZKfbmpuB+ybU6HmAySgk6pjJHRGnxPryeQEE8r3ABrAFmEeZrcU62pFlL
MIME-Version: 1.0
X-Received: by 2002:a92:ca0d:0:b0:2cf:3b0d:c4bf with SMTP id
 j13-20020a92ca0d000000b002cf3b0dc4bfmr6054429ils.66.1652574128950; Sat, 14
 May 2022 17:22:08 -0700 (PDT)
Date:   Sat, 14 May 2022 17:22:08 -0700
In-Reply-To: <20220514233453.1426-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ebd11505df01e597@google.com>
Subject: Re: [syzbot] WARNING in mntput_no_expire (3)
From:   syzbot <syzbot+5b1e53987f858500ec00@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
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

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

fs/file_table.c:377:22: error: implicit declaration of function 'real_mount'; did you mean 'kern_mount'? [-Werror=implicit-function-declaration]
fs/file_table.c:378:16: error: implicit declaration of function 'mnt_get_count'; did you mean 'init_page_count'? [-Werror=implicit-function-declaration]
fs/file_table.c:380:13: error: invalid use of undefined type 'struct mount'


Tested on:

commit:         feb9c5e1 Merge tag 'for_linus' of git://git.kernel.org..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
dashboard link: https://syzkaller.appspot.com/bug?extid=5b1e53987f858500ec00
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16788769f00000

