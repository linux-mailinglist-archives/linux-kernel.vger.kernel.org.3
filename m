Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 296DF551F10
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 16:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243618AbiFTOjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 10:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348621AbiFTOim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 10:38:42 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA181CC
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 06:55:59 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id t21so4036362pfq.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 06:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=K6FQC8omVUUJgdQeDjPAx04ITINqrAocGed+85leMdE=;
        b=lqPL75jjn+YjeGwg+BCnw3Ea5Cg43fPUnrf1wNFV2wKGKv0WcR+THD55wwwhDjh7Lv
         0VLLQEt8jn3cEhVTqcpyKxTO/K8d3w3X4JYetk005X09AStsgXhNFja1899EOWx/5+FX
         BXiSQEtzUATaMEwjDp5C8EQ1ISFZgnhSNjes60EFkXdF4kOsB6qsVqR8+4j0eoy0B7UH
         g73B/McNr9qn+lTyC2km2cmA0SN1yZZDJyrid+pH5ZZqmf8pc79G5LPG1wWkgl9QL79Q
         PXwBxba+mPY2F9R3vq8csNAVrHtbqUjwwVEX9LFiy3bR1UxjnK8H6/pSsvDJu2KBhfYh
         noVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=K6FQC8omVUUJgdQeDjPAx04ITINqrAocGed+85leMdE=;
        b=vXWoGKmTUxPN6oErpNdaB2a5QlPSEdStCutTxjPR67S8prZ7QkNB/bfM74X4+hobWP
         tzIwlQwZe+o1jpERfDUxhL070NaKjDwi0ixInaG/3hD+KgHJOdVIleiS+deh4AIRrAm7
         41s1EEP/+yMAVeM700+ObFQHkFb8WuW/6TN67tVykJTOgiz44dAqXP61RW+rnDDG9rwC
         anIGMw3nN/kN51BhJekVpGh79bBhhfOFz1zXikSu5U8aTjzwNtMmNqR1/FnCXyKsEKW+
         9/TQWBE9X2/5PeJUGPtQq3OlAGSt3A/aOyzf49H+XHs/mJQkaTbj1YldXOHJSLRDBbrV
         j7aQ==
X-Gm-Message-State: AJIora9S2JDoXZpcBL8y09HraXpUr/km7Q0mGTg/yVa+1jX9JQcebZhj
        tb3/DIdKt5GXoyE5HSXixxP68SKjzTo=
X-Google-Smtp-Source: AGRyM1s3IVq9oe7+aWciFBLq4n0mmnwBVb5yTPk6iE5w2ojwapjCoWt+rsiKecxWlKsHk0X2mqCdoA==
X-Received: by 2002:a63:28b:0:b0:401:b84d:780f with SMTP id 133-20020a63028b000000b00401b84d780fmr22016953pgc.187.1655733358689;
        Mon, 20 Jun 2022 06:55:58 -0700 (PDT)
Received: from archdragon (dragonet.kaist.ac.kr. [143.248.133.220])
        by smtp.gmail.com with ESMTPSA id u23-20020a1709026e1700b001620960f1dfsm8761907plk.198.2022.06.20.06.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 06:55:57 -0700 (PDT)
Date:   Mon, 20 Jun 2022 22:55:53 +0900
From:   "Dae R. Jeong" <threeearcat@gmail.com>
To:     anton@tuxera.com, linux-ntfs-dev@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: kernel BUG in ntfs_read_block
Message-ID: <YrB8aSIPHUyapYw2@archdragon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We observed a crash "kernel BUG in ntfs_read_block" during fuzzing.

Unfortunately, we have not found a reproducer for it yet.  We will
inform you if we have any update on this crash.

Detailed crash information is as follows:
-----------------------------------------

- Kernel commit:
b13baccc3850ca

- Crash report:

