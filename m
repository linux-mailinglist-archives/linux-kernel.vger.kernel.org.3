Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A04BB550EED
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 05:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237865AbiFTD2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 23:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237972AbiFTD2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 23:28:41 -0400
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0247C6264;
        Sun, 19 Jun 2022 20:28:40 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id n185so5062190wmn.4;
        Sun, 19 Jun 2022 20:28:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Lp0cIeW3O0ymq9CtYc8A4N1S2P3eOd0h5WBe4BhITFc=;
        b=HfkIsEfGKjqopSbd5pR96d277+R3D2XrSFcDrPHOer2ztjG1vEPMWJGpV93MlyCF9e
         HOR5QphEXJcfaJ34ivtyf8YC8ellAAk3WPBboBR3WB2PZk8j1KfnoKo2NzqU0UwnJFVE
         UTftXUkFPZOR3rAGmyt8ErfvoIeFQ4XtnnF74CK0+cY3LNNJJ2CnCufo+mVioedXoR2d
         d9a4gpv81xjvmRl2zAtcEs8punY8YBNxoMyxczlD6s1Kb4abuMWi2boPCTOqKcxhgqFI
         CMtk+xtWACeYNtZSFhTnvG/eFv9PN2TnG5Hu3sofkQYxsIJSKzO+0CY81MZnoHUipZDa
         KVAw==
X-Gm-Message-State: AOAM5304P/gS+aKsHzu1hU/v3ErDF2l6cyS+el/zruPE1GTWGNXGXhGK
        u2DxotWHyqQVw69G8Zw+XX4rMnLcKmCLH2borfa63j+FgC6PSg==
X-Google-Smtp-Source: ABdhPJxMtmL8WqaR7zHP+AxfvLQpyo/MbytBkpI2np+af/8B30066gF0wLmcRxzJ6loTWjhPzXutTizdituzUUJjpd4=
X-Received: by 2002:a7b:c413:0:b0:39c:37cc:b0fe with SMTP id
 k19-20020a7bc413000000b0039c37ccb0femr32346614wmi.11.1655695718478; Sun, 19
 Jun 2022 20:28:38 -0700 (PDT)
MIME-Version: 1.0
From:   Ilia Mirkin <imirkin@alum.mit.edu>
Date:   Sun, 19 Jun 2022 23:28:27 -0400
Message-ID: <CAKb7UviXhWc4yxvGGCJQ=Pyvc9HUUbYDcnc3E6gVqrJePdEYCw@mail.gmail.com>
Subject: Deadlock in rfcomm_sk_state_change
To:     linux-bluetooth@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

It appears that this deadlock has been reported a few times before:

BZ here: https://bugzilla.kernel.org/show_bug.cgi?id=215746
Patch here: https://lore.kernel.org/all/20211004180734.434511-1-desmondcheongzx@gmail.com/

A Google search turns up a few other instances too.

This is the deadlock I ran into, on a ThinkPad T420s with kernel
v5.18.5. I never ran into this with the kernel I previously had on
here, v5.7.8.

[ 1513.564806] task:krfcommd        state:D stack:14824 pid:  571
ppid:     2 flags:0x00004000
[ 1513.564833] Call Trace:
[ 1513.564838]  <TASK>
[ 1513.564843]  __schedule+0x27a/0x1050
[ 1513.564861]  schedule+0x46/0xb0
[ 1513.564867]  schedule_preempt_disabled+0xc/0x20
[ 1513.564875]  __mutex_lock.constprop.0+0x284/0x4b0
[ 1513.564884]  rfcomm_run+0x14d/0x1340
[ 1513.564895]  ? swake_up_all+0xe0/0xe0
[ 1513.564908]  ? rfcomm_check_accept+0xd0/0xd0
[ 1513.564919]  kthread+0xd4/0x100
[ 1513.564930]  ? kthread_complete_and_exit+0x20/0x20
[ 1513.564940]  ret_from_fork+0x22/0x30
[ 1513.564955]  </TASK>
[ 1513.564968] task:bluetoothd      state:D stack:13248 pid: 4917
ppid:     1 flags:0x00000004
[ 1513.564987] Call Trace:
[ 1513.564990]  <TASK>
[ 1513.564994]  __schedule+0x27a/0x1050
[ 1513.565004]  ? eventfd_read+0xda/0x280
[ 1513.565020]  schedule+0x46/0xb0
[ 1513.565028]  __lock_sock+0x74/0xc0
[ 1513.565042]  ? destroy_sched_domains_rcu+0x30/0x30
[ 1513.565055]  lock_sock_nested+0x3f/0x50
[ 1513.565065]  rfcomm_sk_state_change+0x20/0x100
[ 1513.565078]  __rfcomm_dlc_close+0x8d/0x1a0
[ 1513.565088]  rfcomm_dlc_close+0x66/0x90
[ 1513.565098]  __rfcomm_sock_close+0x30/0xf0
[ 1513.565109]  rfcomm_sock_shutdown+0x4a/0x80
[ 1513.565122]  rfcomm_sock_release+0x22/0x90
[ 1513.565133]  __sock_release+0x38/0xb0
[ 1513.565146]  sock_close+0xc/0x20
[ 1513.565157]  __fput+0x87/0x240
[ 1513.565172]  task_work_run+0x57/0x90
[ 1513.565190]  exit_to_user_mode_prepare+0x108/0x110
[ 1513.565206]  syscall_exit_to_user_mode+0x1d/0x50
[ 1513.565224]  ? __x64_sys_close+0x8/0x40
[ 1513.565239]  do_syscall_64+0x69/0xc0
[ 1513.565253]  ? __x64_sys_close+0x8/0x40
[ 1513.565271]  ? do_syscall_64+0x69/0xc0
[ 1513.565276]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[ 1513.565283] RIP: 0033:0x7f818c753883
[ 1513.565287] RSP: 002b:00007ffd9222fe78 EFLAGS: 00000246 ORIG_RAX:
0000000000000003
[ 1513.565292] RAX: 0000000000000000 RBX: 000056007127afd0 RCX: 00007f818c753883
[ 1513.565295] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000016
[ 1513.565297] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[ 1513.565299] R10: 0000000000000026 R11: 0000000000000246 R12: 0000000000000000
[ 1513.565302] R13: 0000000000000001 R14: 000056007125af84 R15: 000056007125af9c
[ 1513.565306]  </TASK>

However it doesn't look like the patch has been applied (at least in
Linus's current tree), nor does there appear to be any motion on the
BZ-filed issue. Happy to provide any additional information, just let
me know what you need.

Cheers,

Ilia Mirkin
imirkin@alum.mit.edu
