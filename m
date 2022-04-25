Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A376050E562
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 18:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238696AbiDYQSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 12:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbiDYQSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 12:18:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E1098BE3C
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 09:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650903320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0uxnabf8Y3/Gm8yFlXYpryCKvo8Pfth8PWzDsdT55tY=;
        b=aigAJi7FUiX6R/swSuyyoCsGmP1R0HIIJd5gg9mYnjDb0dJ9dPTKJK2zHfYGypKcFf08AV
        vt8olfZFuyB2A4h6vzZR2ivJxMU9TsW/8pZgmiyPk4XBOiCXzgVUdHeYDq/NOVMrxkpsgZ
        uFPTCgJLgtOTZcWE1W3Hd9LhxROb0c8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-675-ryG9Cjw4P_Ca4a8bisdkVA-1; Mon, 25 Apr 2022 12:15:18 -0400
X-MC-Unique: ryG9Cjw4P_Ca4a8bisdkVA-1
Received: by mail-wm1-f69.google.com with SMTP id n25-20020a05600c3b9900b0038ff033b654so2635163wms.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 09:15:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=0uxnabf8Y3/Gm8yFlXYpryCKvo8Pfth8PWzDsdT55tY=;
        b=gHmjswAv8zx0CA2ArEiTJXtYq+0C7QGUyXPx4L62BMGiNmSzDebOROBuO0/PFTdzsC
         OxdijBG155v+xbnJTYX5KbNEzyNj4FOLaGbwMUJjfF3v4FiPDVINT9GN34Qjya7q8Yla
         KbaFSitBU8EOENtbqPL/Ib1afqFwsqmoiDeIdqwieNhSNP+RFGVO1HtdSLkTdyg0SFC0
         XE/oEcPdyFybdRXTkMkLuDbYwLFJQBpHJHLvRGMTkTEa/UYCc8Pw7yq3/U9xPtycqZ3Z
         3dFJtms6qX2d2DA2NEo3VMcBg9tcX2phiZ5A1dIo6poUvsuJwjIiCK9cEj/chC6dwQWx
         6tcQ==
X-Gm-Message-State: AOAM530IFE+U7TWXXjO/dVielLwU1j5bNKId2b4vfEv9WYRHfEWtng82
        Fg6hhAPyepWlTj5Uf1c90tqqVyBCFvi1gockKQy8nJM5HhNFriHd2Sww23mnRzLTlLbyV64rMj/
        lniOGFwycxjLs7f0BvYmnTjEp
X-Received: by 2002:a05:600c:1d9d:b0:38e:c8e0:209f with SMTP id p29-20020a05600c1d9d00b0038ec8e0209fmr17723947wms.43.1650903315692;
        Mon, 25 Apr 2022 09:15:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz9cWdv9BEqgKVys4ZmaQmIwN9KTxBuM5MvcOKi5nU1iXdV7gGu9QV5vfYDyWn9hAFH78VPLg==
X-Received: by 2002:a05:600c:1d9d:b0:38e:c8e0:209f with SMTP id p29-20020a05600c1d9d00b0038ec8e0209fmr17723925wms.43.1650903315506;
        Mon, 25 Apr 2022 09:15:15 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id l3-20020a05600002a300b0020aad7fd63bsm10837734wry.61.2022.04.25.09.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 09:15:15 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     paulmck@kernel.org, linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Subject: Re: "Dying CPU not properly vacated" splat
In-Reply-To: <20220421193821.GA173010@paulmck-ThinkPad-P17-Gen-1>
References: <20220421193821.GA173010@paulmck-ThinkPad-P17-Gen-1>
Date:   Mon, 25 Apr 2022 17:15:13 +0100
Message-ID: <xhsmh4k2h9m26.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Paul,