loop0: detected capacity change from 0 to 67
------------[ cut here ]------------
kernel BUG at fs/ntfs/aops.c:186!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 24003 Comm: syz-executor.0 Not tainted 5.19.0-rc2-31838-gef9c98f9637f #14
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
RIP: 0010:ntfs_read_block+0x23d2/0x2760 fs/ntfs/aops.c:186
Code: 01 00 00 e8 30 60 59 fe e9 f8 02 00 00 e8 26 60 59 fe 48 8b 7c 24 08 48 c7 c6 00 c0 4e 8e e8 75 a3 9d fe 0f 0b e8 0e 60 59 fe <0f> 0b e8 07 60 59 fe 48 8b 5c 24 08 48 89 df be 08 00 00 00 e8 85
RSP: 0018:ffffc90007787560 EFLAGS: 00010283
RAX: ffffffff832c0142 RBX: 0000000000000000 RCX: 0000000000040000
RDX: ffffc900033c1000 RSI: 00000000000024d9 RDI: 00000000000024da
RBP: ffffc90007787708 R08: ffffffff832bdf85 R09: ffffed102bde463b
R10: ffffed102bde463b R11: 0000000000000000 R12: dffffc0000000000
R13: ffffffff953b7bf0 R14: ffff88815ef234a0 R15: ffff888145505000
FS:  00007fbf10dd4700(0000) GS:ffff88823bc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f827b3b5000 CR3: 0000000020368000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 do_read_cache_folio+0x420/0x8e0 mm/filemap.c:3515
 do_read_cache_page mm/filemap.c:3593 [inline]
 read_cache_page+0x6b/0x370 mm/filemap.c:3602
 read_mapping_page include/linux/pagemap.h:759 [inline]
 ntfs_map_page+0x24/0x460 fs/ntfs3/ntfs_fs.h:897
 map_mft_record_page fs/ntfs/mft.c:73 [inline]
 map_mft_record+0x230/0x8f0 fs/ntfs/mft.c:156
 ntfs_read_locked_inode+0x1f5/0x75b0 fs/ntfs/inode.c:550
 ntfs_read_inode_mount+0x133e/0x33d0 fs/ntfs/inode.c:2091
 ntfs_fill_super+0x2c59/0xc540 fs/ntfs/super.c:2854
 mount_bdev+0x32a/0x520 fs/super.c:1367
 legacy_get_tree+0x136/0x270 fs/fs_context.c:610
 vfs_get_tree+0xc2/0x430 fs/super.c:1497
 do_new_mount fs/namespace.c:3040 [inline]
 path_mount+0x2217/0x3e50 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount+0x359/0x430 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x4e/0xa0 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x47a6da
Code: 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fbf10dd3a08 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000020000200 RCX: 000000000047a6da
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007fbf10dd3a60
RBP: 00007fbf10dd3aa0 R08: 00007fbf10dd3aa0 R09: 0000000020000000
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000020000000
R13: 0000000020000100 R14: 00007fbf10dd3a60 R15: 0000000020000040
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ntfs_read_block+0x23d2/0x2760 fs/ntfs/aops.c:186
Code: 01 00 00 e8 30 60 59 fe e9 f8 02 00 00 e8 26 60 59 fe 48 8b 7c 24 08 48 c7 c6 00 c0 4e 8e e8 75 a3 9d fe 0f 0b e8 0e 60 59 fe <0f> 0b e8 07 60 59 fe 48 8b 5c 24 08 48 89 df be 08 00 00 00 e8 85
RSP: 0018:ffffc90007787560 EFLAGS: 00010283
RAX: ffffffff832c0142 RBX: 0000000000000000 RCX: 0000000000040000
RDX: ffffc900033c1000 RSI: 00000000000024d9 RDI: 00000000000024da
RBP: ffffc90007787708 R08: ffffffff832bdf85 R09: ffffed102bde463b
R10: ffffed102bde463b R11: 0000000000000000 R12: dffffc0000000000
R13: ffffffff953b7bf0 R14: ffff88815ef234a0 R15: ffff888145505000
FS:  00007fbf10dd4700(0000) GS:ffff88823bc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f827b3b5000 CR3: 0000000020368000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
