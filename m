Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5BB589D17
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 15:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239981AbiHDNwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 09:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239970AbiHDNwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 09:52:09 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B3C13F33
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 06:52:08 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id s204so23285907oif.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 06:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=4H8DTDCY7KHh19Y7U066i9Gs9khthyKkaKzvx73zQGo=;
        b=5fMRnByF1RAsJF5q0aZRUcqFysc78mQstZyMpyQ3gywRs1pSHMkjj6PpRzmB6taNrY
         mckYCcTJcPhibdnQ1khfLGmuQbkMW4h59uYb8CZXEl+P4TjxwDDQf2hi2yDfbEmFRcLM
         D46QHhJuo3r0W5V/dBDPt8Afcs/Hsgj3IP6PtBUcAtTnzDIUZQ0Q1JxJGGU9O2gpCT+D
         lWeeO4d/jZx9YHgej3HAccSuWYXOkO2LA6gJ21jQHkcXCqIl1zqZjBKUfNwFP3EjyQlE
         S4sp9WWj+v3KvWBACmsEzKsWxmkD21Mh0ab3WFaXofaGFYz0jmZ7TrikKRYfHfLo7BhN
         +PIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=4H8DTDCY7KHh19Y7U066i9Gs9khthyKkaKzvx73zQGo=;
        b=xj9W5SoSt+CpdY3VkRXU7DG0t7hrDJWzfN5qdYwHvka21eqGJlERqYWhuzvNflyXBH
         LlZPovAihOeZkmo5BGKMPtd5i1XsdHdfTtBpVkmuksilwNBSIMpO4OjGDgMDa+V2vwQh
         xbzQjvkiJiTP4FH5HGkU9/JeJEQYRCdWVE7nz5Fhnou7SXu9vVjRnBr5xpvYgFzgmuqP
         2t3BCYq2wG1WSa67W5OhkOPpDEH1oEe34kAIX82TJUqnzkT3MlnEkz6aTXMKqE2xbTe7
         P0naooH1TLKf5VjsbJIciLWzw8FL95MZsjh3Z5j+w2SAOzgLssdIKWR++ZOvqQY2ftXQ
         aYbA==
X-Gm-Message-State: ACgBeo2FpajwrMy7cuHnSY/Vrop6Z+5L809Hww2IhpelU7u3xQJbsRvt
        /G3MkoyzL3SANqk72FyN0t6pjEZyrHGgKIwej4ma
X-Google-Smtp-Source: AA6agR5M87b7ItNi4hLHGCeZCMB52cssUGw/3ygv0WmE6YlX7k/Hek8MCKxcHrFyz9yaxpHbHq6UHnrkcVV8LMuPAgA=
X-Received: by 2002:a05:6808:2389:b0:33a:cbdb:f37a with SMTP id
 bp9-20020a056808238900b0033acbdbf37amr938602oib.136.1659621127735; Thu, 04
 Aug 2022 06:52:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220803050230.30152-1-yepeilin.cs@gmail.com> <20220803222343.31673-1-yepeilin.cs@gmail.com>
In-Reply-To: <20220803222343.31673-1-yepeilin.cs@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 4 Aug 2022 09:51:56 -0400
Message-ID: <CAHC9VhSjA444kYPEsBwWz3fuvY7ohmYb-HKWej4EmBy4mbS4Fw@mail.gmail.com>
Subject: Re: [PATCH v2] audit, io_uring, io-wq: Fix memory leak in
 io_sq_thread() and io_wqe_worker()
To:     Peilin Ye <yepeilin.cs@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Eric Paris <eparis@redhat.com>,
        Peilin Ye <peilin.ye@bytedance.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-audit@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 3, 2022 at 6:24 PM Peilin Ye <yepeilin.cs@gmail.com> wrote:
>
> From: Peilin Ye <peilin.ye@bytedance.com>
>
> Currently @audit_context is allocated twice for io_uring workers:
>
>   1. copy_process() calls audit_alloc();
>   2. io_sq_thread() or io_wqe_worker() calls audit_alloc_kernel() (which
>      is effectively audit_alloc()) and overwrites @audit_context,
>      causing:
>
>   BUG: memory leak
>   unreferenced object 0xffff888144547400 (size 1024):
> <...>
>     hex dump (first 32 bytes):
>       00 00 00 00 00 00 00 00 01 00 00 00 00 00 00 00  ................
>       00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     backtrace:
>       [<ffffffff8135cfc3>] audit_alloc+0x133/0x210
>       [<ffffffff81239e63>] copy_process+0xcd3/0x2340
>       [<ffffffff8123b5f3>] create_io_thread+0x63/0x90
>       [<ffffffff81686604>] create_io_worker+0xb4/0x230
>       [<ffffffff81686f68>] io_wqe_enqueue+0x248/0x3b0
>       [<ffffffff8167663a>] io_queue_iowq+0xba/0x200
>       [<ffffffff816768b3>] io_queue_async+0x113/0x180
>       [<ffffffff816840df>] io_req_task_submit+0x18f/0x1a0
>       [<ffffffff816841cd>] io_apoll_task_func+0xdd/0x120
>       [<ffffffff8167d49f>] tctx_task_work+0x11f/0x570
>       [<ffffffff81272c4e>] task_work_run+0x7e/0xc0
>       [<ffffffff8125a688>] get_signal+0xc18/0xf10
>       [<ffffffff8111645b>] arch_do_signal_or_restart+0x2b/0x730
>       [<ffffffff812ea44e>] exit_to_user_mode_prepare+0x5e/0x180
>       [<ffffffff844ae1b2>] syscall_exit_to_user_mode+0x12/0x20
>       [<ffffffff844a7e80>] do_syscall_64+0x40/0x80
>
> Then,
>
>   3. io_sq_thread() or io_wqe_worker() frees @audit_context using
>      audit_free();
>   4. do_exit() eventually calls audit_free() again, which is okay
>      because audit_free() does a NULL check.
>
> As suggested by Paul Moore, fix it by deleting audit_alloc_kernel() and
> redundant audit_free() calls.
>
> Fixes: 5bd2182d58e9 ("audit,io_uring,io-wq: add some basic audit support to io_uring")
> Suggested-by: Paul Moore <paul@paul-moore.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Peilin Ye <peilin.ye@bytedance.com>
> ---
> Change since v1:
>   - Delete audit_alloc_kernel() (Paul Moore)
>
>  fs/io-wq.c            |  3 ---
>  fs/io_uring.c         |  4 ----
>  include/linux/audit.h |  5 -----
>  kernel/auditsc.c      | 25 -------------------------
>  4 files changed, 37 deletions(-)

This looks good to me, thanks!  Although it looks like the io_uring
related changes will need to be applied by hand as they are pointing
to the old layout under fs/ as opposed to the newer layout in
io_uring/ introduced during this merge window.

Jens, did you want to take this via the io_uring tree or should I take
it via the audit tree?  If the latter, an ACK would be appreciated, if
the former my ACK is below.

Acked-by: Paul Moore <paul@paul-moore.com>

-- 
paul-moore.com
