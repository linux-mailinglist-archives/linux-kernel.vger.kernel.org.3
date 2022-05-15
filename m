Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D25F55278F0
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 19:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236711AbiEORmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 13:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbiEORmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 13:42:14 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5336374
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 10:42:14 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id k184-20020a6bbac1000000b0065aeedd4ba8so8948042iof.20
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 10:42:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=FLJhACA2WCCPpt63FKh/N0iBuVYXMyOOU24UofBXW/4=;
        b=lF97icOo0wCQRVoeOgyrsY1nvaY8PZkSadC1Yni8MT1zW4STMn9cUld2qgdRq6vmaQ
         3twMJqL0UGa+QeifxFzC24cOE4wbNX9gAV9X+ymIJjtw7ArbHlVRv48ZLDJkG6VS+FcK
         Z+7xg53a/dgEaB5kwSDMhMCn2E7iS3X9bkyXl26xJ5MgG4IFT1CBY90yvgRDHyxgYYhV
         LwKhrB1glZ12x3ZbazLJuGIlfO9t3q1YxV4+VXx3V9H8+9CMWvdd5WEAyCCFt3m3tkgP
         PqJoftZaQaL9Kg7wMJkArueY951lsHjZnQx26kmFcre6dy8NlMl9dsKmA+wXd0tYmLww
         /+WQ==
X-Gm-Message-State: AOAM533MqKt9rsF++M7fM/XTrSciQb604n8RSFeqcqDTv788iBg6fzfH
        kZFrY5IS3vPucMBCxKgNWHnfYY3KnZrMV22NZ7zX0/w1nKZN
X-Google-Smtp-Source: ABdhPJzmeXSeCCucyWuyZDdwkScKpp7ELoVA01UVPHfwLT6FwozWYBNRXRE3gA+sDPySsQEI8U8mFI/WEIhU1AEKSBgke8SGbY4t
MIME-Version: 1.0
X-Received: by 2002:a05:6638:25d3:b0:32b:7413:a64f with SMTP id
 u19-20020a05663825d300b0032b7413a64fmr7491272jat.268.1652636533601; Sun, 15
 May 2022 10:42:13 -0700 (PDT)
Date:   Sun, 15 May 2022 10:42:13 -0700
In-Reply-To: <de26ea1c-c263-0418-ba79-e9dfa85a3abd@kernel.dk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000873bb305df106d47@google.com>
Subject: Re: [syzbot] WARNING: still has locks held in io_ring_submit_lock
From:   syzbot <syzbot+987d7bb19195ae45208c@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, f.fainelli@gmail.com,
        io-uring@vger.kernel.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, olteanv@gmail.com,
        syzkaller-bugs@googlegroups.com, xiam0nd.tong@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING: still has locks held in io_ring_submit_lock

====================================
WARNING: iou-wrk-4175/4176 still has locks held!
5.18.0-rc6-syzkaller-00294-gdf8dc7004331 #0 Not tainted
------------------------------------
1 lock held by iou-wrk-4175/4176:
 #0: ffff888019d050a8 (&ctx->uring_lock){+.+.}-{3:3}, at: io_ring_submit_lock+0x75/0xc0 fs/io_uring.c:1500

stack backtrace:
CPU: 1 PID: 4176 Comm: iou-wrk-4175 Not tainted 5.18.0-rc6-syzkaller-00294-gdf8dc7004331 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 try_to_freeze include/linux/freezer.h:66 [inline]
 get_signal+0x17bb/0x24c0 kernel/signal.c:2654
 io_wqe_worker+0x64b/0xdb0 fs/io-wq.c:663
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:298
 </TASK>


Tested on:

commit:         df8dc700 Merge branch 'for-5.19/block' into for-next
git tree:       git://git.kernel.dk/linux-block.git for-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1275d495f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7b4d7b33ae78f4c2
dashboard link: https://syzkaller.appspot.com/bug?extid=987d7bb19195ae45208c
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: no patches were applied.
