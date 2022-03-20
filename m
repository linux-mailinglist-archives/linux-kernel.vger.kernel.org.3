Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA9D4E1C49
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 16:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245321AbiCTPed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 11:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235517AbiCTPeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 11:34:31 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86181CB1E
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 08:33:07 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id s14-20020a056e021a0e00b002c7c03a5d81so6416212ild.9
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 08:33:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=MIhvRryijrTzJR8twQ1HqBta+GyTfRS9hVvbodg7+Pw=;
        b=TuvOPLA/CDOHRcmZhHP5u2ARVIn5gwmqJjYREqjQq6rdK6zXH5aMc0w/hqoP0Z3YUQ
         BItb3JyiVyhFEht/OGkPMhsUrs1xzoUFQCGIXKQmsghzaKVo70QsPJKWB3YKNoTPIB/B
         eEDVpiAsKiGRupnR4Jihb/VUJ64ESmC5nK8f4INyjG6cj6JnKXbFrduVtlJc20NvyeaP
         BwDN3KFpO0HOAo0z7urwQB1NXg/0+HJqaloHSbhQ6tk+0/KucdlBO0mAgbAdDGYp4bgc
         tuAmCU6yc0wZwuZdtNTPiwn+oaXX5T/1gK6QJjoie/mqBplZQ+vD6skaDGYoYYjGGKUD
         z3vQ==
X-Gm-Message-State: AOAM530z8E1KpCqNVs1xNI9yR5oCfHFg6oRl2VIn9rZYYwK2F9I3+U88
        0uXSyulwNdFBrTvfhJCqZZjuhEt9zDAVZ1DJxRYEnmLfmREi
X-Google-Smtp-Source: ABdhPJzqSo43we9ySOJWMo+7EZIm5ZoV9Z81zrjpsC0WvsLPo7j5HPGjquoRJXHc1QVgGqyFHExy7nvak8ozzrAL+QCt4GTIMkhR
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a69:b0:2c8:115b:c614 with SMTP id
 w9-20020a056e021a6900b002c8115bc614mr3010781ilv.61.1647790387202; Sun, 20 Mar
 2022 08:33:07 -0700 (PDT)
Date:   Sun, 20 Mar 2022 08:33:07 -0700
In-Reply-To: <20220320152154.2662-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b1939b05daa81821@google.com>
Subject: Re: [syzbot] INFO: rcu detected stall in gc_worker (3)
From:   syzbot <syzbot+eec403943a2a2455adaa@syzkaller.appspotmail.com>
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

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: rcu detected stall in corrupted

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { 1-... } 2642 jiffies s: 2057 root: 0x2/.
rcu: blocking rcu_node structures (internal RCU debug):
Task dump for CPU 1:
task:syz-executor212 state:R  running task     stack:26424 pid: 4080 ppid:  4063 flags:0x0000000e
Call Trace:
 <TASK>
 </TASK>


Tested on:

commit:         91265a6d Add linux-next specific files for 20220303
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/
console output: https://syzkaller.appspot.com/x/log.txt?x=13f1becb700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=617f79440a35673a
dashboard link: https://syzkaller.appspot.com/bug?extid=eec403943a2a2455adaa
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11d0caeb700000

