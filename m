Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B434949BB47
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 19:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbiAYS2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 13:28:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbiAYS1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 13:27:43 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4C1C06173D
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 10:27:40 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id t1so25455574qkt.11
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 10:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:reply-to:mime-version
         :content-disposition;
        bh=V6n46K/pAXLFpL4WHEMSGlAYgd+7WpRoLKihNnyDQ0Q=;
        b=cCgtYBNLUzpv92W+FoDZvIULugY6BaagkJKMkIWR3JM3umIDXBrikOyWjloEyq9PYx
         2/+FJfyY9gpbQoX74PCxsP6Pg6U7MjRbv+iizOOdvOpPHPjcULfexI+5FrOYh+SFjZZy
         gY39wJEuY+Bzj3bUpZUxqllShPZxM/4V5QU2Z9XkLmThe1bmjYCBIGocE+SKQW42cEa2
         B7oaV4uKPB/70NpmtcWvPPMZM/HThnRlGR5AE5gqcc/mVooAs7pgw6CKq6Sls1eQp87J
         5V0lbakzv9kSa3/slNnfs4yVIbVYMCG8oe42CJf7y6/i511jMwfv9HLKJI7idjD4mZ5T
         1WUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:mime-version:content-disposition;
        bh=V6n46K/pAXLFpL4WHEMSGlAYgd+7WpRoLKihNnyDQ0Q=;
        b=6V1eW+pSCwO4dQMhhN6p2/89/m7J1tQw/lMnuCoajXoCHxylTNZs1bMTAETfYauAur
         Q+rFYDBW7QUe+OKv/1dIKZ+DROr26CL+MzOULGJ3DW77Y6uYU2iymkchq6+dE7ilykXU
         N+ZIeTD30V0r+v8AA3/IvADkEla9tTifR3yvdsYlGiQFZJwD0y3hEBPceUO4T3pdYPu6
         KJDMSeglkIy93qWWX9auUTS7PjP/0KBPFDDHme6NC8h0oaXp26ZbRaLu93pIw8Uzz9G0
         PSvP0ZKW4oBjf/Ed5IL4cve4DMez4CJS/Dq/xwvVVeeJMgmeE1rKDPTae8KA5K42yy+S
         8M+A==
X-Gm-Message-State: AOAM533mnTEqJcZYJd4x61u3gGX20x+lsDxbIbyQ6tx5VZx4O63oAouG
        UHFuRc5To/M07TKg7aEakA==
X-Google-Smtp-Source: ABdhPJyf6IirNCRBKXd8O8Nl2Sy9B/ImHfndLvsuxeOVdUMC051ZX7F6pQBqK85R4NBpH6JCIrx4CQ==
X-Received: by 2002:a37:9b83:: with SMTP id d125mr10690990qke.737.1643135259935;
        Tue, 25 Jan 2022 10:27:39 -0800 (PST)
Received: from serve.minyard.net ([47.184.144.75])
        by smtp.gmail.com with ESMTPSA id g21sm8968679qtb.49.2022.01.25.10.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 10:27:39 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:119b:19f9:7c76:518a])
        by serve.minyard.net (Postfix) with ESMTPSA id 6200E1800BB;
        Tue, 25 Jan 2022 18:27:38 +0000 (UTC)
Date:   Tue, 25 Jan 2022 12:27:37 -0600
From:   Corey Minyard <minyard@acm.org>
To:     Juergen Gross <jgross@suse.com>, Ingo Molnar <mingo@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Possible reproduction of CSD locking issue
Message-ID: <20220125182737.GO34919@minyard.net>
Reply-To: minyard@acm.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have a customer that had been seeing CSD lock issues on a Centos 7
kernel (unfortunately).  I couldn't find anything or any kernel changes
that might fix it, so I was consdering it was the CSD locking issue you
have been chasing for a while.

So I backported the debug patches.  And of course, they stopped seeing
the issue, at least as much, and they had trouble with the extra CPU
time the debug code took.  But they just reproduced it.  Here are the
logs:

