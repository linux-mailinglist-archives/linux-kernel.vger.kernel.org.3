Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 600134A3201
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 22:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353222AbiA2VHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 16:07:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346309AbiA2VHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 16:07:01 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F1CC061714
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 13:07:01 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id c6so28823309ybk.3
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 13:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=U3dc3xqDLlTpC2E+9rOE/F5axFiCJUonmG/KQjDXwZ0=;
        b=IYosVfoz8ZArLESPT+qCN24rTXUj9pma0U7EgFPqSR8Sq2OtFr9ONsO5qu7bSqXJP3
         z5Cf2XC96KZTb0omfQNZs0aA2Nkc5nGws9BzJKcd11VUnzh+jKRUjSyf5kMKznVz9rf4
         V3HpeInl67nXeXFlK4Lly+k+sKtsoqKglJgoLWPRjL5v99v++RzOT1r1ricnTw+yKphV
         7ltO6FGyDrSoLmpk39n+9IPQ0BTs5d4CYhCogCjA9dHhrrBw9+h+PtR5svxXK5uXP7mq
         SgFEHiOCl15i5c12vTD+nARLN22gqY5kqC6EenfSbtejHHHFzAt6gG9Z3yzKxV73bli1
         d47w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=U3dc3xqDLlTpC2E+9rOE/F5axFiCJUonmG/KQjDXwZ0=;
        b=N0AoBkHmQ34LywYOhh17koHgPqcPpVlQXx9/sUru68kRAzfAM8YG9dFSoazKW6ExPT
         9Z1JjTtxRU7UfxCpLw3s5C8EaosOAEyw6vq+VL3QaLXUgNXJEKcyksUwa7LEjzEda7+S
         aJi04elnkHZL+XOyw2x/Y8xuUP/BF5SRUvv1/GSBTFCy6Ow/5qDMhTKN4TH+o9SxW1lj
         rAnJ6yBPahTk5plEkJetyPNjEkvueB5XwzmGWmPxM7tfn+6EOCwpotliZyEnLZo3KQMh
         PldKT7Bckccr6sxJnT2BRnpiT7oIoWWV9UBmLR0WXIEbsUvgEY44kHkPheCFlan07gC5
         dLDg==
X-Gm-Message-State: AOAM532ZzMz0qNu6HhYRGE4nzvXR/zJC7sBfImoshfqQcNTW6gMVMOQL
        yMtRIJPwdDNh4sl641U/HjV7RlPrdjjYtUPOyyE=
X-Google-Smtp-Source: ABdhPJwsHFOowFI71uk77bu4yu1OCDa0mZHuTMX6PJrsJxa/x+zhRVKNQoXRn0d9zL3p2ISMTvZD6GeHERES792aGTs=
X-Received: by 2002:a25:7c3:: with SMTP id 186mr21870996ybh.235.1643490420350;
 Sat, 29 Jan 2022 13:07:00 -0800 (PST)
MIME-Version: 1.0
From:   Vasyl Vavrychuk <vvavrychuk@gmail.com>
Date:   Sat, 29 Jan 2022 23:06:48 +0200
Message-ID: <CAGj4m+4QPE7uHzbsQbG6Fp3Ke2eQRQQ2z2-1rsKDPtXqs-vpGg@mail.gmail.com>
Subject: gdb switches to __sysvec_apic_timer_interrupt or __default_send_IPI_dest_field
 with KVM enabled
To:     qemu-discuss@nongnu.org, linux-kernel@vger.kernel.org,
        gdb@sourceware.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I run Linux kernel under qemu-system-x86_64 via the "-kernel" option.

Also, I added the "-s" option to accept the gdb connection.

After Linux boot up I connect with gdb and set a breakpoint in some
function, for example "device_del", does not matter really.

The problem is if I also use "--enable-kvm", then after breakpoint
triggered and sending "n" from gdb, it switches to

    __sysvec_apic_timer_interrupt (regs=0xffffc90000297de8) at
arch/x86/kernel/apic/apic.c:1102
    1102            trace_local_timer_entry(LOCAL_TIMER_VECTOR);

or to

    __default_send_IPI_dest_field (mask=<optimized out>,
vector=<optimized out>, dest=dest@entry=2048) at
arch/x86/kernel/apic/ipi.c:161
    161             cfg = __prepare_ICR2(mask);

I am stepping over kernel code that does not perform any waiting or blocking.

Everything works fine with "--enable-kvm" removed.

Thanks,
Vasyl