On 21/04/22 12:38, Paul E. McKenney wrote:
> Hello!
>
> The rcutorture TREE03 scenario got the following splat, which appears
> to be a one-off, or if not, having an MTBF in the thousands of hours,
> even assuming that it is specific to TREE03.  (If it is not specific to
> TREE03, we are talking tens of thousands of hours of rcutorture runtime.)
>
> So just in case this rings any bells or there are some diagnostics I
> should add in case this ever happens again.  ;-)
>

There should be a dump of the enqueued tasks right after the snippet you've
sent, any chance you could share that if it's there? That should tell us
which tasks are potentially misbehaving.

>                                                       Thanx, Paul
>
> ------------------------------------------------------------------------
>
> [29213.585252] ------------[ cut here ]------------
> [29213.586287] Dying CPU not properly vacated!
> [29213.586314] WARNING: CPU: 7 PID: 52 at kernel/sched/core.c:9386 sched_cpu_dying.cold.167+0xc/0xc3
> [29213.589181] Modules linked in:
> [29213.589864] CPU: 7 PID: 52 Comm: migration/7 Not tainted 5.18.0-rc1-00196-g24f4daa283b8 #5468
> [29213.591720] Hardware name: Red Hat KVM/RHEL-AV, BIOS 1.13.0-2.module_el8.5.0+746+bbd5d70c 04/01/2014
> [29213.593698] Stopper: multi_cpu_stop+0x0/0xf0 <- stop_machine_cpuslocked+0xea/0x120
> [29213.595333] RIP: 0010:sched_cpu_dying.cold.167+0xc/0xc3
> [29213.596463] Code: 1f ea 00 49 89 e8 48 8d 93 38 07 00 00 48 c7 c7 60 2b d8 b9 e8 be 2a 00 00 e9 4b 7d 4a ff 48 c7 c7 18 2c d8 b9 e8 80 ed ff ff <0f> 0b 44 8b ab d0 09 00 00 8b 4b 04 48 c7 c6 95 d5 d6 b9 48 c7 c7
> [29213.600479] RSP: 0018:ffff9cbbc023bd88 EFLAGS: 00010082
> [29213.601630] RAX: 0000000000000000 RBX: ffff9b98df3e8cc0 RCX: 0000000000000003
> [29213.603175] RDX: 0000000000000003 RSI: 0000000100021495 RDI: 00000000ffffffff
> [29213.604699] RBP: 0000000000000086 R08: 0000000000000000 R09: c000000100021495
> [29213.606230] R10: 000000000081dc88 R11: ffff9cbbc023bba8 R12: ffffffffb889d6c0
> [29213.607755] R13: 0000000000000000 R14: 0000000000000000 R15: ffff9cbbc05bfd01
> [29213.609297] FS:  0000000000000000(0000) GS:ffff9b98df3c0000(0000) knlGS:0000000000000000
> [29213.611045] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [29213.612279] CR2: 0000000000000000 CR3: 0000000016c0c000 CR4: 00000000000006e0
> [29213.613821] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [29213.615433] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [29213.616972] Call Trace:
> [29213.617516]  <TASK>
> [29213.617992]  ? sched_cpu_wait_empty+0x70/0x70
> [29213.618935]  cpuhp_invoke_callback+0x100/0x4a0
> [29213.619899]  cpuhp_invoke_callback_range+0x3b/0x80
> [29213.620933]  take_cpu_down+0x55/0x80
> [29213.621703]  multi_cpu_stop+0x61/0xf0
> [29213.622503]  ? stop_machine_yield+0x10/0x10
> [29213.623408]  cpu_stopper_thread+0x84/0x120
> [29213.624300]  smpboot_thread_fn+0x181/0x220
> [29213.625192]  ? sort_range+0x20/0x20
> [29213.625961]  kthread+0xe3/0x110
> [29213.626641]  ? kthread_complete_and_exit+0x20/0x20
> [29213.627777]  ret_from_fork+0x22/0x30
> [29213.628655]  </TASK>
> [29213.629185] ---[ end trace 0000000000000000 ]---

