Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6168551F6E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 16:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245023AbiFTOzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 10:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245334AbiFTOyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 10:54:47 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC3A56763
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 07:13:16 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 68so4970478pgb.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 07:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=wCEAAcxvJkKAcKZo+YaskSZPskORwzqEWHRtCkp9QAs=;
        b=hR6D9HD1fsQBvsakIY4ablvj8c9W2YZtCuNI0F/lPPgHFPQxANJ7jIqSMbvDiAw6Mj
         2v7I0l3QUmY7FK+uD1dNjYvHtnTYZ4uJRs36Ux1fIkQqVWM6RGqToVr/deHUb46KrMNJ
         suYOmyxrV8w2rLazeBtFMfh4ZRhzmZvKkn1/09iwDaMFLmNhaMqeG0N8dJ+nj2aUaR1a
         voOBCehGX8DoLg+Xsos9CPKSlV/eRTtkYoaT5A66serBNDXvk7UJ/pEiAkk/u4PW71Ua
         d98VQLuOAwUjU/1N2oTANLhePZjhBLYTBG7N/Y76XbkofNgna5weHKfKOMaCysixsxBZ
         Q4mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=wCEAAcxvJkKAcKZo+YaskSZPskORwzqEWHRtCkp9QAs=;
        b=6H0K89sy/o3JWakCWFpXwPTOFOpBWHsugaRyPhHm9vLDIt9xqGl/O8gHru6sVme+J3
         7qBgIll5qQr7v+F1488NRyU6X9g7faUQ8MNclaQ/oY3VeY9FSDl0UCLfJtmEszUy4fic
         9hl6AIaGcgkKc+qcvzQNnQf/LnbXagnyV6beJQ7T7XlQYAkttHcqnyKdNB3Yzikk66Fn
         kjGWh2EqeBS6GQhLhY2IV6CdTjIOxC/u3dIuvIiKrMFQ9mF3/dq4mvZbQJgrmYuzoOgV
         mxoGQSp0mJAb+sXXi6FF9z8ecf//BprHvBDkUlIVsHWAvbI0cQFMv+oDgWlcm/xfAHVj
         nDFQ==
X-Gm-Message-State: AJIora+P79490lUria9pIcvjaofPCI/2YlNFO9wD9G3uZvMB9NuYnnWH
        bt7DtmGc3aF2m1QYrHWqojE=
X-Google-Smtp-Source: AGRyM1tWsfqU41lQ4lIVBL2Ga/br/s6gIsoFfDynCR+7AxaAsLsPXlvGkNJkcKdysqKKT/ZtkQ7BBA==
X-Received: by 2002:a62:6144:0:b0:525:1b46:83de with SMTP id v65-20020a626144000000b005251b4683demr8614724pfb.65.1655734394624;
        Mon, 20 Jun 2022 07:13:14 -0700 (PDT)
Received: from archdragon (dragonet.kaist.ac.kr. [143.248.133.220])
        by smtp.gmail.com with ESMTPSA id u9-20020a1709026e0900b0015e8d4eb282sm8758843plk.204.2022.06.20.07.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 07:13:14 -0700 (PDT)
Date:   Mon, 20 Jun 2022 23:13:09 +0900
From:   "Dae R. Jeong" <threeearcat@gmail.com>
To:     bryantan@vmware.com, rjalisatgi@vmware.com, vdasa@vmware.com,
        pv-drivers@vmware.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: general protection fault in add_wait_queue
Message-ID: <YrCAY/SiCagJV18a@archdragon>
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

We observed a crash "general protection fault in add_wait_queue"
during fuzzing. 

Unfortunately, we have not found a reproducer for the crash yet. We
will inform you if we have any update on this crash.

Detailed crash information is as follows.
------

- Kernel commit:
b13baccc3850ca

- Crash report: 
general protection fault, probably for non-canonical address 0xdffffc0000000019: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x00000000000000c8-0x00000000000000cf]
CPU: 2 PID: 27483 Comm: syz-executor.0 Not tainted 5.19.0-rc1-31595-gdf1bbda1a939 #13
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
RIP: 0010:__lock_acquire+0xf3/0x5e00 kernel/locking/lockdep.c:4926
Code: 89 bc 24 88 00 00 00 0f 85 02 27 00 00 83 3d 9b 05 66 10 00 0f 84 97 43 00 00 83 3d 46 ea f9 0e 00 74 31 48 89 f8 48 c1 e8 03 <42> 80 3c 00 00 74 17 e8 b1 5e 86 00 48 8b bc 24 88 00 00 00 49 b8
RSP: 0018:ffffc900082af260 EFLAGS: 00010002
RAX: 0000000000000019 RBX: 0000000000000001 RCX: 1ffff92001055e6c
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000000000c8
RBP: ffffc900082af5f0 R08: dffffc0000000000 R09: 0000000000000001
R10: fffffbfff2394b3e R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000001
FS:  00007f36801c0700(0000) GS:ffff8880b9300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055fdf32207d0 CR3: 000000005af57000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 lock_acquire+0x1a4/0x4a0 kernel/locking/lockdep.c:5672
 __raw_spin_lock_irqsave include/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0xb3/0x100 kernel/locking/spinlock.c:162
 add_wait_queue+0x3d/0x260 kernel/sched/wait.c:22
 poll_wait include/poll.h:49 [inline]
 vmci_host_poll+0xf8/0x2b0 drivers/misc/vmw_vmci/vmci_host.c:174
 vfs_poll include/poll.h:88 [inline]
 do_pollfd fs/select.c:873 [inline]
 do_poll fs/select.c:921 [inline]
 do_sys_poll+0xc7c/0x1aa0 fs/select.c:1015
 __do_sys_ppoll fs/select.c:1121 [inline]
 __se_sys_ppoll+0x2cc/0x330 fs/select.c:1101
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x4e/0xa0 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x478db9
Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f36801bfbe8 EFLAGS: 00000246 ORIG_RAX: 000000000000010f
RAX: ffffffffffffffda RBX: 0000000000781408 RCX: 0000000000478db9
RDX: 00000000200000c0 RSI: 0000000000000001 RDI: 0000000020000100
RBP: 00000000f477909a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000007815c0
R13: 0000000000781414 R14: 0000000000781408 R15: 00007fffb85f7830
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__lock_acquire+0xf3/0x5e00 kernel/locking/lockdep.c:4926
RSP: 0018:ffffc900082af260 EFLAGS: 00010002
RAX: 0000000000000019 RBX: 0000000000000001 RCX: 1ffff92001055e6c
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000000000c8
RBP: ffffc900082af5f0 R08: dffffc0000000000 R09: 0000000000000001
R10: fffffbfff2394b3e R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000001
FS:  00007f36801c0700(0000) GS:ffff8880b9300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055fdf32207d0 CR3: 000000005af57000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
