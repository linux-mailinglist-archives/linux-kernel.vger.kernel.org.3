Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B26434967F8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 23:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbiAUWrz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 21 Jan 2022 17:47:55 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:46038 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiAUWry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 17:47:54 -0500
Received: from smtpclient.apple (p4fefca45.dip0.t-ipconnect.de [79.239.202.69])
        by mail.holtmann.org (Postfix) with ESMTPSA id 94A56CED19;
        Fri, 21 Jan 2022 23:47:52 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH] Bluetooth: hci_serdev: call init_rwsem() before p->open()
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20220113132704.4354-1-paskripkin@gmail.com>
Date:   Fri, 21 Jan 2022 23:47:52 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        lukas@wunner.de, BlueZ <linux-bluetooth@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Yiru Xu <xyru1999@gmail.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <EE12A872-B63D-40C9-89CF-98DEEB25DA60@holtmann.org>
References: <20220113132704.4354-1-paskripkin@gmail.com>
To:     Pavel Skripkin <paskripkin@gmail.com>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

> kvartet reported, that hci_uart_tx_wakeup() uses uninitialized rwsem.
> The problem was in wrong place for percpu_init_rwsem() call.
> 
> hci_uart_proto::open() may register a timer whose callback may call
> hci_uart_tx_wakeup(). There is a chance, that hci_uart_register_device()
> thread won't be fast enough to call percpu_init_rwsem().
> 
> Fix it my moving percpu_init_rwsem() call before p->open().
> 
> INFO: trying to register non-static key.
> The code is fine but needs lockdep annotation, or maybe
> you didn't initialize this object before use?
> turning off the locking correctness validator.
> CPU: 2 PID: 18524 Comm: syz-executor.5 Not tainted 5.16.0-rc6 #9
> ...
> Call Trace:
> <IRQ>
> __dump_stack lib/dump_stack.c:88 [inline]
> dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
> assign_lock_key kernel/locking/lockdep.c:951 [inline]
> register_lock_class+0x148d/0x1950 kernel/locking/lockdep.c:1263
> __lock_acquire+0x106/0x57e0 kernel/locking/lockdep.c:4906
> lock_acquire kernel/locking/lockdep.c:5637 [inline]
> lock_acquire+0x1ab/0x520 kernel/locking/lockdep.c:5602
> percpu_down_read_trylock include/linux/percpu-rwsem.h:92 [inline]
> hci_uart_tx_wakeup+0x12e/0x490 drivers/bluetooth/hci_ldisc.c:124
> h5_timed_event+0x32f/0x6a0 drivers/bluetooth/hci_h5.c:188
> call_timer_fn+0x1a5/0x6b0 kernel/time/timer.c:1421
> 
> Fixes: d73e17281665 ("Bluetooth: hci_serdev: Init hci_uart proto_lock to avoid oops")
> Reported-by: Yiru Xu <xyru1999@gmail.com>
> Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
> ---
> drivers/bluetooth/hci_serdev.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

