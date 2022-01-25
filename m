Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D82649BF7F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 00:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234777AbiAYX0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 18:26:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234706AbiAYX0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 18:26:02 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2C0C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 15:26:02 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id b22so2643897qkk.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 15:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fireburn-co-uk.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OtjwrHzHKc3fn1SCrPZVpYq+Iid29e/g6FtA1ayaA7k=;
        b=b170mgh3N0fycSDKllLnagA7uZiFV1ByNqPRcx7HzHNwPLvt1x7pWMRwp6YRhIWQCx
         IbtEpge+Bjps4hk0XDHtFUU5WDThe/FibD3FCO9SCUXPYy+P1U/qFk7v731gLPsw2hP5
         PwsMwthyBC/OIsFQ7MlY0wbjRP7o2Ooy/vcO4sysKvSgrwgpBoYnVO6T3KZ6dqWX6fGl
         VLRWH7kF06z+70YporpdXJtlDU3UKZV+5bw+q/klbZj38G0taoZTp9K3miGwOPHV3/LH
         QaVWCrcWjX0AMgnh2hHR4fg974ZoGWKP/jmsCD31KyPOx+b15LxdJJ7bFcEAh4qtkFrm
         lJKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OtjwrHzHKc3fn1SCrPZVpYq+Iid29e/g6FtA1ayaA7k=;
        b=kEu2/itAVU6gxnyJ+PveVxbmd4g6KAJchRe7RYbD/e1IygpPNRpQuxG74pP6Y5s8F6
         3Ignv7IVG8pZp8GO3s+EKs+he/+fYrzY3HajzdSvt8YHv3oXNU5DlhJ7mnj68JpUMoaJ
         kuflspE1W7TtATpxhwEgakgIuakZJnKb0MgCNOtu/eiDW4AsEpHRQjdBLR3t+pXvydM+
         Goiz1I6Rd/h4kJOIo4azT+HWhzgYUqr3bDuHxKtjIPYJEU3xVZa23ooYdBg+W9/vbTBm
         /IP9w61JZETxC6axFT4S5QwT8iFXdn6fIQwRmTAjOyZP4tbK9zLQL7+Q7Ory9FnpoRW9
         Sx9Q==
X-Gm-Message-State: AOAM5305G2rUSRzjvrxioHqyUinKkTj7+s1kJioRskNEBczz91AyNxLa
        FmYjyplWnTsTc6jRrTr5dQe+LBy8EwbBpJTguGZ5jQ==
X-Google-Smtp-Source: ABdhPJyBhSX1/M6deA0wEdudlzi7ThWo8x8JdXkbLDRYT/wBcaBFSP+fV9CMd5Jz/cdebAYvMSuH89CLcQ0VVgyAvtA=
X-Received: by 2002:a05:620a:1474:: with SMTP id j20mr8588947qkl.77.1643153161668;
 Tue, 25 Jan 2022 15:26:01 -0800 (PST)
MIME-Version: 1.0
References: <20211123161038.48009-1-mlevitsk@redhat.com> <20220125150832.1570-1-mike@fireburn.co.uk>
 <6f0d9b07073ca6d3657500ec076edc1ad2a3e40a.camel@redhat.com>
In-Reply-To: <6f0d9b07073ca6d3657500ec076edc1ad2a3e40a.camel@redhat.com>
From:   Mike Lothian <mike@fireburn.co.uk>
Date:   Tue, 25 Jan 2022 23:25:50 +0000
Message-ID: <CAHbf0-FJ0c1yAumKCnXLKKFN=tzeJxSd3HyP=dUOBgBTxVG5fw@mail.gmail.com>
Subject: Re: [PATCH 0/5] iommu/amd: fixes for suspend/resume
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     dwmw@amazon.co.uk, iommu@lists.linux-foundation.org,
        joro@8bytes.org, linux-kernel@vger.kernel.org,
        suravee.suthikulpanit@amd.com, tglx@linutronix.de, will@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jan 2022 at 19:26, Maxim Levitsky <mlevitsk@redhat.com> wrote:
