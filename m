Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBCB0578E77
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 01:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235163AbiGRXuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 19:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiGRXuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 19:50:13 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E0731355
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 16:50:11 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id x11so4306410qts.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 16:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=kGG9hK6/fhPYP5ESwwboqRMB7+NvjeWq6Eay6lmiXCI=;
        b=VlLfcO29O92uk5Fj654ZAYB7C4/sETGre2JqOjHe66hQut5b9toLVEFq8KqrnDyUk+
         lTyXLtkMF4os2hZropep5TrTK5KfFbYVhS8vU/iGRC1aZKV6QfGiZ2YUAtcZnGhz3n+8
         TnfclZ2FfDCg9e2/jrfiD9WhMrzpl8dWmzC/kt4LZmUebSaHvhmiYEpZ/jxuxFMsy/QA
         jlf07oF/b8Da9yqqhah9prZzFFF30sPHJUC4/g9utSFUEmkfzVn43JNNN9BLsGKkClYl
         stwB1CBZ4EFltfW5/TFsHr8rbhENFLMZAbjMi2c5MSaIAVjG2fVxWBCjBwD+f3BKnyIJ
         3kkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=kGG9hK6/fhPYP5ESwwboqRMB7+NvjeWq6Eay6lmiXCI=;
        b=lnkdq4Y1R/r01kko5Q1oJlO+9GllpGjLMFwALu7mvM++KgFRReZnNJiTU4uvCXxvhW
         RCt4ag2MQoAcnT+kZ7oYyiSyXnoaeQ9ecdZ1r5iexGWr8modnrrx0gWLx5zq/8lURAIY
         SedAafjlc2wbdABlCG2fPoVuMK5/UR42yJPtA9gmeIkOaYB66Qcy9/xngVChS28zopZW
         cCb84IdPiihTKdvxJ8hTtO/fU9pPmpmmL8O2hUTYgW57fDDZJkqf1SSap6PE6saSbBHA
         3SQU39VohNs/FW+q+CTKTRQUyvlGkuJ01Hhnn4MI5O8QhHdxlu0zHEBQLqlr4ZFt/Tf4
         JpRw==
X-Gm-Message-State: AJIora8bcYiC5cZoiiA5cuEYCfCDZyxJUaUO2lAYtFNJt7YtfaHXpupl
        rBGQungFGiFOmuhyV2ojlteRmjQJReYJdjwt9v4=
X-Google-Smtp-Source: AGRyM1vMh64VQZjysUkcwkuFQsafV2uQy9g9bSldWAXIM8dm2+6Fak+IMbz2mEZ9QMVqycyjrr6XbkFl4eGN0ibWRp8=
X-Received: by 2002:a05:622a:19aa:b0:31e:f81d:7371 with SMTP id
 u42-20020a05622a19aa00b0031ef81d7371mr2513259qtc.345.1658188210793; Mon, 18
 Jul 2022 16:50:10 -0700 (PDT)
MIME-Version: 1.0
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Tue, 19 Jul 2022 04:50:00 +0500
Message-ID: <CABXGCsPRrUoNtO4J8H8aLWRCGGZkwHqtOZV9Edamd2pXVB0ooA@mail.gmail.com>
Subject: Command "clinfo" causes BUG: kernel NULL pointer dereference,
 address: 0000000000000008 on driver amdgpu
To:     amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys I continue testing 5.19 rc7 and found the bug.
Command "clinfo" causes BUG: kernel NULL pointer dereference, address:
0000000000000008 on driver amdgpu.

Here is trace:
[ 1320.203332] BUG: kernel NULL pointer dereference, address: 0000000000000008
[ 1320.203338] #PF: supervisor read access in kernel mode
[ 1320.203340] #PF: error_code(0x0000) - not-present page
[ 1320.203341] PGD 0 P4D 0
[ 1320.203344] Oops: 0000 [#1] PREEMPT SMP NOPTI
[ 1320.203346] CPU: 5 PID: 1226 Comm: kworker/5:2 Tainted: G W L
-------- --- 5.19.0-0.rc7.53.fc37.x86_64+debug #1
[ 1320.203348] Hardware name: System manufacturer System Product
Name/ROG STRIX X570-I GAMING, BIOS 4403 04/27/2022
[ 1320.203350] Workqueue: events delayed_fput
[ 1320.203354] RIP: 0010:dma_resv_add_fence+0x5a/0x2d0
[ 1320.203358] Code: 85 c0 0f 84 43 02 00 00 8d 50 01 09 c2 0f 88 47
02 00 00 8b 15 73 10 99 01 49 8d 45 70 48 89 44 24 10 85 d2 0f 85 05
02 00 00 <49> 8b 44 24 08 48 3d 80 93 53 97 0f 84 06 01 00 00 48 3d 20
93 53
[ 1320.203360] RSP: 0018:ffffaf4cc1adfc68 EFLAGS: 00010246
[ 1320.203362] RAX: ffff976660408208 RBX: ffff975f545f2000 RCX: 0000000000000000
[ 1320.203363] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff976660408198
[ 1320.203364] RBP: ffff976806f6e800 R08: 0000000000000000 R09: 0000000000000000
[ 1320.203366] R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
[ 1320.203367] R13: ffff976660408198 R14: ffff975f545f2000 R15: ffff976660408198
[ 1320.203368] FS: 0000000000000000(0000) GS:ffff976de1200000(0000)
knlGS:0000000000000000
[ 1320.203370] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1320.203371] CR2: 0000000000000008 CR3: 00000007fb31c000 CR4: 0000000000350ee0
[ 1320.203372] Call Trace:
[ 1320.203374] <TASK>
[ 1320.203378] amdgpu_amdkfd_gpuvm_destroy_cb+0x5d/0x1e0 [amdgpu]
[ 1320.203516] amdgpu_vm_fini+0x2f/0x4e0 [amdgpu]
[ 1320.203625] ? mutex_destroy+0x21/0x50
[ 1320.203629] amdgpu_driver_postclose_kms+0x1da/0x2b0 [amdgpu]
[ 1320.203734] drm_file_free.part.0+0x20d/0x260
[ 1320.203738] drm_release+0x6a/0x120
[ 1320.203741] __fput+0xab/0x270
[ 1320.203743] delayed_fput+0x1f/0x30
[ 1320.203745] process_one_work+0x2a0/0x600
[ 1320.203749] worker_thread+0x4f/0x3a0
[ 1320.203751] ? process_one_work+0x600/0x600
[ 1320.203753] kthread+0xf5/0x120
[ 1320.203755] ? kthread_complete_and_exit+0x20/0x20
[ 1320.203758] ret_from_fork+0x22/0x30
[ 1320.203764] </TASK>

Full kernel log is here:
https://pastebin.com/EeKh2LEr

And one hour later after a lot of messages "BUG: workqueue lockup" GPU
completely hung.

I will be glad to test patches that fix this bug.

-- 
Best Regards,
Mike Gavrilov.