Jan 23 23:39:43 worker0 kernel: [285737.522743] csd: Detected non-responsive CSD lock (#1) on CPU#3, waiting 5000000042 ns for CPU#55 flush_tlb_func+0x0/0xb0(0xffff8e0b3e2afbe8).
Jan 23 23:39:43 worker0 kernel: [285737.522744]  csd: CSD lock (#1) unresponsive.
Jan 23 23:39:43 worker0 kernel: [285737.522747]  csd: cnt(0000000): 0000->0000 queue
Jan 23 23:39:43 worker0 kernel: [285737.522748]  csd: cnt(0000001): ffff->0037 idle
Jan 23 23:39:43 worker0 kernel: [285737.522749]  csd: cnt(63d8dd8): 0003->0037 ipi
Jan 23 23:39:43 worker0 kernel: [285737.522750]  csd: cnt(63d8dd9): 0003->0037 ping
Jan 23 23:39:43 worker0 kernel: [285737.522750]  csd: cnt(63d8dda): 0003->ffff pinged
Jan 23 23:39:43 worker0 kernel: [285737.522751]  csd: cnt(63d8dea): 0035->0037 pinged
Jan 23 23:39:43 worker0 kernel: [285737.522752]  csd: cnt(63d8deb): ffff->0037 gotipi
Jan 23 23:39:43 worker0 kernel: [285737.522752]  csd: cnt(63d8dec): ffff->0037 handle
Jan 23 23:39:43 worker0 kernel: [285737.522753]  csd: cnt(63d8ded): ffff->0037 dequeue (src CPU 0 == empty)
Jan 23 23:39:43 worker0 kernel: [285737.522754]  csd: cnt(63d8dee): ffff->0037 hdlend (src CPU 0 == early)
Jan 23 23:39:43 worker0 kernel: [285737.522754]  csd: cnt(63d8e1f): 0003->0037 queue
Jan 23 23:39:43 worker0 kernel: [285737.522755]  csd: cnt(63d8e20): 0003->0037 ipi
Jan 23 23:39:43 worker0 kernel: [285737.522756]  csd: cnt(63d8e21): 0003->0037 ping
Jan 23 23:39:43 worker0 kernel: [285737.522756]  csd: cnt(63d8e22): 0003->0037 queue
Jan 23 23:39:43 worker0 kernel: [285737.522757]  csd: cnt(63d8e23): 0003->0037 noipi
Jan 23 23:39:43 worker0 kernel: [285737.522757]  csd: cnt now: 63fe4cd
Jan 23 23:39:43 worker0 kernel: [285737.522758] Task dump for CPU 55:
Jan 23 23:39:43 worker0 kernel: [285737.522761] kubelet         R  running task        0 277695      1 0x00080000
Jan 23 23:39:43 worker0 kernel: [285737.522761] Call Trace:
Jan 23 23:39:43 worker0 kernel: [285737.522769]  [<ffffffff84376b6a>] ? __schedule+0x46a/0x990
Jan 23 23:39:43 worker0 kernel: [285737.522774]  [<ffffffff83db6353>] ? context_tracking_user_enter+0x13/0x20
Jan 23 23:39:43 worker0 kernel: [285737.522776]  [<ffffffff843775b5>] ? schedule_user+0x45/0x50
Jan 23 23:39:43 worker0 kernel: [285737.522779]  [<ffffffff8437b518>] ? retint_careful+0x16/0x34
Jan 23 23:39:43 worker0 kernel: [285737.522780] csd: Re-sending CSD lock (#1) IPI from CPU#03 to CPU#55
Jan 23 23:39:43 worker0 kernel: [285737.522788] CPU: 3 PID: 54671 Comm: runc:[2:INIT] Kdump: loaded Tainted: G           OE  ------------ T 3.10.0-1062.12.1.rt56.1042.mvista.test.14.el7.x86_64 #1
Jan 23 23:39:43 worker0 kernel: [285737.522789] Hardware name: Dell Inc. PowerEdge R740/0YWR7D, BIOS 2.9.4 11/06/2020
Jan 23 23:39:43 worker0 kernel: [285737.522789] Call Trace:
Jan 23 23:39:43 worker0 kernel: [285737.522793]  [<ffffffff843718ba>] dump_stack+0x19/0x1b
Jan 23 23:39:43 worker0 kernel: [285737.522798]  [<ffffffff83d0bcd8>] __csd_lock_wait+0x1a8/0x2a0
Jan 23 23:39:43 worker0 kernel: [285737.522800]  [<ffffffff83c6d870>] ? leave_mm+0x120/0x120
Jan 23 23:39:43 worker0 kernel: [285737.522802]  [<ffffffff83d0bfa4>] smp_call_function_single+0xc4/0x1b0
Jan 23 23:39:43 worker0 kernel: [285737.522804]  [<ffffffff83c6d870>] ? leave_mm+0x120/0x120
Jan 23 23:39:43 worker0 kernel: [285737.522809]  [<ffffffff83e2684b>] ? page_counter_uncharge+0x3b/0x70
Jan 23 23:39:43 worker0 kernel: [285737.522811]  [<ffffffff83d0c614>] smp_call_function_many+0x344/0x380
Jan 23 23:39:43 worker0 kernel: [285737.522813]  [<ffffffff83c6d870>] ? leave_mm+0x120/0x120
Jan 23 23:39:43 worker0 kernel: [285737.522816]  [<ffffffff83c6da38>] native_flush_tlb_others+0xb8/0xc0
Jan 23 23:39:43 worker0 kernel: [285737.522818]  [<ffffffff83c6dc25>] flush_tlb_page+0x65/0xf0
Jan 23 23:39:43 worker0 kernel: [285737.522821]  [<ffffffff83dfdf98>] ptep_clear_flush+0x68/0xa0
Jan 23 23:39:43 worker0 kernel: [285737.522825]  [<ffffffff83de6806>] wp_page_copy.isra.83+0x3d6/0x650
Jan 23 23:39:43 worker0 kernel: [285737.522828]  [<ffffffff83de8cb4>] do_wp_page+0xb4/0x710
Jan 23 23:39:43 worker0 kernel: [285737.522832]  [<ffffffff83decbb4>] handle_mm_fault+0x884/0x1340
Jan 23 23:39:43 worker0 kernel: [285737.522835]  [<ffffffff83cd7799>] ? update_cfs_shares+0xa9/0xf0
Jan 23 23:39:43 worker0 kernel: [285737.522839]  [<ffffffff8437efc3>] __do_page_fault+0x213/0x5a0
Jan 23 23:39:43 worker0 kernel: [285737.522841]  [<ffffffff8437f385>] do_page_fault+0x35/0x90
Jan 23 23:39:43 worker0 kernel: [285737.522842]  [<ffffffff8437b728>] page_fault+0x28/0x30
Jan 23 23:39:43 worker0 kernel: [285737.522845] csd: CSD lock (#1) got unstuck on CPU#03, CPU#55 released the lock.

Hopefully this is the issue you are chasing and not something else.
I've been studying them to see what they mean, but I thought you might
be interested to get them asap.

-corey
