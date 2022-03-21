Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B32414E1EBC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 02:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343996AbiCUBdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 21:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343991AbiCUBdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 21:33:37 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75427D8F4D
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 18:32:13 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id b15-20020a05660214cf00b00648a910b964so9627960iow.19
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 18:32:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=+W3wvUyVdsrx5Jm9g/xVjOL/gtGudyyS6dmy1NYOwdg=;
        b=WV/FQyHsxBYQLsKTk4us4CB9SRTIyfLHppsULhZINAsb1RpP5Btedpl1wTjh/BLB5o
         4KkBDZKHYb9xleqVWfMI5cpS9dmD3/IupfWVYuXstbgVYS3bKdyfdlUV+yZCUqZAQ48x
         wOoBFCTw51CaAcCNwi3uXQKpZqU+CaIMCN5J4ONo7NBTQ/w3e7XtcmT4lgVxp5uDF+Ul
         SkFpg46NPKAfII4zZacNgIwiYYnrKSXhWsYf1PqY1hb8xq/cLFvkQfcyVmR5TVrSahcY
         2gVpZ9//5stNRVorPm4GLcrFNNKRqDst0u3TPMWZBKuoe0PG4mqlVsthjbt11SlqVnh7
         i0Kg==
X-Gm-Message-State: AOAM532C7sBq85zaLaQrai9++In0zkuYsf247jSHF9o1Rs+u8hMAVF2L
        S97sOblBEdeLdCuB1A97CO01AW5dg+rRWgR3NbAb9hgV7m4r
X-Google-Smtp-Source: ABdhPJyZWPTQ2SUYtMuDvB6504X60o0gaQM9pTe8q2sng0b/pMWZFn/y0wrCFh2PXf9/rJd5jBxG635gFraBMNXA+WKGtzdRHvaH
MIME-Version: 1.0
X-Received: by 2002:a05:6638:d87:b0:319:b50c:5efc with SMTP id
 l7-20020a0566380d8700b00319b50c5efcmr9616661jaj.5.1647826332878; Sun, 20 Mar
 2022 18:32:12 -0700 (PDT)
Date:   Sun, 20 Mar 2022 18:32:12 -0700
In-Reply-To: <20220321012046.2729-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000390a4c05dab07752@google.com>
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

IPv6: ADDRCONF(NETDEV_CHANGE): veth0_to_batadv: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth1_to_batadv: link becomes ready
rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { 0-... } 2628 jiffies s: 2065 root: 0x1/.
rcu: blocking rcu_node structures (internal RCU debug):
Task dump for CPU 0:
task:syz-executor354 state:R  running task     stack:27224 pid: 4078 ppid:  4061 flags:0x0000400e
Call Trace:
 <TASK>
 </TASK>


Tested on:

commit:         91265a6d Add linux-next specific files for 20220303
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/
console output: https://syzkaller.appspot.com/x/log.txt?x=16355271700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=617f79440a35673a
dashboard link: https://syzkaller.appspot.com/bug?extid=eec403943a2a2455adaa
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17b1f271700000

