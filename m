Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A91E4585E21
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 10:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235352AbiGaIbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 04:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiGaIbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 04:31:10 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E7912622
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 01:31:09 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id a17-20020a056e0208b100b002dc52b51d98so4898182ilt.0
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 01:31:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=zQvI4TiOA16DBzXYviHz1jz0WFrpEFdkix34ssD8V+E=;
        b=E4fDpkmWrRM+2eFt0eThZruWI3Qieui2O9+kKIJlyyJFFXjVvmAOXVqn/tT8WDEmER
         i0lQto4VkWB8UdZZ2ztuY4XtD2PMoWV0mGDSq2hD70ibSy5KwBYOk0t3QBHGIYCXs+8J
         eit3mhSNsesl8gBsXe/p9vUxplGCBXrgLZ8UhJjcqGv8E8ur5of+DySD6J2HIHFMJJN1
         pbCJ51LvQ8J2NsJBcaCHMeiJz2pNtVcPcP2qRqAr1qxK7OEuFltltmtl5b982ZKoSUQG
         QHU72ePUWgpVTdboIlESJ2CYWBYpFqRka2nSSyJ2nw2DCrgHDdy3nmms5rtMpW6gkp8u
         nfeg==
X-Gm-Message-State: AJIora92GvdzCTczSnUjfGbabxN1516xEUNkfCTZ9fjp9uSjG7ayHilJ
        WArLYEiqucjs+AZUJpTStc0OJZ6SMg5XByTwogL/fA2/etX9
X-Google-Smtp-Source: AGRyM1sIxGZt8yFtWSRoFXwUmvMPMdFQM9xRXOuxurefWgECH5Raywdd9pP+RR/DZzLbTc+vfHuBDLDJdF07EgjqSxLlpZmwXKHd
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2d12:b0:67c:3c33:4994 with SMTP id
 c18-20020a0566022d1200b0067c3c334994mr3634264iow.26.1659256268814; Sun, 31
 Jul 2022 01:31:08 -0700 (PDT)
Date:   Sun, 31 Jul 2022 01:31:08 -0700
In-Reply-To: <20220731081548.659-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007e808205e515b47d@google.com>
Subject: Re: [syzbot] INFO: rcu detected stall in gc_worker (3)
From:   syzbot <syzbot+eec403943a2a2455adaa@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
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

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: rcu detected stall in corrupted

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { 0-... } 2654 jiffies s: 2049 root: 0x1/.
rcu: blocking rcu_node structures (internal RCU debug):
Task dump for CPU 0:
task:syz-executor.0  state:R  running task     stack:27224 pid: 4073 ppid:  4053 flags:0x0000400e
Call Trace:
 <TASK>
 </TASK>


Tested on:

commit:         91265a6d Add linux-next specific files for 20220303
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=11978a82080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=617f79440a35673a
dashboard link: https://syzkaller.appspot.com/bug?extid=eec403943a2a2455adaa
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14ff72fe080000

