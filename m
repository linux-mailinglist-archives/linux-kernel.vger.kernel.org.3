Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E23C755A71C
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 07:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbiFYFAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 01:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiFYFAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 01:00:17 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66BE3427E2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 22:00:16 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id p31so7471188qvp.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 22:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1qrPonAVKPhMOTfPeMHYE23I+GZiCtHV4xsHgdJefdw=;
        b=bUPjir8aIntIGdVzOv1x4cfMK3ebucUwYSG+JagWwih0jk1LtX3Ct3DpErZJDWTqqS
         ECYsTlvJl5fIBKjO8X0IbrSj9KBaNSEzu1fl1wk4Sj9QGmaNNfAP7dAEQz0JfIrRjH1H
         WmI1/khrtmVjD2x5Zf/8YWwz7hmz09DUvJJMQRQqk/xV1gpZ6+zVsI0Wv0IKRJ0yZb1Y
         MT69Ip0GqOTUuHtWmtuQQ/Bs8Ej40Dlu7HdUWV0QePescCZZRTdDoPKE3IeU+CC2sg57
         4soOJf/J7R3idi7mmzJbRCJwRvUUX3G6AQ16LZw5WbLvEtBSZfXMpMYiESKYIJeIwRx1
         YDzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=1qrPonAVKPhMOTfPeMHYE23I+GZiCtHV4xsHgdJefdw=;
        b=KZfVu8vWWO4ryLeIIA5BGRFEp7ucrLicmRoTKt9G/dsmkBfYJnH9JTwuzgidq4ZCoy
         SqueOsMav5V4MrfR9/CJa68I1EJiz70x2VCNdg99JWZ6XP+2lLeHEPPcmyA7me+b/Tp8
         aSPnDlFQznU3hpP6cwQQyERWFvfN10hW8NPL25vWEsO+1eq0lUQS+BCPfbA4O2yOFMUM
         tMZPF8fvDO/iP1cz+vpeRefTnZOJbFAMp6sitfo6O+pGCRBsN64XSgmhnfp7Ud4E12fN
         u2HwCQFQARajC8EZn7MiZzC2QDQXJkHRzUIHEPoiwNqi0PXTu9BoUxyAiLqFGx1nwv5v
         pygg==
X-Gm-Message-State: AJIora8e+PmddUtVyqa6ziU/ydbkSxGLUhvjhCfZSs3CuEiUFz22lNeE
        l0VmKmBsE/kXXscsH7c/vTNj2yLKH2VK5/nZ
X-Google-Smtp-Source: AGRyM1u1Uzh31MvFfeN4c7hdu9L2ofTAdT1lhO272q2x+ykzjD9rY3Pvu3EvDFKl6O1Z3+We+94N4w==
X-Received: by 2002:ac8:5793:0:b0:304:ffe3:d3c5 with SMTP id v19-20020ac85793000000b00304ffe3d3c5mr2020051qta.460.1656133215365;
        Fri, 24 Jun 2022 22:00:15 -0700 (PDT)
Received: from localhost ([2600:380:526b:c476:2748:efa5:4652:607d])
        by smtp.gmail.com with ESMTPSA id l2-20020a05620a28c200b006a6cadd89efsm3787141qkp.82.2022.06.24.22.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 22:00:14 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Sat, 25 Jun 2022 14:00:10 +0900
From:   Tejun Heo <tj@kernel.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: re. Spurious wakeup on a newly created kthread
Message-ID: <YraWWl+Go17uPOgR@mtj.duckdns.org>
References: <20220622140853.31383-1-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622140853.31383-1-pmladek@suse.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

cc'ing random assortment of ppl who touched kernel/kthread.c and
others who would know better.

So, Petr debugged a NULL deref in workqueue code to a spurious wakeup
on a newly created kthread. The abbreviated patch description follows.
The original message is at

  http://lkml.kernel.org/r/20220622140853.31383-1-pmladek@suse.com

On Wed, Jun 22, 2022 at 04:08:53PM +0200, Petr Mladek wrote:
> A system crashed with the following BUG() report:
> 
>   [115147.050484] BUG: kernel NULL pointer dereference, address: 0000000000000000
...
>   [115147.050524] Call Trace:
>   [115147.050533]  worker_thread+0xb4/0x3c0
>   [115147.050540]  kthread+0x152/0x170
>   [115147.050544]  ret_from_fork+0x35/0x40
> 
> Further debugging shown that the worker thread was woken
> before worker_attach_to_pool() finished in create_worker().
> 
> Any kthread is supposed to stay in TASK_UNINTERRUPTIBLE sleep
> until it is explicitly woken. But a spurious wakeup might
> break this expectation.
> 
> As a result, worker_thread() might read worker->pool before
> it was set in worker create_worker() by worker_attach_to_pool().
> Also manage_workers() might want to create yet another worker
> before worker->pool->nr_workers is updated. It is a kind off
> a chicken & egg problem.

tl;dr is that the worker creation code expects a newly created worker
kthread to sit tight until the creator finishes setting up stuff and
sends the initial wakeup. However, something, which wasn't identified
in the report (Petr, it'd be great if you can find out who did the
wakeup), wakes up the new kthread before the creation path is done
with init which causes the new kthread to try to deref a NULL pointer.

Petr fixed the problem by adding an extra handshake step so that the
new kthread explicitly waits for the creation path, which is fine, but
the picture isn't making sense to me.

* Are spurious wakeups allowed? The way that we do set_current_state()
  in every iteration in wait_event() seems to suggest that we expect
  someone to spuriously flip task state to RUNNING.

* However, if we're to expect spurious wakeups for anybody anytime,
  why does a newly created kthread bother with
  schedule_preempt_disabled() in kernel/kthread.c::kthread() at all?
  It can't guarantee anything and all it does is masking subtle bugs.

What am I missing here?

Thanks.

-- 
tejun