>
> Could you just apply these patches on top of 5.15 kernel and see if you get the warning?
>
> If something could case it is I think patch 1, it does move the GA log enabled
> to be a bit later.
> I also added few warnings there. I wonder why your dmesg quote doesn't contain the C line
> where the warning happens.
>
> In partucular I added:
>
> if (WARN_ON(status & (MMIO_STATUS_GALOG_RUN_MASK)))
>
> That will fire if GA log is already running (maybe BIOS enabled it? - it really shouldn't do that)
>
>
> And that:
>
> if (WARN_ON(i >= LOOP_TIMEOUT))
>
> also should not happen and worth to be logged IMHO.
>
> Best regards,
>         Maxim Levitsky
>

Hi

I applied on top of another kernel as you asked, I also enabled some debugging

[    0.398833] ------------[ cut here ]------------
[    0.398835] WARNING: CPU: 0 PID: 1 at drivers/iommu/amd/init.c:839
amd_iommu_enable_interrupts+0x1da/0x440
[    0.398840] Modules linked in:
[    0.398841] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.16.0-rc5-agd5f+ #1388
[    0.398843] Hardware name: ASUSTeK COMPUTER INC. ROG Strix
G513QY_G513QY/G513QY, BIOS G513QY.316 11/29/2021
[    0.398845] RIP: 0010:amd_iommu_enable_interrupts+0x1da/0x440
[    0.398847] Code: 4b 38 48 89 41 18 b8 a0 86 01 00 0f 1f 44 00 00
48 8b 4b 38 8b 89 20 20 00 00 f7 c1 00 01 00 00 0f 85 7a fe ff ff ff
c8 75 e6 <0f> 0b e9 6f fe ff ff 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44
0
0 00
[    0.398850] RSP: 0018:ffff888100927c68 EFLAGS: 00010246
[    0.398851] RAX: 0000000000000000 RBX: ffff88810004b000 RCX: 0000000000000018
[    0.398853] RDX: 0000000000000008 RSI: ffff888100927c70 RDI: ffffc900000800f0
[    0.398854] RBP: ffff888100927c68 R08: ffff8881015b8f88 R09: 0000000000000000
[    0.398855] R10: 0000000000000000 R11: ffffffffffffffff R12: ffffffff7fffffff
[    0.398856] R13: 0000777f80000000 R14: 0000000000000000 R15: ffffffff8357a758
[    0.398858] FS:  0000000000000000(0000) GS:ffff888fde400000(0000)
knlGS:0000000000000000
[    0.398859] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.398860] CR2: 0000000000000000 CR3: 00000000ac40c000 CR4: 0000000000150ef0
[    0.398862] Call Trace:
[    0.398864]  <TASK>
[    0.398864]  ? iommu_setup+0x29a/0x29a
[    0.398867]  ? state_next+0x6e/0x1c9
[    0.398870]  ? iommu_setup+0x29a/0x29a
[    0.398872]  ? iommu_go_to_state+0x1f/0x33
[    0.398873]  ? amd_iommu_init+0xa/0x23
[    0.398875]  ? pci_iommu_init+0xf/0x45
[    0.398876]  ? iommu_setup+0x29a/0x29a
[    0.398878]  ? __initstub__kmod_pci_dma__244_136_pci_iommu_initrootfs+0x5/0x8
[    0.398880]  ? do_one_initcall+0x100/0x290
[    0.398882]  ? do_initcall_level+0x8b/0xe5
[    0.398884]  ? do_initcalls+0x44/0x6d
[    0.398885]  ? kernel_init_freeable+0xc7/0x10d
[    0.398886]  ? rest_init+0xc0/0xc0
[    0.398888]  ? kernel_init+0x11/0x150
[    0.398889]  ? ret_from_fork+0x22/0x30
[    0.398891]  </TASK>
[    0.398892] ---[ end trace f048a4ec907dc976 ]---

Which points to patch one and "if (WARN_ON(i >= LOOP_TIMEOUT))"

Hope that helps

Mike
