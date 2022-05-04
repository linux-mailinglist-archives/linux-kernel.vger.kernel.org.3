Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E98B851B029
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 23:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378513AbiEDVOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 17:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358477AbiEDVOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 17:14:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81AED49FB4
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 14:11:12 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651698671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CKPWYgbYXcfIsG95x1ua8STRPsIFuKN1LA1dfgcwhhA=;
        b=1MWan81qhvKGVvbdBCrUwXV2WiAmiNVsoUUJGH95QqQOMCpw0T4wgYf4A+g2olyc52bhX5
        iPkjnQLkzaMTi6VwTaowiIS8cbMF7deB2YVuXC6CUU1VPuQ0YyXE1YyRKgqSVh1BMx6NGY
        PH7E3XlFBlJH0+YsLdSpZOxcxPkVBmlBZUuac+FRKCc1CbnblGRLezF+pnd2zkQkPYobde
        NaJitdWbNoqLmjxim0r4NRHMYq9KhbymOq1JeraQhNiJCk1xWoFypAIhsCW0HAdWfFsUFL
        3/ne/DduUXaQcaFFNpanLge4E7y8ZnNcJfzhpa8/MiaFMZpTtRXJftD4L7GM8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651698671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CKPWYgbYXcfIsG95x1ua8STRPsIFuKN1LA1dfgcwhhA=;
        b=odQlOZT03eWDUW4JUq55Nq9AyO8/0Gcb6em6qQlxjX+3nYEkdyYhLk80Lhp1/T42KeqlyS
        GYGy6dmQmHzE4bBQ==
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH printk v5 1/1] printk: extend console_lock for
 per-console locking
In-Reply-To: <45849b63-d7a8-5cc3-26ad-256a28d09991@samsung.com>
References: <Ymfgis0EAw0Oxoa5@alley> <Ymfwk+X0CHq6ex3s@alley>
 <CGME20220427070833eucas1p27a32ce7c41c0da26f05bd52155f0031c@eucas1p2.samsung.com>
 <2a82eae7-a256-f70c-fd82-4e510750906e@samsung.com>
 <Ymjy3rHRenba7r7R@alley>
 <b6c1a8ac-c691-a84d-d3a1-f99984d32f06@samsung.com>
 <87fslyv6y3.fsf@jogness.linutronix.de>
 <51dfc4a0-f6cf-092f-109f-a04eeb240655@samsung.com>
 <87k0b6blz2.fsf@jogness.linutronix.de>
 <32bba8f8-dec7-78aa-f2e5-f62928412eda@samsung.com>
 <Ym/Z7PYPqvWPEjuL@alley>
 <45849b63-d7a8-5cc3-26ad-256a28d09991@samsung.com>
Date:   Wed, 04 May 2022 23:17:10 +0206
Message-ID: <87pmktm2a9.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-05-03, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> QEMU virt/arm64:
>
> [=C2=A0 174.155760] task:pr/ttyAMA0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 state:S=
 stack:=C2=A0=C2=A0=C2=A0 0 pid:=C2=A0=C2=A0 26=20
> ppid:=C2=A0=C2=A0=C2=A0=C2=A0 2 flags:0x00000008
> [=C2=A0 174.156305] Call trace:
> [=C2=A0 174.156529]=C2=A0 __switch_to+0xe8/0x160
> [=C2=A0 174.157131]=C2=A0 0xffff5ebbbfdd62d8

I can reproduce the apparent stack corruption with qemu:

[    5.545268] task:pr/ttyAMA0      state:S stack:    0 pid:   26 ppid:    =
 2 flags:0x00000008
[    5.545520] Call trace:
[    5.545620]  __switch_to+0x104/0x160
[    5.545796]  __schedule+0x2f4/0x9f0
[    5.546122]  schedule+0x54/0xd0
[    5.546206]  0x0

When it happens, the printk-kthread is the only one with the corrupted
stack. It seems I am doing something wrong when creating the kthread? I
will investigate this.

Thanks Marek for helping us to narrow this down.

John
