Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C34465814E8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 16:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233903AbiGZOPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 10:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232427AbiGZOP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 10:15:29 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68ACDFE9;
        Tue, 26 Jul 2022 07:15:27 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id l23so26452829ejr.5;
        Tue, 26 Jul 2022 07:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=O5E0FSZQiutol3hpHlFkaz9qPEKWwCCD554TzdxrSSo=;
        b=MI4SaaeV9K8xywG0eA8PY60teUvlHzm4hyx40a8D8AoWPrN7KxU7RfDXtquYDI0xa0
         kDpys0J2b9+ZTn+2TSH6/HhU4FRVvRAsmEVpT8zpX/65eEhtyFMeeQvp9FuV+BYPwLp9
         Xex0vx8BxAzItBnlmmmgLR3MLJMXRwJt/Jim/m/rTxAur1Fd9OnZrjHoy6/bMfIeNQH2
         Xs2roMDToNaNOoNdaPiekCqsyX8pa5ckI0tALBjFc8vQYIBxRsXae26TH6KVKAIy2HSA
         MLQ8jyCvVK8Nbp7jlCnbgPS9KucmavwnOJDA4sCbDxlybtRfp9S1xXhsMiHbV3WIxZft
         Dmcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=O5E0FSZQiutol3hpHlFkaz9qPEKWwCCD554TzdxrSSo=;
        b=GIak55HN1UMGU0ll5Q2mEnvy3bEZtg2BFMEUhMAzxYKU+p404lnllKpU6y38k/QeRD
         44/heQarPT2mfrtEKrSp5NEwpYyCNWpUwW3ALWPJ05prVKhJ+d6BwNtXAJfRDn1qDQUR
         5uYdJVrCdlNL2FflC6dfRA83u43AkT/3lOKkZISDa1A/ln4tnNBNmmtIS++/nO0If/3d
         t+UZxEOZkFZzHYvM46ouUX3dKb4CyG2d5yynw5hHjvVhptPdJGR+Vkdu2ilLvisRJgux
         lNXDtUiMT3erIirECBQu1/mbosqgzZc4a6sncrq4uVUIjeMUC58r2OG02EIPrklYBiBM
         2UCA==
X-Gm-Message-State: AJIora/W4TmolrBn8P0JFAjpXSDDEf0ZxBcIMzRpGtDijl1yv/uvOQV1
        IDExHOL4kT0plSrxiSSh4crAhQw1pfNEkBvAwszB+RG4xu7MCA==
X-Google-Smtp-Source: AGRyM1uOuv6BFhxY6EWDgfOZQvxnwqigT/3vy6EMk7gMnXVcsqjivHqldN+fAfBGgxTUIYgbFxY3jDBOFM0ocFmzI1I=
X-Received: by 2002:a17:907:6d1d:b0:72b:6d8a:ca64 with SMTP id
 sa29-20020a1709076d1d00b0072b6d8aca64mr14325849ejc.371.1658844926056; Tue, 26
 Jul 2022 07:15:26 -0700 (PDT)
MIME-Version: 1.0
From:   Wei Chen <harperchen1110@gmail.com>
Date:   Tue, 26 Jul 2022 22:14:50 +0800
Message-ID: <CAO4mrfeAjieDYWN5Fs7+Xt2jTAcH3wEoCosjLLySWFyqRZKGuA@mail.gmail.com>
Subject: WARNING in floppy_shutdown
To:     efremov@linux.com, axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linux Developer,

Recently when using our tool to fuzz kernel, the following crash was triggered:

HEAD commit: 03c765b0e3b4 Linux 5.19-rc4
git tree: upstream
compiler: clang 12.0.0
console output:
https://drive.google.com/file/d/1o65iMAXWvfzQ34k_uGOn-sSvmxHi5CNP/view?usp=sharing
Syzlang reproducer:
https://drive.google.com/file/d/1pFy1YcRtfmZKA540VjsLlb0xnN79rOV4/view?usp=sharing
C reproducer: https://drive.google.com/file/d/1fAwKZ6WIt-RdPMS57Kxhq2eBBZ1hzeZO/view?usp=sharing
kernel config: https://drive.google.com/file/d/1lNGU17X6Ui1NDLE4XCRu3I6f9lzhCBcH/view?usp=sharing

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: Wei Chen <harperchen1110@gmail.com>

floppy driver state
-------------------
now=4294986375 last interrupt=4294975340 diff=11035 last called
handler=seek_interrupt
timeout_message=lock fdc
last output bytes:
1a 90 4294975340
 0 90 4294975340
 3 80 4294975340
d1 90 4294975340
10 90 4294975340
 7 80 4294975340
 8 80 4294975340
 0 90 4294975340
 f 80 4294975340
 0 90 4294975340
 8 80 4294975340
 1 90 4294975340
 4 80 4294975343
 0 90 4294975343
 4 80 4294981723
 0 90 4294981723
 4 80 4294981723
 0 90 4294981723
 4 80 4294981726
 0 90 4294981726
last result at 4294981727
last redo_fd_request at 4294981727
status=80
fdc_busy=1
cont=0000000000000000
current_req=0000000000000000
command_status=-1

floppy0: floppy timeout called
no cont in shutdown!
------------[ cut here ]------------
WARNING: CPU: 0 PID: 16304 at drivers/block/floppy.c:999
floppy_shutdown+0x2ec/0x310
Modules linked in:
CPU: 0 PID: 16304 Comm: kworker/u2:8 Not tainted 5.19.0-rc4+ #26
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Workqueue: floppy floppy_shutdown
RIP: 0010:floppy_shutdown+0x2ec/0x310
Code: aa ae 4a 0c 48 c7 c7 c0 45 77 8b 48 c7 c2 eb d6 dc 8c 48 c7 c1
60 47 77 8b 31 c0 e8 91 b8 6d 05 e9 32 ff ff ff e8 44 66 78 fc <0f> 0b
eb 9d 89 d9 80 e1 07 38 c1 0f 8c 32 fe ff ff 48 89 df e8 3b
RSP: 0018:ffffc9000aa1fc48 EFLAGS: 00010293
RAX: ffffffff85115b9c RBX: 0000000000000001 RCX: ffff88801ef54880
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: dffffc0000000000 R08: ffffffff85115b33 R09: fffffbfff1b5b2e5
R10: fffffbfff1b5b2e5 R11: 0000000000000000 R12: dffffc0000000000
R13: ffff8880162fec08 R14: ffffffff8dad95e0 R15: 1ffff11003d010c3
FS:  0000000000000000(0000) GS:ffff888063c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055ff43183fe8 CR3: 000000001f642000 CR4: 0000000000752ef0
DR0: 0000000000000003 DR1: 0000000000000000 DR2: 0000000000000005
DR3: 0000000000000006 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 <TASK>
 process_one_work+0x88d/0x1250
 worker_thread+0xaf5/0x13b0
 kthread+0x27a/0x310
 ret_from_fork+0x1f/0x30
 </TASK>

Best,
Wei
